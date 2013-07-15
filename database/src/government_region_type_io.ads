--
-- Created by ada_generator.py on 2013-06-12 18:50:26.312912
-- 
with La_Data_Data;
with DB_Commons;
with Base_Types;
with ADA.Calendar;
with Ada.Strings.Unbounded;

with GNATCOLL.SQL.Exec;


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Government_Region_Type_IO is
  
   package d renames DB_Commons;   
   use Base_Types;
   use Ada.Strings.Unbounded;
   
   use GNATCOLL.SQL.Exec;
   

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   
   function Next_Free_Frs_Region_Code( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of Government_Region_Type match the defaults in La_Data_Data.Null_Government_Region_Type
   --
   function Is_Null( government_region : La_Data_Data.Government_Region_Type ) return Boolean;
   
   --
   -- returns the single Government_Region_Type matching the primary key fields, or the La_Data_Data.Null_Government_Region_Type record
   -- if no such record exists
   --
   function Retrieve_By_PK( Frs_Region_Code : Integer; connection : Database_Connection := null ) return La_Data_Data.Government_Region_Type;
   
   --
   -- Retrieves a list of La_Data_Data.Government_Region_Type matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return La_Data_Data.Government_Region_Type_List.Vector;
   
   --
   -- Retrieves a list of La_Data_Data.Government_Region_Type retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return La_Data_Data.Government_Region_Type_List.Vector;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( government_region : La_Data_Data.Government_Region_Type; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to La_Data_Data.Null_Government_Region_Type
   --
   procedure Delete( government_region : in out La_Data_Data.Government_Region_Type; connection : Database_Connection := null );
   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null );
   --
   -- delete all the records identified by the where SQL clause 
   --
   procedure Delete( where_Clause : String; connection : Database_Connection := null );
   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --
   function Retrieve_Associated_Las_In_Region_Types( government_region : La_Data_Data.Government_Region_Type; connection : Database_Connection := null ) return La_Data_Data.Las_In_Region_Type_List.Vector;
   function Retrieve_Associated_Regions_In_Country_Types( government_region : La_Data_Data.Government_Region_Type; connection : Database_Connection := null ) return La_Data_Data.Regions_In_Country_Type_List.Vector;

   --
   -- functions to add something to a criteria
   --
   procedure Add_Name( c : in out d.Criteria; Name : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Name( c : in out d.Criteria; Name : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Frs_Region_Code( c : in out d.Criteria; Frs_Region_Code : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Name_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Frs_Region_Code_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Government_Region_Type_IO;
