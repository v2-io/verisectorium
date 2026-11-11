/-
  The slice in Lean 4, written the way Lean wants it.
  2026-11-11, by the Lean fork of the formal-perspectives spike (Fable 5.2).

  Run:  ~/.elan/bin/lean lean.lean      (Lean 4.35.0, core library only)
  It prints

      ["O", "T", "c", "d", "k"]          canon
      ["T.description"]                  slots promised and empty

  and checks four statements about them; exit 0 means all four hold. Two
  mutations were tried and behave as they should: asserting U is in canon is
  rejected, and un-marking the provisional flag on O's second row puts U and
  u into the printed canon.

  WHAT LEAN REACHED FOR

  1. The kind is in the type. `Segment k` is a segment of kind k, `Slot k` a
     slot for one, `Id k` the id of one. "What kind of thing fills it" is then
     not a rule anybody checks: a claim slot holding an explanation is not a
     value. Two lines near the end show the compiler refusing one.
  2. "How many" is the shape of the field: one is a `Slot`, at most one is an
     `Option (Slot _)`, any number is a `List (Slot _)`.
  3. Holding and pointing are different things in the language, as they are in
     the model. A held segment is a value *inside* its holder (it "lives in it"
     literally). A pointed-at segment is an id, looked up in the store. So a
     held piece cannot be in two places and cannot outlive its holder, with no
     rule saying so; and only pointing can form a loop.
  4. Canon is stated twice. Once as what it *is*: the smallest set containing
     the roots and closed under "is reached through a filled, non-provisional
     slot" (an inductive predicate; no number, no loop). Once as a list that is
     *computed*. A theorem says a list is exactly canon when it has the roots,
     is closed, and is sound; for this instance all three are checked.

  WHERE THE IDIOM DEPARTS FROM THE SLICE AS WORDED

  a. A fifth slot state, `empty`. U's description is not suggested, not
     promised, and not a gap ("something is missing and it is not yet known
     what": here it is known exactly what, an explanation). A field of a
     record must have *some* value, so the instance could not be written
     without deciding what an untouched required slot is.
  b. `gap` moved. A slot of a kind with named slots always knows its kind, so
     a gap ("not yet known what") can only sit where the kind is open: it is a
     row of an outline, beside the typed rows, and not a state of a typed slot.
  c. "Required" is nowhere in the types, on purpose. T with its description
     promised and unwritten has to be a value.

  WHAT WAS AWKWARD

  - An outline takes "a segment of any kind", so its rows pair a kind with a
    slot of that kind (`Row.slot k s`). Fine to write, slightly noisy to read.
  - The types refer to each other (a segment has slots, a slot holds a
    segment, an outline has rows), so they are declared together and every
    function over them is five small functions declared together.
  - Lean must see that each of those functions terminates, and what it would
    accept was narrower than I expected: a function that carried a label down
    through the slots was refused, and the same function returning labels
    upward was accepted. Two of this file's five runs went on that.
  - Checking the four statements by evaluation needed the stronger of Lean's
    two evaluators (`decide +kernel`); the default one stopped at the
    functions over the mutually declared types.
  - Ids are names here and nothing stops two pieces sharing one. Minting
    ("made once, never reused") is about history, and the slice has none.
-/

namespace Slice

/-! ## Kinds -/

inductive VKind | claim | step | explanation
  deriving DecidableEq, Repr

inductive Kind
  | veritoid (v : VKind)
  | derivedResult
  | outline
  deriving DecidableEq, Repr

abbrev Kind.claim       := Kind.veritoid .claim
abbrev Kind.step        := Kind.veritoid .step
abbrev Kind.explanation := Kind.veritoid .explanation

/-- An id knows the kind of what it names. -/
structure Id (k : Kind) where
  name : String
  deriving DecidableEq, Repr

/-- An id with its kind forgotten, for lists that mix kinds. -/
abbrev Ref := String

/-! ## Segments, slots, rows -/

mutual
  /-- A segment of kind k: a veritoid with its content, or an assembly whose
      slots are the fields its kind declares. -/
  inductive Segment : Kind → Type
    | veritoid (v : VKind) (content : String) : Segment (.veritoid v)
    | derivedResult
        (formalClaim : Slot .claim)               -- one
        (derivation  : List (Slot .step))         -- any number
        (description : Slot .explanation)         -- one
        (eli8        : Option (Slot .explanation)) -- at most one
        : Segment .derivedResult
    | outline (rows : List Row) : Segment .outline

  /-- A slot for a segment of kind k. -/
  inductive Slot : Kind → Type
    | empty     {k : Kind}                   : Slot k
    | suggested {k : Kind} (note : String)   : Slot k
    | promised  {k : Kind}                   : Slot k
    | holds     {k : Kind} (id : Id k) (seg : Segment k) (provisional : Bool := false) : Slot k
    | pointsAt  {k : Kind} (id : Id k)                   (provisional : Bool := false) : Slot k

  /-- A row of an outline: a slot of some kind, or a gap, whose kind nobody knows yet. -/
  inductive Row : Type
    | slot (k : Kind) (s : Slot k)
    | gap
end

/-! ## What a segment reaches, through filled slots not marked provisional -/

/-- One step of reach: a piece held inside, or a piece pointed at elsewhere. -/
inductive Link
  | held    (r : Ref)
  | pointed (r : Ref)
  deriving DecidableEq, Repr

def Link.ref : Link → Ref
  | .held r | .pointed r => r

mutual
  /-- Everything a segment reaches without leaving itself: what it holds, what
      those hold, and every id any of them points at. Holding is followed
      here, by structure; pointing is left as an id for the store to resolve. -/
  def Segment.links {k : Kind} : Segment k → List Link
    | .veritoid _ _ => []
    | .derivedResult fc der desc eli =>
        fc.links ++ slotsLinks der ++ desc.links ++ optLinks eli
    | .outline rows => rowsLinks rows

  def Slot.links {k : Kind} : Slot k → List Link
    | .holds id seg false => .held id.name :: seg.links
    | .pointsAt id false  => [.pointed id.name]
    | _ => []                      -- empty, suggested, promised, or provisional

  def slotsLinks {k : Kind} : List (Slot k) → List Link
    | [] => []
    | s :: ss => s.links ++ slotsLinks ss

  def optLinks {k : Kind} : Option (Slot k) → List Link
    | none => []
    | some s => s.links

  def rowsLinks : List Row → List Link
    | [] => []
    | .slot _ s :: rs => s.links ++ rowsLinks rs
    | .gap :: rs => rowsLinks rs
end

/-! ## A store, roots, canon -/

/-- A freestanding segment: it lives in the store under its own id. -/
structure Entry where
  kind : Kind
  id   : Id kind
  seg  : Segment kind

structure Verisectorium where
  store : List Entry
  roots : List Ref

/-- What the piece named r reaches in one step. A held piece is not in the
    store; what it reaches was already gathered by its holder. -/
def Verisectorium.out (V : Verisectorium) (r : Ref) : List Ref :=
  match V.store.find? (fun e => e.id.name == r) with
  | some e => e.seg.links.map Link.ref
  | none => []

/-- **Canon, as what it is.** The smallest set that has the roots and is
    closed under one step of reach. -/
inductive Canon (V : Verisectorium) : Ref → Prop
  | root {r}   : r ∈ V.roots → Canon V r
  | step {r q} : Canon V r → q ∈ V.out r → Canon V q

/-- **Canon, computed.** Add what is reached until a round adds nothing new;
    the number of rounds is the size of the store, which is read, not typed. -/
def Verisectorium.grow (V : Verisectorium) (L : List Ref) : List Ref :=
  (L.flatMap V.out).foldl (fun acc q => if acc.contains q then acc else acc ++ [q]) L

def iter {α : Type} (f : α → α) : Nat → α → α
  | 0, a => a
  | n + 1, a => iter f n (f a)

def Verisectorium.canon (V : Verisectorium) : List Ref :=
  iter V.grow V.store.length V.roots

/-- A list is closed when one step of reach from any member stays inside. -/
def Verisectorium.closed (V : Verisectorium) (L : List Ref) : Bool :=
  L.all fun r => (V.out r).all L.contains

/-- **When a list is exactly canon.** It has the roots, it is closed, and
    everything in it is in canon. For any store of any size. -/
theorem canon_exact (V : Verisectorium) (L : List Ref)
    (hroots : ∀ r, r ∈ V.roots → r ∈ L)
    (hclosed : V.closed L = true)
    (hsound : ∀ r, r ∈ L → Canon V r) :
    ∀ r, Canon V r ↔ r ∈ L := by
  intro r
  constructor
  · intro h
    induction h with
    | root h => exact hroots _ h
    | step _ hq ih =>
      simp only [Verisectorium.closed, List.all_eq_true, List.contains_iff_mem] at hclosed
      exact hclosed _ ih _ hq
  · exact hsound r

/-- The computation only ever adds pieces that are in canon. -/
theorem grow_sound (V : Verisectorium) (L : List Ref) (h : ∀ r, r ∈ L → Canon V r) :
    ∀ r, r ∈ V.grow L → Canon V r := by
  unfold Verisectorium.grow
  have key : ∀ (qs acc : List Ref), (∀ q, q ∈ qs → Canon V q) → (∀ r, r ∈ acc → Canon V r) →
      ∀ r, r ∈ qs.foldl (fun acc q => if acc.contains q then acc else acc ++ [q]) acc →
        Canon V r := by
    intro qs
    induction qs with
    | nil => intro acc _ hacc r hr; exact hacc r hr
    | cons q qs ih =>
      intro acc hqs hacc r hr
      simp only [List.foldl_cons] at hr
      refine ih _ (fun x hx => hqs x (List.mem_cons_of_mem _ hx)) ?_ r hr
      intro x hx
      split at hx
      · exact hacc x hx
      · rcases List.mem_append.mp hx with hx | hx
        · exact hacc x hx
        · rw [List.mem_singleton.mp hx]; exact hqs q List.mem_cons_self
  refine key _ L ?_ h
  intro q hq
  obtain ⟨r, hr, hqr⟩ := List.mem_flatMap.mp hq
  exact .step (h r hr) hqr

theorem canon_sound (V : Verisectorium) : ∀ r, r ∈ V.canon → Canon V r := by
  unfold Verisectorium.canon
  have key : ∀ (n : Nat) (L : List Ref), (∀ r, r ∈ L → Canon V r) →
      ∀ r, r ∈ iter V.grow n L → Canon V r := by
    intro n
    induction n with
    | zero => intro L h r hr; exact h r hr
    | succ n ih => intro L h r hr; exact ih _ (grow_sound V L h) r hr
  exact key _ _ (fun r hr => .root hr)

/-! ## Which slots are promised and empty -/

def Slot.isPromised {k : Kind} : Slot k → Bool
  | .promised => true
  | _ => false

mutual
  /-- The promised, unfilled slots in a segment, each named by where it is
      (a slot name; for a piece held inside, the held piece's name first). -/
  def Segment.promisedSlots {k : Kind} : Segment k → List String
    | .veritoid _ _ => []
    | .derivedResult fc der desc eli =>
        fc.promisedAt.map ("formal-claim" ++ ·) ++ (slotsPromised der).map ("derivation" ++ ·) ++
        desc.promisedAt.map ("description" ++ ·) ++ (optPromised eli).map ("eli8" ++ ·)
    | .outline rows => (rowsPromised rows).map ("row" ++ ·)

  /-- "" for this slot itself if it is promised; otherwise whatever is promised inside what it holds. -/
  def Slot.promisedAt {k : Kind} : Slot k → List String
    | .promised => [""]
    | .holds id seg _ => seg.promisedSlots.map (s!":{id.name}." ++ ·)
    | _ => []

  def slotsPromised {k : Kind} : List (Slot k) → List String
    | [] => []
    | s :: ss => s.promisedAt ++ slotsPromised ss

  def optPromised {k : Kind} : Option (Slot k) → List String
    | none => []
    | some s => s.promisedAt

  def rowsPromised : List Row → List String
    | [] => []
    | .slot _ s :: rs => s.promisedAt ++ rowsPromised rs
    | .gap :: rs => rowsPromised rs
end

def Verisectorium.promisedAndEmpty (V : Verisectorium) : List String :=
  V.store.flatMap fun e => e.seg.promisedSlots.map (s!"{e.id.name}." ++ ·)

/-! ## The instance -/

def c : Segment .claim :=
  .veritoid .claim "Every bounded monotone sequence of reals converges."
def d : Segment .step :=
  .veritoid .step "Take the least upper bound of the terms and show the terms come within any ε of it."
def k : Segment .explanation :=
  .veritoid .explanation "If you keep stepping forward and there is a wall you cannot pass, you end up settling somewhere at or before the wall."
def u : Segment .claim :=
  .veritoid .claim "Every Cauchy sequence of reals converges."

def T : Segment .derivedResult :=
  .derivedResult
    (formalClaim := .holds ⟨"c"⟩ c)
    (derivation  := [.holds ⟨"d"⟩ d])
    (description := .promised)
    (eli8        := some (.holds ⟨"k"⟩ k))

def U : Segment .derivedResult :=
  .derivedResult
    (formalClaim := .holds ⟨"u"⟩ u)
    (derivation  := [])
    (description := .empty)       -- "nothing else yet": see departure (a)
    (eli8        := none)

def O : Segment .outline :=
  .outline
    [ .slot .derivedResult (.pointsAt ⟨"T"⟩),
      .slot .derivedResult (.pointsAt ⟨"U"⟩ (provisional := true)),
      .slot .derivedResult (.suggested "a result about series is probably wanted here"),
      .gap ]

def V : Verisectorium where
  store := [⟨.outline, ⟨"O"⟩, O⟩, ⟨.derivedResult, ⟨"T"⟩, T⟩, ⟨.derivedResult, ⟨"U"⟩, U⟩]
  roots := ["O"]

/-! ## What it computes -/

#eval V.canon               -- ["O", "T", "c", "d", "k"]
#eval V.promisedAndEmpty    -- ["T.description"]

/-- The computed canon is the expected one. -/
theorem canon_computed : V.canon = ["O", "T", "c", "d", "k"] := by decide +kernel

/-- And that list *is* canon, by the definition and not only by the
    computation: nothing was bounded by a number somebody chose. -/
theorem canon_is (r : Ref) : Canon V r ↔ r ∈ ["O", "T", "c", "d", "k"] := by
  have h := canon_exact V V.canon (by decide +kernel) (by decide +kernel) (canon_sound V) r
  rw [canon_computed] at h
  exact h

/-- U and u are not in canon: the only slot that reaches U is provisional. -/
theorem U_not_in_canon : ¬ Canon V "U" ∧ ¬ Canon V "u" := by
  constructor <;> (intro h; have := (canon_is _).mp h; revert this; decide)

theorem promised_and_empty : V.promisedAndEmpty = ["T.description"] := by decide +kernel

/-! ## What the types refuse

    Each block below would be a compile error if the `fail_if_success` were
    removed; the line after it is the same thing with the kinds agreeing, to
    show the refusal is the kind and nothing else. -/

/-- The explanation k cannot be held in a claim slot. -/
example : True := by
  fail_if_success exact (fun (_ : Slot .claim) => trivial) (.holds ⟨"k"⟩ k)
  trivial
example : True := (fun (_ : Slot .explanation) => trivial) (.holds ⟨"k"⟩ k)

/-- A derived result cannot be built with a step where its claim goes. -/
example : True := by
  fail_if_success
    exact (fun (_ : Segment .derivedResult) => trivial)
      (.derivedResult (.holds ⟨"d"⟩ d) [] .promised none)
  trivial
example : True :=
  (fun (_ : Segment .derivedResult) => trivial) (.derivedResult (.holds ⟨"c"⟩ c) [] .promised none)

end Slice

#print axioms Slice.canon_exact
#print axioms Slice.canon_is
