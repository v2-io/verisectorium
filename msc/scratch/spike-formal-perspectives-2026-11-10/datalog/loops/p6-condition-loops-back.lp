% As p5, but now the assumption x itself rests on r2: the condition reads its own consequence.
refuted(x) :- found_false(x).
fault(x)   :- refuted(x).
fault(x)   :- fault(r2).             % x rests on r2
good(d)    :- not fault(x).
owed(r2)   :- not good(d).
fault(r2)  :- owed(r2).
#defined found_false/1.
#show good/1. #show owed/1. #show fault/1.
