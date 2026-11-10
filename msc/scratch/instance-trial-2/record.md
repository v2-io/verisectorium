# The record, read through the model

*The 39 acts `vsect why segment:der-change-expectation-baseline` shows, all recorded between 2026-10-30 21:25Z and 10-31 03:27Z. I read that listing whole; every item of the eight review records (`reviews/tst-*.md`) that targets this segment, with each review's header; `reviews/tst-lane-check-4.md` whole; and finding F1 and F4 of checker 4's write-up (`msc/inside-out-2026-10/c1-lanes/tst-check-4.md` in asf). I did not read the other seven write-ups or the integrators' accounts. Ids are those of `cut.md`. Which veritoids each criterion concerns is my mapping; the record addresses by quotation.*

## 1. What the 39 acts are

| in the record | count | under the model |
|---|---|---|
| `rederive` (10), `read-check` (6) | 16 | ‹check›s: 10 answer validity, 2 answer fidelity (typed on the "derivation" line), 4 answer source |
| `place-finding` | 6 | ‹finding›s: 4 opened by the tool because a check came back narrowed or broken, 2 typed by a checker |
| `revise` | 5 | ‹segment·changeset›s, recorded after the edit was already in git ("adopter"); each carries the author's word *redefined* or *reworded* |
| `review-finding`, outcome answered | 3 | answering, each by a mind that wrote no repair |
| `confirm-rewording`, outcome equivalent | 1 | carrying, by a mind other than the editor |
| `correct` | 8 | 7 say that the git commit an earlier check named is on no branch and give its equivalent on `main` (two of them correct the other two); 1 is a checker changing its own outcome from broken to narrowed. **None of the eight is answering, carrying or contesting** |

No decision of any sort is on the record for this segment: no acceptance, promise, waiver, affirmation or ratification. Twelve of the 39 acts concern an earlier act; core's three acts-about-acts place four of them.

## 2. The six written states of 10-30, by veritoid

| version | landed by | what changed (HEAD ids; a predecessor is named where the piece later moved) |
|---|---|---|
| v1 `dbad31b2` | TST lane integrator | U3 new (k1, z1 to z8, i3, n1); h2 gains the hazard clause; e6, e7 new; d2 gains a fifth example; a first Lineage (l1, l7, l8, n2) |
| v2 `036d0fb1` | round-2 integrator | h2; c1 gains the uniform-age likelihood, and a sentence that conditioning on survival alone does not normalize (w6's predecessor); z7 |
| v3 `f014485d` | round-2 integrator, "reworded" | a spelling in the tag and in a2; e1 gains "given its two premises" |
| v4 `f3dc8ff4` | round-3 integrator | the main derivation replaced: premise a survival tail $Q \sim c/t$, conclusion asymptotic (w3's predecessor); the Jeffreys derivation moved to a new last subsection, said not to apply to a developer's situation; h2; k1 (two words); z4; z7 loses "It also needs no Copernican likelihood; survival to $t_0$ is the whole observation"; e1, e6; l1 to l3 |
| v5 `593f39fd` | round-3 integrator | an observation premise added to U1 (observed because alive at the observer's time); e1 |
| v6 `16e38e57`, HEAD | round-4 integrator | the main derivation replaced again (o1, o2, a1, a2, c1, c2: scale ignorance about the system in progress, exact at every age); U2 new; the Jeffreys subsection deleted; h2; z4; z7; e1 to e6; l3 to l6 |

Untouched since before the sprint: h1, h4, c3, u1, b2, x1, e8 to e15, d1, d3, d4, d6. Untouched since v1: z1, z2, z3, z5, z6, z8, i3, n1, e7, l7, l8, n2.

Four different actors held the author seat in six hours. Which HEAD piece continues which earlier piece (that v4's main claim is w3 and v2's is c1) is my judgment from the diffs; nothing recorded it.

## 3. The sixteen checks

"Independent" is the role the record types. `before`/`after` is the record's own field for whether the criterion was fixed before the outcome was seen.

| # | check | by | crit. | at | dimension, means | concerns | outcome | at HEAD, under the model |
|---|---|---|---|---|---|---|---|---|
| 1 | h2-integration C3 | author | after | v1 | validity: afresh, instance | z2, z3, z5, z6 | confirmed | no standing (author); no weight (after) |
| 2 | check-1 C6 | independent | after | v1 | validity: afresh; reproduces: independent quadrature | z2, z3, z5, z6; e7 | confirmed | every piece it concerns is unchanged since v1; it read k1, reworded at v4, so it lapsed and nobody carried it; no weight in any case (after) |
| 3 | check-1 C7 | independent | after | v1 | fidelity: a case the paraphrase admits | h2, z7 | narrowed | answered by checker 2 |
| 4 | round-2 C8 | author | before | v2 | validity: following | c1, c2, w6's predecessor | confirmed | carried to v3; lapsed at v4; author |
| 5 | round-2 C9 | author | before | v2 | fidelity | h2, z7 | confirmed | carried to v3; lapsed at v4; author |
| 6 | check-2 C11 | independent | before | v3 | validity: following; collision (is "needs no Copernican likelihood" consistent with the main derivation?) | c1, c2, z7 | confirmed | lapsed at v4 |
| 7 | round-3 C9 | author | before | v4 | validity: following | w3's predecessor, z4, w6's predecessor | confirmed | lapsed; author |
| 8 | round-3 C10 | author | after | v4 | source: Caves at the primary, Buch and Gott at a secondary | l1, l2, l3 | confirmed | lapsed; author; after |
| 9 | check-3 C8 | independent | before | v5 | validity: collision with an import (Caves Eqs. 20 to 32) | two sentences, both deleted at v6 | broken, then changed by its own author to narrowed | answered by checker 4 |
| 10 | check-3 C9 | independent | before | v5 | validity: afresh | the observation premise of v5; w2's predecessor | narrowed | answered by checker 4 |
| 11 | check-3 C10 | independent | before | v5 | source: at the primary | l1, l2, l3 | confirmed | l1 and l2 have not changed since v4, l3 was rewritten at v6: lapsed as a unit |
| 12 | round-4 C1 | author | before | v6 | validity: following; instance ($10^7$ simulated systems, script not kept) | c1, c2, w1, w2, w4, w5, w6 | confirmed | binds; author, so raises nothing |
| 13 | round-4 C2 | author | before | v6 | source: at the primary | i1, e3, l4 | confirmed | binds; author |
| 14 | check-4 C1 | independent | before | v6 | validity: following, and the rescaling form afresh | c1, c2, w1, w2, w4, w5, w6, i1 | confirmed | **binds** |
| 15 | check-4 C2 | independent | before | v6 | validity: collision (the hazard route against the segment's own observation premise); instance (a kept script) | z3, z4, z7, and through restatement h2, e6, l6 | narrowed | **binds, unanswered** |
| 16 | check-4 C3 | independent | before | v6 | source: at the primary | i1, e3, l3, l4, l5 | confirmed, with a remark typed separately as F8 | **binds** |

Findings: check-1 C7's (answered), check-3 C8's and C9's (answered), check-4 C2's (open; the write-up's F1), check-4 F4 (open; concerns h1 and the second example of d2, and a dependent), check-4 F8 (open; concerns w8 and l3 to l5).

### What holds at HEAD

| | vsect 0.1 | the model, with each act's reads taken at veritoid grain |
|---|---|---|
| checks holding | 0 of 16 (11 "own text changed", 5 "upstream changed": `scope-adaptive-system` and `def-observation-function`, four `depends:` hops away) | 5 of 16: the five recorded at v6. None of them read anything outside this segment and Caves's paper |
| of those, confirmations that raise a warrant | 0 | 2 (check-4 C1 and C3) |
| what per-veritoid binding saved from before the last rewrite | | nothing. Check 2 would have survived but for two deleted words in a premise sentence it read, and check 11's reading of l1 and l2 but for being one act with l3 |

So here the gain over the tool is the upstream rule and not the grain: the tool lapsed five checks because another lane rewrote the broadest scope segment in the theory sixteen minutes before they were recorded against a worktree that did not yet hold that rewrite.

## 4. Warrants at HEAD

Counting only checks by a mind not the author, criterion first, binding at the current version.

| pieces | dimension | warrant |
|---|---|---|
| c1, c2, w1, w2, w4, w5, w6 | validity | derived once (check-4 C1). An instance exists only by the author; no collision at this version |
| i1, e3, l3, l4 | source | at the primary, once (check-4 C3); F8 stands against l3 to l5 |
| z3, z4, z7 | validity | narrowed by collision and instance (check-4 C2), unanswered |
| h2, e6, l6 | fidelity | never asked at this version; they restate what check-4 C2 narrowed |
| z1, z2, z5, z6 | validity | *never asked* by an act that counts. They have been re-derived three times: by the author (check 1), by an independent checker whose criterion came after (check 2), and as the part that held inside a narrowed check (check 15) |
| **c3**, the claim the title names and every dependent uses | validity | **never asked. No criterion of the 16 mentions the step from lifetime to feature count** |
| h3 (first half), b2, e10, w3, w8, o2 | validity | never asked; F8 stands against w8 |
| a2 (Jeffreys), z2 (Watson), e15 (Laplace) | source | never asked; no citation to ask it against |
| l1, l2 (Gott 1993; Buch, Gott 1994) | source | never asked at HEAD; at a secondary once, lapsed. Each check that read them says Buch and Gott 1994 were not read |
| i3, l7 (Ord) | source | never asked; one remark inside check 2's free text, outside its criterion |
| e7 | reproduces | never asked by an act that counts; no script named |
| o1, a1, u1, b1, k1; c3 as said of software | holds-of | never asked. `item:tst-cheap-falsifiers-and-measurement-design` names the cheapest test |
| a2 | ratified | no decision on record. Proposed in checker 3's write-up, written by the round-4 integrator |
| n1, n2 | novelty | never asked |
| h1, the second example of d2 | fidelity | found (F4) |

## 5. What is accepted, and what is owed

The three candidate acceptance rules of `ontology.md` §4, on the same record.

### D, as asf declares it today
Nothing is accepted: the segment is `stage: draft`, and so is nearly every row of its volume's outline. Canon is empty, so by core's "only canon owes" **the frontier is empty** and asf is steady at every state. Everything above is "shown and not owed", inside the stated conditions as "every provisional piece the canonical projection reaches, with whatever has been recorded against it". No item has a cause, a clearer or a changeset.

### L, landing (asf's own sense of "in canon")
All 65 pieces are canon. Owed, in this segment:

| item | piece | cause | cleared by |
|---|---|---|---|
| raised (a check came back narrowed), and found | z3, z4, z7 | check-4 C2 and the finding it opened | a repair by the author seat, then an answer from someone else |
| found | h2, e6, l6, which restate it | the same finding, whose target is the whole segment | the same |
| found | h1; d2's second example | F4 | likewise |
| found | w8; l3 to l5 | F8 | likewise |
| overclaimed, on one of three readings | e7 | content reporting a numerical check, with no counting run on record | a run; or a `run-of` reference and a script |
| raised by rule | a2, z2, e15 | imports with nothing cited | a citation |
| a decision reported and not on record | a2, e4 | "this segment's reading" has no party | the steward ratifying, or the text not presenting it as settled |

And in other segments, from the same causes: found, `impl-foundations-features` (F7, which restates z7); narrowed, `der-change-investment` (check-4 C9: its list of inherited assumptions omits a1); a question raised on every piece that assumes a premise round 4 changed, answered in the record for `der-dual-optimization` (check-4 C8, confirmed), and unreachable for the five segments that name this one only in prose.

Nothing on the frontier says that c3 has never been checked. That is a stated condition under L, not an owed item.

### E, evidence (the rule core's examples use)
Accepted at HEAD: c1, c2, w1, w2, w4, w5, w6, i1, e3. Nine of 65. Not the headline, not c3, nothing in the hazard unit.

Owed: z7 (accepted for twenty-four minutes at v3, from 23:01:59Z when check-1's finding was answered with check-2 C11 binding, until v4 was written at 23:26Z; reopened then; now narrowed and found); l3, l4, l5 (accepted at v5 on check-3 C10; reopened at v6; check-4 C3 confirms them and F8 stands against them); l1, l2 (accepted at v5; their text has not changed; reopened because the act that accepted them was one act with l3).

Not owed, because never accepted: h2, e6 and l6, which carry the same narrowed claim as z7 in the segment's most-read sentence; z3 and z4, which z7 is predicated on; h1 and d2 (F4); w8 (F8's other half); c3.

So under E the frontier holds the last paragraph of the hazard subsection and the Lineage's attributions, and does not hold the summary sentence that says the same wrong thing, because of which of them an independent check with a pre-fixed criterion happened to concern during one half-hour on 10-30. And whether z7 owes at all turns on my judgment that the HEAD sentence is the same piece as the v3 sentence: had the round-3 integrator's rewrite been recorded as retiring one piece and minting another, z7 would be provisional and the frontier would hold the Lineage alone.

### The open changeset
Under L or E this segment has been inside an open ‹atomic·changeset› since 10-30. Its lane was not alone in it: `scope-evolving-software`, which this segment depends on, was written by the TST lane at 21:23Z and by the Part I round-2 integrator at 22:26Z, and core says two open changesets that write one segment are one from then on. Read at `depends:` grain, every lane of that day's sprint also rests on `scope-adaptive-system`, which was being rewritten until 03:11Z. I did not trace the other lanes; from these two facts the sprint was one changeset by core's rule, and it has not closed: the store's dashboard shows 182 findings not disposed of and 223 rewordings awaiting a second mind at HEAD.

### What a steady state here would state
To close over this segment under L: answers, by someone who wrote no repair, to check-4 C2's finding, F4 and F8 after repairs to z3/z4/z7 with h2/e6/l6, to h1/d2, and to w8/l3 to l5; or a waiver for each with its reason; and the same for F7 and C9 in the two dependents. Its conditions would then read:

- **validity never asked**: c3; h3's first half; b2; e10; w3; o2; z1, z2, z5, z6 by any act that counts; and by a second means (collision or instance, not the author's) for every claim in U1 and U2.
- **source never asked**: Jeffreys' prior, Watson's lemma, Laplace's formula (uncited); Gott 1993, Buch 1994, Gott 1994 (never at a primary); Ord 2023.
- **holds-of never asked**: all five premises, and c3 of real software.
- **ratified, no decision**: a2.
- **reproduces never asked**: e7.
- **the required-when-load-bearing claim·record slot**: empty.
- **inbox**: six notes, five with a recorded disposition of delete not carried out.

## 6. What the model would have done at round 4

The defect check-4 C2 found was made by two writes. At v4 the round-3 integrator made survival the observation for the whole Formal Expression and deleted z7's own sentence saying survival was all it needed. At v6 the round-4 integrator changed the Formal Expression's observation to the uniform-age likelihood, and the hazard unit was left conditioning on survival with no premise of its own.

- **By references.** Nothing in z3, z4 or z7 pointed at the observation premise, at v4 or after, so nothing went stale at v6. This is core's unwritten-reference problem inside one file.
- **By reads.** Check 6 (the only independent check that had looked at this joint) lapsed at v4 when z7 was rewritten, correctly; after that no independent check concerned the hazard unit until check 15. Had check 7 (the author's) listed the observation premise among its reads, it would have lapsed at v6 and named why.
- **By the unit's inner dependency, claims → premises.** U3's own premise k1 did not change at v6, so U3's claims were not dependents of anything that changed. Only an inner dependency from every claim in the segment to every premise in it would have refused the v6 write until the hazard claims were changed or affirmed, and that is some thirty affirmations for one premise edit.
- **By means.** The record has what the stopped-bound run asked for: check 15 says, in its criterion, that it set the hazard route against the segment's own stated observation and ran an instance, and none of the six earlier checks of that unit did after v3. A *read as* that asked for a collision at the current version would have left z3, z4 and z7 short of *corroborated* from 03:03Z until it was run.
