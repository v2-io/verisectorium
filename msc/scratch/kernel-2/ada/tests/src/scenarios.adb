--  KERNEL-SPEC draft 4: the five invented moves of core/src, each as a
--  fork from a checkpoint that closes, and the probes for R2-R5 and
--  R9-R11. Every "ok" / "FAIL" line is an expectation stated before
--  the run.
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line;
with Vk;               use Vk;
with Vk.Model;         use Vk.Model;
with Vk.Lines;         use Vk.Lines;
with Lab;              use Lab;

procedure Scenarios is

   procedure Title (S : String) is
   begin
      New_Line;
      Put_Line ("== " & S);
   end Title;

   -------------------------------------------------------------------
   --  1. impl-a-small-move
   -------------------------------------------------------------------
   procedure Small_Move is
      T : constant Id := 1; C : constant Id := 2; E : constant Id := 3;
      U : constant Id := 4; UU : constant Id := 5;
      Sc : Scene;
      Main, Fork, Mid : Timeline := Empty_Line;
      T_Mid : Natural;
   begin
      Title ("1. A small move: a fork that closes (roots: the two documents)");
      Sc.O := Theory;
      Sc.T (T, 1) := Asm_V (2, Hold (C), Hold (E));
      Sc.T (C, 1) := Claim_V (1);
      Sc.T (C, 2) := Claim_V (2);                     --  gains H
      Sc.T (C, 3) := Claim_V (2);                     --  a dead-end draft
      Sc.T (E, 1) := Claim_V (1);
      Sc.T (U, 1) := Asm_V (2, Hold (UU));
      Sc.T (UU, 1) := Claim_V (1, R (1, C));
      Sc.T (UU, 2) := Claim_V (2, R (1, C));
      Write (Sc, Main, C, 1);  Write (Sc, Main, E, 1);
      Write (Sc, Main, T, 1);  Write (Sc, Main, UU, 1);
      Write (Sc, Main, U, 1);
      Mark (Sc, Main, T);      Mark (Sc, Main, U);
      Observe (Sc, 1, Evid (C, 1, 1, 1));
      Observe (Sc, 2, Evid (E, 1, 1, 1, R1 => Rd (C, 1, Assertions)));
      Observe (Sc, 3, Evid (UU, 1, 1, 1, R1 => Rd (C, 1)));
      Observe (Sc, 4, Evid (T, 1, 2, 1, R1 => Rd (C, 1, Assertions),
                            R2 => Rd (E, 1, Assertions)));
      Observe (Sc, 5, Evid (U, 1, 2, 1, R1 => Rd (UU, 1, Assertions)));
      Show ("checkpoint S0", Sc, Main);
      Expect (Stationary (Sc, Main), "S0 is stationary");

      Fork := Main;
      Observe (Sc, 6, Evid (C, 1, 1, 2, Result => Fails));
      Show ("the finding (it is in the base: main sees it too)", Sc, Fork);
      Expect (Has (Sc, Fork, C6_Fails, C), "c is known wrong");
      Expect (Has (Sc, Main, C6_Fails, C),
              "  and on the main line as well, with no event on it");
      Expect (Has (Sc, Fork, C5_Rests, UU), "u rests on an inconsistent c");
      Expect (not Has (Sc, Fork, C8_Slot, T)
              and then not Has (Sc, Fork, C8_Slot, U),
              "T and U are untouched: a slot needs a filler in canon, "
              & "not a consistent one");

      Write (Sc, Fork, C, 2);
      Show ("c@2 written, nothing else done", Sc, Fork);
      Expect (Has (Sc, Fork, C6_Guard, C), "the defect is presumed in c@2");
      Expect (Has (Sc, Fork, C4_Reconciled, UU),
              "u was written against c@1");
      Expect (Has (Sc, Fork, C5_Asks, UU),
              "u's check read c@1: it no longer applies (evidence has reads)");
      Expect (Has (Sc, Fork, C5_Asks, T),
              "T's whole read read c's assertion: lapsed");

      --  A dead end, and a rewind.
      Mid := Fork;  T_Mid := Sc.Clock;
      Write (Sc, Fork, C, 3);
      Observe (Sc, 11, Evid (C, 3, 1, 1));
      Fork := Rewind (Fork, T_Mid);
      Expect (St (Sc, Fork).S = St (Sc, Mid).S
              and then St (Sc, Fork).F.Dec = St (Sc, Mid).F.Dec,
              "rewind: the dead-end draft c@3 is gone from the line");
      Expect (Owed (Sc, Fork) = Owed (Sc, Mid),
              "  and the check made of it changes nothing here (R2)");

      Observe (Sc, 7, Evid (C, 2, 1, 2));              --  the answer
      Sc.B.Ev (2).Reads (1).Same := Only (2);          --  e's check carried
      Write (Sc, Fork, UU, 2);
      Observe (Sc, 8, Evid (UU, 2, 1, 1, R1 => Rd (C, 2)));
      Observe (Sc, 9, Evid (T, 1, 2, 1, R1 => Rd (C, 2, Assertions),
                            R2 => Rd (E, 1, Assertions)));
      Observe (Sc, 10, Evid (U, 1, 2, 1, R1 => Rd (UU, 2, Assertions)));
      Show ("the fork, repaired", Sc, Fork);
      Expect (Stationary (Sc, Fork), "the fork is stationary");
      Expect (not Stationary (Sc, Main),
              "main is not (the finding stands against it) until the "
              & "fork closes");
      Main := Union (Main, Fork);
      Expect (Stationary (Sc, Main), "closed: checkpoint S1 is stationary");

      --  R4: answered once.
      Fork := Main;
      Sc.T (C, 3) := Claim_V (2);
      Write (Sc, Fork, C, 3);
      Expect (not Has (Sc, Fork, C6_Guard, C),
              "R4: c reworded again later: no guard from the old finding");
      Write (Sc, Fork, C, 1);
      Expect (Has (Sc, Fork, C6_Fails, C),
              "R4: selecting c@1 again brings the finding back");
   end Small_Move;

   -------------------------------------------------------------------
   --  2. impl-an-outline-fills-in
   -------------------------------------------------------------------
   procedure Outline is
      O : constant Id := 1; D : constant Id := 2; R2 : constant Id := 4;
      Q : constant Id := 5;
      Sc : Scene;
      Main, Fork : Timeline := Empty_Line;
   begin
      Title ("2. An outline fills in (dimension 2 is 'accepted', decided)");
      Sc.O := Theory (Decided_2 => True, Ask_Outline => True);
      Sc.O.Asks (3, 1, 1) := 0;       --  this root asks acceptance only
      Sc.T (O, 1) := Asm_V (3, Hold (D));
      Sc.T (O, 2) := Asm_V (3, Hold (D), Point (R2, Provisional => True),
                            Point (Q, Provisional => True));
      Sc.T (O, 3) := Asm_V (3, Hold (D), Point (R2), Point (Q));
      Sc.T (D, 1) := Claim_V (1);
      Sc.T (D, 2) := Claim_V (1);                      --  reworded
      Sc.T (R2, 1) := Claim_V (1, R (1, D), R (1, Q));
      Sc.T (Q, 1) := Claim_V (1);                      --  the assumption
      Write (Sc, Main, D, 1);  Write (Sc, Main, O, 1);  Mark (Sc, Main, O);
      Decide (Sc, Main, 1, Admit_D (D, Only (1), 2));
      Decide (Sc, Main, 2, Admit_D (O, Only (1), 2));
      Expect (Stationary (Sc, Main), "S0 is stationary");

      Fork := Main;
      Decide (Sc, Fork, 3, Promise_D (O, 2));
      Expect (Has (Sc, Fork, C8_Slot, O), "step 1: the promise is owed");
      Expect (not Has (Sc, Fork, C5_Asks, O),
              "  O's acceptance is untouched: promising writes nothing");

      Write (Sc, Fork, Q, 1);  Write (Sc, Fork, R2, 1);
      Write (Sc, Fork, O, 2);
      Decide (Sc, Fork, 4, Admit_D (O, Only (2), 2));
      Show ("step 2: R2 drafted, in a slot flagged provisional", Sc, Fork);
      Expect (Has (Sc, Fork, C8_Slot, O) and then Uncovered (Sc, Fork) = 1,
              "step 2: the promise is still owed, and nothing inside the "
              & "draft is");

      Write (Sc, Fork, O, 3);
      Decide (Sc, Fork, 5, Admit_D (O, Only (3), 2));
      Decide (Sc, Fork, 6, Admit_D (R2, Only (1), 2));
      Decide (Sc, Fork, 7, Admit_D (Q, Only (1), 2));
      Show ("step 4: the flag removed, R2 and Q accepted", Sc, Fork);
      Expect (Stationary (Sc, Fork), "step 4: stationary; the promise kept");
      Main := Union (Main, Fork);
      Expect (Stationary (Sc, Main), "closed: S1");

      Fork := Main;
      Write (Sc, Fork, D, 2);
      Show ("step 5: D reworded", Sc, Fork);
      Expect (Has (Sc, Fork, C5_Asks, D), "step 5: D's acceptance was of D@1");
      Expect (Has (Sc, Fork, C4_Reconciled, R2) and then
              Has (Sc, Fork, C5_Rests, R2),
              "  R2 was written against D@1, and rests on a D not consistent");
      Expect (not Has (Sc, Fork, C5_Asks, R2),
              "  R2's own acceptance stands (it is of R2@1)");
      Expect (Cons (Sc, Fork) (O), "  O holds D and is untouched");
      Decide (Sc, Fork, 8, Admit_D (D, Only (2), 2));
      Decide (Sc, Fork, 9, Affirm_D (R2, Only (1), D, 2));
      Expect (Stationary (Sc, Fork), "step 6: accept D@2, affirm: stationary");
      Main := Union (Main, Fork);

      Fork := Main;
      Observe (Sc, 1, Evid (Q, 1, 1, 1, Result => Fails));
      Show ("step 7: the assumption fails", Sc, Fork);
      Expect (Has (Sc, Fork, C5_Rests, R2) and then
              not Has (Sc, Fork, C5_Asks, R2),
              "step 7: R2 is unsettled through its reference to Q, with no "
              & "word of R2 changed. (Its ACCEPTANCE is not reopened: an "
              & "accept cannot here be conditioned on Q; see the account)");
   end Outline;

   -------------------------------------------------------------------
   --  3. impl-a-finding-is-answered
   -------------------------------------------------------------------
   procedure Finding is
      C : constant Id := 1; E : constant Id := 2; O : constant Id := 5;
      Sc : Scene;
      Main, Fork : Timeline := Empty_Line;
   begin
      Title ("3. A rewording, a wrong finding and a right one");
      Sc.O := Theory;
      Sc.T (O, 1) := Asm_V (3, Point (C), Point (E));
      Sc.T (C, 1) := Claim_V (1);
      Sc.T (C, 2) := Claim_V (1);                      --  reworded
      Sc.T (E, 1) := Claim_V (1, R (2, C));
      Sc.T (E, 2) := Claim_V (2, R (2, C));            --  states H
      Sc.T (E, 3) := Claim_V (2, R (2, C));            --  a comma moved
      Write (Sc, Main, C, 1);  Write (Sc, Main, E, 1);
      Write (Sc, Main, O, 1);  Mark (Sc, Main, O);
      Observe (Sc, 1, Evid (C, 1, 1, 1));
      Observe (Sc, 2, Evid (E, 1, 1, 1));
      Expect (Stationary (Sc, Main), "S0 is stationary");

      Fork := Main;
      Write (Sc, Fork, C, 2);
      Expect (Has (Sc, Fork, C5_Asks, C), "step 1: reworded; its check lapsed");
      Expect (not Has (Sc, Fork, C4_Reconciled, E),
              "  e narrates c, relies on its assertions: unchanged");
      Sc.B.Ev (1).Same := Only (2);
      Expect (Stationary (Sc, Fork), "step 2: one same event carries the check");
      Main := Union (Main, Fork);

      Fork := Main;
      Observe (Sc, 3, Evid (C, 2, 1, 2, Result => Fails));
      Expect (Has (Sc, Fork, C6_Fails, C), "step 3: a finding against c");
      Decide (Sc, Fork, 1, Aside_D (3));
      Expect (Stationary (Sc, Fork),
              "step 4 (R5): set aside by a decision on the fork; c is "
              & "never written");
      Expect (Has (Sc, Main, C6_Fails, C),
              "  on main it still stands until the fork closes");
      Observe (Sc, 5, Evid (E, 1, 1, 2, Result => Fails));
      Write (Sc, Fork, E, 2);
      Expect (Has (Sc, Fork, C6_Guard, E), "step 5: the rewrite does not clear it");
      Observe (Sc, 6, Evid (E, 2, 1, 2));
      Expect (Stationary (Sc, Fork), "step 6: answered at the new version");
      Main := Union (Main, Fork);
      Expect (Stationary (Sc, Main), "closed");

      Fork := Main;
      Write (Sc, Fork, E, 3);
      Expect (not Has (Sc, Fork, C6_Guard, E),
              "afterwards (R4): a comma moved in e; the answered finding "
              & "asks nothing more (draft 3 owed it again at every edit)");
   end Finding;

   -------------------------------------------------------------------
   --  4. impl-two-moves-at-once, and R9
   -------------------------------------------------------------------
   type Variant is
     (Plain, Whole_Read, Reference_To_Rewritten, Slot_To_Rewritten,
      Retired_Target, Unmarked_Root, Withdrawn_Waiver);

   procedure Two_Forks (V : Variant) is
      C : constant Id := 1; U : constant Id := 2; X : constant Id := 3;
      W : constant Id := 4; O : constant Id := 5;
      Sc : Scene;
      Main, A, B, M : Timeline := Empty_Line;
   begin
      Title ("4. Two forks from one checkpoint: " & V'Image);
      Sc.O := Theory (Ask_Outline => V = Whole_Read);
      Sc.T (C, 1) := Claim_V (1);
      Sc.T (C, 2) := Claim_V (2);
      Sc.T (U, 1) := Claim_V (1, R (1, C));
      Sc.T (U, 2) := Claim_V (2, R (1, C));
      Sc.T (X, 1) := Claim_V (1);
      Sc.T (X, 2) :=
        (case V is
           when Reference_To_Rewritten => Claim_V (2, R (1, C)),
           when Retired_Target         => Claim_V (2, R (2, W)),
           when others                 => Claim_V (2));
      Sc.T (W, 1) := Claim_V (1);
      Sc.T (W, 2) := Claim_V (2);
      Sc.T (O, 1) := Asm_V (3, Point (C), Point (X), Point (U));
      Sc.T (O, 2) := Asm_V (3, Point (C), Point (X), Point (W));
      Write (Sc, Main, C, 1);  Write (Sc, Main, U, 1);
      Write (Sc, Main, X, 1);  Write (Sc, Main, W, 1);
      Write (Sc, Main, O, 1);  Mark (Sc, Main, O);
      Observe (Sc, 1, Evid (C, 1, 1, 1));
      Observe (Sc, 2, Evid (U, 1, 1, 1, R1 => Rd (C, 1)));
      Observe (Sc, 3, Evid (X, 1, 1, 1));
      Observe (Sc, 4, Evid (W, 1, 1, 1));
      if V = Whole_Read then
         Observe (Sc, 5, Evid (O, 1, 2, 1, R1 => Rd (C, 1, Assertions),
                               R2 => Rd (X, 1, Assertions)));
      end if;
      if V = Withdrawn_Waiver then
         --  x has a known small defect, waived at the checkpoint.
         Observe (Sc, 5, Evid (X, 1, 1, 2, Result => Part));
         Decide (Sc, Main, 1, Waive_D ((C6_Fails, X, 5, 0)));
      end if;
      Expect (Stationary (Sc, Main), "the checkpoint is stationary");
      A := Main;  B := Main;

      --  Fork A.
      case V is
         when Slot_To_Rewritten =>
            Write (Sc, A, O, 2);          --  bring w into canon
         when Retired_Target =>
            Retire (Sc, A, W);            --  w is not in canon; drop it
         when Unmarked_Root =>
            Unmark (Sc, A, O);
         when Withdrawn_Waiver =>
            --  A repairs x properly and withdraws the waiver.
            null;
         when others =>
            Observe (Sc, 6, Evid (C, 1, 1, 2, Result => Fails));
            Write (Sc, A, C, 2);  Write (Sc, A, U, 2);
            Observe (Sc, 7, Evid (C, 2, 1, 2));
            Observe (Sc, 8, Evid (U, 2, 1, 1, R1 => Rd (C, 2)));
            if V = Whole_Read then
               Observe (Sc, 9, Evid (O, 1, 2, 1,
                                     R1 => Rd (C, 2, Assertions),
                                     R2 => Rd (X, 1, Assertions)));
            end if;
      end case;

      --  Fork B.
      case V is
         when Slot_To_Rewritten =>
            Write (Sc, B, W, 2);          --  w is not in canon here
         when Retired_Target =>
            Write (Sc, B, X, 2);          --  x comes to narrate w
            Observe (Sc, 11, Evid (X, 2, 1, 1));
         when Unmarked_Root =>
            Write (Sc, B, X, 2);
            Observe (Sc, 11, Evid (X, 2, 1, 1));
         when Withdrawn_Waiver =>
            Write (Sc, B, U, 2);          --  unrelated work, leaning on S0
            Observe (Sc, 8, Evid (U, 2, 1, 1, R1 => Rd (C, 1)));
         when others =>
            Observe (Sc, 10, Evid (X, 1, 1, 2, Result => Fails));
            Write (Sc, B, X, 2);
            Observe (Sc, 11, Evid (X, 2, 1, 2));
            if V = Whole_Read then
               Observe (Sc, 12, Evid (O, 1, 2, 1,
                                      R1 => Rd (C, 1, Assertions),
                                      R2 => Rd (X, 2, Assertions)));
            end if;
      end case;
      if V = Withdrawn_Waiver then
         Withdraw (Sc, A, 1);
         Write (Sc, A, X, 2);
         Observe (Sc, 11, Evid (X, 2, 1, 2));
         Observe (Sc, 12, Evid (X, 2, 1, 1));
      end if;

      --  All the evidence is in the base, so each fork is read as of
      --  now, seeing the other's findings. A fork alone is the
      --  checkpoint plus its own events.
      Show ("A alone", Sc, A);
      Show ("B alone", Sc, B);
      M := Union (A, B);
      Show ("both closed", Sc, M);
      declare
         RA : constant Id_Set := Region (Sc, A, M);
         RB : constant Id_Set := Region (Sc, B, M);
         Neither : constant Id_Set :=
           [for P in Id => not RA (P) and then not RB (P)];
      begin
         Put_Line ("    the union agrees with A on " & Set_Image (RA)
                   & ", with B on " & Set_Image (RB)
                   & "; with neither on " & Set_Image (Neither));
         Expect (Stationary_On (Sc, A, RA) and then Stationary_On (Sc, B, RB),
                 "each fork is stationary on the region it shares with "
                 & "the union");
         case V is
            when Unmarked_Root =>
               Expect (Neither (X) and then Stationary (Sc, M),
                       "x is in neither region (B rewrote it; A took it "
                       & "out of canon), and yet nothing is owed: the "
                       & "theorem says where to look, not that there "
                       & "must be something there");
            when Plain | Withdrawn_Waiver =>
               Expect (Neither = [Id => False],
                       "the two regions cover everything: by the theorem "
                       & "(Vk.Merge.Forks_Compose) the union is stationary");
            when Whole_Read =>
               Expect (Neither (O) and then Has (Sc, M, C5_Asks, O),
                       "what is owed is about the outline, which is in "
                       & "neither region (Vk.Merge.Meeting_Is_Local)");
            when Reference_To_Rewritten | Retired_Target =>
               Expect (Neither (X), "what is owed is about x, in neither region");
            when Slot_To_Rewritten =>
               Expect (Neither (W), "what is owed is about w, in neither region");
         end case;
      end;
      case V is
         when Plain =>
            Expect (not Stationary (Sc, A) and then not Stationary (Sc, B),
                    "neither is stationary alone: each sees the other's "
                    & "finding, which is in the base");
            Expect (Stationary (Sc, M), "together they are (R9 holds here)");
         when Whole_Read =>
            Expect (not Stationary (Sc, M) and then Has (Sc, M, C5_Asks, O),
                    "they meet at the outline: one fact that read two parts "
                    & "(the spec's second case)");
         when Reference_To_Rewritten =>
            Expect (Has (Sc, M, C4_Reconciled, X),
                    "they meet at x's reference, written against c@1: "
                    & "NOT one of R9's two cases (no id written twice, no "
                    & "evidence that read what the other rewrote)");
            Sc.Opt.Seen_Recorded := False;
            Expect (Stationary (Sc, M),
                    "OBSERVED: if 'written against' is worked out from "
                    & "the line being read, the union says x@2 was "
                    & "written against c@2, because A's write of c is "
                    & "earlier in time than B's write of x. B never saw "
                    & "c@2. The union is stationary on an affirmation "
                    & "nobody made");
         when Slot_To_Rewritten =>
            Expect (Stationary (Sc, A) and then Stationary (Sc, B),
                    "each alone is stationary");
            Expect (Has (Sc, M, C5_Asks, W),
                    "PREDICTED: together not: A's slot brings into canon "
                    & "the w that B rewrote. NOT one of R9's two cases");
         when Retired_Target =>
            Expect (Stationary (Sc, A) and then Stationary (Sc, B),
                    "each alone is stationary");
            Expect (Has (Sc, M, C3_Resolve, X),
                    "PREDICTED: together not: B's x refers to what A "
                    & "retired. NOT one of R9's two cases");
         when Unmarked_Root =>
            Expect (Stationary (Sc, A) and then Stationary (Sc, B),
                    "each alone is stationary");
            Expect (Stationary (Sc, M),
                    "together: stationary, vacuously (nothing is in canon)");
         when Withdrawn_Waiver =>
            Expect (Stationary (Sc, A) and then Stationary (Sc, B),
                    "each alone is stationary");
            Expect (Stationary (Sc, M),
                    "together: stationary (A repaired what the waiver "
                    & "covered; B did not lean on it)");
      end case;
   end Two_Forks;

   -------------------------------------------------------------------
   --  5. impl-intake
   -------------------------------------------------------------------
   procedure Intake is
      C : constant Id := 1; I : constant Id := 2; Src : constant Id := 3;
      K4 : constant Id := 4; O : constant Id := 5;
      Sc : Scene;
      Main, Fork : Timeline := Empty_Line;
      N0 : Natural;
      function Routed (Ln : Timeline) return Boolean is
         S : constant State := St (Sc, Ln);
         Cx : constant Context := Derive (Sc.O, Sc.T, S.S, S.F);
      begin
         return Affirmed (Sc.T, S.S, S.F, Cx,
                          Consistent (Sc.O, Sc.T, S.S, S.F, S.L, Cx),
                          K4, I, Everything);
      end Routed;
   begin
      Title ("5. An audit comes in");
      Sc.O := Theory;
      Sc.T (O, 1) := Asm_V (3, Point (C), Point (I));
      Sc.T (C, 1) := Claim_V (1);
      Sc.T (I, 1) := Claim_V (1);
      Sc.T (I, 2) := Claim_V (2);                       --  citation dropped
      Sc.T (Src, 1) := Asm_V (3, Hold (K4));
      Sc.T (K4, 1) := Claim_V (0, R (2, I));
      Write (Sc, Main, C, 1);  Write (Sc, Main, I, 1);
      Write (Sc, Main, O, 1);  Mark (Sc, Main, O);
      Observe (Sc, 1, Evid (C, 1, 1, 1));
      Observe (Sc, 2, Evid (I, 1, 1, 1));
      Expect (Stationary (Sc, Main), "S0 is stationary");
      N0 := Owed (Sc, Main);

      Fork := Main;
      Write (Sc, Fork, K4, 1);  Write (Sc, Fork, Src, 1);
      Expect (Owed (Sc, Fork) = N0,
              "step 1: the source comes in under no root; nothing is owed");
      Decide (Sc, Fork, 1, Ask_D (C, 1));
      Expect (Has (Sc, Fork, C9_Raised, C),
              "step 2: a question raised on c is owed although c was "
              & "checked before (C9 now asks for evidence LATER than the "
              & "raise)");
      Observe (Sc, 3, Evid (C, 1, 1, 2));
      Expect (not Has (Sc, Fork, C9_Raised, C), "  a later check answers it");
      Decide (Sc, Fork, 2, Affirm_D (K4, Only (1), I, 1));
      Expect (Routed (Fork),
              "step 4: 'already present' said as an affirm of the chunk "
              & "against i@1 (there is still no routing decision)");
      Main := Union (Main, Fork);
      Expect (Stationary (Sc, Main), "closed");
      Fork := Main;
      Write (Sc, Fork, I, 2);
      Observe (Sc, 4, Evid (I, 2, 1, 1));
      Expect (not Routed (Fork), "step 7: i rewritten; the routing fails");
      Expect (Stationary (Sc, Fork),
              "  and nothing is owed for it: retirement is still no "
              & "constraint");
   end Intake;

   -------------------------------------------------------------------
   --  Probes
   -------------------------------------------------------------------
   procedure Probes is
      Sc : Scene;
      Main, Fork, Before : Timeline := Empty_Line;
      T0 : Natural;

      procedure Fresh is
      begin
         Sc := (others => <>);
         Main := Empty_Line;
         Sc.O := Theory;
         Sc.T (5, 1) := Asm_V (3, Point (1));
      end Fresh;
   begin
      Title ("P1. Guards by the letter: an old pass meets a new finding");
      for Mode in Guard_Mode loop
         Fresh;
         Sc.Opt.Mode := Mode;
         Sc.T (1, 1) := Claim_V (1);
         Sc.T (1, 2) := Claim_V (1);                   --  reworded
         Write (Sc, Main, 1, 1);  Write (Sc, Main, 5, 1);  Mark (Sc, Main, 5);
         Observe (Sc, 1, Evid (1, 1, 1, 1));           --  it passed, once
         Observe (Sc, 2, Evid (1, 1, 1, 1, Result => Fails));  --  same criterion
         Expect (Has (Sc, Main, C6_Fails, 1), Mode'Image & ": p1 found wrong");
         Write (Sc, Main, 1, 2);
         Sc.B.Ev (1).Same := Only (2);                 --  the old pass carried
         if Mode = Letter then
            Expect (Stationary (Sc, Main),
                    "LETTER, PREDICTED: reworded, and the pass that came "
                    & "BEFORE the finding meets its guard: stationary, the "
                    & "defect never looked at (3 events, 2 facts)");
         else
            Expect (Has (Sc, Main, C6_Guard, 1),
                    "LATER: the guard stands until something later than "
                    & "the finding answers it");
         end if;
      end loop;

      Title ("P2. Guards and rewind: a finding against a dropped version");
      for Off in Boolean loop
         Fresh;
         Sc.Opt.Off_Line_Guards := Off;
         Sc.T (1, 1) := Claim_V (1);
         Sc.T (1, 2) := Claim_V (2);                   --  the flawed draft
         Sc.T (1, 3) := Claim_V (2);                   --  the same, reworded
         Write (Sc, Main, 1, 1);  Write (Sc, Main, 5, 1);  Mark (Sc, Main, 5);
         Observe (Sc, 1, Evid (1, 1, 1, 1));
         Fork := Main;  T0 := Sc.Clock;
         Write (Sc, Fork, 1, 2);
         Observe (Sc, 2, Evid (1, 2, 1, 2, Result => Fails));
         Expect (Has (Sc, Fork, C6_Fails, 1),
                 "the draft p1@2 is found wrong on the fork");
         Fork := Rewind (Fork, T0);
         Write (Sc, Fork, 1, 3);
         Observe (Sc, 3, Evid (1, 3, 1, 1));
         if not Off then
            Expect (Stationary (Sc, Fork),
                    "AS WRITTEN, PREDICTED: rewind, write it again "
                    & "reworded: p1@2 is a version 'the line never "
                    & "selected', so no guard: stationary");
         else
            Expect (Has (Sc, Fork, C6_Guard, 1),
                    "switch: a finding against any version of the piece "
                    & "guards the line until answered once");
         end if;
      end loop;

      Title ("P2b. A finding that read something, and the thing rewritten");
      for Letter_Reading in Boolean loop
         Fresh;
         Sc.Opt.Reads_Shed := Letter_Reading;
         Sc.T (5, 1) := Asm_V (3, Point (1), Point (2));
         Sc.T (1, 1) := Claim_V (1, R (2, 2));         --  p1 narrates p2
         Sc.T (2, 1) := Claim_V (1);
         Sc.T (2, 2) := Claim_V (1);                   --  p2 reworded
         Write (Sc, Main, 2, 1);  Write (Sc, Main, 1, 1);
         Write (Sc, Main, 5, 1);  Mark (Sc, Main, 5);
         Observe (Sc, 1, Evid (1, 1, 1, 1));
         Observe (Sc, 2, Evid (2, 1, 1, 1, Same => Only (2)));
         Observe (Sc, 3, Evid (1, 1, 1, 2, Result => Fails,
                               R1 => Rd (2, 1)));      --  it read p2@1
         Expect (Has (Sc, Main, C6_Fails, 1), "p1 found wrong, by a check that read p2");
         Write (Sc, Main, 2, 2);
         if Letter_Reading then
            Expect (Stationary (Sc, Main),
                    "AS WRITTEN, PREDICTED after the first search run: "
                    & "reword p2, which the finding read. The finding no "
                    & "longer applies (its read is not as it was) and "
                    & "guards only LATER versions of p1: p1@1 is clean, "
                    & "untouched and unexamined");
         else
            Expect (Has (Sc, Main, C6_Guard, 1),
                    "as built: a finding that has stopped applying "
                    & "guards the version it was about as well");
         end if;
      end loop;

      Title ("P3. R3: going back");
      Fresh;
      Sc.T (1, 1) := Claim_V (1);
      Sc.T (1, 2) := Claim_V (2);
      Write (Sc, Main, 1, 1);  Write (Sc, Main, 5, 1);  Mark (Sc, Main, 5);
      Observe (Sc, 1, Evid (1, 1, 1, 1));
      Fork := Main;  T0 := Sc.Clock;  Before := Fork;
      Expect (Stationary (Sc, Fork), "stationary at the point");
      Write (Sc, Fork, 1, 2);
      Observe (Sc, 2, Evid (1, 2, 1, 1));              --  about the new one
      Observe (Sc, 3, Evid (1, 2, 1, 2, Result => Fails));
      Fork := Rewind (Fork, T0);
      Expect (St (Sc, Fork).S = St (Sc, Before).S,
              "after the rewind the selection is as it was");
      Expect (Stationary (Sc, Fork),
              "and it is stationary: what was learned is about p1@2, "
              & "which the line no longer has (and, as written, never had)");
      Observe (Sc, 4, Evid (1, 1, 1, 2, Result => Part));
      Expect (not Stationary (Sc, Fork),
              "a finding recorded since, about the version returned to, "
              & "is what makes a return not stationary");

      Title ("P4. R5: what a set aside can do");
      Fresh;
      Sc.T (1, 1) := Claim_V (1);
      Write (Sc, Main, 1, 1);  Write (Sc, Main, 5, 1);  Mark (Sc, Main, 5);
      Observe (Sc, 1, Evid (1, 1, 1, 1));
      Decide (Sc, Main, 1, Ask_D (1, 1));
      Observe (Sc, 2, Evid (1, 1, 1, 2, Result => Fails));
      Expect (not Has (Sc, Main, C9_Raised, 1) and then
              Has (Sc, Main, C6_Fails, 1),
              "a question is raised; a finding answers it (it is "
              & "evidence on the dimension) and is itself owed");
      Decide (Sc, Main, 2, Aside_D (2));
      Expect (not Has (Sc, Main, C6_Fails, 1) and then
              Has (Sc, Main, C9_Raised, 1),
              "set the finding aside: its item goes, and the QUESTION "
              & "comes back. Setting aside a finding can add an item");
      Decide (Sc, Main, 3, Aside_D (1));
      Expect (Has (Sc, Main, C5_Asks, 1),
              "set aside evidence that HOLDS: the warrant falls. A set "
              & "aside is not good news");

      Title ("P5. R10: canon by roots");
      Sc := (others => <>);  Main := Empty_Line;
      Sc.O := Theory;
      Sc.O.Asks (2, 1, 1) := 2;                 --  a document root asks more
      Sc.T (1, 1) := Claim_V (1);
      Sc.T (2, 1) := Claim_V (1, R (1, 1));     --  p2 rests on p1
      Sc.T (3, 1) := Claim_V (1);               --  a provisional piece
      Sc.T (4, 1) := Asm_V (2, Hold (2));                 --  document root
      Sc.T (5, 1) := Asm_V (3, Point (1), Point (2),
                            Point (3, Provisional => True));  --  outline root
      for P in Id loop
         Write (Sc, Main, P, 1);
      end loop;
      Mark (Sc, Main, 5);
      Observe (Sc, 1, Evid (1, 1, 1, 1));
      Observe (Sc, 2, Evid (2, 1, 1, 1));
      Observe (Sc, 5, Evid (4, 1, 2, 1));
      Expect (Stationary (Sc, Main), "under the outline alone: stationary");
      Mark (Sc, Main, 4);
      Show ("the document marked a root too", Sc, Main);
      Expect (Has (Sc, Main, C5_Asks, 2) and then Uncovered (Sc, Main) = 1,
              "p2 is reached by both and held to both: the document asks "
              & "validity 2 and p2 has 1");
      Observe (Sc, 3, Evid (2, 1, 1, 2));
      Show ("p2 checked by a second criterion", Sc, Main);
      Expect (Has (Sc, Main, C5_Asks, 2),
              "OBSERVED: still owed. p2 is predicated on p1, validity caps "
              & "along that, and p1 (asked only 1 by the outline) has 1: "
              & "what a root asks reaches through the cap to pieces the "
              & "root does not reach");
      Observe (Sc, 6, Evid (1, 1, 1, 2));
      Expect (Stationary (Sc, Main), "p1 checked twice as well: stationary");
      Observe (Sc, 4, Evid (3, 1, 1, 1, Result => Fails));
      Expect (Stationary (Sc, Main) and then Conditions (Sc, Main) = 1,
              "bad news against the provisional p3: no item, and one "
              & "stated condition");
      Before := Main;
      Unmark (Sc, Main, 5);
      Show ("the outline unmarked", Sc, Main);
      Expect (Has (Sc, Main, C5_Rests, 2),
              "PREDICTED: unmarking the outline ADDS an item: p1 was in "
              & "canon only through it, and p2 (still under the document) "
              & "rests on p1");

      Title ("P6. R7: is the greatest fixed point now unique?");
      Sc := (others => <>);  Main := Empty_Line;
      Sc.O := Theory;
      Sc.O.RK (2) := (Rests => True, Relies_On => Everything,
                      Caps => [False, False]);
      Sc.T (1, 1) := Claim_V (1, R (2, 2));
      Sc.T (2, 1) := Claim_V (1, R (2, 1));
      Sc.T (5, 1) := Asm_V (3, Point (1), Point (2));
      Write (Sc, Main, 1, 1);  Write (Sc, Main, 2, 1);
      Write (Sc, Main, 5, 1);  Mark (Sc, Main, 5);
      Observe (Sc, 1, Evid (1, 1, 1, 1));
      Observe (Sc, 2, Evid (2, 1, 1, 1));
      Decide (Sc, Main, 1, Affirm_D (1, Only (1), 2, 1));
      declare
         S : constant State := St (Sc, Main);
         C : constant Context := Derive (Sc.O, Sc.T, S.S, S.F);
      begin
         Expect (Stationary (Sc, Main),
                 "two claims resting on each other (by a kind that caps "
                 & "nothing): consistent together");
         Expect (Is_Fixed (Sc.O, Sc.T, S.S, S.F, S.L, C,
                           [5 => True, others => False]),
                 "NOT unique: 'neither of them' is a fixed point too");
      end;

      Title ("P7. Closing second: union, and what re-timing would do");
      Fresh;
      Sc.T (5, 1) := Asm_V (3, Point (1), Point (2));
      Sc.T (1, 1) := Claim_V (1);
      Sc.T (1, 2) := Claim_V (2);
      Sc.T (2, 1) := Claim_V (1);
      Sc.T (2, 2) := Claim_V (2);
      Write (Sc, Main, 1, 1);  Write (Sc, Main, 2, 1);
      Write (Sc, Main, 5, 1);  Mark (Sc, Main, 5);
      Observe (Sc, 1, Evid (1, 1, 1, 1));
      Observe (Sc, 2, Evid (2, 1, 1, 1));
      declare
         A, B, M, Retimed : Timeline;
      begin
         A := Main;  B := Main;
         Observe (Sc, 3, Evid (1, 1, 1, 2, Result => Fails));
         Write (Sc, A, 1, 2);
         Observe (Sc, 4, Evid (1, 2, 1, 2));           --  answered on A
         Write (Sc, B, 2, 2);                          --  B is later
         Observe (Sc, 5, Evid (2, 2, 1, 1));
         M := Union (B, A);                            --  B closed first
         Expect (Stationary (Sc, M),
                 "A closes after B, as a union of timed events: stationary");
         --  The other reading: append A's events after B's, with new
         --  times. Evidence is in the base and keeps its time.
         Retimed := B;
         Write (Sc, Retimed, 1, 2);
         Show ("A's write appended to main with a new time", Sc, Retimed);
         Expect (Has (Sc, Retimed, C6_Guard, 1),
                 "appended and re-timed: the fork was stationary and the "
                 & "main line after closing is not. The answer 'did not "
                 & "apply when recorded': by the new times p1@2 was "
                 & "written after it");
      end;
   end Probes;

begin
   Small_Move;
   Outline;
   Finding;
   for V in Variant loop
      Two_Forks (V);
   end loop;
   Intake;
   Probes;
   New_Line;
   Put_Line ("expectations:" & Checks'Image & ", failed:" & Failures'Image);
   if Failures > 0 then
      Ada.Command_Line.Set_Exit_Status (1);
   end if;
end Scenarios;
