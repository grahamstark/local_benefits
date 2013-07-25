with Ada.Characters.Handling;
with Ada.Exceptions;
with Ada.Assertions;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

with Templates_Parser;

with GNATColl.Traces;

with Conversions.FRS;
with FRS_Binary_Reads;

with Maths_Functions.Weights_Generator;
with Maths_Functions;
with Text_Utils;
with Utils;
with Weighting_Commons;
with FRS_Dataset_Creator;
with Target_Candidates_Type_IO;
with LA_Data_Data;
with Connection_Pool;
with GNATCOLL.SQL_Impl;     
with GNATCOLL.SQL.Exec;     
with GNATCOLL.SQL.Postgres; 
with DB_Commons;
--
--
-- 
package body Model.FRS_Reweighter is
   
   use Ada.Strings.Unbounded;
   use Ada.Text_IO;
   use Text_Utils;
   use Ada.Exceptions;
   use Ada.Assertions;
   use Weighting_Commons;

   package gsi renames GNATCOLL.SQL_Impl;
   package gse renames GNATCOLL.SQL.Exec;
   package gsp renames GNATCOLL.SQL.Postgres;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "MODEL-FRS_REWEIGHTER" );
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   function Equal_Weights_Index( left, right : Weights_Index ) return Boolean is
   begin
      return left.year = right.year and left.id = right.id;
   end  Equal_Weights_Index;
   
   function Lt_Weights_Index( left, right : Weights_Index ) return Boolean is
   begin
      if left.year = right.year then
         return left.id < right.id;
      else
         return left.year < right.year;
      end if;
   end Lt_Weights_Index;
         
   procedure Check_Result( conn : in out gse.Database_Connection ) is
      error_msg : constant String := gse.Error( conn );
   begin
      if( error_msg /= "" )then
         Log( error_msg );
         Connection_Pool.Return_Connection( conn );
         Raise_Exception( db_commons.DB_Exception'Identity, error_msg );
      end if;
   end  Check_Result;     
   
   function FRS_Region_Of_LA( lacode : String ) return Integer is
      t : La_Data_Data.Target_Candidates_Type;
   begin
      t := Target_Candidates_Type_IO.Retrieve_By_PK( 1, TuS( lacode ), FRS_Dataset_Creator.EDITION );
      return t.Frs_Region;
   end FRS_Region_Of_LA;
   
   function Fill_In_Gets( 
      clauses : Selected_Clauses_Array; is_sum : Boolean ) return SQL_Clause is
      sq : SQL_Clause;
      sl : Unbounded_String_List;
   begin
      for i in Candidate_Clauses loop
         if( clauses( i ))then
            declare
               lc : SQL_Clause := Get_One_Clause( i, is_sum );
            begin
               sq.output_columns := sq.output_columns  + lc.output_columns;
               sl.Append( lc.clause );
            end;
         end if;
      end loop;
      sq.clause := TuS( "select id, code," ) & Join( sl, ',' ) & " from target_candidates where edition = " & 
         FRS_Dataset_Creator.EDITION'Img & " and ";
      return sq;      
   end Fill_In_Gets;
  
   function Get_One_Dataset_For_LA( 
      sql             : String ) return Vector is
      query         : gse.Prepared_Statement;
      cursor        : gse.Direct_Cursor;
      conn          : gse.Database_Connection := Connection_Pool.Lease;
      num_data_cols : Natural;
   begin
      query := gse.Prepare( sql, On_Server => True );
      cursor.Fetch( conn, query );
      Check_Result( conn );
      num_data_cols := Positive( gse.Field_Count( cursor ));  
      declare
         v : Vector( 1 .. num_data_cols );
      begin
         cursor.Absolute( 1 );
         for col in 0 .. num_data_cols-1 loop
            declare
               fe : gse.Field_Index := gse.Field_Index( col );
               x  : Amount := Amount( cursor.Float_Value( fe ));
            begin
               v( col+1 ) := x;
            end;
         end loop;            
         Connection_Pool.Return_Connection( conn );
         return v;
      end;
   end Get_One_Dataset_For_LA;
   
   function Make_Year_And_Region_Clause( 
      sample     : Weighting_Sample_Type;
      start_year : Data_Years;
      end_year   : Data_Years;
      which_la   : String ) return Unbounded_String is
      year_clause : Unbounded_String := TuS( "code in ( " );
    begin
     for y in start_year .. end_year loop
         year_clause := year_clause & "'" & DATA_YEAR_STRINGS( y ) & "'";
         if( y < end_year )then
            year_clause := year_clause & ", ";
         end if;
      end loop;
      year_clause := year_clause & ") ";
      case sample is 
         when whole_sample => null;
         when england_and_wales =>
            year_clause := year_clause & " and frs_region <= 11 ";
         when england =>
            year_clause := year_clause & " and frs_region <= 10 "; -- fixeme: not if we're in wales!
         when government_region =>
            declare 
               reg : constant Integer := FRS_Region_Of_LA( which_la );
            begin
               year_clause := year_clause & " and frs_region = " & reg'Img;
            end;
      end case;
      return year_clause;
   end Make_Year_and_Region_Clause;
   

   function Get_Uniform_Weight( 
      sample                : Weighting_Sample_Type;
      start_year            : Data_Years;
      end_year              : Data_Years;
      which_la              : String ) return Amount is
      qstring : constant String :=  
         "select " & 
            "( select tenure_all_categories_tenure from " &
            "   target_candidates where edition = " & FRS_Dataset_Creator.EDITION'Img & " and " & 
            " code='" & which_la & "' ) / count(*) " &
            " as uw  from target_candidates where " &
            " edition = " &
               FRS_Dataset_Creator.EDITION'Img &
            " and " &
            TS( Make_Year_And_Region_Clause( sample, start_year, end_year, which_la ));
      query         : gse.Prepared_Statement;
      cursor        : gse.Direct_Cursor;
      conn          : gse.Database_Connection := Connection_Pool.Lease;
      uw            : Amount;
   begin
      Log( "Get_Uniform_Weight |" & qstring & "| " );
      query := gse.Prepare( qstring, On_Server => True );
      cursor.Fetch( conn, query );      
      Check_Result( conn );
      cursor.Absolute( 1 );
      -- gse.Next( cursor );
      uw := Amount( cursor.Float_Value( 0 ));
      Connection_Pool.Return_Connection( conn );
      return uw;      
   end Get_Uniform_Weight;
   
   function Create_SQL( 
      sample                : Weighting_Sample_Type;
      clauses               : Selected_Clauses_Array;
      which_la              : String;
      start_year            : Data_Years;
      end_year              : Data_Years ) return SQL_Clause_Array is
      sq : SQL_Clause_Array := ( others => Fill_In_Gets( clauses, False ));
   begin
      sq( 1 ).clause := sq( 1 ).clause & "code = '" & Trim( which_la ) & "'";
      sq( 2 ).clause := sq( 2 ).clause & 
         Make_Year_and_Region_Clause( sample, start_year, end_year, which_la );
      return sq;
   end  Create_SQL;
   
   function Get_One_Clause( which : Candidate_Clauses; is_sum : Boolean; multiplier : Amount := 0.0 ) return SQL_Clause is
      use Templates_Parser;
      c : SQL_Clause;

      function Make_Translations return Translate_Set is
         translations : Translate_Set;
      begin
         if( is_sum )then
            Insert( translations, Assoc( "SUM-CLAUSE-START", "Sum( " ));
            Insert( translations, Assoc( "SUM-CLAUSE-END", " ) * " & Amount'Image( multiplier )));
         else
            Insert( translations, Assoc( "SUM-CLAUSE-START", "" ));
            Insert( translations, Assoc( "SUM-CLAUSE-END", "" ));
         end if;
         return translations;
      end Make_Translations;

      translations : constant Translate_Set := Make_Translations;
      
      function Make_Subs( s : String ) return Unbounded_String is
      begin
         return TuS( Translate( s, translations ));
      end Make_Subs;
      
   begin
      case which is
         when economic_activity_aggregated =>
            c.description := TuS( "Economic Activity (ISO) Aggregated" );
            c.output_columns := 2;
            c.clause := Make_Subs(
               "@_SUM-CLAUSE-START_@ Ec_Act_active_Total @_SUM-CLAUSE-END_@," & 
               "@_SUM-CLAUSE-START_@ Ec_Act_inactive_Total @_SUM-CLAUSE-END_@" ); 
            c.labels.Add_To( "Active" );
            c.labels.Add_To( "Inactive" );
         when economic_activity_disaggregated =>
            c.description := Make_Subs( "Economic Activity (ISO) Aggregated" );
            c.output_columns := 7;
            c.clause := Make_Subs(
              "@_SUM-CLAUSE-START_@ Ec_Act_Active_Employee_Full_Time @_SUM-CLAUSE-END_@, " &
              "@_SUM-CLAUSE-START_@ Ec_Act_Active_Employee_Part_Time @_SUM-CLAUSE-END_@, " &
	           "@_SUM-CLAUSE-START_@ (Ec_Act_Active_Self_Employed_Without_Employees_Full_Time + " &
	           " Ec_Act_Active_Self_Employed_With_Employees_Full_Time + " &
	           " Ec_Act_Active_Self_Employed_Without_Employees_Part_Time +" &
	           " Ec_Act_Active_Self_Employed_With_Employees_Part_Time ) @_SUM-CLAUSE-END_@ as self_employed," &
              " @_SUM-CLAUSE-START_@ Ec_Act_Active_Unemployed @_SUM-CLAUSE-END_@, " &
              " @_SUM-CLAUSE-START_@ Ec_Act_Inactive_Retired @_SUM-CLAUSE-END_@, " &    
              " @_SUM-CLAUSE-START_@ Ec_Act_Inactive_Looking_After_Home_Or_Family @_SUM-CLAUSE-END_@, " &
              " @_SUM-CLAUSE-START_@ ( Ec_Act_Inactive_Long_Term_Sick_Or_Disabled + " &
              " Ec_Act_Inactive_Other + " & 
              " Ec_Act_Active_Full_Time_Student +" &
              " Ec_Act_Inactive_Student_Including_Full_Time_Students ) @_SUM-CLAUSE-END_@ as other_inactive");                                     
            c.labels.Add_To( "Full Time Employee" );
            c.labels.Add_To( "Part-Time Employee" );
            c.labels.Add_To( "Self-Employed" );
            c.labels.Add_To( "Unemployed" );
            c.labels.Add_To( "Retired" );
            c.labels.Add_To( "Looking After Home or Family" );
            c.labels.Add_To( "Long Terms Sick or Disabled / Other Inactive/ Students" );
         when occupation_disaggregated =>
            c.description := Make_Subs( "Occupation (Standard Occupational Classification 2000 disaggregated)" );
            c.output_columns := 9;
            c.clause := Make_Subs(
               "  @_SUM-CLAUSE-START_@ occupation_1_managers_directors_and_senior_officials  @_SUM-CLAUSE-END_@, " & 
               "  @_SUM-CLAUSE-START_@ occupation_2_professional_occupations  @_SUM-CLAUSE-END_@, " & 
               "  @_SUM-CLAUSE-START_@ occupation_3_associate_professional_and_technical_occupations  @_SUM-CLAUSE-END_@, " & 
               "  @_SUM-CLAUSE-START_@ occupation_4_administrative_and_secretarial_occupations  @_SUM-CLAUSE-END_@, " & 
               "  @_SUM-CLAUSE-START_@ occupation_5_skilled_trades_occupations  @_SUM-CLAUSE-END_@, " & 
               "  @_SUM-CLAUSE-START_@ occupation_6_caring_leisure_and_other_service_occupations  @_SUM-CLAUSE-END_@, " & 
               "  @_SUM-CLAUSE-START_@ occupation_7_sales_and_customer_service_occupations  @_SUM-CLAUSE-END_@, " & 
               "  @_SUM-CLAUSE-START_@ occupation_8_process_plant_and_machine_operatives @_SUM-CLAUSE-END_@, " & 
               "  @_SUM-CLAUSE-START_@occupation_9_elementary_occupations @_SUM-CLAUSE-END_@ " ); 
            c.labels.Add_To( "Managers, Directors and Senior Officials" );
            c.labels.Add_To( "Professional" );
            c.labels.Add_To( "Associate Professional and Technical" );
            c.labels.Add_To( "Administrative and Secretarial" );
            c.labels.Add_To( "Skilled Trades" );
            c.labels.Add_To( "Caring Leisure and Other Service" );
            c.labels.Add_To( "Sales and Customer Service" );
            c.labels.Add_To( "Process Plant and Machine Operatives" );
            c.labels.Add_To( "Elementary Occupations " );
         when occupation_aggregated =>
            c.description := Make_Subs( "Occupation (aggregated: white_collar,blue_collar)" );
            c.output_columns := 2;
            c.clause := Make_Subs(
               "@_SUM-CLAUSE-START_@ ( occupation_1_managers_directors_and_senior_officials + " & 
               "occupation_2_professional_occupations + " & 
               "occupation_3_associate_professional_and_technical_occupations + " & 
               "occupation_4_administrative_and_secretarial_occupations ) @_SUM-CLAUSE-END_@ as white_collar, " & 
               "@_SUM-CLAUSE-START_@ ( occupation_5_skilled_trades_occupations + " & 
               "occupation_6_caring_leisure_and_other_service_occupations + " & 
               "occupation_7_sales_and_customer_service_occupations + " & 
               "occupation_8_process_plant_and_machine_operatives + " & 
               "occupation_9_elementary_occupations )  @_SUM-CLAUSE-END_@ as blue_collar " ); 
            c.labels.Add_To( "White Collar" );
            c.labels.Add_To( "Blue Collar" );
         when rooms_aggregated =>
            c.description := Make_Subs( "Number of rooms (aggregated: 1,2-3,4-5,6+)" );
            c.output_columns := 4;
            c.clause := Make_Subs(
               "@_SUM-CLAUSE-START_@ number_of_rooms_1_room @_SUM-CLAUSE-END_@ as rooms_1, " &
               "@_SUM-CLAUSE-START_@ ( number_of_rooms_2_rooms + " &
               "number_of_rooms_3_rooms )  @_SUM-CLAUSE-END_@ as rooms_2_3, " & 
               "@_SUM-CLAUSE-START_@ ( number_of_rooms_4_rooms + " &
               "number_of_rooms_5_rooms ) @_SUM-CLAUSE-END_@ as rooms_4_5, " &
               "@_SUM-CLAUSE-START_@ ( number_of_rooms_6_rooms + " &
               "number_of_rooms_7_rooms + " &
               "number_of_rooms_8_rooms + " &
               "number_of_rooms_9_or_more_rooms ) @_SUM-CLAUSE-END_@  as rooms_6_plus " );
            c.labels := Text_Utils.Split( "1,2-3,4-5,6+", ',' );
         when rooms_disaggregated =>
            c.description := Make_Subs( "Number of rooms (disaggregated: 1..9 or more)" );
            c.output_columns := 9;
            c.clause := Make_Subs(
               "  @_SUM-CLAUSE-START_@ number_of_rooms_1_room  @_SUM-CLAUSE-END_@, " &
               "  @_SUM-CLAUSE-START_@ number_of_rooms_2_rooms  @_SUM-CLAUSE-END_@, " &
               "  @_SUM-CLAUSE-START_@ number_of_rooms_3_rooms  @_SUM-CLAUSE-END_@, " & 
               "  @_SUM-CLAUSE-START_@ number_of_rooms_4_rooms  @_SUM-CLAUSE-END_@, " &
               "  @_SUM-CLAUSE-START_@ number_of_rooms_5_rooms  @_SUM-CLAUSE-END_@, " &
               "  @_SUM-CLAUSE-START_@ number_of_rooms_6_rooms  @_SUM-CLAUSE-END_@, " &
               "  @_SUM-CLAUSE-START_@ number_of_rooms_7_rooms  @_SUM-CLAUSE-END_@, " &
               "  @_SUM-CLAUSE-START_@ number_of_rooms_8_rooms  @_SUM-CLAUSE-END_@, " &
               "  @_SUM-CLAUSE-START_@ number_of_rooms_9_or_more_rooms  @_SUM-CLAUSE-END_@" );
            c.labels := Text_Utils.Split( "1,2,3,4,5,6,7,8,9+", ',' );
         when tenure =>
            c.description := Make_Subs( "Tenure Type: Aggregated (owned outright, mortgaged inc. shared ownwership, social rented, private rented, rent-free)" );
            c.output_columns := 4;
            c.clause := Make_Subs(
               " @_SUM-CLAUSE-START_@ Tenure_Owned_Owned_Outright  @_SUM-CLAUSE-END_@ as owned_outright, " &         
               " @_SUM-CLAUSE-START_@ ( Tenure_Owned_Owned_With_A_Mortgage_Or_Loan + " &
               "Tenure_Shared_Ownership_Part_Owned_And_Part_Rented ) @_SUM-CLAUSE-END_@ as mortgaged, " &         
               " @_SUM-CLAUSE-START_@ Tenure_Social_Rented_Total @_SUM-CLAUSE-END_@ as social_rented, " &         
               " @_SUM-CLAUSE-START_@ ( Tenure_Private_Rented_Total + " &         
               "Tenure_Living_Rent_Free )  @_SUM-CLAUSE-END_@ as private_rented_or_rent_free" );
            c.labels := Text_Utils.Split( "Owned outright, Mortgaged inc. Shared Ownwership, Social Rented, Private Rented, Rent-Free", ',' );
         when ethnic_group =>
            c.description := Make_Subs( "Ethnic Group: Aggregated (white, mixed, asian, black, other)" );
            c.output_columns := 4;
            c.clause := Make_Subs(
               " @_SUM-CLAUSE-START_@ ( ethgrp_white + ethgrp_other ) @_SUM-CLAUSE-END_@ as white_or_other, " & 
               " @_SUM-CLAUSE-START_@ ethgrp_mixed @_SUM-CLAUSE-END_@, " &
               " @_SUM-CLAUSE-START_@ ethgrp_asian @_SUM-CLAUSE-END_@, " &
               " @_SUM-CLAUSE-START_@ ethgrp_black @_SUM-CLAUSE-END_@ " );
            c.labels := Text_Utils.Split( "White,Mixed,Asian,Black,Other", ',' );
         when genders =>
            c.description := Make_Subs( "Genders (M/F) All residents" );
            c.output_columns := 2;
            c.clause := Make_Subs( 
               " @_SUM-CLAUSE-START_@ genders_males @_SUM-CLAUSE-END_@ as males, " &
               " @_SUM-CLAUSE-START_@ genders_females @_SUM-CLAUSE-END_@ as females " );
            c.labels.Add_To( "Male" );
            c.labels.Add_To( "Female" );
         when aggregated_ages =>
            c.description := Make_Subs( "Age in ranges: 0-4, 5-10, 11-15, 16-24, 25-34, 35-44, 45-54, 55-59, 60-64, 65-74, 75+" );
            c.output_columns := 11;
            c.clause := Make_Subs( 
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_under_1 + " &
               "age_ranges_age_1 + " &
               "age_ranges_age_2 + " &
               "age_ranges_age_3 + " &
               "age_ranges_age_4 ) @_SUM-CLAUSE-END_@ as age_u5, " & 
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_5 + " &
               "age_ranges_age_6 + " &
               "age_ranges_age_7 + " &
               "age_ranges_age_8 + " &
               "age_ranges_age_9 + " &
               "age_ranges_age_10 ) @_SUM-CLAUSE-END_@ as age_5_10, " & 
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_11 + " &
               "age_ranges_age_12 + " &
               "age_ranges_age_13 + " &
               "age_ranges_age_14 + " &
               "age_ranges_age_15 ) @_SUM-CLAUSE-END_@ as age_11_15, " & 
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_16 + " &
               "age_ranges_age_17 + " &
               "age_ranges_age_18 + " &
               "age_ranges_age_19 + " &
               "age_ranges_age_20 + " &
               "age_ranges_age_21 + " &
               "age_ranges_age_22 + " &
               "age_ranges_age_23 + " &
               "age_ranges_age_24 ) @_SUM-CLAUSE-END_@ as age_16_24, " & 
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_25 + " &
               "age_ranges_age_26 + " &
               "age_ranges_age_27 + " &
               "age_ranges_age_28 + " &
               "age_ranges_age_29 + " &
               "age_ranges_age_30 + " &
               "age_ranges_age_31 + " &
               "age_ranges_age_32 + " &
               "age_ranges_age_33 + " &
               "age_ranges_age_34 ) @_SUM-CLAUSE-END_@ as age_25_34, " &
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_35 + " &
               "age_ranges_age_36 + " &
               "age_ranges_age_37 + " &
               "age_ranges_age_38 + " &
               "age_ranges_age_39 + " &
               "age_ranges_age_40 + " &
               "age_ranges_age_41 + " &
               "age_ranges_age_42 + " &
               "age_ranges_age_43 + " &
               "age_ranges_age_44 ) @_SUM-CLAUSE-END_@ as age_35_44, " &
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_45 + " &
               "age_ranges_age_46 + " &
               "age_ranges_age_47 + " &
               "age_ranges_age_48 + " &
               "age_ranges_age_49 + " &
               "age_ranges_age_50 + " &
               "age_ranges_age_51 + " &
               "age_ranges_age_52 + " &
               "age_ranges_age_53 + " &
               "age_ranges_age_54 ) @_SUM-CLAUSE-END_@ as age_45_54, " &
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_55 + " &
               "age_ranges_age_56 + " &
               "age_ranges_age_57 + " &
               "age_ranges_age_58 + " &
               "age_ranges_age_59 ) @_SUM-CLAUSE-END_@ as age_55_59, " & 
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_60 + " &
               "age_ranges_age_61 + " &
               "age_ranges_age_62 + " &
               "age_ranges_age_63 + " &
               "age_ranges_age_64 ) @_SUM-CLAUSE-END_@ as age_60_64, " & 
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_65 + " &
               "age_ranges_age_66 + " &
               "age_ranges_age_67 + " &
               "age_ranges_age_68 + " &
               "age_ranges_age_69 + " &
               "age_ranges_age_70 + " &
               "age_ranges_age_71 + " &
               "age_ranges_age_72 + " &
               "age_ranges_age_73 + " &
               "age_ranges_age_74 ) @_SUM-CLAUSE-END_@ as age_65_74, " & 
               "@_SUM-CLAUSE-START_@ ( age_ranges_age_75 + " & 
               "age_ranges_age_76 + " & 
               "age_ranges_age_77 + " & 
               "age_ranges_age_78 + " & 
               "age_ranges_age_79 + " & 
               "age_ranges_age_80 + " & 
               "age_ranges_age_81 + " & 
               "age_ranges_age_82 + " & 
               "age_ranges_age_83 + " & 
               "age_ranges_age_84 + " & 
               "age_ranges_age_85 + " & 
               "age_ranges_age_86 + " & 
               "age_ranges_age_87 + " & 
               "age_ranges_age_88 + " & 
               "age_ranges_age_89 + " & 
               "age_ranges_age_90 + " & 
               "age_ranges_age_91 + " & 
               "age_ranges_age_92 + " & 
               "age_ranges_age_93 + " & 
               "age_ranges_age_94 + " & 
               "age_ranges_age_95 + " & 
               "age_ranges_age_96 + " & 
               "age_ranges_age_97 + " & 
               "age_ranges_age_98 + " & 
               "age_ranges_age_99 + " & 
               "age_ranges_age_100_and_over ) @_SUM-CLAUSE-END_@ as age_75_plus " );
            c.labels := Text_Utils.Split( "0-4,5-10,11-15,16-24,25-34,35-44,45-54,55-59,60-64,65-74,75+", ',' );
            
      when housing_benefit =>
            c.description := Make_Subs( "Housing Benefit" );
            c.output_columns := 1;
            c.clause := Make_Subs( "@_SUM-CLAUSE-START_@ HB_Total  @_SUM-CLAUSE-END_@" );
            c.labels.Add_To( "Housing Benefit" );
      when council_tax_benefit =>
            c.description := Make_Subs( "Council Tax Benefit (total recipients)" );
            c.output_columns := 1;
            c.clause := Make_Subs( "@_SUM-CLAUSE-START_@ Ct_All @_SUM-CLAUSE-END_@" );
            c.labels.Add_To( "Council Tax Benefit (total recipients)" );
      when hb_and_ctb =>
            c.description := Make_Subs( "Housing Benefit and Council Tax Benefit" );
            c.output_columns := 1;
            c.clause := Make_Subs( "@_SUM-CLAUSE-START_@ ( Ct_All + HB_Total ) @_SUM-CLAUSE-END_@ as ct_plus_hb" );
            c.labels.Add_To( "Housing Benefit and Council Tax Benefit (total recipients)" );
            
      when income_support =>
            c.description := Make_Subs( "Income Support" );
            c.output_columns := 1;
            c.clause := Make_Subs( "@_SUM-CLAUSE-START_@ income_support_people_claiming_benefit  @_SUM-CLAUSE-END_@ " );
            c.labels.Add_To( "Income Support (total recipients)" );
      when job_seekers_allowance =>
            c.description := Make_Subs( "Job Seekers' Allowance" );
            c.output_columns := 1;
            c.clause := Make_Subs( "@_SUM-CLAUSE-START_@ JSA_Total @_SUM-CLAUSE-END_@" );
            c.labels.Add_To( "Job Seekers' Allowance (total recipients)" );
      when is_jsa_combined =>
            c.description := Make_Subs( "Income Support and Job Seekers' Allowance" );
            c.output_columns := 1;
            c.clause := Make_Subs( "@_SUM-CLAUSE-START_@ ( JSA_Total + income_support_people_claiming_benefit )  @_SUM-CLAUSE-END_@ as jsa_is" );
            c.labels.Add_To( "Income Support and Job Seekers' Allowance (total recipients)" );
      when tax_credits =>
            c.description := Make_Subs( "Working Tax Credits and child tax credits" );
            c.output_columns := 1;
            c.clause := Make_Subs( "@_SUM-CLAUSE-START_@ Credits_Total_Families  @_SUM-CLAUSE-END_@ " );
            c.labels.Add_To( "Working Tax Credits and Child Tax Credits(total recipients)" );
      when pension_credits =>
            c.description := Make_Subs( "Pension credits" );
            c.output_columns := 1;
            c.clause := Make_Subs( "@_SUM-CLAUSE-START_@ pension_credits_number_of_claimants @_SUM-CLAUSE-END_@ " );
            c.labels.Add_To( "Pension Credits (total recipients)" );
      end case;
      return c;
   end Get_One_Clause;

   procedure Print_Diffs( label : String; target_populations: Vector; new_populations : Vector ) is
   use Ada.Text_IO;
      diff : Amount;
   begin
      Put_Line( label );
      for c in target_populations'Range loop
         Int_IO.Put( c, 0 );
         Put( Tab );
         Amount_IO.Put( target_populations( c ), 0, 3, 0 );
         Put( Tab );
         Amount_IO.Put( new_populations( c ), 0, 3, 0 );
         if( target_populations( c ) /= 0.0 )then
            diff := 100.0*( new_populations( c )-target_populations( c ))/target_populations( c );
         end if;
         Put( TAB );
         Amount_IO.Put( diff, 0, 4 , 0 );               
         New_Line;
      end loop;
   end Print_Diffs;
   
   function Count_Rows( cursor : in out gse.Direct_Cursor ) return Natural is
      c : Natural := 0;
   begin
      while gse.Has_Row( cursor ) loop
         gse.Next( cursor );
         c := c + 1;
      end loop;
      gse.First( cursor );
      return c;
   end Count_Rows;
   
   procedure Create_Weights(      
      sample                : Weighting_Sample_Type;
      clauses               : Selected_Clauses_Array;
      which_la              : String;
      start_year            : Data_Years;
      end_year              : Data_Years;      
      weighting_lower_bound : in Amount; 
      weighting_upper_bound : in Amount;
      weighting_function    : in Distance_Function_Type;
      error                 : out Eval_Error_Type;
      weighter              : in out Reweighter ) is
 
      t : La_Data_Data.Target_Candidates_Type;
      
      query         : gse.Prepared_Statement;
      cursor        : gse.Direct_Cursor;
      conn          : gse.Database_Connection := Connection_Pool.Lease;
      num_data_rows : Natural;
      num_data_cols : Natural;
      num_la_rows   : Natural;
      num_la_cols   : Natural;
      sqls          : constant SQL_Clause_Array := Create_SQL( 
         sample,
         clauses,   
         which_la,  
         start_year,
         end_year );
      use type gse.Field_Index;
   begin
      Log( "sample " & Weighting_Sample_Type'Image( sample ));
      Log( "which_la |" & which_la & "| ");
      Log( "start_year |" & Data_Years'Image( start_year ));
      Log( "end_year |" & Data_Years'Image( end_year ));
      Log( "weighting_function " & Distance_Function_Type'Image( weighting_function ));
      --
      -- fixme: we're retrieving this twice!
      --
      t := Target_Candidates_Type_IO.Retrieve_By_PK( 1, TuS( which_la ), FRS_Dataset_Creator.EDITION );
      --
      -- FIXME: this completely conflates DB and logic
      -- but I can't see an easy way out as we need to declare
      -- the reweighter to match the number of rows returned by the query
      -- 
      query := gse.Prepare( To_String( sqls( 2 ).clause ), On_Server => True );
      cursor.Fetch( conn, query );
      Check_Result( conn );
      num_data_rows := gse.Rows_Count( cursor );
      if( num_data_rows = 0 )then -- work around 8.4 psql where Rows_Count returns 0
         num_data_rows := Count_Rows( cursor );  
      end if;
      declare
         c2 : Natural := Count_Rows( cursor );
      begin
         Assert( num_data_rows = c2, " num_data_rows /= c2 c2 = " & c2'Img & " num_data_rows = " & num_data_rows'Img );
      end;
      num_data_cols := Positive( gse.Field_Count( cursor )) - 2;
      Log( "got num_data_rows " & num_data_rows'Img & " cols " & num_data_cols'Img );
      Assert( num_data_cols = sqls( 2 ).output_columns, 
         " mismatch in expected cols " & num_data_cols'Img &
         " vs " & sqls( 2 ).output_columns'Img );   
      -- todo Check_Result( conn );
      declare
         package Reweighter is new Maths_Funcs.Weights_Generator(    
            Num_Constraints   => num_data_cols,
            Num_Observations  => num_data_rows );
         subtype Col_Vector is Reweighter.Col_Vector;
         subtype Row_Vector is Reweighter.Row_Vector;
         subtype Dataset    is Reweighter.Dataset;
         type Indexes_Array is array( 1 .. num_data_rows ) of Weights_Index;
         type Indexes_Array_Access is access Indexes_Array; 
         --
         -- Stack overflow workaround
         --
         type Dataset_Access is access Reweighter.Dataset;
         procedure Free_Dataset is new Ada.Unchecked_Deallocation(
            Object => Dataset, Name => Dataset_Access );
         procedure Free_Indexes is new Ada.Unchecked_Deallocation(
            Object => Indexes_Array, Name => Indexes_Array_Access );
         observations       : Dataset_Access;
         target_populations : Row_Vector;
         initial_weight     : constant Amount := 
            Amount( t.tenure_all_categories_tenure ) / Amount( num_data_rows );
         curr_iterations    : Positive;
         weights            : Col_Vector;
         new_totals         : Row_Vector;
         weights_indexes    : Indexes_Array_Access;
         
         --
         --
         --
         initial_weights    : Col_Vector := ( others => initial_weight );
         one_weights        : Col_Vector := ( others => 1.0 );
         
      begin         
         --
         -- load the FRS data into observations
         -- 
         weights_indexes := new Indexes_Array;
         observations := new Dataset;
         observations.all := ( others => ( others => 0.0 ));
         for row in 1 .. num_data_rows loop
            cursor.Absolute( row );
            Log( "on row " & row'Img );
            weights_indexes.all( row ).id := Sernum_Value( cursor.Integer_Value( 0 ));
            weights_indexes.all( row ).year := Data_Constants.Year_From_Data_String( cursor.Value( 1 ));
            for col in 1 .. num_data_cols loop
               declare
                  fe : gse.Field_Index := gse.Field_Index( col+1 );
                  x : Amount := Amount( cursor.Float_Value( fe ));
               begin
                  observations.all( row, col ) := x;
               end;
            end loop;
         end loop;
         --
         -- get the corresponding LA data
         --
         declare
            qstr : constant String := To_String( sqls( 1 ).clause );
         begin
            Log( "q2 is " & qstr );
            query := gse.Prepare( To_String( sqls( 1 ).clause ), On_Server => True );
         end;
         cursor.Fetch( conn, query );
         Check_Result( conn );
         num_la_rows := gse.Rows_Count( cursor );
         if( num_la_rows = 0 )then -- work around 8.4 psql where Rows_Count returns 0
            num_la_rows := Count_Rows( cursor );  
         end if;
         num_la_cols := Positive( gse.Field_Count( cursor ))-2;
         Assert( num_la_rows = 1, "should have 1 LA row; had " & num_la_rows'Img );
         Assert( num_la_cols = sqls( 2 ).output_columns, 
            " mismatch in expected cols " & num_la_cols'Img &
            " vs " & sqls( 2 ).output_columns'Img );   
         cursor.Absolute( 1 );
         for col in 1 .. num_la_cols loop
            declare
               fe : gse.Field_Index := gse.Field_Index( col+1 );
               x : Amount := Amount( cursor.Float_Value( fe ));
            begin
               target_populations( col ) := x;
            end;
         end loop;
         new_totals := Reweighter.Sum_Dataset( observations.all, one_weights );
         Print_Diffs( "NON WEIGHTED", target_populations, new_totals );
         
         new_totals := Reweighter.Sum_Dataset( observations.all, initial_weights );
         Print_Diffs( "CRUDE WEIGHTED", target_populations, new_totals );
         
         Reweighter.Do_Reweighting(
            Data               => observations.all, 
            Which_Function     => weighting_function,
            Initial_Weights    => initial_weights,            
            Target_Populations => target_populations,
            TolX               => 0.01,
            TolF               => 0.01,
            Max_Iterations     => 40,
            RU                 => Weighting_Upper_Bound,
            RL                 => Weighting_Lower_Bound,
            New_Weights        => weights,
            Iterations         => curr_iterations,
            Error              => error );
         -- Assert( curr_error = normal, "error inReweighter.Do_Reweighting " & curr_error'Img );
         Log( "adding num_data_rows = " & num_data_rows'Img & " rows of data" );
         for row in 1 .. num_data_rows loop
            declare
               use Ada.Calendar;
               year        : Year_Number := weights_indexes.all( row ).year;
               id          : Sernum_Value := weights_indexes.all( row ).id;
               this_weight : Amount := weights( row );
            begin
               -- Log( "adding year = " & year'Img & " id " & id'Img & " weight " & this_weight'Img ); 
               weighter.Add( year, id, this_weight, weight );
            end;
         end loop;
         Log( "curr_iterations " & curr_iterations'Img & " curr_error " & error'Img );
         new_totals := Reweighter.Sum_Dataset( observations.all, weights );
         Print_Diffs( "FINAL WEIGHTED", target_populations, new_totals );
         Free_Dataset( observations );   
         Free_Indexes( weights_indexes );   
      end;
      Connection_Pool.Return_Connection( conn );
      Log( "returning w" );
     
   end Create_Weights;
   
   procedure Add( 
      w     : in out Reweighter; 
      year  : Data_Years;
      id    : Sernum_Value; 
      v     : Amount; 
      which : Weighting_Output_Type ) is
      wi : constant Weights_Index := ( year, id );
      wd : Weighting_Output_Array;
   begin
      if( w.Contains( wi ))then
         wd := w.Element( wi );
         wd( which ) := v;
         w.Replace( wi, wd );
      else
         wd := ( others => 0.0 );
         wd( which ) := v;
         w.Insert( wi, wd );
      end if;   
   end Add;
     
   function Contains( 
      w     : Reweighter; 
      year  : Data_Years; 
      id    : Sernum_Value ) return Boolean is
      wi : constant Weights_Index := ( year, id );
   begin
      return w.Contains( wi );
   end Contains;
   
   function Get(    
      w     : in out Reweighter; 
      year  : Data_Years; 
      id    : Sernum_Value; 
      which : Weighting_Output_Type ) return Amount is
      wi : constant Weights_Index := ( year, id );
      wd : Weighting_Output_Array;
   begin
      if( w.Contains( wi ))then
         wd := w.Element( wi );
         return wd( which );
      end if;
      return 0.0;
   end Get;
      
   procedure Dump( w : Reweighter; filename : String ) is
   use Ada.Text_IO;
   use Weights_Package;
      f : File_Type;
      
      procedure Write_One( c : Cursor ) is
         wi : constant Weights_Index := Key( c );
         wd : constant Weighting_Output_Array := Element( c );
      begin
         Put( f, Data_Constants.DATA_YEAR_STRINGS( wi.year ));
         Put( f, TAB );
         Int_IO.Put( f, Integer( wi.id ), 0 );
         Put( f, TAB );
         for i in Weighting_Output_Type loop
            Amount_IO.Put( f, wd( i ), 0, 3, 0 );
            if( i <  Weighting_Output_Type'Last )then
               Put( f, TAB );            
            end if;
         end loop;
         New_Line( f );
      end Write_One;
      
   begin
      Create( f, Out_File, filename );
      Put( f, '"' & "YEAR" & '"' & TAB & '"' & "SERNUM" & '"' & TAB );
      for i in Weighting_Output_Type loop
         Put( f, '"' & Weighting_Output_Type'Image( i ) & '"' );
            if( i <  Weighting_Output_Type'Last )then
               Put( f, TAB );            
            end if;
      end loop;
      New_Line( f );
      Iterate( w, Write_One'Access );
      Close( f );
   end Dump;   

    
end Model.FRS_Reweighter;
