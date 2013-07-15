--
-- Created by ada_generator.py on 2013-06-12 18:50:26.090090
-- 
with La_Data_Data;
with DB_Commons;
with Base_Types;
with ADA.Calendar;
with Ada.Strings.Unbounded;

with GNATCOLL.SQL.Exec;


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Target_Candidates_Type_IO is
  
   package d renames DB_Commons;   
   use Base_Types;
   use Ada.Strings.Unbounded;
   
   use GNATCOLL.SQL.Exec;
   

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   
   function Next_Free_Id( connection : Database_Connection := null) return Integer;
   function Next_Free_Edition( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of Target_Candidates_Type match the defaults in La_Data_Data.Null_Target_Candidates_Type
   --
   function Is_Null( target_candidates : La_Data_Data.Target_Candidates_Type ) return Boolean;
   
   --
   -- returns the single Target_Candidates_Type matching the primary key fields, or the La_Data_Data.Null_Target_Candidates_Type record
   -- if no such record exists
   --
   function Retrieve_By_PK( Id : Integer; Code : Unbounded_String; Edition : Integer; connection : Database_Connection := null ) return La_Data_Data.Target_Candidates_Type;
   
   --
   -- Retrieves a list of La_Data_Data.Target_Candidates_Type matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return La_Data_Data.Target_Candidates_Type_List.Vector;
   
   --
   -- Retrieves a list of La_Data_Data.Target_Candidates_Type retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return La_Data_Data.Target_Candidates_Type_List.Vector;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( target_candidates : La_Data_Data.Target_Candidates_Type; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to La_Data_Data.Null_Target_Candidates_Type
   --
   procedure Delete( target_candidates : in out La_Data_Data.Target_Candidates_Type; connection : Database_Connection := null );
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

   --
   -- functions to add something to a criteria
   --
   procedure Add_Id( c : in out d.Criteria; Id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Code( c : in out d.Criteria; Code : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Code( c : in out d.Criteria; Code : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Edition( c : in out d.Criteria; Edition : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Frs_Region( c : in out d.Criteria; Frs_Region : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hb_Total( c : in out d.Criteria; Hb_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hb_Social_Rented_Sector( c : in out d.Criteria; Hb_Social_Rented_Sector : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hb_Private_Rented_Sector( c : in out d.Criteria; Hb_Private_Rented_Sector : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hb_Passported( c : in out d.Criteria; Hb_Passported : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hb_Non_Passported( c : in out d.Criteria; Hb_Non_Passported : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ct_All( c : in out d.Criteria; Ct_All : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ct_Passported( c : in out d.Criteria; Ct_Passported : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ct_Non_Passported( c : in out d.Criteria; Ct_Non_Passported : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Genders_All_Usual_Residents( c : in out d.Criteria; Genders_All_Usual_Residents : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Genders_Males( c : in out d.Criteria; Genders_Males : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Genders_Females( c : in out d.Criteria; Genders_Females : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Genders_Lives_In_A_Household( c : in out d.Criteria; Genders_Lives_In_A_Household : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Genders_Lives_In_A_Communal_Establishment( c : in out d.Criteria; Genders_Lives_In_A_Communal_Establishment : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Genders_Schoolchild_Or_Student_Non_Term_Time_Address( c : in out d.Criteria; Genders_Schoolchild_Or_Student_Non_Term_Time_Address : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_All_Categories_Age( c : in out d.Criteria; Age_Ranges_All_Categories_Age : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_Under_1( c : in out d.Criteria; Age_Ranges_Age_Under_1 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_1( c : in out d.Criteria; Age_Ranges_Age_1 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_2( c : in out d.Criteria; Age_Ranges_Age_2 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_3( c : in out d.Criteria; Age_Ranges_Age_3 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_4( c : in out d.Criteria; Age_Ranges_Age_4 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_5( c : in out d.Criteria; Age_Ranges_Age_5 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_6( c : in out d.Criteria; Age_Ranges_Age_6 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_7( c : in out d.Criteria; Age_Ranges_Age_7 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_8( c : in out d.Criteria; Age_Ranges_Age_8 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_9( c : in out d.Criteria; Age_Ranges_Age_9 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_10( c : in out d.Criteria; Age_Ranges_Age_10 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_11( c : in out d.Criteria; Age_Ranges_Age_11 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_12( c : in out d.Criteria; Age_Ranges_Age_12 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_13( c : in out d.Criteria; Age_Ranges_Age_13 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_14( c : in out d.Criteria; Age_Ranges_Age_14 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_15( c : in out d.Criteria; Age_Ranges_Age_15 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_16( c : in out d.Criteria; Age_Ranges_Age_16 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_17( c : in out d.Criteria; Age_Ranges_Age_17 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_18( c : in out d.Criteria; Age_Ranges_Age_18 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_19( c : in out d.Criteria; Age_Ranges_Age_19 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_20( c : in out d.Criteria; Age_Ranges_Age_20 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_21( c : in out d.Criteria; Age_Ranges_Age_21 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_22( c : in out d.Criteria; Age_Ranges_Age_22 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_23( c : in out d.Criteria; Age_Ranges_Age_23 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_24( c : in out d.Criteria; Age_Ranges_Age_24 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_25( c : in out d.Criteria; Age_Ranges_Age_25 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_26( c : in out d.Criteria; Age_Ranges_Age_26 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_27( c : in out d.Criteria; Age_Ranges_Age_27 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_28( c : in out d.Criteria; Age_Ranges_Age_28 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_29( c : in out d.Criteria; Age_Ranges_Age_29 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_30( c : in out d.Criteria; Age_Ranges_Age_30 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_31( c : in out d.Criteria; Age_Ranges_Age_31 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_32( c : in out d.Criteria; Age_Ranges_Age_32 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_33( c : in out d.Criteria; Age_Ranges_Age_33 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_34( c : in out d.Criteria; Age_Ranges_Age_34 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_35( c : in out d.Criteria; Age_Ranges_Age_35 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_36( c : in out d.Criteria; Age_Ranges_Age_36 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_37( c : in out d.Criteria; Age_Ranges_Age_37 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_38( c : in out d.Criteria; Age_Ranges_Age_38 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_39( c : in out d.Criteria; Age_Ranges_Age_39 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_40( c : in out d.Criteria; Age_Ranges_Age_40 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_41( c : in out d.Criteria; Age_Ranges_Age_41 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_42( c : in out d.Criteria; Age_Ranges_Age_42 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_43( c : in out d.Criteria; Age_Ranges_Age_43 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_44( c : in out d.Criteria; Age_Ranges_Age_44 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_45( c : in out d.Criteria; Age_Ranges_Age_45 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_46( c : in out d.Criteria; Age_Ranges_Age_46 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_47( c : in out d.Criteria; Age_Ranges_Age_47 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_48( c : in out d.Criteria; Age_Ranges_Age_48 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_49( c : in out d.Criteria; Age_Ranges_Age_49 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_50( c : in out d.Criteria; Age_Ranges_Age_50 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_51( c : in out d.Criteria; Age_Ranges_Age_51 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_52( c : in out d.Criteria; Age_Ranges_Age_52 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_53( c : in out d.Criteria; Age_Ranges_Age_53 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_54( c : in out d.Criteria; Age_Ranges_Age_54 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_55( c : in out d.Criteria; Age_Ranges_Age_55 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_56( c : in out d.Criteria; Age_Ranges_Age_56 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_57( c : in out d.Criteria; Age_Ranges_Age_57 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_58( c : in out d.Criteria; Age_Ranges_Age_58 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_59( c : in out d.Criteria; Age_Ranges_Age_59 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_60( c : in out d.Criteria; Age_Ranges_Age_60 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_61( c : in out d.Criteria; Age_Ranges_Age_61 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_62( c : in out d.Criteria; Age_Ranges_Age_62 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_63( c : in out d.Criteria; Age_Ranges_Age_63 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_64( c : in out d.Criteria; Age_Ranges_Age_64 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_65( c : in out d.Criteria; Age_Ranges_Age_65 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_66( c : in out d.Criteria; Age_Ranges_Age_66 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_67( c : in out d.Criteria; Age_Ranges_Age_67 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_68( c : in out d.Criteria; Age_Ranges_Age_68 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_69( c : in out d.Criteria; Age_Ranges_Age_69 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_70( c : in out d.Criteria; Age_Ranges_Age_70 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_71( c : in out d.Criteria; Age_Ranges_Age_71 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_72( c : in out d.Criteria; Age_Ranges_Age_72 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_73( c : in out d.Criteria; Age_Ranges_Age_73 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_74( c : in out d.Criteria; Age_Ranges_Age_74 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_75( c : in out d.Criteria; Age_Ranges_Age_75 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_76( c : in out d.Criteria; Age_Ranges_Age_76 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_77( c : in out d.Criteria; Age_Ranges_Age_77 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_78( c : in out d.Criteria; Age_Ranges_Age_78 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_79( c : in out d.Criteria; Age_Ranges_Age_79 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_80( c : in out d.Criteria; Age_Ranges_Age_80 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_81( c : in out d.Criteria; Age_Ranges_Age_81 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_82( c : in out d.Criteria; Age_Ranges_Age_82 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_83( c : in out d.Criteria; Age_Ranges_Age_83 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_84( c : in out d.Criteria; Age_Ranges_Age_84 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_85( c : in out d.Criteria; Age_Ranges_Age_85 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_86( c : in out d.Criteria; Age_Ranges_Age_86 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_87( c : in out d.Criteria; Age_Ranges_Age_87 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_88( c : in out d.Criteria; Age_Ranges_Age_88 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_89( c : in out d.Criteria; Age_Ranges_Age_89 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_90( c : in out d.Criteria; Age_Ranges_Age_90 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_91( c : in out d.Criteria; Age_Ranges_Age_91 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_92( c : in out d.Criteria; Age_Ranges_Age_92 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_93( c : in out d.Criteria; Age_Ranges_Age_93 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_94( c : in out d.Criteria; Age_Ranges_Age_94 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_95( c : in out d.Criteria; Age_Ranges_Age_95 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_96( c : in out d.Criteria; Age_Ranges_Age_96 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_97( c : in out d.Criteria; Age_Ranges_Age_97 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_98( c : in out d.Criteria; Age_Ranges_Age_98 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_99( c : in out d.Criteria; Age_Ranges_Age_99 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Age_Ranges_Age_100_And_Over( c : in out d.Criteria; Age_Ranges_Age_100_And_Over : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_All_Categories_Accommodation_Type( c : in out d.Criteria; Accom_All_Categories_Accommodation_Type : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Total( c : in out d.Criteria; Accom_Unshared_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Total( c : in out d.Criteria; Accom_Unshared_Whole_House_Or_Bungalow_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Detached( c : in out d.Criteria; Accom_Unshared_Whole_House_Or_Bungalow_Detached : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached( c : in out d.Criteria; Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Terraced( c : in out d.Criteria; Accom_Unshared_Whole_House_Or_Bungalow_Terraced : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Flat_Maisonette_Or_Apartment_Total( c : in out d.Criteria; Accom_Unshared_Flat_Maisonette_Or_Apartment_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement( c : in out d.Criteria; Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House( c : in out d.Criteria; Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Flat_Etc_In_Commercial_Building( c : in out d.Criteria; Accom_Unshared_Flat_Etc_In_Commercial_Building : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Unshared_Caravan_Etc( c : in out d.Criteria; Accom_Unshared_Caravan_Etc : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Accom_Shared( c : in out d.Criteria; Accom_Shared : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_All_Categories_Economic_Activity( c : in out d.Criteria; Ec_Act_All_Categories_Economic_Activity : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Active_Total( c : in out d.Criteria; Ec_Act_Active_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Active_Employee_Part_Time( c : in out d.Criteria; Ec_Act_Active_Employee_Part_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Active_Employee_Full_Time( c : in out d.Criteria; Ec_Act_Active_Employee_Full_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Active_Self_Employed_With_Employees_Part_Time( c : in out d.Criteria; Ec_Act_Active_Self_Employed_With_Employees_Part_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Active_Self_Employed_With_Employees_Full_Time( c : in out d.Criteria; Ec_Act_Active_Self_Employed_With_Employees_Full_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Active_Self_Employed_Without_Employees_Part_Time( c : in out d.Criteria; Ec_Act_Active_Self_Employed_Without_Employees_Part_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Active_Self_Employed_Without_Employees_Full_Time( c : in out d.Criteria; Ec_Act_Active_Self_Employed_Without_Employees_Full_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Active_Unemployed( c : in out d.Criteria; Ec_Act_Active_Unemployed : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Active_Full_Time_Student( c : in out d.Criteria; Ec_Act_Active_Full_Time_Student : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Inactive_Total( c : in out d.Criteria; Ec_Act_Inactive_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Inactive_Retired( c : in out d.Criteria; Ec_Act_Inactive_Retired : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Inactive_Student_Including_Full_Time_Students( c : in out d.Criteria; Ec_Act_Inactive_Student_Including_Full_Time_Students : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Inactive_Looking_After_Home_Or_Family( c : in out d.Criteria; Ec_Act_Inactive_Looking_After_Home_Or_Family : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Inactive_Long_Term_Sick_Or_Disabled( c : in out d.Criteria; Ec_Act_Inactive_Long_Term_Sick_Or_Disabled : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ec_Act_Inactive_Other( c : in out d.Criteria; Ec_Act_Inactive_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_All_Categories_Ethnic_Group( c : in out d.Criteria; Ethgrp_All_Categories_Ethnic_Group : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_White( c : in out d.Criteria; Ethgrp_White : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British( c : in out d.Criteria; Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_White_Irish( c : in out d.Criteria; Ethgrp_White_Irish : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_White_Gypsy_Or_Irish_Traveller( c : in out d.Criteria; Ethgrp_White_Gypsy_Or_Irish_Traveller : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_White_Other_White( c : in out d.Criteria; Ethgrp_White_Other_White : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Mixed( c : in out d.Criteria; Ethgrp_Mixed : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean( c : in out d.Criteria; Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African( c : in out d.Criteria; Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian( c : in out d.Criteria; Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed( c : in out d.Criteria; Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Asian( c : in out d.Criteria; Ethgrp_Asian : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Asian_Asian_British_Indian( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Indian : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Asian_Asian_British_Pakistani( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Pakistani : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Asian_Asian_British_Bangladeshi( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Bangladeshi : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Asian_Asian_British_Chinese( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Chinese : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Asian_Asian_British_Other_Asian( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Other_Asian : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Black( c : in out d.Criteria; Ethgrp_Black : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_African( c : in out d.Criteria; Ethgrp_Black_African_Caribbean_Black_British_African : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_Caribbean( c : in out d.Criteria; Ethgrp_Black_African_Caribbean_Black_British_Caribbean : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_Other_Black( c : in out d.Criteria; Ethgrp_Black_African_Caribbean_Black_British_Other_Black : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Other( c : in out d.Criteria; Ethgrp_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Other_Ethnic_Group_Arab( c : in out d.Criteria; Ethgrp_Other_Ethnic_Group_Arab : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group( c : in out d.Criteria; Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_All_Categories_Household_Composition( c : in out d.Criteria; Hcomp_All_Categories_Household_Composition : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Person_Household_Total( c : in out d.Criteria; Hcomp_One_Person_Household_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Person_Household_Aged_65_And_Over( c : in out d.Criteria; Hcomp_One_Person_Household_Aged_65_And_Over : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Person_Household_Other( c : in out d.Criteria; Hcomp_One_Person_Household_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_All_Aged_65_And_Over( c : in out d.Criteria; Hcomp_One_Family_Only_All_Aged_65_And_Over : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_No_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_No_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_One_Dep_Child( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child( c : in out d.Criteria; Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids( c : in out d.Criteria; Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep( c : in out d.Criteria; Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Lone_Parent_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Lone_Parent_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child( c : in out d.Criteria; Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep( c : in out d.Criteria; Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_Other_Total( c : in out d.Criteria; Hcomp_Other_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_Other_With_One_Dep_Child( c : in out d.Criteria; Hcomp_Other_With_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_Other_With_Two_Or_More_Dep_Kids( c : in out d.Criteria; Hcomp_Other_With_Two_Or_More_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_Other_All_Full_Time_Students( c : in out d.Criteria; Hcomp_Other_All_Full_Time_Students : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_Other_All_Aged_65_And_Over( c : in out d.Criteria; Hcomp_Other_All_Aged_65_And_Over : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Hcomp_Other_Other( c : in out d.Criteria; Hcomp_Other_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_All_Categories_Number_Of_Rooms( c : in out d.Criteria; Number_Of_Rooms_All_Categories_Number_Of_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_1_Room( c : in out d.Criteria; Number_Of_Rooms_1_Room : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_2_Rooms( c : in out d.Criteria; Number_Of_Rooms_2_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_3_Rooms( c : in out d.Criteria; Number_Of_Rooms_3_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_4_Rooms( c : in out d.Criteria; Number_Of_Rooms_4_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_5_Rooms( c : in out d.Criteria; Number_Of_Rooms_5_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_6_Rooms( c : in out d.Criteria; Number_Of_Rooms_6_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_7_Rooms( c : in out d.Criteria; Number_Of_Rooms_7_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_8_Rooms( c : in out d.Criteria; Number_Of_Rooms_8_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Number_Of_Rooms_9_Or_More_Rooms( c : in out d.Criteria; Number_Of_Rooms_9_Or_More_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Residence_All_Categories_Residence_Type( c : in out d.Criteria; Residence_All_Categories_Residence_Type : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Residence_Lives_In_A_Household( c : in out d.Criteria; Residence_Lives_In_A_Household : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Residence_Lives_In_A_Communal_Establishment( c : in out d.Criteria; Residence_Lives_In_A_Communal_Establishment : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Residence_Communal_Establishments_With_Persons_Sleeping_Rough( c : in out d.Criteria; Residence_Communal_Establishments_With_Persons_Sleeping_Rough : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_All_Categories_Tenure( c : in out d.Criteria; Tenure_All_Categories_Tenure : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Owned_Total( c : in out d.Criteria; Tenure_Owned_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Owned_Owned_Outright( c : in out d.Criteria; Tenure_Owned_Owned_Outright : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Owned_Owned_With_A_Mortgage_Or_Loan( c : in out d.Criteria; Tenure_Owned_Owned_With_A_Mortgage_Or_Loan : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Shared_Ownership_Part_Owned_And_Part_Rented( c : in out d.Criteria; Tenure_Shared_Ownership_Part_Owned_And_Part_Rented : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Social_Rented_Total( c : in out d.Criteria; Tenure_Social_Rented_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Social_Rented_Rented_From_Council_Local_Authority( c : in out d.Criteria; Tenure_Social_Rented_Rented_From_Council_Local_Authority : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Social_Rented_Other_Social_Rented( c : in out d.Criteria; Tenure_Social_Rented_Other_Social_Rented : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Private_Rented_Total( c : in out d.Criteria; Tenure_Private_Rented_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency( c : in out d.Criteria; Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Private_Rented_Employer_Of_A_Household_Member( c : in out d.Criteria; Tenure_Private_Rented_Employer_Of_A_Household_Member : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Private_Rented_Relative_Or_Friend_Of_Household( c : in out d.Criteria; Tenure_Private_Rented_Relative_Or_Friend_Of_Household : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Private_Rented_Other( c : in out d.Criteria; Tenure_Private_Rented_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Tenure_Living_Rent_Free( c : in out d.Criteria; Tenure_Living_Rent_Free : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_All_Categories_Occupation( c : in out d.Criteria; Occupation_All_Categories_Occupation : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_1_Managers_Directors_And_Senior_Officials( c : in out d.Criteria; Occupation_1_Managers_Directors_And_Senior_Officials : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_2_Professional_Occupations( c : in out d.Criteria; Occupation_2_Professional_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_3_Associate_Professional_And_Technical_Occupations( c : in out d.Criteria; Occupation_3_Associate_Professional_And_Technical_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_4_Administrative_And_Secretarial_Occupations( c : in out d.Criteria; Occupation_4_Administrative_And_Secretarial_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_5_Skilled_Trades_Occupations( c : in out d.Criteria; Occupation_5_Skilled_Trades_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_6_Caring_Leisure_And_Other_Service_Occupations( c : in out d.Criteria; Occupation_6_Caring_Leisure_And_Other_Service_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_7_Sales_And_Customer_Service_Occupations( c : in out d.Criteria; Occupation_7_Sales_And_Customer_Service_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_8_Process_Plant_And_Machine_Operatives( c : in out d.Criteria; Occupation_8_Process_Plant_And_Machine_Operatives : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Occupation_9_Elementary_Occupations( c : in out d.Criteria; Occupation_9_Elementary_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Income_Support_People_Claiming_Benefit( c : in out d.Criteria; Income_Support_People_Claiming_Benefit : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Income_Support_Average_Weekly_Payment( c : in out d.Criteria; Income_Support_Average_Weekly_Payment : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Jsa_Total( c : in out d.Criteria; Jsa_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Pension_Credits_Number_Of_Claimants( c : in out d.Criteria; Pension_Credits_Number_Of_Claimants : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Pension_Credits_Number_Of_Beneficiaries( c : in out d.Criteria; Pension_Credits_Number_Of_Beneficiaries : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Pension_Credits_Average_Weekly_Payment( c : in out d.Criteria; Pension_Credits_Average_Weekly_Payment : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Out_Of_Work_Families( c : in out d.Criteria; Out_Of_Work_Families : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Out_Of_Work_Children( c : in out d.Criteria; Out_Of_Work_Children : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Wtc_And_Ctc_Families( c : in out d.Criteria; Wtc_And_Ctc_Families : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Wtc_And_Ctc_Children( c : in out d.Criteria; Wtc_And_Ctc_Children : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ctc_Only_Families( c : in out d.Criteria; Ctc_Only_Families : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ctc_Only_Children( c : in out d.Criteria; Ctc_Only_Children : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Childcare_Element( c : in out d.Criteria; Childcare_Element : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Credits_No_Children( c : in out d.Criteria; Credits_No_Children : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Credits_Total_Families( c : in out d.Criteria; Credits_Total_Families : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Code_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Frs_Region_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hb_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hb_Social_Rented_Sector_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hb_Private_Rented_Sector_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hb_Passported_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hb_Non_Passported_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ct_All_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ct_Passported_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ct_Non_Passported_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Genders_All_Usual_Residents_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Genders_Males_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Genders_Females_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Genders_Lives_In_A_Household_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Genders_Lives_In_A_Communal_Establishment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Genders_Schoolchild_Or_Student_Non_Term_Time_Address_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_All_Categories_Age_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_Under_1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_21_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_22_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_23_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_24_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_25_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_26_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_27_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_28_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_29_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_30_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_31_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_32_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_33_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_34_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_35_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_36_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_37_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_38_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_39_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_40_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_41_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_42_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_43_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_44_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_45_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_46_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_47_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_48_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_49_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_50_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_51_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_52_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_53_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_54_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_55_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_56_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_57_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_58_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_59_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_60_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_61_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_62_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_63_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_64_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_65_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_66_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_67_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_68_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_69_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_70_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_71_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_72_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_73_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_74_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_75_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_76_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_77_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_78_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_79_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_81_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_82_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_83_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_84_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_85_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_86_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_87_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_88_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_89_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_90_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_91_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_92_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_93_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_94_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_95_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_96_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_97_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_98_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_99_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Age_Ranges_Age_100_And_Over_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_All_Categories_Accommodation_Type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Detached_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Terraced_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Flat_Maisonette_Or_Apartment_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Flat_Etc_In_Commercial_Building_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Unshared_Caravan_Etc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Accom_Shared_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_All_Categories_Economic_Activity_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Active_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Active_Employee_Part_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Active_Employee_Full_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Active_Self_Employed_With_Employees_Part_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Active_Self_Employed_With_Employees_Full_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Active_Self_Employed_Without_Employees_Part_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Active_Self_Employed_Without_Employees_Full_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Active_Unemployed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Active_Full_Time_Student_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Inactive_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Inactive_Retired_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Inactive_Student_Including_Full_Time_Students_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Inactive_Looking_After_Home_Or_Family_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Inactive_Long_Term_Sick_Or_Disabled_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ec_Act_Inactive_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_All_Categories_Ethnic_Group_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_White_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_White_Irish_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_White_Gypsy_Or_Irish_Traveller_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_White_Other_White_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Mixed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Asian_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Asian_Asian_British_Indian_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Asian_Asian_British_Pakistani_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Asian_Asian_British_Bangladeshi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Asian_Asian_British_Chinese_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Asian_Asian_British_Other_Asian_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Black_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_African_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_Caribbean_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_Other_Black_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Other_Ethnic_Group_Arab_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_All_Categories_Household_Composition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Person_Household_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Person_Household_Aged_65_And_Over_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Person_Household_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_All_Aged_65_And_Over_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_No_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Lone_Parent_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_Other_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_Other_With_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_Other_With_Two_Or_More_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_Other_All_Full_Time_Students_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_Other_All_Aged_65_And_Over_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Hcomp_Other_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_All_Categories_Number_Of_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_1_Room_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_2_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_3_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_4_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_5_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_6_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_7_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_8_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Number_Of_Rooms_9_Or_More_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Residence_All_Categories_Residence_Type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Residence_Lives_In_A_Household_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Residence_Lives_In_A_Communal_Establishment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Residence_Communal_Establishments_With_Persons_Sleeping_Rough_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_All_Categories_Tenure_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Owned_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Owned_Owned_Outright_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Owned_Owned_With_A_Mortgage_Or_Loan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Shared_Ownership_Part_Owned_And_Part_Rented_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Social_Rented_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Social_Rented_Rented_From_Council_Local_Authority_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Social_Rented_Other_Social_Rented_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Private_Rented_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Private_Rented_Employer_Of_A_Household_Member_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Private_Rented_Relative_Or_Friend_Of_Household_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Private_Rented_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Tenure_Living_Rent_Free_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_All_Categories_Occupation_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_1_Managers_Directors_And_Senior_Officials_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_2_Professional_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_3_Associate_Professional_And_Technical_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_4_Administrative_And_Secretarial_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_5_Skilled_Trades_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_6_Caring_Leisure_And_Other_Service_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_7_Sales_And_Customer_Service_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_8_Process_Plant_And_Machine_Operatives_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Occupation_9_Elementary_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Income_Support_People_Claiming_Benefit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Income_Support_Average_Weekly_Payment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Jsa_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Pension_Credits_Number_Of_Claimants_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Pension_Credits_Number_Of_Beneficiaries_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Pension_Credits_Average_Weekly_Payment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Out_Of_Work_Families_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Out_Of_Work_Children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Wtc_And_Ctc_Families_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Wtc_And_Ctc_Children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ctc_Only_Families_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ctc_Only_Children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Childcare_Element_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Credits_No_Children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Credits_Total_Families_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Target_Candidates_Type_IO;
