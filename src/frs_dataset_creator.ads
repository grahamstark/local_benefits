with RAW_FRS;
with La_Data_Data;
with Data_Constants;

package FRS_Dataset_Creator is

   use Data_Constants;
   
   procedure Create_Dataset( start_year, end_year : Data_Years );
   
   Weighting_Exception : Exception;
   
   EDITION : constant := 1;
 
private
   
   function Map_Household( hh : Raw_FRS.Raw_Household ) return La_Data_Data.Target_Candidates_Type;
   
end FRS_Dataset_Creator;
