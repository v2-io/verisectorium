/-
  Vk.Refusals — what Lean will and will not let "consistent" be defined as.

  Each `#guard_msgs` block pins the error Lean gives; if a later Lean accepts
  one of these definitions, or words the refusal differently, this file stops
  compiling, so the refusals are checked and not merely reported.
-/
import Vk.Fault

namespace Vk

variable {Piece : Type}

/-! ## 1. Consistency as Lean's own coinductive predicate: accepted -/

/-- The spec's sentence, as written: p is consistent when it has no violation
    of its own and everything it rests on is consistent. Greatest fixed point. -/
coinductive Cons (own : Piece → Prop) (rests : Piece → Piece → Prop) : Piece → Prop where
  | mk {p} : ¬ own p → (∀ q, rests p q → Cons own rests q) → Cons own rests p

/-- Lean's coinductive consistency and "not at fault" are the same predicate. -/
theorem cons_iff_noFault (own : Piece → Prop) (rests : Piece → Piece → Prop) (p : Piece) :
    Cons own rests p ↔ ¬ Fault own rests p := by
  constructor
  · intro hc hf
    induction hf with
    | own ho => cases hc with | mk hno _ => exact hno ho
    | via hr _ ih => cases hc with | mk _ hall => exact ih (hall _ hr)
  · intro h
    refine Cons.coinduct own rests (fun q => ¬ Fault own rests q) ?_ p h
    intro a ha
    exact (noFault_fixed own rests a).mp ha

/-! ## 2. A question in force while its piece is consistent: refused, twice -/

/- As an inductive definition of fault: "p is at fault if a question about it
   is in force, and the question is in force while p is not at fault".
   Refused by the kernel's positivity check. -/
/--
error: (kernel) arg #4 of 'Vk.FaultR.raised' has a non positive occurrence of the datatypes being declared
-/
#guard_msgs in
inductive FaultR (rests : Piece → Piece → Prop) : Piece → Prop
  | raised {p} : ¬ FaultR rests p → FaultR rests p
  | via {p q} : rests p q → FaultR rests q → FaultR rests p

/- As a coinductive definition of consistency. Refused: not monotone. -/
/--
error: Could not prove 'Vk.ConsR' to be monotone in its recursive calls:
  Cannot eliminate recursive call in
    ConsR rests a✝
-/
#guard_msgs (whitespace := lax) in
coinductive ConsR (rests : Piece → Piece → Prop) : Piece → Prop where
  | mk {p} : ¬ ConsR rests p → (∀ q, rests p q → ConsR rests q) → ConsR rests p

/-! ## 3. Two questions, each conditioned on the other piece: refused too

    `Vk.mutual_raise_both_exist` shows this one *has* fixed points (two of
    them). Lean refuses it all the same: what it asks for is monotonicity, which
    is what makes a greatest one exist, not the existence of some fixed point. -/

/--
error: Could not prove 'Vk.consMutual' to be monotone in its recursive calls:
  Cannot eliminate recursive call in
    consMutual !p
-/
#guard_msgs (whitespace := lax) in
def consMutual (p : Bool) : Prop := ¬ consMutual (!p)
coinductive_fixpoint

/-! ## 4. A waiver in force while its piece is consistent: accepted

    The recursive occurrence is positive, so Lean takes it without comment.
    `selfWaived_consistent` then shows what was accepted: a piece with a defect
    is consistent, on the strength of a waiver that holds because it is. -/

coinductive ConsW (defect : Piece → Prop) (rests : Piece → Piece → Prop) : Piece → Prop where
  | mk {p} : (defect p → ConsW defect rests p) →
             (∀ q, rests p q → ConsW defect rests q) → ConsW defect rests p

theorem selfWaived_consistent :
    ConsW (Piece := Unit) (fun _ => True) (fun _ _ => False) () := by
  refine ConsW.coinduct _ _ (fun _ => True) ?_ () trivial
  intro _ _
  exact ⟨fun _ => trivial, fun _ h => h.elim⟩

end Vk

#print axioms Vk.cons_iff_noFault
#print axioms Vk.selfWaived_consistent
