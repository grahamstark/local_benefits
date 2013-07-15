--
-- Created by ada_generator.py on 2013-04-12 16:52:17.761831
-- 
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with AUnit.Test_Cases; 
with AUnit;

package Model.FRS_Reweighter.Tests is
    use AUnit.Test_Cases;
    use AUnit;
    
    type Test_Case is new AUnit.Test_Cases.Test_Case with null record;
    
    procedure Register_Tests (T : in out Test_Case);
    --  Register routines to be run
    
    function Name (T : Test_Case) return Message_String;
    --  Returns name identifying the test case
    
    --  Override if needed. Default empty implementations provided:
    
    --  Preparation performed before each routine:
    procedure Set_Up (T : in out Test_Case);
    
    
end Model.FRS_Reweighter.Tests;
