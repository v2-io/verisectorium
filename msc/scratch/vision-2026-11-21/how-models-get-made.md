# How formal models actually get made: what studies of practice and practitioners' accounts show

*Research report, 2026-11-21. Written for the Claude session working with Joseph in verisectorium, and possibly for Joseph. The ledger at the end says what I read whole, what I read in part, and what I only saw cited. Sentences that are my own inference, rather than something a source says, are marked as mine.*

## The short version

1. **The finished artifact hides how it was made, and everyone who looks closely says so.** Parnas and Clements (1986) argue that it should be hidden, but only after the rejected alternatives have been recorded. Schön calls reading the end back into the beginning "historical revisionism." Nersessian and Greeno show that the textbook story of how Maxwell's equations were derived is close to the opposite of what Maxwell did. So most "method" literature describes the fake. Records of the real process exist, but they are rare: protocol studies, historical reconstructions from notebooks, and a few practitioners' logs (Knuth's 865-entry error log for TeX is the best one I found).

2. **Joseph's two stages show up in the evidence, with one correction that I think matters.** Early, experts do immerse themselves in particulars: Thurston spent years building "a repertoire of constructions, examples and proofs" before he conjectured anything, and Knuth typeset 700 pages with TeX. The detail is in the *instances*, not in the *notation* or in commitment to a structure. Goel's controlled study found that forcing expert designers into a precise notation early cut their exploratory moves by more than half. My reading: early is concrete but loosely committed, later is abstract and precise. Joseph's "a great deal of detail" is consistent with this if the detail is examples, simulations and cases, not formal definitions.

3. **Wrong intermediate versions are useful in two ways that pull against each other, and the stages differ by which one they need.** Early, wrongness is useful when it is cheap and ambiguous, so it can turn into something else (Goel; Gowers's rule of "lots of stupid ideas"). Later, it is useful only when it is sharp enough that the failure can be traced to one part (Wimsatt's criterion; Lakatos's proof-analysis; the AWS model checker finding the bug in a proposed fix). Lakatos also gives the best taxonomy I know of the ways people *mishandle* a counterexample. The worst is redefining your terms so the counterexample no longer counts ("monster-barring"). The best is letting it tell you which hidden condition your concept depended on. In that case the definition is an *output* of the failure, a "proof-generated concept."

4. **Nobody can say how they decide what to leave out, and the best formal-methods practitioners say so plainly.** Lamport: "I don't know how to teach you about abstraction." The AWS team: "a difficult skill, the acquisition of which requires thoughtful practice." Joseph's "I'm not sure I can say yet" is the norm among those who do it well. But the sources do describe *mechanisms* that produce warranted confidence about an omission, even if no rule picks the omission:
   - vary the detail and see that nothing you care about changes (Levins's robust theorems, Wimsatt, two independent AWS specs finding the same bug);
   - be clear about *what* the detail is irrelevant to;
   - leave the detail out of the artifact while keeping its *status* in view ("it's enough to know it's over there"), and record the omission as a known risk;
   - have an independent global check that would catch a mistake in the omitted part (Tao's post-rigorous errors that cancel; Thurston's readers who spot weak points without checking formal steps).

   Naur adds a condition I find sobering: only someone who understands the whole can decide that a part of it is irrelevant. On that reading, the early immersion is what earns the later right to omit.

5. **I think there is a better question than "how do they decide what to cut": "what talks back?"** In every rich account, the version improves because something outside the modeler's head pushes back. For Knuth it was implementation, his own use of TeX, writing the manual, and a torture test. For Schön's designers it is the drawing's "back-talk." For AWS it is the model checker; for Lakatos, counterexamples; in Vincenti's history, pilots plus flight instruments. The decisions about cutting, and about what a failure means, ride on that channel. A model with no such channel cannot iterate well however disciplined its author is.

The rest of this report gives the evidence for each point, my doubts, and the reading ledger.

---

## 1. The finished account is a reconstruction, by design or by accident

**Parnas and Clements, "A Rational Design Process: How and Why to Fake It" (1986).** I read this whole. It is shorter and odder than its reputation suggests. They list seven reasons no real project proceeds rationally: people don't know what they want; "many of the details only become known to us as we progress in the implementation. Some of the things that we learn invalidate our design and we must backtrack"; "until we have separated the concerns, we are bound to make errors"; external change; human error; preconceived ideas; reuse. Then: "Even the small program developments shown in textbooks and papers are unreal. They have been revised and polished until the author has shown us what he wishes he had done, not what actually did happen." Their proposal is to produce, at the end, the documents an ideal process *would* have produced, and they point to mathematicians publishing a cleaner proof than the one they found. Two details are often lost:

- Where information is not yet available, "that fact is noted in the part of the document where the information should go and the design proceeds as if that information were expected to change."
- Their faked documentation deliberately departs from the ideal in one way: "We make a policy of recording all of the design alternatives that we considered and rejected. For each, we explain why it was considered and why it was finally rejected."

So even the canonical case for hiding the process keeps the dead ends, in a separate place.

**Schön, "Designing as Reflective Conversation with the Materials of a Design Situation" (1992).** I read the first half. He names the error that results from taking the polished version at face value: assuming the objects and relations were given at the start "reflects what the Marxists have called 'historical revisionism': reading back onto the beginning of a process what has emerged only at its end." His illustration is Wertheimer's parallelogram: seeing it as a rectangle with a triangle moved over "characteristically comes later on in the process, if it comes at all."

**Nersessian and Greeno, "Multiple Abstracted Representations in Problem Solving and Discovery in Physics" (1990).** I read most of the body. Textbooks present Maxwell as adding the displacement-current term because formal consistency required it for open circuits. What actually happened was a sequence of physical models. Faraday's lines of force came first, with a quantitative law that was wrong because it counted lines as discrete. Then Maxwell's fluid in tubes. Then vortices, which jam if neighbors spin the same way, so he added "idle wheels" between them, made rigid for calculation and elastic again later: "It then took him nine months to figure out how to represent the final (and most critical) piece of the problem: electrostatic actions." Their conclusion: "Considerations of formal consistency, as presented in textbooks, played no significant role in this analysis."

**Lakatos**, who wrote the definitive book on this in mathematics, wrote that "actual history is frequently a caricature of its rational reconstructions." I saw that quote via the SEP entry. *Proofs and Refutations* is itself a rational reconstruction, and the footnotes carry the real history.

**Thurston, "On Proof and Progress in Mathematics" (1994)**, which I read whole, goes further. The definition-theorem-proof picture "doesn't explain the source of the questions," and what mathematicians actually produce is understanding. Formal statements are a lossy encoding of it: "Unless great efforts are made to maintain the tone and flavor of the original human insights, the differences start to evaporate as soon as the mental concepts are translated into precise, formal and explicit definitions." **Naur (1985)**, also read whole, makes the same point about programs. The "theory" the programmers hold is primary, documentation is secondary, and "reestablishing the theory of a program merely from the documentation, is strictly impossible." Knuth, in his TeX keynote, disagrees with that last claim on the strength of literate programming. So the claim that the finished artifact *cannot* carry the process is contested. That it usually *does not* is not.

**What follows for your question:** you were right to distrust method books. The places where the actual process is visible:

- **Protocol studies:** designers think aloud on 1–2 hour tasks (Guindon; Goel; Ball et al.; Dorst and Cross; Adelson and Soloway; Petre).
- **Historical reconstructions from notebooks:** Nersessian on Maxwell; Lakatos on Euler's formula; Holmes on Krebs; Gruber on Darwin's notebooks; Vincenti on flying-quality specifications. I read the first two in part. I know the others only from memory or citation.
- **Practitioners' logs and candid accounts:** Knuth's *The Errors of TeX*; the AWS formal-methods paper; Thurston.
- **Public working records:** Gowers's Polymath projects, which he described, as quoted by *Scientific American*, as possibly "the first fully documented account of how a serious research problem was solved, complete with false starts, dead ends, etcetera." The blog threads and wiki are open. I did not read them; I flag them because they are the closest thing to watching the process that you can open yourself.

## 2. What the process looks like

### Opportunistic, not top-down

The oldest and most replicated finding in software-design protocol studies is that experts do not decompose top-down. I did not get the primary text of **Guindon (1990)**. From Bill Wake's notes on it: designers jumped to low-level solutions before decomposition was complete. The jumps came when the artifact was new to them, when several knowledge sources had to be integrated, or when a subproblem was critical, very different from the rest, or had a solution they already knew. They found new requirements mid-design, and about 60% of these were solved on the spot, not deferred. Mental simulation of scenarios kept surfacing both bugs and requirements. Guindon's claim is that this is not sloppiness but a consequence of ill-structured problems, with top-down decomposition as the special case for well-structured ones. I read only the abstract-level summary of **Ball, Onarheim and Christensen (2010)**. In it, software designers first sketched a rough breadth-first solution covering the easy requirements, then went depth-first on hard requirements, with long mental simulations, and the switch tracked rising *epistemic uncertainty*. That bears on Joseph's "inhabit in detail" if what gets inhabited is chosen: deep where you are unsure, shallow where you are not. My reading.

### Early: concrete particulars, low commitment

Several independent sources describe the early phase as rich in particulars:

- Thurston: "I gradually built up over a number of years a certain intuition for hyperbolic three-manifolds, with a repertoire of constructions, examples and proofs." Only "after a while" did he conjecture geometrization.
- Lamport's practical advice on choosing an abstraction in TLA+ is to start concrete: "start by writing the first few steps of one or two sample behaviors."
- **Adelson and Soloway (1985)**, abstract only: experts in an unfamiliar domain built less detailed mental models and ran more local, less global simulations. Global simulation of a partial design depended on domain experience.
- **Petre and Blackwell (1997)**, which I read most of: ten expert programmers, interrupted mid-design and asked what they "saw." All described a "machine in the mind," a dynamic simulation they could run, freeze, rewind and move around inside.
- Knuth on TeX: "I had to put myself in the rôle of a regular user; there is no substitute for such experience, when a new system is being designed." Over about 250 pages he logged 69 changes, about "one enhancement for every six pages typed," and the rate stayed almost constant.

But **Goel (1992)**, which I read whole, adds a caution. Nine expert industrial and graphic designers each did two one-hour design tasks. In one they used freehand sketching; in the other, MacDraw with the freehand tool off and the grid on. With precise drawing they made far fewer *lateral* transformations, meaning moves from an idea to a different idea rather than to a more detailed version of the same one. Syntactic lateral transformations fell from 8.9 to 3.2 per session and semantic ones from 8.0 to 3.9. Reinterpretations of earlier drawings fell from 2.4 to 0.67. Session length, number of episodes and number of new solutions did not differ, which argues against "MacDraw is just harder to use." His description: "When a new idea is generated in MacDraw, its external representation (in MacDraw) serves to fixate and stifle further exploration. Most subsequent effort after the initial generation is devoted to detailing and refining the same idea." His claim is that ill-structured early problems need ill-structured representations "to prevent premature crystallization of ideas." The phases he observed, preliminary design followed by refinement and detailing, move from coarse and uncommitted to precise and committed.

*My reconciliation, an inference rather than a finding:* the early detail experts immerse themselves in is detail *of the domain and its instances* (cases, behaviors, simulations, examples), held in a loose, reinterpretable medium. What they avoid early is precision of *representation and commitment*. If that is right, a formal notation with strict well-formedness, used during the exploratory phase, could cost exactly the lateral moves that find the good version. Petre's experts said the same in their own register: images "don't carry the baggage of the paradigm - and so might assist in finding things outside the paradigm."

The AWS team arrived at a practical version of this: "We have adopted the practice of first writing a conventional prose design document, then incrementally refining parts of it into PlusCal or TLA+. Often this gives important insights without ever going as far as a full specification or model checking."

### Problem and intention are outputs, not inputs

In Schön's case of the student Petra, she makes a move to fix one quality ("too small in scale") and discovers unintended consequences in other domains, some of which she likes. "It is worth noting that her intention was not fully established at the beginning of her design process, but evolved through her appreciation of an intermediate design product... An evolving intention is one of the outputs of her designing." A move is affirmed when "You get what you intend, and you like what you get." **Dorst and Cross (2001)**, abstract only, nine industrial designers, model creative design as the *co-evolution* of problem and solution spaces. Knuth says it bluntly about TeX: "writing a new sort of program implies continually revising the specifications."

**Vincenti's** chapter on American flying-quality specifications from 1918 to 1943, in *What Engineers Know and How They Know It* (1990), is the clearest case I know of a specification for something new that took decades. I read it years ago and did not re-read it, so treat this as recollection. Neither engineers nor pilots knew at first which measurable properties made an airplane fly well. The specification emerged together with instruments that could measure candidate properties and with the concepts to name them. One example is the stick-force-per-g gradient. The NACA report that consolidated those requirements is Gilruth's *Report 755* (1943), which is on NTRS. If you want a long-run case of a specification found rather than written, this is the one.

## 3. Wrong intermediate versions

### They are the norm, and good practitioners count them

- **Knuth's** log for TeX has 865 entries. He counts enhancements as errors too, "for if I had designed a perfect system in the beginning I would not have made any of these changes and my error log would have been empty." He wrote what he thought was a complete specification in a few weeks of summer 1977. When he sat down to code it, "I encountered loose ends every 15 minutes or so." Later he scrapped the whole system, TeX78, and wrote TeX82: "the original versions of TEX and METAFONT should be scrapped, once they had served their purpose of accumulating enough user experience to indicate what such languages ought to be." His keynote closes: "Therefore I now look forward to making further errors in my next project." He recommends everyone keep such a log, at "less than 1%" extra time.
- **Brooks (1975):** "Where a new system concept or new technology is used, one has to build a system to throw away, for even the best planning is not so omniscient as to get it right the first time." In the 1995 anniversary chapter, which I saw only quoted, he revised this: the biggest mistake in "build one to throw away" is that it assumes the sequential waterfall model. With incremental development, the throwing-away happens continuously, piece by piece.
- **AWS:** a team had designed and reviewed a fix for a known bug. When B.M. modeled the fix, "the model checker found that the problem still occurred, but via a different execution trace." The first fix was wrong too, which is normal.

A detail from Knuth's account that I think is underappreciated: his students implemented only about 15% of the specified language, "but they had chosen their subset wisely, so that a small test program could run from start to finish. Hence it was easy for me to imagine what a complete system would entail." The first wrong version was a thin slice that ran end to end, not a complete layer.

### Two ways wrongness helps, which pull against each other

**Early: cheap, ambiguous, transformable.** Goel's sketch is valuable because a mark can be reread: a head becomes a light bulb. Gowers's ground rules for Polymath, which I got through a summarizing fetch so the quotes are short: "When you do research, you are more likely to succeed if you try out lots of stupid ideas," with "stupid" meaning "not fully thought through"; and give "quick reactions" rather than "carefully polished thoughts."

**Later: sharp enough that the failure points at something.** Wimsatt, "False Models as Means to Truer Theories" (1987), states the criterion: "The primary virtue a model must have if we are to learn from its failures is that it, and the experimental and heuristic tools we have available for analyzing it, are structured in such a way that we can localize its errors and attribute them to some parts, aspects, assumptions, or subcomponents of the model." He also ranks kinds of falsity. A model that is an idealization, or incomplete but with its included variables roughly right, is productively wrong. A "totally wrong-headed picture," or one that just fails to fit, is not. And on the dream of skipping the false models: "Isn't it always better to have a true model than a false one? Naturally it is, but this is never a choice that we are given."

*My inference:* the transition between Joseph's stages may be partly the moment when you switch from wanting your wrong versions to be reinterpretable to wanting them to be diagnosable. A medium that is good for one is bad for the other.

### What to do when a counterexample arrives: Lakatos

*Proofs and Refutations* (1963–64; book 1976) follows the history of Euler's V − E + F = 2 as a classroom dialogue. Its value for your question is a catalogue of responses to a counterexample, most of them bad:

- **Monster-barring:** redefine "polyhedron" so the counterexample doesn't count. The concept is narrowed ad hoc to protect the claim.
- **Exception-barring:** retreat to a safe domain, for example "all convex polyhedra are Eulerian." This is true but discards content, and it excludes things for which the formula still holds.
- **Monster-adjustment:** reinterpret the counterexample until it fits.
- **Lemma-incorporation**, later renamed the "method of proofs and refutations": analyze the proof, find which hidden lemma the counterexample refutes, and make that lemma an explicit condition of an improved conjecture.

His heuristic rules, verbatim from the 1963 BJPS text (Part III, p. 229; I cleaned up OCR artifacts and footnote markers):

> Rule 1. If you have a conjecture, set out to prove it and to refute it. Inspect the proof carefully to prepare a list of non-trivial lemmas (proof-analysis); find counterexamples both to the conjecture (global counterexamples) and to the suspect lemmas (local counterexamples).  
> Rule 2. If you have a global counterexample discard your conjecture, add to your proof-analysis a suitable lemma that will be refuted by it, and replace the discarded conjecture by an improved one that incorporates that lemma as a condition. Do not allow a refutation to be dismissed as a monster. Make all 'hidden lemmas' explicit.  
> Rule 3. If you have a local counterexample, check to see whether it is not also a global counterexample. If it is, you can easily apply Rule 2.

His larger claim is that the mature *concepts*, such as "simply connected polyhedron," are "proof-generated." They are produced by the failures and are hard to understand without the history that made them. The SEP entry puts it as definitions "that can only really be understood by considering the process that gave rise to them." For a project whose product is definitions, I think this is the most directly relevant source in the report. In this picture a wrong definition is not something to fix by tidying; a counterexample to it is how the right definition gets found.

The dialogue also has a character who has had enough: "no pencil is absolutely sharp (and if we overdo sharpening it will break); secondly, pencil-sharpening is not creative mathematics." Lakatos does not endorse him, but the warning against endless boundary-refinement is in the text.

### Using a model you don't believe: Maxwell

From "On Physical Lines of Force" (1861), verified on Wikisource, about his idle-wheel particles:

> The conception of a particle having its motion connected with that of a vortex by perfect rolling contact may appear somewhat awkward. I do not bring it forward as a mode of connexion existing in nature, or even as that which I would willingly assent to as an electrical hypothesis. It is, however, a mode of connexion which is mechanically conceivable, and easily investigated, and it serves to bring out the actual mechanical connexions between the known electro-magnetic phenomena; so that I venture to say that any one who understands the provisional and temporary character of this hypothesis, will find himself rather helped than hindered by it in his search after the true interpretation of the phenomena.

Displacement current came out of this machinery. By "A Dynamical Theory of the Electromagnetic Field" (1865) the vortices and idle wheels are gone and the equations stand on general dynamics. Historians disagree about how far the mechanical analogy kept guiding him; see Longair's 2015 commentary in *Phil. Trans. A* and the Springer study in the ledger. This is the cleanest historical case I found of "leaving detail out with confidence." The detail was scaffolding, explicitly labeled provisional while in use, and dropped once the structure it had helped find could stand without it.

### What gets kept from the failures

- Parnas and Clements keep rejected alternatives, with reasons.
- Knuth keeps a complete log.
- Lakatos puts history in footnotes.
- Polymath keeps everything in public.

Thurston gives the cost of *not* keeping the path. His foliations papers "documented top-level reasoning and conclusions that I often had achieved after much reflection and effort," the field emptied out, and "What mathematicians most wanted and needed from me was to learn my ways of thinking." With geometrization he deliberately did the opposite and published infrastructure and ways of thinking.

## 4. Leaving detail out

### The practitioners' own testimony: it is untaught

Lamport, *Specifying Systems*, ch. 3, which I read in the two relevant pages:

> A specification is an abstraction. It describes some aspects of the system and ignores others. We want the specification to be as simple as possible, so we want to ignore as many details as we can. But, whenever we omit some aspect of the system from the specification, we admit a potential source of error... The hardest part of writing a specification is choosing the proper abstraction. I can teach you about TLA+... But I don't know how to teach you about abstraction... The art of abstraction is learned only through experience.

His worked example also shows the right *posture* toward an omission. He makes val and rdy change in one step, ignoring that voltages on different wires don't change at the same instant. Then he says exactly what this costs: "you won't learn that from my specification." The omission is named as a risk at the moment it is made.

The AWS paper ends on the same note: "Formal methods deal with models of systems, not the systems themselves... The designer must ensure that the model captures the significant aspects of the real system. Achieving this is a difficult skill, the acquisition of which requires thoughtful practice."

Naur gives a reason it can't be reduced to rules: "By far the largest part of the world aspects and activities will of course lie outside the scope of the program text, being irrelevant in the context. However, the decision that a part of the world is relevant can only be made by someone who understands the whole world." He grounds this in Ryle: the relevant similarities "are not, and cannot be, expressed in terms of criteria, no more than the similarities of many other kinds of objects, such as human faces, tunes, or tastes of wine."

So Joseph's "I'm not sure I can say yet" puts him in good company. Lamport, writing a textbook meant to teach exactly this, says the same thing.

### Mechanisms that warrant confidence in an omission

What the sources describe is not a rule for choosing omissions but several ways people come to *trust* one.

**a. Vary it and watch.** Levins (1966), one page read: "we attempt to treat the same problem with several alternative models each with different simplifications but with a common biological assumption. Then, if these models, despite their different assumptions, lead to similar results we have what we can call a robust theorem which is relatively free of the details of the model. Hence our truth is the intersection of independent lies." Just before that is the image I find most useful for "what detail is meaningful." On a map, contiguity and relative distance mean something, "but color is arbitrary and a microscopic view of the map would only show the fibers of the paper on which it is printed. But, in the mathematical models of population biology, it is not always obvious when we are using too high a magnification." Wimsatt lists this as a use of false models: "One may similarly determine assumptions that are irrelevant to a given conclusion." AWS stumbled on a version of it: two engineers wrote independent specs of one algorithm, "quite different in style," and "both found the same bug." Daniel Jackson's "small scope hypothesis" for Alloy, which I saw only in his talk outlines, is the bounded-checking form: most bugs have small counterexamples, so you can check exhaustively in a small world before committing to more detail.

**b. Ask what it is irrelevant *to*.** Wimsatt: "(1) what models are acceptable, (2) what data are relevant to them, and (3) what counts as a 'sufficiently close fit' between model and data is a function of the purposes for which the models and data are employed." Weisberg's "Three Kinds of Idealization" (2007), which I saw only in summaries, separates three warrants that tend to blur together. Galilean idealization leaves out what you intend to add back. Minimalist idealization keeps only the factors that make a difference to a given phenomenon. Multiple-models idealization expects no single best model. Each gives a different kind of confidence about an omission, and mistaking one for another seems like a likely source of error. That last point is my inference.

**c. Omit from the artifact, keep the status in view.** Petre and Blackwell's experts, on "variable selection": "The 'resolution' of the imagery was not uniform... Information outside the focus might be undefined, or unsolved, or soluble, or solved; mainly, it was deemed not important at the moment. 'I don't need to think about that; it's enough to know it's over there...'" And: "All of the imagery could accommodate incompleteness and provisionality, which were usually signalled in the imagery in some way." On this account, confident omission is not forgetting. It is knowing what is there and what state it is in. The written analogues are Parnas's "note the fact where the information should go," Lamport naming the cost of his omission, and AWS stating explicitly "all of the properties of the environment on which the system relies."

**d. Have a global check that would catch a local slip.** Tao, "There's more to mathematics than rigour and proofs," read whole: post-rigorous mathematicians make formal errors "because they no longer need the formalism in order to perform high-level mathematical reasoning," which leads to arguments that are "locally" full of "typos and other formal errors, but... globally quite sound, with the local errors propagating for a while before being cancelled out by other local errors." By contrast, without solid intuition an error "propagate[s] out of control." Thurston on reading: "When the idea is clear, the formal setup is usually unnecessary and redundant," and "People are usually not very good in checking formal correctness of proofs, but they are quite good at detecting potential weaknesses or flaws in proofs." *My inference:* detail can be left out with confidence where something else (intuition about invariants, a model checker, a second model) would notice if leaving it out broke something.

**e. Work one domain at a time and let back-talk bring in the rest.** Schön: "Working initially in one domain, however, she can allow considerations in other domains to enter into her work piecemeal as she discovers the unintended consequences of her moves." Here omission comes *before* confidence. You leave most considerations out because you cannot hold them all, and the situation tells you which ones you can't afford to leave out.

### Tao's stages, and Joseph's

Tao's three stages, pre-rigorous, rigorous and post-rigorous, read almost like Joseph's account. Rigour "should be used to destroy bad intuition while clarifying and elevating good intuition," and the goal is a state where "every heuristic argument naturally suggests its rigorous counterpart, and vice versa." But Tao is describing a *mathematician's development over years*, not the course of one project. *My conjecture, which I have not seen tested:* a single project with a new subject may recapitulate the sequence. You start pre-rigorous about the new thing even if you are post-rigorous in general. You pass through a stretch where precision destroys some of your intuitions. Leaving out with confidence becomes available only once heuristic and formal versions suggest each other. If that is right, Joseph's "being content to be wrong" fits the middle stretch especially, where rigour is destroying intuitions that felt good.

## 5. Questions I think may be better than the ones you asked

You invited this, so here are reframings that the sources pushed me toward. They are offered as possibilities, not corrections.

1. **"What talks back, and how fast?"** rather than "how do they decide what to cut." In Knuth, Schön, Lakatos, AWS and Vincenti, the quality of the decisions tracks the quality of the back-talk channel. Knuth's first thesis is "TeX would have been a complete failure if I had merely specified it and not participated fully in its initial implementation." He also lists using it, writing its manual, and a torture test, and of the manual he says "the process of explaining the language gave me views of the system that I never would have perceived if I had merely designed it, implemented it, and used it." For a formal model of a *practice*, the question becomes: what plays the role of implementation and use?
2. **"What is this detail irrelevant *to*, and what experiment would show it?"** rather than "can this be left out." This turns an act of taste into something checkable (§4a–b).
3. **"Is this stage's medium the right grain?"** Goel's result says the formality of the medium changes which moves you make, not only how fast you make them.
4. **"When a counterexample arrives, which Lakatos move am I about to make?"** Monster-barring is the characteristic failure of definition-building, because it always looks like tidying.
5. **"Where will the record of the wrong versions live, and what does it need to say?"** Parnas's answer is rejected alternatives with reasons; Knuth's is a categorized log; Lakatos's is history in footnotes, apart from the theorem.
6. **"Who holds the theory?"** (Naur). If the understanding lives in minds, then delegating the specification without the theory runs into Knuth's "loose ends every 15 minutes," and only someone who understands the whole can decide what is irrelevant.

## 6. Doubts and limits of the evidence

- **The controlled studies are small, short and early-phase.** Goel had N=9; Petre and Blackwell 10; Dorst and Cross 9; Guindon analyzed a handful of protocols. Sessions run one or two hours on toy briefs such as a poster, an elevator controller or a school layout. None follows a *formal model* being built over months. The long-run evidence is historical reconstruction and practitioners' retrospectives, which are vulnerable to exactly the rationalization this report is about. Petre and Blackwell themselves note that "experts are well-known for rationalizing their practice 'on-the-fly'."
- **Survivorship.** The candid accounts are by people whose projects worked: Knuth, Thurston, Maxwell, AWS. I found nothing comparable on why an iterative approach *failed*, beyond Thurston's foliations story, which is about communication rather than modeling.
- **"Something new."** Most design-protocol tasks are new to the participant but not new in kind. Joseph's case, a formal model of a kind of thing nobody has modeled, is closest to Maxwell, Vincenti, Lakatos's polyhedra, and Knuth's "new sort of program." The protocol studies may transfer less well than the historical cases.
- **My reconciliation of "detail early" with Goel's "coarse early" is inference.** It fits Thurston, Lamport's sample behaviors, Knuth's typing and Adelson and Soloway, but I did not find a study that tests it directly.
- **Sources I relied on through summaries** (see ledger) could be wrong in details. Guindon and Ball et al. in particular I know only through secondary notes and abstracts.
- **I haven't read `core/`**, so the one place where I connect this to the project (below) is a guess from the praxis file and memory index lines that were in my context.

## Where this might touch the project (guesses from outside)

From the praxis loaded with my context, the project already has several of these lessons, apparently learned firsthand:

- "Add a term only when a word earns it," after a first core that "reached eighty-five terms defined against one another before any example was run," reads like Goel's premature crystallization and Lakatos's warning about definitions that run ahead of the counterexamples that should generate them.
- A memory index line says building an instance from core alone tests it better than reading it. That is Knuth's thesis about implementation and use.
- `log.kdl` and the history and Working Notes surfaces are Parnas's rejected-alternatives record and Knuth's error log.

One question the evidence raises and I can't answer from here: does `bin/defs check core`, a well-structured representation in Goel's sense, run during the exploratory phase too, and if so, does it suppress lateral moves? Goel's data would predict that it does if strict well-formedness is required before an idea can be written down at all.

---

## Reading ledger

**Read whole, myself (primary text):**
- Parnas & Clements, "A Rational Design Process: How and Why to Fake It," *IEEE TSE* SE-12(2), 1986. https://userweb.cs.txstate.edu/~rp31/papers/Fake_it.pdf
- Thurston, "On Proof and Progress in Mathematics," *Bull. AMS* 30(2), 1994. https://arxiv.org/abs/math/9404236
- Tao, "There's more to mathematics than rigour and proofs" (blog essay, with later addendum on errors). https://terrytao.wordpress.com/career-advice/theres-more-to-mathematics-than-rigour-and-proofs/
- Naur, "Programming as Theory Building," *Microprocessing and Microprogramming* 15, 1985. https://ingenieria-de-software-i.github.io/assets/bibliografia/programming-as-theory-building.pdf
- Newcombe et al., "Use of Formal Methods at Amazon Web Services," 29 Sept 2014 version (the published version is *CACM* 58(4), 2015, "How Amazon Web Services Uses Formal Methods"). https://6826.csail.mit.edu/2019/papers/formal-methods-amazon.pdf
- Goel, "'Ill-Structured Representations' for Ill-Structured Problems," *Proc. CogSci* 14, 1992. https://escholarship.org/uc/item/3wz7c4nd
- Knuth, "Notes on the Errors of TeX" (TUG keynote), *TUGboat* 10(4), 1989. https://tug.org/TUGboat/tb10-4/tb26knut.pdf

**Read in substantial part, myself:**
- Knuth, "The Errors of TeX," *Software—Practice & Experience* 19(7), 1989: the history sections (journal pp. 610–622) and the error categories, not the full 865-item log. https://yurichev.com/mirrors/knuth1989.pdf · log: https://mirrors.ctan.org/info/knuth-pdf/errata/errorlog.pdf
- Wimsatt, "False Models as Means to Truer Theories" (1987; reprinted in *Re-Engineering Philosophy for Limited Beings*, 2007): the framework, the seven ways a model can be false, and the twelve uses. I skimmed the opening and did not read the Morgan–Castle linkage-mapping case study in detail. https://mechanism.ucsd.edu/bill/teaching/models/Wimsatt.falsemodels.pdf (2006 draft of the reprint)
- Schön, "Designing as Reflective Conversation with the Materials of a Design Situation," *Research in Engineering Design* 3, 1992: about the first half, through the Petra case and seeing patterns. https://www.uio.no/studier/emner/matnat/ifi/IN1060/v25/pensum/schon_design-conversation.pdf
- Petre & Blackwell, "A Glimpse of Expert Programmers' Mental Imagery," *ESP 7*, 1997: most of it. https://courses.cs.duke.edu//fall00/cps189s/readings/petre-expert.pdf
- Nersessian & Greeno, "Multiple Abstracted Representations in Problem Solving and Discovery in Physics," *Proc. CogSci* 12, 1990: most of the body. https://escholarship.org/uc/item/0p42x70s
- Lakatos, "Proofs and Refutations," *BJPS* 1963–64 (four parts): the contents, the three heuristic rules and surrounding dialogue (Part III, about pp. 228–230), and the §7–8 contents. **Not** the dialogue as a whole. The descriptions of monster-barring and the other moves are from my memory of the book, consistent with the section headings and the SEP summary. https://florestanmartinbaillon.github.io/ref_lecture/lakatos.pdf
- Levins, "The Strategy of Model Building in Population Biology," *American Scientist* 54, 1966: pp. 422–423 only. https://www.zoology.ubc.ca/let/pdfs/Levins1966.pdf
- Lamport, *Specifying Systems*, ch. 3 sample: the opening pages on abstraction. https://ptgmedia.pearsoncmg.com/images/032114306X/samplechapter/lamportch03.pdf
- Maxwell, "On Physical Lines of Force," 1861: the idle-wheel passage only, on Wikisource. https://en.wikisource.org/wiki/On_Physical_Lines_of_Force
- Brooks, *The Mythical Man-Month* (1975 text): the "plan to throw one away" passage. https://archive.org/stream/MythicalManMonth/

**Read through a summarizing fetch, so wording may be paraphrased and quotes are short:**
- SEP, "Imre Lakatos." https://plato.stanford.edu/entries/lakatos/
- Gowers, "Is massively collaborative mathematics possible?" (2009 blog post with the Polymath ground rules). https://gowers.wordpress.com/2009/01/27/is-massively-collaborative-mathematics-possible/
- Bill Wake's notes on Guindon (1990). https://xp123.com/?p=697

**Only saw abstracts, search snippets or secondary citations (I did not read the source):**
- Guindon, "Designing the Design Process: Exploiting Opportunistic Thoughts," *HCI* 5, 1990. I tried for the full text and failed.
- Ball, Onarheim & Christensen, "Design requirements, epistemic uncertainty and solution development strategies in software design," *Design Studies* 31, 2010.
- Adelson & Soloway, "The Role of Domain Experience in Software Design," *IEEE TSE* 11(11), 1985.
- Dorst & Cross, "Creativity in the design process: co-evolution of problem–solution," *Design Studies* 22(5), 2001. https://oro.open.ac.uk/3278
- Atman et al., "Engineering design processes: A comparison of students and expert practitioners," *J. Eng. Educ.* 96(4), 2007. It finds that experts spent more time on problem scoping and gathered more information. I did not use it above beyond this note.
- Weisberg, "Three Kinds of Idealization," *J. Phil.* 104(12), 2007.
- Brooks's 1995 revision of "plan to throw one away" (seen quoted only).
- Gowers & Nielsen, "Massively collaborative mathematics," *Nature* 461, 2009 (paywalled; I did not read it).
- Daniel Jackson on Alloy, lightweight formal methods and the small scope hypothesis (talk outlines via search). https://people.csail.mit.edu/dnj/
- Longair, commentary on Maxwell (1865), *Phil. Trans. R. Soc. A* 373, 2015 (https://pmc.ncbi.nlm.nih.gov/articles/PMC4360095/), and a Springer *AHES* article on Maxwell's mechanical analogies (https://link.springer.com/10.1007/s00407-015-0157-9). Both are cited only for the point that the 1865 paper dropped the vortex machinery and that historians disagree how far the analogy persisted.
- Alexander, *Notes on the Synthesis of Form* (1964): good fit is recognizable only through its misfits. Seen in secondary quotation; Schön also cites it. I left it out of the main text for that reason, but it belongs beside Schön.
- Feynman to Charles Weiner, via Gleick's *Genius*, saying his notebooks were not a record of the work but the work ("I actually did the work on the paper"). The wording varies across secondary sources; I did not use it above.
- Process-of-process-modeling studies (Pinggera, Soffer et al., about 2011–2015): lab studies of people building formal BPMN models from a given text, with "modeling phase diagrams." These are the only studies I found that watch *formal models* being built. But the subject matter is given, not new, so I judged them less relevant. A lead if you want it.

**From memory only, not re-checked in this session:** Vincenti's flying-qualities chapter (*What Engineers Know and How They Know It*, 1990, ch. 3); Holmes on Krebs and Gruber on Darwin's notebooks, mentioned only as places where the real process is visible; Chi, Feltovich & Glaser (1981) on experts sorting by deep principle, which I did not use.

## Feedback on the brief

The brief worked well for me. Its explicit permission to find that the questions were wrong is what produced §5, and asking what I read versus skimmed made me more careful than I would otherwise have been. One thing I would have liked to know is what kind of "new" you have in mind. "Formal model or specification of something new" spans mathematics, software specification, scientific modeling and engineering requirements, and these literatures differ. I went broad. If the real target is a formal model of a *practice or institution*, there may be a closer literature than the one I found, such as ethnographies of standards-writing or legal drafting, or conceptual-modeling research, and I would look there next.

I'm available for follow-up questions.
