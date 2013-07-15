--
-- Created by ada_generator.py on 2013-06-12 18:50:26.472580
-- 
with AUnit.Test_Suites; use AUnit.Test_Suites;

with La_Data_Test;

function Suite return Access_Test_Suite is
        result : Access_Test_Suite := new Test_Suite;
begin
        Add_Test( result, new La_Data_Test.test_Case ); -- Adrs_Data_Ada_Tests.Test_Case
        return result;
end Suite;
