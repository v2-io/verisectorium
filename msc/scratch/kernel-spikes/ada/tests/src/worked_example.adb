with AUnit.Assertions; use AUnit.Assertions;
with Kernel;           use Kernel;
with Kernel.States;    use Kernel.States;
with Kernel.Logs;      use Kernel.Logs;
with Kernel.Store;
with Fixtures;         use Fixtures;

package body Worked_Example is

   --  Ids and segments of section 6.
   C : constant Veritoid_Id := 1;
   D : constant Veritoid_Id := 2;
   E : constant Veritoid_Id := 3;
   U : constant Veritoid_Id := 4;
   Seg_T : constant Segment_Id := 1;
   Seg_U : constant Segment_Id := 2;

   --  Build the whole log of section 6, checking the state at each
   --  stage against what the spec says (and, where the spec's list is
   --  short of its own definitions, against the definitions; see the
   --  account). Stop_After limits how far to go, so that the stages can
   --  be inspected separately.
   procedure Build (L : out Log) is
      S : State;
      F : Frontier_List;
      Why : Refusal;
      Cul : Id_Set;
   begin
      L := Empty;

      --  S0: segment T holds c, d, e; segment U holds u.
      declare
         CS : Changeset := (Segment => Seg_T, others => <>);
      begin
         CS := Append (CS, Make_Entry (C, 1, Rederived));
         CS := Append (CS, Make_Entry (D, 1, Rederived,
                                       Refs (Ref (C, Drafted, 1))));
         CS := Append (CS, Make_Entry (E, 1, Drafted,
                                       Refs (Ref (C, Drafted, 1))));
         Must_Append (L, Of_Changeset (CS), "T@S0");
      end;
      declare
         CS : Changeset := (Segment => Seg_U, others => <>);
      begin
         CS := Append (CS, Make_Entry (U, 1, Rederived,
                                       Refs (Ref (C, Rederived, 1))));
         Must_Append (L, Of_Changeset (CS), "U@S0");
      end;
      Must_Append (L, Of_Act (Make_Act ("B", "re-derivation", Check,
                               Rederived, Reads (Rd (C, 1), Rd (D, 1)))),
                   "B checks c@1 d@1");
      Must_Append (L, Of_Act (Make_Act ("A", "read-through", Check,
                               Drafted, Reads (Rd (E, 1)))),
                   "A checks e@1");
      Must_Append (L, Of_Act (Make_Act ("B", "re-derivation", Check,
                               Rederived, Reads (Rd (U, 1)))),
                   "B checks u@1");

      S := Current (L);
      Assert (Position (S, C) = Rederived, "S0 position c");
      Assert (Position (S, D) = Rederived, "S0 position d");
      Assert (Position (S, E) = Drafted,   "S0 position e");
      Assert (Position (S, U) = Rederived, "S0 position u");
      Assert (Ceiling (S, C) = Rederived, "S0 ceiling c");
      Assert (Ceiling (S, D) = Rederived, "S0 ceiling d");
      Assert (Ceiling (S, E) = Drafted,   "S0 ceiling e");
      Assert (Ceiling (S, U) = Rederived, "S0 ceiling u");
      F := Frontier (S);
      Assert (F.Count = 0, "S0 frontier empty, got" & F.Count'Image);
      Assert (Steady (S), "S0 steady");

      --  The perturbation: c needs an extra hypothesis. A writes T:
      --  c@2, d@2 (its reference to c still reconciled against c@1),
      --  e@1 carried and affirmed.
      declare
         CS : Changeset := (Segment => Seg_T, others => <>);
      begin
         CS := Append (CS, Make_Entry (C, 2, Rederived));
         CS := Append (CS, Make_Entry (D, 2, Rederived,
                                       Refs (Ref (C, Drafted, 1))));
         CS := Append (CS, Make_Entry (E, 1, Drafted,
                                       Refs (Ref (C, Drafted, 1))));
         Must_Append (L, Of_Changeset (CS), "T: c@2 d@2 e@1");
      end;
      Must_Append (L, Of_Act (Make_Act ("A", "still right against c@2",
                               Affirmation, Drafted,
                               Reads (Rd (E, 1), Rd (C, 2), Rd (D, 2)))),
                   "A affirms e@1");

      S := Current (L);
      Assert (not Binds (S, S.Acts (1)), "B's first check no longer binds");
      Assert (Binds (S, S.Acts (2)), "A's check on e@1 still binds");
      Assert (Binds (S, S.Acts (3)), "B's check on u@1 still binds");
      Assert (Position (S, C) = Sketch,  "position c after c@2");
      Assert (Position (S, D) = Sketch,  "position d after d@2");
      Assert (Position (S, E) = Drafted, "position e unchanged");
      Assert (Position (S, U) = Rederived, "position u unchanged");
      Assert (Ceiling (S, C) = Sketch, "ceiling c");
      Assert (Ceiling (S, D) = Sketch, "ceiling d");
      Assert (Ceiling (S, E) = Sketch, "ceiling e");
      Assert (Ceiling (S, U) = Sketch, "ceiling u");
      F := Frontier (S);
      --  The seven items the spec lists:
      Assert (Has (F, Overclaim_Item, C), "overclaim(c)");
      Assert (Has (F, Overclaim_Item, D), "overclaim(d)");
      Assert (Has (F, Stale_Item, D, 1), "stale-reference(d, c)");
      Assert (Has (F, Stale_Item, E, 1), "stale-reference(e, c)");
      Assert (Has (F, Stale_Item, U, 1), "stale-reference(u, c)");
      Assert (Has (F, Overclaim_Item, U), "overclaim(u)");
      Assert (Has (F, Unmet_Item, U, 1), "unmet-need(u, c)");
      --  ... and the three its own definitions add (see the account):
      Assert (Has (F, Overclaim_Item, E), "overclaim(e): drafted > sketch");
      Assert (Has (F, Unmet_Item, D, 1), "unmet-need(d, c): sketch < drafted");
      Assert (Has (F, Unmet_Item, E, 1), "unmet-need(e, c): sketch < drafted");
      Assert (F.Count = 10, "frontier has 10 items, got" & F.Count'Image);
      Assert (not Steady (S), "not steady");

      --  B re-derives c@2, d@2.
      Must_Append (L, Of_Act (Make_Act ("B", "re-derivation", Check,
                               Rederived, Reads (Rd (C, 2), Rd (D, 2)))),
                   "B re-derives c@2 d@2");
      S := Current (L);
      Assert (Position (S, C) = Rederived, "position c re-derived");
      Assert (Position (S, D) = Rederived, "position d re-derived");
      F := Frontier (S);
      Assert (Has (F, Stale_Item, D, 1), "d still reconciled against c@1");
      Assert (not Has (F, Overclaim_Item, C), "c no longer overclaimed");

      --  A fixes step 3: d@3, and reconciles d's and e's references
      --  against c@2 (e's content is unchanged, so e stays at @1).
      declare
         CS : Changeset := (Segment => Seg_T, others => <>);
      begin
         CS := Append (CS, Make_Entry (C, 2, Rederived));
         CS := Append (CS, Make_Entry (D, 3, Rederived,
                                       Refs (Ref (C, Drafted, 2))));
         CS := Append (CS, Make_Entry (E, 1, Drafted,
                                       Refs (Ref (C, Drafted, 2))));
         Must_Append (L, Of_Changeset (CS), "T: c@2 d@3 e@1");
      end;
      S := Current (L);
      Assert (not Binds (S, S.Acts (5)), "B's c@2 d@2 check lapsed on d@3");
      Assert (Position (S, C) = Sketch, "c's only check lapsed with d");

      --  B re-derives again.
      Must_Append (L, Of_Act (Make_Act ("B", "re-derivation", Check,
                               Rederived, Reads (Rd (C, 2), Rd (D, 3)))),
                   "B re-derives c@2 d@3");

      --  C changes U: u@2 referencing c@2.
      declare
         CS : Changeset := (Segment => Seg_U, others => <>);
      begin
         CS := Append (CS, Make_Entry (U, 2, Rederived,
                                       Refs (Ref (C, Rederived, 2))));
         Must_Append (L, Of_Changeset (CS), "U: u@2");
      end;

      --  B re-derives u@2.
      Must_Append (L, Of_Act (Make_Act ("B", "re-derivation", Check,
                               Rederived, Reads (Rd (U, 2)))),
                   "B re-derives u@2");

      --  S1.
      S := Current (L);
      Assert (Position (S, C) = Rederived, "S1 position c");
      Assert (Position (S, D) = Rederived, "S1 position d");
      Assert (Position (S, E) = Drafted,   "S1 position e");
      Assert (Position (S, U) = Rederived, "S1 position u");
      Assert (Ceiling (S, E) = Drafted,    "S1 ceiling e");
      F := Frontier (S);
      Assert (F.Count = 0, "S1 frontier empty, got" & F.Count'Image);
      Assert (Steady (S), "S1 steady");
      Assert (Length (L) = 12, "12 records");
      Assert (not Binds (S, S.Acts (5)),
              "the log still holds B's c@2 d@2 check, binding to nothing");

      --  A changeset that would close a cycle (c referencing u) is
      --  refused, and the log does not move. The witness is everything
      --  that could not be ranked: the cycle (c, u) and what rests on it
      --  (d, e).
      declare
         CS : Changeset := (Segment => Seg_T, others => <>);
         N  : constant Log_Count := Length (L);
      begin
         CS := Append (CS, Make_Entry (C, 3, Rederived,
                                       Refs (Ref (U, Drafted, 2))));
         CS := Append (CS, Make_Entry (D, 3, Rederived,
                                       Refs (Ref (C, Drafted, 3))));
         CS := Append (CS, Make_Entry (E, 1, Drafted,
                                       Refs (Ref (C, Drafted, 3))));
         Append (L, Of_Changeset (CS), Why, Cul);
         Assert (Why = Cycle, "cycle refused, got " & Why'Image);
         Assert (Cul (C) and Cul (U), "c and u are culprits");
         Assert (Cul (D) and Cul (E), "d and e rest on the cycle");
         Assert (Length (L) = N, "a refused record is not appended");
      end;
   end Build;

   procedure Test_Stages (T : in out AUnit.Test_Cases.Test_Case'Class) is
      pragma Unreferenced (T);
      L : Log;
   begin
      Build (L);
   end Test_Stages;

   --  P8: write the log, read it back, same log and same state. The
   --  file is kept beside the crate so the CLI has something to show.
   procedure Test_Replay (T : in out AUnit.Test_Cases.Test_Case'Class) is
      pragma Unreferenced (T);
      L, L2    : Log;
      Ok       : Boolean;
      Msg      : String (1 .. 200);
      Last     : Natural;
      Path     : constant String := "../examples/worked-example.log";
   begin
      Build (L);
      Kernel.Store.Save (L, Path);
      Kernel.Store.Load (Path, L2, Ok, Msg, Last);
      Assert (Ok, "reload: " & Msg (1 .. Last));
      Assert (Length (L2) = Length (L), "same length");
      for K in 1 .. Length (L) loop
         Assert (Record_At (L2, K) = Record_At (L, K),
                 "record" & K'Image & " survives the round trip");
      end loop;
      Assert (L2 = L, "same log");
      Assert (Current (L2) = Current (L), "same state");
      for K in 0 .. Length (L) loop
         Assert (State_At (L2, K) = State_At (L, K),
                 "same state as of" & K'Image);
      end loop;
   end Test_Replay;

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Stages'Access, "section 6, stage by stage");
      Register_Routine (T, Test_Replay'Access, "P8: file round trip");
   end Register_Tests;

   overriding function Name (T : Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Worked example");
   end Name;

end Worked_Example;
