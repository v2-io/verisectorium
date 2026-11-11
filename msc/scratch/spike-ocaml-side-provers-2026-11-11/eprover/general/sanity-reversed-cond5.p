% Sanity: the reverse of good news for condition 5 is false of the model
% (new evidence can clear something owed), so this must NOT come back Theorem.
include('two-worlds.ax').
tff(reversed, conjecture, ![P: piece]: ( owed1(cond5, P) => owed2(cond5, P) )).
