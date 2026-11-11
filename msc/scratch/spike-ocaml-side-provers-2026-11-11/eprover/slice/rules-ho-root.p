% Part of rules-ho.p: a root is in canon
thf(seg, type, seg: $tType).
thf(root, type, root: seg > $o).
thf(firm, type, firm: seg > seg > $o).
thf(closed, type, closed: (seg > $o) > $o).
thf(canon, type, canon: seg > $o).
thf(closed_def, axiom,
    ![S: seg > $o]:
      ( (closed @ S)
    <=> ( ![A: seg]: ((root @ A) => (S @ A))
        & ![A: seg, B: seg]: (((S @ A) & (firm @ A @ B)) => (S @ B)) ) )).
thf(canon_def, axiom, ![X: seg]: ( (canon @ X) <=> ![S: seg > $o]: ((closed @ S) => (S @ X)) )).
thf(q, conjecture, ![A: seg]: ((root @ A) => (canon @ A))).
