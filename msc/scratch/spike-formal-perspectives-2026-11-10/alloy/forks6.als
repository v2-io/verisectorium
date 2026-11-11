module forks6

/*
 * Round 10, and the last. Round 9 (forks5.als) let this through
 * (runs/out-forks5/F_KK_EE-solution-0.txt): a result R had two whole reads on
 * record, one that had read v and one that had read v1. Fork A rewrote v, fork
 * B rewrote v1. Each fork still had one whole read standing. The union has
 * none. No event of either fork touched anything the other changed, and no
 * single piece of evidence read both.
 *
 * So the clause cannot be about the forks' events alone. It has to quantify
 * over every piece: no piece, followed through what it is predicated on and
 * what the evidence about it read, reaches something each fork changed. (This
 * is the OCaml build's definition of "meet", without its grading.)
 */

open forks5

fun reads: Piece -> Piece { evReads + rests[C] + rests[A] + rests[B] }

pred G {
  no p: Piece | some p.*reads & change[onA] and some p.*reads & change[onB]
}

run F_KK_EE_G { cannotBothClose and F and KK and EE and G } for 4 but 4 View, 9 Time, 9 Event, 6 Version
run G_KK      { cannotBothClose and G and KK }              for 4 but 4 View, 9 Time, 9 Event, 6 Version
