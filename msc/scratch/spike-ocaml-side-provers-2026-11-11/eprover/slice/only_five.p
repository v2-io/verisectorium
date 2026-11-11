include('axioms.ax').
tff(only_five, conjecture, ![X: seg]: (canon(X) => (X = o | X = t | X = c | X = d | X = k))).
