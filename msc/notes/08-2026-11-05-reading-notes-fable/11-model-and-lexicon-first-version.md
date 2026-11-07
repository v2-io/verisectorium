# The v2 model and its words, as I currently hold them

*To Joseph, from the Fable session that took over on 2026-11-05. You asked for this so that we can check we are holding the same model before you comment on details. It is my synthesis, not a settled design. Nothing here is ratified.*

*It is written to be read top to bottom. Each word is introduced before it is used. Part 8 is the lexicon, with what each word replaces and what it must not be taken to mean. Part 9 lists the places where I chose and you may want to choose differently.*

*Where each idea comes from is marked:*
- ***[J]** yours, from the dialog of 2026-11-05 or your messages of 10-30 to 11-05;*
- ***[RC1]** carried from the August model, which I read whole today;*
- ***[PLAN]** from councils-46's plan;*
- ***[F]** my proposal, which you have not seen argued and should treat as the least tested.*

*What I read to write this: the scratch file, PLAN, Appendix A, the feedback report, the dialog, the building-blocks model, RC1 whole except its Python interpreter, three ASF segments whole, the ASF volume 1 outline in part, and your own messages from 10-30 to today in the asf, councils and aat-v3 sessions. What I did not read is listed at the end.*

---

## Part 1. What this is a model of

A **verisectorium** is a body of written work that is never finished, is worked on by many minds who each arrive knowing nothing about it, and in which every piece says honestly how well it is supported. **v2** is the engine that holds one. AAT is to be the first.

Your picture of the flow [J, 11-03]:

```
external influx ─┐
                 ├─▶ working theory ─▶ canon ─▶ mental models, pedagogy, implications
internal influx ─┘   (provisional)
(spikes, audits, experiments)
```

Three things the October sprint showed that this model has to make impossible or at least visible (the first two in your words of 10-30 and 11-02; the third is the feedback report's measurement):

1. Nobody could see which influx had been looked at, by whom, or how far. The sprint could not tell "found everything" from "found something".
2. Checks and fixes fed each other. Almost half of the claims "fixed" had only been written earlier in the same sprint.
3. Nothing was ever retired. Every pass left more surface than it removed.

And one rule you stated in capitals [J, 11-04]: nobody edits the store by hand. Every change goes through v2. Where v2 cannot express a change, that is how we learn what v2 lacks.

---

## Part 2. The structure: what exists in a store

One example runs through this part. It is the one you used in the dialog: a derived result with a formal claim, a description, and an "explain it to an eight-year-old" paragraph.

### 2.1 Content, kinds, and the basic thing

The store holds pieces of **content**: a formal statement, a paragraph of explanation, a proof step, a figure caption, a question, a note from an auditor.

Every piece of content is of a **kind**. A kind is declared in the store's definition. It says what form the content takes and, most importantly, **which questions can be asked about content of this kind** (2.2) and **what parts it has** (2.3). You asked twice how a "kind" could fail to say what is tracked and what content pieces there are [J, 11-04 and 11-05]. Here a kind says both.

I need one word for "a piece of content, of some kind, with its tracked state". You offered **veritoid**, half in jest. I am using it, because it carries no history. [J for the word; F for stretching it as described in 2.3.]

> **Veritoid.** A piece of content of a declared kind, together with its values on that kind's dimensions, and possibly parts that are themselves veritoids.

### 2.2 Dimensions, values, certainty

A **dimension** is one question that can be asked about a veritoid and answered independently of the other questions. [RC1; your word since August.] Examples: Is it true by derivation? Has it been measured? Who stands behind this choice? Is it faithful to its source? Is it still current? Does a reader come away understanding it?

Two things can move independently, so they never share a dimension. RC1's test for a mistake here is good and I keep it: if a scale's values look like `ruled-but-groundless`, `consulted-and-grounded`, it is two dimensions jammed into one. [RC1]

Each dimension has a **scale**: the values it can take. A scale is one of:
- a **ladder**: ordered rungs, such as sketch, drafted, premises checked, independently re-derived;
- an unordered set;
- a number;
- a **reference**: pointers to other veritoids (2.5). [J]

A veritoid's **value** on a dimension is never typed in by hand. It is computed from the recorded acts that bear on it (Part 3). [RC1; the oldest rule in all of this.]

**Certainty is kept apart from the value** [J, 11-04]. "Novelty: high" and "how sure are we that it is high" are two things. PLAN refined this into three forms a value can take, which I keep because they stop a common confusion:

| Form | What it says | Example |
|---|---|---|
| **position** | what has actually been done to this content | "independently re-derived, against this exact text" |
| **credence** | how probable it is that a truth claim is true, computed from the evidence | 0.93 |
| **judged value** | where something sits on a scale that only judgment can read, held as a spread over the scale, not a point | novelty: probably high, possibly medium |

None of the three is ever inferred from another. A high position does not make a high credence by itself. [PLAN, extending RC1's rule that no dimension stands in for another.]

Your sort of dimensions by **what builds and sustains them** [J, 11-04] is the one I use, because it tells you what work moves each:

- **evidenced**: a truth claim. Built by accumulating evidence.
- **decided**: a choice at a branch point. Built by grounds, consultation, and someone accountable.
- **attested**: asserted and checkable, but we do not keep a chain of evidence for it (who wrote this, when). This is where the recursion stops.
- many are a mix. Importance is one: it is always importance **for** something, and it combines what rests on this (computed) with how much that something matters (decided).

An **attribute** is different from a dimension [J, 11-04]. It is a plain measurement with no judgment in it: word count, age, how recently changed, how many things point here. Rules can turn attributes into dimension values ("stale when age over recency exceeds X"). When a rule fires, that is a recorded act like any other.

A veritoid does not open every dimension its kind allows. When it is created it declares its **ground**: can this be proved, simulated, measured in the wild, checked as an instance of a known model, or only witnessed? The ground decides which evidence dimensions are open for it. A dimension that is not open is a recorded fact ("this was never meant to be measured"), not a gap. [RC1. I think this is RC1's best statement of your "what builds it", and PLAN dropped it.]

### 2.3 Parts, slots, and why the small thing and the whole are one type

You said the small thing almost never makes sense alone, and that the fates of the small things in a group are intertwined so that when a core one fails the rest may go with it [J, 11-05]. And you said the decomposition is "turtles all the way down" in principle, with a practical stopping point [J, 11-05].

I take both literally. **A veritoid can have parts, and the parts are veritoids.** [F]

A kind declares its **slots**. Each slot says what kind of veritoid goes there, whether it is required, and how many (one, at most one, any number). [J: your "template", with order, required and optional.]

```
kind derived-result
  slots:
    formal-claim   one        kind: claim
    derivation     one        kind: derivation      (which itself has a slot  step: any number)
    description    one        kind: explanation
    eli8           at most 1  kind: explanation
    examples       any number kind: worked-example
```

A veritoid with no parts is a **leaf**. Being a leaf is not a kind of thing. It is where we chose to stop cutting. A derivation can be one leaf today. If a check later finds step 4 wrong and the rest sound, the derivation is cut into steps, and from then on each step carries its own values. I call that **refining**. [F] Nothing about the result's name or what points at it changes when this happens.

This is how I read your remark that a list "may be an implicit set of independent veritoids that build on one another, e.g. steps in a derivation" [J]. It is also what ASF's lettered items (a) to (h′) are, and what the three separately labelled claims inside `deriv-stochastic-non-exit` are.

**How the whole gets its values from its parts.** A kind declares this for each of the whole's dimensions, in one of three ways [J, exactly as you said it]:

- **aliased**: the whole's value is one named part's value. "This result's truth is its formal claim's truth."
- **derived**: computed from several parts. "This result is as fresh as its stalest part."
- **own**: asked of the whole and of no part. "Does this hold together when read as one thing?" That is **coherence**. Teachability is another.

RC1 had a question for this (at what depth does state attach, and what is the rule for carrying it upward) and never answered it. Your three ways are the answer.

**Parts depend on each other inside the whole.** The eli8 rests on the description, which rests on the formal claim [J]. A kind declares these inner dependencies. They are why the whole has to be looked at together when one part moves.

*Mapping to the dialog's words:* "atom" was a leaf veritoid; "template" was a kind that has slots; "instance" was a veritoid that has parts and a name. I have folded "atom kind" and "template" into the one word **kind**, which is the rename you said might be right shortly.

### 2.4 Names and segments

Some veritoids have a **name** of their own. The rest are reached through the nearest named one above them: `persistence-threshold#formal-claim`, `persistence-threshold#derivation/step[4]`.

> **Segment.** A named veritoid. It is the unit that has an identity, that is written as one act (Part 4), and that is reviewed as a whole.

I chose "segment" because it is your everyday word for exactly this. [F for the choice.] In this sense a chapter is also a segment (2.6).

A name is a label the store maintains. It can change; old names keep working; a rename is a recorded act. You said plainly that slugs need not stay stable and a mapping is enough [J, 11-04]. A name that no longer reaches anything, or two things under one name, are failures the store must surface, never assume away. [RC1]

**Promoting.** A part can be given its own name and become a segment. Its old place now holds a pointer to it. Everything that pointed at it keeps working. [F] This is how I read "ASF's segments … legitimately mixing independent claims that should be able to have their own name and their own segment space" [J].

So there are two ways the structure grows finer, and neither breaks anything that already points in: **refine** (a leaf gets parts) and **promote** (a part gets a name).

**When the meaning of a named thing changes**, it keeps its name and identity, and its content is replaced. What pointed at it still points at it, and is thereby flagged for a second look (Part 4). [RC1. PLAN says the opposite: a changed meaning gets a new identifier. I think RC1 is right, because the other way silently detaches everything downstream. You described softening as a change to the thing in place, which matches.]

### 2.5 References: how veritoids rest on each other

A veritoid points at other veritoids through reference dimensions. A pointer is a value like any other: someone declared it, on a date, and it can be wrong. [J: "an array dimension from a claim atom to other instances' claim atoms".]

The main one is **predicated-on**: this claim needs those claims. Truth travels along it and only along it. Followed across the whole store it forms the **dependency graph**, which has no cycles. [J; PLAN adds that a cycle found there means something was cut too coarsely.]

It points at a specific part where that is what is relied on. An introduction can rest on another segment's eli8 and not on its formal claim [J]. ASF's frontmatter `depends:` pretended the whole segment depended on whole segments. That was an alias, and often a fair one, because everything else in a result is tied to its claim [J]. The model keeps the alias and stores the real pointers underneath.

A dependency can be on content alone, or on content **at a level**: "I need this to be at least independently re-derived". And even when nobody wrote the level down, there is a **latent** one: a claim cannot be better supported than what it rests on [J, 11-05]. So when a premise drops, the store should ask of everything downstream, "can this still be called a theorem?"

There are other reference dimensions. Each exists only because something treats it differently [RC1's admission rule]:

| Reference | Meaning | Does anything pass along it? |
|---|---|---|
| predicated-on | needs it to be true | credence and level limits, downward only |
| narrates | talks about it (teaching, intros, headlines) | staleness only: if the thing changes, the telling must be re-read |
| restates | says the same claim again elsewhere | the two must agree |
| seeded-by | its framing came from there | "these two checks are not independent" |
| supersedes | answers in its place now | which one is current |

Every reference says how many targets it expects. That is what gives an empty result a meaning: "needs exactly one, found none" is a defect; "any number, found none" is just the answer. [RC1]

**What happens downstream when a premise changes.** You said you could not yet comment on "rebut versus undercut". In plain terms [RC1]:

- The premise is **refuted**. Everything that used it is known-broken from that moment and shown as such, until it is re-derived without the premise or falls too. This is the hard case.
- The premise is **weakened**: narrowed, or dropped a rung, or its credence fell. Nothing downstream is thereby wrong. But what is downstream now computes a lower credence and has a lower limit on its level. Where that pushes something below what it claims, it is flagged. This is the soft case, and it is your latent-level point.

How this meets weight of evidence: weight of evidence is about how several pieces of evidence for **one** claim combine (independent lines add; lines that share a source count once). The two cases above are about how a change in **one claim** reaches **other claims**. They meet in one formula, roughly: a conclusion is at most as credible as *all its premises holding together* times *its own derivation being valid*. Refuting a premise sets the first factor to zero. Weakening one shrinks it. The exact arithmetic depends on the kind of ladder and on how the premises depend on each other, and you already marked that as open [J, 11-05].

### 2.6 Projections: chosen groupings with an order

You said every verisectorium so far has ended up with at least one canonical grouping, not always the dependency graph, "which has a coherency claim as a grouping and usually ordering" [J, 11-05]. And that the dependency graph is "distinct from projecting groups" [J, 11-05].

> **Projection.** A segment whose slots hold pointers to other segments, in a chosen order, for a purpose: a chapter, a part, a volume, a reading path, a report.

I use "projection" because you told councils-46 that for months it has meant something "between a manifestation and a group", which I take to be close to this [J]. A projection is an ordinary segment: it has a name, it can have content of its own (a chapter preface), and it has its own dimensions, above all coherence. So the nesting you described, segments into chapters into parts into volumes into one theory, each level needing to cohere [J, 11-04], is projections of projections. It needs no extra machinery.

The **canonical projection** is the one that says "this is the theory, in this order". A segment that neither the canonical projection nor the dependency graph reaches is an **orphan**. Orphans are allowed (4.4), and how many there are is something you always want to know [J].

A projection's order can disagree with the dependency order on purpose (ASF's "introduced before used" placements). Each such exception is a decision attached to that one ordering, with its reason.

### 2.7 Renderings

A **rendering** is text produced from the store for someone to read: a markdown file, a PDF, a dashboard, the view put in front of an agent about to edit. It is never the thing itself.

This is where the tension you named gets resolved: "what to get in front of the agent that is the holistic-enough picture" against "independence of parts" [J, 11-05]. Names and parts can be as fine as the truth requires. What an agent is shown can be as wide as the work requires. The two no longer constrain each other, because the file is not the unit.

A status word in a rendering is a snapshot with a time on it, never a standing fact. [RC1]

---

## Part 3. How values come to be

This part is almost all RC1. It is the part of RC1 I would keep nearly as it stands, and the part you have had the least reason to look at lately. I state it briefly so you can tell me where it has drifted from what you meant.

### 3.1 Acts and the log

> **Superseded 2026-11-05 (evening):** see `time-and-changesets.md`, written after Joseph pointed out that this section does not represent logical simultaneity. Kept as first written so the correction can be read against it.

Everything that happens is recorded as an **act**: who did it, when, about which veritoid at which exact version, by what method, against what criterion, with what result. The **log** is all acts, and it is only ever added to. A veritoid's **history** is the acts about it.

Every value is computed from the log, as of a moment. Change nothing but the moment, and a value can change (a simulation result expires when the simulator's version moves on). The same log read in any order gives the same values.

Two acts of honesty that RC1 insists on and I keep:
- **Recording too little is as dishonest as claiming too much.** If work was done and not recorded, a later reader cannot tell "never checked" from "checked and they saw a problem". So a deliberate decision not to raise something is itself recorded, with its reason.
- **There must always be a cheap way to say something tentative.** Your words, as RC1 records them: "There should always be a way for agents (including humans) to get their intuitions and tentative results known so they can be adjudicated." Where the honest in-between has no place to go, people choose between silence and overclaiming.

### 3.2 What counts as evidence, and how it combines

A check **counts** only if its pass criterion was fixed before the result was seen. Tuning until things agree is useful work and is recorded as such, but it adds no weight.

Two lines of evidence **add** only to the degree they can be shown not to share a source. The default assumption is that they do share one. Same author, same method, same seed: that is one line said twice. [RC1; your formulation.]

A checker's own stated confidence is testimony about the checker. The store computes credence from it using what it knows of that checker's record. [PLAN]

A check binds to exactly what it read, at the versions it read. When any of that changes, the check lapses, and says why. [vsect 0.1; PLAN]

### 3.3 Decisions

A decision has four dimensions of its own, never fused into one grade [RC1, from your August sessions]: on what grounds; who was consulted; who stands behind it and how firmly (supported, ratified, ruled); and what would reopen it. When a named assumption is later shown false, the decision reopens, carrying what changed.

You distinguished kinds of decision by what they are about [J, 11-04; PLAN's table]:

| About | Example | Lives as |
|---|---|---|
| the subject itself | a modelling choice in AAT | a veritoid of a decision kind |
| one veritoid's state | keeping a label after a rewording; sending two spans of an influx file to a sink | an act on that veritoid |
| where effort goes | "concentrate spikes on this scope for now" | a routing note with an expiry |
| how the store works | adding a kind | a change to the definition |

### 3.4 Limits that are declared, not earned

Some things about a veritoid are simply stated and then consulted. RC1 calls them **bounds** and I keep the idea:
- what this content is allowed to assert on its own authority (nothing new; a summary; a generalization; an original claim). This is what separates, in an ASF `impl-` segment, the sentences that restate a proved result from the ones marked "this segment's own framing";
- what a reader may do with it ("usable as a hypothesis"; "do not revive");
- whether it is safe to show an unprimed auditor.

### 3.5 Standing: who may do what

You asked what "who" means in "who has standing to mint". **Standing** is the condition under which an act counts at all. It is a yes or no asked before any question of quality. A "ruling" recorded by someone with no power to rule is not a weak ruling. It is not one. [RC1]

"Who" is the **actor**: the session or agent identity that the harness attests, which you pointed out already exists and should be read automatically, not typed [J, 11-02]. A kind's definition says, for each act, which actors have standing. Examples:
- only you may record a decision as *ruled* (RC1's meaning of that rung);
- the mind that revised a thing may not be the one that confirms it (vsect 0.1 already enforced this);
- a check by the author of the thing checked does not count as independent.

The feedback report's observation is worth keeping beside this: separation of roles (the one who spikes, the one who verifies, the one who integrates, the one who confirms are different actors) is the only constraint of this sort that ASF has actually needed so far.

---

## Part 4. Change

Everything in this part is from your messages of 11-03 to 11-05, restated. The one place I add something is marked.

### 4.1 The unit of writing is the segment

> **Superseded 2026-11-05 (evening):** see `time-and-changesets.md`, written after Joseph pointed out that this section does not represent logical simultaneity. Kept as first written so the correction can be read against it.

A veritoid is never changed alone. The basic write is a **segment changeset**: one set of simultaneous changes to parts of one segment. (This is your "instance-isolated changeset".) It may change content, change pointers, refine a part, promote a part, or create new segments.

**The write rule.** You said the inner dependencies "would have to be fully coherent and reconciled and correct … or it isn't a valid instance-change". The building-blocks write-up loosened that: a change is accepted if the slots are filled, and anything it makes stale is flagged later. I think neither is quite right, and propose [F]:

> A segment changeset must, for every part that depends on a changed part, do one of two things in the same write: bring it into line, or mark it plainly as **not yet reconciled**. It may never leave it silently as it was.

Take the example. I add a hypothesis to the formal claim. The description and the eli8 rest on it. My write must either update each, or say of each "stale against the new claim". The first is your rule. The second is the cheap tentative statement from 3.1. What is ruled out is the thing that actually happened all through the sprint: the claim moves and the paragraph beside it quietly keeps saying the old thing.

Whether the segment still **coheres** as a whole is a separate question, answered by someone re-reading it. A valid write can still leave coherence lapsed.

### 4.2 Perturbation, frontier, atomic changeset

> **Superseded 2026-11-05 (evening):** see `time-and-changesets.md`, written after Joseph pointed out that this section does not represent logical simultaneity. Kept as first written so the correction can be read against it.

The store is normally **steady**: nothing is known to be inconsistent and no rule would fire.

A **perturbation** is the first segment changeset that disturbs it: an audit finding lands, a claim is softened, a new result arrives.

The **frontier** is everything that is now known not to be consistent, computed after each further write:
- pointers whose target has moved since they were last checked;
- things claiming a level above what their premises now allow;
- parts marked not yet reconciled;
- coherence reviews that lapsed;
- questions a rule has raised that a mind must answer ("does this Part I change require changing the figure in the introduction?").

The **atomic changeset** is the whole set of segment changesets that empties the frontier, or leaves on it only what has been explicitly accepted. It is usually many segments and more than one mind can assemble in one pass, so it is built up in stages, and at every stage the frontier says what is still owed.

Only an atomic changeset may reach the steady state. In between there can be any number of checkpoints. How that is stored is undecided, by your choice; a branch that merges is one way to meet the need, not the design.

If the frontier keeps growing instead of shrinking, work stops and a group looks at the whole: keep going, split it, find the two ideas that were being treated as one, record a genuine tension between two well-supported claims, or recognize that a foundation has moved and everything above it must be redone.

Edits near the roots reach nearly everything, and edits at the leaves reach nearly nothing. Hence your point that the early material should be made as solid as possible in proportion to its age and to how much stands on it.

### 4.3 When a defect is found

Softening the claim is the natural first perturbation. It is honest, and it is the easy thing. Its quick calm is often false, because of the latent level dependencies in 2.5.

The methodology (not the engine) then asks what it would take to change the content so that the earlier level is kept. That is a second perturbation, usually larger. Whether to land the softening first and the strengthening later, or to stack them and land once, is a decision about where effort goes, made with the time available.

You were still weighing a third option: a visible mark on a value saying "a known defect probably lowers this; not yet worked through; do not rely on it". You would accept it if such marks are rare and are nearly always what is being worked on. I have not gone past where you left it.

### 4.4 Creating, connecting, orphans

A segment may be created on its own, connected to nothing. Exploratory work often does not know yet where it belongs. **Connecting** it, by a predicated-on pointer or by placing it in a projection that must then cohere, is its own perturbation and is usually where the large work is.

### 4.5 When the kinds themselves change

The definition changes too: a kind gains a slot, a dimension is split, a ladder gets a new rung. Each veritoid records which version of its kind it follows. You described the range, from cheap and reversible, through easy to apply and hard to undo, to changes that alter what "steady" can even mean for part of the store [J, 11-05], and said to let the machinery for this grow when needed. I have nothing to add except one observation: the May 2026 "audit gold lift", which wrote the same six sub-headings into 120 ASF segments in two days, was a change of this sort done by hand.

---

## Part 5. Intake: how material gets in, and how it gets retired

Mostly [PLAN] and the feedback report's measurements, placed into this structure by me.

A **source** is anything brought in from outside the store's settled content: a paper, an audit report, a spike, an old ASF file, a transcript. A source is cut into **chunks**. Each chunk gets exactly one current **crossing**: the recorded decision about where it went.

A crossing's possible outcomes, including three that the sprint used in practice and PLAN lacked:
- it changed an existing veritoid;
- it became a new veritoid;
- it was already present;
- it is one more independent arrival of something already present (which is evidence, not a duplicate);
- it was superseded, or rejected with a reason;
- it was delivered to another store;
- it is not yet decided.

From the first moment, the store records for each source whether it has been read, by whom, and how far its chunks have got. "Unread" is something you can ask for. A source is retired when every chunk has a final crossing. This is the answer to the first sprint failure.

**The inbox.** You called a segment's Working Notes "one of the most effective … higher-level mechanisms in ASF": a place where miscellany bearing on one segment collects, to be drained [J, 11-05]. RC1 has the reason it works, without connecting the two: an open item only does its job if it sits where the mind that should act on it will pass.

> **Inbox.** Every segment has one. It is a slot that anyone may add to. Its contents are chunks. It is not part of the segment's version, so adding to it or draining it never makes the segment look changed.

That last clause is the measured lesson of the sprint: the drains disposed of about two thousand Working Notes items and retired none, because the notes lived inside the text they were notes about, and nobody was allowed to touch that text. [feedback report]

Some things that sat in Working Notes were never inbox material: a regression guard ("do not restore this form; here is why it is false"), an open question with a named closer, a dead end with its reason. Those are parts of the segment in their own right, of their own kinds, and they stay.

What leaves a store for another store is a **delivery**. You said "set-asides" is a poor name and I agree.

---

## Part 6. Who does the work

You were firm that the model must not try to describe how a council works inside [J, 11-03 and 11-04]. So this is short.

Every change of a value is a **move**. A kind declares its moves: which dimension each one changes, what must be true first, and what the move writes. Each move has a **queue** of things waiting for it. A queue can be worked by more than one **mechanism**: a rule, a single agent, or a council. Which mechanism takes a given item depends on what it is and how much rests on it. A council's charter is derived from the move it serves: the dimension being moved fixes what it must produce, and importance fixes how much agreement is required [J, 11-03].

For now, whoever is working on v2 and AAT is what keeps queues moving [J, 11-04]. The engine's job is only that every queue is visible and none can fill unseen.

The second sprint failure (fixes generating findings generating fixes) is addressed in three places above: a check binds to what it read; the same mind that revised does not confirm; and the frontier, with the stop when it grows.

---

## Part 7. One picture

```
THE DEFINITION (hand-written for now)
┌──────────────────────────────────────────────────────────────────────────────┐
│ KIND ── allows 1..N ──▶ DIMENSION ── has 1 ──▶ SCALE                          │
│   │                        (evidenced | decided | attested | mixed)           │
│   │                        scale: ladder | set | number | reference           │
│   ├── declares 0..N ──▶ SLOT  (which kind · required? · one / ≤1 / any)       │
│   ├── declares ──▶ inner dependencies among its slots                         │
│   ├── declares ──▶ how the whole's values come from parts                     │
│   │                 (aliased | derived | own)                                 │
│   ├── declares ──▶ MOVEs  (dimension changed · precondition · who has standing)│
│   └── declares ──▶ BOUNDs, and whether it has an INBOX                        │
└──────────────────────────────────────────────────────────────────────────────┘

THE STORE
┌──────────────────────────────────────────────────────────────────────────────┐
│ VERITOID ── is of exactly 1 ──▶ KIND (at a version)                           │
│   ├── has content, at 1..N VERSIONs over time                                 │
│   ├── declares its GROUND ──▶ which evidence dimensions are open              │
│   ├── has 1 VALUE per open dimension     ← computed from the LOG, never typed │
│   │        (position | credence | judged value;  certainty kept apart)        │
│   ├── has 0..N PARTs, each filling 1 slot ──▶ VERITOID        (no parts: leaf)│
│   └── reference values ──▶ other VERITOIDs                                    │
│            predicated-on (no cycles) · narrates · restates · seeded-by · …    │
│                                                                               │
│ SEGMENT = a veritoid with a NAME (1 current + old names kept)                 │
│   ├── everything unnamed inside it is addressed  name#slot/slot[i]            │
│   ├── has 1 INBOX  (0..N chunks; outside its version)                         │
│   └── is written only by SEGMENT CHANGESETs                                   │
│                                                                               │
│ PROJECTION = a segment whose slots point at other segments, in order          │
│   (chapter, part, volume, the canonical projection); has its own coherence    │
│                                                                               │
│ ACT ── about 1 veritoid at 1 version · by 1 ACTOR · read 0..N (veritoid@version)│
│   LOG = all acts, append-only          HISTORY of x = acts about x            │
│                                                                               │
│ SOURCE ── cut into 1..N ──▶ CHUNK ── has ≤1 current ──▶ CROSSING (an act)     │
│                                                                               │
│ PERTURBATION ─▶ staged SEGMENT CHANGESETs ─▶ FRONTIER empties ─▶ ATOMIC CHANGESET│
│                                              (only this reaches steady state) │
└──────────────────────────────────────────────────────────────────────────────┘

OUTSIDE THE STORE:  RENDERINGs (files, views, dashboards), each a snapshot as of a moment
```

---

## Part 8. Lexicon

Words I am using, with what each replaces and what it must not be taken to mean.

| Word | Means | Replaces | Is not |
|---|---|---|---|
| **verisectorium** | a living body of work whose pieces carry their own honest support | | |
| **store** | one verisectorium's contents as v2 holds them | | not a git repo; not a directory of files |
| **definition** | the declared kinds, dimensions, moves of one store | "system model", "system definition" | |
| **kind** | a declared type of veritoid: its content form, dimensions, slots, how the whole reads from its parts, its moves | dialog: "atom kind" and "template", merged. RC1: "kind" | not "speech act"; not individuated by how it fails; not a filename prefix |
| **veritoid** | content of a kind, with its values, possibly with parts | dialog: "atom" (leaf) and "instance" (with parts). RC1 and PLAN: "record". Kernel drafts: "atom". Archived design: "statement" | not "the unit of fate". Not necessarily small |
| **content** | the text or data a veritoid holds, at a version | "body" | |
| **part** | a veritoid filling a slot of another | "section", "inner location", "typed part", "sub-record" | |
| **slot** | a declared place in a kind for a part | | |
| **leaf** | a veritoid with no parts | dialog: "atom" | not a kind of thing; a place we stopped cutting |
| **refine** | give a leaf parts | "split at grain", "grain defect repair" | |
| **segment** | a named veritoid: the unit of identity, of writing, of whole review | dialog: "instance". Your "document". RC1: "cluster", "record". PLAN: "composite" | not a file; not one fate; in ASF many are too coarse and should be several |
| **name** | a label the store keeps bound to a segment, with history | "slug", "maintained name", "binding" | not identity itself; may change |
| **promote** | give a part its own name | | |
| **dimension** | one independently answerable question about a veritoid | "aspect", "axis", "facet" | not a namespace such as "evidence" (that is only a prefix in the name) |
| **scale** | the values a dimension can take | | |
| **ladder**, **rung** | an ordered scale and its steps | "stage", "status" values | |
| **value** | a veritoid's computed state on a dimension, as of a moment | "status", "label", "standing" | never typed by hand |
| **position** / **credence** / **judged value** | what has been done / P(true) / a spread over a judged scale | PLAN's three; "certainty" loosely covered all three | none is inferred from another |
| **attribute** | a plain measurement with no judgment | | not a dimension |
| **ground** | what a veritoid declares it can be supported by, which opens its evidence dimensions | RC1: "foundation" | |
| **bound** | a declared limit that is consulted, not earned | RC1: "license", "claim license" | not a dimension |
| **reference** | a value that points at other veritoids | "edge", "link" | not a separate kind of object |
| **predicated-on** | the reference along which truth travels | "depends", "supports", "premise edge" | not the same as "appears before in the outline" |
| **dependency graph** | all predicated-on pointers; no cycles | "support web" | not a projection |
| **projection** | a segment that points at other segments in a chosen order, with its own coherence | "group", "arrangement", "composite", "navigational hierarchy", "outline", "canonical grouping" | not "any computed summary" (RC1 and councils-46 both used it that way); not a rendering |
| **coherence** | a whole's own dimension: does it hold together | | |
| **orphan** | a segment reached by no canonical projection and no dependency | | |
| **rendering** | text produced from the store for a reader | "manifestation", "document" in the file sense, "view" | never the thing itself |
| **act** | one recorded thing someone did | "event", "securing event" | |
| **log**, **history** | all acts; the acts about one veritoid | "trail", "WAL" | |
| **actor** | the attested identity that performed an act | "agent type", `--by` | not typed free text |
| **standing** | whether an actor's act counts at all | | not a degree; not PLAN's "standing" meaning all of a record's values |
| **move** | a declared way a value changes | "transition", "mover", "station" (feedback report's sense), "channel" | |
| **queue** | the things waiting for a move | "stock", "place" | |
| **mechanism** | what works a queue: rule, agent, or council | "drainer", "station" | |
| **segment changeset** | one simultaneous set of changes within one segment | your "instance-isolated changeset" | |
| **perturbation** | the first changeset that disturbs a steady store | "motivating perturbation" | |
| **frontier** | everything currently known not to be consistent | "obligations", "what is still inconsistent" | |
| **atomic changeset** | the full set of segment changesets that restores consistency | "episode" (PLAN, RC1 addendum) | "atomic" here means all-or-nothing; it has nothing to do with "atom" |
| **steady** / **in flux** | nothing inconsistent known / an atomic changeset in progress | "stable / unstable", "fixed point" | |
| **source**, **chunk**, **crossing** | incoming material; a piece of it; the recorded decision where it went | RC1: "unit" for chunk. "influx item", "disposition" | |
| **inbox** | a segment's own intake slot, outside its version | "Working Notes" (the part that is intake), "segment-local influx" | not the guards and open questions that also sat in Working Notes |
| **delivery** | material sent on to another store | "efflux", "set-aside" | |

Words I have deliberately not used: *record, atom, template, instance, group, composite, cluster, station, stock, trail, standing (in PLAN's sense), status, episode, fate*. Each has meant two or more things in the last three months.

One collision I could not avoid and you should know about: the verisectorium plan (your five steps of 11-04) uses **template** for the seed that `v2 init` applies, and **instance** for a verisectorium made from it. Since this document no longer uses either word for anything else, those two can keep that meaning.

---

## Part 9. Where I chose, and you may want otherwise

In rough order of how much rides on each.

1. *(Withdrawn as the working model; see `time-and-changesets.md`.)* **One type instead of two** (2.3). I made the small thing and the whole the same type, differing only in whether they have parts and whether they have a name. You described two things, atoms and template instances. I think the one-type reading is what "turtles all the way down, with a practical granularity" implies, and it answers three open questions from the write-up at once (does an atom keep its identity when it moves; can atoms nest; do templates go all the way up). But it is my step, not yours. If you see leaf content and assembled wholes as different in kind, this is the first thing to tell me.
2. *(Revised; see `time-and-changesets.md`.)* **The write rule** (4.1): reconcile each inner dependent or mark it not yet reconciled, never silent. Stricter than the write-up, looser than your sentence read literally.
3. **Identity survives a change of meaning** (2.4). Against PLAN.
4. **"Projection" for chapters and the canonical ordering** (2.6). *Confirmed by Joseph, 2026-11-05: "Spot on … totally on board."*
5. **"Segment" as the general word for a named veritoid**, including chapters. "Document" was the alternative.
6. **"Veritoid".** You offered it with a smile. I have used it throughout. It may not survive.
7. **Dimensions sorted by what builds them** (evidenced, decided, attested), with RC1's list of particular dimensions left as candidates. I have not tried to settle AAT's actual list of dimensions or kinds here. I think that should be done by writing kinds for real material, by hand, and seeing what breaks.
8. **The inbox outside the version** (Part 5). A statement about the model, forced by the sprint's result. Where it is physically kept is open.

## What I have not read, and what that leaves soft

- **The address theory** (`~/src/address-theory/`). RC1 says it is the careful treatment of names, pointers, things inside things, and "as of a moment", and that its definition entries are the estate's best example of a well-made multi-part thing. Sections 2.4 and 2.5 are written from RC1's summary of it, not from it.
- **`research/knowledge-graphs.md` and `research/plan-review-1.md`**: the mathematics behind credence, combination of premises, and calibration. Section 2.5's "one formula, roughly" and all of 3.2 are stated at the level I can stand behind without them.
- **ASF's `FORMAT`** and every segment type other than def-, deriv-, impl-.
- **RC1's Python interpreter**, and the theory canon that RC1 cites.
- **Councils and high-councils** beyond your own messages about them.
- Your messages before 10-28, and any session outside asf, councils and aat-v3.
