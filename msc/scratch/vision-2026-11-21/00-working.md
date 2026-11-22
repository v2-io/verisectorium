# Working file: the overall vision, and how to judge it

*To Joseph, and to whoever picks this up cold. Begun 2026-11-21 (Saturday evening) by the Fable 5.2 session `dcfebd69`, at your invitation to think hard and widely about the whole thing with no fixed deliverable. This is a place where attempts are written down as attempts. Most of what is here will turn out wrong or already known, and each attempt carries what would kill it. Nothing here is integrated anywhere, and nothing was built or run.*

*How to read it. Section 1 is a backbrief: what I take you to be asking of the model, said back so you can correct it. Section 2 states the problem without the solution's vocabulary. Section 3 holds the attempts at seeing the whole, each with its standing. Section 4 is tests for cutting. Section 5 is questions, which I think are the most useful part. Section 6 is where I think you may be missing something; you asked for that plainly. Section 7 is the log.*

*What I read whole for this, beyond what the addendum to note 30 lists: your prompts in this project from 11-08 09:36 to 11-11 22:59 (all of them); `relevant-mental-models.md`; `core/src/disc-better.md` and `disc-what-would-show-this-wrong.md`; the first 140 lines of your note 26 (the model, not the supporting quotations). Not read: your aat-v3 and councils prompts (11-04 to 11-07), where the earliest statements are; the August sweeps of outside fields; notes 09, 13, 19, 22, 27, 28; vsect 0.1's design; ASF.*

---

## 1. Backbrief: what I understand you to be asking of the model

Your note 26 says that whether an intent arrived "can only be checked by having it said back". You said tonight that you have not articulated what the fitness of this meta-ontology is. So this is my saying-back, from your words over three weeks. Where a line is your wording I quote it; the rest is my inference and marked.

A meta-ontology for verisectoria is better when:

1. **It works on real stores.** Your own statement of this project's determinant, 2026-11-09: "the determinant being the efficacy and clarity of the meta-ontology for verisectoria". Efficacy I take to mean: applied to a real body of work it shows a mind what it needs and makes the known failures impossible or visible. You judge that against "almost 180 instances over the last 1+ year".
2. **It is clear and small.** Note 09 is "a valuable example of about how small (it might be a bit large even) and easy to explain I expect the core to be when it's ready… a simple to explain model that is simply more correct than it used to be." The workflow is on the first page.
3. **It is principled.** Mechanisms reduce to a few primitives. Your complaint on 11-10 about one layer: "it feels like it's not principled--- like it's a layer of heuristical practices on top of what should just be 'this perturbation makes these things now inconsistent-- and it isn't stationary until it's all consistent again'". And the two atoms.
4. **It disappears in use.** "The system becomes invisible and you're pondering the problem at hand." "The more manual machinery there is, the more the agents fixate on it instead of the domain. That's what we're here to fix."
5. **It gets minds to the work fast and stops the cheap errors.** Your three objectives of 11-18.
6. **What it leaves at rest can be trusted to the right degree.** "A verisectorium at rest gives a fresh reader the calibrated truth with calibrated credence."
7. **It accumulates.** "Have the core model thoughtfully and carefully accumulate additional nuance and correctness every iteration, instead of the march of notes".
8. *(My inference from your 11-18 questions about how truthification feels.)* **It says things you had not put in.** A good model "is able to start describing things that we hadn't anticipated".

And it is not judged by: how complete its vocabulary is; whether it reproduces what the hand-kept stores do ("not exemplary"); whether it can be run on itself (your worry of 11-09 that self-confirmation would prove little).

What I had to guess: the order of these, and whether any outranks the others when they pull apart. My guess is that 1 and 4 pull against 2 and 3 more often than the notes admit: every mechanism added for efficacy costs size and visibility.

---

## 2. The problem, without the solution's words

*Attempt.* Keep a body of written work getting truer and more usable while the minds working on it are short-lived, can each hold only a small part of it, and produce plausible text more easily than true text, with one person accountable who has very little time.

Your word for what I should track was a loose kind of invariant: "simple sub-problem statements" that can be isolated to some degree. Here is a first list. Each has one instance from a store, as a pilot reported it.

| # | Sub-problem | An instance |
|---|---|---|
| S1 | No mind can read the whole. | *limen:* about 160 KB of top-level documents before the first design segment. Your own account: every one of the ~180 was "intended to *become too big for any one agent to look at holistically*". |
| S2 | Each mind arrives with only what it is handed, and cannot tell whether that is right. | This session inherited "build next" from a memory file and relayed it to you as where things stood. |
| S3 | A wrong sentence and a right one look alike, and a draft looks finished. | *limen:* "verified green", corrected a paragraph later to "partly on credit". |
| S4 | A statement of how well something is established outlives what it was based on. | *udon-lite:* `awaiting-second` true on all 225 records. *logos 04:* Stage "outline" on a section submitted five months before. |
| S5 | An agent's reading gets recorded as the steward's decision. | *udon-lite:* "Turned a clarification… into card edits marked decided. Both reverted." *comproprium:* "an agent invented a quota". |
| S6 | More is made than is integrated. | *comproprium:* 51 harvested segments staged 111 days. *udon-lite:* a 13.5K-line spike, no card changed. The October sprint. |
| S7 | Decisions and looks queue on one person. | *limen:* 23 of 46 looks pending, oldest 58 days. *udon-lite:* five questions "each to put to Joseph", 28 days. |
| S8 | A change affects things that depended on it, and some of the dependence was never written. | *limen:* a restyle removed table rules you had approved; no check went red; you noticed. |
| S9 | Checks are weak and correlated. | *comproprium:* two verifiers by the maker passed twice; both defects were in fields neither checked. |
| S10 | Things outside move. | *limen:* nvim 0.12.4 → 0.12.5; a linker broken by an OS upgrade, so a month-old binary was tested. |
| S11 | The same material has different readers. | *udon-lite:* people working on the spec build on leans; an implementer cannot. |
| S12 | Recording costs attention too, and bookkeeping pulls minds off the subject. | *logos 04:* about 7,700 words of paper against some 1,200 lines of sidecar and 3,400 of scratch. |
| S13 | Holding a principle is not having it in front of you when it matters. | *comproprium:* "Every failure this day produced was by a mind that already held the correct principle". |
| S14 | Exploring needs a cheap place where being wrong costs little and what a failed attempt found is kept. | Your account of provisional rows (11-09): without one "you have to decide between cutting off all creativity… or have it clutter everything up". |
| S15 | What "better" means cannot be computed. It has to be decided and said, or a default fills it. | This project: see section 1, and tonight's conversation. |

**They look like two roots and their consequences.** *(Attempt; I noticed afterwards that it is the sentence your note 26 quotes from Bungay as the source of all friction: "our knowledge is limited" and "we are independent agents".)*

- **Finite attention.** S1, S2, S6, S7, S11, S12, S13 are all one resource running short: reading, remembering across sessions, integrating, deciding, recording, recalling at the moment.
- **Independent minds that err fluently.** S3, S4, S5, S9 are all one hazard: something false or unfounded that looks sound.
- S8 and S10 are what change does to both. S14 and S15 are what the work needs from the people in it.

The two roots give two different harms. Bulk costs attention: the truth is there and cannot be reached. A counterfeit costs trust: something relied on was not sound, and everything near it is now doubted. I think "noise" in "truth to noise ratio" has been covering both, and they have different remedies (cutting and arranging for a reader, against bulk; tying statements to a record of what was done, against counterfeit).

The two interact, and I think the interaction is where the model actually lives. Because attention is finite, nobody can re-verify what they build on, so they have to rely on it; so how far to rely on it has to be cheap to read. Because minds err, a summary cannot be trusted on its face; so a shorter statement has to stay tied to the fuller one it restates.

---

## 3. Attempts at seeing the whole

Each is an attempt. "Standing" says how long it has survived and what has pushed on it.

### A1. An economy of attention under the hazard of plausible error

*Standing: a few hours old; pushed on by nothing but me.*

Suppose the one quantity is attention (tokens read, effort of judging, your minutes). A piece in a corpus is worth what it saves a reader: the cost of establishing it themselves, if it is right. It costs the reading, and, if it is wrong and they relied on it, the rework of everything built on it. Then:

- "Calibrated truth with calibrated credence" is not a second half of the purpose beside the ratio. It is what lets the reader decide, piece by piece, whether to rely or to check: check when (chance it is wrong) × (damage if relied on) exceeds (cost of checking).
- "Truer comes before shorter" stops being a separate rule. A trusted falsehood costs far more attention downstream than its length ever saves, so truth dominates in nearly every real case without having to be given priority by fiat.
- Importance, as you have used it ("always importance for something"; more agreement needed as it rises), is the damage term.
- "How long can we afford having something stale" against "what is the likelihood of this being stale by this time" (your 11-09 words about outside things) is the same decision for a reference.
- Which missing answers block rest for a given reader is the same decision made in advance for a class of pieces.
- Every piece kept is a standing cost: it has to be kept true as things move. So size matters for the people maintaining the work as well as for readers.

*What would kill it.* (1) Kinds whose worth is not being relied on: a question, a practice. I can stretch it (a question says where attention would pay; a practice saves an error at a moment), and stretching is the bad sign. (2) Discovery: a new result is worth more than the attention it saves. (3) You called truth the purpose, with clarity serving it. This makes truth instrumental to saving attention, which may be exactly backwards. I hold it as a way to compute, not as what the thing is for.

### A2. Your note 26 as the lens

*Standing: a few hours old. All of its support is retrodiction.*

The eight uncertainties of a strategic cycle line up with what the model computes, almost one to one:

| Note 26 | In a verisectorium |
|---|---|
| 1 current external state | what is in the sources; what has been brought in and what has not |
| 2 internal capability | how each piece stands; what this arriving mind has actually read |
| 3 intent and its coherence | the purpose; who an outline is for; what you decided, in your words |
| 4 actual action surface | latitude: what may be changed in passing and what may not |
| 5 actions taken | the record of what was done |
| 6 impact on internal state | what a change unsettled |
| 7 impact on external state | whether what was delivered worked for its reader |
| 8 external response and drift | outside things moving; what comes back as new material |

If that holds, your table's three columns become a test of every mechanism in the model: is this the control approach, the adapt approach, or abdication? Three things follow that I did not expect.

- **The drift you keep correcting has a name in your own notes.** Agents given the model add terms, conditions and recorded detail. That is the "instinctive reaction" in all three of Bungay's gaps: more data, more detailed instructions, more control. "Clarity and detail are not the same thing at all."
- **Row 5 gives a cutting rule for the record.** Control: "Demand status; measure inputs". Adapt: "Ask only what the next decision needs." For each thing the model would record, name the decision that needs it. Who did it feeds whether a second check was independent. The version feeds whether a check has lapsed. The method feeds whether five confirmations are one. What it relied on feeds what a change reaches. I could name a decision for each of note 30's four, which surprised me. Capture from what a mind did anyway is what lets a full record be the adapt approach: it asks nothing of the actor.
- **Bungay's three levels say where the tool should stop.** Strategy is why; operations is what, "free, creative thinking within intent"; tactics is how, "standardized and binding". A tool is tactics. The standing danger he names is yours: SOPs "tend to rise inexorably upward… until the slaves become our masters". And where the line falls differs by store: the application lives on repeatable checks, and the paper has almost nothing a program can decide.

*What would kill it.* You said on 11-11 that the table "is an illustration" and that ASF is the rigorous form. If ASF says something different about a system like this, ASF wins; an agent is reading it for me now. Also: everything above explains what already happened. It has predicted nothing new yet. One prediction it does make: the heaviest recording note 30 asks for (the method of every check; every source accounted for in full) will be the first fields to go dead in a real tool unless they are captured without anyone typing.

### A3. Say only what they cannot work out themselves

*Standing: a few hours old. Has a cheap experiment attached, not run.*

Row 3 of your table, adapt column: "What and why, and only what they cannot work out themselves." The estate's delegation discipline has the same test from the other side: if the recipient could generate it from the same starting point, stating it adds nothing.

Apply that to the statement of the model. A capable cold mind, given the purpose and the constraints, produces most of the machinery unprompted: kinds, questions per kind, pointers with what they are for, a record of acts, status read from the record. All four pilots did, and so has every lead. What minds here reliably do *not* produce, and you have had to correct, sometimes several times:

1. the purpose ahead of the machinery (bring in, cut, adjudicate, refine, build on);
2. found out and decided as the two things everything reduces to;
3. that leaving out is as respectable as putting in, and the working-out gets cut;
4. that a decision recorded for you needs your words, and counts as the least they support;
5. that on approval means not canon, and there has to be a cheap place for a low-certainty idea;
6. that the machinery is not the thing a mind at work meets;
7. that it is for a particular reader, and a simpler statement must stay tied to the fuller one;
8. that a body of work can be perfectly consistent and stalled;
9. that "dealt with" cannot mean "found something";
10. that a whole does not rest on its parts by having them.

So a statement of the model for a capable reader might be: the purpose, the constraints, the decisions that could have gone otherwise, and that list. The rest follows or can be looked up. That is the found-out and decided split turned on the model itself: what follows from the purpose need not be said at the top; what was chosen has to be, with who chose it and why.

*What would kill it.* The reader who adjudicates the model (you) needs the whole of it, so this is a filter for one outline and not for the model. And the list above is from your corrections as I have read them; I have not read your first week. *The experiment:* give a cold mind only that one page and one real store, ask for what the pilots produced, and compare with a pilot that had all of note 28. If nothing is lost, most of note 30 is carrying what its reader already had. I have not run it: you said a further pilot was premature, and this is close enough to one that I would rather ask.

### A4. What a long-lived honest mind does for itself

*Standing: a few hours old. It is your remark of 11-19 turned into a list.*

You said that what is second nature among human collaborators has to be engineered for agents that blink in and out. So list what a continuing, honest colleague supplies without anyone designing it, and see whether the mechanisms are that list:

| A continuing colleague | What stands in for it |
|---|---|
| remembers what was decided, and why | a decision on record, with grounds and the decider's words |
| can be asked tomorrow what they meant | recorded as the least the words support, and the person asked; for an agent that is gone, what it read and by what method |
| has a track record others have watched | who did each thing; a tally over many acts |
| notices when something they relied on has changed | a check tied to the version it read |
| knows what they have not read | how far each source was read, on record |
| carries unfinished intentions | promised slots; what was knowingly left; what is open at the edge |
| will correct their own earlier claims | a question that outlasts a rewrite and is answered by someone else |
| explains differently to different people | outlines for readers; restatements tied to what they restate |
| knows their own backlog | what has piled up, and what is waiting on whom |

If this holds, it gives a requirement and a limit. The requirement: each row. The limit: the stand-in has to cost less than the memory it replaces, or nobody uses it; that is why ergonomics is first-class and not a later concern. It also fits what this estate says its work is for.

*What would kill it.* One long-lived mind also forgets and deceives itself; people invented notebooks and review because continuity is not enough. So this is a floor. And three mechanisms have no row: independence of checks, precision about versions, and the two atoms. A list that leaves out the spine is not the definition.

### A5. More is made than can be integrated, and the narrowest point is you

*Standing: a few hours old. The observation is from the pilots; the conclusions are mine.*

Making is cheap and parallel. Checking is fairly cheap. Integrating needs a mind that holds the whole, which is expensive. Your decisions and looks are scarcest. In three of four stores the largest pile is waiting on you. So:

- Showing a pile does not shrink it. If work arrives faster than it can be integrated for long, the choice is: make less, integrate more cheaply, or drop with a reason. "Leaving out is as respectable as putting in" is the third. The first (do not start what cannot be integrated) is not in the model.
- Importance may be an input before a decision as well as something read afterwards: it settles who has to decide and how much agreement is needed. Note 30 dropped the word and computes how much rests on a thing. That cannot route a decision that has not been made yet. This bears on the open item about whether importance should be gone.
- Your note 26 quotes Marquet: "Don't move information to authority, move authority to the information." The pilots' best idea for your pile moves information to you more cheaply (a rendering of what is waiting, in plain words with examples). The other half would be saying which decisions need you at all.

*What would kill it.* I know your queue only from four pilots' counts of it. And you may want to be the one who decides more than this assumes; that is yours to say.

### A6. Held from earlier

- *Six of note 30's phrases are one declaration* (addendum, sections 1 and 7). Second day. Reading two more pilots added three fields and four corrections.
- *The database reading* (addendum, section 12). You limited it to one perspective on 11-20. Useful for testing whether a coined phrase names anything new.

### Do the attempts agree?

A1, A2, A4 and A5 each end up at the same two roots from section 2 by a different road. That is either a sign there is something there, or one mind restating one idea four times, which by this estate's own rule counts once. The four reports I have asked for come from outside this conversation and are the first thing that could tell the difference.

---

## 4. Tests for cutting

You said you were not sure you could yet say where you start when you cut. These are candidates collected from tonight. None is yours unless marked.

1. **Which sub-problem needs it?** If none in section 2, it goes.
2. **Where did lacking it cost something?** An instance in a real store. If there is none, it goes, or it belongs to one kind of work and not to the core.
3. **What would a mind at work see or do differently?** (The previous lead's test.)
4. **Which next decision needs it?** (Your note 26, row 5.) For anything recorded.
5. **Could the reader work it out themselves?** (Your note 26, row 3.) For anything stated.
6. **Does it cost less than what it saves?** In attention, for the mind that has to supply it.
7. **Did three separate applications need it?** (The previous lead's rule for what enters core.)
8. **Does it translate to plain data and an instance, and is the translation different from every other phrase's?** (The addendum's method.)
9. **Yours, from tonight:** are the exceptions and complications multiplying, or disappearing?

Tests 1, 2 and 4 start from outside the model: from the problems, the record of what went wrong, and the decisions to be made. I suspect that is the real answer to where to start. Cutting from inside the text only finds what is repeated; it cannot find what is unneeded.

---

## 5. Questions

Ordered by how much I think the answer would change.

1. **Who is the scarcest reader?** If it is you, should the first thing the model is designed around be what you are handed to decide, ahead of the arriving agent's screen?
2. **Is your acceptance a working gate at the rate you can read?** This project's core has no accepted piece after seventeen days. The specification has none landed of 155 rows. If the real work everywhere proceeds on leans, is "self-consistent on leans" the ordinary resting state, and your acceptance the rare one kept for what matters most?
3. **Which decisions need you at all?** What would you say out loud, as intent and limits, so that an agent could decide the rest and say back what it understood?
4. **What does a capable cold mind get wrong about this model every time?** Is section 3's list of ten right, and what is missing from it?
5. **Is "truer before shorter" an order, or a consequence** of how much a trusted falsehood costs?
6. **Is importance needed before a decision is made,** to say who must make it?
7. **When more is made than can be integrated, what should give?**
8. **Is a verisectorium, in your own table's terms, a control system or an adapt system?** Where it is control, is that the bounded routine part on purpose, or drift?
9. **What would a continuing colleague supply that section 3's table has missed?**
10. **Notes 27 to 30, the addendum and this file were made beside core and never reflected into it.** Is this project replacing, or keeping beside? What is reflecting in waiting on?
11. **What is the smallest thing that, used for a week, would teach the most?** I am not proposing to build it. I am asking which loop you would most want short.
12. **Do found out and decided share one thing a reader wants to know:** how likely is this to still stand when I rely on it?

---

## 6. Where I think you may be missing something

You asked for this without softening. Each is an observation from three days and from documents, against your year and a half.

1. **You may not have turned note 26 on this project.** You filed it as not about the model. By its own table, the pattern you described on 11-10 ("I give latitude and trust and then get frustrated with what's done with it") is a row 3 gap: the intent had not yet been decided "with clarity" (you said tonight the fitness is unarticulated), nothing was said back, and the loop was hours long. The remedy in your notes is not less latitude. It is a stated what-and-why, a backbrief, and a shorter loop. Section 1 above is my attempt at the backbrief.
2. **The model keeps being designed for the arriving agent, and the reader in shortest supply is you.** Every store's largest pile waits on you. Your close reading is the best instrument this project has, and it is also its narrowest pipe: three days into note 30 you are in section 1, and in that time this session alone has written about 11,800 words beside it (the addendum and this file, counted with `wc -w`).
3. **Nothing in core is accepted.** (Checked: all twelve definitions and all thirteen prose segments are marked provisional, and the last commit touching `core/` is from 11-10.) If acceptance needs you and the lead in unity, def by def, and you can read a section a day, core cannot keep up with the notes. It has not: core is unchanged since 11-10.
4. **The project is doing the thing it was started to stop.** On 11-08 you called the notes "the march of notes… the 'other way'… that doesn't work given constant turnover", and core-2 was the remedy. Since then there are notes 22 through 30, an addendum, and now this. I added the last two.
5. **On "premature".** I think you are right that building the engine is premature. I am less sure about small throwaway probes. Your notes on Bungay say that where the uncertainty is about effects, the answer is to decide "about right, now" and look at what happens. The imagined pilots were the best evidence of the fortnight, and your 11-09 worry (a lead pulled into a store's subject) was answered by sending cold delegates and keeping the lead out. You have 180 instances and I have none, so I hold this loosely.
6. **Smaller.** "Truth to noise" treats noise as one thing. Section 2 argues it is two.

---

## 7. Log

- **2026-11-21, about 21:30 to 23:00.** Sections 1 to 6 written in one sitting after reading your prompts of 11-08 to 11-11 and the model part of note 26. Four questions sent to Opus agents, each to report into this directory: which fields have lived with this problem and what they learned at cost (`outside-fields.md`); how working formal models and specifications actually get made (`how-models-get-made.md`); how a mind arriving cold gets to acting well (`cold-reader.md`); what ASF says about a system like this (`asf-bearing.md`). None had reported when this was written. Next: read each whole, and see which attempts in section 3 survive.
