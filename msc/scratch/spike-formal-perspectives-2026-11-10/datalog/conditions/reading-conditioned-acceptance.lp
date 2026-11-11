% Note 22 section 3.4 inside M0: a decision with a condition. A root may ask of a piece that it
% be accepted; an acceptance is good while every piece its conditions name is not at fault.
% This makes fault depend on the absence of fault, which a stratified engine refuses outright.
accepted_now(R,D,P) :- accept(B,T,D,P), vis(R,B), view(R,TR), T <= TR.
cond_fails(R,D) :- accepted_now(R,D,_), cond(D,X), fault(R,X).
good(R,D) :- accepted_now(R,D,_), not cond_fails(R,D).
has_good(R,P) :- accepted_now(R,D,P), good(R,D).
viol(R,c5_acceptance_not_good,P) :- canon(R,P), asks_accepted(P), not has_good(R,P).
#show good/2.
