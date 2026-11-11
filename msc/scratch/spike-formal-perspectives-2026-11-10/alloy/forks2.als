module forks2

/*
 * After reading the six instances of forks.als (runs/forks.log): the clauses
 * there were too weak, mostly in one way. This file states five clauses
 * afresh, asks whether together they are enough at this size, and then drops
 * each in turn to see whether it was needed, with an instance when it was.
 */

open forks

-- D. the forks write different pieces
pred D { no wroteA & wroteB }

-- E. no single piece of evidence touches (is about, or read) something each fork wrote
pred E {
  no g: Evid | some (g.subj + g.reads).of & wroteA and some (g.subj + g.reads).of & wroteB
}

-- R. no new version on one fork is predicated on, or has a slot for, a piece the other wrote
--    (round 1 of this file had only "predicated on"; runs/forks2-round1-all5-instance.txt is
--    the instance that got through: one fork wrote an assembly with an inner dependency
--    over a filler, the other fork wrote the filler)
pred R {
  no (onA & Write).w.(predOn + slots) & wroteB
  no (onB & Write).w.(predOn + slots) & wroteA
}

-- K. canon in the union is what the forks already had: nothing is in canon in
--    the union that neither fork had there, and nothing a fork wrote is in
--    canon in the union unless it was in canon on that fork
pred K {
  canon[M] = canon[A] + canon[B]
  wroteA & canon[M] in canon[A]
  wroteB & canon[M] in canon[B]
}

-- X. no decision on one fork is about a piece the other fork wrote or made a decision about
--    (round 2 had only "wrote"; runs/forks2-round2-all5-instance.txt got through with no
--    write on either fork: one fork raised a question, the other set aside the evidence
--    that answered it)
fun decTouch[es: set LineEvent]: set Piece {
  (es & Affirm).(ax + ay).of + (es & Raise).rp + (es & SetAside).sa.(subj + reads).of
  + (es & MarkRoot).root
}
pred X {
  no decTouch[onA] & (wroteB + decTouch[onB])
  no decTouch[onB] & wroteA
}

run all5      { cannotBothClose and D and E and R and K and X } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropD     { cannotBothClose and       E and R and K and X } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropE     { cannotBothClose and D and       R and K and X } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropR     { cannotBothClose and D and E and       K and X } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropK     { cannotBothClose and D and E and R and       X } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropX     { cannotBothClose and D and E and R and K       } for 4 but 4 View, 9 Time, 9 Event, 6 Version
