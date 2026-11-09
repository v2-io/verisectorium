---
slug: disc-record-surfaces
form: disc
status: provisional
narrates: [segment, veritoid, kind, act, changeset, frontier, checkpoint]
---

# Four places a record can go, and which is which

*Provisional, 2026-11-09. The Working Notes at the end say what this was adjudicated against.*

## The confusion this settles

Every verisectorium in the estate has kept, somewhere, a record of what happened to its content. Every one of them has mixed four different things into whatever surface was nearest: a commit message carrying a design decision, a Working Notes bullet carrying the only account of why a claim was narrowed, a segment body narrating its own revisions, a hand-kept changelog standing in for acta that were never recorded. Each of the four has a different reader, a different discipline, and a different relation to the model, and they only work when kept apart.

## The four

**The acta.** The record of what was *done*: every «act» and every «changeset», append-only, machine-shaped, corrected only by a later entry and never edited. Everything computed (warrants, whether references hold, the «frontier», whether a state is a «checkpoint») is read from it. It is complete and it is not prose; nobody orients by reading it, and anything a mind needs to understand from it is rendered, not read raw.

**The history of renderings.** Where the corpus's files live under version control, that system keeps the history of the files. It is outside the verisectorium. The model leans on nothing in it: a commit message is not an act, a diff is not a changeset, and a verisectorium that can only be understood by reading its commit history has failed to record what it knew. It remains useful as a rendering's history and as evidence when the acta are doubted.

**Working notes, which are the inbox.** Material bearing on a «segment» that has not yet been adjudicated: chunks from sources, a reader's stumble, a forward pointer to work not started, a question with no closer yet. Additive, meant to be drained, and outside the segment's written state, so that adding to it or emptying it is never a change to the segment. It is influx, not content; nothing in it has standing, and nothing in it is ever cited as if it did. A note that has become standing content (a guard, a dead end with its reason, an open question with a closer) leaves the inbox for a slot of its own kind.

**History.** Written prose kept with a segment, saying what a later mind needs to know about how the segment came to be as it is: what it replaced and why, what was tried and failed, where its pieces came from. It is content, part of the segment's written state, changed by changesets; additive in spirit but revisable, not append-only; pitched for the orienting mind, which the acta are not; and answerable to the acta, which it must never contradict and never substitute for. In the model it is a slot holding veritoids of an *account* kind, with an inner dependency from the account to the claims it accounts for, so that rewriting a claim asks whether its account still tells the truth. It is also the one place a segment may point outward, to sources, notes and spikes, as breadcrumbs for a mind that wants the trail, because an account that says "this came from there" is making a claim about provenance and not borrowing warrant.

The rule that keeps the fourth from swallowing the others: **the body states present truth.** What a claim says, what a definition means, what a decision decided, stand alone in the present tense and rest on nothing outside the segment's own references. History says how they got there. The two are different kinds of veritoid in different slots, and a sentence of history inside a claim ("see the spike for the full derivation") is a claim that has stopped standing on its own.

## Why the fourth is not the acta and not the inbox

Against the acta: the acta are complete and the account is selective; the acta are for the machine and the account is for a mind; the acta warrant and the account warrants nothing. A verisectorium whose only history is its acta has recorded everything and can explain nothing to a newcomer. Against the inbox: the inbox is drained and the account is kept; the inbox is outside the written state and the account is inside it; the inbox has no standing and the account has a dimension (faithful to the acta). A verisectorium that keeps its accounts in Working Notes has made its history undrainable and its inbox unreadable.

## Historical context as a kind of history

A particular form of history matters to a verisectorium that is deriving its own model, as this one is: the evidence, anecdotes and reasoning trails from which a definition or a claim was reached, where older methods were tried and what happened, what the underlying assumptions were. That material is the revisable warrant for the whole at a high level: if the derivation of the model is ever doubted, it is what a mind would go back to. It belongs in the history slot, as its own section where a verisectorium wants the distinction, and it is the natural place for breadcrumbs into notes and sources without those pointers cluttering the definitions. It is never required reading to understand the definition it sits beneath.

## The discipline for a verisectorium kept in markdown files

While a verisectorium is bespoke and its segments are files edited by hand, the four surfaces are sections and files rather than kinds and slots, and the discipline has to be kept by convention until a tool keeps it:

- The acta are their own file, append-only, and nothing else in the corpus carries history that is not also in it.
- Commit messages carry what git needs and nothing the verisectorium needs.
- `## Working Notes` is the inbox: open items, leans, what is unresolved. Drained, not accumulated.
- `## History` and `## Historical Context` are the only sections, with Working Notes and (carefully) Discussion, that may point outside the segment to notes, sources, spikes or other projects. Everything else in a segment, the definition, its invariants, its examples, stands on its own in the present tense.
- A Discussion that comes to rest on a pointer has drifted into history and is moved there.

The precedent matters more than the convenience: a verisectorium that begins with pure, standalone, present-tense segments and then admits the messy material in protected places keeps the line; one that begins mixed never finds it.

## Working Notes
- Adjudicated against Joseph's 2026-11-09 distinction of the four surfaces and his account of what went wrong in ASF and AAT when derivations in formal claims pointed at spikes ("see ../spike-a1233/ for the full derivation"), which he names as the agentic default propensity; and against `segment.md`'s existing split of Working Notes into inbox, standing content and prose fate markers.
- Open. Whether `account` is a core veritoid kind (every verisectorium has history) or one each ontology declares. Lean: the core names it and says what it answers to; whether a segment kind has a history slot is the ontology's.
- Open. Whether an account may itself carry an assertion ("this derivation was independently checked before it was narrowed") or only point at the acts that did. Lean: point only; an account that asserts is a claim in costume.
