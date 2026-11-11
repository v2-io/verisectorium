module forks7

/*
 * Not a round of the "do not meet" search. The TLA+ fork of this spike
 * reported a "lost rewrite": two forks each rewrite the same piece to
 * different versions, each is stationary alone, and the union is stationary
 * too, with whichever write has the later time silently selected. Every
 * forks*.als run before this one asked for a union that is NOT stationary, so
 * none of them could have shown it. This asks for it directly in M0.
 */

open forks

run lostRewrite {
  stationary[A] and stationary[B] and stationary[M]
  some p: wroteA & wroteB | p in canon[M] and p.(sel[A]) != p.(sel[B])
} for 4 but 4 View, 8 Time, 8 Event, 6 Version
