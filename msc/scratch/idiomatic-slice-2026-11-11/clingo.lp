% The slice in clingo (answer-set programming).
% Run:  clingo clingo.lp                 the state as written
%       clingo clingo.lp -c ask=1 0      and: what would canon be under each way of confirming provisional slots?
%
% What is idiomatic here, and what I reached for:
%   - Terms inside facts. A slot's state is written the way a person would say it:
%         slot(o, 2, points_at(uu, provisional)).      slot(o, 3, suggested("...")).
%     Nothing is declared. There are no types; the shape of a term is its own description.
%   - Canon is the same two recursive lines as in any Datalog.
%   - Two different ways to be wrong, and the language has a native form for each:
%       a REFUSAL is an integrity constraint (a line beginning ":-"). A state that breaks one
%         has no answer at all: clingo prints UNSATISFIABLE. I used it for what cannot be a
%         state under this slice: a segment held in two places.
%       an OWED thing is an ordinary derived fact. A claim sitting in the eli8 slot, or a
%         required slot nobody has mentioned, is a state, with something to say about it.
%     Sorting each sentence of the model into one or the other is the decision this language
%     makes you take, and it takes one character to change your mind.
%   - Choice. "Suppose some provisional slots were confirmed" is a statement, not a program:
%     one line in braces, and clingo lists every resulting canon. Nothing else here can ask
%     that so cheaply.
% What it made awkward or left unguarded: a misspelled relation is not an error (it is empty,
%   and an empty `canon` looks like a small canon). Slot order is a number I carry by hand.
%   Holding is a tag on an edge, not containment; hence the constraint below.

% ---------- the ontology
veritoid_kind(claim; step; explanation).
slot_of(derived_result, 1, formal_claim, of(claim),       one).
slot_of(derived_result, 2, derivation,   of(step),        any_number).
slot_of(derived_result, 3, description,  of(explanation), one).
slot_of(derived_result, 4, eli8,         of(explanation), at_most_one).
slot_of(outline,        1, entry,        anything,        any_number).

% ---------- what is written
veritoid(c, claim,       "Every bounded monotone sequence of reals converges.").
veritoid(d, step,        "Take the least upper bound of the terms and show the terms come within any ε of it.").
veritoid(k, explanation, "If you keep stepping forward and there is a wall you cannot pass, you end up settling somewhere at or before the wall.").
veritoid(u, claim,       "Every Cauchy sequence of reals converges.").

assembly(t, derived_result).
slot(t, formal_claim, holds(c, firm)).
slot(t, derivation,   holds(d, firm)).
slot(t, description,  promised).
slot(t, eli8,         holds(k, firm)).

assembly(uu, derived_result).
slot(uu, formal_claim, holds(u, firm)).

assembly(o, outline).
slot(o, entry(1), points_at(t,  firm)).
slot(o, entry(2), points_at(uu, provisional)).
slot(o, entry(3), suggested("a result about series is probably wanted here")).
slot(o, entry(4), gap).
root(o).

% ---------- computed
kind_of(S, K) :- veritoid(S, K, _).
kind_of(S, K) :- assembly(S, K).
name(entry(N), entry) :- slot(_, entry(N), _).        % an outline's numbered entries are all the one declared slot
name(N, N)                :- slot(_, N, _), slot_of(_, _, N, _, _).

fills(A, N, S, How) :- slot(A, N, holds(S, How)).
fills(A, N, S, How) :- slot(A, N, points_at(S, How)).
firm(A, N, S) :- fills(A, N, S, firm).
firm(A, N, S) :- fills(A, N, S, provisional), confirmed(A, N).

canon(A) :- root(A).
canon(S) :- canon(A), firm(A, _, S).

promised_and_empty(A, N) :- slot(A, N, promised).

% ---------- owed: a state, with something wrong in it
misfilled(A, N, S, wanted(Want), got(Got)) :-
    assembly(A, AK), slot_of(AK, _, D, of(Want), _), name(N, D), fills(A, N, S, _), kind_of(S, Got), Got != Want.
overfilled(A, D) :-
    assembly(A, AK), slot_of(AK, _, D, _, (one; at_most_one)), 2 { fills(A, N, S, _) : name(N, D) }.
required_and_unmentioned(A, D) :-
    assembly(A, AK), slot_of(AK, _, D, _, one), not slot(A, D, _).

% ---------- refused: not a state at all
:- slot(A1, N1, holds(S, _)), slot(A2, N2, holds(S, _)), (A1, N1) < (A2, N2).     % held in two places
:- slot(A, _, _), not assembly(A, _).                                             % a slot of nothing

% ---------- asked: what if some provisional slots were confirmed?
#const ask = 0.
{ confirmed(A, N) : fills(A, N, _, provisional) } :- ask = 1.

#show canon/1.
#show promised_and_empty/2.
#show required_and_unmentioned/2.
#show misfilled/5.
#show overfilled/2.
#show confirmed/2.
