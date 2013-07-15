with Ada.Exceptions;
with Ada.Strings.Unbounded; 
with Ada.Text_IO;
with Ada.Assertions;
with GNATColl.Traces;

with FRS_Binary_Reads;
with Utils;
with Text_Utils;
with Base_Types;
with Target_Candidates_Type_IO;
with Conversions.FRS;
with Data_Constants;
with GNATCOLL.SQL.Exec;
with Connection_Pool;
--
--
-- 
package body FRS_Dataset_Creator is
   
   use Ada.Strings.Unbounded;
   use Ada.Text_IO;
   use Ada.Exceptions;
   use La_Data_Data;
   use Base_Types;
   use Ada.Assertions;
      
   package dexec renames GNATCOLL.SQL.Exec; 

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "FRS_DATASET_CREATOR" );

   procedure Inc( a : in out Real; times : Natural := 1 ) is
   begin
      a := a + Real( times );
   end Inc;
   
   procedure Map_HB_CTB( HBINDBU2 : Integer; TENTYP2 : Integer; num_bus : Integer; t : in out Target_Candidates_Type ) is
   begin
      case HBINDBU2 is
         when 0 => 
         -- 0	Benefit Units with no CTB nor HB nor IS/PC/JSA[IB]/ESA[IR]
            null;
         when 1 =>
            Inc( t.Ct_All );
            Inc( t.Ct_Non_Passported );
         -- 1	Benefit Units with CTB only (no HB, IS/PC/JSA[IB]/ESA[IR])
         when 2 =>
            Inc( t.HB_Total );
            Inc( t.HB_Non_Passported );   
            -- 2	Benefit Units with HB only (no CTB, IS/PC/JSA[IB]/ESA[IR])
            if TENTYP2 = 1 then
               Inc( t.Hb_Social_Rented_Sector );
            elsif( TENTYP2 <= 9 or num_bus > 1 )then -- or num_bus > 1 covers hb for 2nd units, crudely
               -- <= 9 just turns this off; should be <= 5 - there are rent-free
               -- single bu hhls receiving  hb
               -- could be true, I suppose (could it?)
               Inc( t.Hb_Private_Rented_Sector );
            else
               Raise_Exception( Weighting_Exception'Identity, 
                        "HB Received for non renter: TENTYP2 = " & TENTYP2'Img );
            end if;
         when 3 => 
            -- 3	Benefit Units with IS/PC/JSA[IB]/ESA[IR] only (no CTB, HB)
            null;
         when 4 =>
            -- 4	Benefit Units with HB and CTB (no IS/PC/JSA[IB]/ESA[IR])
            Inc( t.Ct_All );
            Inc( t.Ct_Non_Passported );
            Inc( t.HB_Total );
            Inc( t.HB_Non_Passported );               
            if TENTYP2 = 1 then
               Inc( t.Hb_Social_Rented_Sector );
            elsif( TENTYP2 <= 9  or num_bus > 1 )then
               Inc( t.Hb_Private_Rented_Sector );
            else
               Raise_Exception( Weighting_Exception'Identity, 
                        "HB Received for non renter: TENTYP2 = " & TENTYP2'Img );
            end if;
         when 5 =>      
            -- 5	Benefit Units with HB and IS/PC/JSA[IB]/ESA[IR] (no CTB)
            Inc( t.HB_Total );
            Inc( t.HB_Passported );               
            if TENTYP2 = 1 then
               Inc( t.Hb_Social_Rented_Sector );
            elsif( TENTYP2 <= 9  or num_bus > 1 )then
               Inc( t.Hb_Private_Rented_Sector );
            else
               Raise_Exception( Weighting_Exception'Identity, 
                        "HB Received for non renter: TENTYP2 = " & TENTYP2'Img );
            end if;
         when 6 =>                  
            -- 6	Benefit Units with CTB and IS/PC/JSA[IB]/ESA[IR] (no HB)
            Inc( t.Ct_All );
            Inc( t.Ct_Passported );
         when 7 =>
            -- 7	Benefit Units with CTB and HB and IS/PC/JSA[IB]/ESA[IR]
            Inc( t.Ct_All );
            Inc( t.Ct_Passported );
            Inc( t.HB_Total );
            Inc( t.HB_Passported );               
            if TENTYP2 = 1 then
               Inc( t.Hb_Social_Rented_Sector );
            elsif( TENTYP2 <= 9  or num_bus > 1 )then
               Inc( t.Hb_Private_Rented_Sector );
            else
               Raise_Exception( Weighting_Exception'Identity, 
                  "HB Received for non renter: TENTYP2 = " & TENTYP2'Img );
            end if;
         when others =>
               Raise_Exception( Weighting_Exception'Identity, 
                  "bu.Benunit_Rec.HBINDBU2 out of range = " & HBINDBU2'Img );                  
      end case;
   end Map_HB_CTB;
   
   procedure Map_Ethnic_Group( ieg : Integer;  t : in out Target_Candidates_Type; n : Natural := 1 ) is
   begin
      Inc( t.Ethgrp_All_Categories_Ethnic_Group );
      Put_Line( "eth group : in : " & ieg'Img );
      case ieg is
         when 1 | -1  => -- Treating all missing as white!
            -- Value = 1	Label = White - British 
            Inc( t.Ethgrp_White, n );
            Inc( t.Ethgrp_White_English_Welsh_Scottish_Northern_Irish_British, n );
         when 2 =>
            -- Value = 2	Label = White - Irish   
            Inc( t.Ethgrp_White, n );
            Inc( t.Ethgrp_White_Irish, n );
         when 3 =>
            -- Value = 3	Label = Any other white background 
            Inc( t.Ethgrp_White, n );
            Inc( t.Ethgrp_White_Other_White, n );
         when 4 =>
            -- Value = 4	Label = Mixed - White and Black Caribbean  
            Inc( t.Ethgrp_Mixed, n );
            Inc( t.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_Caribbean, n );
         when 5 =>
            -- Value = 5	Label = Mixed - White and Black African 
            Inc( t.Ethgrp_Mixed, n );
            Inc( t.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Black_African, n );
         when 6 =>
            -- Value = 6	Label = Mixed - White and Asian 
            Inc( t.Ethgrp_Mixed, n );
            Inc( t.Ethgrp_Mixed_Multiple_Ethnic_Group_White_And_Asian, n );
         when 7 =>   
            -- Value = 7	Label = Any other mixed background 
            Inc( t.Ethgrp_Mixed, n );
            Inc( t.Ethgrp_Mixed_Multiple_Ethnic_Group_Other_Mixed, n );
         when 8 =>
            -- Value = 8	Label = Asian or Asian British - Indian 
            Inc( t.Ethgrp_Asian, n );
            Inc( t.Ethgrp_Asian_Asian_British_Indian, n );
         when 9 =>
            -- Value = 9	Label = Asian or Asian British - Pakistani 
	         Inc( t.Ethgrp_Asian, n );
            Inc( t.Ethgrp_Asian_Asian_British_Pakistani, n );
         when 10 =>
            -- Value = 10	Label = Asian or Asian British - Bangladeshi 
            Inc( t.Ethgrp_Asian, n );
            Inc( t.Ethgrp_Asian_Asian_British_Bangladeshi, n );
         when 11 =>
            -- Value = 11	Label = Any other Asian/Asian British background 
            Inc( t.Ethgrp_Asian, n );
            Inc( t.Ethgrp_Asian_Asian_British_Other_Asian, n );
         when 12 =>
            -- Value = 12	Label = Black or Black British - Caribbean          
            Inc( t.Ethgrp_Black, n );
            Inc( t.Ethgrp_Black_African_Caribbean_Black_British_Caribbean, n );
         when 13 =>   
            -- Value = 13	Label = Black or Black British - African 
	         Inc( t.Ethgrp_Black, n );
            Inc( t.Ethgrp_Black_African_Caribbean_Black_British_African, n );
         when 14 =>
            -- Value = 14	Label = Any other Black/Black British background  
		      Inc( t.Ethgrp_Black, n );
            Inc( t.Ethgrp_Black_African_Caribbean_Black_British_Other_Black, n );
         when 15 =>
            -- Value = 15	Label = Chinese 
		      Inc( t.Ethgrp_Asian, n );
            Inc( t.Ethgrp_Asian_Asian_British_Chinese, n );
         when 16 =>
            Inc( t.Ethgrp_Other, n );
            -- NOTE: census has Arab/Other breakdown here
         when others => Raise_Exception( Weighting_Exception'Identity, 
               "Unmapped Ethnic Group " & ieg'Img );
      end case;
   end Map_Ethnic_Group;
      
   function Map_Household( hh : Raw_FRS.Raw_Household ) return La_Data_Data.Target_Candidates_Type is
   use Raw_FRS;
      t : Target_Candidates_Type; 
   begin
      Put_Line( "at start of Map Household" );
      Inc( t.Tenure_All_Categories_Tenure );
      case hh.household.TENTYP2 is
         when 1 =>
            -- Value = 1	Label = LA / New Town / NIHE / Council rented 
            Inc( t.Tenure_Social_Rented_Total );
            Inc( t.Tenure_Social_Rented_Rented_From_Council_Local_Authority );
         when 2 =>
            -- Value = 2	Label = Housing Association / Co-Op / Trust rented       
            Inc( t.Tenure_Social_Rented_Total );
            Inc( t.Tenure_Social_Rented_Other_Social_Rented );
         when 3 =>
            -- Value = 3	Label = Other private rented unfurnished
            -- private rented cats don't match at all between NOMIS and FRS
            Inc( t.Tenure_Private_Rented_Total );
         when 4 =>
            -- Value = 4	Label = Other private rented furnished                   
            Inc( t.Tenure_Private_Rented_Total );
         when 5 =>
            -- Value = 5	Label = Owned with a mortgage (includes part rent / part own) 
            -- again no part rent slot in NOMIS
            Inc( t.Tenure_Owned_Total );
            Inc( t.Tenure_Owned_Owned_With_A_Mortgage_Or_Loan );
         when 6 =>   
            -- Value = 6	Label = Owned outright 
            Inc( t.Tenure_Owned_Total );
            Inc( t.Tenure_Owned_Owned_Outright );
         when 7 =>
             -- Value = 7	Label = Rent-free
             Inc( t.Tenure_Living_Rent_Free );
         when 8 =>
            -- Value = 8	Label = Squats    6
             Inc( t.Tenure_Living_Rent_Free );
         when others => Raise_Exception( Weighting_Exception'Identity, 
               "Unmapped tenure " & hh.household.TENTYP2'Img );
      end case;
      Put_Line( "rooms : " & hh.household.ROOMS10'Img );
      Inc( t.Number_Of_Rooms_All_Categories_Number_Of_Rooms );
      case hh.household.ROOMS10 is
         when 1 =>
            Inc( t.Number_Of_Rooms_1_Room );
         when 2 =>
            Inc( t.Number_Of_Rooms_2_Rooms );
         when 3 =>
            Inc( t.Number_Of_Rooms_3_Rooms );
         when 4 =>
            Inc( t.Number_Of_Rooms_4_Rooms );
         when 5 =>
            Inc( t.Number_Of_Rooms_5_Rooms );
         when 6 =>
            Inc( t.Number_Of_Rooms_6_Rooms );
         when 7 =>
            Inc( t.Number_Of_Rooms_7_Rooms );
         when 8 =>
            Inc( t.Number_Of_Rooms_8_Rooms );
         when 9 .. 10 =>
            Inc( t.Number_Of_Rooms_9_Or_More_Rooms );
         when others => Raise_Exception( Weighting_Exception'Identity, 
               "Unmapped room count " & hh.household.ROOMS10'Img );
      end case;      
      --
      -- add individual level stuff; just age, ethicity, emp status, occupation so far
      -- NOTE that age in years is blank in this dataset, so using IAGEGR3 directly
      each_bu:
      for buno in  1 .. hh.num_benefit_units loop
         declare
            bu : Raw_Benefit_unit renames hh.benunits( buno );
            on_child_tax_credit : Boolean := False;
            on_working_tax_credit : Boolean := False;
         begin
            -- hb/ctb + passported benefit
            Map_HB_CTB( bu.benunit.HBINDBU2, hh.household.TENTYP2, hh.num_benefit_units, t );
            each_adult:
            for adno in 1 .. bu.numAdults loop
               declare
                  ad : Adult_Rec renames bu.adults( adno ).adult;
               begin
                  -- This is all I have since the other age things have been NULLED
                  -- add to bottom end of range & sort out at the aggregation stage
                  case ad.IAGEGR3 is
                     when 4 =>
                        -- Value = 4	Label = Age 16 to 24 
                        Inc( t.Age_Ranges_Age_16 );
                     when 5 => 
                        -- Value = 5	Label = Age 25 to 34
                        Inc( t.Age_Ranges_Age_25 );
                     when 6 =>
                        -- Value = 6	Label = Age 35 to 44 
                        Inc( t.Age_Ranges_Age_35 );
                     when 7 =>  
                        -- Value = 7	Label = Age 45 to 54 
                        Inc( t.Age_Ranges_Age_45 );
                     when 8 =>  
                        --  Value = 8	Label = Age 55 to 59
                        Inc( t.Age_Ranges_Age_55 );
                     when 9 =>  
                        --  Value = 9	Label = Age 60 to 64 
                        Inc( t.Age_Ranges_Age_60 );
                     when 10 =>  
                        --   Value = 10	Label = Age 65 to 74
                        Inc( t.Age_Ranges_Age_65 );
                     when 11 =>
                        -- Value = 11	Label = Age 75 or over 
                        Inc( t.Age_Ranges_Age_75 );
                     when others => Raise_Exception( Weighting_Exception'Identity, 
                        "Unmapped age bracket " & ad.IAGEGR3'Img );
                  end case;
                  Map_Ethnic_Group( ad.ETHGRP, t );
                  if( adno = 1 ) and bu.num_children > 0 then
                     Map_Ethnic_Group( ad.ETHGRP, t, bu.num_children );
                  end if;
                  Inc( t.Genders_All_Usual_Residents );
                  case ad.SEX is
                     when 1 => Inc( t.Genders_Males );
                     when 2 => Inc( t.Genders_Females );
                     when others => Raise_Exception( Weighting_Exception'Identity, 
                              "Unmapped adult gender " & ad.SEX'Img );
                  end case;
                  
                  -- is, pension credit and jsa: in current receipt.
                  if( ad.BEN3Q1 = 1 )then
                     Inc( t.JSA_Total );
                  end if;
                  if( ad.BEN3Q2 = 1 )then
                     Inc( t.income_support_people_claiming_benefit );
                  end if;
                  if( ad.TAXCRED2 = 1 )then
                     on_child_tax_credit := True;
                  end if;
                  --  In receipt:Child Tax Credit
                  if( ad.TAXCRED1 = 1 )then
                     on_working_tax_credit := True;
                  end if;   
                  if( ad.BEN3Q6 = 1 )then
                     Inc( t.pension_credits_number_of_claimants );
                  end if;
                  
                  -- economic activity and occupation, u75 adults only to match NOMIS empoyment data
                  -- 
                  if( ad.IAGEGR3 < 11 )then
                     Inc( t.Ec_Act_All_Categories_Economic_Activity );
                     --
                     -- NOTE a crosstable of EMPSTAT1 against DVIL03A looks
                     -- a bit peculiar, esp around pt self employed and unoccupied
                     --
                     case ad.EMPSTATI is
                       when 1 =>
                           -- Value = 1	Label = Full-time Employee
                           Inc( t.Ec_Act_Active_Total );
                           Inc( t.Ec_Act_Active_Employee_Full_Time );
                        when 2 =>
                           -- 	Value = 2	Label = Part-time Employee 
                          Inc( t.Ec_Act_Active_Total );
                          Inc( t.Ec_Act_Active_Employee_Part_Time );
                        when 3 =>
                           -- Value = 3	Label = Full-time Self-Employed 
	                       Inc( t.Ec_Act_Active_Total );
	                       if( ad.ES2000 = 3 )then -- again the ES2000/EMPSTAT1 crosstab looks weird
	                          Inc( t.Ec_Act_Active_Self_Employed_Without_Employees_Full_Time );
	                       else
	                          Inc( t.Ec_Act_Active_Self_Employed_With_Employees_Full_Time );
	                       end if;
                        when 4 =>
                          -- Value = 4	Label = Part-time Self-Employed 
	                       Inc( t.Ec_Act_Active_Total );
	                       if( ad.ES2000 = 3 )then -- again the ES2000/EMPSTAT1 crosstab looks weird
	                          Inc( t.Ec_Act_Active_Self_Employed_Without_Employees_Part_Time );
	                       else
	                          Inc( t.Ec_Act_Active_Self_Employed_With_Employees_Part_Time );
	                       end if;
                        when 5 | 10 =>  
                           -- Value = 5	Label = Unemployed
                           -- Value = 10	Label = Temporarily sick/injured !! not sure about sick/inj here
                           Inc( t.Ec_Act_Active_Total );
                           Inc( t.Ec_Act_Active_Unemployed );
                        when 6 =>
                           -- Value = 6	Label = Retired 
                           Inc( t.Ec_Act_Inactive_Total );
                           Inc( t.Ec_Act_Inactive_Retired );
                        when 7 =>
                           -- Value = 7	Label = Student 
                           if( ad.EMPSTATI = 1 )then
                              Inc( t.Ec_Act_Active_Total );
                              Inc( t.Ec_Act_Active_Full_Time_Student );
                           else
                              Inc( t.Ec_Act_Inactive_Total );
                              Inc( t.Ec_Act_Inactive_Student_Including_Full_Time_Students );
                           end if;
                        when 8 =>
                           -- Value = 8	Label = Looking after family/home 
	                        Inc( t.Ec_Act_Inactive_Total );
                           Inc( t.Ec_Act_Inactive_Looking_After_Home_Or_Family );
                        when 9 =>
                           -- Value = 9	Label = Permanently sick/disabled
                           Inc( t.Ec_Act_Inactive_Total );
                           Inc( t.Ec_Act_Inactive_Long_Term_Sick_Or_Disabled );
                        when 11 =>
                           -- 	Value = 11	Label = Other Inactive 
                           Inc( t.Ec_Act_Inactive_Total );
                           Inc( t. Ec_Act_Inactive_Other );                                                                             
                        when others =>
                           Raise_Exception( Weighting_Exception'Identity, 
                              "Unmapped empoyment status " & ad.EMPSTATI'Img );
                     end case;
                     if ad.DVIL03A = 1 then -- currently employed u75s only
                        Inc( t.Occupation_All_Categories_Occupation );
                        case ad.SOC2000 is
                           when 0	=>
                              -- Value = 0	Label = Undefined 
	                           null; 
                           when 1000 => 
                              -- Value = 1000	Label = Managers & Senior Officials 
	                           Inc( t.Occupation_1_Managers_Directors_And_Senior_Officials );
                           when 2000 =>
                              -- Value = 2000	Label = Professional Occupations 
	                           Inc( t.Occupation_2_Professional_Occupations );                              
                           when 3000 => 
                              -- Value = 3000	Label = Associate Prof. & Technical Occupations 
	                           Inc( t.Occupation_3_Associate_Professional_And_Technical_Occupations );
                           when 4000 => 
                              -- Value = 4000	Label = Admin & Secretarial Occupations 
                              Inc( t.Occupation_4_Administrative_And_Secretarial_Occupations );
                           when 5000 =>
                              -- Value = 5000	Label = Skilled Trades Occupations 
                              Inc( t.Occupation_5_Skilled_Trades_Occupations );
                           when 6000 =>                               
                              -- Value = 6000	Label = Personal Service Occupations 
	                           Inc( t.Occupation_6_Caring_Leisure_And_Other_Service_Occupations );
                           when 7000 =>
                              -- Value = 7000	Label = Sales & Customer Service 
                              Inc( t.Occupation_7_Sales_And_Customer_Service_Occupations );
                           when 8000 =>
                              -- Value = 8000	Label = Process, Plant & Machine Operatives 
                              Inc( t.Occupation_8_Process_Plant_And_Machine_Operatives );
                           when 9000 => 
                              -- Value = 9000	Label = Elementary Occupations 
                              Inc( t.Occupation_9_Elementary_Occupations );
                           when others => Raise_Exception( Weighting_Exception'Identity, 
                              "Unmapped occupation for employed person " & ad.SOC2000'Img );
                        end case;
                     end if;
                  end if;
               end; -- Adult
            end loop each_adult;
            if on_child_tax_credit or on_working_tax_credit then
               Inc( t.Credits_Total_Families );
            end if;
            --
            -- Fixme below is mostly wrong because it doesn't sep out unemployed
            -- which the HMRC data does
            -- 
            if on_child_tax_credit and on_working_tax_credit then
               Inc( t.wtc_and_ctc_families );
            elsif on_child_tax_credit then
               Inc( t.ctc_only_families );
            elsif on_working_tax_credit then
               if bu.num_children = 0 then               
                  Inc( t.credits_no_children );
               else
                  -- obviously, this shouldn't ever happen, but look at
                  -- 09/10 sernum 14193 bu 1 - 19 yo FRS kid no longer qualifying
                  -- for CTC but parent getting WTC
                  Put_Line( "HHLDS with WTC/no CTC, but children " );
                  Put_Line( To_String( hh ));
                  -- no slot for this in HMCR by-Council data but this is closest
                  Inc( t.wtc_and_ctc_families );
                  -- Raise_Exception( Weighting_Exception'Identity, " no ctc, wtc, but some children present " & bu.num_children'Img );
               end if;                  
            end if;
            each_child:
            for chno in 1 .. hh.benunits( buno ).num_children loop
               declare
                  ch : Child_Rec renames hh.benunits( buno ).children( chno ).child;
               begin
                  Put_Line(  
                   "CHILD IAGEGR2 " & ch.IAGEGR2'Img &
                   "IAGEGRP " & ch.IAGEGRP'Img & 
                   "AGE " & ch.AGE'Img );
                  case ch.AGE is
                     when 0 => Inc( t.Age_Ranges_Age_Under_1 );
                     when 1 => Inc( t.Age_Ranges_Age_1 );
                     when 2 => Inc( t.Age_Ranges_Age_2 );
                     when 3 => Inc( t.Age_Ranges_Age_3 );
                     when 4 => Inc( t.Age_Ranges_Age_4 ); 
                     when 5 => Inc( t.Age_Ranges_Age_5 ); 
                     when 6 => Inc( t.Age_Ranges_Age_6 ); 
                     when 7 => Inc( t.Age_Ranges_Age_7 ); 
                     when 8 => Inc( t.Age_Ranges_Age_8 ); 
                     when 9 => Inc( t.Age_Ranges_Age_9 );
                     when 10 => Inc( t.Age_Ranges_Age_10 );
                     when 11 => Inc( t.Age_Ranges_Age_11 );
                     when 12 => Inc( t.Age_Ranges_Age_12 );
                     when 13 => Inc( t.Age_Ranges_Age_13 );
                     when 14 => Inc( t.Age_Ranges_Age_14 ); 
                     when 15 => Inc( t.Age_Ranges_Age_15 ); 
                     when 16 => Inc( t.Age_Ranges_Age_16 ); 
                     when 17 => Inc( t.Age_Ranges_Age_17 ); 
                     when 18 => Inc( t.Age_Ranges_Age_18 ); 
                     when 19 => Inc( t.Age_Ranges_Age_19 );
                     
                     when others => Raise_Exception( Weighting_Exception'Identity, 
                              "Unmapped child age " & ch.AGE'Img );
                  end case;      
                  -- count 16-19 yos as economically inactive to match NOMIS;
                  -- they'd have adult records if working
                  if( ch.AGE >= 16 )then
                     Inc( t.Ec_Act_Inactive_Total );
                     -- !!! is this right?
                     Inc( t.Ec_Act_Inactive_Student_Including_Full_Time_Students );
                  end if;
                  Inc( t.Genders_All_Usual_Residents );
                  case ch.SEX is
                     when 1 => Inc( t.Genders_Males );
                     when 2 => Inc( t.Genders_Females );
                     when others => Raise_Exception( Weighting_Exception'Identity, 
                              "Unmapped adult gender " & ch.SEX'Img );
                  end case;
               end; -- child
            end loop each_child;
         end; -- BU declaration
      end loop each_bu;
      return t;
   end Map_Household;
   
   procedure Create_Dataset( start_year, end_year : Data_Years ) is
   use Conversions.FRS; 
   use FRS_Index_Package;
   
      connection : dexec.Database_Connection := Connection_Pool.Lease;
      this_year : Data_Years;
      p           : Natural := 0;   
      
      procedure Map_And_Save_Household( pos : Cursor ) is
         rawhh       : Raw_FRS.Raw_Household;
         index       : Index_Rec;
         t           : Target_Candidates_Type; 
      begin
         index := Element( pos );
         p := p + 1;
         rawhh := FRS_Binary_Reads.Get_Household( index );
         Put_Line( " region is " & rawhh.household.GVTREGN'Img & " num bus " & rawhh.num_benefit_units'Img );
         t := Map_Household( rawhh );
         t.id := Integer( rawhh.household.sernum );
         t.edition := EDITION;
         t.code := To_Unbounded_String( DATA_YEAR_STRINGS( this_year ));
         t.frs_region := rawhh.household.GVTREGN;
         Target_Candidates_Type_IO.Save( t, True, connection );
      end Map_And_Save_Household;
      
      index_map   : FRS_Index;
   begin
      Put_Line( "started" );
      for year in start_year .. end_year loop
         this_year := year; -- semi global for the iterate function
         put_line( "on year " & year'Img );
         Restore_Complete_Index( BASE_DATA_DIR & DATA_YEAR_STRINGS(year) & "/bin/index.bin", index_map );
         FRS_Binary_Reads.Open_Files( year );
         Iterate( index_map, Map_And_Save_Household'Access );
         FRS_Binary_Reads.Close_Files;
      end loop;
      put_line( "done" );
      connection.Commit;
      Connection_Pool.Return_Connection( connection );
   end Create_Dataset;
   
end FRS_Dataset_Creator;
