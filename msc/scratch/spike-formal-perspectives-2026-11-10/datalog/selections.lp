% Not a line: a free choice of one version for each piece, among the versions ever written
% on any line, judged by M0 with everything in the base as of a time. This is the question
% an assumption-based truth maintenance system keeps answered: under what is known, which
% combinations of existing versions could a verisectorium rest at?
% A free selection has no history, so no guards: a finding counts only against the exact
% version it is about. (That is draft 3's reading, and its known cost.)
ever(P,V) :- write(_,T,P,V), view(free,TF), T <= TF.
piece_(P) :- ever(P,_).
1 { sel(free,P,V) : ever(P,V) } 1 :- piece_(P).
selat(free,T,P,V) :- sel(free,P,V), view(free,T).
% what a version was written against is a fact about the write that made it
against(free,P,V,Q,W) :- sel(free,P,V), write(B,T,P,V), wrote_against(B,T,Q,W).
% decisions are taken from every line (there is no line here to belong to)
affirmed(free,P,V,Q,W) :- affirm(_,T,P,V,Q,W), view(free,TF), T <= TF.
root(free,A) :- markroot(_,_,A).
:- not stationary(free).
#show.
#show sel(P,V) : sel(free,P,V).
