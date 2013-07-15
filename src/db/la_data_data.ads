--
-- Created by ada_generator.py on 2013-06-12 18:50:25.957840
-- 
with Ada.Containers.Vectors;
--
-- FIXME: may not be needed
--
with Ada.Calendar;

with Base_Types; use Base_Types;

with Ada.Strings.Unbounded;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package La_Data_Data is

   use Ada.Strings.Unbounded;
   

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===


   --
   -- record modelling regions_in_country : 
   --
   type Regions_In_Country_Type is record
         Country_Name : Unbounded_String := MISSING_W_KEY;
         Region_Name : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Frs_Region_Code : Integer := MISSING_I_KEY;
   end record;
   --
   -- container for regions_in_country : 
   --
   package Regions_In_Country_Type_List is new Ada.Containers.Vectors
      (Element_Type => Regions_In_Country_Type,
      Index_Type => Positive );
   --
   -- default value for regions_in_country : 
   --
   Null_Regions_In_Country_Type : constant Regions_In_Country_Type := (
         Country_Name => MISSING_W_KEY,
         Region_Name => Ada.Strings.Unbounded.Null_Unbounded_String,
         Frs_Region_Code => MISSING_I_KEY
   );
   --
   -- simple print routine for regions_in_country : 
   --
   function To_String( rec : Regions_In_Country_Type ) return String;

   --
   -- record modelling las_in_region : 
   --
   type Las_In_Region_Type is record
         Lacode : Unbounded_String := MISSING_W_KEY;
         Region : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Frs_Region_Code : Integer := MISSING_I_KEY;
   end record;
   --
   -- container for las_in_region : 
   --
   package Las_In_Region_Type_List is new Ada.Containers.Vectors
      (Element_Type => Las_In_Region_Type,
      Index_Type => Positive );
   --
   -- default value for las_in_region : 
   --
   Null_Las_In_Region_Type : constant Las_In_Region_Type := (
         Lacode => MISSING_W_KEY,
         Region => Ada.Strings.Unbounded.Null_Unbounded_String,
         Frs_Region_Code => MISSING_I_KEY
   );
   --
   -- simple print routine for las_in_region : 
   --
   function To_String( rec : Las_In_Region_Type ) return String;

   --
   -- record modelling government_region : 
   --
   type Government_Region_Type is record
         Name : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Frs_Region_Code : Integer := MISSING_I_KEY;
   end record;
   --
   -- container for government_region : 
   --
   package Government_Region_Type_List is new Ada.Containers.Vectors
      (Element_Type => Government_Region_Type,
      Index_Type => Positive );
   --
   -- default value for government_region : 
   --
   Null_Government_Region_Type : constant Government_Region_Type := (
         Name => Ada.Strings.Unbounded.Null_Unbounded_String,
         Frs_Region_Code => MISSING_I_KEY
   );
   --
   -- simple print routine for government_region : 
   --
   function To_String( rec : Government_Region_Type ) return String;

   --
   -- record modelling country : 
   --
   type Country_Type is record
         Name : Unbounded_String := MISSING_W_KEY;
   end record;
   --
   -- container for country : 
   --
   package Country_Type_List is new Ada.Containers.Vectors
      (Element_Type => Country_Type,
      Index_Type => Positive );
   --
   -- default value for country : 
   --
   Null_Country_Type : constant Country_Type := (
         Name => MISSING_W_KEY
   );
   --
   -- simple print routine for country : 
   --
   function To_String( rec : Country_Type ) return String;

   --
   -- record modelling las : 
   --
   type Las_Type is record
         Code : Unbounded_String := MISSING_W_KEY;
         Name : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
   end record;
   --
   -- container for las : 
   --
   package Las_Type_List is new Ada.Containers.Vectors
      (Element_Type => Las_Type,
      Index_Type => Positive );
   --
   -- default value for las : 
   --
   Null_Las_Type : constant Las_Type := (
         Code => MISSING_W_KEY,
         Name => Ada.Strings.Unbounded.Null_Unbounded_String
   );
   --
   -- simple print routine for las : 
   --
   function To_String( rec : Las_Type ) return String;

   --
   -- record modelling target_candidates : One row for each Council/FRS household
   --
   type Target_Candidates_Type is record
         Id : Integer := MISSING_I_KEY;
         Code : Unbounded_String := MISSING_W_KEY;
         Edition : Integer := MISSING_I_KEY;
         Frs_Region : Integer := 0;
         Hb_Total : Real := 0.0;
         Hb_Social_Rented_Sector : Real := 0.0;
         Hb_Private_Rented_Sector : Real := 0.0;
         Hb_Passported : Real := 0.0;
         Hb_Non_Passported : Real := 0.0;
         Ct_All : Real := 0.0;
         Ct_Passported : Real := 0.0;
         Ct_Non_Passported : Real := 0.0;
         Genders_All_Usual_Residents : Real := 0.0;
         Genders_Males : Real := 0.0;
         Genders_Females : Real := 0.0;
         Genders_Lives_In_A_Household : Real := 0.0;
         Genders_Lives_In_A_Communal_Establishment : Real := 0.0;
         Genders_Schoolchild_Or_Student_Non_Term_Time_Address : Real := 0.0;
         Age_Ranges_All_Categories_Age : Real := 0.0;
         Age_Ranges_Age_Under_1 : Real := 0.0;
         Age_Ranges_Age_1 : Real := 0.0;
         Age_Ranges_Age_2 : Real := 0.0;
         Age_Ranges_Age_3 : Real := 0.0;
         Age_Ranges_Age_4 : Real := 0.0;
         Age_Ranges_Age_5 : Real := 0.0;
         Age_Ranges_Age_6 : Real := 0.0;
         Age_Ranges_Age_7 : Real := 0.0;
         Age_Ranges_Age_8 : Real := 0.0;
         Age_Ranges_Age_9 : Real := 0.0;
         Age_Ranges_Age_10 : Real := 0.0;
         Age_Ranges_Age_11 : Real := 0.0;
         Age_Ranges_Age_12 : Real := 0.0;
         Age_Ranges_Age_13 : Real := 0.0;
         Age_Ranges_Age_14 : Real := 0.0;
         Age_Ranges_Age_15 : Real := 0.0;
         Age_Ranges_Age_16 : Real := 0.0;
         Age_Ranges_Age_17 : Real := 0.0;
         Age_Ranges_Age_18 : Real := 0.0;
         Age_Ranges_Age_19 : Real := 0.0;
         Age_Ranges_Age_20 : Real := 0.0;
         Age_Ranges_Age_21 : Real := 0.0;
         Age_Ranges_Age_22 : Real := 0.0;
         Age_Ranges_Age_23 : Real := 0.0;
         Age_Ranges_Age_24 : Real := 0.0;
         Age_Ranges_Age_25 : Real := 0.0;
         Age_Ranges_Age_26 : Real := 0.0;
         Age_Ranges_Age_27 : Real := 0.0;
         Age_Ranges_Age_28 : Real := 0.0;
         Age_Ranges_Age_29 : Real := 0.0;
         Age_Ranges_Age_30 : Real := 0.0;
         Age_Ranges_Age_31 : Real := 0.0;
         Age_Ranges_Age_32 : Real := 0.0;
         Age_Ranges_Age_33 : Real := 0.0;
         Age_Ranges_Age_34 : Real := 0.0;
         Age_Ranges_Age_35 : Real := 0.0;
         Age_Ranges_Age_36 : Real := 0.0;
         Age_Ranges_Age_37 : Real := 0.0;
         Age_Ranges_Age_38 : Real := 0.0;
         Age_Ranges_Age_39 : Real := 0.0;
         Age_Ranges_Age_40 : Real := 0.0;
         Age_Ranges_Age_41 : Real := 0.0;
         Age_Ranges_Age_42 : Real := 0.0;
         Age_Ranges_Age_43 : Real := 0.0;
         Age_Ranges_Age_44 : Real := 0.0;
         Age_Ranges_Age_45 : Real := 0.0;
         Age_Ranges_Age_46 : Real := 0.0;
         Age_Ranges_Age_47 : Real := 0.0;
         Age_Ranges_Age_48 : Real := 0.0;
         Age_Ranges_Age_49 : Real := 0.0;
         Age_Ranges_Age_50 : Real := 0.0;
         Age_Ranges_Age_51 : Real := 0.0;
         Age_Ranges_Age_52 : Real := 0.0;
         Age_Ranges_Age_53 : Real := 0.0;
         Age_Ranges_Age_54 : Real := 0.0;
         Age_Ranges_Age_55 : Real := 0.0;
         Age_Ranges_Age_56 : Real := 0.0;
         Age_Ranges_Age_57 : Real := 0.0;
         Age_Ranges_Age_58 : Real := 0.0;
         Age_Ranges_Age_59 : Real := 0.0;
         Age_Ranges_Age_60 : Real := 0.0;
         Age_Ranges_Age_61 : Real := 0.0;
         Age_Ranges_Age_62 : Real := 0.0;
         Age_Ranges_Age_63 : Real := 0.0;
         Age_Ranges_Age_64 : Real := 0.0;
         Age_Ranges_Age_65 : Real := 0.0;
         Age_Ranges_Age_66 : Real := 0.0;
         Age_Ranges_Age_67 : Real := 0.0;
         Age_Ranges_Age_68 : Real := 0.0;
         Age_Ranges_Age_69 : Real := 0.0;
         Age_Ranges_Age_70 : Real := 0.0;
         Age_Ranges_Age_71 : Real := 0.0;
         Age_Ranges_Age_72 : Real := 0.0;
         Age_Ranges_Age_73 : Real := 0.0;
         Age_Ranges_Age_74 : Real := 0.0;
         Age_Ranges_Age_75 : Real := 0.0;
         Age_Ranges_Age_76 : Real := 0.0;
         Age_Ranges_Age_77 : Real := 0.0;
         Age_Ranges_Age_78 : Real := 0.0;
         Age_Ranges_Age_79 : Real := 0.0;
         Age_Ranges_Age_80 : Real := 0.0;
         Age_Ranges_Age_81 : Real := 0.0;
         Age_Ranges_Age_82 : Real := 0.0;
         Age_Ranges_Age_83 : Real := 0.0;
         Age_Ranges_Age_84 : Real := 0.0;
         Age_Ranges_Age_85 : Real := 0.0;
         Age_Ranges_Age_86 : Real := 0.0;
         Age_Ranges_Age_87 : Real := 0.0;
         Age_Ranges_Age_88 : Real := 0.0;
         Age_Ranges_Age_89 : Real := 0.0;
         Age_Ranges_Age_90 : Real := 0.0;
         Age_Ranges_Age_91 : Real := 0.0;
         Age_Ranges_Age_92 : Real := 0.0;
         Age_Ranges_Age_93 : Real := 0.0;
         Age_Ranges_Age_94 : Real := 0.0;
         Age_Ranges_Age_95 : Real := 0.0;
         Age_Ranges_Age_96 : Real := 0.0;
         Age_Ranges_Age_97 : Real := 0.0;
         Age_Ranges_Age_98 : Real := 0.0;
         Age_Ranges_Age_99 : Real := 0.0;
         Age_Ranges_Age_100_And_Over : Real := 0.0;
         Accom_All_Categories_Accommodation_Type : Real := 0.0;
         Accom_Unshared_Total : Real := 0.0;
         Accom_Unshared_Whole_House_Or_Bungalow_Total : Real := 0.0;
         Accom_Unshared_Whole_House_Or_Bungalow_Detached : Real := 0.0;
         Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached : Real := 0.0;
         Accom_Unshared_Whole_House_Or_Bungalow_Terraced : Real := 0.0;
         Accom_Unshared_Flat_Maisonette_Or_Apartment_Total : Real := 0.0;
         Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement : Real := 0.0;
         Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House : Real := 0.0;
         Accom_Unshared_Flat_Etc_In_Commercial_Building : Real := 0.0;
         Accom_Unshared_Caravan_Etc : Real := 0.0;
         Accom_Shared : Real := 0.0;
         Ec_Act_All_Categories_Economic_Activity : Real := 0.0;
         Ec_Act_Active_Total : Real := 0.0;
         Ec_Act_Active_Employee_Part_Time : Real := 0.0;
         Ec_Act_Active_Employee_Full_Time : Real := 0.0;
         Ec_Act_Active_Self_Employed_With_Employees_Part_Time : Real := 0.0;
         Ec_Act_Active_Self_Employed_With_Employees_Full_Time : Real := 0.0;
         Ec_Act_Active_Self_Employed_Without_Employees_Part_Time : Real := 0.0;
         Ec_Act_Active_Self_Employed_Without_Employees_Full_Time : Real := 0.0;
         Ec_Act_Active_Unemployed : Real := 0.0;
         Ec_Act_Active_Full_Time_Student : Real := 0.0;
         Ec_Act_Inactive_Total : Real := 0.0;
         Ec_Act_Inactive_Retired : Real := 0.0;
         Ec_Act_Inactive_Student_Including_Full_Time_Students : Real := 0.0;
         Ec_Act_Inactive_Looking_After_Home_Or_Family : Real := 0.0;
         Ec_Act_Inactive_Long_Term_Sick_Or_Disabled : Real := 0.0;
         Ec_Act_Inactive_Other : Real := 0.0;
         Ethgrp_All_Categories_Ethnic_Group : Real := 0.0;
         Ethgrp_White : Real := 0.0;
         Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British : Real := 0.0;
         Ethgrp_White_Irish : Real := 0.0;
         Ethgrp_White_Gypsy_Or_Irish_Traveller : Real := 0.0;
         Ethgrp_White_Other_White : Real := 0.0;
         Ethgrp_Mixed : Real := 0.0;
         Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean : Real := 0.0;
         Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African : Real := 0.0;
         Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian : Real := 0.0;
         Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed : Real := 0.0;
         Ethgrp_Asian : Real := 0.0;
         Ethgrp_Asian_Asian_British_Indian : Real := 0.0;
         Ethgrp_Asian_Asian_British_Pakistani : Real := 0.0;
         Ethgrp_Asian_Asian_British_Bangladeshi : Real := 0.0;
         Ethgrp_Asian_Asian_British_Chinese : Real := 0.0;
         Ethgrp_Asian_Asian_British_Other_Asian : Real := 0.0;
         Ethgrp_Black : Real := 0.0;
         Ethgrp_Black_African_Caribbean_Black_British_African : Real := 0.0;
         Ethgrp_Black_African_Caribbean_Black_British_Caribbean : Real := 0.0;
         Ethgrp_Black_African_Caribbean_Black_British_Other_Black : Real := 0.0;
         Ethgrp_Other : Real := 0.0;
         Ethgrp_Other_Ethnic_Group_Arab : Real := 0.0;
         Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group : Real := 0.0;
         Hcomp_All_Categories_Household_Composition : Real := 0.0;
         Hcomp_One_Person_Household_Total : Real := 0.0;
         Hcomp_One_Person_Household_Aged_65_And_Over : Real := 0.0;
         Hcomp_One_Person_Household_Other : Real := 0.0;
         Hcomp_One_Family_Only_Total : Real := 0.0;
         Hcomp_One_Family_Only_All_Aged_65_And_Over : Real := 0.0;
         Hcomp_One_Family_Only_Married_Cple_Total : Real := 0.0;
         Hcomp_One_Family_Only_Married_Cple_No_Kids : Real := 0.0;
         Hcomp_One_Family_Only_Married_Cple_One_Dep_Child : Real := 0.0;
         Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids : Real := 0.0;
         Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep : Real := 0.0;
         Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total : Real := 0.0;
         Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids : Real := 0.0;
         Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child : Real := 0.0;
         Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids : Real := 0.0;
         Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep : Real := 0.0;
         Hcomp_One_Family_Only_Cohabiting_Cple_Total : Real := 0.0;
         Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids : Real := 0.0;
         Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child : Real := 0.0;
         Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids : Real := 0.0;
         Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep : Real := 0.0;
         Hcomp_One_Family_Only_Lone_Parent_Total : Real := 0.0;
         Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child : Real := 0.0;
         Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids : Real := 0.0;
         Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep : Real := 0.0;
         Hcomp_Other_Total : Real := 0.0;
         Hcomp_Other_With_One_Dep_Child : Real := 0.0;
         Hcomp_Other_With_Two_Or_More_Dep_Kids : Real := 0.0;
         Hcomp_Other_All_Full_Time_Students : Real := 0.0;
         Hcomp_Other_All_Aged_65_And_Over : Real := 0.0;
         Hcomp_Other_Other : Real := 0.0;
         Number_Of_Rooms_All_Categories_Number_Of_Rooms : Real := 0.0;
         Number_Of_Rooms_1_Room : Real := 0.0;
         Number_Of_Rooms_2_Rooms : Real := 0.0;
         Number_Of_Rooms_3_Rooms : Real := 0.0;
         Number_Of_Rooms_4_Rooms : Real := 0.0;
         Number_Of_Rooms_5_Rooms : Real := 0.0;
         Number_Of_Rooms_6_Rooms : Real := 0.0;
         Number_Of_Rooms_7_Rooms : Real := 0.0;
         Number_Of_Rooms_8_Rooms : Real := 0.0;
         Number_Of_Rooms_9_Or_More_Rooms : Real := 0.0;
         Residence_All_Categories_Residence_Type : Real := 0.0;
         Residence_Lives_In_A_Household : Real := 0.0;
         Residence_Lives_In_A_Communal_Establishment : Real := 0.0;
         Residence_Communal_Establishments_With_Persons_Sleeping_Rough : Real := 0.0;
         Tenure_All_Categories_Tenure : Real := 0.0;
         Tenure_Owned_Total : Real := 0.0;
         Tenure_Owned_Owned_Outright : Real := 0.0;
         Tenure_Owned_Owned_With_A_Mortgage_Or_Loan : Real := 0.0;
         Tenure_Shared_Ownership_Part_Owned_And_Part_Rented : Real := 0.0;
         Tenure_Social_Rented_Total : Real := 0.0;
         Tenure_Social_Rented_Rented_From_Council_Local_Authority : Real := 0.0;
         Tenure_Social_Rented_Other_Social_Rented : Real := 0.0;
         Tenure_Private_Rented_Total : Real := 0.0;
         Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency : Real := 0.0;
         Tenure_Private_Rented_Employer_Of_A_Household_Member : Real := 0.0;
         Tenure_Private_Rented_Relative_Or_Friend_Of_Household : Real := 0.0;
         Tenure_Private_Rented_Other : Real := 0.0;
         Tenure_Living_Rent_Free : Real := 0.0;
         Occupation_All_Categories_Occupation : Real := 0.0;
         Occupation_1_Managers_Directors_And_Senior_Officials : Real := 0.0;
         Occupation_2_Professional_Occupations : Real := 0.0;
         Occupation_3_Associate_Professional_And_Technical_Occupations : Real := 0.0;
         Occupation_4_Administrative_And_Secretarial_Occupations : Real := 0.0;
         Occupation_5_Skilled_Trades_Occupations : Real := 0.0;
         Occupation_6_Caring_Leisure_And_Other_Service_Occupations : Real := 0.0;
         Occupation_7_Sales_And_Customer_Service_Occupations : Real := 0.0;
         Occupation_8_Process_Plant_And_Machine_Operatives : Real := 0.0;
         Occupation_9_Elementary_Occupations : Real := 0.0;
         Income_Support_People_Claiming_Benefit : Real := 0.0;
         Income_Support_Average_Weekly_Payment : Real := 0.0;
         Jsa_Total : Real := 0.0;
         Pension_Credits_Number_Of_Claimants : Real := 0.0;
         Pension_Credits_Number_Of_Beneficiaries : Real := 0.0;
         Pension_Credits_Average_Weekly_Payment : Real := 0.0;
         Out_Of_Work_Families : Real := 0.0;
         Out_Of_Work_Children : Real := 0.0;
         Wtc_And_Ctc_Families : Real := 0.0;
         Wtc_And_Ctc_Children : Real := 0.0;
         Ctc_Only_Families : Real := 0.0;
         Ctc_Only_Children : Real := 0.0;
         Childcare_Element : Real := 0.0;
         Credits_No_Children : Real := 0.0;
         Credits_Total_Families : Real := 0.0;
   end record;
   --
   -- container for target_candidates : One row for each Council/FRS household
   --
   package Target_Candidates_Type_List is new Ada.Containers.Vectors
      (Element_Type => Target_Candidates_Type,
      Index_Type => Positive );
   --
   -- default value for target_candidates : One row for each Council/FRS household
   --
   Null_Target_Candidates_Type : constant Target_Candidates_Type := (
         Id => MISSING_I_KEY,
         Code => MISSING_W_KEY,
         Edition => MISSING_I_KEY,
         Frs_Region => 0,
         Hb_Total => 0.0,
         Hb_Social_Rented_Sector => 0.0,
         Hb_Private_Rented_Sector => 0.0,
         Hb_Passported => 0.0,
         Hb_Non_Passported => 0.0,
         Ct_All => 0.0,
         Ct_Passported => 0.0,
         Ct_Non_Passported => 0.0,
         Genders_All_Usual_Residents => 0.0,
         Genders_Males => 0.0,
         Genders_Females => 0.0,
         Genders_Lives_In_A_Household => 0.0,
         Genders_Lives_In_A_Communal_Establishment => 0.0,
         Genders_Schoolchild_Or_Student_Non_Term_Time_Address => 0.0,
         Age_Ranges_All_Categories_Age => 0.0,
         Age_Ranges_Age_Under_1 => 0.0,
         Age_Ranges_Age_1 => 0.0,
         Age_Ranges_Age_2 => 0.0,
         Age_Ranges_Age_3 => 0.0,
         Age_Ranges_Age_4 => 0.0,
         Age_Ranges_Age_5 => 0.0,
         Age_Ranges_Age_6 => 0.0,
         Age_Ranges_Age_7 => 0.0,
         Age_Ranges_Age_8 => 0.0,
         Age_Ranges_Age_9 => 0.0,
         Age_Ranges_Age_10 => 0.0,
         Age_Ranges_Age_11 => 0.0,
         Age_Ranges_Age_12 => 0.0,
         Age_Ranges_Age_13 => 0.0,
         Age_Ranges_Age_14 => 0.0,
         Age_Ranges_Age_15 => 0.0,
         Age_Ranges_Age_16 => 0.0,
         Age_Ranges_Age_17 => 0.0,
         Age_Ranges_Age_18 => 0.0,
         Age_Ranges_Age_19 => 0.0,
         Age_Ranges_Age_20 => 0.0,
         Age_Ranges_Age_21 => 0.0,
         Age_Ranges_Age_22 => 0.0,
         Age_Ranges_Age_23 => 0.0,
         Age_Ranges_Age_24 => 0.0,
         Age_Ranges_Age_25 => 0.0,
         Age_Ranges_Age_26 => 0.0,
         Age_Ranges_Age_27 => 0.0,
         Age_Ranges_Age_28 => 0.0,
         Age_Ranges_Age_29 => 0.0,
         Age_Ranges_Age_30 => 0.0,
         Age_Ranges_Age_31 => 0.0,
         Age_Ranges_Age_32 => 0.0,
         Age_Ranges_Age_33 => 0.0,
         Age_Ranges_Age_34 => 0.0,
         Age_Ranges_Age_35 => 0.0,
         Age_Ranges_Age_36 => 0.0,
         Age_Ranges_Age_37 => 0.0,
         Age_Ranges_Age_38 => 0.0,
         Age_Ranges_Age_39 => 0.0,
         Age_Ranges_Age_40 => 0.0,
         Age_Ranges_Age_41 => 0.0,
         Age_Ranges_Age_42 => 0.0,
         Age_Ranges_Age_43 => 0.0,
         Age_Ranges_Age_44 => 0.0,
         Age_Ranges_Age_45 => 0.0,
         Age_Ranges_Age_46 => 0.0,
         Age_Ranges_Age_47 => 0.0,
         Age_Ranges_Age_48 => 0.0,
         Age_Ranges_Age_49 => 0.0,
         Age_Ranges_Age_50 => 0.0,
         Age_Ranges_Age_51 => 0.0,
         Age_Ranges_Age_52 => 0.0,
         Age_Ranges_Age_53 => 0.0,
         Age_Ranges_Age_54 => 0.0,
         Age_Ranges_Age_55 => 0.0,
         Age_Ranges_Age_56 => 0.0,
         Age_Ranges_Age_57 => 0.0,
         Age_Ranges_Age_58 => 0.0,
         Age_Ranges_Age_59 => 0.0,
         Age_Ranges_Age_60 => 0.0,
         Age_Ranges_Age_61 => 0.0,
         Age_Ranges_Age_62 => 0.0,
         Age_Ranges_Age_63 => 0.0,
         Age_Ranges_Age_64 => 0.0,
         Age_Ranges_Age_65 => 0.0,
         Age_Ranges_Age_66 => 0.0,
         Age_Ranges_Age_67 => 0.0,
         Age_Ranges_Age_68 => 0.0,
         Age_Ranges_Age_69 => 0.0,
         Age_Ranges_Age_70 => 0.0,
         Age_Ranges_Age_71 => 0.0,
         Age_Ranges_Age_72 => 0.0,
         Age_Ranges_Age_73 => 0.0,
         Age_Ranges_Age_74 => 0.0,
         Age_Ranges_Age_75 => 0.0,
         Age_Ranges_Age_76 => 0.0,
         Age_Ranges_Age_77 => 0.0,
         Age_Ranges_Age_78 => 0.0,
         Age_Ranges_Age_79 => 0.0,
         Age_Ranges_Age_80 => 0.0,
         Age_Ranges_Age_81 => 0.0,
         Age_Ranges_Age_82 => 0.0,
         Age_Ranges_Age_83 => 0.0,
         Age_Ranges_Age_84 => 0.0,
         Age_Ranges_Age_85 => 0.0,
         Age_Ranges_Age_86 => 0.0,
         Age_Ranges_Age_87 => 0.0,
         Age_Ranges_Age_88 => 0.0,
         Age_Ranges_Age_89 => 0.0,
         Age_Ranges_Age_90 => 0.0,
         Age_Ranges_Age_91 => 0.0,
         Age_Ranges_Age_92 => 0.0,
         Age_Ranges_Age_93 => 0.0,
         Age_Ranges_Age_94 => 0.0,
         Age_Ranges_Age_95 => 0.0,
         Age_Ranges_Age_96 => 0.0,
         Age_Ranges_Age_97 => 0.0,
         Age_Ranges_Age_98 => 0.0,
         Age_Ranges_Age_99 => 0.0,
         Age_Ranges_Age_100_And_Over => 0.0,
         Accom_All_Categories_Accommodation_Type => 0.0,
         Accom_Unshared_Total => 0.0,
         Accom_Unshared_Whole_House_Or_Bungalow_Total => 0.0,
         Accom_Unshared_Whole_House_Or_Bungalow_Detached => 0.0,
         Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached => 0.0,
         Accom_Unshared_Whole_House_Or_Bungalow_Terraced => 0.0,
         Accom_Unshared_Flat_Maisonette_Or_Apartment_Total => 0.0,
         Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement => 0.0,
         Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House => 0.0,
         Accom_Unshared_Flat_Etc_In_Commercial_Building => 0.0,
         Accom_Unshared_Caravan_Etc => 0.0,
         Accom_Shared => 0.0,
         Ec_Act_All_Categories_Economic_Activity => 0.0,
         Ec_Act_Active_Total => 0.0,
         Ec_Act_Active_Employee_Part_Time => 0.0,
         Ec_Act_Active_Employee_Full_Time => 0.0,
         Ec_Act_Active_Self_Employed_With_Employees_Part_Time => 0.0,
         Ec_Act_Active_Self_Employed_With_Employees_Full_Time => 0.0,
         Ec_Act_Active_Self_Employed_Without_Employees_Part_Time => 0.0,
         Ec_Act_Active_Self_Employed_Without_Employees_Full_Time => 0.0,
         Ec_Act_Active_Unemployed => 0.0,
         Ec_Act_Active_Full_Time_Student => 0.0,
         Ec_Act_Inactive_Total => 0.0,
         Ec_Act_Inactive_Retired => 0.0,
         Ec_Act_Inactive_Student_Including_Full_Time_Students => 0.0,
         Ec_Act_Inactive_Looking_After_Home_Or_Family => 0.0,
         Ec_Act_Inactive_Long_Term_Sick_Or_Disabled => 0.0,
         Ec_Act_Inactive_Other => 0.0,
         Ethgrp_All_Categories_Ethnic_Group => 0.0,
         Ethgrp_White => 0.0,
         Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British => 0.0,
         Ethgrp_White_Irish => 0.0,
         Ethgrp_White_Gypsy_Or_Irish_Traveller => 0.0,
         Ethgrp_White_Other_White => 0.0,
         Ethgrp_Mixed => 0.0,
         Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean => 0.0,
         Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African => 0.0,
         Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian => 0.0,
         Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed => 0.0,
         Ethgrp_Asian => 0.0,
         Ethgrp_Asian_Asian_British_Indian => 0.0,
         Ethgrp_Asian_Asian_British_Pakistani => 0.0,
         Ethgrp_Asian_Asian_British_Bangladeshi => 0.0,
         Ethgrp_Asian_Asian_British_Chinese => 0.0,
         Ethgrp_Asian_Asian_British_Other_Asian => 0.0,
         Ethgrp_Black => 0.0,
         Ethgrp_Black_African_Caribbean_Black_British_African => 0.0,
         Ethgrp_Black_African_Caribbean_Black_British_Caribbean => 0.0,
         Ethgrp_Black_African_Caribbean_Black_British_Other_Black => 0.0,
         Ethgrp_Other => 0.0,
         Ethgrp_Other_Ethnic_Group_Arab => 0.0,
         Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group => 0.0,
         Hcomp_All_Categories_Household_Composition => 0.0,
         Hcomp_One_Person_Household_Total => 0.0,
         Hcomp_One_Person_Household_Aged_65_And_Over => 0.0,
         Hcomp_One_Person_Household_Other => 0.0,
         Hcomp_One_Family_Only_Total => 0.0,
         Hcomp_One_Family_Only_All_Aged_65_And_Over => 0.0,
         Hcomp_One_Family_Only_Married_Cple_Total => 0.0,
         Hcomp_One_Family_Only_Married_Cple_No_Kids => 0.0,
         Hcomp_One_Family_Only_Married_Cple_One_Dep_Child => 0.0,
         Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids => 0.0,
         Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep => 0.0,
         Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total => 0.0,
         Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids => 0.0,
         Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child => 0.0,
         Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids => 0.0,
         Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep => 0.0,
         Hcomp_One_Family_Only_Cohabiting_Cple_Total => 0.0,
         Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids => 0.0,
         Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child => 0.0,
         Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids => 0.0,
         Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep => 0.0,
         Hcomp_One_Family_Only_Lone_Parent_Total => 0.0,
         Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child => 0.0,
         Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids => 0.0,
         Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep => 0.0,
         Hcomp_Other_Total => 0.0,
         Hcomp_Other_With_One_Dep_Child => 0.0,
         Hcomp_Other_With_Two_Or_More_Dep_Kids => 0.0,
         Hcomp_Other_All_Full_Time_Students => 0.0,
         Hcomp_Other_All_Aged_65_And_Over => 0.0,
         Hcomp_Other_Other => 0.0,
         Number_Of_Rooms_All_Categories_Number_Of_Rooms => 0.0,
         Number_Of_Rooms_1_Room => 0.0,
         Number_Of_Rooms_2_Rooms => 0.0,
         Number_Of_Rooms_3_Rooms => 0.0,
         Number_Of_Rooms_4_Rooms => 0.0,
         Number_Of_Rooms_5_Rooms => 0.0,
         Number_Of_Rooms_6_Rooms => 0.0,
         Number_Of_Rooms_7_Rooms => 0.0,
         Number_Of_Rooms_8_Rooms => 0.0,
         Number_Of_Rooms_9_Or_More_Rooms => 0.0,
         Residence_All_Categories_Residence_Type => 0.0,
         Residence_Lives_In_A_Household => 0.0,
         Residence_Lives_In_A_Communal_Establishment => 0.0,
         Residence_Communal_Establishments_With_Persons_Sleeping_Rough => 0.0,
         Tenure_All_Categories_Tenure => 0.0,
         Tenure_Owned_Total => 0.0,
         Tenure_Owned_Owned_Outright => 0.0,
         Tenure_Owned_Owned_With_A_Mortgage_Or_Loan => 0.0,
         Tenure_Shared_Ownership_Part_Owned_And_Part_Rented => 0.0,
         Tenure_Social_Rented_Total => 0.0,
         Tenure_Social_Rented_Rented_From_Council_Local_Authority => 0.0,
         Tenure_Social_Rented_Other_Social_Rented => 0.0,
         Tenure_Private_Rented_Total => 0.0,
         Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency => 0.0,
         Tenure_Private_Rented_Employer_Of_A_Household_Member => 0.0,
         Tenure_Private_Rented_Relative_Or_Friend_Of_Household => 0.0,
         Tenure_Private_Rented_Other => 0.0,
         Tenure_Living_Rent_Free => 0.0,
         Occupation_All_Categories_Occupation => 0.0,
         Occupation_1_Managers_Directors_And_Senior_Officials => 0.0,
         Occupation_2_Professional_Occupations => 0.0,
         Occupation_3_Associate_Professional_And_Technical_Occupations => 0.0,
         Occupation_4_Administrative_And_Secretarial_Occupations => 0.0,
         Occupation_5_Skilled_Trades_Occupations => 0.0,
         Occupation_6_Caring_Leisure_And_Other_Service_Occupations => 0.0,
         Occupation_7_Sales_And_Customer_Service_Occupations => 0.0,
         Occupation_8_Process_Plant_And_Machine_Operatives => 0.0,
         Occupation_9_Elementary_Occupations => 0.0,
         Income_Support_People_Claiming_Benefit => 0.0,
         Income_Support_Average_Weekly_Payment => 0.0,
         Jsa_Total => 0.0,
         Pension_Credits_Number_Of_Claimants => 0.0,
         Pension_Credits_Number_Of_Beneficiaries => 0.0,
         Pension_Credits_Average_Weekly_Payment => 0.0,
         Out_Of_Work_Families => 0.0,
         Out_Of_Work_Children => 0.0,
         Wtc_And_Ctc_Families => 0.0,
         Wtc_And_Ctc_Children => 0.0,
         Ctc_Only_Families => 0.0,
         Ctc_Only_Children => 0.0,
         Childcare_Element => 0.0,
         Credits_No_Children => 0.0,
         Credits_Total_Families => 0.0
   );
   --
   -- simple print routine for target_candidates : One row for each Council/FRS household
   --
   function To_String( rec : Target_Candidates_Type ) return String;

        
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end La_Data_Data;
