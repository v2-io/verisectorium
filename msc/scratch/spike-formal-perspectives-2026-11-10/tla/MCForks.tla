------------------------------ MODULE MCForks ------------------------------
(* Two forks from one checkpoint, every interleaving.                        *)
(* Claims c and x, x predicated on c; an outline O points at both; the root  *)
(* asks that each claim has been checked.  Checks here read nothing else, so *)
(* the only thing tying x to c is the reference (condition 2).               *)
EXTENDS Veri, TLC

CONSTANT WithFinding

FPieces == {"c", "x", "O"}
FKind   == [p \in FPieces |-> IF p = "O" THEN "outline" ELSE "claim"]
FFill   == [p \in FPieces |-> IF p = "O" THEN {"c", "x"} ELSE {}]
FInner  == [p \in FPieces |-> {}]
FRoots  == {"O"}
FPred(p, n) == IF p = "x" THEN {"c"} ELSE {}
FVers   == [p \in FPieces |-> CASE p = "c" -> {2, 3} [] p = "x" -> {2} [] OTHER -> {}]
FAff    == {<<"x", "c">>}

Ev(id, n, subj, ver, crit, out) ==
  [id |-> id, n |-> n, subj |-> subj, ver |-> ver, crit |-> crit, out |-> out, reads |-> {}]
V(p, v) == Ev(<<"valid", p, v>>, 0, p, v, "valid", "holds")
Bad     == Ev(<<"caseX", "c", 1>>, 0, "c", 1, "caseX", "fails")
Fix(v)  == Ev(<<"caseX", "c", v>>, 0, "c", v, "caseX", "holds")

FEvPool == {V("c", 2), V("c", 3), V("x", 2)}
             \cup (IF WithFinding THEN {Bad, Fix(2), Fix(3)} ELSE {})

FLine0 == << W("c", 1, 1, {}, 0, "S0"), W("x", 1, 2, {<<"c", 1>>}, 0, "S0"), W("O", 1, 3, {}, 0, "S0") >>
FBase0 == {[e |-> V("c", 1), t |-> 4], [e |-> V("x", 1), t |-> 5]}
FNow0  == 6

FView == [ main |-> [i \in DOMAIN main |-> <<main[i].k, main[i].p, main[i].v, main[i].t, main[i].by>>],
           sel  |-> [p \in {"c", "x"} |-> Sel(main, p)],
           frontier |-> FrontierOf(main, base),
           forks |-> [f \in Forks |-> IF fork[f].open
                        THEN [i \in DOMAIN fork[f].ev |-> <<fork[f].ev[i].k, fork[f].ev[i].p, fork[f].ev[i].v, fork[f].ev[i].t>>]
                        ELSE <<>>],
           known |-> {b.e.id : b \in base} ]
=============================================================================
