% For EVERY state: while a finding applies to a piece in canon, the state is not stationary.
include('../m0/m0.ax').
tff(finding_blocks, conjecture,
    ![E: ev, P: piece, V: ver, C: crit]: ( (canon(P) & evid(E, P, V, C, fails) & applies(E)) => ~ stationary )).
