% Two pieces that rest on each other, nothing wrong with either. (R7's ring.)
piece(a;b). rests(a,b). rests(b,a).
% fault, as a least fixed point: at fault only for a reason
fault(P) :- owed(P).
fault(P) :- rests(P,Q), fault(Q).
ok_by_fault(P) :- piece(P), not fault(P).
% note 22's condition 5 transcribed literally as a rule ("rests only on pieces
% that are themselves consistent"), which Datalog reads as a LEAST fixed point
bad_rest(P) :- rests(P,Q), not consistent(Q).
consistent(P) :- piece(P), not owed(P), not bad_rest(P).
#defined owed/1.
#show ok_by_fault/1. #show consistent/1. #show fault/1.
