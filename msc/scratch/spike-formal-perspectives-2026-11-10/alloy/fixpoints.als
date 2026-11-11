module fixpoints

/*
 * Is "consistent" a fixed point, or is it reachability?
 *
 * The kernel spec (draft 4, section 4) says: consistent is the greatest fixed
 * point over the pieces in canon. m0.als says it with no fixed point: a piece
 * is consistent when nothing it transitively rests on has a violation of its
 * own. This file asks Alloy whether those are the same thing, and what
 * happens to each when a question is allowed to be conditional on consistency.
 */

open m0

-- PART 1: obligations unconditional (the model as m0 has it) -----------------

-- The spec's wording, as a property of a candidate set S.
pred fixed[v: View, S: set Piece] {
  S = { p: canon[v] | p not in own[v] and p.(rests[v]) in S }
}

-- 1a. the closed form is a fixed point
assert closedFormIsFixed { all v: View | fixed[v, consistent[v]] }

-- 1b. every fixed point is inside it: it is the greatest
assert closedFormIsGreatest {
  all v: View, S: set Piece | fixed[v, S] implies S in consistent[v]
}

-- 1c. is it the only one? (expected: no; show me the smallest other one)
run anotherFixedPoint {
  some v: View, S: set Piece | fixed[v, S] and S != consistent[v]
} for 3 but 1 View, 4 Time, 4 Event

-- 1c'. the same with no piece predicated on itself (expected: a ring of two)
run anotherFixedPointNoSelfLoop {
  all ver: Version | ver.of not in ver.predOn
  some v: View, S: set Piece | fixed[v, S] and S != consistent[v]
} for 4 but 1 View, 5 Time, 5 Event

-- 1d. whether the WHOLE state is stationary never consults the recursive clause
assert stationaryIgnoresRecursion {
  all v: View | stationary[v] iff consistent[v] = canon[v]
}

check closedFormIsFixed          for 4 but 1 View, 6 Time, 6 Event, 6 Version
check closedFormIsGreatest       for 4 but 1 View, 6 Time, 6 Event, 6 Version
check stationaryIgnoresRecursion for 4 but 1 View, 6 Time, 6 Event, 6 Version

-- PART 2: a question conditional on consistency -------------------------------

-- A raise that stands only while the piece it names is consistent.
sig CondRaise in Raise { cond: one Piece }

fun v9C[v: View, S: set Piece]: set Piece {
  { p: canon[v] | some r: v.line & Raise |
      r.rp = p and (r in CondRaise implies r.cond in S) and
      no g: Evid | applies[v, g] and g.subj.of = p and g.crit = r.rc and lt[r.at, g.at] }
}
fun ownC[v: View, S: set Piece]: set Piece {
  v1[v] + v2[v] + v4a[v] + v4b[v] + v5a[v] + v5b[v] + v5c[v] + v6[v] + v9C[v, S]
}
pred fixedC[v: View, S: set Piece] {
  S = { p: canon[v] | p not in ownC[v, S] and p.(rests[v]) in S }
}

-- Alloy cannot say "there is no set S such that ..." (a universal over sets
-- cannot be skolemized). The standard way round: make the candidate sets atoms
-- and require that every subset of Piece is one of them.
sig Cand { mem: set Piece }
pred everySubsetIsACand {
  some k: Cand | no k.mem
  all k: Cand, p: Piece | some k2: Cand | k2.mem = k.mem + p
}

-- 2a. a state in which consistency has no answer at all
run noFixedPoint {
  everySubsetIsACand
  some v: View | some canon[v] and no k: Cand | fixedC[v, k.mem]
} for 3 but 1 View, 5 Time, 5 Event, 2 Piece, 4 Cand

-- 2b. a state with fixed points and no greatest among them
run noGreatest {
  everySubsetIsACand
  some v: View {
    some k: Cand | fixedC[v, k.mem]
    no g: Cand | fixedC[v, g.mem] and (all k: Cand | fixedC[v, k.mem] implies k.mem in g.mem)
  }
} for 4 but 1 View, 7 Time, 7 Event, 3 Piece, 8 Cand

-- 2b'. the same with nothing predicated on anything, so that only the questions matter
run noGreatestQuestionsOnly {
  everySubsetIsACand
  no Version.predOn
  some v: View {
    some k: Cand | fixedC[v, k.mem]
    no g: Cand | fixedC[v, g.mem] and (all k: Cand | fixedC[v, k.mem] implies k.mem in g.mem)
  }
} for 4 but 1 View, 7 Time, 7 Event, 3 Piece, 8 Cand

-- 2c. with no conditional raise, part 2 is part 1 (a check on this file itself)
assert unconditionalIsPart1 {
  all v: View, S: set Piece | no CondRaise implies (fixedC[v, S] iff fixed[v, S])
}
check unconditionalIsPart1 for 4 but 1 View, 6 Time, 6 Event, 0 Cand

-- 2d. the direct statement, to record what Alloy does with it
run noFixedPointDirect {
  some v: View | some canon[v] and (all S: set Piece | not fixedC[v, S])
} for 3 but 1 View, 5 Time, 5 Event, 2 Piece, 0 Cand
