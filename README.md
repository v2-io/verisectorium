# verisectorium

The verisectorium model and, later, its engine (`v2`; `vsect` 0.1 was its first tool). Begun afresh on 2026-11-04 (Joseph: "new ideal vsect from the beginning, which can draw on anything principled from prior efforts").

This repository is itself a bespoke verisectorium, kept by hand, with the working-versus-canonical line drawn in its directories:

- **`core/`** — the currently known truth about the model. `core/model.outline.md` is the canonical projection, a lexicon-shaped outline, one row per term, each marked accepted, promised, provisional or gap, with a `def` column saying whether a file exists. `core/def/<term>.md` is one file per term (KDL block, then Intro, Definition, Discussion, Examples, Working Notes; see `core/def/README.md`); a def is provisional until decided by steward and lead, unanimous. `core/log.yaml` is the append-only record of changes to core, so core carries no history of its own.
- **`msc/notes/`** — frozen copies of the working documents the model was worked out in, in the order written; `00-INDEX.md` says what each is and what supersedes what. Fully superseded notes move to `msc/notes/.archive/`.
- **`msc/scratch/`** — concrete attempts: DSL sketches, spikes, censuses, trial runs. Experimental, and never confused with core. `kernel-spikes/` holds the four kernels built from one spec in Rust and Ada/SPARK (2026-11-07) with `COMPARISON.md` and `RUNS.md`.
- **`.archive/`** — the earlier work with its git history, as influx: `prior-incarnation/` (the verisectorium as it grew in `arch`, 2026-08-05 to 11-04, with the theory store and RC1 at `theory/influx/segments-model-rc1/`) and `prior-vsect/` (vsect 0.1).

The first store the model is written for is AAT, at `~/src/aat-v3/`; its store definition lives there. Where something in core may be AAT's rather than the core's, it is marked as such; nothing is generalized before a second and third instance (udon's spec, an essay-centric store, vivarium) have been tried.
