/-
  Vk.Tiers — "as types instead of terms": how far that goes, on note 22's own
  example kind (§2.2, `derived-result`).

  Three tiers come out.
    1. Unrepresentable: no value of the type says it.
    2. Refused: a value says it, and the operation that would produce it demands
       a proof it cannot have (`Vk.M0.close`).
    3. Owed: a value says it, it is a legitimate state of work, and a computed
       proposition about it is false for now.
-/

namespace Vk.Tiers

set_option linter.unusedVariables false

/-- Kinds of content. -/
inductive K | claim | step | expl
  deriving DecidableEq, Repr

/-- An id is minted for a piece of one kind, and the kind is part of its type. -/
structure Id (k : K) where
  n : Nat
  deriving DecidableEq, Repr

/-- A slot for a piece of kind `k`. The four states of note 22 §2.2, and the
    two ways of being filled. -/
inductive Slot (Content : K → Type) (k : K)
  | suggested (note : String)
  | promised
  | gap
  | holds (content : Content k)
  | pointsAt (id : Id k)

/-- `assembly kind derived-result`, as a type. -/
structure DerivedResult (Content : K → Type) where
  formalClaim : Slot Content .claim          -- one
  derivation  : List (Slot Content .step)    -- any number
  description : Slot Content .expl           -- one
  eli8        : Option (Slot Content .expl)  -- at most one

/-! ## Tier 1: what the type makes unsayable

    "What kind of thing fills it" and "how many" are in the type. An
    explanation in the claim slot is not a state that is owed something; it is
    not a state. -/

example (Content : K → Type) (x : Content .expl) : True := by
  fail_if_success
    have _ : Slot Content .claim := Slot.holds x
  trivial

/-- Control: the same line with the kinds agreeing is accepted, so the failure
    above is the kind mismatch and nothing else. -/
example (Content : K → Type) (x : Content .expl) : Slot Content .expl := Slot.holds x

/-- Pointing at a piece of the wrong kind is unsayable too, because an id
    carries its kind. -/
example (Content : K → Type) (i : Id .step) : True := by
  fail_if_success
    have _ : Slot Content .claim := Slot.pointsAt i
  trivial

example (Content : K → Type) (i : Id .step) : Slot Content .step := Slot.pointsAt i

/-! ## Tier 3: what the type must leave sayable

    "Required" cannot be in the type. A result whose claim is promised and not
    yet written is a state the model wants (note 22: a promised slot is owed,
    not impossible), so it has to be a value. -/

def workInProgress (Content : K → Type) : DerivedResult Content where
  formalClaim := .promised
  derivation  := []
  description := .suggested "say what the claim is for"
  eli8        := none

def Slot.filled {Content : K → Type} {k : K} : Slot Content k → Bool
  | .holds _ | .pointsAt _ => true
  | _ => false

/-- Requiredness is a computed proposition about a value (condition 8). -/
def DerivedResult.complete {Content : K → Type} (r : DerivedResult Content) : Bool :=
  r.formalClaim.filled && r.description.filled

example (Content : K → Type) : (workInProgress Content).complete = false := rfl

/-! ## An ontology change is a function somebody has to write

    Add a required slot to the kind. Old values are not values of the new
    type; nothing "now owes" by itself. What makes the model's sentence true
    ("adding a required slot makes every existing segment owe something") is
    that the migration can fill the new slot with an *empty state*. -/

structure DerivedResult2 (Content : K → Type) extends DerivedResult Content where
  scope : Slot Content .expl                 -- newly required

def migrate {Content : K → Type} (r : DerivedResult Content) : DerivedResult2 Content :=
  { r with scope := .gap }

def DerivedResult2.complete {Content : K → Type} (r : DerivedResult2 Content) : Bool :=
  r.toDerivedResult.complete && r.scope.filled

/-- Every migrated result owes the new slot, whatever it was before. -/
theorem migrated_owes {Content : K → Type} (r : DerivedResult Content) :
    (migrate r).complete = false := by
  simp [migrate, DerivedResult2.complete, Slot.filled]

/-! ## Lean's own promised slot

    Lean has this three-tier structure for its own proofs, and the middle of it
    is the model's "promised". A proof may be left as `sorry`: the theorem is
    accepted, flagged, and everything built on it is traceably resting on the
    promise. -/

/-- A claim whose derivation is promised and not written. -/
theorem promised_lemma : ∀ n : Nat, n + 0 = n := by
  sorry

/-- A result predicated on it. Its own derivation is complete. -/
theorem built_on_it : (2 : Nat) + 0 = 2 := promised_lemma 2

end Vk.Tiers

/-! What the second theorem rests on: Lean computes it, nobody typed it. -/
#print axioms Vk.Tiers.built_on_it
#print axioms Vk.Tiers.migrated_owes
