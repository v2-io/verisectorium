# Fast typed judgments (TypeSafe's Jev) in a verisectorium: first thoughts

*To Joseph, from the Fable 5.2 session of 2026-11-18/19, at your request, written down before it scrolled away. You asked how TypeSafe "might (or might not) be used for certain flows / adjudications that are not strictly deterministic but that could also go a lot faster than via LLM tool loops". These are thoughts and nothing more: I did not call the API, and nothing of yours was sent anywhere.*

*What they rest on: the TypeSafe skill's own guidance, read whole; and the first six thousand characters or so of four pages of its documentation (models and limits, known weak spots, question types, and the citation-check cookbook), fetched 2026-11-19. I did not read the rest of the documentation, the API reference or any SDK. The words for the model's parts are note 28's.*

## What it is, in the terms that matter here

A service that answers small typed questions about state you send with the request. Four question types: a choice among named options, the probability that a statement is true, a level on a described scale, and a box in an image. Every question in a request is answered independently and in parallel over the same state, and each answer comes back as data with probabilities. The current model is `jev-1.14.0`. Its documented limits are 64k tokens per request and 32k per question by default, with a slower and less accurate long-context mode. Input is priced per token and output is free.

Its own guidance is one sentence: judgments from the model, decisions in code. Break a decision into the snap judgments it depends on, ask each as its own question, and write the logic that combines them where it can be read and tested.

## Why it fits the model at all

**It is the model's own split.** A fast judgment is something found out, by an instrument. What to do with it is a rule, which is a decision made in advance. Note 28 keeps those apart, and so does this service's guidance, for its own reasons.

**It leaves a record an agent's read does not.** The exact question text, the state shown and the model version are small, complete and re-runnable by anyone. On 2026-11-06 you endorsed the record of what was done as the ground, with everything else a judgment over it by a stated rule that can be re-run. A question to this service is that, literally.

**"How sure" has a shape.** For the kinds of question it can answer, the answer arrives with a probability, and the middle band (their suggested starting thresholds are 0.7 and 0.3) can have its own outcome: ask a mind.

## Where I think it fits well

1. **Placing chunks when material is brought in.** Which of these candidate pieces does this chunk bear on; is what it says already said in that piece; does it claim something is wrong. High volume, low stakes per item, and the least built part of the model. It is also where an agent loop costs most.
2. **Is a gloss faithful to its passage.** Their citation cookbook is nearly the paper pilot's case: a string match in code first (is the quotation there at all), then one question on whether the passage supports, contradicts or says nothing about the claim made of it.
3. **Sentences that speak about standing.** "We prove", "verified", a ranking with no stated basis. The fresh reader of note 27 pointed out that the rule against content overstating its standing had never fired, because nothing could say which sentences were about standing. One yes-or-no question per sentence could. Hyperbole is the same question, and both belong to your third objective.
4. **Proposing reliance nobody wrote down.** Over candidate pairs: does this paragraph use that term in its defined sense; does this claim need that one. The answers are proposals for a mind to confirm, and code does the ordering (is the term met before it is used).
5. **When a piece should come to mind.** The census category the model had no place for. A check fast enough to run in a hook, before an agent acts, could ask whether a pending act matches a practice's trigger. An agent loop cannot run there. This is the most speculative item on the list.

## Where I would use it only as a screen

- **What act your words were.** Ruled, supported, leaned, a question, an aside. The spec pilot's rule already has the right shape: record the least the words support, and ask. A fast answer could decide when to ask. It should never be what is recorded. This is the gravest error in the estate, and the documentation says plainly that the model reads literally, which is the wrong failing for your register.
- **Whether two versions are the same for some purpose.** A pure reflow is settled in code. For anything else it could sort "probably unchanged" from "look", with a mind deciding.

## Where it does not fit

- **Does a claim follow.** It is built for snap judgments. It would have passed the stopped bound along with everyone else.
- **Dates, staleness, counting, anything numeric.** Their own page says to keep these in code.
- **Anything that needs the neighbourhood.** A piece and its premise fit in 32k tokens; a chapter does not, and the documentation says accuracy falls as irrelevant state grows.
- **Deciding.** By design, and rightly.

## Cautions

- **One line of evidence, of the cheapest kind.** An answer from it should be recorded as that way of asking, by that model version, and never counted as an independent check beside a mind's.
- **The version moves.** The `jev-latest` alias changes when a release ships. Evidence from it relied on a version; with an alias, that reliance moves with nobody watching. Pin the versioned id.
- **Nothing here is known to work on this material.** The estate already has labels for a small test: the citation manager's verification events with their recorded outcomes; or twenty of your sayings that you label yourself.
- **It is an outside service.** Your words and unpublished material would leave the machine. Its own guidance asks for your permission, a budget and a statement of what is sent before any test; the deny-list belongs with that.
- **Their own warning about tuning.** Wording written to produce a particular answer on particular cases breaks on new inputs and on the next version. Criteria that gain a clause per failing case, and thresholds fitted to a handful of examples, are the signs.

## Addendum, same day: a sweep for what a change touches

*You asked whether it allows a lot of context: could it have many segments loaded and, given a change, give probabilities on which are affected? Written down at your request. Still thoughts; still nothing sent.*

**The limits, from its models page.** By default 64k tokens for a whole request and 32k for any one question together with the shared state. A long-context header raises both to 262k at the same price, and the documentation says that mode is slower and less accurate. Its page on weak spots says accuracy falls when the state is large and mostly irrelevant, and advises filtering first.

**So the shape is the reverse of loading many segments.** Every question in a request sees the whole state. Two hundred segments in the state, and a question about one of them, means each answer is made with 199 irrelevant segments in view. Their own guidance says the same another way: when asking one question of many items, put each item in its own question.

- **State:** the change only. The old text, the new text, and a plain sentence or two saying what is no longer claimed.
- **Questions:** one per candidate segment, with that segment's text inside the question.
- **Batching:** as many as fit in 64k per request, with requests sent in parallel.

Each judgment then sees the change and one segment. At the listed price, my rough arithmetic for sweeping four hundred segments of two thousand tokens each is a few cents, so it could run on every change against a whole volume and not only along written references.

**What is asked matters more than how much is loaded.** "Is this segment affected" is too broad for a snap judgment. It breaks into things a person could answer at a glance:

- does this segment use the term that changed;
- does it restate the sentence that changed;
- does it rely on the claim holding in the case that was just excluded.

The third is the model's own question for a narrowed premise, "did you rely on what is gone", which nothing computes today. Writing the one or two sentences that say what is gone is itself a judgment, and it is the step I would give to a mind, or check by one.

**What comes back, and what it is for.** A probability per segment: a ranked list for a mind, with the middle band meaning "look". It is a way of finding reliance nobody wrote down, which every pilot named as the hole. Following written references stays in code, and a confirmed hit should become a written reference so the next change reaches it without a sweep.

**What it would not do.** Follow dependence through several steps; that is code's job once the pointers exist. Read dense mathematics well: their page says it does better on plain language than on low-level notation, and I have not tested it. Say that a segment is *not* affected with enough confidence to skip a check that matters.

**Where it sits in the model.** A sweep is a thing done, by an instrument at a pinned version, with the question text on record. Its answers are proposals: a high one puts a question to a piece, to be answered by a mind. A low one is not evidence that the piece is fine.

**A test with labels already in hand.** The repair of the stopped bound on 2026-10-30 has a known change and a known set of consumers that had to be re-read. Sweep that volume with the change and see whether those consumers rank at the top. It would send theory segments to the service, so it needs your go-ahead and a budget first.

**What I do not know.** Latency. How much accuracy the long-context mode loses. Whether any of this holds on your material.

## Addendum 2, same day: Joseph's framing, orientation first

His words, on reading the above: "In my mind I'm thinking of using it more of a 'prerequisite orientation' factor (along with recent heat etc. ala vivarium's verisectorium) -- gives us a very fast way (along with the even faster deterministic dependency graphs etc.) to get an agent into the right initial files with some level of confidence, knowing that it can then expand its orientation to additional things it realizes it needs as it sees fit..."

I think this is a better first use than any above. The sweep is the same (what an arriving mind is about to do, or the piece it was sent to, in the state; one candidate per question), and its answers rank what to read first, beside what the written references and recent activity already give. Three things make it the right place to start. A miss is cheap, because the agent widens its own reading afterwards and nothing is recorded as standing on the ranking. It serves the first objective directly, getting a mind to the locus of action. And it is the one use where a list selected by something other than the reader's own priors is the point: the reading the agent would have chosen for itself is the one with its blind spot in it. The cautions carry over unchanged: a low rank is not a reason to leave something unread, and the version is pinned.

## If you want a first test

The intake case, on a public store: take one real source already cut by hand, ask for each chunk which of a few candidate pieces it bears on, and compare with where it was actually placed. It sends nothing private, it is where speed matters most, and a wrong answer costs nothing because a mind was going to look anyway.
