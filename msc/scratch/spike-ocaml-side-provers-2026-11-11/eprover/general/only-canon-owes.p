% For EVERY state: a piece that is not in canon owes nothing.
include('../m0/m0.ax').
tff(only_canon_owes, conjecture, ![C: cond, P: piece]: ( owed(C, P) => canon(P) )).
