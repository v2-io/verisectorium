% For ANY store: with the same roots, if every firm step of the first store
% is a firm step of the second (a provisional slot was confirmed, say), is
% everything in the first canon in the second? True of the model. Asked here
% with each canon given by the two rules and "whatever is in canon has a
% reason".
tff(seg, type, seg: $tType).
tff(root, type, root: seg > $o).
tff(firm1, type, firm1: (seg * seg) > $o).  tff(firm2, type, firm2: (seg * seg) > $o).
tff(canon1, type, canon1: seg > $o).        tff(canon2, type, canon2: seg > $o).
tff(r1, axiom, ![A: seg]: ( root(A) => canon1(A) )).
tff(s1, axiom, ![A: seg, S: seg]: ( (canon1(A) & firm1(A, S)) => canon1(S) )).
tff(o1, axiom, ![S: seg]: ( canon1(S) => ( root(S) | ?[A: seg]: (canon1(A) & firm1(A, S)) ) )).
tff(r2, axiom, ![A: seg]: ( root(A) => canon2(A) )).
tff(s2, axiom, ![A: seg, S: seg]: ( (canon2(A) & firm2(A, S)) => canon2(S) )).
tff(o2, axiom, ![S: seg]: ( canon2(S) => ( root(S) | ?[A: seg]: (canon2(A) & firm2(A, S)) ) )).
tff(more, axiom, ![A: seg, S: seg]: ( firm1(A, S) => firm2(A, S) )).
tff(q, conjecture, ![S: seg]: ( canon1(S) => canon2(S) )).
