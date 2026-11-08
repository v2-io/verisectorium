--  Randomized tests (fixed seed) over logs built through the kernel's
--  own API. The kernel is compiled with contracts on, so every call
--  also runs its postconditions; the oracles here are deliberately
--  independent of those contracts (a naive recursive ceiling, a direct
--  closure check, hand-written frontier predicates).
with AUnit;
with AUnit.Test_Cases;

package Property_Tests is
   type Test is new AUnit.Test_Cases.Test_Case with null record;

   overriding procedure Register_Tests (T : in out Test);
   overriding function Name (T : Test) return AUnit.Message_String;
end Property_Tests;
