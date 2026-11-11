module forks3

/*
 * Round 4. forks2.als was tightened three times and each time an instance got
 * through (runs/forks2-round{1,2,3}-all5-instance.txt). What the three had in
 * common: something on one fork TOUCHED a piece (referred to it, had a slot
 * for it, decided about it) that the other fork CHANGED (wrote, or decided
 * about). So this file states the clauses by what is touched and what is
 * changed, asks whether all of them together are enough at this size, and
 * drops each in turn.
 */

open forks

fun wr[es: set LineEvent]:  set Piece { (es & Write).w.of }
fun ref[es: set LineEvent]: set Piece { (es & Write).w.(predOn + slots) }
fun dec[es: set LineEvent]: set Piece {
  (es & Affirm).(ax + ay).of + (es & Raise).rp + (es & SetAside).sa.(subj + reads).of
  + (es & MarkRoot).root
}

pred WW { no wr[onA] & wr[onB] }                                   -- both wrote one piece
pred RW { no ref[onA] & wr[onB]  and  no ref[onB] & wr[onA] }      -- one refers to / has a slot for what the other wrote
pred DW { no dec[onA] & wr[onB]  and  no dec[onB] & wr[onA] }      -- one decided about what the other wrote
pred DD { no dec[onA] & dec[onB] }                                 -- both decided about one piece
pred RD { no ref[onA] & dec[onB] and  no ref[onB] & dec[onA] }     -- one refers to / has a slot for what the other decided about
-- Round 7: EV widened from "something each WROTE" to "something each wrote or decided
-- about". runs/forks3-round6-all7-instance.txt got through round 6: fork A wrote nothing;
-- it raised a question, the answer to which read a piece fork B rewrote.
pred EV {
  no g: Evid | some (g.subj + g.reads).of & (wr[onA] + dec[onA])
           and some (g.subj + g.reads).of & (wr[onB] + dec[onB])
}
-- Round 5 widened KK to every piece a fork touched, and
-- runs/forks3-round5-all7-instance.txt still got through: fork A's write to an outline
-- brought v into canon; fork B marked as a root an assembly O1 that A's same write had
-- dropped from canon; O1 (written by neither) declares a dependency of v on O1, which
-- binds only when both are in canon, and that is so only in the union.
-- Round 6: the blunt form. Neither fork moves canon at all, relative to the other.
fun touch[es: set LineEvent]: set Piece { wr[es] + ref[es] + dec[es] }
pred KK {
  canon[M] = canon[A]
  canon[M] = canon[B]
}

run all7   { cannotBothClose and WW and RW and DW and DD and RD and EV and KK } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropWW { cannotBothClose and        RW and DW and DD and RD and EV and KK } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropRW { cannotBothClose and WW and        DW and DD and RD and EV and KK } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropDW { cannotBothClose and WW and RW and        DD and RD and EV and KK } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropDD { cannotBothClose and WW and RW and DW and        RD and EV and KK } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropRD { cannotBothClose and WW and RW and DW and DD and        EV and KK } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropEV { cannotBothClose and WW and RW and DW and DD and RD and        KK } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run dropKK { cannotBothClose and WW and RW and DW and DD and RD and EV        } for 4 but 4 View, 9 Time, 9 Event, 6 Version
