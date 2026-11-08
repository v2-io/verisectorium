--  Test runner: runs Kernel_Suite.Suite and exits non-zero on any failure,
--  so `alr test` (from ../) and `alr run` (from here) report failure to
--  the shell.
with Ada.Command_Line;
with AUnit;
with AUnit.Reporter.Text;
with AUnit.Run;
with Kernel_Suite;

procedure Kernel_Tests is
   function Runner is
     new AUnit.Run.Test_Runner_With_Status (Kernel_Suite.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
   use type AUnit.Status;
begin
   if Runner (Reporter) /= AUnit.Success then
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
   end if;
end Kernel_Tests;
