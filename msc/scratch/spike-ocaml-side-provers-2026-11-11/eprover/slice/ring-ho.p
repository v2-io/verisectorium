% The ring again, in higher-order logic, with canon said as what it is.
thf(seg, type, seg: $tType).
thf(root, type, root: seg > $o).
thf(firm, type, firm: seg > seg > $o).
thf(x, type, x: seg).
thf(closed, type, closed: (seg > $o) > $o).
thf(canon, type, canon: seg > $o).
thf(closed_def, axiom,
    ![S: seg > $o]:
      ( (closed @ S)
    <=> ( ![A: seg]: ((root @ A) => (S @ A))
        & ![A: seg, B: seg]: (((S @ A) & (firm @ A @ B)) => (S @ B)) ) )).
thf(canon_def, axiom, ![X: seg]: ( (canon @ X) <=> ![S: seg > $o]: ((closed @ S) => (S @ X)) )).
thf(firm_exactly, axiom, ![A: seg, B: seg]: ( (firm @ A @ B) <=> ((A = x) & (B = x)) )).
thf(no_roots, axiom, ![A: seg]: ~ (root @ A)).
thf(q, conjecture, ~ (canon @ x)).
