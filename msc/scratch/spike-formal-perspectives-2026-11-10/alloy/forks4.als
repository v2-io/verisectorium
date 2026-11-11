module forks4

/*
 * Round 8, the last tried. Seven rounds of naming kinds of overlap each let an
 * instance through (forks.als, forks2.als, forks3.als and their saved round
 * logs). Round 7's instance: fork B gave an assembly an inner dependency over
 * a piece it neither wrote nor decided about; the evidence that met it had
 * read a piece fork A rewrote.
 *
 * So here the clause is stated once, generally: nothing one fork TOUCHED
 * (wrote, referred to, had a slot for, decided about), followed through what
 * the evidence about it read, is something the other fork CHANGED (wrote or
 * decided about). Plus the blunt canon clause.
 */

open forks

fun wr[es: set LineEvent]:  set Piece { (es & Write).w.of }
fun ref[es: set LineEvent]: set Piece { (es & Write).w.(predOn + slots) }
fun dec[es: set LineEvent]: set Piece {
  (es & Affirm).(ax + ay).of + (es & Raise).rp + (es & SetAside).sa.(subj + reads).of
  + (es & MarkRoot).root
}
fun change[es: set LineEvent]: set Piece { wr[es] + dec[es] }
fun evReads: Piece -> Piece { { p, q: Piece | some g: Evid | g.subj.of = p and q in g.reads.of } }
fun touch[es: set LineEvent]: set Piece {
  (wr[es] + ref[es] + dec[es]).*evReads
}

pred F {
  no touch[onA] & change[onB]
  no touch[onB] & change[onA]
}
pred KK {
  canon[M] = canon[A]
  canon[M] = canon[B]
}

run F_and_KK { cannotBothClose and F and KK } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run F_only   { cannotBothClose and F }        for 4 but 4 View, 9 Time, 9 Event, 6 Version
run KK_only  { cannotBothClose and KK }       for 4 but 4 View, 9 Time, 9 Event, 6 Version
