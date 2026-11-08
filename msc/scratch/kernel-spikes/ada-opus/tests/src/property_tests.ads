--  Randomized checks of P1-P8 over generated logs, against oracles
--  written independently of the kernel (plain recursion, DFS).
with AUnit;
with AUnit.Test_Cases;

package Property_Tests is
   type Test is new AUnit.Test_Cases.Test_Case with null record;

   overriding procedure Register_Tests (T : in out Test);
   overriding function Name (T : Test) return AUnit.Message_String;
end Property_Tests;
