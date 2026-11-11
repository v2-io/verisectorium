% M0 as rules. The state-to-frontier function of 01-common-reading.md, in
% Datalog with stratified negation (clingo syntax; no choice, no aggregates).
% A "view" R is what the conventions call a line read as of a time:
%   view(R,T)      the time the state is read at
%   vis(R,B)       which branches' line events the line has
% Stored relations (written, recorded) are in a story file. Everything
% below is derived. Nothing below can be asserted from outside.

% ---------- the state of a line, as of any time up to the view's
time(T) :- write(_,T,_,_).
time(T) :- evidence(_,T,_,_,_,_).
time(T) :- view(_,T).

on(R,P,V,T)    :- write(B,T,P,V), vis(R,B), view(R,TR), T <= TR.
over(R,P,T,T1) :- on(R,P,_,T), on(R,P,_,T2), T < T2, T2 <= T1, time(T1), view(R,TR), T1 <= TR.
selat(R,T1,P,V) :- on(R,P,V,T), T <= T1, time(T1), view(R,TR), T1 <= TR, not over(R,P,T,T1).
sel(R,P,V)     :- selat(R,T,P,V), view(R,T).
selected(R,P)  :- sel(R,P,_).
once(R,P,V)    :- on(R,P,V,_).                 % the line selected V at some time

% what the write that now selects P@V was written against (recorded by the write)
selwrite(R,P,V,T) :- on(R,P,V,T), sel(R,P,V), view(R,TR), not over(R,P,T,TR).
against(R,P,V,Q,W) :- selwrite(R,P,V,T), write(B,T,P,V), vis(R,B), wrote_against(B,T,Q,W).

% ---------- the base: seen by every line, as of the view's time
known(R,E) :- evidence(E,T,_,_,_,_), view(R,TR), T <= TR.
aside(R,E) :- setaside(B,T,E), vis(R,B), view(R,TR), T <= TR.

% "same": for evidence E, versions V and W of P do not differ (symmetric, closed)
smv(E,P,V,W) :- same(E,P,V,W).
smv(E,P,W,V) :- smv(E,P,V,W).
smv(E,P,V,X) :- smv(E,P,V,W), smv(E,P,W,X).

% evidence applies, at a time T on the line
subj_ok(R,T,E) :- evidence(E,_,P,V,_,_), selat(R,T,P,V).
subj_ok(R,T,E) :- evidence(E,_,P,V,_,_), selat(R,T,P,W), smv(E,P,V,W).
read_ok(R,T,E,Q) :- reads(E,Q,W), selat(R,T,Q,W).
read_ok(R,T,E,Q) :- reads(E,Q,W), selat(R,T,Q,X), smv(E,Q,W,X).
read_bad(R,T,E) :- reads(E,Q,_), known(R,E), time(T), view(R,TR), T <= TR, not read_ok(R,T,E,Q).
appl_at(R,T,E) :- known(R,E), subj_ok(R,T,E), not read_bad(R,T,E), not aside(R,E).
applies(R,E)   :- appl_at(R,T,E), view(R,T).

% ---------- canon: reached from marked roots through non-provisional slots
root(R,A)  :- markroot(B,T,A), vis(R,B), view(R,TR), T <= TR.
canon(R,A) :- root(R,A), selected(R,A).
canon(R,Q) :- canon(R,A), sel(R,A,V), slot(A,V,Q,_,firm), selected(R,Q).

% ---------- the conditions (numbers are note 22's)
% 1. every reference reaches a selected piece
viol(R,c1_dangling(Q),P) :- canon(R,P), sel(R,P,V), pred(P,V,Q), not selected(R,Q).

% 2. every reference was written, or affirmed, against its target as it now is
affirmed(R,P,V,Q,W) :- affirm(B,T,P,V,Q,W), vis(R,B), view(R,TR), T <= TR.
reconciled(R,P,V,Q,W) :- against(R,P,V,Q,W).
reconciled(R,P,V,Q,W) :- affirmed(R,P,V,Q,W).
viol(R,c2_unreconciled(Q,W),P) :- canon(R,P), sel(R,P,V), pred(P,V,Q), sel(R,Q,W), not reconciled(R,P,V,Q,W).

% 4. nothing known wrong
finding(E,P,V,C,T) :- evidence(E,T,P,V,C,fails).
viol(R,c4_finding(E),P) :- canon(R,P), finding(E,P,_,_,_), applies(R,E).
%    guard: a finding against a version the line once selected, P now elsewhere,
%    not met by later evidence that holds on its criterion and applied when recorded
met(R,E) :- finding(E,P,_,C,T), known(R,E), evidence(E2,T2,P,_,C,holds), T < T2, appl_at(R,T2,E2).
viol(R,c4_guard(E),P) :- canon(R,P), finding(E,P,V,_,_), known(R,E), once(R,P,V), not sel(R,P,V), not aside(R,E), not met(R,E).

% 5. what its root asks: claims checked, results read whole
checked(R,P) :- applies(R,E), evidence(E,_,P,_,valid,holds).
viol(R,c5_unchecked,P) :- canon(R,P), asks_valid(P), not checked(R,P).
unread(R,E,A) :- applies(R,E), evidence(E,_,A,VA,whole,holds), sel(R,A,VA), slot(A,VA,Q,_,_), sel(R,Q,W), not reads(E,Q,W).
whole(R,A) :- applies(R,E), evidence(E,_,A,_,whole,holds), not unread(R,E,A).
viol(R,c5_not_read_whole,A) :- canon(R,A), result(A), not whole(R,A).

% 6. inner dependencies looked at together, as the fillers now are
together(R,X,VX,Y,VY) :- affirmed(R,X,VX,Y,VY).
together(R,X,VX,Y,VY) :- applies(R,E), evidence(E,_,X,VX,_,holds), reads(E,Y,VY).
viol(R,c6_not_together(X,Y),A) :- canon(R,A), inner(A,X,Y), sel(R,X,VX), sel(R,Y,VY), not together(R,X,VX,Y,VY).

% 9. a raised question has later applying evidence
raised(R,P,C,T) :- raise(B,T,P,C), vis(R,B), view(R,TR), T <= TR.
answered(R,P,C,T) :- raised(R,P,C,T), applies(R,E), evidence(E,T2,P,_,C,_), T < T2.
viol(R,c9_unanswered(C),P) :- canon(R,P), raised(R,P,C,T), not answered(R,P,C,T).

% waivers cover an item and remove nothing
waived(R,K,P) :- waive(B,T,K,P), vis(R,B), view(R,TR), T <= TR.
owed(R,K,P) :- viol(R,K,P), not waived(R,K,P).

% 5, second half. Fault: a piece owes something itself, or rests on one at fault.
% Least fixed point: a piece is at fault only for a reason.
rests(R,P,Q) :- sel(R,P,V), pred(P,V,Q).
fault(R,P) :- owed(R,_,P).
fault(R,P) :- rests(R,P,Q), fault(R,Q).
viol(R,c5_rests_outside_canon(Q),P) :- canon(R,P), rests(R,P,Q), selected(R,Q), not canon(R,Q).   % corrected after de-novo-feedback-1 finding 7: this was marked as fault and never owed
viol(R,c5_rests_on_fault(Q),P) :- canon(R,P), rests(R,P,Q), fault(R,Q).                              % a viol, so that it can be waived like any other item

stationary(R) :- view(R,_), not anything(R).
anything(R) :- owed(R,_,_).

#show owed/3.
#show stationary/1.
