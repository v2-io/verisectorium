with Ada.Numerics.Discrete_Random;
with AUnit.Assertions; use AUnit.Assertions;
with Kernel;           use Kernel;
with Kernel.States;    use Kernel.States;
with Kernel.Logs;      use Kernel.Logs;
with Kernel.Store;
with Fixtures;         use Fixtures;

package body Property_Tests is

   package Rnd is new Ada.Numerics.Discrete_Random (Natural);
   Gen : Rnd.Generator;

   function Pick (N : Positive) return Positive is
     (Rnd.Random (Gen) mod N + 1);

   function Coin (Percent : Natural) return Boolean is
     (Rnd.Random (Gen) mod 100 < Percent);

   function Random_Rung return Rung is
     (Rung'Val (Rnd.Random (Gen) mod 4));

   Segments_Used : constant := 4;

   ----------------------------------------------------------------------
   --  Independent oracles
   ----------------------------------------------------------------------

   --  Position by a direct scan of the acts.
   function Oracle_Position (S : State; V : Veritoid_Id) return Rung is
      P : Rung := Sketch;
   begin
      for K in 1 .. S.N_Acts loop
         declare
            A : Act renames S.Acts (K);
            Bound : Boolean := True;
            Reads_V : Boolean := False;
         begin
            for I in 1 .. A.Reads.Count loop
               declare
                  R : Read renames A.Reads.Items (I);
               begin
                  if not S.Veritoids (R.Id).Present
                    or else S.Veritoids (R.Id).Vers /= R.Vers
                  then
                     Bound := False;
                  end if;
                  if R.Id = V then
                     Reads_V := True;
                  end if;
               end;
            end loop;
            if A.Kind = Check and then Bound and then Reads_V
              and then A.Attests > P
            then
               P := A.Attests;
            end if;
         end;
      end loop;
      return P;
   end Oracle_Position;

   --  Ceiling by the spec's recursion (terminates: accepted states have
   --  no reference cycles), memoized so that a dense graph stays cheap.
   type Memo is array (Veritoid_Id) of Boolean;

   procedure Oracle_Ceiling_Into
     (S : State; V : Veritoid_Id; Known : in out Memo; C : in out Rung_Array)
   is
      T : Veritoid_Table renames S.Veritoids;
      M : Rung := Oracle_Position (S, V);
   begin
      if Known (V) then
         return;
      end if;
      for I in 1 .. T (V).Refs.Count loop
         declare
            W : constant Veritoid_Id := T (V).Refs.Items (I).Target;
         begin
            if T (W).Present then
               Oracle_Ceiling_Into (S, W, Known, C);
               M := Rung'Min (M, C (W));
            else
               M := Sketch;
            end if;
         end;
      end loop;
      C (V) := M;
      Known (V) := True;
   end Oracle_Ceiling_Into;

   function Oracle_Ceiling (S : State; V : Veritoid_Id) return Rung is
      Known : Memo := [others => False];
      C     : Rung_Array := [others => Sketch];
   begin
      Oracle_Ceiling_Into (S, V, Known, C);
      return C (V);
   end Oracle_Ceiling;

   --  The frontier predicates, written out again.
   procedure Check_Frontier (S : State; Where : String) is
      F : constant Frontier_List := Frontier (S);
      T : Veritoid_Table renames S.Veritoids;
      Expected : Natural := 0;
   begin
      for V in Veritoid_Id loop
         if T (V).Present then
            declare
               Over : constant Boolean :=
                 T (V).Claimed > Oracle_Ceiling (S, V);
            begin
               Assert (Has (F, Overclaim_Item, V) = Over,
                       Where & ": overclaim" & V'Image);
               if Over then
                  Expected := Expected + 1;
               end if;
               for I in 1 .. T (V).Refs.Count loop
                  declare
                     R : Reference renames T (V).Refs.Items (I);
                     St : constant Boolean :=
                       not T (R.Target).Present
                       or else T (R.Target).Vers /= R.Seen;
                     Un : constant Boolean :=
                       (if T (R.Target).Present
                        then Oracle_Ceiling (S, R.Target) < R.Needed
                        else Sketch < R.Needed);
                  begin
                     Assert (Has (F, Stale_Item, V, I) = St,
                             Where & ": stale" & V'Image & I'Image);
                     Assert (Has (F, Unmet_Item, V, I) = Un,
                             Where & ": unmet" & V'Image & I'Image);
                     if St then
                        Expected := Expected + 1;
                     end if;
                     if Un then
                        Expected := Expected + 1;
                     end if;
                  end;
               end loop;
            end;
         else
            Assert (not Has (F, Overclaim_Item, V),
                    Where & ": absent veritoid never overclaims");
         end if;
      end loop;
      Assert (Natural (F.Count) = Expected,
              Where & ": frontier size" & F.Count'Image
              & " expected" & Expected'Image);
      Assert (Steady (S) = (Expected = 0), Where & ": steady");
      --  P7, checked directly.
      if Steady (S) then
         for V in Veritoid_Id loop
            if T (V).Present then
               Assert (T (V).Claimed <= Ceiling (S, V),
                       Where & ": steady but overclaimed" & V'Image);
            end if;
         end loop;
      end if;
   end Check_Frontier;

   --  P6 checked directly against the kernel's own Ceiling.
   procedure Check_Ceiling_Bound (S : State; Where : String) is
      T : Veritoid_Table renames S.Veritoids;
   begin
      for V in Veritoid_Id loop
         if T (V).Present then
            Assert (Ceiling (S, V) = Oracle_Ceiling (S, V),
                    Where & ": ceiling" & V'Image & " = oracle");
            Assert (Position (S, V) = Oracle_Position (S, V),
                    Where & ": position" & V'Image & " = oracle");
            Assert (Ceiling (S, V) <= Position (S, V),
                    Where & ": ceiling <= position" & V'Image);
            for I in 1 .. T (V).Refs.Count loop
               declare
                  W : constant Veritoid_Id := T (V).Refs.Items (I).Target;
               begin
                  if T (W).Present then
                     Assert (Ceiling (S, V) <= Ceiling (S, W),
                             Where & ": ceiling bound" & V'Image & W'Image);
                  else
                     Assert (Ceiling (S, V) = Sketch,
                             Where & ": dangling reference caps at sketch");
                  end if;
               end;
            end loop;
         end if;
      end loop;
   end Check_Ceiling_Bound;

   --  Culprits of a cycle refusal: non-empty, and every member has a
   --  present reference target in the set, in the table the changeset
   --  would have produced.
   procedure Check_Culprits
     (S : State; C : Changeset; Cul : Id_Set; Where : String)
   is
      T : constant Veritoid_Table := Candidate_Table (S.Veritoids, C);
      Any : Boolean := False;
   begin
      for V in Veritoid_Id loop
         if Cul (V) then
            Any := True;
            Assert (T (V).Present, Where & ": culprit present");
            declare
               Found : Boolean := False;
            begin
               for I in 1 .. T (V).Refs.Count loop
                  declare
                     W : constant Veritoid_Id := T (V).Refs.Items (I).Target;
                  begin
                     if T (W).Present and then Cul (W) then
                        Found := True;
                     end if;
                  end;
               end loop;
               Assert (Found, Where & ": culprit" & V'Image
                       & " has a culprit target");
            end;
         end if;
      end loop;
      Assert (Any, Where & ": culprits non-empty");
   end Check_Culprits;

   ----------------------------------------------------------------------
   --  Random records
   ----------------------------------------------------------------------

   function Random_Changeset (S : State) return Changeset is
      Seg : constant Segment_Id := Segment_Id (Pick (Segments_Used));
      C   : Changeset := (Segment => Seg, others => <>);
      T   : Veritoid_Table renames S.Veritoids;
   begin
      --  Keep most of the segment's current veritoids, bump some.
      for V in Veritoid_Id loop
         if T (V).Owner = Owner_Id (Seg) and then T (V).Present
           and then Coin (85) and then C.Count < Max_Per_Segment
         then
            C := Append (C, Make_Entry
                   (V,
                    (if Coin (40) then T (V).Vers + 1 else T (V).Vers),
                    Random_Rung,
                    T (V).Refs));
         end if;
      end loop;
      --  Sometimes introduce a fresh id.
      if Coin (60) and then C.Count < Max_Per_Segment then
         for V in Veritoid_Id loop
            if T (V).Owner = No_Owner and then not Names (C, V) then
               C := Append (C, Make_Entry (V, 1, Random_Rung));
               exit;
            end if;
         end loop;
      end if;
      --  Rewrite references of some entries: random targets among what
      --  is present or named here, random needs, seen mostly current.
      for I in 1 .. C.Count loop
         if Coin (50) then
            declare
               E : Veritoid_Entry := C.Items (I);
               N : constant Natural := Rnd.Random (Gen) mod 3;
            begin
               E.Refs := No_Refs;
               for J in 1 .. N loop
                  declare
                     W : constant Veritoid_Id := Veritoid_Id (Pick (Max_Veritoids));
                  begin
                     if (T (W).Present or else Names (C, W)) and then W /= E.Id
                     then
                        E.Refs := Append
                          (E.Refs,
                           Ref (W, Random_Rung,
                                (if Names (C, W)
                                 then C.Items (Index_Of (C, W)).Vers
                                 elsif Coin (80) then T (W).Vers
                                 else T (W).Vers + 1)));
                     end if;
                  end;
               end loop;
               C.Items (I) := E;
            end;
         end if;
      end loop;
      --  Now and then close a two-cycle inside the changeset, so that
      --  the refusal path and its witness are exercised.
      if C.Count >= 2 and then Coin (15) then
         declare
            First : Veritoid_Entry := C.Items (1);
            Last_E : Veritoid_Entry := C.Items (C.Count);
         begin
            if First.Refs.Count < Max_Refs and then Last_E.Refs.Count < Max_Refs
            then
               First.Refs := Append (First.Refs, Ref (Last_E.Id, Sketch, Last_E.Vers));
               Last_E.Refs := Append (Last_E.Refs, Ref (First.Id, Sketch, First.Vers));
               C.Items (1) := First;
               C.Items (C.Count) := Last_E;
            end if;
         end;
      end if;
      return C;
   end Random_Changeset;

   function Random_Act (S : State) return Act is
      R : Read_List := No_Reads;
      T : Veritoid_Table renames S.Veritoids;
      N : constant Natural := 1 + Rnd.Random (Gen) mod 3;
   begin
      for J in 1 .. N loop
         declare
            V : constant Veritoid_Id := Veritoid_Id (Pick (Max_Veritoids));
         begin
            if T (V).Owner /= No_Owner and then not Reads_Id (R, V) then
               R := Append (R, Rd (V, (if T (V).Present and then Coin (90)
                                       then T (V).Vers else 1)));
            end if;
         end;
      end loop;
      return Make_Act
        ((if Coin (50) then "A" else "B"), "random",
         (if Coin (85) then Check else Affirmation), Random_Rung, R);
   end Random_Act;

   ----------------------------------------------------------------------
   --  The tests
   ----------------------------------------------------------------------

   Accepted_CS, Refused_Cycle, Refused_Other, Accepted_Acts : Natural := 0;

   procedure Grow (L : in out Log; Steps : Positive) is
      Why : Refusal;
      Cul : Id_Set;
   begin
      for Step_N in 1 .. Steps loop
         exit when Length (L) = Max_Log;
         declare
            S : constant State := Current (L);
         begin
            if Coin (45) then
               declare
                  C : constant Changeset := Random_Changeset (S);
               begin
                  Append (L, Of_Changeset (C), Why, Cul);
                  case Why is
                     when Accepted =>
                        Accepted_CS := Accepted_CS + 1;
                     when Cycle =>
                        Refused_Cycle := Refused_Cycle + 1;
                        Check_Culprits (S, C, Cul, "step" & Step_N'Image);
                     when others =>
                        Refused_Other := Refused_Other + 1;
                  end case;
               end;
            else
               Append (L, Of_Act (Random_Act (S)), Why, Cul);
               if Why = Accepted then
                  Accepted_Acts := Accepted_Acts + 1;
               end if;
               Assert (Why in Accepted | Full,
                       "acts over known ids are accepted, got " & Why'Image);
            end if;
         end;
      end loop;
   end Grow;

   procedure Test_Random_Logs (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
   begin
      Rnd.Reset (Gen, 2026);
      for Run in 1 .. 12 loop
         declare
            L : Log := Empty;
         begin
            Grow (L, 40);
            declare
               S : constant State := Current (L);
               Where : constant String := "run" & Run'Image;
            begin
               Check_Ceiling_Bound (S, Where);
               Check_Frontier (S, Where);
               --  P1: fold twice, and fold a copy of the prefix.
               Assert (State_At (L, Length (L)) = S, Where & ": fold twice");
               declare
                  K  : constant Log_Count :=
                    Log_Count (Rnd.Random (Gen) mod Natural (Length (L) + 1));
                  L2 : Log := Empty;
               begin
                  for J in 1 .. K loop
                     Must_Append (L2, Record_At (L, J), Where & " copy");
                  end loop;
                  Assert (Current (L2) = State_At (L, K),
                          Where & ": prefix" & K'Image & " folds the same");
               end;
            end;
         end;
      end loop;
      Assert (Accepted_CS > 20, "enough changesets accepted:"
              & Accepted_CS'Image);
      Assert (Refused_Cycle > 0, "some cycle was refused:"
              & Refused_Cycle'Image);
      Assert (Accepted_Acts > 20, "enough acts:" & Accepted_Acts'Image);
   end Test_Random_Logs;

   --  P4 and P3 checked directly across random appends.
   procedure Test_Monotone_And_Lapse
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
      L : Log := Empty;
      Why : Refusal;
      Cul : Id_Set;
   begin
      Rnd.Reset (Gen, 7);
      Grow (L, 15);
      for Step_N in 1 .. 60 loop
         exit when Length (L) = Max_Log;
         declare
            S0 : constant State := Current (L);
         begin
            if Coin (50) then
               declare
                  A : constant Act := Random_Act (S0);
               begin
                  Append (L, Of_Act (A), Why, Cul);
                  if Why = Accepted then
                     declare
                        S1 : constant State := Current (L);
                     begin
                        for V in Veritoid_Id loop
                           Assert (Position (S1, V) >= Position (S0, V),
                                   "P4: never lowers" & V'Image);
                           if A.Kind = Affirmation
                             or else not Reads_Id (A.Reads, V)
                           then
                              Assert (Position (S1, V) = Position (S0, V),
                                      "P4: unread veritoid unchanged"
                                      & V'Image);
                           end if;
                        end loop;
                     end;
                  end if;
               end;
            else
               declare
                  C : constant Changeset := Random_Changeset (S0);
               begin
                  Append (L, Of_Changeset (C), Why, Cul);
                  if Why = Accepted then
                     declare
                        S1 : constant State := Current (L);
                     begin
                        for K in 1 .. S0.N_Acts loop
                           declare
                              A : Act renames S0.Acts (K);
                              Touched : Boolean := False;
                              In_Seg  : Boolean := False;
                           begin
                              for I in 1 .. A.Reads.Count loop
                                 declare
                                    R : Read renames A.Reads.Items (I);
                                    Old : Veritoid renames S0.Veritoids (R.Id);
                                 begin
                                    if Old.Owner = Owner_Id (C.Segment) then
                                       In_Seg := True;
                                       if not Names (C, R.Id)
                                         or else C.Items (Index_Of (C, R.Id)).Vers
                                                 /= R.Vers
                                       then
                                          Touched := True;
                                       end if;
                                    end if;
                                 end;
                              end loop;
                              if Binds (S0, A) then
                                 Assert (Binds (S1, A) = not Touched,
                                         "P3: lapse iff touched, act" & K'Image);
                              end if;
                              if not In_Seg then
                                 Assert (Binds (S1, A) = Binds (S0, A),
                                         "P3: untouched segment, act" & K'Image);
                              end if;
                           end;
                        end loop;
                     end;
                  end if;
               end;
            end if;
         end;
      end loop;
   end Test_Monotone_And_Lapse;

   --  P8 on random logs.
   procedure Test_Round_Trip (T : in out AUnit.Test_Cases.Test_Case'Class) is
      pragma Unreferenced (T);
      Path : constant String := "obj/property-roundtrip.log";
   begin
      Rnd.Reset (Gen, 99);
      for Run in 1 .. 5 loop
         declare
            L, L2 : Log := Empty;
            Ok    : Boolean;
            Msg   : String (1 .. 200);
            Last  : Natural;
         begin
            Grow (L, 30);
            Kernel.Store.Save (L, Path);
            Kernel.Store.Load (Path, L2, Ok, Msg, Last);
            Assert (Ok, "run" & Run'Image & " reload: " & Msg (1 .. Last));
            Assert (L2 = L, "run" & Run'Image & ": same log");
            Assert (Current (L2) = Current (L),
                    "run" & Run'Image & ": same state");
         end;
      end loop;
   end Test_Round_Trip;

   --  What the kernel refuses, and that a refusal leaves the log alone.
   procedure Test_Refusals (T : in out AUnit.Test_Cases.Test_Case'Class) is
      pragma Unreferenced (T);
      L : Log := Empty;
      C : Changeset := (Segment => 1, others => <>);
   begin
      C := Append (C, Make_Entry (1, 1, Drafted));
      C := Append (C, Make_Entry (1, 2, Drafted));
      Assert (Try_Append (L, Of_Changeset (C)) = Duplicate_Id,
              "the same id twice");
      Assert (Length (L) = 0, "nothing appended");

      C := (Segment => 1, others => <>);
      C := Append (C, Make_Entry (1, 1, Drafted));
      Must_Append (L, Of_Changeset (C), "segment 1 introduces id 1");
      C := (Segment => 2, others => <>);
      C := Append (C, Make_Entry (1, 1, Drafted));
      Assert (Try_Append (L, Of_Changeset (C)) = Foreign_Id,
              "segment 2 may not name segment 1's id");

      Assert (Try_Append (L, Of_Act (Make_Act ("A", "x", Check, Drafted,
                                     Reads (Rd (5, 1)))))
              = Unknown_Id,
              "an act may not read an id never introduced");

      --  Self-reference is the smallest cycle.
      C := (Segment => 1, others => <>);
      C := Append (C, Make_Entry (1, 2, Drafted, Refs (Ref (1, Sketch, 1))));
      Assert (Try_Append (L, Of_Changeset (C)) = Cycle, "self-reference");

      --  A removed id is a tombstone: an act that read it never binds
      --  again, and the segment may not bring it back.
      C := (Segment => 1, others => <>);
      Must_Append (L, Of_Changeset (C), "segment 1 drops id 1");
      Assert (not Current (L).Veritoids (1).Present, "gone");
      Assert (Current (L).Veritoids (1).Owner = 1, "still owned by 1");
      C := Append (C, Make_Entry (1, 1, Drafted));
      Must_Append (L, Of_Changeset (C), "segment 1 re-adds its own id");
      Assert (Length (L) = 3, "three records");
   end Test_Refusals;

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Random_Logs'Access,
                        "random logs: P1, P5, P6, P7 against oracles");
      Register_Routine (T, Test_Monotone_And_Lapse'Access,
                        "random appends: P3, P4 directly");
      Register_Routine (T, Test_Round_Trip'Access, "random logs: P8");
      Register_Routine (T, Test_Refusals'Access, "refusals and tombstones");
   end Register_Tests;

   overriding function Name (T : Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Properties");
   end Name;

end Property_Tests;
