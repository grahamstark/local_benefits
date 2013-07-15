with Base_Model_Types; 
with RAW_FRS;
with Weighting_Commons;
with Ada.Calendar;
with Data_Constants;
with Ada.Containers.Ordered_Maps;
with Ada.Strings.Unbounded;
with Text_Utils;
package Model.FRS_Reweighter is
   
   use Base_Model_Types;
   use Weighting_Commons;
   use Data_Constants;
   use Ada.Strings.Unbounded;
   
   type Weighting_Sample_Type is ( whole_sample, england_and_wales, england, government_region );

   type LA_Code is new String( 1 .. 10 );
   
   type Candidate_Clauses is ( 
      aggregated_ages, 
      genders, 
      ethnic_group, 
      tenure, 
      rooms_aggregated, 
      rooms_disaggregated,
      occupation_aggregated,
      occupation_disaggregated,
      economic_activity_aggregated,
      economic_activity_disaggregated,
      housing_benefit,
      council_tax_benefit,
      hb_and_ctb,
      income_support,
      job_seekers_allowance,
      is_jsa_combined,
      tax_credits,
      pension_credits
      );
   type Selected_Clauses_Array is array( Candidate_Clauses ) of Boolean;

   type Weighting_Output_Type is ( weight, earnings, unearned, rents, other_housing, ct );

   type Reweighter is tagged private;

   function Contains( 
      w     : Reweighter; 
      year  : Data_Years; 
      id    : Sernum_Value ) return Boolean; 
   
   procedure Add( 
      w     : in out Reweighter; 
      year  : Data_Years; 
      id    : Sernum_Value; 
      v     : Amount; 
      which : Weighting_Output_Type );
      
   function Get(    
      w     : in out Reweighter; 
      year  : Data_Years; 
      id    : Sernum_Value; 
      which : Weighting_Output_Type ) return Amount;
      
   procedure Dump( w : Reweighter; filename : String );   
      
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
      weighter              : in out Reweighter );
   
private
   
   type SQL_Clause is tagged record
      clause         : Unbounded_String := Null_Unbounded_String;
      output_columns : Natural          := 0;
      description    : Unbounded_String := Null_Unbounded_String;
      labels         : Text_Utils.Unbounded_String_List;
   end record;
   
   type SQL_Clause_Array is array( 1 .. 2 ) of SQL_Clause;
   
   function Get_One_Clause( which : Candidate_Clauses; is_sum : Boolean; multiplier : Amount := 0.0 ) return SQL_Clause;

   function Create_SQL( 
      sample                : Weighting_Sample_Type;
      clauses               : Selected_Clauses_Array;
      which_la              : String;
      start_year            : Data_Years;
      end_year              : Data_Years ) return SQL_Clause_Array;      

   type Weights_Index is record
      year : Data_Years;
      id   : Sernum_Value;
   end record;
   
   type Weighting_Output_Array is array( Weighting_Output_Type ) of Amount;

   function Equal_Weights_Index( left, right : Weights_Index ) return Boolean;  
   function Lt_Weights_Index( left, right : Weights_Index ) return Boolean;  
   
   package Weights_Package is new Ada.Containers.Ordered_Maps(
      Key_Type     => Weights_Index,
      Element_Type => Weighting_Output_Array,
      "="          => "=",
      "<"          => Lt_Weights_Index );
   subtype Weights_Map is Weights_Package.Map;      

   type Reweighter is new Weights_Map with null record;
   
  function Get_One_Dataset_For_LA( 
      sql             : String ) return Vector;
      
   function Get_Uniform_Weight( 
      sample                : Weighting_Sample_Type;
      start_year            : Data_Years;
      end_year              : Data_Years;
      which_la              : String ) return Amount;
      
   function Make_Year_And_Region_Clause( 
      sample     : Weighting_Sample_Type;
      start_year : Data_Years;
      end_year   : Data_Years;
      which_la   : String ) return Unbounded_String;   
end Model.FRS_Reweighter;
