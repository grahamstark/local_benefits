with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with GNATColl.Traces;

with Text_Utils;

with AUnit.Assertions;             
with AUnit.Test_Cases; 
with Environment;
with Connection_Pool;
with Signal_Handler; 
with Weighting_Commons;

package body Model.FRS_Reweighter.Tests is

   use Ada.Strings.Unbounded;
   use Ada.Text_IO;
   use Weighting_Commons;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "FRS_DATASET_CREATOR-TESTS" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use AUnit.Test_Cases.Registration;
   
   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Calendar;

   procedure Test_Create_SQL( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      sq : SQL_Clause_Array;
      lacode : constant String := "E06000047";
      start_year :Data_Years := 2009;
      clauses : Selected_Clauses_Array := ( others => False );
   begin
      for c in Candidate_Clauses loop
         clauses( c ) := True;
         for end_year in start_year.. 2010 loop
            for sample in  Weighting_Sample_Type loop
               sq := Create_SQL( sample, clauses, lacode, start_year, end_year );
               Put_Line( "New Clause " & c'Img & " end year " & end_year'Img & " sample " & sample'Img );
               Put_Line( "retrieve LA SQL " & To_String( sq( 1 ).clause ));
               Put_Line( "num columns " & sq( 1 ).output_columns'Img );
               Put_Line( "retrieve FRS SQL " & To_String( sq( 2 ).clause ));
               Put_Line( "num columns " & sq( 2 ).output_columns'Img );               
            end loop;
         end loop;
      end loop;
   end Test_Create_SQL;
   
   procedure Test_Create_Weights( t : in out AUnit.Test_Cases.Test_Case'Class ) is
      wm : Reweighter;
      clauses : Selected_Clauses_Array := ( others => False );
      error   : Eval_Error_Type;
   begin   
      clauses( genders ) := True;
      clauses( ethnic_group ) := True;
      clauses( tenure ) := True;
      clauses( aggregated_ages ) := True;
      clauses( rooms_aggregated ) := True;
      clauses( occupation_disaggregated ) := True;
      Create_Weights(      
         sample                => whole_sample,
         clauses               => clauses,
         which_la              => "E06000008",
         start_year            => 2009,
         end_year              => 2010,
         weighting_lower_bound => 0.02,
         weighting_upper_bound => 20.0,
         weighting_function    => constrained_chi_square,
         error                 => error,
         weighter              => wm );
      Assert( error = normal, "error condition " & error'Img );
      wm.Dump( "output/wm_dump_01.csv" );
   end Test_Create_Weights;
   
   procedure Register_Tests (T : in out Test_Case) is      
   begin
      Register_Routine (T, Test_Create_SQL'Access, "Test_Create_SQL" );
      Register_Routine (T, Test_Create_Weights'Access, "Test_Create_Weights" );
   end Register_Tests;
   
   --  Register routines to be run
   
   
   function Name ( t : Test_Case ) return Message_String is
   begin
      return Format( "FRS Dataset Creator Test Suite" );
   end Name;

   --  Preparation performed before each routine:
   procedure Set_Up( t : in out Test_Case ) is
   begin
      null;
   end Set_Up;
   
   --  Preparation performed after each routine:
   procedure Shut_Down( t : in out Test_Case ) is
   begin
      null;
   end Shut_Down;
   

end Model.FRS_Reweighter.Tests;
