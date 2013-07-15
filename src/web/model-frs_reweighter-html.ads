with Ada.Strings.Unbounded;
with AWS.Status;
with La_Data_Data;

package Model.FRS_Reweighter.HTML is
   
   use Ada.Strings.Unbounded;
   use La_Data_Data;
   
   function Handle_Input_Page( request : in AWS.Status.Data; la : LAs_Type ) return String;    

end Model.FRS_Reweighter.HTML;
