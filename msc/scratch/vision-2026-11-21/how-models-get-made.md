# How formal models actually get made: what studies of practice and practitioners' accounts show

*Research report, 2026-11-21. Written for the Claude session working with Joseph in verisectorium, and possibly for Joseph. Sentences that are my own inference, rather than something a source says, are marked as mine.*

*How to use the footnotes.* Each main claim carries a footnote. A footnote says how I know the source: read whole, read in part (and which part), through a summarizing fetch, abstract or search snippet only, or from memory. It then gives the citation, a link, a quotation with where it sits, and what surrounds it, including anything that cuts against how I used it. The reading ledger at the end gives the same information per source.

## Revision note (later the same evening)

Joseph asked for per-claim footnotes. Writing them took me back into the sources, and some things changed. I would rather list them plainly than tidy them away:

1. **I overstated how universal the "can't say how to cut" testimony is.** The short version said "Nobody can say how they decide what to leave out." What I have is narrower: two formal-methods practitioners (Lamport; the AWS team) say it is learned only through experience or practice, and Naur argues it cannot be reduced to rules. Knuth contests a neighbouring claim of Naur's. Item 4 is rewritten.
2. **"In every rich account" was too broad.** The accounts it rests on are Knuth, Schön, Lakatos, AWS and Vincenti, and the Vincenti one is from memory. It now says "in every rich account I found," and the list is given.
3. **Knuth's "thin slice" was his students' prototype, not his own first version.** Liang and Plass implemented about 15% of the language so that it ran end to end. Knuth's own first full system was TeX78, which he later scrapped. My earlier sentence ("the first wrong version was a thin slice") invited reading it as Knuth's own first version.
4. **When Knuth wrote the TeX specification.** He did not write it "in a few weeks of summer 1977." He wrote a draft he thought complete in one week in May 1977, then a thoroughly revised definition after two weeks in July.
5. **Lakatos.** I had given "simply connected polyhedron" as the proof-generated concept. The text's own lemma-incorporating theorem is "All simple polyhedra with simply-connected faces are Eulerian." I also read more of the dialogue (Part II, around p. 138) and the Delta passage on monster-barring, so the descriptions of the moves now rest on the text, not only on my memory of the book. The point that exception-barring "excludes things for which the formula still holds" comes from the SEP entry's summary, and is now attributed there.
6. **Gowers, the SEP entry, and the *Scientific American* quotation** reached me first through a summarizing fetch. I have now checked them against the page text directly, and the quotations stand.
7. **Guindon.** "The oldest and most replicated finding in software-design protocol studies" was my characterization from memory of that literature, not something I checked tonight. It is now marked as such. Bill Wake's notes, which are my only access to Guindon, are an outline. A second fetch gave verbatim lines, which the footnote quotes.
8. **Petre and Blackwell.** I wrote that the experts' mental simulations could be "rewound." The paper says reversal was possible "in some cases."
9. **Goel: two things I had not said.**
   - The tables in my copy are garbled by OCR. I matched numbers to rows by layout and by the significance markers.
   - Goel rejects one alternative explanation of his result on theoretical grounds rather than with data: that sketching simply gives a more complete record of thinking. The footnote explains. This weakens the result somewhat.
10. **The SEP entry's authors.** While writing its footnote I first gave the authors from memory as "Larvor et al.". The page's metadata says Alan Musgrave and Charles Pigden. Corrected.

---

## The short version

1. **The finished artifact hides how it was made, and every source I found that looked closely says so.** Parnas and Clements (1986) argue that it should be hidden, but only after the rejected alternatives have been recorded.[^parnas-unreal][^parnas-rejected] Schön calls reading the end back into the beginning "historical revisionism."[^schon-revisionism] Nersessian and Greeno show that the textbook story of how Maxwell's equations were derived is close to the opposite of what Maxwell did.[^nersessian] So most "method" literature describes the fake. Records of the real process exist but are rare: protocol studies, historical reconstructions from notebooks, and a few practitioners' logs. Knuth's 865-entry error log for TeX is the best one I found.[^knuth-errors]

2. **Joseph's description of the stages shows up in the evidence, with one correction that I think matters.** Early, experts do immerse themselves in particulars: Thurston spent years building "a repertoire of constructions, examples and proofs" before he conjectured anything,[^thurston-repertoire] and Knuth typeset hundreds of pages of a real book with TeX.[^knuth-user] But the detail is in the *instances*, not in the *notation* or in commitment to a structure. Goel's controlled study found that putting expert designers into a precise drawing medium cut their moves to a genuinely different idea by more than half.[^goel] My reading: early is concrete but loosely committed, later is abstract and precise. Joseph's "a great deal of detail" fits this if the detail is examples, simulations and cases rather than formal definitions.

3. **Wrong intermediate versions are useful in two ways that pull against each other, and the stages differ in which one they need.** Early, wrongness is useful when it is cheap and ambiguous, so it can turn into something else (Goel; Gowers's rule of "lots of stupid ideas").[^goel-bulb][^gowers] Later, it is useful only when it is sharp enough that the failure can be traced to one part. That is Wimsatt's criterion, Lakatos's proof-analysis, and the AWS model checker finding the bug in a proposed fix.[^wimsatt-localize][^aws-fix] Lakatos also gives the best taxonomy I know of the ways people *mishandle* a counterexample. The worst is redefining your terms so the counterexample no longer counts ("monster-barring"). The best is letting it tell you which hidden condition your concept depended on, so that the definition is an *output* of the failure.[^lakatos-moves]

4. **Two formal-methods practitioners say the skill of leaving things out is learned only through experience, and Naur argues it cannot be reduced to rules.** Lamport: "I don't know how to teach you about abstraction."[^lamport-abstraction] The AWS team: "a difficult skill, the acquisition of which requires thoughtful practice."[^aws-skill] Naur: only someone who understands the whole can decide that a part of it is irrelevant.[^naur-relevance] On that reading, the early immersion is what earns the later right to omit; that is my inference. Joseph's "I'm not sure I can say yet" is in good company. What the sources do describe are *mechanisms* that give warranted confidence about an omission, even though no rule picks the omission:
   - Vary the detail and see that nothing you care about changes.[^levins][^aws-two-specs]
   - Be clear about *what* the detail is irrelevant to.[^wimsatt-purpose]
   - Leave the detail out of the artifact but keep its *status* in view ("it's enough to know it's over there"), and record the omission as a known risk.[^petre-variable][^lamport-cost]
   - Have an independent global check that would catch a mistake in the omitted part.[^tao-errors][^thurston-reading]

5. **I think there is a better question than "how do they decide what to cut": "what talks back?"** In every rich account I found, the version improves because something outside the modeler's head pushes back:
   - Knuth: implementation, his own use of TeX, writing the manual, and a torture test.[^knuth-theses]
   - Schön's designers: the drawing's "back-talk."
   - AWS: the model checker.
   - Lakatos: counterexamples.
   - Vincenti's history (from memory): pilots together with flight instruments.[^vincenti]

   The decisions about cutting, and about what a failure means, depend on that channel. *My inference:* a model with no such channel cannot iterate well, however disciplined its author is.

The rest of this report gives the evidence for each point, my doubts, and the reading ledger.

---

## 1. The finished account is a reconstruction, by design or by accident

**Parnas and Clements, "A Rational Design Process: How and Why to Fake It" (1986).** It is shorter and odder than its reputation suggests. They list seven reasons no real project proceeds rationally:
- people don't know what they want;
- "many of the details only become known to us as we progress in the implementation. Some of the things that we learn invalidate our design and we must backtrack";
- "until we have separated the concerns, we are bound to make errors";
- external change;
- human error;
- preconceived ideas;
- reuse.

Then: "Even the small program developments shown in textbooks and papers are unreal."[^parnas-unreal] Their proposal is to produce, at the end, the documents an ideal process *would* have produced. They point to mathematicians publishing a cleaner proof than the one they found.[^parnas-math] Two details are often lost:

- Where information is not yet available, "that fact is noted in the part of the document where the information should go and the design proceeds as if that information were expected to change."[^parnas-unavailable]
- Their faked documentation deliberately departs from the ideal in one way: they record "all of the design alternatives that we considered and rejected," with reasons.[^parnas-rejected]

So even the canonical case for hiding the process keeps the dead ends, in a separate place.

**Schön (1992)** names the error that results from taking the polished version at face value: assuming the objects and relations were given at the start is "historical revisionism: reading back onto the beginning of a process what has emerged only at its end."[^schon-revisionism]

**Nersessian and Greeno (1990).** Textbooks present Maxwell as adding the displacement-current term because formal consistency required it for open circuits. What actually happened was a sequence of physical models:
- Faraday's lines of force, with a quantitative law that was wrong because it counted lines as discrete;
- Maxwell's fluid in tubes;
- vortices, which jam if neighbours spin the same way, so he added "idle wheels" between them, made them rigid for calculation, then elastic again.

Their conclusion: "Considerations of formal consistency, as presented in textbooks, played no significant role in this analysis."[^nersessian]

**Lakatos** wrote that "actual history is frequently a caricature of its rational reconstructions."[^lakatos-caricature] *Proofs and Refutations* is itself a rational reconstruction; its footnotes carry the real history.

**Thurston (1994)** says the definition-theorem-proof picture "doesn't explain the source of the questions." What mathematicians actually produce is understanding, and formal statements are a lossy encoding of it.[^thurston-evaporate] **Naur (1985)** makes the same point about programs: the "theory" the programmers hold is primary, and "reestablishing the theory of a program merely from the documentation, is strictly impossible."[^naur-revival] Knuth disagrees with that last claim on the strength of literate programming.[^knuth-naur] So the claim that the finished artifact *cannot* carry the process is contested. The claim that it usually *does not* is not.

**What follows for your question:** you were right to distrust method books. These are the places where the actual process is visible:
- **Protocol studies**, in which designers think aloud through tasks of one to two hours: Guindon; Goel; Ball et al.; Dorst and Cross; Adelson and Soloway; Petre.
- **Historical reconstructions from notebooks**: Nersessian on Maxwell; Lakatos on Euler's formula; Holmes on Krebs; Gruber on Darwin's notebooks; Vincenti on flying-quality specifications. I read the first two in part. The others I know from memory or citation.
- **Practitioners' logs and candid accounts**: Knuth; the AWS paper; Thurston.
- **Public working records**: Gowers's Polymath projects, called possibly "the first fully documented account of how a serious [math] research problem was solved, complete with false starts, dead ends, etcetera."[^polymath] The blog threads and wiki are open to read. I did not read them.

## 2. What the process looks like

### Opportunistic, not top-down

A finding repeated across software-design protocol studies (this is my memory of that literature, not something I checked tonight) is that experts do not decompose top-down. I did not get the primary text of **Guindon (1990)**. From Bill Wake's notes on it:[^guindon]
- Designers jumped to low-level solutions before decomposition was complete.
- The jumps came when the artifact was new to them, when several knowledge sources had to be integrated, or when a subproblem was critical, very different from the rest, or had a solution they already knew.
- New requirements turned up mid-design, and about 60% were solved on the spot.

**Ball, Onarheim and Christensen (2010)**, which I know only from an abstract-level summary:[^ball] software designers first made a rough breadth-first solution covering the easy requirements, then went depth-first on hard ones with long mental simulations. The switch tracked rising *epistemic uncertainty*. *My reading:* this bears on Joseph's "inhabit in detail" if what gets inhabited is chosen, deep where you are unsure and shallow where you are not.

### Early: concrete particulars, low commitment

Several independent sources describe the early phase as rich in particulars:
- **Thurston** spent years building "a repertoire of constructions, examples and proofs" before conjecturing geometrization.[^thurston-repertoire]
- **Lamport**'s practical advice on choosing an abstraction is to start concrete: "start by writing the first few steps of one or two sample behaviors."[^lamport-sample]
- **Adelson and Soloway** (abstract only): in an unfamiliar domain, experts built less detailed mental models and ran more local, less global simulations.[^adelson]
- **Petre and Blackwell**: ten expert programmers, questioned mid-design at moments of inward focus. All described a dynamic mental simulation, a "machine in the mind," which they could slow, stop and move around inside, and in some cases reverse.[^petre-machine]
- **Knuth**: "I had to put myself in the rôle of a regular user; there is no substitute for such experience, when a new system is being designed." He added an enhancement for roughly every six pages he typed.[^knuth-user]

But **Goel (1992)** adds a caution. Nine expert designers each did two one-hour tasks, one by freehand sketching and one in MacDraw with the freehand tool off and the grid on. With the precise tool they made far fewer *lateral* transformations, which he defines as moves to a different idea rather than to a more detailed version of the same one. They also reinterpreted earlier drawings far less often. Measures of ease (session length, number of episodes, number of new solutions) did not differ. His description: in MacDraw a new idea's "external representation ... serves to fixate and stifle further exploration."[^goel]

*My reconciliation, which is inference and not a finding:* the early detail experts immerse themselves in is detail of the domain and its instances, held in a loose, reinterpretable medium. What they avoid early is precision of representation and commitment. If that is right, a strict formal notation used during the exploratory phase could cost exactly the lateral moves that find the good version. Petre's experts said something similar in their own words: images "don't carry the baggage of the paradigm."[^petre-paradigm] The AWS team arrived at a practical version of this: prose design first, then "incrementally refining parts of it into PlusCal or TLA+."[^aws-prose]

### Problem and intention are outputs, not inputs

In Schön's case of the student Petra, she makes a move to fix one quality and discovers unintended consequences, some of which she likes: "An evolving intention is one of the outputs of her designing."[^schon-intention] **Dorst and Cross (2001)** (abstract only) model creative design as the *co-evolution* of problem and solution.[^dorst] Knuth: "writing a new sort of program implies continually revising the specifications."[^knuth-revising]

**Vincenti's** chapter on American flying-quality specifications from 1918 to 1943 is, as I remember it, the clearest case I know of a specification for something new that took decades to find.[^vincenti]

## 3. Wrong intermediate versions

### They are the norm, and good practitioners count them

- **Knuth's** log for TeX has 865 entries. He counts enhancements as errors too, "for if I had designed a perfect system in the beginning I would not have made any of these changes."[^knuth-errors]
  - He wrote a draft design he thought "pretty complete" in a week in May 1977, and a thoroughly revised definition in July. When he sat down to code it: "I encountered loose ends every 15 minutes or so."[^knuth-spec]
  - Later he scrapped the whole first system, TeX78, once it had "served [its] purpose of accumulating enough user experience to indicate what such languages ought to be."[^knuth-scrap]
  - He recommends everyone keep such a log, at "less than 1%" extra time.[^knuth-log]
- **Brooks (1975):** "one has to build a system to throw away, for even the best planning is not so omniscient as to get it right the first time."[^brooks75] In 1995, which I saw only quoted, he revised this: build-one-to-throw-away assumes the waterfall model, and with incremental development the throwing away happens continuously.[^brooks95]
- **AWS:** a reviewed fix for a known bug, once modeled, still failed "via a different execution trace."[^aws-fix]

A detail from Knuth's account: his *students'* summer prototype implemented only about 15% of the language, but "they had chosen their subset wisely, so that a small test program could run from start to finish. Hence it was easy for me to imagine what a complete system would entail."[^knuth-slice] So the first thing built was a thin slice that ran end to end, not a complete layer. (Knuth's own first full version came after that, and it too was eventually thrown away.)

### Two ways wrongness helps, which pull against each other

**Early: cheap, ambiguous, transformable.** Goel's sketch is valuable because a mark can be reread: a head becomes a light bulb.[^goel-bulb] Gowers's ground rules for Polymath: "When you do research, you are more likely to succeed if you try out lots of stupid ideas," where "stupid" means "not fully thought through"; and "resist the temptation to go away and think about something and come back with carefully polished thoughts."[^gowers]

**Later: sharp enough that the failure points at something.** Wimsatt: "The primary virtue a model must have if we are to learn from its failures is that it ... [is] structured in such a way that we can localize its errors and attribute them to some parts, aspects, assumptions, or subcomponents of the model."[^wimsatt-localize] He ranks kinds of falsity. Idealizations, and incomplete models whose included variables are roughly right, are the most productively wrong. A "totally wrong-headed" model, or one that just fails to fit, is not.[^wimsatt-falsity] And: "Isn't it always better to have a true model than a false one? Naturally it is, but this is never a choice that we are given."[^wimsatt-falsity]

*My inference:* the transition between stages may partly be the moment you switch from wanting your wrong versions to be reinterpretable to wanting them to be diagnosable. A medium good for one is bad for the other.

### What to do when a counterexample arrives: Lakatos

*Proofs and Refutations* (BJPS 1963–64; book 1976) follows the history of Euler's V − E + F = 2 as a classroom dialogue. For your question, its value is a catalogue of responses to a counterexample, most of them bad:[^lakatos-moves]
- **Monster-barring:** redefine "polyhedron" so that the counterexample doesn't count. The naive conjecture survives in words while its terms change meaning underneath.
- **Exception-barring:** retreat to a safe domain, such as "all convex polyhedra are Eulerian." Lakatos's Teacher objects that this "introduced an element which is really extraneous to the argument: convexity." (The SEP entry adds that such restrictions also exclude cases for which the formula still holds.)
- **Monster-adjustment:** reinterpret the counterexample so that it becomes an example.
- **Lemma-incorporation,** which he later proposes to rename the "method of proof and refutations": find which lemma of the proof the counterexample refutes, and make that lemma an explicit condition.

His heuristic rules:[^lakatos-rules]

> Rule 1. If you have a conjecture, set out to prove it and to refute it. Inspect the proof carefully to prepare a list of non-trivial lemmas (proof-analysis); find counterexamples both to the conjecture (global counterexamples) and to the suspect lemmas (local counterexamples).  
> Rule 2. If you have a global counterexample discard your conjecture, add to your proof-analysis a suitable lemma that will be refuted by it, and replace the discarded conjecture by an improved one that incorporates that lemma as a condition. Do not allow a refutation to be dismissed as a monster. Make all 'hidden lemmas' explicit.  
> Rule 3. If you have a local counterexample, check to see whether it is not also a global counterexample. If it is, you can easily apply Rule 2.

The concepts that result, such as "simple polyhedra with simply-connected faces," are "proof-generated." They are produced by the failures, and are hard to understand without the history that made them.[^lakatos-proofgen] For a project whose product is definitions, I think this is the most directly relevant source here. In this picture a counterexample to a definition is how the right definition gets found, and not something to tidy away.

The dialogue also has a character who has had enough: "pencil-sharpening is not creative mathematics."[^lakatos-pencil]

### Using a model you don't believe: Maxwell

From "On Physical Lines of Force" (1861), about his idle-wheel particles: "I do not bring it forward as a mode of connexion existing in nature ... It is, however, a mode of connexion which is mechanically conceivable, and easily investigated ... any one who understands the provisional and temporary character of this hypothesis, will find himself rather helped than hindered by it."[^maxwell1861]

Displacement current came out of this machinery. In "A Dynamical Theory of the Electromagnetic Field" (1865) the vortices and idle wheels are gone, though historians disagree about how far the mechanical analogy kept guiding him.[^maxwell1865] This is the cleanest historical case I found of leaving detail out with confidence: scaffolding explicitly labelled provisional while it was in use, then dropped once the structure it had helped find could stand on its own.

### What gets kept from the failures

- Parnas and Clements keep the rejected alternatives, with reasons.[^parnas-rejected]
- Knuth keeps a complete log.
- Lakatos puts the history in footnotes.
- Polymath keeps everything in public.

Thurston gives the cost of *not* keeping the path. His foliations papers "documented top-level reasoning and conclusions," and the field emptied. For geometrization he deliberately published infrastructure and ways of thinking instead.[^thurston-foliations]

## 4. Leaving detail out

### What practitioners say: learned by experience, not taught

**Lamport:** "The hardest part of writing a specification is choosing the proper abstraction. I can teach you about TLA+ ... But I don't know how to teach you about abstraction ... The art of abstraction is learned only through experience."[^lamport-abstraction] His worked example also shows a posture toward omission. He ignores the fact that voltages on different wires don't change at the same instant, and says exactly what that costs: "you won't learn that from my specification."[^lamport-cost]

**The AWS team:** "The designer must ensure that the model captures the significant aspects of the real system. Achieving this is a difficult skill, the acquisition of which requires thoughtful practice."[^aws-skill]

**Naur** gives a reason it can't be reduced to rules: "the decision that a part of the world is relevant can only be made by someone who understands the whole world."[^naur-relevance] He grounds this in Ryle: the relevant similarities "are not, and cannot be, expressed in terms of criteria."[^naur-relevance]

That is two practitioners' testimony and one argument, not a survey. But Lamport is writing a textbook meant to teach exactly this, which makes his admission weigh more.

### Mechanisms that warrant confidence in an omission

**a. Vary it and watch.** Levins: treat the problem "with several alternative models each with different simplifications but with a common biological assumption"; a result that survives is a "robust theorem ... relatively free of the details of the model. Hence our truth is the intersection of independent lies." His map image is the one I find most useful for telling which details mean something. Contiguity on a map means something, "but color is arbitrary and a microscopic view of the map would only show the fibers of the paper"; in models, "it is not always obvious when we are using too high a magnification."[^levins]
- Wimsatt lists the same use: to "determine assumptions that are irrelevant to a given conclusion."[^wimsatt-irrelevant]
- AWS stumbled on a version of it: two independent specs of one algorithm, "quite different in style," "both found the same bug."[^aws-two-specs]
- Jackson's "small scope hypothesis" for Alloy is the bounded-checking form.[^jackson]

**b. Ask what it is irrelevant *to*.** Wimsatt: what models are acceptable and what counts as a close enough fit "is a function of the purposes for which the models and data are employed."[^wimsatt-purpose] Weisberg separates three warrants for idealization, which I know only from summaries:[^weisberg]
- Galilean: leave out what you intend to add back later.
- Minimalist: keep only the factors that make a difference to the phenomenon.
- Multiple-models: expect no single best model.

*My inference:* each gives a different kind of confidence, and mistaking one for another is a likely source of error.

**c. Omit from the artifact, keep the status in view.** Petre and Blackwell's experts: "Information outside the focus might be undefined, or unsolved, or soluble, or solved; mainly, it was deemed not important at the moment. 'I don't need to think about that; it's enough to know it's over there...'"[^petre-variable] In this account, confident omission is not forgetting; it is knowing what is there and what state it is in. Written analogues:
- Parnas's "note the fact where the information should go";[^parnas-unavailable]
- Lamport naming the cost of his omission;[^lamport-cost]
- AWS writing down "all of the properties of the environment on which the system relies."[^aws-env]

**d. Have a global check that would catch a local slip.** Tao: post-rigorous arguments can be locally full of "typos and other formal errors, but ... globally quite sound, with the local errors propagating for a while before being cancelled out by other local errors." Without intuition to check it, an error can "propagate out of control."[^tao-errors] Thurston: people "are quite good at detecting potential weaknesses or flaws in proofs" though not at checking formal correctness.[^thurston-reading] *My inference:* detail can be left out with confidence where something else (intuition about invariants, a model checker, a second model) would notice if leaving it out broke something.

**e. Work one domain at a time and let back-talk bring in the rest.** Schön: "Working initially in one domain, however, she can allow considerations in other domains to enter into her work piecemeal as she discovers the unintended consequences of her moves."[^schon-piecemeal] Here omission comes *before* confidence, and the situation tells you which omissions you cannot afford.

### Tao's stages, and Joseph's

Tao's three stages (pre-rigorous, rigorous, post-rigorous) read almost like Joseph's account.[^tao-stages] But Tao describes a mathematician's development over years, not the course of one project.

*My conjecture, which I have not seen tested:* a single project with a new subject may recapitulate the sequence. You start pre-rigorous about the new thing even if you are post-rigorous in general. You then pass through a stretch where precision destroys some intuitions. Leaving things out with confidence becomes available only once the heuristic and formal versions suggest each other.

## 5. Questions I think may be better than the ones you asked

These are offered as possibilities, not corrections.

1. **"What talks back, and how fast?"** rather than "how do they decide what to cut." Knuth's first thesis is "TeX would have been a complete failure if I had merely specified it and not participated fully in its initial implementation." He adds that writing the manual "gave me views of the system that I never would have perceived if I had merely designed it, implemented it, and used it."[^knuth-theses] For a formal model of a *practice*, the question becomes: what plays the role of implementation and use?
2. **"What is this detail irrelevant *to*, and what experiment would show it?"** This turns an act of taste into something checkable (§4a–b).
3. **"Is this stage's medium the right grain?"** Goel's result is that the formality of the medium changes which moves you make.
4. **"When a counterexample arrives, which Lakatos move am I about to make?"** Monster-barring is the characteristic failure of definition-building, because it always looks like tidying.
5. **"Where will the record of the wrong versions live, and what does it need to say?"**
6. **"Who holds the theory?"** (Naur). If the understanding lives in minds, then delegating the specification without the theory runs into Knuth's "loose ends every 15 minutes."

## 6. Doubts and limits of the evidence

- **The controlled studies are small, short, and cover only the early phase.** Goel had nine designers; Petre and Blackwell, ten; Dorst and Cross, nine; Guindon analysed a handful of protocols. Sessions of one to two hours on toy briefs. None follows a *formal model* built over months. The long-run evidence is historical reconstruction and retrospectives by practitioners, which are open to exactly the rationalization this report is about. Petre and Blackwell themselves note that "experts are well-known for rationalizing their practice 'on-the-fly'."[^petre-rationalize]
- **Survivorship.** The candid accounts are all by people whose projects worked.
- **"Something new."** Most design-protocol tasks are new to the participant but not new in kind. Joseph's case is closer to Maxwell, Vincenti, Lakatos's polyhedra and Knuth's "new sort of program."
- **My reconciliation of "detail early" with Goel's "coarse early" is inference.** No study I found tests it directly.
- **Goel's single controlled result is weaker than its numbers look.** It has nine participants and one-tailed tests, and he rules out the "more complete record" explanation on theoretical grounds rather than with data.[^goel]
- **I haven't read `core/`.** The section below is a guess from the praxis file and memory-index lines that were in my context.

## Where this might touch the project (guesses from outside)

- "Add a term only when a word earns it," written after a first core that "reached eighty-five terms defined against one another before any example was run," reads like Goel's premature crystallization, and like Lakatos's definitions arriving ahead of the counterexamples that should generate them.
- A memory-index line says building an instance from core alone tests it better than reading it. That is Knuth's thesis about implementation and use.
- `log.kdl`, the history surfaces and the Working Notes surfaces correspond to Parnas's record of rejected alternatives and to Knuth's error log.

One question I can't answer from here: does `bin/defs check core`, a well-structured representation in Goel's sense, run during the exploratory phase too? Goel's data would predict that it suppresses lateral moves if strict well-formedness is required before an idea can be written down at all.

---

## Reading ledger

**Read whole, myself:** Parnas & Clements 1986; Thurston 1994; Tao (essay and addendum); Naur 1985; the AWS 2014 paper; Goel 1992; Knuth's 1989 TUGboat keynote.

**Read in substantial or targeted part, myself:**
- Knuth, *The Errors of TeX*: history sections, pp. 610–622.
- Wimsatt: framework, kinds of falsity, the twelve uses. I did not read the Morgan–Castle case study.
- Schön 1992: first half.
- Petre & Blackwell 1997: most of it.
- Nersessian & Greeno 1990: most of the body.
- Lakatos, BJPS 1963: contents; Part I, pp. 14–15 (Delta on monster-barring); Part II, pp. 137–138 (the Teacher's summary of the methods); Part III, pp. 228–230 (rules, Alpha).
- Levins 1966: pp. 422–423.
- Lamport, ch. 3 sample: pp. 23–25.
- Maxwell 1861: the idle-wheel passage, on Wikisource.
- Brooks 1975: ch. 11 passage.
- SEP "Imre Lakatos", Gowers's 2009 post, and the *Scientific American* Polymath piece: first through a summarizing fetch, then the quoted passages checked against the page text.

**Through a summarizing fetch only:** Bill Wake's 1994 notes on Guindon. Two fetches; the second gave the verbatim lines quoted in the footnote.

**Abstracts, search snippets or secondary citation only:** Guindon 1990; Ball, Onarheim & Christensen 2010; Adelson & Soloway 1985; Dorst & Cross 2001; Atman et al. 2007; Weisberg 2007; Brooks 1995; Gowers & Nielsen, *Nature* 2009; Jackson on Alloy; Longair 2015 and the Springer AHES article on Maxwell; Alexander 1964; Feynman–Weiner via Gleick; the process-of-process-modeling studies (Pinggera, Soffer et al.).

**From memory only:** Vincenti, ch. 3; Holmes on Krebs; Gruber on Darwin; the general character of the software-design protocol literature.

Full citations and links are in the footnotes. For sources not footnoted:
- Atman et al., *J. Eng. Educ.* 96(4), 2007, finds that experts spent more time on problem scoping. I did not use it.
- Alexander, *Notes on the Synthesis of Form*, 1964, on recognizing good fit only through misfits, is seen only in secondary quotation. It belongs beside Schön.
- The process-of-process-modeling studies (about 2011–2015) watch people build formal BPMN models from a given text. They are the only studies I found that observe *formal* models being built, but their subject matter is given rather than new. A lead, if you want it.

## Feedback on the brief

The brief worked well for me. The explicit permission to find that the questions were wrong produced §5, and the request to say what I read made me more careful. One thing I would have liked to know is what kind of "new" you mean. If the real target is a formal model of a *practice or institution*, there may be a closer literature (ethnographies of standards-writing or legal drafting, conceptual-modeling research), and I would look there next.

Writing the footnotes was worth doing beyond what the ledger gave. Going back to the sources turned up the nine changes listed at the top. The ledger alone would not have caught any of them, because it records which sources I read, not whether each claim matches what its source says.

I'm available for follow-up questions.

---

[^parnas-unreal]: **Read whole** (local PDF of the paper). Parnas, D. L. & Clements, P. C., "A Rational Design Process: How and Why to Fake It," *IEEE Trans. Software Eng.* SE-12(2):251–257, 1986. <https://userweb.cs.txstate.edu/~rp31/papers/Fake_it.pdf>. §II: "Even the small program developments shown in textbooks and papers are unreal. They have been revised and polished until the author has shown us what he wishes he had done, not what actually did happen." *Context:* this closes their list of seven reasons a rational process is impossible. §III then argues the idealized process is still worth describing, and the rest of the paper prescribes documents. Their concern is documentation for maintainers and reviewers, not an account of how good designs are found. So they are a witness to the gap between finished account and process, not a study of the process.

[^parnas-rejected]: **Read whole.** Parnas & Clements 1986, §VII "Faking the Ideal Process": "Our documentation differs from the ideal documentation in one important way. We make a policy of recording all of the design alternatives that we considered and rejected. For each, we explain why it was considered and why it was finally rejected. Months, weeks, or even hours later, when we wonder why we did what we did, we can find out." *Context:* the justification is entirely about later readers, including the authors themselves.

[^parnas-unavailable]: **Read whole.** Parnas & Clements 1986, §VII: "If a piece of information is unavailable, that fact is noted in the part of the document where the information should go and the design proceeds as if that information were expected to change." Their requirements-document criteria (§V.A.2) say the same: "Where information is not available before development must begin, the areas of incompleteness should be explicitly indicated."

[^parnas-math]: **Read whole.** Parnas & Clements 1986, §VII: "Mathematicians diligently polish their proofs, usually presenting a proof very different from the first one that they discovered. A first proof is often the result of a tortured discovery process."

[^schon-revisionism]: **Read in part** (first half, through the Petra case and "Seeing Patterns"). Schön, D. A., "Designing as Reflective Conversation with the Materials of a Design Situation," *Research in Engineering Design* 3:131–147, 1992. <https://www.uio.no/studier/emner/matnat/ifi/IN1060/v25/pensum/schon_design-conversation.pdf>. §1, p. 132: "Students of designing can avoid dealing with design worlds and their construction only by assuming counterfactually that objects and relations are given as 'inputs' with the first presentation of a design situation. This assumption reflects what the Marxists have called 'historical revisionism': reading back onto the beginning of a process what has emerged only at its end." *Context:* the paper is addressed to AI-in-design researchers. His target is a *modelling* assumption, that the problem's objects are given, which makes it closer to our case than a complaint about textbooks would be. He illustrates with Wertheimer's parallelogram.

[^nersessian]: **Read in part** (most of the body). Nersessian, N. J. & Greeno, J. G., "Multiple Abstracted Representations in Problem Solving and Discovery in Physics," *Proc. 12th Annual Conf. Cognitive Science Society*, 1990, pp. 77ff. <https://escholarship.org/uc/item/0p42x70s>. pp. 79–80: "It then took him nine months to figure out how to represent the final (and most critical) piece of the problem: electrostatic actions." And: "Considerations of formal consistency, as presented in textbooks, played no significant role in this analysis." *Context:* they call this "an exceedingly compressed version of the actual process" and refer to Nersessian's fuller analyses (1984, 1986), which I did not read. On Faraday: "the only quantitative measure he introduced is between the number of lines cut and the intensity of the induced force. This relationship is incorrect, because 'number of' is an integer while 'field intensity' is a continuous function."

[^lakatos-caricature]: **Read in part** (SEP entry; first through a summarizing fetch, then this passage checked in the page text). Musgrave, A. & Pigden, C., "Imre Lakatos," *Stanford Encyclopedia of Philosophy*. <https://plato.stanford.edu/entries/lakatos/>. Quoting *Proofs and Refutations* p. 21: "actual history is frequently a caricature of its rational reconstructions." *Context:* Lakatos says this about a footnote noting that a character's historical claim is "historically false" though "heuristically correct." The SEP entry adds that critics protested the reverse: rational reconstruction is a caricature of real history.

[^thurston-evaporate]: **Read whole.** Thurston, W. P., "On Proof and Progress in Mathematics," *Bull. AMS* 30(2):161–177, 1994. <https://arxiv.org/abs/math/9404236>. §1 on the definition-theorem-proof model: "A clear difficulty with the DTP model is that it doesn't explain the source of the questions." §2, after listing seven ways of thinking about the derivative: "Unless great efforts are made to maintain the tone and flavor of the original human insights, the differences start to evaporate as soon as the mental concepts are translated into precise, formal and explicit definitions."

[^naur-revival]: **Read whole.** Naur, P., "Programming as Theory Building," *Microprocessing and Microprogramming* 15:253–261, 1985. <https://ingenieria-de-software-i.github.io/assets/bibliografia/programming-as-theory-building.pdf>. §6: "A very important consequence of the Theory Building View is that program revival, that is reestablishing the theory of a program merely from the documentation, is strictly impossible." *Context:* his evidence is two cases from experience (a compiler handed between groups; a large real-time system's fault-finding team), not a study.

[^knuth-naur]: **Read whole.** Knuth, D. E., "Notes on the Errors of TeX," keynote, *TUGboat* 10(4):529–531, 1989. <https://tug.org/TUGboat/tb10-4/tb26knut.pdf>. "My experiences agree well with Peter Naur's hypothesis that programming is 'theory building' ... But I do not share Naur's unproved assertion that 'reestablishing the theory of a program merely from the documentation is strictly impossible.' On the contrary, I believe that improved methods of documentation (which I have called 'literate programming') are able to communicate everything necessary for the maintenance and modification of programs."

[^polymath]: **Read in part** (the *Scientific American* blog page; the passage checked in the page text). "Project Polymath: Collaborative Mathematics through Blogs," *Scientific American* Degrees of Freedom blog. <https://www.scientificamerican.com/blog/degrees-of-freedom/project-polymath-collaborative-mathematics-through-blogs/>. "As Gowers wrote on his blog, Polymath may be 'the first fully documented account of how a serious [math] research problem was solved, complete with false starts, dead ends, etcetera.' Or, as Tao puts it, the project was valuable because it showed 'an example of how the sausage is made.'" I did not find or read the Gowers post the quotation comes from. Wiki: <https://michaelnielsen.org/polymath1/>. I have not opened it; the address is from memory.

[^guindon]: **Summarizing fetch only** (two fetches). Wake, W. C., "Notes on Guindon – 'Designing the Design Process'" (the page title misspells "Guidon"), posted 16 Sept 1994. <https://xp123.com/?p=697>. When asked for verbatim lines, the second fetch returned: "Immediate solution development for new requirements (60% of new requirements solved immediately)"; and, under "Deviations Occur When…": "Artifact is new to designer", "Integration of multiple knowledge sources", "Subproblems appeared" that were "critical," "very different, or" "had an immediately known solution." The notes are an outline, and Wake doubts whether strict top-down design was more than a strawman. The paper: Guindon, R., "Designing the Design Process: Exploiting Opportunistic Thoughts," *Human-Computer Interaction* 5:305–344, 1990. I have not seen it.

[^ball]: **Abstract-level search summary only.** Ball, L. J., Onarheim, B. & Christensen, B. T., "Design requirements, epistemic uncertainty and solution development strategies in software design," *Design Studies* 31:567–589, 2010. Record: <https://orbit.dtu.dk/en/publications/design-requirements-epistemic-uncertainty-and-solution-developmen/>. My text paraphrases the summary. I have no quotation from the paper.

[^thurston-repertoire]: **Read whole.** Thurston 1994, §6: "I gradually built up over a number of years a certain intuition for hyperbolic three-manifolds, with a repertoire of constructions, examples and proofs. (This process actually started when I was an undergraduate, and was strongly bolstered by applications to foliations.) After a while, I conjectured or speculated that all three-manifolds have a certain geometric structure." *Context:* he immediately adds that his style is "not one of making broad sweeping but careless generalities ... I make clear mental models, and I think things through." The years of examples were not loose thinking.

[^lamport-sample]: **Read in part** (pp. 23–25 of the sample chapter). Lamport, L., *Specifying Systems*, Addison-Wesley, 2002, ch. 3. <https://ptgmedia.pearsoncmg.com/images/032114306X/samplechapter/lamportch03.pdf>. "When writing a specification, you must first choose the abstraction ... To help make these choices, I recommend that you start by writing the first few steps of one or two sample behaviors, just as I did at the beginning of this section. Chapter 7 has more to say about these choices." I have not read chapter 7.

[^adelson]: **Abstract via search summary only.** Adelson, B. & Soloway, E., "The Role of Domain Experience in Software Design," *IEEE Trans. Software Eng.* 11(11):1351–1360, 1985. The summary reported less detailed mental models and more local simulation in the unfamiliar domain, and global simulation as related to domain experience. No quotation.

[^petre-machine]: **Read in part** (most of the paper). Petre, M. & Blackwell, A. F., "A Glimpse of Expert Programmers' Mental Imagery," in *Empirical Studies of Programmers: Seventh Workshop*, 1997, pp. 109–123. The venue is from memory, consistent with the page numbers on my copy. <https://courses.cs.duke.edu//fall00/cps189s/readings/petre-expert.pdf>. §5.5: "All of the experts described a sort of dynamic mental simulation, a 'machine in the mind'." §6.1: "All of the images were described as dynamic, but subject to control, so that the rate could be varied, or the image could be frozen. In some cases, the activity could be reversed." *Method:* ten experts with ten or more years' experience, prompted at signs of inward focus with questions like "What do you see?" and "What colour is it?". These are introspective reports, and the authors are cautious about them themselves.

[^knuth-user]: **Read in part** (history sections). Knuth, D. E., "The Errors of TeX," *Software—Practice and Experience* 19(7):607–685, 1989. <https://yurichev.com/mirrors/knuth1989.pdf>. p. 622: "I had to put myself in the rôle of a regular user; there is no substitute for such experience, when a new system is being designed." On pp. 621–622, between 13 May and 22 June he "processed about 250 pages, and added 69 new entries to the log," 29 bugs and 40 enhancements, "a regular rate of about one enhancement for every six pages typed." The book was the 700-page second volume of *The Art of Computer Programming*.

[^goel]: **Read whole.** Goel, V., "'Ill-Structured Representations' for Ill-Structured Problems," *Proc. 14th Annual Conf. Cognitive Science Society*, 1992, pp. 130–135. <https://escholarship.org/uc/item/3wz7c4nd>.
    - *Design:* nine expert industrial and graphic designers, each doing two one-hour sessions (freehand, versus MacDraw 1.9.5 with "the freehand tool turned off and the grid turned on").
    - *Results, freehand versus MacDraw, per session:* syntactic lateral transformations 8.9 vs 3.2; semantic lateral transformations 8.0 vs 3.9; reinterpretations 2.4 vs 0.67; p < .05 one-tailed. The OCR of the tables in my copy is scrambled; I assigned numbers to rows by layout and by the significance markers, and I am fairly but not fully sure of the assignment. Session length (57.7 vs 53.2 min), number of episodes and number of new solutions did not differ significantly ("F<1").
    - *Quotation (p. 133):* "When a new idea is generated in MacDraw, its external representation (in MacDraw) serves to fixate and stifle further exploration. Most subsequent effort after the initial generation is devoted to detailing and refining the same idea."
    - *A doubt he raises himself:* the difference could be an artifact, because protocols record thinking more completely when the external medium matches the internal one. He rejects this because it "violates some very important metatheoretical constraints on the system of internal representation," which is a theoretical argument rather than data.

[^petre-paradigm]: **Read in part.** Petre & Blackwell 1997, §7.3: "As phrased by one expert: 'the advantage is that they [images] don't carry the baggage of the paradigm - and so might assist in finding things outside the paradigm.'"

[^aws-prose]: **Read whole** (2014 version). Newcombe, C., Rath, T., Zhang, F., Munteanu, B., Brooker, M. & Deardeuff, M., "Use of Formal Methods at Amazon Web Services," 29 Sept 2014; published as "How Amazon Web Services Uses Formal Methods," *CACM* 58(4):66–73, 2015. <https://6826.csail.mit.edu/2019/papers/formal-methods-amazon.pdf>. "We have adopted the practice of first writing a conventional prose design document, then incrementally refining parts of it into PlusCal or TLA+. Often this gives important insights without ever going as far as a full specification or model checking." I did not compare this with the published 2015 text.

[^schon-intention]: **Read in part.** Schön 1992, p. 135: "It is worth noting that her intention was not fully established at the beginning of her design process, but evolved through her appreciation of an intermediate design product. Her intention developed in 'conversation' with the process by which she transformed her design. An evolving intention is one of the outputs of her designing." A move is affirmed when "the intended consequences of the move are achieved and its unintended consequences are judged desirable ... 'You get what you intend, and you like what you get.'" *Context:* the case is one first-year student's account in a single studio review, with data collected by Roger Simmonds. It is an illustration, not a sample.

[^dorst]: **Abstract only.** Dorst, K. & Cross, N., "Creativity in the design process: co-evolution of problem–solution," *Design Studies* 22(5):425–437, 2001. <https://oro.open.ac.uk/3278>. Protocol studies of nine experienced industrial designers; the abstract proposes "co-evolution of problem/solution spaces" and "'default' and 'surprise' problem/solution spaces." I did not get the text.

[^knuth-revising]: **Read in part.** Knuth 1989 (SP&E), p. 622: "I had to be doing it myself, because writing a new sort of program implies continually revising the specifications."

[^vincenti]: **From memory** (I read the book years ago and did not re-read it). Vincenti, W. G., *What Engineers Know and How They Know It*, Johns Hopkins, 1990, ch. 3 on flying-quality specifications for American aircraft, 1918–1943. As I remember it, neither engineers nor pilots knew at first which measurable properties made an airplane fly well. The specification emerged together with flight instruments and with concepts such as the stick-force-per-g gradient. The NACA report that consolidated the requirements is Gilruth, R. R., *Requirements for Satisfactory Flying Qualities of Airplanes*, NACA Report 755, 1943, <https://ntrs.nasa.gov/api/citations/19930091834/downloads/19930091834.pdf>. I got that link from a search and did not open it. A search snippet from a NASA memoir says Gilruth's requirements were based on about 16 airplanes tested. Treat everything in this footnote as recollection plus unopened pointers.

[^knuth-errors]: **Read whole** (keynote). Knuth 1989 (TUGboat): "Altogether the error log contains 865 entries so far ... Categories A, B, D, F, L, M, R, S, T are bugs ... categories C, E, G, I, P, Q are enhancements ... I consider both bugs and enhancements to be errors, for if I had designed a perfect system in the beginning I would not have made any of these changes and my error log would have been empty." The log itself is at <https://mirrors.ctan.org/info/knuth-pdf/errata/errorlog.pdf>; I did not read it. Note that he did *not* log the changes made in rewriting TeX78 into TeX82.

[^knuth-spec]: **Read in part.** Knuth 1989 (SP&E), pp. 612–613: "the design of TEX was begun on 5 May 1977. A week later, I wrote a draft report containing what I thought was a pretty complete design." He returned to it on 3 July and "prepared a thoroughly revised language definition after two weeks of further study." Coding began 16 September: "Although I had thought that my specification of TEX was quite complete, I encountered loose ends every 15 minutes or so when I was actually faced with writing the code." The lesson he draws: "the designer of a new kind of system must participate fully in the implementation."

[^knuth-scrap]: **Read in part.** Knuth 1989 (SP&E), p. 616: "the original versions of TEX and METAFONT should be scrapped, once they had served their purpose of accumulating enough user experience to indicate what such languages ought to be. New versions of TEX and METAFONT should be written, designed to last a long time."

[^knuth-log]: **Read whole** (keynote). Thesis 6: "I recommend that everybody keep an error log such as the one I kept for TEX. The amount of extra time required is negligible (less than 1%), and the resulting records help us to understand ourselves and our fallible natures."

[^brooks75]: **Read in part** (the passage, in the archive.org text). Brooks, F. P., *The Mythical Man-Month*, 1975, ch. 11 "Plan to Throw One Away": "Where a new system concept or new technology is used, one has to build a system to throw away, for even the best planning is not so omniscient as to get it right the first time ... Hence plan to throw one away; you will, anyhow." <https://archive.org/stream/MythicalManMonth/>.

[^brooks95]: **Seen quoted only** (a search snippet; I could not find the 1995 chapter in the archive text I had). The 1995 anniversary chapter reportedly says: "The biggest mistake in the 'Build one to throw away' concept is that it implicitly assumes the classical sequential or waterfall model of software construction." I have not verified the wording.

[^aws-fix]: **Read whole.** Newcombe et al. 2014: "The team had already designed and reviewed a fix for this bug, so B.M. changed the spec to include the proposed fix. The model checker found that the problem still occurred, but via a different execution trace. A stronger fix was proposed, and the model checker verified the second fix." The paper's table also lists a DynamoDB entry: "Found 1 bug, and found a bug in the first proposed fix."

[^knuth-slice]: **Read in part.** Knuth 1989 (SP&E), p. 613, on Liang and Plass's summer 1977 work: "They had implemented only about 15 per cent of the language, and they had used data structures that were not general enough or efficient enough to support the remaining 85 per cent; but they had chosen their subset wisely, so that a small test program could run from start to finish. Hence it was easy for me to imagine what a complete system would entail." *Context:* this was the students' prototype, built while Knuth was away. He then coded the "final version of TEX (or so I thought)" himself.

[^goel-bulb]: **Read whole.** Goel 1992, p. 131, on ambiguity in sketches: "the token b in Figure 2 was interpreted as a human head and later reinterpreted as a light bulb."

[^gowers]: **Read in part** (first through a summarizing fetch; the quoted passages then checked in the page text). Gowers, T., "Is massively collaborative mathematics possible?", blog post, 27 Jan 2009. <https://gowers.wordpress.com/2009/01/27/is-massively-collaborative-mathematics-possible/>. Rule 3: "When you do research, you are more likely to succeed if you try out lots of stupid ideas. Similarly, stupid comments are welcome here. (In the sense in which I am using 'stupid', it means something completely different from 'unintelligent'. It just means not fully thought through.)" Rule 6: "So try to resist the temptation to go away and think about something and come back with carefully polished thoughts: just give quick reactions to what you read." *Context:* these are rules for a collaborative blog, written before the project ran, not findings about it.

[^wimsatt-localize]: **Read in part** (framework, kinds of falsity, the twelve uses). Wimsatt, W. C., "False Models as Means to Truer Theories," in Nitecki & Hoffman (eds.), *Neutral Models in Biology*, Oxford, 1987, pp. 23–55; reprinted as ch. 6 of *Re-Engineering Philosophy for Limited Beings*, Harvard, 2007. My copy is an April 2006 draft of the reprint: <https://mechanism.ucsd.edu/bill/teaching/models/Wimsatt.falsemodels.pdf>. p. 7: "The primary virtue a model must have if we are to learn from its failures is that it, and the experimental and heuristic tools we have available for analyzing it, are structured in such a way that we can localize its errors and attribute them to some parts, aspects, assumptions, or subcomponents of the model. If we can do this, then 'piecemeal engineering' can improve the model by modifying its offending parts." *Context:* he goes on to argue that the Quine–Duhem thesis, that theories meet tests only as wholes, is false in practice.

[^wimsatt-falsity]: **Read in part.** Wimsatt (2006 draft), pp. 6–7. On the seven ways a model can be false: "The most productive kinds of falsity for a model are cases 2 or 3 above [idealization; incompleteness], though cases of types 1 and 4 should sometimes produce useful insights." Case 5 is a "totally wrong-headed picture of nature." And: "Isn't it always better to have a true model than a false one? Naturally it is, but this is never a choice that we are given, and it is a choice that only philosophers could delight in imagining."

[^lakatos-moves]: **Read in part** (targeted passages, myself). Lakatos, I., "Proofs and Refutations (I–IV)," *British Journal for the Philosophy of Science* 14 (1963–64). Copy: <https://florestanmartinbaillon.github.io/ref_lecture/lakatos.pdf>.
    - Part I, §4(b), pp. 14–15, Delta introducing monster-barring: "But why accept the counterexample? We proved our conjecture—now it is a theorem ... It is the 'criticism' that should retreat. It is fake criticism."
    - Part II, p. 138, the Teacher's summary: "The monsterbarring method defends this naive conjecture by reinterpreting its terms in such a way that at the end we have a monsterbarring theorem: 'All polyhedra are Eulerian'. But the identity of the linguistic expressions of the naive conjecture and the monsterbarring theorem hides, behind surreptitious changes in the meaning of the terms, an essential improvement. The exception-barring method introduced an element which is really extraneous to the argument: convexity. The exception-barring theorem was: 'All convex polyhedra are Eulerian.' The lemma-incorporating method relied on the argument—i.e. on the proof—and on nothing else."
    - Part III, p. 229: "I would propose to rechristen our 'method of lemma-incorporation' the 'method of proof and refutations'."

    Monster-adjustment I describe from memory of the book; I saw only its section heading and the start of Rho's speech. The SEP entry is the source for the point that restrictions exclude polyhedra for which the formula still holds.

[^lakatos-rules]: **Read in part** (this passage, myself). Lakatos, BJPS 1963, Part III, p. 229. I removed OCR artifacts and footnote markers; the wording is otherwise as printed. The rules follow from the dialogue's conclusion that each method should be judged by whether it uses the proof. In the footnotes on this page, Lakatos quotes Darboux: "I am terrified by the hoard of implicit lemmas."

[^lakatos-proofgen]: **Read in part** (myself) plus the SEP entry (checked in the page text). Lakatos, BJPS 1963, Part II, p. 138: "It virtually summed up the proof in the lemma-incorporating theorem: 'All simple polyhedra with simply-connected faces are Eulerian.' This shows that (now I use the term 'proving' in the traditional sense) one does not prove what one has set out to prove." The SEP entry: the dialectic "can generate ... quite complicated definitions of mathematical concepts, definitions that can only really be understood by considering the process that gave rise to them. But mathematics teaching is not historical." *Correction:* the first version of this report said "simply connected polyhedron," which is not the text's formulation.

[^lakatos-pencil]: **Read in part** (only the surrounding lines). Lakatos, BJPS 1963, Part III, about pp. 229–230, Alpha speaking: "no pencil is absolutely sharp (and if we overdo sharpening it will break); secondly, pencil-sharpening is not creative mathematics." *Context:* Alpha is retreating to a "master-theorem" grounded in intuition; Gamma replies "I am lost." From the dialogue's direction I believe Lakatos does not endorse Alpha, but I did not read far enough to confirm how the exchange is resolved.

[^maxwell1861]: **Read in part** (this passage, on Wikisource; checked in the page text). Maxwell, J. C., "On Physical Lines of Force," *Philosophical Magazine*, 1861–62. <https://en.wikisource.org/wiki/On_Physical_Lines_of_Force>. Full sentence: "The conception of a particle having its motion connected with that of a vortex by perfect rolling contact may appear somewhat awkward. I do not bring it forward as a mode of connexion existing in nature, or even as that which I would willingly assent to as an electrical hypothesis. It is, however, a mode of connexion which is mechanically conceivable, and easily investigated, and it serves to bring out the actual mechanical connexions between the known electro-magnetic phenomena; so that I venture to say that any one who understands the provisional and temporary character of this hypothesis, will find himself rather helped than hindered by it in his search after the true interpretation of the phenomena." *Context:* the preceding sentences assign the particles their roles ("These particles, in our theory, play the part of electricity").

[^maxwell1865]: **Search snippets only.** An NYU lecture outline's snippet: the 1865 paper "Replaced vortex model with dynamical justification of field equations." A Springer *Archive for History of Exact Sciences* article (<https://link.springer.com/10.1007/s00407-015-0157-9>) is reported as arguing that the 1865 description of the field as a "complicated mechanism" still rests on a mechanical analogy. Longair's commentary, *Phil. Trans. R. Soc. A* 373, 2015 (<https://pmc.ncbi.nlm.nih.gov/articles/PMC4360095/>), I did not open. So "the vortices and idle wheels are gone" rests on snippets and on my memory of the history. The disagreement among historians is what the snippets report.

[^thurston-foliations]: **Read whole.** Thurston 1994, §6: his foliations papers "documented top-level reasoning and conclusions that I often had achieved after much reflection and effort ... This created a high entry barrier." Later in §6: "What mathematicians most wanted and needed from me was to learn my ways of thinking, and not in fact to learn my proof of the geometrization conjecture for Haken manifolds." He attributes the field's evacuation to two "ecological effects" (the formidable style, and too little left for others to gain), not to exhaustion of its questions.

[^lamport-abstraction]: **Read in part** (pp. 23–25). Lamport 2002, ch. 3, p. 24: "The hardest part of writing a specification is choosing the proper abstraction. I can teach you about TLA+, so expressing an abstract view of a system as a TLA+ specification becomes a straightforward task. But I don't know how to teach you about abstraction. A good engineer knows how to abstract the essence of a system and suppress the unimportant details when specifying and designing it. The art of abstraction is learned only through experience."

[^lamport-cost]: **Read in part.** Lamport 2002, ch. 3, pp. 23–24: "I decided to ignore this aspect of the physical system and pretend that the values of val and rdy represented by those voltages change instantaneously. This simplifies the specification, but at the price of ignoring what may be an important detail of the system ... you won't learn that from my specification." Then: "A specification is an abstraction ... But, whenever we omit some aspect of the system from the specification, we admit a potential source of error."

[^aws-skill]: **Read whole.** Newcombe et al. 2014, Conclusion: "Formal methods deal with models of systems, not the systems themselves, so the adage applies; 'All models are wrong, some are useful.' The designer must ensure that the model captures the significant aspects of the real system. Achieving this is a difficult skill, the acquisition of which requires thoughtful practice."

[^naur-relevance]: **Read whole.** Naur 1985, §4: "By far the largest part of the world aspects and activities will of course lie outside the scope of the program text, being irrelevant in the context. However, the decision that a part of the world is relevant can only be made by someone who understands the whole world. This understanding must be contributed by the programmer." §3, after Ryle: "the similarities in question are not, and cannot be, expressed in terms of criteria, no more than the similarities of many other kinds of objects, such as human faces, tunes, or tastes of wine, can be thus expressed." *Context:* this is a philosophical argument, not a finding.

[^levins]: **Read in part** (pp. 422–423). Levins, R., "The Strategy of Model Building in Population Biology," *American Scientist* 54:421–431, 1966. <https://www.zoology.ubc.ca/let/pdfs/Levins1966.pdf>. p. 423: "There is always room for doubt as to whether a result depends on the essentials of a model or on the details of the simplifying assumptions. This problem does not arise in the more familiar models, such as the geographic map, where we all know that contiguity on the map implies contiguity in reality, relative distances on the map correspond to relative distances in reality, but color is arbitrary and a microscopic view of the map would only show the fibers of the paper on which it is printed. But, in the mathematical models of population biology, it is not always obvious when we are using too high a magnification. Therefore, we attempt to treat the same problem with several alternative models each with different simplifications but with a common biological assumption. Then, if these models, despite their different assumptions, lead to similar results we have what we can call a robust theorem which is relatively free of the details of the model. Hence our truth is the intersection of independent lies." *Context:* the paper's main thesis, a trade-off among generality, realism and precision, was disputed by Orzack & Sober (1993); I saw this in search results and did not read it. The robustness idea is separable from that thesis.

[^wimsatt-irrelevant]: **Read in part.** Wimsatt (2006 draft), p. 8, item 10 of the twelve uses: "A family of models of the same phenomenon, each of which makes various false assumptions, has several distinctive uses: (a) One may look for results which are true in all of the models, and therefore presumably independent of different specific assumptions which vary across models. These invariant results (Levins' (1966) 'robust theorems') are thus more likely trustworthy or 'true'. (b) One may similarly determine assumptions that are irrelevant to a given conclusion. (c) Where a result is true in some models and false in others, one may determine which assumptions or conditions a given result depends upon."

[^aws-two-specs]: **Read whole.** Newcombe et al. 2014: "C.N. independently wrote a spec for the same algorithm; C.N.'s spec was quite different in style to that written by M.D., but both found the same bug in the algorithm. This suggests that the benefits of using TLA+ are quite robust to variations between engineers." *Context:* they draw a conclusion about the method's robustness across engineers, not about which details are irrelevant. Using it as an instance of robustness analysis is my reading.

[^jackson]: **Search snippets of talk outlines only.** Jackson, D., talks on lightweight formal methods and Alloy (e.g. <https://people.csail.mit.edu/dnj/talks/>). Snippet: "many bugs have small counterexamples … and models often have many bugs." His book *Software Abstractions* (MIT Press, 2006; 2nd ed. 2012) states the small scope hypothesis; that is from memory.

[^wimsatt-purpose]: **Read in part.** Wimsatt (2006 draft), p. 2: "Similarly, (1) what models are acceptable, (2) what data are relevant to them, and (3) what counts as a 'sufficiently close fit' between model and data is a function of the purposes for which the models and data are employed." *Context:* he draws the parallel with experimental controls, and notes that people who applaud controls in experiments often criticize models for doing the same thing.

[^weisberg]: **Summaries only.** Weisberg, M., "Three Kinds of Idealization," *Journal of Philosophy* 104(12):639–659, 2007. Record: <https://repository.upenn.edu/philosophy_papers/14>. One of the summaries I saw gave its p. 640 as describing Galilean idealization as introducing distortions to make theories computationally tractable. The three-way glosses in my text are paraphrases.

[^petre-variable]: **Read in part.** Petre & Blackwell 1997. §6.2 "Variable selection": "The 'resolution' of the imagery was not uniform; the experts chose where to put their attention at any given moment, and different regions of the imagery were described as coming in and out of focus. Information outside the focus might be undefined, or unsolved, or soluble, or solved; mainly, it was deemed not important at the moment. 'I don't need to think about that; it's enough to know it's over there . . .'" §6.4: "All of the imagery could accommodate incompleteness and provisionality, which were usually signalled in the imagery in some way, e.g., absence, fuzziness, partial shading, distance in a landscape, change of tone."

[^aws-env]: **Read whole.** Newcombe et al. 2014: "After defining correctness properties, we then precisely describe an abstract version of the design along with an abstract version of its operating environment. We express 'what must go right' by explicitly specifying all of the properties of the environment on which the system relies."

[^tao-errors]: **Read whole.** Tao, T., "There's more to mathematics than rigour and proofs," essay on *What's new*, with an addendum. <https://terrytao.wordpress.com/career-advice/theres-more-to-mathematics-than-rigour-and-proofs/>. Addendum: post-rigorous mathematicians make formal errors "because they no longer need the formalism in order to perform high-level mathematical reasoning, and are actually proceeding largely through intuition, which is then translated (possibly incorrectly) into formal mathematical language." This produces "a mathematical argument by a post-rigorous mathematician which locally contains a number of typos and other formal errors, but is globally quite sound, with the local errors propagating for a while before being cancelled out by other local errors. (In contrast, when unchecked by a solid intuition, once an error is introduced in an argument by a pre-rigorous or rigorous mathematician, it is possible for the error to propagate out of control until one is left with complete nonsense at the end of the argument.)"

[^thurston-reading]: **Read whole.** Thurston 1994, §4: "When people are doing mathematics, the flow of ideas and the social standard of validity is much more reliable than formal documents. People are usually not very good in checking formal correctness of proofs, but they are quite good at detecting potential weaknesses or flaws in proofs." §3: "When the idea is clear, the formal setup is usually unnecessary and redundant."

[^schon-piecemeal]: **Read in part.** Schön 1992, p. 136: "If Petra had initially formulated her problem in terms of all the consequences and qualities in all of the domains she eventually found worthy of mention, the problem-solving task confronting her would have seemed overwhelmingly complex. Working initially in one domain, however, she can allow considerations in other domains to enter into her work piecemeal as she discovers the unintended consequences of her moves."

[^tao-stages]: **Read whole.** Tao, essay: "The point of rigour is not to destroy all intuition; instead, it should be used to destroy bad intuition while clarifying and elevating good intuition." And: "The ideal state to reach is when every heuristic argument naturally suggests its rigorous counterpart, and vice versa." The stages are stated as stages of mathematical *education*: "This stage usually occupies the late graduate years and beyond."

[^knuth-theses]: **Read whole** (keynote). Knuth 1989 (TUGboat), theses 1–4 and 9:
    - "1. TEX would have been a complete failure if I had merely specified it and not participated fully in its initial implementation. The process of implementation constantly led me to unanticipated questions and to new insights about how the original specifications could be improved."
    - "3. ... The process of explaining the language gave me views of the system that I never would have perceived if I had merely designed it, implemented it, and used it."
    - "9. TEX proved to be highly reliable and portable because it was subjected to a 'torture test'."
    - Thesis 7 cuts the other way on one point. Structured programming gave him "enough confidence in my code that I did not feel the need to test anything for six months ... Therefore I saved considerable time by not having to do any prototyping." So Knuth's account is not uniformly pro-prototype.

[^petre-rationalize]: **Read in part.** Petre & Blackwell 1997, §4: "Experts are well-known for rationalizing their practice 'on-the-fly'. As reported by Schooler, Ohlsson & Brooks (1993), there is evidence that solving insight problems relies on essentially nonreportable processes, even that verbalisation interferes with some important thought processes."
