with Hello_Tests;

package body Kernel_Suite is
   use AUnit.Test_Suites;

   Result     : aliased Test_Suite;
   Hello_Case : aliased Hello_Tests.Test;

   function Suite return Access_Test_Suite is
   begin
      Add_Test (Result'Access, Hello_Case'Access);
      return Result'Access;
   end Suite;
end Kernel_Suite;
