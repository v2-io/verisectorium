/-
  Vk.Fault — consistency without a state.

  This file has no pieces, versions or events in it. It is about one question
  only: what kind of definition is "p is consistent", given that the spec says
  "everything p rests on is consistent" inside it.

  Everything here is for an arbitrary type of pieces (finite or not) and an
  arbitrary `rests` relation. Nothing is bounded and nothing is decided by
  search. Proved = accepted by Lean's kernel; see the `#print axioms` lines at
  the end for what each theorem rests on.
-/

namespace Vk

variable {Piece : Type}

/-! ## 1. Fault: the inductive reading -/

/-- `Fault own rests p`: p has a violation of its own, or rests on something at fault.
    An *inductive* predicate: every fault has a finite reason. -/
inductive Fault (own : Piece → Prop) (rests : Piece → Piece → Prop) : Piece → Prop
  | own  {p}   : own p → Fault own rests p
  | via  {p q} : rests p q → Fault own rests q → Fault own rests p

/-- Reflexive-transitive closure of `rests`, written out so the file needs no library. -/
inductive Reach (rests : Piece → Piece → Prop) : Piece → Piece → Prop
  | refl {p}     : Reach rests p p
  | step {p q r} : rests p q → Reach rests q r → Reach rests p r

/-- **Fault is reachability.** p is at fault exactly when something it
    transitively rests on has a violation of its own. No fixed point is
    mentioned on the right-hand side. -/
theorem fault_iff_reach (own : Piece → Prop) (rests : Piece → Piece → Prop) (p : Piece) :
    Fault own rests p ↔ ∃ q, Reach rests p q ∧ own q := by
  constructor
  · intro h
    induction h with
    | own h => exact ⟨_, .refl, h⟩
    | via hr _ ih =>
      obtain ⟨q, hq, ho⟩ := ih
      exact ⟨q, .step hr hq, ho⟩
  · rintro ⟨q, hq, ho⟩
    induction hq with
    | refl => exact .own ho
    | step hr _ ih => exact .via hr (ih ho)

/-! ## 2. The spec's reading: a fixed point of a step -/

/-- The step the spec iterates: given a guess `C` at which pieces are
    consistent, p passes when it has no violation of its own and everything it
    rests on is in `C`. -/
def step (own : Piece → Prop) (rests : Piece → Piece → Prop)
    (C : Piece → Prop) (p : Piece) : Prop :=
  ¬ own p ∧ ∀ q, rests p q → C q

/-- "Not at fault" is a fixed point of the step. -/
theorem noFault_fixed (own : Piece → Prop) (rests : Piece → Piece → Prop) (p : Piece) :
    ¬ Fault own rests p ↔ step own rests (fun q => ¬ Fault own rests q) p := by
  constructor
  · intro h
    exact ⟨fun ho => h (.own ho), fun q hr hq => h (.via hr hq)⟩
  · rintro ⟨hno, hall⟩ hf
    cases hf with
    | own ho => exact hno ho
    | via hr hq => exact hall _ hr hq

/-- "Not at fault" is the **greatest** set that the step does not shrink:
    any `C` with `C ⊆ step C` contains no piece at fault. -/
theorem noFault_greatest (own : Piece → Prop) (rests : Piece → Piece → Prop)
    (C : Piece → Prop) (hC : ∀ p, C p → step own rests C p) :
    ∀ p, C p → ¬ Fault own rests p := by
  intro p hp hf
  induction hf with
  | own ho => exact (hC _ hp).1 ho
  | via hr _ ih => exact ih ((hC _ hp).2 _ hr)

/-! So when a piece's *own* violations do not depend on which pieces are
    consistent, the greatest fixed point the spec asks for (R7) is the
    complement of an inductive predicate, and by `fault_iff_reach` it is plain
    reachability. Existence needs no argument, and "which fixed point" has an
    answer that does not use the word. -/

/-! ## 3. The ring: other fixed points exist, and what they are -/

/-- Two pieces resting on each other, nothing wrong with either. -/
def ringRests : Bool → Bool → Prop := fun a b => a ≠ b

/-- In the ring nobody is at fault … -/
theorem ring_noFault : ∀ b, ¬ Fault (fun _ => False) ringRests b := by
  intro b h
  induction h with
  | own h => exact h
  | via _ _ ih => exact ih

/-- … and yet "nobody is consistent" is a fixed point of the step too. This is
    the non-uniqueness both builds report (Ada P6, OCaml test `R7`). -/
theorem ring_empty_fixed :
    ∀ b, (fun _ : Bool => False) b ↔ step (fun _ => False) ringRests (fun _ => False) b := by
  intro b
  constructor
  · intro h; exact h.elim
  · rintro ⟨_, hall⟩
    exact hall (!b) (by cases b <;> simp [ringRests])

/-- What the smaller fixed point says, read inductively: "at fault, because
    the other is, because I am". It is a fixed point of the *fault* step that
    is not the least one, i.e. a fault with no finite reason. -/
theorem ring_groundless (b : Bool) :
    ¬ ∃ q, Reach ringRests b q ∧ (fun _ : Bool => False) q := by
  rintro ⟨_, _, h⟩; exact h

/-! ## 4. When own violations depend on consistency -/

/-- The general step: a piece's own violations may read the guess `C`. -/
def stepDep (own : (Piece → Prop) → Piece → Prop) (rests : Piece → Piece → Prop)
    (C : Piece → Prop) (p : Piece) : Prop :=
  ¬ own C p ∧ ∀ q, rests p q → C q

/-- `own` is *antitone* in the guess: assuming more pieces consistent never
    creates a violation. A waiver that holds while something is consistent is
    of this sort. -/
def Antitone (own : (Piece → Prop) → Piece → Prop) : Prop :=
  ∀ C D : Piece → Prop, (∀ p, C p → D p) → ∀ p, own D p → own C p

/-- Knaster–Tarski for predicates, proved from nothing: if `own` is antitone,
    the greatest fixed point of the step exists. -/
def gfp (F : (Piece → Prop) → Piece → Prop) (p : Piece) : Prop :=
  ∃ C : Piece → Prop, (∀ x, C x → F C x) ∧ C p

theorem stepDep_mono {own : (Piece → Prop) → Piece → Prop} (h : Antitone own)
    (rests : Piece → Piece → Prop) (C D : Piece → Prop) (hCD : ∀ p, C p → D p) :
    ∀ p, stepDep own rests C p → stepDep own rests D p := by
  rintro p ⟨hno, hall⟩
  exact ⟨fun ho => hno (h C D hCD p ho), fun q hr => hCD _ (hall q hr)⟩

theorem gfp_fixed {own : (Piece → Prop) → Piece → Prop} (h : Antitone own)
    (rests : Piece → Piece → Prop) (p : Piece) :
    gfp (stepDep own rests) p ↔ stepDep own rests (gfp (stepDep own rests)) p := by
  have mono := stepDep_mono h rests
  have post : ∀ x, gfp (stepDep own rests) x → stepDep own rests (gfp (stepDep own rests)) x := by
    rintro x ⟨C, hC, hx⟩
    exact mono C _ (fun y hy => ⟨C, hC, hy⟩) x (hC x hx)
  constructor
  · exact post p
  · intro hp
    exact ⟨stepDep own rests (gfp (stepDep own rests)),
      fun x hx => mono _ _ post x hx, hp⟩

theorem gfp_greatest (F : (Piece → Prop) → Piece → Prop)
    (C : Piece → Prop) (hC : ∀ x, C x → F C x) : ∀ p, C p → gfp F p :=
  fun _ hp => ⟨C, hC, hp⟩

/-! ### 4a. A question conditioned on its own piece's consistency: no fixed point.
    One piece. The question is in force exactly when the piece is consistent,
    and a question in force is unanswered, so it is a violation. -/

def raiseOwn : (Unit → Prop) → Unit → Prop := fun C p => C p

theorem conditioned_raise_no_fixed_point :
    ¬ ∃ C : Unit → Prop, ∀ p, C p ↔ stepDep raiseOwn (fun _ _ => False) C p := by
  rintro ⟨C, hC⟩
  have h := hC ()
  simp only [stepDep, raiseOwn] at h
  have hn : ¬ C () := fun hc => (h.mp hc).1 hc
  exact hn (h.mpr ⟨hn, fun _ hf => hf.elim⟩)

/-- It is exactly the antitone hypothesis that fails. -/
theorem raiseOwn_not_antitone : ¬ Antitone raiseOwn := by
  intro h
  exact h (fun _ => False) (fun _ => True) (fun _ hp => hp.elim) () trivial

/-! ### 4b. Two questions, each conditioned on the *other* piece: two fixed
    points, neither containing the other, so no greatest. -/

def raiseOther : (Bool → Prop) → Bool → Prop := fun C p => C (!p)

theorem mutual_raise_fixed_points (C : Bool → Prop)
    (hC : ∀ p, C p ↔ stepDep raiseOther (fun _ _ => False) C p) :
    (C true ∧ ¬ C false) ∨ (C false ∧ ¬ C true) := by
  have ht := hC true
  have hf := hC false
  simp only [stepDep, raiseOther, Bool.not_true, Bool.not_false] at ht hf
  by_cases h : C true
  · exact .inl ⟨h, (ht.mp h).1⟩
  · exact .inr ⟨hf.mpr ⟨h, fun _ hx => hx.elim⟩, h⟩

theorem mutual_raise_both_exist :
    (∀ p, (fun b => b = true) p ↔ stepDep raiseOther (fun _ _ => False) (fun b => b = true) p) ∧
    (∀ p, (fun b => b = false) p ↔ stepDep raiseOther (fun _ _ => False) (fun b => b = false) p) := by
  constructor <;> intro p <;> cases p <;> simp [stepDep, raiseOther]

/-! ### 4c. A waiver conditioned on its own piece's consistency: antitone, so a
    greatest fixed point exists, and it is the one where the waiver holds.
    One piece with one defect; the defect is covered while the piece is consistent. -/

def waiveOwn : (Unit → Prop) → Unit → Prop := fun C p => ¬ C p

theorem waiveOwn_antitone : Antitone waiveOwn := by
  intro C D hCD p hD hC
  exact hD (hCD p hC)

/-- Both "consistent" and "not" are fixed points; the greatest says consistent.
    The piece is consistent *because it is waived because it is consistent*. -/
theorem conditioned_waiver_two_fixed_points :
    (∀ p, (fun _ : Unit => True) p ↔ stepDep waiveOwn (fun _ _ => False) (fun _ => True) p) ∧
    (∀ p, (fun _ : Unit => False) p ↔ stepDep waiveOwn (fun _ _ => False) (fun _ => False) p) := by
  constructor <;> intro p <;> simp [stepDep, waiveOwn]

/-! ## 5. The skeleton of a frame property

    If two worlds agree, on a region closed under `rests`, about own violations
    and about what rests on what, they agree there about fault. All of the
    content of the Ada build's `Frame` theorem is in showing that its fifteen
    kinds of instance each read only a named neighbourhood; this is what is
    left when that is granted, and it holds for any number of pieces. -/

theorem frame (own own' : Piece → Prop) (rests rests' : Piece → Piece → Prop)
    (R : Piece → Prop)
    (hown : ∀ p, R p → (own p ↔ own' p))
    (hrests : ∀ p q, R p → (rests p q ↔ rests' p q))
    (hclosed : ∀ p q, R p → rests p q → R q) :
    ∀ p, R p → (Fault own rests p ↔ Fault own' rests' p) := by
  have closed' : ∀ p q, R p → rests' p q → R q :=
    fun p q hp hr => hclosed p q hp ((hrests p q hp).mpr hr)
  intro p hp
  constructor
  · intro h
    induction h with
    | own ho => exact .own ((hown _ hp).mp ho)
    | via hr _ ih => exact .via ((hrests _ _ hp).mp hr) (ih (hclosed _ _ hp hr))
  · intro h
    induction h with
    | own ho => exact .own ((hown _ hp).mpr ho)
    | via hr _ ih => exact .via ((hrests _ _ hp).mpr hr) (ih (closed' _ _ hp hr))

/-- Two forks, the frame applied twice: if the merged world agrees with fork A
    on region RA and with fork B on region RB, the regions cover everything,
    and each fork is fault-free on its own region, the merge is fault-free. -/
theorem forks_compose
    (ownA ownB ownM : Piece → Prop) (restsA restsB restsM : Piece → Piece → Prop)
    (RA RB : Piece → Prop)
    (cover : ∀ p, RA p ∨ RB p)
    (hA : ∀ p, RA p → (ownM p ↔ ownA p)) (hA' : ∀ p q, RA p → (restsM p q ↔ restsA p q))
    (cA : ∀ p q, RA p → restsM p q → RA q)
    (hB : ∀ p, RB p → (ownM p ↔ ownB p)) (hB' : ∀ p q, RB p → (restsM p q ↔ restsB p q))
    (cB : ∀ p q, RB p → restsM p q → RB q)
    (okA : ∀ p, RA p → ¬ Fault ownA restsA p) (okB : ∀ p, RB p → ¬ Fault ownB restsB p) :
    ∀ p, ¬ Fault ownM restsM p := by
  intro p hf
  cases cover p with
  | inl h => exact okA p h ((frame ownM ownA restsM restsA RA hA hA' cA p h).mp hf)
  | inr h => exact okB p h ((frame ownM ownB restsM restsB RB hB hB' cB p h).mp hf)

/-! ## 6. Polarity: the skeleton of "good news does no harm"

    Fault only grows when own violations grow or more rests on more. So if a
    piece of news can only *remove* own violations and changes nothing about
    what rests on what, it cannot put anything at fault. -/

theorem fault_mono (own own' : Piece → Prop) (rests rests' : Piece → Piece → Prop)
    (ho : ∀ p, own p → own' p) (hr : ∀ p q, rests p q → rests' p q) :
    ∀ p, Fault own rests p → Fault own' rests' p := by
  intro p h
  induction h with
  | own h => exact .own (ho _ h)
  | via h _ ih => exact .via (hr _ _ h) ih

end Vk

/-! ## What each theorem rests on -/
#print axioms Vk.fault_iff_reach
#print axioms Vk.noFault_fixed
#print axioms Vk.noFault_greatest
#print axioms Vk.ring_empty_fixed
#print axioms Vk.gfp_fixed
#print axioms Vk.conditioned_raise_no_fixed_point
#print axioms Vk.mutual_raise_fixed_points
#print axioms Vk.conditioned_waiver_two_fixed_points
#print axioms Vk.frame
#print axioms Vk.forks_compose
#print axioms Vk.fault_mono
