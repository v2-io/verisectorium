# Addendum to note 30: what its general phrases turned into in two pilots

*To Joseph, for reading beside note 30 as you go through it. Written late on 2026-11-19 by a Fable 5.2 session (`dcfebd69`) that arrived cold that evening. You had said that several phrases in note 30 are "pseudo-generalizations that aren't actually generalizations and are mostly semantic punts", and asked me to inhabit a pilot's concrete application and get its read on them. This is that, followed by two earlier observations from the same conversation (on "built-upon" and on the ratio). Nothing here has been integrated into note 30, and nothing was built or run.*

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

*Added later the same night, at your request. I then read every file of the `comproprium` pilot (the collection; a cold agent) and of the `logos-04` pilot (the paper; a fork of note 28's author) and asked whether sections 1 and 2 survive them. Still unread: the first `limen` pilot and the two readings across the pilots. Sections 1 and 2 are left as first written; this section says where they are wrong.*

**What holds.** Both wrote the same declaration again. Each outline names a reader, says what it includes, and lists what it requires by kind, and both mark some requirements as not blocking. The paper's pilot adds a confirming case: an outline whose reader is "not yet decided" is shown as "cannot rest: no reader". So the finding that six phrases are facets of one declaration holds in all four pilots. Two cautions on how much that is worth: two of the four are forks of the session that wrote note 28, and both cold pilots say they had to guess how an outline's asking combines with a kind's.

**Three more fields the declaration needs.** The first two pilots hid these because each had, in effect, one outline of one sort.

- **An order.** The collection orders one outline by the moment a thing should arrive and another by the sequence it clicked in. The paper's pilot found that order is relied on: "the reader has met this" is true in one paper's order and false in another's.
- **A limit on size.** The collection: a new card in the system prompt "has to say which card it displaces or why the budget grew", while its reference outline may grow freely. The paper: "within the venue's length", checked by a word count. The application's smallest outline: "Small on purpose: it has to fit in a mind."
- **Who may see it.** Both have pieces that are in the work and may not appear in a public outline.

**Four corrections to sections 1 and 2.**

1. **"Built-upon" is not "included in this reader's outline".** The paper has pieces the author has attested that are in no paper. Its pilot: "It is not a suggestion." So being stood behind and being included come apart, which is what section 3 above expected and section 1's table then blurred. The collection adds a fifth meaning to section 3's four: used, and it helped. Its pilot wrote that "for practices the numerator is not truth; it is whether they fire and help", and preferred "true and built-upon" to section 1 of the note because the phrase was loose enough to cover that. I take that as evidence for your objection: the phrase fits every store because it does not say which of five things it means.
2. **"The whole" is two things.** In the paper the body of work is the argument and each paper is an outline over it. In the collection the pieces are one store and three outlines draw on it. So there is the pool of pieces, and there is what one outline includes. In the application and the specification the two nearly coincide, which is why section 1 gave one plain meaning.
3. **"How each piece stands" is not the latest answer to each question.** Some questions are never finished and their answers accumulate. A practice in the collection stands as "fired 1 for its deriver … missed 3 of 3 for an inheritor". A claim in the paper stands by how many readers tried to break it and how: "4 readers found the same thing". And one piece can have parts that stand differently: in a quotation the words are captured and the account of the occasion is an agent's. Better: the answers on record for each question its kind asks, each with who or what gave it, by what method, and about which version and which part.
4. **Step 3 of the triple is not "make it agree with the existing work".** In the collection, adding a saying replaces nothing; sayings that restate one another are kept side by side on purpose. What the third mind does there is fit the thing into an outline with a size limit. In the paper it also has to respect order and what may be shown. So step 3 is: make it meet the requirements of the outline it is going into. That is the same declaration once more, so "the whole's terms" is a seventh facet of it. Steps 1 and 2 fit both pilots as written, with one addition the specification's pilot also made: where the content is decided, the author's assent is a further step, and in the paper it is the first thing asked of any claim.

**On your guess about a fitness function.** I wrote that neither pilot had one. The paper's pilot has the same kind of line the specification's did: `weighs "fidelity to sources, and the author's attestation, before polish"`. Both are an order of priority on one outline, not a function. Both pilots that wrote one are forks of the same session, so it is one mind's habit twice. It is still the only form "how determinants weigh" has taken anywhere in the pilots.

**On the ratio.** In three of the four pilots the denominator appears as a size limit declared on one outline, which is a requirement like any other; and where priorities are stated they are stated as an order. Nothing in any pilot computes a ratio. That fits reading section 1 of the note as two aims in order with a limit, per outline. The collection's pilot adds something neither reading covers: for a reader in the middle of acting, what counts is "what is in front of them at the moment of acting", not what they once got through.

**One observation about the stores.** The collection's pilot found that the pieces had not been touched since the two days they were made, while the document drawn from them was edited for weeks: "the root with a real reader and a real third mind stayed alive, and the store of pieces behind it, with neither, did not." That is a reading from file dates and about a ninth of the document, by its own account. If it holds, it bears on the pool-and-outline split in correction 2: a pool that no outline with a reader draws on is not kept up.

## 8. Other phrases I would look at and have not worked through

"On its own merits" and "on its own premises" are covered above. Not yet examined in the same way: "stands by" (in section 6's table), "standing" in its several uses, "open at the edge", and "knowingly left". I list them only as places to look.
