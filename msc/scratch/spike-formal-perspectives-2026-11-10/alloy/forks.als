module forks

/*
 * Two forks from one checkpoint. Each alone is stationary. Is their union?
 *
 * The way Alloy is used here: propose a description of "the forks do not
 * meet", ask for the smallest pair that satisfies it and still cannot both
 * close, read the instance, tighten the description, ask again. No generator
 * is written; each run is one sentence.
 *
 * All four views are read as of the same (last) time, so all see the same
 * base. That takes the Ada build's G5 (a fork sees the other's evidence at
 * once) out of the picture on purpose: what is left is about writes and
 * decisions only.
 */

open m0

one sig C, A, B, M extends View {}

fun onA: set LineEvent { A.line - C.line }
fun onB: set LineEvent { B.line - C.line }
fun wroteA: set Piece { (onA & Write).w.of }
fun wroteB: set Piece { (onB & Write).w.of }

fact twoForks {
  View = C + A + B + M
  C.line in A.line
  C.line in B.line
  M.line = A.line + B.line
  no onA & onB
  some onA
  some onB
  -- the forks' events come after the checkpoint and after everything on it
  all f: onA + onB | lt[C.now, f.at]
  A.now = last
  B.now = last
  M.now = last
  LineEvent in M.line          -- no line events outside the picture
  stationary[C]
  some canon[C]
}

pred cannotBothClose { stationary[A] and stationary[B] and not stationary[M] }

-- Round 0. Any pair at all.
run r0_any { cannotBothClose } for 4 but 4 View, 8 Time, 8 Event, 6 Version

-- Round 1. They write different pieces.
pred differentPieces { no wroteA & wroteB }
run r1_differentPieces { cannotBothClose and differentPieces }
  for 4 but 4 View, 8 Time, 8 Event, 6 Version

-- Round 2. ... and no evidence read, or was about, a piece both forks touch
-- in the sense of: one wrote it and the evidence matters to the other.
-- (The draft-3 sentence: "they fail to compose only where they select
-- different versions of one id, or one's evidence read what the other rewrote".)
-- Evidence here belongs to no fork, so "one's evidence" is read as: evidence
-- about a piece one fork wrote.
pred noEvidenceAcross {
  no g: Evid | (g.subj.of in wroteA and some g.reads.of & wroteB)
            or (g.subj.of in wroteB and some g.reads.of & wroteA)
}
run r2_draft3Sentence { cannotBothClose and differentPieces and noEvidenceAcross }
  for 4 but 4 View, 8 Time, 8 Event, 6 Version

-- Round 3. ... and neither fork's new versions are predicated on what the other wrote.
pred noReferenceAcross {
  no (onA & Write).w.predOn & wroteB
  no (onB & Write).w.predOn & wroteA
}
run r3_noReferenceAcross { cannotBothClose and differentPieces and noEvidenceAcross and noReferenceAcross }
  for 4 but 4 View, 8 Time, 8 Event, 6 Version

-- Round 4. ... and neither fork's writes change which pieces are in canon.
pred canonUnmoved { canon[A] = canon[C] and canon[B] = canon[C] and no (onA + onB) & MarkRoot }
run r4_canonUnmoved {
  cannotBothClose and differentPieces and noEvidenceAcross and noReferenceAcross and canonUnmoved
} for 4 but 4 View, 8 Time, 8 Event, 6 Version

-- Round 5. ... and no decision on one fork is about a version of what the other wrote.
pred noDecisionAcross {
  no f: onA & Affirm | some (f.ax + f.ay).of & wroteB
  no f: onB & Affirm | some (f.ax + f.ay).of & wroteA
  no r: onA & Raise | r.rp in wroteB
  no r: onB & Raise | r.rp in wroteA
  no z: onA & SetAside | some (z.sa.subj + z.sa.reads).of & wroteB
  no z: onB & SetAside | some (z.sa.subj + z.sa.reads).of & wroteA
}
run r5_noDecisionAcross {
  cannotBothClose and differentPieces and noEvidenceAcross and noReferenceAcross
  and canonUnmoved and noDecisionAcross
} for 4 but 4 View, 8 Time, 8 Event, 6 Version
