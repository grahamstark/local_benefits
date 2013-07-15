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

package body FRS_Dataset_Creator.Tests is

   use Ada.Strings.Unbounded;
   use Ada.Text_IO;
  
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

   procedure Test_Create_FRS( t : in out AUnit.Test_Cases.Test_Case'Class ) is
   begin
      Create_Dataset( 2009, 2010 );
   end  Test_Create_FRS;
   
   procedure Register_Tests (T : in out Test_Case) is      
   begin
      Register_Routine (T, Test_Create_FRS'Access, "Test_Create_FRS" );
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
   
begin
   Connection_Pool.Initialise(
      Environment.Get_Server_Name,
      Environment.Get_Database_Name,
      Environment.Get_Username,
      Environment.Get_Password,
      2 );
end FRS_Dataset_Creator.Tests;
