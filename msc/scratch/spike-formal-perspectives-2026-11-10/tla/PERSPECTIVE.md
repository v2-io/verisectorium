# TLA+ looking at the model

*2026-11-10, by the TLA+ fork of the spike (Fable 5.2). For the spike lead, then an independent verifier, then possibly Joseph. It rests on `../01-common-reading.md` (the small model M0 and the story from note 22 §4.3). Nothing here is a fact about the model until it is adjudicated in core, and nothing here proposes a mechanism.*

## What TLA+ is, in one paragraph

A TLA+ specification names some variables, says how they start, and says which steps are allowed. A model checker (TLC) then visits every reachable state of a small instance and checks what you claimed: that something is true in every state, or true of every step. The language makes you answer two questions before anything else: *what is the state*, and *what counts as a step*. Most of what it showed about the model came from having to answer those two.

## What was built

| file | what |
|---|---|
| `Veri.tla` (245 lines) | M0. The function from (a line, the base) to a frontier, as plain operators; the steps learn, open, write, affirm, rewind, abandon, close; and the claims checked below. |
| `MCStory.tla` | Note 22 §4.3 as a universe: the pieces, S0, the evidence. A scripted run, and a free search. |
| `MCForks.tla` | The smallest two-fork universe I could make: claims c and x, x predicated on c, one outline. |
| `*.cfg`, `run.sh` | One configuration per run. `./run.sh <cfg> <module>` writes `runs/<cfg>.out` whole. |

Cuts from M0, all mine: assemblies are written once and never rewritten, so canon never moves; no *same* events, no set-aside, raise, promise or waiver; a fork does not select again a version it already selected. So nothing below speaks to canon moving, or to setting a finding aside.

## What it showed

### 1. The verisectorium's state is two things, and it has exactly two kinds of step

To write the checkpoint-level specification I had to say what a reader of the verisectorium can see. From note 22 ("at any moment the verisectorium *is* its latest checkpoint"; evidence can arrive against a checkpoint, and "it says so") the answer is a pair: the latest checkpoint's line, and everything recorded. Then there are two kinds of visible step and no others:

- **learn**: something is recorded; the line does not change;
- **close**: the line changes, the record does not, and the new line is stationary with the record as it then is.

Everything done on a fork (opening it, writing, affirming, rewinding, abandoning it) changes neither, so from outside it is no step at all. That is what TLA+ calls refinement with stuttering, and it is the same idea as note 22's "inside, it was many steps in sequence; from outside it is one logical instant". TLC checked that every step of the fork-level specification is a learn, a close, or invisible: `forks-2`, 1,141,264 states, two forks; `forks-5`, 815,172 states; `forks-9`, 2,512,166 states.

That check passes almost by construction, so the result is not the pass. It is what had to be said to state it:

- **A check made on a fork is a visible step.** Evidence goes to the base, and the base is half of what the verisectorium is. So "nothing on a fork is the verisectorium" is true of a fork's writes and decisions and false of what was found out there. In the story, B's check of c1′ is on the verisectorium's record from 09:00, though c1′ is in no checkpoint and never will be. The model says this on purpose (it is what makes going back lose work and not knowledge). TLA+ only makes it impossible to say the first sentence without the exception.
- **The model has no step that it promises will happen.** Every claim I could find to check is of the kind "nothing bad happens": a close only lands on a stationary state, a finding is not shed. Nothing says a perturbation is ever dealt with. TLA+ keeps those two kinds of claim apart by construction, and here the second kind is empty. I think that is correct for the model (waivers exist; "better" is a direction the model does not enforce), and it is worth knowing that stabilizing is entirely praxis: the model can say what is owed and cannot say that anything will be done about it. *This paragraph is a reading; nothing was run for it.*

### 2. "Every checkpoint is stationary" is not true of states. It is true of closes.

The spec's R11 says every checkpoint's state is stationary. Written as a claim about every state ("the main line with the base is stationary"), TLC refutes it in two states (`forks-8`): one finding is recorded against c, and the main line owes, with no step on the main line. Written as "the main line is stationary with the base as it stood at its last close", it holds in all 2,512,166 states of `forks-9`.

Both builders found this and reworded R11 (Ada G5, OCaml R11). What TLA+ adds is where the property lives. Stationary is not something the verisectorium *is*; it is something every *close* lands on. Between closes, the only thing that can be said of the verisectorium is that whatever it owes was learned since it last rested. Note 22 §4.2 already has the sentence ("the checkpoint was stationary when it was reached and is not now, and it says so"). The word "checkpoint" is doing two jobs there: the state that was rested at, which is fixed and stationary for ever because its record is frozen with it; and the verisectorium now, which is that line read with today's record. They are different objects and only the first is stationary.

It also sorts the steps by who takes them. Learning is not something the verisectorium does; evidence arrives. Closing is the only thing it does. So what a verisectorium can promise a reader is: I only move to states where nothing is owed, and I will tell you what has been learned since.

### 3. The story, run mechanically

`story-1-as-told` runs the table of note 22 §4.3 event by event and prints the frontier after each. Against the prose column:

| row | note 22 says | the conditions say, in addition or instead |
|---|---|---|
| 08:30 | c1 known wrong; u1 rests on it | the same |
| 09:00, c1′ tried | "c1′ is fine. But u1 needs the stronger conclusion" | c1′ is not fine by the letter: the auditor's case has not been looked for in it (the presumption of 3.3), and it shows as an open guard. Also owed: T's whole read, e beside the new claim, u's reference and u's check. The prose names the one item that made A give up, not the frontier. |
| 10:00, rewind | as at 08:30 | the same, exactly |
| 10:30 | c2 unchecked; T not read whole; u1 written against c1 | also: the auditor's case not yet looked for in c2 (cleared at 11:00, as the story has it); u unchecked, since its check read c1; **k2 not looked at beside e1** |
| 11:00 to 13:00 | as told | the same, plus the item on k |
| 14:00 | empty; S1 | **not empty. The close is refused**: k2 was never looked at beside the description it depends on. |

The last row is the one that matters. The kind says the eli8 depends on the description. The story rewrites the eli8 and nobody affirms it beside the description. A whole read of T does not do it by the letter (the spec's C2 asks for an affirmation, or evidence *about one filler* that read the other; a whole read is about T). With one affirmation added at 10:30 the story closes (`story-2-k-affirmed`). So either the example is missing an event, or a whole read is meant to count as having looked at the parts together. The common reading flagged that this might come out; it did.

A second thing in the story's own summary. Note 22 says the record holds "that B passed a derivation with an error in step 3". As the table is written it does not: at 11:30 A "finds an error in step 3 and writes d3", and the finding is not an event. The record holds B's check of c2 by way of d2, and a later write of d3; nothing on record says d2 was wrong. If A's discovery is recorded as a finding against d2 (`story-3-error-recorded`), the record does hold it, and then the close is refused for a new reason: a defect found in d2 is presumed present in d3 until someone looks for it there, and B's 12:00 check is about c, not d. With that look recorded (`story-4-error-answered`) it closes. So the sentence in the summary is true only if the 11:30 row gains an event, and that event costs a second one.

### 4. What the model lets this fork do that the story does not

A model checker can be asked the story's question backwards: given S0, the finding, and what minds *could* write and record, what are all the ways the fork can close? `search-*` do that over the story's own versions and evidence, plus three things I added as possibilities: c1′ does avoid the auditor's case; someone reads T whole while it still holds d2 and passes it; someone reads T whole with the old eli8 and passes it. (Evidence is learned as soon as it can be; see the comment in `MCStory.tla` for why that loses nothing here.)

- **It never closes with c1′** (`search-2`, all 639,311 states). Note 22: "neither d2 nor c1′ was ever in it". For c1′ the model enforces this by itself, because no check of u reads c1′.
- **It can close with d2**, the derivation with the error (`search-3`, a 13-state trace). Nothing in the conditions stands in the way, since the error was never recorded. This is the same fact as the second half of §3, from the other side.
- **The shortest close keeps the old eli8** (`search-1`, an 11-state trace: write c2 and d3, check, affirm e beside c2, write u2, check, two whole reads, close). The eli8 depends on the description; the description was affirmed unchanged; so nothing asks anyone to look at the eli8 again, though the claim under both has gained a hypothesis. Only the whole read stands between a stale eli8 and S1. That is how core's «changeset» words the rule too (a dependent of what *changed* is changed or affirmed), so it is the model as written and not a slip in M0. Whether an affirmation of the middle of a chain should shield the end of it is a question the example raises and I have not seen asked.

These three depend on the pool I gave the search, and the second and third on evidence I invented as possible. What they establish is what M0's conditions permit, not what would happen.

### 5. Two forks: the order of a line is the one thing that must not be read

`MCForks.tla` lets two forks from one checkpoint interleave every way. I ran three rules for when a fork may close: the resulting line is stationary; that, and the fork's own line is stationary too; that, and nobody else has closed since it opened ("fresh"). And the two ways the builders found to make the resulting line: merge by time, or append.

| run | rule | claim | result |
|---|---|---|---|
| `forks-1`, `-1b`, `-1c` | merged stationary / both; what a write was written against is worked out from the line | no reference counts as reconciled against a version its writer never saw | **refuted**, 9- and 10-state traces. `-1c` is exactly the OCaml build's clock case: A rewrites c and closes; B, who never saw it, rewrites x; B's write is later in time, so on the merged line x "was written against" A's c. |
| `forks-2` | merged stationary; a write records what it saw (Ada G10) | the same | holds, 1,141,264 states |
| `forks-3`, `-3b` | merged stationary / both; merge by time; writes record what they saw | every write on the main line replaced the version standing before it | **refuted**. In `-3b` A rewrites c, checks it, reconciles x and closes; B, from the old checkpoint, does the same with a different rewrite of c and closes. Each fork was stationary alone and the result is stationary. A's version is gone and nobody who saw it decided that. In `-3`, under the weaker rule, B closes first and A's later close buries A's own write *in the past* of the main line: the close changes nothing about what is selected and reports success (and A's rewrite had not even been checked; only the merged line is asked). |
| `forks-6`, `-6b` | the same, appending | the same | **refuted** the same way |
| `forks-4` | merge by time | the main line only ever grows at its end | **refuted** in 7 states. As a *set* of events it only grows (`forks-2`). As a sequence, a later close inserts events before ones already there. |
| `forks-7` | append | the main line only ever grows at its end | holds, 1,262,814 states |
| `forks-5`, `-9` | fresh | all of the above | all hold: 815,172 states; 2,512,166 with a finding in play |

What this says about the model, in its own words:

- **The clock case and the lost rewrite are one fault.** In both, what is owed was read from *where an event sits in a line*: "what this write was written against" from the events before it, "which version is selected" from the write after which there is no other. A line that is assembled by merging has an order nobody chose. Where the event itself records the fact (the Ada build's G10: a write records what it saw), the test "is the merged line stationary" is sound for that fact; TLC found no failure in 1.1 million states. Selection has no such record in M0 or in the spec, so two rewrites of one piece merge silently and the later clock wins. The spec's own rule avoids this (§6: a fork may close after the main line has moved only if its events and theirs do not meet, and two writes of one id meet). The OCaml account §7.1 asks whether stationarity of the merge could be the rule instead. In this universe the answer is: only for the facts that events carry explicitly, and "which version this write replaces" is not yet one of them.
- **"Events are only ever added" is true of the base as a set and is not true of a line as a history, if closing merges by time.** A reader who asked "what did the main line select as of noon?" before and after a later close can get two answers. A checkpoint survives this only by being kept as what it was (a snapshot), which is the reading the Ada build took (G1). Appending keeps the history and breaks the clock. TLA+ does not say which to want; it says the sentence in note 22 §4.2 ("events are only ever added") needs "to what" after it.
- **I did not check either builder's code for the lost rewrite.** Ada's G6 counts 1,938 pairs where both forks wrote one id and the union owed something; whether there are pairs where both wrote one id and the union owed *nothing* is the question, and the accounts do not say.

## What TLA+ refused, could not say, or was poor at

- **It gave no help with the state-to-frontier function.** That function is about 75 of `Veri.tla`'s 245 lines (the fork's own later count; this sentence first said three quarters) and it is plain set theory with no types. TLA+ neither checked it nor shaped it: the parser caught one precedence slip, and whether the operators mean what M0 says was checked only by my reading the story's trace against the table. Whatever is learned about the nine conditions will be learned in a language that has something to say about data.
- **Time is expensive.** Every event carries a time, so two independent events in either order are two different states, and the checker cannot see that they commute. A universe of three pieces and two forks took 1 to 2.5 million states and up to eight minutes. The OCaml build visited 8 million *pairs of forks* in universes larger than this. For questions about the function, exhaustive search in OCaml is far better. TLC earns its place only where the question is about orders of steps.
- **Nothing was proved.** TLC checks small instances. TLA+ has a proof system (TLAPS); I did not use it, and for this model I would not reach for it before Lean or SPARK.
- **It cannot say "owed".** A TLA+ state satisfies an invariant or does not. The frontier, a thing that is computed, shown and worked off, is in this specification only an ordinary value I chose to compute. The language sees two kinds of predicate: ones I assert of every state, and ones that gate a step. The model's third kind, a condition that is allowed to fail and whose failures are the work, has no native place.

## What it would rename

- *Atomic changeset*: one step of the checkpoint-level specification. *What happens on a fork*: no step. The model's two clocks are the two specifications.
- *Checkpoint*: two words. The state rested at (frozen with its record), and the verisectorium now.
- *Perturbation*: a learn step; the environment's move.
- *Stationary*: a property of where a close lands, not of the verisectorium.

## What became of the guesses in `../02-guesses-before-running.md`

- **G-T1** (a fork-level specification implements the checkpoint-level one): borne out, and nearly by construction. The content was in what had to be made visible: the base.
- **G-T2** (learning must be a visible step, or R11 is false as an invariant): borne out. Two visible steps, learn and close; R11 as a state invariant fails in two states.
- **G-T3** (interleavings reproduce the clock case): borne out, and it came with a second failure of the same kind that I had not guessed (the lost rewrite), and a third observation (the main line's past changes under merging).

Not guessed, and found: the story as told does not close (k2); the story's summary claims a record its table does not make (the error in d2); the shortest close leaves the eli8 untouched.

## What was run, what was only read, what is a guess

**Run** (TLC 2026.11.06, from `tla2tools.jar` v1.8.0, sha256 `e1f11b75…bcd7f`; OpenJDK 27.0.1; 2 workers). Every result above names its run; every `runs/*.out` is whole. Counts are of distinct states.

| run | outcome |
|---|---|
| `story-1-as-told` | deadlock at the close: one item left (k). 19 states |
| `story-2-k-affirmed` | closes. 21 states |
| `story-3-error-recorded` | deadlock at the close: guard open on d. 21 states |
| `story-4-error-answered` | closes. 23 states |
| `search-1-shortest-close` | a close found at depth 11 (202,570 states visited before it) |
| `search-2-never-with-c1p` | holds; exhaustive, 639,311 states, depth 18 |
| `search-3-never-with-d2`, `search-4-never-with-k1` | refuted, traces of 13 and 11 states |
| `forks-1`, `-1b`, `-1c`, `-3`, `-3b`, `-4`, `-6`, `-6b`, `-8` | refuted, with traces |
| `forks-2`, `-5`, `-7`, `-9` | hold; exhaustive within `now <= 12` |

Two caveats a verifier should have. The exhaustive two-fork runs are bounded by a clock limit (`MaxNow = 12`, six or seven timed events after the checkpoint) and by forks of at most two line events; "holds" means within that. And `forks-2`, `-7` and `-9` were run before three later edits to `Veri.tla`, all additive (a third close rule, a stricter variant of one invariant, and a weakening of the lost-rewrite invariant so that writing the same version twice does not count); none changes what those three configurations check, and `forks-5` was re-run after them with the same counts. Re-running the three takes about fifteen minutes.

**Read, not run**: the comparison with the builders' accounts (I read both draft-4 accounts whole, and none of their code). Lamport's refinement and stuttering are named from memory of the TLA+ literature, not checked against a text tonight.

**Guesses of mine**: that the absence of any promised step is right for the model (§1); that "which version a write replaces", recorded by the write, would make the lost rewrite visible to the conditions the way G10 made the clock case visible (§5). I did not build the second.

## Re-running

```sh
cd msc/scratch/spike-formal-perspectives-2026-11-10/tla
curl -sSL -o tla2tools.jar https://github.com/tlaplus/tlaplus/releases/download/v1.8.0/tla2tools.jar
./run.sh story-1-as-told MCStory      # likewise every story-* and search-* with MCStory
./run.sh forks-1c-clock-both-strict MCForks   # likewise every forks-* with MCForks
```

The jar is not tracked (`.gitignore`). v1.8.0 is the project's rolling pre-release, so the file at that address may differ later; the one used here is identified by the checksum above. The v1.7.4 jar does not accept `ALIAS` in a configuration file, which every configuration here uses to print the frontier in traces.
