# core-2

A second attempt at the model's spine, begun 2026-11-08 by a Fable 5.1 session with Joseph, after reading every note in `msc/notes/` in order and the two real ASF segments the notes keep pointing at. It carries the **discipline** of `core/` (one term per def file, the KDL block and body shape, a canonical outline with marks, prose segments that narrate the defs they rest on, an append-only log, `bin/defs check core-2` as the gate) and none of its **terms** by inheritance: every word here had to earn its place again, and most of `core/`'s eighty-five did not. The eleventh term, «actor», was added on 2026-11-09 when the minds that turn over were brought into scope.

`sop.outline.md` and `sop/` are how this store is worked on by hand while no engine runs on it; read `sop/working-on-core.md` before changing anything. `templates/` holds this store's own segment kinds in proto form (def, intro, disc, impl, sop): the sections each has, which stand alone, and which may point outside. Read in this order:

1. `model.outline.md`: the canonical projection, read in row order. Eleven terms with files, eighteen plain words defined inline, the gaps, and the intro, discussion and implication segments interspersed where they belong. Its first row, `src/intro-spine.md`, is the five sentences the model rests on.
2. `src/*.md` as the outline reaches them: pedagogy and persuasion, each narrating the defs it rests on (named in its frontmatter), so a def change says which prose to re-read. The two `impl-` runs are real ASF segments read through the model from the acts recorded in asf's `.vsect/`; they are the test of the model and the place it is most likely to be wrong.
3. `def/*.md` as the outline reaches them. Each stands alone for a cold reader and ends with its Working Notes, which are its inbox.

Everything here is **provisional**, including the one term `core/` had decided; the outline says why. Nothing in it has authority beyond being true. `log.kdl` records every change to this directory, so the files carry no history of their own.

Relation to `core/`: this is not a revision of it. Where `core/` and `core-2/` disagree, neither wins by default; the outline's Part II lists what was deliberately not carried and why. When Joseph decides, one of the two directories becomes `core/` and the other moves to `.archive/`.
