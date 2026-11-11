% One piece p in canon. A question about p that stands only while p is consistent.
% (Both builds' smallest case: one piece, one decision, "no answer at all".)
stands(q)  :- not fault(p).
owed(p)    :- stands(q).          % the question is unanswered
fault(p)   :- owed(p).
