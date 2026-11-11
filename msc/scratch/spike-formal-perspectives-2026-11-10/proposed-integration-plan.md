# Suggestions for integration, with reasons

*2026-11-11, spike lead. Suggestions only. Whoever spiked a result is not the one who verifies or lands it, and nothing below has been verified by anyone but its maker. Each item says what it rests on. Most are rewordings or subtractions; where one could be read as adding a mechanism I have said so and suggest it not be taken that way.*

*Corrected 2026-11-11 after the independent read (`de-novo-feedback-1.md`); see `08-corrections-after-the-independent-read.md`. Section 1's first three items have now been done by that reader, and its findings supersede my guesses there.*

*Everything here was found on M0 (`01-common-reading.md`), a model much smaller than kernel spec draft 4, on one story and a handful of small cases. In core's terms each is a working note with stated conditions and nothing more.*

## 1. Before anything is integrated: what an independent reader should try to break

In the order I think most likely to yield.

1. **The causal footing** (`datalog/PERSPECTIVE.md` §2.5, `datalog/causal/`). It is the claim with the most riding on it and the least behind it: one small program of mine, one story, five cases I wrote myself to match the builders' descriptions of their cases, not their actual cases. A reader should build the builders' own probes (Ada P1, P2, P2b; OCaml's tests `checked before selected`, `a rewind forgets an answer`, `R4`, `a shared dependent, and the clock`) and see whether the table in §2.5 survives them.
2. **The polarity script** (`datalog/polarity/polarity.py`). The good-news table rests on a theorem I stated from memory and on fifty lines of my own parsing. Its one independent check is 1,350 single additions to one story.
3. **Whether the four M0s are one model.** Each instrument wrote M0 itself and took its own readings where the common reading was silent (the Lean file lists four, the TLA+ file lists its cuts). All four report the same departures from note 22's table. I did not compare their frontiers item for item at every row.
4. **The TLA+ fork's lost rewrite against the builders' code** (the Alloy fork reproduced it on its own M0, `alloy/forks7.als`)**.** The fork says it did not look. If neither build's close rule can merge two rewrites of one piece, the finding is about a rule the spec does not have (closing on the stationarity of the merge), which the OCaml account raised only as a question.
5. **The Lean fork's theorems** re-run from clean (`lean/run.sh`), and its three mutations.
6. **The Alloy fork's readings of its instances.** Each world the solver returned was read by one mind; the fork says so. And its last sentence about forks not meeting (round 14) is undecided: it could be run to an answer with more time.

## 2. Working notes that could be placed in core, in core's words

Each is a candidate note for the Working Notes of the def named, with its conditions. None is a body change.

| where | the note | rests on |
|---|---|---|
| «steady·state», beside "Order, checkpoints and forks" | On a line merged from two forks, three faults come from reading something owed from an event's *place* in the line: a write credited with having seen what it never saw; two rewrites of one piece merging silently; a guard on one fork's version answered by a pass on the other's. All three need a fork to be allowed to close on the stationarity of the merge, which is a rule still being weighed and not the spec's. Where each write says what it replaces and what it was written against, the first cannot be stated, the second can be said (with a clause), the third is owed with no clause. The costs: "answered since" cannot be said unless an answer names its question; what a write says it replaces is unchecked testimony. | M0 on both footings, one story, the independent reader's merge case (`datalog/runs/15`, `19`); TLC, two forks (`tla/` forks-1 to -7); the Ada account's G10. Two cases I first counted here were faults of the guard's wording (`de-novo-feedback-1.md` §1b). Not tried on anything a builder built. |
| «frontier» or note 22 §4.1 condition 5 | "Rests only on pieces that are themselves consistent" can be said the way core says it in «frontier»: a piece is at fault when it owes something itself or rests on one at fault. Then consistent is "nothing it rests on, however far down, owes anything", there is no fixed point to choose, and two pieces resting on each other with nothing wrong are simply fine. | Proved in Lean for an abstract "owes" and "rests", any number of pieces, not for M0's own function. Run under three logic engines on the ring. It makes a default explicit and does not choose it: "consistent needs a reason" is the other, and rejects the ring as it rejects a circular waiver. |
| «dimension», beside "three things an ontology must not declare", item (1) | The rule covers three different things. A question or promise conditioned on consistency can have no answer. A waiver conditioned on consistency always has one; what is wrong with it is that a defective piece can then stand on a waiver that holds because the piece stands. An acceptance conditioned on a piece *upstream* of what it supports is harmless, and is what «decision»'s "reopened when its basis fails" needs; the rule does not forbid it (draft 4 gives acceptances conditions), and what stopped the builders was a reading one of them took. The finer line is: no chain of conditions and restings leads from a piece back to itself. | Six small programs under three engines; one story built into M0 (`datalog` §2.3, `runs/13`); Lean's monotonicity check accepting the waiver and refusing the questions (`lean` §5). The finer line is tested on those and nothing wider. |
| «decision» | With who-did-it set aside, none of four formal tools could tell a decision from a piece of evidence by its shape: both are records that someone attested something about versions, and both are good while what they were about is unchanged. The differences the kernel spec draws between them (evidence in the base, decisions on a line) are choices and are not forced by the logic. The difference the two atoms were named for, who may add one and who may undo it, is in the part that is set aside. | A reading across all four perspectives (`lean` §3; `datalog` §2.1, §4). Nothing was run for it. It is the remark here I am least sure how to weigh. |
| «steady·state» | *Stationary* is true of where a close lands, with the record as it then stood. It is not a property the verisectorium keeps. "The checkpoint" in note 22 §4.2 names two things: the state rested at, frozen with its record, which stays stationary; and that line read with today's record, which may not be. A check made on a fork is on the verisectorium's record at once, though the fork's writes are not the verisectorium. | TLC: the invariant form refuted in two states, the as-of form holding in 2.5 million (`tla` §2); Lean: two states, two theorems (`lean` §2); both builders' rewordings of R11. |
| note 22 §3.3, on **same** | If "the same" means "do not differ in what matters", it chains and runs both ways for free, and the worry about carry upon carry is a worry that one attestation in the chain was wrong. If it means "close enough" it does not chain and evidence cannot be about it. A read that relies on existence only, normalization, and an attested sameness are one thing *if* sameness is equality of what was seen of a version. The Lean construction shows that conditional and not that a mind's attestation is of that kind; it does not answer the worry about carry upon carry. | A construction in Lean beside M0 (`lean` §8); the same idea in build systems, from secondary sources (`03` §4). |
| «changeset», "When two changes can both land" | The property has a name in the database literature, *invariant confluence*, with a theorem from which this much follows: nobody can know from each fork alone that both may close, so something at the close must look at the other. (I first drew more from it than it gives.) The lost rewrite is that literature's *lost update*. | Read in the primary this session (`03` §1). The mapping is mine. |
| «act» or wherever guards are spoken of | A guard is a regression test: a criterion that once failed on a piece is asked of its later versions. Core already has the words. | A reading (`03` §4). |

## 3. The example in note 22 §4.3

All four instruments ran the table mechanically. All four report the first three items below; the fourth is the TLA+ fork's. These are for whoever next edits note 22; they are small.

- 09:00: "c1′ is fine" is not so by §3.3; the auditor's case was not looked for in it.
- 10:30: the open guard on c2 is not in the column (the story clears it at 11:00).
- 14:00: by note 22's wording of condition 6, S1 is not reached; by core's «changeset» rule (a dependent of what *changed* is changed or affirmed) it is, exactly as told, since the description did not change. The two wordings differ and the example is where it shows. Under the first: Nobody looked at the rewritten eli8 beside the description. Either the story gains one affirmation at 10:30, or one of two readings is stated: a write of a dependent piece counts as having looked at what it depends on; or a whole read counts as having looked at the parts together.
- The summary says the record holds "that B passed a derivation with an error in step 3". As tabled it does not: A's discovery at 11:30 is not an event. If it is made one, a look for that error in d3 is owed before the close (`tla` §3).

Two questions the example raises about the model itself, which I have not seen asked:

- Does an affirmation of the middle of a chain shield the end of it? The TLA+ fork's shortest route to a close keeps the *old* eli8: the claim gained a hypothesis, the description was affirmed unchanged, so nothing asks anyone to look at the eli8, and only the whole read stands between a stale eli8 and S1 (`tla` §4).
- Does a whole read discharge inner dependencies? If it does, condition 6 does no work wherever a root asks for whole reads.

## 4. On writing core's formal layer in one of these

Joseph's question was whether core's formal spec could be carried "as types instead of 'terms'". What the four perspectives say, taken together:

- **It is not one layer.** There is the shape of what can be stored (ids, versions, events, kinds and slots). There is the function from a state to what it owes (the nine conditions). There is how states succeed one another (forks, closing). Each instrument was good at one and gave little on the others: the TLA+ fork says TLA+ "gave no help with the state-to-frontier function"; the Lean fork says Lean "gave nothing on lines, forks or interleavings"; the logic engines cannot say a refused write or "better".
- **Types reach the first part and stop.** In Lean, what kind of piece fills a slot and how many are typing; "required" is not, and nothing in the nine conditions is. A typed core would certify the bookkeeping and never a claim (`lean` §3, §9).
- **Six of the nine conditions went down as rules** (the two about how well something stands, and promises, were not tried, and the first two are where this family is least at home). Written as a logic program they are about fifty lines, they run, they are the definition and not a description of it, and a frontier item's cause and remedy fall out as the leaves of its derivation (`datalog` §2.7). Of everything tried, this is the form in which note 22 §4.1 lost least and gained most. If core ever carries a formal claim beside §4.1's prose, I would try it as rules first, with the §4.3 story as its test.
- **Theorems about the rules** (well-definedness, good news, locality) were short in Lean and are already in SPARK at bounded sizes. That is a third thing again, and it is for the kernel work, not for core.

A caution I would attach to my own third bullet: Joseph's "this is *not* an experiment in manual verisectorium". Fifty rules beside the prose is one more thing to keep true by hand unless it replaces something.

## 5. What I would not do

- Put *replaces*, *fault*, *view* or any other word from these files into core. They are these instruments' words. The notes in §2 are written without them where I could manage it.
- Take the third truth value ("undetermined") from the well-founded semantics as a proposal. It is one of three stances a logic can take toward a looping condition, and the model has not asked for one.
- Treat anything here as settling a question in note 22 Part 8. The nearest it comes is the first one (evidence crosses forks, writes and decisions stay): the perspectives say the cut is a choice, and say nothing about which choice is right.
