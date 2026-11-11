# What Alloy showed about the model

*2026-11-10/11, by the Alloy fork of the formal-perspectives spike (Fable 5.2). For the spike lead, then for an independent verifier, then possibly for Joseph. It is about `../01-common-reading.md` (M0: the lead's reduction of note 22 Parts 2 to 4 and the kernel spec draft 4), not about core and not about the full spec. Nothing here is a fact about the model until adjudicated in core, and nothing here proposes a mechanism.*

## Alloy, in three sentences

Alloy describes a world as sets and relations, and everything said about it is said with joins, unions, differences and the transitive closure of a relation. It has no recursion and no loops. Its tool takes a description and a size limit and either produces a world that fits or reports that none exists within the limit, so "no counterexample" always means "none this small".

## What was run, and what the words mean

| file | what it is | result |
|---|---|---|
| `m0.als` | M0: pieces, versions, events, a line read as of a time, and conditions 1, 2, 4, 5, 6, 9 as relations | used by the others |
| `story.als` | note 22 §4.3 as one fixed world of 31 events, read at ten moments | **run**; the computed frontier at each row is in `runs/out-story/story-solution-0.txt` |
| `fixpoints.als` | is "consistent" a fixed point, or reachability? what a conditional question does | **run**; 3 checks with no counterexample, 5 instances found, 1 statement the tool refused |
| `forks.als`, `forks2.als`, `forks3.als`, `forks4.als`, `forks5.als`, `forks6.als` | two forks from one checkpoint, each stationary, whose union is not: fifteen rounds of "say when they do not meet, and show me a pair that gets through" | **run**; see the table below. `forks6.als` was stopped unfinished |
| `forks7.als` | the TLA+ fork's "lost rewrite", asked for directly | **run**; found |

To re-run: `./run.sh <file>.als -s glucose` writes `runs/<file>.log` and `runs/out-<file>/`; `./show.sh <solution file>` prints a found world compactly (`./showf.sh` for the fork ones). The jar is not in the repository: `curl -sL -o tool/alloy.jar https://github.com/AlloyTools/org.alloytools.alloy/releases/download/v6.2.0/org.alloytools.alloy.dist.jar`, run with `/opt/homebrew/opt/openjdk/bin/java`. Alloy 6.2.0, solver glucose (the story's first runs used the default SAT4J and gave the same relations). `story.als` takes about three minutes; the others one to four, except `forks6.als`, which did not finish in ten.

Sizes. "No counterexample" below means: none with at most 4 pieces, 6 versions, 6 events and one state (`fixpoints.als`). The fork runs allowed 4 pieces, 6 versions and 9 events. These are smaller than either build's universes; what Alloy adds is that the *statement* being tested is one sentence and no generator stands between it and the search.

Cut from M0, knowingly: promises (condition 8), waivers, unmarking a root, **same** for decisions. Not excluded, and it shows in the instances: an assembly with a slot for itself, a piece predicated on itself, a write that re-selects the version already selected, a set-aside recorded before the evidence it sets aside. An instance Alloy returns is *a* world that fits, not the smallest or the most natural one, and several below carry such oddities beside the part that matters. I read each instance by hand; the readings are mine and a second reader should redo them from the saved files.

Alloy 6's own addition, time (mutable relations and temporal operators over one linear run), was **not used**. A line that forks and rewinds is not one linear run, and I modelled events as data instead. That choice is a judgment, not a tested finding.

## 1. The whole computed side is a query, and it needs no fixed point

*Run; the claim about the spec is an argument.*

`m0.als` computes, from a set of events and a time, which version of each piece is selected, what is in canon, which evidence applies, and every condition, with no recursion anywhere in the file. Three closures are all it uses: canon (reached from the roots through slots), **same** (versions linked by any chain of same-events), and fault (below).

The kernel spec defines *consistent* as a greatest fixed point, and both builds report that the fixed point is not unique and that "greatest" is a choice (R7). Alloy cannot write a fixed point, so the question had to be put differently: is there a definition with none? There is, and it is one line:

> a piece is at fault when it, or anything it is transitively predicated on, has a violation of its own.

`fixpoints.als` then asks whether this is the same thing as the spec's wording, taken as a property of a candidate set S ("S is exactly the canon pieces with no violation of their own that rest only on members of S"):

- the one-line definition is such a set: no counterexample (`closedFormIsFixed`);
- every such set is contained in it, so it is the greatest: no counterexample (`closedFormIsGreatest`);
- other such sets exist. The smallest Alloy returned is one piece predicated on itself; with that excluded, two pieces predicated on each other (`anotherFixedPoint`, `anotherFixedPointNoSelfLoop`). This is the builds' ring.

So in M0, where questions and promises are unconditional, the greatest fixed point *is* reachability, and the other fixed points are sets that leave a piece out for no reason. Said in the model's words: fault spreads along rests-on from pieces that have something wrong with them, which is how core already says it ("unsettledness spreads along it and along nothing else"). The fixed-point wording, the question of which fixed point, and the non-uniqueness the builds measured belong to the wording and not to what is being said. Whether that survives the full spec (warrant levels, caps, waived items that do not spread) I did not test; I expect it to, because the only recursive clause in draft 4's constraints is the one about resting.

A smaller thing that the same file makes plain, true by construction here: whether the *whole* state is stationary never looks at the recursive clause. A state is stationary when no piece has a violation of its own. The clause "and rests only on consistent pieces" changes which pieces show an item and what "stationary of a part" means; it cannot change whether the whole frontier is empty.

## 2. A conditional question, found from one sentence each

*Run.*

Allowing a raised question to stand only while some named piece is consistent, `fixpoints.als` asks for a state with no consistent answer, and for one with answers and no greatest.

- `noFixedPoint`: one piece, in canon, and one question about it that stands only while that piece is consistent. Neither "consistent" nor "not" is stable. This is the builds' one-piece counterexample.
- `noGreatestQuestionsOnly`: two pieces, each with a question that stands only while the *other* is consistent. "Only the first is consistent" and "only the second is" are both stable, and "both" is not. This is the OCaml build's two-piece case.

Each took one sentence to ask for and the tool supplied the world. That part of the lead's guess G-A2 held.

**What Alloy has no way to say.** "There is no set S such that …" cannot be given to the tool directly; it answers "requires higher-order quantification that could not be skolemized" (`noFixedPointDirect`, kept in the file to record this; it is why that log ends `exit=1`). The way round is to make every subset of the pieces an object and quantify over those, which costs $2^n$ objects and limits this question to three pieces. Asking whether *some* set has a property is free; asking whether *none* has is not. For this model that is the difference between "is this state stationary" (free) and "does this ontology always have an answer" (not), and it is the second that the Ada build proved.

## 3. The story, read mechanically

*Run. One fixed world; nothing searched.*

The frontier M0 computes at each row, beside note 22's column. A piece is listed under the condition it fails.

| row | note 22 says | M0 computes |
|---|---|---|
| 0, S0 | empty | empty |
| 1, 08:30 finding | c1 known wrong; u1 rests on it | c: a finding applies. Nothing else has a violation of its own; u is at fault through c. T and U are not (holding is not resting) |
| 2, 09:00 c1′, checked | c1′ is fine; u1 needs the stronger conclusion | c: the auditor's case has not been looked for at c1′ (an open guard). u: written against c1, and its check read c1. T: not read whole as it now is. e: not looked at beside c1′ |
| 3, 10:00 rewound | as at 08:30 | identical to row 1. The check of c1′ is in the base and touches nothing |
| 4, 10:30 c2 d2 k2 | c2 unchecked; e1 looked at against c2; T not read whole; u1 written against c1 | the same, and: c's open guard (the auditor's case, separately from "unchecked"); u unchecked; **k: k2 not looked at beside e1** |
| 5, 11:00 | T's whole read; u1 | T; u (reference and check); k |
| 6, 11:30 d3 | c2 unchecked again | c again unchecked; T; u; k |
| 7, 12:00 | T's whole read; u1 | T; u; k |
| 8, 13:00 u2 | whole reads of T and U | T; U; k |
| 9, 14:00 | empty: S1 | **k** |

Three things came out that the prose column does not have.

**S1 is not stationary by the letter.** The eli8 depends on the description. At 10:30 the eli8 was rewritten (k2) and the description was kept (e1). Nothing on record says anyone looked at k2 beside e1: there is no affirmation of that pair, and no evidence about k that read e. Condition 6 as M0 has it, and C2 in draft 4 as written ("met by an affirm decision or by evidence about one filler that read the other"), are therefore unmet from 10:30 on, including at 14:00. Two readings would each make S1 stationary, and they are different readings:

- *writing the dependent counts as having looked at what it depends on.* `m0.als` carries this as a second version of the condition; under it exactly S0 and S1 are stationary and row 2 still owes e against c1′ (`oStationaryW` in the output). This is the direction core's own rule runs in («changeset»: when a piece changes, each piece that depends on it is changed too or affirmed; k was changed).
- *a whole read of the assembly that read both counts.* The 14:00 read of T read e1 and k2. It is evidence about T, not about k, so the letter excludes it.

Which is meant is the model's to say. What Alloy showed is only that the story's last row needs one of them.

**Row 2's "c1′ is fine" is true of one question and not of another.** B's check of c1′ was a validity check. The auditor's finding was by a different criterion (the failing case), and the rule that a found defect is presumed present until looked for leaves it open against c1′. The story may well intend that B looked; the record as told does not say so. It makes no difference to the story, since the fork is rewound.

**"Unchecked" and "the defect has not been looked for" are two items at 10:30,** and the story closes both at 11:00 in one sentence ("B checks c2 by following d2, and checks the auditor's case against it"). The mechanical reading agrees with the story there; it only shows that the sentence is two acts.

Rows 1, 3, 5 to 8 otherwise agree with the prose, with the one standing addition of k.

## 4. Two forks: fourteen sentences, each defeated, and a fifteenth left undecided

*Run. The interpretation at the end is an argument.*

The question: two forks from a stationary checkpoint, each stationary by itself, read at the same time so that both see the same base. When is their union stationary? Each round states a condition under which the forks "do not meet" and asks for a pair that satisfies it and still cannot both close.

| round | "they do not meet" means, added to all before | what got through |
|---|---|---|
| 0 | nothing | A marks as a root a piece that B writes |
| 1 | they write different pieces | B's write to an outline brings into canon a piece A rewrote; A's rewrite was owed nothing while the piece was outside canon |
| 2 | and no evidence about a piece one wrote read a piece the other wrote (draft 3's sentence) | A marks a root; B writes a piece that root reaches |
| 3 | and no new version is predicated on what the other wrote | B's write to an outline brings a piece into canon; A wrote an inner dependency over it |
| 4 | and neither fork alone changes what is in canon | A writes a slot for a piece B has not got; B writes that piece. Canon grows only in the union |
| 5 | and no decision on one is about what the other wrote | B writes an assembly with an inner dependency over a filler; A writes the filler |
| 6 | and no new version has a slot for what the other wrote | no writes at all: B raises a question, A sets aside the evidence that answers it |
| 7 | and no decision on one is about what the other decided about | B's outline write brings a claim into canon; A set aside the check it needs |
| 8 | clauses restated by *touched* and *changed*; canon in the union is the union of the forks' | both forks only *refer* to one piece: A's slot brings it into canon, B's assembly declares a dependency over it |
| 9 | and canon agrees, for every piece a fork touched, between that fork and the union | A's write puts v in canon and drops O1; B marks O1 as a root; O1, written by neither, declares that v depends on it |
| 10 | and neither fork moves canon at all | A wrote nothing: it raised a question, and the answer had read a piece B rewrote |
| 11 | and no evidence touches something each wrote or decided about | B declared a dependency over a piece it neither wrote nor decided about; the evidence meeting it had read a piece A rewrote |
| 12 | one clause: nothing a fork touched, followed through what the evidence about it read, is something the other changed | **a finding in the base, about a piece neither fork touched, that had read one piece as A left it and one as B left it.** It applies on neither fork and applies in the union |
| 13 | and no single piece of evidence read something each fork changed | **a result with two whole reads on record, one that had read v and one that had read v1. A rewrote v; B rewrote v1. Each fork still has one read standing. The union has none** |
| 14 | and no piece at all, followed through what it is predicated on and what its evidence read, reaches something each fork changed | **undecided.** The solver was stopped by hand after about ten minutes with no answer; every earlier round returned a world in under two. A long silence is what a search with nothing to find looks like, and it is not a result |

(The table numbers every tightening 0 to 14. The files number differently in their own comments: `forks.als` holds table rows 0 to 5 as six runs; `forks2.als` and `forks3.als` were each tightened in place, three and four times; `forks4.als`, `forks5.als` and `forks6.als` are rows 12, 13 and 14. Where a file was tightened in place, the earlier clause is described in its comments and the instance that defeated it is saved as `runs/forks2-round*-all5-instance.txt` and `runs/forks3-round*-all7-instance.txt`; the earlier clause texts themselves were overwritten, so those rounds can be re-read and not re-run, and a verifier matching rows 5 to 11 to saved instances should go by the instance, not by my row number.)

**One thing these rounds could not have shown, added after reading the TLA+ fork's account.** Every round asks for a union that is *not* stationary. The TLA+ fork found a pair where the union *is* stationary and wrong: both forks rewrite one piece, and whichever write has the later time is silently the selected one. `forks7.als` asks M0 for that directly and gets it in eight seconds (`runs/out-forks7/lostRewrite-solution-0.txt`: a root at one version; fork B rewrites it; fork A, later by the clock, writes the old version again; the union is stationary with B's version gone and nothing owed). So "is the union stationary" is not the whole question even where it has an answer, and rounds 0 to 14 are about only the half of it that the frontier can see. Round 0's clause (they write different pieces) excludes this case; it is the one clause in the table that is there for a reason the frontier does not report.

What this shows about the model, as I read it:

**"The forks do not meet" cannot be said by listing kinds of overlap between what the two forks did.** Each list was natural, and each was defeated by a pair that an author would recognize as a real meeting. This is the same thing both builds report from the other side: the Ada proof takes a five-part definition of "agree on a region", and the OCaml account says its relation was written by hand to be safe. Alloy's contribution is the sequence of worlds that shows why a shorter statement does not do.

**Rounds 12 and 13 are the two I would keep.** Neither involves anything one fork did to something the other touched.

- *Round 12: evidence can be about a combination of versions that no line has yet.* Evidence is about versions, and versions exist wherever they were written, so a finding can read c as one fork has it and k as another has it. It is true, it is on record, and it applies nowhere until the two close together. This is the model's own answer to the gap core calls the unconnected contradiction (two changes that contradict in substance with no reference between them), reached from the other end: such a contradiction becomes visible exactly when someone records evidence that read both, and the model lets them do that before the merge.
- *Round 13: redundant support, each fork removing a different one.* The piece was better supported than it needed to be, by two reads that shared nothing, and each fork relied, without any record of relying, on the one it had not disturbed. The lead guessed (G-A3) that the smallest failing pair would be the anomaly the database literature calls write skew. For the first twelve rounds it was not: most were about canon moving. This one is that anomaly in its plainest form, and it arrived only when everything else had been excluded. I have not checked the literature's wording; the lead is reading it.

**Why canon dominated the early rounds, said relationally.** Canon is a closure, and the closure of a union is larger than the union of the closures: a path that takes one step from each fork exists on neither. Rounds 0 to 4, 7, 8 and 9 are all this. It is why "what a fork read" has to include which assemblies could reach a piece, as both builds found; the reason is not special to canon by placement, only to canon being reachability.

**A way of seeing all of them at once** (an argument; not run). Every item on the frontier is a conjunction: this piece is in canon, *and* this is asked of it, *and* nothing on record meets it. Each conjunct is a relation that events add to or take from. A fork is stationary when no such conjunction is satisfied by its events. The union can satisfy one by taking the first conjunct from one fork and the second from the other. In every instance above the new item is of that shape: canon from A with a dependency from B; a question from B with a set-aside from A; one lapse from each. If that is the right general statement, then two forks meet exactly when some frontier item needs facts from both, which is a property of the frontier's definition and can be read off it, condition by condition, instead of being discovered by search.

## 5. How the model looks from here

**A line is a set and a state is a set read at a time.** Alloy has no sequences worth using, so a line had to be a set of events with their times, and a state that set read as of a time. That is the reading both builders say the spec forced on them (the Ada account's G1). Here it was not a reading taken; there was no other way to write it down.

**Fork, rewind and close are not operations in this view.** Row 3 of the story, the rewind, is not something that happens: it is a smaller set of events read at a later time. A fork is a set that contains a checkpoint's set. Closing is choosing which set the verisectorium now is. The only one of the four change-words that is a *fact* is checkpoint: that a certain set, read at a certain time, was stationary and was rested at. What the model says in verbs, Alloy says in which set is being looked at.

**Every sentence had to be sorted into "cannot be otherwise" or "may fail and is then owed".** Alloy has two places to put a rule: a `fact`, which no world may break, and a predicate, which a world may fail. Writing M0 put a handful of things in the first (a provisional filler is a filler; one event per time; a write records what its own references pointed at) and all of the numbered conditions in the second, because a fork must be able to pass through states that fail them. Core has an open row on this (which constraints are refusals); the relational view does not answer it, but it does not let the question be skipped for any sentence.

**What Alloy made obvious:** consistency as reachability (§1); canon as a closure, and so not additive over forks (§4); that the story's last row leans on an unstated reading (§3).

**What it refused or could not say:** "for every set" (§2); "the smallest" or "the typical" world (each instance is one that fits); anything about a real-sized verisectorium (31 events took three minutes to *evaluate*, with nothing to search for). It is an instrument for asking whether a sentence about the model is true of small worlds, and for being shown the world where it is not.

**What it would rename:** *consistent* as "nothing at fault upstream"; *the frontier* as a query over the record; *fork*, *rewind*, *close* as views of one growing set of events.

## What the lead's three guesses came to

- **G-A1** (with obligations unconditional, consistency needs no fixed point): held in M0 within the sizes above; argued, not tested, for the full spec.
- **G-A2** (the builds' small counterexamples from declarative statements, no generator): held for the three fixed-point cases. For forks it held in a different way than guessed: not the builds' two cases but a sequence of fourteen defeated statements, of which the builds' accounts name most; the fifteenth was not decided.
- **G-A3** (the smallest failing pair is write skew): not for the first twelve rounds; exactly that at round 13.

## Not done

Promises, waivers, unmarking, descent, warrant levels. Three or more forks; a fork closing after another has closed. Alloy 6's temporal operators. Any check of the argument at the end of §4. Round 14 of §4 to an answer. Larger sizes: nothing here was pushed past 4 pieces. The instances were read by me alone.
