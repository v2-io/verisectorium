% M0 again, same function, written so that the rule graph can tell good news from bad.
% Two changes of form and none of content (checked: same frontier on the story, see bridge.lp):
%  - a description of a piece of evidence (what it is about, what it read, when) is
%    vocabulary: evd/5, reads/3. That it was RECORDED is the event: rec_h (it holds), rec_f (it fails).
%    Likewise same_h / same_f, setaside_h / setaside_f, and a question's description qd/4 versus rec_raise/2.
%  - every rule that carried evidence is written once for each.
time(T) :- write(_,T,_,_).
time(T) :- evd(_,T,_,_,_).
time(T) :- view(_,T).
on(R,P,V,T)    :- write(B,T,P,V), vis(R,B), view(R,TR), T <= TR.
over(R,P,T,T1) :- on(R,P,_,T), on(R,P,_,T2), T < T2, T2 <= T1, time(T1), view(R,TR), T1 <= TR.
selat(R,T1,P,V) :- on(R,P,V,T), T <= T1, time(T1), view(R,TR), T1 <= TR, not over(R,P,T,T1).
sel(R,P,V)     :- selat(R,T,P,V), view(R,T).
selected(R,P)  :- sel(R,P,_).
once(R,P,V)    :- on(R,P,V,_).
selwrite(R,P,V,T) :- on(R,P,V,T), sel(R,P,V), view(R,TR), not over(R,P,T,TR).
against(R,P,V,Q,W) :- selwrite(R,P,V,T), write(B,T,P,V), vis(R,B), wrote_against(B,T,Q,W).

known_h(R,E) :- rec_h(E), evd(E,T,_,_,_), view(R,TR), T <= TR.
known_f(R,E) :- rec_f(E), evd(E,T,_,_,_), view(R,TR), T <= TR.
aside_h(R,E) :- setaside_h(B,T,E), vis(R,B), view(R,TR), T <= TR.
aside_f(R,E) :- setaside_f(B,T,E), vis(R,B), view(R,TR), T <= TR.
smv_h(E,P,V,W) :- same_h(E,P,V,W).   smv_h(E,P,W,V) :- smv_h(E,P,V,W).   smv_h(E,P,V,X) :- smv_h(E,P,V,W), smv_h(E,P,W,X).
smv_f(E,P,V,W) :- same_f(E,P,V,W).   smv_f(E,P,W,V) :- smv_f(E,P,V,W).   smv_f(E,P,V,X) :- smv_f(E,P,V,W), smv_f(E,P,W,X).

subj_ok_h(R,T,E) :- evd(E,_,P,V,_), selat(R,T,P,V).
subj_ok_h(R,T,E) :- evd(E,_,P,V,_), selat(R,T,P,W), smv_h(E,P,V,W).
read_ok_h(R,T,E,Q) :- reads(E,Q,W), selat(R,T,Q,W).
read_ok_h(R,T,E,Q) :- reads(E,Q,W), selat(R,T,Q,X), smv_h(E,Q,W,X).
read_bad_h(R,T,E) :- reads(E,Q,_), time(T), view(R,TR), T <= TR, not read_ok_h(R,T,E,Q).
appl_at_h(R,T,E) :- known_h(R,E), subj_ok_h(R,T,E), not read_bad_h(R,T,E), not aside_h(R,E).
applies_h(R,E)   :- appl_at_h(R,T,E), view(R,T).

subj_ok_f(R,T,E) :- evd(E,_,P,V,_), selat(R,T,P,V).
subj_ok_f(R,T,E) :- evd(E,_,P,V,_), selat(R,T,P,W), smv_f(E,P,V,W).
read_ok_f(R,T,E,Q) :- reads(E,Q,W), selat(R,T,Q,W).
read_ok_f(R,T,E,Q) :- reads(E,Q,W), selat(R,T,Q,X), smv_f(E,Q,W,X).
read_bad_f(R,T,E) :- reads(E,Q,_), time(T), view(R,TR), T <= TR, not read_ok_f(R,T,E,Q).
appl_at_f(R,T,E) :- known_f(R,E), subj_ok_f(R,T,E), not read_bad_f(R,T,E), not aside_f(R,E).
applies_f(R,E)   :- appl_at_f(R,T,E), view(R,T).

root(R,A)  :- markroot(B,T,A), vis(R,B), view(R,TR), T <= TR.
canon(R,A) :- root(R,A), selected(R,A).
canon(R,Q) :- canon(R,A), sel(R,A,V), slot(A,V,Q,_,firm), selected(R,Q).

viol(R,c1_dangling(Q),P) :- canon(R,P), sel(R,P,V), pred(P,V,Q), not selected(R,Q).
affirmed(R,P,V,Q,W) :- affirm(B,T,P,V,Q,W), vis(R,B), view(R,TR), T <= TR.
reconciled(R,P,V,Q,W) :- against(R,P,V,Q,W).
reconciled(R,P,V,Q,W) :- affirmed(R,P,V,Q,W).
viol(R,c2_unreconciled(Q,W),P) :- canon(R,P), sel(R,P,V), pred(P,V,Q), sel(R,Q,W), not reconciled(R,P,V,Q,W).

viol(R,c4_finding(E),P) :- canon(R,P), evd(E,_,P,_,_), applies_f(R,E).
met(R,E) :- evd(E,T,P,_,C), evd(E2,T2,P,_,C), T < T2, appl_at_h(R,T2,E2).
viol(R,c4_guard(E),P) :- canon(R,P), evd(E,_,P,V,_), known_f(R,E), once(R,P,V), not sel(R,P,V), not aside_f(R,E), not met(R,E).

checked(R,P) :- applies_h(R,E), evd(E,_,P,_,valid).
viol(R,c5_unchecked,P) :- canon(R,P), asks_valid(P), not checked(R,P).
unread(R,E,A) :- evd(E,_,A,VA,whole), sel(R,A,VA), slot(A,VA,Q,_,_), sel(R,Q,W), not reads(E,Q,W).
whole(R,A) :- applies_h(R,E), evd(E,_,A,_,whole), not unread(R,E,A).
viol(R,c5_not_read_whole,A) :- canon(R,A), result(A), not whole(R,A).

together(R,X,VX,Y,VY) :- affirmed(R,X,VX,Y,VY).
together(R,X,VX,Y,VY) :- applies_h(R,E), evd(E,_,X,VX,_), reads(E,Y,VY).
together(R,X,VX,Y,VY) :- against(R,X,VX,Y,VY).
viol(R,c6_not_together(X,Y),A) :- canon(R,A), inner(A,X,Y), sel(R,X,VX), sel(R,Y,VY), not together(R,X,VX,Y,VY).

raised(R,Q) :- rec_raise(B,Q), qd(Q,T,_,_), vis(R,B), view(R,TR), T <= TR.
answered(R,Q) :- qd(Q,T,P,C), applies_h(R,E), evd(E,T2,P,_,C), T < T2.
answered(R,Q) :- qd(Q,T,P,C), applies_f(R,E), evd(E,T2,P,_,C), T < T2.
viol(R,c9_unanswered(C),P) :- canon(R,P), raised(R,Q), qd(Q,_,P,C), not answered(R,Q).

waived(R,K,P) :- waive(B,T,K,P), vis(R,B), view(R,TR), T <= TR.
owed(R,K,P) :- viol(R,K,P), not waived(R,K,P).
rests(R,P,Q) :- sel(R,P,V), pred(P,V,Q).
fault(R,P) :- owed(R,_,P).
fault(R,P) :- rests(R,P,Q), fault(R,Q).
fault(R,P) :- canon(R,P), rests(R,P,Q), selected(R,Q), not canon(R,Q).
owed(R,c5_rests_on_fault(Q),P) :- canon(R,P), rests(R,P,Q), fault(R,Q).
stationary(R) :- view(R,_), not anything(R).
anything(R) :- owed(R,_,_).
#show owed/3.
#show stationary/1.
