/-
  Vk.View — what "these two versions are the same, for this evidence" is, as a type.

  Note 22 §3.3: "there is no 'lapsing' and no 'carrying' as things that happen.
  There is evidence about versions, and evidence that two versions do not differ
  in what matters." This file asks what that sentence is when evidence is a
  family of types indexed by what it is about.

  A version here is its content (`V` is the type of contents a piece could
  have), as in core's "the hash of its normalized content".
-/

namespace Vk.View

/-- A way of looking at a version: what a particular reading could see of it. -/
structure Lens (V : Type) where
  Obs : Type
  obs : V → Obs

variable {V : Type}

/-- Evidence is about *what was seen*, not about the version it was seen in. -/
structure Found (L : Lens V) (seen : L.Obs) where
  holds : Bool

/-- Evidence found at version v. -/
abbrev Found.at (L : Lens V) (v : V) := Found L (L.obs v)

/-- **Applying is having the same type.** If v and w look the same through the
    lens, evidence found at v *is* evidence at w: not carried, not copied. -/
theorem same_type (L : Lens V) {v w : V} (h : L.obs v = L.obs w) :
    Found.at L v = Found.at L w := congrArg (Found L) h

def carry (L : Lens V) {v w : V} (h : L.obs v = L.obs w) (e : Found.at L v) : Found.at L w :=
  cast (same_type L h) e

/-- Bad news is carried exactly as good news is. The type has no way to ask
    which it is. (Both builds: "saying two versions are the same carries bad
    news forward as readily as good.") -/
theorem carry_keeps_outcome (L : Lens V) {v w : V} (h : L.obs v = L.obs w) (e : Found.at L v) :
    (carry L h e).holds = e.holds := by
  have key : ∀ (a b : L.Obs) (hab : a = b) (x : Found L a),
      (cast (congrArg (Found L) hab) x).holds = x.holds := by
    intro a b hab x; subst hab; rfl
  exact key _ _ h e

/-! ## Four lenses that the model has under four different names -/

/-- Reads only that the thing exists. Every version looks the same: evidence
    that read a filler this way never stops applying when the filler is
    rewritten. (The spec's "relies on existence only"; why two repairs under
    one outline do not meet.) -/
def existence : Lens V := ⟨Unit, fun _ => ()⟩

theorem existence_never_lapses (v w : V) : (existence (V := V)).obs v = existence.obs w := rfl

/-- Reads everything. No two different versions look the same. -/
def everything : Lens V := ⟨V, id⟩

theorem everything_lapses_on_any_change {v w : V} (h : (everything (V := V)).obs v = everything.obs w) :
    v = w := h

/-- Reads the content after a normalization the kind declares (a reflow, a
    renumbering). Sameness is *computed*: nobody has to say it. (core's
    «veritoid»: "a reflow mints nothing".) -/
def normalized (norm : V → V) : Lens V := ⟨V, norm⟩

/-- Reads the content up to a relation that somebody has *attested*: the
    recorded `same` facts for this evidence. The observation type is Lean's
    primitive quotient. -/
def attested (same : V → V → Prop) : Lens V := ⟨Quot same, Quot.mk same⟩

/-- One recorded `same` fact makes the two versions one observation. -/
theorem attested_same {same : V → V → Prop} {v w : V} (h : same v w) :
    (attested same).obs v = (attested same).obs w := Quot.sound h

/-- It runs backwards with nothing more recorded … -/
theorem attested_symm {same : V → V → Prop} {v w : V} (h : same v w) :
    (attested same).obs w = (attested same).obs v := (Quot.sound h).symm

/-- … and chains with nothing more recorded. The spec's "reachable by same
    events" is not an extra rule; it is what a quotient is. -/
theorem attested_trans {same : V → V → Prop} {v w x : V} (h₁ : same v w) (h₂ : same w x) :
    (attested same).obs v = (attested same).obs x := (Quot.sound h₁).trans (Quot.sound h₂)

/-! ## Recording more sameness, and taking some back -/

/-- When more `same` facts are recorded, what was one observation stays one:
    there is a map from the old observations to the new, and it commutes with
    looking. So evidence already carried stays carried. -/
def coarsen {same same' : V → V → Prop} (h : ∀ v w, same v w → same' v w) :
    Quot same → Quot same' :=
  Quot.lift (Quot.mk same') (fun v w hvw => Quot.sound (h v w hvw))

theorem coarsen_obs {same same' : V → V → Prop} (h : ∀ v w, same v w → same' v w) (v : V) :
    coarsen h ((attested same).obs v) = (attested same').obs v := rfl

/-- Setting a `same` fact aside goes the other way, and there the map need not
    exist. With versions `false` and `true` made the same and then not: any
    function back from the one observation to the two would have to send it to
    both. So evidence that had been carried is not "uncarried" by some rule; it
    is simply evidence about an observation that no longer is one. -/
theorem no_way_back :
    ¬ ∃ f : Quot (fun (_ _ : Bool) => True) → Quot (fun (_ _ : Bool) => False),
        ∀ b, f (Quot.mk _ b) = Quot.mk _ b := by
  rintro ⟨f, hf⟩
  have h : (Quot.mk (fun (_ _ : Bool) => False) true) = Quot.mk _ false := by
    rw [← hf true, ← hf false]
    exact congrArg f (Quot.sound trivial)
  -- the two classes of the discrete quotient are told apart by reading the Bool back
  have := congrArg (Quot.lift id (fun _ _ (h : False) => h.elim)) h
  simp at this

end Vk.View

#print axioms Vk.View.same_type
#print axioms Vk.View.carry_keeps_outcome
#print axioms Vk.View.attested_trans
#print axioms Vk.View.no_way_back
