module forks5

/*
 * Round 9. Round 8 (forks4.als, F and KK together) let this through
 * (runs/out-forks4/F_and_KK-solution-0.txt): a FINDING in the base, about a
 * piece neither fork touched, that had read one piece as fork A left it and
 * another as fork B left it. It applies on neither fork and applies in the
 * union. So one more clause: no single piece of evidence, whatever it is
 * about, read something each fork changed.
 */

open forks4

pred EE {
  no g: Evid | some (g.subj + g.reads).of & change[onA] and some (g.subj + g.reads).of & change[onB]
}

run F_KK_EE { cannotBothClose and F and KK and EE } for 4 but 4 View, 9 Time, 9 Event, 6 Version
