--  kernel_cli LOG [K]       load LOG, print the state and frontier as of
--                           record K (default: the end), and check that
--                           every recorded result is what the kernel
--                           computes again
--  kernel_cli --example OUT write the worked example's log to OUT, then
--                           print it as above, at every mark

with Ada.Command_Line; use Ada.Command_Line;
with Ada.Exceptions;
with Ada.Text_IO;      use Ada.Text_IO;
with Kernel.Model;     use Kernel.Model;
with Kernel.Store;     use Kernel.Store;
with Kernel.Text;      use Kernel.Text;
with Worked_Example;

procedure Kernel_Cli is

   procedure Show (N : Names; L : Log; K : Natural) is
      S : constant State := State_At (L, K);
   begin
      Put_Line ("state as of record" & K'Image & " of" & Length (L)'Image
                & ":");
      Put (Describe_State (N, S));
      Put_Line ("frontier" & (if Steady (S) then " (steady):" else ":"));
      Put (Describe_Frontier (N, S));
   end Show;

   --  Recompute each record's outcome against the state before it and
   --  report any record whose recorded result disagrees.
   function Audit (N : Names; L : Log) return Boolean is
      Ok : Boolean := True;
   begin
      for I in 1 .. Length (L) loop
         declare
            E : constant Log_Entry := Get (L, I);
            R : constant Outcome :=
              Try (State_At (L, I - 1), E.Kind, E.CS, E.A).Result;
         begin
            if R /= E.Result then
               Put_Line ("record" & I'Image & " is recorded as "
                         & Outcome_Name (E.Result) & " but computes as "
                         & Outcome_Name (R) & ": " & To_Line (N, E));
               Ok := False;
            end if;
         end;
      end loop;
      return Ok;
   end Audit;

   N : Names;
   L : Log;
begin
   if Argument_Count = 2 and then Argument (1) = "--example" then
      declare
         St : Store;
         M  : Worked_Example.Marks;
      begin
         Worked_Example.Build (N, St, M);
         Save (Argument (2), N, St.L);
         Put_Line ("wrote " & Argument (2));
         for Mk in M'Range loop
            New_Line;
            Put_Line ("== " & Mk'Image);
            Show (N, St.L, M (Mk));
         end loop;
      end;
      return;
   end if;

   if Argument_Count not in 1 .. 2 then
      Put_Line ("usage: kernel_cli LOG [K] | kernel_cli --example OUT");
      Set_Exit_Status (Failure);
      return;
   end if;

   Load (Argument (1), N, L);
   declare
      K : constant Natural :=
        (if Argument_Count = 2 then Natural'Value (Argument (2))
         else Length (L));
   begin
      if K > Length (L) then
         Put_Line ("the log has" & Length (L)'Image & " records");
         Set_Exit_Status (Failure);
         return;
      end if;
      if not Audit (N, L) then
         Put_Line ("(records whose recorded result disagrees are folded by "
                   & "what they compute now)");
      end if;
      Show (N, L, K);
   end;
exception
   when E : Format_Error =>
      Put_Line ("cannot read the log: "
                & Ada.Exceptions.Exception_Message (E));
      Set_Exit_Status (Failure);
   when E : Name_Error =>
      Put_Line (Ada.Exceptions.Exception_Message (E));
      Set_Exit_Status (Failure);
end Kernel_Cli;
