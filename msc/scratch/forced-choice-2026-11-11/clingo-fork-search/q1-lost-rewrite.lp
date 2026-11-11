% Is there a pair of forks that each rewrite c to a different version, each able to close
% alone, whose union is stationary? (The TLA+ fork's lost rewrite.)
:- not stationary(both).
:- not 1 { write(a,_,c,_) }.  :- not 1 { write(b,_,c,_) }.
:- write(a,_,c,V), write(b,_,c,V).
