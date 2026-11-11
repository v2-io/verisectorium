--  The five invented moves of core/src, and the specific probes the
--  audit and the draft-3 read predicted, each run through the kernel.
--  Every "ok" / "FAIL" line is an expectation stated before the run.
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line;
with Vk;               use Vk;
with Vk.Model;         use Vk.Model;
with Lab;              use Lab;

procedure Scenarios is

   procedure Title (S : String) is
   begin
      New_Line;
      Put_Line ("== " & S);
   end Title;

   function Claim_V (Says : Assertion := 1; R1, R2 : Ref := (others => <>))
      return Version is
     (Exists => True, K => 1, Says => [Says, 0], Refs => [R1, R2],
      others => <>);

   function Asm_V (K : Kind; S1, S2, S3 : Slot := (others => <>))
      return Version is
     (Exists => True, K => K, Slots => [S1, S2, S3], others => <>);

   -------------------------------------------------------------------
   --  1. impl-a-small-move
   -------------------------------------------------------------------
   procedure Small_Move is
      T : constant Id := 1; C : constant Id := 2; E : constant Id := 3;
      U : constant Id := 4; UU : constant Id := 5;
      W : World;
      S0, S1 : Selection;
   begin
      Title ("1. A small move (canon by rule)");
      W.O := Theory (By_Rule);
      W.T (T, 1) := Asm_V (2, Hold (C), Hold (E));
      W.T (C, 1) := Claim_V (1);
      W.T (C, 2) := Claim_V (2);                      --  gains H
      W.T (E, 1) := Claim_V (1);
      W.T (U, 1) := Asm_V (2, Hold (UU));
      W.T (UU, 1) := Claim_V (1, R (1, C));
      W.T (UU, 2) := Claim_V (2, R (1, C));
      S0 := [T => Pk (1), C => Pk (1), E => Pk (1), U => Pk (1),
             UU => Pk (1)];
      W.S := S0;
      W.F.Ev (1) := Evid (C, 1, 1, 1);
      W.F.Ev (2) := Evid (E, 1, 1, 1, R1 => Rd (C, 1, Assertions));
      W.F.Ev (3) := Evid (UU, 1, 1, 1, R1 => Rd (C, 1));
      W.F.Ev (4) := Evid (T, 1, 2, 1, R1 => Rd (C, 1, Assertions),
                          R2 => Rd (E, 1, Assertions));
      W.F.Ev (5) := Evid (U, 1, 2, 1, R1 => Rd (UU, 1, Assertions));
      W.F.Dec (1) := Affirm_D (UU, Only (1), C, 1);
      Show ("S0", W);
      Expect (Stationary (W), "S0 is stationary");

      --  08:30: the finding, by a second criterion.
      W.F.Ev (6) := Evid (C, 1, 1, 2, Result => Fails);
      Show ("after the finding on c", W);
      Expect (Has (W, C6_Fails, C), "c is known wrong");
      Expect (Has (W, C5_Rests, UU), "u rests on an inconsistent c");
      Expect (Has (W, C8_Slot, T),
              "T's required slot holds an inconsistent piece (hub, C8)");
      Expect (Has (W, C8_Slot, U), "and so does U's");

      --  09:25: the candidate with only c rewritten.
      W.S (C) := Pk (2);
      Show ("candidate: c@2 selected, nothing else done", W);
      Expect (Has (W, C6_Guard, C),
              "the defect is presumed present in c@2 (guard)");
      Expect (Has (W, C4_Reconciled, UU), "u's reference to c is not reconciled");
      Expect (Has (W, C5_Standard, UU),
              "u's check read c@1: it no longer applies, the rule fails");
      Expect (Has (W, C5_Standard, T), "T's whole read read c's assertion");

      --  The rest of the repair: facts and one more version.
      W.S (UU) := Pk (2);
      W.F.Ev (7) := Evid (C, 2, 1, 2);                 --  the answer
      W.F.Ev (2).Reads (1).Same := Only (2);           --  e's check carried
      W.F.Ev (8) := Evid (UU, 2, 1, 1, R1 => Rd (C, 2));
      W.F.Dec (2) := Affirm_D (UU, Only (2), C, 2);
      W.F.Ev (9) := Evid (T, 1, 2, 1, R1 => Rd (C, 2, Assertions),
                          R2 => Rd (E, 1, Assertions));
      W.F.Ev (10) := Evid (U, 1, 2, 1, R1 => Rd (UU, 2, Assertions));
      S1 := W.S;
      Show ("S1", W);
      Expect (Stationary (W), "S1 is stationary: the move is one changeset");

      --  Q3: going back.
      W.S := S0;
      Expect (not Stationary (W),
              "going back to S0 with what was learned: not stationary");
      Expect (Owed (W) > 0 and then Has (W, C6_Fails, C),
              "  and the reason is the finding, nothing else about c");
      --  M3: revert the repair only.
      W.S := S1;
      W.S (C) := Pk (1);
      Expect (Has (W, C6_Fails, C),
              "reverting c after the answer brings the finding back");

      --  Finding 1 of the draft-3 read: evidence without reads.
      W.S := S0;
      W.S (C) := Pk (2);
      W.F.Dec (3) := Affirm_D (UU, Only (1), C, 2);
      W.O.Reads_On := True;
      Expect (Has (W, C5_Standard, UU),
              "reads on: u@1 beside c@2 needs a fresh check");
      W.O.Reads_On := False;
      Expect (not Has (W, C5_Standard, UU) and then not Has (W, C4_Reconciled, UU)
              and then not Has (W, C5_Rests, UU),
              "reads off (literal draft 3): the author's affirm alone "
              & "makes u consistent on a rewritten premise");
   end Small_Move;

   -------------------------------------------------------------------
   --  2. impl-an-outline-fills-in
   -------------------------------------------------------------------
   procedure Outline is
      O : constant Id := 1; D : constant Id := 2; R1 : constant Id := 3;
      R2 : constant Id := 4; Q : constant Id := 5;
      W : World;
   begin
      Title ("2. An outline fills in (canon by decision)");
      W.O := Theory (By_Decision);
      W.T (O, 1) := Asm_V (3, Hold (D), Point (R1));
      W.T (O, 2) := Asm_V (3, Hold (D), Point (R1), Point (R2));
      W.T (D, 1) := Claim_V (1);
      W.T (D, 2) := Claim_V (1);                       --  reworded
      W.T (R1, 1) := Claim_V (1, R (1, D));
      W.T (R2, 1) := Claim_V (1, R (1, R1));
      W.T (Q, 1) := Claim_V (1);
      W.S := [O => Pk (1), D => Pk (1), R1 => Pk (1), others => No_Pick];
      W.F.Dec (1) := Admit_D (D, Only (1));
      W.F.Dec (2) := Admit_D (R1, Only (1), Sound (D));
      W.F.Dec (3) := Admit_D (O, Only (1));
      W.F.Dec (4) := Affirm_D (R1, Only (1), D, 1);
      Show ("S0", W);
      Expect (Stationary (W), "S0 is stationary (slot 3 empty)");

      --  Step 1: the promise. Note: in draft 3 a slot has no written
      --  "promised" state, so O has no new version.
      W.F.Dec (5) := Promise_D (O, 3);
      Expect (Has (W, C8_Slot, O), "step 1: the promise is owed");
      Expect (not Has (W, C5_Standard, O),
              "  and O's acceptance is untouched (core: reopened)");

      --  Step 2: R2 written and pointed at, not asserted.
      W.S (O) := Pk (2);
      W.S (R2) := Pk (1, Asserted => False);
      W.S (Q) := Pk (1, Asserted => False);
      W.F.Dec (6) := Admit_D (O, Only (2));
      Expect (Has (W, C8_Slot, O), "step 2: filled by a draft, still owed");
      Expect (Uncovered (W) = 1, "  and nothing inside the draft is owed");

      --  Steps 3-4: checked, then asserted on a named assumption Q.
      W.F.Ev (1) := Evid (R2, 1, 1, 1);
      W.S (R2) := Pk (1);
      W.S (Q) := Pk (1);
      W.F.Dec (7) := Admit_D (R2, Only (1), Sound (R1), Sound (Q));
      W.F.Dec (8) := Admit_D (Q, Only (1));
      W.F.Dec (9) := Affirm_D (R2, Only (1), R1, 1);
      Show ("after step 4", W);
      Expect (Stationary (W), "step 4: stationary, the promise kept");

      --  Step 5: D reworded.
      W.S (D) := Pk (2);
      Show ("after D is reworded", W);
      Expect (Has (W, C5_Standard, D), "step 5: D's acceptance read D@1");
      Expect (Has (W, C5_Standard, R1) and then Has (W, C5_Standard, R2),
              "  R1 and R2 were accepted on what they rest on being sound");
      Expect (Has (W, C4_Reconciled, R1), "  R1's reference is not reconciled");
      Expect (not Has (W, C5_Standard, O),
              "  O holds D and its acceptance is untouched");
      Expect (Has (W, C8_Slot, O) and then not Cons (W) (O),
              "  OBSERVED: but the promise O kept is unkept again, because "
              & "R2 is inconsistent, and O with it (C8 asks for a "
              & "consistent filler)");
      W.O.Slot_Needs_Consistent := False;
      Expect (Cons (W) (O),
              "  switch: C8 asks only for an asserted filler: O untouched");
      W.O.Slot_Needs_Consistent := True;

      --  Step 6.
      W.F.Dec (10) := Admit_D (D, Only (2));
      W.F.Dec (11) := Affirm_D (R1, Only (1), D, 2);
      Expect (Stationary (W),
              "step 6: accept D@2, affirm R1's reference: stationary; "
              & "R1's and R2's acceptances stand again unasked (no latch)");

      --  Step 7: the assumption fails; nothing of R2 changes.
      W.F.Ev (2) := Evid (Q, 1, 1, 1, Result => Fails);
      Show ("after the assumption fails", W);
      Expect (Has (W, C5_Standard, R2),
              "step 7: R2's acceptance fails with no word of R2 changed");
      Expect (not Has (W, C5_Standard, R1), "  R1 is untouched");
   end Outline;

   -------------------------------------------------------------------
   --  3. impl-a-finding-is-answered
   -------------------------------------------------------------------
   procedure Finding is
      C : constant Id := 1; E : constant Id := 2;
      W : World;
   begin
      Title ("3. A rewording, a wrong finding and a right one (by rule)");
      W.O := Theory (By_Rule);
      W.T (C, 1) := Claim_V (1);
      W.T (C, 2) := Claim_V (1);                       --  reworded
      W.T (E, 1) := Claim_V (1, R (2, C));
      W.T (E, 2) := Claim_V (2, R (2, C));             --  states H
      W.T (E, 3) := Claim_V (2, R (2, C));             --  a comma moved
      W.S := [C => Pk (1), E => Pk (1), others => No_Pick];
      W.F.Ev (1) := Evid (C, 1, 1, 1);
      W.F.Ev (2) := Evid (E, 1, 1, 1);
      W.F.Dec (1) := Affirm_D (E, Only (1), C, 1);
      Expect (Stationary (W), "S0 is stationary");

      W.S (C) := Pk (2);
      Expect (Has (W, C5_Standard, C), "step 1: reworded, its check lapsed");
      Expect (not Has (W, C4_Reconciled, E),
              "  e narrates c and relies on its assertions, which did not "
              & "change: no affirmation needed");
      W.F.Ev (1).Same := Only (2);
      Expect (Stationary (W), "step 2: one same fact carries the check");

      W.F.Ev (3) := Evid (C, 2, 1, 2, Result => Fails);
      Expect (Has (W, C6_Fails, C), "step 3: a finding against c");
      W.F.Ev (4) := Evid (C, 2, 1, 2);
      Expect (Has (W, C6_Fails, C),
              "step 4: contrary evidence on the same criterion at the same "
              & "version clears nothing (literal draft 3)");
      W.O.Set_Aside_On := False;
      W.F.Dec (2) := Aside_D (3);
      Expect (not Stationary (W), "  with no set-aside decision: stuck");
      W.O.Set_Aside_On := True;
      Expect (Stationary (W),
              "  set aside by a decision: clear, and c never touched");

      W.F.Ev (5) := Evid (E, 1, 1, 2, Result => Fails);
      W.S (E) := Pk (2);
      Expect (Has (W, C6_Guard, E), "step 5: the rewrite does not clear it");
      W.F.Ev (6) := Evid (E, 2, 1, 2);
      W.F.Dec (3) := Affirm_D (E, Only (2), C, 2);
      Expect (Stationary (W), "step 6: answered at the new version");

      W.S (E) := Pk (3);
      W.F.Dec (4) := Affirm_D (E, Only (3), C, 2);
      Expect (Has (W, C6_Guard, E),
              "afterwards: a comma moved in e, and the old finding is owed "
              & "again until its answer is carried (the guard is for ever)");
      W.F.Ev (6).Same := Only (3);
      Expect (Stationary (W), "  one same fact per guard per edit");
   end Finding;

   -------------------------------------------------------------------
   --  4. impl-two-moves-at-once, and Q8
   -------------------------------------------------------------------
   type Hub is (Bare, Reads_Assertions, Points_Assertions);

   procedure Two_Moves (H : Hub; Meet : Boolean) is
      C : constant Id := 1; U : constant Id := 2; X : constant Id := 3;
      O : constant Id := 5;
      W, A, B, M : World;
   begin
      Title ("4. Two moves at once; outline " & H'Image
             & (if Meet then "; x comes to rest on c" else ""));
      W.O := Theory (By_Rule);
      if H = Points_Assertions then
         W.O.Point_Kind := 2;
      end if;
      W.T (C, 1) := Claim_V (1);
      W.T (C, 2) := Claim_V (2);
      W.T (U, 1) := Claim_V (1, R (1, C));
      W.T (U, 2) := Claim_V (2, R (1, C));
      W.T (X, 1) := Claim_V (1);
      W.T (X, 2) := (if Meet then Claim_V (2, R (1, C)) else Claim_V (2));
      W.T (O, 1) := Asm_V (3, Point (C), Point (X), Point (U));
      W.S := [C => Pk (1), U => Pk (1), X => Pk (1), O => Pk (1),
              others => No_Pick];
      W.F.Ev (1) := Evid (C, 1, 1, 1);
      W.F.Ev (2) := Evid (U, 1, 1, 1, R1 => Rd (C, 1));
      W.F.Ev (3) := Evid (X, 1, 1, 1);
      W.F.Ev (5) :=
        (if H = Reads_Assertions then
           Evid (O, 1, 2, 1, R1 => Rd (C, 1, Assertions),
                 R2 => Rd (X, 1, Assertions))
         else Evid (O, 1, 2, 1));
      W.F.Dec (1) := Affirm_D (U, Only (1), C, 1);
      if H = Points_Assertions then
         W.F.Dec (2) := Affirm_D (O, Only (1), C, 1);
         W.F.Dec (3) := Affirm_D (O, Only (1), X, 1);
         W.F.Dec (4) := Affirm_D (O, Only (1), U, 1);
      end if;
      Expect (Stationary (W), "S0 is stationary");

      --  Changeset A: the repair of c and u.
      A := W;
      A.F.Ev (6) := Evid (C, 1, 1, 2, Result => Fails);
      A.S (C) := Pk (2);
      A.S (U) := Pk (2);
      A.F.Ev (7) := Evid (C, 2, 1, 2);
      A.F.Ev (8) := Evid (U, 2, 1, 1, R1 => Rd (C, 2));
      A.F.Dec (5) := Affirm_D (U, Only (2), C, 2);
      case H is
         when Bare => null;
         when Reads_Assertions =>
            A.F.Ev (9) := Evid (O, 1, 2, 1, R1 => Rd (C, 2, Assertions),
                                R2 => Rd (X, 1, Assertions));
         when Points_Assertions =>
            A.F.Dec (6) := Affirm_D (O, Only (1), C, 2);
            A.F.Dec (7) := Affirm_D (O, Only (1), U, 2);
      end case;
      Expect (Stationary (A), "A alone reaches a stationary selection");

      --  Changeset B: the repair of x.
      B := W;
      B.F.Ev (10) := Evid (X, 1, 1, 2, Result => Fails);
      B.S (X) := Pk (2);
      B.F.Ev (11) := Evid (X, 2, 1, 2);
      if Meet then
         B.F.Dec (8) := Affirm_D (X, Only (2), C, 1);
      end if;
      case H is
         when Bare => null;
         when Reads_Assertions =>
            B.F.Ev (12) := Evid (O, 1, 2, 1, R1 => Rd (C, 1, Assertions),
                                 R2 => Rd (X, 2, Assertions));
         when Points_Assertions =>
            B.F.Dec (9) := Affirm_D (O, Only (1), X, 2);
      end case;
      Expect (Stationary (B), "B alone reaches a stationary selection");

      --  Both: each piece from whichever changeset moved it; all facts.
      M := W;
      for P in Id loop
         if A.S (P) /= W.S (P) then
            M.S (P) := A.S (P);
         elsif B.S (P) /= W.S (P) then
            M.S (P) := B.S (P);
         end if;
      end loop;
      for I in Ev_Ix loop
         if A.F.Ev (I).Present then
            M.F.Ev (I) := A.F.Ev (I);
         elsif B.F.Ev (I).Present then
            M.F.Ev (I) := B.F.Ev (I);
         end if;
      end loop;
      for J in Dec_Ix loop
         if A.F.Dec (J).Present then
            M.F.Dec (J) := A.F.Dec (J);
         elsif B.F.Dec (J).Present then
            M.F.Dec (J) := B.F.Dec (J);
         end if;
      end loop;
      Show ("both applied", M);
      if Meet then
         Expect (not Stationary (M) and then Has (M, C4_Reconciled, X),
                 "they meet at x's new reference to c: not stationary");
      elsif H = Reads_Assertions then
         Expect (not Stationary (M) and then Has (M, C5_Standard, O)
                 and then Uncovered (M) = 1,
                 "PREDICTED (audit M5): neither whole read of the outline "
                 & "applies to the combined selection; the two meet at O");
      else
         Expect (Stationary (M), "applied together: stationary (Q8 holds)");
      end if;
   end Two_Moves;

   -------------------------------------------------------------------
   --  5. impl-intake
   -------------------------------------------------------------------
   procedure Intake is
      C : constant Id := 1; I : constant Id := 2; Src : constant Id := 3;
      K2 : constant Id := 4; K4 : constant Id := 5;
      W : World;
      N0 : Natural;
      function Routed (W : World) return Boolean is
        (Affirmed (W.T, W.S, W.F, Ctx (W), Cons (W), K4, I, Everything));
   begin
      Title ("5. An audit comes in (by rule)");
      W.O := Theory (By_Rule);
      W.T (C, 1) := Claim_V (1);
      W.T (I, 1) := Claim_V (1);
      W.T (I, 2) := Claim_V (2);                        --  citation dropped
      W.T (Src, 1) := Asm_V (3, Hold (K2), Hold (K4));
      W.T (K2, 1) := Claim_V (0, R (2, C));
      W.T (K4, 1) := Claim_V (0, R (2, I));
      W.S := [C => Pk (1), I => Pk (1), others => No_Pick];
      W.F.Ev (1) := Evid (C, 1, 1, 1);
      W.F.Ev (2) := Evid (I, 1, 1, 1);
      Expect (Stationary (W), "S0 is stationary");
      N0 := Owed (W);

      W.S (Src) := Pk (1, Asserted => False);
      W.S (K2) := Pk (1, Asserted => False);
      W.S (K4) := Pk (1, Asserted => False);
      Expect (Owed (W) = N0, "step 1: the source comes in; nothing is owed");

      W.F.Dec (1) := Ask_D (C, 1);
      Expect (not Has (W, C9_Raised, C),
              "step 2: a question raised on c about validity is ALREADY "
              & "MET by c's old check (C9 asks only that some evidence on "
              & "the dimension applies)");
      W.F.Dec (2) := Ask_D (C, 2);
      Expect (Has (W, C9_Raised, C),
              "  on a dimension never asked it is owed");
      W.F.Dec (2).Withdrawn := True;

      W.F.Dec (3) := Affirm_D (K4, Only (1), I, 1);
      Expect (Routed (W),
              "step 4: 'already present' said as an affirm of the chunk "
              & "against i@1 (draft 3 has no routing decision)");
      W.S (I) := Pk (2);
      W.F.Ev (3) := Evid (I, 2, 1, 1);
      Expect (not Routed (W), "step 7: i rewritten; the routing fails");
      Expect (Stationary (W),
              "  and nothing is owed for it: retirement is no constraint");
   end Intake;

   -------------------------------------------------------------------
   --  Probes
   -------------------------------------------------------------------
   procedure Probes is
      W : World;
   begin
      Title ("P1. Q6: an obligation conditioned on consistency (the liar)");
      W.O := Theory (By_Placement);
      W.T (1, 1) := Claim_V (1);
      W.S := [1 => Pk (1), others => No_Pick];
      Expect (Stationary (W) and then Fixed (W), "one asserted claim: fine");
      W.F.Dec (1) := Ask_D (1, 1, Sound (1));
      Expect (not Stratified (W.F), "a raise that holds while p1 is consistent");
      Expect (not Fixed (W),
              "PREDICTED: 'consistent' has no fixed point: the raise holds "
              & "iff p1 is consistent iff the raise does not hold");
      Show ("what the descent stops at", W);

      Title ("P2. Q4: a same fact that does harm");
      W := (others => <>);
      W.O := Theory (By_Placement);
      W.T (1, 1) := Claim_V (1);
      W.T (1, 2) := Claim_V (1);
      W.S := [1 => Pk (2), others => No_Pick];
      W.F.Ev (1) := Evid (1, 1, 1, 1, Result => Fails);
      W.F.Ev (2) := Evid (1, 2, 1, 1);
      Expect (Stationary (W), "p1@2 with its old defect answered: stationary");
      W.F.Ev (1).Same := Only (2);
      Expect (Has (W, C6_Fails, 1),
              "PREDICTED: add 'same(p1@1, p1@2, for the failing fact)': "
              & "the failure now applies at the selected version");

      Title ("P3. A waived defect, and what rests on it");
      W := (others => <>);
      W.O := Theory (By_Placement);
      W.T (1, 1) := Claim_V (1);
      for P in Id range 2 .. 5 loop
         W.T (P, 1) := Claim_V (1, R (1, P - 1));
         W.F.Dec (Dec_Ix (P)) := Affirm_D (P, Only (1), P - 1, 1);
      end loop;
      W.S := [others => Pk (1)];
      Expect (Stationary (W), "a chain of five, each resting on the last");
      W.F.Ev (1) := Evid (1, 1, 1, 1, Result => Fails);
      W.F.Dec (1) := Waive_D ((C6_Fails, 1, 1, 0));
      Expect (Has (W, C6_Guard, 1),
              "OBSERVED: at the very version found wrong the guard is "
              & "violated as well as C6's first clause, and only "
              & "conflicting evidence could meet it: two waivers per defect");
      W.F.Dec (6) := Waive_D ((C6_Guard, 1, 1, 1));
      Show ("root defect waived", W);
      Expect (Uncovered (W) = 4,
              "the root defect waived leaves 4 uncovered items: every piece "
              & "downstream needs its own");
      W.O.Waived_Is_Consistent := True;
      Expect (Stationary (W),
              "switch: a covered violation does not spread: nothing more needed");

      Title ("P4. C8: a required slot and an inconsistent part");
      W := (others => <>);
      W.O := Theory (By_Placement);
      W.T (1, 1) := Asm_V (2, Hold (2));
      W.T (2, 1) := Claim_V (1);
      W.S := [1 => Pk (1), 2 => Pk (1), others => No_Pick];
      Expect (Stationary (W), "a document and its required claim");
      W.F.Ev (1) := Evid (2, 1, 1, 1, Result => Fails);
      Expect (Has (W, C8_Slot, 1),
              "the claim is found wrong: the document is inconsistent too "
              & "(C8 asks for a consistent filler)");
      W.O.Slot_Needs_Consistent := False;
      Expect (not Has (W, C8_Slot, 1) and then Cons (W) (1),
              "switch: C8 asks only that the filler is asserted: the "
              & "document stays consistent, as def/segment.md says");

      Title ("P5. Q10: guards off");
      W := (others => <>);
      W.O := Theory (By_Placement);
      W.T (1, 1) := Claim_V (1);
      W.T (1, 2) := Claim_V (1);
      W.S := [1 => Pk (2), others => No_Pick];
      W.F.Ev (1) := Evid (1, 1, 1, 1, Result => Fails);
      Expect (not Stationary (W), "guards on: the reworded piece owes");
      W.O.Guards_On := False;
      Expect (Stationary (W) and then Owed (W) = 0,
              "guards off: one piece, two versions, one fact: a reworded "
              & "piece with a known unexamined defect, stationary");

      Title ("P6. Q5's edges: what does shed a known defect");
      W := (others => <>);
      W.O := Theory (By_Placement);
      W.T (1, 1) := Claim_V (1);
      W.T (2, 1) := Claim_V (1);                        --  the same words
      W.S := [1 => Pk (1), others => No_Pick];
      W.F.Ev (1) := Evid (1, 1, 1, 1, Result => Fails);
      Expect (not Stationary (W), "p1 is known wrong");
      W.S := [2 => Pk (1), others => No_Pick];
      Expect (Stationary (W),
              "the same content under a fresh id, no descent recorded: "
              & "stationary");
      W.F.Desc (1, 2) := True;
      Expect (Has (W, C6_Guard, 2), "  with descent recorded: guarded");
      W.S := [1 => Pk (1, Asserted => False), others => No_Pick];
      Expect (Stationary (W),
              "p1 selected and not asserted: stationary (a leaf drops free)");

      Title ("P8. Q6: pieces resting on one another");
      W := (others => <>);
      W.O := Theory (By_Decision);
      W.O.RK (2) := (Rests => True, Relies_On => Everything,
                     Caps => [False, False]);    --  rests, caps nothing
      W.T (1, 1) := Claim_V (1, R (2, 2));
      W.T (2, 1) := Claim_V (1, R (2, 1));
      W.S := [1 => Pk (1), 2 => Pk (1), others => No_Pick];
      W.F.Dec (1) := Affirm_D (1, Only (1), 2, 1);
      W.F.Dec (2) := Affirm_D (2, Only (1), 1, 1);
      W.F.Dec (3) := Admit_D (1, Only (1), Sound (2));
      W.F.Dec (4) := Admit_D (2, Only (1), Sound (1));
      Expect (Stationary (W) and then Cons (W) (1) and then Cons (W) (2),
              "two claims each accepted on the other being sound: "
              & "consistent together, in whatever order they were accepted");
      Expect (Is_Fixed (W.O, W.T, W.S, W.F, Ctx (W), [others => False]),
              "  'neither is consistent' is a fixed point too: the "
              & "greatest is the one taken");
      W.S (2).Asserted := False;
      Expect (Has (W, C5_Standard, 1) and then Has (W, C5_Rests, 1),
              "  with only one of them asserted, it is not consistent");

      Title ("P9. Q10: what a one-word edit needs, by C4");
      W := (others => <>);
      W.O := Theory (By_Placement);
      W.T (1, 1) := Claim_V (1);
      W.T (2, 1) := Claim_V (1);
      W.T (3, 1) := Claim_V (1, R (1, 1), R (1, 2));   --  the piece edited
      W.T (3, 2) := Claim_V (1, R (1, 1), R (1, 2));   --  one word changed
      W.T (4, 1) := Claim_V (1, R (1, 3));             --  relies on everything
      W.T (5, 1) := Claim_V (1, R (2, 3));             --  relies on assertions
      W.S := [others => Pk (1)];
      W.F.Dec (1) := Affirm_D (3, Only (1), 1, 1);
      W.F.Dec (2) := Affirm_D (3, Only (1), 2, 1);
      W.F.Dec (3) := Affirm_D (4, Only (1), 3, 1);
      W.F.Dec (4) := Affirm_D (5, Only (1), 3, 1);
      Expect (Stationary (W), "p3 with two references out and two in");
      W.S (3) := Pk (2);
      Show ("p3 reworded, 'written against' NOT counted", W);
      Expect (Uncovered (W) = 4 and then Has (W, C5_Rests, 4),
              "3 affirmations owed: one per reference out of the edited "
              & "piece, one per reference in that relies on everything, "
              & "none for the one that relies on assertions (the fourth "
              & "item is p4 resting on a p3 that is not yet consistent)");
      W.F.Dec (5) := Affirm_D (3, Only (2), 1, 1);
      W.F.Dec (6) := Affirm_D (3, Only (2), 2, 1);
      Expect (Uncovered (W) = 1,
              "with 'written against' counted (the new version's own "
              & "references): 1, the dependent that relies on everything");

      Title ("P7. Q9: one record under the three standards");
      for St in Canon_Standard loop
         W := (others => <>);
         W.O := Theory (St);
         W.T (1, 1) := Claim_V (1);
         W.T (2, 1) := Claim_V (1, R (1, 1));
         W.S := [1 => Pk (1), 2 => Pk (1), others => No_Pick];
         W.F.Dec (1) := Affirm_D (2, Only (1), 1, 1);
         Put_Line ("  " & St'Image & ": two asserted claims, no evidence, "
                   & "no decisions:" & Owed (W)'Image & " owed");
         W.F.Ev (1) := Evid (1, 1, 1, 1);
         W.F.Ev (2) := Evid (2, 1, 1, 1);
         Put_Line ("  " & St'Image & ": each checked once:"
                   & Owed (W)'Image & " owed");
         W.F.Dec (2) := Admit_D (1, Only (1));
         W.F.Dec (3) := Admit_D (2, Only (1), Sound (1));
         Put_Line ("  " & St'Image & ": and each accepted:"
                   & Owed (W)'Image & " owed");
      end loop;
   end Probes;

begin
   Small_Move;
   Outline;
   Finding;
   Two_Moves (Bare, Meet => False);
   Two_Moves (Points_Assertions, Meet => False);
   Two_Moves (Reads_Assertions, Meet => False);
   Two_Moves (Bare, Meet => True);
   Intake;
   Probes;
   New_Line;
   Put_Line ("expectations:" & Checks'Image & ", failed:" & Failures'Image);
   if Failures > 0 then
      Ada.Command_Line.Set_Exit_Status (1);
   end if;
end Scenarios;
