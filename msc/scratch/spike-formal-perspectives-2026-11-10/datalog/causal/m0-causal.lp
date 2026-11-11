% M0 with one change of footing: no rule reads where an event sits in a line.
% Every write records what its writer saw: the write it replaces (replaces/2), what its
% references pointed at and what it was made beside (wrote_against/3). Which version is
% selected is then "written and not replaced", not "written last by the clock"; and a guard
% is about a piece's own chain of writes and about evidence ABOUT versions.
% Times remain on events, and are used for one thing only: which events a view has yet
% ("as of"). Nothing compares the times of two events on a line.

% ---------- the line as a set of events; the base as of the view's time
onw(R,W)      :- write(B,W,_,_), wtime(W,T), vis(R,B), view(R,TR), T <= TR.
replaced(R,W0):- onw(R,W), replaces(W,W0).
head(R,W)     :- onw(R,W), not replaced(R,W).
sel(R,P,V)    :- head(R,W), write(_,W,P,V).
selected(R,P) :- sel(R,P,_).
against(R,P,V,Q,VQ) :- head(R,W), write(_,W,P,V), wrote_against(W,Q,VQ).
anc(R,W,W0)   :- onw(R,W), replaces(W,W0), onw(R,W0).
anc(R,W,W0)   :- anc(R,W,W1), anc(R,W1,W0).
chain(R,W,W)  :- head(R,W).                     % the head and everything it descends from
chain(R,W,W0) :- head(R,W), anc(R,W,W0).

known(R,E) :- evidence(E,T,_,_,_,_), view(R,TR), T <= TR.
aside(R,E) :- setaside(B,T,E), vis(R,B), view(R,TR), T <= TR.
smv(E,P,V,W) :- same(E,P,V,W).   smv(E,P,W,V) :- smv(E,P,V,W).   smv(E,P,V,X) :- smv(E,P,V,W), smv(E,P,W,X).
subj_ok(R,E) :- evidence(E,_,P,V,_,_), sel(R,P,V).
subj_ok(R,E) :- evidence(E,_,P,V,_,_), sel(R,P,W), smv(E,P,V,W).
read_ok(R,E,Q) :- reads(E,Q,W), sel(R,Q,W).
read_ok(R,E,Q) :- reads(E,Q,W), sel(R,Q,X), smv(E,Q,W,X).
read_bad(R,E) :- reads(E,Q,_), known(R,E), not read_ok(R,E,Q).
applies(R,E)  :- known(R,E), subj_ok(R,E), not read_bad(R,E), not aside(R,E).

root(R,A)  :- markroot(B,T,A), vis(R,B), view(R,TR), T <= TR.
canon(R,A) :- root(R,A), selected(R,A).
canon(R,Q) :- canon(R,A), sel(R,A,V), slot(A,V,Q,_,firm), selected(R,Q).

% ---------- the conditions
% 0. new, and only sayable on this footing: one piece, two versions, neither replacing the other
viol(R,c0_two_versions(V1,V2),P) :- canon(R,P), sel(R,P,V1), sel(R,P,V2), V1 < V2.
viol(R,c1_dangling(Q),P) :- canon(R,P), sel(R,P,V), pred(P,V,Q), not selected(R,Q).
affirmed(R,P,V,Q,W) :- affirm(B,T,P,V,Q,W), vis(R,B), view(R,TR), T <= TR.
reconciled(R,P,V,Q,W) :- against(R,P,V,Q,W).
reconciled(R,P,V,Q,W) :- affirmed(R,P,V,Q,W).
viol(R,c2_unreconciled(Q,W),P) :- canon(R,P), sel(R,P,V), pred(P,V,Q), sel(R,Q,W), not reconciled(R,P,V,Q,W).

finding(E,P,V,C) :- evidence(E,_,P,V,C,fails).
viol(R,c4_finding(E),P) :- canon(R,P), finding(E,P,_,_), applies(R,E).
%    guard. A write of the finding's version lies behind the head, and no write after it on
%    the way to the head made a version that evidence, by the finding's criterion, holds OF.
hit(R,E,Wh,W0) :- finding(E,P,V0,_), known(R,E), not aside(R,E), head(R,Wh), write(_,Wh,P,Vh), Vh != V0,
                  chain(R,Wh,W0), write(_,W0,P,V0).
after(R,Wh,W0,W1) :- hit(R,_,Wh,W0), chain(R,Wh,W1), anc(R,W1,W0).
metc(R,E,Wh,W0) :- hit(R,E,Wh,W0), finding(E,P,_,C), after(R,Wh,W0,W1), write(_,W1,P,V1),
                   evidence(E2,_,P,V1,C,holds), known(R,E2), not aside(R,E2).
viol(R,c4_guard(E),P) :- canon(R,P), finding(E,P,_,_), hit(R,E,Wh,W0), not metc(R,E,Wh,W0).

checked(R,P) :- applies(R,E), evidence(E,_,P,_,valid,holds).
viol(R,c5_unchecked,P) :- canon(R,P), asks_valid(P), not checked(R,P).
unread(R,E,A) :- applies(R,E), evidence(E,_,A,VA,whole,holds), sel(R,A,VA), slot(A,VA,Q,_,_), sel(R,Q,W), not reads(E,Q,W).
whole(R,A) :- applies(R,E), evidence(E,_,A,_,whole,holds), not unread(R,E,A).
viol(R,c5_not_read_whole,A) :- canon(R,A), result(A), not whole(R,A).

together(R,X,VX,Y,VY) :- affirmed(R,X,VX,Y,VY).
together(R,X,VX,Y,VY) :- applies(R,E), evidence(E,_,X,VX,_,holds), reads(E,Y,VY).
together(R,X,VX,Y,VY) :- against(R,X,VX,Y,VY).
viol(R,c6_not_together(X,Y),A) :- canon(R,A), inner(A,X,Y), sel(R,X,VX), sel(R,Y,VY), not together(R,X,VX,Y,VY).

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
#defined same/4. #defined setaside/3. #defined waive/4. #defined inner/3. #defined result/1. #defined pred/3.
#defined affirm/6. #defined wrote_against/3. #defined reads/3. #defined replaces/2. #defined asks_valid/1.
