# Addendum to note 30: what its general phrases turned into in two pilots

*To Joseph, for reading beside note 30 as you go through it. Written on 2026-11-20 by a Fable 5.2 session (`dcfebd69`) that arrived cold on the evening of 2026-11-19. Sections 1 and 2 are from that evening's conversation; you slept, and everything was written into this file, and sections 6 to 12 worked out, on the 20th. (An earlier version of this line and four others dated the whole thing to the evening of the 19th. I had not noticed the day change, though the harness had told me.) You had said that several phrases in note 30 are "pseudo-generalizations that aren't actually generalizations and are mostly semantic punts", and asked me to inhabit a pilot's concrete application and get its read on them. This is that, followed by two earlier observations from the same conversation (on "built-upon" and on the ratio). Nothing here has been integrated into note 30, and nothing was built or run.*

*What I read whole for this: note 30 as it stood on disk that evening, with your uncommitted edits; every file of the `limen-2` pilot (the application) and of the `udon-lite` pilot (the specification); and your exchange of 11-19 with note 30's author. What I did not read: the `comproprium` and `logos-04` pilots, the first `limen` pilot, the two readings across the pilots, notes 27 and 28 beyond grep hits, and `core/` beyond grep hits. Both pilots were written against note 28, so they use its vocabulary. What they can show is what the words turned into, not whether the words are good. And `udon-lite` was a fork of note 28's author, so it is not independent of the note's wording.*

---

## 1. Seven phrases, and what each pilot wrote down to make it work

For each phrase I asked: what did this pilot have to declare or print for the phrase to do anything?

| Note 30's phrase | In limen (the application) | In udon-lite (the spec) | Plainly |
|---|---|---|---|
| "built-upon" | on `origin/main`, where worktrees are cut from | any row the working outline includes; its readers build on leans | included in this reader's outline |
| "the whole" | the main branch | the rows of the outline | what the outline includes |
| "reaches" | `gathers rule behaviour decision` | `reaches "rows marked landed"` | which rows count |
| "held to", "the whole's terms" | `asks behaviour "pinned" blocks-rest=#true` | `asks "rule" "stands-behind" at-least="lean"` | the outline's list of requirements |
| "answers for" | declared as a root in the ontology | the same | declared, so settledness is computed over it |
| "unsettled" / "at rest" | six `holds-when` lines; an exit code | "7 out of line" | a blocking requirement is unmet, or something relied on has changed / neither is so |
| "how each piece stands" | the `vsect look` screen: pinned by which suite, green at which commit, seen on which build, decided at what weight | two columns, "Stands behind" and "Found out", plus a count of what is open | for each question its kind asks: the latest answer, who or what gave it, and whether it is about the current version |

(The quoted declarations are from each pilot's `v-ontology.kdl`, with runs of alignment spaces collapsed.)

## 2. What comes out of the table

**Most of the phrases are one object.** Six of the seven rows describe the same declaration, which the two pilots wrote almost identically: an outline names a reader, says which rows it includes, and lists what it requires of them, each requirement either blocking or only shown. "Built-upon", "the whole", "reaches", "held to", "answers for" and "at rest" are facets of that one declaration. Stated once, as a declaration with three fields, they would need no vocabulary of their own.

**Your two guesses.** You guessed one phrase might turn out to be "the overall fitness function of the verisectorium", and that "how each piece stands" might be "what settled label it has on its determinant".

- Neither pilot has a fitness function. The nearest thing is one line on one of udon's outlines: `weighs "agrees-with-the-rules" over="everything else"`.
- The second guess is close, but in both stores it is several answers and not one label. limen's largest finding was that most of its pieces need two: who is behind what the piece says, and what shows that the build does it.

**The triple (merits, premises, the whole's terms) is compressed from your own words.** On 11-18 you wrote of an attempt "decoupled from the verisectorium just enough to independently reach any truth whether or not it is already premised in the corpus", a verifier working "within the premises that the author holds", and a third mind settling it "on the verisectorium's terms". Read that way, the three steps differ in what the made thing has to agree with:

1. While being made, it need not agree with the existing work.
2. The checker asks whether it holds given its maker's own assumptions.
3. The third mind makes it agree with the existing work.

Both pilots fit this. In udon a spike is opened as "nothing here is the spec", then an audit re-runs its scripts, then cards are rewritten. In limen it is a worktree, then mutation runs and a read of the diff against what the report claims, then a merge with the full gate. So this one is a real generalization. It was compressed until it stopped saying what it meant.

**The ratio, as a pilot met it.** limen's pilot reported it as effort per fact. It read about 160 KB of top-level documents before the first design segment, and the one design segment that had been rewritten into the present tense took "a fraction of the effort per fact" of the others.

## 3. "Built-upon": where it came from and what it could mean

The phrase first appears on 11-18, in the scratch paragraph written after six invented examples (`msc/scratch/examples-2026-11-18-six-kinds.md`). Every opening paragraph since has carried it word for word: three attempts in note 27, then note 28, then note 30. I found no place where anyone defined it.

Its ancestor is your purpose statement of 11-08, as `core/src/intro-spine.md` has it: pieces "reassembled into coherent results that others read and build on", and "results built on adjudicated results are how discovery and decision proceed". There "build on" is a verb about what readers do with the output. On 11-18 it became an adjective in a numerator, where it has to be a property of a piece. I can see four things it could mean there, and they move independently:

1. **Has dependents.** Other pieces rely on it.
2. **Fit to rely on.** Established well enough that a reader may build on it without checking again.
3. **Placed.** Reflected into the work, as opposed to sitting in a pile.
4. **Accepted for building on.** Someone decided the work will proceed on it.

The first does not belong in a numerator: section 6 of note 30 treats a cheap choice that much rests on as a warning. The third is already the denominator's job. That leaves the second and the fourth.

Core keeps those two apart. `core/def/decision.md` lists "build on the claim" as a decision made in light of evidence, and `core/def/dimension.md` says: "Building on a model of middling credence is a decision about the work, not a finding about the model." If that is what the phrase was reaching for, then "true and built-upon" is your two atoms, found out and decided, compressed into two adjectives. That is my reading; no note says it. Section 1's table gives a third, simpler candidate from the pilots: included in this reader's outline.

## 4. The ratio: four loose places in section 1

These are readings of note 30's text, not checked against the earlier notes.

1. **It is stated two ways.** The opening has "what is true and built-upon" over what a reader has to get through. Section 1 has "what is known to be true by its degree" over the same. Those are different numerators, and neither is explained.
2. **"Truth to noise" is not the ratio described.** What a reader has to get through includes the truth. So what is described is truth over everything, and noise is the remainder.
3. **"Truer comes before shorter" contradicts a ratio.** A ratio says the two trade against each other at some rate. That sentence says they do not: truth wins outright, and length matters only between equally true versions. As I read it, the note has two aims in a fixed order, for a named reader, and "ratio" is a figure of speech for them. I asked you whether the ratio is meant as a real quantity or as two aims in order, and you have not yet said.
4. **The paragraph on calibrated credence may belong inside the numerator.** "Known to be true by its degree" and "calibrated truth with calibrated credence" look like one idea said twice, once as the top of a fraction and once as what a reader is owed. Section 1 presents them as two halves.

## 5. Two smaller points from the same conversation

- **"Every answer is either (a) or (b) … Many piece kinds have both."** The subject shifts from answers to kinds, and nothing says how one piece comes to have several answers. Something like "Each question a kind allows is settled one of two ways … Many kinds ask questions of both sorts" keeps one subject.
- **"Most pieces have one of each."** Section 4 says "nearly every one is asked something of each sort", but in its own table seven of the twelve rows have both columns filled and five have only "is found out".

- **"No amount of computing over the record produces it."** You called it superlative and empty, and I agree: it adds nothing to the sentence before it, "The purpose is decided."
- **"All three answerings."** Section 2 could say what is meant by the three steps directly (section 2 above gives one way), and then "answerings" is not needed.

## 6. Where your edits of that evening leave the rest of note 30 behind

Seen in the uncommitted diff at 20:00 on 11-19. I changed none of these.

- The dated paragraph "Changed after Joseph began reading" says the opening paragraph "is now the lead's wording (attempt 5 in note 27)" and "names no term". It is now your wording, under a new heading.
- The comparison table says "§1, the purpose: Unchanged", and the "third round" paragraph refers to the edit of section 1 that you invited. The italic line that recorded those changes at the top of section 1 is gone, so the trail for section 1 is now only in the commits.
- The index row for note 30 has the old title and older terms ("instrument", "what is waiting comes first").
- "Many piece kinds have both" in the opening is weaker than section 6's "most pieces have one of each". See section 5 above for what the table supports.
- "holds as its core facts about *what was written*" reads as if a word dropped out. There is a double space after a semicolon in section 1's first paragraph.

## 7. The other two pilots, and what they correct above

*Added on 2026-11-20, at your request. I then read every file of the `comproprium` pilot (the collection; a cold agent) and of the `logos-04` pilot (the paper; a fork of note 28's author) and asked whether sections 1 and 2 survive them. Still unread: the first `limen` pilot and the two readings across the pilots. Sections 1 and 2 are left as first written; this section says where they are wrong.*

**What holds.** Both wrote the same declaration again. Each outline names a reader, says what it includes, and lists what it requires by kind, and both mark some requirements as not blocking. The paper's pilot adds a confirming case: an outline whose reader is "not yet decided" is shown as "cannot rest: no reader". So the finding that six phrases are facets of one declaration holds in all four pilots. Two cautions on how much that is worth: two of the four are forks of the session that wrote note 28, and both cold pilots say they had to guess how an outline's asking combines with a kind's.

**Three more fields the declaration needs.** The first two pilots hid these because each had, in effect, one outline of one sort.

- **An order.** The collection orders one outline by the moment a thing should arrive and another by the sequence it clicked in. The paper's pilot found that order is relied on: "the reader has met this" is true in one paper's order and false in another's.
- **A limit on size.** The collection: a new card in the system prompt "has to say which card it displaces or why the budget grew", while its reference outline may grow freely. The paper: "within the venue's length", checked by a word count. The application's smallest outline: "Small on purpose: it has to fit in a mind."
- **Who may see it.** Both have pieces that are in the work and may not appear in a public outline.

**Four corrections to sections 1 and 2.**

1. **"Built-upon" is not "included in this reader's outline".** The paper has pieces the author has attested that are in no paper. Its pilot: "It is not a suggestion." So being stood behind and being included come apart, which is what section 3 above expected and section 1's table then blurred. The collection adds a fifth meaning to section 3's four: used, and it helped. Its pilot wrote: "For practices the numerator is not truth; it is whether they fire and help." It preferred "true and built-upon" to section 1 of the note because the phrase was loose enough to cover that. I take that as evidence for your objection: the phrase fits every store because it does not say which of five things it means.
2. **"The whole" is two things.** In the paper the body of work is the argument and each paper is an outline over it. In the collection the pieces are one store and three outlines draw on it. So there is the pool of pieces, and there is what one outline includes. In the application and the specification the two nearly coincide, which is why section 1 gave one plain meaning.
3. **"How each piece stands" is not the latest answer to each question.** Some questions are never finished and their answers accumulate. A practice in the collection stands as "fired 1 for its deriver … missed 3 of 3 for an inheritor". A claim in the paper stands by how many readers tried to break it and how: "4 readers found the same thing". And one piece can have parts that stand differently: in a quotation the words are captured and the account of the occasion is an agent's. Better: the answers on record for each question its kind asks, each with who or what gave it, by what method, and about which version and which part.
4. **Step 3 of the triple is not "make it agree with the existing work".** In the collection, adding a saying replaces nothing; sayings that restate one another are kept side by side on purpose. What the third mind does there is fit the thing into an outline with a size limit. In the paper it also has to respect order and what may be shown. So step 3 is: make it meet the requirements of the outline it is going into. That is the same declaration once more, so "the whole's terms" is a seventh facet of it. Steps 1 and 2 fit both pilots as written, with one addition the specification's pilot also made: where the content is decided, the author's assent is a further step, and in the paper it is the first thing asked of any claim.

**On your guess about a fitness function.** I wrote that neither pilot had one. The paper's pilot has the same kind of line the specification's did: `weighs "fidelity to sources, and the author's attestation, before polish"`. Both are an order of priority on one outline, not a function. Both pilots that wrote one are forks of the same session, so it is one mind's habit twice. It is still the only form "how determinants weigh" has taken anywhere in the pilots.

**On the ratio.** In three of the four pilots the denominator appears as a size limit declared on one outline, which is a requirement like any other; and where priorities are stated they are stated as an order. Nothing in any pilot computes a ratio. That fits reading section 1 of the note as two aims in order with a limit, per outline. The collection's pilot adds something neither reading covers: for a reader in the middle of acting, what counts is "what is in front of them at the moment of acting", not what they once got through.

**One observation about the stores.** The collection's pilot found that the pieces had not been touched since the two days they were made, while the document drawn from them was edited for weeks: "the root with a real reader and a real third mind stayed alive, and the store of pieces behind it, with neither, did not." That is a reading from file dates and about a ninth of the document, by its own account. If it holds, it bears on the pool-and-outline split in correction 2: a pool that no outline with a reader draws on is not kept up.

## 8. The concrete instances behind each interpretation

*For you to check against what you know of the stores. Every instance below is from a pilot's files, in the pilot's words or counts. I opened none of the four stores myself, so each is the pilot's report of the store, and the pilots say which of their numbers were counted and which read from prose. Quotation marks are around words the pilots quote from the stores.*

### 8.1 The declaration: an outline names a reader, what it includes, and what it requires

**Different readers over the same pieces.**
- *udon-lite.* The people working on lite build on leans; an implementer cannot. The store has a decision that a lean is "enough to act on decisively, as working spec".
- *logos 04.* The anonymous build and the named build are one outline that differs in what it leaves out. The neighbouring logos 03 already builds two assemblies over one set of sections.
- *comproprium.* The system prompt (an agent that will not come back to it), `the-chain.md` (a mind reading once, in order), and the `vera/`, `praxes/`, `exempla/` directories, for which no outline exists.
- *limen.* A builder with one row to land, you in the window, and an auditor arriving cold on a bare brief.

**What an outline includes.**
- *udon-lite.* Of 155 outline rows: 142 proposed, 10 gaps, 3 examples, none landed. Under note 28's wording nothing in the store was held to anything, while `rule:unquoted-run-is-one-value` lists five conflicts with other cards "each to put to Joseph".
- *logos 04.* The manifest's list headed "Held back … the larger/earlier witness paper", and the question whether one circuit of the argument is "paper 4's bridge, or the sibling paper's spine", open in three places when the paper was sent.
- *limen.* `impl/rp1-bursts.md` and `impl/cb1-fence-floor.md` are linked from no PIPELINE row.

**Required, but not blocking.**
- *limen.* 23 of the 46 rows in VERDICTS.md end in some form of "his eyes pending", the oldest from 2026-09-22. DEBTS.md ends with a second list: "Verdicts still owed by Joseph (not debts, listed so they are not lost)".
- *comproprium.* A practice that "is obviously correct and has never fired is `proposed`, and that is the honest and useful label."

**Order.**
- *logos 04.* "Presentation / build order — DECIDED 2026-06-01"; "Filename numbers are LOGICAL IDs, not build order … do NOT renumber". After it, a citation plan was wrong ("the original '§3-first' plan predates the build-order decision"), and a term was used before the section that introduces it.
- *comproprium.* `the-chain.md`: "Atomizing it keeps every conclusion and destroys the derivation." And FORMAT.md: "An empty pair means: this belongs in an onboarding view, not in a system prompt".

**A limit on size.**
- *logos 04.* The anonymous build is 8,333 words against the venue's length.
- *limen.* PIPELINE.md is the required first read; with the other top-level documents it is about 160 KB before the first design segment.

**Who may see it.**
- *logos 04.* The deny-list scan is the only automated gate the store has; some material appears in any paper "only as structure".
- *comproprium.* The drafting record is kept out of git "because this repo is public"; PROVENANCE logs redactions from the stopgap on 2026-08-12.

### 8.2 The five things "built-upon" could mean

| Meaning | An instance |
|---|---|
| has dependents | *udon-lite:* `def:framed` is used by eight rules, is "agent vocabulary", and nobody has ruled on it; two of the eight read it differently. 39 of 40 definitions are provisional while 94 rules use them. |
| fit to rely on | *limen:* P9 (the page owns no colour) is asserted by `web/test-page-colors.js`. Its counter-case: a design sentence the code contradicted for three weeks because nothing asserted it. |
| placed | *comproprium:* 51 harvested segments staged in `INGEST/harvest-a` and `-b` since 2026-07-30/31. *udon-lite:* the value spike, 13.5K lines: "Nothing is decided and no card has changed from this work." |
| accepted for building on | *logos 04:* `[?JW]` and "attest/retire" mark lines waiting on you. *limen:* "Yes on sizing" (IM-2). |
| used, and it helped | *comproprium:* the probe against piping through `head` fired once for the agent that derived it and was missed three times within the hour by the successor that had just transcribed it. *limen:* verdict #15, "Table looks great!" |

Stood behind and included nowhere: in logos 04, the inverse experiment, normative generativity at length, and the self-severing circuit.

### 8.3 "The whole" as a pool of pieces and as one outline

- *logos 04.* The pilot's main finding about the store: the argument is the body of work and a paper is an order over it for one reader.
- *comproprium.* All 57 segment files in `vera/`, `praxes/` and `exempla/` were last modified between 2026-07-30 and 2026-08-01. The stopgap was last modified 2026-08-24. It has 18 interrupt cards where `praxes/` has 10 segments, and contains no `#slug` reference to the corpus. README says "where it and the living corpus disagree, the corpus wins".

### 8.4 "How each piece stands" as the answers on record

**Two answers on one piece, one decided and one found out.**
- *limen.* "`<C-e>`/`<C-y>` are a pure view scroll": a "deliberate deviation" from vim by the D2 session, still on the list of verdicts owed; whether limen does it is shown by `parity/d2.js`.
- *udon-lite.* `rule:nil-spelling`: your own call of 10-09 on the spelling, and a lean of 10-21 on the warning ("null as text should cause a warning, not an error, IMO."), with no cases written.

**By what method, and about which version.**
- *limen.* W1-o stood as "inferred from the code" for five weeks before a gate reproduced it. A Chrome test "had checked the model, not the drawing", and the message area drew 4 px tall in your window (verdict #33). On 2026-09-21 an audit found "the suites had been running against the cached binary from 2026-08-29".
- *logos 04.* A gloss of Ricoeur dropped "in some sense". An example attributed to Belshaw was not found in Belshaw 2012.

**Answers that accumulate.**
- *logos 04.* "a four-reader convergent flag" on "it is the only warrant anyone has ever had".
- *comproprium.* The typed ladder fired / fired-once / proposed cannot tell the deriver from an inheritor, and the corpus says the two "are different events".

**Parts of one piece that stand differently.**
- *comproprium.* A harvester's two verifiers passed its quotation segments twice while both real defects were in the fields an agent had written: "independence of *method* does not give you independence of *scope*."

**The written-in status that this replaces.**
- *udon-lite.* `awaiting-second` is true on all 225 records.
- *logos 04.* The manifest's Stage column says "outline" for the fusion section, drafted by 2026-06-01 and submitted on 2026-06-02.
- *limen.* PIPELINE's State reads `specified` for D4, whose three steps landed in September.

### 8.5 The three steps

**Made without having to agree with the existing work.**
- *limen.* The EC-0 spike of 2026-10-08 refuted the design it was opened beside: the design said nvim's `'autoread'` would notice changes and that the apply could run inside the autocmd.
- *logos 04.* `scratch/flow-04-the-fusion.md`, five attempts, mined for lines afterwards.

**Checked on its maker's own assumptions.**
- *udon-lite.* Two audits re-ran the value spikes' scripts.
- *limen.* The D4 verifier, on a bare brief: "the headline survives … the characterization was too clean".

**Made to meet the requirements of where it is going.**
- *limen.* At the EC merge the coordinator found that `engine.rs` masked every line equal to `=======`: "caught by the coordinator at merge". After an audit found "the proposal's superseded text still under amendments that contradicted it", `external-changes.md` was rewritten to say what is built. Two sentences still say a finding "is DEBTS RP-1", 42 days after RP-1 landed.
- *comproprium.* Nobody has done it: the two harvests have sat for 111 days.

**The further step where the content is decided.**
- *udon-lite.* The handoff of 10-29: "Turned a clarification (`<…>`) and a request to change my recommendation (`null`) into card edits marked decided. Both reverted." And the first ADJUDICATION-GUIDE "opened with the spikes' internal terms".
- *limen.* "a choice made for Joseph on his evident intent, not his ruling".
- *comproprium.* "Ruled `exempla` by Joseph, 2026-07-30": the quoted words are not in the staged primaries. And `feedback.md` on the 5–15-line brief: "an agent invented a quota".

### 8.6 Priorities and the ratio

- *udon-lite.* `CTQ-FACTORS.md` carries weights on the aims, and scores a branch's "impact radius" by each card's `strength` (forced > decided > lean > provisional).
- *limen.* Lines marked as amendments: `cli.md` ten, `structure-engine.md` and `formats-and-plugins.md` nine each, `page-architecture.md` eight. `typography.md` reasons toward a 66-character measure and ends by saying it is now 120 columns.
- *logos 04.* On 2026-06-01 everything that was not prose was moved out of each section into a sidecar: "the in-band apparatus had outgrown the prose". About 7,700 words of body against some 1,200 lines of sidecar and 3,400 of scratch.
- *comproprium.* "Every failure this day produced was by a mind that already held the correct principle — in its own words, in its own context, minutes earlier."

## 9. "Piece"

*Read whole for this: `core/def/segment.md` and `core/def/veritoid.md`. Not read: where note 28 or 27 first wrote "right or wrong on its own".*

In note 30 "piece" is the plain word for what core calls a «segment». Core says a segment is one of two things:

- a **veritoid**: content with nothing inside it, "the smallest thing a question is asked of". A formal statement, one step of a derivation, a paragraph of explanation, a question, a chunk cut from a source.
- an **assembly**: slots, each filled by a segment it holds or by a pointer to one that lives elsewhere. A document-like segment is an assembly of veritoids. An outline is an assembly whose slots mostly point.

So it recurses (step, result, chapter, volume), and a file is a rendering of a segment and never the segment.

Note 30 says "pieces, each small enough to be right or wrong on its own, gathered into larger pieces to any depth", and then uses the word at all three scales without saying which. Two things were lost:

1. **The defining property is one core had replaced.** Core lists "unit of fate" among the words to avoid for a veritoid: "how a piece fails is one dimension among several; what makes it one piece is that questions attach to it." Note 30's "right or wrong on its own" is the fate criterion. It also fits only the leaf: an outline is a piece and is not right or wrong in that sense.

   Your correction to this (2026-11-20, after reading it): "'unit of fate' is too ambiguous already to begin with. It was useful when identifying an accidental composition that wasn't broken into veritoids (two or more parts can be falsified / 'fated' independent of the others ==> not fully broken into the smallest 'kinds' yet). It does not do a good job in core, where the concept ends up too ambiguous and too restrictive at the same time." So it is a test for a piece that has not been cut far enough, and not a definition of a piece. Core's own discussion says nearly that ("'One fate' is a quality target … a check that narrows part of it is the evidence that it wants splitting"), and note 30 took the test for the definition.
2. **Slots inside a document.** In note 30 "slot" appears only for outlines. In core every assembly has slots, including a single result (its claim, its derivation, its explanation).

Three of the pilots' complaints look to me like rediscoveries of what core already has:

- *comproprium:* "one file here is four or five pieces" (the words, the date, the occasion, an agent's reading, the cue), each with its own author. In core that is an assembly with five slots.
- *logos 04:* cutting to the sentence "makes the piece the wrong size to write". Core: small segments cost a reader nothing, because the file is only a rendering.
- *udon-lite:* a fixture file is one record and its cases are the units.

One complaint core does not answer: limen's source files, which are relied on and are not pieces at all. That is the next section.

## 10. Things relied on that are outside

*Read whole for this: `core/def/reference.md`, and `core/def/dimension.md` from its definition to the end. Not read: notes 22 to 28 on this subject, or the address-theory repository.*

**Where it stands: not settled, and said three ways.**

*Core* has two routes to an outside thing and has finished neither.
- A «reference» goes from a segment to a segment only. Whether a reference's "target may be outside the verisectorium" is listed in its working notes as one of the properties a reference kind should be named by.
- A dimension's `against` is the other route: what a piece is compared with (logic, "a simulator at a version", "the cited work, named by reference"). A check reads whatever fills it, so a change there lapses the check.
- Your words of 2026-11-09 are in «dimension»'s working notes: influx as a mixing layer between two flows, each outside anchor with its own velocity, "ideally something slower than the v's, or all you can hope for is a snapshot"; and the two questions kept apart, "how long can we afford having something stale if it is stale" against "what is the likelihood of this being stale by this time". Beside them is a candidate marked untested: an inside veritoid that pins the outside thing, "this source at this version, last looked at then".

*Note 30* has three sentences: things relied on that are not pieces "are held outside the pieces, have versions of their own where they have any, and are asked nothing." It lists the unversioned case under "Not sure of".

*The pilots* each built a different shape.
- *limen:* a `subject` block for the code and the build identity, and an `outside` block (nvim, node, comrak 0.54.0, your nvim config, `~/src/nightfox.nvim`), fingerprinted at each gate run.
- *logos 04:* a book is a piece of its own kind, recorded with how far it was read (the store types "[abstract + citing gloss only — body unread]" after a reference by hand). A separate `leans-on` tie goes to a result "held in another verisectorium", in review.
- *udon-lite:* `neighbour` declarations for the SOP and for address theory, with links written `[[sop/conv:row-type]]`.
- *comproprium:* a source is its content hash, and "located, source since gone" is a state a quotation can be in.

**What I think is being lumped** (my sorting; no note makes it). At least four different things:

1. **Material brought in and cut**: a transcript, an audit. It ends up inside, as chunks.
2. **A versioned thing a piece is about that is never brought in**: a build, a toolchain, a simulator, a book at an edition.
3. **A piece in another verisectorium**, which has a recorded standing of its own there.
4. **The world**, with no version to name: your half-life case.

They differ in what can be known: whether there is a version to name, and whether anything else records how well the thing stands.

**"Are asked nothing" is wrong.** Your comment on it: "a perfect example of where the ethereal phrase … ends up not only meaning nothing particularly concrete, but where it ends up being concretely wrong under almost any useful definition". The logos pilot records how far each book was read. Your 11-09 note says how likely a source is to have moved is found out, about the source.

**What it would be as data** (my sketch, from your phrase "meta-data + expected obsolescence curve"; untested):

```
locator            where the thing is: a path, a URL, a citation, a build id
version            a content hash or an edition, if it has one
last_checked       when, by whom or by what program, by what method
obsolescence       the expected rate of change of the source     (found out, about the source)
max_staleness      how long this use can tolerate being stale    (decided, per use)
```

The last two are your two questions. With them, whether a reference is due to be checked again is a computation. For kind 2 a change of `version` is detected outright. For kind 4 there is no `version` and the last two fields do all the work. For kind 3 the record could also carry the standing the other verisectorium reported when it was last checked. The pin candidate in core is this record held as a veritoid inside.

## 11. The personifying verbs, as data

Your complaint, as you put it: "personifying a reference instead of saying 'meta-data + expected obselescence curve' just has us drifting further and further from actual underlying principles". The habit is not only note 30's. Core's «dimension» is defined as "one question asked of a piece", and all four pilot ontologies use `asks` as a keyword. Underneath, core's version is concrete: a dimension is declared with six parts (what it measures, of which kinds, against what, found out or decided, produced by what, how it is read). But the verb brings a family with it, and note 30 has most of the family.

The right-hand column is my translation. No note says it, and each row is a best guess.

| As written | As data |
|---|---|
| a kind "says what can be asked of it" | a kind declares typed fields |
| each thing a kind lets be asked is a "dimension" | one declared field, with the six parts above |
| an "answer", "found out" or "decided" | a field's value, with a type tag saying which of two record shapes backs it: evidence records, or a decision record |
| an outline "asks" of what it reaches | an outline declares which fields are required for the rows it includes, each blocking or not |
| an outline the verisectorium "answers for" | an outline declared in the ontology, so that settledness is computed over it |
| a piece is "held to" what the outlines ask | the set of requirements that apply to it |
| a decision "stands by whoever is behind it" | a decision record has an author field and a how-decided field |
| "in whose words" | a decision record has a pointer to a located quotation |
| "how each piece stands" | the records on file for each of its fields: who or what, by what method, about which version and which part |
| "puts a question to the piece" | opens an item keyed to the piece's id and not to a version, so that a rewrite does not close it |
| what a reader is "owed" | fields the outline must show for each row |
| "knowingly left" | a waiver record: what, why, by whom, when to look again |
| "unsettled" | a blocking requirement has no current value, or a recorded dependency's target has changed since it was last checked |
| outside things "are asked nothing" | wrong; see section 10's record |

## 12. The same things in database terms

You, on 2026-11-20: "I don't mind that we're revisiting database theory in terms of epistemology-- I do mind that what has emerged sounds like a third thing altogether". This is the mapping as I see it. Every row is my guess, the right-hand column is loose where it says so, and I have checked none of it against the address-theory repository or against note 13 (which has an Ash/Rowan lead I have not read).

| In the notes | In database terms |
|---|---|
| a kind | a table's schema |
| a veritoid | one row, in a table cut to normal form |
| the "one fate" test | a normalization test: if two parts of a row can be shown wrong independently, the row holds two facts and should be split. (Loose: normal forms are defined by functional dependencies, and this test is by independent falsification.) |
| a dimension | a column, declared with its type and with what may write it |
| an assembly's slots; holding and pointing | composition and foreign keys |
| a reference with the version it last saw | a foreign key that also stores the target's version when it was last read, so that staleness is a comparison |
| an outline | a view over the tables, with an order |
| what was written, at versions that never change | immutable, content-addressed rows |
| what was done (the acta) | an append-only event log |
| "computed in place of asserted" | a derived value or a view over the log, in place of a stored column someone updates |
| a status written into a piece | a denormalized stored copy of a derived value, which goes stale |
| "unsettled" | an integrity constraint is violated |
| a resting state | a consistent snapshot |
| a changeset; "off to the side" | a transaction; a branch |
| an outline's requirements, blocking or not | constraints declared per view, some enforced and some only reported |

What the epistemology adds to that, as far as I can see, is three things and no more:

1. **Every value carries its provenance**: who or what produced it, by what method, about which version, relying on what.
2. **Values come in two types** by what backs them: evidence, or a decision by someone with authority to make it.
3. **Constraints differ per reader**, and a reference to something outside carries an expected rate of going stale.

I first ended this section by saying that the model therefore *is* a provenance-carrying, event-sourced database with per-view constraints. That claimed too much, and you corrected it: the database reading is "a useful perspective on verisectorium (especially to help avoid generative clutter) but not as an attempt at defining verisectorium, which … has as much to do with the limits of individual reader's attention and minds and the difference between the sources, integration efforts, corpus, and outputs -- as a dynamical system -- all tied to the epistemology with ergonomics becoming first-class concerns accordingly".

So this table is one reading among several you named as each acceptable for its audience: conventions and tooling; a document store; a schema and a document flow; an epistemology. What it is good for is checking whether a coined phrase names something new or re-names a row above.

What the table leaves out is what you list. It describes what is stored and what must hold. It says nothing about rates: how fast sources arrive, how fast they are integrated, how much sits between, and how much one reader can take in. The pilots' most concrete findings were all of that sort and none is a schema fact: 51 harvested segments staged for 111 days in comproprium, 23 looks waiting on you in limen with the oldest 58 days old, a 13.5K-line spike in udon-lite from which no card had changed.

## 13. Which of note 30's words have been kicked, and which have not

*Added 2026-11-21. You said that evening that kicking every under-defined term and looking for unasked questions "feels like a very, very worthy use of effort and time right now", and that your unease about a model settling early is usually a sense of "unasked questions hiding in the work". Every word kicked so far has had one. This section says where the kicking has reached and where it has not, so the next kick can be chosen. The right-hand judgments are mine.*

**Kicked, with what was under it** (and where).

| Word or phrase | What was under it | Where |
|---|---|---|
| root | two different graphs | note 30, dated paragraph of 11-19 |
| act; instrument; typed; telling; waiting | each was covering two things | note 30, dated paragraphs of 11-19 |
| asserted | three cases; the fault is detachment from the record | note 30 §8 |
| built-upon | five possible meanings | sections 3 and 7 here |
| the whole; reaches; held to; answers for; at rest; the whole's terms | one declaration, with seven facets | sections 1 and 7 here |
| how each piece stands | answers that accumulate; parts that stand differently | section 7 here |
| the ratio | a quantity, or two aims in order: not yet answered | section 4 here |
| piece | a test for cutting taken as a definition; slots inside a document lost | section 9 here |
| are asked nothing | wrong; four kinds of outside thing | section 10 here |
| by what method; about exactly what | found by the agents' footnotes to be what a list of sources read cannot replace | the working file, 3f |

**Not yet kicked, where I would expect something.** For each: what note 30 says, an instance from a pilot, and the question I think is hiding. In the order I would take them.

1. **"A specific reader (an individual, not an abstraction)"** (section 1). Every reader the four pilots named is a role, a task or a moment: "someone implementing a parser, who has read nothing else"; "a mind doing the round-up for a session about to start"; "an agent on a named substrate, at its first token"; "a referee… reading once, in order". None is an individual. And one of the research reports found that what a reader gets from a text depends on the task as much as on the reader. *Is a reader a person, a role, a task or a moment, and which of those does an outline name?*
2. **"Something other than its maker"** (section 2). The collection's pilot: "the checker was written by the maker of these pieces, in the same session." Your account of 11-09: a compaction is "one agent finishing and a new distinct (often somewhat confused and deceived) agent just starting". A fork starts with everything its parent read. *Other in what respect: what it has read, what it was told, or what model it runs on? Does the same session after a compaction count?* What can be recorded is a key for the actor, whether it was forked from another, and what it read; "other" would then be computed from those and not asserted.
3. **"Where the stakes ask for it"** and **"how cheaply the reflecting can be undone"** (section 2). Both decide how much checking a thing gets and in what order, and neither is recorded or computed anywhere in the note. Note 30 took the word "importance" out and still leans on it here under another name. *Where do the stakes of a change live before the change is made?*
4. **"A question is about the piece and not a version"** (section 7). That needs a piece to stay the same piece through a rewrite. The application's pilot replaced one design document whole. The collection's says "a different occasion is a different saying." Core answers this (an identity minted at creation; a split retires it and names its descendants). Note 30 does not, and its one chosen rule depends on it. *What makes it the same piece afterwards?*
5. **"Open at the edge"** (section 8). The note puts two things there: "questions about whether more could be said", and "the answers the outline wants and does not wait for". The application pilot's screen has five under that heading: looks owed by you, questions for you, choices made on your behalf, first guesses, and rows only proposed. Some of those are where the work could go next. Others are debts that do not block. *Are these one list?* The first kind is the only place in the note where moving the work forward appears at all.
6. **"How much would move if a given piece did"** (section 8). The application pilot's three answers to it were "change it in passing", "his to confirm, yours to try another way", and "not a thing to change in passing". *Does "move" mean has to be checked again, decided again, or rewritten?* The three cost very different amounts.
7. **"Found out or decided"** (section 6). I have not kicked this at all, because it is your spine. The collection's pilot wanted a third (witnessed) and folded it back. The ASF report maps the two onto what an agent believes and what it aims at. *Is "decided" one thing: a choice about what the work says, a choice about what to do with a piece, and the purpose itself?*
8. **"Each piece at each of its versions"** (section 7). *A version of what: a sentence, a section, a file? Is a reflowed paragraph a new version?* Core says a version is a hash of content normalized as its kind declares.
9. **"Material keeps the standing its source gave it"** (section 9). *What standing does a source give?* An audit by an unknown reader, your own message and a published paper differ.
10. **"The locus of action"** (section 1, your words). One research agent asked what "acting well" means for an arriving mind here: auditing, attempting something new, or integrating. *Is there one locus, or one per kind of work?*
11. **"Since you last looked"** (section 3). *Who is "you" for a mind that did not exist last time?*

**On questions themselves, with your correction.** `msc/notes/16-2026-11-06-unasked-questions.md` records eleven questions a session gave you on 11-06 when you asked what was not being asked. Three of them are on topics I raised on 11-21 believing they were new (your attention as the scarcest thing; whether a store answers to anything outside itself; whether the surface is shrinking), and I first wrote here that they had been "asked and lost". You answered: "I was very unsatisfied with those 'unasked questions', btw--- you've surfaced far more valuable ones tonight." So an overlap of topic is not the same question, and I had counted it as one.

What I think the difference is (my reading). The eleven of 11-06 were produced by asking a session to look for its own blind spots, and its answer opens by saying it cannot see them. They are the questions any careful mind would list. The ones from 11-21 were not found by asking what was missing. Each came from something outside the statement pushing on it: a term pushed down to an instance, a store that did not fit, a field that had lived with the problem, your own theory, a quotation that had to be found. That suggests how to act on your unease: it is less useful to ask "what are we not asking" than to ask what has not yet had the chance to push back.

A question raised without an instance or a ground also seems not to last. Two of the eleven (what agents will do to empty the list of unsettled things; what can be shown to a skeptical outsider) are not in note 30 at all. An agent is going through the notes and core to see what has been asked and what became of it, and I will use that as a map for myself and not hand you a census.

## 14. Other phrases I would look at and have not worked through

"On its own merits" and "on its own premises" are covered above. Not yet examined in the same way: "stands by" (in section 6's table), "standing" in its several uses, "open at the edge", and "knowingly left". I list them only as places to look.
