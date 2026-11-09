---
slug: working-on-core
form: praxis
status: provisional
---

# Working on core

*For any mind, Joseph included, changing anything under `core-2/`. This verisectorium has no engine yet; the discipline the model describes is kept here by hand and by `bin/defs check core-2`.*

## The procedure

1. **Orient before writing.** Read `README.md`, then `model.outline.md` in row order, reading each `src/` and `def/` segment as its row arrives. A mind arriving after a compaction is a new actor and treats its summary as influx, not as memory: re-read what the summary claims you know before relying on it. If the work is one segment, read that segment whole and the segments it narrates or references.
2. **Know which surface you are changing.** A def's one-line definition, Definition, Invariants and Examples state present truth and stand alone. Discussion argues and may lean outward with care. History and Historical Context say how a thing came to be and may point to notes, sources and other projects. Working Notes is the inbox: open items with leans, drained as they resolve. `log.kdl` is the record of what was done to this verisectorium. A sentence in the wrong surface is a defect even when it is true.
3. **Add a term only when a word earns it.** A plain word becomes a term when its Working Notes would hold a decision no other file can hold. Otherwise it is an inline row in the outline. Every new term gets a row in the outline, a file from `templates/def.md`, and a `narrates` entry in any prose segment that leans on it.
4. **Change the design, then the words.** A def's body changes only because the model changed. Provenance (what report, which turn of Joseph's, which note) goes into Historical Context or Working Notes and into the acta entry, never into the body. Nothing in a body names another project as its reason.
5. **Run the gate before saying anything is done.** `bin/defs check core-2` must pass: every «term» and ‹subtype› resolves, relations point at terms, files and outline rows agree, `src/` frontmatter names real terms, and no standalone section points outside. Run `md-press` on every touched markdown file and take its math conversions where they are right.
6. **Record every change to core as an actum.** One `entry` in `log.kdl`, newest last, with `at` read from the clock when the entry is appended (`date`), never estimated, `did` (what changed) and `why` (the reason, naming Joseph where the reason is his), appended only after the change is verified on disk, never before or alongside it: an actum that runs ahead of its change is a false record, and this session wrote two. The acta are append-only; a mistake is corrected by a later entry.
7. **Commit when a coherent change lands**, one attributable change per commit, with a message a future mind can orient from. Do not push; the remote is public and pushing is Joseph's.
8. **Before claiming a segment is ready for adjudication, get a cold read.** Launch a fresh agent with a two-line brief (what to read, where to write) and nothing about what you expect. Fix what it catches that is plainly right; record what it surfaces that is a decision as a Working Note for Joseph. Do not add the cold read's findings to the body as provenance.
9. **Decisions are the steward's and the lead's, unanimous.** A def stays `status provisional` until both say otherwise; leans are written as leans ("Lean: …"), decisions as "Decide (Joseph)." Nothing is marked decided to close a loop.

## Why these steps

- Steps 1 and 8 are the model's own account of actors: a mind's sense of having oriented is not evidence, and a check by a different mind is. This verisectorium cannot yet run the check, so the procedure asks for it.
- Step 2 is `src/disc-record-surfaces.md` applied to markdown. The failure it prevents is the one that undid the estate's earlier theory verisectoria: derivations in formal claims pointing at spikes, history accumulating in inboxes, acta kept as prose.
- Step 3 is what kept the second core from repeating the first, which reached eighty-five terms defined against one another before any example was run.
- Step 4 keeps the core a core: readable as the model of every verisectorium, not as this verisectorium's history.
- Steps 5 and 6 are the refusals and the record this verisectorium has while it has no engine; the gate is the frontier it can compute, and the acta are the one it cannot lose.

## Historical Context

Written 2026-11-09, the second day of `core-2/`, from how the work actually went: a first iteration written in one file and then moved into segments; a cold read that corrected one false claim and found four unmade decisions; Joseph's corrections on purpose before machinery, on provenance out of bodies, and on the four record surfaces. The earlier handoffs in `msc/notes/` (15, 17) and the notes themselves are the specimen of what this procedure replaces.

## Working Notes
- Open. Whether the praxes want their own checker rules (the gate does not read `praxes/` yet).
- Open. Whether step 7's "do not push" belongs in a praxis or only in the session's standing instructions.
