/-
  Vk.Story — note 22 §4.3, row by row, through `Vk.Model`.

  The frontiers were first printed with `#eval` (`runs/04-story-frontiers-printed.log`),
  read against note 22's column, and then pinned here as statements the kernel checks.
-/
import Vk.Model

namespace Vk.Story
open Vk.M0

inductive Pc | O | T | U | c | d | e | k | u
  deriving DecidableEq, Repr

inductive Cr | valid | whole | caseX
  deriving DecidableEq, Repr

open Pc Cr

/-- Versions: c1 = 1, c1′ = 10, c2 = 2; d1 = 1, d1′ = 10, d2 = 2, d3 = 3; and so on. -/
def W : Written Pc Cr where
  kind  := fun | c | u => .claim | T | U => .result | O => .outline | _ => .other
  pred  := fun p _ => match p with | u => [c] | _ => []
  slots := fun p _ => match p with
    | O => [⟨T, false⟩, ⟨U, false⟩]
    | T => [⟨c, false⟩, ⟨d, false⟩, ⟨e, false⟩, ⟨k, false⟩]
    | U => [⟨u, false⟩]
    | _ => []
  inner := fun | T => [(e, c), (k, e)] | _ => []
  valid := valid
  whole := whole
  fuel  := 8

def ev (id time : Nat) (subj : Pc) (ver : Nat) (crit : Cr) (o : Outcome) (reads : List (At Pc)) :
    Evidence Pc Cr := ⟨id, time, subj, ver, crit, o, reads⟩

def E1  := ev 1  3   c 1  valid .holds [(d, 1)]
def E2  := ev 2  3   u 1  valid .holds [(c, 1)]
def E3  := ev 3  4   T 1  whole .holds [(c, 1), (d, 1), (e, 1), (k, 1)]
def E4  := ev 4  4   U 1  whole .holds [(u, 1)]
def E5  := ev 5  510 c 1  caseX .fails []
def E6  := ev 6  541 c 10 valid .holds [(d, 10)]
def E7  := ev 7  660 c 2  valid .holds [(d, 2)]
def E8  := ev 8  661 c 2  caseX .holds []
def E9  := ev 9  720 c 2  valid .holds [(d, 3)]
def E10 := ev 10 781 u 2  valid .holds [(c, 2)]
def E11 := ev 11 840 T 1  whole .holds [(c, 2), (d, 3), (e, 1), (k, 2)]
def E12 := ev 12 841 U 1  whole .holds [(u, 2)]

/-- Row 0: S0. -/
def row0 : State Pc Cr where
  line := [ .write 1 c 1 [], .write 1 d 1 [], .write 1 e 1 [], .write 1 k 1 [],
            .write 1 u 1 [(c, 1)], .write 1 T 1 [], .write 1 U 1 [], .write 1 O 1 [],
            .markRoot 1 O, .affirm 2 (e, 1) (c, 1), .affirm 2 (k, 1) (e, 1) ]
  base := [E1, E2, E3, E4]

/-- Row 1, 08:30: the finding. No event on any line. -/
def row1 := learn row0 E5
/-- Row 2, 09:00: the first repair, on a fork, and B's check of it. -/
def row2 := learn (act (act row1 (.write 540 c 10 [])) (.write 540 d 10 [])) E6
/-- Row 3, 10:00: rewind to where the fork stood at 08:30. -/
def row3 := rewind row2 510
/-- Row 4, 10:30: the second repair. `kAgainst` is what k2's write records
    having been made beside: the story does not say, so it is a parameter. -/
def row4' (kAgainst : List (At Pc)) :=
  act (act (act (act row3 (.write 630 c 2 [])) (.write 630 d 2 [])) (.write 630 k 2 kAgainst))
    (.affirm 630 (e, 1) (c, 2))
def after11   (r4 : State Pc Cr) := learn (learn r4 E7) E8
def after1130 (r4 : State Pc Cr) := act (after11 r4) (.write 690 d 3 [])
def after12   (r4 : State Pc Cr) := learn (after1130 r4) E9
def after13   (r4 : State Pc Cr) := learn (act (after12 r4) (.write 780 u 2 [(c, 2)])) E10
def after14   (r4 : State Pc Cr) := learn (learn (after13 r4) E11) E12

/-- Reading A: k2's write counts as having been made beside e1. -/
def row4 := row4' [(e, 1)]
def row5 := after11 row4
def row6 := after1130 row4
def row7 := after12 row4
def row8 := after13 row4
def row9 := after14 row4
/-- Reading B, the letter of the story: nothing says k2 was looked at beside e1. -/
def row9B := after14 (row4' [])

/-! ## The frontier at every row, pinned.

    Each `example` is checked by evaluation in Lean's kernel (`decide`), not by
    the compiler. Beside each: note 22's own words for that row. -/

/-- S0. "empty" -/
example : frontier W row0 = [] := by decide

/-- 08:30. "c1 is known wrong. u1 rests on it." -/
example : frontier W row1 = [.finding c 5, .restsOnFault u c] := by decide

/-- 09:00, the first repair. Note 22: "c1′ is fine. But u1 needs the stronger
    conclusion." The conditions say more: c1′ is *not* fine, since the auditor's
    case was found in c1 and has not been looked for in c1′ (the note's own rule
    in §3.3); e1 has not been looked at beside c1′; T has not been read whole. -/
example : frontier W row2 =
    [.unasked T whole, .notTogether T e c, .guard c 5,
     .unreconciled u c, .unasked u valid, .restsOnFault u c] := by decide

/-- 10:00, after the rewind. "As at 08:30." Exactly: the frontier is the one
    of row 1, though the base now also holds E6. -/
example : frontier W row3 = frontier W row1 := by decide
example : row3.base = row1.base ++ [E6] := by decide
example : row3.line = row1.line := by decide

/-- 10:30, the second repair. "c2 has not been checked. e1 has been looked at
    against c2. T has not been read whole as it now is. u1 was written against
    c1." All four are here. Two more the note does not list: the guard (the
    auditor's case has not yet been looked for in c2), and u's check, which
    read c1. -/
example : frontier W row4 =
    [.unasked T whole, .guard c 5, .unasked c valid,
     .unreconciled u c, .unasked u valid, .restsOnFault u c] := by decide

/-- 11:00. "T's whole read; u1." -/
example : frontier W row5 = [.unasked T whole, .unreconciled u c, .unasked u valid] := by decide

/-- 11:30, d3 written. "B's 11:00 evidence read d2 … c2 is unchecked again." -/
example : frontier W row6 =
    [.unasked T whole, .unasked c valid, .unreconciled u c, .unasked u valid,
     .restsOnFault u c] := by decide

/-- 12:00. "T's whole read; u1." -/
example : frontier W row7 = [.unasked T whole, .unreconciled u c, .unasked u valid] := by decide

/-- 13:00. "Whole reads of T and U." -/
example : frontier W row8 = [.unasked T whole, .unasked U whole] := by decide

/-- 14:00. "Empty. S1." -/
example : frontier W row9 = [] := by decide

/-! ## Checkpoints -/

/-- S0 and S1 exist as checkpoints: each carries its proof. -/
def S0 : Checkpoint W := close W row0 (by decide)
def S1 : Checkpoint W := close W row9 (by decide)

/-- At 13:00 the fork cannot be closed: no proof exists to hand to `close`. -/
theorem cannot_close_at_13 : ¬ Stationary W row8 := by decide

/-- A checkpoint's proof is about the state it was built from. S0 with the
    08:30 finding in the base is a different state, and it is not stationary:
    the finding is evidence, it is in the base, and no line event was needed
    (the Ada account's G5). `S0` itself is still a checkpoint. -/
theorem S0_after_the_finding : ¬ Stationary W (learn S0.state E5) := by decide

/-- By the letter of the story, S1 is not reached. Nothing in §4.3 says k2 was
    looked at beside e1, and the kind declares that k depends on e. If k2's
    write does not count as having been made beside e1, one item is left at
    14:00 and the fork cannot close. -/
example : frontier W row9B = [.notTogether T k e] := by decide

/-! ## Going back loses the work and not what was learned -/

/-- After 12:00, abandon everything since 08:30 and write c2, d3 and k2 again.
    Nothing is checked again: E8 (the auditor's case) and E9 (c2 by way of d3)
    are in the base and apply at once. What is owed is what was owed at 12:00. -/
def replay : State Pc Cr :=
  act (act (act (act (rewind row7 510) (.write 900 c 2 [])) (.write 900 d 3 []))
    (.write 900 k 2 [(e, 1)])) (.affirm 900 (e, 1) (c, 2))

example : (rewind row7 510).line = row1.line := by decide
example : frontier W replay = frontier W row7 := by decide

/-! ## The frontier is not monotone in the record

    More on record can mean more owed. So "owed" cannot be read as "provable
    from what is recorded": adding a hypothesis never unproves anything, and
    adding the 08:30 finding un-stations S0. -/
theorem more_record_can_owe_more :
    ¬ (∀ (s : State Pc Cr) (g : Evidence Pc Cr), Stationary W s → Stationary W (learn s g)) := by
  intro h
  exact S0_after_the_finding (h S0.state E5 S0.stationary)

/-! ## What the checkpoints rest on -/
#print axioms S0
#print axioms S1
#print axioms cannot_close_at_13
#print axioms more_record_can_owe_more

end Vk.Story
