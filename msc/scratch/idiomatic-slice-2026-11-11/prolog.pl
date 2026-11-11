% The slice in Prolog (SWI-Prolog 10).
% Run:  swipl -q -g main -t halt prolog.pl
%
% What a Prolog programmer would write, and why it differs from the Datalog versions beside it:
%
%   - The data is terms, and a term can contain a term. So HOLDING IS CONTAINMENT: a held
%     segment is written inside its holder, and POINTING is a name. The two ways of filling a
%     slot stop being a tag on an edge and become the difference between a thing and a
%     reference to a thing. "A held segment has one holder" needs no rule; there is nowhere
%     else for it to be. Of the three rule languages this is the only one where the instance
%     reads like the outline it describes.
%   - A slot state is a term shape: suggested(Note), promised, gap, holds(Segment),
%     points_at(Name), and provisional(Filled) wrapped round either of the last two. A
%     provisional mark on an empty slot is a term nothing matches (see well_formed/1).
%   - The kind table is facts, as in Datalog. Checking an assembly against its kind is one
%     predicate that walks the term.
%   - Canon is a walk from the roots: into what is held, and through names to what is pointed
%     at, stopping at provisional. It is TABLED, which here does one thing: two outlines that
%     point at each other would send a plain Prolog walk round for ever, and with the table
%     line it terminates. (For the instance below, which has no loop, it changes nothing.)
%   - Nothing here needed the third truth value that tabling can give; this slice has no "not"
%     that loops.
%
% What it made awkward, or leaves entirely to the writer: there are no types and no
% declarations. A slot written holds(c), with a bare name where a segment should be, is read
% without complaint; it is reported below only because I wrote well_formed/1 to say what a
% slot state is, and canon would otherwise just not reach it. Whether a wrong state is
% refused, reported or silently ignored is decided clause by clause by whoever writes the
% clause; I have made it reported (problem/1). A held assembly would need a name to be in
% canon, and the instance has none, so I left that case out. And the order of clauses and goals matters, which it does not in the
% Datalogs.

:- use_module(library(lists)).
:- table canon/1.

% ---------- the ontology: what each assembly kind's slots take, in order
veritoid_kind(claim).  veritoid_kind(step).  veritoid_kind(explanation).

slots_of(derived_result, [ formal_claim - one(claim),
                           derivation   - any_number(step),
                           description  - one(explanation),
                           eli8         - at_most_one(explanation) ]).
slots_of(outline,        [ entry        - any_number(anything) ]).

% ---------- what is written. Freestanding segments, by name; what they hold is inside them.
segment(t,
  assembly(derived_result,
    [ formal_claim - holds(veritoid(c, claim, "Every bounded monotone sequence of reals converges.")),
      derivation   - holds(veritoid(d, step,  "Take the least upper bound of the terms and show the terms come within any ε of it.")),
      description  - promised,
      eli8         - holds(veritoid(k, explanation, "If you keep stepping forward and there is a wall you cannot pass, you end up settling somewhere at or before the wall."))
    ])).

segment(uu,
  assembly(derived_result,
    [ formal_claim - holds(veritoid(u, claim, "Every Cauchy sequence of reals converges.")) ])).

segment(o,
  assembly(outline,
    [ entry - points_at(t),
      entry - provisional(points_at(uu)),
      entry - suggested("a result about series is probably wanted here"),
      entry - gap
    ])).

root(o).

% ---------- canon: what the roots reach through slots that are filled and not provisional
canon(Name)  :- root(Name).
canon(Inner) :- canon(Name), body(Name, assembly(_, Slots)), member(_ - Fill, Slots), reached(Fill, Inner).

reached(holds(veritoid(Name, _, _)), Name).
reached(points_at(Name), Name).

% the body of a named thing: a freestanding segment, or a veritoid held somewhere
body(Name, Body) :- segment(Name, Body).
body(Name, veritoid(Name, K, Text)) :- segment(_, assembly(_, Slots)), member(_ - Fill, Slots), filler(Fill, veritoid(Name, K, Text)).

filler(holds(S), S).
filler(provisional(holds(S)), S).

% ---------- questions that fall out
promised_and_empty(Name, Slot) :- segment(Name, assembly(_, Slots)), member(Slot - promised, Slots).

content(Name, Text) :- body(Name, veritoid(Name, _, Text)).

% ---------- what is wrong with a state, reported
problem(unknown_slot(Name, Slot)) :-
    segment(Name, assembly(Kind, Slots)), slots_of(Kind, Decl), member(Slot - _, Slots), \+ memberchk(Slot - _, Decl).
problem(not_a_slot_state(Name, Slot, Fill)) :-
    segment(Name, assembly(_, Slots)), member(Slot - Fill, Slots), \+ well_formed(Fill).
problem(wrong_kind(Name, Slot, wanted(Want), got(Got))) :-
    segment(Name, assembly(Kind, Slots)), slots_of(Kind, Decl), member(Slot - Fill, Slots),
    memberchk(Slot - Count, Decl), Count =.. [_, Want], Want \== anything,
    filled_with(Fill, What), kind_of(What, Got), Got \== Want.
problem(too_many(Name, Slot)) :-
    segment(Name, assembly(Kind, Slots)), slots_of(Kind, Decl), member(Slot - Count, Decl),
    ( Count = one(_) ; Count = at_most_one(_) ),
    findall(F, (member(Slot - F, Slots), filled_with(F, _)), [_, _ | _]).
problem(required_and_unmentioned(Name, Slot)) :-
    segment(Name, assembly(Kind, Slots)), slots_of(Kind, Decl), member(Slot - one(_), Decl), \+ memberchk(Slot - _, Slots).

well_formed(suggested(Note)) :- string(Note).
well_formed(promised).
well_formed(gap).
well_formed(provisional(F)) :- filled(F).
well_formed(F) :- filled(F).
filled(holds(veritoid(N, K, T))) :- atom(N), veritoid_kind(K), string(T).
filled(holds(assembly(K, S)))    :- slots_of(K, _), is_list(S).
filled(points_at(N))             :- atom(N).

filled_with(provisional(F), What) :- !, filled_with(F, What).
filled_with(holds(S), S).
filled_with(points_at(N), S) :- segment(N, S).
kind_of(veritoid(_, K, _), K).
kind_of(assembly(K, _), K).

main :-
    findall(X, canon(X), Canon0), sort(Canon0, Canon),
    format("canon: ~w~n", [Canon]),
    forall(promised_and_empty(N, S), format("promised and empty: ~w of ~w~n", [S, N])),
    forall(problem(P), format("problem: ~w~n", [P])),
    forall((member(X, Canon), content(X, T)), format("  ~w says: ~s~n", [X, T])).
