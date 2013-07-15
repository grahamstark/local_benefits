--
-- Created by ada_generator.py on 2013-06-12 18:50:26.516556
-- 


with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 

with GNATColl.Traces;

with AUnit.Assertions;             
with AUnit.Test_Cases; 

with Base_Types;
with Environment;

with DB_Commons;
with La_Data_Data;

with Connection_Pool;

with Target_Candidates_Type_IO;
with Las_Type_IO;
with Country_Type_IO;
with Government_Region_Type_IO;
with Las_In_Region_Type_IO;
with Regions_In_Country_Type_IO;


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body La_Data_Test is

   RECORDS_TO_ADD     : constant integer := 100;
   RECORDS_TO_DELETE  : constant integer := 50;
   RECORDS_TO_ALTER   : constant integer := 50;
   
   package d renames DB_Commons;
   
   use Base_Types;
   use ada.strings.Unbounded;
   use La_Data_Data;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "LA_DATA_TEST" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   
      -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use AUnit.Test_Cases.Registration;
   
   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Calendar;
   
   
--
-- test creating and deleting records  
--
--
   procedure Target_Candidates_Type_Create_Test(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      --
      -- local print iteration routine
      --
      procedure Print( pos : Target_Candidates_Type_List.Cursor ) is 
      target_candidates_test_item : La_Data_Data.Target_Candidates_Type;
      begin
         target_candidates_test_item := Target_Candidates_Type_List.element( pos );
         Log( To_String( target_candidates_test_item ));
      end print;

   
      target_candidates_test_item : La_Data_Data.Target_Candidates_Type;
      target_candidates_test_list : La_Data_Data.Target_Candidates_Type_List.Vector;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Target_Candidates_Type_Create_Test" );
      
      Log( "Clearing out the table" );
      Target_Candidates_Type_IO.Delete( criteria );
      
      Log( "Target_Candidates_Type_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         target_candidates_test_item.Id := Target_Candidates_Type_IO.Next_Free_Id;
         target_candidates_test_item.Code := To_Unbounded_String( "k_" & i'img );
         target_candidates_test_item.Edition := Target_Candidates_Type_IO.Next_Free_Edition;
         -- missingtarget_candidates_test_item declaration ;
         target_candidates_test_item.Hb_Total := 1010100.012;
         target_candidates_test_item.Hb_Social_Rented_Sector := 1010100.012;
         target_candidates_test_item.Hb_Private_Rented_Sector := 1010100.012;
         target_candidates_test_item.Hb_Passported := 1010100.012;
         target_candidates_test_item.Hb_Non_Passported := 1010100.012;
         target_candidates_test_item.Ct_All := 1010100.012;
         target_candidates_test_item.Ct_Passported := 1010100.012;
         target_candidates_test_item.Ct_Non_Passported := 1010100.012;
         target_candidates_test_item.Genders_All_Usual_Residents := 1010100.012;
         target_candidates_test_item.Genders_Males := 1010100.012;
         target_candidates_test_item.Genders_Females := 1010100.012;
         target_candidates_test_item.Genders_Lives_In_A_Household := 1010100.012;
         target_candidates_test_item.Genders_Lives_In_A_Communal_Establishment := 1010100.012;
         target_candidates_test_item.Genders_Schoolchild_Or_Student_Non_Term_Time_Address := 1010100.012;
         target_candidates_test_item.Age_Ranges_All_Categories_Age := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_Under_1 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_1 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_2 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_3 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_4 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_5 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_6 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_7 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_8 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_9 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_10 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_11 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_12 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_13 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_14 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_15 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_16 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_17 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_18 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_19 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_20 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_21 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_22 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_23 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_24 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_25 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_26 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_27 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_28 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_29 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_30 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_31 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_32 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_33 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_34 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_35 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_36 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_37 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_38 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_39 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_40 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_41 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_42 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_43 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_44 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_45 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_46 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_47 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_48 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_49 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_50 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_51 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_52 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_53 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_54 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_55 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_56 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_57 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_58 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_59 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_60 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_61 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_62 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_63 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_64 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_65 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_66 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_67 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_68 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_69 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_70 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_71 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_72 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_73 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_74 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_75 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_76 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_77 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_78 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_79 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_80 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_81 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_82 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_83 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_84 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_85 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_86 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_87 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_88 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_89 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_90 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_91 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_92 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_93 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_94 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_95 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_96 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_97 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_98 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_99 := 1010100.012;
         target_candidates_test_item.Age_Ranges_Age_100_And_Over := 1010100.012;
         target_candidates_test_item.Accom_All_Categories_Accommodation_Type := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Total := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Whole_House_Or_Bungalow_Total := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Whole_House_Or_Bungalow_Detached := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Whole_House_Or_Bungalow_Terraced := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Flat_Maisonette_Or_Apartment_Total := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Flat_Etc_In_Commercial_Building := 1010100.012;
         target_candidates_test_item.Accom_Unshared_Caravan_Etc := 1010100.012;
         target_candidates_test_item.Accom_Shared := 1010100.012;
         target_candidates_test_item.Ec_Act_All_Categories_Economic_Activity := 1010100.012;
         target_candidates_test_item.Ec_Act_Active_Total := 1010100.012;
         target_candidates_test_item.Ec_Act_Active_Employee_Part_Time := 1010100.012;
         target_candidates_test_item.Ec_Act_Active_Employee_Full_Time := 1010100.012;
         target_candidates_test_item.Ec_Act_Active_Self_Employed_With_Employees_Part_Time := 1010100.012;
         target_candidates_test_item.Ec_Act_Active_Self_Employed_With_Employees_Full_Time := 1010100.012;
         target_candidates_test_item.Ec_Act_Active_Self_Employed_Without_Employees_Part_Time := 1010100.012;
         target_candidates_test_item.Ec_Act_Active_Self_Employed_Without_Employees_Full_Time := 1010100.012;
         target_candidates_test_item.Ec_Act_Active_Unemployed := 1010100.012;
         target_candidates_test_item.Ec_Act_Active_Full_Time_Student := 1010100.012;
         target_candidates_test_item.Ec_Act_Inactive_Total := 1010100.012;
         target_candidates_test_item.Ec_Act_Inactive_Retired := 1010100.012;
         target_candidates_test_item.Ec_Act_Inactive_Student_Including_Full_Time_Students := 1010100.012;
         target_candidates_test_item.Ec_Act_Inactive_Looking_After_Home_Or_Family := 1010100.012;
         target_candidates_test_item.Ec_Act_Inactive_Long_Term_Sick_Or_Disabled := 1010100.012;
         target_candidates_test_item.Ec_Act_Inactive_Other := 1010100.012;
         target_candidates_test_item.Ethgrp_All_Categories_Ethnic_Group := 1010100.012;
         target_candidates_test_item.Ethgrp_White := 1010100.012;
         target_candidates_test_item.Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British := 1010100.012;
         target_candidates_test_item.Ethgrp_White_Irish := 1010100.012;
         target_candidates_test_item.Ethgrp_White_Gypsy_Or_Irish_Traveller := 1010100.012;
         target_candidates_test_item.Ethgrp_White_Other_White := 1010100.012;
         target_candidates_test_item.Ethgrp_Mixed := 1010100.012;
         target_candidates_test_item.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean := 1010100.012;
         target_candidates_test_item.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African := 1010100.012;
         target_candidates_test_item.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian := 1010100.012;
         target_candidates_test_item.Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed := 1010100.012;
         target_candidates_test_item.Ethgrp_Asian := 1010100.012;
         target_candidates_test_item.Ethgrp_Asian_Asian_British_Indian := 1010100.012;
         target_candidates_test_item.Ethgrp_Asian_Asian_British_Pakistani := 1010100.012;
         target_candidates_test_item.Ethgrp_Asian_Asian_British_Bangladeshi := 1010100.012;
         target_candidates_test_item.Ethgrp_Asian_Asian_British_Chinese := 1010100.012;
         target_candidates_test_item.Ethgrp_Asian_Asian_British_Other_Asian := 1010100.012;
         target_candidates_test_item.Ethgrp_Black := 1010100.012;
         target_candidates_test_item.Ethgrp_Black_African_Caribbean_Black_British_African := 1010100.012;
         target_candidates_test_item.Ethgrp_Black_African_Caribbean_Black_British_Caribbean := 1010100.012;
         target_candidates_test_item.Ethgrp_Black_African_Caribbean_Black_British_Other_Black := 1010100.012;
         target_candidates_test_item.Ethgrp_Other := 1010100.012;
         target_candidates_test_item.Ethgrp_Other_Ethnic_Group_Arab := 1010100.012;
         target_candidates_test_item.Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group := 1010100.012;
         target_candidates_test_item.Hcomp_All_Categories_Household_Composition := 1010100.012;
         target_candidates_test_item.Hcomp_One_Person_Household_Total := 1010100.012;
         target_candidates_test_item.Hcomp_One_Person_Household_Aged_65_And_Over := 1010100.012;
         target_candidates_test_item.Hcomp_One_Person_Household_Other := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Total := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_All_Aged_65_And_Over := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Married_Cple_Total := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Married_Cple_No_Kids := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Married_Cple_One_Dep_Child := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids := 1010100.012;
         target_candidates_test_item.Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child := 1010100.012;
         target_candidates_test_item.Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Cohabiting_Cple_Total := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Lone_Parent_Total := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids := 1010100.012;
         target_candidates_test_item.Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep := 1010100.012;
         target_candidates_test_item.Hcomp_Other_Total := 1010100.012;
         target_candidates_test_item.Hcomp_Other_With_One_Dep_Child := 1010100.012;
         target_candidates_test_item.Hcomp_Other_With_Two_Or_More_Dep_Kids := 1010100.012;
         target_candidates_test_item.Hcomp_Other_All_Full_Time_Students := 1010100.012;
         target_candidates_test_item.Hcomp_Other_All_Aged_65_And_Over := 1010100.012;
         target_candidates_test_item.Hcomp_Other_Other := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_All_Categories_Number_Of_Rooms := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_1_Room := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_2_Rooms := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_3_Rooms := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_4_Rooms := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_5_Rooms := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_6_Rooms := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_7_Rooms := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_8_Rooms := 1010100.012;
         target_candidates_test_item.Number_Of_Rooms_9_Or_More_Rooms := 1010100.012;
         target_candidates_test_item.Residence_All_Categories_Residence_Type := 1010100.012;
         target_candidates_test_item.Residence_Lives_In_A_Household := 1010100.012;
         target_candidates_test_item.Residence_Lives_In_A_Communal_Establishment := 1010100.012;
         target_candidates_test_item.Residence_Communal_Establishments_With_Persons_Sleeping_Rough := 1010100.012;
         target_candidates_test_item.Tenure_All_Categories_Tenure := 1010100.012;
         target_candidates_test_item.Tenure_Owned_Total := 1010100.012;
         target_candidates_test_item.Tenure_Owned_Owned_Outright := 1010100.012;
         target_candidates_test_item.Tenure_Owned_Owned_With_A_Mortgage_Or_Loan := 1010100.012;
         target_candidates_test_item.Tenure_Shared_Ownership_Part_Owned_And_Part_Rented := 1010100.012;
         target_candidates_test_item.Tenure_Social_Rented_Total := 1010100.012;
         target_candidates_test_item.Tenure_Social_Rented_Rented_From_Council_Local_Authority := 1010100.012;
         target_candidates_test_item.Tenure_Social_Rented_Other_Social_Rented := 1010100.012;
         target_candidates_test_item.Tenure_Private_Rented_Total := 1010100.012;
         target_candidates_test_item.Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency := 1010100.012;
         target_candidates_test_item.Tenure_Private_Rented_Employer_Of_A_Household_Member := 1010100.012;
         target_candidates_test_item.Tenure_Private_Rented_Relative_Or_Friend_Of_Household := 1010100.012;
         target_candidates_test_item.Tenure_Private_Rented_Other := 1010100.012;
         target_candidates_test_item.Tenure_Living_Rent_Free := 1010100.012;
         target_candidates_test_item.Occupation_All_Categories_Occupation := 1010100.012;
         target_candidates_test_item.Occupation_1_Managers_Directors_And_Senior_Officials := 1010100.012;
         target_candidates_test_item.Occupation_2_Professional_Occupations := 1010100.012;
         target_candidates_test_item.Occupation_3_Associate_Professional_And_Technical_Occupations := 1010100.012;
         target_candidates_test_item.Occupation_4_Administrative_And_Secretarial_Occupations := 1010100.012;
         target_candidates_test_item.Occupation_5_Skilled_Trades_Occupations := 1010100.012;
         target_candidates_test_item.Occupation_6_Caring_Leisure_And_Other_Service_Occupations := 1010100.012;
         target_candidates_test_item.Occupation_7_Sales_And_Customer_Service_Occupations := 1010100.012;
         target_candidates_test_item.Occupation_8_Process_Plant_And_Machine_Operatives := 1010100.012;
         target_candidates_test_item.Occupation_9_Elementary_Occupations := 1010100.012;
         target_candidates_test_item.Income_Support_People_Claiming_Benefit := 1010100.012;
         target_candidates_test_item.Income_Support_Average_Weekly_Payment := 1010100.012;
         target_candidates_test_item.Jsa_Total := 1010100.012;
         target_candidates_test_item.Pension_Credits_Number_Of_Claimants := 1010100.012;
         target_candidates_test_item.Pension_Credits_Number_Of_Beneficiaries := 1010100.012;
         target_candidates_test_item.Pension_Credits_Average_Weekly_Payment := 1010100.012;
         target_candidates_test_item.Out_Of_Work_Families := 1010100.012;
         target_candidates_test_item.Out_Of_Work_Children := 1010100.012;
         target_candidates_test_item.Wtc_And_Ctc_Families := 1010100.012;
         target_candidates_test_item.Wtc_And_Ctc_Children := 1010100.012;
         target_candidates_test_item.Ctc_Only_Families := 1010100.012;
         target_candidates_test_item.Ctc_Only_Children := 1010100.012;
         target_candidates_test_item.Childcare_Element := 1010100.012;
         target_candidates_test_item.Credits_No_Children := 1010100.012;
         target_candidates_test_item.Credits_Total_Families := 1010100.012;
         Target_Candidates_Type_IO.Save( target_candidates_test_item, False );         
      end loop;
      
      target_candidates_test_list := Target_Candidates_Type_IO.Retrieve( criteria );
      
      Log( "Target_Candidates_Type_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         target_candidates_test_item := Target_Candidates_Type_List.element( target_candidates_test_list, i );
         Target_Candidates_Type_IO.Save( target_candidates_test_item );         
      end loop;
      
      Log( "Target_Candidates_Type_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         target_candidates_test_item := Target_Candidates_Type_List.element( target_candidates_test_list, i );
         Target_Candidates_Type_IO.Delete( target_candidates_test_item );         
      end loop;
      
      Log( "Target_Candidates_Type_Create_Test: retrieve all records" );
      Target_Candidates_Type_List.iterate( target_candidates_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Target_Candidates_Type_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Target_Candidates_Type_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Target_Candidates_Type_Create_Test : exception thrown " & Exception_Information(Error) );
   end Target_Candidates_Type_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Las_Type_Create_Test(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      --
      -- local print iteration routine
      --
      procedure Print( pos : Las_Type_List.Cursor ) is 
      las_test_item : La_Data_Data.Las_Type;
      begin
         las_test_item := Las_Type_List.element( pos );
         Log( To_String( las_test_item ));
      end print;

   
      las_test_item : La_Data_Data.Las_Type;
      las_test_list : La_Data_Data.Las_Type_List.Vector;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Las_Type_Create_Test" );
      
      Log( "Clearing out the table" );
      Las_Type_IO.Delete( criteria );
      
      Log( "Las_Type_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         las_test_item.Code := To_Unbounded_String( "k_" & i'img );
         las_test_item.Name := To_Unbounded_String("dat forName");
         Las_Type_IO.Save( las_test_item, False );         
      end loop;
      
      las_test_list := Las_Type_IO.Retrieve( criteria );
      
      Log( "Las_Type_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         las_test_item := Las_Type_List.element( las_test_list, i );
         las_test_item.Name := To_Unbounded_String("Altered::dat forName");
         Las_Type_IO.Save( las_test_item );         
      end loop;
      
      Log( "Las_Type_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         las_test_item := Las_Type_List.element( las_test_list, i );
         Las_Type_IO.Delete( las_test_item );         
      end loop;
      
      Log( "Las_Type_Create_Test: retrieve all records" );
      Las_Type_List.iterate( las_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Las_Type_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Las_Type_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Las_Type_Create_Test : exception thrown " & Exception_Information(Error) );
   end Las_Type_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Country_Type_Create_Test(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      --
      -- local print iteration routine
      --
      procedure Print( pos : Country_Type_List.Cursor ) is 
      country_test_item : La_Data_Data.Country_Type;
      begin
         country_test_item := Country_Type_List.element( pos );
         Log( To_String( country_test_item ));
      end print;

   
      country_test_item : La_Data_Data.Country_Type;
      country_test_list : La_Data_Data.Country_Type_List.Vector;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Country_Type_Create_Test" );
      
      Log( "Clearing out the table" );
      Country_Type_IO.Delete( criteria );
      
      Log( "Country_Type_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         country_test_item.Name := To_Unbounded_String( "k_" & i'img );
         Country_Type_IO.Save( country_test_item, False );         
      end loop;
      
      country_test_list := Country_Type_IO.Retrieve( criteria );
      
      Log( "Country_Type_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         country_test_item := Country_Type_List.element( country_test_list, i );
         Country_Type_IO.Save( country_test_item );         
      end loop;
      
      Log( "Country_Type_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         country_test_item := Country_Type_List.element( country_test_list, i );
         Country_Type_IO.Delete( country_test_item );         
      end loop;
      
      Log( "Country_Type_Create_Test: retrieve all records" );
      Country_Type_List.iterate( country_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Country_Type_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Country_Type_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Country_Type_Create_Test : exception thrown " & Exception_Information(Error) );
   end Country_Type_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Government_Region_Type_Create_Test(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      --
      -- local print iteration routine
      --
      procedure Print( pos : Government_Region_Type_List.Cursor ) is 
      government_region_test_item : La_Data_Data.Government_Region_Type;
      begin
         government_region_test_item := Government_Region_Type_List.element( pos );
         Log( To_String( government_region_test_item ));
      end print;

   
      government_region_test_item : La_Data_Data.Government_Region_Type;
      government_region_test_list : La_Data_Data.Government_Region_Type_List.Vector;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Government_Region_Type_Create_Test" );
      
      Log( "Clearing out the table" );
      Government_Region_Type_IO.Delete( criteria );
      
      Log( "Government_Region_Type_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         government_region_test_item.Frs_Region_Code := Government_Region_Type_IO.Next_Free_Frs_Region_Code;
         government_region_test_item.Name := To_Unbounded_String("dat forName");
         Government_Region_Type_IO.Save( government_region_test_item, False );         
      end loop;
      
      government_region_test_list := Government_Region_Type_IO.Retrieve( criteria );
      
      Log( "Government_Region_Type_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         government_region_test_item := Government_Region_Type_List.element( government_region_test_list, i );
         government_region_test_item.Name := To_Unbounded_String("Altered::dat forName");
         Government_Region_Type_IO.Save( government_region_test_item );         
      end loop;
      
      Log( "Government_Region_Type_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         government_region_test_item := Government_Region_Type_List.element( government_region_test_list, i );
         Government_Region_Type_IO.Delete( government_region_test_item );         
      end loop;
      
      Log( "Government_Region_Type_Create_Test: retrieve all records" );
      Government_Region_Type_List.iterate( government_region_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Government_Region_Type_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Government_Region_Type_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Government_Region_Type_Create_Test : exception thrown " & Exception_Information(Error) );
   end Government_Region_Type_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Las_In_Region_Type_Create_Test(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      --
      -- local print iteration routine
      --
      procedure Print( pos : Las_In_Region_Type_List.Cursor ) is 
      las_in_region_test_item : La_Data_Data.Las_In_Region_Type;
      begin
         las_in_region_test_item := Las_In_Region_Type_List.element( pos );
         Log( To_String( las_in_region_test_item ));
      end print;

   
      las_in_region_test_item : La_Data_Data.Las_In_Region_Type;
      las_in_region_test_list : La_Data_Data.Las_In_Region_Type_List.Vector;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Las_In_Region_Type_Create_Test" );
      
      Log( "Clearing out the table" );
      Las_In_Region_Type_IO.Delete( criteria );
      
      Log( "Las_In_Region_Type_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         las_in_region_test_item.Lacode := To_Unbounded_String( "k_" & i'img );
         las_in_region_test_item.Frs_Region_Code := Las_In_Region_Type_IO.Next_Free_Frs_Region_Code;
         las_in_region_test_item.Region := To_Unbounded_String("dat forRegion");
         Las_In_Region_Type_IO.Save( las_in_region_test_item, False );         
      end loop;
      
      las_in_region_test_list := Las_In_Region_Type_IO.Retrieve( criteria );
      
      Log( "Las_In_Region_Type_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         las_in_region_test_item := Las_In_Region_Type_List.element( las_in_region_test_list, i );
         las_in_region_test_item.Region := To_Unbounded_String("Altered::dat forRegion");
         Las_In_Region_Type_IO.Save( las_in_region_test_item );         
      end loop;
      
      Log( "Las_In_Region_Type_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         las_in_region_test_item := Las_In_Region_Type_List.element( las_in_region_test_list, i );
         Las_In_Region_Type_IO.Delete( las_in_region_test_item );         
      end loop;
      
      Log( "Las_In_Region_Type_Create_Test: retrieve all records" );
      Las_In_Region_Type_List.iterate( las_in_region_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Las_In_Region_Type_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Las_In_Region_Type_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Las_In_Region_Type_Create_Test : exception thrown " & Exception_Information(Error) );
   end Las_In_Region_Type_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Regions_In_Country_Type_Create_Test(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
      --
      -- local print iteration routine
      --
      procedure Print( pos : Regions_In_Country_Type_List.Cursor ) is 
      regions_in_country_test_item : La_Data_Data.Regions_In_Country_Type;
      begin
         regions_in_country_test_item := Regions_In_Country_Type_List.element( pos );
         Log( To_String( regions_in_country_test_item ));
      end print;

   
      regions_in_country_test_item : La_Data_Data.Regions_In_Country_Type;
      regions_in_country_test_list : La_Data_Data.Regions_In_Country_Type_List.Vector;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Regions_In_Country_Type_Create_Test" );
      
      Log( "Clearing out the table" );
      Regions_In_Country_Type_IO.Delete( criteria );
      
      Log( "Regions_In_Country_Type_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         regions_in_country_test_item.Country_Name := To_Unbounded_String( "k_" & i'img );
         regions_in_country_test_item.Frs_Region_Code := Regions_In_Country_Type_IO.Next_Free_Frs_Region_Code;
         regions_in_country_test_item.Region_Name := To_Unbounded_String("dat forRegion_Name");
         Regions_In_Country_Type_IO.Save( regions_in_country_test_item, False );         
      end loop;
      
      regions_in_country_test_list := Regions_In_Country_Type_IO.Retrieve( criteria );
      
      Log( "Regions_In_Country_Type_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         regions_in_country_test_item := Regions_In_Country_Type_List.element( regions_in_country_test_list, i );
         regions_in_country_test_item.Region_Name := To_Unbounded_String("Altered::dat forRegion_Name");
         Regions_In_Country_Type_IO.Save( regions_in_country_test_item );         
      end loop;
      
      Log( "Regions_In_Country_Type_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         regions_in_country_test_item := Regions_In_Country_Type_List.element( regions_in_country_test_list, i );
         Regions_In_Country_Type_IO.Delete( regions_in_country_test_item );         
      end loop;
      
      Log( "Regions_In_Country_Type_Create_Test: retrieve all records" );
      Regions_In_Country_Type_List.iterate( regions_in_country_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Regions_In_Country_Type_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Regions_In_Country_Type_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Regions_In_Country_Type_Create_Test : exception thrown " & Exception_Information(Error) );
   end Regions_In_Country_Type_Create_Test;

   
   
   
   
   
   
   procedure Register_Tests (T : in out Test_Case) is
   begin
      --
      -- Tests of record creation/deletion
      --
      Register_Routine (T, Target_Candidates_Type_Create_Test'Access, "Test of Creation and deletion of Target_Candidates_Type" );
      Register_Routine (T, Las_Type_Create_Test'Access, "Test of Creation and deletion of Las_Type" );
      Register_Routine (T, Country_Type_Create_Test'Access, "Test of Creation and deletion of Country_Type" );
      Register_Routine (T, Government_Region_Type_Create_Test'Access, "Test of Creation and deletion of Government_Region_Type" );
      Register_Routine (T, Las_In_Region_Type_Create_Test'Access, "Test of Creation and deletion of Las_In_Region_Type" );
      Register_Routine (T, Regions_In_Country_Type_Create_Test'Access, "Test of Creation and deletion of Regions_In_Country_Type" );
      --
      -- Tests of foreign key relationships
      --
      --  not implemented yet Register_Routine (T, Las_Type_Child_Retrieve_Test'Access, "Test of Finding Children of Las_Type" );
      --  not implemented yet Register_Routine (T, Country_Type_Child_Retrieve_Test'Access, "Test of Finding Children of Country_Type" );
      --  not implemented yet Register_Routine (T, Government_Region_Type_Child_Retrieve_Test'Access, "Test of Finding Children of Government_Region_Type" );
   end Register_Tests;
   
   --  Register routines to be run
   
   
   function Name ( t : Test_Case ) return Message_String is
   begin
      return Format( "La_Data_Test Test Suite" );
   end Name;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===
   
   --  Preparation performed before each routine:
   procedure Set_Up( t : in out Test_Case ) is
   begin
       Connection_Pool.Initialise(
              Environment.Get_Server_Name,
              Environment.Get_Database_Name,
              Environment.Get_Username,
              Environment.Get_Password,
              10 );
      GNATColl.Traces.Parse_Config_File( "./etc/logging_config_file.txt" );
   end Set_Up;
   
   --  Preparation performed after each routine:
   procedure Shut_Down( t : in out Test_Case ) is
   begin
      Connection_Pool.Shutdown;
   end Shut_Down;
   
   
begin
   null;
end La_Data_Test;
