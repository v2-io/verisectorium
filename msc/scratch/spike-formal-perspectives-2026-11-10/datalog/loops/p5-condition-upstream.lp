% Note 22 section 3.4 / impl-an-outline-fills-in step 7: a decision about r2 is good
% while a named assumption x stands. x does not rest on r2. Nothing loops back.
refuted(x) :- found_false(x).
fault(x)   :- refuted(x).
good(d)    :- not fault(x).          % the decision's condition
owed(r2)   :- not good(d).           % r2 needs the decision
fault(r2)  :- owed(r2).
#defined found_false/1.
#show good/1. #show owed/1. #show fault/1.
