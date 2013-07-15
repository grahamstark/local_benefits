--
-- Created by ada_generator.py on 2013-06-12 18:50:26.300093
-- 
with La_Data_Data;


with Ada.Containers.Vectors;

with Environment;

with DB_Commons; 

with GNATCOLL.SQL_Impl;
with GNATCOLL.SQL.Postgres;


with Ada.Exceptions;  
with Ada.Strings; 
with Ada.Strings.Wide_Fixed;
with Ada.Characters.Conversions;
with Ada.Strings.Unbounded; 
with Text_IO;
with Ada.Strings.Maps;
with Connection_Pool;
with GNATColl.Traces;

with Las_In_Region_Type_IO;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Las_Type_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "LAS_TYPE_IO" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   
   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   
   --
   -- generic packages to handle each possible type of decimal, if any, go here
   --


   
   --
   -- Select all variables; substring to be competed with output from some criteria
   --
   SELECT_PART : constant String := "select " &
         "code, name " &
         " from las " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into las (" &
         "code, name " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from las ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update las set  ";
   
   
   procedure Check_Result( conn : in out gse.Database_Connection ) is
      error_msg : constant String := gse.Error( conn );
   begin
      if( error_msg /= "" )then
         Log( error_msg );
         Connection_Pool.Return_Connection( conn );
         Raise_Exception( db_commons.DB_Exception'Identity, error_msg );
      end if;
   end  Check_Result;     


   

   --
   -- returns true if the primary key parts of Las_Type match the defaults in La_Data_Data.Null_Las_Type
   --
   --
   -- Does this Las_Type equal the default La_Data_Data.Null_Las_Type ?
   --
   function Is_Null( las : La_Data_Data.Las_Type ) return Boolean is
   use La_Data_Data;
   begin
      return las = La_Data_Data.Null_Las_Type;
   end Is_Null;


   
   --
   -- returns the single Las_Type matching the primary key fields, or the La_Data_Data.Null_Las_Type record
   -- if no such record exists
   --
   function Retrieve_By_PK( Code : Unbounded_String; connection : Database_Connection := null ) return La_Data_Data.Las_Type is
      l : La_Data_Data.Las_Type_List.Vector;
      las : La_Data_Data.Las_Type;
      c : d.Criteria;
   begin      
      Add_Code( c, Code );
      l := Retrieve( c, connection );
      if( not La_Data_Data.Las_Type_List.is_empty( l ) ) then
         las := La_Data_Data.Las_Type_List.First_Element( l );
      else
         las := La_Data_Data.Null_Las_Type;
      end if;
      return las;
   end Retrieve_By_PK;

   
   --
   -- Retrieves a list of La_Data_Data.Las_Type matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return La_Data_Data.Las_Type_List.Vector is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of La_Data_Data.Las_Type retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return La_Data_Data.Las_Type_List.Vector is
      l : La_Data_Data.Las_Type_List.Vector;
      ps : gse.Prepared_Statement;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      query : constant String := SELECT_PART & " " & sqlstr;
      cursor   : gse.Forward_Cursor;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "retrieve made this as query " & query );
      ps := gse.Prepare( query, On_Server => True );
      cursor.Fetch( local_connection, ps );
      Check_Result( local_connection );
      while gse.Has_Row( cursor ) loop
         declare
           las : La_Data_Data.Las_Type;
         begin
            if not gse.Is_Null( cursor, 0 )then
               las.Code:= To_Unbounded_String( gse.Value( cursor, 0 ));
            end if;
            if not gse.Is_Null( cursor, 1 )then
               las.Name:= To_Unbounded_String( gse.Value( cursor, 1 ));
            end if;
            l.append( las ); 
         end;
         gse.Next( cursor );
      end loop;
      if( is_local_connection )then
         local_connection.Commit;
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return l;
   end Retrieve;

   
   --
   -- Update the given record 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Update( las : La_Data_Data.Las_Type; connection : Database_Connection := null ) is
      pk_c : d.Criteria;
      values_c : d.Criteria;
      local_connection : Database_Connection;
      is_local_connection : Boolean;

   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      --
      -- values to be updated
      --
      Add_Name( values_c, las.Name );
      --
      -- primary key fields
      --
      Add_Code( pk_c, las.Code );
      declare      
         query : constant String := UPDATE_PART & " " & d.To_String( values_c, "," ) & d.To_String( pk_c );
      begin
         Log( "update; executing query" & query );
         gse.Execute( local_connection, query );
         Check_Result( local_connection );
         if( is_local_connection )then
            local_connection.Commit;
            Connection_Pool.Return_Connection( local_connection );
         end if;
      end;
   end Update;


   --
   -- Save the compelete given record 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( las : La_Data_Data.Las_Type; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      c : d.Criteria;
      las_tmp : La_Data_Data.Las_Type;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if( overwrite ) then
         las_tmp := retrieve_By_PK( las.Code );
         if( not is_Null( las_tmp )) then
            Update( las, local_connection );
            return;
         end if;
      end if;
      Add_Code( c, las.Code );
      Add_Name( c, las.Name );
      declare
         query : constant String := INSERT_PART & " ( "  & d.To_Crude_Array_Of_Values( c ) & " )";
      begin
         Log( "save; executing query" & query );
         gse.Execute( local_connection, query );
         local_connection.Commit;
         Check_Result( local_connection );
      end;   
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;


   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to La_Data_Data.Null_Las_Type
   --

   procedure Delete( las : in out La_Data_Data.Las_Type; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_Code( c, las.Code );
      Delete( c, connection );
      las := La_Data_Data.Null_Las_Type;
      Log( "delete record; execute query OK" );
   end Delete;


   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null ) is
   begin      
      delete( d.to_string( c ), connection );
      Log( "delete criteria; execute query OK" );
   end Delete;
   
   procedure Delete( where_Clause : String; connection : gse.Database_Connection := null ) is
      local_connection : gse.Database_Connection;     
      is_local_connection : Boolean;
      query : constant String := DELETE_PART & where_Clause;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "delete; executing query" & query );
      gse.Execute( local_connection, query );
      Check_Result( local_connection );
      Log( "delete; execute query OK" );
      if( is_local_connection )then
         local_connection.Commit;
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Delete;


   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --
   function Retrieve_Associated_Las_In_Region_Types( las : La_Data_Data.Las_Type; connection : Database_Connection := null ) return La_Data_Data.Las_In_Region_Type_List.Vector is
      c : d.Criteria;
   begin
      Las_In_Region_Type_IO.Add_Lacode( c, las.Code );
      return Las_In_Region_Type_IO.retrieve( c, connection );
   end Retrieve_Associated_Las_In_Region_Types;



   --
   -- functions to add something to a criteria
   --
   procedure Add_Code( c : in out d.Criteria; Code : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "code", op, join, To_String( Code ), 10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Code;


   procedure Add_Code( c : in out d.Criteria; Code : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "code", op, join, Code, 10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Code;


   procedure Add_Name( c : in out d.Criteria; Name : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "name", op, join, To_String( Name ), 60 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Name;


   procedure Add_Name( c : in out d.Criteria; Name : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "name", op, join, Name, 60 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Name;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Code_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "code", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Code_To_Orderings;


   procedure Add_Name_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "name", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Name_To_Orderings;


   
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Las_Type_IO;
