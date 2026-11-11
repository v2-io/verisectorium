# What rules-and-facts languages see in the model

*2026-11-11, by the spike lead (Fable 5.2). Three engines were used on one small program: clingo 5.8.3 (stable models), Soufflé 2.5 (stratified Datalog, with provenance), SWI-Prolog 10.0.2 (well-founded semantics by tabling). The program is M0 of `../01-common-reading.md`, which is my reduction of note 22 and kernel spec draft 4, not either of them. Every run cited is in `runs/`, whole. Nothing here is a fact about the model until it is adjudicated in core.*

*Corrected 2026-11-11 after the independent read (`../de-novo-feedback-1.md`); what changed and why is in `../08-corrections-after-the-independent-read.md`.*

**How to read the labels.** *Run*: a tool produced it, and the file is named. *Read off the rules*: obtained by a script of mine over the program's text, with no state run; sound only if the standard theorem it leans on is as I remember it and the script has no bug. *Standard*: a result from the literature, which I checked against a text only where it says so. *Guess*: mine.

## To re-run everything

```sh
cd msc/scratch/spike-formal-perspectives-2026-11-10/datalog
clingo m0.lp story.lp --outf=0 -V0 | tr ' ' '\n' | sort                              # runs/01
clingo m0.lp story.lp reading-write-looks.lp --outf=0 -V0 | tr ' ' '\n' | sort       # runs/02
for f in loops/p*.lp; do echo "== $f"; clingo $f 0 --outf=0 -V0; done                # runs/03 (p5b is a fact to add to p5)
swipl -q -g main -t halt loops/wfs.pl                                                # runs/04
for f in loops/strat-*.dl; do souffle $f; done                                       # runs/05
python3 polarity/polarity.py m0.lp reading-write-looks.lp                            # runs/06
python3 polarity/polarity.py polarity/m0-split.lp                                    # runs/08
clingo m0.lp story-forks.lp --outf=0 -V0 | tr ' ' '\n' | sort                        # runs/09, first half
clingo m0.lp story-forks.lp reading-against-computed.lp --outf=0 -V0 | tr ' ' '\n' | sort   # runs/09, second half
for T in 20 35 75 95 106 115; do clingo m0.lp story.lp reading-write-looks.lp selections.lp <(echo "view(free,$T).") 0 --outf=0 -V0; done   # runs/12
clingo m0.lp conditions/reading-conditioned-acceptance.lp conditions/story-assumption.lp 0 --outf=0 -V0                    # runs/13, first half
clingo m0.lp conditions/reading-conditioned-acceptance.lp conditions/story-assumption.lp conditions/loop.lp 0 --outf=0 -V0  # runs/13, second half
clingo causal/m0-causal.lp causal/story.lp --outf=0 -V0 | tr ' ' '\n' | sort              # runs/15 (diff against runs/02: none)
clingo m0.lp causal/holes-clock.lp --outf=0 -V0 | tr ' ' '\n' | sort                      # runs/16, first half
clingo causal/m0-causal.lp causal/holes-causal.lp --outf=0 -V0 | tr ' ' '\n' | sort       # runs/16, second half
python3 polarity/check_good_news.py                                                     # runs/14 (about fifteen seconds)
```

Everything finishes in under a second. `runs/10` is Soufflé's interactive explainer, fed from a pipe; the command is at the end of this file.

## 1. The story runs, and the conditions do not quite give the story's own table

`m0.lp` is 55 rules. `story.lp` is note 22 §4.3 as stored facts: the writes, the twelve pieces of evidence, the affirmations, and one line per row of the table saying which events the line has and as of when. The frontier at each row is computed (**run**, `runs/01-story-frontier.txt`).

Rows 1, 3, 5, 6, 7 and 8 come out as note 22's right-hand column says, apart from the eli8 item below. Four places differ, and each is the conditions being more exact than the prose, not a bug in either:

- **09:00, the weakened claim.** The note says "c1′ is fine". By the note's own rule (§3.3: a defect once found is presumed still there until someone looks for it by the same criterion) c1′ is not fine yet: B checked that it follows, and nobody looked for the auditor's case in it. The conditions also owe a whole read of T and a look at the description beside c1′. None of this changes the story (the attempt is abandoned for the reason the note gives), but the dead end was further from stationary than the table suggests.
- **10:30, the auditor's case.** The note's column for 10:30 does not list it, but until B looks for the auditor's case in c2 (which the story has B do at 11:00) the guard from the finding is open on c2. The story does the right thing; the column leaves it out.
- **10:30 onward, the eli8.** Nobody in the story looks at the rewritten eli8 (k2) beside the description (e1). I had predicted this one in the common reading. By the letter of condition 6 it is owed at every row from 10:30 to the end, **and S1 is not stationary** (`runs/01`, last rows). It becomes stationary under one added reading: a write of a dependent piece counts as having looked at what it depends on, as that then stood, and the write records it (`reading-write-looks.lp`, `runs/02`). That is the same move condition 2 already makes for references. Whether the 14:00 whole read of T should also count as looking at k2 beside e1 is a second possible reading, and a different one: under it condition 6 does no work wherever a root asks for whole reads.
- **S0 read again at 14:00** (the main line, no fork, everything known): it owes the finding against c1 and u's resting on it. This is the note's "the checkpoint was stationary when it was reached and is not now, and it says so", computed. The abandoned first fork, read at 14:00, owes exactly what it owed at 09:00: nothing learned since is about its versions.

## 2. What this way of seeing makes obvious

### 2.1 "Computed, never typed" is the theory's line, and the engines do not hold it

The theory of these languages divides relations into stored and derived, and takes the two sets to be disjoint: a derived relation has rules and no facts. That is note 22 §3.6 exactly, and I expected the tools to enforce it. **They do not** (**run**, `runs/11-typed-status-is-accepted.txt`). Adding the one line `stationary(r1_0830).` beside the rules makes clingo report the 08:30 row as stationary, with the finding against c1 still owed in the same answer; Soufflé prints a hand-written `owed` fact beside the computed ones without a warning. To both engines a fact is a rule with no body, and a status typed by hand is indistinguishable from one that was computed.

So the oldest rule in the model is a one-line check in this family (no relation both has rules and has facts; `polarity.py` computes the two sets), and it is a check someone has to run. It does not come free. This overturns the strong form of my guess G-D1.

The view does see **two** rows where the model has three. *Written* and *recorded* are both stored facts; nothing in the language tells a version from a piece of evidence. What it does tell apart is how the rules read a stored fact, which is §2.4.

### 2.2 Fault needs a reason. Consistency is the absence of one.

These languages compute least fixed points: a derived fact is true only if something derives it. The kernel spec defines *consistent* as a greatest fixed point, and both builds report that it is "not the only fixed point" (two pieces resting on each other are consistent together, or inconsistent together, with nothing wrong with either; R7).

Written the way this family writes things, the recursion is on **fault**:

```
fault(P) :- owed(_, P).                 % it owes something itself
fault(P) :- rests(P, Q), fault(Q).      % or it rests on a piece at fault
```

and consistent is its absence. The ring then has one answer and no choice was made: neither piece is at fault, because nothing derives that either is (**run**: `loops/p3-ring.lp`, one stable model; well-founded value *false*; Soufflé accepts it and prints both pieces as fine). This is also how core already says it («frontier»: "Unsettledness spreads only along what rests on what"). It makes one default explicit (fault needs a reason) and does not show the model wants that default over the other (consistent needs a reason), under which the ring would be refused.

The same file holds note 22's condition 5 transcribed literally ("rests only on pieces … that are themselves consistent") as a rule. That version has **two** stable models, and its well-founded value is *undefined* (**run**, `runs/03`, `runs/04`). So the non-uniqueness both builds measured (66 states in 100,000 in one, a hand-built ring in the other) is a property of the direction the sentence is written in. Stated as "a piece is at fault when it owes something or rests on one that is", there is nothing to choose.

### 2.3 The builds' rule about conditions is three different things, and the family has a name for each

Note 23 (b): consistency is well defined provided no question, promise or waiver is conditioned on whether something is consistent. The six small programs in `loops/` take that apart (**run**, all three engines; `runs/03`, `04`, `05`).

| the case | stable models | well-founded value | stratified Datalog |
|---|---|---|---|
| a question about p that stands only while p is consistent | **none** | undefined | refused |
| two questions, each standing only while the *other* piece is consistent | **two** | undefined | refused |
| a *waiver* of p's defect that stands only while p is consistent | **two** (waived and fine; not waived and at fault) | undefined | refused |
| a decision about r2 that is good while an *upstream* assumption x is not at fault; x does not rest on r2 | **one** | defined: good; and when x is found false, r2 owes | **refused** |
| the same, but x rests on r2 | two | undefined | refused |

Reading the table in the model's words:

- The first row is the builds' one-piece counterexample, and it is the liar: an obligation that exists only if it is met. No semantics gives it an answer.
- The second and third rows are not paradoxes. They are self-supporting: each has two answers that are both coherent, and the only question is which to take. The spec's greatest fixed point takes the generous one (the waiver stands because the piece is consistent because the waiver stands). A reader may well not want that, but it is a different defect from the first row's, and the builds' rule treats them as one.
- **The fourth row is the one that matters.** A decision conditioned on how an upstream piece stands, where nothing leads back, has exactly one answer under two of the three semantics, and behaves as note 22 §3.4 and `impl-an-outline-fills-in` step 7 want: the named assumption fails, and the decision resting on it stops supporting anything, with not a word rewritten. The rule "unconditional" does not forbid this, as I first wrote: draft 4 gives acceptances conditions. What stopped the builders was narrower (Ada G11 is a reading that builder took to avoid a circle; the OCaml account leaves it untested).
- Soufflé refuses the fourth row with the same error as the first. Its test is on relation names: *fault* depends on *not good*, which depends on *not fault*. That is the same test as "no obligation may be conditioned on consistency", and it is blunt in the same way. The finer test is on the pieces themselves: no chain of conditions and restings leads from a piece back to itself. In the literature the first is *stratified*. I called the second *locally stratified*, and the independent reader says that is the wrong name: local stratification is a property of the ground program whatever the facts are, and `conditions/reading-conditioned-acceptance.lp` is not locally stratified. The notion that depends on the facts is *weak* or *modular* stratification, for which the same conclusion (one model, total under the well-founded semantics) holds. That is from the reader's memory of the literature and checked by neither of us; I think the reader is right.

So the lead's guess holds: stratification is the builds' finding (b). And it sharpens: the exact boundary is not "unconditional" but "no cycle through a condition", which is a property of a state, of the same sort as the spec's existing "no capping cycle" (C3). **How far this is shown.** On the five programs above, of two to six rules each. And once inside M0 (**run**, `runs/13-conditioned-acceptance.txt`): `conditions/` adds a root that asks for an acceptance, an acceptance that is good while a named assumption is not at fault, and the story of `impl-an-outline-fills-in` steps 4 and 7. With the assumption upstream there is one answer: stationary before; and after a check finds the assumption false, the result owes a good acceptance, with nothing rewritten. With the assumption made to rest on the result, there are two answers at the same moment (everything fine; or the acceptance not good and the assumption resting on a fault). My script reports the cycle through negation in the rules (`cond_fails` to `good`), which is what Soufflé would refuse. I have not tried any of this on the builds' universes, and one story is one story. The well-founded semantics suggests a third stance beside refusing and choosing: a decision whose condition loops gets the value *undetermined*, which is itself something that can be shown as owed. That is a stance, not a proposal.

### 2.4 Which news is good can be read off the rules, without running a state

In a stratified program, if a stored relation reaches a derived one only through an odd number of negations, adding stored facts can never add derived ones (**standard**; from memory, not checked against a text). `polarity/polarity.py` reads a rule file and reports, for each stored relation, by which parities it reaches `owed`.

On M0 as first written the answer for evidence is "either", because one relation carries good and bad news. `polarity/m0-split.lp` is the same function with the recording of evidence that holds, and of evidence that fails, as two stored relations (it gives the identical frontier on the story: **run**, `runs/07`). On that (`runs/08`, **read off the rules**):

| stored | toward *owed* | the builds' finding it matches |
|---|---|---|
| marking as recorded a piece of evidence that holds, *its description being already there* | can only remove | part of R6. For the description itself (`evd`, `reads`) the script says "either" (`runs/08`), and recording a new piece of evidence adds all three; so the rule graph alone does not give R6. I had left those two rows out |
| *same*, said of evidence that holds | can only remove | R6's second condition |
| *same*, said of a finding | either | "carries bad news forward as readily as good" |
| an affirmation; a waiver; what a write records it was written against | can only remove | |
| raising a question | can only add | |
| setting aside evidence that holds | can only add | OCaml §3.4 |
| setting aside a finding | **either** | Ada G8: "a set aside is not good news" |
| recording a finding | **either** | OCaml's reading 8: a failing answer still answers the question |
| a write; marking a root | either | R10: unmarking a root can add items |

The builds reached these by search and by hand-built probes. Here they are paths in the graph of one small program's rules. The limits are real: this is M0, which has no warrant levels, so the builds' first condition (`read_as` monotone) is true of it by construction and is not tested; the script reads relation names and not arguments, so it can say "either" where a finer reading would say "only remove" (it did, for raising a question, until I rewrote the rules for questions in the split form); and I have not checked the script against anything but these two programs. One sanity check by running states (`polarity/check_good_news.py`, `runs/14`): 1,350 single additions of evidence that holds to the story, in every shape a small vocabulary allows and at two times; none made any row owe anything new, and 51 removed something. That tests the story's rows and nothing wider.

### 2.5 Two things read the order of a line, and both are where the faults were found

Everything in `m0.lp` is computed from the line's *present* selection and the stored facts, with one exception: the guard (rules at lines 63–64). And the present selection is itself read from the order of the line: a piece is at the version of its *latest* write. "Met by evidence that holds on the same criterion … provided that evidence applied when recorded" needs the selection of every piece at every earlier time, and "a version the line once selected" needs the line's history. Nothing else in the program asks what the line used to be.

Both builds, separately, found their holes there: Ada's G2, G3 and G4 ("three of the four holes this build found are in exactly that layer, in the wording of when a guard stands"), OCaml's §3.2 (a check made before the write does not count; going back and forward loses an answer) and §3.3. In this view those are one observation. The frontier is a function of the present selection and the record everywhere except in the one rule that makes a found defect stick, and that rule is where a base that is the same for every line and a history that differs per line have to be joined. I did not at first see that "latest" is the same kind of thing; the TLA+ fork's lost rewrite showed it.

**Then tested, after the TLA+ fork's result came in** (`causal/`, **run**, `runs/15` and `runs/16`). The TLA+ fork found a second fault of the same family (two forks each rewrite one piece, each is stationary alone, the merged line is stationary, and whichever write is later by the clock silently wins), and read it as: something owed is being read from where an event sits in a line. That and the paragraph above are one observation, so I rewrote M0 on a different footing and ran both.

`causal/m0-causal.lp` is M0 with one change. Every write records what its writer saw: which write it replaces, as well as what it was written against and beside. Then a piece's selected version is "written and not replaced", not "written last by the clock"; a guard is read from the piece's own chain of replacements and from evidence *about* versions; and no rule compares the times of two events. Times stay on events and are used for one thing: which events a view has yet.

- On the story it gives the identical frontier at every row (`runs/15`). It is no longer than M0 (52 rules against 55, and the three it lacks are the clause for raised questions, which I left out): the apparatus for "the selection as of an earlier time" is gone, and a piece's chain of replacements has taken its place.
- On five small cases from the builders' accounts and the TLA+ fork's (`runs/16`):

| case | by the clock | by what each write saw |
|---|---|---|
| two forks each rewrite c (TLA+ fork's lost rewrite) | union stationary; the later write wins silently | **owed**: c has two versions, neither replacing the other |
| found wrong, fixed and answered, the bad version put back, then any edit (OCaml §3.3) | stationary: the defect is shed | **owed**: the guard is open |
| the fix is checked for the case before the line has it (OCaml §3.2) | owed: the check "did not apply when recorded" | stationary: the check is about that version |
| an old pass, then a finding on the same criterion, reworded with the old pass carried (Ada G2) | owed | owed |
| a draft found wrong on a fork, the fork rewound, the draft re-entered reworded (Ada G3) | stationary: the hole | stationary: **the hole remains** |

**What that table does and does not show** (rewritten after the independent read, which was right). The first row comes out owed because I wrote a clause for it (`c0_two_versions`); remove the clause and the union is stationary on this footing too. What the footing gives is that the clause can be said. The second and third rows come out the same way on the clock footing with only the guard reworded (`causal/m0-clock-guard-reworded.lp`, the reader's three rules; `runs/19`), so they were faults of the guard's wording and not of the footing. On one line the order of replacement and the clock's order are the same order; they differ only after a merge, and only the first row is a merge. The case where the footing does real work with no clause is the reader's, not one of mine: a finding on a claim, one fork fixing it and having the defect looked for, another fork rewriting the claim differently and unlooked-at. On the clock the union owes nothing; on the causal footing the guard stays open along the second fork's own chain, with or without the two-versions clause (`causal/merge-guard-*.lp`, `runs/19`). One is not helped on either footing: a write that does not say what it descends from sheds what was found against it, on either footing. That last is note 22's open item on descent, and no footing closes it, because it is a writer leaving something out.

The clock case (§2.6) cannot be stated on this footing at all, since nothing reads order.

Costs I had not reported, all the reader's. A pass that read something the line never had answers a guard here, where the clock wording asked that it applied. What a write says it replaces is testimony nothing checks: a write that falsely names another piece's write as replaced leaves that piece unselected and out of canon, and the state stationary. "Later than the finding" is gone as well as "answered since". And all three faults that are about merges need a fork to be allowed to close on the stationarity of the merge, which the spec's own rule (§6) does not allow.

What this is and is not. Joseph's sentence asks for "causal ordering, fwiw, definitely a clock and an addative base". The spec took the clock as the order ("times are totally ordered") and both builds, the TLA+ fork and this file then each found a fault that comes from reading it. That is a hypothesis about merged lines, with one good case behind it, one case that needs a clause, and the costs above; the first version of this paragraph said "the clock is for the record", which was more than was shown. **This is M0, not the spec**: no retirement or descent, no raised questions (I dropped that clause here; it compares a question's time with an answer's, and would need the answer to name the question), and nothing was searched. It is a perspective with a small test behind it, and whether the model should say it is not this spike's to decide.

### 2.6 What a mind saw is stored, never derived

`story-forks.lp` has three forks from one checkpoint (**run**, `runs/09`). Two unrelated repairs under one outline both close: their union is stationary, and the outline is not a meeting place. A fork that rewrites c and a fork that rewords a piece w predicated on c each close alone, and their union owes: w2 was written against c1.

Under the other reading of "written against" (worked out from the line: what was c at when w2 was written?), the union is stationary, because in the merged line the rewording comes after the rewrite by the clock, and the rule credits w2's writer with having seen a version of c it never saw. This is Ada's G10 and OCaml's clock case, and both builds fixed it the same way.

In this family it has a one-line statement: *what a write was written against* cannot be a derived relation, because a derived relation is a function of the line, and merging two lines changes the line. It has to be a stored fact, set down by whoever did the looking. The same holds for what evidence read (the builds' rule 2) and for an affirmation. Those are three instances of one thing: **what a mind looked at is testimony, and an engine that works it out from the record instead will, after a merge, be testifying for the mind.** Draft 4 has two of the three as rules and found the third as a bug.

### 2.7 A frontier item is a proof, and its leaves are its two halves

Note 22: the frontier is "every place one of these fails, each naming what failed and what it would take". Soufflé keeps the derivation of every derived fact. For the claim c at 11:30 (**run**, `runs/10`, on a cut of M0 for that one row):

```
asks_valid("c")   !checked("c")
-------------------------------
     owed_unchecked("c")
```

and asked why c is not checked, it answers: the check E7 would do it, E7 does not apply, because E7 read d at d2 and d is not at d2. The stored facts in the tree that are present are *what failed* (the root asks; E7 read d2). The ones that are absent are *what it would take* (d back at d2, or a check that read d3). An item's cause and its remedy are the two kinds of leaf of one tree. Nothing has to be designed for the frontier to name them.

### 2.8 There is no "append", so the builders' reading is the only one available

A line is a set of timed events; a state is read as of a time; closing two forks is the union of their events. Both builders had to choose this reading against the spec's wording (Ada G1, OCaml §4 items 1 and 2). In these languages there is no other way to write it: `story.lp` says of each row which branches the line has and as of when, and that is all a row is.

## 3. What it refuses, and what it cannot say

- **It refuses, by default, every conditioned decision** (§2.3). A stratified engine cannot run note 22 §3.4 as written. An answer-set or tabled engine can.
- **It cannot say "better".** Everything here is about one state. A comparison of two states is outside the program, and I did not try to bring it in.
- **It cannot say who.** By the spec's own choice; but note that "what a mind saw is stored" (§2.6) is the place where *who* will have to attach when it comes back.
- **It has no notion of a refused write.** Every set of stored facts is a state, and anything wrong with it is owed. Core's "refused as a draft" (a segment changeset whose inner dependents are neither changed nor affirmed) would have to live in whatever puts facts in, not in the rules.
- **Levels of warrant** would need either aggregation or a rule per level; I left them out of M0, so nothing here speaks to caps.

## 4. What it would rename

- *Consistent* → not at **fault**; and condition 5's second half as "fault spreads along resting", which is core's older wording.
- *Unconditional* (of a question, promise or waiver) → **well-founded**: its condition does not lead back to itself.
- *Good news* → a stored fact the frontier is **antitone** in. The spec's list of what counts (R6) is then a column of a table, not a definition.
- The spec's *times are totally ordered* → each event names what its maker saw; the clock is kept and nothing owed is read from it (§2.5).
- The spec's *base* and *line* → facts the rules read the same way whatever else is known, and facts the rules read through "latest". By that test an affirmation and a waiver read like evidence (§2.4: they can only remove), though the spec puts them on the line. Whether a decision made on an abandoned fork *should* be known on the next one is a question about people, which this view cannot answer; it only says the logic does not force the spec's cut. Note 22 lists that cut first among the choices that are the lead's.

## 5. What was not done

- The program is M0, not draft 4: no warrant levels, no `read_as`, no caps, no descent or retirement, no overclaims, one root, nobody's standing.
- Nothing here searches a space of states. Every result is about the story, the three-fork story, or six toy programs. The polarity table is about all states of M0 only if the standard theorem and my script are both right.
- The Soufflé provenance run in `runs/10` is on a cut of M0 for one row. M0 itself has since been translated to Soufflé and accepted (`souffle/`, `runs/17`; see `../07-datalog-family-apart.md`).
- `m0.lp` holds conditions 1, 2, 4, 5, 6 and 9: six of note 22's nine. The two about how well something stands, and the one about promises, are not here.
- Condition 5 had a defect, found by the independent reader: a canon piece resting on a piece outside canon was marked at fault and nothing was owed. Corrected in all four programs; no earlier run changed (`runs/19`, last block).
- §2.5's causal footing and §2.3's finer boundary are tested only as far as each section says.
- `selections.lp` and `runs/12` (which combinations of versions ever written could be rested at, with no line) are described in `../03-other-bodies-of-work.md` §3, since the question is truth maintenance's.

```sh
# runs/10
cd explain && printf 'setdepth 8\nexplain owed_unchecked("c")\nexplain read_bad("E7")\nexplain applies("E8")\nexplainnegation checked("c")\n1\n"E7"\n"c2"\nexplainnegation applies("E7")\n1\n"c"\n"c2"\n"valid"\n"holds"\nexit\n' | souffle -t explain row6.dl
```
