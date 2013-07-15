--
-- Created by ada_generator.py on 2013-04-12 16:52:17.765545
-- 
with AUnit.Test_Suites; use AUnit.Test_Suites;

-- with LAB_Test;
with LA_Reweighter.Tests;
with Model.FRS_Reweighter.Tests;
with FRS_Dataset_Creator.Tests;
with GNATColl.Traces;
with GNAT.Command_Line;
with Ada.Text_IO;

function Suite return Access_Test_Suite is
   
use GNAT.Command_Line;   
use Ada.Text_IO;
   
   result              : Access_Test_Suite := new Test_Suite;
   run_old_tests       : Boolean := False;
   create_frs          : Boolean := False;
   run_generator_tests : Boolean := False;
   
   
   
begin
   GNATColl.Traces.Parse_Config_File( "./etc/logging_config_file.txt" );
   loop
      case Getopt ("o f g h") is         
         when ASCII.NUL => exit;
         when 'o' => run_old_tests := True;
         when 'f' => create_frs := True;
         when 'g' => run_generator_tests := True;
         when 'h' => 
            Put_Line( "Usage: -o run old tests; -f create FRS dataset; -g run generator tests; -h print help " );
            return result;
         when others => null;
      end case;
   end loop;
   if( run_old_tests )then
      Add_Test( result, new LA_Reweighter.Tests.Test_Case );
   end if;
   
   if( create_frs )then
      Add_Test( result, new FRS_Dataset_Creator.Tests.Test_Case );
   end if;
   
   if( run_generator_tests )then
      Add_Test( result, new Model.FRS_Reweighter.Tests.Test_Case );
   end if;
   
   return result;
end Suite;
