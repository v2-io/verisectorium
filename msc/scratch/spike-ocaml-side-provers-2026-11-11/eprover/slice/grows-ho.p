% The same question in higher-order logic (THF), which E 3 also reads.
% Here canon can be said as what it is: in every set that has the roots and
% is closed under a firm step.
thf(seg, type, seg: $tType).
thf(root, type, root: seg > $o).
thf(firm1, type, firm1: seg > seg > $o).
thf(firm2, type, firm2: seg > seg > $o).
thf(closed, type, closed: (seg > seg > $o) > (seg > $o) > $o).
thf(canon, type, canon: (seg > seg > $o) > seg > $o).
thf(closed_def, axiom,
    ![F: seg > seg > $o, S: seg > $o]:
      ( (closed @ F @ S)
    <=> ( ![A: seg]: ((root @ A) => (S @ A))
        & ![A: seg, B: seg]: (((S @ A) & (F @ A @ B)) => (S @ B)) ) )).
thf(canon_def, axiom,
    ![F: seg > seg > $o, X: seg]:
      ( (canon @ F @ X) <=> ![S: seg > $o]: ((closed @ F @ S) => (S @ X)) )).
thf(more, axiom, ![A: seg, B: seg]: ((firm1 @ A @ B) => (firm2 @ A @ B))).
thf(q, conjecture, ![X: seg]: ((canon @ firm1 @ X) => (canon @ firm2 @ X))).
