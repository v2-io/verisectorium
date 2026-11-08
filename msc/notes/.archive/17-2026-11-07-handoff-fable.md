# Handoff: where the model work stands (Fable session, 2026-11-06/07)

*To whoever picks this up cold, from the Fable session that founded `core/` with Joseph. Written near the end of the session, re-read against the files, not from memory of the work. Everything is committed on `main` in `~/src/verisectorium/`; nothing is pushed (Joseph's call; the remote is public).*

## Read these, in this order

1. `README.md` and `core/def/README.md`: what this repository is and the def file shape and the reference conventions («term», «wording|def/term», ‹subtype›, ⸱ between words).
2. `core/model.outline.md`: the canonical projection, 85 rows, ordered by dependence. Read the legend; every row's `mark` and `def` column mean what it says.
3. `core/def/verisectorium.md`: the one decided term. Everything else in `core/def/` is provisional, and the five stubs from the kernel spikes (`version`, `act`, `affirmation`, `reference`, `segment-changeset`) carry decisions waiting for Joseph in their working notes.
4. `msc/scratch/kernel-spikes/COMPARISON.md`: four kernels built from `KERNEL-SPEC.md` in Rust and Ada/SPARK by Opus 5.5 and Fable 5.1, independent by construction; §4 is what they agree the spec (and so the model) got wrong; §5 is where they decided differently, which is the list of model decisions. `RUNS.md` has the measured spend.
5. `00-INDEX.md` here for the earlier notes; `16` for the eleven questions; `14` for Joseph's provisional/promised/gaps statement verbatim.

## What is settled

- `«verisectorium»` decided, steward-and-lead, 2026-11-07. The conventions: one term per def file; terms are nouns, singular, with `pl`; verbs, adjectives and states live inside their noun or as its declared subtypes; KDL 2.0 block for the machine fields; `bin/defs check` is the gate.
- `ontology` replaces `definition`; `data⸱store` replaces `store`; `truth⸱determinant` replaces `answers⸱to`; `better`, `answers to`, `soften` are plain English.
- Joseph on the working-notes convention: no history or breadcrumbs in core; `core/log.yaml` and commits carry provenance; a def's working notes are its inbox, self-contained enough to decide the question.

## Open, in the order I'd take them

1. `truth-determinant` as the second decided term; its two open notes (declared once vs refinable per kind; a piece answering to two at once) shape the rest.
2. The five spike-fed decisions, each in a stub's working notes with alternatives and the fork's lean: refusals recorded vs reported (2–2 among the kernels); whether a content version covers references; which repair of the inert affirmation; whether `needed` on a reference is the author's assertion or something the ceiling consults; a word for "owed because of".
3. The split files still share intros verbatim with former group-mates (each says so in its first working note); rewrite per term as each is adjudicated, not as a sweep.
4. The language question: a SPARK-proven kernel was reached twice; the unmeasured cost is unbounded data in SPARK. One more spike (the same kernel over SPARK's formal containers) would settle it; the two Ada agents' encoding facts are in their accounts.
5. `KERNEL-SPEC.md` §6's list is wrong and carries a correction note; if the spec is reused, fix the list.

## Things I'd want you to know that no file says plainly

- The outline's `see` column is to be retired once the notes are integrated (Joseph's TODO at its top).
- `written`/`computed` became subtypes of «property»; `aliased`/`derived`/`owned` of «value»; `provisional`/`promised`/`present` of «row». The checker reads subtypes from the outline too, so an unfiled term can declare them.
- Joseph's "(2) sense" of verisectorium (this project) stays in the definition by his decision; an SoP verisectorium may one day take it.
- The grep-filtered command chain is in this project's Claude memory as the anti-example, with his correction that it was a last-step lapse, not a habit.
