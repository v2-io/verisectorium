with Ada.Directories;
with Ada.Environment_Variables;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;
with AUnit.Assertions;      use AUnit.Assertions;
with Kernel.Model;          use Kernel.Model;
with Kernel.Store;          use Kernel.Store;
with Kernel.Text;           use Kernel.Text;

package body Property_Tests is

   Pool     : constant := 8;     --  veritoids v1 .. v8 (ids 1 .. 8)
   Segs     : constant := 3;
   --  KERNEL_TRIALS overrides; every kernel contract is also checked at
   --  run time here, which makes each trial slow.
   function Trials return Positive is
     (if Ada.Environment_Variables.Exists ("KERNEL_TRIALS")
      then Positive'Value (Ada.Environment_Variables.Value ("KERNEL_TRIALS"))
      else 60);
   Max_Len  : constant := 40;

   package Rand is new Ada.Numerics.Discrete_Random (Natural);
   G : Rand.Generator;

   function Pick (Hi : Natural) return Natural is   --  0 .. Hi - 1
     (Rand.Random (G) mod Hi);
   function Chance (Pct : Natural) return Boolean is (Pick (100) < Pct);
   function Any_Rung return Rung is (Rung'Val (Pick (4)));

   ---------------------------------------------------------------------
   --  Oracles, written from the spec without reusing kernel code
   ---------------------------------------------------------------------

   function O_Binds (T : Veritoid_Table; A : Act) return Boolean is
   begin
      for I in 1 .. A.N_Reads loop
         if not T (A.Reads (I).Id).Present
           or else T (A.Reads (I).Id).Ver /= A.Reads (I).Ver
         then
            return False;
         end if;
      end loop;
      return True;
   end O_Binds;

   function O_Position (S : State; V : Veritoid_Id) return Rung is
      R : Rung := Sketch;
   begin
      for J in 1 .. S.N_Acts loop
         declare
            A     : Act renames S.Acts (J);
            Reads : Boolean := False;
         begin
            for I in 1 .. A.N_Reads loop
               Reads := Reads or else A.Reads (I).Id = V;
            end loop;
            if A.Kind = Check and then Reads and then O_Binds (S.V, A)
              and then A.Level > R
            then
               R := A.Level;
            end if;
         end;
      end loop;
      return R;
   end O_Position;

   --  The spec's recursive ceiling.  Depth guards against a cycle, which
   --  an accepted state must never have.
   function O_Ceiling (S : State; V : Veritoid_Id; Depth : Natural := 0)
      return Rung
   is
      R : Rung;
   begin
      Assert (Depth <= Max_Veritoids, "cycle reached by the ceiling oracle");
      if not S.V (V).Present then
         return Sketch;
      end if;
      R := O_Position (S, V);
      for Q in 1 .. S.V (V).N_Refs loop
         R := Rung'Min (R, O_Ceiling (S, S.V (V).Refs (Q).Target, Depth + 1));
      end loop;
      return R;
   end O_Ceiling;

   function O_Has_Cycle (T : Veritoid_Table) return Boolean is
      type Color is (White, Grey, Black);
      C     : array (Veritoid_Id) of Color := [others => White];
      Found : Boolean := False;
      procedure Visit (V : Veritoid_Id) is
      begin
         C (V) := Grey;
         for Q in 1 .. T (V).N_Refs loop
            declare
               W : constant Veritoid_Id := T (V).Refs (Q).Target;
            begin
               if T (W).Present then
                  if C (W) = Grey then
                     Found := True;
                  elsif C (W) = White then
                     Visit (W);
                  end if;
               end if;
            end;
         end loop;
         C (V) := Black;
      end Visit;
   begin
      for V in Veritoid_Id loop
         if T (V).Present and then C (V) = White then
            Visit (V);
         end if;
      end loop;
      return Found;
   end O_Has_Cycle;

   --  Count of frontier items the spec defines, and a check that the
   --  kernel's frontier flags agree item by item.
   procedure Check_Frontier (S : State; Ctx : String) is
      F : constant Frontier_Set := Frontier (S);
      Empty : Boolean := True;
   begin
      for V in Veritoid_Id loop
         declare
            X     : Veritoid renames S.V (V);
            Ceil  : constant Rung := O_Ceiling (S, V);
         begin
            Assert (F.Overclaim (V) = (X.Present and then X.Claimed > Ceil),
                    Ctx & ": overclaim flag");
            for Q in Ref_Index loop
               declare
                  In_Use : constant Boolean :=
                    X.Present and then Q <= X.N_Refs;
                  Tg     : constant Veritoid_Id := X.Refs (Q).Target;
               begin
                  Assert (F.Stale (V, Q)
                          = (In_Use and then
                               (not S.V (Tg).Present
                                or else S.V (Tg).Ver /= X.Refs (Q).Seen)),
                          Ctx & ": stale flag");
                  Assert (F.Unmet (V, Q)
                          = (In_Use and then
                               O_Ceiling (S, Tg) < X.Refs (Q).Needed),
                          Ctx & ": unmet flag");
                  Empty := Empty and then not F.Stale (V, Q)
                           and then not F.Unmet (V, Q);
               end;
            end loop;
            Empty := Empty and then not F.Overclaim (V);
         end;
      end loop;
      Assert (Steady (S) = Empty, Ctx & ": steady iff empty");
   end Check_Frontier;

   ---------------------------------------------------------------------
   --  Generators
   ---------------------------------------------------------------------

   function Gen_Changeset (S : State) return Changeset is
      CS   : Changeset;
      Used : array (Veritoid_Id) of Boolean := [others => False];
   begin
      CS.Author := Actor_Id (1 + Pick (3));
      CS.Segment := Segment_Id (1 + Pick (Segs));
      for K in 1 .. Pick (5) loop
         declare
            V  : Veritoid_Id := 1 + Pick (Pool);
            It : Item;
         begin
            --  Mostly ids this segment may take; sometimes a foreign one,
            --  sometimes a duplicate, to exercise refusals.
            for Tries in 1 .. 6 loop
               exit when not Used (V)
                 and then (not S.V (V).Present
                           or else S.V (V).Segment = CS.Segment
                           or else Chance (5));
               V := 1 + Pick (Pool);
            end loop;
            if Used (V) and then not Chance (3) then
               goto Skip;
            end if;
            Used (V) := True;
            It.Id := V;
            if S.V (V).Present and then Chance (50) then
               It.Ver := S.V (V).Ver;
               It.N_Refs := S.V (V).N_Refs;
               It.Refs := S.V (V).Refs;
            else
               It.Ver := (if S.V (V).Present and then Chance (85)
                          then S.V (V).Ver + 1
                          else Version (1 + Pick (3)));
            end if;
            It.Claimed := (if Chance (40) then Sketch else Any_Rung);
            if It.N_Refs = 0 or else Chance (30) then
               It.N_Refs := Pick (3);
               for Q in 1 .. It.N_Refs loop
                  declare
                     Tg : constant Veritoid_Id := 1 + Pick (Pool);
                  begin
                     It.Refs (Q) :=
                       (Target => Tg,
                        Needed => (if Chance (50) then Sketch else Any_Rung),
                        Seen   => (if S.V (Tg).Present and then Chance (85)
                                   then S.V (Tg).Ver
                                   else Version (1 + Pick (3))));
                  end;
               end loop;
            end if;
            It.Affirmed := Chance (85);
            CS.N_Items := CS.N_Items + 1;
            CS.Items (CS.N_Items) := It;
         end;
         <<Skip>>
      end loop;
      return CS;
   end Gen_Changeset;

   function Gen_Act (S : State) return Act is
      A : Act;
   begin
      A.Actor := Actor_Id (1 + Pick (3));
      A.Criterion := Criterion_Id (1 + Pick (2));
      A.Kind := (if Chance (90) then Check else Affirmation);
      A.Level := Any_Rung;
      A.N_Reads := 1 + Pick (3);
      for I in 1 .. A.N_Reads loop
         declare
            V : constant Veritoid_Id := 1 + Pick (Pool);
         begin
            A.Reads (I) :=
              (Id  => V,
               Ver => (if S.V (V).Present and then Chance (85)
                       then S.V (V).Ver else Version (1 + Pick (3))));
         end;
      end loop;
      return A;
   end Gen_Act;

   ---------------------------------------------------------------------
   --  The run
   ---------------------------------------------------------------------

   type Counter is
     (Records, Accepted_CS, Accepted_Check, Refused_Cycle, Refused_Other,
      Lapses, Steady_States, Nonempty_Frontiers, Rebinds);
   Count : array (Counter) of Natural := [others => 0];

   procedure Check_Step
     (Old_S : State; Kind : Record_Kind; CS : Changeset; A : Act;
      O : Outcome; New_S : State; Ctx : String)
   is
   begin
      if O /= Accepted then
         Assert (Same (New_S, Old_S), Ctx & ": refusal changed state");
         if O = Cycle then
            Count (Refused_Cycle) := Count (Refused_Cycle) + 1;
            --  Completeness of the cycle check (not proved; tested here).
            Assert (O_Has_Cycle (New_Table (Old_S.V, CS)),
                    Ctx & ": refused as a cycle but has none");
         else
            Count (Refused_Other) := Count (Refused_Other) + 1;
         end if;
         return;
      end if;

      if Kind = Changeset_Record then
         Count (Accepted_CS) := Count (Accepted_CS) + 1;
         --  P5
         Assert (not O_Has_Cycle (New_S.V), Ctx & ": accepted a cycle");
         --  P3, against an oracle for "changed or removed"
         for J in 1 .. Old_S.N_Acts loop
            declare
               X        : Act renames Old_S.Acts (J);
               Hit      : Boolean := False;
               Touches  : Boolean := False;
            begin
               for I in 1 .. X.N_Reads loop
                  declare
                     Id : constant Veritoid_Id := X.Reads (I).Id;
                     In_Seg : constant Boolean :=
                       Old_S.V (Id).Present
                       and then Old_S.V (Id).Segment = CS.Segment;
                     Kept : Boolean := False;
                     Listed : Boolean := False;
                  begin
                     for K in 1 .. CS.N_Items loop
                        if CS.Items (K).Id = Id then
                           Listed := True;
                           Kept := Kept
                             or else CS.Items (K).Ver = Old_S.V (Id).Ver;
                        end if;
                     end loop;
                     Hit := Hit or else (In_Seg and then not Kept);
                     Touches := Touches or else In_Seg or else Listed;
                  end;
               end loop;
               if O_Binds (Old_S.V, X) then
                  Assert (O_Binds (New_S.V, X) = not Hit,
                          Ctx & ": P3 lapse not exact");
                  if Hit then
                     Count (Lapses) := Count (Lapses) + 1;
                  end if;
               elsif O_Binds (New_S.V, X) then
                  Count (Rebinds) := Count (Rebinds) + 1;
               end if;
               if not Touches then
                  Assert (O_Binds (New_S.V, X) = O_Binds (Old_S.V, X),
                          Ctx & ": P3 untouched act changed");
               end if;
            end;
         end loop;
      elsif A.Kind = Check then
         Count (Accepted_Check) := Count (Accepted_Check) + 1;
         --  P4
         for V in Veritoid_Id loop
            declare
               P0, P1 : Rung;
               Reads  : Boolean := False;
            begin
               P0 := O_Position (Old_S, V);
               P1 := O_Position (New_S, V);
               for I in 1 .. A.N_Reads loop
                  Reads := Reads or else A.Reads (I).Id = V;
               end loop;
               Assert (P1 >= P0, Ctx & ": P4 position fell");
               Assert (Reads or else P1 = P0, Ctx & ": P4 unread moved");
               Assert (P1 <= Rung'Max (P0, A.Level), Ctx & ": P4 overshoot");
            end;
         end loop;
      end if;
   end Check_Step;

   procedure Check_State (S : State; Ctx : String) is
      C : constant Rung_Array := Ceilings (S);
   begin
      for V in Veritoid_Id loop
         Assert (Position (S, V) = O_Position (S, V), Ctx & ": position");
         Assert (C (V) = O_Ceiling (S, V), Ctx & ": ceiling vs recursion");
         if S.V (V).Present then
            --  P6
            Assert (C (V) <= O_Position (S, V), Ctx & ": P6 position");
            for Q in 1 .. S.V (V).N_Refs loop
               Assert (C (V) <= C (S.V (V).Refs (Q).Target),
                       Ctx & ": P6 reference");
            end loop;
         end if;
      end loop;
      Check_Frontier (S, Ctx);
      if Steady (S) then
         Count (Steady_States) := Count (Steady_States) + 1;
         --  P7
         for V in Veritoid_Id loop
            Assert (not S.V (V).Present or else S.V (V).Claimed <= C (V),
                    Ctx & ": P7");
         end loop;
      else
         Count (Nonempty_Frontiers) := Count (Nonempty_Frontiers) + 1;
      end if;
   end Check_State;

   procedure Test_Properties (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
      N : Names;
   begin
      for I in 1 .. Pool loop
         declare
            Id : constant Veritoid_Id :=
              Veritoid_Named (N, "v" & Character'Val (48 + I));
            pragma Unreferenced (Id);
         begin
            null;
         end;
      end loop;
      for I in 1 .. Segs loop
         declare
            Id : constant Segment_Id :=
              Segment_Named (N, "S" & Character'Val (48 + I));
            pragma Unreferenced (Id);
         begin
            null;
         end;
      end loop;
      declare
         A1 : constant Actor_Id := Actor_Named (N, "A");
         A2 : constant Actor_Id := Actor_Named (N, "B");
         A3 : constant Actor_Id := Actor_Named (N, "C");
         C1 : constant Criterion_Id := Criterion_Named (N, "check");
         C2 : constant Criterion_Id := Criterion_Named (N, "rederive");
         pragma Unreferenced (A1, A2, A3, C1, C2);
      begin
         null;
      end;

      Rand.Reset (G, 2026_11_07);
      for Trial in 1 .. Trials loop
         declare
            St   : Store := Empty_Store;
            Prev : Store;
            Len  : constant Positive := 1 + Pick (Max_Len);
            Ctx  : constant String := "trial" & Trial'Image;
         begin
            for K in 1 .. Len loop
               declare
                  Kind : constant Record_Kind :=
                    (if Chance (45) then Changeset_Record else Act_Record);
                  CS   : constant Changeset :=
                    (if Kind = Changeset_Record then Gen_Changeset (St.Cur)
                     else (others => <>));
                  A    : constant Act :=
                    (if Kind = Act_Record then Gen_Act (St.Cur)
                     else (others => <>));
                  O    : Outcome;
                  Here : constant String := Ctx & " record" & K'Image;
               begin
                  Prev := St;
                  Append (St, Kind, CS, A, O);
                  Count (Records) := Count (Records) + 1;
                  --  P2
                  Assert (Length (St.L) = Length (Prev.L) + 1,
                          Here & ": P2 length");
                  for I in 1 .. Length (Prev.L) loop
                     Assert (Same_Entry (Get (St.L, I), Get (Prev.L, I)),
                             Here & ": P2 prefix");
                  end loop;
                  --  P1: the kept state is the fold of the log
                  Assert (Same (St.Cur, State_At (St.L, Length (St.L))),
                          Here & ": P1 fold");
                  Check_Step (Prev.Cur, Kind, CS, A, O, St.Cur, Here);
                  Check_State (St.Cur, Here);
               end;
            end loop;

            --  P1 again: a log rebuilt record by record folds the same.
            --  P8: write, read back, fold the same at every index.
            declare
               L2   : Log := Empty_Log;
               L3   : Log;
               N3   : Names;
               Ok   : Boolean;
               Path : constant String := "property-trial.log";
            begin
               for I in 1 .. Length (St.L) loop
                  Push (L2, Get (St.L, I), Ok);
               end loop;
               Save (Path, N, St.L);
               Load (Path, N3, L3);
               Ada.Directories.Delete_File (Path);
               Assert (Length (L3) = Length (St.L), Ctx & ": P8 length");
               for I in 1 .. Length (St.L) loop
                  Assert (Same_Entry (Get (L3, I), Get (St.L, I)),
                          Ctx & ": P8 record");
               end loop;
               for K in 0 .. Length (St.L) loop
                  Assert (Same (State_At (L2, K), State_At (St.L, K)),
                          Ctx & ": P1 rebuilt");
                  Assert (Same (State_At (L3, K), State_At (St.L, K)),
                          Ctx & ": P8 state");
               end loop;
            end;
         end;
      end loop;

      Ada.Text_IO.Put_Line ("property run (seed 20261107,"
                            & Positive'Image (Trials) & " trials):");
      for C in Counter loop
         Ada.Text_IO.Put_Line ("  " & C'Image & Count (C)'Image);
      end loop;
      Assert (Count (Refused_Cycle) > 0 and then Count (Lapses) > 0
              and then Count (Steady_States) > 0
              and then Count (Nonempty_Frontiers) > 0,
              "generator failed to reach the interesting cases");
   end Test_Properties;

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Properties'Access,
                        "P1-P8 on random logs against oracles");
   end Register_Tests;

   overriding function Name (T : Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Properties");
   end Name;

end Property_Tests;
