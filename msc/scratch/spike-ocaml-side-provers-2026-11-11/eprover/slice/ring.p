% "Nothing else is in canon", as first-order logic can say it, against a ring.
% One segment, x, not a root, pointing firmly at itself. By the two rules it
% is not in canon. Is that provable from "whatever is in canon has a reason"?
tff(seg, type, seg: $tType).
tff(firm, type, firm: (seg * seg) > $o).
tff(canon, type, canon: seg > $o).
tff(root, type, root: seg > $o).
tff(x, type, x: seg).
tff(canon_root, axiom, ![A: seg]: ( root(A) => canon(A) )).
tff(canon_step, axiom, ![A: seg, S: seg]: ( (canon(A) & firm(A, S)) => canon(S) )).
tff(canon_only, axiom, ![S: seg]: ( canon(S) => ( root(S) | ?[A: seg]: (canon(A) & firm(A, S)) ) )).
tff(firm_exactly, axiom, ![A: seg, S: seg]: ( firm(A, S) <=> (A = x & S = x) )).
tff(no_roots, axiom, ![A: seg]: ~ root(A)).
tff(q, conjecture, ~ canon(x)).
