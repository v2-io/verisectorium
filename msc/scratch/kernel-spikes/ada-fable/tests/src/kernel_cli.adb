--  kernel_cli LOGFILE [INDEX]
--
--  Loads a log, folds it (to INDEX if given, else to the end) and
--  prints the state and the frontier. Porcelain, to exercise the kernel.
with Ada.Command_Line;    use Ada.Command_Line;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Characters.Handling;
with Kernel;              use Kernel;
with Kernel.States;       use Kernel.States;
with Kernel.Logs;         use Kernel.Logs;
with Kernel.Store;

procedure Kernel_CLI is

   function Img (N : Integer) return String is
     (Ada.Strings.Fixed.Trim (N'Image, Ada.Strings.Both));

   function Low (S : String) return String
     renames Ada.Characters.Handling.To_Lower;

   function Trim (S : String) return String is
     (Ada.Strings.Fixed.Trim (S, Ada.Strings.Both));

   procedure Show (S : State) is
      F : constant Frontier_List := Frontier (S);
      T : Veritoid_Table renames S.Veritoids;
   begin
      Put_Line ("veritoids:");
      for V in Veritoid_Id loop
         if T (V).Present then
            Put ("  #" & Img (Integer (V)) & "@" & Img (Integer (T (V).Vers))
                 & " seg " & Img (Integer (T (V).Owner))
                 & " claimed " & Low (T (V).Claimed'Image)
                 & " position " & Low (Position (S, V)'Image)
                 & " ceiling " & Low (Ceiling (S, V)'Image));
            if T (V).Refs.Count > 0 then
               Put ("  rests on");
               for I in 1 .. T (V).Refs.Count loop
                  declare
                     R : Reference renames T (V).Refs.Items (I);
                  begin
                     Put (" #" & Img (Integer (R.Target))
                          & "@" & Img (Integer (R.Seen))
                          & " needs " & Low (R.Needed'Image));
                  end;
               end loop;
            end if;
            New_Line;
         elsif T (V).Owner /= No_Owner then
            Put_Line ("  #" & Img (Integer (V)) & " removed (was seg "
                      & Img (Integer (T (V).Owner)) & ")");
         end if;
      end loop;
      Put_Line ("acts:");
      for K in 1 .. S.N_Acts loop
         declare
            A : Act renames S.Acts (K);
         begin
            Put ("  " & Img (Integer (K)) & ". " & Trim (A.Actor) & " "
                 & Low (A.Kind'Image) & " at " & Low (A.Attests'Image)
                 & " (" & Trim (A.Criterion) & ") read");
            for I in 1 .. A.Reads.Count loop
               Put (" #" & Img (Integer (A.Reads.Items (I).Id))
                    & "@" & Img (Integer (A.Reads.Items (I).Vers)));
            end loop;
            Put_Line ((if Binds (S, A) then "  [binds]" else "  [lapsed]"));
         end;
      end loop;
      Put_Line ("frontier (" & Img (Integer (F.Count)) & "):");
      for J in 1 .. F.Count loop
         declare
            X : Frontier_Item renames F.Items (J);
         begin
            case X.Kind is
               when Overclaim_Item =>
                  Put_Line ("  overclaim #" & Img (Integer (X.V)));
               when Stale_Item =>
                  Put_Line ("  stale-reference #" & Img (Integer (X.V))
                            & " -> #"
                            & Img (Integer (T (X.V).Refs.Items (X.Ref).Target)));
               when Unmet_Item =>
                  Put_Line ("  unmet-need #" & Img (Integer (X.V))
                            & " -> #"
                            & Img (Integer (T (X.V).Refs.Items (X.Ref).Target)));
            end case;
         end;
      end loop;
      Put_Line ((if Steady (S) then "steady" else "not steady"));
   end Show;

   L    : Log;
   Ok   : Boolean;
   Msg  : String (1 .. 200);
   Last : Natural;
begin
   if Argument_Count < 1 then
      Put_Line ("usage: kernel_cli LOGFILE [INDEX]");
      Set_Exit_Status (Failure);
      return;
   end if;
   Kernel.Store.Load (Argument (1), L, Ok, Msg, Last);
   if not Ok then
      Put_Line ("load failed at " & Msg (1 .. Last));
      Put_Line ("records before it: " & Img (Integer (Length (L))));
      Set_Exit_Status (Failure);
      return;
   end if;
   declare
      K : Log_Count := Length (L);
   begin
      if Argument_Count >= 2 then
         K := Log_Count'Value (Argument (2));
         if K > Length (L) then
            Put_Line ("the log has only " & Img (Integer (Length (L)))
                      & " records");
            Set_Exit_Status (Failure);
            return;
         end if;
      end if;
      Put_Line ("state as of record " & Img (Integer (K)) & " of "
                & Img (Integer (Length (L))));
      Show (State_At (L, K));
   end;
end Kernel_CLI;
