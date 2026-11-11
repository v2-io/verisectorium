% The check both clingo answers named as what would show them wrong: the TLA+ fork's
% two-fork question (spike .../tla/MCForks.tla), asked in clingo, over the SAME rules that
% run the story (the spike's datalog/m0.lp, unchanged). No generator, no second model:
% a few lines of choice, and the conditions are whatever m0.lp says they are.
%
% Universe: outline o (root) points at claims c and x; x is predicated on c; both checked.
% Two forks from that checkpoint. Up to six events after it, each at its own time, each
% chosen from a small menu and (for writes) given to fork a or fork b.

% ---------- the checkpoint
asks_valid(c;x). pred(x,x0,c). pred(x,x1,c).
slot(o,o1,c,point,firm). slot(o,o1,x,point,firm).
write(s0,1,c,c0). write(s0,2,x,x0). wrote_against(s0,2,c,c0). write(s0,3,o,o1). markroot(s0,4,o).
evidence(k0,5,c,c0,valid,holds). evidence(k1,6,x,x0,valid,holds). reads(k1,c,c0).

% ---------- what may happen afterwards
#const last = 25.
when(20..last).
menu(wr(c,c1); wr(c,c2); wr(x,x1)).                         % rewrites
menu(chk(c,c1); chk(c,c2)).                                 % a check of a version of c
menu(chk(x,x0,C); chk(x,x1,C)) :- C = (c0;c1;c2).           % a check of x that read c at some version
menu(aff(x,X,C)) :- X = (x0;x1), C = (c0;c1;c2).            % x looked at beside c and kept

{ happens(T,E) : menu(E) } 1 :- when(T).
:- happens(T,_), not happens(T-1,_), when(T-1).             % no holes in time: fewer mirror images
1 { by(T,a); by(T,b) } 1 :- happens(T,wr(_,_)).
1 { by(T,a); by(T,b) } 1 :- happens(T,aff(_,_,_)).
% what a write of x says it was written against: its writer's own choice of what it saw
1 { saw(T,C) : C = (c0;c1;c2) } 1 :- happens(T,wr(x,_)).

write(F,T,P,V)            :- happens(T,wr(P,V)), by(T,F).
wrote_against(F,T,c,C)    :- happens(T,wr(x,_)), by(T,F), saw(T,C).
affirm(F,T,x,X,c,C)       :- happens(T,aff(x,X,C)), by(T,F).
evidence(e(T),T,c,V,valid,holds) :- happens(T,chk(c,V)).
evidence(e(T),T,x,X,valid,holds) :- happens(T,chk(x,X,_)).
reads(e(T),c,C)                  :- happens(T,chk(x,_,C)).

% ---------- three lines, read at the end
view(alone_a,30). vis(alone_a,s0). vis(alone_a,a).
view(alone_b,30). vis(alone_b,s0). vis(alone_b,b).
view(both,30).    vis(both,s0).    vis(both,a). vis(both,b).

% honesty of the forks: a writer can only have seen what its own line had when it wrote
:- happens(T,wr(x,_)), by(T,F), saw(T,C), F = a, not selat(alone_a,T,c,C).
:- happens(T,wr(x,_)), by(T,F), saw(T,C), F = b, not selat(alone_b,T,c,C).
% nobody checks, or looks at, a version before somebody has written it; and a fork can only
% affirm what its own line has in front of it
time(T) :- when(T).      % so that "what the line had at T" is defined at an affirmation's time too (without this line every affirmation was silently forbidden: second run)
written_by(T,P,V) :- write(_,T,P,V).
:- happens(T,chk(c,V)),   not written_before(T,c,V).
:- happens(T,chk(x,X,C)), not written_before(T,x,X).
:- happens(T,chk(x,X,C)), not written_before(T,c,C).
written_before(T,P,V) :- when(T), written_by(T0,P,V), T0 < T.
:- happens(T,aff(x,X,C)), by(T,a), not selat(alone_a,T,x,X).
:- happens(T,aff(x,X,C)), by(T,a), not selat(alone_a,T,c,C).
:- happens(T,aff(x,X,C)), by(T,b), not selat(alone_b,T,x,X).
:- happens(T,aff(x,X,C)), by(T,b), not selat(alone_b,T,c,C).
% each fork did something, and each could close alone
:- not by(_,a).  :- not by(_,b).
:- not stationary(alone_a).  :- not stationary(alone_b).

#minimize { 1,T : happens(T,_) }.
#show.
#show does(T,E,F) : happens(T,E), by(T,F).
#show does(T,E,base) : happens(T,E), not by(T,_).
#show saw/2.
#show owed(K,P) : owed(both,K,P).
#show union_stationary : stationary(both).
#defined same/4. #defined setaside/3. #defined raise/4. #defined waive/4. #defined inner/3. #defined result/1.
