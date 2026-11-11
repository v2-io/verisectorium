module slice

/*
 * The slice of msc/scratch/idiomatic-slice-2026-11-11/README.md, the way Alloy
 * would want it. Alloy 6.2. By the Alloy fork of the formal-perspectives spike.
 *
 * To run (the jar is the one the spike fetched; it is not in the repository):
 *   J=/opt/homebrew/opt/openjdk/bin/java
 *   A=../spike-formal-perspectives-2026-11-10/alloy/tool/alloy.jar
 *   $J -jar $A exec -f -o alloy-out -t text -s glucose alloy.als > alloy.log 2>&1
 * What came back is in alloy.log and alloy-out/, and is summarised at the foot
 * of this file.
 *
 * HOW ALLOY WANTS TO SAY IT
 *
 * 1. A kind is a signature. "A segment is a veritoid or an assembly" is two
 *    lines of declaration, and "of exactly one kind, never both" is what
 *    `abstract` and `extends` already mean. Nothing has a kind as a value;
 *    a thing IS of its kind.
 * 2. A slot is a field of its assembly kind, and "how many" is the word
 *    in front of the field's type: one, lone (at most one), seq (any number,
 *    in order). This is very close to core's own
 *        rel holds term="segment" card="{0,N}"
 *    with the difference that the next sentence can use it.
 * 3. A slot's state is a signature too. Suggested, Promised, Gap, Holds and
 *    PointsAt are five kinds of slot. Only a suggested one has a note and
 *    only a filled one has a filler, and that is said by where the field is
 *    declared, not by a rule.
 * 4. Provisional and root are subsets (`in`), not kinds: marks that some
 *    filled slots and some assemblies carry and others of the same kind do not.
 * 5. Canon is one expression: Root.*reach. Reflexive transitive closure is
 *    an operator here.
 * 6. Then the part that is most Alloy's own: the instance is not the model.
 *    The model is the first half of this file and admits many worlds; the
 *    README's table is one of them, written as `one sig`s; and the questions
 *    at the end are asked of all small worlds, not only that one.
 *
 * WHERE IT DEPARTS FROM THE SLICE AS WORDED, AND WHAT IT REFUSED
 *
 * a. "formal-claim: one". In the README's own instance T's description is
 *    promised and U's is not there at all. So "one" cannot mean one FILLER.
 *    Here it means: one slot, always present, in some state. Whether a
 *    required slot is FILLED is then a predicate (`complete`), which a world
 *    may fail, and U fails it. Alloy forces this choice at every sentence:
 *    a `fact` removes worlds, a `pred` describes them. Anything that can be
 *    owed has to be a pred. (For "nothing else yet" in U, I wrote gaps; the
 *    README does not say which empty state U's other slots are in.)
 * b. What may fill a slot is a fact about the slot's field, stated once per
 *    kind (`kinds fit`). It is not a type in the sense of a typed language:
 *    Alloy does not stop an ill-kinded filler from being written, it has no
 *    worlds containing one. For a single state that is the same thing. For
 *    work in progress it is not: a draft with the wrong kind of thing in a
 *    slot cannot be shown at all, only excluded.
 * c. Content. Alloy has a String type and I used it, so the sentences are
 *    really here. But Alloy can do nothing with a string except compare it
 *    for equality; content is an opaque atom with a label. That matches the
 *    slice (content is what questions are asked OF) and it means nothing
 *    about content can ever be said in this language.
 * d. Order. `seq` gives the outline its 1, 2, 3, 4. It drags in integers,
 *    which Alloy bounds like everything else (hence `5 Int, 4 seq` below).
 * e. "Holds: lives in it." Said as a fact: nothing is held by two slots,
 *    and a thing is not held inside itself. "Points at: lives elsewhere"
 *    I left unconstrained; a pointer at something held nowhere is allowed.
 * f. A trap I fell into, and it is worth more than the rest of this list.
 *    Alloy's String holds only the literals that appear in the question being
 *    run. Q3 and Q4 below mention no literal, so in their worlds there were
 *    no strings, so no veritoid could have content, so there were NO WORLDS,
 *    and my first run answered Q4 "no counterexample" and Q3 "no such world"
 *    for that reason alone. Q4's answer was the one I expected and I would
 *    not have looked; Q3's was not, and that is how I found it. `someText`
 *    is the repair. A check that passes because nothing exists reads exactly
 *    like a check that passes.
 */

-- THE SLICE ----------------------------------------------------------------

abstract sig Segment {}

abstract sig Veritoid extends Segment { content: one String }
sig Claim, Step, Explanation extends Veritoid {}

abstract sig Assembly extends Segment {}
sig Root in Assembly {}

abstract sig Slot {}
sig Suggested extends Slot { note: one String }
sig Promised, Gap extends Slot {}
abstract sig Filled extends Slot { filler: one Segment }
sig Holds, PointsAt extends Filled {}
sig Provisional in Filled {}

sig DerivedResult extends Assembly {
  formalClaim: one Slot,
  derivation:  seq Slot,
  description: one Slot,
  eli8:        lone Slot
}

sig Outline extends Assembly {
  rows: seq Slot
}

fun slots: Assembly -> Slot {
  formalClaim + description + eli8
  + { r: DerivedResult, s: Slot | s in r.derivation.elems }
  + { o: Outline, s: Slot | s in o.rows.elems }
}

fact kindsFit {
  DerivedResult.formalClaim.filler       in Claim
  DerivedResult.derivation.elems.filler  in Step
  DerivedResult.(description + eli8).filler in Explanation
}

fact slotsAreSomewhereOnce {
  all s: Slot | one slots.s                              -- every slot is a slot of one assembly
  all r: DerivedResult | not r.derivation.hasDups
  all o: Outline | not o.rows.hasDups
}

fact holding {
  all x: Segment | lone (Holds <: filler).x              -- held by at most one slot
  no a: Assembly | a in a.^(slots.(Holds <: filler))     -- and not inside itself
}

-- COMPUTED -------------------------------------------------------------------

-- one assembly reaches a segment through a slot that is filled and not provisional
fun reach: Assembly -> Segment { (slots :> (Filled - Provisional)).filler }

fun canon: set Segment { Root.*reach }

fun promisedAndEmpty: Assembly -> Slot { slots :> Promised }

-- "one" in the declared sense: every required slot of this result is filled
pred complete[r: DerivedResult] { r.(formalClaim + description) in Filled }

-- THE INSTANCE ---------------------------------------------------------------

one sig c, u extends Claim {}
one sig d extends Step {}
one sig k extends Explanation {}
one sig T, U extends DerivedResult {}
one sig O extends Outline {}

one sig T_claim, T_step, T_eli8, U_claim extends Holds {}
one sig T_desc extends Promised {}
one sig U_desc, O_4 extends Gap {}
one sig O_1, O_2 extends PointsAt {}
one sig O_3 extends Suggested {}

pred theInstance {
  c.content = "Every bounded monotone sequence of reals converges."
  d.content = "Take the least upper bound of the terms and show the terms come within any epsilon of it."
  k.content = "If you keep stepping forward and there is a wall you cannot pass, you end up settling somewhere at or before the wall."
  u.content = "Every Cauchy sequence of reals converges."

  T.formalClaim = T_claim
  T_claim.filler = c
  T.derivation = 0 -> T_step
  T_step.filler = d
  T.description = T_desc
  T.eli8 = T_eli8
  T_eli8.filler = k

  U.formalClaim = U_claim
  U_claim.filler = u
  no U.derivation
  U.description = U_desc
  no U.eli8

  O.rows = 0 -> O_1 + 1 -> O_2 + 2 -> O_3 + 3 -> O_4
  O_1.filler = T
  O_2.filler = U
  O_3.note = "a result about series is probably wanted here"

  Root = O
  Provisional = O_2
}

-- so that what is computed shows up in the printed world
one sig Computed { inCanon: set Segment, owedPromise: Assembly -> Slot, incomplete: set DerivedResult }
fact report {
  Computed.inCanon = canon
  Computed.owedPromise = promisedAndEmpty
  Computed.incomplete = { r: DerivedResult | not complete[r] }
}

-- QUESTIONS ------------------------------------------------------------------

-- see note (f): a question that names no string has no strings in its worlds
pred someText { some "any sentence" }

-- Q1. Show the instance. (Expected: one world.)
run show { theInstance }
  for exactly 7 Segment, exactly 10 Slot, 5 Int, 4 seq, exactly 1 Computed

-- Q2. In the instance, canon is O, T, c, d, k; and the one promised, empty slot is T's description.
check expected {
  theInstance implies (canon = O + T + c + d + k and promisedAndEmpty = T -> T_desc)
} for exactly 7 Segment, exactly 10 Slot, 5 Int, 4 seq, exactly 1 Computed

-- Q3. Of every small world, not only this one: can a thing be in canon while
--     the assembly that HOLDS it is not? (Expected: yes; a pointer reaches in.)
run inCanonButHolderIsNot {
  someText
  some s: Holds | s.filler in canon and slots.s not in canon
} for 9 Segment, 12 Slot, 5 Int, 4 seq, exactly 1 Computed

-- Q4. Of every small world: is everything in canon either a root or reached
--     through a slot that is filled and not provisional? (Expected: no counterexample.)
check canonIsOnlyWhatIsReached {
  someText implies all x: canon - Root | some s: Filled - Provisional | s.filler = x and slots.s in canon
} for 9 Segment, 12 Slot, 5 Int, 4 seq, exactly 1 Computed

-- Q5. A guard on Q4 after note (f): the worlds Q4 ranges over are not empty of interest.
run q4IsNotVacuous {
  someText
  some canon - Root
} for 9 Segment, 12 Slot, 5 Int, 4 seq, exactly 1 Computed

/*
 * WHAT CAME BACK (alloy.log; Alloy 6.2.0, glucose)
 *
 *   show                       one world found; alloy-out/show-solution-0.txt
 *                              Computed.inCanon     = O, T, c, d, k
 *                              Computed.owedPromise = T -> T_desc
 *                              Computed.incomplete  = T, U
 *   expected                   no counterexample (and `show` proves the instance exists)
 *   inCanonButHolderIsNot      a world found
 *   canonIsOnlyWhatIsReached   no counterexample, up to 9 segments and 12 slots
 *   q4IsNotVacuous             a world found
 *
 * `incomplete = T, U` is the departure in note (a) showing itself: T's
 * description is promised and not filled, U's is a gap, so neither result has
 * its required slots filled, and both are perfectly good worlds.
 */
