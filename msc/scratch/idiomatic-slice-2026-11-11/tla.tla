-------------------------------- MODULE tla --------------------------------
(***************************************************************************)
(* The slice of ./README.md, the way TLA+ wants it.                        *)
(*                                                                         *)
(* TLA+ has no types.  Everything is a set, a function or a record, and a  *)
(* "kind" is not something the language knows about: it is a value, and    *)
(* whether a piece fits its kind is an ordinary formula that may be false. *)
(* So this file has three parts:                                           *)
(*   1. the instance, as plain values (content included);                  *)
(*   2. definitions that say WHAT canon, fitting a kind, and "promised and *)
(*      empty" are, with no algorithm for finding them;                    *)
(*   3. the part a TLA+ writer cannot leave out: what can HAPPEN to a      *)
(*      slot, and what each kind of step does to canon.  The README asks   *)
(*      for one state with no history; this part departs from it, and is   *)
(*      the only part where the language has something of its own to say.  *)
(*                                                                         *)
(* Run (TLC from tla2tools.jar v1.8.0; outputs kept as tla.out and         *)
(* tla-question.out):                                                      *)
(*   java -cp tla2tools.jar tlc2.TLC -config tla.cfg tla                   *)
(*   java -cp tla2tools.jar tlc2.TLC -config tla-question.cfg tla          *)
(* The first prints canon, the promised-and-empty slots and what does not  *)
(* fit its kind, then checks the claims of part 3 over all 256 reachable   *)
(* states.  The second is expected to end with a counterexample: the one   *)
(* step that brings u into canon.                                          *)
(*                                                                         *)
(* IDIOMS REACHED FOR, AND WHY                                             *)
(*  - Data as functions and records.  A slot's state is a record with a    *)
(*    tag, and the states have different fields (a suggestion has a note,  *)
(*    a filled slot has a segment).  There is no sum type to declare.      *)
(*  - Canon as "the smallest set closed under ...", written as exactly     *)
(*    that sentence.  TLC finds it by trying all 128 subsets of seven      *)
(*    pieces, which is the price of a definition with no algorithm in it.  *)
(*  - Fitting a kind as a set of findings, not a type.  So a piece that    *)
(*    does not fit is still there and can be talked about: U has no        *)
(*    description, and that is printed, not refused.                       *)
(*  - ASSUME, which TLC evaluates before any state exists: the nearest     *)
(*    thing TLA+ has to "just compute this".                               *)
(*  - A question asked as a claim to be refuted ("u is never in canon").   *)
(*                                                                         *)
(* DEPARTURES FROM THE SLICE AS WORDED                                     *)
(*  - A slot that is declared and simply not written (U's description) is  *)
(*    a fifth situation beside suggested, promised, gap and filled.  I     *)
(*    left absence as absence and it shows up as a finding.                *)
(*  - Part 3 has history, which the README leaves out.                     *)
(*                                                                         *)
(* AWKWARD, OR REFUSED                                                     *)
(*  - "derived-result" cannot be a record field name (the hyphen), so the  *)
(*    kinds table is built with :> and @@ where everything else is a       *)
(*    record.                                                              *)
(*  - In {e : a \in S, i \in T(a)} the second set may not mention a.  That  *)
(*    cost the first run (twenty errors) and is why two definitions go     *)
(*    through UNION.  It ran on the second attempt.                        *)
(*  - Content is a string, and a string is an atom: it can be stored,      *)
(*    compared and printed, and nothing else.                              *)
(*  - Nothing stops e.seg being asked of a promised slot.  It is an error  *)
(*    only if a run happens to evaluate it.                                *)
(*  - Honestly: parts 1 and 2 are what any language with sets would give,  *)
(*    with less checking than most.  Part 3 is the only place TLA+ adds    *)
(*    something: promising never moves canon, approving only adds to it,   *)
(*    doubting only removes from it, said in three lines and checked.      *)
(***************************************************************************)
EXTENDS Naturals, Sequences, FiniteSets, TLC

-----------------------------------------------------------------------------
(* 1. THE INSTANCE *)

\* A veritoid is a kind and a sentence.  A function from names to records.
Veritoid == [
  c |-> [kind |-> "claim",       content |-> "Every bounded monotone sequence of reals converges."],
  d |-> [kind |-> "step",        content |-> "Take the least upper bound of the terms and show the terms come within any ε of it."],
  k |-> [kind |-> "explanation", content |-> "If you keep stepping forward and there is a wall you cannot pass, you end up settling somewhere at or before the wall."],
  u |-> [kind |-> "claim",       content |-> "Every Cauchy sequence of reals converges."] ]

AssemblyKind == [T |-> "derived-result", U |-> "derived-result", O |-> "outline"]

Veritoids  == DOMAIN Veritoid
Assemblies == DOMAIN AssemblyKind
Segments   == Veritoids \cup Assemblies
KindOf(s)  == IF s \in Veritoids THEN Veritoid[s].kind ELSE AssemblyKind[s]
AllKinds   == {KindOf(s) : s \in Segments}

\* What an assembly kind declares: its slots, in order.
Declares ==
  "derived-result" :> << [slot |-> "formal-claim", takes |-> {"claim"},       count |-> "one"],
                         [slot |-> "derivation",   takes |-> {"step"},        count |-> "any number"],
                         [slot |-> "description",  takes |-> {"explanation"}, count |-> "one"],
                         [slot |-> "eli8",         takes |-> {"explanation"}, count |-> "at most one"] >>
  @@ "outline"     :> << [slot |-> "item",         takes |-> AllKinds,        count |-> "any number"] >>

\* The states of a slot are records, and they need not have the same fields.
Holds(s)        == [st |-> "holds",  seg |-> s, provisional |-> FALSE]
PointsAt(s)     == [st |-> "points", seg |-> s, provisional |-> FALSE]
Provisional(e)  == [e EXCEPT !.provisional = TRUE]
Suggested(note) == [st |-> "suggested", note |-> note]
Promised        == [st |-> "promised"]
Gap             == [st |-> "gap"]
In(slot, state) == [slot |-> slot] @@ state

\* What is written in each assembly: a sequence of (slot, state).
Slots0 == [
  T |-> << In("formal-claim", Holds("c")), In("derivation", Holds("d")),
           In("description", Promised),    In("eli8", Holds("k")) >>,
  U |-> << In("formal-claim", Holds("u")) >>,
  O |-> << In("item", PointsAt("T")),
           In("item", Provisional(PointsAt("U"))),
           In("item", Suggested("a result about series is probably wanted here")),
           In("item", Gap) >> ]
Roots0 == {"O"}

-----------------------------------------------------------------------------
(* 2. WHAT THINGS ARE.  sl is "what is written in each assembly", r the roots. *)

Filled(e)   == e.st \in {"holds", "points"}
Entries(sl, a) == {sl[a][i] : i \in DOMAIN sl[a]}
\* what an assembly passes canon on to
Reaches(sl, a) == {e.seg : e \in {x \in Entries(sl, a) : Filled(x) /\ ~x.provisional}}

\* Canon is the smallest set that contains the roots and, with each assembly,
\* everything it reaches.  This is the definition; nothing here says how to find it.
Closed(sl, r, S) == r \subseteq S /\ \A a \in S \cap Assemblies : Reaches(sl, a) \subseteq S
Canon(sl, r) == {s \in Segments : \A S \in SUBSET Segments : Closed(sl, r, S) => s \in S}

PromisedAndEmpty(sl) ==
  UNION {{<<a, sl[a][i].slot>> : i \in {j \in DOMAIN sl[a] : sl[a][j].st = "promised"}} : a \in Assemblies}

\* Fitting a kind.  Not a type: a set of findings, empty when the piece fits.
DeclIndex(a, name) ==
  CHOOSE i \in DOMAIN Declares[AssemblyKind[a]] : Declares[AssemblyKind[a]][i].slot = name
Decl(a, name) == Declares[AssemblyKind[a]][DeclIndex(a, name)]
Count(sl, a, name) == Cardinality({i \in DOMAIN sl[a] : sl[a][i].slot = name})
ShapeFindingsOf(sl, a) ==
  LET D == Declares[AssemblyKind[a]]
      W == sl[a] IN
     {<<a, D[i].slot, "declared as one, and absent">> :
        i \in {j \in DOMAIN D : D[j].count = "one" /\ Count(sl, a, D[j].slot) = 0}}
  \cup {<<a, D[i].slot, "more than the kind allows">> :
        i \in {j \in DOMAIN D : D[j].count # "any number" /\ Count(sl, a, D[j].slot) > 1}}
  \cup {<<a, W[i].slot, "filled by the wrong kind of thing">> :
        i \in {j \in DOMAIN W : Filled(W[j]) /\ KindOf(W[j].seg) \notin Decl(a, W[j].slot).takes}}
  \cup {<<a, W[i].slot, "out of the declared order">> :
        i \in {j \in DOMAIN W : j > 1 /\ DeclIndex(a, W[j].slot) < DeclIndex(a, W[j-1].slot)}}
ShapeFindings(sl) == UNION {ShapeFindingsOf(sl, a) : a \in Assemblies}

\* A held segment lives in exactly one place; a pointed-at one lives somewhere.
HeldBy(sl, s) == {a \in Assemblies : \E e \in Entries(sl, a) : e.st = "holds" /\ e.seg = s}
LivesSomewhere(sl) ==
  /\ \A s \in Segments : Cardinality(HeldBy(sl, s)) <= 1
  /\ \A a \in Assemblies : \A e \in Entries(sl, a) : Filled(e) => e.seg \in Segments

\* TLC evaluates these when the module is loaded, before any state exists.
ASSUME PrintT(<<"canon", Canon(Slots0, Roots0)>>)
ASSUME Canon(Slots0, Roots0) = {"O", "T", "c", "d", "k"}
ASSUME PrintT(<<"in canon, with content", [s \in Canon(Slots0, Roots0) \cap Veritoids |-> Veritoid[s].content]>>)
ASSUME PrintT(<<"promised and empty", PromisedAndEmpty(Slots0)>>)
ASSUME PrintT(<<"does not fit its kind", ShapeFindings(Slots0)>>)
ASSUME LivesSomewhere(Slots0)

-----------------------------------------------------------------------------
(* 3. WHAT CAN HAPPEN TO A SLOT *)

VARIABLE slots
roots == Roots0

Init == slots = Slots0

Entry(a, i) == slots[a][i]
Places == UNION {{<<a, i>> : i \in DOMAIN slots[a]} : a \in Assemblies}

\* someone inside the work says this will exist
Promise(a, i) ==
  /\ Entry(a, i).st \in {"suggested", "gap"}
  /\ slots' = [slots EXCEPT ![a][i] = In(Entry(a, i).slot, Promised)]
\* a filled slot is taken off approval, or put back on it
Approve(a, i) ==
  /\ Filled(Entry(a, i)) /\ Entry(a, i).provisional
  /\ slots' = [slots EXCEPT ![a][i].provisional = FALSE]
Doubt(a, i) ==
  /\ Filled(Entry(a, i)) /\ ~Entry(a, i).provisional
  /\ slots' = [slots EXCEPT ![a][i].provisional = TRUE]

Next == \E p \in Places : Promise(p[1], p[2]) \/ Approve(p[1], p[2]) \/ Doubt(p[1], p[2])
Spec == Init /\ [][Next]_slots

Now == Canon(slots, roots)

\* Claims about every step, not about every state.
PromisingMovesNothing == [][(\E p \in Places : Promise(p[1], p[2])) => Now' = Now]_slots
ApprovingOnlyAdds     == [][(\E p \in Places : Approve(p[1], p[2])) => Now \subseteq Now']_slots
DoubtingOnlyRemoves   == [][(\E p \in Places : Doubt(p[1], p[2]))   => Now' \subseteq Now]_slots
\* Claims about every state.
RootsAlwaysCanon      == roots \subseteq Now
StillLivesSomewhere   == LivesSomewhere(slots)
\* A question put as a claim to be refuted: "u is never in canon".
\* TLC's shortest counterexample is the fewest steps that bring u in.
UNeverCanon           == "u" \notin Now

Show == [canon |-> Now, promisedAndEmpty |-> PromisedAndEmpty(slots)]
=============================================================================
