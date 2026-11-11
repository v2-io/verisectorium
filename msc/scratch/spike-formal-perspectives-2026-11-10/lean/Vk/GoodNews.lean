/-
  Vk.GoodNews — "good news does no harm" (the spec's R6), proved for M0.

  For every type of pieces and criteria, every ontology and version table of
  M0's shape, every state (a line and a base of any length), and every piece of
  evidence that *holds*: recording it puts nothing on the frontier that was not
  already there.

  What this is and is not. It is a proof for unboundedly many pieces, which
  neither build gives (the Ada proof is for every ontology of bounded tables;
  the OCaml result is a search). It is about M0, which is far smaller than the
  spec: no warrant levels, so no `read_as` whose monotonicity would be a
  hypothesis, and no `same` events, so the builds' second condition does not
  arise. It shows the *shape* of the argument at any size, not R6 itself.
-/
import Vk.Model

namespace Vk.M0

set_option linter.unusedSectionVars false

variable {P C : Type} [DecidableEq P] [DecidableEq C]

/-! ## Recording evidence changes nothing that is read from the line -/

@[simp] theorem learn_line (s : State P C) (g : Evidence P C) : (learn s g).line = s.line := rfl
@[simp] theorem learn_base (s : State P C) (g : Evidence P C) : (learn s g).base = s.base ++ [g] := rfl
@[simp] theorem sel_learn (s : State P C) (g : Evidence P C) (p : P) : sel (learn s g) p = sel s p := rfl
@[simp] theorem selAt_learn (s : State P C) (g : Evidence P C) (a : At P) :
    selAt (learn s g) a = selAt s a := rfl
@[simp] theorem writtenAgainst_learn (s : State P C) (g : Evidence P C) (p : P) :
    writtenAgainst (learn s g) p = writtenAgainst s p := rfl
@[simp] theorem everWritten_learn (s : State P C) (g : Evidence P C) (p : P) (v : Nat) :
    everWritten (learn s g) p v = everWritten s p v := rfl
@[simp] theorem isSetAside_learn (s : State P C) (g : Evidence P C) (i : Nat) :
    isSetAside (learn s g) i = isSetAside s i := rfl
@[simp] theorem affirmed_learn (s : State P C) (g : Evidence P C) (a b : At P) :
    affirmed (learn s g) a b = affirmed s a b := rfl
@[simp] theorem waived_learn (s : State P C) (g : Evidence P C) (i : Item P C) :
    waived (learn s g) i = waived s i := rfl
@[simp] theorem applies_learn (s : State P C) (g e : Evidence P C) :
    applies (learn s g) e = applies s e := rfl
@[simp] theorem preds_learn (W : Written P C) (s : State P C) (g : Evidence P C) (p : P) :
    preds W (learn s g) p = preds W s p := rfl
@[simp] theorem fill_learn (W : Written P C) (s : State P C) (g : Evidence P C) (a : P) :
    fill W (learn s g) a = fill W s a := rfl
/-- **Canon is read from the line alone.** No evidence, good or bad, moves a
    piece in or out of it. -/
@[simp] theorem canon_learn (W : Written P C) (s : State P C) (g : Evidence P C) :
    canon W (learn s g) = canon W s := rfl

/-! ## Three things only become more true as evidence is added -/

theorem together_mono (s : State P C) (g : Evidence P C) (x y : P)
    (h : together s x y = true) : together (learn s g) x y = true := by
  unfold together at h ⊢
  simp only [sel_learn]
  split <;> simp_all [List.any_append]
  rcases h with h | h <;> simp [h]

theorem answered_mono (s : State P C) (g f : Evidence P C)
    (h : answered s f = true) : answered (learn s g) f = true := by
  unfold answered at h ⊢
  simp only [learn_base, List.any_append, applies_learn, Bool.or_eq_true]
  exact Or.inl h


theorem not_together_anti (s : State P C) (g : Evidence P C) (x y : P)
    (h : together (learn s g) x y = false) : together s x y = false := by
  cases ht : together s x y with
  | false => rfl
  | true => rw [together_mono s g x y ht] at h; cases h

theorem not_answered_anti (s : State P C) (g f : Evidence P C)
    (h : answered (learn s g) f = false) : answered s f = false := by
  cases ht : answered s f with
  | false => rfl
  | true => rw [answered_mono s g f ht] at h; cases h

/-! ## What the root asks -/

theorem ite_sub {α : Type} (a b : Bool) (i x : α)
    (h : i ∈ if (a || b) = true then [] else [x]) : i ∈ if a = true then [] else [x] := by
  cases a <;> cases b <;> simp_all

theorem asks_sub (W : Written P C) (s : State P C) (g : Evidence P C) (p : P) (i : Item P C)
    (h : i ∈ asks W (learn s g) p) : i ∈ asks W s p := by
  unfold asks at h ⊢
  simp only [learn_base, List.any_append, applies_learn, fill_learn] at h
  cases hk : W.kind p <;> simp only [hk] at h ⊢
  · exact ite_sub _ _ _ _ h
  · exact ite_sub _ _ _ _ h
  · exact h
  · exact h

/-! ## A piece's own violations only shrink -/

theorem own_sub (W : Written P C) (s : State P C) (g : Evidence P C) (hg : g.outcome = .holds)
    (cn : List P) (p : P) (i : Item P C)
    (h : i ∈ own W (learn s g) cn p) : i ∈ own W s cn p := by
  unfold own at h ⊢
  simp only [List.mem_filter, List.mem_append, List.mem_map, List.mem_filterMap,
    waived_learn, preds_learn, sel_learn, learn_base, learn_line, applies_learn,
    isSetAside_learn, everWritten_learn] at h ⊢
  obtain ⟨h, hw⟩ := h
  refine ⟨?_, hw⟩
  rcases h with (((((((h | h) | h) | h) | h) | h) | h) | h)
  · -- 1, dangling: read from the line
    exact .inl (.inl (.inl (.inl (.inl (.inl (.inl h))))))
  · -- 2, unreconciled: looked-at-together only becomes more true
    obtain ⟨a, ⟨ha, hc⟩, rfl⟩ := h
    simp only [Bool.and_eq_true, Bool.not_eq_true'] at hc
    refine .inl (.inl (.inl (.inl (.inl (.inl (.inr ⟨a, ⟨ha, ?_⟩, rfl⟩))))))
    simp [hc.1, not_together_anti s g p a hc.2]
  · -- 4, a finding applies: the new evidence holds, so it is not one
    obtain ⟨a, ⟨hm, hc⟩, rfl⟩ := h
    refine .inl (.inl (.inl (.inl (.inl (.inr ⟨a, ⟨?_, hc⟩, rfl⟩)))))
    rcases hm with hm | hm
    · exact hm
    · simp only [List.mem_singleton] at hm
      subst hm
      simp [hg] at hc
  · -- 4, a guard: answered only becomes more true
    obtain ⟨a, ⟨hm, hc⟩, rfl⟩ := h
    simp only [Bool.and_eq_true, Bool.not_eq_true'] at hc
    obtain ⟨⟨⟨⟨h1, h2⟩, h3⟩, h4⟩, h5⟩ := hc
    refine .inl (.inl (.inl (.inl (.inr ⟨a, ⟨?_, ?_⟩, rfl⟩))))
    · rcases hm with hm | hm
      · exact hm
      · simp only [List.mem_singleton] at hm
        subst hm
        simp [hg] at h1
    · simp [h1, h2, h3, h4, not_answered_anti s g a h5]
  · -- 5, what the root asks
    exact .inl (.inl (.inl (.inr (asks_sub W s g p i h))))
  · -- 5, rests outside canon: read from the line
    exact .inl (.inl (.inr h))
  · -- 6, inner dependencies
    obtain ⟨a, ⟨ha, hc⟩, rfl⟩ := h
    simp only [Bool.not_eq_true'] at hc
    refine .inl (.inr ⟨a, ⟨ha, ?_⟩, rfl⟩)
    simp [not_together_anti s g a.1 a.2 hc]
  · -- 9, questions: answered only becomes more true
    obtain ⟨a, ha, hm⟩ := h
    refine .inr ⟨a, ha, ?_⟩
    cases a with
    | raise t q c =>
      simp only [List.any_append, Bool.not_or, Bool.and_eq_true, Bool.not_eq_true'] at hm ⊢
      split at hm
      · rename_i hc
        rw [if_pos (show _ ∧ _ from ⟨hc.1, by simpa using hc.2.1⟩)]
        exact hm
      · cases hm
    | _ => cases hm

/-! ## Fault only shrinks, and so does the frontier -/

theorem faultStep_sub (W : Written P C) (s : State P C) (g : Evidence P C) (hg : g.outcome = .holds)
    (cn F F' : List P) (hF : ∀ q, q ∈ F' → q ∈ F) :
    ∀ q, q ∈ faultStep W (learn s g) cn F' → q ∈ faultStep W s cn F := by
  intro q hq
  unfold faultStep at hq ⊢
  simp only [List.mem_filter, Bool.or_eq_true, preds_learn, List.any_eq_true,
    List.contains_iff_mem, Bool.not_eq_true', List.isEmpty_eq_false_iff_exists_mem] at hq ⊢
  obtain ⟨hc, h⟩ := hq
  refine ⟨hc, ?_⟩
  rcases h with (h | ⟨i, hi⟩) | ⟨r, hr, hrF⟩
  · exact .inl (.inl (hF q h))
  · exact .inl (.inr ⟨i, own_sub W s g hg cn q i hi⟩)
  · exact .inr ⟨r, hr, hF r hrF⟩

theorem iter_sub (W : Written P C) (s : State P C) (g : Evidence P C) (hg : g.outcome = .holds)
    (cn : List P) : ∀ (n : Nat) (F F' : List P), (∀ q, q ∈ F' → q ∈ F) →
    ∀ q, q ∈ iter (faultStep W (learn s g) cn) n F' → q ∈ iter (faultStep W s cn) n F := by
  intro n
  induction n with
  | zero => intro F F' hF q hq; exact hF q hq
  | succ n ih =>
    intro F F' hF q hq
    exact ih _ _ (faultStep_sub W s g hg cn F F' hF) q hq

theorem faulty_sub (W : Written P C) (s : State P C) (g : Evidence P C) (hg : g.outcome = .holds) :
    ∀ q, q ∈ faulty W (learn s g) → q ∈ faulty W s := by
  intro q hq
  unfold faulty at hq ⊢
  simp only [canon_learn] at hq
  exact iter_sub W s g hg (canon W s) W.fuel [] [] (fun _ h => h) q hq

/-- **Good news does no harm.** Recording evidence that holds puts nothing on
    the frontier that was not already there. For every type of pieces, every
    ontology and version table of M0's shape, and every state. -/
theorem good_news (W : Written P C) (s : State P C) (g : Evidence P C) (hg : g.outcome = .holds) :
    ∀ i, i ∈ frontier W (learn s g) → i ∈ frontier W s := by
  intro i hi
  unfold frontier at hi ⊢
  simp only [List.mem_flatMap, canon_learn, List.mem_append, List.mem_filter, List.mem_map,
    preds_learn, waived_learn, List.contains_iff_mem] at hi ⊢
  obtain ⟨p, hp, h⟩ := hi
  refine ⟨p, hp, ?_⟩
  rcases h with h | ⟨⟨q, ⟨hq, hF⟩, rfl⟩, hw⟩
  · exact .inl (own_sub W s g hg (canon W s) p i h)
  · exact .inr ⟨⟨q, ⟨hq, faulty_sub W s g hg q hF⟩, rfl⟩, hw⟩

/-- So a checkpoint stays stationary under any amount of good news. -/
theorem stationary_good_news (W : Written P C) (s : State P C) (g : Evidence P C)
    (hg : g.outcome = .holds) (h : Stationary W s) : Stationary W (learn s g) := by
  unfold Stationary at h ⊢
  cases hf : frontier W (learn s g) with
  | nil => rfl
  | cons i rest =>
    have := good_news W s g hg i (by rw [hf]; exact List.mem_cons_self)
    rw [h] at this
    cases this

/-! The hypothesis `holds` is needed: `Vk.Story.S0_after_the_finding` is a
    stationary state that one piece of evidence that *fails* makes not so. -/

/-- A rewind does not touch the base: what was learned is still there. -/
theorem rewind_keeps_base (s : State P C) (t : Nat) : (rewind s t).base = s.base := rfl

end Vk.M0

#print axioms Vk.M0.good_news
#print axioms Vk.M0.stationary_good_news
