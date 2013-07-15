with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with GNATColl.Traces;

with Text_Utils;

with AUnit.Assertions;             
with AUnit.Test_Cases; 

package body LA_Reweighter.Tests is

   use Ada.Strings.Unbounded;
   use Ada.Text_IO;
  
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "LA_REWEIGHTER.TESTS" );
   
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
   
   procedure Create_Datasets_Tests ( t : in out AUnit.Test_Cases.Test_Case'Class ) is
   begin
      Put_Line( Header_String );
      Make_And_Store_FRS_Datasets( "output/31_variables_v2/created_datasets/" );
   end Create_Datasets_Tests;
   
   procedure Create_Weights_Tests ( t : in out AUnit.Test_Cases.Test_Case'Class ) is
   begin
      Put_Line( Header_String );
      for wt in Weighting_Sample_Type loop
         declare
            outdir : constant String := "output/31_variables_v2/weights/" & Text_Utils.Censor_String( wt'Img ) & "/";
         begin
            Put_Line( "Writing to |" & outdir & "|" );
            Create_Weights(
               frs_dir               => "output/31_variables_v2/created_datasets/",
               output_dir            => outdir,
               start_la              => District_Or_Unitary_Authorities'First,
               end_la                => District_Or_Unitary_Authorities'Last, -- ualad09_hartlepool, 
               target_type           => wt,
               weighting_lower_bound => 1.0/200.0,
               weighting_upper_bound => 200.0,
               weighting_function    => constrained_chi_square );
         end;
      end loop;
   end Create_Weights_Tests;      
   
   procedure Register_Tests (T : in out Test_Case) is      
   begin
      null;
      -- Register_Routine (T, Create_Datasets_Tests'Access, "Create_Datasets_Tests" );
      -- Register_Routine (T, Create_Weights_Tests'Access, "Create_Weights_Tests" );
   end Register_Tests;
   
   --  Register routines to be run
   
   
   function Name ( t : Test_Case ) return Message_String is
   begin
      return Format( "Lab_Test Test Suite" );
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
   
begin
   Read_Pointers( "data/frs/hh_regional_pointers.csv" );
end LA_Reweighter.Tests;
