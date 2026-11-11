# De novo feedback 1 on the formal-perspectives spike

*2026-11-10, late evening (MST). By a Fable 5.2 agent asked for an independent critical pass, with no brief beyond "audit it and write here". I am the same model as the spike's makers, so this is a different context and not a different mind. I changed nothing in the spike; this file is the only thing I added. Nothing here is adjudicated by anyone.*

## What I read, ran, and did not

**Read whole, myself:** `README.md`, `DEBRIEF.md`, `01`, `02`, `03`, `05`, `proposed-integration-plan.md`; all four `PERSPECTIVE.md`; `datalog/` every `.lp`, `.pl`, `.py` and the runs I cite; `lean/Vk/Model.lean`, `Story.lean`, `Fault.lean`, `Refusals.lean`, `View.lean`, the mutations and the build log; `tla/Veri.tla`, `MCForks.tla`, `MCStory.tla`; `alloy/m0.als`, `forks.als`, `forks4.als`, `forks5.als`, `forks7.als`, `fixpoints.als`. Outside the spike: `msc/notes/22` and `23`, `KERNEL-SPEC.md` draft 4.

**Read in part:** `lean/Vk/GoodNews.lean` (statements and the last third; not every lemma's proof), the Ada account (G1 to G12 and the R7 lines), the OCaml account (by search, around the clock case, R7, and `impl-an-outline-fills-in`), `core/def/changeset.md` (the Definition and Invariants lines that the perspectives cite), the Bailis paper (the pages holding Definition 5, Definition 6 and Theorem 1).

**Read and found nothing to report:** `lean/Vk/Tiers.lean`.

**Not read:** `alloy/story.als`, `forks2.als`, `forks3.als`, `forks6.als` and their saved instances (rounds 5 to 11); most TLC traces; the builders' code; kernel spec draft 3; any source in `03` other than Bailis. Nothing below speaks to those. This pass is of the spike as committed at `599199d` and `4fa250e`. While I worked, someone added `07-datalog-family-apart.md`, `datalog/souffle/` and `datalog/runs/17` and `18` (untracked when I finished); I did not read them, and where they bear on a finding below (the perspective's "M0 itself was not translated to Soufflé", for one) I have not taken them into account.

**Ran** (clingo, Lean, TLC, all on copies in a scratch directory; at most two processes at a time):

- Datalog: `runs/01`, `02`, `15`, `16` reproduce; the split program gives the same frontier as `m0.lp` on the story; `polarity.py` reproduces `runs/08`.
- Lean: built from clean in a copy, exit 0, the same 25 axiom lines; the three mutations fail as the perspective says. The only `sorry` is the deliberate one in `Tiers.lean`.
- TLC: `story-1`, `forks-8`, `forks-3b` reproduce (19 states and a deadlock; 2 states; `NoLostUpdate` violated). `forks-9` and `forks-2`, two of the three the TLA+ file says were run before its last edits to `Veri.tla`, reproduce with identical counts (finding 6).
- Alloy: nothing re-run. I read three saved instances by hand (rounds 12, 13 and `forks7`).
- Eight small probes of my own, given inline below so they can be re-run.

## In short

The exemplars run and their logs are what the files say they are. The perspective files are careful, each more careful than the debrief built on them. The trouble is mostly in the step from the perspectives to `DEBRIEF.md` and the plan: qualifications the forks wrote did not survive, and the item the debrief puts first claims more than its own programs show.

Ordered by how much I think each matters:

1. **Debrief item 1 (the causal footing) is over-attributed.** Of the three cases it says come right "with no clause written for them", one needs a clause that was written for it, and the other two come right on the clock footing with only the guard reworded. On a single line the clock's order and the order of replacement are the same order; they differ only after a merge. There is a case where the footing does real work with no clause, and the spike did not write it. I give it.
2. **Debrief item 6, "S1 is not stationary by the letter", leaves out that core's own rule says S1 is reached as told.** Three of the four perspective files point at that rule. The debrief and the plan do not.
3. **Debrief item 3 says the rule forbids a decision conditioned on an upstream piece. The rule as written does not.**
4. **The good-news row of the polarity table was read off the rules only for a flag.** The same script reports "either" for the description of a piece of evidence, and the table omits those rows.
5. **"The nine conditions are rules, about fifty lines" is six of the nine**, and the plan's main recommendation rests on it.
6. **The 2.5 million states behind debrief item 5 check something true by construction.**
7. **`datalog/m0.lp` has a defect in condition 5**: a canon piece resting on a piece outside canon is stationary.
8. **The four M0s are four functions that agree on the story.** I list the differences I found.
9. Smaller things in Lean, Alloy, `03`, and two quotations.

What I tried to break and could not is at the end.

## 1. The causal footing

**The claim** (`DEBRIEF.md` item 1; `datalog/PERSPECTIVE.md` §2.5; plan §2 first row): four faults all come from reading something owed from where an event sits in a line; rewritten so that no rule reads the clock, "the second and third faults show as owed with no clause written for them, the fourth does not arise, and the first cannot be stated."

**1a. The second fault shows as owed because a clause was written for it.** `causal/m0-causal.lp` line 36 to 37:

```
% 0. new, and only sayable on this footing: one piece, two versions, neither replacing the other
viol(R,c0_two_versions(V1,V2),P) :- canon(R,P), sel(R,P,V1), sel(R,P,V2), V1 < V2.
```

With that line removed, the lost rewrite is stationary on the causal footing too:

```sh
cd datalog && grep -v c0_two_versions causal/m0-causal.lp > /tmp/noc0.lp
clingo /tmp/noc0.lp causal/holes-causal.lp --outf=0 -V0 | tr ' ' '\n' | grep a_
# stationary(a_fork1) stationary(a_fork2) stationary(a_union)
```

What the footing gives is that the clause *can be said* (the file's own comment says exactly this). The debrief and §2.5 ("three of the five come out as the builders wanted with no clause written for them") say more than that.

**1b. The third and fourth come right on the clock footing with the guard reworded.** I replaced the two guard rules of `m0.lp` (lines 63 and 64) with three that still read the clock, and changed nothing else. Selection is still "latest write by the clock":

```
hitc(R,E,Tv) :- finding(E,P,V,_,_), known(R,E), not aside(R,E), on(R,P,V,Tv), sel(R,P,Vh), Vh != V.
metc(R,E,Tv) :- hitc(R,E,Tv), finding(E,P,_,C,_), on(R,P,V1,T1), Tv < T1, evidence(E2,_,P,V1,C,holds), known(R,E2), not aside(R,E2).
viol(R,c4_guard(E),P) :- canon(R,P), finding(E,P,_,_,_), hitc(R,E,Tv), not metc(R,E,Tv).
```

On `causal/holes-clock.lp` this gives: round trip **owed**, checked-before-selected **stationary**, old pass owed, rewound draft stationary, lost rewrite stationary. That is the causal column of the §2.5 table in every row but the first. The story's frontier is unchanged at every row (diffed against `runs/02`).

So what fixed those two cases is (i) counting a guard once per time the line wrote the bad version instead of once per finding, and (ii) dropping "applied when recorded", which note 23 §8 already calls a wording error. Neither is a change of footing. The reason is simple: on one line, worked in sequence, each write replaces the write before it, so the chain of replacements *is* the clock's order of that piece's writes. The two orders can differ only where a line is assembled from two (a merge), and only the first row of the table is a merge.

**1c. Where the footing does matter, with no clause.** A guard across a merge. A finding on c0. Fork A fixes it (c1) and the case is looked for in c1. Fork B, from the same checkpoint, rewrites c0 to c2, later by the clock; nobody looks for the case in c2.

```
% clock footing (with m0.lp)
slot(o,o1,c,point,firm). asks_valid(c).
write(s0,1,c,c0). write(s0,2,o,o1). markroot(s0,3,o). evidence(k0,4,c,c0,valid,holds).
evidence(f,10,c,c0,casex,fails).
write(a,20,c,c1). evidence(ka,21,c,c1,valid,holds). evidence(kx,22,c,c1,casex,holds).
write(b,30,c,c2). evidence(kb,31,c,c2,valid,holds).
view(g_b,40). vis(g_b,s0). vis(g_b,b).
view(g_union,40). vis(g_union,s0). vis(g_union,a). vis(g_union,b).
```

(Plus the `#defined` line from `holes-clock.lp`. The causal version names the writes `w0`, `wa`, `wb` with `replaces(wa,w0). replaces(wb,w0).`)

| | fork B alone | the union |
|---|---|---|
| clock, as written | owed: guard | **stationary** |
| clock, guard reworded as in 1b | owed: guard | **stationary** |
| causal | owed: guard | owed: two versions; **owed: guard** |
| causal, with the two-versions clause removed | owed: guard | **owed: guard** |

On the clock footing B's version is the one selected, it was never looked at for the case, B could not close alone, and the union owes nothing: A's pass sits between by the clock and answers for a version it was never about. On the causal footing the guard is read along B's own chain and stays open, whether or not the two-versions clause is there. This is the claim's real territory and a better case for it than any of the five in `runs/16`. It still exists only where a close is allowed on the stationarity of the merge (1e).

**1d. What the footing costs, not reported.**

- *A pass that read something the line never had answers a guard.* `metc` asks only that the passing evidence be known and not set aside. The clock rule asks that it applied. Probe: finding on c0; write c1; `evidence(kx,22,c,c1,casex,holds). reads(kx,d,dNEVER).` with d at d0 throughout. Clock: owed. Causal: stationary. Whether that is wrong depends on what the rule is for, but it is a way to shed a guard that the clock wording did not have.
- *`replaces` is testimony nothing checks.* A write of c that also names d's write as replaced (`replaces(w1,w0). replaces(w1,wd0).`) leaves d with no head: d is unselected, drops out of canon, and the state is stationary though the root asked that d be checked. On the clock footing no write can unselect another piece.
- *Condition 9 is gone.* The perspective says so (§2.5, last paragraph); the debrief does not. "Answered since" is the one condition that is about order in itself, and the footing has no way to say it without evidence naming the question it answers, which is a change to the model.
- *"Later than the finding" is gone too.* A pass counts by being about a later version in the chain, whenever it was made. I think that is defensible, and it is a change, not a transcription.
- The program is 54 rules, not 52 (line 23 holds three). It is "no longer than M0" only with condition 9's three rules left out.

**1e. Two of the four faults are faults of a close rule the spec does not have.** The TLA+ perspective says this plainly (§5: "The spec's own rule avoids this (§6: … two writes of one id meet)"); the plan says it in §1 item 4; the debrief lists both as faults "found" and adds "neither builder reports it". Draft 4 §6 lets a fork close after the main line has moved only if the forks do not meet, and R9's first clause is "they select different versions of one id". The OCaml account already carries it as an open decision of the model's (§3.1, and line 146: "Whether two forks may close because the merged state is stationary or only because they do not meet (§3.1). The first is cheaper and has the clock hole"), and note 23 §8 repeats it. The lost rewrite is a second hole in that same undecided rule. That is worth saying, and it is a different statement from "the spec's order is wrong". In database terms it is the *lost update*, which snapshot isolation prevents by first-committer-wins; `03` names write skew and not this, though the TLA+ invariant is called `NoLostUpdate`.

**1f. One hole from note 23 §8 was not among the five cases.** "Rewriting something a finding had read makes the finding stop applying" (Ada G4; §2.5 names G4 in its second paragraph and then tests G2 and G3). Probe: `evidence(fg,10,c,c0,casex,fails). reads(fg,d,d0).` then a write of d1. Both footings: stationary after the write. The footing does not help it. (The Lean and Alloy M0s guard here, as the Ada build's repair does; see 8. For Lean I ran it: the story's S0 with a finding on c that read d1, then a write of d, gives `Item.guard c`. For Alloy I read it from `guardOpen` and did not run it.)

**What I think stands.** That selection read as "latest by the clock" is unsafe on a merged line, and that a write saying what it replaces makes the conflict sayable, are both shown. That is G10 again for one more fact, as the TLA+ fork guessed. "The clock is for the record, and what the conditions should read is what each event's maker saw" is a fair hypothesis with one good case (1c) and three costs (1d). It has not been tried on anything a builder built, which the plan says. To strengthen it I would test only on merged lines, since nowhere else can the two orders disagree, and I would state the price: every clause that says "since" needs its events to name what they answer.

## 2. "S1 is not stationary by the letter"

**The claim** (`DEBRIEF.md` item 6, first bullet; plan §3): the eli8 was rewritten and nobody looked at it beside the description, so the story needs one more affirmation or one of two readings stated.

**What the debrief leaves out.** `core/def/changeset.md` line 19: "For every held segment that depends, by an inner dependency of the kind, on one that *changed*, it either changes that one too or carries the author's affirmation of it." At 10:30 the claim changed, so the description (which depends on it) must be changed or affirmed, and it was affirmed. The description did not change, so nothing is asked of the eli8 on its account. The eli8 changed, and nothing depends on it. By core, the 10:30 write is whole and S1 is reached exactly as the story tells it.

Three perspective files point at this rule, each in its own way: Lean §1 says it outright ("by core nothing is owed here; note 22's condition 6 … read as a condition on a state with no memory of what changed, does not say"); Alloy §3 cites it as the direction core's rule runs in; TLA+ §4 cites it as why the old eli8 may be kept. The debrief says "by the letter, S1 is not stationary" and the plan offers two repairs. The third reading, that condition 6 is about a *change* and the story is right, is the one core already holds, and it is missing from both.

It also changes what the fourth bullet means. "The shortest route keeps the old eli8" is not a gap the example exposes. It is the same rule working as designed: an unchanged, affirmed middle shields the end. Whether it should is a fair question; the TLA+ file asks it as a question and says it is "the model as written and not a slip in M0". The debrief keeps the question and drops that sentence. The search that produced the trace also needed E17, a whole read that passes T with the old eli8, which the fork invented as possible and says so.

Two smaller things about the same item.

- *The same letter was not applied to S0.* The story never says anyone looked at k1 beside e1, or e1 beside c1. `01` supplies both affirmations at row 0 so that S0 is stationary, and then holds row 4 to the letter. The note asserts both S0 and S1 are stationary. Trusting the assertion at one end and not the other is a choice; under either uniform choice the finding reads differently ("the story under-specifies condition 6 at both ends", or "nothing is missing").
- *"All four languages found" it.* `01` predicted it before anything was run ("an exemplar that finds condition 6 owed on k there has found something in the story"), and each instrument encoded that reading. It is one reading run four times. The README says this of agreement in general; the debrief's sentence reads as four findings.

"c1′ is fine is not so by your own rule" likewise turns on a choice of the encoding: that the auditor's finding is on a criterion B's check of c1′ did not cover. The 11:00 row supports reading it that way. The Alloy file says it with the right weight ("true of one question and not of another … the story may well intend that B looked"). The debrief states it flat.

## 3. "The rule forbids it"

**The claim** (`DEBRIEF.md` item 3, third bullet; plan §2 third row): a decision conditioned on an upstream piece is harmless, is what note 22 §3.4 says a decision is, and "the rule forbids it, and both builders reported that they could not say" it.

**As written, the rule does not cover it.** Note 22 §4.1: "A question, a promise or a waiver is unconditional." Draft 4 §2: "A raise, promise, waive or set aside decision has no conditions", and in the same list, "An accept or affirm decision about p@v has 'p is at v …' among its conditions." Acceptances have conditions in the spec.

What stopped the builders was something else in each case. Ada G11 is a *reading the builder took* ("an accept decision's conditions are plain ones") to avoid a circle between warrants and consistency, with its cost stated. The OCaml account (line 135) says step 7 "needs a decision with a condition … this would go through `asks`, untested". Neither says the unconditional rule forbade it, and OCaml does not say it could not be said.

So "the builds' rule is three different things" is two things the rule covers (questions and promises; waivers) and one it does not. The useful part survives: the upstream-conditioned acceptance has one answer in `runs/13`, and G11's circle is real only when a condition leads back. It should be addressed to G11's reading, not to the rule.

Two more on this item.

- *"Locally stratified" is not the name of the finer test.* §2.3 says the boundary "no chain of conditions and restings leads from a piece back to itself" is, in the literature, local stratification. Local stratification is a property of the ground program over all constants, whatever the facts are. `conditions/reading-conditioned-acceptance.lp` has `cond_fails(R,D) :- …, cond(D,X), fault(R,X)`, whose ground instances include X = r2 whether or not `cond(dec1,r2)` is a fact, so the ground dependency graph has the negative cycle regardless, and the program is not locally stratified. The property that depends on the facts, which is what "a property of a state" needs, is weak stratification (Przymusinska and Przymusinski) or modular stratification (Ross). The conclusion wanted (one model, total under the well-founded semantics) does hold for modularly stratified programs. This is from my memory of that literature and I checked no text.
- *Items 2 and 3 pull against each other.* Item 2: two pieces resting on each other with nothing wrong "are simply fine", and the other fixed points are "a piece being at fault for no reason". Item 3: a waiver that holds because its piece is consistent should be forbidden because "nothing should stand on a circle". Both are positive loops, and the greatest fixed point is what accepts both. Saying consistency as fault does not remove the choice of fixed point; it makes the least fixed point of *fault* the default, which is the greatest of *consistent*. The opposite default, "consistent needs a reason", is as sayable and rejects both circles. Lean's theorem (`noFault_fixed`, `noFault_greatest`, `cons_iff_noFault`) is correct and proves the two phrasings equal. It cannot say which the model wants, and "there is no fixed point to choose" reads as though it had.

## 4. The good-news row was read off the rules for a flag only

**The claim** (`datalog/PERSPECTIVE.md` §2.4; `05` row G-D6 "Held"; debrief: "recording evidence that holds can only remove items" can be "read off the rules without running a state").

`polarity/m0-split.lp` splits a piece of evidence into its description (`evd/5`, `reads/3`, called vocabulary) and a flag that it was recorded (`rec_h`, `rec_f`). The script's own output (`runs/08`):

```
evd              +-  either
reads            +-  either
rec_h            -   can only remove
```

The table in §2.4 has the `rec_h` row and not the other two. Recording a new piece of evidence adds all three facts. So what was read off the graph is: *given that the description is already there*, flagging it as recorded and holding can only remove. For the event itself the script says "either".

I think the property is true of M0 anyway (a new description only adds a time point and per-evidence atoms, and Lean's `good_news` proves it for the Lean M0). But that is by argument and by Lean, not by the rule graph, and the perspective's limits paragraph does not mention it. The theorem the script leans on ("from memory, not checked against a text") I also believe, by induction over strata, and also did not check.

## 5. "The nine conditions are rules"

`DEBRIEF.md`: "The nine conditions are rules. Written as a logic program they are about fifty lines; they run". Plan §4: the same, and "this is the form in which note 22 §4.1 lost least and gained most. If core ever carries a formal claim beside §4.1's prose, I would try it as rules first."

`m0.lp` has conditions 1, 2, 4, 5, 6 and 9. Conditions 3 and 7 need warrant levels and 8 needs promises; `01` says all three are left out. `datalog/PERSPECTIVE.md` §3 says of levels that they "would need either aggregation or a rule per level". The recommendation may be right, but it has been tried on the six conditions that are joins and negations, and the two that are about *how well* something stands are where this family is least at home. The debrief and the plan should say six.

## 6. The states behind "stationary is where a close lands"

`DEBRIEF.md` item 5: written as "stationary with the record as it stood at its last close", it "holds in all two and a half million states of a small two-fork universe".

In `Veri.tla`, `R11_AsOf == Stationary(main, cpBase)`. The only step that changes `main` or `cpBase` is `Close`, which sets `main' = M` and `cpBase' = base` under the guard `Stationary(M, base)`. So, given a stationary start, the invariant holds after every close by the guard, and between closes because neither variable moves. It is inductive in three lines for any universe and any close rule. TLC visiting 2.5 million states adds nothing to that, and could not have come out otherwise. The TLA+ file says "passes almost by construction" of the refinement check; of this one it does not, and the debrief sets the number beside "refutes it in two states" as though the two were a measured contrast.

The observation itself (two objects named "checkpoint"; a check made on a fork is at once on the record) is a clarification I find useful. It was reached by having to write the state down, as the fork says, and stands as an argument.

Also: `forks-9` ran under `CloseRule = "fresh"` (a fork may close only if nobody else has closed since it opened), which the debrief's "small two-fork universe" does not mention; with forks of at most two line events.

*Re-run.* The TLA+ file says `forks-2`, `-7` and `-9` were run before three later edits to `Veri.tla` and not re-run. I re-ran `forks-9` and `forks-2` against `Veri.tla` as committed, in a copy. Both come out exactly as stored: `forks-9`, 25,116,813 states generated, 2,512,166 distinct, depth 18, no error; `forks-2`, 8,681,535 generated, 1,141,264 distinct, depth 18, no error. So the fork's statement that the later edits change nothing those configurations check holds for these two. `forks-7` I did not re-run.

## 7. A defect in `datalog/m0.lp`, condition 5

Lines 92 and 93:

```
fault(R,P) :- canon(R,P), rests(R,P,Q), selected(R,Q), not canon(R,Q).
owed(R,c5_rests_on_fault(Q),P) :- canon(R,P), rests(R,P,Q), fault(R,Q).
```

A canon piece P resting on a selected piece Q outside canon is marked at fault, but nothing is owed unless *Q* is at fault, and a piece outside canon has no violations. Probe:

```
slot(o,o1,c,point,firm). asks_valid(c). pred(c,c0,x).
write(s0,1,c,c0). wrote_against(s0,1,x,x0). write(s0,2,x,x0). write(s0,3,o,o1). markroot(s0,4,o). evidence(k0,5,c,c0,valid,holds).
view(t4,30). vis(t4,s0).
#show fault/2.
```

Result: `fault(t4,c)` and `stationary(t4)`. `01` says a piece "rests … only on canon pieces"; the Lean (`Item.outside`), Alloy (`v5c`) and TLA+ (`q \notin Canon`) models each owe here. The same two lines are in `causal/m0-causal.lp` and `polarity/m0-split.lp`. The story never exercises it. A related smaller thing: `c5_rests_on_fault` is derived straight into `owed` and so cannot be waived, where every other item can.

## 8. The four M0s

Plan §1 item 3 asks whether they are one model. By reading the pinned frontiers in `lean/Vk/Story.lean` against `datalog/runs/01` and `02` I find them the same item for item at every row (under the write-looks reading, and with `row9B` equal to the letter). I did not compare Alloy's or TLC's story output item for item.

As functions they differ, and none of the differences shows on the story:

| | Datalog | Lean | Alloy | TLA+ |
|---|---|---|---|---|
| a guard is met by a later pass that… | applied when recorded | applies now | applies now | applies now |
| a finding that stops applying because something it read was rewritten (Ada G4) | no guard | **guard** (`!applies`, not "version differs") | **guard** (the same way) | no guard |
| condition 2 met by a check of p that read the target | no | yes | no | no |
| "a write counts as having looked" | stored by the write | stored by the write | **worked out from the clock** (`writtenAfter` compares the times of two last writes) | not modelled |
| resting on a piece outside canon | **not owed** (finding 7) | owed | owed | owed |
| evidence about a combination of versions no live line has | allowed | allowed | allowed | **not recordable** (`Avail`) |

Two of these bear on results the debrief reports. Alloy's write-looks reading is the derived kind that `datalog/PERSPECTIVE.md` §2.6 argues must never be derived ("an engine that works it out from the record … will, after a merge, be testifying for the mind"); the Alloy fork runs use the strict reading, so no reported result depends on it, but `oStationaryW` in the story output does. And Alloy's round 12 (a finding that read one piece as A left it and one as B left it) exists only because nothing in that M0 asks how such a check was made; in the TLA+ M0 it cannot be recorded. Whether a mind may check a combination that no line holds is a question about the model that neither file asks. The debrief presents round 12 as the model's own answer to the unconnected contradiction.

## 9. Smaller

**Lean.**

- *A checkpoint can be had for a state that owes, by typing a number.* `Written.fuel` bounds how far canon is iterated ("any number ≥ the pieces in play"), and it is a field someone fills in. With too little, canon is cut short and the frontier under-reports. This compiles beside the story:

  ```lean
  def W0 : Written Pc Cr := { W with fuel := 1 }
  example : frontier W0 row1 = [] := by decide
  def S_bad : Checkpoint W0 := close W0 row1 (by decide)   -- the 08:30 state, finding and all
  ```

  It does not touch `good_news` (proved for any fuel) or the story (fuel 8, enough). It does qualify "cannot be filled in without a proof that nothing is owed … works without strain".
- *The fault theorems are not about M0.* `Fault.lean` is about an arbitrary `own` and `rests`. `Model.lean` does not import it; its `faulty` is a bounded iteration over canon and no theorem links the two. "Lean proved … that this is the spec's greatest fixed point" is true of the abstract step and has not been stated of the Lean M0's frontier function, nor of the spec's (waived items, effective warrant).
- *"If it means close enough it cannot be built at all" is the construction's premise, returned as a result* (`View.lean`; debrief, "Types and proofs"; plan §2, the row on **same**). The file makes evidence a type indexed by what a lens observes, so two versions are the same exactly when a function gives equal values, and an attested sameness is Lean's quotient, which takes the equivalence closure of whatever relation it is handed. Nothing is refused: hand it a relation that does not chain and it chains it. So what is shown is "if sameness is equality under a view, chaining is free", which is true and tidy. It is not shown that a mind's attestation "these do not differ in what matters" *is* of that kind. Each of five such attestations can be right as a judgment of two versions and the first and last still differ in what matters; that is the worry about carry upon carry, and "one attestation in the chain was wrong" does not describe it. The spec already chains (draft 4 §4: "reachable by **same** events"), so the construction agrees with the spec; it does not settle the worry, and the plan's note says it does.
- *Mutation 3 cannot fail to fail.* It asks `rfl` to prove `g.outcome = .holds` for an arbitrary `g`. That shows the lemma has a hypothesis, which its signature shows. The real counterexample (`more_record_can_owe_more`) is in the build; the mutation adds nothing to it.

**Alloy.** I read the instances for rounds 12 and 13 and `forks7`.

- *Round 13's "result with two whole reads" has no parts.* In `out-forks5/F_KK_EE-solution-0.txt`, `Version<:slots={}`. The result holds nothing; canon is the result alone; each "whole read" read one piece that is not a filler and is not in canon. The same in round 12 (and the finding there is about a version of the outline that was never written, tied to the selected one by a `same` event). The fork warned that instances carry oddities, and the *shape* of round 13 is real and has a natural form in every M0: a claim checked twice, once by way of d and once by way of e; one fork rewrites d, the other e; each still has a check and the union has none. I would describe it that way and not as a result's whole reads, which in the common reading must read every filler.
- *The reproduction of the lost rewrite is a degenerate one.* In `out-forks7`, the piece is an empty outline that is its own root, of which nothing is asked; fork B writes a new version of it; fork A writes the *same version it already had*, later. The perspective describes this accurately. "The Alloy fork then reproduced it" in the debrief suggests two forks each rewriting a claim. The Datalog case A is the non-degenerate one.
- "Fourteen sentences" counts round 0, which is no sentence. Rounds 5 to 11 cannot be re-run (the clause texts were overwritten; the file says so). `fixpoints.log` has four checks with no counterexample, not three (the fourth is the file's check on itself).

**`03`, other bodies of work.**

- *The two Bailis quotations are verbatim.* I fetched arXiv 1402.2237 and found Definition 6 and Theorem 1 word for word, and "we define merge as set union of the versions contained at different servers".
- *The use made of the theorem goes past it.* It is about a *set of transactions*, over every reachable pair of states, and about systems that want coordination-freedom, availability and convergence together. From it: one cannot know from each fork alone that both may close; something at close must look at the other. It does not say that a particular pair which fails must be *reworked* (that the merge owes something is just what failing means), and "in any engine whatever" holds only for engines with that merge and those three aims. The verisectorium's close is already a coordinated step. So "reworked on the new checkpoint is not a cost of this design" does not follow from the theorem; what follows is that some check at close is unavoidable, which the spec has. The mapping also needs every intermediate state to satisfy the invariant, and a fork passes through states that are not stationary; the file says "the mapping is mine" and does not say where it strains. The paper does not use the term "write skew" (I searched the text); `03` does not say it does, but gives that name no source and no label.
- *A standard the spike applies to note 22 and not to itself.* The debrief faults the story's summary because "A's discovery of the error is not an event". `03` §3 says the dead end "is the nogood {u at u1, c at c1′}, and it is known before any later fork tries that pair again". As tabled, nothing records that u1 does not follow from c1′; in `selections.lp` that pair is excluded only because u1 was written against c1, which one affirmation would undo.

**Two quotations.**

- `DEBRIEF.md` item 2 and `datalog/PERSPECTIVE.md` §2.2 quote core as saying "unsettledness spreads along what rests on what". Core has "Unsettledness spreads along it and along nothing else" (`model.outline.md`, the *rests on* row) and "reopening spreads along what rests on what" (`src/impl-two-moves-at-once.md`). The quoted sentence is a blend of the two. The Alloy file quotes the first correctly.
- The plan calls this the way "core used to say it" and "core's older wording". It is in core now.

**Debrief item 4** (none of the four can tell the two atoms apart) says nothing was run for it. It is close to note 22 §3.2 as it stands ("Every piece of evidence is at bottom something someone or something attested"; the footnote gives it to Joseph, 11-10), so the instruments returned what the encodings were given. Its sharper half, that what tells them apart lives in the part set aside, is the debrief's own reading and I think the right thing to keep.

## What I tried to break and could not

- The Datalog story frontier, row by row against note 22's table and against Lean's pins.
- Lean's `Fault.lean` and `Refusals.lean`: I read every statement and proof; they say what the perspective says, with the scope noted in 9.
- The TLC lost-rewrite trace (`forks-3b`): read state by state; it is as described, a serial trace in which B closes after A under the "both" rule.
- The counts I checked: 55 rules in `m0.lp`; 1,273 lines of Lean; 21 TLC configurations and 21 outputs; 18 Datalog run files; 1,350 additions in `check_good_news.py` (2 × 15 × 3 × 15).
- `runs/12` (which combinations could be rested at) at the six times sampled, by reasoning about each excluded combination I could think of; I did not re-run it.
- The ring under three semantics, and the six loop programs: as reported.

## What this file does not establish

That my eight probes are the right ones; each is a few facts, written by me tonight, read by nobody else. That the reworded clock guard in 1b is a good rule (it was written to isolate a cause, and it shares the foreign-reads route of 1d). That core's changeset rule is the reading note 22 means by condition 6; I say only that core has it and the debrief omits it. Anything about the files listed under "not read". I did not build the builders' probes that plan §1 item 1 asks for, so the causal footing is still untested on anything a builder wrote.
