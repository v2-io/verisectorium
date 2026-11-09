# core-2/templates — this verisectorium's segment kinds, in proto form

A verisectorium's ontology declares its segment kinds: which slots a segment has, in what order, which are required, and which veritoid kind fills each. This verisectorium is bespoke and kept in markdown by hand, so its segment kinds exist first as **templates**: one file per kind, showing the sections in order with a line on what each holds, which sections must stand alone, and which may point outside. They are the proto-form of what `kind.md` calls a ‹segment·kind›, written for this verisectorium's own content, and they are what `bin/defs check core-2` enforces where it can.

| template | the segment kind | lives in |
|---|---|---|
| `def.md` | a term definition | `def/<term>.md` |
| `intro.md` | an introduction a cold mind reads first | `src/intro-<slug>.md` |
| `disc.md` | a discussion that narrates defs | `src/disc-<slug>.md` |
| `impl.md` | an implication or worked run that exercises defs | `src/impl-<slug>.md` |
| `praxis.md` | a praxis: what is expected of a mind here that no tool enforces | `praxes/<slug>.md`, projected by `praxes.outline.md` |

The slots common to every kind here: a standalone body that states present truth and points nowhere outside the segment (the one-line definition, Definition, Invariants, Examples for a def; the argument for a prose segment), `## Discussion` (careful; may lean outward but should not come to rest on a pointer), `## History` (how the segment came to be as it is, revisable, faithful to `log.kdl`), `## Historical Context` (where it came from; breadcrumbs to notes, sources, spikes, other projects), and `## Working Notes` (the inbox: open items with leans, drained). The four record surfaces and the reason for the standalone rule are in `src/disc-record-surfaces.md`.

When this verisectorium's ontology is written as data, these files are what it is written from, and each template's sections become declared slots with their veritoid kinds; until then, a template is edited the way a kind would be, with an actum, and every existing segment of that kind owes conformance.
