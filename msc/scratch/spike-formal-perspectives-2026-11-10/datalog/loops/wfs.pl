% The same six programs under the well-founded semantics (SWI-Prolog tabling).
% Each atom comes out true, false, or undefined. Run: swipl -q -g main -t halt wfs.pl
:- table p1_stands/0, p1_owed/0, p1_fault/0.
p1_stands :- tnot(p1_fault).
p1_owed   :- p1_stands.
p1_fault  :- p1_owed.

:- table p2_fault/1, p2_owed/1, p2_stands/1.
:- discontiguous p2_fault/1, p2_owed/1, p2_stands/1.
p2_stands(qa) :- tnot(p2_fault(b)).   p2_owed(a) :- p2_stands(qa).   p2_fault(a) :- p2_owed(a).
p2_stands(qb) :- tnot(p2_fault(a)).   p2_owed(b) :- p2_stands(qb).   p2_fault(b) :- p2_owed(b).

:- table p3_fault/1, p3_consistent/1, p3_bad_rest/1.
p3_rests(a,b). p3_rests(b,a).
p3_fault(P) :- p3_rests(P,Q), p3_fault(Q).
p3_bad_rest(P) :- p3_rests(P,Q), tnot(p3_consistent(Q)).
p3_consistent(P) :- member(P,[a,b]), tnot(p3_bad_rest(P)).

:- table p4_waived/0, p4_owed/0, p4_fault/0.
p4_waived :- tnot(p4_fault).
p4_owed   :- tnot(p4_waived).
p4_fault  :- p4_owed.

:- dynamic found_false/1.
:- table p5_fault/1, p5_good/0, p5_owed/0.
p5_fault(x)  :- found_false(x).
p5_fault(r2) :- p5_owed.
p5_good      :- tnot(p5_fault(x)).
p5_owed      :- tnot(p5_good).

:- table p6_fault/1, p6_good/0, p6_owed/0.
p6_fault(x)  :- p6_fault(r2).
p6_fault(r2) :- p6_owed.
p6_good      :- tnot(p6_fault(x)).
p6_owed      :- tnot(p6_good).

tv(G, V) :- ( call_delays(G, D) -> ( D == true -> V = true ; V = undefined ) ; V = false ).
show(Label, G) :- tv(G, V), format("~w~t~58|~w~n", [Label, V]).
main :-
  show('p1 question on own consistency: fault(p)', p1_fault),
  show('p2 crossed questions: fault(a)', p2_fault(a)),
  show('p2 crossed questions: fault(b)', p2_fault(b)),
  show('p3 ring, by fault: fault(a)', p3_fault(a)),
  show('p3 ring, literal: consistent(a)', p3_consistent(a)),
  show('p4 waiver on own consistency: waived', p4_waived),
  show('p4 waiver on own consistency: fault(p)', p4_fault),
  show('p5 condition upstream: good(d)', p5_good),
  show('p5 condition upstream: fault(r2)', p5_fault(r2)),
  show('p6 condition loops back: good(d)', p6_good),
  show('p6 condition loops back: fault(r2)', p6_fault(r2)).
