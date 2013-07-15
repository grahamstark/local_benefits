--
-- Created by ada_generator.py on 2013-06-12 18:50:25.980022
-- 

with GNAT.Calendar.Time_IO;
-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body La_Data_Data is

   use ada.strings.Unbounded;
   package tio renames GNAT.Calendar.Time_IO;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===
   
   
   function To_String( rec : Regions_In_Country_Type ) return String is
   begin
      return  "Regions_In_Country_Type: " &
         "Country_Name = " & To_String( rec.Country_Name ) &
         "Region_Name = " & To_String( rec.Region_Name ) &
         "Frs_Region_Code = " & rec.Frs_Region_Code'Img;
   end to_String;



   function To_String( rec : Las_In_Region_Type ) return String is
   begin
      return  "Las_In_Region_Type: " &
         "Lacode = " & To_String( rec.Lacode ) &
         "Region = " & To_String( rec.Region ) &
         "Frs_Region_Code = " & rec.Frs_Region_Code'Img;
   end to_String;



   function To_String( rec : Government_Region_Type ) return String is
   begin
      return  "Government_Region_Type: " &
         "Name = " & To_String( rec.Name ) &
         "Frs_Region_Code = " & rec.Frs_Region_Code'Img;
   end to_String;



   function To_String( rec : Country_Type ) return String is
   begin
      return  "Country_Type: " &
         "Name = " & To_String( rec.Name );
   end to_String;



   function To_String( rec : Las_Type ) return String is
   begin
      return  "Las_Type: " &
         "Code = " & To_String( rec.Code ) &
         "Name = " & To_String( rec.Name );
   end to_String;



   function To_String( rec : Target_Candidates_Type ) return String is
   begin
      return  "Target_Candidates_Type: " &
         "Id = " & rec.Id'Img &
         "Code = " & To_String( rec.Code ) &
         "Edition = " & rec.Edition'Img &
         "Frs_Region = " & rec.Frs_Region'Img &
         "Hb_Total = " & rec.Hb_Total'Img &
         "Hb_Social_Rented_Sector = " & rec.Hb_Social_Rented_Sector'Img &
         "Hb_Private_Rented_Sector = " & rec.Hb_Private_Rented_Sector'Img &
         "Hb_Passported = " & rec.Hb_Passported'Img &
         "Hb_Non_Passported = " & rec.Hb_Non_Passported'Img &
         "Ct_All = " & rec.Ct_All'Img &
         "Ct_Passported = " & rec.Ct_Passported'Img &
         "Ct_Non_Passported = " & rec.Ct_Non_Passported'Img &
         "Genders_All_Usual_Residents = " & rec.Genders_All_Usual_Residents'Img &
         "Genders_Males = " & rec.Genders_Males'Img &
         "Genders_Females = " & rec.Genders_Females'Img &
         "Genders_Lives_In_A_Household = " & rec.Genders_Lives_In_A_Household'Img &
         "Genders_Lives_In_A_Communal_Establishment = " & rec.Genders_Lives_In_A_Communal_Establishment'Img &
         "Genders_Schoolchild_Or_Student_Non_Term_Time_Address = " & rec.Genders_Schoolchild_Or_Student_Non_Term_Time_Address'Img &
         "Age_Ranges_All_Categories_Age = " & rec.Age_Ranges_All_Categories_Age'Img &
         "Age_Ranges_Age_Under_1 = " & rec.Age_Ranges_Age_Under_1'Img &
         "Age_Ranges_Age_1 = " & rec.Age_Ranges_Age_1'Img &
         "Age_Ranges_Age_2 = " & rec.Age_Ranges_Age_2'Img &
         "Age_Ranges_Age_3 = " & rec.Age_Ranges_Age_3'Img &
         "Age_Ranges_Age_4 = " & rec.Age_Ranges_Age_4'Img &
         "Age_Ranges_Age_5 = " & rec.Age_Ranges_Age_5'Img &
         "Age_Ranges_Age_6 = " & rec.Age_Ranges_Age_6'Img &
         "Age_Ranges_Age_7 = " & rec.Age_Ranges_Age_7'Img &
         "Age_Ranges_Age_8 = " & rec.Age_Ranges_Age_8'Img &
         "Age_Ranges_Age_9 = " & rec.Age_Ranges_Age_9'Img &
         "Age_Ranges_Age_10 = " & rec.Age_Ranges_Age_10'Img &
         "Age_Ranges_Age_11 = " & rec.Age_Ranges_Age_11'Img &
         "Age_Ranges_Age_12 = " & rec.Age_Ranges_Age_12'Img &
         "Age_Ranges_Age_13 = " & rec.Age_Ranges_Age_13'Img &
         "Age_Ranges_Age_14 = " & rec.Age_Ranges_Age_14'Img &
         "Age_Ranges_Age_15 = " & rec.Age_Ranges_Age_15'Img &
         "Age_Ranges_Age_16 = " & rec.Age_Ranges_Age_16'Img &
         "Age_Ranges_Age_17 = " & rec.Age_Ranges_Age_17'Img &
         "Age_Ranges_Age_18 = " & rec.Age_Ranges_Age_18'Img &
         "Age_Ranges_Age_19 = " & rec.Age_Ranges_Age_19'Img &
         "Age_Ranges_Age_20 = " & rec.Age_Ranges_Age_20'Img &
         "Age_Ranges_Age_21 = " & rec.Age_Ranges_Age_21'Img &
         "Age_Ranges_Age_22 = " & rec.Age_Ranges_Age_22'Img &
         "Age_Ranges_Age_23 = " & rec.Age_Ranges_Age_23'Img &
         "Age_Ranges_Age_24 = " & rec.Age_Ranges_Age_24'Img &
         "Age_Ranges_Age_25 = " & rec.Age_Ranges_Age_25'Img &
         "Age_Ranges_Age_26 = " & rec.Age_Ranges_Age_26'Img &
         "Age_Ranges_Age_27 = " & rec.Age_Ranges_Age_27'Img &
         "Age_Ranges_Age_28 = " & rec.Age_Ranges_Age_28'Img &
         "Age_Ranges_Age_29 = " & rec.Age_Ranges_Age_29'Img &
         "Age_Ranges_Age_30 = " & rec.Age_Ranges_Age_30'Img &
         "Age_Ranges_Age_31 = " & rec.Age_Ranges_Age_31'Img &
         "Age_Ranges_Age_32 = " & rec.Age_Ranges_Age_32'Img &
         "Age_Ranges_Age_33 = " & rec.Age_Ranges_Age_33'Img &
         "Age_Ranges_Age_34 = " & rec.Age_Ranges_Age_34'Img &
         "Age_Ranges_Age_35 = " & rec.Age_Ranges_Age_35'Img &
         "Age_Ranges_Age_36 = " & rec.Age_Ranges_Age_36'Img &
         "Age_Ranges_Age_37 = " & rec.Age_Ranges_Age_37'Img &
         "Age_Ranges_Age_38 = " & rec.Age_Ranges_Age_38'Img &
         "Age_Ranges_Age_39 = " & rec.Age_Ranges_Age_39'Img &
         "Age_Ranges_Age_40 = " & rec.Age_Ranges_Age_40'Img &
         "Age_Ranges_Age_41 = " & rec.Age_Ranges_Age_41'Img &
         "Age_Ranges_Age_42 = " & rec.Age_Ranges_Age_42'Img &
         "Age_Ranges_Age_43 = " & rec.Age_Ranges_Age_43'Img &
         "Age_Ranges_Age_44 = " & rec.Age_Ranges_Age_44'Img &
         "Age_Ranges_Age_45 = " & rec.Age_Ranges_Age_45'Img &
         "Age_Ranges_Age_46 = " & rec.Age_Ranges_Age_46'Img &
         "Age_Ranges_Age_47 = " & rec.Age_Ranges_Age_47'Img &
         "Age_Ranges_Age_48 = " & rec.Age_Ranges_Age_48'Img &
         "Age_Ranges_Age_49 = " & rec.Age_Ranges_Age_49'Img &
         "Age_Ranges_Age_50 = " & rec.Age_Ranges_Age_50'Img &
         "Age_Ranges_Age_51 = " & rec.Age_Ranges_Age_51'Img &
         "Age_Ranges_Age_52 = " & rec.Age_Ranges_Age_52'Img &
         "Age_Ranges_Age_53 = " & rec.Age_Ranges_Age_53'Img &
         "Age_Ranges_Age_54 = " & rec.Age_Ranges_Age_54'Img &
         "Age_Ranges_Age_55 = " & rec.Age_Ranges_Age_55'Img &
         "Age_Ranges_Age_56 = " & rec.Age_Ranges_Age_56'Img &
         "Age_Ranges_Age_57 = " & rec.Age_Ranges_Age_57'Img &
         "Age_Ranges_Age_58 = " & rec.Age_Ranges_Age_58'Img &
         "Age_Ranges_Age_59 = " & rec.Age_Ranges_Age_59'Img &
         "Age_Ranges_Age_60 = " & rec.Age_Ranges_Age_60'Img &
         "Age_Ranges_Age_61 = " & rec.Age_Ranges_Age_61'Img &
         "Age_Ranges_Age_62 = " & rec.Age_Ranges_Age_62'Img &
         "Age_Ranges_Age_63 = " & rec.Age_Ranges_Age_63'Img &
         "Age_Ranges_Age_64 = " & rec.Age_Ranges_Age_64'Img &
         "Age_Ranges_Age_65 = " & rec.Age_Ranges_Age_65'Img &
         "Age_Ranges_Age_66 = " & rec.Age_Ranges_Age_66'Img &
         "Age_Ranges_Age_67 = " & rec.Age_Ranges_Age_67'Img &
         "Age_Ranges_Age_68 = " & rec.Age_Ranges_Age_68'Img &
         "Age_Ranges_Age_69 = " & rec.Age_Ranges_Age_69'Img &
         "Age_Ranges_Age_70 = " & rec.Age_Ranges_Age_70'Img &
         "Age_Ranges_Age_71 = " & rec.Age_Ranges_Age_71'Img &
         "Age_Ranges_Age_72 = " & rec.Age_Ranges_Age_72'Img &
         "Age_Ranges_Age_73 = " & rec.Age_Ranges_Age_73'Img &
         "Age_Ranges_Age_74 = " & rec.Age_Ranges_Age_74'Img &
         "Age_Ranges_Age_75 = " & rec.Age_Ranges_Age_75'Img &
         "Age_Ranges_Age_76 = " & rec.Age_Ranges_Age_76'Img &
         "Age_Ranges_Age_77 = " & rec.Age_Ranges_Age_77'Img &
         "Age_Ranges_Age_78 = " & rec.Age_Ranges_Age_78'Img &
         "Age_Ranges_Age_79 = " & rec.Age_Ranges_Age_79'Img &
         "Age_Ranges_Age_80 = " & rec.Age_Ranges_Age_80'Img &
         "Age_Ranges_Age_81 = " & rec.Age_Ranges_Age_81'Img &
         "Age_Ranges_Age_82 = " & rec.Age_Ranges_Age_82'Img &
         "Age_Ranges_Age_83 = " & rec.Age_Ranges_Age_83'Img &
         "Age_Ranges_Age_84 = " & rec.Age_Ranges_Age_84'Img &
         "Age_Ranges_Age_85 = " & rec.Age_Ranges_Age_85'Img &
         "Age_Ranges_Age_86 = " & rec.Age_Ranges_Age_86'Img &
         "Age_Ranges_Age_87 = " & rec.Age_Ranges_Age_87'Img &
         "Age_Ranges_Age_88 = " & rec.Age_Ranges_Age_88'Img &
         "Age_Ranges_Age_89 = " & rec.Age_Ranges_Age_89'Img &
         "Age_Ranges_Age_90 = " & rec.Age_Ranges_Age_90'Img &
         "Age_Ranges_Age_91 = " & rec.Age_Ranges_Age_91'Img &
         "Age_Ranges_Age_92 = " & rec.Age_Ranges_Age_92'Img &
         "Age_Ranges_Age_93 = " & rec.Age_Ranges_Age_93'Img &
         "Age_Ranges_Age_94 = " & rec.Age_Ranges_Age_94'Img &
         "Age_Ranges_Age_95 = " & rec.Age_Ranges_Age_95'Img &
         "Age_Ranges_Age_96 = " & rec.Age_Ranges_Age_96'Img &
         "Age_Ranges_Age_97 = " & rec.Age_Ranges_Age_97'Img &
         "Age_Ranges_Age_98 = " & rec.Age_Ranges_Age_98'Img &
         "Age_Ranges_Age_99 = " & rec.Age_Ranges_Age_99'Img &
         "Age_Ranges_Age_100_And_Over = " & rec.Age_Ranges_Age_100_And_Over'Img &
         "Accom_All_Categories_Accommodation_Type = " & rec.Accom_All_Categories_Accommodation_Type'Img &
         "Accom_Unshared_Total = " & rec.Accom_Unshared_Total'Img &
         "Accom_Unshared_Whole_House_Or_Bungalow_Total = " & rec.Accom_Unshared_Whole_House_Or_Bungalow_Total'Img &
         "Accom_Unshared_Whole_House_Or_Bungalow_Detached = " & rec.Accom_Unshared_Whole_House_Or_Bungalow_Detached'Img &
         "Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached = " & rec.Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached'Img &
         "Accom_Unshared_Whole_House_Or_Bungalow_Terraced = " & rec.Accom_Unshared_Whole_House_Or_Bungalow_Terraced'Img &
         "Accom_Unshared_Flat_Maisonette_Or_Apartment_Total = " & rec.Accom_Unshared_Flat_Maisonette_Or_Apartment_Total'Img &
         "Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement = " & rec.Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement'Img &
         "Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House = " & rec.Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House'Img &
         "Accom_Unshared_Flat_Etc_In_Commercial_Building = " & rec.Accom_Unshared_Flat_Etc_In_Commercial_Building'Img &
         "Accom_Unshared_Caravan_Etc = " & rec.Accom_Unshared_Caravan_Etc'Img &
         "Accom_Shared = " & rec.Accom_Shared'Img &
         "Ec_Act_All_Categories_Economic_Activity = " & rec.Ec_Act_All_Categories_Economic_Activity'Img &
         "Ec_Act_Active_Total = " & rec.Ec_Act_Active_Total'Img &
         "Ec_Act_Active_Employee_Part_Time = " & rec.Ec_Act_Active_Employee_Part_Time'Img &
         "Ec_Act_Active_Employee_Full_Time = " & rec.Ec_Act_Active_Employee_Full_Time'Img &
         "Ec_Act_Active_Self_Employed_With_Employees_Part_Time = " & rec.Ec_Act_Active_Self_Employed_With_Employees_Part_Time'Img &
         "Ec_Act_Active_Self_Employed_With_Employees_Full_Time = " & rec.Ec_Act_Active_Self_Employed_With_Employees_Full_Time'Img &
         "Ec_Act_Active_Self_Employed_Without_Employees_Part_Time = " & rec.Ec_Act_Active_Self_Employed_Without_Employees_Part_Time'Img &
         "Ec_Act_Active_Self_Employed_Without_Employees_Full_Time = " & rec.Ec_Act_Active_Self_Employed_Without_Employees_Full_Time'Img &
         "Ec_Act_Active_Unemployed = " & rec.Ec_Act_Active_Unemployed'Img &
         "Ec_Act_Active_Full_Time_Student = " & rec.Ec_Act_Active_Full_Time_Student'Img &
         "Ec_Act_Inactive_Total = " & rec.Ec_Act_Inactive_Total'Img &
         "Ec_Act_Inactive_Retired = " & rec.Ec_Act_Inactive_Retired'Img &
         "Ec_Act_Inactive_Student_Including_Full_Time_Students = " & rec.Ec_Act_Inactive_Student_Including_Full_Time_Students'Img &
         "Ec_Act_Inactive_Looking_After_Home_Or_Family = " & rec.Ec_Act_Inactive_Looking_After_Home_Or_Family'Img &
         "Ec_Act_Inactive_Long_Term_Sick_Or_Disabled = " & rec.Ec_Act_Inactive_Long_Term_Sick_Or_Disabled'Img &
         "Ec_Act_Inactive_Other = " & rec.Ec_Act_Inactive_Other'Img &
         "Ethgrp_All_Categories_Ethnic_Group = " & rec.Ethgrp_All_Categories_Ethnic_Group'Img &
         "Ethgrp_White = " & rec.Ethgrp_White'Img &
         "Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British = " & rec.Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British'Img &
         "Ethgrp_White_Irish = " & rec.Ethgrp_White_Irish'Img &
         "Ethgrp_White_Gypsy_Or_Irish_Traveller = " & rec.Ethgrp_White_Gypsy_Or_Irish_Traveller'Img &
         "Ethgrp_White_Other_White = " & rec.Ethgrp_White_Other_White'Img &
         "Ethgrp_Mixed = " & rec.Ethgrp_Mixed'Img &
         "Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean = " & rec.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean'Img &
         "Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African = " & rec.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African'Img &
         "Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian = " & rec.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian'Img &
         "Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed = " & rec.Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed'Img &
         "Ethgrp_Asian = " & rec.Ethgrp_Asian'Img &
         "Ethgrp_Asian_Asian_British_Indian = " & rec.Ethgrp_Asian_Asian_British_Indian'Img &
         "Ethgrp_Asian_Asian_British_Pakistani = " & rec.Ethgrp_Asian_Asian_British_Pakistani'Img &
         "Ethgrp_Asian_Asian_British_Bangladeshi = " & rec.Ethgrp_Asian_Asian_British_Bangladeshi'Img &
         "Ethgrp_Asian_Asian_British_Chinese = " & rec.Ethgrp_Asian_Asian_British_Chinese'Img &
         "Ethgrp_Asian_Asian_British_Other_Asian = " & rec.Ethgrp_Asian_Asian_British_Other_Asian'Img &
         "Ethgrp_Black = " & rec.Ethgrp_Black'Img &
         "Ethgrp_Black_African_Caribbean_Black_British_African = " & rec.Ethgrp_Black_African_Caribbean_Black_British_African'Img &
         "Ethgrp_Black_African_Caribbean_Black_British_Caribbean = " & rec.Ethgrp_Black_African_Caribbean_Black_British_Caribbean'Img &
         "Ethgrp_Black_African_Caribbean_Black_British_Other_Black = " & rec.Ethgrp_Black_African_Caribbean_Black_British_Other_Black'Img &
         "Ethgrp_Other = " & rec.Ethgrp_Other'Img &
         "Ethgrp_Other_Ethnic_Group_Arab = " & rec.Ethgrp_Other_Ethnic_Group_Arab'Img &
         "Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group = " & rec.Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group'Img &
         "Hcomp_All_Categories_Household_Composition = " & rec.Hcomp_All_Categories_Household_Composition'Img &
         "Hcomp_One_Person_Household_Total = " & rec.Hcomp_One_Person_Household_Total'Img &
         "Hcomp_One_Person_Household_Aged_65_And_Over = " & rec.Hcomp_One_Person_Household_Aged_65_And_Over'Img &
         "Hcomp_One_Person_Household_Other = " & rec.Hcomp_One_Person_Household_Other'Img &
         "Hcomp_One_Family_Only_Total = " & rec.Hcomp_One_Family_Only_Total'Img &
         "Hcomp_One_Family_Only_All_Aged_65_And_Over = " & rec.Hcomp_One_Family_Only_All_Aged_65_And_Over'Img &
         "Hcomp_One_Family_Only_Married_Cple_Total = " & rec.Hcomp_One_Family_Only_Married_Cple_Total'Img &
         "Hcomp_One_Family_Only_Married_Cple_No_Kids = " & rec.Hcomp_One_Family_Only_Married_Cple_No_Kids'Img &
         "Hcomp_One_Family_Only_Married_Cple_One_Dep_Child = " & rec.Hcomp_One_Family_Only_Married_Cple_One_Dep_Child'Img &
         "Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids = " & rec.Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids'Img &
         "Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep = " & rec.Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep'Img &
         "Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total = " & rec.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total'Img &
         "Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids = " & rec.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids'Img &
         "Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child = " & rec.Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child'Img &
         "Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids = " & rec.Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids'Img &
         "Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep = " & rec.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep'Img &
         "Hcomp_One_Family_Only_Cohabiting_Cple_Total = " & rec.Hcomp_One_Family_Only_Cohabiting_Cple_Total'Img &
         "Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids = " & rec.Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids'Img &
         "Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child = " & rec.Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child'Img &
         "Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids = " & rec.Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids'Img &
         "Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep = " & rec.Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep'Img &
         "Hcomp_One_Family_Only_Lone_Parent_Total = " & rec.Hcomp_One_Family_Only_Lone_Parent_Total'Img &
         "Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child = " & rec.Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child'Img &
         "Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids = " & rec.Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids'Img &
         "Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep = " & rec.Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep'Img &
         "Hcomp_Other_Total = " & rec.Hcomp_Other_Total'Img &
         "Hcomp_Other_With_One_Dep_Child = " & rec.Hcomp_Other_With_One_Dep_Child'Img &
         "Hcomp_Other_With_Two_Or_More_Dep_Kids = " & rec.Hcomp_Other_With_Two_Or_More_Dep_Kids'Img &
         "Hcomp_Other_All_Full_Time_Students = " & rec.Hcomp_Other_All_Full_Time_Students'Img &
         "Hcomp_Other_All_Aged_65_And_Over = " & rec.Hcomp_Other_All_Aged_65_And_Over'Img &
         "Hcomp_Other_Other = " & rec.Hcomp_Other_Other'Img &
         "Number_Of_Rooms_All_Categories_Number_Of_Rooms = " & rec.Number_Of_Rooms_All_Categories_Number_Of_Rooms'Img &
         "Number_Of_Rooms_1_Room = " & rec.Number_Of_Rooms_1_Room'Img &
         "Number_Of_Rooms_2_Rooms = " & rec.Number_Of_Rooms_2_Rooms'Img &
         "Number_Of_Rooms_3_Rooms = " & rec.Number_Of_Rooms_3_Rooms'Img &
         "Number_Of_Rooms_4_Rooms = " & rec.Number_Of_Rooms_4_Rooms'Img &
         "Number_Of_Rooms_5_Rooms = " & rec.Number_Of_Rooms_5_Rooms'Img &
         "Number_Of_Rooms_6_Rooms = " & rec.Number_Of_Rooms_6_Rooms'Img &
         "Number_Of_Rooms_7_Rooms = " & rec.Number_Of_Rooms_7_Rooms'Img &
         "Number_Of_Rooms_8_Rooms = " & rec.Number_Of_Rooms_8_Rooms'Img &
         "Number_Of_Rooms_9_Or_More_Rooms = " & rec.Number_Of_Rooms_9_Or_More_Rooms'Img &
         "Residence_All_Categories_Residence_Type = " & rec.Residence_All_Categories_Residence_Type'Img &
         "Residence_Lives_In_A_Household = " & rec.Residence_Lives_In_A_Household'Img &
         "Residence_Lives_In_A_Communal_Establishment = " & rec.Residence_Lives_In_A_Communal_Establishment'Img &
         "Residence_Communal_Establishments_With_Persons_Sleeping_Rough = " & rec.Residence_Communal_Establishments_With_Persons_Sleeping_Rough'Img &
         "Tenure_All_Categories_Tenure = " & rec.Tenure_All_Categories_Tenure'Img &
         "Tenure_Owned_Total = " & rec.Tenure_Owned_Total'Img &
         "Tenure_Owned_Owned_Outright = " & rec.Tenure_Owned_Owned_Outright'Img &
         "Tenure_Owned_Owned_With_A_Mortgage_Or_Loan = " & rec.Tenure_Owned_Owned_With_A_Mortgage_Or_Loan'Img &
         "Tenure_Shared_Ownership_Part_Owned_And_Part_Rented = " & rec.Tenure_Shared_Ownership_Part_Owned_And_Part_Rented'Img &
         "Tenure_Social_Rented_Total = " & rec.Tenure_Social_Rented_Total'Img &
         "Tenure_Social_Rented_Rented_From_Council_Local_Authority = " & rec.Tenure_Social_Rented_Rented_From_Council_Local_Authority'Img &
         "Tenure_Social_Rented_Other_Social_Rented = " & rec.Tenure_Social_Rented_Other_Social_Rented'Img &
         "Tenure_Private_Rented_Total = " & rec.Tenure_Private_Rented_Total'Img &
         "Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency = " & rec.Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency'Img &
         "Tenure_Private_Rented_Employer_Of_A_Household_Member = " & rec.Tenure_Private_Rented_Employer_Of_A_Household_Member'Img &
         "Tenure_Private_Rented_Relative_Or_Friend_Of_Household = " & rec.Tenure_Private_Rented_Relative_Or_Friend_Of_Household'Img &
         "Tenure_Private_Rented_Other = " & rec.Tenure_Private_Rented_Other'Img &
         "Tenure_Living_Rent_Free = " & rec.Tenure_Living_Rent_Free'Img &
         "Occupation_All_Categories_Occupation = " & rec.Occupation_All_Categories_Occupation'Img &
         "Occupation_1_Managers_Directors_And_Senior_Officials = " & rec.Occupation_1_Managers_Directors_And_Senior_Officials'Img &
         "Occupation_2_Professional_Occupations = " & rec.Occupation_2_Professional_Occupations'Img &
         "Occupation_3_Associate_Professional_And_Technical_Occupations = " & rec.Occupation_3_Associate_Professional_And_Technical_Occupations'Img &
         "Occupation_4_Administrative_And_Secretarial_Occupations = " & rec.Occupation_4_Administrative_And_Secretarial_Occupations'Img &
         "Occupation_5_Skilled_Trades_Occupations = " & rec.Occupation_5_Skilled_Trades_Occupations'Img &
         "Occupation_6_Caring_Leisure_And_Other_Service_Occupations = " & rec.Occupation_6_Caring_Leisure_And_Other_Service_Occupations'Img &
         "Occupation_7_Sales_And_Customer_Service_Occupations = " & rec.Occupation_7_Sales_And_Customer_Service_Occupations'Img &
         "Occupation_8_Process_Plant_And_Machine_Operatives = " & rec.Occupation_8_Process_Plant_And_Machine_Operatives'Img &
         "Occupation_9_Elementary_Occupations = " & rec.Occupation_9_Elementary_Occupations'Img &
         "Income_Support_People_Claiming_Benefit = " & rec.Income_Support_People_Claiming_Benefit'Img &
         "Income_Support_Average_Weekly_Payment = " & rec.Income_Support_Average_Weekly_Payment'Img &
         "Jsa_Total = " & rec.Jsa_Total'Img &
         "Pension_Credits_Number_Of_Claimants = " & rec.Pension_Credits_Number_Of_Claimants'Img &
         "Pension_Credits_Number_Of_Beneficiaries = " & rec.Pension_Credits_Number_Of_Beneficiaries'Img &
         "Pension_Credits_Average_Weekly_Payment = " & rec.Pension_Credits_Average_Weekly_Payment'Img &
         "Out_Of_Work_Families = " & rec.Out_Of_Work_Families'Img &
         "Out_Of_Work_Children = " & rec.Out_Of_Work_Children'Img &
         "Wtc_And_Ctc_Families = " & rec.Wtc_And_Ctc_Families'Img &
         "Wtc_And_Ctc_Children = " & rec.Wtc_And_Ctc_Children'Img &
         "Ctc_Only_Families = " & rec.Ctc_Only_Families'Img &
         "Ctc_Only_Children = " & rec.Ctc_Only_Children'Img &
         "Childcare_Element = " & rec.Childcare_Element'Img &
         "Credits_No_Children = " & rec.Credits_No_Children'Img &
         "Credits_Total_Families = " & rec.Credits_Total_Families'Img;
   end to_String;



        
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end La_Data_Data;
