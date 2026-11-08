--  The worked example of KERNEL-SPEC.md section 6, as a test, plus the
--  replay of its log through a file (P8).
with AUnit;
with AUnit.Test_Cases;

package Worked_Example is
   type Test is new AUnit.Test_Cases.Test_Case with null record;

   overriding procedure Register_Tests (T : in out Test);
   overriding function Name (T : Test) return AUnit.Message_String;
end Worked_Example;
