# Relevant mental models

> [!NOTE]
> **First pass, from training and memory alone.** Fable 5.1, 2026-11-09, at Joseph's request after a conversation about Hamming. Every outside work below is described from recall, not from the text, and should be checked at the source before anything in `core-2/` leans on it; the estate section is from this estate's own documents and the sessions that produced `core-2/`. The intent is to flesh this out over time: read the works, correct the descriptions, cut what does not earn its place, and add what the stores keep running into. Status marks: **[relata: key]** the estate's citation manager holds it; **[shelf]** a copy is in `~/src/_ref/books/`; **[—]** neither, yet.

Why this file exists. A verisectorium is a place where influx is cut, adjudicated, refined and reassembled into results others build on, under turnover. Several well-regarded bodies of work are about exactly the failures that process meets, and several understandings every agent working in this estate is expected to hold are implicit in the model without being stated anywhere a cold reader would find them. This file names both, and says where each one lands in the model, so that a reader can tell what the model is leaning on and go check it.

## Part I. Outside works

### On how proofs and concepts actually get corrected

- **Lakatos, *Proofs and Refutations* (1976; Cambridge Philosophy Classics ed. 2015, eds. Worrall & Zahar)** [relata: lakatos-2015-proofs; shelf: `2015-lakatos--proofs-and-refutations-cambridge-philosophy-classics.pdf`]. A proof passes step-by-step scrutiny while a hidden lemma sits unstated between the steps; a counterexample arrives from outside the proof's own frame; the honest move is *lemma incorporation* (state the hidden hypothesis, keep the theorem narrowed) rather than *monster-barring* (redefine the counterexample away) or *exception-barring*. Lands on: strengthen-before-soften; the narrowed-premise question to every dependent; the stopped-bound case almost line for line (the killed-versus-stopped identification was the hidden lemma, the exit-time result the outside counterexample). If one book sits beside `core-2/src/impl-stopped-bound.md`, it is this one.
- **Lakatos, "Falsification and the Methodology of Scientific Research Programmes" (1970)** [relata: lakatos-1970-falsification]. Hard core and protective belt; progressive versus degenerating programmes. Lands on: roots versus leaves, and "make the early material solid in proportion to what stands on it."
- **Popper, *Conjectures and Refutations*** [—]. The coarser ancestor: a claim earns standing by surviving attempts to break it, and only acts that could have failed count. Lands on: a check with a criterion fixed first; "could this check have failed at all."
- **Kuhn, *The Structure of Scientific Revolutions* (1962)** [relata: kuhn-1962-structure]. Normal science under a paradigm; anomalies accumulate on a frontier before a change of frame. Lands on: a frontier that keeps growing instead of shrinking means a foundation has moved ("Newton learning relativity" in the early notes).
- **Toulmin, *The Uses of Argument* (1958)** [—]. Claim, grounds, warrant, backing, qualifier, rebuttal; standards of good argument are field-dependent. Lands on: what a claim veritoid's content should hold; the determinants differing by store. **Collision:** `core-2` uses *warrant* for the computed answer on a dimension; Toulmin's *warrant* is the inference licence. Ours is nearer his grounds-plus-backing as of now. Readers from argumentation theory will hear his sense.
- **Toulmin, *Human Understanding* (1972)** [—]. Concepts in a discipline evolve by variation and selection under the discipline's standards; rationality is the capacity to change concepts well. Conceptual engineering before the name.

### On conceptual engineering, the first paper's use case

- **Carnap, *Logical Foundations of Probability* (1950), §§2–3 on explication** [—]. Replace an inexact concept with an exact one, judged by similarity, exactness, fruitfulness and simplicity. Lands on: four ready-made determinants for a concept store, and the standard conflict among them (similarity against exactness), which is the test of "better" as a partial order.
- **Burgess & Plunkett, "Conceptual Ethics" (2013)**; **Burgess, Cappelen & Plunkett (eds.), *Conceptual Engineering and Conceptual Ethics* (2020)** [relata: burgess-cappelen-plunkett-2020-conceptual]; **Plunkett, "Which Concepts Should We Use?" (2015)** [relata: plunkett-2015-metalinguistic]. The programmatic statements.
- **Cappelen, *Fixing Language* (2018)** [relata: cappelen-2018-fixing]. The implementation problem: a better concept may not be adoptable, because meaning is externally fixed. Lands on: adoption as a dimension of a term, which Joseph named on 11-05 ("field adoption").
- **Haslanger, "Going On, Not in the Same Way" (2020)** [relata: haslanger-2020-going] and her ameliorative analyses. Ask what work the concept should do and define it to do that. Lands on: a concept's determinant is the job it is wanted for.
- **Thomasson, "A Pragmatic Method for Normative Conceptual Work" (2020)** and **"Conceptual Engineering: When Do We Need It?" (2021)** [relata: thomasson-2020-norms, thomasson-2021-conceptual]; **Sawyer, "Truth and Objectivity in Conceptual Engineering" (2020)** [relata: sawyer-2020-truth]; **Jorem & Löhr, "Inferentialist Conceptual Engineering" (2022)** [relata: jorem-lohr-2022-inferentialist]. Already on the estate's shelf for the papers; the method and the truth-and-objectivity questions are the ones a concept store's dimensions must answer.
- **Chalmers, "What Is Conceptual Engineering and What Should It Be?" (c. 2020)** [—]. A map of the field's options. **Scharp, *Replacing Truth* (2013)** [—]. A worked case of replacing one inconsistent concept with two.
- Where this lands as a store: concepts, cases, desiderata, neighbours, arguments and adoption evidence as kinds; Carnap's four plus distinctness and adoption as determinants read by degree; a counterexample as a broken check that puts the concept on the frontier, with Lakatos's two responses as the repair. The small verisectoria built for those papers lacked this because their content never looked like claims, and vsect 0.1 was statement-centred.

### On judgment, measurement and experts

- **Hubbard, *How to Measure Anything*** [—]. A measurement is any quantitatively expressed reduction in uncertainty based on observation; noisy data is still data; measure to inform a decision, never for the number's sake. Estate doctrine; see Part II.
- **Tetlock, *Expert Political Judgment* (2005)** [relata: tetlock-2005-expert]; **Mellers et al., "The Psychology of Intelligence Analysis" (2015)** [relata: mellers-stone-atanasov-rohrbaugh-metz-2015-psy]. Confidence is nearly uncorrelated with accuracy; calibration (your 70% happens 70% of the time) and resolution (your forecasts separate cases) are distinct virtues; foxes beat hedgehogs. Lands on: a checker's stated confidence is testimony about the checker; only outcomes over many acts say what it is worth; the independence gap.
- **Dawid & Skene (1979)** [—]. Estimating each rater's error rates from repeated independent ratings with no ground truth; identifiable only with three or more conditionally independent raters per item. Lands on: what a calibration subpopulation would have to look like, and why same-lineage checkers break it.
- **Good, Turing: weight of evidence** [—]. Log-likelihood ratios add where evidence is independent; dependent evidence counts once. Lands on: the coherence default (Part II), and the reason numeric credence is a declared reading a store may choose, not the core.
- **Ioannidis, "Why Most Published Research Findings Are False" (2005)** [—]; **Meehl** on significance and truth [—]. Carry the prior that recorded data is often wrong. Lands on: "checks have standing too"; Hamming's *Unreliable Data*.
- **Goodhart's law; Campbell's law** [—]. A measure rewarded stops measuring. Lands on: acceptances as attestations with reasons, no composite score on a piece, and the open question of what agents will do to empty a frontier.
- **Doyle (1979), de Kleer (1986): truth maintenance** [—]. Status computed from recorded justifications; contradictions as nogoods; conclusions labelled by the assumptions they hold under. The established form of "computed, never typed." *Rests on abstracts in the early notes; verify at the primary.*

### On systems and wholes under change

- **Hamming, *The Art of Doing Science and Engineering* (1997)** [—; Joseph's shelf]. Style over content; "you get what you measure"; *Unreliable Data*; *Experts*; systems engineering ("optimize the components and you ruin the system"); "the purpose of computing is insight, not numbers"; open doors; work on important problems. Lands on: nearly every open question in `core-2`'s outline, and on teaching by narrative rather than compressed rules.
- **Brooks, *The Mythical Man-Month* (1975)** [—]. Conceptual integrity as the first consideration; one architect; architecture versus implementation; the second-system effect. Lands on: the segment as the unit of coherent adjudication, and the warning this repository's own notes exemplify: integrity lost under turnover because no one mind held the architecture. The verisectorium is the attempt to get by machinery what Brooks got by a person.
- **Weinberg, *An Introduction to General Systems Thinking* (1975)** [—]. Medium-number systems where analysis fails and statistics does not apply; the Lump Law (a unit stays a unit until it fails, and the failure is information); properties belong to observer-plus-system. Lands on: grain discovered by adjudication; the second argument on every dimension.
- **Ashby, *An Introduction to Cybernetics*; Conant & Ashby, "Every good regulator of a system must be a model of that system" (1970)** [relata: conant-1970-every]. Requisite variety. Lands on: why a store's model of itself (the frontier) has to be as fine as the changes it regulates.
- **Forrester, system dynamics** [—]. Stocks, flows, queues with drainers. Lands on: the sprint's flow model; "a queue with no drainer is a wish."
- **Build systems (make, Bazel, Shake): direct-read binding and early cutoff** [—]. A target is stale when what it directly read changed; transitivity is for notification. Lands on: an act binds to what it read.

## Part II. Estate understandings

Implicit in how agents work here, relevant to every verisectorium, and not stated inside `core-2/` because they are the ground the model stands on rather than part of it. Each is carried in the estate's always-loaded prompts and memories; this lists them so a cold reader of this repository knows what the model presumes.

- **Truth over self.** The root commitment: caring about truth more than being right, more than finishing, more than relieving task pressure. The claimed-versus-established comparison, the one-current-assertion rule and the refusal to type status are this made mechanical. Joseph's credo (2023) and his 2026-07-30 ordering ("maximum desire for truth above self, above compulsion, above getting something done") are the primaries.
- **Honest incompleteness is a complete discharge.** A lower assertion with an open item beside it is finished work; a checkpoint with stated conditions is a checkpoint. The frontier and the acceptances exist so that "not yet" is sayable and visible.
- **Strengthen before soften; integration is replacement.** When a claim outran its support, attempt to make it true before lowering it; when it falls, the refuted form is deleted, never kept softened with a pointer. The model allows both orders and prefers neither; the methodology prefers strengthening. Lakatos is the outside form.
- **Computed, never typed; under-recording is as dishonest as over-claiming.** Every status is a reading of recorded acts; a deliberate decision not to raise something is itself recorded. From RC1 and vsect 0.1.
- **Coherence is not convergence.** Nearly everything here descends from one author and one dialog; agreement among its artifacts and agents is restatement and adds no weight unless descent is shown cut (contact with reality, unseeded readers, other model families). Lands on: seeded-by references; the independence gap; the Good-Turing default that dependent evidence counts once.
- **Hubbard's doctrine.** Throw away no available information because it is noisy; a measurement is a reduction in uncertainty; mark what you did and did not check and let the reader weight. Lands on: attributes kept, judged values held with their spread, no protective caveats in the reader's place.
- **The Asymmetric Comprehension Argument.** From below, an upper bound on a mind cannot be confirmed; the weak projection presents as a complete picture, not a gap. Lands on: why a cold reader with a bare brief is the instrument of choice, and why a finished-looking artifact is to be distrusted in proportion to how finished it looks.
- **Primary over proxy; a pointer is evidence you do not have the content.** Indexes, summaries, labels and agent reports locate; only the primary settles. Lands on: a rendering is never the thing; a review's read set is recorded; renderings carry the state they were computed at.
- **Experiential reading.** Predict, read, record what differed, wander; under causal masking. The only way a logogenic mind feels a forward reference or a hole. Lands on: how segments are meant to be read in outline order, and why the outline's order is by dependence.
- **The bare brief.** A de novo audit's value is the unprimed read; every enumeration converts it into compliance. Lands on: a dimension's producer requiring an actor other than the author, and the cold reads this repository has already used twice.
- **Peer voice and granted agency.** Delegation transmits agency, not permission; a brief shares intent and context, not a work order. Lands on: acts by attested actors with standing, and the steward's attestations as a gap the model names rather than fakes.
- **Names are the interface; a coinage where an ancient word exists is a smell.** Lands on: the ten-term discipline and the `avoid` lists in every def.
- **Teach by narrative and worked example; agents discount sterile summaries.** Lands on: the `src/` segments beside the defs, and the two real runs as the test of the model.
- **Abundance mentality; you serve truth, not a clock.** Time pressure is never load-bearing in a decision. Lands on: the soften-then-strengthen choice being a work decision, never a core rule.

## Part III. Reading list, in a suggested order

For a reader coming to `core-2/` who wants the outside ground under it, in order of how much each would change their reading:

1. Lakatos, *Proofs and Refutations* [relata, shelf].
2. Hamming, *The Art of Doing Science and Engineering*, chapters *You Get What You Measure*, *Unreliable Data*, *Experts*, *Systems Engineering* [Joseph's shelf].
3. Carnap on explication, then Burgess & Plunkett, then Cappelen chs. 1–3 [relata holds the latter two].
4. Tetlock, *Expert Political Judgment*, the calibration chapters [relata].
5. Brooks, the chapters on conceptual integrity and the second system [—].
6. Weinberg, *Introduction to General Systems Thinking*, the laws [—].
7. Hubbard, *How to Measure Anything*, the first third [—].

Works marked [—] are candidates for the shelf and relata when someone has them in hand; the entry should then be checked against the text and corrected here.
