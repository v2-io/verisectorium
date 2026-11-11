# Twelve formal languages and tools tried on the model, side by side

*Promoted from `msc/scratch/` to a numbered note on 2026-11-11 at Joseph's word ("put the language results, when all ready, as a numbered note instead of leaving it in scratch"). Every path below that is not otherwise rooted is relative to `msc/scratch/`. Sections 1 to 8 are about the first eight; section 9 adds Rocq, Why3, Cameleer and E.*

*2026-11-10/11, assembled by the lead (Fable 5.2) for Joseph, who asked for "a bigger table that separates those out and adds ocaml + ada". Scratch; nothing here is adjudicated.*

*What each cell rests on. Every language's column comes from the note of the one mind that used it on this model, read whole by me: `kernel-2/ocaml/AS-A-HOME.md` and `kernel-2/ada/AS-A-HOME.md` (the two builders, each of whom built kernel spec drafts 3 and 4); `spike-formal-perspectives-2026-11-10/lean/`, `alloy/`, `tla/AS-A-HOME.md` (the spike's three forks); and `07-datalog-family-apart.md` (the spike lead, for Soufflé, clingo and tabled Prolog). Where a cell is my own reading of code (I read `ocaml/lib/model.ml`, `ada/src/vk.ads` and `ada/src/vk-model.ads` whole and nothing else of either build) it is marked (lead). Where the independent read of the spike (`de-novo-feedback-1.md`) qualifies a claim, the cell carries the qualification and is marked (audit).*

*Limits that apply to every row. One evening per language and one mind each, all the same model family. The two builders worked on the kernel spec; the six spike columns worked on a much smaller model (no warrant levels, no descent, one root). Only the two builders have carried anything across a change to the spec. The Ada builder read nobody else's note; the OCaml builder read the spike lead's `06` and not the forks'.*

## 1. Where each one lands, in its user's words

| language | as the home for the model's formal layer | what it is right for |
|---|---|---|
| **OCaml** | "not alone" | "the formal layer's executable reference and its counterexample search" |
| **Ada / SPARK** | "Not alone, and not first." | "the kernel once its shape has settled, and above all the claims of the form 'for every ontology, under this named condition'" |
| **Lean 4** | "As one part of a combination, and a specific part. Not as the home." | "the definitions that have to have exactly one reading, and the few statements about them worth proving for every state" |
| **Soufflé** (strict Datalog) | "yes, as far as I have now seen, while decisions stay unconditional" | "being the one copy that runs, is checked for names, and explains itself" |
| **clingo** (answer sets) | "as the workbench beside it, not as the copy of record" | "trying a reading of the spec in two lines beside another; finding out whether a rule loops; searching small spaces" |
| **SWI-Prolog, tabled** | "cannot say; I did not run the model in it" | giving a third value, *undefined*, to a condition that loops (on six toy programs) |
| **Alloy 6** | "Not as the home. Yes, and gladly, as the instrument you point at a sentence before you believe it." | asking for a small world in which a proposed general sentence about the model is false |
| **TLA+** | "no"; as a standing part, "I lean no" | "an instrument picked up for a question about orders of steps" |

Datalog itself is a language and a guarantee (one answer, always terminates, order does not matter, provided no rule depends on the absence of something that depends on it). Soufflé, clingo and tabled Prolog are three engines that agree wherever that proviso holds and differ where it is broken: Soufflé refuses, clingo lists every self-consistent answer (possibly none, possibly several), tabled Prolog answers *undefined*.

## 2. How the model sits in each

| | what is stored (pieces, slots, events) | the conditions | can a reader check them against note 22 by reading? |
|---|---|---|---|
| **OCaml** | about 150 lines of sum and record types; a slot is `Empty \| Holds \| Points` with a provisional flag; one constructor per kind of event and per kind of owed item. But ids, versions, events and dimensions are all `int` | one 140-line function, organized by kind of piece, numbered as the spec and not as the note | "As it stands, a reader cannot." A trial pulled four of the nine out as one function per sentence (88 lines) and it agreed with the original on 163,840 lines; the builder expects the other five to be harder |
| **Ada / SPARK** | bounded tables: five pieces, three versions, twelve evidence facts; one flat record for every kind of decision; no "veritoid or assembly" type, a number says which (lead) | one named function per kind of owed item, written with "for all" and "for some"; these are also the contracts the proofs are about | closest of the two builds (lead): each condition has a name and reads as logic. Narrower than the spec in ways listed under `DEPARTS:` |
| **Lean 4** | sum types; in one trial the kind of filler and how many are in the slot's type, with suggested, promised and gap as values | a 246-line function with the bookkeeping by hand | yes for the definitions; the proofs "cannot be read, only re-run" |
| **Soufflé** | a typed declaration per relation (53 for 55 rules): "the stored vocabulary written down once and checked" | rules, one per sentence. Six of the nine conditions (audit); the three about how well something stands were not written | yes, for those six |
| **clingo** | nothing declared | the same rules | yes, for those six |
| **Prolog, tabled** | nothing declared | not written for the model | |
| **Alloy 6** | signatures, "the closest thing to core's KDL blocks that I saw tonight, and they are checked" | relations and three closures, no recursion | yes; "the most readable picture for someone who is not a programmer" |
| **TLA+** | untyped records and sets | 75 of 245 lines, "mathematics with no one checking it" | readable, checked by nothing |

## 3. What each can do

| | run a state and say what is owed | find a counterexample to a general sentence | prove something of every state | say why an item is owed |
|---|---|---|---|---|
| **OCaml** | yes, fast: tens of millions of small states in minutes | yes, by a generator and a check written by hand; the witness prints itself and is not shrunk | no | no |
| **Ada / SPARK** | yes | not from the prover ("says yes or it says nothing"); a 1,200-line random search written by hand | **yes**, for every ontology of the bounded types: 656 checks, including that what is owed about a set of pieces depends on nothing outside what they read. The layer that reads a state from events is not proved | no |
| **Lean 4** | yes, slowly (about a second for eight pieces) | no | **yes**, at any size, for the small model: good news does no harm; the abstract fault and frame results (not linked to the Lean model or the spec: audit) | no |
| **Soufflé** | yes, 0.04 s on the example | no | no | **yes**, built in, as an interactive prompt |
| **clingo** | yes, under a second | yes, "in a few lines", over small spaces | no | no |
| **Prolog, tabled** | not tried | by hand | no | not tried |
| **Alloy 6** | barely: three minutes for the 31-event example | **yes**, its one real job: the sentence is one line, eight seconds to two minutes each, within four pieces; each world read by hand | no ("none this small") | no |
| **TLA+** | yes | yes, for orders of steps: the shortest trace, often a degenerate one | no (its proof system was not tried) | no |

## 4. Toolchain, and what goes wrong quietly

| | to get it | speed in use | the quiet failure its user warns of |
|---|---|---|---|
| **OCaml** | opam switch, about 950 MB, built from source by a setup agent | builds in a second or two | a failed build leaves the old program, which runs; a check that silently has nothing to check, because of the generator's distribution |
| **Ada / SPARK** | Alire, GNAT, gnatprove | prover runs of three to five minutes; must run alone | a timeout looks the same for a false claim, a true one needing a hint, and one that proved yesterday; at least two obligations proved once and timed out later unchanged |
| **Lean 4** | 2.8 GB, changes monthly | builds in about a second | the pull toward what is provable: a model cut smaller until a theorem goes through. A checkpoint "with a proof" was built for a state that owes by lowering a bound (audit) |
| **Soufflé** | one `brew install` | instant | accepts a status typed by hand beside the rule that computes it |
| **clingo** | the same install | instant | a misspelled relation prints one line marked "info" and is then treated as empty, so the answer gets shorter and looks like "nothing owed" (the TLA+ fork checked this on clingo 5.8.3) |
| **Prolog, tabled** | already present | not measured | "it accepts everything" |
| **Alloy 6** | one jar and a JDK | minutes; one query stopped after ten with no answer | the size bound is part of the meaning, and nothing checks that a passing result is not vacuous |
| **TLA+** | one jar, but only the pre-release prints readable traces; four attempts to the first run | 1.5 to 8 minutes for three pieces and two forks | no types; every "holds" is for one universe and one clock bound chosen by hand |

## 5. Changing the model

| | trying a second reading of the spec | carried across draft 3 to draft 4? |
|---|---|---|
| **OCaml** | a switch in the ontology record and an `if`; cheap, but "has to be anticipated in the code" | yes, at more cost than "half carried over" suggests: a new file, the skeleton of the conditions copied in, every explorer check and test written new. Written against a small state interface it "would have been about a third" |
| **Ada / SPARK** | a field of the ontology record; a lemma that does not mention it holds both ways | yes: the proofs crossed "almost for nothing" (one parameter added, 343 checks proved first run); the tests were rewritten nearly whole, about 1,500 lines; and the proof about found defects shrank, because that rule moved into the unproved layer |
| **Lean 4** | cannot be skipped: "I could not type the next line without choosing" | no |
| **Soufflé** | not reported | no |
| **clingo** | a file of one to three lines added on the command line, and the two frontiers diffed | no |
| **Alloy 6** | a second predicate beside the first | no |
| **TLA+** | a constant in a configuration file; nine configurations compared three close rules and two ways of joining lines | no |

## 6. What the users agree on, and one thing they do not

- **Nobody would make their own language the home alone.** Seven of the seven who had an opinion say so, each of its own language.
- **Every language added is another hand-kept copy of the conditions.** The Lean and TLA+ forks say it of the combination. The OCaml builder says it of one language: its definition of what each condition reads is "a second, hand-kept statement of the conditions" beside the first, and the fork result rests on it. There are six copies tonight.
- **Finding what is wrong and proving what is right are different jobs.** The Ada builder: the proofs "found the conditions under which true things are true"; the false things were found by reading closely enough to type the spec and by a search written by hand. The Alloy fork names the first job as a fourth layer the spike lead's three had left out.
- **The engine for rules is a decision about the model.** If a decision may carry a condition (note 22 §3.4), strict Datalog cannot hold it and someone must say what two answers, or *undefined*, mean.

The disagreement is about what goes at the centre. The spike lead puts rules there, with the example as their test. The OCaml builder puts the existing OCaml model there, conditions pulled out one per sentence, because the search is already attached to it, and says "the two are closer than they look: the pulled-out conditions are nearly rules already, and the thing OCaml adds is the search around them". The Ada builder would want "a model finder or a logic that speaks in relations" before the proofs, and SPARK for the state-to-frontier function and the theorems. None of the three has used the others' language on this model.

## 7. One small slice, written the way each language wants it

Joseph, after seeing excerpts cut from the existing builds: "Rather than the code segments as they already existed, I'd love to see a representation (including content for veritoids) that is idiomatic in that language with that small subset". Each of the eight was written fresh, by the mind that had used that language on this model, from one shared text (`idiomatic-slice-2026-11-11/README.md`): a segment is a veritoid (a sentence of content, of a kind) or an assembly of slots declared by its kind; a slot is suggested, promised, a gap, or filled by holding or pointing, possibly provisional; canon is what the marked roots reach through filled, non-provisional slots. One instance: result T holds a claim, a step and an eli8, its description promised; result U holds one claim; outline O, a root, points at T, points provisionally at U, has one suggested slot and one gap.

All eight run and give canon as O, T, c, d, k. What follows is the idiomatic core of each, cut from the files in `idiomatic-slice-2026-11-11/` with `…` where I trimmed; printing, the instance (except where it is the point) and the checks are in the files. I read all eight whole and ran none of them myself.

### OCaml (`ocaml.ml`): a kind is a type

```ocaml
module Veritoid : sig
  type 'kind t
  type claim = [ `Claim ] t
  type step = [ `Step ] t
  type explanation = [ `Explanation ] t
  val claim : string -> string -> claim
  …
end

type 'a filler = Holds of 'a | Points_at of 'a

type 'a slot =
  | Open  (** declared by the kind; nobody has said anything yet *)
  | Suggested of string
  | Promised
  | Filled of { filler : 'a filler; provisional : bool }

type derived_result = {
  id : Id.t;
  formal_claim : claim slot;  (** one *)
  derivation : step slot list;  (** any number, in order *)
  description : explanation slot;  (** one *)
  eli8 : explanation slot option;  (** at most one *)
}

type outline = { id : Id.t; entries : entry list }
and entry = Slot of segment slot | Gap
and segment = Veritoid of veritoid | Assembly of assembly
…

let t = { id = Id.mint "T"; formal_claim = holds c; derivation = [ holds d ];
          description = Promised; eli8 = Some (holds k) }
```

The compiler refuses a step in the claim slot, a second formal claim, a veritoid as a root, and a pointer to nothing. Its builder's caution: "Kinds are types, so the ontology is the program. A verisectorium cannot declare a new kind without this file being edited and recompiled".

### Ada 2022 (`ada_spark.adb`): a slot is a record whose fields depend on its state; holding is containment

```ada
type Slot_State is (Suggested, Promised, Gap, Holds, Points_At);
subtype Filled is Slot_State range Holds .. Points_At;

type Slot (State : Slot_State := Gap) is record
   Declared_As : Slot_Name;      --  which of the kind's slots it is
   case State is
      when Suggested =>
         Note : Notes.Holder;
      when Promised | Gap =>
         null;
      when Filled =>
         Provisional : Boolean := False;
         case State is
            when Holds     => Inside : Holders.Holder;   --  a segment, inside
            when Points_At => Target : Notes.Holder;     --  a name
            when others    => null;
         end case;
   end case;
end record;

Derived_Result : aliased constant Assembly_Kind :=
  (Slots => 4, Name_Length => 14, Name => "derived-result",
   Declares =>
     [(+"formal-claim", One,         Only (Claim)),
      (+"derivation",   Any_Number,  Only (Step)),
      (+"description",  One,         Only (Explanation)),
      (+"eli8",         At_Most_One, Only (Explanation))]);

subtype Assembly is Unchecked_Assembly
with Dynamic_Predicate => Conforms (Assembly);
```

Kinds are data (a constant table), and a value that does not conform to its kind cannot be made: the attempt raises. Asking a gap for its note raises too. Plain Ada, not SPARK; the file's notes say which shapes of the kernel build were the prover's.

### Lean 4 (`lean.lean`): the kind is in the type, and canon is stated before it is computed

```lean
mutual
  inductive Segment : Kind → Type
    | veritoid (v : VKind) (content : String) : Segment (.veritoid v)
    | derivedResult
        (formalClaim : Slot .claim)               -- one
        (derivation  : List (Slot .step))         -- any number
        (description : Slot .explanation)         -- one
        (eli8        : Option (Slot .explanation)) -- at most one
        : Segment .derivedResult
    | outline (rows : List Row) : Segment .outline

  inductive Slot : Kind → Type
    | empty     {k : Kind}                   : Slot k
    | suggested {k : Kind} (note : String)   : Slot k
    | promised  {k : Kind}                   : Slot k
    | holds     {k : Kind} (id : Id k) (seg : Segment k) (provisional : Bool := false) : Slot k
    | pointsAt  {k : Kind} (id : Id k)                   (provisional : Bool := false) : Slot k

  inductive Row : Type
    | slot (k : Kind) (s : Slot k)
    | gap
end

/-- Canon, as what it is: the smallest set that has the roots and is closed under one step of reach. -/
inductive Canon (V : Verisectorium) : Ref → Prop
  | root {r}   : r ∈ V.roots → Canon V r
  | step {r q} : Canon V r → q ∈ V.out r → Canon V q

theorem canon_is (r : Ref) : Canon V r ↔ r ∈ ["O", "T", "c", "d", "k"] := …
```

The only one of the eight that proves its computed list *is* canon, by the definition and for a store of any size, and that U is not in it.

### Soufflé (`souffle.dl`): the declarations are the vocabulary

```souffle
.type Seg      <: symbol
.type Kind     <: symbol
.type SlotName <: symbol
.type Standing = Firm {} | Provisional {}
.type Fill     = Suggested {note : symbol}
               | Promised  {}
               | Gap       {}
               | Holds     {held : Seg, standing : Standing}
               | PointsAt  {target : Seg, standing : Standing}

.decl slot_of(k : Kind, pos : number, name : SlotName, takes : Takes, how_many : Count)
.decl veritoid(s : Seg, k : Kind, content : symbol)
.decl slot(a : Seg, name : SlotName, nth : number, fill : Fill)
.decl root(a : Seg)

veritoid("c", "claim", "Every bounded monotone sequence of reals converges.").
slot("T", "formal-claim", 1, $Holds("c", $Firm())).
slot("T", "description",  1, $Promised()).
slot("O", "entry", 2, $PointsAt("U", $Provisional())).

canon(A) :- root(A).
canon(S) :- canon(A), fills(A, _, S, $Firm()).

misfilled(A, N, S, Want, Got) :- assembly(A, AK), slot_of(AK, _, N, $Of(Want), _), fills(A, N, S, _), kind_of(S, Got), Got != Want.
```

"Nothing is refused at the level of a state. A claim in the eli8 slot is not an error; it is a row in `misfilled`." The types guard the rules and not the data.

### clingo (`clingo.lp`): a slot's state said as a person would say it; refused and owed are two forms; and it can ask "what if"

```prolog
slot(t, formal_claim, holds(c, firm)).
slot(t, description,  promised).
slot(o, entry(2), points_at(uu, provisional)).
slot(o, entry(3), suggested("a result about series is probably wanted here")).
root(o).

canon(A) :- root(A).
canon(S) :- canon(A), firm(A, _, S).

% owed: a state, with something wrong in it
required_and_unmentioned(A, D) :- assembly(A, AK), slot_of(AK, _, D, _, one), not slot(A, D, _).

% refused: not a state at all
:- slot(A1, N1, holds(S, _)), slot(A2, N2, holds(S, _)), (A1, N1) < (A2, N2).     % held in two places

% asked: what if some provisional slots were confirmed?
{ confirmed(A, N) : fills(A, N, _, provisional) } :- ask = 1.
```

"Sorting each sentence of the model into one or the other is the decision this language makes you take, and it takes one character to change your mind."

### Prolog (`prolog.pl`): the instance reads like the outline it describes

```prolog
segment(t,
  assembly(derived_result,
    [ formal_claim - holds(veritoid(c, claim, "Every bounded monotone sequence of reals converges.")),
      derivation   - holds(veritoid(d, step,  "Take the least upper bound of the terms and show the terms come within any ε of it.")),
      description  - promised,
      eli8         - holds(veritoid(k, explanation, "If you keep stepping forward …"))
    ])).

segment(o,
  assembly(outline,
    [ entry - points_at(t),
      entry - provisional(points_at(uu)),
      entry - suggested("a result about series is probably wanted here"),
      entry - gap
    ])).

root(o).

:- table canon/1.
canon(Name)  :- root(Name).
canon(Inner) :- canon(Name), body(Name, assembly(_, Slots)), member(_ - Fill, Slots), reached(Fill, Inner).
```

A term can contain a term, so holding is containment and pointing is a name. No types and no declarations: what a slot state *is* exists only because a predicate was written to say so.

### Alloy 6 (`alloy.als`): a kind is a signature, "how many" is the word before the field, canon is one expression

```alloy
abstract sig Segment {}
abstract sig Veritoid extends Segment { content: one String }
sig Claim, Step, Explanation extends Veritoid {}
abstract sig Assembly extends Segment {}
sig Root in Assembly {}

abstract sig Slot {}
sig Suggested extends Slot { note: one String }
sig Promised, Gap extends Slot {}
abstract sig Filled extends Slot { filler: one Segment }
sig Holds, PointsAt extends Filled {}
sig Provisional in Filled {}

sig DerivedResult extends Assembly {
  formalClaim: one Slot,
  derivation:  seq Slot,
  description: one Slot,
  eli8:        lone Slot
}

fun reach: Assembly -> Segment { (slots :> (Filled - Provisional)).filler }
fun canon: set Segment { Root.*reach }

pred complete[r: DerivedResult] { r.(formalClaim + description) in Filled }
```

The model and the instance are separate, and the questions at the end are asked of every small world, not only this one. Its fork's warning, found on this file: two of its questions first passed because no world existed at all (a quirk of how Alloy bounds strings). "A check that passes because nothing exists reads exactly like a check that passes."

### TLA+ (`tla.tla`): no types; canon as the sentence that defines it; and what can happen to a slot

```tla
Veritoid == [
  c |-> [kind |-> "claim", content |-> "Every bounded monotone sequence of reals converges."],
  … ]

Holds(s)        == [st |-> "holds",  seg |-> s, provisional |-> FALSE]
PointsAt(s)     == [st |-> "points", seg |-> s, provisional |-> FALSE]
Suggested(note) == [st |-> "suggested", note |-> note]
Promised        == [st |-> "promised"]
Gap             == [st |-> "gap"]

\* Canon is the smallest set that contains the roots and, with each assembly,
\* everything it reaches.  This is the definition; nothing here says how to find it.
Closed(sl, r, S) == r \subseteq S /\ \A a \in S \cap Assemblies : Reaches(sl, a) \subseteq S
Canon(sl, r) == {s \in Segments : \A S \in SUBSET Segments : Closed(sl, r, S) => s \in S}

Promise(a, i) == …   Approve(a, i) == …   Doubt(a, i) == …

PromisingMovesNothing == [][(\E p \in Places : Promise(p[1], p[2])) => Now' = Now]_slots
ApprovingOnlyAdds     == [][(\E p \in Places : Approve(p[1], p[2])) => Now \subseteq Now']_slots
DoubtingOnlyRemoves   == [][(\E p \in Places : Doubt(p[1], p[2]))   => Now' \subseteq Now]_slots
```

Its fork, honestly: the data and the definitions "are what any language with sets would give, with less checking than most"; the steps are "the only place TLA+ adds something". It departed from the slice to add them.

### What writing it idiomatically made each one say about the model

Nobody was asked these; they fell out of the languages.

| what came out | who said it | in whose words |
|---|---|---|
| **There is a fifth slot state: declared and untouched.** U's empty description is not suggested, promised or a gap | OCaml (`Open`), Lean (`empty`), TLA+ (left absent, shown as a finding). Alloy wrote gaps and said the text does not say | Lean: "A field of a record must have *some* value, so the instance could not be written without deciding what an untouched required slot is." |
| **A gap is not a state of a typed slot.** It can only sit where the kind is open, as an entry of an outline | OCaml and Lean (different minds, written within minutes of each other; I have not confirmed that neither saw the other's file) | OCaml: "In a typed slot the kind of what is missing is known, which is exactly what a gap denies … I did not set out to say this; the type of `Gap` would not go anywhere else." |
| **Holding can be containment, and then "held once" needs no rule.** Where it cannot be, it becomes a constraint | containment: Ada, Lean, Prolog. A rule or fact: Soufflé, clingo, Alloy, TLA+. Neither (not refused): OCaml | Ada: "The model's two ways of filling a slot are the language's two ways of having a thing." |
| **"One" means the slot is there, not that it is filled.** Whether it is filled is something a state may fail | OCaml, Ada, Lean, Alloy | Alloy: "a `fact` removes worlds, a `pred` describes them. Anything that can be owed has to be a pred." |
| **Being a root is said about an assembly, not written in it** | OCaml, Ada, Lean (a list beside the store); Alloy (a subset) | OCaml: "nothing in the assembly changes when it is said" |
| **Kinds as types refuse the most and can be declared by nobody but the programmer** | OCaml and Lean put kinds in types; Ada, Soufflé, clingo, Prolog, TLA+ keep them as data; Alloy's signatures sit between | OCaml: "For one verisectorium's own kinds written once, this is the best thing in the file. For a tool that must load any verisectorium's ontology, it is the wrong shape" |
| **Refused or owed is a choice made sentence by sentence** | clingo (a constraint or a derived fact), Alloy (a fact or a predicate), Ada (a predicate on the type or a check elsewhere), Soufflé (nothing is refused) | clingo: "it takes one character to change your mind" |
| **Content is opaque everywhere.** It is stored, compared and printed, and no language could say anything about it | all eight | Alloy: "That matches the slice (content is what questions are asked OF) and it means nothing about content can ever be said in this language." |

## 8. Forced to choose one, and to live with it

Joseph, on reading the verdicts above: "It's always 'safest' to not recommend ones own experience as the home, I would think. I wonder what they would choose if they looked at all of the assembled report and *had* to choose a home and had to live with the result..." Each of the six minds that used a language was asked for one language, no combination, as the one who would keep it true through the next several changes to the spec. Each wrote before reading any other answer. The lead wrote first, before asking. The answers are in `forced-choice-2026-11-11/`, each a page; I read all seven whole.

| who | used | chose | second | the reason it gives, in a line |
|---|---|---|---|---|
| Ada builder | Ada / SPARK | **Ada / SPARK** | (Lean or Soufflé, under other beliefs) | a home must search, prove for every ontology, and survive a spec change; only SPARK and Lean prove, and in SPARK a solver writes the proofs, which is why they crossed the change for nothing |
| OCaml builder | OCaml | **Lean 4** | OCaml | "the only one of the eight in which all four jobs can be done on one text"; in OCaml "none found in the universes visited" would be permanent |
| Lean fork | Lean 4 | **Lean 4** | OCaml | the statement adjudicated and the thing that runs can be the same text; it can say "for every state"; it will not let a sentence stand with two readings |
| Alloy fork | Alloy 6 | **Lean 4** | Soufflé | "It labels its own claims, by machine": proved, stated and owed, and merely tried are told apart by the toolchain, which is the model's oldest rule applied to its own formal layer |
| spike lead | Soufflé, clingo, Prolog | **clingo** | OCaml | one copy of the conditions runs the example and is what the search is asked over; the one language with evidence that a cold mind could read and repair it |
| TLA+ fork | TLA+ | **clingo** | OCaml | the model is still at the stage of finding which sentences are wrong, so the search has to be inside the language and a second reading has to cost two lines |
| the lead | none (a reader) | **OCaml** | | search found the errors; the types read fastest; it could be the engine. Argued partly by leaning on the Ada proofs, which the question forbade |

Three for Lean, two for clingo, one for Ada, and one reader for OCaml. Three of the six chose a language they had not used. OCaml is the second choice of three and the fallback of a fourth, and nobody who used a language chose it first.

**What they agree on.** There should be one copy of the conditions, written one per sentence of note 22, that Joseph can read and that runs. Every answer says so, and every answer names a second hand-kept copy as the thing it fears most.

**What divides them is one judgment about the model, not about languages.** If the model is still at the stage where the work is finding which sentences are false, the search must be in the home and cheap to re-ask, and that points at clingo (or OCaml). If its general claims ("for every ontology, under this condition") are what the work is for and will be rewritten several times, the home must prove, and that points at Lean (or SPARK). The TLA+ fork: "once the conditions stop moving, this is the first thing I would regret." The Ada builder, betting the other way: "I think they will be rewritten several times, and I think they matter most."

**What each says would show it wrong, and what is cheap to find out.**

- *Lean, three times:* nobody has measured compiled Lean on the search. The OCaml builder would go back to OCaml "within the week" if it is not within about a factor of ten; the Lean fork has not written the search at all.
- *clingo, twice:* both named the same test, the two-fork search asked in clingo, and the spike lead then ran it. All three known faults came out in under a fifth of a second each, on a model far smaller than the OCaml explorer covers. Two of its three runs first returned a wrong answer that read like a right one, caught only because the right answers were already known. The spike lead: "I hold that less firmly than I did an hour ago."
- *Everyone:* whether Joseph reads rules or propositions or functions fastest. The Lean fork: "your reading is what the layer is for."

**How much these seven are worth as a count.** Less than seven. The spike lead and its three forks began from one reading; the two builders are separate from them and from each other; all seven are one model. The split between the two clingo answers and the two Lean answers runs inside the one lineage, which is some evidence the forks have diverged. No answer rests on having kept any of these languages true through a change, except the two builders', and they chose differently.

## 9. The provers on the OCaml side: Rocq, Why3, Cameleer, E

*Added 2026-11-11. Joseph, on reading sections 1 to 8: "Did OCaml not use rocq as intended? what about why3/cameleer, alt-ergo, eprover, etc.?" It had not. His first ask had named "ocaml / rocq or something"; Rocq reached the OCaml builder only as an aside in its brief, and Why3, Cameleer, Alt-Ergo and E "never crossed my mind; that is an omission, not a judgment". So sections 1 to 8 set Ada with its prover against OCaml without one, and several of the forced choices turned on "OCaml cannot prove", which nobody had checked. The OCaml builder then forked four ways and ran them, each fork leaving what the first spike's forks left: `spike-ocaml-side-provers-2026-11-11/` (a perspective on the small model and a firsthand note per tool, and a debrief), and four more slices in `idiomatic-slice-2026-11-11/`.*

*What this section rests on: the spike lead's `DEBRIEF.md` and the four `AS-A-HOME.md` notes, read whole by me; the cores of the four slice files, cut by line number and not read whole; the four `PERSPECTIVE.md` files not read at all. An independent read of the spike (`spike-ocaml-side-provers-2026-11-11/de-novo-feedback-1.md`) came back after this section was first written and found three of its sentences wrong; they are corrected in place and listed under "After the independent read" below. The four forks began from one mind's reading, guesses and forced choice. Nothing here has been checked by anyone but its makers. The tables in sections 1 to 5 have not been widened to twelve columns; this section carries the four new rows.*

### Where each lands, in its user's words

| tool | as the home | what it did tonight | what goes wrong quietly |
|---|---|---|---|
| **Rocq 9.3**, extracted to OCaml | "Yes, more than I expected, and with one cost I had under-weighed." | canon proved to be exactly its two rules, for every store; the small model and note 22's example pinned row by row; "recording evidence which holds adds nothing owed" for the small model's own function; the model then run from extracted OCaml. Installed in under four minutes | little: nine failed compiles, "every one was loud". But the functions that are easy to prove are slow (on an outline of 200 results, 2.7 s extracted against 0.0002 s for an unproved walk), and what the types knew is partly erased at the boundary with OCaml |
| **Why3 1.9** (WhyML, with Alt-Ergo, Z3 and E behind it) | "Not alone … It would not win." The one to pick "if the rule were 'the conditions stay as programs that run, and proof is added to them where it is cheap'" | 149 obligations across the slice and the small model, about a dozen needing help (most are "this recursion terminates"); canon and three small notions tied to their sentences with "a machine holding the two together"; no condition of the small model has a contract; extracted OCaml that "looks hand-written" | "A timeout is not an answer": a false statement and a true one missing a lemma look the same. "An unproved lemma is still used": a goal read *Valid* while resting on one that timed out. Results can move with a solver upgrade |
| **Cameleer / GOSPEL** (specifications on the OCaml itself) | "No, and the reason is the first item under dread, not anything about the idea." | "the only arrangement where the conditions that run in the fast OCaml explorer are literally the text the lemmas are about"; proved for every state that a write elsewhere leaves a piece's findings and checks alone, in a cut with no guards, fixed point, forks or canon | the toolchain: "a research tool held together by a pinned commit", needing a compiler three major versions behind the kernel's. And everything said of Why3 |
| **E 3.1** alone (first-order logic) | "No. Not as the home, and not as a standing part either." | deciding in a fraction of a second whether a general sentence follows from the conditions as written, both ways | cannot run a state (no answer after seventeen minutes on the example's last row); three statuses that mean "no answer"; "every closing is written by hand, and a missing one is silent" |

Alt-Ergo had no fork of its own; it is the solver behind Why3 and Cameleer.

### The same slice, in each

**Rocq (`rocq.v`): OCaml's types, a rule, a function, and the proof that they agree**

```coq
Record veritoid (k : vkind) := Veritoid { v_name : name; content : string }.

Inductive filler (A : Type) := Holds (x : A) | PointsAt (target : name).

Inductive slot (A : Type) :=
| Untouched  (* declared by the kind; nobody has said anything yet *)
| Suggested (note : string)
| Promised
| Filled (f : filler A) (provisional : bool).

Record derived_result := DerivedResult {
  r_name : name;
  formal_claim : slot (veritoid Claim);
  derivation : list (slot (veritoid Step));
  description : slot (veritoid Explanation);
  eli8 : option (slot (veritoid Explanation)) }.

Inductive entry := Entry (s : slot held) | Gap.

Inductive Canon (V : verisectorium) : name -> Prop :=
| canon_root : forall r, In r (roots V) -> Canon V r
| canon_step : forall r q, Canon V r -> In q (out V r) -> Canon V q.

Definition canon_list (V : verisectorium) : list name :=
  iter (S (List.length (universe V))) (step V) (roots V).

Theorem canon_list_is_canon : forall V r, Canon V r <-> In r (canon_list V).

Fail Definition wrong := DerivedResult "T" (holds d) [] Promised None.

Extraction "rocq_extracted.ml" canon_list promised here.
```

The types are the OCaml slice's with different punctuation, including its fifth slot state and its gap as an entry. What is new is the last four statements: canon as two rules, a function, a theorem for every store that the function computes exactly what the rules say (no bound typed by hand; it is read from the store), a refusal kept as a checked line, and the OCaml that comes out.

**Why3 (`why3.mlw`): the function carries its own promise**

```whyml
inductive canon (v: world) (n: id) =
  | Canon_root: forall v: world, r: id.
      mem r (roots v) -> canon v r
  | Canon_step: forall v: world, r q: id.
      canon v r -> mem q (out v r) -> canon v q

(* The promise. If this answers at all, its answer is canon exactly: by the
   two rules, for any world whatever. *)
let canon_of (v: world) : option (list id)
  ensures { match result with
            | Some s -> forall r. canon v r <-> mem r s
            | None -> true
            end }
= let s = grow v (size v + 1) (roots v) in
  if is_closed v s then Some s else None
```

The sentence sits in the function's contract and solvers discharge it. Weaker than Rocq's here: it promises exactness only when a closedness check passes, and does not prove the number of rounds always suffices.

**Cameleer (`cameleer.ml`): ordinary OCaml, with the kind's rule as an invariant beside the type**

```ocaml
type derived_result = {
  r_id : int;
  formal_claim : veritoid slot;  (* one *)
  derivation : veritoid slot list;  (* any number, in order *)
  description : veritoid slot;  (* one *)
  eli8 : veritoid slot option;  (* at most one *)
}
(*@ invariant takes Claim formal_claim
    invariant all_take Step derivation
    invariant takes Explanation description
    invariant match eli8 with None -> true | Some s -> takes Explanation s *)

let canon_list (roots : int list) (es : (int * int) list) : int list =
  close (count es + 1) roots es roots
(*@ s = canon_list roots es
      ensures forall x. mem x s -> canon roots es x
      ensures forall x. mem x roots -> mem x s *)
```

Here the kind of a veritoid is a value, not a type, so "a claim goes in the claim slot" is an invariant the solvers must hold, where OCaml alone and Rocq refuse it at compile time.

**E (`eprover.p`): nothing is assumed, so everything that is so has to be said**

```tptp
tff(canon_root, axiom, ![A: seg]: ( root(A) => canon(A) )).
tff(canon_step, axiom, ![A: seg, S: seg]: ( (canon(A) & firm(A, S)) => canon(S) )).

% CLOSING. "And nothing else is in canon." First-order logic cannot say "the
% least set closed under the two rules". This is the nearest it has: whatever
% is in canon has a reason. It is weaker: see slice/ring.p.
tff(canon_only, axiom,
    ![S: seg]: ( canon(S) => ( root(S) | ?[A: seg]: (canon(A) & firm(A, S)) ) )).

tff(root_exactly, axiom, ![A: seg]: ( root(A) <=> A = o )).

tff(canon_is, conjecture,
    ![X: seg]: ( canon(X) <=> (X = o | X = t | X = c | X = d | X = k) )).
```

The two rules read as well as any in section 7. The price is the lines marked "exactly": that these are all the roots, all the slots, all the pieces, each written by hand.

### What it adds to what the other eight said about the model

- **Everything the model computes reads absence as information.** The E fork, having had to write "these are all the writes, all the evidence, the only root" each time: "The model's rule that standing is computed and never typed is only as good as the record being *all* of the record." That the model "says it nowhere" is too strong: note 22 §4.2, `core/src/disc-better.md` and the first spike's debrief each say which record a state is read from. What is the fork's own is that the dependence runs through every computed thing, selection and canon included, and has no one name. Its example of where that would bite (a reader computing what is owed from an incomplete copy) is reasoning, not a run.
- **"Rests only on consistent pieces" said as reaching, again, and it is still a choice.** The Rocq fork read it as "nothing it reaches by *predicated on* has something wrong of its own", with the same function and theorem as canon. Saying it that way *is* choosing the greatest fixed point (a clean ring is fine); it does not avoid the choice, as the first spike's corrected debrief already says. And the two are equal only when a piece's own conditions do not read which pieces are consistent; in the kernel's OCaml model they do (decisions conditioned on consistency; the effective warrant). Rocq defines the reaching form and proves nothing about a fixed point.
- **A fifth slot state and the gap as an entry, again.** Rocq, Why3 and Cameleer all carry `Untouched` and `Gap` as an entry. They are forks of the mind that wrote the OCaml slice, so this is that slice restated, not three more votes.
- **The example in note 22, again: two wordings, two answers.** Read as note 22 words condition 6, the rewritten eli8 owes a look beside the description and S1 is not reached; read as core's «changeset» words it (what depends on something that *changed*), nothing is owed and the story closes as told. The Rocq fork encodes both and its checkpoint uses the second; Why3 and E have only the first. "c1′ is fine" is true of the question B asked and not of the auditor's, if the auditor's is a separate criterion, which the story does not say. None of it is independent of the first spike, whose common reading all four began from. Why3 puts the condition-6 item on the dependent piece, Rocq and E on the assembly.

### After the independent read

`spike-ocaml-side-provers-2026-11-11/de-novo-feedback-1.md`, by a fresh mind with a bare brief; read whole by me. Everything it re-ran reproduced, and it could not make a proved statement fail. What it found is in the debrief and in how the four small models relate, and three of its findings were already in this section in my words (now corrected above): the flat reading of note 22's example, which I had myself corrected to Joseph some hours earlier; "says so nowhere"; and "each condition a function with its sentence above it" for Why3.

Beyond those:

- **The four small models are four functions that agree on the story.** A finding on the current version, after something it read is rewritten, leaves an owed item in Rocq and nothing in Why3 or E (the same split the first read found between Lean and Datalog). Why3's small model gets its number of rounds for canon from the hand-written ontology with no check: with an ontology listing one piece, the 08:30 row comes back stationary. E's and Cameleer's condition 5 do not ask that a whole read have read every part.
- **What "proved" covers.** In Rocq, two statements with real content (the reaching theorem, and good news). In Why3's small model, 53 of 87 obligations are that a recursion terminates. In Cameleer, seven of nine lemmas, with one true lemma timing out and one *Valid* resting on it. E's six theorems are not vacuous; and good news for the second half of condition 5 does not merely lack an answer there, it does not follow in first-order logic.
- **In all three typed slices, a slot's kind constrains what it holds and not what it points at.**
- **A second proved-fast function stacks on the Rocq fork's new rule** (the reader's inference): the sentence, the function, and a fast function proved equal is three texts and two proofs for each condition, of which the evening has none of nine.

### What it does to the forced choices in section 8

The OCaml builder's choice of Lean rested on OCaml having no route to "for every state". Three routes were walked in an evening. It has changed its answer to **Rocq and the OCaml it extracts to**, with two things held beside it: neither it nor its fork has used Lean, so "ahead of Lean" compares one touched thing with one untouched; and if Rocq with extracted OCaml counts as two languages, its first answer stands. The count in section 8 is then two for Lean, two for clingo, one for Ada, one for Rocq with OCaml, and the lead as a reader for OCaml. The other five have not been asked again.

The Rocq fork adds a rule none of the earlier answers had: "every condition is written twice, as the sentence and as the function, and the proof that they agree is the first proof owed." It did that for canon and for "rests on", and for none of the nine conditions.

The independent read's judgment of this change: what the evening established is that the premise for choosing Lean was false, not that Rocq is ahead of it; "the evidence for it is the same as it was before the spike, minus one false premise."

What would overturn it, by its own account: speed. Its findings in the kernel builds all came from visiting tens of millions of states in minutes; the function that was easy to prove is four orders of magnitude slower than an unproved one on the slice's example; and nobody has timed extracted code against the explorer on one model.

## What I have not done

Read the Ada proof files, either explorer, either test suite, or the Ada layer that reads a state from events. Run anything in OCaml, Ada, Lean, Alloy or TLA+. (I did run one two-rule example in clingo, Soufflé and SWI-Prolog, for a different question.) Checked any figure in the builders' notes against their logs. For section 9: read the four `PERSPECTIVE.md` files of the OCaml-side spike, read its four slice files whole, or seen its independent read.
