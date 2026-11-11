/-
  Vk.Model — M0 (`../01-common-reading.md`) as a computed function.

  Recorded things are data. Everything said about how anything stands is a
  function of that data, and a checkpoint is a value that cannot be built
  without a proof that its frontier is empty.

  Departures from M0, all cuts: no `same` events (they are looked at on their
  own in `Vk.View`); no promises (condition 8); a guard needs the finding's
  version to have been written on this line (the letter of draft 4 §4, the
  Ada account's G3). Everything is for an arbitrary type of pieces `P` and of
  criteria `C` with decidable equality; nothing is bounded.
-/

namespace Vk.M0

/-- A piece at a version. -/
abbrev At (P : Type) := P × Nat

inductive Outcome | holds | fails
  deriving DecidableEq, Repr

inductive Kind | claim | result | outline | other
  deriving DecidableEq, Repr

/-- One frontier item: which condition fails, of which piece, on what. The
    numbers are note 22 §4.1's. -/
inductive Item (P C : Type)
  | dangling     (p q : P)            -- 1: p refers to q and q is not there
  | unreconciled (p q : P)            -- 2: p was not written or re-read against q as q now is
  | finding      (p : P) (eid : Nat)  -- 4: this finding applies to p as it is
  | guard        (p : P) (eid : Nat)  -- 4: found in an earlier version, not looked for since
  | unasked      (p : P) (c : C)      -- 5: what the root asks of p has no applying answer
  | outside      (p q : P)            -- 5: p rests on q and q is not in canon
  | restsOnFault (p q : P)            -- 5: p rests on q and q is at fault
  | notTogether  (a x y : P)          -- 6: in assembly a, x depends on y; not looked at together
  | unanswered   (p : P) (c : C)      -- 9: a question raised and not answered since
  deriving DecidableEq, Repr

/-- Evidence. In the base: it is about versions, so it is true wherever they are. -/
structure Evidence (P C : Type) where
  id      : Nat
  time    : Nat
  subj    : P
  ver     : Nat
  crit    : C
  outcome : Outcome
  reads   : List (At P)
  deriving DecidableEq, Repr

/-- What happens on a line. -/
inductive Ev (P C : Type)
  | write    (time : Nat) (p : P) (v : Nat) (against : List (At P))
  | affirm   (time : Nat) (a b : At P)
  | raise    (time : Nat) (p : P) (c : C)
  | setAside (time : Nat) (eid : Nat)
  | markRoot (time : Nat) (a : P)
  | waive    (time : Nat) (item : Item P C)
  deriving DecidableEq, Repr

def Ev.time {P C : Type} : Ev P C → Nat
  | .write t .. | .affirm t .. | .raise t .. | .setAside t .. | .markRoot t .. | .waive t .. => t

structure Slot (P : Type) where
  filler      : P
  provisional : Bool := false
  deriving DecidableEq, Repr

/-- What is fixed before any event: the ontology (kinds, inner dependencies,
    what the root asks) and the content of every version that could be written
    (what it is predicated on; for an assembly, its slots). A version *is* its
    content here, so "immutable" needs no rule. -/
structure Written (P C : Type) where
  kind   : P → Kind
  pred   : P → Nat → List P
  slots  : P → Nat → List (Slot P)
  inner  : P → List (P × P)
  valid  : C
  whole  : C
  /-- a bound on how far reachability is iterated; any number ≥ the pieces in play -/
  fuel   : Nat

/-- A state: a line and the base. Both are only data. -/
structure State (P C : Type) where
  line : List (Ev P C)
  base : List (Evidence P C)
  deriving Repr

variable {P C : Type} [DecidableEq P] [DecidableEq C]

/-! ## Read from a line -/

/-- The latest write of p on the line, by time (a line is a set of timed events). -/
def lastWrite (s : State P C) (p : P) : Option (Nat × Nat × List (At P)) :=
  s.line.foldl (fun acc ev =>
    match ev with
    | .write t q v ag =>
      if q = p then
        match acc with
        | some (t0, _, _) => if t0 ≤ t then some (t, v, ag) else acc
        | none => some (t, v, ag)
      else acc
    | _ => acc) none

def sel (s : State P C) (p : P) : Option Nat := (lastWrite s p).map (·.2.1)

def selAt (s : State P C) (a : At P) : Bool := sel s a.1 == some a.2

def writtenAgainst (s : State P C) (p : P) : List (At P) :=
  ((lastWrite s p).map (·.2.2)).getD []

def everWritten (s : State P C) (p : P) (v : Nat) : Bool :=
  s.line.any fun | .write _ q w _ => decide (q = p ∧ w = v) | _ => false

def isSetAside (s : State P C) (eid : Nat) : Bool :=
  s.line.any fun | .setAside _ i => i == eid | _ => false

def affirmed (s : State P C) (a b : At P) : Bool :=
  s.line.any fun | .affirm _ x y => decide (x = a ∧ y = b) | _ => false

def waived (s : State P C) (i : Item P C) : Bool :=
  s.line.any fun | .waive _ j => decide (j = i) | _ => false

def roots (s : State P C) : List P :=
  s.line.filterMap fun | .markRoot _ a => some a | _ => none

/-- Evidence applies when its subject and everything it read are as they were. -/
def applies (s : State P C) (e : Evidence P C) : Bool :=
  selAt s (e.subj, e.ver) && e.reads.all (selAt s) && !isSetAside s e.id

/-! ## Canon: reached from the roots through non-provisional slots -/

def fill (W : Written P C) (s : State P C) (a : P) : List P :=
  match sel s a with
  | some v => ((W.slots a v).filter (fun sl => !sl.provisional)).map (·.filler)
  | none => []

def grow (W : Written P C) (s : State P C) (cur : List P) : List P :=
  ((cur.flatMap (fill W s)).foldl (fun acc q => if acc.contains q then acc else acc ++ [q]) cur)

def iter {α : Type} (f : α → α) : Nat → α → α
  | 0, a => a
  | n + 1, a => iter f n (f a)

def canon (W : Written P C) (s : State P C) : List P := iter (grow W s) W.fuel (roots s)

/-! ## The conditions, piece by piece -/

def preds (W : Written P C) (s : State P C) (p : P) : List P :=
  match sel s p with
  | some v => W.pred p v
  | none => []

/-- A finding is answered by evidence that holds, on its criterion, later, applying now. -/
def answered (s : State P C) (f : Evidence P C) : Bool :=
  s.base.any fun g =>
    decide (g.subj = f.subj ∧ g.crit = f.crit ∧ g.outcome = .holds ∧ f.time < g.time) && applies s g

/-- Has x, as it is, been looked at beside y, as it is? By an affirm, by x's
    own write having been made against y, or by evidence about x that read y. -/
def together (s : State P C) (x y : P) : Bool :=
  match sel s x, sel s y with
  | some vx, some vy =>
    affirmed s (x, vx) (y, vy) || (writtenAgainst s x).contains (y, vy) ||
      s.base.any (fun e => decide (e.subj = x ∧ e.ver = vx) && applies s e && e.reads.contains (y, vy))
  | _, _ => false

/-- What the root asks of a piece, by its kind. A claim: checked. A result:
    read whole, by one piece of evidence that read every filler. -/
def asks (W : Written P C) (s : State P C) (p : P) : List (Item P C) :=
  match W.kind p with
  | .claim =>
    if s.base.any (fun e => decide (e.subj = p ∧ e.crit = W.valid ∧ e.outcome = .holds) && applies s e)
    then [] else [.unasked p W.valid]
  | .result =>
    if s.base.any (fun e => decide (e.subj = p ∧ e.crit = W.whole ∧ e.outcome = .holds) && applies s e
          && (fill W s p).all (fun q => (e.reads.map (·.1)).contains q))
    then [] else [.unasked p W.whole]
  | _ => []

/-- The violations that are a piece's own (everything but resting on a fault). -/
def own (W : Written P C) (s : State P C) (cn : List P) (p : P) : List (Item P C) :=
  let ps := preds W s p
  let items : List (Item P C) :=
    ((ps.filter (fun q => (sel s q).isNone)).map (Item.dangling p)) ++
    ((ps.filter (fun q => (sel s q).isSome && !together s p q)).map (Item.unreconciled p)) ++
    ((s.base.filter (fun e => decide (e.subj = p ∧ e.outcome = .fails) && applies s e)).map
        (fun e => Item.finding p e.id)) ++
    ((s.base.filter (fun e => decide (e.subj = p ∧ e.outcome = .fails) && !applies s e
        && !isSetAside s e.id && everWritten s p e.ver && !answered s e)).map
        (fun e => Item.guard p e.id)) ++
    asks W s p ++
    ((ps.filter (fun q => !cn.contains q)).map (Item.outside p)) ++
    (((W.inner p).filter (fun xy => !together s xy.1 xy.2)).map (fun xy => Item.notTogether p xy.1 xy.2)) ++
    ((s.line.filterMap (fun
        | .raise t q c =>
          if q = p ∧ !(s.base.any (fun e => decide (e.subj = p ∧ e.crit = c ∧ t < e.time) && applies s e))
          then some (Item.unanswered p c) else none
        | _ => none)))
  items.filter (fun i => !waived s i)

/-- Fault as a least fixed point: start from nobody, add whoever has an
    unwaived violation of its own or rests on someone already added. -/
def faultStep (W : Written P C) (s : State P C) (cn : List P) (F : List P) : List P :=
  cn.filter fun p => F.contains p || !(own W s cn p).isEmpty || (preds W s p).any F.contains

def faulty (W : Written P C) (s : State P C) : List P :=
  let cn := canon W s
  iter (faultStep W s cn) W.fuel []

/-- **The frontier.** A function of the state and nothing else. -/
def frontier (W : Written P C) (s : State P C) : List (Item P C) :=
  let cn := canon W s
  let F := faulty W s
  cn.flatMap fun p =>
    own W s cn p ++
    (((preds W s p).filter F.contains).map (Item.restsOnFault p)).filter (fun i => !waived s i)

def Stationary (W : Written P C) (s : State P C) : Prop := frontier W s = []

instance (W : Written P C) (s : State P C) : Decidable (Stationary W s) :=
  inferInstanceAs (Decidable (frontier W s = []))

/-! ## Change -/

/-- Record evidence. It goes to the base, whatever line is being read. -/
def learn (s : State P C) (e : Evidence P C) : State P C := { s with base := s.base ++ [e] }

/-- Do something on the line. -/
def act (s : State P C) (ev : Ev P C) : State P C := { s with line := s.line ++ [ev] }

/-- Rewind: drop the line's events after a time. The base is untouched. -/
def rewind (s : State P C) (t : Nat) : State P C :=
  { s with line := s.line.filter (fun ev => ev.time ≤ t) }

/-- **A checkpoint cannot be built without a proof that its state is
    stationary.** There is no field in which "stationary" could be typed. -/
structure Checkpoint (W : Written P C) where
  state      : State P C
  stationary : Stationary W state

/-- Closing a fork: the only way to get the next checkpoint. -/
def close (W : Written P C) (fork : State P C) (h : Stationary W fork) : Checkpoint W :=
  ⟨fork, h⟩

end Vk.M0
