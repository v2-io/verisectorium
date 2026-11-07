# The v2 model and its words, as I currently hold them

*To Joseph, from the Fable session that took over on 2026-11-05. You asked for this so that we can check we are holding the same model before you comment on details. It is my synthesis, not a settled design. Nothing here is ratified.*

*It is written to be read top to bottom. Each word is introduced before it is used, or carries a pointer to where it is. Part 8 is the lexicon, with what each word replaces and what it must not be taken to mean. Part 9 lists the places where I chose and you may want to choose differently, and then the things I know are open. A short note at the very end says what changed since the version you began reading on the evening of 11-05.*

*Where each idea comes from is marked:*
- ***[J]** yours, from the dialog of 2026-11-05 or your messages of 10-30 to 11-05;*
- ***[RC1]** carried from the August model, which I read whole today;*
- ***[PLAN]** from councils-46's plan, or the scratch file before it;*
- ***[F]** my proposal, which you have not seen argued and should treat as the least tested.*

*What I read to write this: the scratch file, PLAN, Appendix A, the feedback report, the dialog, the building-blocks model, RC1 whole except its Python interpreter, three ASF segments whole, the ASF volume 1 outline in part, and your own messages from 10-30 to today in the asf, councils and aat-v3 sessions. What I did not read is listed near the end. Later that evening a fresh Opus 5.5 agent read this document cold and checked about forty of its attributions against the sources. Its findings held up wherever I checked them, and I have worked them in. Its read is beside this file as `model-and-lexicon-denovo-1.md`.*

---

## Part 1. What this is a model of

A **verisectorium** is a body of written work that is never finished, is worked on by many minds who each arrive knowing nothing about it, and in which every piece says honestly how well it is supported. A **store** is one verisectorium's contents as the engine holds them. **v2** is the engine. AAT is to be the first store.

Your picture of the flow [J, 11-03]:

```
external influx ─┐
                 ├─▶ theory ─────────▶ models & theory ─▶ mental models / projections /
internal influx ─┘   (working,          (canon)            pedagogy / implications
(spikes, audits,      provisional)
 experiments)
```

(In that picture you used "projections" for what is produced for readers. Below, 2.6 uses the word in the sense you confirmed on 11-05, and 2.8 calls produced text a rendering.)

Three things the October sprint showed that this model has to make impossible or at least visible (the first two in your words of 10-30 and 11-02; the third is the feedback report's measurement):

1. Nobody could see which influx had been looked at, by whom, or how far. The sprint could not tell "found everything" from "found something".
2. Checks and fixes fed each other. Almost half of the claims "fixed" had only been written earlier in the same sprint.
3. No source was ever retired. Every pass left more surface than it removed.

And one rule you stated in capitals [J, 11-04]: nobody edits the store by hand. Every change goes through v2. Where v2 cannot express a change, that is how we learn what v2 lacks.

---

## Part 2. The structure: what exists in a store

One example runs through this part and Part 4. It is the one you used in the dialog: a derived result with a formal claim, a description, and an "explain it to an eight-year-old" paragraph.

### 2.1 Content, kinds, and the veritoid

The store holds pieces of **content**: a formal statement, a paragraph of explanation, a proof step, a figure caption, a question, a note from an auditor.

Every piece of content is of a **kind**. A kind is declared in the store's **definition**, which for now is written by hand. A kind says what form the content takes and which questions can be asked about content of that kind. Those questions are the subject of 2.2.

> **Veritoid.** A piece of content of a declared kind, together with its values on that kind's dimensions. [J: "content with one or more dimensions + rules". The word is the one you offered, half in jest. It carries no history, which is why I am using it.]

In today's ASF files a veritoid is usually a `##` section, or something smaller inside one.

### 2.2 Dimensions, values, certainty

A **dimension** is one question that can be asked about a veritoid and answered independently of the other questions. [RC1; your word since August.] Examples: Is it true by derivation? Has it been measured? Who stands behind this choice? Is it faithful to its source? Is it still current? Does a reader come away understanding it?

Two things that can move independently never share a dimension. RC1's test for a mistake here is good and I keep it: if a scale's values look like `ruled-but-groundless`, `consulted-and-grounded`, it is two dimensions jammed into one. [RC1]

Each dimension has a **scale**: the values it can take. A scale is a **ladder** (ordered rungs, such as sketch, drafted, premises checked, independently re-derived), or an unordered set, or a number.

A veritoid's **value** on a dimension is never typed in by hand. It is computed from what has been recorded as done (Part 3). [RC1; the oldest rule in all of this.]

**Every value comes with how sure we are of it, and the two are held separately** [J, 11-04]. "Novelty: high" is one thing. "How sure are we that it is high" is another, written beside it and never folded into it. PLAN sorted values into three forms, which differ in what "how sure" means for each:

| Form | The value | How sure |
|---|---|---|
| **position** | what has actually been done to this content: "independently re-derived, against this exact text" | it is a fact about the record; either the acts are there or they are not |
| **credence** | for a truth claim: the claim, and the probability that it is true, computed from the evidence | the probability itself, e.g. 0.93 |
| **judged value** | where something sits on a scale that only judgment can read: "novelty: high" | a spread over the scale: probably high, possibly medium |

None of the three is ever inferred from another. A high position does not make a high credence by itself. [PLAN, extending RC1's rule that no dimension stands in for another.]

Your sort of dimensions by **what builds and sustains them** [J, 11-04] is the one I use, because it tells you what work moves each:

- **evidenced**: a truth claim. Built by accumulating evidence.
- **decided**: a choice at a branch point. Built by grounds, consultation, and someone accountable.
- **attested**: asserted and checkable, but we do not keep a chain of evidence for it (who wrote this, when). This is the floor: the chain of "and what supports that?" stops here, as you said it must.
- many are a mix. Importance is one: it is always importance **for** something, and it combines what rests on this (computed) with how much that something matters (decided).

An **attribute** is different from a dimension [J, 11-04]. It is a plain measurement with no judgment in it: word count, age, how recently changed, how many things point here. Rules can turn attributes into dimension values ("stale when age over recency exceeds X"). When a rule fires, that is recorded like anything else, at a definite moment.

**Two things an author states about a veritoid, beside its content.**

- Its **ground**: can this be proved, simulated, measured in the wild, checked as an instance of a known model, or only witnessed? The ground decides which evidence dimensions are open for it. A dimension that is not open is a recorded fact ("this was never meant to be measured"), not a gap. [RC1. I think this is RC1's best statement of your "what builds it", and PLAN dropped it.]
- Its **claimed level**: what the content asserts about its own support. "Theorem." "Exact under these premises." "Conditional." "Hypothesis." This is written, like the content, and is not a value. The store's work is to compare it with what has been earned. A veritoid that claims more than its computed values allow is an inconsistency to be worked off (Part 4). **Softening** a claim means lowering its claimed level or narrowing what it says. [PLAN and the scratch file had this as "what it claims" beside "what its trail has established". Your "can this … be a theorem anymore?" needs it. My first draft lost it, and the reviewer caught that. Where exactly it lives is open: Part 9.]

### 2.3 Segments: veritoids are assembled, and the assembly is a thing

A veritoid almost never makes sense alone. You said so, and you said the fates of the veritoids in a group are intertwined, usually so that if a core one fails the others may go down with it [J, 11-05].

> **Segment.** A named, ordered assembly of veritoids, filling the slots its kind declares, with some values of its own. It is the unit that has a name, that is written as one whole (Part 4), and that is reviewed as a whole. [J: your "template instance". "Segment" is your everyday word for it.]

Segments have kinds too. A **segment kind** declares its **slots**: which kind of veritoid goes in each, whether the slot is required, and how many it holds (one, at most one, any number). [J: several in a specific order, some required, some optional.]

```
segment kind  derived-result
  slots, in order:
    formal-claim   one         veritoid kind: claim
    derivation     any number  veritoid kind: proof-step
    description    one         veritoid kind: explanation
    eli8           at most 1   veritoid kind: explanation
```

Veritoid kinds are shared across segment kinds where that fits (an explanation is an explanation wherever it sits), and some belong to one segment kind only [J].

**A slot can hold several veritoids.** The steps of a derivation are separate veritoids that build on one another, in one slot [J, 11-05]. ASF's lettered items (a) to (h′) under one statement are the same. When a check shows that what was written as one veritoid has pieces that stand or fall separately, it is **split** into several in the same slot, and from then on each carries its own values.

**How a segment gets its own values.** A segment kind declares this for each of the segment's dimensions, in one of three ways. [J: "often via aliasing a dimension to a specific dimension of one specific atom within the template/instance, plus derived and plus its own that apply to the whole". The three names and the examples are councils-46's.]

- **aliased**: the segment's value is one named veritoid's value. "This result's truth is its formal claim's truth."
- **derived**: computed from several. "This result is as fresh as its stalest veritoid."
- **own**: asked of the whole and of no single veritoid. "Does this hold together when read as one thing?" That is **coherence**. Teachability is another.

RC1 had a question for this (at what depth does state attach, and what is the rule for carrying it upward) and never answered it. Your three ways answer it for a segment and its veritoids. How it carries further up, through chapters and parts, is in 2.6.

**Veritoids depend on each other inside the segment.** The eli8 rests on the description, which rests on the formal claim [J]. A segment kind declares these **inner dependencies** between its slots. They are why the whole segment has to be looked at together when one veritoid in it moves.

*On depth.* There are two levels of content, and only two: veritoids, and the segments they are assembled into. You observed that the decomposition is "turtles all the way down" as mathematics, with a practical granularity as a matter of practice [J, 11-05]. I hold it the same way. Any veritoid could in principle be taken apart further, and two levels is where practice stops. (Segments themselves are then gathered into chapters and parts, to any depth. That is 2.6, and it is gathering, not content inside content.)

*Mapping to the dialog's words:* "atom" is veritoid; "atom kind" is veritoid kind; "template" is segment kind; "instance" is segment.

### 2.4 Names, and how the structure is recut

A segment has a **name**. A name is a label the store maintains. It can change; old names keep working; a rename is recorded. You said plainly that slugs need not stay stable and a mapping is enough [J, 11-04]. A name that no longer reaches anything, or two things under one name, are failures the store must surface, never assume away. [RC1]

A veritoid is reached through its segment. A rendering might show `persistence-threshold#formal-claim` or `persistence-threshold#derivation[4]`.

**What I do not know: whether a veritoid has an identity of its own.** The dialog left this open (councils-46's question: is an atom's identity derived from its place, or minted?) and you did not answer it. It matters as soon as the structure is recut:

- **Split**: one veritoid becomes several in its slot. Which of them do existing pointers now reach?
- **Merge**: two veritoids turn out to be one claim said twice, and become one.
- **Promote**: one or more veritoids are moved out into a segment of their own, with its own name. This is how I read "ASF's segments … legitimately mixing independent claims that should be able to have their own name and their own segment space" [J, 11-05].
- **Fold back**: the reverse of promote.
- **Retire**: a veritoid or segment leaves present truth. A refuted result is replaced by what is now true (the no-go, the narrower statement), or is removed with its name left resolving to what answers in its place.

The requirement is clear: none of these may silently break or silently redirect anything that points in. If addresses are positions, a split shifts every later position and pointers land on the wrong step. So either veritoids carry an identity that survives being moved, or every recut must rewrite or flag every pointer it touches. I have not chosen. This is the address theory's subject and I have not read it. [F for the list of five; the first version of this document claimed split and promote "disturb nothing", which was not earned.]

**When the meaning of a named thing changes.** Two defaults are possible, and both are honest:

- *The name stays with the thing* [RC1]. Content is replaced; identity persists; everything that pointed at it still points at it, and every such pointer is flagged for a second look because its target moved (Part 4).
- *A changed meaning gets a new identifier* [PLAN, from ontology practice]. The old one is marked superseded by the new. Pointers stay on the old meaning until someone moves them. This rule exists because under the first default a pointer can end up on a claim its author never saw.

I lean to the first, because you described softening as a change to the thing in place, and because under the first the store does the flagging by default while under the second a person has to notice. But the second's worry is real, and the first is only safe if "flagged because its target moved" can never be skipped.

### 2.5 References: how veritoids rest on each other

A veritoid points at other veritoids. You described the main case as "an array dimension from a 'claim' atom to those other instance's claim atoms" [J, 11-05].

A pointer is written by an author, like content and unlike a value: someone declared it, on a date, and it can be wrong. What the store computes about a pointer is whether it still holds: does its target exist, has the target changed since this pointer was last checked against it, is the target at the level this pointer requires. [F for putting it this way. You called it a dimension. It behaves like one in that it is declared per kind and has computed status; it differs in that its targets are authored. I think that difference is worth keeping visible.]

The main reference is **predicated-on**: this claim needs those claims. Support travels along it. Followed across the whole store it forms the **dependency graph**, which has no cycles. [J; PLAN adds that a cycle found there means something was cut too coarsely.]

It points at the specific veritoid that is relied on. An introduction can rest on another segment's eli8 and not on its formal claim [J]. ASF's frontmatter `depends:` pretended the whole segment depended on whole segments. That was an alias, and often a fair one, because everything else in a result is tied to its claim [J]. The model keeps the alias and stores the real pointers underneath.

A dependency can be on content alone, or on content **at a level**: "I need this to be at least independently re-derived". And even when nobody wrote the level down, there is a **latent** one: a claim cannot be better supported than what it rests on [J, 11-05]. So when a premise drops, the store should ask of everything downstream, "can this still be called a theorem?"

There are other references. Each exists only because something treats it differently [RC1's admission rule]:

| Reference | Meaning | What passes along it |
|---|---|---|
| predicated-on | needs it to be true | support, and limits on level |
| narrates | talks about it (teaching, intros, headlines) | staleness only: if the thing changes, the telling must be re-read |
| restates | says the same claim again elsewhere | the two must agree |
| seeded-by | its framing came from there | "these two checks are not independent" |
| supersedes | answers in its place now | which one is current |

Every reference says how many targets it expects. That is what gives an empty result a meaning: "needs exactly one, found none" is a defect; "any number, found none" is just the answer. [RC1]

**What happens downstream when a premise changes.** You said you could not yet comment on "rebut versus undercut". RC1 has two cases. Working an example (4.2) showed me there are three:

- The premise is **refuted**. Whatever was derived using it has lost that support, and is known-broken until it is re-derived without the premise, or is itself found false. Note what this does not say: a refuted premise does not make the conclusion false. It makes it unsupported by that route. [RC1's "rebut"]
- The premise **drops in level**: a check lapsed, a rung was lost, its credence fell. Nothing downstream is thereby wrong. But what is downstream now has less support and a lower limit on what it may claim. Where that puts something below its claimed level, it is flagged. This is the soft case, and it is your latent-level point. [RC1's "undercut"]
- The premise is **narrowed**: it now says less, or says it under an added condition. RC1 files this with the soft case. That is only right for dependents that did not use the part that was cut away. A dependent that did use it is in the first case, not the second. So a narrowing puts a question to every dependent: did you rely on what is gone? [F; RC1 names this as unresolved: a dependence on one clause of a premise.]

How this meets weight of evidence. Weight of evidence is about how several pieces of evidence for **one** claim combine: independent lines add, and lines that share a source count once. The three cases above are about how a change in **one claim** reaches **other claims**. They meet here: the support that a derivation gives its conclusion is, roughly, the chance that *all its premises hold together* and *the derivation itself is valid*. Refute a premise and that support is gone. Lower a premise and it shrinks. What the conclusion's credence is once its support is gone is a separate matter (it might be true for other reasons, or have other derivations), and a single number cannot tell "unsupported" from "shown false" unless that is kept track of. The exact arithmetic depends on the kind of ladder and on how the premises depend on each other, and you already marked that as open [J, 11-05]. I have not read the two research files where the mathematics so far is.

### 2.6 Projections: chosen groupings with an order

You said every verisectorium so far has ended up with at least one canonical grouping, not always the dependency graph, "which has a coherency claim as a grouping and usually ordering" [J, 11-05]. And that the dependency graph is "distinct from projecting groups" [J, 11-05].

> **Projection.** A segment whose slots hold pointers to other segments, in a chosen order, for a purpose: a chapter, a part, a volume, a reading path, a report. [The word and this meaning confirmed by you, 11-05.]

A projection is a segment in every other respect: it has a name, it can have veritoids of its own (a chapter preface), it has its own dimensions, above all coherence, and it is written as one whole. So the nesting you described, segments into chapters into parts into volumes into one theory, each level needing to cohere [J, 11-04], is projections of projections, to any depth.

**A projection's coherence must not lapse every time anything beneath it changes.** If it did, one edit to one segment would lapse its chapter, its part, its volume and the theory, and nothing could ever settle without re-reading everything. PLAN saw this and had the answer, which I keep: a review of a chapter says **what it read of each member**. If it read only each segment's headline claim and claimed level, then only a change to one of those lapses it. A reworded proof step three levels down does not. What a projection's review reads of its members is declared in the projection's kind. [PLAN: "Upward lapse in the hierarchy is a declared rule. It is not automatic."]

The **canonical projection** is the one that says "this is the theory, in this order". An **orphan** is a segment that the canonical projection does not include, directly or through other projections, and that has no predicated-on pointer into or out of it. Orphans are allowed (4.5), and how many there are is something you always want to know [J].

A projection's order can disagree with the dependency order on purpose (ASF's "introduced before used" placements). Each such exception is a decision attached to that one ordering, with its reason.

### 2.7 What is written and what is computed

Collecting the above, because the rest depends on the line being clear.

**Written by an author**, and changed only by writing: a veritoid's content; its ground; its claimed level; its pointers. A segment's assembly: which veritoids, in which slots, in what order. A projection's list of members and their order.

**Computed by the store**, never written: every value on every dimension; whether each pointer holds; every attribute; a segment's aliased and derived values.

### 2.8 Renderings

A **rendering** is text produced from the store for someone to read: a markdown file, a PDF, a dashboard, the view put in front of an agent about to edit. It is never the thing itself.

This is where the tension you named gets resolved: "what to get in front of the agent that is the holistic-enough picture" against "independence of parts" [J, 11-05]. Segments can be as small as the truth requires. What an agent is shown can be as wide as the work requires. The two no longer constrain each other, because the file is not the unit.

A status word in a rendering is a snapshot with a time on it, never a standing fact. [RC1]

---

## Part 3. How values come to be

Sections 3.2 to 3.5 are almost all RC1. They are the part of RC1 I would keep nearly as it stands, and the part you have had the least reason to look at lately. I state them briefly so you can tell me where they have drifted from what you meant. Section 3.1 is where RC1 fell short and your dialog supplies what was missing.

### 3.1 Two kinds of time, and what gets recorded

**There are two kinds of time, and they are kept apart.**

- **Steady time.** The store moves from one steady state to the next. Each such move happens at one instant, logically. Nothing exists between two steady states. [J: "simultaneously, logically speaking"]
- **Work time.** The hours and days in which minds actually put such a move together: drafting, checking, re-editing, waiting. It has an order, clock times, and actors. [J: practical sequence]

Everything that happens is recorded in the **log**, which is only ever added to. A **state** is the store as of a point in the log: what every veritoid's written content is, how the segments are assembled, which version of the definition is in force, and what has been recorded as done. A **steady state** is one the store has actually rested in. While a move is being put together there is also a **working state**: the last steady state plus what has been staged so far. It changes as work proceeds, and it is never "the theory".

**Three sorts of thing are recorded.** [F, built on your two changesets and on the gap RC1's own field trial found]

1. A **segment changeset**: a new written state for one segment, replacing the old one as a whole. The changes inside it have no order among themselves. (4.1)
2. An **act**: a check, a review, a decision, a crossing (Part 5), an author's affirmation (4.1), a rule firing. An act is performed by an actor (3.5) against a state, steady or working. It **binds** to exactly what it read there: usually the written content of some veritoids at their versions, sometimes a value ("I relied on this being at least re-derived"). It can read many veritoids in many segments. A whole-segment review reads the whole segment. A review of an entire move reads all of it and carries one signature. When anything an act read is later changed, the act no longer binds, and the store can say why.
3. An **atomic changeset**: the container for one move from a steady state to the next. It holds the segment changesets and the acts that belong to that move. (4.3)

Every value is computed from the log as of a state. The same recorded things, read in any order, give the same values. Nothing moves a value silently: when something outside the store changes (a simulator gets a new version; a date passes that a rule cares about), that is recorded at a definite moment, and it is that record which moves the value. [RC1 calls the simulator case an era, and PLAN kept it.]

**More than one move can be in progress at once.** You said a subgraph or a single segment "can get quite a bit of work done on it independently / in parallel with 'canon'" [J, 11-05]. So there can be several working states, each belonging to one atomic changeset in progress. What happens when two of them touch the same things, or when two that never touched are both completed, is the question you raised and deliberately set aside: "is the *union* also known to be stable / internally coherent?? This is way too big a question for us to answer though right now" [J, 11-05]. PLAN's candidate was that overlapping ones are merged or one waits. I leave it where you left it, and note only that the model above does not answer it.

Two points of honesty that RC1 insists on and I keep:
- **Recording too little is as dishonest as claiming too much.** If work was done and not recorded, a later reader cannot tell "never checked" from "checked and they saw a problem". So a deliberate decision not to raise something is itself recorded, with its reason.
- **There must always be a cheap way to say something tentative.** Your words, as RC1 records them: "There should always be a way for agents (including humans) to get their intuitions and tentative results known so they can be adjudicated." Where the honest in-between has no place to go, people choose between silence and overclaiming.

### 3.2 What counts as evidence, and how it combines

A check **counts** only if its pass criterion was fixed before the result was seen. Tuning until things agree is useful work and is recorded as such, but it adds no weight.

Two lines of evidence **add** only to the degree they can be shown not to share a source. The default assumption is that they do share one. Same author, same method, same seed: that is one line said twice. [RC1; your formulation.]

A checker's own stated confidence is testimony about the checker. The store computes credence from it using what it knows of that checker's record. [PLAN]

One thing this leaves unsaid, and it carries weight: nearly every checker here is an instance of the same model family. What, if anything, makes two such instances independent lines is not settled anywhere I have read.

### 3.3 Decisions

A decision has four dimensions of its own, never fused into one grade [RC1, from your August sessions]: on what grounds; who was consulted; who stands behind it and how firmly (supported, ratified, ruled); and what would reopen it. When a named assumption is later shown false, the decision reopens, carrying what changed.

You distinguished decisions by what they are about [J, 11-04; PLAN's table]:

| About | Example | Recorded as |
|---|---|---|
| the subject itself | a modelling choice in AAT | a veritoid of a decision kind, with those four dimensions |
| the inside of the store | keeping a claimed level after a rewording; deciding where two spans of an influx file go | an act |
| where effort goes | "concentrate spikes on this scope for now" | an act with an expiry |
| how the store works | adding a kind | a change to the definition |

You also said the line between the first two is not always sharp when the project *is* the store, as with ASF [J, 11-04].

### 3.4 Limits that are declared, not earned

Some things about a veritoid are simply stated and then consulted. RC1 calls them **bounds** and I keep the idea:
- what this content is allowed to assert on its own authority (nothing new; a summary; a generalization; an original claim). This is what separates, in an ASF `impl-` segment, the sentences that restate a proved result from the ones marked "this segment's own framing";
- what a reader may do with it ("usable as a hypothesis"; "do not revive");
- whether it is safe to show an unprimed auditor.

### 3.5 Standing: who may do what

You asked what "who" means in "who has standing to mint". **Standing** is the condition under which an act counts at all. It is a yes or no asked before any question of quality. A "ruling" recorded by someone with no power to rule is not a weak ruling. It is not one. [RC1]

"Who" is the **actor**: the session or agent identity that the harness attests, which you pointed out already exists and should be read automatically, not typed [J, 11-02]. A kind's definition says, for each sort of act, which actors have standing. Two examples:
- only you may record a decision as *ruled* (RC1's meaning of that rung);
- the mind that revised a thing may not be the one that confirms it (vsect 0.1 already enforced this).

Standing is different from independence. A check by the author of the thing checked has standing as a check. It simply adds no independent weight (3.2).

A gap to know about: the harness's identity for your own main session is the session itself. An act recorded there by you, and one recorded there by the agent on its own initiative, look the same. "Only you may rule" needs some way of attesting that it was you, which does not exist yet.

---

## Part 4. Change

The ideas in this part are from your messages of 11-03 to 11-05. The places where I have added something are marked [F].

### 4.1 The unit of writing is the segment

A veritoid is never changed alone. The basic write is a **segment changeset**: one set of simultaneous changes to what is written in one segment. (This is your "instance-isolated changeset".) It may change content, pointers, grounds and claimed levels; recut the segment (2.4); and, as you said it should be able to, create new segments [J, 11-05].

> **A segment changeset is a whole new written state of one segment.** For every veritoid that depends, by the segment kind's inner dependencies, on a changed one, the changeset either changes it too or carries the author's explicit affirmation that it is still right against the new content. A segment state with a veritoid that is neither is not a changeset. It is still a draft. [J for the rule: inner dependencies "would have to be fully coherent and reconciled and correct … or it isn't a valid instance-change". F for "changed or affirmed" as the form a machine can check.]

Pointers that reach *out* of the segment, or *into* it from elsewhere, are not the changeset's to reconcile. They become things owed (4.3).

What makes the rule workable is the line drawn in 2.7 between what is written and what is computed:

- **What is written** is reconciled by the author, inside the changeset, at one instant. The description must say what the new claim says.
- **Values** are not the author's to set. The moment the changeset is staged, every act that read what changed stops binding, and positions drop accordingly. Earning them back takes further acts, usually by other minds, in work time.

So "coherent and reconciled and correct" applies to what is written, at once. "Independently re-derived", "holds together as a whole", "faithful to its source" are values, and they come back one act at a time. [F. You pictured a content change that "would automatically lower the certainty which would effectively trigger the two sides of the adjudication at the same time" [J, 11-04]; binding is my mechanism for the lowering, not something you described.]

One thing I have made sharper than you did. When content changes, I have positions drop at once and completely: a re-derivation of the old text is not a re-derivation of the new one. Whether *credence* should also fall all the way, or only part of the way for a small rewording, is open. You wondered aloud about a drop "shaped more heavily toward a lowering" [J, 11-04], and PLAN has a forecast that orders the re-checks without standing in for them.

The author's affirmation ("the description is still right") is an act by the author, carried in the changeset. It never counts as an independent check. Its job is only that nothing is left as it was without someone having looked.

### 4.2 A worked example

Steady state S0. Segment T is a derived result: a formal claim c1, a derivation d1 (its steps, written as one thing here for short), a description e1 and an eli8 k1. Agent B has independently re-derived the claim c1 by way of d1, so c1's position on the derivation ladder is "re-derived"; that act read c1 and d1. T has been read as a whole and found coherent. Segment U has a claim u1 that is predicated on T's claim at "re-derived or better". To keep the table short, suppose nothing else in the store points at T or U, and leave aside the chapter that holds them (2.6 says when it would need re-reading).

| Work time | What happens | What is owed afterwards |
|---|---|---|
| 08:30 | An auditor finds that T's claim is false as stated and needs an extra hypothesis H. The finding is recorded as an act. | The store is no longer steady. This act is the **perturbation**. Owed: T's claim is known-broken. (Whether S0's readers can see that yet is the open question in 4.4.) |
| 09:00–09:25 | Agent A drafts: adds H to the claim (c2), reworks the derivation to use H (d2), re-reads the description and finds it still right, rewrites the eli8 (k2). | Nothing staged yet. Drafts are not changesets. |
| 09:25 | A submits **segment changeset 1 on T**: {c1→c2, d1→d2, e1 affirmed against c2, k1→k2}. One instant, four veritoids, no order. | B's re-derivation read c1 and d1, so it no longer binds; c2's position is "drafted". T's whole-read no longer binds. U's pointer targets something that changed, and by narrowing (2.5), so U must be asked whether it used what is gone. U needs "re-derived" and T's claim is "drafted". **Four things owed.** |
| 11:00 | B re-derives c2 by way of d2. | Binds to c2 and d2. T's claim is "re-derived" again. Two owed: T's whole-read, and the question to U. |
| 11:30 | A finds and fixes an error in step 3. **Segment changeset 2 on T**: {d2→d3}. | B's 11:00 act read d2. It no longer binds. T's claim is "drafted" again. |
| 12:00 | B re-derives c2 by way of d3. | Binds to c2 and d3. |
| 13:00 | Agent C answers the question to U: U's claim follows only if U also assumes H. **Segment changeset 3 on U**: {u1→u2, pointer re-declared against c2, …}. | U's pointer holds. u2's own position is "drafted". |
| 13:30 | B re-derives u2. | Binds to u2 and c2. |
| 14:00 | Whole-reads of T and of U, by someone other than their authors. Nothing owed. | The move is complete. **S1.** |

What S1 contains, and what the history on the steady line says:
- T's claim went c1→c2. T's derivation went d1→**d3**. Version d2 was never part of any steady state.
- U's claim went u1→u2 at the same instant as T's. There was never a theory in which T had H and U did not.
- The acts that count in S1 are the ones that bind to what S1 contains: B's 12:00 and 13:30 re-derivations, the two whole-reads, A's affirmation of e1.
- B's 11:00 re-derivation is in the log. It binds to nothing in S1. It is not neutral, though: B passed a derivation that had an error in step 3. That is exactly the kind of record the store needs in order to know how much B's checks are worth (3.2).

### 4.3 Perturbation, frontier, atomic changeset

The example, in general terms.

The store is **steady** when nothing is known to be inconsistent, apart from what has been explicitly accepted, and no rule would fire.

A **perturbation** is whatever first disturbs it: a finding, a softened claim, a new result, a rule firing because a date passed.

The **frontier** is everything owed: all that is known not to be consistent in a working state, computed again after each further write or act.
- pointers whose target has changed since they were last checked against it;
- veritoids whose claimed level is above what their values, or their premises, now allow;
- acts that no longer bind, where a value depended on them;
- questions a rule has raised that a mind must answer ("does this Part I change require changing the figure in the introduction?").

The **atomic changeset** is the whole set of segment changesets and acts that empties the frontier, or leaves on it only what has been explicitly accepted. It is usually more than one mind can assemble in one pass, so it is built up in stages, and at every stage the frontier says what is still owed. It is finished when, everywhere the perturbation reached, what is written is consistent and every claimed level is either earned again or honestly lowered.

Only a complete atomic changeset moves the store to its next steady state. How working states are stored and checkpointed is undecided, by your choice; a branch that merges is one way to meet the need, not the design.

If the frontier keeps growing instead of shrinking, work stops and a group looks at the whole: keep going, split the changeset, find the two ideas that were being treated as one, record a genuine tension between two well-supported claims, or recognize that a foundation has moved and everything above it must be redone.

Changes near the roots of the dependency graph reach nearly everything, and changes at its tips reach nearly nothing. Hence your point that the early material should be made as solid as possible in proportion to its age and to how much stands on it.

### 4.4 When a defect is found

Softening the claim is the natural first response. It is honest, and it is the easy thing. Its quick calm is often false, because of the latent level dependencies in 2.5.

The methodology (not the engine) then asks what it would take to change the content so that the earlier claimed level is kept. That is a second perturbation, usually larger. Whether to complete the softening first and take up the strengthening afterward, or to stack them and complete once, is a decision about where effort goes, made with the time available.

**One question this picture sharpens and does not answer.** The 08:30 row of the example shows it. A finding that something is broken is itself a perturbation. If readers of the store only ever see steady states, the finding stays invisible to them until 14:00. RC1 says known-broken must show "immediately, visibly". You were weighing exactly this: a mark on a value saying "a known defect probably lowers this; not yet worked through; do not rely on it", which you called "a sort of 'known honesty' orthogonal to internal-consistency / stability". You would accept it if such marks are rare and are nearly always what is being worked on. A steady state would then be promising two different things, consistent and honestly current, and a marked value would be the first without the second. I have not gone past where you left it.

### 4.5 Creating, connecting, orphans

A segment may be created on its own, connected to nothing. Exploratory work often does not know yet where it belongs. **Connecting** it, by a predicated-on pointer or by placing it in a projection that must then cohere, is its own perturbation and is usually where the large work is.

### 4.6 When the kinds themselves change

The definition changes too: a segment kind gains a slot, a dimension is split, a ladder gets a new rung. Each veritoid and segment records which version of its kind it follows. You described the range, from cheap and reversible, through easy to apply and hard to undo, to changes that alter what "steady" can even mean for part of the store [J, 11-05], and said to let the machinery for this grow when needed.

Two observations.

The May 2026 "audit gold lift", which wrote the same six slots into 120 ASF segments in two days, was a change of this sort done by hand.

And this is where a question of yours from 11-04 gets an answer. You asked for a structure in which something like "novelty" starts as a soft label, later becomes a rule-backed assertion, later an auditable value with a procedure behind it, and finally "graduates into its whole new *kind*" with its own content (near neighbours in the literature, dates of the last search) and its own freshness. In this model each graduation is a change to the definition. The first three change how the novelty dimension's value is produced. The last adds a slot to the segment kind for a novelty assessment, a veritoid with content and dimensions of its own, and re-declares the segment's novelty as aliased to it. Nothing new is needed to express it. [PLAN has this as a four-rung ladder of "graduation"; I think it is better seen as four ordinary definition changes.]

---

## Part 5. Intake: how material gets in, and how it gets retired

Mostly [PLAN] and the feedback report's measurements, placed into this structure by me.

A **source** is anything brought in from outside the store's settled content: a paper, an audit report, a spike, an old ASF file, a transcript. A source is cut into **chunks**, and the chunks must cover all of it. If a reader cuts chunks only around what they happened to notice, "every chunk dealt with" still means "found something", which was the first sprint failure. Whatever has not yet been cut is itself visible as not yet cut.

Each chunk has at most one current **crossing**: the recorded decision about where it went. A crossing is an act. A chunk with none is undecided.

A crossing's possible outcomes, including three that the sprint used in practice and PLAN lacked:
- it changed an existing veritoid;
- it became a new veritoid;
- it was already present;
- it is one more independent arrival of something already present (which is evidence, not a duplicate);
- it was superseded, or rejected with a reason;
- it was delivered to another store;
- it was passed to a segment's inbox (below), which is not final: it still has to be dealt with there.

From the first moment, the store records for each source whether it has been read, by whom, and how far its chunks have got. "Unread" is something you can ask for. A source is retired when all of it has been cut and every chunk has a final crossing.

**The inbox.** You called a segment's Working Notes "one of the most effective (when used correctly) higher-level mechanisms in ASF": a place where miscellany bearing on one segment collects, to be drained [J, 11-05]. RC1 has the reason it works, without connecting the two: an open item only does its job if it sits where the mind that should act on it will pass.

> **Inbox.** Every segment has one. Anyone may add to it. What it holds are chunks: passed there from a source, or written there directly, in which case the note is its own small source. It is not part of the segment's written state, so adding to it or emptying it is not a segment changeset and never makes the segment look changed.

That last clause is the measured lesson of the sprint: the drains disposed of about two thousand Working Notes items and retired no sources, because the notes lived inside the text they were notes about, and nobody was allowed to touch that text. [feedback report]

Some things that sat in Working Notes were never inbox material: a regression guard ("do not restore this form; here is why it is false"), an open question with a named closer, a dead end with its reason. Those are veritoids of their own kinds, in slots of their own, and they stay.

What leaves a store for another store is a **delivery**. You said "set-asides" is a poor name and I agree.

---

## Part 6. Who does the work

You were firm that the model must not try to describe how a council works inside [J, 11-03 and 11-04]. So this is short.

A **move** is a declared way for a value to change through an act. A kind declares its moves: which dimension each one changes, what must be true first, who has standing, and what the act must record. Each move has a **queue** of things waiting for it. A queue can be worked by more than one **mechanism**: a rule, a single agent, or a council. Which mechanism takes a given item depends on what it is and how much rests on it. A council's charter is derived from the move it serves: the dimension being moved fixes what it must produce, and importance fixes how much agreement is required [J, 11-03 and 11-04].

For now, whoever is working on v2 and AAT is what keeps queues moving [J, 11-04]. The engine's job is only that every queue is visible and none can fill unseen.

**On the second sprint failure.** Your own diagnosis of the loop was specific: "wrong integrator agent after a verification pass with a new mind", and "Why does a new integrator land the independent checker's findings instead of the original integrator? That seems extremely wasteful and prone to error" [J, 11-02 and 10-30]. So the cause was a *fresh* mind landing a checker's findings, writing new text that then needed checking. The remedy that points to is continuity on the writing side: the checker's findings go back to the author of the changeset, inside the same atomic changeset. (In the example, A remains the author of T from start to finish, and B only checks.) Independence belongs on the checking side only. The model supports this (one atomic changeset, one author per segment changeset where possible, checks by others) but does not enforce it, and I do not yet know whether it should.

---

## Part 7. One picture

```
THE DEFINITION (hand-written for now; has versions)
┌────────────────────────────────────────────────────────────────────────────────┐
│ VERITOID KIND ── allows 1..N ──▶ DIMENSION ── has 1 ──▶ SCALE (ladder|set|number)│
│   │                 (evidenced | decided | attested | mixed)                    │
│   ├── declares ──▶ content form · which REFERENCEs it may hold · BOUNDs         │
│   └── declares ──▶ MOVEs (dimension changed · precondition · who has standing)  │
│                                                                                 │
│ SEGMENT KIND ── declares 1..N, in order ──▶ SLOT                                │
│   │      (which veritoid kind · required? · one / at most one / any number)     │
│   │      (in a projection kind: pointers to segments, and what a review of the  │
│   │       projection reads of each member)                                      │
│   ├── declares ──▶ inner dependencies among its slots                           │
│   ├── declares ──▶ the segment's own DIMENSIONs: aliased | derived | own        │
│   └── declares ──▶ MOVEs on those                                               │
└────────────────────────────────────────────────────────────────────────────────┘

THE STORE
┌────────────────────────────────────────────────────────────────────────────────┐
│ SEGMENT ── is of exactly 1 ──▶ SEGMENT KIND                                     │
│   ├── has 1 NAME (current) + 0..N old names                                     │
│   ├── WRITTEN: which VERITOIDs fill which slots, in order                       │
│   │        (a PROJECTION: pointers ──▶ other SEGMENTs, in order)                │
│   ├── COMPUTED: VALUEs on its own dimensions (aliased | derived | own)          │
│   └── has 1 INBOX (0..N CHUNKs; not part of what is written)                    │
│                                                                                 │
│ VERITOID ── is of exactly 1 ──▶ VERITOID KIND                                   │
│   ├── sits in exactly 1 slot of exactly 1 SEGMENT   (identity of its own: open) │
│   ├── WRITTEN: content · GROUND · CLAIMED LEVEL                                 │
│   │            REFERENCEs ──▶ other VERITOIDs                                   │
│   │            (predicated-on, no cycles · narrates · restates · seeded-by · …) │
│   └── COMPUTED: 1 VALUE per open dimension (position | credence | judged value, │
│                 each with how sure) · whether each reference holds · ATTRIBUTEs │
│                                                                                 │
│ LOG = everything recorded, append-only.   STATE = the store as of a point in it.│
│   steady states:  S0 ─▶ S1 ─▶ S2      working states: one per move in progress  │
│                                                                                 │
│ ATOMIC CHANGESET ── one move from a steady state to the next                    │
│   ├── holds 0..N SEGMENT CHANGESETs (each: 1 segment, a whole new written state)│
│   └── holds 0..N ACTs                                                           │
│                                                                                 │
│ ACT ── by 1 ACTOR · against 1 state · binds to what it read (content at a       │
│        version, or a value), across any number of veritoids and segments        │
│        check · review · decision · crossing · affirmation · rule firing         │
│                                                                                 │
│ FRONTIER = what is owed in a working state; empty or accepted at a steady state │
│                                                                                 │
│ SOURCE ── cut, completely, into 1..N ──▶ CHUNK ── at most 1 current ──▶ CROSSING│
└────────────────────────────────────────────────────────────────────────────────┘

OUTSIDE THE STORE:  RENDERINGs (files, views, dashboards), each a snapshot as of a state
```

---

## Part 8. Lexicon

Words I am using, with what each replaces and what it must not be taken to mean.

| Word | Means | Replaces | Is not |
|---|---|---|---|
| **verisectorium** | a living body of work whose pieces carry their own honest support | | |
| **store** | one verisectorium's contents as v2 holds them | | not a git repo; not a directory of files |
| **definition** | the declared kinds, dimensions and moves of one store | "system model", "system definition" | |
| **veritoid** | a piece of content of a declared kind, with its values | dialog: "atom". RC1 and PLAN: "record" (in its small sense). Kernel drafts: "atom". Archived design: "statement" | not "the unit of fate"; not meaningful alone |
| **content** | the text or data a veritoid holds, at a version | "body" | |
| **kind** | a declared type. A **veritoid kind** says what form the content takes and which dimensions it allows. A **segment kind** says which slots a segment has and how the segment's values come from its veritoids | dialog: "atom kind" and "template". RC1: "kind" | not "speech act"; not defined by how a thing fails; not a filename prefix |
| **segment** | a named, ordered assembly of veritoids: the unit of identity, of writing, of whole review | dialog: "instance". Your "document". RC1: "cluster", and "record" in its large sense. PLAN: "composite" | not a file; not one fate; in ASF many are too coarse and should be several |
| **slot** | a declared place in a segment kind, holding one, at most one, or any number of veritoids | "section", "inner location", "typed part" | |
| **inner dependency** | a declared dependence of one slot on another within a segment kind | | not a predicated-on pointer |
| **split**, **merge**, **promote**, **fold back**, **retire** | the ways the structure is recut: one veritoid into several; several into one; veritoids out to their own segment; back in; out of present truth | "grain repair" | |
| **name** | a label the store keeps bound to a segment, with history | "slug", "maintained name", "binding" | may change; not the thing |
| **dimension** | one independently answerable question about a veritoid or a segment | "aspect", "axis", "facet" | not a namespace such as "evidence" (that is only a prefix in the name) |
| **scale**; **ladder**, **rung** | the values a dimension can take; an ordered scale and its steps | "stage", "status" values | |
| **value** | computed state on a dimension, as of a state of the store, with how sure | "status", "label", PLAN's "standing" | never typed by hand |
| **position** / **credence** / **judged value** | what has been done / a claim with its probability / a judged label with a spread | "certainty" loosely covered several of these | none is inferred from another |
| **aliased** / **derived** / **own** | the three ways a segment gets a value: from one veritoid; from several; asked of the whole | RC1's unanswered "projection rule upward" | |
| **coherence** | a segment's own dimension: does it hold together | | |
| **attribute** | a plain measurement with no judgment | | not a dimension |
| **ground** | what an author states a veritoid can be supported by, which opens its evidence dimensions | RC1: "foundation" | |
| **claimed level** | what a veritoid's content asserts about its own support; written, and compared with what is computed | scratch file: "what it claims". ASF: `status:`, inline tags, Epistemic Status prose | not a value |
| **soften** | lower a claimed level, or narrow what is said | | |
| **bound** | a declared limit that is consulted, not earned | RC1: "license", "claim license" | not a dimension |
| **reference** (pointer) | a written link from a veritoid to others; the store computes whether it holds | "edge", "link" | |
| **predicated-on** | the reference along which support travels | "depends", "supports", "premise edge" | not "appears earlier in the outline" |
| **dependency graph** | all predicated-on pointers; no cycles | "support web" | not a projection |
| **refuted** / **dropped in level** / **narrowed** | three ways a premise can change, with different consequences downstream | RC1: "rebut", "undercut" (two cases) | |
| **projection** | a segment whose slots point at other segments in a chosen order, with its own coherence | "group", "arrangement", "composite", "navigational hierarchy", "outline", "canonical grouping" | not "any computed summary" (RC1 and councils-46 both used it that way); not a rendering |
| **orphan** | a segment in no canonical projection and with no predicated-on pointer in or out | | |
| **rendering** | text produced from the store for a reader | "manifestation", "document" in the file sense, "view" | never the thing itself |
| **log** | everything recorded, append-only | "trail", "WAL" | |
| **state** | the store as of a point in the log | | not only content versions |
| **steady state** | a state the store has rested in: nothing known inconsistent beyond what is accepted | "stable", "fixed point", "main" | |
| **working state** | the last steady state plus what one move in progress has staged | "branch", "unstable" | never "the theory" |
| **steady time** / **work time** | the sequence of steady states / the hours in which a move is assembled | | not the same clock |
| **segment changeset** | a whole new written state for one segment, simultaneous inside | your "instance-isolated changeset" | not a draft; not a single-veritoid edit |
| **atomic changeset** | everything that takes the store from one steady state to the next | "episode" (PLAN, RC1 addendum) | "atomic" here means all-or-nothing; it has nothing to do with "atom" |
| **perturbation** | whatever first disturbs a steady store | "motivating perturbation" | |
| **frontier** | everything still owed in a working state | "obligations", "what is still inconsistent" | |
| **act** | one recorded thing an actor did against a state: a check, review, decision, crossing, affirmation, rule firing | "event", "securing event" | not limited to one veritoid; not a change of what is written |
| **bind** | an act binds to exactly what it read; when that changes it no longer binds | "lapse" (for the ending of it) | |
| **actor** | the attested identity that performed an act | "agent type", `--by` | not typed free text |
| **standing** | whether an actor's act counts at all | | not a degree; not independence; not PLAN's "standing" |
| **move** | a declared way for a value to change through an act | "transition", "mover", "channel", "station" in the feedback report's sense | |
| **queue** | the things waiting for a move | "stock", "place" | |
| **mechanism** | what works a queue: rule, agent, or council | "drainer", "station" | |
| **source**, **chunk**, **crossing** | incoming material; a piece of it; the recorded decision where it went | RC1: "unit" for chunk. "influx item", "disposition" | |
| **inbox** | a segment's own intake, outside its written state | "Working Notes" (the part that is intake), "segment-local influx" | not a slot; not the guards and open questions that also sat in Working Notes |
| **delivery** | material sent on to another store | "efflux", "set-aside" | |

Words I have deliberately not used: *record, atom, template, instance, group, composite, cluster, station, stock, trail, status, episode, fate*, and *standing* in PLAN's sense. Each has meant two or more things in the last three months.

One collision you should know about: the verisectorium plan (your five steps of 11-04) uses **template** for the seed that `v2 init` applies, and **instance** for a verisectorium made from it. Since this document does not use either word for anything else, those two can keep that meaning.

---

## Part 9. Where I chose, and what I know is open

### Choices of mine that you have not confirmed

In rough order of how much rides on each.

1. **Two levels of content** (2.3): veritoids, and the segments they are assembled into, with no veritoid inside a veritoid. This is the closest reading I can give of what you described in the dialog. You have not confirmed it. When I asked, you said of this and the next item "I'm still not sure", and earlier you leaned toward modelling the recursion mathematically while keeping a practical granularity. I had briefly made the two levels one recursive type and withdrew that, because your two changesets are stated at exactly these two levels and the worked example needed nothing deeper.
2. **The write rule** (4.1): every dependent veritoid in the segment is changed or affirmed by the author, in the same changeset. Your rule, with "affirmed" added so that "nothing was left unlooked-at" is something a machine can check.
3. **What is written is reconciled at once; values come back one act at a time** (2.7, 4.1). This is how I made your "fully coherent and reconciled and correct" compatible with re-checks that need a different mind. If you meant more than what is written by "correct", the rule needs another look.
4. **Three sorts of recorded thing** (3.1): segment changesets, acts, and the atomic changeset that holds them, with an act able to read across many segments and to bind to a value as well as to text.
5. **A projection is a segment** (2.6), differing only in that its slots hold pointers to segments, and with a declared rule for what its review reads of its members. The word is confirmed; that it is the same sort of thing as a segment is my step.
6. **References are written, not computed** (2.5). You called the dependency an "array dimension". I have kept the targets as authored and made only "does it hold" computed.
7. **A claimed level is written beside the content** (2.2). I am fairly sure the model needs it. I am not sure it is one field. It might be part of the content proper (the word "Theorem" in the text), or a bound, or declared by the veritoid's kind.
8. **A premise that is narrowed is a third case** (2.5), not a soft one.
9. **An act alone is an atomic changeset of size one.** A confirming check on a steady state changes a value and nothing written. I treat it as a move that completes at once because nothing is owed.
10. **The name stays with the thing when its meaning changes** (2.4). A lean, against PLAN, with PLAN's worry stated there.
11. **The inbox is outside the segment's written state** (Part 5). Forced by the sprint's result. Where it is physically kept is open.
12. **"Veritoid"** and **"segment"** as the two words. "Document" was the alternative for the second. The first may not survive.
13. **Dimensions sorted by what builds them**, with RC1's list of particular dimensions left as candidates. I have not tried to settle AAT's actual dimensions or kinds here. I think that should be done by writing kinds for real material, by hand, and seeing what breaks.

### Open, and I have not tried to close

- **Whether a veritoid has an identity of its own**, and so how split, merge, promote, fold back and retire keep pointers honest (2.4). Unanswered since the dialog.
- **Whether a known defect may show on a steady state before it is worked through** (4.4). Yours, still being weighed.
- **Several moves in progress at once, and whether two completed ones combine into something steady** (3.1). Yours, deliberately set aside.
- **How much credence a small rewording should cost** (4.1), and the arithmetic of support along predicated-on (2.5).
- **What makes two checkers of the same model family independent** (3.2).
- **How "it was Joseph" is attested** (3.5).
- **Whether continuity of the author through a round of checking should be enforced** (Part 6).

## What I have not read, and what that leaves soft

- **The address theory** (`~/src/address-theory/`). RC1 says it is the careful treatment of names, pointers, things inside things, and "as of a moment". Sections 2.4 and 2.5 are written from RC1's summary of it, and the first open item above is probably answered or sharpened there.
- **`research/knowledge-graphs.md` and `research/plan-review-1.md`**: the mathematics behind credence, combination of premises, and calibration. The last paragraph of 2.5 and all of 3.2 are stated at the level I can stand behind without them.
- **ASF's `FORMAT`** and every segment type other than def-, deriv-, impl-.
- **RC1's Python interpreter**, and the theory canon that RC1 cites.
- **Councils and high-councils** beyond your own messages about them.
- Your messages before 10-28, and any session outside asf, councils and aat-v3.

## What changed since the version you began reading (evening of 11-05)

Twice. First, after your note that 3.1 did not represent logical simultaneity:
- 3.1 was rewritten around two kinds of time; 4.1 to 4.3 were rewritten with the worked example; 2.3 stopped making the veritoid and the segment one recursive type.

Then, after the cold read by a fresh agent the same evening, whose main findings I checked and agreed with:
- **Claimed level** was restored (2.2). Without it "softening" and "claiming more than is earned" had nothing to refer to.
- **State** is now a point in the log, not just content versions (3.1), and outside changes are recorded, not silent.
- **Several moves at once** is named as open, in your words (3.1). The earlier text quietly allowed only one.
- **A chapter's coherence** no longer lapses on every edit beneath it (2.6).
- **Split and promote** no longer claim to disturb nothing; veritoid identity is listed as open; ways to shrink the structure were added (2.4).
- **Pointers** are written, not computed (2.5, 2.7).
- **Narrowing** is a third case, and the sentence about premises and credence no longer says a refuted premise makes its conclusion false (2.5).
- The **second sprint failure** is now stated with your diagnosis, which my earlier text had not addressed (Part 6).
- Your **novelty** question from 11-04 is answered (4.6).
- Attributions were corrected where I had been looser than the source: your flow diagram had lost the word "projections"; "exactly as you said it" over-credited you with councils-46's names; one paraphrase sat inside quotation marks; and Part 9 had said "this is your model" of something you had said you were not sure of.

The earlier versions are kept in `research/reading-fable-2026-11-05/` (files 10, 11 and 12).
