module m0

/*
 * M0 (../01-common-reading.md) as relations.
 *
 * Everything below the "COMPUTED" line is a function of a View (a line of
 * events, read as of a time) and of nothing else. There is no recursion in
 * this file and no fixed point: only joins, set difference, and the
 * transitive closure operator.
 *
 * Cut from M0, knowingly: promise (condition 8), waive, same-for-decisions,
 * unmarking a root. Kept: write, evidence (with reads), same, affirm, raise,
 * set-aside, mark-root; conditions 1, 2, 4, 5, 6, 9.
 */

open util/ordering[Time]

sig Time {}

-- WRITTEN ------------------------------------------------------------------

abstract sig Piece {}
sig Veritoid extends Piece {}
sig Claim extends Veritoid {}            -- the root asks that these be checked
abstract sig Asm extends Piece {}
sig Result, Outline extends Asm {}       -- the root asks that a Result be read whole

sig Version {
  of:    one Piece,
  predOn: set Piece,           -- a veritoid version: what it is predicated on
  slots: set Piece,           -- an assembly version: its fillers (not their versions)
  prov:  set Piece,           -- the fillers whose slot is flagged provisional
  inner: Piece -> Piece       -- inner dependencies among its fillers (i depends on j)
} {
  of in Veritoid implies (no slots and no prov and no inner)
  of in Asm implies no predOn
  prov in slots
  inner in slots -> slots
}

abstract sig Crit {}
one sig Valid, Whole extends Crit {}
sig OtherCrit extends Crit {}

-- EVENTS -------------------------------------------------------------------

abstract sig Event { at: one Time }
fact oneEventPerTime { all disj e1, e2: Event | e1.at != e2.at }

abstract sig LineEvent extends Event {}   -- belongs to a line
abstract sig BaseEvent extends Event {}   -- belongs to the base: seen from every line

sig Write extends LineEvent {
  w: one Version,
  against: Piece -> lone Version          -- what each reference pointed at when written
} {
  against.Version in w.predOn
  all q: Piece | q.against.of in q
}
sig Affirm   extends LineEvent { ax, ay: one Version }  -- ax was looked at beside ay and kept
sig Raise    extends LineEvent { rp: one Piece, rc: one Crit }
sig SetAside extends LineEvent { sa: one Evid }
sig MarkRoot extends LineEvent { root: one Asm }

sig Evid extends BaseEvent {
  subj:  one Version,
  crit:  one Crit,
  reads: set Version
}
sig Finding in Evid {}                    -- the evidence whose outcome is "fails"
sig Same extends BaseEvent { sfor: one Evid, sa1, sa2: one Version }

-- A view: a line (a SET of line events) read as of a time.
sig View { line: set LineEvent, now: one Time } {
  all e: line | lte[e.at, now]
}

-- COMPUTED -----------------------------------------------------------------

fun writes[v: View]: set Write { v.line & Write }

fun lastW[v: View, p: Piece]: set Write {
  { x: writes[v] | x.w.of = p and no y: writes[v] | y.w.of = p and lt[x.at, y.at] }
}

fun sel[v: View]: Piece -> Version {
  { p: Piece, ver: Version | some x: lastW[v, p] | x.w = ver }
}

fun eqv[v: View, e: Evid]: Version -> Version {
  let s = { p, q: Version | some sm: Same |
              sm.sfor = e and lte[sm.at, v.now] and sm.sa1 = p and sm.sa2 = q } |
    (Version <: iden) + ^(s + ~s)
}

pred applies[v: View, e: Evid] {
  lte[e.at, v.now]
  no z: v.line & SetAside | z.sa = e
  some (e.subj.of).(sel[v]) & (e.subj).(eqv[v, e])
  all r: e.reads | some (r.of).(sel[v]) & r.(eqv[v, e])
}

fun good[v: View]: set Evid { { e: Evid - Finding | applies[v, e] } }
fun bad[v: View]:  set Evid { { e: Finding | applies[v, e] } }

fun roots[v: View]: set Asm { (v.line & MarkRoot).root }

fun fill[v: View]: Piece -> Piece {
  { h, p: Piece | some s: h.(sel[v]) | p in s.slots - s.prov }
}

-- canon is reachability
fun canon[v: View]: set Piece { (roots[v]).*(fill[v]) & (sel[v]).Version }

fun rests[v: View]: Piece -> Piece {
  { p, q: Piece | q in p.(sel[v]).predOn }
}

-- the conditions, numbered as in note 22 section 4.1; each returns the pieces it fails on

fun v1[v: View]: set Piece {
  { p: canon[v] | some q: p.(rests[v]) | no q.(sel[v]) }
}

pred reconciled[v: View, p, q: Piece] {
  (some lw: lastW[v, p] | q.(lw.against) = q.(sel[v]))
  or (some f: v.line & Affirm | f.ax = p.(sel[v]) and f.ay = q.(sel[v]))
}
fun v2[v: View]: set Piece {
  { p: canon[v] | some q: p.(rests[v]) | some q.(sel[v]) and not reconciled[v, p, q] }
}

fun v4a[v: View]: set Piece {
  { p: canon[v] | some e: bad[v] | e.subj.of = p }
}

pred guardOpen[v: View, p: Piece, e: Evid] {
  e in Finding
  e.subj.of = p
  lte[e.at, v.now]
  no z: v.line & SetAside | z.sa = e
  not applies[v, e]
  some x: writes[v] | x.w = e.subj          -- the line selected that version at some time
  no g: good[v] | g.subj.of = p and g.crit = e.crit and lt[e.at, g.at]
}
fun v4b[v: View]: set Piece {
  { p: canon[v] | some e: Finding | guardOpen[v, p, e] }
}

fun v5a[v: View]: set Piece {
  { p: canon[v] & Claim | no g: good[v] | g.subj.of = p and g.crit = Valid }
}
fun v5b[v: View]: set Piece {
  { p: canon[v] & Result | no g: good[v] |
      g.subj.of = p and g.crit = Whole and p.(sel[v]).slots in g.reads.of }
}
fun v5c[v: View]: set Piece {
  { p: canon[v] | some q: p.(rests[v]) | some q.(sel[v]) and q not in canon[v] }
}

pred together[v: View, i, j: Piece] {
  (some f: v.line & Affirm | f.ax = i.(sel[v]) and f.ay = j.(sel[v]))
  or (some g: good[v] | g.subj.of = i and j in g.reads.of)
}
-- attributed to the dependent filler
fun v6[v: View]: set Piece {
  { i: canon[v] | some h: canon[v], j: Piece |
      i -> j in h.(sel[v]).inner and not together[v, i, j] }
}
-- A second reading of condition 6, kept beside the first because the story
-- turns on it (PERSPECTIVE.md, "the story"): writing the dependent counts as
-- having looked at what it depends on, as that then stood.
pred writtenAfter[v: View, i, j: Piece] {
  some x: lastW[v, i], y: lastW[v, j] | lt[y.at, x.at]
}
fun v6w[v: View]: set Piece {
  { i: canon[v] | some h: canon[v], j: Piece |
      i -> j in h.(sel[v]).inner and not together[v, i, j] and not writtenAfter[v, i, j] }
}
fun ownW[v: View]: set Piece {
  v1[v] + v2[v] + v4a[v] + v4b[v] + v5a[v] + v5b[v] + v5c[v] + v6w[v] + v9[v]
}
pred stationaryW[v: View] { no ownW[v] }

fun v9[v: View]: set Piece {
  { p: canon[v] | some r: v.line & Raise | r.rp = p and
      no g: Evid | applies[v, g] and g.subj.of = p and g.crit = r.rc and lt[r.at, g.at] }
}

-- a piece with a violation of its own
fun own[v: View]: set Piece {
  v1[v] + v2[v] + v4a[v] + v4b[v] + v5a[v] + v5b[v] + v5c[v] + v6[v] + v9[v]
}

pred stationary[v: View] { no own[v] }

-- "consistent", with no fixed point: nothing it transitively rests on has a
-- violation of its own.
fun fault[v: View]: set Piece {
  canon[v] & ((Piece <: iden) + ^(rests[v])).(own[v])
}
fun consistent[v: View]: set Piece { canon[v] - fault[v] }
