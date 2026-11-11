module story
/*
 * Note 22 section 4.3, row by row, as one fixed instance.
 * Nothing here is searched for: every atom and every event is given, and the
 * solver only evaluates the M0 conditions at ten views. The sig Out makes the
 * computed sets show up in the solution so they can be read.
 */
open m0

one sig d, e, k extends Veritoid {}
one sig c, u extends Claim {}
one sig T, U extends Result {}
one sig O extends Outline {}
one sig c1, c1p, c2, d1, d1p, d2, d3, e1, k1, k2, u1, u2, T1, U1, O1 extends Version {}
one sig CaseX extends OtherCrit {}
one sig Wc1, Wd1, We1, Wk1, Wu1, WT, WU, WO, Wc1p, Wd1p, Wc2, Wd2, Wk2, Wd3, Wu2 extends Write {}
one sig Af_e1c1, Af_k1e1, Af_e1c2 extends Affirm {}
one sig MR extends MarkRoot {}
one sig E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12 extends Evid {}
one sig V0, V1, V2, V3, V4, V5, V6, V7, V8, V9 extends View {}

fact closedWorld {
  Piece = c + d + e + k + u + T + U + O
  Version = c1 + c1p + c2 + d1 + d1p + d2 + d3 + e1 + k1 + k2 + u1 + u2 + T1 + U1 + O1
  Event = Wc1 + Wd1 + We1 + Wk1 + Wu1 + WT + WU + WO + MR + Af_e1c1 + Af_k1e1 + E1 + E2 + E3 + E4 + E5 + Wc1p + Wd1p + E6 + Wc2 + Wd2 + Wk2 + Af_e1c2 + E7 + E8 + Wd3 + E9 + Wu2 + E10 + E11 + E12
  View = V0 + V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8 + V9
  OtherCrit = CaseX
  no Raise and no SetAside and no Same
  Finding = E5
}

fact versions {
  (c1 + c1p + c2).of = c
  (d1 + d1p + d2 + d3).of = d
  e1.of = e
  (k1 + k2).of = k
  (u1 + u2).of = u
  T1.of = T
  U1.of = U
  O1.of = O
  (u1 + u2).predOn = c
  no (c1 + c1p + c2 + d1 + d1p + d2 + d3 + e1 + k1 + k2).predOn
  T1.slots = c + d + e + k
  T1.inner = e -> c + k -> e
  no T1.prov
  U1.slots = u
  no U1.inner
  no U1.prov
  O1.slots = T + U
  no O1.inner
  no O1.prov
}

fact events {
  -- one event per time, in this order (stated as next-of, so the solver propagates it)
  Wc1.at = first
  Wd1.at = Wc1.at.next
  We1.at = Wd1.at.next
  Wk1.at = We1.at.next
  Wu1.at = Wk1.at.next
  WT.at = Wu1.at.next
  WU.at = WT.at.next
  WO.at = WU.at.next
  MR.at = WO.at.next
  Af_e1c1.at = MR.at.next
  Af_k1e1.at = Af_e1c1.at.next
  E1.at = Af_k1e1.at.next
  E2.at = E1.at.next
  E3.at = E2.at.next
  E4.at = E3.at.next
  E5.at = E4.at.next
  Wc1p.at = E5.at.next
  Wd1p.at = Wc1p.at.next
  E6.at = Wd1p.at.next
  Wc2.at = E6.at.next
  Wd2.at = Wc2.at.next
  Wk2.at = Wd2.at.next
  Af_e1c2.at = Wk2.at.next
  E7.at = Af_e1c2.at.next
  E8.at = E7.at.next
  Wd3.at = E8.at.next
  E9.at = Wd3.at.next
  Wu2.at = E9.at.next
  E10.at = Wu2.at.next
  E11.at = E10.at.next
  E12.at = E11.at.next
  Wc1.w = c1
  Wd1.w = d1
  We1.w = e1
  Wk1.w = k1
  Wu1.w = u1
  WT.w = T1
  WU.w = U1
  WO.w = O1
  Wc1p.w = c1p
  Wd1p.w = d1p
  Wc2.w = c2
  Wd2.w = d2
  Wk2.w = k2
  Wd3.w = d3
  Wu2.w = u2
  Wu1.against = c -> c1
  Wu2.against = c -> c2
  no (Write - Wu1 - Wu2).against
  MR.root = O
  Af_e1c1.ax = e1
  Af_e1c1.ay = c1
  Af_k1e1.ax = k1
  Af_k1e1.ay = e1
  Af_e1c2.ax = e1
  Af_e1c2.ay = c2

  E1.subj = c1
  E1.crit = Valid
  E1.reads = d1
  E2.subj = u1
  E2.crit = Valid
  E2.reads = c1
  E3.subj = T1
  E3.crit = Whole
  E3.reads = c1 + d1 + e1 + k1
  E4.subj = U1
  E4.crit = Whole
  E4.reads = u1
  E5.subj = c1
  E5.crit = CaseX
  no E5.reads   -- the auditor's finding (in Finding)
  E6.subj = c1p
  E6.crit = Valid
  E6.reads = d1p
  E7.subj = c2
  E7.crit = Valid
  E7.reads = d2
  E8.subj = c2
  E8.crit = CaseX
  no E8.reads
  E9.subj = c2
  E9.crit = Valid
  E9.reads = d3
  E10.subj = u2
  E10.crit = Valid
  E10.reads = c2
  E11.subj = T1
  E11.crit = Whole
  E11.reads = c2 + d3 + e1 + k2
  E12.subj = U1
  E12.crit = Whole
  E12.reads = u2
}

fun S0L: set LineEvent { Wc1 + Wd1 + We1 + Wk1 + Wu1 + WT + WU + WO + MR + Af_e1c1 + Af_k1e1 }
fun F4: set LineEvent { S0L + Wc2 + Wd2 + Wk2 + Af_e1c2 }

fact views {
  V0.line = S0L
  V0.now = E4.at   -- S0
  V1.line = S0L
  V1.now = E5.at   -- 08:30 the finding
  V2.line = S0L + Wc1p + Wd1p
  V2.now = E6.at   -- 09:00 first repair, checked
  V3.line = S0L
  V3.now = E6.at   -- 10:00 rewound; E6 still in the base
  V4.line = F4
  V4.now = Af_e1c2.at   -- 10:30 second repair
  V5.line = F4
  V5.now = E8.at   -- 11:00 checked
  V6.line = F4 + Wd3
  V6.now = Wd3.at   -- 11:30 d3
  V7.line = F4 + Wd3
  V7.now = E9.at   -- 12:00
  V8.line = F4 + Wd3 + Wu2
  V8.now = E10.at   -- 13:00
  V9.line = F4 + Wd3 + Wu2
  V9.now = E12.at   -- 14:00
}

one sig Out {
  o2, o4a, o4b, o5a, o5b, o6, o6w, oOther: View -> Piece,
  oFault: View -> Piece,
  oStationary, oStationaryW: set View
}
fact report {
  Out.o2  = { v: View, p: Piece | p in v2[v] }
  Out.o4a = { v: View, p: Piece | p in v4a[v] }
  Out.o4b = { v: View, p: Piece | p in v4b[v] }
  Out.o5a = { v: View, p: Piece | p in v5a[v] }
  Out.o5b = { v: View, p: Piece | p in v5b[v] }
  Out.o6  = { v: View, p: Piece | p in v6[v] }
  Out.o6w = { v: View, p: Piece | p in v6w[v] }
  Out.oOther = { v: View, p: Piece | p in v1[v] + v5c[v] + v9[v] }
  Out.oFault = { v: View, p: Piece | p in fault[v] }
  Out.oStationary = { v: View | stationary[v] }
  Out.oStationaryW = { v: View | stationaryW[v] }
}

run story {} for exactly 8 Piece, exactly 15 Version, exactly 3 Crit, exactly 31 Event, exactly 31 Time, exactly 10 View, exactly 1 Out

