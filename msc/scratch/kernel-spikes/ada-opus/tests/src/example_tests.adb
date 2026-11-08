with Ada.Directories;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AUnit.Assertions;      use AUnit.Assertions;
with Kernel.Model;          use Kernel.Model;
with Kernel.Store;          use Kernel.Store;
with Kernel.Text;           use Kernel.Text;
with Builder;               use Builder;
with Worked_Example;        use Worked_Example;

package body Example_Tests is

   type Strings is array (Positive range <>) of Unbounded_String;
   function "+" (S : String) return Unbounded_String
     renames To_Unbounded_String;

   --  The frontier of S, as names, equals Expected as a set.
   procedure Assert_Frontier (N : Names; S : State; Expected : Strings;
                              Where : String)
   is
      Got : constant Item_List := Frontier_Items (N, S);
      function Has (L : Item_List; X : Unbounded_String) return Boolean is
        (for some Y of L => Y = X);
   begin
      for X of Expected loop
         Assert (Has (Got, X), Where & ": missing " & To_String (X)
                 & "; frontier is" & ASCII.LF & Describe_Frontier (N, S));
      end loop;
      for Y of Got loop
         Assert ((for some X of Expected => X = Y),
                 Where & ": unexpected " & To_String (Y));
      end loop;
   end Assert_Frontier;

   function Id (N : in out Names; S : String) return Veritoid_Id is
     (Veritoid_Named (N, S));

   ---------------------------------------------------------------------

   procedure Test_Worked_Example
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
      N  : Names;
      St : Store;
      M  : Marks;
   begin
      Build (N, St, M);

      declare
         S : constant State := State_At (St.L, M (S0));
      begin
         Assert (Steady (S), "S0 is steady");
         Assert (Position (S, Id (N, "c")) = Rederived, "S0 position c");
         Assert (Ceiling (S, Id (N, "e")) = Drafted, "S0 ceiling e");
      end;

      declare
         S : constant State := State_At (St.L, M (Perturbed));
      begin
         --  Act 1 is B's check reading c@1, d@1.
         Assert (S.Acts (1).Actor = Actor_Named (N, "B")
                 and then not Binds (S.V, S.Acts (1)),
                 "B's check no longer binds");
         Assert (Position (S, Id (N, "c")) = Sketch, "position(c) = sketch");
         Assert (Ceiling (S, Id (N, "d")) = Sketch, "ceiling(d) = sketch");
         Assert (Ceiling (S, Id (N, "e")) = Sketch, "ceiling(e) = sketch");
         --  What the spec's definitions give.  Against the spec's listed
         --  expectation: unmet-need(d, c), overclaim(e) and unmet-need(e, c)
         --  are added (ceiling(c) = sketch is below both needs, and e's
         --  latent level falls below its claim), and stale-reference(e, c)
         --  is absent (A's affirmation reconciled e against c@2).
         Assert_Frontier
           (N, S,
            [+"overclaim(c)", +"overclaim(d)", +"stale-reference(d, c)",
             +"unmet-need(d, c)", +"overclaim(e)", +"unmet-need(e, c)",
             +"overclaim(u)", +"stale-reference(u, c)",
             +"unmet-need(u, c)"],
            "after A's changeset");
      end;

      Assert_Frontier (N, State_At (St.L, M (Rederived_1)),
                       [+"stale-reference(d, c)", +"stale-reference(u, c)"],
                       "after B's first re-derivation");

      --  d@3 lapses B's re-derivation of (c@2, d@2): c falls again.
      Assert_Frontier
        (N, State_At (St.L, M (Fixed)),
         [+"overclaim(c)", +"overclaim(d)", +"unmet-need(d, c)",
          +"overclaim(e)", +"unmet-need(e, c)", +"overclaim(u)",
          +"stale-reference(u, c)", +"unmet-need(u, c)"],
         "after d@3");

      Assert_Frontier (N, State_At (St.L, M (Rederived_2)),
                       [+"stale-reference(u, c)"],
                       "after B's second re-derivation");
      Assert_Frontier (N, State_At (St.L, M (U_Changed)),
                       [+"overclaim(u)"], "after u@2");

      declare
         S : constant State := State_At (St.L, M (S1));
      begin
         Assert (Steady (S), "S1 is steady");
         Assert (Same (S, St.Cur), "S1 is the current state");
         --  Act 4 is B's first re-derivation (c@2, d@2): still in the log,
         --  binding to nothing (all-or-nothing: c@2 is current, d@2 is not).
         Assert (S.Acts (4).N_Reads = 2
                 and then S.Acts (4).Reads (2).Ver = 2
                 and then not Binds (S.V, S.Acts (4)),
                 "B's first re-derivation of d@2 binds to nothing");
         Assert (Length (St.L) = M (S1), "nothing refused");
      end;
   end Test_Worked_Example;

   procedure Test_Literal_Reading
     (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
      N  : Names;
      St : Store;
      M  : Marks;
   begin
      --  If "e@1 affirmed" leaves e's reference at c@1, stale-reference(e, c)
      --  appears as the spec lists, but nothing in the rest of the sequence
      --  touches e, so the spec's S1 is not steady.
      Build (N, St, M, Affirm_E => False);
      Assert_Frontier (N, St.Cur, [+"stale-reference(e, c)"],
                       "literal reading at S1");
   end Test_Literal_Reading;

   procedure Test_Refusals (T : in out AUnit.Test_Cases.Test_Case'Class) is
      pragma Unreferenced (T);
      N      : Names;
      St     : Store;
      M      : Marks;
      CS     : Changeset;
      Before : State;
      Len    : Natural;
   begin
      Build (N, St, M);
      Before := St.Cur;
      Len := Length (St.L);

      --  c referencing d, while d references c: a cycle.
      CS := New_CS (N, "A", "T");
      Add_Item (N, CS, "c", 3, Rederived, [Ref ("d", Drafted, 4)]);
      Add_Item (N, CS, "d", 4, Rederived, [Ref ("c", Drafted, 3)]);
      Add_Item (N, CS, "e", 1, Drafted, [Ref ("c", Drafted, 2)]);
      Put_CS (St, CS, Expect => Cycle);
      Assert (Length (St.L) = Len + 1, "the refusal is recorded");
      Assert (Get (St.L, Len + 1).Result = Cycle, "recorded as Cycle");
      Assert (Same (St.Cur, Before), "a refusal changes no state");

      --  e's reference moved without an affirmation.
      CS := New_CS (N, "A", "T");
      Add_Item (N, CS, "c", 3, Rederived);
      Add_Item (N, CS, "d", 4, Rederived, [Ref ("c", Drafted, 3)]);
      Add_Item (N, CS, "e", 1, Drafted, [Ref ("c", Drafted, 3)]);
      Put_CS (St, CS, Expect => Unaffirmed_Reconcile);

      --  u lives in U; T cannot claim it.
      CS := New_CS (N, "A", "T");
      Add_Item (N, CS, "c", 2, Rederived);
      Add_Item (N, CS, "u", 9, Sketch);
      Put_CS (St, CS, Expect => Foreign_Id);

      CS := New_CS (N, "A", "T");
      Add_Item (N, CS, "c", 2, Rederived);
      Add_Item (N, CS, "c", 3, Rederived);
      Put_CS (St, CS, Expect => Duplicate_Item);

      Assert (Same (St.Cur, Before), "four refusals, no state change");
      Assert (Length (St.L) = Len + 4, "four refusals recorded");
   end Test_Refusals;

   procedure Test_Resurrection (T : in out AUnit.Test_Cases.Test_Case'Class)
   is
      pragma Unreferenced (T);
      N  : Names;
      St : Store := Empty_Store;
      CS : Changeset;
   begin
      --  With content versions as content hashes, reverting content brings
      --  the old version back, and an act that read it binds again.  P3
      --  speaks only of lapsing; this pins what happens on the way back.
      CS := New_CS (N, "A", "X");
      Add_Item (N, CS, "x", 1, Checked);
      Put_CS (St, CS);
      Put_Act (St, New_Act (N, "B", "check", Checked, [Rd ("x", 1)]));
      Assert (Steady (St.Cur), "x checked");

      CS := New_CS (N, "A", "X");
      Add_Item (N, CS, "x", 2, Checked);
      Put_CS (St, CS);
      Assert (Position (St.Cur, Id (N, "x")) = Sketch, "lapsed");

      CS := New_CS (N, "A", "X");
      Add_Item (N, CS, "x", 1, Checked);
      Put_CS (St, CS);
      Assert (Position (St.Cur, Id (N, "x")) = Checked,
              "reverting content re-binds the old check");
      Assert (Steady (St.Cur), "steady again with no new act");
   end Test_Resurrection;

   procedure Test_Replay (T : in out AUnit.Test_Cases.Test_Case'Class) is
      pragma Unreferenced (T);
      N, N2 : Names;
      St    : Store;
      M     : Marks;
      L2    : Log;
      Path  : constant String := "worked-example.log";
   begin
      Build (N, St, M);
      Save (Path, N, St.L);
      Load (Path, N2, L2);
      Assert (Length (L2) = Length (St.L), "same length");
      for I in 1 .. Length (L2) loop
         Assert (Same_Entry (Get (L2, I), Get (St.L, I)),
                 "record" & I'Image & " round-trips");
      end loop;
      for K in 0 .. Length (L2) loop
         Assert (Same (State_At (L2, K), State_At (St.L, K)),
                 "state as of" & K'Image & " replays");
      end loop;
      Ada.Directories.Delete_File (Path);
   end Test_Replay;

   ---------------------------------------------------------------------

   overriding procedure Register_Tests (T : in out Test) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Worked_Example'Access, "worked example");
      Register_Routine (T, Test_Literal_Reading'Access,
                        "literal reading of 'e@1 affirmed' never steadies");
      Register_Routine (T, Test_Refusals'Access, "refusals are recorded");
      Register_Routine (T, Test_Resurrection'Access,
                        "reverted content re-binds old acts");
      Register_Routine (T, Test_Replay'Access, "worked example replays");
   end Register_Tests;

   overriding function Name (T : Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Worked example and cases");
   end Name;

end Example_Tests;
