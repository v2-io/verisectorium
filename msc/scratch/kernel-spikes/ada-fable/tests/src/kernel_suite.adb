with Worked_Example;
with Property_Tests;

package body Kernel_Suite is
   use AUnit.Test_Suites;

   Result   : aliased Test_Suite;
   Worked   : aliased Worked_Example.Test;
   Property : aliased Property_Tests.Test;

   function Suite return Access_Test_Suite is
   begin
      Add_Test (Result'Access, Worked'Access);
      Add_Test (Result'Access, Property'Access);
      return Result'Access;
   end Suite;
end Kernel_Suite;
