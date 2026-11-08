with Ada.Numerics.Discrete_Random;
with AUnit.Assertions; use AUnit.Assertions;
with Kernel.Hello;     use Kernel.Hello;

package body Hello_Tests is

   procedure Test_Examples (T : in out AUnit.Test_Cases.Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Assert (Saturating_Add (2, 3) = 5, "2 + 3 = 5");
      Assert (Saturating_Add (Natural'Last, 1) = Natural'Last, "saturates");
   end Test_Examples;

   --  A hand-rolled randomized check (fixed seed, so reproducible). There
   --  is no proptest-grade standard in Ada; see ../../README.md.
   procedure Test_Random (T : in out AUnit.Test_Cases.Test_Case'Class) is
      pragma Unreferenced (T);
      package Random_Natural is new Ada.Numerics.Discrete_Random (Natural);
      Gen : Random_Natural.Generator;
   begin
      Random_Natural.Reset (Gen, 42);
      for I in 1 .. 1_000 loop
         declare
            X    : constant Natural := Random_Natural.Random (Gen);
            Y    : constant Natural := Random_Natural.Random (Gen);
            Wide : constant Long_Long_Integer :=
              Long_Long_Integer (X) + Long_Long_Integer (Y);
            Cap  : constant Long_Long_Integer :=
              Long_Long_Integer (Natural'Last);
         begin
            Assert
              (Long_Long_Integer (Saturating_Add (X, Y))
               = Long_Long_Integer'Min (Wide, Cap),
               "matches widened sum for" & X'Image & Y'Image);
         end;
      end loop;
   end Test_Random;

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Examples'Access, "examples");
      Register_Routine
        (T, Test_Random'Access, "randomized against widened sum");
   end Register_Tests;

   overriding function Name (T : Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Kernel.Hello");
   end Name;

end Hello_Tests;
