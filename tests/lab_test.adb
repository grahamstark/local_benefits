with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;

with GNATColl.Traces;

with AUnit.Assertions;             
with AUnit.Test_Cases; 

with LA_Reweighter;
with Raw_FRS;
with FRS_Binary_Reads;
with Maths_Functions.Weights_Generator;
with Maths_Functions;
with Weighting_Commons;
with Data_Constants;
with Conversions.FRS;
with Base_Model_Types;

package body Lab_Test is

   use Ada.Strings.Unbounded;
   use Ada.Text_IO;
   use Base_Model_Types;
   use LA_Reweighter;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "LAB_TEST" );
   
   package Maths_Funcs is new Maths_Functions( Amount );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use AUnit.Test_Cases.Registration;
   
   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Calendar;

   use Data_Constants;
   use Weighting_Commons;
   
   this_year   : constant Data_Years := 2010;
   -- scotland and ireland
   num_households : constant Positive := RAW_FRS_HOUSEHOLD_COUNTS( this_year ); -- -  (4126 + 1895);
   subtype Compressed_Targets_Range is Positive range 1 .. 31;   

   package Reweigher is new Maths_Funcs.Weights_Generator(    
      Num_Constraints   => Compressed_Targets_Range'Last,
      Num_Observations  => num_households );

   observations          : Reweigher.Dataset := ( others => ( others => 0.0 ));
   Weighting_Upper_Bound : constant Amount := 20.0;
   Weighting_Lower_Bound : constant Amount := 0.05;
   weighting_function    : constant Distance_Function_Type := constrained_chi_square;
   max_num_households    : constant := 30_000;
   
   type Ptr_Rec is record
      region : Integer;
      sernum : Sernum_Value;
   end record;
   
   type Ptr_Array is array( 1 .. max_num_households ) of Ptr_Rec;

   ptrs : Ptr_Array;
   
   procedure FRS_Read_Test( t : in out AUnit.Test_Cases.Test_Case'Class ) is
   use FRS_Binary_Reads;
   use Conversions.FRS;
   use FRS_Index_Package;
   use Maths_Funcs;
   use Reweigher;
   
   type Region_Counts_Array is array( 1 .. 13 ) of Integer;
   region_counts : Region_Counts_Array := ( others => 0 );
   
   function HHlds_By_FRS_Region_2010( which : Integer ) return Natural is
      a : Natural := 0;
   begin
      case which is
         When 1  => a := 1025;
         When 2  => a := 2627;
         When 3  => a := 0;
         When 4  => a := 1920;
         When 5  => a := 1637;
         When 6  => a := 1947;
         When 7  => a := 2117;
         When 8  => a := 2205;
         When 9  => a := 2904;
         When 10  => a := 1773;
         When 11  => a := 1174;
         When 12  => a := 0;
         When 13  => a := 0;
         when others => null;
      end case;
      return a;
   end  HHlds_By_FRS_Region_2010;

   type Ptr_Rec is record
      region : Integer;
      sernum : Sernum_Value;
   end record;
   
   function Age_Band_From_Age( age : Integer ) return Positive is
      age_pos : Positive := Positive'Last; -- We DIE if out-of-range
   begin
      case age is
         when 0 .. 5 =>
            age_pos := 1;
         when 6 .. 10 =>
            age_pos := 2;
         when 11 .. 15 =>
            age_pos := 3;
         when 16 .. 18 =>
            age_pos := 4;
         when 19 .. 21 =>
            age_pos := 5;
         when 22 .. 30 =>
            age_pos := 6;
         when 31 .. 40 =>
            age_pos := 7;
         when 41 .. 50 =>
            age_pos := 8;
         when 51 .. 60 =>
            age_pos := 9;
         when 61 .. 64 =>
            age_pos := 10;
         when 65 .. 69 =>
            age_pos := 11;
         when 70 .. 74 =>
            age_pos := 12;
         when 75 .. 79 =>
            age_pos := 13;
         when 80 .. 84 =>
            age_pos := 14;
         when 85 .. 120 =>
            age_pos := 15;
         when others =>
            Put_Line( "OUT OF RANGE AGE " & age'Img );
      end case;
      return age_pos;
   end Age_Band_From_Age;
   
   -- 
   -- FRS Tenure
   -- Value = 1	Label = Owns it outright 
	-- Value = 2	Label = Buying with the help of a mortgage 
	-- Value = 3	Label = Part own, part rent 
	-- Value = 4	Label = Rents 
	-- Value = 5	Label = Rent-free 
	-- Value = 6	Label = Squatting
	-- 
	-- TENTYPE2 
	-- 
	-- Value = 1	Label = LA / New Town / NIHE / Council rented            1 
	-- Value = 2	Label = Housing Association / Co-Op / Trust rented       2
	-- Value = 3	Label = Other private rented unfurnished                 3
	-- Value = 4	Label = Other private rented furnished                   3
	-- Value = 5	Label = Owned with a mortgage (includes part rent / part own) 4 
	-- Value = 6	Label = Owned outright 5
	-- Value = 7	Label = Rent-free 6
	-- Value = 8	Label = Squats    6
   -- 
	-- NOMIS:
	   -- tenure_type_owned_owned_outright,                  5
      -- tenure_type_owned_owned_with_a_mortgage_or_loan,   4
      -- tenure_type_shared_ownership_part_owned_and_part_rented, 4
      -- tenure_type_social_rented_total, 
      -- tenure_type_social_rented_rented_from_council_local_authority, 1
      -- tenure_type_social_rented_other_social_rented, 2
      -- tenure_type_private_rented_total,
      -- tenure_type_private_rented_private_landlord_or_letting_agency, 3
      -- tenure_type_private_rented_employer_of_a_household_member,  3
      -- tenure_type_private_rented_relative_or_friend_of_household_member, 3
      -- tenure_type_private_rented_other, 3
      -- tenure_type_living_rent_free, 6
-- 
	
      index_map        : FRS_Index;
      index            : Index_Rec;
      size             : Natural := 0;
      hhno             : Natural := 0;
      frs_person_count : Amount := 0.0;
      --
      -- group the LA data into 15 age ranges & 2 genders 6 tenure types and 7 room counts 
      -- (so far; more needs added?
      --
      
      function Map_Ethnic_Group( ieg : Integer ) return Positive is
         oeg : Positive := Positive'Last;
      begin
         Put_Line( "eth group : in : " & ieg'Img );
   -- Value = 1	Label = White - British  1
	-- Value = 2	Label = White - Irish    1
	-- Value = 3	Label = Any other white background 1 
	-- Value = 4	Label = Mixed - White and Black Caribbean 2 
	-- Value = 5	Label = Mixed - White and Black African 2
	-- Value = 6	Label = Mixed - White and Asian 2
	-- Value = 7	Label = Any other mixed background 2 
	-- Value = 8	Label = Asian or Asian British - Indian 3 
	-- Value = 9	Label = Asian or Asian British - Pakistani 3 
	-- Value = 10	Label = Asian or Asian British - Bangladeshi 3 
	-- Value = 11	Label = Any other Asian/Asian British background 3
	-- Value = 12	Label = Black or Black British - Caribbean 4
	-- Value = 13	Label = Black or Black British - African 4
	-- Value = 14	Label = Any other Black/Black British background 4 
	-- Value = 15	Label = Chinese 3
	-- Value = 16	Label = Any other 5
	      case ieg is
	         when -1 | 1 .. 3 => oeg := 1; -- tread refused as white???
            when 4 .. 7 => oeg := 2;
            when 15 | 8 .. 11 => oeg := 3;
            when 12 .. 14 => oeg := 4;
            when 16 => oeg := 5;
            when others => oeg := Positive'Last;
         end case;
         Put_Line( "eth group : out : " & oeg'Img );
         return oeg;
      end Map_Ethnic_Group;
      
      procedure Do_For_Region( which : Integer ) is
         index : Index_Rec;
      begin
         for i in ptrs'Range loop
            if( ptrs( i ).region = which )then
               index := index_map.Element( ptrs( i ).sernum );
            end if;
         end loop;
      end Do_For_Region;

      function Map_Household( hh : Raw_FRS.Raw_Household ) return Row_Vector is
      use Raw_FRS;
         cv : Row_Vector := ( others => 0.0 );
         ab : Positive;
         heads_race : Integer := 1;
      begin
         --
         -- tenure hh level slots 18-23
         --
         Put_Line( "at start of Map Household" );
         case hh.household.TENTYP2 is
            when 1 => ab := 19;
            when 2 => ab := 20;
            when 3 .. 4 => ab := 21;
            when 5 => ab := 22;
            when 6 => ab := 23;
            when 7 .. 8 => ab := 24;
            when others => ab := 9999; -- BLOW UP
         end case;
         cv( ab ) := 1.0;
         Put_Line( "rooms : " & hh.household.ROOMS10'Img );
         case hh.household.ROOMS10 is
            when 1 => ab := 25;
            when 2 => ab := 26;
            when 3 => ab := 27;
            when 4 => ab := 28;
            when 5 => ab := 29;
            when 6 .. 8  => ab := 30;
            when 9 .. 100 => ab := 31;
            when others => ab := 9999; -- BLOW UP
         end case;
         
         region_counts( hh.household.GVTREGN ) := region_counts( hh.household.GVTREGN ) + 1; 
         
         cv( ab ) := 1.0;
         -- TENTYPE2 
         -- 
         -- Value = 1	Label = LA / New Town / NIHE / Council rented            1 
         -- Value = 2	Label = Housing Association / Co-Op / Trust rented       2
         -- Value = 3	Label = Other private rented unfurnished                 3
         -- Value = 4	Label = Other private rented furnished                   3
         -- Value = 5	Label = Owned with a mortgage (includes part rent / part own) 4 
         -- Value = 6	Label = Owned outright 5
         -- Value = 7	Label = Rent-free 6
         -- Value = 8	Label = Squats    6

         --
         -- add individual level stuff; just age, ethicity & gender so far
         --
         for buno in  1 .. hh.num_benefit_units loop
               for adno in 1 .. hh.benunits( buno ).numAdults loop
                  declare
                     ad : Adult_Rec renames hh.benunits( buno ).adults( adno ).adult;
                  begin
                     Put_Line( 
                        "ADULT age " & ad.AGE'Img & 
                        " IAGEGR2 " & ad.IAGEGR2'Img & 
                        " IAGEGR3 " & ad.IAGEGR3'Img & 
                        " IAGEGR4 " & ad.IAGEGR4'Img & 
                        " IAGEGRP " & ad.IAGEGRP'Img );
                        
                     ab := ad.IAGEGR3;
                     cv( ab ) := cv( ab ) + 1.0;
                     ab := Map_Ethnic_Group( ad.ETHGRP ) + 11;
                     cv( ab ) := cv( ab ) + 1.0;
                     if( buno = 1 ) and ( adno = 1 )then
                        heads_race := ab;
                     end if;
                     ab := ad.SEX + 16;
                     cv( ab ) := cv( ab ) + 1.0;
                     frs_person_count := frs_person_count + 1.0;
                  end;
               end loop;
               for chno in 1 .. hh.benunits( buno ).num_children loop
                  declare
                     ch : Child_Rec renames hh.benunits( buno ).children( chno ).child;
                  begin
                     Put_Line(  
                      "CHILD IAGEGR2 " & ch.IAGEGR2'Img &
                      "IAGEGRP " & ch.IAGEGRP'Img & 
                      "AGE " & ch.AGE'Img );
                     ab := ch.IAGEGRP;
                     cv( ab ) := cv( ab ) + 1.0;
                     ab := ch.SEX + 16;
                     cv( heads_race ) := cv( heads_race ) + 1.0; 
                     cv( ab ) := cv( ab ) + 1.0;                     
                     frs_person_count := frs_person_count + 1.0;
                  end;
               end loop;
         end loop;
         return cv;
      end Map_Household;

      
      function Get_Target_Vector_For_LA( la : Local_Authorities ) return Row_Vector is
         v : constant Weight_Targets_Array := ALL_LAS( la );
         cv : Row_Vector;
      begin
      
      -- IAGEGRP
      -- Value = 1	Label = Age 4 and under 
      -- Value = 2	Label = Age 5 to 10 
      -- Value = 3	Label = Age 11 to 15 
	-- 
      -- IAGEGR3
      -- Value = 4	Label = Age 16 to 24 
      -- Value = 5	Label = Age 25 to 34 
      -- Value = 6	Label = Age 35 to 44 
      -- Value = 7	Label = Age 45 to 54 
      -- Value = 8	Label = Age 55 to 59 
      -- Value = 9	Label = Age 60 to 64 
      -- Value = 10	Label = Age 65 to 74 
      -- Value = 11	Label = Age 75 or over 

         --
         -- ages 1 .. 15
         --
         cv( 1 ) := sum( v, age_ranges_age_under_1,  age_ranges_age_4  ); 
         cv( 2 ) := sum( v, age_ranges_age_5,  age_ranges_age_10  ); 
         cv( 3 ) := sum( v, age_ranges_age_11,  age_ranges_age_15  ); 
         cv( 4 ) := sum( v, age_ranges_age_16,  age_ranges_age_24  ); 
         cv( 5 ) := sum( v, age_ranges_age_25,  age_ranges_age_34  ); 
         cv( 6 ) := sum( v, age_ranges_age_35,  age_ranges_age_44  ); 
         cv( 7 ) := sum( v, age_ranges_age_45,  age_ranges_age_54  ); 
         cv( 8 ) := sum( v, age_ranges_age_55,  age_ranges_age_59  ); 
         cv( 9 ) := sum( v, age_ranges_age_60,  age_ranges_age_64  ); 
         cv( 10 ) := sum( v, age_ranges_age_65,  age_ranges_age_74  ); 
         cv( 11 ) := sum( v, age_ranges_age_75,  age_ranges_age_100_and_over );
         cv( 12 ) := v( ethnic_group_white );
         cv( 13 ) := v( ethnic_group_mixed );
         cv( 14 ) := v( ethnic_group_asian );
         cv( 15 ) := v( ethnic_group_black );
         cv( 16 ) := v( ethnic_group_other );
         
         -- m/f 16-17
         cv( 17 ) := v( genders_males );
         cv( 18 ) := v( genders_females );
         --
         -- tenure 18-23
         --
         cv( 19 ) := v( tenure_type_social_rented_rented_from_council_local_authority );
         cv( 20 ) := v( tenure_type_social_rented_other_social_rented );
         cv( 21 ) := Sum( v, tenure_type_private_rented_private_landlord_or_letting_agency, tenure_type_private_rented_other );
         cv( 22 ) := Sum( v, tenure_type_owned_owned_with_a_mortgage_or_loan, tenure_type_shared_ownership_part_owned_and_part_rented );
         cv( 23 ) := v( tenure_type_owned_owned_outright ); 
         cv( 24 ) := v( tenure_type_living_rent_free ); 
         --
         -- Room could 24-30
         --         
         cv( 25 ) := v( number_of_rooms_1_room );
         cv( 26 ) := v( number_of_rooms_2_rooms );
         cv( 27 ) := v( number_of_rooms_3_rooms );
         cv( 28 ) := v( number_of_rooms_4_rooms );
         cv( 29 ) := v( number_of_rooms_5_rooms );
         cv( 30 ) := Sum( v, number_of_rooms_6_rooms, number_of_rooms_8_rooms );
         cv( 31 ) := v( number_of_rooms_9_or_more_rooms );
      
         return cv;
      end Get_Target_Vector_For_LA;
      
      procedure Dump_Main_Dataset( filename : String ) is
         f : File_Type;         
      begin
         Create( f, Out_File, filename );
         for hh in Col_Vector'Range loop
            for row in Row_Vector'Range loop
               Put( f, observations( hh, row )'Img );
               if( row < Row_Vector'Last )then
                  Put( f, "," );
               end if;
            end loop;
            New_Line( f );
         end loop;
         Close( f );
      end Dump_Main_Dataset;

      --
      -- grab the next household and add a row vector of data for it 
      -- to the main dataset; data layout matches the totals target above
      --
      procedure Load_Household( pos : Cursor ) is
         hh       : Raw_FRS.Raw_Household;
         
         --
         -- create a row vector with counts for people in age ranges & genders (and more to come) 
         --
         
         counts_for_hh : Row_Vector;
      begin
         index := Element( pos );
         hh := Get_Household( index );
         if( hh.household.GVTREGN < 99 )then -- no scotland and ireland
            hhno := hhno + 1;
            ptrs( hhno ).region := hh.household.GVTREGN;
            ptrs( hhno ).sernum := hh.household.sernum;
            counts_for_hh := Map_Household( hh );
            for i in Row_Vector'Range loop
               observations( hhno, i ) := counts_for_hh( i );
            end loop;
            Put_Line( "On HHLD" & hhno'Img );
            if( hhno mod 10_000 = 0 ) then
               Put_Line( "raw household " & Natural'Image( hhno ) );
               Put_Line( Raw_FRS.To_String( hh ));
            end if;
         end if;
      end Load_Household;
      
      i : Natural := 0;      
   begin
      --
      -- Iterate over each FRS household creating our main dataset
      -- This has 1 row per household, 30 (to date) columns with
      -- col
      LA_Reweighter.Read_Pointers( "data/frs/hh_regional_pointers.csv" );
      Put_Line( "opening indexes" );
      Restore_Complete_Index( BASE_DATA_DIR & DATA_YEAR_STRINGS(this_year) & "/bin/index.bin", index_map );
      Put_Line( "opening data files" );
      FRS_Binary_Reads.Open_Files( this_year );
      Put_Line( "starting iterations" );
      Iterate( index_map, Load_Household'Access );
      declare
         f :  File_Type;
      begin
          Create( f, Out_File, "output/" & "hh_regional_pointers.csv" );
          for hhno in ptrs'Range loop
            Put_Line( f, 
            hhno'Img & "," & ptrs( hhno ).sernum'Img & "," & ptrs( hhno ).region'Img ); 
         end loop;       
         Close( f );
      end;

      -- We now have our main dataset
      -- For each LA in the 2011 Nomis Census data,
      -- create our weights and write them to a file; 
      -- set initial weights as LA households/FRS Households
      -- FIXME: non-hhld population??
      -- write weights for each LA to a file 
      -- TODO: include hh reference numbers in each file 
      --
      
      for r in 1  .. 13 loop
         Put_Line( "Region " & r'Img & " " & region_counts( r )'Img );
      end loop;
      
      for which_la in District_Or_Unitary_Authorities loop
         declare
            la_household_total  : constant Amount := ALL_LAS( which_la )( tenure_type_all_categories_tenure );
            initial_weight      : constant Amount := la_household_total/Amount( num_households ); 
            initial_weights     : Col_Vector := ( others => initial_weight );
            weights             : Col_Vector;
            curr_iterations     : Positive;
            curr_error          : Eval_Error_Type;
            target_populations  : Row_Vector := Get_Target_Vector_For_LA( which_la );
            f                   : File_Type;
         begin      
            i := i+ 1;
            -- exit when i > 1; -- TEMP
            Do_Reweighting(
               Data               => observations, 
               Which_Function     => weighting_function,
               Initial_Weights    => initial_weights,            
               Target_Populations => target_populations,
               TolX               => 0.01,
               TolF               => 0.01,
               Max_Iterations     => 40,
               RU                 => Weighting_Upper_Bound,
               RL                 => Weighting_Lower_Bound,
               New_Weights        => weights,
               Iterations         => curr_iterations,
               Error              => curr_error );
            Create( f, Out_File, "output/" & which_la'Img & "_weights.csv" );
            Put_Line( f, "Error " & curr_error'Img );
            Put_Line( f, "Iterations " & curr_iterations'Img );
            Put_Line( f, "Initial,Final" );
            for hhno in 1 .. num_households loop
               Put_Line( f, initial_weights( hhno )'Img & "," & weights( hhno )'Img );
            end loop;
            Close( f );
         end;
      end loop;
      Dump_Main_Dataset( "output/main_dataset.csv" );

      FRS_Binary_Reads.Close_Files;
   end FRS_Read_Test;
   
   
   procedure Register_Tests (T : in out Test_Case) is
      
   begin
      Register_Routine (T, FRS_Read_Test'Access, "" );
   end Register_Tests;
   
   --  Register routines to be run
   
   
   function Name ( t : Test_Case ) return Message_String is
   begin
      return Format( "Lab_Test Test Suite" );
   end Name;

   --  Preparation performed before each routine:
   procedure Set_Up( t : in out Test_Case ) is
   begin
      GNATColl.Traces.Parse_Config_File( "./etc/logging_config_file.txt" );
   end Set_Up;
   
   --  Preparation performed after each routine:
   procedure Shut_Down( t : in out Test_Case ) is
   begin
      null;
   end Shut_Down;
   
begin
   null;
end LAB_Test;
