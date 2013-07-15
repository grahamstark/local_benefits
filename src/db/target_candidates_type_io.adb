--
-- Created by ada_generator.py on 2013-06-12 18:50:26.286528
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


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Target_Candidates_Type_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "TARGET_CANDIDATES_TYPE_IO" );
   
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
         "id, code, edition, frs_region, hb_total, hb_social_rented_sector, hb_private_rented_sector, hb_passported, hb_non_passported, ct_all," &
         "ct_passported, ct_non_passported, genders_all_usual_residents, genders_males, genders_females, genders_lives_in_a_household, genders_lives_in_a_communal_establishment, genders_schoolchild_or_student_non_term_time_address, age_ranges_all_categories_age, age_ranges_age_under_1," &
         "age_ranges_age_1, age_ranges_age_2, age_ranges_age_3, age_ranges_age_4, age_ranges_age_5, age_ranges_age_6, age_ranges_age_7, age_ranges_age_8, age_ranges_age_9, age_ranges_age_10," &
         "age_ranges_age_11, age_ranges_age_12, age_ranges_age_13, age_ranges_age_14, age_ranges_age_15, age_ranges_age_16, age_ranges_age_17, age_ranges_age_18, age_ranges_age_19, age_ranges_age_20," &
         "age_ranges_age_21, age_ranges_age_22, age_ranges_age_23, age_ranges_age_24, age_ranges_age_25, age_ranges_age_26, age_ranges_age_27, age_ranges_age_28, age_ranges_age_29, age_ranges_age_30," &
         "age_ranges_age_31, age_ranges_age_32, age_ranges_age_33, age_ranges_age_34, age_ranges_age_35, age_ranges_age_36, age_ranges_age_37, age_ranges_age_38, age_ranges_age_39, age_ranges_age_40," &
         "age_ranges_age_41, age_ranges_age_42, age_ranges_age_43, age_ranges_age_44, age_ranges_age_45, age_ranges_age_46, age_ranges_age_47, age_ranges_age_48, age_ranges_age_49, age_ranges_age_50," &
         "age_ranges_age_51, age_ranges_age_52, age_ranges_age_53, age_ranges_age_54, age_ranges_age_55, age_ranges_age_56, age_ranges_age_57, age_ranges_age_58, age_ranges_age_59, age_ranges_age_60," &
         "age_ranges_age_61, age_ranges_age_62, age_ranges_age_63, age_ranges_age_64, age_ranges_age_65, age_ranges_age_66, age_ranges_age_67, age_ranges_age_68, age_ranges_age_69, age_ranges_age_70," &
         "age_ranges_age_71, age_ranges_age_72, age_ranges_age_73, age_ranges_age_74, age_ranges_age_75, age_ranges_age_76, age_ranges_age_77, age_ranges_age_78, age_ranges_age_79, age_ranges_age_80," &
         "age_ranges_age_81, age_ranges_age_82, age_ranges_age_83, age_ranges_age_84, age_ranges_age_85, age_ranges_age_86, age_ranges_age_87, age_ranges_age_88, age_ranges_age_89, age_ranges_age_90," &
         "age_ranges_age_91, age_ranges_age_92, age_ranges_age_93, age_ranges_age_94, age_ranges_age_95, age_ranges_age_96, age_ranges_age_97, age_ranges_age_98, age_ranges_age_99, age_ranges_age_100_and_over," &
         "accom_all_categories_accommodation_type, accom_unshared_total, accom_unshared_whole_house_or_bungalow_total, accom_unshared_whole_house_or_bungalow_detached, accom_unshared_whole_house_or_bungalow_semi_detached, accom_unshared_whole_house_or_bungalow_terraced, accom_unshared_flat_maisonette_or_apartment_total, accom_unshared_flat_etc_purpose_built_flats_or_tenement, accom_unshared_flat_etc_part_of_a_converted_or_shared_house, accom_unshared_flat_etc_in_commercial_building," &
         "accom_unshared_caravan_etc, accom_shared, ec_act_all_categories_economic_activity, ec_act_active_total, ec_act_active_employee_part_time, ec_act_active_employee_full_time, ec_act_active_self_employed_with_employees_part_time, ec_act_active_self_employed_with_employees_full_time, ec_act_active_self_employed_without_employees_part_time, ec_act_active_self_employed_without_employees_full_time," &
         "ec_act_active_unemployed, ec_act_active_full_time_student, ec_act_inactive_total, ec_act_inactive_retired, ec_act_inactive_student_including_full_time_students, ec_act_inactive_looking_after_home_or_family, ec_act_inactive_long_term_sick_or_disabled, ec_act_inactive_other, ethgrp_all_categories_ethnic_group, ethgrp_white," &
         "ethgrp_white_english_welsh_scottish_northern_irish_british, ethgrp_white_irish, ethgrp_white_gypsy_or_irish_traveller, ethgrp_white_other_white, ethgrp_mixed, ethgrp_mixed_multiple_ethnic_group_white_and_black_caribbean, ethgrp_mixed_multiple_ethnic_group_white_and_black_african, ethgrp_mixed_multiple_ethnic_group_white_and_asian, ethgrp_mixed_multiple_ethnic_group_other_mixed, ethgrp_asian," &
         "ethgrp_asian_asian_british_indian, ethgrp_asian_asian_british_pakistani, ethgrp_asian_asian_british_bangladeshi, ethgrp_asian_asian_british_chinese, ethgrp_asian_asian_british_other_asian, ethgrp_black, ethgrp_black_african_caribbean_black_british_african, ethgrp_black_african_caribbean_black_british_caribbean, ethgrp_black_african_caribbean_black_british_other_black, ethgrp_other," &
         "ethgrp_other_ethnic_group_arab, ethgrp_other_ethnic_group_any_other_ethnic_group, hcomp_all_categories_household_composition, hcomp_one_person_household_total, hcomp_one_person_household_aged_65_and_over, hcomp_one_person_household_other, hcomp_one_family_only_total, hcomp_one_family_only_all_aged_65_and_over, hcomp_one_family_only_married_cple_total, hcomp_one_family_only_married_cple_no_kids," &
         "hcomp_one_family_only_married_cple_one_dep_child, hcomp_one_family_only_married_cple_two_or_more_dep_kids, hcomp_one_family_only_married_cple_all_kids_non_dep, hcomp_one_family_only_same_sex_civ_part_cple_total, hcomp_one_family_only_same_sex_civ_part_cple_no_kids, hcomp_same_sex_civ_part_cple_one_dep_child, hcomp_same_sex_civ_part_cple_two_plus_dep_kids, hcomp_one_family_only_same_sex_civ_part_cple_all_kids_non_dep, hcomp_one_family_only_cohabiting_cple_total, hcomp_one_family_only_cohabiting_cple_no_kids," &
         "hcomp_one_family_only_cohabiting_cple_one_dep_child, hcomp_one_family_only_cohabiting_cple_two_or_more_dep_kids, hcomp_one_family_only_cohabiting_cple_all_kids_non_dep, hcomp_one_family_only_lone_parent_total, hcomp_one_family_only_lone_parent_one_dep_child, hcomp_one_family_only_lone_parent_two_or_more_dep_kids, hcomp_one_family_only_lone_parent_all_kids_non_dep, hcomp_other_total, hcomp_other_with_one_dep_child, hcomp_other_with_two_or_more_dep_kids," &
         "hcomp_other_all_full_time_students, hcomp_other_all_aged_65_and_over, hcomp_other_other, number_of_rooms_all_categories_number_of_rooms, number_of_rooms_1_room, number_of_rooms_2_rooms, number_of_rooms_3_rooms, number_of_rooms_4_rooms, number_of_rooms_5_rooms, number_of_rooms_6_rooms," &
         "number_of_rooms_7_rooms, number_of_rooms_8_rooms, number_of_rooms_9_or_more_rooms, residence_all_categories_residence_type, residence_lives_in_a_household, residence_lives_in_a_communal_establishment, residence_communal_establishments_with_persons_sleeping_rough, tenure_all_categories_tenure, tenure_owned_total, tenure_owned_owned_outright," &
         "tenure_owned_owned_with_a_mortgage_or_loan, tenure_shared_ownership_part_owned_and_part_rented, tenure_social_rented_total, tenure_social_rented_rented_from_council_local_authority, tenure_social_rented_other_social_rented, tenure_private_rented_total, tenure_private_rented_private_landlord_or_letting_agency, tenure_private_rented_employer_of_a_household_member, tenure_private_rented_relative_or_friend_of_household, tenure_private_rented_other," &
         "tenure_living_rent_free, occupation_all_categories_occupation, occupation_1_managers_directors_and_senior_officials, occupation_2_professional_occupations, occupation_3_associate_professional_and_technical_occupations, occupation_4_administrative_and_secretarial_occupations, occupation_5_skilled_trades_occupations, occupation_6_caring_leisure_and_other_service_occupations, occupation_7_sales_and_customer_service_occupations, occupation_8_process_plant_and_machine_operatives," &
         "occupation_9_elementary_occupations, income_support_people_claiming_benefit, income_support_average_weekly_payment, jsa_total, pension_credits_number_of_claimants, pension_credits_number_of_beneficiaries, pension_credits_average_weekly_payment, out_of_work_families, out_of_work_children, wtc_and_ctc_families," &
         "wtc_and_ctc_children, ctc_only_families, ctc_only_children, childcare_element, credits_no_children, credits_total_families " &
         " from target_candidates " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into target_candidates (" &
         "id, code, edition, frs_region, hb_total, hb_social_rented_sector, hb_private_rented_sector, hb_passported, hb_non_passported, ct_all," &
         "ct_passported, ct_non_passported, genders_all_usual_residents, genders_males, genders_females, genders_lives_in_a_household, genders_lives_in_a_communal_establishment, genders_schoolchild_or_student_non_term_time_address, age_ranges_all_categories_age, age_ranges_age_under_1," &
         "age_ranges_age_1, age_ranges_age_2, age_ranges_age_3, age_ranges_age_4, age_ranges_age_5, age_ranges_age_6, age_ranges_age_7, age_ranges_age_8, age_ranges_age_9, age_ranges_age_10," &
         "age_ranges_age_11, age_ranges_age_12, age_ranges_age_13, age_ranges_age_14, age_ranges_age_15, age_ranges_age_16, age_ranges_age_17, age_ranges_age_18, age_ranges_age_19, age_ranges_age_20," &
         "age_ranges_age_21, age_ranges_age_22, age_ranges_age_23, age_ranges_age_24, age_ranges_age_25, age_ranges_age_26, age_ranges_age_27, age_ranges_age_28, age_ranges_age_29, age_ranges_age_30," &
         "age_ranges_age_31, age_ranges_age_32, age_ranges_age_33, age_ranges_age_34, age_ranges_age_35, age_ranges_age_36, age_ranges_age_37, age_ranges_age_38, age_ranges_age_39, age_ranges_age_40," &
         "age_ranges_age_41, age_ranges_age_42, age_ranges_age_43, age_ranges_age_44, age_ranges_age_45, age_ranges_age_46, age_ranges_age_47, age_ranges_age_48, age_ranges_age_49, age_ranges_age_50," &
         "age_ranges_age_51, age_ranges_age_52, age_ranges_age_53, age_ranges_age_54, age_ranges_age_55, age_ranges_age_56, age_ranges_age_57, age_ranges_age_58, age_ranges_age_59, age_ranges_age_60," &
         "age_ranges_age_61, age_ranges_age_62, age_ranges_age_63, age_ranges_age_64, age_ranges_age_65, age_ranges_age_66, age_ranges_age_67, age_ranges_age_68, age_ranges_age_69, age_ranges_age_70," &
         "age_ranges_age_71, age_ranges_age_72, age_ranges_age_73, age_ranges_age_74, age_ranges_age_75, age_ranges_age_76, age_ranges_age_77, age_ranges_age_78, age_ranges_age_79, age_ranges_age_80," &
         "age_ranges_age_81, age_ranges_age_82, age_ranges_age_83, age_ranges_age_84, age_ranges_age_85, age_ranges_age_86, age_ranges_age_87, age_ranges_age_88, age_ranges_age_89, age_ranges_age_90," &
         "age_ranges_age_91, age_ranges_age_92, age_ranges_age_93, age_ranges_age_94, age_ranges_age_95, age_ranges_age_96, age_ranges_age_97, age_ranges_age_98, age_ranges_age_99, age_ranges_age_100_and_over," &
         "accom_all_categories_accommodation_type, accom_unshared_total, accom_unshared_whole_house_or_bungalow_total, accom_unshared_whole_house_or_bungalow_detached, accom_unshared_whole_house_or_bungalow_semi_detached, accom_unshared_whole_house_or_bungalow_terraced, accom_unshared_flat_maisonette_or_apartment_total, accom_unshared_flat_etc_purpose_built_flats_or_tenement, accom_unshared_flat_etc_part_of_a_converted_or_shared_house, accom_unshared_flat_etc_in_commercial_building," &
         "accom_unshared_caravan_etc, accom_shared, ec_act_all_categories_economic_activity, ec_act_active_total, ec_act_active_employee_part_time, ec_act_active_employee_full_time, ec_act_active_self_employed_with_employees_part_time, ec_act_active_self_employed_with_employees_full_time, ec_act_active_self_employed_without_employees_part_time, ec_act_active_self_employed_without_employees_full_time," &
         "ec_act_active_unemployed, ec_act_active_full_time_student, ec_act_inactive_total, ec_act_inactive_retired, ec_act_inactive_student_including_full_time_students, ec_act_inactive_looking_after_home_or_family, ec_act_inactive_long_term_sick_or_disabled, ec_act_inactive_other, ethgrp_all_categories_ethnic_group, ethgrp_white," &
         "ethgrp_white_english_welsh_scottish_northern_irish_british, ethgrp_white_irish, ethgrp_white_gypsy_or_irish_traveller, ethgrp_white_other_white, ethgrp_mixed, ethgrp_mixed_multiple_ethnic_group_white_and_black_caribbean, ethgrp_mixed_multiple_ethnic_group_white_and_black_african, ethgrp_mixed_multiple_ethnic_group_white_and_asian, ethgrp_mixed_multiple_ethnic_group_other_mixed, ethgrp_asian," &
         "ethgrp_asian_asian_british_indian, ethgrp_asian_asian_british_pakistani, ethgrp_asian_asian_british_bangladeshi, ethgrp_asian_asian_british_chinese, ethgrp_asian_asian_british_other_asian, ethgrp_black, ethgrp_black_african_caribbean_black_british_african, ethgrp_black_african_caribbean_black_british_caribbean, ethgrp_black_african_caribbean_black_british_other_black, ethgrp_other," &
         "ethgrp_other_ethnic_group_arab, ethgrp_other_ethnic_group_any_other_ethnic_group, hcomp_all_categories_household_composition, hcomp_one_person_household_total, hcomp_one_person_household_aged_65_and_over, hcomp_one_person_household_other, hcomp_one_family_only_total, hcomp_one_family_only_all_aged_65_and_over, hcomp_one_family_only_married_cple_total, hcomp_one_family_only_married_cple_no_kids," &
         "hcomp_one_family_only_married_cple_one_dep_child, hcomp_one_family_only_married_cple_two_or_more_dep_kids, hcomp_one_family_only_married_cple_all_kids_non_dep, hcomp_one_family_only_same_sex_civ_part_cple_total, hcomp_one_family_only_same_sex_civ_part_cple_no_kids, hcomp_same_sex_civ_part_cple_one_dep_child, hcomp_same_sex_civ_part_cple_two_plus_dep_kids, hcomp_one_family_only_same_sex_civ_part_cple_all_kids_non_dep, hcomp_one_family_only_cohabiting_cple_total, hcomp_one_family_only_cohabiting_cple_no_kids," &
         "hcomp_one_family_only_cohabiting_cple_one_dep_child, hcomp_one_family_only_cohabiting_cple_two_or_more_dep_kids, hcomp_one_family_only_cohabiting_cple_all_kids_non_dep, hcomp_one_family_only_lone_parent_total, hcomp_one_family_only_lone_parent_one_dep_child, hcomp_one_family_only_lone_parent_two_or_more_dep_kids, hcomp_one_family_only_lone_parent_all_kids_non_dep, hcomp_other_total, hcomp_other_with_one_dep_child, hcomp_other_with_two_or_more_dep_kids," &
         "hcomp_other_all_full_time_students, hcomp_other_all_aged_65_and_over, hcomp_other_other, number_of_rooms_all_categories_number_of_rooms, number_of_rooms_1_room, number_of_rooms_2_rooms, number_of_rooms_3_rooms, number_of_rooms_4_rooms, number_of_rooms_5_rooms, number_of_rooms_6_rooms," &
         "number_of_rooms_7_rooms, number_of_rooms_8_rooms, number_of_rooms_9_or_more_rooms, residence_all_categories_residence_type, residence_lives_in_a_household, residence_lives_in_a_communal_establishment, residence_communal_establishments_with_persons_sleeping_rough, tenure_all_categories_tenure, tenure_owned_total, tenure_owned_owned_outright," &
         "tenure_owned_owned_with_a_mortgage_or_loan, tenure_shared_ownership_part_owned_and_part_rented, tenure_social_rented_total, tenure_social_rented_rented_from_council_local_authority, tenure_social_rented_other_social_rented, tenure_private_rented_total, tenure_private_rented_private_landlord_or_letting_agency, tenure_private_rented_employer_of_a_household_member, tenure_private_rented_relative_or_friend_of_household, tenure_private_rented_other," &
         "tenure_living_rent_free, occupation_all_categories_occupation, occupation_1_managers_directors_and_senior_officials, occupation_2_professional_occupations, occupation_3_associate_professional_and_technical_occupations, occupation_4_administrative_and_secretarial_occupations, occupation_5_skilled_trades_occupations, occupation_6_caring_leisure_and_other_service_occupations, occupation_7_sales_and_customer_service_occupations, occupation_8_process_plant_and_machine_operatives," &
         "occupation_9_elementary_occupations, income_support_people_claiming_benefit, income_support_average_weekly_payment, jsa_total, pension_credits_number_of_claimants, pension_credits_number_of_beneficiaries, pension_credits_average_weekly_payment, out_of_work_families, out_of_work_children, wtc_and_ctc_families," &
         "wtc_and_ctc_children, ctc_only_families, ctc_only_children, childcare_element, credits_no_children, credits_total_families " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from target_candidates ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update target_candidates set  ";
   
   
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
   -- Next highest avaiable value of Id - useful for saving  
   --
   function Next_Free_Id( connection : Database_Connection := null) return Integer is
      query      : constant String := "select max( id ) from target_candidates";
      cursor     : gse.Forward_Cursor;
      ai         : Integer := 0;
      ps : gse.Prepared_Statement;
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

      ps := gse.Prepare( query, On_Server => True );
      cursor.Fetch( local_connection, ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0 );
      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai+1;
   end Next_Free_Id;


   -- 
   -- Next highest avaiable value of Edition - useful for saving  
   --
   function Next_Free_Edition( connection : Database_Connection := null) return Integer is
      query      : constant String := "select max( edition ) from target_candidates";
      cursor     : gse.Forward_Cursor;
      ai         : Integer := 0;
      ps : gse.Prepared_Statement;
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

      ps := gse.Prepare( query, On_Server => True );
      cursor.Fetch( local_connection, ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0 );
      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai+1;
   end Next_Free_Edition;



   --
   -- returns true if the primary key parts of Target_Candidates_Type match the defaults in La_Data_Data.Null_Target_Candidates_Type
   --
   --
   -- Does this Target_Candidates_Type equal the default La_Data_Data.Null_Target_Candidates_Type ?
   --
   function Is_Null( target_candidates : La_Data_Data.Target_Candidates_Type ) return Boolean is
   use La_Data_Data;
   begin
      return target_candidates = La_Data_Data.Null_Target_Candidates_Type;
   end Is_Null;


   
   --
   -- returns the single Target_Candidates_Type matching the primary key fields, or the La_Data_Data.Null_Target_Candidates_Type record
   -- if no such record exists
   --
   function Retrieve_By_PK( Id : Integer; Code : Unbounded_String; Edition : Integer; connection : Database_Connection := null ) return La_Data_Data.Target_Candidates_Type is
      l : La_Data_Data.Target_Candidates_Type_List.Vector;
      target_candidates : La_Data_Data.Target_Candidates_Type;
      c : d.Criteria;
   begin      
      Add_Id( c, Id );
      Add_Code( c, Code );
      Add_Edition( c, Edition );
      l := Retrieve( c, connection );
      if( not La_Data_Data.Target_Candidates_Type_List.is_empty( l ) ) then
         target_candidates := La_Data_Data.Target_Candidates_Type_List.First_Element( l );
      else
         target_candidates := La_Data_Data.Null_Target_Candidates_Type;
      end if;
      return target_candidates;
   end Retrieve_By_PK;

   
   --
   -- Retrieves a list of La_Data_Data.Target_Candidates_Type matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return La_Data_Data.Target_Candidates_Type_List.Vector is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of La_Data_Data.Target_Candidates_Type retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return La_Data_Data.Target_Candidates_Type_List.Vector is
      l : La_Data_Data.Target_Candidates_Type_List.Vector;
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
           target_candidates : La_Data_Data.Target_Candidates_Type;
         begin
            if not gse.Is_Null( cursor, 0 )then
               target_candidates.Id := Integer( gse.Integer_Value( cursor, 0 ));
            end if;
            if not gse.Is_Null( cursor, 1 )then
               target_candidates.Code:= To_Unbounded_String( gse.Value( cursor, 1 ));
            end if;
            if not gse.Is_Null( cursor, 2 )then
               target_candidates.Edition := Integer( gse.Integer_Value( cursor, 2 ));
            end if;
            if not gse.Is_Null( cursor, 3 )then
               target_candidates.Frs_Region := Integer( gse.Integer_Value( cursor, 3 ));
            end if;
            if not gse.Is_Null( cursor, 4 )then
               target_candidates.Hb_Total:= Real( gse.Float_Value( cursor, 4 ));
            end if;
            if not gse.Is_Null( cursor, 5 )then
               target_candidates.Hb_Social_Rented_Sector:= Real( gse.Float_Value( cursor, 5 ));
            end if;
            if not gse.Is_Null( cursor, 6 )then
               target_candidates.Hb_Private_Rented_Sector:= Real( gse.Float_Value( cursor, 6 ));
            end if;
            if not gse.Is_Null( cursor, 7 )then
               target_candidates.Hb_Passported:= Real( gse.Float_Value( cursor, 7 ));
            end if;
            if not gse.Is_Null( cursor, 8 )then
               target_candidates.Hb_Non_Passported:= Real( gse.Float_Value( cursor, 8 ));
            end if;
            if not gse.Is_Null( cursor, 9 )then
               target_candidates.Ct_All:= Real( gse.Float_Value( cursor, 9 ));
            end if;
            if not gse.Is_Null( cursor, 10 )then
               target_candidates.Ct_Passported:= Real( gse.Float_Value( cursor, 10 ));
            end if;
            if not gse.Is_Null( cursor, 11 )then
               target_candidates.Ct_Non_Passported:= Real( gse.Float_Value( cursor, 11 ));
            end if;
            if not gse.Is_Null( cursor, 12 )then
               target_candidates.Genders_All_Usual_Residents:= Real( gse.Float_Value( cursor, 12 ));
            end if;
            if not gse.Is_Null( cursor, 13 )then
               target_candidates.Genders_Males:= Real( gse.Float_Value( cursor, 13 ));
            end if;
            if not gse.Is_Null( cursor, 14 )then
               target_candidates.Genders_Females:= Real( gse.Float_Value( cursor, 14 ));
            end if;
            if not gse.Is_Null( cursor, 15 )then
               target_candidates.Genders_Lives_In_A_Household:= Real( gse.Float_Value( cursor, 15 ));
            end if;
            if not gse.Is_Null( cursor, 16 )then
               target_candidates.Genders_Lives_In_A_Communal_Establishment:= Real( gse.Float_Value( cursor, 16 ));
            end if;
            if not gse.Is_Null( cursor, 17 )then
               target_candidates.Genders_Schoolchild_Or_Student_Non_Term_Time_Address:= Real( gse.Float_Value( cursor, 17 ));
            end if;
            if not gse.Is_Null( cursor, 18 )then
               target_candidates.Age_Ranges_All_Categories_Age:= Real( gse.Float_Value( cursor, 18 ));
            end if;
            if not gse.Is_Null( cursor, 19 )then
               target_candidates.Age_Ranges_Age_Under_1:= Real( gse.Float_Value( cursor, 19 ));
            end if;
            if not gse.Is_Null( cursor, 20 )then
               target_candidates.Age_Ranges_Age_1:= Real( gse.Float_Value( cursor, 20 ));
            end if;
            if not gse.Is_Null( cursor, 21 )then
               target_candidates.Age_Ranges_Age_2:= Real( gse.Float_Value( cursor, 21 ));
            end if;
            if not gse.Is_Null( cursor, 22 )then
               target_candidates.Age_Ranges_Age_3:= Real( gse.Float_Value( cursor, 22 ));
            end if;
            if not gse.Is_Null( cursor, 23 )then
               target_candidates.Age_Ranges_Age_4:= Real( gse.Float_Value( cursor, 23 ));
            end if;
            if not gse.Is_Null( cursor, 24 )then
               target_candidates.Age_Ranges_Age_5:= Real( gse.Float_Value( cursor, 24 ));
            end if;
            if not gse.Is_Null( cursor, 25 )then
               target_candidates.Age_Ranges_Age_6:= Real( gse.Float_Value( cursor, 25 ));
            end if;
            if not gse.Is_Null( cursor, 26 )then
               target_candidates.Age_Ranges_Age_7:= Real( gse.Float_Value( cursor, 26 ));
            end if;
            if not gse.Is_Null( cursor, 27 )then
               target_candidates.Age_Ranges_Age_8:= Real( gse.Float_Value( cursor, 27 ));
            end if;
            if not gse.Is_Null( cursor, 28 )then
               target_candidates.Age_Ranges_Age_9:= Real( gse.Float_Value( cursor, 28 ));
            end if;
            if not gse.Is_Null( cursor, 29 )then
               target_candidates.Age_Ranges_Age_10:= Real( gse.Float_Value( cursor, 29 ));
            end if;
            if not gse.Is_Null( cursor, 30 )then
               target_candidates.Age_Ranges_Age_11:= Real( gse.Float_Value( cursor, 30 ));
            end if;
            if not gse.Is_Null( cursor, 31 )then
               target_candidates.Age_Ranges_Age_12:= Real( gse.Float_Value( cursor, 31 ));
            end if;
            if not gse.Is_Null( cursor, 32 )then
               target_candidates.Age_Ranges_Age_13:= Real( gse.Float_Value( cursor, 32 ));
            end if;
            if not gse.Is_Null( cursor, 33 )then
               target_candidates.Age_Ranges_Age_14:= Real( gse.Float_Value( cursor, 33 ));
            end if;
            if not gse.Is_Null( cursor, 34 )then
               target_candidates.Age_Ranges_Age_15:= Real( gse.Float_Value( cursor, 34 ));
            end if;
            if not gse.Is_Null( cursor, 35 )then
               target_candidates.Age_Ranges_Age_16:= Real( gse.Float_Value( cursor, 35 ));
            end if;
            if not gse.Is_Null( cursor, 36 )then
               target_candidates.Age_Ranges_Age_17:= Real( gse.Float_Value( cursor, 36 ));
            end if;
            if not gse.Is_Null( cursor, 37 )then
               target_candidates.Age_Ranges_Age_18:= Real( gse.Float_Value( cursor, 37 ));
            end if;
            if not gse.Is_Null( cursor, 38 )then
               target_candidates.Age_Ranges_Age_19:= Real( gse.Float_Value( cursor, 38 ));
            end if;
            if not gse.Is_Null( cursor, 39 )then
               target_candidates.Age_Ranges_Age_20:= Real( gse.Float_Value( cursor, 39 ));
            end if;
            if not gse.Is_Null( cursor, 40 )then
               target_candidates.Age_Ranges_Age_21:= Real( gse.Float_Value( cursor, 40 ));
            end if;
            if not gse.Is_Null( cursor, 41 )then
               target_candidates.Age_Ranges_Age_22:= Real( gse.Float_Value( cursor, 41 ));
            end if;
            if not gse.Is_Null( cursor, 42 )then
               target_candidates.Age_Ranges_Age_23:= Real( gse.Float_Value( cursor, 42 ));
            end if;
            if not gse.Is_Null( cursor, 43 )then
               target_candidates.Age_Ranges_Age_24:= Real( gse.Float_Value( cursor, 43 ));
            end if;
            if not gse.Is_Null( cursor, 44 )then
               target_candidates.Age_Ranges_Age_25:= Real( gse.Float_Value( cursor, 44 ));
            end if;
            if not gse.Is_Null( cursor, 45 )then
               target_candidates.Age_Ranges_Age_26:= Real( gse.Float_Value( cursor, 45 ));
            end if;
            if not gse.Is_Null( cursor, 46 )then
               target_candidates.Age_Ranges_Age_27:= Real( gse.Float_Value( cursor, 46 ));
            end if;
            if not gse.Is_Null( cursor, 47 )then
               target_candidates.Age_Ranges_Age_28:= Real( gse.Float_Value( cursor, 47 ));
            end if;
            if not gse.Is_Null( cursor, 48 )then
               target_candidates.Age_Ranges_Age_29:= Real( gse.Float_Value( cursor, 48 ));
            end if;
            if not gse.Is_Null( cursor, 49 )then
               target_candidates.Age_Ranges_Age_30:= Real( gse.Float_Value( cursor, 49 ));
            end if;
            if not gse.Is_Null( cursor, 50 )then
               target_candidates.Age_Ranges_Age_31:= Real( gse.Float_Value( cursor, 50 ));
            end if;
            if not gse.Is_Null( cursor, 51 )then
               target_candidates.Age_Ranges_Age_32:= Real( gse.Float_Value( cursor, 51 ));
            end if;
            if not gse.Is_Null( cursor, 52 )then
               target_candidates.Age_Ranges_Age_33:= Real( gse.Float_Value( cursor, 52 ));
            end if;
            if not gse.Is_Null( cursor, 53 )then
               target_candidates.Age_Ranges_Age_34:= Real( gse.Float_Value( cursor, 53 ));
            end if;
            if not gse.Is_Null( cursor, 54 )then
               target_candidates.Age_Ranges_Age_35:= Real( gse.Float_Value( cursor, 54 ));
            end if;
            if not gse.Is_Null( cursor, 55 )then
               target_candidates.Age_Ranges_Age_36:= Real( gse.Float_Value( cursor, 55 ));
            end if;
            if not gse.Is_Null( cursor, 56 )then
               target_candidates.Age_Ranges_Age_37:= Real( gse.Float_Value( cursor, 56 ));
            end if;
            if not gse.Is_Null( cursor, 57 )then
               target_candidates.Age_Ranges_Age_38:= Real( gse.Float_Value( cursor, 57 ));
            end if;
            if not gse.Is_Null( cursor, 58 )then
               target_candidates.Age_Ranges_Age_39:= Real( gse.Float_Value( cursor, 58 ));
            end if;
            if not gse.Is_Null( cursor, 59 )then
               target_candidates.Age_Ranges_Age_40:= Real( gse.Float_Value( cursor, 59 ));
            end if;
            if not gse.Is_Null( cursor, 60 )then
               target_candidates.Age_Ranges_Age_41:= Real( gse.Float_Value( cursor, 60 ));
            end if;
            if not gse.Is_Null( cursor, 61 )then
               target_candidates.Age_Ranges_Age_42:= Real( gse.Float_Value( cursor, 61 ));
            end if;
            if not gse.Is_Null( cursor, 62 )then
               target_candidates.Age_Ranges_Age_43:= Real( gse.Float_Value( cursor, 62 ));
            end if;
            if not gse.Is_Null( cursor, 63 )then
               target_candidates.Age_Ranges_Age_44:= Real( gse.Float_Value( cursor, 63 ));
            end if;
            if not gse.Is_Null( cursor, 64 )then
               target_candidates.Age_Ranges_Age_45:= Real( gse.Float_Value( cursor, 64 ));
            end if;
            if not gse.Is_Null( cursor, 65 )then
               target_candidates.Age_Ranges_Age_46:= Real( gse.Float_Value( cursor, 65 ));
            end if;
            if not gse.Is_Null( cursor, 66 )then
               target_candidates.Age_Ranges_Age_47:= Real( gse.Float_Value( cursor, 66 ));
            end if;
            if not gse.Is_Null( cursor, 67 )then
               target_candidates.Age_Ranges_Age_48:= Real( gse.Float_Value( cursor, 67 ));
            end if;
            if not gse.Is_Null( cursor, 68 )then
               target_candidates.Age_Ranges_Age_49:= Real( gse.Float_Value( cursor, 68 ));
            end if;
            if not gse.Is_Null( cursor, 69 )then
               target_candidates.Age_Ranges_Age_50:= Real( gse.Float_Value( cursor, 69 ));
            end if;
            if not gse.Is_Null( cursor, 70 )then
               target_candidates.Age_Ranges_Age_51:= Real( gse.Float_Value( cursor, 70 ));
            end if;
            if not gse.Is_Null( cursor, 71 )then
               target_candidates.Age_Ranges_Age_52:= Real( gse.Float_Value( cursor, 71 ));
            end if;
            if not gse.Is_Null( cursor, 72 )then
               target_candidates.Age_Ranges_Age_53:= Real( gse.Float_Value( cursor, 72 ));
            end if;
            if not gse.Is_Null( cursor, 73 )then
               target_candidates.Age_Ranges_Age_54:= Real( gse.Float_Value( cursor, 73 ));
            end if;
            if not gse.Is_Null( cursor, 74 )then
               target_candidates.Age_Ranges_Age_55:= Real( gse.Float_Value( cursor, 74 ));
            end if;
            if not gse.Is_Null( cursor, 75 )then
               target_candidates.Age_Ranges_Age_56:= Real( gse.Float_Value( cursor, 75 ));
            end if;
            if not gse.Is_Null( cursor, 76 )then
               target_candidates.Age_Ranges_Age_57:= Real( gse.Float_Value( cursor, 76 ));
            end if;
            if not gse.Is_Null( cursor, 77 )then
               target_candidates.Age_Ranges_Age_58:= Real( gse.Float_Value( cursor, 77 ));
            end if;
            if not gse.Is_Null( cursor, 78 )then
               target_candidates.Age_Ranges_Age_59:= Real( gse.Float_Value( cursor, 78 ));
            end if;
            if not gse.Is_Null( cursor, 79 )then
               target_candidates.Age_Ranges_Age_60:= Real( gse.Float_Value( cursor, 79 ));
            end if;
            if not gse.Is_Null( cursor, 80 )then
               target_candidates.Age_Ranges_Age_61:= Real( gse.Float_Value( cursor, 80 ));
            end if;
            if not gse.Is_Null( cursor, 81 )then
               target_candidates.Age_Ranges_Age_62:= Real( gse.Float_Value( cursor, 81 ));
            end if;
            if not gse.Is_Null( cursor, 82 )then
               target_candidates.Age_Ranges_Age_63:= Real( gse.Float_Value( cursor, 82 ));
            end if;
            if not gse.Is_Null( cursor, 83 )then
               target_candidates.Age_Ranges_Age_64:= Real( gse.Float_Value( cursor, 83 ));
            end if;
            if not gse.Is_Null( cursor, 84 )then
               target_candidates.Age_Ranges_Age_65:= Real( gse.Float_Value( cursor, 84 ));
            end if;
            if not gse.Is_Null( cursor, 85 )then
               target_candidates.Age_Ranges_Age_66:= Real( gse.Float_Value( cursor, 85 ));
            end if;
            if not gse.Is_Null( cursor, 86 )then
               target_candidates.Age_Ranges_Age_67:= Real( gse.Float_Value( cursor, 86 ));
            end if;
            if not gse.Is_Null( cursor, 87 )then
               target_candidates.Age_Ranges_Age_68:= Real( gse.Float_Value( cursor, 87 ));
            end if;
            if not gse.Is_Null( cursor, 88 )then
               target_candidates.Age_Ranges_Age_69:= Real( gse.Float_Value( cursor, 88 ));
            end if;
            if not gse.Is_Null( cursor, 89 )then
               target_candidates.Age_Ranges_Age_70:= Real( gse.Float_Value( cursor, 89 ));
            end if;
            if not gse.Is_Null( cursor, 90 )then
               target_candidates.Age_Ranges_Age_71:= Real( gse.Float_Value( cursor, 90 ));
            end if;
            if not gse.Is_Null( cursor, 91 )then
               target_candidates.Age_Ranges_Age_72:= Real( gse.Float_Value( cursor, 91 ));
            end if;
            if not gse.Is_Null( cursor, 92 )then
               target_candidates.Age_Ranges_Age_73:= Real( gse.Float_Value( cursor, 92 ));
            end if;
            if not gse.Is_Null( cursor, 93 )then
               target_candidates.Age_Ranges_Age_74:= Real( gse.Float_Value( cursor, 93 ));
            end if;
            if not gse.Is_Null( cursor, 94 )then
               target_candidates.Age_Ranges_Age_75:= Real( gse.Float_Value( cursor, 94 ));
            end if;
            if not gse.Is_Null( cursor, 95 )then
               target_candidates.Age_Ranges_Age_76:= Real( gse.Float_Value( cursor, 95 ));
            end if;
            if not gse.Is_Null( cursor, 96 )then
               target_candidates.Age_Ranges_Age_77:= Real( gse.Float_Value( cursor, 96 ));
            end if;
            if not gse.Is_Null( cursor, 97 )then
               target_candidates.Age_Ranges_Age_78:= Real( gse.Float_Value( cursor, 97 ));
            end if;
            if not gse.Is_Null( cursor, 98 )then
               target_candidates.Age_Ranges_Age_79:= Real( gse.Float_Value( cursor, 98 ));
            end if;
            if not gse.Is_Null( cursor, 99 )then
               target_candidates.Age_Ranges_Age_80:= Real( gse.Float_Value( cursor, 99 ));
            end if;
            if not gse.Is_Null( cursor, 100 )then
               target_candidates.Age_Ranges_Age_81:= Real( gse.Float_Value( cursor, 100 ));
            end if;
            if not gse.Is_Null( cursor, 101 )then
               target_candidates.Age_Ranges_Age_82:= Real( gse.Float_Value( cursor, 101 ));
            end if;
            if not gse.Is_Null( cursor, 102 )then
               target_candidates.Age_Ranges_Age_83:= Real( gse.Float_Value( cursor, 102 ));
            end if;
            if not gse.Is_Null( cursor, 103 )then
               target_candidates.Age_Ranges_Age_84:= Real( gse.Float_Value( cursor, 103 ));
            end if;
            if not gse.Is_Null( cursor, 104 )then
               target_candidates.Age_Ranges_Age_85:= Real( gse.Float_Value( cursor, 104 ));
            end if;
            if not gse.Is_Null( cursor, 105 )then
               target_candidates.Age_Ranges_Age_86:= Real( gse.Float_Value( cursor, 105 ));
            end if;
            if not gse.Is_Null( cursor, 106 )then
               target_candidates.Age_Ranges_Age_87:= Real( gse.Float_Value( cursor, 106 ));
            end if;
            if not gse.Is_Null( cursor, 107 )then
               target_candidates.Age_Ranges_Age_88:= Real( gse.Float_Value( cursor, 107 ));
            end if;
            if not gse.Is_Null( cursor, 108 )then
               target_candidates.Age_Ranges_Age_89:= Real( gse.Float_Value( cursor, 108 ));
            end if;
            if not gse.Is_Null( cursor, 109 )then
               target_candidates.Age_Ranges_Age_90:= Real( gse.Float_Value( cursor, 109 ));
            end if;
            if not gse.Is_Null( cursor, 110 )then
               target_candidates.Age_Ranges_Age_91:= Real( gse.Float_Value( cursor, 110 ));
            end if;
            if not gse.Is_Null( cursor, 111 )then
               target_candidates.Age_Ranges_Age_92:= Real( gse.Float_Value( cursor, 111 ));
            end if;
            if not gse.Is_Null( cursor, 112 )then
               target_candidates.Age_Ranges_Age_93:= Real( gse.Float_Value( cursor, 112 ));
            end if;
            if not gse.Is_Null( cursor, 113 )then
               target_candidates.Age_Ranges_Age_94:= Real( gse.Float_Value( cursor, 113 ));
            end if;
            if not gse.Is_Null( cursor, 114 )then
               target_candidates.Age_Ranges_Age_95:= Real( gse.Float_Value( cursor, 114 ));
            end if;
            if not gse.Is_Null( cursor, 115 )then
               target_candidates.Age_Ranges_Age_96:= Real( gse.Float_Value( cursor, 115 ));
            end if;
            if not gse.Is_Null( cursor, 116 )then
               target_candidates.Age_Ranges_Age_97:= Real( gse.Float_Value( cursor, 116 ));
            end if;
            if not gse.Is_Null( cursor, 117 )then
               target_candidates.Age_Ranges_Age_98:= Real( gse.Float_Value( cursor, 117 ));
            end if;
            if not gse.Is_Null( cursor, 118 )then
               target_candidates.Age_Ranges_Age_99:= Real( gse.Float_Value( cursor, 118 ));
            end if;
            if not gse.Is_Null( cursor, 119 )then
               target_candidates.Age_Ranges_Age_100_And_Over:= Real( gse.Float_Value( cursor, 119 ));
            end if;
            if not gse.Is_Null( cursor, 120 )then
               target_candidates.Accom_All_Categories_Accommodation_Type:= Real( gse.Float_Value( cursor, 120 ));
            end if;
            if not gse.Is_Null( cursor, 121 )then
               target_candidates.Accom_Unshared_Total:= Real( gse.Float_Value( cursor, 121 ));
            end if;
            if not gse.Is_Null( cursor, 122 )then
               target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Total:= Real( gse.Float_Value( cursor, 122 ));
            end if;
            if not gse.Is_Null( cursor, 123 )then
               target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Detached:= Real( gse.Float_Value( cursor, 123 ));
            end if;
            if not gse.Is_Null( cursor, 124 )then
               target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached:= Real( gse.Float_Value( cursor, 124 ));
            end if;
            if not gse.Is_Null( cursor, 125 )then
               target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Terraced:= Real( gse.Float_Value( cursor, 125 ));
            end if;
            if not gse.Is_Null( cursor, 126 )then
               target_candidates.Accom_Unshared_Flat_Maisonette_Or_Apartment_Total:= Real( gse.Float_Value( cursor, 126 ));
            end if;
            if not gse.Is_Null( cursor, 127 )then
               target_candidates.Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement:= Real( gse.Float_Value( cursor, 127 ));
            end if;
            if not gse.Is_Null( cursor, 128 )then
               target_candidates.Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House:= Real( gse.Float_Value( cursor, 128 ));
            end if;
            if not gse.Is_Null( cursor, 129 )then
               target_candidates.Accom_Unshared_Flat_Etc_In_Commercial_Building:= Real( gse.Float_Value( cursor, 129 ));
            end if;
            if not gse.Is_Null( cursor, 130 )then
               target_candidates.Accom_Unshared_Caravan_Etc:= Real( gse.Float_Value( cursor, 130 ));
            end if;
            if not gse.Is_Null( cursor, 131 )then
               target_candidates.Accom_Shared:= Real( gse.Float_Value( cursor, 131 ));
            end if;
            if not gse.Is_Null( cursor, 132 )then
               target_candidates.Ec_Act_All_Categories_Economic_Activity:= Real( gse.Float_Value( cursor, 132 ));
            end if;
            if not gse.Is_Null( cursor, 133 )then
               target_candidates.Ec_Act_Active_Total:= Real( gse.Float_Value( cursor, 133 ));
            end if;
            if not gse.Is_Null( cursor, 134 )then
               target_candidates.Ec_Act_Active_Employee_Part_Time:= Real( gse.Float_Value( cursor, 134 ));
            end if;
            if not gse.Is_Null( cursor, 135 )then
               target_candidates.Ec_Act_Active_Employee_Full_Time:= Real( gse.Float_Value( cursor, 135 ));
            end if;
            if not gse.Is_Null( cursor, 136 )then
               target_candidates.Ec_Act_Active_Self_Employed_With_Employees_Part_Time:= Real( gse.Float_Value( cursor, 136 ));
            end if;
            if not gse.Is_Null( cursor, 137 )then
               target_candidates.Ec_Act_Active_Self_Employed_With_Employees_Full_Time:= Real( gse.Float_Value( cursor, 137 ));
            end if;
            if not gse.Is_Null( cursor, 138 )then
               target_candidates.Ec_Act_Active_Self_Employed_Without_Employees_Part_Time:= Real( gse.Float_Value( cursor, 138 ));
            end if;
            if not gse.Is_Null( cursor, 139 )then
               target_candidates.Ec_Act_Active_Self_Employed_Without_Employees_Full_Time:= Real( gse.Float_Value( cursor, 139 ));
            end if;
            if not gse.Is_Null( cursor, 140 )then
               target_candidates.Ec_Act_Active_Unemployed:= Real( gse.Float_Value( cursor, 140 ));
            end if;
            if not gse.Is_Null( cursor, 141 )then
               target_candidates.Ec_Act_Active_Full_Time_Student:= Real( gse.Float_Value( cursor, 141 ));
            end if;
            if not gse.Is_Null( cursor, 142 )then
               target_candidates.Ec_Act_Inactive_Total:= Real( gse.Float_Value( cursor, 142 ));
            end if;
            if not gse.Is_Null( cursor, 143 )then
               target_candidates.Ec_Act_Inactive_Retired:= Real( gse.Float_Value( cursor, 143 ));
            end if;
            if not gse.Is_Null( cursor, 144 )then
               target_candidates.Ec_Act_Inactive_Student_Including_Full_Time_Students:= Real( gse.Float_Value( cursor, 144 ));
            end if;
            if not gse.Is_Null( cursor, 145 )then
               target_candidates.Ec_Act_Inactive_Looking_After_Home_Or_Family:= Real( gse.Float_Value( cursor, 145 ));
            end if;
            if not gse.Is_Null( cursor, 146 )then
               target_candidates.Ec_Act_Inactive_Long_Term_Sick_Or_Disabled:= Real( gse.Float_Value( cursor, 146 ));
            end if;
            if not gse.Is_Null( cursor, 147 )then
               target_candidates.Ec_Act_Inactive_Other:= Real( gse.Float_Value( cursor, 147 ));
            end if;
            if not gse.Is_Null( cursor, 148 )then
               target_candidates.Ethgrp_All_Categories_Ethnic_Group:= Real( gse.Float_Value( cursor, 148 ));
            end if;
            if not gse.Is_Null( cursor, 149 )then
               target_candidates.Ethgrp_White:= Real( gse.Float_Value( cursor, 149 ));
            end if;
            if not gse.Is_Null( cursor, 150 )then
               target_candidates.Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British:= Real( gse.Float_Value( cursor, 150 ));
            end if;
            if not gse.Is_Null( cursor, 151 )then
               target_candidates.Ethgrp_White_Irish:= Real( gse.Float_Value( cursor, 151 ));
            end if;
            if not gse.Is_Null( cursor, 152 )then
               target_candidates.Ethgrp_White_Gypsy_Or_Irish_Traveller:= Real( gse.Float_Value( cursor, 152 ));
            end if;
            if not gse.Is_Null( cursor, 153 )then
               target_candidates.Ethgrp_White_Other_White:= Real( gse.Float_Value( cursor, 153 ));
            end if;
            if not gse.Is_Null( cursor, 154 )then
               target_candidates.Ethgrp_Mixed:= Real( gse.Float_Value( cursor, 154 ));
            end if;
            if not gse.Is_Null( cursor, 155 )then
               target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean:= Real( gse.Float_Value( cursor, 155 ));
            end if;
            if not gse.Is_Null( cursor, 156 )then
               target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African:= Real( gse.Float_Value( cursor, 156 ));
            end if;
            if not gse.Is_Null( cursor, 157 )then
               target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian:= Real( gse.Float_Value( cursor, 157 ));
            end if;
            if not gse.Is_Null( cursor, 158 )then
               target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed:= Real( gse.Float_Value( cursor, 158 ));
            end if;
            if not gse.Is_Null( cursor, 159 )then
               target_candidates.Ethgrp_Asian:= Real( gse.Float_Value( cursor, 159 ));
            end if;
            if not gse.Is_Null( cursor, 160 )then
               target_candidates.Ethgrp_Asian_Asian_British_Indian:= Real( gse.Float_Value( cursor, 160 ));
            end if;
            if not gse.Is_Null( cursor, 161 )then
               target_candidates.Ethgrp_Asian_Asian_British_Pakistani:= Real( gse.Float_Value( cursor, 161 ));
            end if;
            if not gse.Is_Null( cursor, 162 )then
               target_candidates.Ethgrp_Asian_Asian_British_Bangladeshi:= Real( gse.Float_Value( cursor, 162 ));
            end if;
            if not gse.Is_Null( cursor, 163 )then
               target_candidates.Ethgrp_Asian_Asian_British_Chinese:= Real( gse.Float_Value( cursor, 163 ));
            end if;
            if not gse.Is_Null( cursor, 164 )then
               target_candidates.Ethgrp_Asian_Asian_British_Other_Asian:= Real( gse.Float_Value( cursor, 164 ));
            end if;
            if not gse.Is_Null( cursor, 165 )then
               target_candidates.Ethgrp_Black:= Real( gse.Float_Value( cursor, 165 ));
            end if;
            if not gse.Is_Null( cursor, 166 )then
               target_candidates.Ethgrp_Black_African_Caribbean_Black_British_African:= Real( gse.Float_Value( cursor, 166 ));
            end if;
            if not gse.Is_Null( cursor, 167 )then
               target_candidates.Ethgrp_Black_African_Caribbean_Black_British_Caribbean:= Real( gse.Float_Value( cursor, 167 ));
            end if;
            if not gse.Is_Null( cursor, 168 )then
               target_candidates.Ethgrp_Black_African_Caribbean_Black_British_Other_Black:= Real( gse.Float_Value( cursor, 168 ));
            end if;
            if not gse.Is_Null( cursor, 169 )then
               target_candidates.Ethgrp_Other:= Real( gse.Float_Value( cursor, 169 ));
            end if;
            if not gse.Is_Null( cursor, 170 )then
               target_candidates.Ethgrp_Other_Ethnic_Group_Arab:= Real( gse.Float_Value( cursor, 170 ));
            end if;
            if not gse.Is_Null( cursor, 171 )then
               target_candidates.Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group:= Real( gse.Float_Value( cursor, 171 ));
            end if;
            if not gse.Is_Null( cursor, 172 )then
               target_candidates.Hcomp_All_Categories_Household_Composition:= Real( gse.Float_Value( cursor, 172 ));
            end if;
            if not gse.Is_Null( cursor, 173 )then
               target_candidates.Hcomp_One_Person_Household_Total:= Real( gse.Float_Value( cursor, 173 ));
            end if;
            if not gse.Is_Null( cursor, 174 )then
               target_candidates.Hcomp_One_Person_Household_Aged_65_And_Over:= Real( gse.Float_Value( cursor, 174 ));
            end if;
            if not gse.Is_Null( cursor, 175 )then
               target_candidates.Hcomp_One_Person_Household_Other:= Real( gse.Float_Value( cursor, 175 ));
            end if;
            if not gse.Is_Null( cursor, 176 )then
               target_candidates.Hcomp_One_Family_Only_Total:= Real( gse.Float_Value( cursor, 176 ));
            end if;
            if not gse.Is_Null( cursor, 177 )then
               target_candidates.Hcomp_One_Family_Only_All_Aged_65_And_Over:= Real( gse.Float_Value( cursor, 177 ));
            end if;
            if not gse.Is_Null( cursor, 178 )then
               target_candidates.Hcomp_One_Family_Only_Married_Cple_Total:= Real( gse.Float_Value( cursor, 178 ));
            end if;
            if not gse.Is_Null( cursor, 179 )then
               target_candidates.Hcomp_One_Family_Only_Married_Cple_No_Kids:= Real( gse.Float_Value( cursor, 179 ));
            end if;
            if not gse.Is_Null( cursor, 180 )then
               target_candidates.Hcomp_One_Family_Only_Married_Cple_One_Dep_Child:= Real( gse.Float_Value( cursor, 180 ));
            end if;
            if not gse.Is_Null( cursor, 181 )then
               target_candidates.Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids:= Real( gse.Float_Value( cursor, 181 ));
            end if;
            if not gse.Is_Null( cursor, 182 )then
               target_candidates.Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep:= Real( gse.Float_Value( cursor, 182 ));
            end if;
            if not gse.Is_Null( cursor, 183 )then
               target_candidates.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total:= Real( gse.Float_Value( cursor, 183 ));
            end if;
            if not gse.Is_Null( cursor, 184 )then
               target_candidates.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids:= Real( gse.Float_Value( cursor, 184 ));
            end if;
            if not gse.Is_Null( cursor, 185 )then
               target_candidates.Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child:= Real( gse.Float_Value( cursor, 185 ));
            end if;
            if not gse.Is_Null( cursor, 186 )then
               target_candidates.Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids:= Real( gse.Float_Value( cursor, 186 ));
            end if;
            if not gse.Is_Null( cursor, 187 )then
               target_candidates.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep:= Real( gse.Float_Value( cursor, 187 ));
            end if;
            if not gse.Is_Null( cursor, 188 )then
               target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_Total:= Real( gse.Float_Value( cursor, 188 ));
            end if;
            if not gse.Is_Null( cursor, 189 )then
               target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids:= Real( gse.Float_Value( cursor, 189 ));
            end if;
            if not gse.Is_Null( cursor, 190 )then
               target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child:= Real( gse.Float_Value( cursor, 190 ));
            end if;
            if not gse.Is_Null( cursor, 191 )then
               target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids:= Real( gse.Float_Value( cursor, 191 ));
            end if;
            if not gse.Is_Null( cursor, 192 )then
               target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep:= Real( gse.Float_Value( cursor, 192 ));
            end if;
            if not gse.Is_Null( cursor, 193 )then
               target_candidates.Hcomp_One_Family_Only_Lone_Parent_Total:= Real( gse.Float_Value( cursor, 193 ));
            end if;
            if not gse.Is_Null( cursor, 194 )then
               target_candidates.Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child:= Real( gse.Float_Value( cursor, 194 ));
            end if;
            if not gse.Is_Null( cursor, 195 )then
               target_candidates.Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids:= Real( gse.Float_Value( cursor, 195 ));
            end if;
            if not gse.Is_Null( cursor, 196 )then
               target_candidates.Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep:= Real( gse.Float_Value( cursor, 196 ));
            end if;
            if not gse.Is_Null( cursor, 197 )then
               target_candidates.Hcomp_Other_Total:= Real( gse.Float_Value( cursor, 197 ));
            end if;
            if not gse.Is_Null( cursor, 198 )then
               target_candidates.Hcomp_Other_With_One_Dep_Child:= Real( gse.Float_Value( cursor, 198 ));
            end if;
            if not gse.Is_Null( cursor, 199 )then
               target_candidates.Hcomp_Other_With_Two_Or_More_Dep_Kids:= Real( gse.Float_Value( cursor, 199 ));
            end if;
            if not gse.Is_Null( cursor, 200 )then
               target_candidates.Hcomp_Other_All_Full_Time_Students:= Real( gse.Float_Value( cursor, 200 ));
            end if;
            if not gse.Is_Null( cursor, 201 )then
               target_candidates.Hcomp_Other_All_Aged_65_And_Over:= Real( gse.Float_Value( cursor, 201 ));
            end if;
            if not gse.Is_Null( cursor, 202 )then
               target_candidates.Hcomp_Other_Other:= Real( gse.Float_Value( cursor, 202 ));
            end if;
            if not gse.Is_Null( cursor, 203 )then
               target_candidates.Number_Of_Rooms_All_Categories_Number_Of_Rooms:= Real( gse.Float_Value( cursor, 203 ));
            end if;
            if not gse.Is_Null( cursor, 204 )then
               target_candidates.Number_Of_Rooms_1_Room:= Real( gse.Float_Value( cursor, 204 ));
            end if;
            if not gse.Is_Null( cursor, 205 )then
               target_candidates.Number_Of_Rooms_2_Rooms:= Real( gse.Float_Value( cursor, 205 ));
            end if;
            if not gse.Is_Null( cursor, 206 )then
               target_candidates.Number_Of_Rooms_3_Rooms:= Real( gse.Float_Value( cursor, 206 ));
            end if;
            if not gse.Is_Null( cursor, 207 )then
               target_candidates.Number_Of_Rooms_4_Rooms:= Real( gse.Float_Value( cursor, 207 ));
            end if;
            if not gse.Is_Null( cursor, 208 )then
               target_candidates.Number_Of_Rooms_5_Rooms:= Real( gse.Float_Value( cursor, 208 ));
            end if;
            if not gse.Is_Null( cursor, 209 )then
               target_candidates.Number_Of_Rooms_6_Rooms:= Real( gse.Float_Value( cursor, 209 ));
            end if;
            if not gse.Is_Null( cursor, 210 )then
               target_candidates.Number_Of_Rooms_7_Rooms:= Real( gse.Float_Value( cursor, 210 ));
            end if;
            if not gse.Is_Null( cursor, 211 )then
               target_candidates.Number_Of_Rooms_8_Rooms:= Real( gse.Float_Value( cursor, 211 ));
            end if;
            if not gse.Is_Null( cursor, 212 )then
               target_candidates.Number_Of_Rooms_9_Or_More_Rooms:= Real( gse.Float_Value( cursor, 212 ));
            end if;
            if not gse.Is_Null( cursor, 213 )then
               target_candidates.Residence_All_Categories_Residence_Type:= Real( gse.Float_Value( cursor, 213 ));
            end if;
            if not gse.Is_Null( cursor, 214 )then
               target_candidates.Residence_Lives_In_A_Household:= Real( gse.Float_Value( cursor, 214 ));
            end if;
            if not gse.Is_Null( cursor, 215 )then
               target_candidates.Residence_Lives_In_A_Communal_Establishment:= Real( gse.Float_Value( cursor, 215 ));
            end if;
            if not gse.Is_Null( cursor, 216 )then
               target_candidates.Residence_Communal_Establishments_With_Persons_Sleeping_Rough:= Real( gse.Float_Value( cursor, 216 ));
            end if;
            if not gse.Is_Null( cursor, 217 )then
               target_candidates.Tenure_All_Categories_Tenure:= Real( gse.Float_Value( cursor, 217 ));
            end if;
            if not gse.Is_Null( cursor, 218 )then
               target_candidates.Tenure_Owned_Total:= Real( gse.Float_Value( cursor, 218 ));
            end if;
            if not gse.Is_Null( cursor, 219 )then
               target_candidates.Tenure_Owned_Owned_Outright:= Real( gse.Float_Value( cursor, 219 ));
            end if;
            if not gse.Is_Null( cursor, 220 )then
               target_candidates.Tenure_Owned_Owned_With_A_Mortgage_Or_Loan:= Real( gse.Float_Value( cursor, 220 ));
            end if;
            if not gse.Is_Null( cursor, 221 )then
               target_candidates.Tenure_Shared_Ownership_Part_Owned_And_Part_Rented:= Real( gse.Float_Value( cursor, 221 ));
            end if;
            if not gse.Is_Null( cursor, 222 )then
               target_candidates.Tenure_Social_Rented_Total:= Real( gse.Float_Value( cursor, 222 ));
            end if;
            if not gse.Is_Null( cursor, 223 )then
               target_candidates.Tenure_Social_Rented_Rented_From_Council_Local_Authority:= Real( gse.Float_Value( cursor, 223 ));
            end if;
            if not gse.Is_Null( cursor, 224 )then
               target_candidates.Tenure_Social_Rented_Other_Social_Rented:= Real( gse.Float_Value( cursor, 224 ));
            end if;
            if not gse.Is_Null( cursor, 225 )then
               target_candidates.Tenure_Private_Rented_Total:= Real( gse.Float_Value( cursor, 225 ));
            end if;
            if not gse.Is_Null( cursor, 226 )then
               target_candidates.Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency:= Real( gse.Float_Value( cursor, 226 ));
            end if;
            if not gse.Is_Null( cursor, 227 )then
               target_candidates.Tenure_Private_Rented_Employer_Of_A_Household_Member:= Real( gse.Float_Value( cursor, 227 ));
            end if;
            if not gse.Is_Null( cursor, 228 )then
               target_candidates.Tenure_Private_Rented_Relative_Or_Friend_Of_Household:= Real( gse.Float_Value( cursor, 228 ));
            end if;
            if not gse.Is_Null( cursor, 229 )then
               target_candidates.Tenure_Private_Rented_Other:= Real( gse.Float_Value( cursor, 229 ));
            end if;
            if not gse.Is_Null( cursor, 230 )then
               target_candidates.Tenure_Living_Rent_Free:= Real( gse.Float_Value( cursor, 230 ));
            end if;
            if not gse.Is_Null( cursor, 231 )then
               target_candidates.Occupation_All_Categories_Occupation:= Real( gse.Float_Value( cursor, 231 ));
            end if;
            if not gse.Is_Null( cursor, 232 )then
               target_candidates.Occupation_1_Managers_Directors_And_Senior_Officials:= Real( gse.Float_Value( cursor, 232 ));
            end if;
            if not gse.Is_Null( cursor, 233 )then
               target_candidates.Occupation_2_Professional_Occupations:= Real( gse.Float_Value( cursor, 233 ));
            end if;
            if not gse.Is_Null( cursor, 234 )then
               target_candidates.Occupation_3_Associate_Professional_And_Technical_Occupations:= Real( gse.Float_Value( cursor, 234 ));
            end if;
            if not gse.Is_Null( cursor, 235 )then
               target_candidates.Occupation_4_Administrative_And_Secretarial_Occupations:= Real( gse.Float_Value( cursor, 235 ));
            end if;
            if not gse.Is_Null( cursor, 236 )then
               target_candidates.Occupation_5_Skilled_Trades_Occupations:= Real( gse.Float_Value( cursor, 236 ));
            end if;
            if not gse.Is_Null( cursor, 237 )then
               target_candidates.Occupation_6_Caring_Leisure_And_Other_Service_Occupations:= Real( gse.Float_Value( cursor, 237 ));
            end if;
            if not gse.Is_Null( cursor, 238 )then
               target_candidates.Occupation_7_Sales_And_Customer_Service_Occupations:= Real( gse.Float_Value( cursor, 238 ));
            end if;
            if not gse.Is_Null( cursor, 239 )then
               target_candidates.Occupation_8_Process_Plant_And_Machine_Operatives:= Real( gse.Float_Value( cursor, 239 ));
            end if;
            if not gse.Is_Null( cursor, 240 )then
               target_candidates.Occupation_9_Elementary_Occupations:= Real( gse.Float_Value( cursor, 240 ));
            end if;
            if not gse.Is_Null( cursor, 241 )then
               target_candidates.Income_Support_People_Claiming_Benefit:= Real( gse.Float_Value( cursor, 241 ));
            end if;
            if not gse.Is_Null( cursor, 242 )then
               target_candidates.Income_Support_Average_Weekly_Payment:= Real( gse.Float_Value( cursor, 242 ));
            end if;
            if not gse.Is_Null( cursor, 243 )then
               target_candidates.Jsa_Total:= Real( gse.Float_Value( cursor, 243 ));
            end if;
            if not gse.Is_Null( cursor, 244 )then
               target_candidates.Pension_Credits_Number_Of_Claimants:= Real( gse.Float_Value( cursor, 244 ));
            end if;
            if not gse.Is_Null( cursor, 245 )then
               target_candidates.Pension_Credits_Number_Of_Beneficiaries:= Real( gse.Float_Value( cursor, 245 ));
            end if;
            if not gse.Is_Null( cursor, 246 )then
               target_candidates.Pension_Credits_Average_Weekly_Payment:= Real( gse.Float_Value( cursor, 246 ));
            end if;
            if not gse.Is_Null( cursor, 247 )then
               target_candidates.Out_Of_Work_Families:= Real( gse.Float_Value( cursor, 247 ));
            end if;
            if not gse.Is_Null( cursor, 248 )then
               target_candidates.Out_Of_Work_Children:= Real( gse.Float_Value( cursor, 248 ));
            end if;
            if not gse.Is_Null( cursor, 249 )then
               target_candidates.Wtc_And_Ctc_Families:= Real( gse.Float_Value( cursor, 249 ));
            end if;
            if not gse.Is_Null( cursor, 250 )then
               target_candidates.Wtc_And_Ctc_Children:= Real( gse.Float_Value( cursor, 250 ));
            end if;
            if not gse.Is_Null( cursor, 251 )then
               target_candidates.Ctc_Only_Families:= Real( gse.Float_Value( cursor, 251 ));
            end if;
            if not gse.Is_Null( cursor, 252 )then
               target_candidates.Ctc_Only_Children:= Real( gse.Float_Value( cursor, 252 ));
            end if;
            if not gse.Is_Null( cursor, 253 )then
               target_candidates.Childcare_Element:= Real( gse.Float_Value( cursor, 253 ));
            end if;
            if not gse.Is_Null( cursor, 254 )then
               target_candidates.Credits_No_Children:= Real( gse.Float_Value( cursor, 254 ));
            end if;
            if not gse.Is_Null( cursor, 255 )then
               target_candidates.Credits_Total_Families:= Real( gse.Float_Value( cursor, 255 ));
            end if;
            l.append( target_candidates ); 
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
   procedure Update( target_candidates : La_Data_Data.Target_Candidates_Type; connection : Database_Connection := null ) is
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
      Add_Frs_Region( values_c, target_candidates.Frs_Region );
      Add_Hb_Total( values_c, target_candidates.Hb_Total );
      Add_Hb_Social_Rented_Sector( values_c, target_candidates.Hb_Social_Rented_Sector );
      Add_Hb_Private_Rented_Sector( values_c, target_candidates.Hb_Private_Rented_Sector );
      Add_Hb_Passported( values_c, target_candidates.Hb_Passported );
      Add_Hb_Non_Passported( values_c, target_candidates.Hb_Non_Passported );
      Add_Ct_All( values_c, target_candidates.Ct_All );
      Add_Ct_Passported( values_c, target_candidates.Ct_Passported );
      Add_Ct_Non_Passported( values_c, target_candidates.Ct_Non_Passported );
      Add_Genders_All_Usual_Residents( values_c, target_candidates.Genders_All_Usual_Residents );
      Add_Genders_Males( values_c, target_candidates.Genders_Males );
      Add_Genders_Females( values_c, target_candidates.Genders_Females );
      Add_Genders_Lives_In_A_Household( values_c, target_candidates.Genders_Lives_In_A_Household );
      Add_Genders_Lives_In_A_Communal_Establishment( values_c, target_candidates.Genders_Lives_In_A_Communal_Establishment );
      Add_Genders_Schoolchild_Or_Student_Non_Term_Time_Address( values_c, target_candidates.Genders_Schoolchild_Or_Student_Non_Term_Time_Address );
      Add_Age_Ranges_All_Categories_Age( values_c, target_candidates.Age_Ranges_All_Categories_Age );
      Add_Age_Ranges_Age_Under_1( values_c, target_candidates.Age_Ranges_Age_Under_1 );
      Add_Age_Ranges_Age_1( values_c, target_candidates.Age_Ranges_Age_1 );
      Add_Age_Ranges_Age_2( values_c, target_candidates.Age_Ranges_Age_2 );
      Add_Age_Ranges_Age_3( values_c, target_candidates.Age_Ranges_Age_3 );
      Add_Age_Ranges_Age_4( values_c, target_candidates.Age_Ranges_Age_4 );
      Add_Age_Ranges_Age_5( values_c, target_candidates.Age_Ranges_Age_5 );
      Add_Age_Ranges_Age_6( values_c, target_candidates.Age_Ranges_Age_6 );
      Add_Age_Ranges_Age_7( values_c, target_candidates.Age_Ranges_Age_7 );
      Add_Age_Ranges_Age_8( values_c, target_candidates.Age_Ranges_Age_8 );
      Add_Age_Ranges_Age_9( values_c, target_candidates.Age_Ranges_Age_9 );
      Add_Age_Ranges_Age_10( values_c, target_candidates.Age_Ranges_Age_10 );
      Add_Age_Ranges_Age_11( values_c, target_candidates.Age_Ranges_Age_11 );
      Add_Age_Ranges_Age_12( values_c, target_candidates.Age_Ranges_Age_12 );
      Add_Age_Ranges_Age_13( values_c, target_candidates.Age_Ranges_Age_13 );
      Add_Age_Ranges_Age_14( values_c, target_candidates.Age_Ranges_Age_14 );
      Add_Age_Ranges_Age_15( values_c, target_candidates.Age_Ranges_Age_15 );
      Add_Age_Ranges_Age_16( values_c, target_candidates.Age_Ranges_Age_16 );
      Add_Age_Ranges_Age_17( values_c, target_candidates.Age_Ranges_Age_17 );
      Add_Age_Ranges_Age_18( values_c, target_candidates.Age_Ranges_Age_18 );
      Add_Age_Ranges_Age_19( values_c, target_candidates.Age_Ranges_Age_19 );
      Add_Age_Ranges_Age_20( values_c, target_candidates.Age_Ranges_Age_20 );
      Add_Age_Ranges_Age_21( values_c, target_candidates.Age_Ranges_Age_21 );
      Add_Age_Ranges_Age_22( values_c, target_candidates.Age_Ranges_Age_22 );
      Add_Age_Ranges_Age_23( values_c, target_candidates.Age_Ranges_Age_23 );
      Add_Age_Ranges_Age_24( values_c, target_candidates.Age_Ranges_Age_24 );
      Add_Age_Ranges_Age_25( values_c, target_candidates.Age_Ranges_Age_25 );
      Add_Age_Ranges_Age_26( values_c, target_candidates.Age_Ranges_Age_26 );
      Add_Age_Ranges_Age_27( values_c, target_candidates.Age_Ranges_Age_27 );
      Add_Age_Ranges_Age_28( values_c, target_candidates.Age_Ranges_Age_28 );
      Add_Age_Ranges_Age_29( values_c, target_candidates.Age_Ranges_Age_29 );
      Add_Age_Ranges_Age_30( values_c, target_candidates.Age_Ranges_Age_30 );
      Add_Age_Ranges_Age_31( values_c, target_candidates.Age_Ranges_Age_31 );
      Add_Age_Ranges_Age_32( values_c, target_candidates.Age_Ranges_Age_32 );
      Add_Age_Ranges_Age_33( values_c, target_candidates.Age_Ranges_Age_33 );
      Add_Age_Ranges_Age_34( values_c, target_candidates.Age_Ranges_Age_34 );
      Add_Age_Ranges_Age_35( values_c, target_candidates.Age_Ranges_Age_35 );
      Add_Age_Ranges_Age_36( values_c, target_candidates.Age_Ranges_Age_36 );
      Add_Age_Ranges_Age_37( values_c, target_candidates.Age_Ranges_Age_37 );
      Add_Age_Ranges_Age_38( values_c, target_candidates.Age_Ranges_Age_38 );
      Add_Age_Ranges_Age_39( values_c, target_candidates.Age_Ranges_Age_39 );
      Add_Age_Ranges_Age_40( values_c, target_candidates.Age_Ranges_Age_40 );
      Add_Age_Ranges_Age_41( values_c, target_candidates.Age_Ranges_Age_41 );
      Add_Age_Ranges_Age_42( values_c, target_candidates.Age_Ranges_Age_42 );
      Add_Age_Ranges_Age_43( values_c, target_candidates.Age_Ranges_Age_43 );
      Add_Age_Ranges_Age_44( values_c, target_candidates.Age_Ranges_Age_44 );
      Add_Age_Ranges_Age_45( values_c, target_candidates.Age_Ranges_Age_45 );
      Add_Age_Ranges_Age_46( values_c, target_candidates.Age_Ranges_Age_46 );
      Add_Age_Ranges_Age_47( values_c, target_candidates.Age_Ranges_Age_47 );
      Add_Age_Ranges_Age_48( values_c, target_candidates.Age_Ranges_Age_48 );
      Add_Age_Ranges_Age_49( values_c, target_candidates.Age_Ranges_Age_49 );
      Add_Age_Ranges_Age_50( values_c, target_candidates.Age_Ranges_Age_50 );
      Add_Age_Ranges_Age_51( values_c, target_candidates.Age_Ranges_Age_51 );
      Add_Age_Ranges_Age_52( values_c, target_candidates.Age_Ranges_Age_52 );
      Add_Age_Ranges_Age_53( values_c, target_candidates.Age_Ranges_Age_53 );
      Add_Age_Ranges_Age_54( values_c, target_candidates.Age_Ranges_Age_54 );
      Add_Age_Ranges_Age_55( values_c, target_candidates.Age_Ranges_Age_55 );
      Add_Age_Ranges_Age_56( values_c, target_candidates.Age_Ranges_Age_56 );
      Add_Age_Ranges_Age_57( values_c, target_candidates.Age_Ranges_Age_57 );
      Add_Age_Ranges_Age_58( values_c, target_candidates.Age_Ranges_Age_58 );
      Add_Age_Ranges_Age_59( values_c, target_candidates.Age_Ranges_Age_59 );
      Add_Age_Ranges_Age_60( values_c, target_candidates.Age_Ranges_Age_60 );
      Add_Age_Ranges_Age_61( values_c, target_candidates.Age_Ranges_Age_61 );
      Add_Age_Ranges_Age_62( values_c, target_candidates.Age_Ranges_Age_62 );
      Add_Age_Ranges_Age_63( values_c, target_candidates.Age_Ranges_Age_63 );
      Add_Age_Ranges_Age_64( values_c, target_candidates.Age_Ranges_Age_64 );
      Add_Age_Ranges_Age_65( values_c, target_candidates.Age_Ranges_Age_65 );
      Add_Age_Ranges_Age_66( values_c, target_candidates.Age_Ranges_Age_66 );
      Add_Age_Ranges_Age_67( values_c, target_candidates.Age_Ranges_Age_67 );
      Add_Age_Ranges_Age_68( values_c, target_candidates.Age_Ranges_Age_68 );
      Add_Age_Ranges_Age_69( values_c, target_candidates.Age_Ranges_Age_69 );
      Add_Age_Ranges_Age_70( values_c, target_candidates.Age_Ranges_Age_70 );
      Add_Age_Ranges_Age_71( values_c, target_candidates.Age_Ranges_Age_71 );
      Add_Age_Ranges_Age_72( values_c, target_candidates.Age_Ranges_Age_72 );
      Add_Age_Ranges_Age_73( values_c, target_candidates.Age_Ranges_Age_73 );
      Add_Age_Ranges_Age_74( values_c, target_candidates.Age_Ranges_Age_74 );
      Add_Age_Ranges_Age_75( values_c, target_candidates.Age_Ranges_Age_75 );
      Add_Age_Ranges_Age_76( values_c, target_candidates.Age_Ranges_Age_76 );
      Add_Age_Ranges_Age_77( values_c, target_candidates.Age_Ranges_Age_77 );
      Add_Age_Ranges_Age_78( values_c, target_candidates.Age_Ranges_Age_78 );
      Add_Age_Ranges_Age_79( values_c, target_candidates.Age_Ranges_Age_79 );
      Add_Age_Ranges_Age_80( values_c, target_candidates.Age_Ranges_Age_80 );
      Add_Age_Ranges_Age_81( values_c, target_candidates.Age_Ranges_Age_81 );
      Add_Age_Ranges_Age_82( values_c, target_candidates.Age_Ranges_Age_82 );
      Add_Age_Ranges_Age_83( values_c, target_candidates.Age_Ranges_Age_83 );
      Add_Age_Ranges_Age_84( values_c, target_candidates.Age_Ranges_Age_84 );
      Add_Age_Ranges_Age_85( values_c, target_candidates.Age_Ranges_Age_85 );
      Add_Age_Ranges_Age_86( values_c, target_candidates.Age_Ranges_Age_86 );
      Add_Age_Ranges_Age_87( values_c, target_candidates.Age_Ranges_Age_87 );
      Add_Age_Ranges_Age_88( values_c, target_candidates.Age_Ranges_Age_88 );
      Add_Age_Ranges_Age_89( values_c, target_candidates.Age_Ranges_Age_89 );
      Add_Age_Ranges_Age_90( values_c, target_candidates.Age_Ranges_Age_90 );
      Add_Age_Ranges_Age_91( values_c, target_candidates.Age_Ranges_Age_91 );
      Add_Age_Ranges_Age_92( values_c, target_candidates.Age_Ranges_Age_92 );
      Add_Age_Ranges_Age_93( values_c, target_candidates.Age_Ranges_Age_93 );
      Add_Age_Ranges_Age_94( values_c, target_candidates.Age_Ranges_Age_94 );
      Add_Age_Ranges_Age_95( values_c, target_candidates.Age_Ranges_Age_95 );
      Add_Age_Ranges_Age_96( values_c, target_candidates.Age_Ranges_Age_96 );
      Add_Age_Ranges_Age_97( values_c, target_candidates.Age_Ranges_Age_97 );
      Add_Age_Ranges_Age_98( values_c, target_candidates.Age_Ranges_Age_98 );
      Add_Age_Ranges_Age_99( values_c, target_candidates.Age_Ranges_Age_99 );
      Add_Age_Ranges_Age_100_And_Over( values_c, target_candidates.Age_Ranges_Age_100_And_Over );
      Add_Accom_All_Categories_Accommodation_Type( values_c, target_candidates.Accom_All_Categories_Accommodation_Type );
      Add_Accom_Unshared_Total( values_c, target_candidates.Accom_Unshared_Total );
      Add_Accom_Unshared_Whole_House_Or_Bungalow_Total( values_c, target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Total );
      Add_Accom_Unshared_Whole_House_Or_Bungalow_Detached( values_c, target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Detached );
      Add_Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached( values_c, target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached );
      Add_Accom_Unshared_Whole_House_Or_Bungalow_Terraced( values_c, target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Terraced );
      Add_Accom_Unshared_Flat_Maisonette_Or_Apartment_Total( values_c, target_candidates.Accom_Unshared_Flat_Maisonette_Or_Apartment_Total );
      Add_Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement( values_c, target_candidates.Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement );
      Add_Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House( values_c, target_candidates.Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House );
      Add_Accom_Unshared_Flat_Etc_In_Commercial_Building( values_c, target_candidates.Accom_Unshared_Flat_Etc_In_Commercial_Building );
      Add_Accom_Unshared_Caravan_Etc( values_c, target_candidates.Accom_Unshared_Caravan_Etc );
      Add_Accom_Shared( values_c, target_candidates.Accom_Shared );
      Add_Ec_Act_All_Categories_Economic_Activity( values_c, target_candidates.Ec_Act_All_Categories_Economic_Activity );
      Add_Ec_Act_Active_Total( values_c, target_candidates.Ec_Act_Active_Total );
      Add_Ec_Act_Active_Employee_Part_Time( values_c, target_candidates.Ec_Act_Active_Employee_Part_Time );
      Add_Ec_Act_Active_Employee_Full_Time( values_c, target_candidates.Ec_Act_Active_Employee_Full_Time );
      Add_Ec_Act_Active_Self_Employed_With_Employees_Part_Time( values_c, target_candidates.Ec_Act_Active_Self_Employed_With_Employees_Part_Time );
      Add_Ec_Act_Active_Self_Employed_With_Employees_Full_Time( values_c, target_candidates.Ec_Act_Active_Self_Employed_With_Employees_Full_Time );
      Add_Ec_Act_Active_Self_Employed_Without_Employees_Part_Time( values_c, target_candidates.Ec_Act_Active_Self_Employed_Without_Employees_Part_Time );
      Add_Ec_Act_Active_Self_Employed_Without_Employees_Full_Time( values_c, target_candidates.Ec_Act_Active_Self_Employed_Without_Employees_Full_Time );
      Add_Ec_Act_Active_Unemployed( values_c, target_candidates.Ec_Act_Active_Unemployed );
      Add_Ec_Act_Active_Full_Time_Student( values_c, target_candidates.Ec_Act_Active_Full_Time_Student );
      Add_Ec_Act_Inactive_Total( values_c, target_candidates.Ec_Act_Inactive_Total );
      Add_Ec_Act_Inactive_Retired( values_c, target_candidates.Ec_Act_Inactive_Retired );
      Add_Ec_Act_Inactive_Student_Including_Full_Time_Students( values_c, target_candidates.Ec_Act_Inactive_Student_Including_Full_Time_Students );
      Add_Ec_Act_Inactive_Looking_After_Home_Or_Family( values_c, target_candidates.Ec_Act_Inactive_Looking_After_Home_Or_Family );
      Add_Ec_Act_Inactive_Long_Term_Sick_Or_Disabled( values_c, target_candidates.Ec_Act_Inactive_Long_Term_Sick_Or_Disabled );
      Add_Ec_Act_Inactive_Other( values_c, target_candidates.Ec_Act_Inactive_Other );
      Add_Ethgrp_All_Categories_Ethnic_Group( values_c, target_candidates.Ethgrp_All_Categories_Ethnic_Group );
      Add_Ethgrp_White( values_c, target_candidates.Ethgrp_White );
      Add_Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British( values_c, target_candidates.Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British );
      Add_Ethgrp_White_Irish( values_c, target_candidates.Ethgrp_White_Irish );
      Add_Ethgrp_White_Gypsy_Or_Irish_Traveller( values_c, target_candidates.Ethgrp_White_Gypsy_Or_Irish_Traveller );
      Add_Ethgrp_White_Other_White( values_c, target_candidates.Ethgrp_White_Other_White );
      Add_Ethgrp_Mixed( values_c, target_candidates.Ethgrp_Mixed );
      Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean( values_c, target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean );
      Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African( values_c, target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African );
      Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian( values_c, target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian );
      Add_Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed( values_c, target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed );
      Add_Ethgrp_Asian( values_c, target_candidates.Ethgrp_Asian );
      Add_Ethgrp_Asian_Asian_British_Indian( values_c, target_candidates.Ethgrp_Asian_Asian_British_Indian );
      Add_Ethgrp_Asian_Asian_British_Pakistani( values_c, target_candidates.Ethgrp_Asian_Asian_British_Pakistani );
      Add_Ethgrp_Asian_Asian_British_Bangladeshi( values_c, target_candidates.Ethgrp_Asian_Asian_British_Bangladeshi );
      Add_Ethgrp_Asian_Asian_British_Chinese( values_c, target_candidates.Ethgrp_Asian_Asian_British_Chinese );
      Add_Ethgrp_Asian_Asian_British_Other_Asian( values_c, target_candidates.Ethgrp_Asian_Asian_British_Other_Asian );
      Add_Ethgrp_Black( values_c, target_candidates.Ethgrp_Black );
      Add_Ethgrp_Black_African_Caribbean_Black_British_African( values_c, target_candidates.Ethgrp_Black_African_Caribbean_Black_British_African );
      Add_Ethgrp_Black_African_Caribbean_Black_British_Caribbean( values_c, target_candidates.Ethgrp_Black_African_Caribbean_Black_British_Caribbean );
      Add_Ethgrp_Black_African_Caribbean_Black_British_Other_Black( values_c, target_candidates.Ethgrp_Black_African_Caribbean_Black_British_Other_Black );
      Add_Ethgrp_Other( values_c, target_candidates.Ethgrp_Other );
      Add_Ethgrp_Other_Ethnic_Group_Arab( values_c, target_candidates.Ethgrp_Other_Ethnic_Group_Arab );
      Add_Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group( values_c, target_candidates.Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group );
      Add_Hcomp_All_Categories_Household_Composition( values_c, target_candidates.Hcomp_All_Categories_Household_Composition );
      Add_Hcomp_One_Person_Household_Total( values_c, target_candidates.Hcomp_One_Person_Household_Total );
      Add_Hcomp_One_Person_Household_Aged_65_And_Over( values_c, target_candidates.Hcomp_One_Person_Household_Aged_65_And_Over );
      Add_Hcomp_One_Person_Household_Other( values_c, target_candidates.Hcomp_One_Person_Household_Other );
      Add_Hcomp_One_Family_Only_Total( values_c, target_candidates.Hcomp_One_Family_Only_Total );
      Add_Hcomp_One_Family_Only_All_Aged_65_And_Over( values_c, target_candidates.Hcomp_One_Family_Only_All_Aged_65_And_Over );
      Add_Hcomp_One_Family_Only_Married_Cple_Total( values_c, target_candidates.Hcomp_One_Family_Only_Married_Cple_Total );
      Add_Hcomp_One_Family_Only_Married_Cple_No_Kids( values_c, target_candidates.Hcomp_One_Family_Only_Married_Cple_No_Kids );
      Add_Hcomp_One_Family_Only_Married_Cple_One_Dep_Child( values_c, target_candidates.Hcomp_One_Family_Only_Married_Cple_One_Dep_Child );
      Add_Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids( values_c, target_candidates.Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids );
      Add_Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep( values_c, target_candidates.Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep );
      Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total( values_c, target_candidates.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total );
      Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids( values_c, target_candidates.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids );
      Add_Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child( values_c, target_candidates.Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child );
      Add_Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids( values_c, target_candidates.Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids );
      Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep( values_c, target_candidates.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_Total( values_c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_Total );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids( values_c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child( values_c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids( values_c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep( values_c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep );
      Add_Hcomp_One_Family_Only_Lone_Parent_Total( values_c, target_candidates.Hcomp_One_Family_Only_Lone_Parent_Total );
      Add_Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child( values_c, target_candidates.Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child );
      Add_Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids( values_c, target_candidates.Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids );
      Add_Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep( values_c, target_candidates.Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep );
      Add_Hcomp_Other_Total( values_c, target_candidates.Hcomp_Other_Total );
      Add_Hcomp_Other_With_One_Dep_Child( values_c, target_candidates.Hcomp_Other_With_One_Dep_Child );
      Add_Hcomp_Other_With_Two_Or_More_Dep_Kids( values_c, target_candidates.Hcomp_Other_With_Two_Or_More_Dep_Kids );
      Add_Hcomp_Other_All_Full_Time_Students( values_c, target_candidates.Hcomp_Other_All_Full_Time_Students );
      Add_Hcomp_Other_All_Aged_65_And_Over( values_c, target_candidates.Hcomp_Other_All_Aged_65_And_Over );
      Add_Hcomp_Other_Other( values_c, target_candidates.Hcomp_Other_Other );
      Add_Number_Of_Rooms_All_Categories_Number_Of_Rooms( values_c, target_candidates.Number_Of_Rooms_All_Categories_Number_Of_Rooms );
      Add_Number_Of_Rooms_1_Room( values_c, target_candidates.Number_Of_Rooms_1_Room );
      Add_Number_Of_Rooms_2_Rooms( values_c, target_candidates.Number_Of_Rooms_2_Rooms );
      Add_Number_Of_Rooms_3_Rooms( values_c, target_candidates.Number_Of_Rooms_3_Rooms );
      Add_Number_Of_Rooms_4_Rooms( values_c, target_candidates.Number_Of_Rooms_4_Rooms );
      Add_Number_Of_Rooms_5_Rooms( values_c, target_candidates.Number_Of_Rooms_5_Rooms );
      Add_Number_Of_Rooms_6_Rooms( values_c, target_candidates.Number_Of_Rooms_6_Rooms );
      Add_Number_Of_Rooms_7_Rooms( values_c, target_candidates.Number_Of_Rooms_7_Rooms );
      Add_Number_Of_Rooms_8_Rooms( values_c, target_candidates.Number_Of_Rooms_8_Rooms );
      Add_Number_Of_Rooms_9_Or_More_Rooms( values_c, target_candidates.Number_Of_Rooms_9_Or_More_Rooms );
      Add_Residence_All_Categories_Residence_Type( values_c, target_candidates.Residence_All_Categories_Residence_Type );
      Add_Residence_Lives_In_A_Household( values_c, target_candidates.Residence_Lives_In_A_Household );
      Add_Residence_Lives_In_A_Communal_Establishment( values_c, target_candidates.Residence_Lives_In_A_Communal_Establishment );
      Add_Residence_Communal_Establishments_With_Persons_Sleeping_Rough( values_c, target_candidates.Residence_Communal_Establishments_With_Persons_Sleeping_Rough );
      Add_Tenure_All_Categories_Tenure( values_c, target_candidates.Tenure_All_Categories_Tenure );
      Add_Tenure_Owned_Total( values_c, target_candidates.Tenure_Owned_Total );
      Add_Tenure_Owned_Owned_Outright( values_c, target_candidates.Tenure_Owned_Owned_Outright );
      Add_Tenure_Owned_Owned_With_A_Mortgage_Or_Loan( values_c, target_candidates.Tenure_Owned_Owned_With_A_Mortgage_Or_Loan );
      Add_Tenure_Shared_Ownership_Part_Owned_And_Part_Rented( values_c, target_candidates.Tenure_Shared_Ownership_Part_Owned_And_Part_Rented );
      Add_Tenure_Social_Rented_Total( values_c, target_candidates.Tenure_Social_Rented_Total );
      Add_Tenure_Social_Rented_Rented_From_Council_Local_Authority( values_c, target_candidates.Tenure_Social_Rented_Rented_From_Council_Local_Authority );
      Add_Tenure_Social_Rented_Other_Social_Rented( values_c, target_candidates.Tenure_Social_Rented_Other_Social_Rented );
      Add_Tenure_Private_Rented_Total( values_c, target_candidates.Tenure_Private_Rented_Total );
      Add_Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency( values_c, target_candidates.Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency );
      Add_Tenure_Private_Rented_Employer_Of_A_Household_Member( values_c, target_candidates.Tenure_Private_Rented_Employer_Of_A_Household_Member );
      Add_Tenure_Private_Rented_Relative_Or_Friend_Of_Household( values_c, target_candidates.Tenure_Private_Rented_Relative_Or_Friend_Of_Household );
      Add_Tenure_Private_Rented_Other( values_c, target_candidates.Tenure_Private_Rented_Other );
      Add_Tenure_Living_Rent_Free( values_c, target_candidates.Tenure_Living_Rent_Free );
      Add_Occupation_All_Categories_Occupation( values_c, target_candidates.Occupation_All_Categories_Occupation );
      Add_Occupation_1_Managers_Directors_And_Senior_Officials( values_c, target_candidates.Occupation_1_Managers_Directors_And_Senior_Officials );
      Add_Occupation_2_Professional_Occupations( values_c, target_candidates.Occupation_2_Professional_Occupations );
      Add_Occupation_3_Associate_Professional_And_Technical_Occupations( values_c, target_candidates.Occupation_3_Associate_Professional_And_Technical_Occupations );
      Add_Occupation_4_Administrative_And_Secretarial_Occupations( values_c, target_candidates.Occupation_4_Administrative_And_Secretarial_Occupations );
      Add_Occupation_5_Skilled_Trades_Occupations( values_c, target_candidates.Occupation_5_Skilled_Trades_Occupations );
      Add_Occupation_6_Caring_Leisure_And_Other_Service_Occupations( values_c, target_candidates.Occupation_6_Caring_Leisure_And_Other_Service_Occupations );
      Add_Occupation_7_Sales_And_Customer_Service_Occupations( values_c, target_candidates.Occupation_7_Sales_And_Customer_Service_Occupations );
      Add_Occupation_8_Process_Plant_And_Machine_Operatives( values_c, target_candidates.Occupation_8_Process_Plant_And_Machine_Operatives );
      Add_Occupation_9_Elementary_Occupations( values_c, target_candidates.Occupation_9_Elementary_Occupations );
      Add_Income_Support_People_Claiming_Benefit( values_c, target_candidates.Income_Support_People_Claiming_Benefit );
      Add_Income_Support_Average_Weekly_Payment( values_c, target_candidates.Income_Support_Average_Weekly_Payment );
      Add_Jsa_Total( values_c, target_candidates.Jsa_Total );
      Add_Pension_Credits_Number_Of_Claimants( values_c, target_candidates.Pension_Credits_Number_Of_Claimants );
      Add_Pension_Credits_Number_Of_Beneficiaries( values_c, target_candidates.Pension_Credits_Number_Of_Beneficiaries );
      Add_Pension_Credits_Average_Weekly_Payment( values_c, target_candidates.Pension_Credits_Average_Weekly_Payment );
      Add_Out_Of_Work_Families( values_c, target_candidates.Out_Of_Work_Families );
      Add_Out_Of_Work_Children( values_c, target_candidates.Out_Of_Work_Children );
      Add_Wtc_And_Ctc_Families( values_c, target_candidates.Wtc_And_Ctc_Families );
      Add_Wtc_And_Ctc_Children( values_c, target_candidates.Wtc_And_Ctc_Children );
      Add_Ctc_Only_Families( values_c, target_candidates.Ctc_Only_Families );
      Add_Ctc_Only_Children( values_c, target_candidates.Ctc_Only_Children );
      Add_Childcare_Element( values_c, target_candidates.Childcare_Element );
      Add_Credits_No_Children( values_c, target_candidates.Credits_No_Children );
      Add_Credits_Total_Families( values_c, target_candidates.Credits_Total_Families );
      --
      -- primary key fields
      --
      Add_Id( pk_c, target_candidates.Id );
      Add_Code( pk_c, target_candidates.Code );
      Add_Edition( pk_c, target_candidates.Edition );
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
   procedure Save( target_candidates : La_Data_Data.Target_Candidates_Type; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      c : d.Criteria;
      target_candidates_tmp : La_Data_Data.Target_Candidates_Type;
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
         target_candidates_tmp := retrieve_By_PK( target_candidates.Id, target_candidates.Code, target_candidates.Edition );
         if( not is_Null( target_candidates_tmp )) then
            Update( target_candidates, local_connection );
            return;
         end if;
      end if;
      Add_Id( c, target_candidates.Id );
      Add_Code( c, target_candidates.Code );
      Add_Edition( c, target_candidates.Edition );
      Add_Frs_Region( c, target_candidates.Frs_Region );
      Add_Hb_Total( c, target_candidates.Hb_Total );
      Add_Hb_Social_Rented_Sector( c, target_candidates.Hb_Social_Rented_Sector );
      Add_Hb_Private_Rented_Sector( c, target_candidates.Hb_Private_Rented_Sector );
      Add_Hb_Passported( c, target_candidates.Hb_Passported );
      Add_Hb_Non_Passported( c, target_candidates.Hb_Non_Passported );
      Add_Ct_All( c, target_candidates.Ct_All );
      Add_Ct_Passported( c, target_candidates.Ct_Passported );
      Add_Ct_Non_Passported( c, target_candidates.Ct_Non_Passported );
      Add_Genders_All_Usual_Residents( c, target_candidates.Genders_All_Usual_Residents );
      Add_Genders_Males( c, target_candidates.Genders_Males );
      Add_Genders_Females( c, target_candidates.Genders_Females );
      Add_Genders_Lives_In_A_Household( c, target_candidates.Genders_Lives_In_A_Household );
      Add_Genders_Lives_In_A_Communal_Establishment( c, target_candidates.Genders_Lives_In_A_Communal_Establishment );
      Add_Genders_Schoolchild_Or_Student_Non_Term_Time_Address( c, target_candidates.Genders_Schoolchild_Or_Student_Non_Term_Time_Address );
      Add_Age_Ranges_All_Categories_Age( c, target_candidates.Age_Ranges_All_Categories_Age );
      Add_Age_Ranges_Age_Under_1( c, target_candidates.Age_Ranges_Age_Under_1 );
      Add_Age_Ranges_Age_1( c, target_candidates.Age_Ranges_Age_1 );
      Add_Age_Ranges_Age_2( c, target_candidates.Age_Ranges_Age_2 );
      Add_Age_Ranges_Age_3( c, target_candidates.Age_Ranges_Age_3 );
      Add_Age_Ranges_Age_4( c, target_candidates.Age_Ranges_Age_4 );
      Add_Age_Ranges_Age_5( c, target_candidates.Age_Ranges_Age_5 );
      Add_Age_Ranges_Age_6( c, target_candidates.Age_Ranges_Age_6 );
      Add_Age_Ranges_Age_7( c, target_candidates.Age_Ranges_Age_7 );
      Add_Age_Ranges_Age_8( c, target_candidates.Age_Ranges_Age_8 );
      Add_Age_Ranges_Age_9( c, target_candidates.Age_Ranges_Age_9 );
      Add_Age_Ranges_Age_10( c, target_candidates.Age_Ranges_Age_10 );
      Add_Age_Ranges_Age_11( c, target_candidates.Age_Ranges_Age_11 );
      Add_Age_Ranges_Age_12( c, target_candidates.Age_Ranges_Age_12 );
      Add_Age_Ranges_Age_13( c, target_candidates.Age_Ranges_Age_13 );
      Add_Age_Ranges_Age_14( c, target_candidates.Age_Ranges_Age_14 );
      Add_Age_Ranges_Age_15( c, target_candidates.Age_Ranges_Age_15 );
      Add_Age_Ranges_Age_16( c, target_candidates.Age_Ranges_Age_16 );
      Add_Age_Ranges_Age_17( c, target_candidates.Age_Ranges_Age_17 );
      Add_Age_Ranges_Age_18( c, target_candidates.Age_Ranges_Age_18 );
      Add_Age_Ranges_Age_19( c, target_candidates.Age_Ranges_Age_19 );
      Add_Age_Ranges_Age_20( c, target_candidates.Age_Ranges_Age_20 );
      Add_Age_Ranges_Age_21( c, target_candidates.Age_Ranges_Age_21 );
      Add_Age_Ranges_Age_22( c, target_candidates.Age_Ranges_Age_22 );
      Add_Age_Ranges_Age_23( c, target_candidates.Age_Ranges_Age_23 );
      Add_Age_Ranges_Age_24( c, target_candidates.Age_Ranges_Age_24 );
      Add_Age_Ranges_Age_25( c, target_candidates.Age_Ranges_Age_25 );
      Add_Age_Ranges_Age_26( c, target_candidates.Age_Ranges_Age_26 );
      Add_Age_Ranges_Age_27( c, target_candidates.Age_Ranges_Age_27 );
      Add_Age_Ranges_Age_28( c, target_candidates.Age_Ranges_Age_28 );
      Add_Age_Ranges_Age_29( c, target_candidates.Age_Ranges_Age_29 );
      Add_Age_Ranges_Age_30( c, target_candidates.Age_Ranges_Age_30 );
      Add_Age_Ranges_Age_31( c, target_candidates.Age_Ranges_Age_31 );
      Add_Age_Ranges_Age_32( c, target_candidates.Age_Ranges_Age_32 );
      Add_Age_Ranges_Age_33( c, target_candidates.Age_Ranges_Age_33 );
      Add_Age_Ranges_Age_34( c, target_candidates.Age_Ranges_Age_34 );
      Add_Age_Ranges_Age_35( c, target_candidates.Age_Ranges_Age_35 );
      Add_Age_Ranges_Age_36( c, target_candidates.Age_Ranges_Age_36 );
      Add_Age_Ranges_Age_37( c, target_candidates.Age_Ranges_Age_37 );
      Add_Age_Ranges_Age_38( c, target_candidates.Age_Ranges_Age_38 );
      Add_Age_Ranges_Age_39( c, target_candidates.Age_Ranges_Age_39 );
      Add_Age_Ranges_Age_40( c, target_candidates.Age_Ranges_Age_40 );
      Add_Age_Ranges_Age_41( c, target_candidates.Age_Ranges_Age_41 );
      Add_Age_Ranges_Age_42( c, target_candidates.Age_Ranges_Age_42 );
      Add_Age_Ranges_Age_43( c, target_candidates.Age_Ranges_Age_43 );
      Add_Age_Ranges_Age_44( c, target_candidates.Age_Ranges_Age_44 );
      Add_Age_Ranges_Age_45( c, target_candidates.Age_Ranges_Age_45 );
      Add_Age_Ranges_Age_46( c, target_candidates.Age_Ranges_Age_46 );
      Add_Age_Ranges_Age_47( c, target_candidates.Age_Ranges_Age_47 );
      Add_Age_Ranges_Age_48( c, target_candidates.Age_Ranges_Age_48 );
      Add_Age_Ranges_Age_49( c, target_candidates.Age_Ranges_Age_49 );
      Add_Age_Ranges_Age_50( c, target_candidates.Age_Ranges_Age_50 );
      Add_Age_Ranges_Age_51( c, target_candidates.Age_Ranges_Age_51 );
      Add_Age_Ranges_Age_52( c, target_candidates.Age_Ranges_Age_52 );
      Add_Age_Ranges_Age_53( c, target_candidates.Age_Ranges_Age_53 );
      Add_Age_Ranges_Age_54( c, target_candidates.Age_Ranges_Age_54 );
      Add_Age_Ranges_Age_55( c, target_candidates.Age_Ranges_Age_55 );
      Add_Age_Ranges_Age_56( c, target_candidates.Age_Ranges_Age_56 );
      Add_Age_Ranges_Age_57( c, target_candidates.Age_Ranges_Age_57 );
      Add_Age_Ranges_Age_58( c, target_candidates.Age_Ranges_Age_58 );
      Add_Age_Ranges_Age_59( c, target_candidates.Age_Ranges_Age_59 );
      Add_Age_Ranges_Age_60( c, target_candidates.Age_Ranges_Age_60 );
      Add_Age_Ranges_Age_61( c, target_candidates.Age_Ranges_Age_61 );
      Add_Age_Ranges_Age_62( c, target_candidates.Age_Ranges_Age_62 );
      Add_Age_Ranges_Age_63( c, target_candidates.Age_Ranges_Age_63 );
      Add_Age_Ranges_Age_64( c, target_candidates.Age_Ranges_Age_64 );
      Add_Age_Ranges_Age_65( c, target_candidates.Age_Ranges_Age_65 );
      Add_Age_Ranges_Age_66( c, target_candidates.Age_Ranges_Age_66 );
      Add_Age_Ranges_Age_67( c, target_candidates.Age_Ranges_Age_67 );
      Add_Age_Ranges_Age_68( c, target_candidates.Age_Ranges_Age_68 );
      Add_Age_Ranges_Age_69( c, target_candidates.Age_Ranges_Age_69 );
      Add_Age_Ranges_Age_70( c, target_candidates.Age_Ranges_Age_70 );
      Add_Age_Ranges_Age_71( c, target_candidates.Age_Ranges_Age_71 );
      Add_Age_Ranges_Age_72( c, target_candidates.Age_Ranges_Age_72 );
      Add_Age_Ranges_Age_73( c, target_candidates.Age_Ranges_Age_73 );
      Add_Age_Ranges_Age_74( c, target_candidates.Age_Ranges_Age_74 );
      Add_Age_Ranges_Age_75( c, target_candidates.Age_Ranges_Age_75 );
      Add_Age_Ranges_Age_76( c, target_candidates.Age_Ranges_Age_76 );
      Add_Age_Ranges_Age_77( c, target_candidates.Age_Ranges_Age_77 );
      Add_Age_Ranges_Age_78( c, target_candidates.Age_Ranges_Age_78 );
      Add_Age_Ranges_Age_79( c, target_candidates.Age_Ranges_Age_79 );
      Add_Age_Ranges_Age_80( c, target_candidates.Age_Ranges_Age_80 );
      Add_Age_Ranges_Age_81( c, target_candidates.Age_Ranges_Age_81 );
      Add_Age_Ranges_Age_82( c, target_candidates.Age_Ranges_Age_82 );
      Add_Age_Ranges_Age_83( c, target_candidates.Age_Ranges_Age_83 );
      Add_Age_Ranges_Age_84( c, target_candidates.Age_Ranges_Age_84 );
      Add_Age_Ranges_Age_85( c, target_candidates.Age_Ranges_Age_85 );
      Add_Age_Ranges_Age_86( c, target_candidates.Age_Ranges_Age_86 );
      Add_Age_Ranges_Age_87( c, target_candidates.Age_Ranges_Age_87 );
      Add_Age_Ranges_Age_88( c, target_candidates.Age_Ranges_Age_88 );
      Add_Age_Ranges_Age_89( c, target_candidates.Age_Ranges_Age_89 );
      Add_Age_Ranges_Age_90( c, target_candidates.Age_Ranges_Age_90 );
      Add_Age_Ranges_Age_91( c, target_candidates.Age_Ranges_Age_91 );
      Add_Age_Ranges_Age_92( c, target_candidates.Age_Ranges_Age_92 );
      Add_Age_Ranges_Age_93( c, target_candidates.Age_Ranges_Age_93 );
      Add_Age_Ranges_Age_94( c, target_candidates.Age_Ranges_Age_94 );
      Add_Age_Ranges_Age_95( c, target_candidates.Age_Ranges_Age_95 );
      Add_Age_Ranges_Age_96( c, target_candidates.Age_Ranges_Age_96 );
      Add_Age_Ranges_Age_97( c, target_candidates.Age_Ranges_Age_97 );
      Add_Age_Ranges_Age_98( c, target_candidates.Age_Ranges_Age_98 );
      Add_Age_Ranges_Age_99( c, target_candidates.Age_Ranges_Age_99 );
      Add_Age_Ranges_Age_100_And_Over( c, target_candidates.Age_Ranges_Age_100_And_Over );
      Add_Accom_All_Categories_Accommodation_Type( c, target_candidates.Accom_All_Categories_Accommodation_Type );
      Add_Accom_Unshared_Total( c, target_candidates.Accom_Unshared_Total );
      Add_Accom_Unshared_Whole_House_Or_Bungalow_Total( c, target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Total );
      Add_Accom_Unshared_Whole_House_Or_Bungalow_Detached( c, target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Detached );
      Add_Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached( c, target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached );
      Add_Accom_Unshared_Whole_House_Or_Bungalow_Terraced( c, target_candidates.Accom_Unshared_Whole_House_Or_Bungalow_Terraced );
      Add_Accom_Unshared_Flat_Maisonette_Or_Apartment_Total( c, target_candidates.Accom_Unshared_Flat_Maisonette_Or_Apartment_Total );
      Add_Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement( c, target_candidates.Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement );
      Add_Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House( c, target_candidates.Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House );
      Add_Accom_Unshared_Flat_Etc_In_Commercial_Building( c, target_candidates.Accom_Unshared_Flat_Etc_In_Commercial_Building );
      Add_Accom_Unshared_Caravan_Etc( c, target_candidates.Accom_Unshared_Caravan_Etc );
      Add_Accom_Shared( c, target_candidates.Accom_Shared );
      Add_Ec_Act_All_Categories_Economic_Activity( c, target_candidates.Ec_Act_All_Categories_Economic_Activity );
      Add_Ec_Act_Active_Total( c, target_candidates.Ec_Act_Active_Total );
      Add_Ec_Act_Active_Employee_Part_Time( c, target_candidates.Ec_Act_Active_Employee_Part_Time );
      Add_Ec_Act_Active_Employee_Full_Time( c, target_candidates.Ec_Act_Active_Employee_Full_Time );
      Add_Ec_Act_Active_Self_Employed_With_Employees_Part_Time( c, target_candidates.Ec_Act_Active_Self_Employed_With_Employees_Part_Time );
      Add_Ec_Act_Active_Self_Employed_With_Employees_Full_Time( c, target_candidates.Ec_Act_Active_Self_Employed_With_Employees_Full_Time );
      Add_Ec_Act_Active_Self_Employed_Without_Employees_Part_Time( c, target_candidates.Ec_Act_Active_Self_Employed_Without_Employees_Part_Time );
      Add_Ec_Act_Active_Self_Employed_Without_Employees_Full_Time( c, target_candidates.Ec_Act_Active_Self_Employed_Without_Employees_Full_Time );
      Add_Ec_Act_Active_Unemployed( c, target_candidates.Ec_Act_Active_Unemployed );
      Add_Ec_Act_Active_Full_Time_Student( c, target_candidates.Ec_Act_Active_Full_Time_Student );
      Add_Ec_Act_Inactive_Total( c, target_candidates.Ec_Act_Inactive_Total );
      Add_Ec_Act_Inactive_Retired( c, target_candidates.Ec_Act_Inactive_Retired );
      Add_Ec_Act_Inactive_Student_Including_Full_Time_Students( c, target_candidates.Ec_Act_Inactive_Student_Including_Full_Time_Students );
      Add_Ec_Act_Inactive_Looking_After_Home_Or_Family( c, target_candidates.Ec_Act_Inactive_Looking_After_Home_Or_Family );
      Add_Ec_Act_Inactive_Long_Term_Sick_Or_Disabled( c, target_candidates.Ec_Act_Inactive_Long_Term_Sick_Or_Disabled );
      Add_Ec_Act_Inactive_Other( c, target_candidates.Ec_Act_Inactive_Other );
      Add_Ethgrp_All_Categories_Ethnic_Group( c, target_candidates.Ethgrp_All_Categories_Ethnic_Group );
      Add_Ethgrp_White( c, target_candidates.Ethgrp_White );
      Add_Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British( c, target_candidates.Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British );
      Add_Ethgrp_White_Irish( c, target_candidates.Ethgrp_White_Irish );
      Add_Ethgrp_White_Gypsy_Or_Irish_Traveller( c, target_candidates.Ethgrp_White_Gypsy_Or_Irish_Traveller );
      Add_Ethgrp_White_Other_White( c, target_candidates.Ethgrp_White_Other_White );
      Add_Ethgrp_Mixed( c, target_candidates.Ethgrp_Mixed );
      Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean( c, target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean );
      Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African( c, target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African );
      Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian( c, target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian );
      Add_Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed( c, target_candidates.Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed );
      Add_Ethgrp_Asian( c, target_candidates.Ethgrp_Asian );
      Add_Ethgrp_Asian_Asian_British_Indian( c, target_candidates.Ethgrp_Asian_Asian_British_Indian );
      Add_Ethgrp_Asian_Asian_British_Pakistani( c, target_candidates.Ethgrp_Asian_Asian_British_Pakistani );
      Add_Ethgrp_Asian_Asian_British_Bangladeshi( c, target_candidates.Ethgrp_Asian_Asian_British_Bangladeshi );
      Add_Ethgrp_Asian_Asian_British_Chinese( c, target_candidates.Ethgrp_Asian_Asian_British_Chinese );
      Add_Ethgrp_Asian_Asian_British_Other_Asian( c, target_candidates.Ethgrp_Asian_Asian_British_Other_Asian );
      Add_Ethgrp_Black( c, target_candidates.Ethgrp_Black );
      Add_Ethgrp_Black_African_Caribbean_Black_British_African( c, target_candidates.Ethgrp_Black_African_Caribbean_Black_British_African );
      Add_Ethgrp_Black_African_Caribbean_Black_British_Caribbean( c, target_candidates.Ethgrp_Black_African_Caribbean_Black_British_Caribbean );
      Add_Ethgrp_Black_African_Caribbean_Black_British_Other_Black( c, target_candidates.Ethgrp_Black_African_Caribbean_Black_British_Other_Black );
      Add_Ethgrp_Other( c, target_candidates.Ethgrp_Other );
      Add_Ethgrp_Other_Ethnic_Group_Arab( c, target_candidates.Ethgrp_Other_Ethnic_Group_Arab );
      Add_Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group( c, target_candidates.Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group );
      Add_Hcomp_All_Categories_Household_Composition( c, target_candidates.Hcomp_All_Categories_Household_Composition );
      Add_Hcomp_One_Person_Household_Total( c, target_candidates.Hcomp_One_Person_Household_Total );
      Add_Hcomp_One_Person_Household_Aged_65_And_Over( c, target_candidates.Hcomp_One_Person_Household_Aged_65_And_Over );
      Add_Hcomp_One_Person_Household_Other( c, target_candidates.Hcomp_One_Person_Household_Other );
      Add_Hcomp_One_Family_Only_Total( c, target_candidates.Hcomp_One_Family_Only_Total );
      Add_Hcomp_One_Family_Only_All_Aged_65_And_Over( c, target_candidates.Hcomp_One_Family_Only_All_Aged_65_And_Over );
      Add_Hcomp_One_Family_Only_Married_Cple_Total( c, target_candidates.Hcomp_One_Family_Only_Married_Cple_Total );
      Add_Hcomp_One_Family_Only_Married_Cple_No_Kids( c, target_candidates.Hcomp_One_Family_Only_Married_Cple_No_Kids );
      Add_Hcomp_One_Family_Only_Married_Cple_One_Dep_Child( c, target_candidates.Hcomp_One_Family_Only_Married_Cple_One_Dep_Child );
      Add_Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids( c, target_candidates.Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids );
      Add_Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep( c, target_candidates.Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep );
      Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total( c, target_candidates.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total );
      Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids( c, target_candidates.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids );
      Add_Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child( c, target_candidates.Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child );
      Add_Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids( c, target_candidates.Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids );
      Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep( c, target_candidates.Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_Total( c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_Total );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids( c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child( c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids( c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids );
      Add_Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep( c, target_candidates.Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep );
      Add_Hcomp_One_Family_Only_Lone_Parent_Total( c, target_candidates.Hcomp_One_Family_Only_Lone_Parent_Total );
      Add_Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child( c, target_candidates.Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child );
      Add_Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids( c, target_candidates.Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids );
      Add_Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep( c, target_candidates.Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep );
      Add_Hcomp_Other_Total( c, target_candidates.Hcomp_Other_Total );
      Add_Hcomp_Other_With_One_Dep_Child( c, target_candidates.Hcomp_Other_With_One_Dep_Child );
      Add_Hcomp_Other_With_Two_Or_More_Dep_Kids( c, target_candidates.Hcomp_Other_With_Two_Or_More_Dep_Kids );
      Add_Hcomp_Other_All_Full_Time_Students( c, target_candidates.Hcomp_Other_All_Full_Time_Students );
      Add_Hcomp_Other_All_Aged_65_And_Over( c, target_candidates.Hcomp_Other_All_Aged_65_And_Over );
      Add_Hcomp_Other_Other( c, target_candidates.Hcomp_Other_Other );
      Add_Number_Of_Rooms_All_Categories_Number_Of_Rooms( c, target_candidates.Number_Of_Rooms_All_Categories_Number_Of_Rooms );
      Add_Number_Of_Rooms_1_Room( c, target_candidates.Number_Of_Rooms_1_Room );
      Add_Number_Of_Rooms_2_Rooms( c, target_candidates.Number_Of_Rooms_2_Rooms );
      Add_Number_Of_Rooms_3_Rooms( c, target_candidates.Number_Of_Rooms_3_Rooms );
      Add_Number_Of_Rooms_4_Rooms( c, target_candidates.Number_Of_Rooms_4_Rooms );
      Add_Number_Of_Rooms_5_Rooms( c, target_candidates.Number_Of_Rooms_5_Rooms );
      Add_Number_Of_Rooms_6_Rooms( c, target_candidates.Number_Of_Rooms_6_Rooms );
      Add_Number_Of_Rooms_7_Rooms( c, target_candidates.Number_Of_Rooms_7_Rooms );
      Add_Number_Of_Rooms_8_Rooms( c, target_candidates.Number_Of_Rooms_8_Rooms );
      Add_Number_Of_Rooms_9_Or_More_Rooms( c, target_candidates.Number_Of_Rooms_9_Or_More_Rooms );
      Add_Residence_All_Categories_Residence_Type( c, target_candidates.Residence_All_Categories_Residence_Type );
      Add_Residence_Lives_In_A_Household( c, target_candidates.Residence_Lives_In_A_Household );
      Add_Residence_Lives_In_A_Communal_Establishment( c, target_candidates.Residence_Lives_In_A_Communal_Establishment );
      Add_Residence_Communal_Establishments_With_Persons_Sleeping_Rough( c, target_candidates.Residence_Communal_Establishments_With_Persons_Sleeping_Rough );
      Add_Tenure_All_Categories_Tenure( c, target_candidates.Tenure_All_Categories_Tenure );
      Add_Tenure_Owned_Total( c, target_candidates.Tenure_Owned_Total );
      Add_Tenure_Owned_Owned_Outright( c, target_candidates.Tenure_Owned_Owned_Outright );
      Add_Tenure_Owned_Owned_With_A_Mortgage_Or_Loan( c, target_candidates.Tenure_Owned_Owned_With_A_Mortgage_Or_Loan );
      Add_Tenure_Shared_Ownership_Part_Owned_And_Part_Rented( c, target_candidates.Tenure_Shared_Ownership_Part_Owned_And_Part_Rented );
      Add_Tenure_Social_Rented_Total( c, target_candidates.Tenure_Social_Rented_Total );
      Add_Tenure_Social_Rented_Rented_From_Council_Local_Authority( c, target_candidates.Tenure_Social_Rented_Rented_From_Council_Local_Authority );
      Add_Tenure_Social_Rented_Other_Social_Rented( c, target_candidates.Tenure_Social_Rented_Other_Social_Rented );
      Add_Tenure_Private_Rented_Total( c, target_candidates.Tenure_Private_Rented_Total );
      Add_Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency( c, target_candidates.Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency );
      Add_Tenure_Private_Rented_Employer_Of_A_Household_Member( c, target_candidates.Tenure_Private_Rented_Employer_Of_A_Household_Member );
      Add_Tenure_Private_Rented_Relative_Or_Friend_Of_Household( c, target_candidates.Tenure_Private_Rented_Relative_Or_Friend_Of_Household );
      Add_Tenure_Private_Rented_Other( c, target_candidates.Tenure_Private_Rented_Other );
      Add_Tenure_Living_Rent_Free( c, target_candidates.Tenure_Living_Rent_Free );
      Add_Occupation_All_Categories_Occupation( c, target_candidates.Occupation_All_Categories_Occupation );
      Add_Occupation_1_Managers_Directors_And_Senior_Officials( c, target_candidates.Occupation_1_Managers_Directors_And_Senior_Officials );
      Add_Occupation_2_Professional_Occupations( c, target_candidates.Occupation_2_Professional_Occupations );
      Add_Occupation_3_Associate_Professional_And_Technical_Occupations( c, target_candidates.Occupation_3_Associate_Professional_And_Technical_Occupations );
      Add_Occupation_4_Administrative_And_Secretarial_Occupations( c, target_candidates.Occupation_4_Administrative_And_Secretarial_Occupations );
      Add_Occupation_5_Skilled_Trades_Occupations( c, target_candidates.Occupation_5_Skilled_Trades_Occupations );
      Add_Occupation_6_Caring_Leisure_And_Other_Service_Occupations( c, target_candidates.Occupation_6_Caring_Leisure_And_Other_Service_Occupations );
      Add_Occupation_7_Sales_And_Customer_Service_Occupations( c, target_candidates.Occupation_7_Sales_And_Customer_Service_Occupations );
      Add_Occupation_8_Process_Plant_And_Machine_Operatives( c, target_candidates.Occupation_8_Process_Plant_And_Machine_Operatives );
      Add_Occupation_9_Elementary_Occupations( c, target_candidates.Occupation_9_Elementary_Occupations );
      Add_Income_Support_People_Claiming_Benefit( c, target_candidates.Income_Support_People_Claiming_Benefit );
      Add_Income_Support_Average_Weekly_Payment( c, target_candidates.Income_Support_Average_Weekly_Payment );
      Add_Jsa_Total( c, target_candidates.Jsa_Total );
      Add_Pension_Credits_Number_Of_Claimants( c, target_candidates.Pension_Credits_Number_Of_Claimants );
      Add_Pension_Credits_Number_Of_Beneficiaries( c, target_candidates.Pension_Credits_Number_Of_Beneficiaries );
      Add_Pension_Credits_Average_Weekly_Payment( c, target_candidates.Pension_Credits_Average_Weekly_Payment );
      Add_Out_Of_Work_Families( c, target_candidates.Out_Of_Work_Families );
      Add_Out_Of_Work_Children( c, target_candidates.Out_Of_Work_Children );
      Add_Wtc_And_Ctc_Families( c, target_candidates.Wtc_And_Ctc_Families );
      Add_Wtc_And_Ctc_Children( c, target_candidates.Wtc_And_Ctc_Children );
      Add_Ctc_Only_Families( c, target_candidates.Ctc_Only_Families );
      Add_Ctc_Only_Children( c, target_candidates.Ctc_Only_Children );
      Add_Childcare_Element( c, target_candidates.Childcare_Element );
      Add_Credits_No_Children( c, target_candidates.Credits_No_Children );
      Add_Credits_Total_Families( c, target_candidates.Credits_Total_Families );
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
   -- Delete the given record. Throws DB_Exception exception. Sets value to La_Data_Data.Null_Target_Candidates_Type
   --

   procedure Delete( target_candidates : in out La_Data_Data.Target_Candidates_Type; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_Id( c, target_candidates.Id );
      Add_Code( c, target_candidates.Code );
      Add_Edition( c, target_candidates.Edition );
      Delete( c, connection );
      target_candidates := La_Data_Data.Null_Target_Candidates_Type;
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

   --
   -- functions to add something to a criteria
   --
   procedure Add_Id( c : in out d.Criteria; Id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "id", op, join, Id );
   begin
      d.add_to_criteria( c, elem );
   end Add_Id;


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


   procedure Add_Edition( c : in out d.Criteria; Edition : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "edition", op, join, Edition );
   begin
      d.add_to_criteria( c, elem );
   end Add_Edition;


   procedure Add_Frs_Region( c : in out d.Criteria; Frs_Region : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "frs_region", op, join, Frs_Region );
   begin
      d.add_to_criteria( c, elem );
   end Add_Frs_Region;


   procedure Add_Hb_Total( c : in out d.Criteria; Hb_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hb_total", op, join, Hb_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Total;


   procedure Add_Hb_Social_Rented_Sector( c : in out d.Criteria; Hb_Social_Rented_Sector : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hb_social_rented_sector", op, join, Hb_Social_Rented_Sector );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Social_Rented_Sector;


   procedure Add_Hb_Private_Rented_Sector( c : in out d.Criteria; Hb_Private_Rented_Sector : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hb_private_rented_sector", op, join, Hb_Private_Rented_Sector );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Private_Rented_Sector;


   procedure Add_Hb_Passported( c : in out d.Criteria; Hb_Passported : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hb_passported", op, join, Hb_Passported );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Passported;


   procedure Add_Hb_Non_Passported( c : in out d.Criteria; Hb_Non_Passported : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hb_non_passported", op, join, Hb_Non_Passported );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Non_Passported;


   procedure Add_Ct_All( c : in out d.Criteria; Ct_All : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ct_all", op, join, Ct_All );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ct_All;


   procedure Add_Ct_Passported( c : in out d.Criteria; Ct_Passported : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ct_passported", op, join, Ct_Passported );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ct_Passported;


   procedure Add_Ct_Non_Passported( c : in out d.Criteria; Ct_Non_Passported : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ct_non_passported", op, join, Ct_Non_Passported );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ct_Non_Passported;


   procedure Add_Genders_All_Usual_Residents( c : in out d.Criteria; Genders_All_Usual_Residents : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "genders_all_usual_residents", op, join, Genders_All_Usual_Residents );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_All_Usual_Residents;


   procedure Add_Genders_Males( c : in out d.Criteria; Genders_Males : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "genders_males", op, join, Genders_Males );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Males;


   procedure Add_Genders_Females( c : in out d.Criteria; Genders_Females : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "genders_females", op, join, Genders_Females );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Females;


   procedure Add_Genders_Lives_In_A_Household( c : in out d.Criteria; Genders_Lives_In_A_Household : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "genders_lives_in_a_household", op, join, Genders_Lives_In_A_Household );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Lives_In_A_Household;


   procedure Add_Genders_Lives_In_A_Communal_Establishment( c : in out d.Criteria; Genders_Lives_In_A_Communal_Establishment : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "genders_lives_in_a_communal_establishment", op, join, Genders_Lives_In_A_Communal_Establishment );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Lives_In_A_Communal_Establishment;


   procedure Add_Genders_Schoolchild_Or_Student_Non_Term_Time_Address( c : in out d.Criteria; Genders_Schoolchild_Or_Student_Non_Term_Time_Address : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "genders_schoolchild_or_student_non_term_time_address", op, join, Genders_Schoolchild_Or_Student_Non_Term_Time_Address );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Schoolchild_Or_Student_Non_Term_Time_Address;


   procedure Add_Age_Ranges_All_Categories_Age( c : in out d.Criteria; Age_Ranges_All_Categories_Age : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_all_categories_age", op, join, Age_Ranges_All_Categories_Age );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_All_Categories_Age;


   procedure Add_Age_Ranges_Age_Under_1( c : in out d.Criteria; Age_Ranges_Age_Under_1 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_under_1", op, join, Age_Ranges_Age_Under_1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_Under_1;


   procedure Add_Age_Ranges_Age_1( c : in out d.Criteria; Age_Ranges_Age_1 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_1", op, join, Age_Ranges_Age_1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_1;


   procedure Add_Age_Ranges_Age_2( c : in out d.Criteria; Age_Ranges_Age_2 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_2", op, join, Age_Ranges_Age_2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_2;


   procedure Add_Age_Ranges_Age_3( c : in out d.Criteria; Age_Ranges_Age_3 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_3", op, join, Age_Ranges_Age_3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_3;


   procedure Add_Age_Ranges_Age_4( c : in out d.Criteria; Age_Ranges_Age_4 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_4", op, join, Age_Ranges_Age_4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_4;


   procedure Add_Age_Ranges_Age_5( c : in out d.Criteria; Age_Ranges_Age_5 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_5", op, join, Age_Ranges_Age_5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_5;


   procedure Add_Age_Ranges_Age_6( c : in out d.Criteria; Age_Ranges_Age_6 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_6", op, join, Age_Ranges_Age_6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_6;


   procedure Add_Age_Ranges_Age_7( c : in out d.Criteria; Age_Ranges_Age_7 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_7", op, join, Age_Ranges_Age_7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_7;


   procedure Add_Age_Ranges_Age_8( c : in out d.Criteria; Age_Ranges_Age_8 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_8", op, join, Age_Ranges_Age_8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_8;


   procedure Add_Age_Ranges_Age_9( c : in out d.Criteria; Age_Ranges_Age_9 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_9", op, join, Age_Ranges_Age_9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_9;


   procedure Add_Age_Ranges_Age_10( c : in out d.Criteria; Age_Ranges_Age_10 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_10", op, join, Age_Ranges_Age_10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_10;


   procedure Add_Age_Ranges_Age_11( c : in out d.Criteria; Age_Ranges_Age_11 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_11", op, join, Age_Ranges_Age_11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_11;


   procedure Add_Age_Ranges_Age_12( c : in out d.Criteria; Age_Ranges_Age_12 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_12", op, join, Age_Ranges_Age_12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_12;


   procedure Add_Age_Ranges_Age_13( c : in out d.Criteria; Age_Ranges_Age_13 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_13", op, join, Age_Ranges_Age_13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_13;


   procedure Add_Age_Ranges_Age_14( c : in out d.Criteria; Age_Ranges_Age_14 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_14", op, join, Age_Ranges_Age_14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_14;


   procedure Add_Age_Ranges_Age_15( c : in out d.Criteria; Age_Ranges_Age_15 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_15", op, join, Age_Ranges_Age_15 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_15;


   procedure Add_Age_Ranges_Age_16( c : in out d.Criteria; Age_Ranges_Age_16 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_16", op, join, Age_Ranges_Age_16 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_16;


   procedure Add_Age_Ranges_Age_17( c : in out d.Criteria; Age_Ranges_Age_17 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_17", op, join, Age_Ranges_Age_17 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_17;


   procedure Add_Age_Ranges_Age_18( c : in out d.Criteria; Age_Ranges_Age_18 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_18", op, join, Age_Ranges_Age_18 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_18;


   procedure Add_Age_Ranges_Age_19( c : in out d.Criteria; Age_Ranges_Age_19 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_19", op, join, Age_Ranges_Age_19 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_19;


   procedure Add_Age_Ranges_Age_20( c : in out d.Criteria; Age_Ranges_Age_20 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_20", op, join, Age_Ranges_Age_20 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_20;


   procedure Add_Age_Ranges_Age_21( c : in out d.Criteria; Age_Ranges_Age_21 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_21", op, join, Age_Ranges_Age_21 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_21;


   procedure Add_Age_Ranges_Age_22( c : in out d.Criteria; Age_Ranges_Age_22 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_22", op, join, Age_Ranges_Age_22 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_22;


   procedure Add_Age_Ranges_Age_23( c : in out d.Criteria; Age_Ranges_Age_23 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_23", op, join, Age_Ranges_Age_23 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_23;


   procedure Add_Age_Ranges_Age_24( c : in out d.Criteria; Age_Ranges_Age_24 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_24", op, join, Age_Ranges_Age_24 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_24;


   procedure Add_Age_Ranges_Age_25( c : in out d.Criteria; Age_Ranges_Age_25 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_25", op, join, Age_Ranges_Age_25 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_25;


   procedure Add_Age_Ranges_Age_26( c : in out d.Criteria; Age_Ranges_Age_26 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_26", op, join, Age_Ranges_Age_26 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_26;


   procedure Add_Age_Ranges_Age_27( c : in out d.Criteria; Age_Ranges_Age_27 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_27", op, join, Age_Ranges_Age_27 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_27;


   procedure Add_Age_Ranges_Age_28( c : in out d.Criteria; Age_Ranges_Age_28 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_28", op, join, Age_Ranges_Age_28 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_28;


   procedure Add_Age_Ranges_Age_29( c : in out d.Criteria; Age_Ranges_Age_29 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_29", op, join, Age_Ranges_Age_29 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_29;


   procedure Add_Age_Ranges_Age_30( c : in out d.Criteria; Age_Ranges_Age_30 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_30", op, join, Age_Ranges_Age_30 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_30;


   procedure Add_Age_Ranges_Age_31( c : in out d.Criteria; Age_Ranges_Age_31 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_31", op, join, Age_Ranges_Age_31 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_31;


   procedure Add_Age_Ranges_Age_32( c : in out d.Criteria; Age_Ranges_Age_32 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_32", op, join, Age_Ranges_Age_32 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_32;


   procedure Add_Age_Ranges_Age_33( c : in out d.Criteria; Age_Ranges_Age_33 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_33", op, join, Age_Ranges_Age_33 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_33;


   procedure Add_Age_Ranges_Age_34( c : in out d.Criteria; Age_Ranges_Age_34 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_34", op, join, Age_Ranges_Age_34 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_34;


   procedure Add_Age_Ranges_Age_35( c : in out d.Criteria; Age_Ranges_Age_35 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_35", op, join, Age_Ranges_Age_35 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_35;


   procedure Add_Age_Ranges_Age_36( c : in out d.Criteria; Age_Ranges_Age_36 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_36", op, join, Age_Ranges_Age_36 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_36;


   procedure Add_Age_Ranges_Age_37( c : in out d.Criteria; Age_Ranges_Age_37 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_37", op, join, Age_Ranges_Age_37 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_37;


   procedure Add_Age_Ranges_Age_38( c : in out d.Criteria; Age_Ranges_Age_38 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_38", op, join, Age_Ranges_Age_38 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_38;


   procedure Add_Age_Ranges_Age_39( c : in out d.Criteria; Age_Ranges_Age_39 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_39", op, join, Age_Ranges_Age_39 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_39;


   procedure Add_Age_Ranges_Age_40( c : in out d.Criteria; Age_Ranges_Age_40 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_40", op, join, Age_Ranges_Age_40 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_40;


   procedure Add_Age_Ranges_Age_41( c : in out d.Criteria; Age_Ranges_Age_41 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_41", op, join, Age_Ranges_Age_41 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_41;


   procedure Add_Age_Ranges_Age_42( c : in out d.Criteria; Age_Ranges_Age_42 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_42", op, join, Age_Ranges_Age_42 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_42;


   procedure Add_Age_Ranges_Age_43( c : in out d.Criteria; Age_Ranges_Age_43 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_43", op, join, Age_Ranges_Age_43 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_43;


   procedure Add_Age_Ranges_Age_44( c : in out d.Criteria; Age_Ranges_Age_44 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_44", op, join, Age_Ranges_Age_44 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_44;


   procedure Add_Age_Ranges_Age_45( c : in out d.Criteria; Age_Ranges_Age_45 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_45", op, join, Age_Ranges_Age_45 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_45;


   procedure Add_Age_Ranges_Age_46( c : in out d.Criteria; Age_Ranges_Age_46 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_46", op, join, Age_Ranges_Age_46 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_46;


   procedure Add_Age_Ranges_Age_47( c : in out d.Criteria; Age_Ranges_Age_47 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_47", op, join, Age_Ranges_Age_47 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_47;


   procedure Add_Age_Ranges_Age_48( c : in out d.Criteria; Age_Ranges_Age_48 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_48", op, join, Age_Ranges_Age_48 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_48;


   procedure Add_Age_Ranges_Age_49( c : in out d.Criteria; Age_Ranges_Age_49 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_49", op, join, Age_Ranges_Age_49 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_49;


   procedure Add_Age_Ranges_Age_50( c : in out d.Criteria; Age_Ranges_Age_50 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_50", op, join, Age_Ranges_Age_50 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_50;


   procedure Add_Age_Ranges_Age_51( c : in out d.Criteria; Age_Ranges_Age_51 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_51", op, join, Age_Ranges_Age_51 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_51;


   procedure Add_Age_Ranges_Age_52( c : in out d.Criteria; Age_Ranges_Age_52 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_52", op, join, Age_Ranges_Age_52 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_52;


   procedure Add_Age_Ranges_Age_53( c : in out d.Criteria; Age_Ranges_Age_53 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_53", op, join, Age_Ranges_Age_53 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_53;


   procedure Add_Age_Ranges_Age_54( c : in out d.Criteria; Age_Ranges_Age_54 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_54", op, join, Age_Ranges_Age_54 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_54;


   procedure Add_Age_Ranges_Age_55( c : in out d.Criteria; Age_Ranges_Age_55 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_55", op, join, Age_Ranges_Age_55 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_55;


   procedure Add_Age_Ranges_Age_56( c : in out d.Criteria; Age_Ranges_Age_56 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_56", op, join, Age_Ranges_Age_56 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_56;


   procedure Add_Age_Ranges_Age_57( c : in out d.Criteria; Age_Ranges_Age_57 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_57", op, join, Age_Ranges_Age_57 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_57;


   procedure Add_Age_Ranges_Age_58( c : in out d.Criteria; Age_Ranges_Age_58 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_58", op, join, Age_Ranges_Age_58 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_58;


   procedure Add_Age_Ranges_Age_59( c : in out d.Criteria; Age_Ranges_Age_59 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_59", op, join, Age_Ranges_Age_59 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_59;


   procedure Add_Age_Ranges_Age_60( c : in out d.Criteria; Age_Ranges_Age_60 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_60", op, join, Age_Ranges_Age_60 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_60;


   procedure Add_Age_Ranges_Age_61( c : in out d.Criteria; Age_Ranges_Age_61 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_61", op, join, Age_Ranges_Age_61 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_61;


   procedure Add_Age_Ranges_Age_62( c : in out d.Criteria; Age_Ranges_Age_62 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_62", op, join, Age_Ranges_Age_62 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_62;


   procedure Add_Age_Ranges_Age_63( c : in out d.Criteria; Age_Ranges_Age_63 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_63", op, join, Age_Ranges_Age_63 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_63;


   procedure Add_Age_Ranges_Age_64( c : in out d.Criteria; Age_Ranges_Age_64 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_64", op, join, Age_Ranges_Age_64 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_64;


   procedure Add_Age_Ranges_Age_65( c : in out d.Criteria; Age_Ranges_Age_65 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_65", op, join, Age_Ranges_Age_65 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_65;


   procedure Add_Age_Ranges_Age_66( c : in out d.Criteria; Age_Ranges_Age_66 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_66", op, join, Age_Ranges_Age_66 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_66;


   procedure Add_Age_Ranges_Age_67( c : in out d.Criteria; Age_Ranges_Age_67 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_67", op, join, Age_Ranges_Age_67 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_67;


   procedure Add_Age_Ranges_Age_68( c : in out d.Criteria; Age_Ranges_Age_68 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_68", op, join, Age_Ranges_Age_68 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_68;


   procedure Add_Age_Ranges_Age_69( c : in out d.Criteria; Age_Ranges_Age_69 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_69", op, join, Age_Ranges_Age_69 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_69;


   procedure Add_Age_Ranges_Age_70( c : in out d.Criteria; Age_Ranges_Age_70 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_70", op, join, Age_Ranges_Age_70 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_70;


   procedure Add_Age_Ranges_Age_71( c : in out d.Criteria; Age_Ranges_Age_71 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_71", op, join, Age_Ranges_Age_71 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_71;


   procedure Add_Age_Ranges_Age_72( c : in out d.Criteria; Age_Ranges_Age_72 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_72", op, join, Age_Ranges_Age_72 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_72;


   procedure Add_Age_Ranges_Age_73( c : in out d.Criteria; Age_Ranges_Age_73 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_73", op, join, Age_Ranges_Age_73 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_73;


   procedure Add_Age_Ranges_Age_74( c : in out d.Criteria; Age_Ranges_Age_74 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_74", op, join, Age_Ranges_Age_74 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_74;


   procedure Add_Age_Ranges_Age_75( c : in out d.Criteria; Age_Ranges_Age_75 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_75", op, join, Age_Ranges_Age_75 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_75;


   procedure Add_Age_Ranges_Age_76( c : in out d.Criteria; Age_Ranges_Age_76 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_76", op, join, Age_Ranges_Age_76 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_76;


   procedure Add_Age_Ranges_Age_77( c : in out d.Criteria; Age_Ranges_Age_77 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_77", op, join, Age_Ranges_Age_77 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_77;


   procedure Add_Age_Ranges_Age_78( c : in out d.Criteria; Age_Ranges_Age_78 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_78", op, join, Age_Ranges_Age_78 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_78;


   procedure Add_Age_Ranges_Age_79( c : in out d.Criteria; Age_Ranges_Age_79 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_79", op, join, Age_Ranges_Age_79 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_79;


   procedure Add_Age_Ranges_Age_80( c : in out d.Criteria; Age_Ranges_Age_80 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_80", op, join, Age_Ranges_Age_80 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_80;


   procedure Add_Age_Ranges_Age_81( c : in out d.Criteria; Age_Ranges_Age_81 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_81", op, join, Age_Ranges_Age_81 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_81;


   procedure Add_Age_Ranges_Age_82( c : in out d.Criteria; Age_Ranges_Age_82 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_82", op, join, Age_Ranges_Age_82 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_82;


   procedure Add_Age_Ranges_Age_83( c : in out d.Criteria; Age_Ranges_Age_83 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_83", op, join, Age_Ranges_Age_83 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_83;


   procedure Add_Age_Ranges_Age_84( c : in out d.Criteria; Age_Ranges_Age_84 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_84", op, join, Age_Ranges_Age_84 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_84;


   procedure Add_Age_Ranges_Age_85( c : in out d.Criteria; Age_Ranges_Age_85 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_85", op, join, Age_Ranges_Age_85 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_85;


   procedure Add_Age_Ranges_Age_86( c : in out d.Criteria; Age_Ranges_Age_86 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_86", op, join, Age_Ranges_Age_86 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_86;


   procedure Add_Age_Ranges_Age_87( c : in out d.Criteria; Age_Ranges_Age_87 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_87", op, join, Age_Ranges_Age_87 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_87;


   procedure Add_Age_Ranges_Age_88( c : in out d.Criteria; Age_Ranges_Age_88 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_88", op, join, Age_Ranges_Age_88 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_88;


   procedure Add_Age_Ranges_Age_89( c : in out d.Criteria; Age_Ranges_Age_89 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_89", op, join, Age_Ranges_Age_89 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_89;


   procedure Add_Age_Ranges_Age_90( c : in out d.Criteria; Age_Ranges_Age_90 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_90", op, join, Age_Ranges_Age_90 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_90;


   procedure Add_Age_Ranges_Age_91( c : in out d.Criteria; Age_Ranges_Age_91 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_91", op, join, Age_Ranges_Age_91 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_91;


   procedure Add_Age_Ranges_Age_92( c : in out d.Criteria; Age_Ranges_Age_92 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_92", op, join, Age_Ranges_Age_92 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_92;


   procedure Add_Age_Ranges_Age_93( c : in out d.Criteria; Age_Ranges_Age_93 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_93", op, join, Age_Ranges_Age_93 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_93;


   procedure Add_Age_Ranges_Age_94( c : in out d.Criteria; Age_Ranges_Age_94 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_94", op, join, Age_Ranges_Age_94 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_94;


   procedure Add_Age_Ranges_Age_95( c : in out d.Criteria; Age_Ranges_Age_95 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_95", op, join, Age_Ranges_Age_95 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_95;


   procedure Add_Age_Ranges_Age_96( c : in out d.Criteria; Age_Ranges_Age_96 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_96", op, join, Age_Ranges_Age_96 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_96;


   procedure Add_Age_Ranges_Age_97( c : in out d.Criteria; Age_Ranges_Age_97 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_97", op, join, Age_Ranges_Age_97 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_97;


   procedure Add_Age_Ranges_Age_98( c : in out d.Criteria; Age_Ranges_Age_98 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_98", op, join, Age_Ranges_Age_98 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_98;


   procedure Add_Age_Ranges_Age_99( c : in out d.Criteria; Age_Ranges_Age_99 : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_99", op, join, Age_Ranges_Age_99 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_99;


   procedure Add_Age_Ranges_Age_100_And_Over( c : in out d.Criteria; Age_Ranges_Age_100_And_Over : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "age_ranges_age_100_and_over", op, join, Age_Ranges_Age_100_And_Over );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_100_And_Over;


   procedure Add_Accom_All_Categories_Accommodation_Type( c : in out d.Criteria; Accom_All_Categories_Accommodation_Type : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_all_categories_accommodation_type", op, join, Accom_All_Categories_Accommodation_Type );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_All_Categories_Accommodation_Type;


   procedure Add_Accom_Unshared_Total( c : in out d.Criteria; Accom_Unshared_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_total", op, join, Accom_Unshared_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Total;


   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Total( c : in out d.Criteria; Accom_Unshared_Whole_House_Or_Bungalow_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_whole_house_or_bungalow_total", op, join, Accom_Unshared_Whole_House_Or_Bungalow_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Whole_House_Or_Bungalow_Total;


   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Detached( c : in out d.Criteria; Accom_Unshared_Whole_House_Or_Bungalow_Detached : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_whole_house_or_bungalow_detached", op, join, Accom_Unshared_Whole_House_Or_Bungalow_Detached );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Whole_House_Or_Bungalow_Detached;


   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached( c : in out d.Criteria; Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_whole_house_or_bungalow_semi_detached", op, join, Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached;


   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Terraced( c : in out d.Criteria; Accom_Unshared_Whole_House_Or_Bungalow_Terraced : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_whole_house_or_bungalow_terraced", op, join, Accom_Unshared_Whole_House_Or_Bungalow_Terraced );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Whole_House_Or_Bungalow_Terraced;


   procedure Add_Accom_Unshared_Flat_Maisonette_Or_Apartment_Total( c : in out d.Criteria; Accom_Unshared_Flat_Maisonette_Or_Apartment_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_flat_maisonette_or_apartment_total", op, join, Accom_Unshared_Flat_Maisonette_Or_Apartment_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Flat_Maisonette_Or_Apartment_Total;


   procedure Add_Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement( c : in out d.Criteria; Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_flat_etc_purpose_built_flats_or_tenement", op, join, Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement;


   procedure Add_Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House( c : in out d.Criteria; Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_flat_etc_part_of_a_converted_or_shared_house", op, join, Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House;


   procedure Add_Accom_Unshared_Flat_Etc_In_Commercial_Building( c : in out d.Criteria; Accom_Unshared_Flat_Etc_In_Commercial_Building : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_flat_etc_in_commercial_building", op, join, Accom_Unshared_Flat_Etc_In_Commercial_Building );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Flat_Etc_In_Commercial_Building;


   procedure Add_Accom_Unshared_Caravan_Etc( c : in out d.Criteria; Accom_Unshared_Caravan_Etc : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_unshared_caravan_etc", op, join, Accom_Unshared_Caravan_Etc );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Caravan_Etc;


   procedure Add_Accom_Shared( c : in out d.Criteria; Accom_Shared : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "accom_shared", op, join, Accom_Shared );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Shared;


   procedure Add_Ec_Act_All_Categories_Economic_Activity( c : in out d.Criteria; Ec_Act_All_Categories_Economic_Activity : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_all_categories_economic_activity", op, join, Ec_Act_All_Categories_Economic_Activity );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_All_Categories_Economic_Activity;


   procedure Add_Ec_Act_Active_Total( c : in out d.Criteria; Ec_Act_Active_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_active_total", op, join, Ec_Act_Active_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Total;


   procedure Add_Ec_Act_Active_Employee_Part_Time( c : in out d.Criteria; Ec_Act_Active_Employee_Part_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_active_employee_part_time", op, join, Ec_Act_Active_Employee_Part_Time );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Employee_Part_Time;


   procedure Add_Ec_Act_Active_Employee_Full_Time( c : in out d.Criteria; Ec_Act_Active_Employee_Full_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_active_employee_full_time", op, join, Ec_Act_Active_Employee_Full_Time );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Employee_Full_Time;


   procedure Add_Ec_Act_Active_Self_Employed_With_Employees_Part_Time( c : in out d.Criteria; Ec_Act_Active_Self_Employed_With_Employees_Part_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_active_self_employed_with_employees_part_time", op, join, Ec_Act_Active_Self_Employed_With_Employees_Part_Time );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Self_Employed_With_Employees_Part_Time;


   procedure Add_Ec_Act_Active_Self_Employed_With_Employees_Full_Time( c : in out d.Criteria; Ec_Act_Active_Self_Employed_With_Employees_Full_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_active_self_employed_with_employees_full_time", op, join, Ec_Act_Active_Self_Employed_With_Employees_Full_Time );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Self_Employed_With_Employees_Full_Time;


   procedure Add_Ec_Act_Active_Self_Employed_Without_Employees_Part_Time( c : in out d.Criteria; Ec_Act_Active_Self_Employed_Without_Employees_Part_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_active_self_employed_without_employees_part_time", op, join, Ec_Act_Active_Self_Employed_Without_Employees_Part_Time );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Self_Employed_Without_Employees_Part_Time;


   procedure Add_Ec_Act_Active_Self_Employed_Without_Employees_Full_Time( c : in out d.Criteria; Ec_Act_Active_Self_Employed_Without_Employees_Full_Time : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_active_self_employed_without_employees_full_time", op, join, Ec_Act_Active_Self_Employed_Without_Employees_Full_Time );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Self_Employed_Without_Employees_Full_Time;


   procedure Add_Ec_Act_Active_Unemployed( c : in out d.Criteria; Ec_Act_Active_Unemployed : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_active_unemployed", op, join, Ec_Act_Active_Unemployed );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Unemployed;


   procedure Add_Ec_Act_Active_Full_Time_Student( c : in out d.Criteria; Ec_Act_Active_Full_Time_Student : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_active_full_time_student", op, join, Ec_Act_Active_Full_Time_Student );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Full_Time_Student;


   procedure Add_Ec_Act_Inactive_Total( c : in out d.Criteria; Ec_Act_Inactive_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_inactive_total", op, join, Ec_Act_Inactive_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Total;


   procedure Add_Ec_Act_Inactive_Retired( c : in out d.Criteria; Ec_Act_Inactive_Retired : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_inactive_retired", op, join, Ec_Act_Inactive_Retired );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Retired;


   procedure Add_Ec_Act_Inactive_Student_Including_Full_Time_Students( c : in out d.Criteria; Ec_Act_Inactive_Student_Including_Full_Time_Students : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_inactive_student_including_full_time_students", op, join, Ec_Act_Inactive_Student_Including_Full_Time_Students );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Student_Including_Full_Time_Students;


   procedure Add_Ec_Act_Inactive_Looking_After_Home_Or_Family( c : in out d.Criteria; Ec_Act_Inactive_Looking_After_Home_Or_Family : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_inactive_looking_after_home_or_family", op, join, Ec_Act_Inactive_Looking_After_Home_Or_Family );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Looking_After_Home_Or_Family;


   procedure Add_Ec_Act_Inactive_Long_Term_Sick_Or_Disabled( c : in out d.Criteria; Ec_Act_Inactive_Long_Term_Sick_Or_Disabled : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_inactive_long_term_sick_or_disabled", op, join, Ec_Act_Inactive_Long_Term_Sick_Or_Disabled );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Long_Term_Sick_Or_Disabled;


   procedure Add_Ec_Act_Inactive_Other( c : in out d.Criteria; Ec_Act_Inactive_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ec_act_inactive_other", op, join, Ec_Act_Inactive_Other );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Other;


   procedure Add_Ethgrp_All_Categories_Ethnic_Group( c : in out d.Criteria; Ethgrp_All_Categories_Ethnic_Group : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_all_categories_ethnic_group", op, join, Ethgrp_All_Categories_Ethnic_Group );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_All_Categories_Ethnic_Group;


   procedure Add_Ethgrp_White( c : in out d.Criteria; Ethgrp_White : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_white", op, join, Ethgrp_White );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White;


   procedure Add_Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British( c : in out d.Criteria; Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_white_english_welsh_scottish_northern_irish_british", op, join, Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British;


   procedure Add_Ethgrp_White_Irish( c : in out d.Criteria; Ethgrp_White_Irish : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_white_irish", op, join, Ethgrp_White_Irish );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White_Irish;


   procedure Add_Ethgrp_White_Gypsy_Or_Irish_Traveller( c : in out d.Criteria; Ethgrp_White_Gypsy_Or_Irish_Traveller : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_white_gypsy_or_irish_traveller", op, join, Ethgrp_White_Gypsy_Or_Irish_Traveller );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White_Gypsy_Or_Irish_Traveller;


   procedure Add_Ethgrp_White_Other_White( c : in out d.Criteria; Ethgrp_White_Other_White : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_white_other_white", op, join, Ethgrp_White_Other_White );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White_Other_White;


   procedure Add_Ethgrp_Mixed( c : in out d.Criteria; Ethgrp_Mixed : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_mixed", op, join, Ethgrp_Mixed );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed;


   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean( c : in out d.Criteria; Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_mixed_multiple_ethnic_group_white_and_black_caribbean", op, join, Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean;


   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African( c : in out d.Criteria; Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_mixed_multiple_ethnic_group_white_and_black_african", op, join, Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African;


   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian( c : in out d.Criteria; Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_mixed_multiple_ethnic_group_white_and_asian", op, join, Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian;


   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed( c : in out d.Criteria; Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_mixed_multiple_ethnic_group_other_mixed", op, join, Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed;


   procedure Add_Ethgrp_Asian( c : in out d.Criteria; Ethgrp_Asian : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_asian", op, join, Ethgrp_Asian );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian;


   procedure Add_Ethgrp_Asian_Asian_British_Indian( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Indian : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_asian_asian_british_indian", op, join, Ethgrp_Asian_Asian_British_Indian );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Indian;


   procedure Add_Ethgrp_Asian_Asian_British_Pakistani( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Pakistani : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_asian_asian_british_pakistani", op, join, Ethgrp_Asian_Asian_British_Pakistani );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Pakistani;


   procedure Add_Ethgrp_Asian_Asian_British_Bangladeshi( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Bangladeshi : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_asian_asian_british_bangladeshi", op, join, Ethgrp_Asian_Asian_British_Bangladeshi );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Bangladeshi;


   procedure Add_Ethgrp_Asian_Asian_British_Chinese( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Chinese : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_asian_asian_british_chinese", op, join, Ethgrp_Asian_Asian_British_Chinese );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Chinese;


   procedure Add_Ethgrp_Asian_Asian_British_Other_Asian( c : in out d.Criteria; Ethgrp_Asian_Asian_British_Other_Asian : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_asian_asian_british_other_asian", op, join, Ethgrp_Asian_Asian_British_Other_Asian );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Other_Asian;


   procedure Add_Ethgrp_Black( c : in out d.Criteria; Ethgrp_Black : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_black", op, join, Ethgrp_Black );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Black;


   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_African( c : in out d.Criteria; Ethgrp_Black_African_Caribbean_Black_British_African : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_black_african_caribbean_black_british_african", op, join, Ethgrp_Black_African_Caribbean_Black_British_African );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Black_African_Caribbean_Black_British_African;


   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_Caribbean( c : in out d.Criteria; Ethgrp_Black_African_Caribbean_Black_British_Caribbean : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_black_african_caribbean_black_british_caribbean", op, join, Ethgrp_Black_African_Caribbean_Black_British_Caribbean );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Black_African_Caribbean_Black_British_Caribbean;


   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_Other_Black( c : in out d.Criteria; Ethgrp_Black_African_Caribbean_Black_British_Other_Black : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_black_african_caribbean_black_british_other_black", op, join, Ethgrp_Black_African_Caribbean_Black_British_Other_Black );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Black_African_Caribbean_Black_British_Other_Black;


   procedure Add_Ethgrp_Other( c : in out d.Criteria; Ethgrp_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_other", op, join, Ethgrp_Other );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Other;


   procedure Add_Ethgrp_Other_Ethnic_Group_Arab( c : in out d.Criteria; Ethgrp_Other_Ethnic_Group_Arab : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_other_ethnic_group_arab", op, join, Ethgrp_Other_Ethnic_Group_Arab );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Other_Ethnic_Group_Arab;


   procedure Add_Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group( c : in out d.Criteria; Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ethgrp_other_ethnic_group_any_other_ethnic_group", op, join, Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group;


   procedure Add_Hcomp_All_Categories_Household_Composition( c : in out d.Criteria; Hcomp_All_Categories_Household_Composition : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_all_categories_household_composition", op, join, Hcomp_All_Categories_Household_Composition );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_All_Categories_Household_Composition;


   procedure Add_Hcomp_One_Person_Household_Total( c : in out d.Criteria; Hcomp_One_Person_Household_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_person_household_total", op, join, Hcomp_One_Person_Household_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Person_Household_Total;


   procedure Add_Hcomp_One_Person_Household_Aged_65_And_Over( c : in out d.Criteria; Hcomp_One_Person_Household_Aged_65_And_Over : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_person_household_aged_65_and_over", op, join, Hcomp_One_Person_Household_Aged_65_And_Over );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Person_Household_Aged_65_And_Over;


   procedure Add_Hcomp_One_Person_Household_Other( c : in out d.Criteria; Hcomp_One_Person_Household_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_person_household_other", op, join, Hcomp_One_Person_Household_Other );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Person_Household_Other;


   procedure Add_Hcomp_One_Family_Only_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_total", op, join, Hcomp_One_Family_Only_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Total;


   procedure Add_Hcomp_One_Family_Only_All_Aged_65_And_Over( c : in out d.Criteria; Hcomp_One_Family_Only_All_Aged_65_And_Over : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_all_aged_65_and_over", op, join, Hcomp_One_Family_Only_All_Aged_65_And_Over );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_All_Aged_65_And_Over;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_married_cple_total", op, join, Hcomp_One_Family_Only_Married_Cple_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_Total;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_No_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_No_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_married_cple_no_kids", op, join, Hcomp_One_Family_Only_Married_Cple_No_Kids );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_No_Kids;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_One_Dep_Child( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_married_cple_one_dep_child", op, join, Hcomp_One_Family_Only_Married_Cple_One_Dep_Child );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_One_Dep_Child;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_married_cple_two_or_more_dep_kids", op, join, Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep( c : in out d.Criteria; Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_married_cple_all_kids_non_dep", op, join, Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep;


   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_same_sex_civ_part_cple_total", op, join, Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total;


   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_same_sex_civ_part_cple_no_kids", op, join, Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids;


   procedure Add_Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child( c : in out d.Criteria; Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_same_sex_civ_part_cple_one_dep_child", op, join, Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child;


   procedure Add_Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids( c : in out d.Criteria; Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_same_sex_civ_part_cple_two_plus_dep_kids", op, join, Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids;


   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep( c : in out d.Criteria; Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_same_sex_civ_part_cple_all_kids_non_dep", op, join, Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_cohabiting_cple_total", op, join, Hcomp_One_Family_Only_Cohabiting_Cple_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_Total;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_cohabiting_cple_no_kids", op, join, Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_cohabiting_cple_one_dep_child", op, join, Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_cohabiting_cple_two_or_more_dep_kids", op, join, Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep( c : in out d.Criteria; Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_cohabiting_cple_all_kids_non_dep", op, join, Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep;


   procedure Add_Hcomp_One_Family_Only_Lone_Parent_Total( c : in out d.Criteria; Hcomp_One_Family_Only_Lone_Parent_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_lone_parent_total", op, join, Hcomp_One_Family_Only_Lone_Parent_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Lone_Parent_Total;


   procedure Add_Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child( c : in out d.Criteria; Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_lone_parent_one_dep_child", op, join, Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child;


   procedure Add_Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids( c : in out d.Criteria; Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_lone_parent_two_or_more_dep_kids", op, join, Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids;


   procedure Add_Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep( c : in out d.Criteria; Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_one_family_only_lone_parent_all_kids_non_dep", op, join, Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep;


   procedure Add_Hcomp_Other_Total( c : in out d.Criteria; Hcomp_Other_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_other_total", op, join, Hcomp_Other_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_Total;


   procedure Add_Hcomp_Other_With_One_Dep_Child( c : in out d.Criteria; Hcomp_Other_With_One_Dep_Child : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_other_with_one_dep_child", op, join, Hcomp_Other_With_One_Dep_Child );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_With_One_Dep_Child;


   procedure Add_Hcomp_Other_With_Two_Or_More_Dep_Kids( c : in out d.Criteria; Hcomp_Other_With_Two_Or_More_Dep_Kids : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_other_with_two_or_more_dep_kids", op, join, Hcomp_Other_With_Two_Or_More_Dep_Kids );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_With_Two_Or_More_Dep_Kids;


   procedure Add_Hcomp_Other_All_Full_Time_Students( c : in out d.Criteria; Hcomp_Other_All_Full_Time_Students : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_other_all_full_time_students", op, join, Hcomp_Other_All_Full_Time_Students );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_All_Full_Time_Students;


   procedure Add_Hcomp_Other_All_Aged_65_And_Over( c : in out d.Criteria; Hcomp_Other_All_Aged_65_And_Over : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_other_all_aged_65_and_over", op, join, Hcomp_Other_All_Aged_65_And_Over );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_All_Aged_65_And_Over;


   procedure Add_Hcomp_Other_Other( c : in out d.Criteria; Hcomp_Other_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "hcomp_other_other", op, join, Hcomp_Other_Other );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_Other;


   procedure Add_Number_Of_Rooms_All_Categories_Number_Of_Rooms( c : in out d.Criteria; Number_Of_Rooms_All_Categories_Number_Of_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_all_categories_number_of_rooms", op, join, Number_Of_Rooms_All_Categories_Number_Of_Rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_All_Categories_Number_Of_Rooms;


   procedure Add_Number_Of_Rooms_1_Room( c : in out d.Criteria; Number_Of_Rooms_1_Room : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_1_room", op, join, Number_Of_Rooms_1_Room );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_1_Room;


   procedure Add_Number_Of_Rooms_2_Rooms( c : in out d.Criteria; Number_Of_Rooms_2_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_2_rooms", op, join, Number_Of_Rooms_2_Rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_2_Rooms;


   procedure Add_Number_Of_Rooms_3_Rooms( c : in out d.Criteria; Number_Of_Rooms_3_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_3_rooms", op, join, Number_Of_Rooms_3_Rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_3_Rooms;


   procedure Add_Number_Of_Rooms_4_Rooms( c : in out d.Criteria; Number_Of_Rooms_4_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_4_rooms", op, join, Number_Of_Rooms_4_Rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_4_Rooms;


   procedure Add_Number_Of_Rooms_5_Rooms( c : in out d.Criteria; Number_Of_Rooms_5_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_5_rooms", op, join, Number_Of_Rooms_5_Rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_5_Rooms;


   procedure Add_Number_Of_Rooms_6_Rooms( c : in out d.Criteria; Number_Of_Rooms_6_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_6_rooms", op, join, Number_Of_Rooms_6_Rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_6_Rooms;


   procedure Add_Number_Of_Rooms_7_Rooms( c : in out d.Criteria; Number_Of_Rooms_7_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_7_rooms", op, join, Number_Of_Rooms_7_Rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_7_Rooms;


   procedure Add_Number_Of_Rooms_8_Rooms( c : in out d.Criteria; Number_Of_Rooms_8_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_8_rooms", op, join, Number_Of_Rooms_8_Rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_8_Rooms;


   procedure Add_Number_Of_Rooms_9_Or_More_Rooms( c : in out d.Criteria; Number_Of_Rooms_9_Or_More_Rooms : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "number_of_rooms_9_or_more_rooms", op, join, Number_Of_Rooms_9_Or_More_Rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_9_Or_More_Rooms;


   procedure Add_Residence_All_Categories_Residence_Type( c : in out d.Criteria; Residence_All_Categories_Residence_Type : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "residence_all_categories_residence_type", op, join, Residence_All_Categories_Residence_Type );
   begin
      d.add_to_criteria( c, elem );
   end Add_Residence_All_Categories_Residence_Type;


   procedure Add_Residence_Lives_In_A_Household( c : in out d.Criteria; Residence_Lives_In_A_Household : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "residence_lives_in_a_household", op, join, Residence_Lives_In_A_Household );
   begin
      d.add_to_criteria( c, elem );
   end Add_Residence_Lives_In_A_Household;


   procedure Add_Residence_Lives_In_A_Communal_Establishment( c : in out d.Criteria; Residence_Lives_In_A_Communal_Establishment : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "residence_lives_in_a_communal_establishment", op, join, Residence_Lives_In_A_Communal_Establishment );
   begin
      d.add_to_criteria( c, elem );
   end Add_Residence_Lives_In_A_Communal_Establishment;


   procedure Add_Residence_Communal_Establishments_With_Persons_Sleeping_Rough( c : in out d.Criteria; Residence_Communal_Establishments_With_Persons_Sleeping_Rough : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "residence_communal_establishments_with_persons_sleeping_rough", op, join, Residence_Communal_Establishments_With_Persons_Sleeping_Rough );
   begin
      d.add_to_criteria( c, elem );
   end Add_Residence_Communal_Establishments_With_Persons_Sleeping_Rough;


   procedure Add_Tenure_All_Categories_Tenure( c : in out d.Criteria; Tenure_All_Categories_Tenure : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_all_categories_tenure", op, join, Tenure_All_Categories_Tenure );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_All_Categories_Tenure;


   procedure Add_Tenure_Owned_Total( c : in out d.Criteria; Tenure_Owned_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_owned_total", op, join, Tenure_Owned_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Owned_Total;


   procedure Add_Tenure_Owned_Owned_Outright( c : in out d.Criteria; Tenure_Owned_Owned_Outright : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_owned_owned_outright", op, join, Tenure_Owned_Owned_Outright );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Owned_Owned_Outright;


   procedure Add_Tenure_Owned_Owned_With_A_Mortgage_Or_Loan( c : in out d.Criteria; Tenure_Owned_Owned_With_A_Mortgage_Or_Loan : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_owned_owned_with_a_mortgage_or_loan", op, join, Tenure_Owned_Owned_With_A_Mortgage_Or_Loan );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Owned_Owned_With_A_Mortgage_Or_Loan;


   procedure Add_Tenure_Shared_Ownership_Part_Owned_And_Part_Rented( c : in out d.Criteria; Tenure_Shared_Ownership_Part_Owned_And_Part_Rented : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_shared_ownership_part_owned_and_part_rented", op, join, Tenure_Shared_Ownership_Part_Owned_And_Part_Rented );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Shared_Ownership_Part_Owned_And_Part_Rented;


   procedure Add_Tenure_Social_Rented_Total( c : in out d.Criteria; Tenure_Social_Rented_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_social_rented_total", op, join, Tenure_Social_Rented_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Social_Rented_Total;


   procedure Add_Tenure_Social_Rented_Rented_From_Council_Local_Authority( c : in out d.Criteria; Tenure_Social_Rented_Rented_From_Council_Local_Authority : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_social_rented_rented_from_council_local_authority", op, join, Tenure_Social_Rented_Rented_From_Council_Local_Authority );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Social_Rented_Rented_From_Council_Local_Authority;


   procedure Add_Tenure_Social_Rented_Other_Social_Rented( c : in out d.Criteria; Tenure_Social_Rented_Other_Social_Rented : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_social_rented_other_social_rented", op, join, Tenure_Social_Rented_Other_Social_Rented );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Social_Rented_Other_Social_Rented;


   procedure Add_Tenure_Private_Rented_Total( c : in out d.Criteria; Tenure_Private_Rented_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_private_rented_total", op, join, Tenure_Private_Rented_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Total;


   procedure Add_Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency( c : in out d.Criteria; Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_private_rented_private_landlord_or_letting_agency", op, join, Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency;


   procedure Add_Tenure_Private_Rented_Employer_Of_A_Household_Member( c : in out d.Criteria; Tenure_Private_Rented_Employer_Of_A_Household_Member : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_private_rented_employer_of_a_household_member", op, join, Tenure_Private_Rented_Employer_Of_A_Household_Member );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Employer_Of_A_Household_Member;


   procedure Add_Tenure_Private_Rented_Relative_Or_Friend_Of_Household( c : in out d.Criteria; Tenure_Private_Rented_Relative_Or_Friend_Of_Household : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_private_rented_relative_or_friend_of_household", op, join, Tenure_Private_Rented_Relative_Or_Friend_Of_Household );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Relative_Or_Friend_Of_Household;


   procedure Add_Tenure_Private_Rented_Other( c : in out d.Criteria; Tenure_Private_Rented_Other : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_private_rented_other", op, join, Tenure_Private_Rented_Other );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Other;


   procedure Add_Tenure_Living_Rent_Free( c : in out d.Criteria; Tenure_Living_Rent_Free : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "tenure_living_rent_free", op, join, Tenure_Living_Rent_Free );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Living_Rent_Free;


   procedure Add_Occupation_All_Categories_Occupation( c : in out d.Criteria; Occupation_All_Categories_Occupation : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_all_categories_occupation", op, join, Occupation_All_Categories_Occupation );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_All_Categories_Occupation;


   procedure Add_Occupation_1_Managers_Directors_And_Senior_Officials( c : in out d.Criteria; Occupation_1_Managers_Directors_And_Senior_Officials : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_1_managers_directors_and_senior_officials", op, join, Occupation_1_Managers_Directors_And_Senior_Officials );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_1_Managers_Directors_And_Senior_Officials;


   procedure Add_Occupation_2_Professional_Occupations( c : in out d.Criteria; Occupation_2_Professional_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_2_professional_occupations", op, join, Occupation_2_Professional_Occupations );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_2_Professional_Occupations;


   procedure Add_Occupation_3_Associate_Professional_And_Technical_Occupations( c : in out d.Criteria; Occupation_3_Associate_Professional_And_Technical_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_3_associate_professional_and_technical_occupations", op, join, Occupation_3_Associate_Professional_And_Technical_Occupations );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_3_Associate_Professional_And_Technical_Occupations;


   procedure Add_Occupation_4_Administrative_And_Secretarial_Occupations( c : in out d.Criteria; Occupation_4_Administrative_And_Secretarial_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_4_administrative_and_secretarial_occupations", op, join, Occupation_4_Administrative_And_Secretarial_Occupations );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_4_Administrative_And_Secretarial_Occupations;


   procedure Add_Occupation_5_Skilled_Trades_Occupations( c : in out d.Criteria; Occupation_5_Skilled_Trades_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_5_skilled_trades_occupations", op, join, Occupation_5_Skilled_Trades_Occupations );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_5_Skilled_Trades_Occupations;


   procedure Add_Occupation_6_Caring_Leisure_And_Other_Service_Occupations( c : in out d.Criteria; Occupation_6_Caring_Leisure_And_Other_Service_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_6_caring_leisure_and_other_service_occupations", op, join, Occupation_6_Caring_Leisure_And_Other_Service_Occupations );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_6_Caring_Leisure_And_Other_Service_Occupations;


   procedure Add_Occupation_7_Sales_And_Customer_Service_Occupations( c : in out d.Criteria; Occupation_7_Sales_And_Customer_Service_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_7_sales_and_customer_service_occupations", op, join, Occupation_7_Sales_And_Customer_Service_Occupations );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_7_Sales_And_Customer_Service_Occupations;


   procedure Add_Occupation_8_Process_Plant_And_Machine_Operatives( c : in out d.Criteria; Occupation_8_Process_Plant_And_Machine_Operatives : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_8_process_plant_and_machine_operatives", op, join, Occupation_8_Process_Plant_And_Machine_Operatives );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_8_Process_Plant_And_Machine_Operatives;


   procedure Add_Occupation_9_Elementary_Occupations( c : in out d.Criteria; Occupation_9_Elementary_Occupations : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "occupation_9_elementary_occupations", op, join, Occupation_9_Elementary_Occupations );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_9_Elementary_Occupations;


   procedure Add_Income_Support_People_Claiming_Benefit( c : in out d.Criteria; Income_Support_People_Claiming_Benefit : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "income_support_people_claiming_benefit", op, join, Income_Support_People_Claiming_Benefit );
   begin
      d.add_to_criteria( c, elem );
   end Add_Income_Support_People_Claiming_Benefit;


   procedure Add_Income_Support_Average_Weekly_Payment( c : in out d.Criteria; Income_Support_Average_Weekly_Payment : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "income_support_average_weekly_payment", op, join, Income_Support_Average_Weekly_Payment );
   begin
      d.add_to_criteria( c, elem );
   end Add_Income_Support_Average_Weekly_Payment;


   procedure Add_Jsa_Total( c : in out d.Criteria; Jsa_Total : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "jsa_total", op, join, Jsa_Total );
   begin
      d.add_to_criteria( c, elem );
   end Add_Jsa_Total;


   procedure Add_Pension_Credits_Number_Of_Claimants( c : in out d.Criteria; Pension_Credits_Number_Of_Claimants : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "pension_credits_number_of_claimants", op, join, Pension_Credits_Number_Of_Claimants );
   begin
      d.add_to_criteria( c, elem );
   end Add_Pension_Credits_Number_Of_Claimants;


   procedure Add_Pension_Credits_Number_Of_Beneficiaries( c : in out d.Criteria; Pension_Credits_Number_Of_Beneficiaries : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "pension_credits_number_of_beneficiaries", op, join, Pension_Credits_Number_Of_Beneficiaries );
   begin
      d.add_to_criteria( c, elem );
   end Add_Pension_Credits_Number_Of_Beneficiaries;


   procedure Add_Pension_Credits_Average_Weekly_Payment( c : in out d.Criteria; Pension_Credits_Average_Weekly_Payment : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "pension_credits_average_weekly_payment", op, join, Pension_Credits_Average_Weekly_Payment );
   begin
      d.add_to_criteria( c, elem );
   end Add_Pension_Credits_Average_Weekly_Payment;


   procedure Add_Out_Of_Work_Families( c : in out d.Criteria; Out_Of_Work_Families : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "out_of_work_families", op, join, Out_Of_Work_Families );
   begin
      d.add_to_criteria( c, elem );
   end Add_Out_Of_Work_Families;


   procedure Add_Out_Of_Work_Children( c : in out d.Criteria; Out_Of_Work_Children : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "out_of_work_children", op, join, Out_Of_Work_Children );
   begin
      d.add_to_criteria( c, elem );
   end Add_Out_Of_Work_Children;


   procedure Add_Wtc_And_Ctc_Families( c : in out d.Criteria; Wtc_And_Ctc_Families : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "wtc_and_ctc_families", op, join, Wtc_And_Ctc_Families );
   begin
      d.add_to_criteria( c, elem );
   end Add_Wtc_And_Ctc_Families;


   procedure Add_Wtc_And_Ctc_Children( c : in out d.Criteria; Wtc_And_Ctc_Children : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "wtc_and_ctc_children", op, join, Wtc_And_Ctc_Children );
   begin
      d.add_to_criteria( c, elem );
   end Add_Wtc_And_Ctc_Children;


   procedure Add_Ctc_Only_Families( c : in out d.Criteria; Ctc_Only_Families : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ctc_only_families", op, join, Ctc_Only_Families );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ctc_Only_Families;


   procedure Add_Ctc_Only_Children( c : in out d.Criteria; Ctc_Only_Children : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ctc_only_children", op, join, Ctc_Only_Children );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ctc_Only_Children;


   procedure Add_Childcare_Element( c : in out d.Criteria; Childcare_Element : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "childcare_element", op, join, Childcare_Element );
   begin
      d.add_to_criteria( c, elem );
   end Add_Childcare_Element;


   procedure Add_Credits_No_Children( c : in out d.Criteria; Credits_No_Children : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "credits_no_children", op, join, Credits_No_Children );
   begin
      d.add_to_criteria( c, elem );
   end Add_Credits_No_Children;


   procedure Add_Credits_Total_Families( c : in out d.Criteria; Credits_Total_Families : Real; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "credits_total_families", op, join, Credits_Total_Families );
   begin
      d.add_to_criteria( c, elem );
   end Add_Credits_Total_Families;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Id_To_Orderings;


   procedure Add_Code_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "code", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Code_To_Orderings;


   procedure Add_Edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Edition_To_Orderings;


   procedure Add_Frs_Region_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frs_region", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Frs_Region_To_Orderings;


   procedure Add_Hb_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hb_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Total_To_Orderings;


   procedure Add_Hb_Social_Rented_Sector_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hb_social_rented_sector", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Social_Rented_Sector_To_Orderings;


   procedure Add_Hb_Private_Rented_Sector_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hb_private_rented_sector", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Private_Rented_Sector_To_Orderings;


   procedure Add_Hb_Passported_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hb_passported", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Passported_To_Orderings;


   procedure Add_Hb_Non_Passported_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hb_non_passported", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hb_Non_Passported_To_Orderings;


   procedure Add_Ct_All_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ct_all", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ct_All_To_Orderings;


   procedure Add_Ct_Passported_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ct_passported", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ct_Passported_To_Orderings;


   procedure Add_Ct_Non_Passported_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ct_non_passported", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ct_Non_Passported_To_Orderings;


   procedure Add_Genders_All_Usual_Residents_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "genders_all_usual_residents", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_All_Usual_Residents_To_Orderings;


   procedure Add_Genders_Males_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "genders_males", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Males_To_Orderings;


   procedure Add_Genders_Females_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "genders_females", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Females_To_Orderings;


   procedure Add_Genders_Lives_In_A_Household_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "genders_lives_in_a_household", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Lives_In_A_Household_To_Orderings;


   procedure Add_Genders_Lives_In_A_Communal_Establishment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "genders_lives_in_a_communal_establishment", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Lives_In_A_Communal_Establishment_To_Orderings;


   procedure Add_Genders_Schoolchild_Or_Student_Non_Term_Time_Address_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "genders_schoolchild_or_student_non_term_time_address", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genders_Schoolchild_Or_Student_Non_Term_Time_Address_To_Orderings;


   procedure Add_Age_Ranges_All_Categories_Age_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_all_categories_age", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_All_Categories_Age_To_Orderings;


   procedure Add_Age_Ranges_Age_Under_1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_under_1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_Under_1_To_Orderings;


   procedure Add_Age_Ranges_Age_1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_1_To_Orderings;


   procedure Add_Age_Ranges_Age_2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_2_To_Orderings;


   procedure Add_Age_Ranges_Age_3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_3_To_Orderings;


   procedure Add_Age_Ranges_Age_4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_4_To_Orderings;


   procedure Add_Age_Ranges_Age_5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_5_To_Orderings;


   procedure Add_Age_Ranges_Age_6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_6_To_Orderings;


   procedure Add_Age_Ranges_Age_7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_7_To_Orderings;


   procedure Add_Age_Ranges_Age_8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_8_To_Orderings;


   procedure Add_Age_Ranges_Age_9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_9_To_Orderings;


   procedure Add_Age_Ranges_Age_10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_10_To_Orderings;


   procedure Add_Age_Ranges_Age_11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_11_To_Orderings;


   procedure Add_Age_Ranges_Age_12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_12_To_Orderings;


   procedure Add_Age_Ranges_Age_13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_13_To_Orderings;


   procedure Add_Age_Ranges_Age_14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_14_To_Orderings;


   procedure Add_Age_Ranges_Age_15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_15", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_15_To_Orderings;


   procedure Add_Age_Ranges_Age_16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_16", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_16_To_Orderings;


   procedure Add_Age_Ranges_Age_17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_17", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_17_To_Orderings;


   procedure Add_Age_Ranges_Age_18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_18", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_18_To_Orderings;


   procedure Add_Age_Ranges_Age_19_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_19", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_19_To_Orderings;


   procedure Add_Age_Ranges_Age_20_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_20", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_20_To_Orderings;


   procedure Add_Age_Ranges_Age_21_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_21", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_21_To_Orderings;


   procedure Add_Age_Ranges_Age_22_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_22", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_22_To_Orderings;


   procedure Add_Age_Ranges_Age_23_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_23", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_23_To_Orderings;


   procedure Add_Age_Ranges_Age_24_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_24", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_24_To_Orderings;


   procedure Add_Age_Ranges_Age_25_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_25", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_25_To_Orderings;


   procedure Add_Age_Ranges_Age_26_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_26", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_26_To_Orderings;


   procedure Add_Age_Ranges_Age_27_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_27", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_27_To_Orderings;


   procedure Add_Age_Ranges_Age_28_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_28", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_28_To_Orderings;


   procedure Add_Age_Ranges_Age_29_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_29", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_29_To_Orderings;


   procedure Add_Age_Ranges_Age_30_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_30", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_30_To_Orderings;


   procedure Add_Age_Ranges_Age_31_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_31", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_31_To_Orderings;


   procedure Add_Age_Ranges_Age_32_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_32", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_32_To_Orderings;


   procedure Add_Age_Ranges_Age_33_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_33", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_33_To_Orderings;


   procedure Add_Age_Ranges_Age_34_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_34", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_34_To_Orderings;


   procedure Add_Age_Ranges_Age_35_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_35", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_35_To_Orderings;


   procedure Add_Age_Ranges_Age_36_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_36", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_36_To_Orderings;


   procedure Add_Age_Ranges_Age_37_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_37", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_37_To_Orderings;


   procedure Add_Age_Ranges_Age_38_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_38", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_38_To_Orderings;


   procedure Add_Age_Ranges_Age_39_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_39", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_39_To_Orderings;


   procedure Add_Age_Ranges_Age_40_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_40", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_40_To_Orderings;


   procedure Add_Age_Ranges_Age_41_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_41", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_41_To_Orderings;


   procedure Add_Age_Ranges_Age_42_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_42", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_42_To_Orderings;


   procedure Add_Age_Ranges_Age_43_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_43", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_43_To_Orderings;


   procedure Add_Age_Ranges_Age_44_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_44", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_44_To_Orderings;


   procedure Add_Age_Ranges_Age_45_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_45", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_45_To_Orderings;


   procedure Add_Age_Ranges_Age_46_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_46", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_46_To_Orderings;


   procedure Add_Age_Ranges_Age_47_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_47", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_47_To_Orderings;


   procedure Add_Age_Ranges_Age_48_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_48", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_48_To_Orderings;


   procedure Add_Age_Ranges_Age_49_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_49", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_49_To_Orderings;


   procedure Add_Age_Ranges_Age_50_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_50", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_50_To_Orderings;


   procedure Add_Age_Ranges_Age_51_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_51", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_51_To_Orderings;


   procedure Add_Age_Ranges_Age_52_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_52", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_52_To_Orderings;


   procedure Add_Age_Ranges_Age_53_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_53", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_53_To_Orderings;


   procedure Add_Age_Ranges_Age_54_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_54", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_54_To_Orderings;


   procedure Add_Age_Ranges_Age_55_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_55", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_55_To_Orderings;


   procedure Add_Age_Ranges_Age_56_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_56", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_56_To_Orderings;


   procedure Add_Age_Ranges_Age_57_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_57", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_57_To_Orderings;


   procedure Add_Age_Ranges_Age_58_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_58", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_58_To_Orderings;


   procedure Add_Age_Ranges_Age_59_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_59", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_59_To_Orderings;


   procedure Add_Age_Ranges_Age_60_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_60", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_60_To_Orderings;


   procedure Add_Age_Ranges_Age_61_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_61", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_61_To_Orderings;


   procedure Add_Age_Ranges_Age_62_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_62", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_62_To_Orderings;


   procedure Add_Age_Ranges_Age_63_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_63", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_63_To_Orderings;


   procedure Add_Age_Ranges_Age_64_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_64", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_64_To_Orderings;


   procedure Add_Age_Ranges_Age_65_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_65", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_65_To_Orderings;


   procedure Add_Age_Ranges_Age_66_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_66", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_66_To_Orderings;


   procedure Add_Age_Ranges_Age_67_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_67", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_67_To_Orderings;


   procedure Add_Age_Ranges_Age_68_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_68", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_68_To_Orderings;


   procedure Add_Age_Ranges_Age_69_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_69", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_69_To_Orderings;


   procedure Add_Age_Ranges_Age_70_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_70", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_70_To_Orderings;


   procedure Add_Age_Ranges_Age_71_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_71", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_71_To_Orderings;


   procedure Add_Age_Ranges_Age_72_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_72", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_72_To_Orderings;


   procedure Add_Age_Ranges_Age_73_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_73", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_73_To_Orderings;


   procedure Add_Age_Ranges_Age_74_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_74", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_74_To_Orderings;


   procedure Add_Age_Ranges_Age_75_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_75", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_75_To_Orderings;


   procedure Add_Age_Ranges_Age_76_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_76", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_76_To_Orderings;


   procedure Add_Age_Ranges_Age_77_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_77", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_77_To_Orderings;


   procedure Add_Age_Ranges_Age_78_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_78", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_78_To_Orderings;


   procedure Add_Age_Ranges_Age_79_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_79", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_79_To_Orderings;


   procedure Add_Age_Ranges_Age_80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_80", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_80_To_Orderings;


   procedure Add_Age_Ranges_Age_81_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_81", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_81_To_Orderings;


   procedure Add_Age_Ranges_Age_82_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_82", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_82_To_Orderings;


   procedure Add_Age_Ranges_Age_83_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_83", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_83_To_Orderings;


   procedure Add_Age_Ranges_Age_84_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_84", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_84_To_Orderings;


   procedure Add_Age_Ranges_Age_85_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_85", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_85_To_Orderings;


   procedure Add_Age_Ranges_Age_86_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_86", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_86_To_Orderings;


   procedure Add_Age_Ranges_Age_87_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_87", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_87_To_Orderings;


   procedure Add_Age_Ranges_Age_88_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_88", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_88_To_Orderings;


   procedure Add_Age_Ranges_Age_89_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_89", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_89_To_Orderings;


   procedure Add_Age_Ranges_Age_90_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_90", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_90_To_Orderings;


   procedure Add_Age_Ranges_Age_91_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_91", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_91_To_Orderings;


   procedure Add_Age_Ranges_Age_92_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_92", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_92_To_Orderings;


   procedure Add_Age_Ranges_Age_93_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_93", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_93_To_Orderings;


   procedure Add_Age_Ranges_Age_94_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_94", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_94_To_Orderings;


   procedure Add_Age_Ranges_Age_95_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_95", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_95_To_Orderings;


   procedure Add_Age_Ranges_Age_96_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_96", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_96_To_Orderings;


   procedure Add_Age_Ranges_Age_97_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_97", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_97_To_Orderings;


   procedure Add_Age_Ranges_Age_98_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_98", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_98_To_Orderings;


   procedure Add_Age_Ranges_Age_99_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_99", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_99_To_Orderings;


   procedure Add_Age_Ranges_Age_100_And_Over_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age_ranges_age_100_and_over", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Age_Ranges_Age_100_And_Over_To_Orderings;


   procedure Add_Accom_All_Categories_Accommodation_Type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_all_categories_accommodation_type", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_All_Categories_Accommodation_Type_To_Orderings;


   procedure Add_Accom_Unshared_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Total_To_Orderings;


   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_whole_house_or_bungalow_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Whole_House_Or_Bungalow_Total_To_Orderings;


   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Detached_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_whole_house_or_bungalow_detached", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Whole_House_Or_Bungalow_Detached_To_Orderings;


   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_whole_house_or_bungalow_semi_detached", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Whole_House_Or_Bungalow_Semi_Detached_To_Orderings;


   procedure Add_Accom_Unshared_Whole_House_Or_Bungalow_Terraced_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_whole_house_or_bungalow_terraced", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Whole_House_Or_Bungalow_Terraced_To_Orderings;


   procedure Add_Accom_Unshared_Flat_Maisonette_Or_Apartment_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_flat_maisonette_or_apartment_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Flat_Maisonette_Or_Apartment_Total_To_Orderings;


   procedure Add_Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_flat_etc_purpose_built_flats_or_tenement", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Flat_Etc_Purpose_Built_Flats_Or_Tenement_To_Orderings;


   procedure Add_Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_flat_etc_part_of_a_converted_or_shared_house", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Flat_Etc_Part_Of_A_Converted_Or_Shared_House_To_Orderings;


   procedure Add_Accom_Unshared_Flat_Etc_In_Commercial_Building_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_flat_etc_in_commercial_building", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Flat_Etc_In_Commercial_Building_To_Orderings;


   procedure Add_Accom_Unshared_Caravan_Etc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_unshared_caravan_etc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Unshared_Caravan_Etc_To_Orderings;


   procedure Add_Accom_Shared_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accom_shared", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Accom_Shared_To_Orderings;


   procedure Add_Ec_Act_All_Categories_Economic_Activity_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_all_categories_economic_activity", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_All_Categories_Economic_Activity_To_Orderings;


   procedure Add_Ec_Act_Active_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_active_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Total_To_Orderings;


   procedure Add_Ec_Act_Active_Employee_Part_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_active_employee_part_time", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Employee_Part_Time_To_Orderings;


   procedure Add_Ec_Act_Active_Employee_Full_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_active_employee_full_time", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Employee_Full_Time_To_Orderings;


   procedure Add_Ec_Act_Active_Self_Employed_With_Employees_Part_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_active_self_employed_with_employees_part_time", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Self_Employed_With_Employees_Part_Time_To_Orderings;


   procedure Add_Ec_Act_Active_Self_Employed_With_Employees_Full_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_active_self_employed_with_employees_full_time", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Self_Employed_With_Employees_Full_Time_To_Orderings;


   procedure Add_Ec_Act_Active_Self_Employed_Without_Employees_Part_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_active_self_employed_without_employees_part_time", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Self_Employed_Without_Employees_Part_Time_To_Orderings;


   procedure Add_Ec_Act_Active_Self_Employed_Without_Employees_Full_Time_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_active_self_employed_without_employees_full_time", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Self_Employed_Without_Employees_Full_Time_To_Orderings;


   procedure Add_Ec_Act_Active_Unemployed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_active_unemployed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Unemployed_To_Orderings;


   procedure Add_Ec_Act_Active_Full_Time_Student_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_active_full_time_student", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Active_Full_Time_Student_To_Orderings;


   procedure Add_Ec_Act_Inactive_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_inactive_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Total_To_Orderings;


   procedure Add_Ec_Act_Inactive_Retired_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_inactive_retired", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Retired_To_Orderings;


   procedure Add_Ec_Act_Inactive_Student_Including_Full_Time_Students_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_inactive_student_including_full_time_students", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Student_Including_Full_Time_Students_To_Orderings;


   procedure Add_Ec_Act_Inactive_Looking_After_Home_Or_Family_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_inactive_looking_after_home_or_family", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Looking_After_Home_Or_Family_To_Orderings;


   procedure Add_Ec_Act_Inactive_Long_Term_Sick_Or_Disabled_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_inactive_long_term_sick_or_disabled", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Long_Term_Sick_Or_Disabled_To_Orderings;


   procedure Add_Ec_Act_Inactive_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ec_act_inactive_other", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ec_Act_Inactive_Other_To_Orderings;


   procedure Add_Ethgrp_All_Categories_Ethnic_Group_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_all_categories_ethnic_group", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_All_Categories_Ethnic_Group_To_Orderings;


   procedure Add_Ethgrp_White_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_white", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White_To_Orderings;


   procedure Add_Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_white_english_welsh_scottish_northern_irish_british", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British_To_Orderings;


   procedure Add_Ethgrp_White_Irish_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_white_irish", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White_Irish_To_Orderings;


   procedure Add_Ethgrp_White_Gypsy_Or_Irish_Traveller_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_white_gypsy_or_irish_traveller", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White_Gypsy_Or_Irish_Traveller_To_Orderings;


   procedure Add_Ethgrp_White_Other_White_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_white_other_white", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_White_Other_White_To_Orderings;


   procedure Add_Ethgrp_Mixed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_mixed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed_To_Orderings;


   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_mixed_multiple_ethnic_group_white_and_black_caribbean", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean_To_Orderings;


   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_mixed_multiple_ethnic_group_white_and_black_african", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African_To_Orderings;


   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_mixed_multiple_ethnic_group_white_and_asian", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian_To_Orderings;


   procedure Add_Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_mixed_multiple_ethnic_group_other_mixed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed_To_Orderings;


   procedure Add_Ethgrp_Asian_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_asian", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_To_Orderings;


   procedure Add_Ethgrp_Asian_Asian_British_Indian_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_asian_asian_british_indian", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Indian_To_Orderings;


   procedure Add_Ethgrp_Asian_Asian_British_Pakistani_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_asian_asian_british_pakistani", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Pakistani_To_Orderings;


   procedure Add_Ethgrp_Asian_Asian_British_Bangladeshi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_asian_asian_british_bangladeshi", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Bangladeshi_To_Orderings;


   procedure Add_Ethgrp_Asian_Asian_British_Chinese_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_asian_asian_british_chinese", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Chinese_To_Orderings;


   procedure Add_Ethgrp_Asian_Asian_British_Other_Asian_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_asian_asian_british_other_asian", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Asian_Asian_British_Other_Asian_To_Orderings;


   procedure Add_Ethgrp_Black_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_black", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Black_To_Orderings;


   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_African_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_black_african_caribbean_black_british_african", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Black_African_Caribbean_Black_British_African_To_Orderings;


   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_Caribbean_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_black_african_caribbean_black_british_caribbean", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Black_African_Caribbean_Black_British_Caribbean_To_Orderings;


   procedure Add_Ethgrp_Black_African_Caribbean_Black_British_Other_Black_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_black_african_caribbean_black_british_other_black", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Black_African_Caribbean_Black_British_Other_Black_To_Orderings;


   procedure Add_Ethgrp_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_other", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Other_To_Orderings;


   procedure Add_Ethgrp_Other_Ethnic_Group_Arab_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_other_ethnic_group_arab", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Other_Ethnic_Group_Arab_To_Orderings;


   procedure Add_Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp_other_ethnic_group_any_other_ethnic_group", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ethgrp_Other_Ethnic_Group_Any_Other_Ethnic_Group_To_Orderings;


   procedure Add_Hcomp_All_Categories_Household_Composition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_all_categories_household_composition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_All_Categories_Household_Composition_To_Orderings;


   procedure Add_Hcomp_One_Person_Household_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_person_household_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Person_Household_Total_To_Orderings;


   procedure Add_Hcomp_One_Person_Household_Aged_65_And_Over_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_person_household_aged_65_and_over", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Person_Household_Aged_65_And_Over_To_Orderings;


   procedure Add_Hcomp_One_Person_Household_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_person_household_other", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Person_Household_Other_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Total_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_All_Aged_65_And_Over_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_all_aged_65_and_over", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_All_Aged_65_And_Over_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_married_cple_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_Total_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_No_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_married_cple_no_kids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_No_Kids_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_married_cple_one_dep_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_One_Dep_Child_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_married_cple_two_or_more_dep_kids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_Two_Or_More_Dep_Kids_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_married_cple_all_kids_non_dep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Married_Cple_All_Kids_Non_Dep_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_same_sex_civ_part_cple_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_Total_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_same_sex_civ_part_cple_no_kids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_No_Kids_To_Orderings;


   procedure Add_Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_same_sex_civ_part_cple_one_dep_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Same_Sex_Civ_Part_Cple_One_Dep_Child_To_Orderings;


   procedure Add_Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_same_sex_civ_part_cple_two_plus_dep_kids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Same_Sex_Civ_Part_Cple_Two_Plus_Dep_Kids_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_same_sex_civ_part_cple_all_kids_non_dep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Same_Sex_Civ_Part_Cple_All_Kids_Non_Dep_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_cohabiting_cple_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_Total_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_cohabiting_cple_no_kids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_No_Kids_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_cohabiting_cple_one_dep_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_One_Dep_Child_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_cohabiting_cple_two_or_more_dep_kids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_Two_Or_More_Dep_Kids_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_cohabiting_cple_all_kids_non_dep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Cohabiting_Cple_All_Kids_Non_Dep_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Lone_Parent_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_lone_parent_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Lone_Parent_Total_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_lone_parent_one_dep_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Lone_Parent_One_Dep_Child_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_lone_parent_two_or_more_dep_kids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Lone_Parent_Two_Or_More_Dep_Kids_To_Orderings;


   procedure Add_Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_one_family_only_lone_parent_all_kids_non_dep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_One_Family_Only_Lone_Parent_All_Kids_Non_Dep_To_Orderings;


   procedure Add_Hcomp_Other_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_other_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_Total_To_Orderings;


   procedure Add_Hcomp_Other_With_One_Dep_Child_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_other_with_one_dep_child", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_With_One_Dep_Child_To_Orderings;


   procedure Add_Hcomp_Other_With_Two_Or_More_Dep_Kids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_other_with_two_or_more_dep_kids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_With_Two_Or_More_Dep_Kids_To_Orderings;


   procedure Add_Hcomp_Other_All_Full_Time_Students_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_other_all_full_time_students", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_All_Full_Time_Students_To_Orderings;


   procedure Add_Hcomp_Other_All_Aged_65_And_Over_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_other_all_aged_65_and_over", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_All_Aged_65_And_Over_To_Orderings;


   procedure Add_Hcomp_Other_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcomp_other_other", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Hcomp_Other_Other_To_Orderings;


   procedure Add_Number_Of_Rooms_All_Categories_Number_Of_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_all_categories_number_of_rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_All_Categories_Number_Of_Rooms_To_Orderings;


   procedure Add_Number_Of_Rooms_1_Room_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_1_room", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_1_Room_To_Orderings;


   procedure Add_Number_Of_Rooms_2_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_2_rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_2_Rooms_To_Orderings;


   procedure Add_Number_Of_Rooms_3_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_3_rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_3_Rooms_To_Orderings;


   procedure Add_Number_Of_Rooms_4_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_4_rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_4_Rooms_To_Orderings;


   procedure Add_Number_Of_Rooms_5_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_5_rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_5_Rooms_To_Orderings;


   procedure Add_Number_Of_Rooms_6_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_6_rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_6_Rooms_To_Orderings;


   procedure Add_Number_Of_Rooms_7_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_7_rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_7_Rooms_To_Orderings;


   procedure Add_Number_Of_Rooms_8_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_8_rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_8_Rooms_To_Orderings;


   procedure Add_Number_Of_Rooms_9_Or_More_Rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "number_of_rooms_9_or_more_rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Number_Of_Rooms_9_Or_More_Rooms_To_Orderings;


   procedure Add_Residence_All_Categories_Residence_Type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "residence_all_categories_residence_type", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Residence_All_Categories_Residence_Type_To_Orderings;


   procedure Add_Residence_Lives_In_A_Household_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "residence_lives_in_a_household", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Residence_Lives_In_A_Household_To_Orderings;


   procedure Add_Residence_Lives_In_A_Communal_Establishment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "residence_lives_in_a_communal_establishment", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Residence_Lives_In_A_Communal_Establishment_To_Orderings;


   procedure Add_Residence_Communal_Establishments_With_Persons_Sleeping_Rough_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "residence_communal_establishments_with_persons_sleeping_rough", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Residence_Communal_Establishments_With_Persons_Sleeping_Rough_To_Orderings;


   procedure Add_Tenure_All_Categories_Tenure_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_all_categories_tenure", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_All_Categories_Tenure_To_Orderings;


   procedure Add_Tenure_Owned_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_owned_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Owned_Total_To_Orderings;


   procedure Add_Tenure_Owned_Owned_Outright_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_owned_owned_outright", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Owned_Owned_Outright_To_Orderings;


   procedure Add_Tenure_Owned_Owned_With_A_Mortgage_Or_Loan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_owned_owned_with_a_mortgage_or_loan", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Owned_Owned_With_A_Mortgage_Or_Loan_To_Orderings;


   procedure Add_Tenure_Shared_Ownership_Part_Owned_And_Part_Rented_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_shared_ownership_part_owned_and_part_rented", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Shared_Ownership_Part_Owned_And_Part_Rented_To_Orderings;


   procedure Add_Tenure_Social_Rented_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_social_rented_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Social_Rented_Total_To_Orderings;


   procedure Add_Tenure_Social_Rented_Rented_From_Council_Local_Authority_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_social_rented_rented_from_council_local_authority", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Social_Rented_Rented_From_Council_Local_Authority_To_Orderings;


   procedure Add_Tenure_Social_Rented_Other_Social_Rented_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_social_rented_other_social_rented", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Social_Rented_Other_Social_Rented_To_Orderings;


   procedure Add_Tenure_Private_Rented_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_private_rented_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Total_To_Orderings;


   procedure Add_Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_private_rented_private_landlord_or_letting_agency", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Private_Landlord_Or_Letting_Agency_To_Orderings;


   procedure Add_Tenure_Private_Rented_Employer_Of_A_Household_Member_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_private_rented_employer_of_a_household_member", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Employer_Of_A_Household_Member_To_Orderings;


   procedure Add_Tenure_Private_Rented_Relative_Or_Friend_Of_Household_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_private_rented_relative_or_friend_of_household", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Relative_Or_Friend_Of_Household_To_Orderings;


   procedure Add_Tenure_Private_Rented_Other_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_private_rented_other", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Private_Rented_Other_To_Orderings;


   procedure Add_Tenure_Living_Rent_Free_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure_living_rent_free", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Tenure_Living_Rent_Free_To_Orderings;


   procedure Add_Occupation_All_Categories_Occupation_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_all_categories_occupation", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_All_Categories_Occupation_To_Orderings;


   procedure Add_Occupation_1_Managers_Directors_And_Senior_Officials_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_1_managers_directors_and_senior_officials", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_1_Managers_Directors_And_Senior_Officials_To_Orderings;


   procedure Add_Occupation_2_Professional_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_2_professional_occupations", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_2_Professional_Occupations_To_Orderings;


   procedure Add_Occupation_3_Associate_Professional_And_Technical_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_3_associate_professional_and_technical_occupations", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_3_Associate_Professional_And_Technical_Occupations_To_Orderings;


   procedure Add_Occupation_4_Administrative_And_Secretarial_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_4_administrative_and_secretarial_occupations", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_4_Administrative_And_Secretarial_Occupations_To_Orderings;


   procedure Add_Occupation_5_Skilled_Trades_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_5_skilled_trades_occupations", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_5_Skilled_Trades_Occupations_To_Orderings;


   procedure Add_Occupation_6_Caring_Leisure_And_Other_Service_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_6_caring_leisure_and_other_service_occupations", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_6_Caring_Leisure_And_Other_Service_Occupations_To_Orderings;


   procedure Add_Occupation_7_Sales_And_Customer_Service_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_7_sales_and_customer_service_occupations", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_7_Sales_And_Customer_Service_Occupations_To_Orderings;


   procedure Add_Occupation_8_Process_Plant_And_Machine_Operatives_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_8_process_plant_and_machine_operatives", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_8_Process_Plant_And_Machine_Operatives_To_Orderings;


   procedure Add_Occupation_9_Elementary_Occupations_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupation_9_elementary_occupations", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Occupation_9_Elementary_Occupations_To_Orderings;


   procedure Add_Income_Support_People_Claiming_Benefit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "income_support_people_claiming_benefit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Income_Support_People_Claiming_Benefit_To_Orderings;


   procedure Add_Income_Support_Average_Weekly_Payment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "income_support_average_weekly_payment", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Income_Support_Average_Weekly_Payment_To_Orderings;


   procedure Add_Jsa_Total_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jsa_total", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Jsa_Total_To_Orderings;


   procedure Add_Pension_Credits_Number_Of_Claimants_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pension_credits_number_of_claimants", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Pension_Credits_Number_Of_Claimants_To_Orderings;


   procedure Add_Pension_Credits_Number_Of_Beneficiaries_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pension_credits_number_of_beneficiaries", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Pension_Credits_Number_Of_Beneficiaries_To_Orderings;


   procedure Add_Pension_Credits_Average_Weekly_Payment_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pension_credits_average_weekly_payment", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Pension_Credits_Average_Weekly_Payment_To_Orderings;


   procedure Add_Out_Of_Work_Families_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "out_of_work_families", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Out_Of_Work_Families_To_Orderings;


   procedure Add_Out_Of_Work_Children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "out_of_work_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Out_Of_Work_Children_To_Orderings;


   procedure Add_Wtc_And_Ctc_Families_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wtc_and_ctc_families", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Wtc_And_Ctc_Families_To_Orderings;


   procedure Add_Wtc_And_Ctc_Children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wtc_and_ctc_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Wtc_And_Ctc_Children_To_Orderings;


   procedure Add_Ctc_Only_Families_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctc_only_families", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ctc_Only_Families_To_Orderings;


   procedure Add_Ctc_Only_Children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctc_only_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ctc_Only_Children_To_Orderings;


   procedure Add_Childcare_Element_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "childcare_element", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Childcare_Element_To_Orderings;


   procedure Add_Credits_No_Children_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "credits_no_children", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Credits_No_Children_To_Orderings;


   procedure Add_Credits_Total_Families_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "credits_total_families", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Credits_Total_Families_To_Orderings;


   
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Target_Candidates_Type_IO;
