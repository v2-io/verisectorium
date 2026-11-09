# What the udon specification work and the address theory hold their pieces to account for

*A reading of the primaries, 2026-11-08, by Claude (Opus 5.5), for the census of what a body of work should record about how each of its pieces stands. First reader is the coordinator; then Joseph, cold, looking for specimens. I did not open `~/src/verisectorium/` (apart from writing this file) or `~/src/aat-v3/` at any point, and I have not compared this against any earlier reading.*

*A caution that applies to all of it: most of these records were written by the model I am. Where I find them coherent, that is one lineage reading itself.*

**Path shorthand.** `lite/` is `~/src/arch/firmatum/udon/v2/spec-lite-0.1.0/`. `v2/` is `~/src/arch/firmatum/udon/v2/`. `addr/` is `~/src/address-theory/`. `VERBATIM` is `lite/.int/STEWARD-VERBATIM.md`, Joseph's kept words, cited by line. All counts were taken by script over the working tree on 2026-11-08.

---

## 1. The short version

**What gets asked of a piece here is mostly not "is it true?"** It is, in roughly this order of consequence:

1. Whose words is this, and did they say that?
2. How firmly was it said, and what does moving it cost?
3. Has the person who decides even seen it?
4. What is it called, and what must it not be called?
5. Does it still feel obvious once it is combined with everything else?
6. What had to be true for this to be right, what would reopen it, and what breaks if it moves?

Questions 1 to 3 are about acts of deciding. Question 4 is about the vocabulary. Question 5 is a judgment made by minds looking at examples. Only part of question 6 is checkable by anything resembling proof. §3 takes each question in turn, with specimens.

**The apparatus designed to carry standing is almost entirely unexercised, and standing lives elsewhere.** In `lite/`, on the working tree:

| Designed carrier | State |
|---|---|
| `verification-level` and `evidence` frontmatter | on **0** records. Non-empty ladders are declared for 11 kinds across two `kinds.yaml` files. |
| Row-type `landed` ("committed canon") | **0** rows. `main.outline.md` has 142 `proposed`, 10 `gap`, 3 `example`; `sop/main.outline.md` has 31 `proposed`, 5 `gap`. |
| `awaiting-second` | `true` on **236 of 236** records, including every decision that has had a written second reading. It discriminates nothing. |
| ∂ and ※ computed columns | shown nowhere, by decision (`no-computed-columns-yet`). `bin/` is empty. |
| `decided-by` values `ruled`, `delegated` | **0** uses in either decision set, though both are in the current template. |
| `strength: forced` | **0** uses. |
| Fixtures | 1 file; 4 of 94 rule cards cite it. |
| `property` and `explanation` records | **0** written. |

What actually tells a reader how a piece stands: Joseph's own word kept under a quote, one line saying how firm it was, `strength:` (on 53 of 134 cards), the sentence "Not reviewed with Joseph", working notes, and free-standing review reports in `.int/` that are attached to no record. §5 sets this out, and I think it is the most useful thing here for a model.

**On whether the question is the right one:** partly. "How does this piece stand?" keeps coming apart in these corpora in three ways. Standing here is mostly a statement about *what the next mind owes before moving it*, which is forward-looking. It often belongs to an *act* or a *relation* rather than to the piece. And its grain is frequently finer than the record: a single card routinely holds Joseph's words, an agent derivation he assented to, and an agent default he never addressed. §6 argues this.

---

## 2. Who asks, and in what form

**Who asks.**

- **Joseph**, as decider, by several distinguishable acts, and also as the person who spots what has drifted.
- **The coordinator** of a session, who frames the question, offers a lean, and records.
- **Second readers**, fresh agents of the same model, who compare outcome against quote (`lite/sop/influx/adr-check-notes.md`, `lite/.int/adr-second-look-2026-09-30.md`, `lite/.int/adr-check-2026-10-08*.md`).
- **History agents**, who write a question's history without seeing any lean (`lite/.int/pre-design/README.md`).
- **Vocabulary agents and the coordinator**, who append labeled opinions to definition cards.
- **De novo auditors and impact reviewers** (`lite/.int/peg-audit-2026-10-21.md`, `lite/.int/impact-unquoted-run-2026-10-21.md`).
- **Cross-substrate reviewers** (grok, codex, agy, in `v2/spec-0.09.01/.reviews/`).
- **Cold trial agents**, Haiku through Fable, primed and unprimed (`lite/.int/trial-values-2026-10-28/`).
- **Downstream consumers**: ai-risk-model reading the address theory, vsect as "lite's first real customer".
- **Parser implementers, who do not exist yet** and are written in as a future asker: "there is a critical stakeholder that will only start once the spec is 'complete' enough-- but also that is a critical input for the spec" (VERBATIM:661).
- **Tools**, in the address theory only (`bin/compose-lexicon --check`).

**In what form.** Frontmatter booleans and enumerations. Prose sections with fixed names (Grounds, Epistemic status, Implications, Assumptions, Reopen when). Quote blocks with a location. A one-line "word" note under a quote. `.context.md` sidecars. Working notes with labeled opinions. Outline cells. Ledger rows. Fixture profiles. The directory a thing sits in (`.int/`, `obj.future/`, `.archive/`). A separate file of verbatim words. Dated review reports. Commit messages.

---

## 3. The questions, with specimens

Ordered by how much I think each matters, which is my judgment. My evidence for the ordering is what Joseph intervenes on most sharply, what has been reverted, and what the second readers most often find.

### 3.1 Whose words are these, and did they say that?

The dominant question in `lite/` and the estate's founding worry.

The record of why it exists, from `v2/DECISIONS.md:159`:

> **Provenance of the K-rows, and what to do at a conflict.** Joseph never ratified any row below *as written* — he ratified statements in live collaboration; the K-labels and row prose are the coordinating agent's good-faith interpretation made at the time (his comments often need it: anti-examples, hedges, "I would prefer" meaning not-yet-decided). That interpretation work was legitimate — but it is **interpretation, not ratified text**. So when a row later conflicts with something else (another row, a worked example, an implementation question), do not adjudicate rule-vs-rule: the conflict is evidence an inference has become load-bearing, and the protocol is to return to Joseph with *"when you said 'xyz' — were you also implying 'abc'? I assumed yes at the time, now I'm wondering."*

The form it took:

- every decision has a Quote section with where the words are kept, and "Not located" if they cannot be found (`lite/adr/TEMPLATE.md:60`);
- `wording: verbatim | rendering`;
- a corpus file of his words, so that records can quote a file instead of a transcript;
- a named hazard (`lite/sop/src/ref-hazards.md`): "An agent's sentence carried as Joseph's words. A slogan from an agent's research report was attributed to Joseph, used as the warrant for a scope clause, and made a headline".

What second readers actually find when they check this is rarely a false quote. "The verbatim layer is clean" in both reviews (`adr-check-notes.md`, `adr-second-look-2026-09-30.md`). The failures are subtler, and worth holding because they name what a record needs to be checkable against:

- **Hedges dropped.** "Several records lose a qualifier Joseph gave: … 'I think we can adopt an **interim** convention' … The Outcome presents matched brackets and the escape rule as settled, with no 'interim'." The reader proposes a check: "does any '…' in a Quote, or any paraphrase in the Outcome, remove a qualifier" (`lite/.int/adr-check-2026-10-08.md:42–51`).
- **Tier-mixing inside one outcome.** "within one Outcome, Joseph's words, agent derivations he assented to, and agent defaults he never addressed … all sit at the same visual tier. A per-bullet marker such as *(his words)*, *(assented)* or *(agent default)* would catch most of what I found" (same file, line 209).
- **An answer whose question is lost.** "§1 keeps Joseph's answers ('3. sure', '5. yes', 'i can sustain your lean') without the questions they answer, which exist only in chat." (`adr-check-notes.md:37`). And: "not sure what 'option 2' is referring to" (VERBATIM:209). The lesson drawn: "a retroactive ask works only if it carries the content being asked about."
- **Saying less than he did.** "Most of what I found is on the 'less' side, which a 'check for overclaim' brief would have steered me away from" (`adr-second-look`, §7).
- **A driver that was the agent's argument.** The template's answer is that a driver the deciders did not give is marked "(**inferred, unconfirmed**: whose reading, and where.)".

The sharpest specimen of the failure in its live form, 2026-10-29, after an agent edited five cards on his clarification and marked them decided (`VERBATIM:2046`, `2062`):

> goodness. I thought I was just clarifying what I meant for you to pass onto the other agent-- not adjudicating that fully and officially and thoroughly in the code yet

> I don't mind you changing what you want to change based on verbatim leans etc.-- it can easily be fixed if a lean ends up tipping the other way-- I just don't want to pretend it's been fully adjudicated in our discussion, nor pretend that *I* asked anyone to change the cards when I haven't.

Note what he is holding the card to there. Changing the card is fine. What is forbidden is the card's implied claim about the state of the conversation.

**Counter-pressure, which any model should keep beside this.** Joseph has also said (VERBATIM:83):

> One reason I gave that "older isn't priveleged over newer, provenance isn't priveleged" note was because I've found that otherwise the agents will get too caught up on trying to decide what I said when, which is really irrelevant as far as authority or prominence-- we just need to know what has been tried, what the reasoning was, why it did or didn't end up working etc.

And (VERBATIM:1785): "I'm not really interested in fact checking casual conversations held days ago about this stuff and reporting that as some kind of finding or conclusion. I'm interested in the CTQ weights adjudicating various design proposals."

And, as quoted in `lite/sop/influx/proposed-decision-authority.md` §1.4, from a note I did not read at its source: "they cared so much about the provenance correctness that they forgot for a moment to even care whether it was a good decision or not."

That proposal draws the design consequence: "The label is where agents' attention goes" (§1.4, carried into `adr/decision-authority.md` as a driver).

So attribution is the question most asked and the one most capable of displacing the question it serves.

### 3.2 How firmly was it said, and what does moving it cost?

Here "standing" is defined as a revisit path. `lite/adr/decision-authority.md` is the fullest statement. Five of its rows:

| Value | What happened | Revisiting it |
|---|---|---|
| `proposed` | Nobody with standing has decided. | Change it freely. |
| `delegated` | A delegate decided under a named grant; the decider hasn't acted on this record. | Anyone may raise it; superseding it falls within the same grant; the decider may support, ratify, rule or decline it. |
| `supported` | The decider saw it and had no objections at that time. | Cheap: bring what changed. |
| `ratified` | The decider thought it through and would like to know if someone feels differently. | Bring the disagreement to the decider, with reasons. |
| `ruled` | The decider's call, which may rest on a reason not stated. | Work out your best understanding of why it was made, check that understanding with the decider, then decide together; never argue from reconstructed reasons alone. |

Joseph's distinction in his own register (VERBATIM:298):

> wrt the difference between a lean and a ruling-- either one you can push back on as more understanding and other situations may demand, but it might help with the tone-- "We've got a problem here- due to such-and-such-ruling (upon which we predicated many other decisions) -- this other thing is now problematic it turns out..." vs, for a lean, "Remember you were leaning toward this?.... If you reconsider that, it would clean up this new thing...." -- [rulings] seem strong enough to essentially propagate into other decisions and tradeoffs, whereas leans shouldn't cost much to reconsider.

Why he leaves things soft (VERBATIM:661):

> when I decline to rule on things and instead support of lean or even like-- again those are enough to act decisively on as "working spec" -- the main reason I leave them softer is because I expect there to continue to be slight reworks as remaining open questions interfere with the tentative positions, because (as already recorded) it retains the strength of the position to help calibrate revisiting things, but *also* because I will want the parser implementers to be able to propose changes in these areas

The field that survived, proposed by him as "a 'strength' scalar maybe in the frontmatter-- how revisitable it is" (VERBATIM:1037), and defined in `lite/sop/influx/udon-team-notes.md`:

- `forced`: follows from other cards; revisiting it means revisiting those, which Grounds names;
- `decided`: debated and decided; revisit with a reason (a new case, a conflict, an implementer's finding);
- `lean`: working spec, cheap to revisit; implementers are invited to propose the other way;
- `provisional`: holds the place until a named discussion settles it.

A specimen of how this looks when a single card holds parts of different firmness, from `lite/src/rule-opaque-span-raw-text.md`:

> **How firm.** His words: "I vote" (raw text), "I think we can adopt an interim convention" (matched brackets), "I'm ok … for now" (the newline error, the agent's proposal), "I'm OK with your lean" (the any-`\X` escape, the agent's lean), "I'm ok keeping it simple" (the `;{…}` newline). Raw text and matched brackets are his own calls (`steward`); the newline errors are `supported` parts; the escape rule, first `supported` ("I'm OK with your lean"), was reaffirmed in his own words later that evening

And a finding about what happens to the axis when the decider says it doesn't bind. Asked to classify three calls, Joseph answered (VERBATIM:499):

> As I explained earlier, no difference from the spec's perspective. Preserve them as what I said so that as other issues come up now or during parser implementation there isn't some sense of orthodoxy to adhere to. You are free to mark them as "decided" for lite-1.0 assuming you have a footnote somewhere that says that decided can be revisited if/when undiscovered confounding factors come up.

The second reader's observation (`adr-check-2026-10-08-b.md:89`): "`decided-by` now carries almost nothing for lite's spec records beyond the word line. `steward` versus `supported` there tracks his phrasing ('I think' versus 'my current lean'), not anything a reader acts on differently."

Two more things belong here. First, a pending correction that shows the vocabulary is still unsettled by its author (VERBATIM:213): "sustained means I fully endorse and 'decide' based on someone else's proposed 'lean' … whereas ratify means I endorse an already decided item after the fact." It is recorded as pending on `decision-authority`, and under it that record's `ratified` conflates timing with firmness.

Second, the older ledger's register notes, from `v2/DECISIONS.md` K16: "'I'm OK with' means I am OK with it — not that I think it should be law — I'm ok going either way."

### 3.3 Has the person who decides even seen it?

A plain, distinct question, and the one that reorganized the priorities of `lite/` in October. It is carried by the sentence "Not reviewed with Joseph", by `awaiting-decision`, and by `strength: provisional` on 39 of 40 definition cards.

The moment it surfaced (VERBATIM:826):

> Again I keep seeing you use "label" when you mean "attribute" or if you're being more specific "the attribute's name's label construct" -- is that an example of something that got a def/ lexical definition decided and it just wasn't communicated to me? or is it casual use/misuse, or have definitions not been nailed down yet as appropriate and as they've come up etc.?

The inventory's answer (`lite/.int/lexicon-inventory-2026-10-09.md`):

> "**label" and "line scan" came in from 0.10.0's glossary**, an agent-written suite from the 2026-08-09 overnight unification pass that Joseph never ruled on, and the card drafters used them as if settled … So the honest category is the third one: definitions were never nailed down with him. The cards then used inherited words casually, which made them look settled.

How it reads on a live record (`lite/def/def-typed-value.md`):

> **Not reviewed with Joseph.** Joseph, 2026-10-09: "I haven't looked at any or been asked about any of those things … but the idea that they can just kind of organically be whatever would cause serious trouble really soon if allowed to continue." Every term here is provisional until he rules on it

And the top of `lite/TODO-MSC.md`: "**None of the definition cards marked `strength: provisional` has been discussed with Joseph or accepted by him.** They are agents' drafts, with research and leans in their working notes. The only definition he has accepted is [[def:delimited-string]] (tacitly, 2026-10-20)."

The address theory's version is `:status proposed` on all seven term groups, with this tension noted by a reader: "'Quality bar' vs `:status proposed`. The plan calls these entries 'the quality bar', which is faithful to Joseph's words about their refinement; their recorded status is still `proposed`" (`addr/inf/SOLIDIFICATION-PASS-2026-10-09.md`). So a downstream project relied on them more than their status claims.

A sibling hazard with its own memory, from `lite/.int/HANDOFF-2026-10-29.md`: "never argue from an agent's undiscussed draft as if it were the state of things". Agents reason from a provisional card as if settled. One session's professio named that as the hardest thing to avoid.

### 3.4 What is it called, and what must it not be called?

Joseph puts this at or above the rules (VERBATIM:826):

> Getting the names right and having us all speak the same language, DDD-style, is critical to this-- deciding on the right name that hasn't been adjudicated and that has conflicting invented guesses over time or even some conventional uses that were stable but with exceptions-- is just as important if not *more* fundamental than the rules governing them. To think otherwise is to fall into the engineering trap of thinking that if something "works the same way" it doesn't make a difference what things are called inside. That is only true of something guaranteed to never be changed or need changes ever again-- which rules out pretty much everything meaningful.

What he asked each definition to carry (VERBATIM:844):

> for each entry be sure and have agents add an "Avoid" list that includes all prior names or confusions. Then, for ones not settled, have agents try to determine prior non-conflicting leans of mine and other agents (often implicit for both and ambiguous), examples and precedents in other languages, notations, parsers, grammars, lexers, etc., any questions about the semantic meanings or register or affordances etc.—- all in the working notes, enough for you to add your own lean with reasoning to me

`lite/def/def-head-position.md` is the most complete specimen I read. It has the term and a working definition marked "(Working definition of the thing, under Joseph's name for it. Neither the name nor the extent is reviewed for lite.)". It has an Avoid list giving each rejected name's coiner and commit. It has dated quotes from `history.jsonl` by line. It has "Readings of his usage (mine)", "Precedents" (regex, flex, YAML contexts, CommonMark, Haskell), "Questions about meaning, register and affordance", "My own opinion (the drafter's; not a lean of Joseph's)", and "Coordinator's lean (Opus 5.5, 2026-10-09; my opinion for Joseph, not a lean of his)". That card is about 100 lines around a one-sentence definition. Definition cards average 19 top-level working-note bullets, with a maximum of 52.

The failure taxonomy for a definition (`lite/sop/def/def-record-kinds.md`): "fails by being ill-defined for some input, by being used inconsistently, or by colliding with an existing term. It is repaired by restating it, fixing the uses, or citing the existing term instead."

The address theory's form of the same questions, in `addr/def/def-reference.ud` and its siblings:

- `:avoid [address] ; An address is a reference, but it is given its own narrower definition later`
- `:avoid [search query] ; each names an activity or artifact, not the connection established`
- `@{UPPER-CASE}` for a term that is "load-bearing but deliberately not yet defined".

The second edition's acceptance test for an entry, from `addr/.archive/second-theory-iteration-2026-08-08/terms/TERM.term.un`:

> ACCEPTANCE TEST (the five-second glance): a steward reading a term they have never seen knows (1) what to call it, (2) what not to call it, (3) what it is, (4) what must be true of it — before any apparatus appears.

Also on record there, after a template "failed rather miserably": "the survey optimized field coverage; the target was reading experience. 90% payload, 10% apparatus."

And a comment discipline that treats undefined terms as a leak (`addr/defs.source.ud:12`):

> Comment discipline: comments may cite, question, or record — they may NOT dress a phrase up as a term unless it is defined here or @{flagged}.

Marking: «term» for lite's terms and ⟦term⟧ for the SOP's, with a stated reason for delimiting at all: "officially defined terms should always be deliniated" (jaw §1.8); "A delimited term that no `terms:` list contains (a dangle); a term that two definitions both list (a collide)" (`lite/sop/src/conv-term-delimiters.md`).

### 3.5 Does it still feel obvious once combined with everything else?

This is Joseph's actual method for deciding, and it has a specific form (VERBATIM:284):

> One of the most valuable things for *me* when deciding on leans and tradeoffs has been to do some diffuse thinking where I construct lots of random permutations of the rules I'm considering-- almost always combining lots of them instead of just the one under the microscope in isolation. These are good advanced composite fixtures, but more specifically they become my "self-introspection" check on how *obvious* it feels, and when if ever it would *not* feel obvious or what it would preclude etc. etc. Such a set of examples with the different ASTs it *could* create depending on which way something leans, and then a bunch of composite permutations that show it in [many] other contexts-- is by far the best way to communicate to *me* (fwiw) what the issues/tradeoffs are.

It comes with an instruction about what not to bring him, same message: "asking me to make decisions on P12 and B35.3(c) and on the 'fragmantic capture' or something that is newly coined for this spec or otherwise ambiguous … those kinds of summaries, questions, statements, requests, will *not* save time and will in fact bog the project down further".

The cold-agent version generalizes it, as a measured instrument. `lite/CTQ-FACTORS.md`:

- A2, generative guessability: "Measured by exposure curves: fresh panels write UDON from held-out trees given as JSON, at several exposure levels. Silent misses (it parses, to a different tree) weigh more than errors."
- A1, agent-subjective beauty: "A reason like 'this seems more beautiful to me, I think because it's less ambiguous about which value belongs to which name' counts even when no other contributor covers it, and may point to a missing one."

And agent instinct is admitted as evidence outright (VERBATIM:1057):

> you are a "principle target end-user" of udon. Your "beginners mind" trained instincts are actually quite an asset, as is your intuition. … A simple "this seems to be what I would expect" is a perfectly valid rationale for you! (and for me, to be honest)

The trial's own framing of what it is worth, `lite/.int/trial-values-2026-10-28/RESULTS.md`: "Read it as eight instincts, not a measurement: eight agents of one vendor's model families, one run each. The two Haikus are the thinnest evidence … And the arms were leakier than designed".

Fixture profiles make this a record field. `lite/sop/def/def-fixture-profiles.md`: `canonical`, `idiomatic` and `counter` gate conformance; `descriptive` "never gates. It carries a set of ⟦reading⟧s, one tree per open alternative", keyed to the question, and flips when the question closes. `counter` carries `expects`, "what a reader plausibly thinks the input means: the wrong reading the case exists to correct".

In the address theory the matching move is the stress case with a stated refutation (`addr/def/def-match.ud`):

> Exhaustiveness — every addressing form examined decomposes into bindings consulted and matches run … — is held provisionally with its refutation stated: a mechanism that is neither reorganizes this layer.

And `addr/def/def-binding.ud`: "Hardest known stress case: Java packages 'exist by virtue of use' — the namespace is constituted by the union of its users, which strains 'kept by whoever minted it.'" In `defs.source.ud` the same note reads "on record so it isn't discovered against us".

### 3.6 What must stay true, what would reopen this, and what breaks if it moves?

Three linked sub-questions.

**Assumptions and reopen conditions.** The template makes them required and forbids back-filling (`lite/adr/TEMPLATE.md:36–40`):

> *Required. What must stay true for this decision to stay right. Each assumption that could break becomes a line in "Reopen when".* … *If none were recorded, write "None recorded". Do not reconstruct them.*

Joseph's statement of why (`lite/adr/decision-authority.md`):

> it (and any other decision) is not set in stone, that's part of why this process exists, so that we can see what assumptions went into some decision and know when it's appropriate to revisit for the sake of the real goals instead of momentum/inertia and appeals-to-authority.

A specimen of a reopen condition that is really a measurable (`lite/adr/errors-stop-parsing.md`): "Tools on the live corpus need partial trees from documents with errors." And `lite/sop/adr/notes-disposition-at-freeze.md`: "Records reach freeze with notes routinely deferred rather than resolved. That would mean the drain only moves the pile."

**Impact.** Joseph asked for the frontmatter to carry both directions (VERBATIM:724):

> you'll start (hopefully) instinctively using the frontmatter of each card to say which other rulings it depends on or assumes, for example, and the inverse-- which other rules are consequences of it-- with your "verbatim" quotes and reasoning as working notes in that very segment-- easy to find, easy to know what the impact of a change would be, etc. etc. etc.

"Impact radius" then became a named cost in `lite/CTQ-FACTORS.md`: "A branch's **impact radius** is a cost, not a quality: the cards it changes, adds or deletes, weighted by each card's `strength`". An instance as a task: "have a fresh agent look for any inconsistencies between that rule and everything else including verbatim statements and leans etc.-- in order for us to know what the impact radius is" (VERBATIM:1466; the result is `lite/.int/impact-unquoted-run-2026-10-21.md`).

**Derivability.** This is the question closest to proof, and it is asked of pieces in an unusual way, as an insult to the record when it has to be asked at all (VERBATIM:752):

> bare ```- should be very obviously a fenced block preserved verbatim. The fact that it's a question worries me. Same with third question-- the answer should have been a very obvious as derived from the rules we finally landed on.

And (VERBATIM:746): "correct- but it should follow from the other rules and already be clear, not its own rule I would think...". And (VERBATIM:769): "partial orientation will also cause you to generalize incorrectly and assert new rules that should be obvious derivations of existing conventions and rules."

So a card can fail by not needing to exist. The tell is in Joseph's example for Grounds (VERBATIM:1037): "Only option that leaves ... and ... consistent- revision blocked by those."

**Collision.** When two records conflict the protocol is explicit: "When decisions conflict: don't weigh one decision against the other. Go back to the decider" (`lite/sop/src/conv-decisions.md`). And in the address theory the fixes proposed are exactly collisions between entries, each with current text, proposed text and reason, none applied until he decides (`addr/inf/DEF-FIXES-PROPOSED-2026-10-09.md`):

> `def-binding` counts a collision per maintainer; `def-scope` counts it per scope … SB 53 (one legislature, one name minted in two code chapters) is where they disagree, and ai-risk-model tripped on it.

`v2/theory/FORMAT.md` §1 gives the mechanism: "A segment forces a present-truth claim, and two present-truth claims about one thing can *collide*. An append-only history layer is collision-free by construction".

### 3.7 What is deliberately left open, why, and what would close it?

Both corpora treat a declared absence as a first-class statement, and this is one of the things they do best.

`v2/spec-0.09.01/CARVEOUTS.md`:

> Each carve-out carries the **demand-side reason it is open** — so no future reader closes it in a framing the reason has already invalidated — and what would actually close it. This register exists because of a measured failure: three clean-room rewrites (2026-07-20) were handed the spec without these reasons, and all three diligently *closed* the multi-line question per-construct — diligence on a wrongly-framed question producing well-organized irrelevance.

`addr/defs.source.ud:231`, headed "Deliberately left open (named so they cannot arrive by assumption)". `addr/def/def-resolution.ud` lists its deliberately-open items and states one as a debt: "Termination under open edge labels is this theory's undischarged obligation."

`v2/theory/src/norm-gap-as-discontinuity.udon`: a gap "MUST NOT: carry an identity that other claims `depends` on …, assert how many segments belong in the hole". And on what a gap is for: "Collision cannot detect missing claims."

`v2/theory/FORMAT.md` §0a: "Honest incompleteness is a complete discharge." §0b: "An absence claim … is a universal negative, and a universal negative is warranted only by the search that produced it."

`lite/`'s closer vocabulary makes "who may close this" part of the question (`lite/sop/def/def-question-closers.md`): `steward-purpose` ("only what lite is *for* decides between the alternatives. No argument or measurement settles it"), `steward-fact` ("only he knows the answer (for example, what he meant, or what he recalls)"), `awaiting`, and `agent-open`, the default. It adds: "Joseph's arguments and measurements count as evidence like anyone's. Only his purpose and his own knowledge are reserved to him."

The cell-marks make the same distinction at the smallest grain: `—` not applicable, `∅` applicable but missing, `⚠` couldn't read the inputs. "Empty, failed, and not-run are always told apart" (`lite/sop/def/def-outline.md`).

### 3.8 What kind of claim is it, and what is the warrant's own standing?

The register question. `v2/theory/FORMAT.md` §9 and `v2/udon-needs/CLAUDE.md` have the four registers, derived, evidenced, decided, proposed. The operative statement:

> **A convention honestly stated is a complete answer.** "Chosen among what seem to be essentially equal options in order to have a standard; revisit at will" is legitimate reasoning and needs no argument manufactured for it. What is illegitimate is dressing that choice as a derivation. (`v2/theory/FORMAT.md` §5)

`v2/udon-needs/02-tooling-needs/src/method-evidence-tiers.md` is the most developed design in the whole set, and it is the one I would point a model at first. Its points:

- It has three axes and two locks, and says what each is for: "Each kind is defined by its **repair**".
- "A **decided** claim takes none — a decision is not strong-or-weak; asking 'how confident are we that we *chose* X?' is a category error".
- The convergent lock: "**The lock keys on failure-mode independence, and that is the whole discipline.**"
- It reports a reduction of its own claims: "`design` and `theoretic` share an author, so under the failure-mode key they are one estate leg, which un-armed several convergence claims" (`RESIDUALS.md`).
- Verification as events: "Each chapter's frontmatter carries a `verified:` list; each entry records **what was verified · against what · by whom · when** — never 'what state was attained'", including a `deliberately-corrected-away` event so a later reader will not "fix it back".

Small warrant marks in the working registers:

- `[L]`/`[P]`, "parser behavior is never language behavior" (`addr/sop/src/disc-orient.md`).
- `[recall]` and `[verified]` in the address-theory second edition.
- **(read)**, **(inferred)**, **(guess)** in `lite/sop/influx/proposed-decision-authority.md`.
- `[SG]` "where the correspondence is exact enough to inherit their proofs", then per-site checking, with `addr/inf/SOLIDIFICATION-PASS` §6 listing "Literature claims checked at the primaries".
- "recall" for things a reader knows but did not open, in `addr/inf/RESULT-AND-MOMENT`.

Evidence that is not admitted as such (VERBATIM:1761):

> they should not read any "live" documents in the corpus as empirical evidence of anything whatosever. Their own instincts will serve far better as empirical evidence-- all "udon" (and markdown etc. for that matter) they may come across, or analyses of it, were by fiat and arbitrary decisions by me and agents in this work and do not have the epistemic value of sampling things in the wild. They are only good for ideation, they are not evidence.

`v2/theory/FORMAT.md` §10: "Past decisions carry no normative standing, however accurately reported." And `addr/sop/src/disc-orient.md`: "same-author estate agreement is coherence, not corroboration".

The address theory adds a warrant type a spec does not need: inheritance from outside literature under premises. `addr/def/def-resolution.ud`: "Formal inheritance holds under premises established where used: resolution against a snapshot; finiteness; acyclic paths; regular admissibility; preference a preorder applied as a minimum." And `addr/def/def-scope.ud`: "each inheritance is verified where used, not here."

### 3.9 Does it serve what it is for?

This came into `lite/` late and changed things when it did. Joseph, redirecting spike agents (VERBATIM:1755): "the CTQ file we spent time on just before this is the guiding light and compass-- any past stuff they come across is only useful inasmuch as it meets those factors".

`lite/CTQ-FACTORS.md` holds weights and two vetoes. The form of what is measured matters: "A **veto** is pass/fail … The rest are weighted 0–10. … The factors overlap on purpose: none can be maximized at the others' expense".

`lite/sop/src/conv-purpose-layer.md` holds the guards, and they are worth quoting because a fitness is the one kind of piece in this set whose failure is a claim about a measure:

> **Goodhart.** A fitness serves a named principle, and its claim that the proxy tracks the principle stays on record and stays checkable. Meeting the number is never taken as meeting the principle.

> **Commitment.** "An objective's threshold on a fitness must be set before the measurement it gates. A threshold chosen after seeing the numbers is tuned, not tested (RC1's commitment law)."

Its reasoning for keeping principle, fitness and objective apart: "each can be wrong while the others hold. The principle can be right and the proxy bad; the proxy sound and the threshold too low; the threshold met and the principle no longer wanted." `fitness` remains "possible, not yet admitted".

Grounding direction, stated hard (`addr/sop/src/disc-orient.md`): "Decision authority flows demand→theory→grammar, never grammar→demand; the current 0.9.1 grammar is a fact to price, never the verdict."

`force` on objectives is empty on all four objective cards, awaiting Joseph. Joseph has not adopted the two principles (`lite/obj/prin-one-rule-everywhere.md`): "he is 'not convinced' the two principles 'are principled'; 'The old list from 2011 already gives me a better grounding than those two somewhat arbitrary principles seem to be'".

### 3.10 What did this cost, knowingly?

Asked consistently and answered in prose. `Negative Consequences` in decisions; `Implications` in cards ("for some of the user-facing costs accepted", VERBATIM:1036); **Costs accepted** in the folded decisions.

A good specimen, from `lite/src/rule-opaque-span-raw-text.md`: "Resolving every `\X` to `X` in the tree means a future interior grammar that gives `\` its own meaning (a path grammar's `\.`, say) reads `@{a\.b}` differently from lite, which hands over `a.b`. Acceptable under [[decision:forward-compat-aspiration]]; keeping the unresolved source text in meta would recover it."

The decision-authority record even records its own cost: "`steward` and `ratified` now differ only in where the call came from, which `deciders` already says. That small overlap is kept on purpose, to avoid churn."

### 3.11 Is the text only present truth?

A question asked of form, and Joseph presses it as a matter of what a spec *is* (VERBATIM:1037):

> you left all sorts of breadcrumbs that I for one would be surprised to see in an official spec-- Grounds -- "Joseph, 2026-10-09: "I think "..." and '...' should essentially...." blah blah blah-- that's historical breadcrumbs, not a spec. Try: Grounds: debated-decided, see [context](...) file. Revisit as needed.

And (`lite/main.outline.md:233`): "Cards quote 0.10.0? They really shouldn't-- we need to put that on the list of things to fix. I can't see that adding any value whatsoever-- bread-crumbs to a broken draft from another agent working on a problem that was completely distinct from ours".

So the words of the decider are needed, and do not belong in the spec. The resolution is a sidecar file whose first line reads "*History and provenance for the card beside it, kept for whoever later wonders why the rule is what it is. Not spec text and not a record; nothing here binds.*"

The grain of who needs it (VERBATIM:1028): "only really be relevant to spec researchers or something very specialized in the future (usually just me wondering why I did something)".

The strictest statement of the outline's obligation is his (jaw §1.1, `lite/sop/influx/jaw-proposal-and-feedback.md`): "THE OUTLINE MUST ALWAYS BE TRUE. That becomes difficult when we are first assembling it and trying things out etc." The response is the four concerns, with the observation that only the concern-3 cells can drift. A row claims only what its row-type claims.

### 3.12 Has anyone else looked, at what, and does the look check the right thing?

`awaiting-second` asks this as a boolean. The review reports answer it properly, and all open with what was read and how. The best of them asks whether the check is the right one. `adr-check-notes.md:32–50`:

> **For delegated records, the defined check is empty.** Their Quote is the delegation itself, which can't confirm or refute any particular outcome. What these records need from a second reader: 1. Is the decision within the delegation (which "those" it covers)? 2. Does it contradict, narrow or reverse anything Joseph said, anywhere? 3. Were the options fairly put, including a stronger one? 4. Is the reasoning stated?

The template absorbed that. The same reader's opening states the limit: "I'm the same model as their author, with a separate context, so this is a second reading, not an independent lineage."

Note that this is a question about the *check*, asked of a *kind*. It is the one place the corpus asks what a reader of a record would need the check to have been.

---

## 4. How the corpora differ

| | `lite/` spec store | `lite/sop/` | `addr/` | `v2/DECISIONS.md` ledger | `v2/theory/` and `udon-needs/` |
|---|---|---|---|---|---|
| Unit | "card": one normative statement | record of a kind told apart "by how it fails and what repairs it" | term group; one definer per term | ledger row | one-claim segment; chapter |
| What mostly grounds it | Joseph's words; agent leans labeled | Joseph's words in jaw §1, delegated calls | definition + stress cases + checked literature | Joseph via an agent's interpretation | derivation or evidence, by register |
| Standing carrier actually in use | word line, `strength`, Epistemic-status sentence, working notes | `decided-by` + Quote | `:status proposed` (constant); working notes' "left open" | row group heading; provenance note | `status`, `stage`, `register`, `support-kind`, `verified:` |
| How it is checked | second readers on decisions; `.int/` audits; cold trials | second readers | reading at primaries; a consumer's use; `compose-lexicon --check` | none recorded per row | event log (udon-needs); gates (FORMAT) |
| Ceiling (`max`) | dropped: "essentially an aspiration or intuition at first and basically helps define the 'kind' later" | none | column in the outline | n/a | first-class in the outline, "because … it follows from the **kind** of claim" |
| What changes it | new card edit; supersession for cross-cutting decisions | supersession, never edit | proposal in `inf/`, steward decides, one commit per entry | "Overturns" table | "Stage is a present-tense work-remaining marker, not a gate and not a trophy" |

The address theory is the only one with an executable check of its pieces. `bin/compose-lexicon` confirms every source line renders, every term form resolves through declarations, and reports what doesn't (`addr/LEXICON.md`, Assembler notes: "`@{moment}` is no declared form of any term"). That check found the real gap: `moment` is load-bearing in a `|rels` row and undefined. Its verdict is attached to nothing and has to be read.

Its acceptance by a consumer is a form of holding-to-account I did not see elsewhere: ai-risk-model pins a commit, has its own citation check, and reports strains back. The solidification pass treats those strains as findings about the theory: "Where that use strains, the strain usually points at a real gap in the theory". It also marks the limit: "Treat the ai-risk-model demand as weak corroboration: it came from a model of the same family".

---

## 5. Where the designed apparatus and the working practice part ways

This is my own reading of the working tree. It concerns only `lite/`, where a designed apparatus exists to diverge from.

**The check warrant has barely started, and that is not visible on any record.** The proposal's shape is two warrants (`lite/sop/influx/proposed-verisectorium.md`):

> **Decision warrant:** who decided, on what reasoning and assumptions, against which alternatives, and what would reopen it. … **Check warrant:** the truth-apt properties of the rules. Every input gives exactly one tree; the rules don't contradict each other; the rule set keeps the reserve-don't-ignore promise; a real parser agrees with the fixtures.

The check warrant is planned, and the planned places are empty: no property records, one fixture file, no ladder rung written. Meanwhile real checking has happened in places that attach to no record. `.int/peg-audit-2026-10-21.md` built an interpreter that reads the grammar out of the file and ran cases from the cards. `.int/impact-unquoted-run-2026-10-21.md` found "Three conflicts inside the card's own Statement". The value trial tested agent expectations. None of those moved any field. A reader of `rule:unquoted-run-is-one-value` learns from its frontmatter that it is `strength: lean` and `needs-work: true`, and learns about the review only from prose, if at all.

**Flags that are never cleared stop meaning anything.** "The second reader clears `awaiting-second`" (`conv-record-flags`). Second readers have read 11 + 15 + 4 decisions in lite and 37 in the SOP store, and each says it edited no record. The value is true on all 236. The convention gives the clearing to the second reader, the readers leave records alone, and no later step does it.

**Decisions moved into cards, and the machinery did not follow.** On 2026-10-09 (VERBATIM:730): "Isn't a card a decision already?" Twenty-nine rule-level decision records were folded into cards' Discussion sections. Consequences visible now:

- `per:` is empty on 72 of 94 rule cards.
- 20 of the 21 cards whose Epistemic status reads "A rule, resting on the decisions in `per`. No fixtures yet." have `per: []`.
- The sentence is now false on its face in those 20, and a linter for `conv-record-cadence` would not catch it.

**Three generations of standing language coexist.** A rule card may have an Epistemic status sentence (82 cards), `strength:` (13), or both, or neither. The Epistemic status sentences are themselves a small census of how standing gets said when nobody prescribes it: "Decided for this version" (about 20), "Chosen. No fixture yet." (13), "A rule, chosen, not derived. Checkable by fixtures." (12), then single phrasings such as "Joseph's lean, working spec.", "Ruled.", "A rule carried from 0.10.0 and reaffirmed in this session without a de[cision]…", "Provisional, pending a history search". Grounds is quote-led on 56 of 94 by a rough classifier, the form Joseph objected to on 2026-10-20. The reshaping is proceeding card by card as cards are opened (`lite/TODO-MSC.md`, *Cleanup*). That is a reasonable way to do it, and it means the set is mid-migration with no field saying which generation a card is in.

**A fact kept in two places.** `depends:` and the hand-written `consequences:` should be mirrors. Checked by script: 92 `consequences` entries have no matching `depends` on the other side, and 116 `depends` entries have no matching `consequences`. The template had already recorded the principle after measuring it on `affects`: "A fact kept in two places drifts, so each is kept in one." Joseph asked for the inverse by hand anyway, and the agent noted the conflict at the time (VERBATIM:726). `consequences:` is defined in no SOP record and is not in `kinds.yaml`'s `requires:`. A reader cannot tell from either field whether its absence means no link or no bookkeeping.

**Fields that were retired tell you what didn't earn its place.** The template records why, with counts:

> In the 26 decisions in `sop/adr/` (2026-09-30) it had drifted the way the `questions:` field did before it was dropped. Every one of the 26 is cited through `per:`, but 20 had `affects: []`. The 6 that filled it listed only some of their citers, in filename forms that don't resolve

`max` was dropped for lite because it was `decided` on nearly every row. In the theory corpus, on the same reasoning about kinds, it became first-class. These are not in contradiction: a decided corpus has a nearly constant ceiling, a derived corpus doesn't.

**One line on what this all suggests.** None of this is carelessness. Every one of these is written down by someone who noticed it. But the fields that get filled are the ones a person needs in the turn they are working in, and the fields that get left are the ones that would pay off only if something computed them later. A model of standing that depends on a clearing act nobody owns will report the state of its authors' attention.

---

## 6. Is "how each piece stands" the right question?

Mostly yes, with three amendments I would argue for. These are my arguments, offered for the census to weigh.

**Standing here is mostly forward-looking.** Look at what the fields say:

- The three flags: "Each says who or what moves next on this record" (`conv-record-flags`).
- `strength`: "how revisitable it is".
- `decided-by`'s value is defined by a "Revisiting it" column.
- Closers say who may close.
- Reopen-when says when.
- `needs-work` points at work.

Even `lean` and `ruled` are instructions about tone at the moment of reopening (VERBATIM:298). The recurring content is *what the next mind owes before acting on this or moving it*. A grade of how good it is appears rarely, and the corpus explicitly rejects it where it would appear: "No field or cell anywhere holds a hand-typed standing word such as 'verified', 'solid' or 'done'" (`sop/def/def-record.md`). If the census frames standing as an attribute of a piece, it may miss that these corpora mostly record an obligation on a future reader.

**A lot of it is not a property of the piece.** It belongs to:

- an *act* (who said what, when, in answer to what; what a reader read);
- a *relation* (a collision, a dependence, an impact radius, the fact that one card's working note reopens another);
- a *scope* ("decided for this version", "lite-1.0", "for now", "right now");
- a *state of the conversation* ("the issue is still being discussed").

`udon-needs` has already moved this way: "what was verified · against what · by whom · when — never 'what state was attained'". Joseph's objection on 2026-10-29 is to a claim about the conversation, made by a record.

**The record is often the wrong grain.** The kinds are defined at one unit that can fail independently, and the rule is: "If two parts of a file can fail independently, they are two records" (`def-record.md`). Yet Joseph himself said of a card carrying several decisions: "ideally each its own file but I'm not going to be a pedant about it when the organization really wants something like this instead" (VERBATIM:1036). And the provenance that matters, how firm and whose, varies by clause within a card, as the `How firm` paragraph on `rule:opaque-span-raw-text` shows and as the second reader proposed marking per bullet. The address theory is explicit about the same thing from another side: a term group of eight terms in one file, "split when any earns independent weight".

There is a fourth thing I notice but hold less firmly. **The corpus most concerned with who decided is the one where the decider keeps saying that isn't the point.** "I reserve the right to change my mind about anything and everything in the past :-)" (VERBATIM:74). The apparatus for keeping his words straight exists so that his words do not become orthodoxy (VERBATIM:499). That is coherent. It also means every field that makes authority more legible increases the risk he named: agents who "forgot for a moment to even care whether it was a good decision or not". A model that treats authority as a dimension of standing would want a matching provision saying what the dimension is not for. The nearest thing in the corpus is the substitution law: "A ⟦decision⟧ never makes a ⟦property⟧ true, and a good ⟦explanation⟧ is never evidence for a rule."

---

## 7. A few specimens with no other home

**The portable test for adding a field**, from `v2/theory/FORMAT.md` §9: "Two labels earn separation where they **route to different repairs**. That test is more portable than any particular axis set … Before adding a field, name the two repairs." The same idea at kind level, `lite/sop/def/def-record-kinds.md`: "A new kind is admitted only by exhibiting a thing that fails and is repaired differently from every kind already declared." And on a change of kind, Joseph (jaw §1.6): "because the very way 'it can fail' changes, it's really not so much a mutation as a dissolution and emergence of something else."

**The ladder that only promotes**, `v2/theory/FORMAT.md` §3: "Stage is a present-tense work-remaining marker, not a gate and not a trophy. … **A ladder that only promotes accumulates falsehood.**"

**On what verification means when an artifact is the object**, `v2/theory/src/norm-proxy-discipline.udon`: "**Verified-against-artifact** — checking that a file asserts $P$ verifies the file; it does not verify $P$."

**A hazard table worth reading whole**: `lite/sop/src/ref-hazards.md`. Especially "A condition lost between the check and the landing. A verifier proved a statement 'under exogenous future actions'; the text that landed dropped the qualifier and kept the word 'exact'" and "'Verified' meaning 'examined'. A handoff listed chapters as 'Verified' after a review that found about fifty defects." Its admission rule: "a hazard belongs here once it has recurred, or once it has a nameable tell and a dated occurrence."

**How much weight to give a label's author**, `v2/udon-needs/01-ideation/STEWARD-CALLS.md`, row 7, Joseph on an agent's summary: "decided to to his own synthesis dressed as copies and commentary instead of drawing in all of that raw feedback for us. Deeper pass wanted, originals wanted. 'weak demand-signal' overruled premature."

**A status-like claim that was corrected by reading**, `v2/spec-0.09.01/.reviews/RESPONSE.md`, Round 4: "**Verified against the record — my rendering was wrong.**"

**A disposition table against a theory**, `v2/spec-0.10.01/NUANCE-AUDIT.md`: "The steward's challenge, answered row by row: *'nuance is where all would-be axioms and unifications go to die.'* Each 0.10.0 nuance gets a disposition: **derives** … **convention** (honestly arbitrary; kept, stated as a decision), **overridden** … or **strain** (fights the frame; reported, not resolved). A unification that can't fill this table is a slogan." It is the cleanest case I saw of asking every piece *how it relates to the frame*. Worth noting that the draft it served was called "a misfire" a week later (`v2/WHERE-THINGS-STAND-2026-09-27.md`).

**A second-edition working note on a concept possibly being cruft**, `addr/.archive/.../src/def-descriptors.md`: "Steward skepticism recorded (2026-08-07): 'silent re-satisfaction' as a defined failure mode may itself be cruft on an untrue foundation — 'an unprincipled stand-in for a more principled event-sourced foundation… the errors are further upstream.'" A definition carrying its own possible retirement.

---

## 8. What I read, and what I didn't

**Read whole.**

`lite/`: `main.outline.md`, `CTQ-FACTORS.md`, `TODO-MSC.md`, `.vsect/kinds.yaml`, `adr/TEMPLATE.md`, 9 of 18 spec decisions (`decision-authority`, `leans-are-working-spec`, `decided-for-this-version`, `errors-stop-parsing`, `spec-organization-delegated`, `references-vocabulary`, `representational-options`, `term-typed-value`, `reserved-is-an-error`), 4 of 94 rule cards (`strings-like-ruby`, `unquoted-run-is-one-value`, `nil-spelling`, `opaque-span-raw-text`), 3 of 40 definition cards (`typed-value`, `delimited-string`, `head-position`), `obj-reserve-dont-ignore`, `prin-one-rule-everywhere`, 3 `.context.md` sidecars.

`lite/sop/`: `main.outline.md`, `.vsect/kinds.yaml`, all 21 `src/`, all 10 `def/`, all 5 `influx/`. Of `sop/adr/`, 4 of 46 whole, and the Outcome and Quote of 3 more.

`lite/.int/`: `README`, `HANDOFF-2026-10-29`, `adr-second-look-2026-09-30`, `adr-check-2026-10-08` and `-b`, `vsect-requirements-on-lite`, `lexicon-inventory-2026-10-09`, `reflections-what-the-parser-keeps`, `reorg-spike-2026-10-08`.

`v2/`: `README`, `DECISIONS`, `OPEN`, `WHERE-THINGS-STAND-2026-09-27`, `theory/FORMAT`, `theory/UDON-THEORY-canon.outline.udon`, two `theory/src` norms, `udon-needs/CLAUDE`, `udon-needs/01-ideation/STEWARD-CALLS`, `udon-needs/02-tooling-needs/NOTATION-KEY` and `src/method-evidence-tiers`, `spec-0.09.01/.reviews/{STEWARD-FLAGS,RESPONSE}`, `spec-0.10.01/{NUANCE-AUDIT,fixtures/README,working-notes/AUDIT-2026-09-01}`, `msc/for-joseph/01-PLAIN-DECISIONS`. Also `udon/defining-udon.md`.

`addr/`: `CLAUDE`, `sop/src/disc-orient`, `sop/SOP.outline`, `sop/inf/lexicon-tooling-recommendation`, `PRACTICA`, `DECISIONS`, `CHANGELOG`, `ADDRESSING-THEORY.outline`, `defs.source`, all 7 `def/*.ud`, all 6 of `inf/` including `.integrated/`, `ref/README`, `.practica`, the git log. From the archived second edition: `DECISIONS`, `terms/TERM.term.un`, `terms/designator.term.un`, `sop/ORIENT`, `src/def-descriptors`.

**Read in part, or by search.**

- `VERBATIM`: lines 1–991 read whole; lines 992–2077 searched for status-related terms, with about 20 passages read by line. It is the most important file I did not finish. Anything after 2026-10-20 that I cite is from the extracted lines.
- `lite/.int/peg-audit-2026-10-21`, `impact-unquoted-run-2026-10-21`: heads only. `trial-values-2026-10-28/RESULTS.md`: first 60 lines. `pre-design/README`: head. `dat/implied-root.yaml`: its header. `rule-missing-value`: head.
- `v2/spec-0.09.01/CARVEOUTS.md`: first 40 lines. `udon-needs/02-tooling-needs/RESIDUALS.md`: first 50 lines. `msc/for-joseph/00-QUEUE`: head.
- `addr/.archive/.../CHEATSHEET-2.un`: first 40 lines. The Fable reflections and founding notes: by search only. `addr/LEXICON.md`: Assembler notes only.

**By script over all records, not read.** Frontmatter fields and values, and section headings, across `lite/src`, `def`, `obj`, `adr`, `sop/adr`, `sop/src`, `sop/def`; `depends`/`consequences` reciprocity; `per:` emptiness; outline row-types. The reciprocity counts key each link on `kind:slug` from filenames, and `rule:nesting` (a gap row, 7 citations) is a legal unwritten target.

**Skipped.**

- 90 of 94 rule cards and 37 of 40 definition cards, individually. My generalizations about them come from the script and from what reviewers report.
- 9 of 18 spec decisions and 39 of 46 SOP decisions, individually (`adr-check-notes.md` reports on all of the original SOP set).
- `lite/.int/pre-design/` (about 70 files), `spike-values-2026-10-22/` (about 110 files), `principles-survey-2026-10-01.md`, and the other `.int/` proposals.
- All spec suites themselves: `spec-0.09.01`, `0.10.00`, `0.10.01` CORE and companions, which Joseph has said he would rather agents avoid (VERBATIM:1000).
- `v2/theory/to-integrate/`, `spikes/`, `.archived/`, most of `udon-needs/`.
- The five papers in `addr/ref/`, `bin/` source in `addr/`, the rest of the second edition.
- `test/usability/` in udon, which Joseph notes as prior measurement (VERBATIM:2074).

I did not open the transcripts, `history.jsonl`, vivarium, or the RC1 corpus cited throughout. Where this document quotes through a secondary, it says so. I have not checked those quotations at their source.

---

## 9. Adjacent, and feedback

**Small things found on the way, none fixed:**

- `lite/main.outline.md:27` and `lite/sop/def/def-record.md` cite `[[rule:implied-root]]`, but `src/rule-implied-root.md` no longer exists. It was split into three cards, as the fixture's header notes.
- `VERBATIM` holds the opening of session `9fa643a2` twice (sections at lines 940 and 970).
- `lite/adr/errors-stop-parsing.md` has `superseded-by: [{card: rule:missing-value, …}]`, a shape the template does not define, and since decisions fold into cards it is a real case the template will need.
- The `adr/decision-authority.md` working note records that Joseph's `sustained`/`ratified` definitions were never folded in; it has been pending since 2026-10-01.

**On the brief.** It worked for me. Separating "what these hold pieces to account for" from "what it should record" left room to report that some of the question's frame didn't fit. One thing I would have liked to know: whether "piece" was meant at record grain. It became a finding, so I am glad it wasn't specified.

I am available for questions. I have not read the earlier readings, and I'd suggest keeping it that way until the comparison is done.
