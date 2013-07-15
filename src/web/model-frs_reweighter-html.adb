with Ada.Strings.Unbounded;
with Ada.Exceptions;
with AWS.Parameters;
with AWS.Session;
with AWS.Containers.Tables;
with AWS.URL;

with Templates_Parser;

with GNATColl.Traces;

with Base_Model_Types;
with Data_Constants;
with Model.LA_Global_Settings;
with Web_Utils;
with Weighting_Commons;
with Html_Utils;
with Text_Utils;
with Target_Candidates_Type_IO;
with FRS_Dataset_Creator;
with Utils;

package body Model.FRS_Reweighter.HTML is
   
   use Text_Utils;   
   use Weighting_Commons;
   use Data_Constants;
   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   
   package euws  renames Model.LA_Global_Settings;
   
   Package HTU is new HTML_Utils( Rate => Amount, Counter_Type => Counter_Type );
     
   type Combined_Settings is tagged record
      which_la                    : Unbounded_String;
      start_year                  : Data_Years := 2010;
      start_year_error            : Unbounded_String;
      end_year                    : Data_Years := 2010;
      end_year_error              : Unbounded_String;
      weighting_lower_bound       : Amount;
      weighting_lower_bound_str   : Unbounded_String;
      weighting_lower_bound_error : Unbounded_String;
      weighting_upper_bound       : Amount;
      weighting_upper_bound_str   : Unbounded_String;
      weighting_upper_bound_error : Unbounded_String;
      clauses                     : Selected_Clauses_Array;
      weighting_function          : Distance_Function_Type; 
      sample                      : Weighting_Sample_Type;
      has_error                   : Boolean;
   end record;
   
   function Good_To_Go( settings : Combined_Settings ) return Boolean is
   begin
      if settings.has_error or settings.which_la = Null_Unbounded_String then
         return False;
      end if;
      for s in settings.clauses'Range loop
         if( settings.clauses( s ))then
            return True;
         end if;
      end loop;
      return False;
   end Good_To_Go; 

   Null_Combined_Settings : constant Combined_Settings := (
      which_la                    => Null_Unbounded_String,
      start_year                  => 2009,
      start_year_error            => Null_Unbounded_String,
      end_year                    => 2010,
      end_year_error              => Null_Unbounded_String,
      weighting_lower_bound       => 0.1,
      weighting_lower_bound_str   => Null_Unbounded_String,
      weighting_lower_bound_error => Null_Unbounded_String,
      weighting_upper_bound       => 10.0,
      weighting_upper_bound_str   => Null_Unbounded_String,
      weighting_upper_bound_error => Null_Unbounded_String,
      clauses                     => ( others => False ),
      weighting_function          => constrained_chi_square,
      sample                      => Weighting_Sample_Type'First,
      has_error                   => False
      
   );

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL-FRS_REWEIGHTER-HTML" );
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   function Make_Summary_Table( 
      settings      : Combined_Settings;
      label         : String;   
      which_la      : String; 
      which_clause  : Candidate_Clauses;
      sample_weight : Amount ) return String is
   use Templates_Parser;
      
      translations : Translate_Set;
      
      la_clause    : constant SQL_Clause := Get_One_Clause( which_clause, False );
      la_sql       : constant String := "select " & TS( la_clause.clause ) &
            " from target_candidates where " &
            " edition = " & FRS_Dataset_Creator.EDITION'Img & " and code ='" & which_la & "'";
      la_data      : constant Vector := Get_One_Dataset_For_LA( la_sql );
      frs_clause   : constant SQL_Clause := Get_One_Clause( which_clause, True, sample_weight );
      frs_sql      : constant String := "select " & TS( frs_clause.clause ) &
            " from target_candidates where " &
            " edition = " & FRS_Dataset_Creator.EDITION'Img & " and " & 
            TS( Make_Year_And_Region_Clause( settings.sample, settings.start_year, settings.end_year, which_la ));
      
      frs_data     : constant Vector := Get_One_Dataset_For_LA( frs_sql );
      la_values    : Vector_Tag;
      frs_values   : Vector_Tag;
      labels       : Vector_Tag;
      classes      : Vector_Tag;
      diff         : Amount;
   begin
      for i in la_data'Range loop
         la_values := la_values & Format_With_Commas( Integer( la_data( i )));
         frs_values := frs_values & Format_With_Commas( Integer( frs_data( i )));
         if( la_data( i ) /= 0.0 )then
            diff := ( frs_data( i ) - la_data( i )) / la_data( i );
            if( diff > 0.20 )then
               classes := classes & "frs_vgt";
            elsif( diff > 0.05 )then
               classes := classes & "frs_gt";
            elsif( diff < -0.20 )then
               classes := classes & "frs_vlt";
            elsif( diff < -0.05 )then
               classes := classes & "frs_lt";
            else
               classes := classes & "frs_eq";
            end if;
         end if;
         labels := labels & la_clause.labels.Element( i );
      end loop;
      Insert( translations, Assoc( "TITLE", label ));
      Insert( translations, Assoc( "DESCRIPTION", la_clause.description ));   
      Insert( translations, Assoc( "LA_VALUES", la_values ));   
      Insert( translations, Assoc( "FRS_VALUES", frs_values ));   
      Insert( translations, Assoc( "LABELS", labels ));   
      Insert( translations, Assoc( "CLASSES", classes ));   
      return Web_Utils.Parse_Template(
         euws.template_components_path & "summary_table",
         translations );
   end Make_Summary_Table;
  
   package Combined_Settings_Session_Package is new AWS.Session.Generic_Data(
      Combined_Settings,
      Null_Combined_Settings );
      
   type Actions is ( find, generate, no_action );

   function Extract_Action( cgi_values : AWS.Parameters.List ) return Actions is
      use HTU;
      action : Actions := no_action;
   begin
      if( Contains_Key( cgi_values, "find" ))then 
         action :=  find;
      elsif( Contains_Key( cgi_values, "generate" ))then 
         action :=  generate;
      end if;
      Log( "Extract_Action; got action as " & action'Img );
      return action;
   end Extract_Action;
   
   function Handle_Input_Page( request : in AWS.Status.Data; la : LAs_Type ) return String is
   use La_Data_Data;
   use Templates_Parser;
      procedure WS_Select is new HTU.Make_One_Select_Box_2( T => Weighting_Sample_Type );
      procedure WF_Select is new HTU.Make_One_Select_Box_2( T => Distance_Function_Type );
      session_id     : constant AWS.Session.Id := AWS.Status.Session( request );
      settings       : Combined_Settings := Combined_Settings_Session_Package.Get( session_id, "Settings" );
      params         : constant AWS.Parameters.List := AWS.Status.Parameters( request );
      translations   : Translate_Set;
      output_string  : Unbounded_String;
      this_is_error  : Boolean := False;
      labels         : Vector_Tag;
      ids            : Vector_Tag;
      boxes          : Vector_Tag;
      summary_tables : Vector_Tag;
      action         : constant Actions := Extract_Action( params );
      uniform_weight : Amount;          
      rw             : Reweighter;
   begin
      Log( "cgi is " & HTU.Dump( params ));
      settings.which_la := la.code;
      WS_Select(
         varname       => "sample",
         output_str    => output_string,
         value         => settings.sample,  
         default_value => whole_sample,
         help          => 
            "FRS Subset to use",
         param_string  => params.Get( "sample" ),
         param_is_set  => params.Exist( "sample" ));
      Insert( translations, Assoc( "SAMPLE", output_string ));
      settings.has_error := False; 
      WF_Select(
         varname       => "weighting_function",
         output_str    => output_string,
         value         => settings.weighting_function,  
         default_value => settings.weighting_function,
         help          => 
            "Weighting function to use; see the referenced papers. " &
            "Stick to constrained-chi unless you know what you are doing",
         param_string  => params.Get( "weighting_function" ),
         param_is_set  => params.Exist( "weighting_function" ));
      Insert( translations, Assoc( "WEIGHTING-FUNCTION", output_string ));

      HTU.Make_One_Input(
         varname       => "start_year",
         output_str    => output_string,
         value         => settings.start_year,
         default_value => 2009,
         help          => "",
         param_string  => params.Get( "start_year" ),
         param_is_set  => params.Exist( "start_year" ),
         min           => 2009,
         max           => 2010,
         is_error      => this_is_error );
      Insert( translations, Assoc( "START-YEAR", output_string ));
      settings.has_error := this_is_error and settings.has_error;
      
      HTU.Make_One_Input(
         varname       => "end_year",
         output_str    => output_string,
         value         => settings.end_year,
         default_value => 2010,
         param_string  => params.Get( "end_year" ),
         min           => 2009,
         max           => 2010,
         is_error      => this_is_error,
         param_is_set  => params.Exist( "end_year" ));
      Insert( translations, Assoc( "END-YEAR", output_string ));
      settings.has_error := this_is_error and settings.has_error;
         
      -- if( action = find )then
            -- 
      -- end if;
      
         
      settings.has_error := this_is_error and settings.has_error;
      Insert( translations, Assoc( "WHICH-LA", output_string ));
      
      HTU.Make_One_Input(
         varname       => "weighting_upper_bound",
         output_str    => output_string,
         value         => settings.weighting_upper_bound,
         default_value => 1.0,
         prec          => 6,
         help          => "If using a constrained weighting function, " &
                          "the ratio between original and final weights " &
                          "cannot be greater than this.",
         param_string  => params.Get( "weighting_upper_bound" ),
         param_is_set  => params.Exist( "weighting_upper_bound" ),
         min           => 1.0,
         max           => 100.0,
         is_percent    => False,
         is_error      => this_is_error );
      settings.has_error := this_is_error and settings.has_error;
      Insert( translations, Assoc( "WEIGHTING-UPPER-BOUND", output_string ));
      
      HTU.Make_One_Input(
         varname       => "weighting_lower_bound",
         output_str    => output_string,
         value         => settings.weighting_lower_bound,
         default_value => 0.1,
         prec          => 6,
         help          => "If using a constrained weighting function, " &
                          "the ratio between original and final weights " &
                          "cannot be less than this.",
         param_string  => params.Get( "weighting_lower_bound" ),
         param_is_set  => params.Exist( "weighting_lower_bound" ),
         min           => 0.000001,
         max           => 1.0,
         is_percent    => False,
         is_error      => this_is_error );
      settings.has_error := this_is_error and settings.has_error;
      Insert( translations, Assoc( "WEIGHTING-LOWER-BOUND", output_string ));
      uniform_weight := Get_Uniform_Weight( 
            settings.sample, 
            settings.start_year, 
            settings.end_year, 
            TS( la.code ));
      for t in Candidate_Clauses loop
         declare
            id : constant String := Censor_String( Candidate_Clauses'Image( t ));
            label :constant String := Prettify_Image( Candidate_Clauses'Image( t ));
         begin
            HTU.Make_One_Input( 
               varname       => id,
               output_str    => output_string,
               value         => settings.clauses( t ),
               default_value => False,
               help          => TS( Get_One_Clause( t, False ).description ),
               param_string  => params.Get( id ),
               param_is_set  => params.Exist( id ),
               use_if_set    => True );
            labels := labels & label;
            ids    := ids & id;
            boxes  := boxes & output_string;
            summary_tables := summary_tables & Make_Summary_Table( 
               settings, 
               label, 
               TS( la.code ), 
               t, 
               uniform_weight );    
         end;
      end loop;
      
      Insert( translations, Assoc( "LABELS", labels ));
      Insert( translations, Assoc( "IDS", ids ));
      Insert( translations, Assoc( "SUMMARY-TABLES", summary_tables ));
      Insert( translations, Assoc( "BOXES", boxes ));
      if action = generate then    
         if Good_To_Go( settings ) then
            declare
               file_base : constant String := Utils.Random_String;
               filename  : constant String := euws.Tmp_Dir & euws.Dir_Separator & file_base & ".csv";
               url       : constant String := euws.Web_Root & "/csv/?filename=" & file_base;
               error     : Eval_Error_Type;
            begin
               Create_Weights(
                  Sample                => settings.sample,
                  Clauses               => settings.clauses,
                  Which_LA              => TS( settings.which_la ),
                  Start_Year            => settings.start_year, 
                  End_Year              => settings.end_year,      
                  Weighting_Lower_bound => settings.weighting_lower_bound, 
                  Weighting_Upper_bound => settings.weighting_upper_bound,
                  Weighting_Function    => settings.weighting_function,
                  Error                 => error,
                  Weighter              => rw );
               if( error = normal )then
                  rw.Dump( filename );
                  Log( "dumped to filename " & filename );
                  Insert( translations, Assoc( "MESSAGE", "Download Weights  <a href='" & url & "'>here</a>." ));
               else
                  Insert( translations, Assoc( "MESSAGE", "Weight Generation Failed with error condition " & error'Img ));
               end if;
            exception
               when e : Others =>
                  Insert( translations, Assoc( "MESSAGE", "Weight Generation Failed with message " & 
                     Exception_Information( e )));
            end;
         else
            Insert( translations, Assoc( "MESSAGE", "You need to select at least one target." ));
         end if;
      end if;
      Combined_Settings_Session_Package.Set( session_id, "Settings", settings );      
      return Web_Utils.Parse_Template(
         euws.template_components_path & "input_section",
         translations );
   end  Handle_Input_Page;
   

   
end Model.FRS_Reweighter.HTML;
      
