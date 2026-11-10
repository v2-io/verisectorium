# Segment kinds across the estate's verisectoria

*2026-11-10. A breakdown of the kinds of segment file in the verisectoria found in `proto-instances.md`, and of the slots each kind carries: headings, and also the frontmatter fields, bold-labelled fields, udon elements, KDL nodes and YAML fields where a store keeps its shape there. Only files an outline, manifest, index or pipeline reaches are counted. Five territory passes decided each file's kind and what each store declares; one uniform extractor then read every file the same way (titles, `#`/`##`/`###` headings, frontmatter keys one layer deep, line-start bold labels; fenced code skipped, a fence that never closes ignored); this file is generated from both by `msc/scratch/proto-instances/segment-kinds/compile.py` (gitignored, with the per-store detail).*

**Reading the tables.** Each kind has a heading, then its total files and lines, the stores it occurs in (with file counts), and where its shape is declared, then a table of its slots. (`compile.py --joined` regenerates the report with one table per family instead.)

| column | meaning |
|---|---|
| slot | the slot's name in backticks, however it is carried; `›` nests a slot under its parent. Parentheses mark implicit slots no heading names: `(Slug)` (a file's identity where only its filename gives it), `(Title)` (the first `#` heading), `(Preamble)` (unheaded text between the title and the first section), `(Title › Norm)` (a title convention: the text before the first colon, shared by three or more distinct files). A `###` heading that is a member of a collection the parent names (one of the Key Principles, one Claim of a Claim Record) or a named part of the parent's own content (a Discussion's sections) is content written for each segment, not a slot of the kind, so it gets no row; the parent's purpose cell says how many it holds. The verdicts are in `items.tsv` beside `compile.py`, adjudicated by reading for every nested row this report showed before, automatic elsewhere; `item-dryrun.md` there says how. After the name, a cardinality mark: none for required and single, ` ➕` required and repeated within a segment, `﹖` optional, ` 🞷` optional and repeated (the repeated ones are marked loudly). |
| count | how many times the slot is filled across the kind; more than `f` when segments carry it more than once |
| f | files of the kind that carry it |
| l | lines of text it takes to specify the slot, summed: a section with its subsections, a frontmatter key with its continuation lines, and at least one line per file that has it |
| l/tot | `l` as a share of the kind's total lines |
| decl | `D` declared by the store, `U` undeclared; `D*`/`U*` when the slot is implicit. For declared slots `R` required or `O` optional; for undeclared ones `R*` (every file has it) or `O*` (some do), inferred. A slot whose stores disagree takes the strongest declaration among them; its notes say which stores declare it how. A declared slot whose store does not say required or optional gets `R*` or `O*` inferred, as an undeclared one does. |
| form | `fm` frontmatter, `hd` heading, `la` bold label, `if` implied by filename or path, `im` implicit in the markdown (title, preamble), `ot` other (udon element, KDL node, YAML key, inline tag, callout) |
| purpose & notes | what the slot is for, then notes; in the first table, which stores carry it when not all of the kind's do |

A slot gets its own row when a store declares it or when at least half the kind's files carry it. Undeclared slots carried by fewer are *minor*: one row per kind counts them (with one-off headings and withheld personal headings), and a line after the table lists them with their file counts, most common first.

The two application-response stores appear as `ais`.

**Keys.** The first table merges thirteen stores that share ASF's type vocabulary, so a row there aggregates across stores. Everywhere else, rows are per store and kind, because the same kind name means different things in different stores (`claim` has four shapes in four stores).

**Privacy.** ELI homes and the personal memory clusters show only generic slot names; personal heading text was withheld at extraction and appears only as counts. The "very last ad-hoc verisectorium" archive shows kind rows only, as its README asks.

## What the breakdown shows

1. **One lineage, thirteen stores.** ASF's type vocabulary (definition, scope, formulation, derived, derivation, result, hypothesis, observation, normative, detail, sketch, discussion, …) and its four-section cadence (Formal Expression, Epistemic Status, Discussion, Working Notes) reach 561 files across the four ASF volumes, vivarium core, udon theory, address theory's second iteration, the aat-v3 crossing, TFT, the prior verisectorium theory store and template, and both ais stores. It travelled by copying, and each copy froze at the moment it was taken (vivarium core, a copy, is nonetheless the most uniform store in either repo):
   - vivarium's FORMAT was copied on 2026-07-13 and never took up the Claim Record;
   - udon theory ported the cadence into udon elements (`|formal-expression`, …);
   - the ais response store kept the type names but not the cadence: its 43 claim, discussion and norm segments are Outline / Joseph's statement / Gloss / Backing skeletons.
2. **Most of a kind's declared shape is not in headings.** It is in frontmatter (about 40% of the tools territory's rows), in bold-labelled fields (the Claim Record's six, Findings' five, the Epistemic Status ceiling, the adjudicated claims' Rung and Verification chain), in udon elements and attributes, in KDL nodes (core defs), YAML fields (relata, model-beta), inline statement tags (`*[Definition (id)]*`, which replace `## Formal Expression` in the aat-v3 crossing), and in Scrivener's binder metadata. A heading-only count would read several of the most disciplined stores as shapeless.
3. **Where a store declares a shape, files split three ways.**
   - *Filled by all:* the TST analyses (all 960 carry the six core sections; the declared footer is mostly bold lines instead of a heading), udon's 64 ADRs, autopax's five v2 ADRs, the 325 velocity claims, the dossier entries, the eoi cards, relata's five required fields.
   - *Declared, filled by none:* the TST vault's analysis template (0 of 960) and principle-note template; vivarium's Findings; three optional ADR slots; the core templates' "The question this settles", "The argument" and "Historical Context" in core's own discussions.
   - *Filled, never declared:* the AAT gold lift (113 files), LLM and ELI's "Pointers for Fleshing Out" (14), udon definitions' `## Avoid` (20) and their Working Notes review structure (about half the kind's lines), tooling needs' "What this opens" (23 of 26), live_docs' `## Decision` (128 of 129), the global memory's lead / Why / How to apply / Cross-references slots, and a nested `metadata.type` in 256 project memories.
4. **Working Notes is where undeclared structure accumulates.** The gold lift, the pointer blocks, udon's review sub-template, off-ramp blocks, and migration history (21 ASF files) all live there. That is what core's «segment» Discussion predicts: the inbox carrying standing content and history it has no other slot for.
5. **Declarations come in every form, and few are checked.** Prose tables (udon's `conv-record-cadence`, which calls itself "proposed, or even exploratory"), templates by example (`adr/TEMPLATE.md`, `_TEMPLATE.md`), code (relata's `REQUIRED_FIELDS`, the harness's `memoryTypes.ts`), YAML (`kinds.yaml`, `analysis_requirements.yaml`), README tables of contents (TFT), FORMAT prose, CLAUDE.md rules. udon's declared conformance check, which includes section order, has never run.
6. **Shapes drift by generation, and the generations coexist.**
   - udon Lite rule cards: 81 in the declared shape, 13 in the 2026-10-20 shape that was proposed and never adopted.
   - Claude memory: `type` at top level in 136 files, nested in 256.
   - comproprium: the harvests adopted D3a's trigger rename; the 20 quotations in `exempla/` did not.
   - The TST analyses renamed their math slot after the first 44 files.
   - autopax: nine classic Context/Decision/Consequences ADRs beside five in the README's v2 format.
   - ASF Epistemic Status: the "Max attainable / Currently" ceiling is in 103 of 115 vivarium segments, 4 AAT ones, and replaced in LLM and ELI by an undeclared triple (17).
7. **Exemptions that were never written down.** All 17 ASF `impl-` segments lack the three sections FORMAT requires of them; the written exemption names only intros and `disc-`. ASF titles carry the type (`# Derived: …`) by habit, not by declaration.
8. **This repository's own core and its templates disagree in both directions.** None of the 7 discussions has the template's three sections (5 are a title and prose); 2 of 5 impls have "The material" and "The run"; all 11 defs carry `### Etymology` and `### Adjudication`, which `templates/def.md` does not declare. The templates README says existing segments owe conformance.
9. **For papers, the kind is finer than "section" but not in the headings.** The OUT manifests split a section's opening segment from its continuations (30 of NeurIPS 01's 39 appendix files are continuations), and what a segment holds (theorem, lemma, proof, table) is a callout type `AUTHORING.md` declares. Headings are titles.
10. **Defects found along the way.** 17 relata entries are written frontmatter-style, so strict YAML loaders reject them; one model-beta label has an unquoted comma; 108 TST analyses open with a stray unclosed code fence that hides their headings from naive parsers.

## At a glance

| family | kinds | files (units) | stores |
|---|---:|---:|---|
| ASF lineage: theory segments sharing one type vocabulary | 31 | 562 | AAT, ELI, LLM, TFT, TST, aat-v3, addr-2nd, ais-resp, ais-sop, udon-theory, viv, vs-prior, vs-template |
| Verisectorium model stores | 23 | 189 | Segments model RC1, aat-v3 model defs, first core, verisectorium core, verisectorium praxes, very last ad-hoc verisectorium |
| Term and definition stores | 14 | 2,675 | ASF terminology, Address Theory, ai-risk-model lexicon, ai-risk-model model-beta, vivarium lexicon |
| Specifications, rules and decisions | 34 | 598 | UDON 0.9 decision briefs, UDON Lite pre-design questions, UDON Lite spec, UDON Lite spec (vsect-init, supers, autopax ADRs, live_docs |
| Procedures, norms and principles | 22 | 201 | ASF SOPs, Address Theory SOP, UDON Lite SOP, firmatum principles, practica normative claims, prior theory SOP, vivarium process norms |
| Claim, evidence and source records | 89 | 5,192 | NeurIPS 01 adjudicated, NeurIPS 02 adjudicated, NeurIPS 03 adjudicated, NeurIPS adjudicated-common, RONR-12 unified model (councils), agent-behavior dossier, ai-risk-model source segments, ai-risk-model thin-pass records (G, comproprium, comproprium harvests, harness- and ecosystem-velocity cl, logos refs, neurips refs, overarching ponderata, relata data store, stopgap system prompt drafting, udon-needs: ideation gathering, udon-needs: tooling needs |
| Ledgers and projections (ASF ancillary) | 7 | 941 | ASF README partials, ASF items (TODOs), ASF notation (planned store, never, ASF questions |
| Tool and app pipelines | 5 | 178 | aspectus, limen |
| Readings, walks and analyses | 23 | 3,031 | AAT summary walk, ASF de-novo audit walks, Practica chapter reading (s3), TST library analyses, TST principle analyses, aat-refactored, agent memory survey |
| Predecessor theories | 8 | 63 | TST vault theory, Temporal Software Theory |
| Papers, essays, books and applications | 99 | 668 | ACA paper, After consciousness paper, ELI essays (Feb 2026), ELI essays quote bank (explication, Explication essay pipeline, Granted agency paper, Joseph bio ingestion (ops), LLM agent ethics, Living language, NeurIPS 01 tragedy (paper), NeurIPS 02 convergence (paper), NeurIPS 02 pre-restructure segment, NeurIPS 03 hallucinate (paper), NeurIPS 03 pre-reshape segments, Novel draft (Scrivener 2), Paper 1 quote substrate, Paper 3 quote substrate, Paper 4 prep substrate, Practica paper drafts (s4), Practica paper drafts (s5), Principia Ars Technica (book), Reflections (Scrivener), Simplex material (Scrivener), Vis Veritatis, ais (eoi cards), behavioral-floor, causal-language, ops paper portfolio, vault: Principles, vault: clean_split, vault: gemini foundation |
| Agent memory, skills and identity | 59 | 1,123 | Architectus home, Claude agents, Claude project memories, Claude skills (user level), Dialogue-curator agent components, NeurIPS sprint memory snapshot, Zi-am-tur home (current), Zi-am-tur home (sapientia generati, global Claude memory, jj skill, live_docs skills, memory curation workshop |

## ASF lineage: theory segments sharing one type vocabulary

### Formulation

**Total Files**: 76  
**Total Lines**: 5,105  
**Where**: viv 39, vs-prior 14, AAT 11, ais-sop 4, vs-template 3, TFT 3, udon-theory 2  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Preamble)` | 74 | 74 | 101 | 0.02 | D* R | im | one-sentence statement of the claim, no heading; in viv 39, vs-prior 14, AAT 11, ais-sop 4, TFT 3, vs-template 3; undeclared in TFT; required in AAT, ais-sop, viv; declared in vs-prior, vs-template |
| `(Title)` | 74 | 74 | 74 | 0.01 | D* R | im | title; in viv 39, vs-prior 14, AAT 11, ais-sop 4, TFT 3, vs-template 3; undeclared in TFT; required in AAT, ais-sop, viv; declared in vs-prior, vs-template |
| `Slug` | 71 | 71 | 71 | 0.01 | D R | fm | identity (= filename); in viv 39, vs-prior 14, AAT 11, ais-sop 4, vs-template 3; required in AAT, ais-sop, viv; undeclared in vs-prior, vs-template |
| `Status` | 71 | 71 | 71 | 0.01 | D R | fm | epistemic strength; in viv 39, vs-prior 14, AAT 11, ais-sop 4, vs-template 3; required in AAT, ais-sop, viv; undeclared in vs-prior, vs-template |
| `Depends` | 71 | 71 | 283 | 0.06 | D R | fm | prerequisite slugs; in viv 39, vs-prior 14, AAT 11, ais-sop 4, vs-template 3; required in AAT, ais-sop, viv; undeclared in vs-prior, vs-template |
| `Type` | 50 | 50 | 50 | 0.01 | D R | fm | kind of claim; in viv 39, AAT 11 |
| `Stage` | 50 | 50 | 50 | 0.01 | D R | fm | working-process state (current-state marker); in viv 39, AAT 11 |
| `(Title › Formulation)`﹖ | 32 | 32 | 32 | 0.01 | U* O* | im | in vs-prior 14, AAT 11, ais-sop 4, vs-template 3 |
| `Form`﹖ | 21 | 21 | 21 | 0.00 | D O* | fm | its kind; in vs-prior 14, ais-sop 4, vs-template 3; declared in ais-sop; undeclared in vs-prior, vs-template |
| `Type-expected`﹖ | 21 | 21 | 21 | 0.00 | D O* | fm | predicted type once established; in vs-prior 14, ais-sop 4, vs-template 3; declared in ais-sop; undeclared in vs-prior, vs-template |
| `Max`﹖ | 21 | 21 | 21 | 0.00 | D O* | fm | the ceiling its status can reach; in vs-prior 14, ais-sop 4, vs-template 3; declared in ais-sop; undeclared in vs-prior, vs-template |
| `State`﹖ | 21 | 21 | 21 | 0.00 | D O* | fm | process flags; in vs-prior 14, ais-sop 4, vs-template 3; declared in ais-sop; undeclared in vs-prior, vs-template |
| `Working Notes`﹖ | 71 | 71 | 856 | 0.17 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon); in viv 39, vs-prior 14, AAT 11, ais-sop 4, vs-template 3; optional in AAT, ais-sop, viv; declared in vs-prior, vs-template |
| `Formal Expression` | 63 | 63 | 1,371 | 0.27 | D R | hd | the formal statement itself: math, definition, rule; in viv 39, AAT 11, vs-prior 6, ais-sop 4, vs-template 3; required in AAT, ais-sop, viv; declared in vs-prior, vs-template |
| `Epistemic Status` | 63 | 63 | 552 | 0.11 | D R | hd | what is derived vs assumed; tier and ceiling; in viv 39, AAT 11, vs-prior 6, ais-sop 4, vs-template 3; required in AAT, ais-sop, viv; declared in vs-prior, vs-template |
| `Discussion` | 61 | 61 | 606 | 0.12 | D R | hd | interpretation and connections; in viv 37, AAT 11, vs-prior 6, ais-sop 4, vs-template 3; declared in ais-sop, vs-prior, vs-template; required in AAT, viv |
| `Claim Record`﹖ | 3 | 3 | 104 | 0.02 | D O | hd | per-claim register, population, true/false-of, falsifier, instantiated; holds 7 ### claims in 3 files, each with fields Register, Population, True of, False of, Falsifier, Instantiated; in AAT 3 |
| `(Preamble)` | 2 | 2 | 12 | 0.00 | D* R | im | title, one-line summary, any lead paragraph before the first ##; attribute section before the first slot; in udon-theory 2 |
| `Title` | 2 | 2 | 2 | 0.00 | D R | ot | human-readable slug; in udon-theory 2 |
| `Summary` | 2 | 2 | 4 | 0.00 | D R | ot | one sentence; in udon-theory 2 |
| `Formal-expression` | 2 | 2 | 18 | 0.00 | D R | ot | the claim; in udon-theory 2 |
| `Epistemic-status` | 2 | 2 | 10 | 0.00 | D R | ot | derived vs assumed; ceiling; in udon-theory 2 |
| `Discussion` | 2 | 2 | 10 | 0.00 | D R | ot | interpretation and connections; in udon-theory 2 |
| `Working-notes`﹖ | 2 | 2 | 6 | 0.00 | D O | ot | forward pointers, guards, dead ends; in udon-theory 2 |
| `Formal Expression › What Is Derived vs. What Is Chosen`﹖ | 2 | 2 | 55 | 0.01 | D O | hd | derivation-audit table: each claim, its source, its strength; in AAT 2 |
| `Max attainable`﹖ | 2 | 2 | 2 | 0.00 | D O | la | ceiling: strongest status it could ever reach; in viv 2 |
| `Findings`﹖ | 1 | 1 | 31 | 0.01 | D O | hd | catalog entries surfaced into FINDINGS.md; holds 1 ### finding in 1 file, each with fields Brief, Impact, Novelty Claim, Related Work, Search Log; in AAT 1 |
| *(149 minor slots)* |  |  | 1,167 | 0.23 | U O* |  | listed below |

*Minor and undeclared slots:* [Formulation] (9), Dual-home demote (5), Dual homes demoted (5), Currently robust-qualitative (5), Known incomplete (4), Misfire-feedback caution carried from the outline (4), (Slug) (3), References (3), … (+141 more)

### Definition

**Total Files**: 58  
**Total Lines**: 4,955  
**Where**: AAT 21, TST 8, ELI 7, addr-2nd 4, aat-v3 4, vs-prior 4, vs-template 3, ais-sop 3, viv 3, LLM 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Depends` | 58 | 58 | 184 | 0.04 | D R | fm | prerequisite slugs; required in AAT, ELI, LLM, TST, ais-sop, viv; undeclared in addr-2nd, vs-prior, vs-template; declared in aat-v3 |
| `(Preamble)` | 58 | 58 | 138 | 0.03 | D* R | im | one-sentence statement of the claim, no heading; required in AAT, ELI, LLM, TST, ais-sop, viv; undeclared in aat-v3, addr-2nd; declared in vs-prior, vs-template |
| `(Title)` | 58 | 58 | 58 | 0.01 | D* R | im | title; ASF prefixes it with the type word; required in AAT, ELI, LLM, TST, ais-sop, viv; undeclared in aat-v3, addr-2nd; declared in vs-prior, vs-template |
| `Slug` | 54 | 54 | 54 | 0.01 | D R | fm | identity (= filename); in AAT 21, TST 8, ELI 7, addr-2nd 4, vs-prior 4, ais-sop 3, viv 3, vs-template 3, LLM 1; required in AAT, ELI, LLM, TST, ais-sop, viv; undeclared in addr-2nd, vs-prior, vs-te… |
| `Status` | 54 | 54 | 54 | 0.01 | D R | fm | epistemic strength; in AAT 21, TST 8, ELI 7, addr-2nd 4, vs-prior 4, ais-sop 3, viv 3, vs-template 3, LLM 1; required in AAT, ELI, LLM, TST, ais-sop, viv; undeclared in addr-2nd, vs-prior, vs-template |
| `(Title › Definition)`﹖ | 49 | 49 | 49 | 0.01 | U* O* | im | in AAT 20, TST 8, addr-2nd 4, aat-v3 4, vs-prior 4, ais-sop 3, vs-template 3, ELI 2, LLM 1 |
| `Type` | 40 | 40 | 40 | 0.01 | D R | fm | kind of claim; in AAT 21, TST 8, ELI 7, viv 3, LLM 1 |
| `Stage` | 40 | 40 | 40 | 0.01 | D R | fm | working-process state (current-state marker); in AAT 21, TST 8, ELI 7, viv 3, LLM 1 |
| `Form`﹖ | 14 | 14 | 14 | 0.00 | D O* | fm | its kind; in addr-2nd 4, vs-prior 4, ais-sop 3, vs-template 3; declared in ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `Type-expected`﹖ | 14 | 14 | 14 | 0.00 | D O* | fm | predicted type once established; in addr-2nd 4, vs-prior 4, ais-sop 3, vs-template 3; declared in ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `Max`﹖ | 14 | 14 | 14 | 0.00 | D O* | fm | the ceiling its status can reach; in addr-2nd 4, vs-prior 4, ais-sop 3, vs-template 3; declared in ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `State`﹖ | 14 | 14 | 14 | 0.00 | D O* | fm | process flags; in addr-2nd 4, vs-prior 4, ais-sop 3, vs-template 3; declared in ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `Source`﹖ | 4 | 4 | 4 | 0.00 | D O* | fm | where in ASF it was crossed from, at what commit; in aat-v3 4 |
| `Statements`﹖ | 4 | 4 | 4 | 0.00 | D O* | fm | the statements the segment is carved into, each with its kind and premises; in aat-v3 4 |
| `Epistemic Status` | 58 | 58 | 341 | 0.07 | D R | hd | what is derived vs assumed; tier and ceiling; required in AAT, ELI, LLM, TST, ais-sop, viv; undeclared in addr-2nd; declared in aat-v3, vs-prior, vs-template |
| `Discussion` | 57 | 57 | 712 | 0.14 | D R | hd | interpretation and connections; declared in aat-v3, ais-sop, vs-prior, vs-template; required in AAT, ELI, LLM, TST, viv; undeclared in addr-2nd |
| `Working Notes`﹖ | 57 | 57 | 1,213 | 0.24 | D O | hd | the inbox: open items with leans, cautions, provenance; not canon; optional in AAT, ELI, LLM, TST, ais-sop, viv; undeclared in addr-2nd; declared in aat-v3, vs-prior, vs-template |
| `Formal Expression` | 53 | 53 | 1,414 | 0.29 | D R | hd | the claim itself, with equation-level tags; in AAT 21, TST 8, ELI 6, addr-2nd 4, vs-prior 4, ais-sop 3, viv 3, vs-template 3, LLM 1; required in AAT, ELI, LLM, TST, ais-sop, viv; undeclared in addr… |
| `*[Definition]*`﹖ | 15 | 15 | 15 | 0.00 | D O* | ot | inline tag opening a definition statement; in addr-2nd 4, aat-v3 4, vs-prior 4, vs-template 3; undeclared in addr-2nd, vs-prior, vs-template; declared in aat-v3 |
| `Claim Record`﹖ | 6 | 6 | 250 | 0.05 | D O | hd | per-claim register, population, true/false-of, falsifier, instantiated; holds 17 ### claims in 6 files, each with fields Register, Population, True of, False of, Falsifier, Instantiated; in AAT 6 |
| `Max attainable status`﹖ | 5 | 5 | 5 | 0.00 | D O | la | ceiling: strongest status it could ever reach; in ELI 5 |
| `*[of]*`﹖ | 4 | 4 | 4 | 0.00 | D O* | ot | inline tag attaching later prose to a statement; in aat-v3 4 |
| `*[Choice]*`﹖ | 3 | 3 | 3 | 0.00 | D O* | ot | inline tag opening a choice statement; in aat-v3 3 |
| `*[Claim]*`﹖ | 2 | 2 | 2 | 0.00 | D O* | ot | inline tag opening a claim statement; in aat-v3 2 |
| *(88 minor slots)* |  |  | 1,101 | 0.22 | U O* |  | listed below |

*Minor and undeclared slots:* What would strengthen this (5), Memorata-search queries (5), What would soften this (4), Upstream files (4), Internal references (4), Open questions for verification (4), Promotion-blocking (4), Source.store (4), Source.slug (4), Source.commit (4), Source.type (4), Source.status (4), Source.stage (4), Statements.as (4), Migration note (3), Terms-required (3), Terms-relevant (3), Statements.defined-by (3), Statements.premise (3), … (+69 more)

### Discussion

**Total Files**: 56  
**Total Lines**: 5,289  
**Where**: AAT 25, viv 12, ais-resp 8, LLM 4, addr-2nd 3, vs-prior 2, udon-theory 1, TFT 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Title)` | 55 | 55 | 55 | 0.01 | D* R | im | title; ASF prefixes it with the type word; in AAT 25, viv 12, ais-resp 8, LLM 4, addr-2nd 3, vs-prior 2, TFT 1; undeclared in TFT, addr-2nd; required in AAT, LLM, ais-resp, viv; declared in vs-prior |
| `Slug` | 54 | 54 | 54 | 0.01 | D R | fm | identity (= filename); in AAT 25, viv 12, ais-resp 8, LLM 4, addr-2nd 3, vs-prior 2; required in AAT, LLM, ais-resp, viv; undeclared in addr-2nd, vs-prior |
| `Status` | 54 | 54 | 54 | 0.01 | D R | fm | epistemic strength; in AAT 25, viv 12, ais-resp 8, LLM 4, addr-2nd 3, vs-prior 2; required in AAT, LLM, ais-resp, viv; undeclared in addr-2nd, vs-prior |
| `Depends` | 54 | 54 | 246 | 0.05 | D R | fm | prerequisite slugs; in AAT 25, viv 12, ais-resp 8, LLM 4, addr-2nd 3, vs-prior 2; required in AAT, LLM, ais-resp, viv; undeclared in addr-2nd, vs-prior |
| `(Preamble)` | 52 | 52 | 99 | 0.02 | D* R | im | one-sentence statement of the claim, no heading; in AAT 25, viv 12, ais-resp 5, LLM 4, addr-2nd 3, vs-prior 2, TFT 1; undeclared in TFT, addr-2nd; required in AAT, LLM, ais-resp, viv; declared in v… |
| `Type` | 41 | 41 | 41 | 0.01 | D R | fm | kind of claim; in AAT 25, viv 12, LLM 4 |
| `Stage` | 41 | 41 | 41 | 0.01 | D R | fm | working-process state (current-state marker); in AAT 25, viv 12, LLM 4 |
| `(Title › Discussion)`﹖ | 33 | 33 | 33 | 0.01 | U* O* | im | in AAT 25, ais-resp 2, LLM 2, addr-2nd 2, vs-prior 2 |
| `Form`﹖ | 13 | 13 | 13 | 0.00 | D O* | fm | its kind; in ais-resp 8, addr-2nd 3, vs-prior 2; declared in ais-resp; undeclared in addr-2nd, vs-prior |
| `Max`﹖ | 13 | 13 | 13 | 0.00 | D O* | fm | the ceiling its status can reach; in ais-resp 8, addr-2nd 3, vs-prior 2; declared in ais-resp; undeclared in addr-2nd, vs-prior |
| `State`﹖ | 13 | 13 | 13 | 0.00 | D O* | fm | process flags; in ais-resp 8, addr-2nd 3, vs-prior 2; declared in ais-resp; undeclared in addr-2nd, vs-prior |
| `Type-expected`﹖ | 7 | 7 | 7 | 0.00 | D O* | fm | predicted type once established; in addr-2nd 3, ais-resp 2, vs-prior 2; declared in ais-resp; undeclared in addr-2nd, vs-prior |
| `Working Notes`﹖ | 50 | 50 | 891 | 0.17 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon); in AAT 25, viv 12, ais-resp 4, LLM 4, addr-2nd 3, vs-prior 2; optional in AAT, LLM, ais-resp, viv; undeclared in addr-2nd; declar… |
| `Epistemic Status` | 43 | 43 | 346 | 0.07 | D R | hd | what is derived vs assumed; tier and ceiling; in AAT 25, viv 12, LLM 4, addr-2nd 2; optional in AAT, LLM; required in viv; undeclared in addr-2nd |
| `Discussion` | 41 | 41 | 498 | 0.09 | D R | hd | interpretation and connections; in AAT 24, viv 12, LLM 4, addr-2nd 1; required in AAT, LLM, viv; undeclared in addr-2nd |
| `Formal Expression` | 33 | 33 | 1,365 | 0.26 | D R | hd | the claim itself, with equation-level tags; in AAT 17, viv 12, LLM 4; optional in AAT, LLM; required in viv |
| `Findings`﹖ | 13 | 13 | 332 | 0.06 | D O | hd | catalog entries surfaced into FINDINGS.md; holds 14 ### findings in 13 files, each with fields Brief, Impact, Novelty Claim, Related Work, Search Log; in AAT 13 |
| `Max attainable status`﹖ | 2 | 2 | 2 | 0.00 | D O | la | ceiling: strongest status it could ever reach; in LLM 2 |
| `(Preamble)` | 1 | 1 | 3 | 0.00 | D* R | im | title, one-line summary, any lead paragraph before the first ##; attribute section before the first slot; in udon-theory 1 |
| `Title` | 1 | 1 | 1 | 0.00 | D R | ot | human-readable slug; in udon-theory 1 |
| `Summary` | 1 | 1 | 2 | 0.00 | D R | ot | one sentence; in udon-theory 1 |
| `Discussion` | 1 | 1 | 19 | 0.00 | D R | ot | interpretation and connections; in udon-theory 1 |
| `Formal-expression`﹖ | 0 | 0 | 0 | 0.00 | U O* | ot | the claim; declared, filled by no file |
| `Epistemic-status`﹖ | 0 | 0 | 0 | 0.00 | U O* | ot | derived vs assumed; ceiling; declared, filled by no file |
| `Working-notes`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | forward pointers, guards, dead ends; declared, filled by no file |
| *(139 minor slots)* |  |  | 1,620 | 0.31 | U O* |  | listed below |

*Minor and undeclared slots:* Group (8), Migration note (5), Joseph's statement (4), The pattern (4), Why This Pattern Matters (3), Terms-relevant (3), Working Notes › Incidental audit gold (16), Outline (2), … (+130 more)

### Derived

**Total Files**: 44  
**Total Lines**: 6,414  
**Where**: AAT 24, TFT 7, TST 6, ELI 5, LLM 2  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Preamble)` | 44 | 44 | 104 | 0.02 | D* R | im | one-sentence statement of the claim, no heading; undeclared in TFT; required in AAT, ELI, LLM, TST |
| `(Title)` | 44 | 44 | 44 | 0.01 | D* R | im | title; ASF prefixes it with the type word; undeclared in TFT; required in AAT, ELI, LLM, TST |
| `Slug` | 37 | 37 | 37 | 0.01 | D R | fm | identity (= filename); in AAT 24, TST 6, ELI 5, LLM 2 |
| `Type` | 37 | 37 | 37 | 0.01 | D R | fm | kind of claim; in AAT 24, TST 6, ELI 5, LLM 2 |
| `Status` | 37 | 37 | 37 | 0.01 | D R | fm | epistemic strength; in AAT 24, TST 6, ELI 5, LLM 2 |
| `Depends` | 37 | 37 | 206 | 0.03 | D R | fm | prerequisite slugs; in AAT 24, TST 6, ELI 5, LLM 2 |
| `Stage` | 37 | 37 | 37 | 0.01 | D R | fm | working-process state (current-state marker); in AAT 24, TST 6, ELI 5, LLM 2 |
| `(Title › Derived)`﹖ | 35 | 35 | 35 | 0.01 | U* O* | im | in AAT 23, TST 6, ELI 4, LLM 2 |
| `Formal Expression` | 37 | 37 | 2,011 | 0.31 | D R | hd | the claim itself, with equation-level tags; holds 47 named ### parts in 12 files, each with fields Finite reserves, Structural collapse; 7 ### items in 5 files; in AAT 24, TST 6, ELI 5, LLM 2 |
| `Epistemic Status` | 37 | 37 | 394 | 0.06 | D R | hd | what is derived vs assumed; tier and ceiling; in AAT 24, TST 6, ELI 5, LLM 2 |
| `Discussion` | 37 | 37 | 672 | 0.10 | D R | hd | interpretation and connections; in AAT 24, TST 6, ELI 5, LLM 2 |
| `Working Notes`﹖ | 37 | 37 | 935 | 0.15 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon); in AAT 24, TST 6, ELI 5, LLM 2 |
| `Findings`﹖ | 11 | 11 | 263 | 0.04 | D O | hd | catalog entries surfaced into FINDINGS.md; holds 8 ### findings in 8 files, each with fields Brief, Impact, Novelty Claim, Related Work, Search Log; in AAT 8, TST 2, LLM 1 |
| `Claim Record`﹖ | 6 | 6 | 292 | 0.05 | D O | hd | per-claim register, population, true/false-of, falsifier, instantiated; holds 20 ### claims in 6 files, each with fields Register, Population, True of, False of, Falsifier, Instantiated; in AAT 6 |
| `Formal Expression › What Is Derived vs. What Is Chosen`﹖ | 3 | 3 | 46 | 0.01 | D O | hd | derivation-audit table: each claim, its source, its strength; in AAT 3 |
| *(196 minor slots)* |  |  | 2,526 | 0.39 | U O* |  | listed below |

*Minor and undeclared slots:* (Slug) (7), Migration note (6), Epistemic status (5), Domain Instantiations (4), Open Questions (3), Boyd (3), Domain instantiations (3), What would strengthen this (3), … (+187 more)

### Claim

**Total Files**: 43  
**Total Lines**: 1,790  
**Where**: ais-resp 28, vs-prior 10, vs-template 2, ais-sop 2, addr-2nd 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 43 | 43 | 43 | 0.02 | D R | fm | identity; required in ais-resp, ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `Form` | 43 | 43 | 43 | 0.02 | D R* | fm | its kind; declared in ais-resp, ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `Status` | 43 | 43 | 43 | 0.02 | D R | fm | standing; required in ais-resp, ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `Max` | 43 | 43 | 43 | 0.02 | D R* | fm | the ceiling its status can reach; declared in ais-resp, ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `State` | 43 | 43 | 43 | 0.02 | D R* | fm | process flags; declared in ais-resp, ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `Depends` | 43 | 43 | 43 | 0.02 | D R | fm | what it rests on; required in ais-resp, ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `(Title)` | 43 | 43 | 43 | 0.02 | D* R | im | the segment's name / one-line claim; required in ais-resp, ais-sop; undeclared in addr-2nd; declared in vs-prior, vs-template |
| `Type-expected`﹖ | 37 | 37 | 37 | 0.02 | D O* | fm | predicted type once established; declared in ais-resp, ais-sop; undeclared in addr-2nd, vs-prior, vs-template |
| `(Preamble)` | 37 | 37 | 37 | 0.02 | D* R | im | unheaded text between the title and the first section (summary line, status line); required in ais-resp, ais-sop; undeclared in addr-2nd; declared in vs-prior, vs-template |
| `(Title › Claim)`﹖ | 37 | 37 | 37 | 0.02 | U* O* | im |  |
| `Group`﹖ | 28 | 28 | 28 | 0.02 | U O* | fm | outline group; in ais-resp 28 |
| `(Title › Core line N)`﹖ | 4 | 4 | 4 | 0.00 | U* O* | im | in ais-resp 4 |
| `Working Notes`﹖ | 15 | 15 | 113 | 0.06 | D O | hd | the inbox: open items with leans, cautions, provenance; not canon; in vs-prior 10, ais-sop 2, vs-template 2, addr-2nd 1; optional in ais-sop; undeclared in addr-2nd; declared in vs-prior, vs-template |
| `Formal Expression` | 13 | 13 | 221 | 0.12 | D R | hd | the formal statement itself: math, definition, rule; in vs-prior 8, ais-sop 2, vs-template 2, addr-2nd 1; required in ais-sop; undeclared in addr-2nd; declared in vs-prior, vs-template |
| `Epistemic Status` | 13 | 13 | 54 | 0.03 | D R | hd | how strongly the body is warranted, and on what; in vs-prior 8, ais-sop 2, vs-template 2, addr-2nd 1; required in ais-sop; undeclared in addr-2nd; declared in vs-prior, vs-template |
| `Discussion`﹖ | 12 | 12 | 120 | 0.07 | D O* | hd | why it is cut this way; argument and context around the formal body; in vs-prior 8, ais-sop 2, vs-template 2 |
| *(64 minor slots)* |  |  | 754 | 0.42 | U O* |  | listed below |

*Minor and undeclared slots:* Outline (11), [Claim] (10), In Joseph's words (7), Joseph's statement (6), Gloss (6), Backing (6), The claim (5), Inner argument (4), References (4), Clean attractor (3), Residue attractor (3), … (+53 more)

### Derivation

**Total Files**: 37  
**Total Lines**: 7,138  
**Where**: AAT 36, ELI 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 37 | 37 | 37 | 0.01 | D R | fm | identity (= filename) |
| `Type` | 37 | 37 | 37 | 0.01 | D R | fm | kind of claim |
| `Status` | 37 | 37 | 37 | 0.01 | D R | fm | epistemic strength |
| `Depends` | 37 | 37 | 215 | 0.03 | D R | fm | prerequisite slugs |
| `Stage` | 37 | 37 | 37 | 0.01 | D R | fm | working-process state (current-state marker) |
| `(Preamble)` | 37 | 37 | 72 | 0.01 | D* R | im | one-sentence statement of the claim, no heading |
| `(Title)` | 37 | 37 | 37 | 0.01 | D* R | im | title; ASF prefixes it with the type word |
| `(Title › Derivation)`﹖ | 36 | 36 | 36 | 0.01 | U* O* | im | in AAT 36 |
| `Epistemic Status` | 37 | 37 | 391 | 0.05 | D R | hd | what is derived vs assumed; tier and ceiling |
| `Discussion` | 37 | 37 | 508 | 0.07 | D R | hd | interpretation and connections; holds 1 named ### parts in 1 file; 1 ### item in 1 file |
| `Working Notes`﹖ | 35 | 35 | 666 | 0.09 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon) |
| `Formal Expression` | 30 | 30 | 2,687 | 0.38 | D R | hd | the claim itself, with equation-level tags; holds 98 named ### parts in 23 files; 13 ### items in 9 files |
| `Findings`﹖ | 15 | 15 | 395 | 0.06 | D O | hd | catalog entries surfaced into FINDINGS.md; holds 16 ### findings in 15 files, each with fields Brief, Impact, Novelty Claim, Related Work, Search Log; in AAT 15 |
| `Formal Expression › What Is Derived vs. What Is Chosen`﹖ | 9 | 9 | 173 | 0.02 | D O | hd | derivation-audit table: each claim, its source, its strength; in AAT 9 |
| `What Is Derived vs. What Is Chosen`﹖ | 3 | 3 | 79 | 0.01 | D O | hd | derivation-audit table: each claim, its source, its strength; in AAT 3 |
| `Max attainable`﹖ | 3 | 3 | 3 | 0.00 | D O | la | ceiling: strongest status it could ever reach; in AAT 3 |
| `Claim Record`﹖ | 3 | 3 | 188 | 0.03 | D O | hd | per-claim register, population, true/false-of, falsifier, instantiated; holds 13 ### claims in 3 files, each with fields Register, Population, True of, False of, Falsifier, Instantiated; in AAT 3 |
| `Summary of Results › What Is Derived vs. What Is Chosen`﹖ | 1 | 1 | 29 | 0.00 | D O | hd | derivation-audit table: each claim, its source, its strength; in AAT 1 |
| *(87 minor slots)* |  |  | 2,446 | 0.34 | U O* |  | listed below |

*Minor and undeclared slots:* Migration note (4), Setup (3), Motivation (3), What is load-bearing (3), Working Notes › Incidental audit gold (11), Formal Expression › Setup (8), Formal Expression › No-go (4), … (+80 more)

### Term

**Total Files**: 29  
**Total Lines**: 275  
**Where**: addr-2nd 29  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Term`﹖ | 28 | 28 | 228 | 0.83 | U O* | ot | one term: one-line definition, inflections, synonyms/avoid |
| `Invariants`﹖ | 28 | 28 | 115 | 0.42 | U O* | ot | what must always hold |
| *(3 ad hoc headings)* |  |  | 13 | 0.05 | U O* |  | listed below |

*Minor and undeclared slots:* |open; |note; |quote

### Observation

**Total Files**: 28  
**Total Lines**: 2,034  
**Where**: viv 17, AAT 3, LLM 2, ELI 2, addr-2nd 1, vs-prior 1, udon-theory 1, TST 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 27 | 27 | 27 | 0.01 | D R | fm | identity (= filename); in viv 17, AAT 3, LLM 2, ELI 2, TST 1, addr-2nd 1, vs-prior 1; required in AAT, ELI, LLM, TST, viv; undeclared in addr-2nd, vs-prior |
| `Status` | 27 | 27 | 27 | 0.01 | D R | fm | epistemic strength; in viv 17, AAT 3, LLM 2, ELI 2, TST 1, addr-2nd 1, vs-prior 1; required in AAT, ELI, LLM, TST, viv; undeclared in addr-2nd, vs-prior |
| `Depends` | 27 | 27 | 145 | 0.07 | D R | fm | prerequisite slugs; in viv 17, AAT 3, LLM 2, ELI 2, TST 1, addr-2nd 1, vs-prior 1; required in AAT, ELI, LLM, TST, viv; undeclared in addr-2nd, vs-prior |
| `(Preamble)` | 27 | 27 | 40 | 0.02 | D* R | im | one-sentence statement of the claim, no heading; in viv 17, AAT 3, LLM 2, ELI 2, TST 1, addr-2nd 1, vs-prior 1; required in AAT, ELI, LLM, TST, viv; undeclared in addr-2nd; declared in vs-prior |
| `(Title)` | 27 | 27 | 27 | 0.01 | D* R | im | title; ASF prefixes it with the type word; in viv 17, AAT 3, LLM 2, ELI 2, TST 1, addr-2nd 1, vs-prior 1; required in AAT, ELI, LLM, TST, viv; undeclared in addr-2nd; declared in vs-prior |
| `Type` | 25 | 25 | 25 | 0.01 | D R | fm | kind of claim; in viv 17, AAT 3, LLM 2, ELI 2, TST 1 |
| `Stage` | 25 | 25 | 25 | 0.01 | D R | fm | working-process state (current-state marker); in viv 17, AAT 3, LLM 2, ELI 2, TST 1 |
| `(Title › Observation)`﹖ | 9 | 9 | 9 | 0.00 | U* O* | im | in AAT 3, LLM 2, TST 1, ELI 1, addr-2nd 1, vs-prior 1 |
| `Epistemic Status` | 25 | 25 | 207 | 0.10 | D R | hd | what is derived vs assumed; tier and ceiling; in viv 17, AAT 3, TST 1, LLM 1, ELI 1, addr-2nd 1, vs-prior 1; required in AAT, ELI, LLM, TST, viv; undeclared in addr-2nd; declared in vs-prior |
| `Discussion` | 25 | 25 | 201 | 0.10 | D R | hd | interpretation and connections; in viv 17, AAT 3, LLM 2, TST 1, ELI 1, vs-prior 1; required in AAT, ELI, LLM, TST, viv; declared in vs-prior |
| `Formal Expression` | 24 | 24 | 784 | 0.39 | D R | hd | the claim itself, with equation-level tags; in viv 17, AAT 2, TST 1, LLM 1, ELI 1, addr-2nd 1, vs-prior 1; required in AAT, ELI, LLM, TST, viv; undeclared in addr-2nd; declared in vs-prior |
| `Working Notes`﹖ | 23 | 23 | 233 | 0.11 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon); in viv 17, AAT 2, TST 1, LLM 1, ELI 1, vs-prior 1; optional in AAT, ELI, LLM, TST, viv; declared in vs-prior |
| `(Preamble)` | 1 | 1 | 6 | 0.00 | D* R | im | title, one-line summary, any lead paragraph before the first ##; attribute section before the first slot; in udon-theory 1 |
| `Title` | 1 | 1 | 1 | 0.00 | D R | ot | human-readable slug; in udon-theory 1 |
| `Summary` | 1 | 1 | 2 | 0.00 | D R | ot | one sentence; in udon-theory 1 |
| `Formal-expression` | 1 | 1 | 24 | 0.01 | D R | ot | the claim; in udon-theory 1 |
| `Epistemic-status` | 1 | 1 | 4 | 0.00 | D R | ot | derived vs assumed; ceiling; in udon-theory 1 |
| `Discussion` | 1 | 1 | 4 | 0.00 | D R | ot | interpretation and connections; in udon-theory 1 |
| `Working-notes`﹖ | 1 | 1 | 3 | 0.00 | D O | ot | forward pointers, guards, dead ends; in udon-theory 1 |
| *(68 minor slots)* |  |  | 245 | 0.12 | U O* |  | listed below |

*Minor and undeclared slots:* Do not re-claim (3), [Observation] (2), Instrument (2), Owed (2), Instruments (2), Consumers (2), Form (2), Type-expected (2), Max (2), State (2), … (+58 more)

### Scope

**Total Files**: 27  
**Total Lines**: 2,585  
**Where**: AAT 8, LLM 6, ELI 4, viv 4, TST 3, aat-v3 1, TFT 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Preamble)` | 27 | 27 | 56 | 0.02 | D* R | im | one-sentence statement of the claim, no heading; undeclared in TFT, aat-v3; required in AAT, ELI, LLM, TST, viv |
| `(Title)` | 27 | 27 | 27 | 0.01 | D* R | im | title; ASF prefixes it with the type word; undeclared in TFT, aat-v3; required in AAT, ELI, LLM, TST, viv |
| `Depends` | 26 | 26 | 114 | 0.04 | D R | fm | prerequisite slugs; in AAT 8, LLM 6, ELI 4, viv 4, TST 3, aat-v3 1; required in AAT, ELI, LLM, TST, viv; declared in aat-v3 |
| `Slug` | 25 | 25 | 25 | 0.01 | D R | fm | identity (= filename); in AAT 8, LLM 6, ELI 4, viv 4, TST 3 |
| `Type` | 25 | 25 | 25 | 0.01 | D R | fm | kind of claim; in AAT 8, LLM 6, ELI 4, viv 4, TST 3 |
| `Status` | 25 | 25 | 25 | 0.01 | D R | fm | epistemic strength; in AAT 8, LLM 6, ELI 4, viv 4, TST 3 |
| `Stage` | 25 | 25 | 25 | 0.01 | D R | fm | working-process state (current-state marker); in AAT 8, LLM 6, ELI 4, viv 4, TST 3 |
| `(Title › Scope)`﹖ | 15 | 15 | 15 | 0.01 | U* O* | im | in AAT 8, TST 3, LLM 2, ELI 1, aat-v3 1 |
| `Source`﹖ | 1 | 1 | 1 | 0.00 | D O* | fm | where in ASF it was crossed from, at what commit; in aat-v3 1 |
| `Statements`﹖ | 1 | 1 | 1 | 0.00 | D O* | fm | the statements the segment is carved into, each with its kind and premises; in aat-v3 1 |
| `Working Notes`﹖ | 26 | 26 | 601 | 0.23 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon); in AAT 8, LLM 6, ELI 4, viv 4, TST 3, aat-v3 1; optional in AAT, ELI, LLM, TST, viv; declared in aat-v3 |
| `Epistemic Status` | 25 | 25 | 206 | 0.08 | D R | hd | what is derived vs assumed; tier and ceiling; in AAT 8, LLM 6, viv 4, TST 3, ELI 3, aat-v3 1; required in AAT, ELI, LLM, TST, viv; declared in aat-v3 |
| `Discussion` | 25 | 25 | 343 | 0.13 | D R | hd | interpretation and connections; in AAT 8, LLM 6, viv 4, TST 3, ELI 3, aat-v3 1; required in AAT, ELI, LLM, TST, viv; declared in aat-v3 |
| `Formal Expression` | 24 | 24 | 742 | 0.29 | D R | hd | the claim itself, with equation-level tags; in AAT 8, LLM 6, viv 4, TST 3, ELI 3 |
| `Max attainable status`﹖ | 7 | 7 | 7 | 0.00 | D O | la | ceiling: strongest status it could ever reach; in LLM 4, ELI 3 |
| `Findings`﹖ | 2 | 2 | 52 | 0.02 | D O | hd | catalog entries surfaced into FINDINGS.md; holds 1 ### finding in 1 file, each with fields Brief, Impact, Novelty Claim, Related Work, Search Log; in TST 1, LLM 1 |
| `*[Choice]*`﹖ | 1 | 1 | 1 | 0.00 | D O* | ot | inline tag opening a choice statement; in aat-v3 1 |
| `*[Claim]*`﹖ | 1 | 1 | 1 | 0.00 | D O* | ot | inline tag opening a claim statement; in aat-v3 1 |
| `*[Definition]*`﹖ | 1 | 1 | 1 | 0.00 | D O* | ot | inline tag opening a definition statement; in aat-v3 1 |
| `*[Scope]*`﹖ | 1 | 1 | 1 | 0.00 | D O* | ot | inline tag opening a scope statement; in aat-v3 1 |
| `*[Teaching]*`﹖ | 1 | 1 | 1 | 0.00 | D O* | ot | inline tag opening a teaching statement; in aat-v3 1 |
| `*[of]*`﹖ | 1 | 1 | 1 | 0.00 | D O* | ot | inline tag attaching later prose to a statement; in aat-v3 1 |
| *(78 minor slots)* |  |  | 875 | 0.34 | U O* |  | listed below |

*Minor and undeclared slots:* What would strengthen this (7), What would soften this (7), Upstream files (7), Memorata-search queries (7), Internal references (7), Open questions for verification (7), Promotion-blocking (7), Migration note (6), … (+70 more)

### Normative

**Total Files**: 26  
**Total Lines**: 1,155  
**Where**: viv 14, ais-resp 7, udon-theory 2, vs-prior 1, AAT 1, ELI 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 24 | 24 | 24 | 0.02 | D R | fm | identity (= filename); in viv 14, ais-resp 7, AAT 1, ELI 1, vs-prior 1; required in AAT, ELI, ais-resp, viv; undeclared in vs-prior |
| `Status` | 24 | 24 | 24 | 0.02 | D R | fm | epistemic strength; in viv 14, ais-resp 7, AAT 1, ELI 1, vs-prior 1; required in AAT, ELI, ais-resp, viv; undeclared in vs-prior |
| `Depends` | 24 | 24 | 58 | 0.05 | D R | fm | prerequisite slugs; in viv 14, ais-resp 7, AAT 1, ELI 1, vs-prior 1; required in AAT, ELI, ais-resp, viv; undeclared in vs-prior |
| `(Preamble)` | 24 | 24 | 28 | 0.02 | D* R | im | one-sentence statement of the claim, no heading; in viv 14, ais-resp 7, AAT 1, ELI 1, vs-prior 1; required in AAT, ELI, ais-resp, viv; declared in vs-prior |
| `(Title)` | 24 | 24 | 24 | 0.02 | D* R | im | title; ASF prefixes it with the type word; in viv 14, ais-resp 7, AAT 1, ELI 1, vs-prior 1; required in AAT, ELI, ais-resp, viv; declared in vs-prior |
| `Type` | 16 | 16 | 16 | 0.01 | D R | fm | kind of claim; in viv 14, AAT 1, ELI 1 |
| `Stage` | 16 | 16 | 16 | 0.01 | D R | fm | working-process state (current-state marker); in viv 14, AAT 1, ELI 1 |
| `Form`﹖ | 8 | 8 | 8 | 0.01 | D O* | fm | speech-act kind; in ais-resp 7, vs-prior 1; declared in ais-resp; undeclared in vs-prior |
| `Type-expected`﹖ | 8 | 8 | 8 | 0.01 | D O* | fm | expected asf type; in ais-resp 7, vs-prior 1; declared in ais-resp; undeclared in vs-prior |
| `Max`﹖ | 8 | 8 | 8 | 0.01 | D O* | fm | ceiling of strength; in ais-resp 7, vs-prior 1; declared in ais-resp; undeclared in vs-prior |
| `State`﹖ | 8 | 8 | 8 | 0.01 | D O* | fm | process-state flags; in ais-resp 7, vs-prior 1; declared in ais-resp; undeclared in vs-prior |
| `(Title › Norm)`﹖ | 8 | 8 | 8 | 0.01 | U* O* | im | in ais-resp 7, vs-prior 1 |
| `Formal Expression` | 16 | 16 | 224 | 0.19 | D R | hd | the claim itself, with equation-level tags; in viv 14, AAT 1, vs-prior 1; required in AAT, viv; declared in vs-prior |
| `Epistemic Status` | 16 | 16 | 91 | 0.08 | D R | hd | what is derived vs assumed; tier and ceiling; in viv 14, AAT 1, vs-prior 1; required in AAT, viv; declared in vs-prior |
| `Discussion` | 16 | 16 | 119 | 0.10 | D R | hd | interpretation and connections; in viv 14, AAT 1, vs-prior 1; required in AAT, viv; declared in vs-prior |
| `Working Notes`﹖ | 16 | 16 | 128 | 0.11 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon); in viv 14, AAT 1, vs-prior 1; optional in AAT, viv; declared in vs-prior |
| `(Preamble)` | 2 | 2 | 11 | 0.01 | D* R | im | title, one-line summary, any lead paragraph before the first ##; attribute section before the first slot; in udon-theory 2 |
| `Title` | 2 | 2 | 2 | 0.00 | D R | ot | human-readable slug; in udon-theory 2 |
| `Summary` | 2 | 2 | 4 | 0.00 | D R | ot | one sentence; in udon-theory 2 |
| `Formal-expression` | 2 | 2 | 32 | 0.03 | D R | ot | the claim; in udon-theory 2 |
| `Epistemic-status` | 2 | 2 | 6 | 0.01 | D R | ot | derived vs assumed; ceiling; in udon-theory 2 |
| `Discussion` | 2 | 2 | 8 | 0.01 | D R | ot | interpretation and connections; in udon-theory 2 |
| `Working-notes`﹖ | 2 | 2 | 6 | 0.01 | D O | ot | forward pointers, guards, dead ends; in udon-theory 2 |
| `Claim Record`﹖ | 1 | 1 | 16 | 0.01 | D O | hd | per-claim register, population, true/false-of, falsifier, instantiated; holds 1 ### claim in 1 file, each with fields Register, Population, True of, False of, Falsifier, Instantiated; in AAT 1 |
| *(31 minor slots)* |  |  | 238 | 0.21 | U O* |  | listed below |

*Minor and undeclared slots:* Group (7), Outline (5), Currently robust-qualitative (2), Companions (2), [Norm] (1), Constructive impossibility posture (1), Anti-collapse (1), Cousins in the same outline (1), … (+23 more)

### Detail

**Total Files**: 17  
**Total Lines**: 1,316  
**Where**: viv 15, AAT 2  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 17 | 17 | 17 | 0.01 | D R | fm | identity (= filename) |
| `Type` | 17 | 17 | 17 | 0.01 | D R | fm | kind of claim |
| `Status` | 17 | 17 | 17 | 0.01 | D R | fm | epistemic strength |
| `Depends` | 17 | 17 | 137 | 0.10 | D R | fm | prerequisite slugs |
| `Stage` | 17 | 17 | 17 | 0.01 | D R | fm | working-process state (current-state marker) |
| `(Preamble)` | 17 | 17 | 20 | 0.02 | D* R | im | one-sentence statement of the claim, no heading |
| `(Title)` | 17 | 17 | 17 | 0.01 | D* R | im | title; ASF prefixes it with the type word |
| `Epistemic Status` | 17 | 17 | 77 | 0.06 | D R | hd | what is derived vs assumed; tier and ceiling |
| `Working Notes`﹖ | 17 | 17 | 127 | 0.10 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon) |
| `Formal Expression` | 16 | 16 | 547 | 0.42 | D R | hd | the claim itself, with equation-level tags; holds 7 ### items in 1 file, each with fields Directional fidelity parameter, Sector parameter, No upper saturation, The linear approximation is exact when |
| `Discussion` | 16 | 16 | 70 | 0.05 | D R | hd | interpretation and connections |
| *(33 minor slots)* |  |  | 349 | 0.27 | U O* |  | listed below |

*Minor and undeclared slots:* Source peel (3), Max attainable (1), Working Notes › Incidental audit gold (1), Model S (1), Measurement Targets (1), Estimator Cookbook (1), … (+27 more)

### Discussion/Impl

**Total Files**: 17  
**Total Lines**: 1,400  
**Where**: AAT 9, TST 4, LLM 4  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 17 | 17 | 17 | 0.01 | D R | fm | identity (= filename) |
| `Type` | 17 | 17 | 17 | 0.01 | D R | fm | kind of claim |
| `Status` | 17 | 17 | 17 | 0.01 | D R | fm | epistemic strength |
| `Depends` | 17 | 17 | 183 | 0.13 | D R | fm | prerequisite slugs |
| `Stage` | 17 | 17 | 17 | 0.01 | D R | fm | working-process state (current-state marker) |
| `(Preamble)` | 17 | 17 | 25 | 0.02 | D* R | im | one-sentence statement of the claim, no heading |
| `(Title)` | 17 | 17 | 17 | 0.01 | D* R | im | title; ASF prefixes it with the type word |
| `(Title › Additional Implications & Discussion)` | 17 | 17 | 17 | 0.01 | U* R* | im |  |
| `Working Notes`﹖ | 17 | 17 | 332 | 0.24 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon) |
| *(84 minor slots)* |  |  | 835 | 0.60 | U O* |  | listed below |

*Minor and undeclared slots:* Working Notes › Incidental audit gold (7), The loop is a Pearl-Level-2 engine (1), The sandbox hard ceiling (1), One pattern, multiple deployment modes (1), … (+80 more)

### Hypothesis

**Total Files**: 16  
**Total Lines**: 1,604  
**Where**: AAT 8, TST 3, LLM 2, ELI 2, TFT 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Preamble)` | 16 | 16 | 31 | 0.02 | D* R | im | one-sentence statement of the claim, no heading; undeclared in TFT; required in AAT, ELI, LLM, TST |
| `(Title)` | 16 | 16 | 16 | 0.01 | D* R | im | title; ASF prefixes it with the type word; undeclared in TFT; required in AAT, ELI, LLM, TST |
| `Slug` | 15 | 15 | 15 | 0.01 | D R | fm | identity (= filename); in AAT 8, TST 3, LLM 2, ELI 2 |
| `Type` | 15 | 15 | 15 | 0.01 | D R | fm | kind of claim; in AAT 8, TST 3, LLM 2, ELI 2 |
| `Status` | 15 | 15 | 15 | 0.01 | D R | fm | epistemic strength; in AAT 8, TST 3, LLM 2, ELI 2 |
| `Depends` | 15 | 15 | 66 | 0.04 | D R | fm | prerequisite slugs; in AAT 8, TST 3, LLM 2, ELI 2 |
| `Stage` | 15 | 15 | 15 | 0.01 | D R | fm | working-process state (current-state marker); in AAT 8, TST 3, LLM 2, ELI 2 |
| `(Title › Hypothesis)`﹖ | 13 | 13 | 13 | 0.01 | U* O* | im | in AAT 8, TST 3, LLM 2 |
| `Epistemic Status` | 15 | 15 | 144 | 0.09 | D R | hd | what is derived vs assumed; tier and ceiling; in AAT 8, TST 3, LLM 2, ELI 2 |
| `Discussion` | 14 | 14 | 274 | 0.17 | D R | hd | interpretation and connections; in AAT 8, TST 3, ELI 2, LLM 1 |
| `Working Notes`﹖ | 14 | 14 | 330 | 0.21 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon); in AAT 8, TST 3, ELI 2, LLM 1 |
| `Formal Expression` | 13 | 13 | 364 | 0.23 | D R | hd | the claim itself, with equation-level tags; in AAT 8, TST 3, ELI 2 |
| `Findings`﹖ | 1 | 1 | 22 | 0.01 | D O | hd | catalog entries surfaced into FINDINGS.md; holds 1 ### finding in 1 file, each with fields Brief, Impact, Novelty Claim, Related Work, Search Log; in TST 1 |
| *(52 minor slots)* |  |  | 602 | 0.38 | U O* |  | listed below |

*Minor and undeclared slots:* Working Notes › Incidental audit gold (6), (Slug) (1), Epistemic status (1), Why this is non-trivial (1), Exploit (1), Explore (1), Causal Information Yield (1), … (+45 more)

### Result

**Total Files**: 14  
**Total Lines**: 2,253  
**Where**: AAT 11, LLM 2, TST 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 14 | 14 | 14 | 0.01 | D R | fm | identity (= filename) |
| `Type` | 14 | 14 | 14 | 0.01 | D R | fm | kind of claim |
| `Status` | 14 | 14 | 14 | 0.01 | D R | fm | epistemic strength |
| `Depends` | 14 | 14 | 91 | 0.04 | D R | fm | prerequisite slugs |
| `Stage` | 14 | 14 | 14 | 0.01 | D R | fm | working-process state (current-state marker) |
| `(Preamble)` | 14 | 14 | 51 | 0.02 | D* R | im | one-sentence statement of the claim, no heading |
| `(Title)` | 14 | 14 | 14 | 0.01 | D* R | im | title; ASF prefixes it with the type word |
| `(Title › Result)` | 14 | 14 | 14 | 0.01 | U* R* | im |  |
| `Formal Expression` | 14 | 14 | 766 | 0.34 | D R | hd | the claim itself, with equation-level tags |
| `Epistemic Status` | 14 | 14 | 113 | 0.05 | D R | hd | what is derived vs assumed; tier and ceiling |
| `Discussion` | 14 | 14 | 257 | 0.11 | D R | hd | interpretation and connections |
| `Working Notes`﹖ | 14 | 14 | 401 | 0.18 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon) |
| `Working Notes › Incidental audit gold`﹖ | 10 | 10 | 315 | 0.14 | U O* | hd | per-segment gold lifted from de-novo audit reflections (routing.sop §8); in AAT 10 |
| `Claim Record`﹖ | 4 | 4 | 260 | 0.12 | D O | hd | per-claim register, population, true/false-of, falsifier, instantiated; holds 18 ### claims in 4 files, each with fields Register, Population, True of, False of, Falsifier, Instantiated; in AAT 4 |
| `Findings`﹖ | 4 | 4 | 99 | 0.04 | D O | hd | catalog entries surfaced into FINDINGS.md; holds 4 ### findings in 4 files, each with fields Brief, Impact, Novelty Claim, Related Work, Search Log; in AAT 4 |
| *(23 minor slots)* |  |  | 247 | 0.11 | U O* |  | listed below |

*Minor and undeclared slots:* Formal Expression › Derivation (2), Migration note (2), Derivation (1), Max attainable (1), Honest failure modes (1), Discussion › Connections (1), … (+17 more)

### Reference

**Total Files**: 10  
**Total Lines**: 1,586  
**Where**: ais-resp 4, TFT 2, ais-sop 2, vs-template 2  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Preamble)`﹖ | 9 | 9 | 37 | 0.02 | U* O* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)`﹖ | 9 | 9 | 9 | 0.01 | U* O* | im | the segment's name / one-line claim |
| `Slug`﹖ | 8 | 8 | 8 | 0.01 | U O* | fm | identity (= filename); in ais-resp 4, ais-sop 2, vs-template 2 |
| `Form`﹖ | 8 | 8 | 8 | 0.01 | U O* | fm | speech-act kind; in ais-resp 4, ais-sop 2, vs-template 2 |
| `Status`﹖ | 8 | 8 | 8 | 0.01 | U O* | fm | strength / lifecycle state; in ais-resp 4, ais-sop 2, vs-template 2 |
| `Max`﹖ | 8 | 8 | 8 | 0.01 | U O* | fm | ceiling of strength; in ais-resp 4, ais-sop 2, vs-template 2 |
| `State`﹖ | 8 | 8 | 8 | 0.01 | U O* | fm | process-state flags; in ais-resp 4, ais-sop 2, vs-template 2 |
| `Depends`﹖ | 8 | 8 | 8 | 0.01 | U O* | fm | prerequisites; in ais-resp 4, ais-sop 2, vs-template 2 |
| *(109 minor slots)* |  |  | 2,687 | 1.69 | U O* |  | listed below |

*Minor and undeclared slots:* Source (4), Retrieved (4), Fidelity (4), Cite-by (4), (Slug) (2), The Model (2), Built (2), Planned (2), Working Notes (2), Re-verified (2), Model sufficiency (1), Scope (1), … (+97 more)

### Postulate

**Total Files**: 9  
**Total Lines**: 443  
**Where**: vs-prior 3, viv 2, vs-template 1, ais-sop 1, AAT 1, TST 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 9 | 9 | 9 | 0.02 | D R | fm | identity (= filename); required in AAT, TST, ais-sop, viv; undeclared in vs-prior, vs-template |
| `Status` | 9 | 9 | 9 | 0.02 | D R | fm | epistemic strength; required in AAT, TST, ais-sop, viv; undeclared in vs-prior, vs-template |
| `Depends` | 9 | 9 | 11 | 0.02 | D R | fm | prerequisite slugs; required in AAT, TST, ais-sop, viv; undeclared in vs-prior, vs-template |
| `(Preamble)` | 9 | 9 | 10 | 0.02 | D* R | im | one-sentence statement of the claim, no heading; required in AAT, TST, ais-sop, viv; declared in vs-prior, vs-template |
| `(Title)` | 9 | 9 | 9 | 0.02 | D* R | im | title; ASF prefixes it with the type word; required in AAT, TST, ais-sop, viv; declared in vs-prior, vs-template |
| `(Title › Postulate)`﹖ | 7 | 7 | 7 | 0.02 | U* O* | im | in vs-prior 3, ais-sop 1, AAT 1, TST 1, vs-template 1 |
| `Form`﹖ | 5 | 5 | 5 | 0.01 | D O* | fm | its kind; in vs-prior 3, ais-sop 1, vs-template 1; declared in ais-sop; undeclared in vs-prior, vs-template |
| `Type-expected`﹖ | 5 | 5 | 5 | 0.01 | D O* | fm | predicted type once established; in vs-prior 3, ais-sop 1, vs-template 1; declared in ais-sop; undeclared in vs-prior, vs-template |
| `Max`﹖ | 5 | 5 | 5 | 0.01 | D O* | fm | the ceiling its status can reach; in vs-prior 3, ais-sop 1, vs-template 1; declared in ais-sop; undeclared in vs-prior, vs-template |
| `State`﹖ | 5 | 5 | 5 | 0.01 | D O* | fm | process flags; in vs-prior 3, ais-sop 1, vs-template 1; declared in ais-sop; undeclared in vs-prior, vs-template |
| `Type` | 4 | 4 | 4 | 0.01 | D R | fm | kind of claim; in viv 2, AAT 1, TST 1 |
| `Stage` | 4 | 4 | 4 | 0.01 | D R | fm | working-process state (current-state marker); in viv 2, AAT 1, TST 1 |
| `Formal Expression` | 9 | 9 | 99 | 0.22 | D R | hd | the claim itself, with equation-level tags; required in AAT, TST, ais-sop, viv; declared in vs-prior, vs-template |
| `Epistemic Status` | 9 | 9 | 40 | 0.09 | D R | hd | what is derived vs assumed; tier and ceiling; required in AAT, TST, ais-sop, viv; declared in vs-prior, vs-template |
| `Discussion` | 9 | 9 | 107 | 0.24 | D R | hd | interpretation and connections; declared in ais-sop, vs-prior, vs-template; required in AAT, TST, viv |
| `Working Notes`﹖ | 9 | 9 | 84 | 0.19 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon); optional in AAT, TST, ais-sop, viv; declared in vs-prior, vs-template |
| *(8 minor slots)* |  |  | 47 | 0.11 | U O* |  | listed below |

*Minor and undeclared slots:* [Postulate] (4), Working Notes › Incidental audit gold (1), Functional (1), Non-functional (1), Quality (1), Sustainability (1), Impact on others (1), Known incomplete surfaces (1)

### Card

**Total Files**: 9  
**Total Lines**: 172  
**Where**: ais-resp 9  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 9 | 9 | 9 | 0.05 | U R* | fm | identity (= filename) |
| `Form` | 9 | 9 | 9 | 0.05 | U R* | fm | speech-act kind |
| `Status` | 9 | 9 | 9 | 0.05 | U R* | fm | strength / lifecycle state |
| `State` | 9 | 9 | 9 | 0.05 | U R* | fm | process-state flags |
| `Depends` | 9 | 9 | 9 | 0.05 | U R* | fm | prerequisites |
| `Group` | 9 | 9 | 9 | 0.05 | U R* | fm | outline group |
| `(Preamble)` | 9 | 9 | 41 | 0.24 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 9 | 9 | 9 | 0.05 | U* R* | im | the segment's name / one-line claim |

### Sketch

**Total Files**: 9  
**Total Lines**: 325  
**Where**: viv 8, AAT 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 9 | 9 | 9 | 0.03 | D R | fm | identity (= filename) |
| `Type` | 9 | 9 | 9 | 0.03 | D R | fm | kind of claim |
| `Status` | 9 | 9 | 9 | 0.03 | D R | fm | epistemic strength |
| `Depends` | 9 | 9 | 41 | 0.13 | D R | fm | prerequisite slugs |
| `Stage` | 9 | 9 | 9 | 0.03 | D R | fm | working-process state (current-state marker) |
| `(Preamble)` | 9 | 9 | 10 | 0.03 | D* R | im | one-sentence statement of the claim, no heading |
| `(Title)` | 9 | 9 | 9 | 0.03 | D* R | im | title; ASF prefixes it with the type word |
| `Epistemic Status` | 9 | 9 | 42 | 0.13 | D R | hd | what is derived vs assumed; tier and ceiling |
| `Working Notes`﹖ | 9 | 9 | 53 | 0.16 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon) |
| `Formal Expression` | 8 | 8 | 64 | 0.20 | D R | hd | the claim itself, with equation-level tags; in viv 8 |
| `Discussion` | 2 | 2 | 8 | 0.02 | D R | hd | interpretation and connections |
| `Max attainable`﹖ | 1 | 1 | 1 | 0.00 | D O | la | ceiling: strongest status it could ever reach; in viv 1 |
| *(11 minor slots)* |  |  | 34 | 0.10 | U O* |  | listed below |

*Minor and undeclared slots:* What the corollary licenses (1), What it does not license without further argument (1), The Open Question (1), Proposed Direction (1), Baseline re-anchor (1), … (+6 more)

### Worked-example

**Total Files**: 7  
**Total Lines**: 1,301  
**Where**: AAT 4, TFT 2, viv 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Preamble)` | 7 | 7 | 10 | 0.01 | D* R | im | one-sentence statement of the claim, no heading; undeclared in TFT; required in AAT, viv |
| `(Title)` | 7 | 7 | 7 | 0.01 | D* R | im | title; ASF prefixes it with the type word; undeclared in TFT; required in AAT, viv |
| `Slug` | 5 | 5 | 5 | 0.00 | D R | fm | identity (= filename); in AAT 4, viv 1 |
| `Type` | 5 | 5 | 5 | 0.00 | D R | fm | kind of claim; in AAT 4, viv 1 |
| `Status` | 5 | 5 | 5 | 0.00 | D R | fm | epistemic strength; in AAT 4, viv 1 |
| `Depends` | 5 | 5 | 52 | 0.04 | D R | fm | prerequisite slugs; in AAT 4, viv 1 |
| `Stage` | 5 | 5 | 5 | 0.00 | D R | fm | working-process state (current-state marker); in AAT 4, viv 1 |
| `(Title › Worked Example)`﹖ | 5 | 5 | 5 | 0.00 | U* O* | im | in AAT 4, viv 1 |
| `Epistemic Status` | 5 | 5 | 24 | 0.02 | D R | hd | what is derived vs assumed; tier and ceiling; in AAT 4, viv 1 |
| `System`﹖ | 4 | 4 | 49 | 0.04 | U O* | hd | recurring subsection; in AAT 3, TFT 1 |
| `Working Notes`﹖ | 4 | 4 | 25 | 0.02 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon); in AAT 3, viv 1 |
| `Formal Expression` | 1 | 1 | 14 | 0.01 | D R | hd | the claim itself, with equation-level tags; in viv 1 |
| `Discussion` | 1 | 1 | 4 | 0.00 | D R | hd | interpretation and connections; in viv 1 |
| *(63 minor slots)* |  |  | 1,250 | 0.96 | U O* |  | listed below |

*Minor and undeclared slots:* Mapping Quality Summary (3), (Slug) (2), Epistemic status (2), Purpose (2), Summary (2), Setup (2), Chain Instantiation (2), Chain Instantiation › Scope (2), … (+55 more)

### Resp Draft

**Total Files**: 7  
**Total Lines**: 356  
**Where**: ais-resp 7  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.02 | U* R* | if |  |
| `(Title)`﹖ | 4 | 4 | 4 | 0.01 | U* O* | im | the segment's name / one-line claim |
| *(15 minor slots)* |  |  | 339 | 0.95 | U O* |  | listed below |

*Minor and undeclared slots:* (Preamble) (3), Scratch (2), Assembly notes (1), The word is undefined where it is most used (1), Draft (1), Scratch › The one fact that organizes both uses (1), … (+9 more)

### Discussion/Intro

**Total Files**: 6  
**Total Lines**: 411  
**Where**: AAT 6  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 6 | 6 | 6 | 0.01 | D R | fm | identity (= filename) |
| `Type` | 6 | 6 | 6 | 0.01 | D R | fm | kind of claim |
| `Status` | 6 | 6 | 6 | 0.01 | D R | fm | epistemic strength |
| `Depends` | 6 | 6 | 22 | 0.05 | D R | fm | prerequisite slugs |
| `Stage` | 6 | 6 | 6 | 0.01 | D R | fm | working-process state (current-state marker) |
| `(Preamble)` | 6 | 6 | 77 | 0.19 | D* R | im | one-sentence statement of the claim, no heading |
| `(Title)` | 6 | 6 | 6 | 0.01 | D* R | im | title; ASF prefixes it with the type word |
| `(Title › Chapter Introduction)` | 6 | 6 | 6 | 0.01 | U* R* | im |  |
| `Working Notes`﹖ | 6 | 6 | 189 | 0.46 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon) |
| `Working Notes › Incidental audit gold` | 6 | 6 | 146 | 0.36 | U R* | hd | per-segment gold lifted from de-novo audit reflections (routing.sop §8) |

### Outline

**Total Files**: 5  
**Total Lines**: 532  
**Where**: vs-template 2, addr-2nd 1, aat-v3 1, vs-prior 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 5 | 5 | 5 | 0.01 | U* R* | if |  |
| `(Title)` | 5 | 5 | 5 | 0.01 | U* R* | im | the title |
| `(Preamble)`﹖ | 4 | 4 | 11 | 0.02 | U* O* | im | unheaded text between the title and the first section (summary line, status line); in vs-template 2, addr-2nd 1, aat-v3 1 |
| `Working Notes` | 5 | 5 | 43 | 0.08 | U R* | hd | the inbox: open items with leans, cautions, provenance; not canon |
| *(54 minor slots)* |  |  | 712 | 1.34 | U O* |  | listed below |

*Minor and undeclared slots:* Column semantics (2), Todo (1), Warning (1), [Definition] (1), Rowan/Archema harvest folded in (1), Source disposition (1), Survey follow-ups it flagged for itself (1), … (+47 more)

### Directive

**Total Files**: 3  
**Total Lines**: 193  
**Where**: ais-sop 2, vs-template 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 3 | 3 | 3 | 0.02 | U R* | fm | identity (= filename) |
| `Form` | 3 | 3 | 3 | 0.02 | U R* | fm | speech-act kind |
| `Status` | 3 | 3 | 3 | 0.02 | U R* | fm | strength / lifecycle state |
| `Max` | 3 | 3 | 3 | 0.02 | U R* | fm | ceiling of strength |
| `State` | 3 | 3 | 3 | 0.02 | U R* | fm | process-state flags |
| `Depends` | 3 | 3 | 3 | 0.02 | U R* | fm | prerequisites |
| `(Preamble)` | 3 | 3 | 35 | 0.18 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 3 | 3 | 3 | 0.02 | U* R* | im | the segment's name / one-line claim |
| `Segment discipline`﹖ | 2 | 2 | 2 | 0.01 | U O* | la |  |
| `Register discipline`﹖ | 2 | 2 | 2 | 0.01 | U O* | la |  |
| `File hygiene`﹖ | 2 | 2 | 2 | 0.01 | U O* | la |  |
| `Steward relationship`﹖ | 2 | 2 | 2 | 0.01 | U O* | la |  |
| `Commits`﹖ | 2 | 2 | 2 | 0.01 | U O* | la |  |
| *(11 minor slots)* |  |  | 153 | 0.79 | U O* |  | listed below |

*Minor and undeclared slots:* Orientation is three things, in order (1), Domain-related Hazards, named so nobody re-learns them (1), Where records land (1), Doctrina — know what the corpus already knows (1), … (+7 more)

### Empirical

**Total Files**: 2  
**Total Lines**: 191  
**Where**: AAT 1, TST 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 2 | 2 | 2 | 0.01 | D R | fm | identity (= filename) |
| `Type` | 2 | 2 | 2 | 0.01 | D R | fm | kind of claim |
| `Status` | 2 | 2 | 2 | 0.01 | D R | fm | epistemic strength |
| `Depends` | 2 | 2 | 7 | 0.04 | D R | fm | prerequisite slugs |
| `Stage` | 2 | 2 | 2 | 0.01 | D R | fm | working-process state (current-state marker) |
| `(Preamble)` | 2 | 2 | 5 | 0.03 | D* R | im | one-sentence statement of the claim, no heading |
| `(Title)` | 2 | 2 | 2 | 0.01 | D* R | im | title; ASF prefixes it with the type word |
| `Formal Expression` | 2 | 2 | 35 | 0.18 | D R | hd | the claim itself, with equation-level tags |
| `Epistemic Status` | 2 | 2 | 12 | 0.06 | D R | hd | what is derived vs assumed; tier and ceiling |
| `Discussion` | 2 | 2 | 60 | 0.31 | D R | hd | interpretation and connections |
| `Working Notes`﹖ | 2 | 2 | 51 | 0.27 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon) |
| `Domain validation`﹖ | 1 | 1 | 1 | 0.01 | U O* | la | in AAT 1 |
| `Open questions`﹖ | 1 | 1 | 1 | 0.01 | U O* | la | in AAT 1 |
| `Working Notes › Incidental audit gold`﹖ | 1 | 1 | 43 | 0.23 | U O* | hd | in AAT 1 |

### Procedures

**Total Files**: 1  
**Total Lines**: 169  
**Where**: TFT 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Epistemic status` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Purpose` | 1 | 1 | 4 | 0.02 | U R* | hd |  |
| `B.1 Measurement Targets` | 1 | 1 | 12 | 0.07 | U R* | hd |  |
| `B.2 Estimator Cookbook` | 1 | 1 | 72 | 0.43 | U R* | hd | holds 5 ### estimators in 1 file |
| `B.3 Recommended Estimation Sequence` | 1 | 1 | 10 | 0.06 | U R* | hd |  |
| `B.4 Minimal Reproducibility Checklist` | 1 | 1 | 14 | 0.08 | U R* | hd |  |
| `B.5 Estimator Uncertainty and Sample-Size Guidance` | 1 | 1 | 19 | 0.11 | U R* | hd |  |
| `B.6 Decision-Theoretic Procedures` | 1 | 1 | 35 | 0.21 | U R* | hd | holds 3 ### procedures in 1 file |

### Readme (Toc)

**Total Files**: 1  
**Total Lines**: 130  
**Where**: TFT 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 4 | 0.03 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Supporting material` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Operationalization` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Axiom` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Scope Definition` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Formulation` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Definition` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Derived` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Empirical Claim` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Hypothesis` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Discussion` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Table of Contents` | 1 | 1 | 24 | 0.18 | U R* | hd |  |
| `Reading Guide` | 1 | 1 | 8 | 0.06 | U R* | hd |  |
| `Epistemic Status Legend` | 1 | 1 | 11 | 0.08 | U R* | hd |  |
| `The Core Structure` | 1 | 1 | 17 | 0.13 | U R* | hd |  |
| `What's Probably Missing` | 1 | 1 | 12 | 0.09 | U R* | hd |  |
| `What's Potentially Missing` | 1 | 1 | 12 | 0.09 | U R* | hd |  |
| `Falsification Predictions` | 1 | 1 | 16 | 0.12 | U R* | hd |  |
| `Source Material` | 1 | 1 | 5 | 0.04 | U R* | hd |  |
| `TODO` | 1 | 1 | 12 | 0.09 | U R* | hd |  |
| `Planned Companion Documents` | 1 | 1 | 4 | 0.03 | U R* | hd |  |

### Axiom

**Total Files**: 1  
**Total Lines**: 154  
**Where**: TFT 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Level 1 — Associational` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Level 2 — Interventional` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Level 3 — Counterfactual` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `The Temporal Arrow` | 1 | 1 | 9 | 0.06 | U R* | hd |  |
| `Causality as Temporal Ordering` | 1 | 1 | 12 | 0.08 | U R* | hd |  |
| `The Three Levels of Epistemic Access` | 1 | 1 | 35 | 0.23 | U R* | hd |  |
| `Why This Is an Axiom` | 1 | 1 | 4 | 0.03 | U R* | hd |  |
| `The Recursive Update` | 1 | 1 | 53 | 0.34 | U R* | hd | holds 4 named ### parts in 1 file |
| `Consequences for the Feedback Loop` | 1 | 1 | 9 | 0.06 | U R* | hd |  |
| `Causal Structure Independent of Coupling Strength` | 1 | 1 | 14 | 0.09 | U R* | hd |  |
| `Implications for Model Updating` | 1 | 1 | 4 | 0.03 | U R* | hd |  |
| `Agent Identity and Temporal Continuity` | 1 | 1 | 11 | 0.07 | U R* | hd |  |

### Volume-introduction

**Total Files**: 1  
**Total Lines**: 73  
**Where**: AAT 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `Introduction` | 1 | 1 | 68 | 0.93 | U R* | hd | holds 5 named ### parts in 1 file |
| `Working Notes` | 1 | 1 | 6 | 0.08 | U R* | hd |  |

### Proposed-schema

**Total Files**: 1  
**Total Lines**: 227  
**Where**: AAT 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.00 | D R | fm | identity (= filename) |
| `Type` | 1 | 1 | 1 | 0.00 | D R | fm | kind of claim |
| `Status` | 1 | 1 | 1 | 0.00 | D R | fm | epistemic strength |
| `Depends` | 1 | 1 | 5 | 0.02 | D R | fm | prerequisite slugs |
| `Stage` | 1 | 1 | 1 | 0.00 | D R | fm | working-process state (current-state marker) |
| `(Preamble)` | 1 | 1 | 3 | 0.01 | D* R | im | one-sentence statement of the claim, no heading |
| `(Title)` | 1 | 1 | 1 | 0.00 | D* R | im | title; ASF prefixes it with the type word |
| `Editorial signal` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Formal Expression` | 1 | 1 | 54 | 0.24 | D R | hd | the claim itself, with equation-level tags; holds 1 named ### parts in 1 file |
| `Epistemic Status` | 1 | 1 | 16 | 0.07 | D R | hd | what is derived vs assumed; tier and ceiling |
| `Claim Record`﹖ | 1 | 1 | 44 | 0.19 | D O | hd | per-claim register, population, true/false-of, falsifier, instantiated; holds 3 ### claims in 1 file, each with fields Register, Population, True of, False of, Falsifier, Instantiated |
| `Discussion` | 1 | 1 | 24 | 0.11 | D R | hd | interpretation and connections |
| `Findings`﹖ | 1 | 1 | 23 | 0.10 | D O | hd | catalog entries surfaced into FINDINGS.md; holds 1 ### finding in 1 file, each with fields Brief, Impact, Novelty Claim, Related Work, Search Log |
| `Working Notes`﹖ | 1 | 1 | 47 | 0.21 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon) |
| `Working Notes › Incidental audit gold` | 1 | 1 | 37 | 0.16 | U R* | hd |  |

### Measurement

**Total Files**: 1  
**Total Lines**: 53  
**Where**: TST 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.02 | D R | fm | identity (= filename) |
| `Type` | 1 | 1 | 1 | 0.02 | D R | fm | kind of claim |
| `Status` | 1 | 1 | 1 | 0.02 | D R | fm | epistemic strength |
| `Depends` | 1 | 1 | 3 | 0.06 | D R | fm | prerequisite slugs |
| `Stage` | 1 | 1 | 1 | 0.02 | D R | fm | working-process state (current-state marker) |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | D* R | im | one-sentence statement of the claim, no heading |
| `(Title)` | 1 | 1 | 1 | 0.02 | D* R | im | title; ASF prefixes it with the type word |
| `Requirements` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Formal Expression` | 1 | 1 | 14 | 0.26 | D R | hd | the claim itself, with equation-level tags |
| `Epistemic Status` | 1 | 1 | 6 | 0.11 | D R | hd | what is derived vs assumed; tier and ceiling |
| `Discussion` | 1 | 1 | 14 | 0.26 | D R | hd | interpretation and connections |
| `Working Notes`﹖ | 1 | 1 | 6 | 0.11 | D O | hd | forward pointers, regression guards, dead-end warnings (not canon) |

### Orient

**Total Files**: 1  
**Total Lines**: 51  
**Where**: vs-template 1  
**Shape declared in**: ASF format.sop.md; copied into vivarium FORMAT.md and the verisectorium template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.02 | U R* | fm | identity |
| `Form` | 1 | 1 | 1 | 0.02 | U R* | fm | its kind |
| `Status` | 1 | 1 | 1 | 0.02 | U R* | fm | standing |
| `Max` | 1 | 1 | 1 | 0.02 | U R* | fm | the ceiling its status can reach |
| `State` | 1 | 1 | 1 | 0.02 | U R* | fm | process flags |
| `Depends` | 1 | 1 | 1 | 0.02 | U R* | fm | what it rests on |
| `(Preamble)` | 1 | 1 | 2 | 0.04 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the title |
| `Hazards, named so nobody re-learns them` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Where records land` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Doctrina — know what the corpus already knows` | 1 | 1 | 21 | 0.41 | U R* | hd |  |
| `Praxes — how work happens here` | 1 | 1 | 6 | 0.12 | U R* | hd |  |
| `Professio — declare yourself` | 1 | 1 | 4 | 0.08 | U R* | hd |  |
| `Feedback channel` | 1 | 1 | 6 | 0.12 | U R* | hd |  |
## Verisectorium model stores

### Form

**Total Files**: 63  
**Total Lines**: 2,481  
**Where**: very last ad-hoc verisectorium 63  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Def

**Total Files**: 29  
**Total Lines**: 1,124  
**Where**: first core 29  
**Shape declared in**: def/README.md; ## Definition(s) counted with ## Definition

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 29 | 29 | 29 | 0.03 | U* R* | if |  |
| `(Preamble)` | 29 | 29 | 29 | 0.03 | D* R | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 29 | 29 | 29 | 0.03 | D* R | im | title: the term, with its one-line definition directly under it |
| `status` | 29 | 29 | 29 | 0.03 | D R | ot | provisional or decided-by |
| `term` | 29 | 29 | 29 | 0.03 | D R | ot | term node: name, part of speech, plural |
| `Definition` | 29 | 29 | 216 | 0.19 | D R* | hd | the elaboration or senses of the term |
| `Definition › Invariants` | 29 | 29 | 132 | 0.12 | U R* | hd |  |
| `Working Notes` | 29 | 29 | 219 | 0.19 | D R | hd | the inbox: open items with leans, cautions, provenance; not canon |
| `Discussion`﹖ | 24 | 24 | 134 | 0.12 | D O* | hd | why it is cut this way; argument and context around the formal body |
| `Examples`﹖ | 24 | 24 | 133 | 0.12 | D O* | hd | concrete cases |
| `Intro`﹖ | 22 | 22 | 88 | 0.08 | D O | hd | how the term sits among its neighbours, for a cold reader |
| `term/rel`﹖ | 20 | 20 | 63 | 0.06 | D O | ot | typed relations to other terms, with cardinality |
| `term/avoid`﹖ | 19 | 19 | 35 | 0.03 | D O | ot | words not to use, with the past misuse |
| `term/synonyms`﹖ | 7 | 7 | 7 | 0.01 | D O | ot | acceptable other words |
| `term/subtypes`﹖ | 2 | 2 | 2 | 0.00 | D O | ot | named subtypes |
| *(2 minor slots)* |  |  | 2 | 0.00 | U O* |  | listed below |

*Minor and undeclared slots:* Ceiling of a missing target is sketch (1), Refusal kinds the spikes needed (1)

### Term-group

**Total Files**: 17  
**Total Lines**: 952  
**Where**: aat-v3 model defs 17  
**Shape declared in**: def/README.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `intro` | 17 | 17 | 156 | 0.16 | D R* | ot | paragraphs introducing every term in relation |
| `status` | 17 | 17 | 51 | 0.05 | D R* | ot | proposed |
| `term-group` | 17 | 17 | 88 | 0.09 | D R* | ot | the terms this file defines |
| `terms` | 17 | 17 | 958 | 1.01 | D R* | ot | one entry per term |
| `terms.*.def` | 17 | 17 | 17 | 0.02 | D R* | ot | one-line definition |
| `terms.*.invariants` | 17 | 17 | 17 | 0.02 | D R* | ot | what must always hold |
| `terms.*.pos` | 17 | 17 | 17 | 0.02 | D R* | ot | part of speech |
| `working-notes`﹖ | 16 | 16 | 69 | 0.07 | D O* | ot | open items; where content came from |
| `terms.*.pl`﹖ | 15 | 15 | 15 | 0.02 | D O* | ot | plural |
| `terms.*.rels`﹖ | 15 | 15 | 15 | 0.02 | D O* | ot | relations with cardinalities |
| `discussion`﹖ | 14 | 14 | 91 | 0.10 | D O* | ot | why it is cut this way |
| `terms.*.avoid`﹖ | 14 | 14 | 14 | 0.01 | D O* | ot | words not to use, with reasons |
| `terms.*.synonyms`﹖ | 14 | 14 | 14 | 0.01 | D O* | ot | acceptable other words |
| `examples`﹖ | 10 | 10 | 47 | 0.05 | D O* | ot | concrete cases |

### Obs

**Total Files**: 17  
**Total Lines**: 765  
**Where**: very last ad-hoc verisectorium 17  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Chapter

**Total Files**: 13  
**Total Lines**: 749  
**Where**: Segments model RC1 13  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 13 | 13 | 13 | 0.02 | U* R* | if |  |
| `(Preamble)` | 13 | 13 | 73 | 0.10 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 13 | 13 | 13 | 0.02 | U* R* | im | the title |
| `Working Notes`﹖ | 9 | 9 | 74 | 0.10 | U O* | hd | the inbox: open items with leans, cautions, provenance; not canon; holds 1 ### note in 1 file, each with fields The strain, verbatim in substance, Disposition |
| *(60 minor slots)* |  |  | 571 | 0.76 | U O* |  | listed below |

*Minor and undeclared slots:* The acceptance test for the whole model (1), Altitude 1 — why a record must carry its own honesty (1), Altitude 2 — what a record is (1), Altitude 3 — how records truthify (1), … (+56 more)

### Def

**Total Files**: 11  
**Total Lines**: 658  
**Where**: verisectorium core 11  
**Shape declared in**: core/templates/; ### Etymology and ### Adjudication sit under Historical Context in all 11; templates/def.md has neither

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 11 | 11 | 11 | 0.02 | U* R* | if |  |
| `(Preamble)` | 11 | 11 | 11 | 0.02 | D* R | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 11 | 11 | 11 | 0.02 | D* R | im | title: the term, with its one-line definition directly under it |
| `status` | 11 | 11 | 11 | 0.02 | D R | ot | provisional or decided-by |
| `term` | 11 | 11 | 11 | 0.02 | D R | ot | term node: name, part of speech, plural |
| `term/avoid`﹖ | 11 | 11 | 29 | 0.04 | D O | ot | words not to use, with the past misuse |
| `term/rel`﹖ | 11 | 11 | 38 | 0.06 | D O | ot | typed relations to other terms, with cardinality |
| `Definition` | 11 | 11 | 166 | 0.25 | D R | hd | the elaboration or senses of the term; holds 1 named ### parts in 1 file |
| `Definition › Invariants` | 11 | 11 | 81 | 0.12 | U R* | hd |  |
| `Discussion` | 11 | 11 | 65 | 0.10 | D R | hd | why it is cut this way; argument and context around the formal body |
| `Examples` | 11 | 11 | 63 | 0.10 | D R | hd | concrete cases |
| `Historical Context`﹖ | 11 | 11 | 92 | 0.14 | D O | hd | where it came from: evidence, older methods, breadcrumbs; holds 1 named ### parts in 1 file |
| `Historical Context › Etymology` | 11 | 11 | 33 | 0.05 | U R* | hd |  |
| `Historical Context › Adjudication` | 11 | 11 | 37 | 0.06 | U R* | hd |  |
| `Working Notes` | 11 | 11 | 98 | 0.15 | D R | hd | the inbox: open items with leans, cautions, provenance; not canon |
| `term/subtypes`﹖ | 6 | 6 | 6 | 0.01 | D O | ot | named subtypes |
| `term/synonyms`﹖ | 4 | 4 | 4 | 0.01 | D O | ot | acceptable other words |
| `Intro`﹖ | 3 | 3 | 9 | 0.01 | D O | hd | how the term sits among its neighbours, for a cold reader |
| *(3 minor slots)* |  |  | 3 | 0.00 | U O* |  | listed below |

*Minor and undeclared slots:* Finding out (1), Making so (1), The actor's own record (1)

### Survey

**Total Files**: 9  
**Total Lines**: 465  
**Where**: very last ad-hoc verisectorium 9  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Disc

**Total Files**: 7  
**Total Lines**: 227  
**Where**: verisectorium core 7  
**Shape declared in**: core/templates/; 5 of 7 are a title and prose only; none has The question this settles, The argument or Historical Context

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 7 | 7 | 7 | 0.03 | D R | fm | identity |
| `Form` | 7 | 7 | 7 | 0.03 | D R | fm | its kind |
| `Status` | 7 | 7 | 7 | 0.03 | D R | fm | standing |
| `Narrates` | 7 | 7 | 7 | 0.03 | D R | fm | the defs it leans on (lapse set) |
| `(Preamble)` | 7 | 7 | 52 | 0.23 | D* R | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 7 | 7 | 7 | 0.03 | D* R | im | the title |
| `Working Notes` | 2 | 2 | 8 | 0.04 | D R | hd | the inbox: open items with leans, cautions, provenance; not canon |
| `Open` | 1 | 1 | 7 | 0.03 | D R | hd | what the discussion leaves undecided |
| *(13 minor slots)* |  |  | 76 | 0.33 | U O* |  | listed below |

*Minor and undeclared slots:* Why the actor is in the model (1), A compaction is a new actor with a source (1), Orientation gets its purpose from the frontier (1), The actor's record, and standing (1), … (+9 more)

### Impl

**Total Files**: 5  
**Total Lines**: 272  
**Where**: verisectorium core 5  
**Shape declared in**: core/templates/; 2 of 5 number their sections (1., 2., ...) and word them differently; normalized here

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 5 | 5 | 5 | 0.02 | D R | fm | identity |
| `Form` | 5 | 5 | 5 | 0.02 | D R | fm | its kind |
| `Status` | 5 | 5 | 5 | 0.02 | D R | fm | standing |
| `Narrates` | 5 | 5 | 5 | 0.02 | D R | fm | the defs it leans on (lapse set) |
| `(Preamble)` | 5 | 5 | 10 | 0.04 | D* R | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 5 | 5 | 5 | 0.02 | D* R | im | the title |
| `What this says about the model` | 3 | 3 | 31 | 0.11 | D R | hd | where the model held, strained, or left things open |
| `Working Notes` | 3 | 3 | 13 | 0.05 | D R | hd | the inbox: open items with leans, cautions, provenance; not canon |
| `The material` | 2 | 2 | 17 | 0.06 | D R | hd | what was run through the model |
| `The run` | 2 | 2 | 27 | 0.10 | D R | hd | the record read through the model |
| `Historical Context` | 1 | 1 | 4 | 0.01 | D R | hd | where it came from: evidence, older methods, breadcrumbs |
| *(12 minor slots)* |  |  | 125 | 0.46 | U O* |  | listed below |

*Minor and undeclared slots:* Where it has to choose, and has not (1), What the frontier holds at HEAD, under the model (1), What vsect 0.1 shows instead (1), What strained (1), Cost (1), The segment, cut (1), … (+6 more)

### Norm

**Total Files**: 5  
**Total Lines**: 158  
**Where**: very last ad-hoc verisectorium 5  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Outline

**Total Files**: 1  
**Total Lines**: 18  
**Where**: aat-v3 model defs 1  
**Shape declared in**: def/README.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(list)` | 1 | 1 | 18 | 1.00 | U* R* | im | reading order of the groups |

### Outline

**Total Files**: 1  
**Total Lines**: 83  
**Where**: verisectorium core 1  
**Shape declared in**: core/templates/

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 8 | 0.10 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the title |
| `Legend` | 1 | 1 | 7 | 0.08 | U R* | ot | legend for the outline's columns |
| `Note` | 1 | 1 | 2 | 0.02 | U R* | ot | working note (stripped at build in papers) |
| `Part I` | 1 | 1 | 62 | 0.75 | U R* | hd |  |
| `Working Notes` | 1 | 1 | 7 | 0.08 | U R* | hd |  |
| `Historical Context` | 1 | 1 | 3 | 0.04 | U R* | hd |  |

### Outline

**Total Files**: 1  
**Total Lines**: 167  
**Where**: first core 1  
**Shape declared in**: def/README.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 16 | 0.10 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the title |
| `Legend` | 1 | 1 | 13 | 0.08 | U R* | ot | legend for the outline's columns |
| `Note` | 1 | 1 | 6 | 0.04 | U R* | ot | working note (stripped at build in papers) |
| `TODO` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Part I` | 1 | 1 | 56 | 0.34 | U R* | hd |  |
| `Part II` | 1 | 1 | 60 | 0.36 | U R* | hd | holds 3 named ### parts in 1 file |
| `Part III. Patterns` | 1 | 1 | 13 | 0.08 | U R* | hd |  |
| `Part IV. Instances` | 1 | 1 | 4 | 0.02 | U R* | hd |  |
| `Part V. Questions and Prompts` | 1 | 1 | 14 | 0.08 | U R* | hd |  |

### Readme

**Total Files**: 1  
**Total Lines**: 13  
**Where**: verisectorium core 1  
**Shape declared in**: core/templates/

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.08 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 6 | 0.46 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.08 | U* R* | im | the title |

### Intro

**Total Files**: 1  
**Total Lines**: 20  
**Where**: verisectorium core 1  
**Shape declared in**: core/templates/; one prose body; no Working Notes, which the template requires

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.05 | D R | fm | identity |
| `Form` | 1 | 1 | 1 | 0.05 | D R | fm | its kind |
| `Status` | 1 | 1 | 1 | 0.05 | D R | fm | standing |
| `Narrates` | 1 | 1 | 1 | 0.05 | D R | fm | the defs it leans on (lapse set) |
| `(Preamble)` | 1 | 1 | 8 | 0.40 | D* R | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.05 | D* R | im | the title |

### Outline

**Total Files**: 1  
**Total Lines**: 9  
**Where**: verisectorium praxes 1  
**Shape declared in**: core/templates/praxis.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.11 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 6 | 0.67 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.11 | U* R* | im | the title |

### Praxis

**Total Files**: 1  
**Total Lines**: 41  
**Where**: verisectorium praxes 1  
**Shape declared in**: core/templates/praxis.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.02 | D R | fm | identity |
| `Form` | 1 | 1 | 1 | 0.02 | D R | fm | its kind |
| `Status` | 1 | 1 | 1 | 0.02 | D R | fm | standing |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | D* R | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.02 | D* R | im | the title |
| `The procedure` | 1 | 1 | 16 | 0.39 | D R | hd | the steps, in order |
| `Why these steps` | 1 | 1 | 8 | 0.20 | D R | hd | the reasons, so a mind can tell when a step does not apply |
| `Historical Context` | 1 | 1 | 4 | 0.10 | D R | hd | where it came from: evidence, older methods, breadcrumbs |
| `Working Notes` | 1 | 1 | 4 | 0.10 | D R | hd | the inbox: open items with leans, cautions, provenance; not canon |

### Readme

**Total Files**: 1  
**Total Lines**: 11  
**Where**: first core 1  
**Shape declared in**: def/README.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.09 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 5 | 0.45 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.09 | U* R* | im | the title |

### Outline

**Total Files**: 1  
**Total Lines**: 231  
**Where**: very last ad-hoc verisectorium 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Def

**Total Files**: 1  
**Total Lines**: 43  
**Where**: very last ad-hoc verisectorium 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Disc

**Total Files**: 1  
**Total Lines**: 32  
**Where**: very last ad-hoc verisectorium 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Emp

**Total Files**: 1  
**Total Lines**: 59  
**Where**: very last ad-hoc verisectorium 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Outline

**Total Files**: 1  
**Total Lines**: 55  
**Where**: Segments model RC1 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.04 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the title |
| `Purpose` | 1 | 1 | 6 | 0.11 | U R* | hd |  |
| `The model in one paragraph` | 1 | 1 | 6 | 0.11 | U R* | hd |  |
| `Contents, in reading order` | 1 | 1 | 24 | 0.44 | U R* | hd |  |
| `Deliberately excluded` | 1 | 1 | 8 | 0.15 | U R* | hd |  |
| `Working Notes` | 1 | 1 | 6 | 0.11 | U R* | hd |  |
## Term and definition stores

### Claim (in Relation)

**Total Files**: 943  
**Total Lines**: 13,170  
**Where**: ai-risk-model model-beta 943  
**Shape declared in**: model-beta/SCHEMA.md (claims)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Author` | 943 | 943 | 1,886 | 0.14 | D R* | la | who wrote it |
| `Channel` | 943 | 943 | 1,502 | 0.11 | D R* | la | how it reached us |
| `Evidence` | 943 | 943 | 1,886 | 0.14 | D R* | la | what backs it |
| `Quote`﹖ | 920 | 920 | 2,554 | 0.19 | D O* | la | verbatim text |
| `Doc`﹖ | 870 | 870 | 1,740 | 0.13 | D O* | la | relata key |
| `Qualifier`﹖ | 858 | 858 | 1,667 | 0.13 | D O* | la | source's own hedge |
| `Loc`﹖ | 802 | 802 | 1,595 | 0.12 | D O* | la | location |
| `Bears_on`﹖ | 93 | 93 | 186 | 0.01 | D O | la | what the evidence is about |
| *(2 ad hoc headings)* |  |  | 154 | 0.01 | U O* |  | listed below |

*Minor and undeclared slots:* force, checked_by

### Relation

**Total Files**: 573  
**Total Lines**: 13,210  
**Where**: ai-risk-model model-beta 573  
**Shape declared in**: model-beta/SCHEMA.md (relations)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 573 | 573 | 1,146 | 0.09 | D R | la | identity |
| `From` | 573 | 573 | 1,146 | 0.09 | D R* | la | source end |
| `Type` | 573 | 573 | 1,146 | 0.09 | D R | la | kind |
| `Claims` | 573 | 573 | 7,319 | 0.55 | D R | la | claims carrying it |
| `Sign`﹖ | 564 | 564 | 955 | 0.07 | D O | la | + / - / ? |
| `To`﹖ | 550 | 550 | 1,100 | 0.08 | D O* | la | target end |
| `Targets`﹖ | 23 | 23 | 34 | 0.00 | D O | la | relations moderated |
| `Delay`﹖ | 8 | 8 | 15 | 0.00 | D O | la | delay |
| *(1 minor slots)* |  |  | 349 | 0.03 | U O* |  | listed below |

*Minor and undeclared slots:* Note (140)

### Mapping

**Total Files**: 450  
**Total Lines**: 6,082  
**Where**: ai-risk-model model-beta 450  
**Shape declared in**: model-beta/SCHEMA.md (mappings)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Concept` | 450 | 450 | 900 | 0.15 | U R* | la | our concept |
| `Rel` | 450 | 450 | 900 | 0.15 | D R* | la | SKOS-style match |
| `Src` | 450 | 450 | 900 | 0.15 | D R* | la | note file |
| `Term` | 450 | 450 | 891 | 0.15 | D R* | la | source term |
| `Channel` | 450 | 450 | 611 | 0.10 | D R* | la | how it reached us |
| `Loc`﹖ | 413 | 413 | 819 | 0.13 | D O* | la | location |
| `Quote`﹖ | 238 | 238 | 614 | 0.10 | D O* | la | verbatim text |
| `Note`﹖ | 219 | 219 | 447 | 0.07 | D O* | la | note (emitted) |

### Concept

**Total Files**: 287  
**Total Lines**: 3,778  
**Where**: ai-risk-model model-beta 287  
**Shape declared in**: model-beta/SCHEMA.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 287 | 287 | 574 | 0.15 | D R | la | identity |
| `Kind` | 287 | 287 | 574 | 0.15 | D R* | la | sub-kind |
| `Label` | 287 | 287 | 586 | 0.16 | D R | la | short label |
| `Broader`﹖ | 272 | 272 | 320 | 0.08 | D O* | la | taxonomy parent |
| `Proposed_by`﹖ | 272 | 272 | 552 | 0.15 | D O* | la | who introduced it |
| `Definition`﹖ | 219 | 219 | 541 | 0.14 | D O* | la | working sense |
| `Notes`﹖ | 113 | 113 | 359 | 0.10 | D O* | la | notes |
| `Distinct_from`﹖ | 93 | 93 | 152 | 0.04 | D O* | la | look-alikes that differ |
| `Ais_term`﹖ | 30 | 30 | 61 | 0.02 | D O* | la | ais's own term |
| `Scale`﹖ | 13 | 13 | 27 | 0.01 | D O* | la | severity / scope |
| `Sd_kind`﹖ | 8 | 8 | 16 | 0.00 | D O* | la | system-dynamics role |
| `Units`﹖ | 6 | 6 | 12 | 0.00 | D O* | la | units |
| *(2 ad hoc headings)* |  |  | 4 | 0.00 | U O* |  | listed below |

*Minor and undeclared slots:* safeguards and governance practices, by degree

### Term-entry

**Total Files**: 177  
**Total Lines**: 4,327  
**Where**: ASF terminology 177  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 177 | 177 | 177 | 0.04 | D R* | fm | identity (= filename) |
| `Schema version` | 177 | 177 | 177 | 0.04 | D R* | fm | schema version |
| `Term` | 177 | 177 | 177 | 0.04 | D R* | fm | canonical lowercase prose form |
| `Name` | 177 | 177 | 177 | 0.04 | D R* | fm | display form |
| `Brief` | 177 | 177 | 179 | 0.04 | D R* | fm | one-line gloss rendered into LEXICON.md |
| `Layer` | 177 | 177 | 177 | 0.04 | D R* | fm | slug / prose-symbol / framing-vocabulary / public-api |
| `Status` | 177 | 177 | 177 | 0.04 | D R* | fm | working … canon … superseded |
| `Tags` | 177 | 177 | 183 | 0.04 | D R* | fm | section tags for render |
| `Source type` | 177 | 177 | 177 | 0.04 | D R* | fm | asf / external / standard / … |
| `Primary source` | 177 | 177 | 177 | 0.04 | D R* | fm | defining segment |
| `First asf mention` | 177 | 177 | 177 | 0.04 | D R* | fm | first use |
| `See also` | 177 | 177 | 194 | 0.04 | D R* | fm | related entries |
| `Aliases` | 177 | 177 | 186 | 0.04 | D R* | fm | acceptable variants |
| `Do not confuse` | 177 | 177 | 202 | 0.05 | D R* | fm | external collisions |
| `Notation`﹖ | 57 | 57 | 57 | 0.01 | D O* | fm | LaTeX form (meant to drive NOTATION.md) |
| `Internal note`﹖ | 7 | 7 | 7 | 0.00 | D O* | fm | agent-side, never rendered |
| *(38 minor slots)* |  |  | 149 | 0.03 | U O* |  | listed below |

*Minor and undeclared slots:* Seq (59), Subgroup (54), What is included (1), From opinion to measurement (1), Organizational reflection (1), (C-i) Shared composite objective (1), … (+32 more)

### Term (udon)

**Total Files**: 106  
**Total Lines**: —  
**Where**: vivarium lexicon 106  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:status` | 106 | 106 | 106 | 106.00 | D R* | ot | settled / carved / open |
| `Rel`﹖ | 48 | 48 | 100 | 100.00 | D O | ot | relation edge :to <term> :kind <verb> |
| `Source`﹖ | 28 | 28 | 58 | 58.00 | D O | ot | design doc carrying the full machinery |
| `Not`﹖ | 26 | 26 | 30 | 30.00 | D O | ot | what it is not / not to call it |
| `:name`﹖ | 20 | 20 | 20 | 20.00 | D O* | ot | display name / headword |
| `Confused`﹖ | 14 | 14 | 18 | 18.00 | D O | ot | easily confused with, and how to tell apart |
| `Context`﹖ | 7 | 7 | 14 | 14.00 | D O | ot | binding scope beyond vivarium; register |
| *(3 minor slots)* |  |  | 166 | 166.00 | U O* |  | listed below |

*Minor and undeclared slots:* :since (33), :forms (10), :anchor (5)

### Term

**Total Files**: 74  
**Total Lines**: 225  
**Where**: ai-risk-model model-beta 74  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Invariants`﹖ | 50 | 50 | 127 | 0.56 | U O* | ot | what holds of every instance |
| `Rels`﹖ | 40 | 40 | 63 | 0.28 | U O* | ot | typed relations to other terms |
| *(2 minor slots)* |  |  | 35 | 0.16 | U O* |  | listed below |

*Minor and undeclared slots:* :avoid (27), :synonyms (7)

### Term

**Total Files**: 20  
**Total Lines**: 215  
**Where**: ai-risk-model lexicon 20  
**Shape declared in**: def/README.md §What an entry's blocks mean

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:source` | 20 | 20 | 20 | 0.09 | D R* | fm | where the definition comes from and how modified |
| `:avoid`﹖ | 5 | 5 | 5 | 0.02 | D O* | fm | words to avoid |
| `:synonyms`﹖ | 1 | 1 | 1 | 0.00 | D O* | fm | synonyms |
| `Invariants` | 20 | 20 | 82 | 0.38 | D R* | ot | what holds of every instance |
| `Rels`﹖ | 12 | 12 | 19 | 0.09 | D O* | ot | typed relations to other terms |
| `Conditions`﹖ | 9 | 9 | 20 | 0.09 | D O* | ot | when the source says it arises |
| `Practices`﹖ | 9 | 9 | 28 | 0.13 | D O* | ot | the source's advice about it |
| `Collisions`﹖ | 7 | 7 | 30 | 0.14 | D O* | ot | other senses of the same words |
| `Ambiguity`﹖ | 1 | 1 | 3 | 0.01 | D O* | ot | declared ambiguity left unresolved |
| `Proposed-widening`﹖ | 1 | 1 | 3 | 0.01 | D O* | ot | scope widening proposed, not adopted |
| *(1 ad hoc headings)* |  |  | 4 | 0.02 | U O* |  | listed below |

*Minor and undeclared slots:* |examples

### Term-group

**Total Files**: 14  
**Total Lines**: 827  
**Where**: ai-risk-model model-beta 14  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:status` | 14 | 14 | 56 | 0.07 | U R* | fm | strength / state |
| `Term` | 14 | 14 | 301 | 0.36 | U R* | ot | term element |
| `Discussion` | 14 | 14 | 81 | 0.10 | U R* | ot | interpretation |
| `Working-notes` | 14 | 14 | 64 | 0.08 | U R* | ot | open items |
| `Examples`﹖ | 12 | 12 | 109 | 0.13 | U O* | ot | worked examples |
| `Lexical-map`﹖ | 12 | 12 | 216 | 0.26 | U O* | ot | source terms mapped to this term |

### Section (udon)

**Total Files**: 9  
**Total Lines**: —  
**Where**: vivarium lexicon 9  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:num` | 9 | 9 | 9 | 9.00 | U R* | ot | frozen section number |
| `:name` | 9 | 9 | 9 | 9.00 | D R* | ot | display name / headword |
| `Term` | 9 | 9 | 515 | 515.00 | U R* | ot |  |
| *(2 minor slots)* |  |  | 95 | 95.00 | U O* |  | listed below |

*Minor and undeclared slots:* Note (4), :seeded (1)

### Note (udon)

**Total Files**: 8  
**Total Lines**: —  
**Where**: vivarium lexicon 8  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:name` | 8 | 8 | 8 | 8.00 | D R* | ot | display name / headword |
| *(2 minor slots)* |  |  | 40 | 40.00 | U O* |  | listed below |

*Minor and undeclared slots:* :anchor (1), Term (1)

### Term-group

**Total Files**: 7  
**Total Lines**: 315  
**Where**: Address Theory 7  
**Shape declared in**: sop/src/disc-orient.md; order and slots from disc-orient: header, :status, leading paragraph, /term each, then /discussion /examples /working-notes

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Term-group` | 7 | 7 | 315 | 1.00 | D R | ot | group header naming every term the file defines, plus the leading paragraph |
| `Term` | 7 | 7 | 179 | 0.57 | D R | ot | one term: one-line definition, inflections, synonyms/avoid |
| `Invariants`﹖ | 7 | 7 | 57 | 0.18 | D O | ot | what must always hold |
| `Discussion` | 7 | 7 | 32 | 0.10 | D R* | ot | why the group is cut this way |
| `Examples` | 7 | 7 | 45 | 0.14 | D R* | ot | concrete cases |
| `Working-notes` | 7 | 7 | 23 | 0.07 | D R* | ot | open items with leans; provenance |
| `Rels`﹖ | 6 | 6 | 22 | 0.07 | D O | ot | typed relations with cardinalities |

### Term-group

**Total Files**: 6  
**Total Lines**: 361  
**Where**: ai-risk-model lexicon 6  
**Shape declared in**: def/README.md (address-theory blocks)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:status` | 6 | 6 | 6 | 0.02 | D R* | fm | strength / state |
| `:source` | 6 | 6 | 24 | 0.07 | D R* | fm | where the definition comes from and how modified |
| `Term` | 6 | 6 | 235 | 0.65 | D R* | ot | term element |
| `Discussion` | 6 | 6 | 41 | 0.11 | D R* | ot | interpretation |
| `Working-notes` | 6 | 6 | 25 | 0.07 | D R* | ot | open items |
| `Examples`﹖ | 4 | 4 | 30 | 0.08 | D O* | ot | worked examples |

### Outline

**Total Files**: 1  
**Total Lines**: 33  
**Where**: Address Theory 1  
**Shape declared in**: sop/src/disc-orient.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.06 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im | the title |
| `Third-edition reset` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Foundation cut` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Def/-primacy decision` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Part I — Vocabulary Foundation` | 1 | 1 | 16 | 0.48 | U R* | hd |  |
| `Part II — Theory` | 1 | 1 | 6 | 0.18 | U R* | hd |  |
| `Working Notes` | 1 | 1 | 6 | 0.18 | U R* | hd |  |
## Specifications, rules and decisions

### Decision

**Total Files**: 129  
**Total Lines**: 5,473  
**Where**: live_docs 129  
**Shape declared in**: live_docs AGENTS.md schema rules + skills/_shared/doc-types.md, doc-style.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 129 | 129 | 129 | 0.02 | D R | fm | identity |
| `Title` | 129 | 129 | 129 | 0.02 | D R | fm | name |
| `Label` | 129 | 129 | 129 | 0.02 | D R | fm | short label |
| `Summary` | 129 | 129 | 129 | 0.02 | D R* | fm | 1-3 sentence gist |
| `Type` | 129 | 129 | 129 | 0.02 | D R | fm | kind |
| `Status` | 129 | 129 | 129 | 0.02 | D R | fm | strength / lifecycle state |
| `Force` | 129 | 129 | 129 | 0.02 | D R | fm | must / should / may |
| `Realization` | 129 | 129 | 129 | 0.02 | D R | fm | built or not |
| `Belongs to`﹖ | 127 | 127 | 127 | 0.02 | D O | fm | hierarchy edge |
| `History`﹖ | 127 | 127 | 254 | 0.05 | D O | fm | change trail |
| `History.summary`﹖ | 127 | 127 | 127 | 0.02 | U O* | fm |  |
| `Provenance`﹖ | 111 | 111 | 111 | 0.02 | D O | fm | derived-from edge |
| `Requires`﹖ | 103 | 103 | 103 | 0.02 | D O | fm | dependency edge |
| `Domain`﹖ | 99 | 99 | 99 | 0.02 | D O | fm | business grouping |
| `History.session`﹖ | 86 | 86 | 88 | 0.02 | U O* | fm |  |
| `History.change type`﹖ | 85 | 85 | 86 | 0.02 | U O* | fm |  |
| `Relates`﹖ | 79 | 79 | 79 | 0.01 | D O | fm | see-also edge |
| `Created` | 44 | 44 | 44 | 0.01 | D R | fm | creation time |
| `Intent` | 20 | 20 | 20 | 0.00 | D R | fm | requested / chosen / incidental |
| `Superseded by`﹖ | 8 | 8 | 8 | 0.00 | D O | fm | replacement |
| `Scope`﹖ | 6 | 6 | 6 | 0.00 | D O | fm | scope facet |
| `Decision`﹖ | 128 | 128 | 1,151 | 0.21 | U O* | hd | the decision itself; holds 3 ### items in 2 files; 14 named ### parts in 5 files |
| `Correction`﹖ | 8 | 8 | 36 | 0.01 | D O | hd | deprecation / correction record |
| *(53 minor slots)* |  |  | 971 | 0.18 | U O* |  | listed below |

*Minor and undeclared slots:* Context (50), Consequences (46), Rationale (31), Why (29), Intent basis (7), Consequence (2), Governance (1), Garden-summarize is a variation of cascade-checking (1), … (+45 more)

### Rule

**Total Files**: 81  
**Total Lines**: 4,868  
**Where**: UDON Lite spec 81  
**Shape declared in**: sop/src/conv-record-cadence.md (convention, "proposed, or even exploratory")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 81 | 81 | 81 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 81 | 81 | 81 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 81 | 81 | 81 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 81 | 81 | 81 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Layer` | 81 | 81 | 81 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Per` | 81 | 81 | 81 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Depends` | 81 | 81 | 81 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Consequences` | 81 | 81 | 81 | 0.02 | U R* | fm |  |
| `(Slug)` | 81 | 81 | 81 | 0.02 | U* R* | if |  |
| `(Preamble)` | 81 | 81 | 81 | 0.02 | U* R* | im |  |
| `(Title)` | 81 | 81 | 81 | 0.02 | U* R* | im |  |
| `Statement` | 81 | 81 | 664 | 0.14 | D R | hd | the normative clause(s) themselves |
| `Grounds` | 81 | 81 | 356 | 0.07 | D R | hd | what the card rests on (decisions, objectives, or forced-by) |
| `Epistemic status` | 81 | 81 | 326 | 0.07 | D R | hd | what is checked, what is chosen |
| `Working notes`﹖ | 81 | 81 | 982 | 0.20 | D O | hd | open threads, leans, things to check; drained before freeze |
| `Explanation`﹖ | 48 | 48 | 668 | 0.14 | D O | hd | teaching example, adds nothing to the Statement |
| `Discussion`﹖ | 24 | 24 | 703 | 0.14 | D O | hd | reasoning, context, carried decision text |
| `Cautions`﹖ | 1 | 1 | 4 | 0.00 | D O | hd | known hazards of reading or using the record |
| *(21 minor slots)* |  |  | 79 | 0.02 | U O* |  | listed below |

*Minor and undeclared slots:* Test-fixtures (30), Reasoning (18), Joseph's words (12), Open (2), Title prefix: (1), Open, raised with Joseph's own example 2026-10-21 (1), Joseph's rewording, 2026-10-20 (1), … (+14 more)

### Reference

**Total Files**: 43  
**Total Lines**: 994  
**Where**: live_docs 43  
**Shape declared in**: live_docs AGENTS.md schema rules + skills/_shared/doc-types.md, doc-style.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 43 | 43 | 43 | 0.04 | D R | fm | identity |
| `Title` | 43 | 43 | 43 | 0.04 | D R | fm | name |
| `Label` | 43 | 43 | 43 | 0.04 | D R | fm | short label |
| `Type` | 43 | 43 | 43 | 0.04 | D R | fm | kind |
| `Status` | 43 | 43 | 43 | 0.04 | D R | fm | strength / lifecycle state |
| `Kind` | 43 | 43 | 43 | 0.04 | D R* | fm | sub-kind |
| `Source` | 43 | 43 | 43 | 0.04 | D R* | fm | where it came from |
| `Imported` | 43 | 43 | 43 | 0.04 | D R* | fm | import date |
| `Created` | 27 | 27 | 27 | 0.03 | D R | fm | creation time |
| `History`﹖ | 25 | 25 | 50 | 0.05 | D O | fm | change trail |
| `History.summary`﹖ | 25 | 25 | 25 | 0.03 | U O* | fm |  |
| `Summary`﹖ | 22 | 22 | 22 | 0.02 | D O* | fm | 1-3 sentence gist |
| `Belongs to`﹖ | 16 | 16 | 16 | 0.02 | D O | fm | hierarchy edge |
| `Domain`﹖ | 11 | 11 | 11 | 0.01 | D O | fm | business grouping |
| `Provenance`﹖ | 2 | 2 | 2 | 0.00 | D O | fm | derived-from edge |
| *(56 minor slots)* |  |  | 334 | 0.34 | U O* |  | listed below |

*Minor and undeclared slots:* History.change type (7), History.session (7), Intent (5), Overview (4), Restatement (3), Summary (2), Context / Origin (1), Core Feature Areas Proposed (1), … (+48 more)

### Definition

**Total Files**: 40  
**Total Lines**: 3,838  
**Where**: UDON Lite spec 40  
**Shape declared in**: sop/src/conv-record-cadence.md (convention, "proposed, or even exploratory"); Invariants is missing in 14 cards, all from the outline's "Vocabulary

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 40 | 40 | 40 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 40 | 40 | 40 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 40 | 40 | 40 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 40 | 40 | 40 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Strength` | 40 | 40 | 40 | 0.01 | U R* | fm |  |
| `Terms` | 40 | 40 | 40 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Per` | 40 | 40 | 40 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Depends` | 40 | 40 | 40 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Consequences` | 40 | 40 | 40 | 0.01 | U R* | fm |  |
| `(Slug)` | 40 | 40 | 40 | 0.01 | U* R* | if |  |
| `(Preamble)` | 40 | 40 | 42 | 0.01 | U* R* | im |  |
| `(Title)` | 40 | 40 | 40 | 0.01 | U* R* | im |  |
| `Terms` | 40 | 40 | 402 | 0.10 | D R | hd | the defined terms and their definitions |
| `Working notes`﹖ | 40 | 40 | 2,013 | 0.52 | D O | hd | open threads, leans, things to check; drained before freeze; holds 30 ### notes in 17 files, each with fields My lean, Precedents for the umbrella, A collision to weigh, HTML's "parse error" is the… |
| `Working notes › Coordinator's lean`﹖ | 38 | 38 | 193 | 0.05 | U O* | hd |  |
| `Invariants` | 26 | 26 | 135 | 0.04 | D R | hd | what always holds of the defined thing |
| `Examples`﹖ | 24 | 24 | 269 | 0.07 | D O | hd | worked spellings |
| `Avoid`﹖ | 21 | 21 | 323 | 0.08 | U O* | hd | rejected words, with who used them when |
| `Discussion`﹖ | 4 | 4 | 67 | 0.02 | D O | hd | reasoning, context, carried decision text |
| *(306 minor slots)* |  |  | 1,027 | 0.27 | U O* |  | listed below |

*Minor and undeclared slots:* Precedents (7), Joseph's words (6), Readings of his usage (5), Register (4), Questions of meaning and affordance (4), Candidates (4), My lean (3), CommonMark (3), DOM (3), "kind" (3), XML (3), Ruby (3), XML Infoset (3), … (+293 more)

### Lexicon Term

**Total Files**: 36  
**Total Lines**: 237  
**Where**: live_docs 36  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Term` | 36 | 36 | 36 | 0.15 | U R* | fm | source term |
| `Definition` | 36 | 36 | 36 | 0.15 | U R* | fm | working sense |
| `(Slug)` | 36 | 36 | 36 | 0.15 | U* R* | if |  |
| `Similar terms`﹖ | 28 | 28 | 28 | 0.12 | U O* | fm | near terms |
| *(3 minor slots)* |  |  | 29 | 0.12 | U O* |  | listed below |

*Minor and undeclared slots:* Allowed aliases (15), Restricted aliases (13), Context (1)

### Principle

**Total Files**: 33  
**Total Lines**: 1,158  
**Where**: live_docs 33  
**Shape declared in**: live_docs AGENTS.md schema rules + skills/_shared/doc-types.md, doc-style.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 33 | 33 | 33 | 0.03 | D R | fm | identity |
| `Title` | 33 | 33 | 33 | 0.03 | D R | fm | name |
| `Label` | 33 | 33 | 33 | 0.03 | D R | fm | short label |
| `Summary` | 33 | 33 | 33 | 0.03 | D R* | fm | 1-3 sentence gist |
| `Type` | 33 | 33 | 33 | 0.03 | D R | fm | kind |
| `Status` | 33 | 33 | 33 | 0.03 | D R | fm | strength / lifecycle state |
| `Force` | 33 | 33 | 33 | 0.03 | D R | fm | must / should / may |
| `Belongs to`﹖ | 33 | 33 | 33 | 0.03 | D O | fm | hierarchy edge |
| `History`﹖ | 33 | 33 | 66 | 0.06 | D O | fm | change trail |
| `History.summary` | 33 | 33 | 33 | 0.03 | U R* | fm |  |
| `Provenance`﹖ | 32 | 32 | 32 | 0.03 | D O | fm | derived-from edge |
| `History.change type`﹖ | 24 | 24 | 25 | 0.02 | U O* | fm |  |
| `Domain`﹖ | 23 | 23 | 23 | 0.02 | D O | fm | business grouping |
| `Relates`﹖ | 23 | 23 | 23 | 0.02 | D O | fm | see-also edge |
| `History.session`﹖ | 22 | 22 | 22 | 0.02 | U O* | fm |  |
| `Requires`﹖ | 11 | 11 | 11 | 0.01 | D O | fm | dependency edge |
| `Created` | 9 | 9 | 9 | 0.01 | D R | fm | creation time |
| `Scope`﹖ | 1 | 1 | 1 | 0.00 | D O | fm | scope facet |
| `Intent` | 1 | 1 | 1 | 0.00 | D R | fm | requested / chosen / incidental |
| `Statement`﹖ | 29 | 29 | 144 | 0.12 | U O* | hd | the principle stated |
| `Rationale`﹖ | 19 | 19 | 112 | 0.10 | U O* | hd | the why |
| *(28 minor slots)* |  |  | 163 | 0.14 | U O* |  | listed below |

*Minor and undeclared slots:* Why (6), Principle (4), The store is not an archive (1), Method (1), Corollary (1), Scope (1), Application (1), Relationship (1), Caveats that shaped the decision (1), … (+19 more)

### Component

**Total Files**: 30  
**Total Lines**: 1,519  
**Where**: live_docs 30  
**Shape declared in**: live_docs AGENTS.md schema rules + skills/_shared/doc-types.md, doc-style.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 30 | 30 | 30 | 0.02 | D R | fm | identity |
| `Title` | 30 | 30 | 30 | 0.02 | D R | fm | name |
| `Label` | 30 | 30 | 30 | 0.02 | D R | fm | short label |
| `Summary` | 30 | 30 | 30 | 0.02 | D R* | fm | 1-3 sentence gist |
| `Type` | 30 | 30 | 30 | 0.02 | D R | fm | kind |
| `Status` | 30 | 30 | 30 | 0.02 | D R | fm | strength / lifecycle state |
| `Realization` | 30 | 30 | 30 | 0.02 | D R | fm | built or not |
| `History`﹖ | 30 | 30 | 60 | 0.04 | D O | fm | change trail |
| `History.summary` | 30 | 30 | 30 | 0.02 | U R* | fm |  |
| `Belongs to`﹖ | 29 | 29 | 29 | 0.02 | D O | fm | hierarchy edge |
| `History.change type`﹖ | 24 | 24 | 24 | 0.02 | U O* | fm |  |
| `History.session`﹖ | 24 | 24 | 24 | 0.02 | U O* | fm |  |
| `Domain`﹖ | 23 | 23 | 23 | 0.02 | D O | fm | business grouping |
| `Relates`﹖ | 17 | 17 | 17 | 0.01 | D O | fm | see-also edge |
| `Provenance`﹖ | 16 | 16 | 16 | 0.01 | D O | fm | derived-from edge |
| `Requires`﹖ | 15 | 15 | 15 | 0.01 | D O | fm | dependency edge |
| `Intent` | 14 | 14 | 14 | 0.01 | D R | fm | requested / chosen / incidental |
| `Scope`﹖ | 12 | 12 | 12 | 0.01 | D O | fm | scope facet |
| `Created` | 6 | 6 | 6 | 0.00 | D R | fm | creation time |
| *(67 minor slots)* |  |  | 566 | 0.37 | U O* |  | listed below |

*Minor and undeclared slots:* Component (6), What this component covers (4), What this is (2), Auto viewer rebuild (1), Capability description (1), Capability description › Reference/archived demotion (1), … (+61 more)

### Question (71–91)

**Total Files**: 21  
**Total Lines**: 1,823  
**Where**: UDON Lite pre-design questions 21  
**Shape declared in**: .int/pre-design/README.md (prose: "the question, the alternatives, UDON examples and the tree each alternative produces, and interactions")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 21 | 21 | 21 | 0.01 | U* R* | if |  |
| `(Title)` | 21 | 21 | 21 | 0.01 | U* R* | im |  |
| `The question` | 21 | 21 | 319 | 0.17 | D R* | hd | the question, neutrally |
| `Interactions` | 21 | 21 | 142 | 0.08 | D R* | hd | other questions this couples to |
| `Why lite must decide`﹖ | 20 | 20 | 80 | 0.04 | U O* | hd | why the question cannot be deferred |
| `Alternatives`﹖ | 17 | 17 | 670 | 0.37 | D O* | hd | the options, each with UDON and tree; holds 65 ### alternatives in 17 files |
| `What the texts say, in date order`﹖ | 11 | 11 | 193 | 0.11 | U O* | hd |  |
| *(61 minor slots)* |  |  | 483 | 0.26 | U O* |  | listed below |

*Minor and undeclared slots:* What the texts say (9), 2011, udon-c/docs/DECIDED.md (8), Old parser (6), Jan 2026, design/udon-ast.md (3), Edge cases any alternative has to state (2), … (+56 more)

### Decided Entry

**Total Files**: 20  
**Total Lines**: 606  
**Where**: UDON 0.9 decision briefs 20  
**Shape declared in**: no declaration found

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Preamble)` | 20 | 20 | 101 | 0.17 | U* R* | im | title, one-line summary, any lead paragraph before the first ## |
| `Ratified`﹖ | 15 | 15 | 200 | 0.33 | U O* | hd | Joseph's ratified scope, verbatim or near |
| *(28 ad hoc headings)* |  |  | 305 | 0.50 | U O* |  | listed below |

*Minor and undeclared slots:* Open | Authority | Migration | Definition

### Question (50–69)

**Total Files**: 20  
**Total Lines**: 1,132  
**Where**: UDON Lite pre-design questions 20  
**Shape declared in**: .int/pre-design/README.md (prose: "the question, the alternatives, UDON examples and the tree each alternative produces, and interactions")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 20 | 20 | 20 | 0.02 | U* R* | if |  |
| `(Preamble)` | 20 | 20 | 20 | 0.02 | U* R* | im |  |
| `(Title)` | 20 | 20 | 20 | 0.02 | U* R* | im |  |
| `Interactions` | 20 | 20 | 93 | 0.08 | D R* | hd | other questions this couples to |
| `The question`﹖ | 19 | 19 | 224 | 0.20 | D O* | hd | the question, neutrally |
| `Alternatives`﹖ | 19 | 19 | 403 | 0.36 | D O* | hd | the options, each with UDON and tree; holds 57 ### alternatives in 18 files |
| `Sub-questions`﹖ | 14 | 14 | 86 | 0.08 | U O* | hd | smaller questions inside |
| `Where it has come up`﹖ | 10 | 10 | 97 | 0.09 | U O* | hd |  |
| *(45 minor slots)* |  |  | 208 | 0.18 | U O* |  | listed below |

*Minor and undeclared slots:* Why lite must decide (4), Where it came up (4), Joseph, 2026-01-13 (4), K9 (3), What the texts say (2), 2011 (2), Joseph, 2025-12-25 (2), K15 (2), … (+37 more)

### Decision

**Total Files**: 18  
**Total Lines**: 1,495  
**Where**: UDON Lite spec 18  
**Shape declared in**: adr/TEMPLATE.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 18 | 18 | 18 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 18 | 18 | 18 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 18 | 18 | 18 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 18 | 18 | 18 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Title` | 18 | 18 | 18 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Status` | 18 | 18 | 18 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Decided-by` | 18 | 18 | 18 | 0.01 | D R | fm | required by .vsect/kinds.yaml |
| `Decided` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Updated` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Deciders` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Consulted` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Informed` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Wording` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Grounds-recorded` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Supersedes` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Superseded-by` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Closes` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `Leaves-open` | 18 | 18 | 18 | 0.01 | U R* | fm |  |
| `(Slug)` | 18 | 18 | 18 | 0.01 | U* R* | if |  |
| `(Title)` | 18 | 18 | 18 | 0.01 | U* R* | im |  |
| `Context and Problem Statement` | 18 | 18 | 79 | 0.05 | D R | hd | what has to be decided and why now |
| `Decision Drivers` | 18 | 18 | 84 | 0.06 | D R | hd | forces, each tied to an objective or marked inferred |
| `Assumptions` | 18 | 18 | 77 | 0.05 | D R | hd | what must stay true; each becomes a reopen trigger |
| `Considered Options` | 18 | 18 | 92 | 0.06 | D R | hd | the options on the table |
| `Decision Outcome` | 18 | 18 | 559 | 0.37 | D R | hd | the choice and its because |
| `Decision Outcome › Quote` | 18 | 18 | 170 | 0.11 | U R* | hd |  |
| `Decision Outcome › Positive Consequences` | 18 | 18 | 77 | 0.05 | U R* | hd |  |
| `Decision Outcome › Negative Consequences` | 18 | 18 | 77 | 0.05 | U R* | hd |  |
| `Decision Outcome › What changes` | 18 | 18 | 84 | 0.06 | U R* | hd |  |
| `Reopen when` | 18 | 18 | 114 | 0.08 | D R | hd | falsifiers |
| `Working notes`﹖ | 18 | 18 | 76 | 0.05 | D O | hd | open threads, leans, things to check; drained before freeze |
| `Pros and Cons of the Options`﹖ | 1 | 1 | 18 | 0.01 | D O | hd | per-option argument; holds 1 ### option in 1 file |
| *(6 minor slots)* |  |  | 15 | 0.01 | U O* |  | listed below |

*Minor and undeclared slots:* Pros and Cons of the Options › Split the two facts (1), Pros and Cons of the Options › Also fold steward away (1), For Joseph (1), Since unsettled (1), The layers (1), … (+1 more)

### Requirement

**Total Files**: 13  
**Total Lines**: 549  
**Where**: live_docs 13  
**Shape declared in**: live_docs AGENTS.md schema rules + skills/_shared/doc-types.md, doc-style.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 13 | 13 | 13 | 0.02 | D R | fm | identity |
| `Title` | 13 | 13 | 13 | 0.02 | D R | fm | name |
| `Label` | 13 | 13 | 13 | 0.02 | D R | fm | short label |
| `Summary` | 13 | 13 | 13 | 0.02 | D R* | fm | 1-3 sentence gist |
| `Type` | 13 | 13 | 13 | 0.02 | D R | fm | kind |
| `Status` | 13 | 13 | 13 | 0.02 | D R | fm | strength / lifecycle state |
| `Force` | 13 | 13 | 13 | 0.02 | D R | fm | must / should / may |
| `Realization` | 13 | 13 | 13 | 0.02 | D R | fm | built or not |
| `Belongs to`﹖ | 13 | 13 | 13 | 0.02 | D O | fm | hierarchy edge |
| `History`﹖ | 13 | 13 | 26 | 0.05 | D O | fm | change trail |
| `History.summary` | 13 | 13 | 13 | 0.02 | U R* | fm |  |
| `History.change type` | 13 | 13 | 13 | 0.02 | U R* | fm |  |
| `History.session` | 13 | 13 | 13 | 0.02 | U R* | fm |  |
| `Provenance`﹖ | 12 | 12 | 12 | 0.02 | D O | fm | derived-from edge |
| `Domain`﹖ | 11 | 11 | 11 | 0.02 | D O | fm | business grouping |
| `Requires`﹖ | 9 | 9 | 9 | 0.02 | D O | fm | dependency edge |
| `Intent` | 9 | 9 | 9 | 0.02 | D R | fm | requested / chosen / incidental |
| `Intent basis`﹖ | 9 | 9 | 9 | 0.02 | U O* | fm | evidence for intent |
| `Relates`﹖ | 8 | 8 | 8 | 0.01 | D O | fm | see-also edge |
| `Scope`﹖ | 1 | 1 | 1 | 0.00 | D O | fm | scope facet |
| `Requirement`﹖ | 11 | 11 | 56 | 0.10 | U O* | hd | the requirement stated |
| `Why`﹖ | 11 | 11 | 44 | 0.08 | U O* | hd | the why |
| *(10 minor slots)* |  |  | 68 | 0.12 | U O* |  | listed below |

*Minor and undeclared slots:* When to pause (1), When not to pause (1), Warning format (1), Rationale (1), What this component covers (1), The core methodological pair (1), The six original principles (1), … (+3 more)

### Rule (2026-10-20 Card Shape)

**Total Files**: 13  
**Total Lines**: 760  
**Where**: UDON Lite spec 13  
**Shape declared in**: sop/src/conv-record-cadence.md (convention, "proposed, or even exploratory") as amended by the proposal in sop/influx/udon-team-notes.md §2026-10-2

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 13 | 13 | 13 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 13 | 13 | 13 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 13 | 13 | 13 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 13 | 13 | 13 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Layer` | 13 | 13 | 13 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Strength` | 13 | 13 | 13 | 0.02 | U R* | fm |  |
| `Per` | 13 | 13 | 13 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Depends` | 13 | 13 | 13 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Consequences` | 13 | 13 | 13 | 0.02 | U R* | fm |  |
| `(Slug)` | 13 | 13 | 13 | 0.02 | U* R* | if |  |
| `(Preamble)` | 13 | 13 | 13 | 0.02 | U* R* | im |  |
| `(Title)` | 13 | 13 | 13 | 0.02 | U* R* | im |  |
| `Context`﹖ | 10 | 10 | 10 | 0.01 | U O* | fm |  |
| `Statement` | 13 | 13 | 55 | 0.07 | D R | hd | the normative clause(s) themselves |
| `Grounds` | 13 | 13 | 52 | 0.07 | D R | hd | what the card rests on (decisions, objectives, or forced-by) |
| `Explanation`﹖ | 13 | 13 | 203 | 0.27 | D O | hd | teaching example, adds nothing to the Statement |
| `Implications`﹖ | 10 | 10 | 57 | 0.07 | D O | hd | user-facing costs the decision accepts |
| `Working notes`﹖ | 9 | 9 | 65 | 0.09 | D O | hd | open threads, leans, things to check; drained before freeze |
| `Discussion`﹖ | 3 | 3 | 106 | 0.14 | D O | hd | reasoning, context, carried decision text |
| `Epistemic status`﹖ | 1 | 1 | 4 | 0.01 | U O* | hd | what is checked, what is chosen |
| `Decisions carried`﹖ | 1 | 1 | 13 | 0.02 | D O | hd | list of decisions a multi-decision card holds |
| *(12 minor slots)* |  |  | 12 | 0.02 | U O* |  | listed below |

*Minor and undeclared slots:* Surrogates only in pairs (1), Default-on or default-off (1), Under discussion (2026-10-29), not decided (1), <…> reopened wholesale (1), Joseph's words (1), Reasoning (1), … (+6 more)

### Question-discussion

**Total Files**: 13  
**Total Lines**: 6,987  
**Where**: UDON Lite pre-design questions 13  
**Shape declared in**: .int/pre-design/README.md (prose: "the full history … in chronological order, then leans")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 13 | 13 | 13 | 0.00 | U* R* | if |  |
| `(Preamble)` | 13 | 13 | 264 | 0.04 | U* R* | im |  |
| `(Title)` | 13 | 13 | 13 | 0.00 | U* R* | im |  |
| `History` | 13 | 13 | 5,285 | 0.76 | D R* | hd | chronological history from transcripts and files; holds 301 ### histories in 12 files, each with fields Source, Speaker, Bears on this question, Incidental, What it says, Same day (+12 more) |
| `Threads worth noticing` | 13 | 13 | 520 | 0.07 | U R* | hd | the history agent's reading |
| `What the neutral file misses` | 13 | 13 | 572 | 0.08 | U R* | hd | what the history adds to the neutral statement; holds 13 ### misses in 1 file, each with fields What all texts agree on |
| `Written by`﹖ | 9 | 9 | 9 | 0.00 | U O* | la |  |
| *(72 minor slots)* |  |  | 410 | 0.06 | U O* |  | listed below |

*Minor and undeclared slots:* Who wrote this (4), Method (3), 2011 originals (3), Read whole first (2), What this is (2), V2 (2), Repo reads (1), Dating (1), Getting Joseph's exact words, indentation intact (1), … (+63 more)

### Question (01–13)

**Total Files**: 13  
**Total Lines**: 1,005  
**Where**: UDON Lite pre-design questions 13  
**Shape declared in**: .int/pre-design/README.md (prose: "the question, the alternatives, UDON examples and the tree each alternative produces, and interactions")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 13 | 13 | 13 | 0.01 | U* R* | if |  |
| `(Title)` | 13 | 13 | 13 | 0.01 | U* R* | im |  |
| `Interactions` | 13 | 13 | 71 | 0.07 | D R* | hd | other questions this couples to |
| `Alternatives`﹖ | 5 | 5 | 259 | 0.26 | D O* | hd | the options, each with UDON and tree; holds 15 ### alternatives in 5 files |
| `The question`﹖ | 4 | 4 | 16 | 0.02 | D O* | hd | the question, neutrally |
| *(41 minor slots)* |  |  | 655 | 0.65 | U O* |  | listed below |

*Minor and undeclared slots:* Settled (6), Background (2), Current rule (2), Questions for lite (2), 0.10.0 §2.1 (1), 0.10.0 §6.4 and §6.10 (1), Why lite must decide (1), What follows the line (1), … (+33 more)

### Context (Sidecar)

**Total Files**: 12  
**Total Lines**: 104  
**Where**: UDON Lite spec 12  
**Shape declared in**: .vsect/kinds.yaml exclude + sop/influx/udon-team-notes.md: "not a record and never resolves"

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 12 | 12 | 12 | 0.12 | U* R* | if |  |
| `(Preamble)` | 12 | 12 | 66 | 0.63 | U* R* | im |  |
| `(Title)` | 12 | 12 | 12 | 0.12 | U* R* | im |  |
| `(Title › Context)` | 12 | 12 | 12 | 0.12 | U* R* | im |  |
| *(3 minor slots)* |  |  | 3 | 0.03 | U O* |  | listed below |

*Minor and undeclared slots:* Readings by the agent, not his words (1), A note the coordinator added at the time (1), His further words that day (1)

### Constraint

**Total Files**: 11  
**Total Lines**: 439  
**Where**: live_docs 11  
**Shape declared in**: live_docs AGENTS.md schema rules + skills/_shared/doc-types.md, doc-style.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 11 | 11 | 11 | 0.03 | D R | fm | identity |
| `Title` | 11 | 11 | 11 | 0.03 | D R | fm | name |
| `Label` | 11 | 11 | 11 | 0.03 | D R | fm | short label |
| `Summary` | 11 | 11 | 11 | 0.03 | D R* | fm | 1-3 sentence gist |
| `Type` | 11 | 11 | 11 | 0.03 | D R | fm | kind |
| `Status` | 11 | 11 | 11 | 0.03 | D R | fm | strength / lifecycle state |
| `Force` | 11 | 11 | 11 | 0.03 | D R | fm | must / should / may |
| `Imposed by` | 11 | 11 | 11 | 0.03 | D R | fm | who set the limit |
| `Belongs to`﹖ | 11 | 11 | 11 | 0.03 | D O | fm | hierarchy edge |
| `Provenance`﹖ | 11 | 11 | 11 | 0.03 | D O | fm | derived-from edge |
| `History`﹖ | 11 | 11 | 22 | 0.05 | D O | fm | change trail |
| `History.summary` | 11 | 11 | 11 | 0.03 | U R* | fm |  |
| `History.change type` | 11 | 11 | 11 | 0.03 | U R* | fm |  |
| `History.session` | 11 | 11 | 11 | 0.03 | U R* | fm |  |
| `Domain`﹖ | 9 | 9 | 9 | 0.02 | D O | fm | business grouping |
| `Relates`﹖ | 8 | 8 | 8 | 0.02 | D O | fm | see-also edge |
| `Requires`﹖ | 8 | 8 | 8 | 0.02 | D O | fm | dependency edge |
| `Intent` | 2 | 2 | 2 | 0.00 | D R | fm | requested / chosen / incidental |
| `Scope`﹖ | 2 | 2 | 2 | 0.00 | D O | fm | scope facet |
| `Constraint`﹖ | 8 | 8 | 52 | 0.12 | U O* | hd | the constraint stated |
| *(8 minor slots)* |  |  | 53 | 0.12 | U O* |  | listed below |

*Minor and undeclared slots:* Why (3), Statement (2), Rationale (2), Why it matters (1), Context (1), Why this is a constraint, not a convenience (1), Skills must be self-contained (1), Intent basis (1)

### Adr (V1, Classic)

**Total Files**: 9  
**Total Lines**: 3,921  
**Where**: autopax ADRs 9  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 9 | 9 | 9 | 0.00 | U* R* | if |  |
| `(Title)` | 9 | 9 | 9 | 0.00 | U* R* | im |  |
| `(Preamble)`﹖ | 7 | 7 | 63 | 0.02 | U* O* | im |  |
| `Context` | 9 | 9 | 207 | 0.05 | U R* | hd | forces; holds 4 named ### parts in 3 files |
| `Consequences` | 9 | 9 | 191 | 0.05 | U R* | hd | consequences; holds 1 ### consequence in 1 file, each with fields Explicit > implicit, Validation > permissiveness, SemVer for schemas |
| `Status`﹖ | 8 | 8 | 8 | 0.00 | U O* | la |  |
| `Date`﹖ | 7 | 7 | 7 | 0.00 | U O* | la |  |
| `Deciders`﹖ | 7 | 7 | 7 | 0.00 | U O* | la |  |
| `Decision`﹖ | 7 | 7 | 1,485 | 0.38 | U O* | hd | the decision ("Decision N: ..." when several); holds 32 named ### parts in 6 files, each with fields Principle, Proposed Lexicon Entries, Portkey ID format patterns, Why this matters, Critical pars… |
| `References`﹖ | 7 | 7 | 117 | 0.03 | U O* | hd | sources; holds 1 ### reference in 1 file |
| `Consequences › Positive`﹖ | 5 | 5 | 45 | 0.01 | U O* | hd |  |
| `Consequences › Negative`﹖ | 5 | 5 | 32 | 0.01 | U O* | hd |  |
| *(261 minor slots)* |  |  | 3,060 | 0.78 | U O* |  | listed below |

*Minor and undeclared slots:* Status (4), Open Questions (4), Related (3), Positive (3), Negative (3), Implementation (3), Revision History (3), Standard (2), Supersedes (2), Date (2), Deciders (2), … (+246 more)

### Use-case

**Total Files**: 7  
**Total Lines**: 244  
**Where**: live_docs 7  
**Shape declared in**: live_docs AGENTS.md schema rules + skills/_shared/doc-types.md, doc-style.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 7 | 7 | 7 | 0.03 | D R | fm | identity |
| `Title` | 7 | 7 | 7 | 0.03 | D R | fm | name |
| `Label` | 7 | 7 | 7 | 0.03 | D R | fm | short label |
| `Summary` | 7 | 7 | 7 | 0.03 | D R* | fm | 1-3 sentence gist |
| `Type` | 7 | 7 | 7 | 0.03 | D R | fm | kind |
| `Status` | 7 | 7 | 7 | 0.03 | D R | fm | strength / lifecycle state |
| `Realization` | 7 | 7 | 7 | 0.03 | D R | fm | built or not |
| `Belongs to`﹖ | 7 | 7 | 7 | 0.03 | D O | fm | hierarchy edge |
| `Provenance`﹖ | 7 | 7 | 7 | 0.03 | D O | fm | derived-from edge |
| `History`﹖ | 7 | 7 | 14 | 0.06 | D O | fm | change trail |
| `History.summary` | 7 | 7 | 7 | 0.03 | U R* | fm |  |
| `Relates`﹖ | 6 | 6 | 6 | 0.02 | D O | fm | see-also edge |
| `History.change type`﹖ | 6 | 6 | 6 | 0.02 | U O* | fm |  |
| `History.session`﹖ | 6 | 6 | 6 | 0.02 | U O* | fm |  |
| `Domain`﹖ | 5 | 5 | 5 | 0.02 | D O | fm | business grouping |
| `Intent` | 2 | 2 | 2 | 0.01 | D R | fm | requested / chosen / incidental |
| `Created` | 1 | 1 | 1 | 0.00 | D R | fm | creation time |
| `Requires`﹖ | 1 | 1 | 1 | 0.00 | D O | fm | dependency edge |
| `Use-case`﹖ | 5 | 5 | 27 | 0.11 | U O* | hd | the scenario |
| *(12 minor slots)* |  |  | 55 | 0.23 | U O* |  | listed below |

*Minor and undeclared slots:* Rationale (2), Intent basis (2), Consumer markers (1), The force it creates (1), Why it matters now (1), What the store must do (1), Boundaries (1), The scenario (1), … (+4 more)

### Goal

**Total Files**: 6  
**Total Lines**: 194  
**Where**: live_docs 6  
**Shape declared in**: live_docs AGENTS.md schema rules + skills/_shared/doc-types.md, doc-style.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 6 | 6 | 6 | 0.03 | D R | fm | identity |
| `Title` | 6 | 6 | 6 | 0.03 | D R | fm | name |
| `Label` | 6 | 6 | 6 | 0.03 | D R | fm | short label |
| `Summary` | 6 | 6 | 6 | 0.03 | D R* | fm | 1-3 sentence gist |
| `Type` | 6 | 6 | 6 | 0.03 | D R | fm | kind |
| `Status` | 6 | 6 | 6 | 0.03 | D R | fm | strength / lifecycle state |
| `Realization` | 6 | 6 | 6 | 0.03 | D R | fm | built or not |
| `Belongs to`﹖ | 6 | 6 | 6 | 0.03 | D O | fm | hierarchy edge |
| `Provenance`﹖ | 6 | 6 | 6 | 0.03 | D O | fm | derived-from edge |
| `Domain`﹖ | 6 | 6 | 6 | 0.03 | D O | fm | business grouping |
| `History`﹖ | 6 | 6 | 12 | 0.06 | D O | fm | change trail |
| `History.summary` | 6 | 6 | 6 | 0.03 | U R* | fm |  |
| `History.change type`﹖ | 4 | 4 | 4 | 0.02 | U O* | fm |  |
| `History.session`﹖ | 4 | 4 | 4 | 0.02 | U O* | fm |  |
| `Relates`﹖ | 3 | 3 | 3 | 0.02 | D O | fm | see-also edge |
| `Intent` | 3 | 3 | 3 | 0.02 | D R | fm | requested / chosen / incidental |
| `Intent basis`﹖ | 3 | 3 | 3 | 0.02 | U O* | fm | evidence for intent |
| `Created` | 2 | 2 | 2 | 0.01 | D R | fm | creation time |
| `Requires`﹖ | 1 | 1 | 1 | 0.01 | D O | fm | dependency edge |
| `Goal`﹖ | 4 | 4 | 16 | 0.08 | U O* | hd | the goal stated |
| `Why`﹖ | 4 | 4 | 16 | 0.08 | U O* | hd | the why |
| *(6 minor slots)* |  |  | 30 | 0.15 | U O* |  | listed below |

*Minor and undeclared slots:* Scope note (1), Statement (1), Rationale (1), How the goal is met (1), The goal (1), What that asks for (1)

### Adr (V2, Readme Format)

**Total Files**: 5  
**Total Lines**: 2,358  
**Where**: autopax ADRs 5  
**Shape declared in**: declared (README)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Adr` | 5 | 5 | 5 | 0.00 | D R | fm | number |
| `Title` | 5 | 5 | 5 | 0.00 | D R | fm | title |
| `Aliases` | 5 | 5 | 5 | 0.00 | D R | fm | Obsidian link aliases |
| `Status` | 5 | 5 | 5 | 0.00 | D R | fm | lifecycle state (+flags) |
| `First introduced` | 5 | 5 | 5 | 0.00 | D R | fm | date created |
| `Last changed` | 5 | 5 | 5 | 0.00 | D R | fm | datetime of last change |
| `Deciders` | 5 | 5 | 5 | 0.00 | D R | fm | who must unanimously agree |
| `Supersedes`﹖ | 5 | 5 | 5 | 0.00 | D O | fm | ADR it replaces |
| `Superseded by`﹖ | 5 | 5 | 5 | 0.00 | D O | fm | ADR replacing it |
| `Related`﹖ | 5 | 5 | 5 | 0.00 | D O | fm | conceptual relations |
| `Blocked by`﹖ | 5 | 5 | 5 | 0.00 | D O | fm | decision-lifecycle dependencies |
| `Needed for`﹖ | 5 | 5 | 5 | 0.00 | D O | fm | ADRs waiting on this |
| `(Slug)` | 5 | 5 | 5 | 0.00 | U* R* | if |  |
| `(Title)` | 5 | 5 | 5 | 0.00 | U* R* | im |  |
| `Preamble` | 5 | 5 | 67 | 0.03 | D R | hd | status history group |
| `Preamble › Status Timeline` | 5 | 5 | 29 | 0.01 | U R* | hd |  |
| `Preamble › Change Log` | 5 | 5 | 28 | 0.01 | U R* | hd |  |
| `ADR` | 5 | 5 | 803 | 0.34 | D R | hd | the decision group |
| `ADR › Context` | 5 | 5 | 147 | 0.06 | U R* | hd |  |
| `ADR › Proposals` | 5 | 5 | 479 | 0.20 | U R* | hd |  |
| `ADR › Expected Impact` | 5 | 5 | 167 | 0.07 | U R* | hd |  |
| `Discussion`﹖ | 5 | 5 | 568 | 0.24 | D O | hd | group; holds 9 named ### parts in 2 files, each with fields Current Catalog Implementation, As Archema Resources, Model Stacks |
| `Discussion › Alternatives Considered` | 5 | 5 | 129 | 0.05 | U R* | hd |  |
| `Discussion › Open Questions` | 5 | 5 | 95 | 0.04 | U R* | hd |  |
| `Execution Notes`﹖ | 5 | 5 | 434 | 0.18 | D O | hd | group; holds 1 ### note in 1 file, each with fields Status |
| `End-matter`﹖ | 5 | 5 | 349 | 0.15 | D O | hd | group; holds 3 named ### parts in 1 file |
| `End-matter › References` | 5 | 5 | 75 | 0.03 | U R* | hd |  |
| `Amendments`﹖ | 5 | 5 | 58 | 0.02 | D O | hd | post-decision amendments; holds 2 ### amendments in 1 file, each with fields Authorized by, Implemented by, Commit, Change, Rationale, Impact on Proposals (+2 more) |
| `Execution Notes › OPERATA Tasks`﹖ | 4 | 4 | 93 | 0.04 | U O* | hd |  |
| `Execution Notes › Patterns to Avoid`﹖ | 3 | 3 | 56 | 0.02 | U O* | hd |  |
| `End-matter › Appendices`﹖ | 3 | 3 | 226 | 0.10 | U O* | hd |  |
| *(109 minor slots)* |  |  | 529 | 0.22 | U O* |  | listed below |

*Minor and undeclared slots:* Decision (2), Rationale (2), If these proposals are accepted (2), Risk (2), Mitigation (2), Approach (2), Pros (2), Cons (2), Rejected because (2), Resolution deferred (2), … (+99 more)

### Guide

**Total Files**: 5  
**Total Lines**: 326  
**Where**: live_docs 5  
**Shape declared in**: live_docs AGENTS.md schema rules + skills/_shared/doc-types.md, doc-style.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 5 | 5 | 5 | 0.02 | D R | fm | identity |
| `Title` | 5 | 5 | 5 | 0.02 | D R | fm | name |
| `Label` | 5 | 5 | 5 | 0.02 | D R | fm | short label |
| `Summary` | 5 | 5 | 5 | 0.02 | D R* | fm | 1-3 sentence gist |
| `Type` | 5 | 5 | 5 | 0.02 | D R | fm | kind |
| `Status` | 5 | 5 | 5 | 0.02 | D R | fm | strength / lifecycle state |
| `Force` | 5 | 5 | 5 | 0.02 | D R | fm | must / should / may |
| `Belongs to`﹖ | 5 | 5 | 5 | 0.02 | D O | fm | hierarchy edge |
| `Provenance`﹖ | 5 | 5 | 5 | 0.02 | D O | fm | derived-from edge |
| `Domain`﹖ | 5 | 5 | 5 | 0.02 | D O | fm | business grouping |
| `History`﹖ | 5 | 5 | 10 | 0.03 | D O | fm | change trail |
| `History.summary` | 5 | 5 | 5 | 0.02 | U R* | fm |  |
| `History.change type` | 5 | 5 | 6 | 0.02 | U R* | fm |  |
| `History.session`﹖ | 4 | 4 | 4 | 0.01 | U O* | fm |  |
| `Relates`﹖ | 4 | 4 | 4 | 0.01 | D O | fm | see-also edge |
| `Requires`﹖ | 3 | 3 | 3 | 0.01 | D O | fm | dependency edge |
| `Intent` | 1 | 1 | 1 | 0.00 | D R | fm | requested / chosen / incidental |
| *(18 minor slots)* |  |  | 192 | 0.59 | U O* |  | listed below |

*Minor and undeclared slots:* Guide (2), What this is (2), Cascade (1), Why it works (1), Automated via apply-to-docs skill (1), Example (1), When to use it (1), Priority (1), … (+10 more)

### Objective

**Total Files**: 4  
**Total Lines**: 195  
**Where**: UDON Lite spec 4  
**Shape declared in**: sop/src/conv-record-cadence.md (convention, "proposed, or even exploratory")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 4 | 4 | 4 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 4 | 4 | 4 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 4 | 4 | 4 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 4 | 4 | 4 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Force` | 4 | 4 | 4 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Per` | 4 | 4 | 4 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Depends` | 4 | 4 | 4 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `(Slug)` | 4 | 4 | 4 | 0.02 | U* R* | if |  |
| `(Preamble)` | 4 | 4 | 4 | 0.02 | U* R* | im |  |
| `(Title)` | 4 | 4 | 4 | 0.02 | U* R* | im |  |
| `Statement` | 4 | 4 | 20 | 0.10 | D R | hd | the normative clause(s) themselves |
| `Grounds` | 4 | 4 | 25 | 0.13 | D R | hd | what the card rests on (decisions, objectives, or forced-by) |
| `What discharges it` | 4 | 4 | 26 | 0.13 | D R | hd | how the objective is met |
| `Epistemic status` | 4 | 4 | 16 | 0.08 | D R | hd | what is checked, what is chosen |
| `Discussion`﹖ | 4 | 4 | 36 | 0.18 | D O | hd | reasoning, context, carried decision text |
| `Working notes`﹖ | 4 | 4 | 20 | 0.10 | D O | hd | open threads, leans, things to check; drained before freeze |
| *(4 minor slots)* |  |  | 4 | 0.02 | U O* |  | listed below |

*Minor and undeclared slots:* Known collisions, from the pre-design files (1), Decision (1), What "represent" doesn't settle (1), Decisions (1)

### Brief

**Total Files**: 4  
**Total Lines**: 707  
**Where**: UDON 0.9 decision briefs 4  
**Shape declared in**: no declaration found

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.01 | U* R* | if |  |
| `(Preamble)` | 4 | 4 | 24 | 0.03 | U* R* | im |  |
| `(Title)` | 4 | 4 | 4 | 0.01 | U* R* | im |  |
| `Recommendation`﹖ | 3 | 3 | 75 | 0.11 | U O* | hd | the brief's recommendation |
| `The question`﹖ | 2 | 2 | 21 | 0.03 | U O* | hd | the question, neutrally |
| `Concrete next action`﹖ | 2 | 2 | 30 | 0.04 | U O* | hd |  |
| `Next action`﹖ | 2 | 2 | 16 | 0.02 | U O* | hd |  |
| `Options`﹖ | 2 | 2 | 83 | 0.12 | U O* | hd | options for Joseph |
| *(27 minor slots)* |  |  | 459 | 0.65 | U O* |  | listed below |

*Minor and undeclared slots:* Headline (1), Termination rules (1), Honest two-fork residue (1), The three coordinating-session findings — verified, two corrected (1), Candidate syntaxes (1), … (+22 more)

### Principle

**Total Files**: 2  
**Total Lines**: 81  
**Where**: UDON Lite spec 2  
**Shape declared in**: sop/src/conv-record-cadence.md (convention, "proposed, or even exploratory")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Per` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Depends` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `(Slug)` | 2 | 2 | 2 | 0.02 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 2 | 0.02 | U* R* | im |  |
| `(Title)` | 2 | 2 | 2 | 0.02 | U* R* | im |  |
| `Awaiting Joseph` | 2 | 2 | 2 | 0.02 | U R* | la |  |
| `Statement` | 2 | 2 | 11 | 0.14 | D R | hd | the normative clause(s) themselves |
| `Grounds` | 2 | 2 | 13 | 0.16 | D R | hd | what the card rests on (decisions, objectives, or forced-by) |
| `How it is used` | 2 | 2 | 8 | 0.10 | D R | hd | how the principle breaks ties |
| `Epistemic status` | 2 | 2 | 8 | 0.10 | D R | hd | what is checked, what is chosen |
| `Working notes`﹖ | 2 | 2 | 12 | 0.15 | D O | hd | open threads, leans, things to check; drained before freeze |
| `Discussion`﹖ | 1 | 1 | 5 | 0.06 | D O | hd | reasoning, context, carried decision text |

### Definition

**Total Files**: 2  
**Total Lines**: 78  
**Where**: UDON Lite spec (vsect-init, supers 2  
**Shape declared in**: .old/vsect-init/proposed-verisectorium.md ("Cadence of a rule file"; "every record of every kind ends with a Working notes section"); only Working

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 2 | 2 | 2 | 0.03 | U R* | fm |  |
| `Terms` | 2 | 2 | 2 | 0.03 | U R* | fm |  |
| `State` | 2 | 2 | 2 | 0.03 | U R* | fm |  |
| `Per` | 2 | 2 | 2 | 0.03 | U R* | fm |  |
| `Depends` | 2 | 2 | 2 | 0.03 | U R* | fm |  |
| `Questions` | 2 | 2 | 2 | 0.03 | U R* | fm |  |
| `Max` | 2 | 2 | 2 | 0.03 | U R* | fm |  |
| `(Slug)` | 2 | 2 | 2 | 0.03 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 2 | 0.03 | U* R* | im |  |
| `(Title)` | 2 | 2 | 2 | 0.03 | U* R* | im |  |
| `Decided` | 2 | 2 | 2 | 0.03 | U R* | la |  |
| `Terms` | 2 | 2 | 13 | 0.17 | U R* | hd | the defined terms and their definitions |
| `Invariants` | 2 | 2 | 10 | 0.13 | U R* | hd | what always holds of the defined thing |
| `Examples` | 2 | 2 | 10 | 0.13 | U R* | hd | worked spellings |
| `Working notes` | 2 | 2 | 19 | 0.24 | D R | hd | open threads, leans, things to check; drained before freeze |
| `Document`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Root-node`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Meta`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Open`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Typed-value`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Explicit-typed-value`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Implicit-typed-value`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Type-label`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Open, and deliberately not settled here`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |

### Adr Addendum

**Total Files**: 1  
**Total Lines**: 47  
**Where**: autopax ADRs 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `Some higher level perspective and context` | 1 | 1 | 48 | 1.02 | U R* | hd |  |

### Readme (Lifecycle + Format)

**Total Files**: 1  
**Total Lines**: 325  
**Where**: autopax ADRs 1  
**Shape declared in**: n/a (declares the others)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 3 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `Addendum vs Appendix vs New ADR` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `ADR Threshold` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Multi-Decision ADRs` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Relationship to Other Docs` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `ADR Lifecycle` | 1 | 1 | 24 | 0.07 | U R* | hd |  |
| `Statuses` | 1 | 1 | 54 | 0.17 | U R* | hd | holds 4 named ### parts in 1 file |
| `Status Transitions` | 1 | 1 | 33 | 0.10 | U R* | hd | holds 2 named ### parts in 1 file |
| `ADR Format` | 1 | 1 | 144 | 0.44 | U R* | hd | holds 4 named ### parts in 1 file, each with fields Note on dependencies, Note on structure, Status Timeline, Context, Proposals, Expected Impact |
| `Key Principles` | 1 | 1 | 39 | 0.12 | U R* | hd | holds 4 ### key principles in 1 file |
| `Open Questions` | 1 | 1 | 20 | 0.06 | U R* | hd |  |
| `References` | 1 | 1 | 5 | 0.02 | U R* | hd |  |

### Objective

**Total Files**: 1  
**Total Lines**: 44  
**Where**: UDON Lite spec (vsect-init, supers 1  
**Shape declared in**: .old/vsect-init/proposed-verisectorium.md ("Cadence of a rule file"; "every record of every kind ends with a Working notes section"); only Working

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `State` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Per` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Depends` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Questions` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Max` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `Statement` | 1 | 1 | 7 | 0.16 | U R* | hd | the normative clause(s) themselves |
| `Grounds` | 1 | 1 | 6 | 0.14 | U R* | hd | what the card rests on (decisions, objectives, or forced-by) |
| `What discharges it` | 1 | 1 | 8 | 0.18 | U R* | hd | how the objective is met |
| `Epistemic status` | 1 | 1 | 7 | 0.16 | U R* | hd | what is checked, what is chosen |
| `Working notes` | 1 | 1 | 4 | 0.09 | D R | hd | open threads, leans, things to check; drained before freeze |

### Principle

**Total Files**: 1  
**Total Lines**: 36  
**Where**: UDON Lite spec (vsect-init, supers 1  
**Shape declared in**: .old/vsect-init/proposed-verisectorium.md ("Cadence of a rule file"; "every record of every kind ends with a Working notes section"); only Working

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `State` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Per` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Depends` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Questions` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Max` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.03 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im |  |
| `Statement` | 1 | 1 | 4 | 0.11 | U R* | hd | the normative clause(s) themselves |
| `How it is used` | 1 | 1 | 7 | 0.19 | U R* | hd | how the principle breaks ties |
| `Grounds` | 1 | 1 | 4 | 0.11 | U R* | hd | what the card rests on (decisions, objectives, or forced-by) |
| `Epistemic status` | 1 | 1 | 4 | 0.11 | U R* | hd | what is checked, what is chosen |
| `Working notes` | 1 | 1 | 5 | 0.14 | D R | hd | open threads, leans, things to check; drained before freeze |

### Rule

**Total Files**: 1  
**Total Lines**: 49  
**Where**: UDON Lite spec (vsect-init, supers 1  
**Shape declared in**: .old/vsect-init/proposed-verisectorium.md ("Cadence of a rule file"; "every record of every kind ends with a Working notes section")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Layer` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `State` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Per` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Depends` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Questions` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Fixtures` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `Max` | 1 | 1 | 1 | 0.02 | U R* | fm |  |
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `Statement` | 1 | 1 | 7 | 0.14 | D R | hd | the normative clause(s) themselves |
| `Open parts, not decided here` | 1 | 1 | 8 | 0.16 | D R | hd |  |
| `Grounds` | 1 | 1 | 6 | 0.12 | D R | hd | what the card rests on (decisions, objectives, or forced-by) |
| `Epistemic status` | 1 | 1 | 4 | 0.08 | D R | hd | what is checked, what is chosen |
| `Explanation`﹖ | 1 | 1 | 6 | 0.12 | D O | hd | teaching example, adds nothing to the Statement |
| `Working notes` | 1 | 1 | 4 | 0.08 | D R | hd | open threads, leans, things to check; drained before freeze |

### Audit

**Total Files**: 1  
**Total Lines**: 120  
**Where**: UDON 0.9 decision briefs 1  
**Shape declared in**: no declaration found

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 14 | 0.12 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Categories` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Fixed now` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Riding pending executions` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Genuine tensions` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Worst offender` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Findings` | 1 | 1 | 43 | 0.36 | U R* | hd | holds 1 named ### parts in 1 file, each with fields test/usability/ |
| `Genuine tensions` | 1 | 1 | 43 | 0.36 | U R* | hd |  |
| `Counts` | 1 | 1 | 16 | 0.13 | U R* | hd |  |

### Supplement

**Total Files**: 1  
**Total Lines**: 323  
**Where**: UDON 0.9 decision briefs 1  
**Shape declared in**: no declaration found

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 6 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `Phase-3 impl` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Suffixes never drifted` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `(C) Views-over-reserved-attrs hybrid` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `The eight invariants › Mixin ›  ` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `The eight invariants › Event model ›  ` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Between (A) and (C), (C) dominates weakly` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `C-1 · Reserved wire names` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `C-2 · Unassigned $-names` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `C-3 · D1c reopened with inverted premise` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `C-4 · API surface` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `C-5 · fmt normalization` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Spec` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Impl` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Genealogy of the incumbent` | 1 | 1 | 30 | 0.09 | U R* | hd |  |
| `The three models` | 1 | 1 | 15 | 0.05 | U R* | hd |  |
| `Joseph's requirement-revealing case, worked through each model` | 1 | 1 | 29 | 0.09 | U R* | hd |  |
| `The eight invariants` | 1 | 1 | 137 | 0.42 | U R* | hd | holds 8 ### invariants in 1 file, each with fields (A)/ |
| `The honest cost of (A)/` | 1 | 1 | 20 | 0.06 | U R* | hd |  |
| `Recommendation` | 1 | 1 | 36 | 0.11 | U R* | hd |  |
| `Exact deltas for` | 1 | 1 | 48 | 0.15 | U R* | hd |  |

### Model

**Total Files**: 1  
**Total Lines**: 111  
**Where**: UDON 0.9 decision briefs 1  
**Shape declared in**: no declaration found

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 3 | 0.03 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Type-scoped uniqueness` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `View B — distinct` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Substrate — spec-forced` | 1 | 1 | 46 | 0.41 | U R* | hd |  |
| `Recommended host views — authority N` | 1 | 1 | 26 | 0.23 | U R* | hd |  |
| `Parser / host decisions (the knobs to expose) — authority 2 + N` | 1 | 1 | 13 | 0.12 | U R* | hd |  |
| `Schema decisions — authority N` | 1 | 1 | 7 | 0.06 | U R* | hd |  |
| `What ratifying this closes` | 1 | 1 | 14 | 0.13 | U R* | hd |  |
## Procedures, norms and principles

### Decision

**Total Files**: 46  
**Total Lines**: 3,638  
**Where**: UDON Lite SOP 46  
**Shape declared in**: adr/TEMPLATE.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Awaiting-second` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Awaiting-decision` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Needs-work` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Title` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Status` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Decided-by` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Decided` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Updated` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Deciders` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Consulted` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Informed` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Wording` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Grounds-recorded` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Supersedes` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Superseded-by` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Closes` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `Leaves-open` | 46 | 46 | 46 | 0.01 | U R* | fm |  |
| `(Slug)` | 46 | 46 | 46 | 0.01 | U* R* | if |  |
| `(Title)` | 46 | 46 | 46 | 0.01 | U* R* | im |  |
| `Context and Problem Statement` | 46 | 46 | 193 | 0.05 | D R | hd | what has to be decided and why now |
| `Decision Drivers` | 46 | 46 | 212 | 0.06 | D R | hd | forces, each tied to an objective or marked inferred |
| `Assumptions` | 46 | 46 | 185 | 0.05 | D R | hd | what must stay true; each becomes a reopen trigger |
| `Considered Options` | 46 | 46 | 231 | 0.06 | D R | hd | the options on the table |
| `Decision Outcome` | 46 | 46 | 1,266 | 0.35 | D R | hd | the choice and its because |
| `Decision Outcome › Quote` | 46 | 46 | 365 | 0.10 | U R* | hd |  |
| `Decision Outcome › Positive Consequences` | 46 | 46 | 202 | 0.06 | U R* | hd |  |
| `Decision Outcome › Negative Consequences` | 46 | 46 | 186 | 0.05 | U R* | hd |  |
| `Decision Outcome › What changes` | 46 | 46 | 201 | 0.06 | U R* | hd |  |
| `Reopen when` | 46 | 46 | 285 | 0.08 | D R | hd | falsifiers |
| `Working notes`﹖ | 46 | 46 | 138 | 0.04 | D O | hd | open threads, leans, things to check; drained before freeze |
| `Pros and Cons of the Options`﹖ | 10 | 10 | 116 | 0.03 | D O | hd | per-option argument; holds 23 ### options in 10 files |
| *(13 minor slots)* |  |  | 13 | 0.00 | U O* |  | listed below |

*Minor and undeclared slots:* Headers (1), Cells the linter writes (1), Notes for the future linter, not rules now (1), Resolved (1), Kept (1), Deferred (1), Promoted (1), The norm (1), … (+5 more)

### Cli-conventions Section

**Total Files**: 35  
**Total Lines**: 2,731  
**Where**: firmatum principles 35  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 35 | 35 | 35 | 0.01 | U* R* | if |  |
| *(173 minor slots)* |  |  | 5,261 | 1.93 | U O* |  | listed below |

*Minor and undeclared slots:* AI Agent Considerations (1), AI Agent Considerations › Auto-Detection of Agent Mode (1), AI Agent Considerations › Agent Mode Behavior (1), … (+170 more)

### Norm (udon)

**Total Files**: 19  
**Total Lines**: —  
**Where**: vivarium process norms 19  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:kind` | 19 | 19 | 19 | 19.00 | U R* | ot | prescription / proscription |
| `Feedback`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | dated participant feedback; Joseph adjudicates; declared, filled by no file |
| *(3 minor slots)* |  |  | 144 | 144.00 | U O* |  | listed below |

*Minor and undeclared slots:* :authority (4), :source (1), :files (1)

### Norm

**Total Files**: 19  
**Total Lines**: 386  
**Where**: firmatum principles 19  
**Shape declared in**: principles/src/README.md (frontmatter vocabulary; "every atom carries a provenance line")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 19 | 19 | 19 | 0.05 | D R* | fm | identity (= filename) |
| `Form` | 19 | 19 | 19 | 0.05 | D R | fm | speech-act kind |
| `Type` | 19 | 19 | 19 | 0.05 | D R* | fm | kind |
| `Max` | 19 | 19 | 19 | 0.05 | D R* | fm | ceiling of strength |
| `State` | 19 | 19 | 19 | 0.05 | D R* | fm | process-state flags |
| `(Preamble)` | 19 | 19 | 80 | 0.21 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 19 | 19 | 19 | 0.05 | U* R* | im | the segment's name / one-line claim |
| `(Title › Norm)` | 19 | 19 | 19 | 0.05 | U* R* | im |  |
| `Provenance`﹖ | 1 | 1 | 4 | 0.01 | D O* | hd | where it came from and who decided |
| *(14 minor slots)* |  |  | 65 | 0.17 | U O* |  | listed below |

*Minor and undeclared slots:* Decided-by (2), Content channel (1), Tuning channel (1), Why this is a law and not taste (1), The carve (1), External measurement (1), Estate field reports (1), … (+7 more)

### Convention

**Total Files**: 16  
**Total Lines**: 680  
**Where**: UDON Lite SOP 16  
**Shape declared in**: sop/src/conv-record-cadence.md (convention, "proposed, or even exploratory")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 16 | 16 | 16 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 16 | 16 | 16 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 16 | 16 | 16 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 16 | 16 | 16 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Per` | 16 | 16 | 16 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Depends` | 16 | 16 | 16 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `(Slug)` | 16 | 16 | 16 | 0.02 | U* R* | if |  |
| `(Preamble)` | 16 | 16 | 16 | 0.02 | U* R* | im |  |
| `(Title)` | 16 | 16 | 16 | 0.02 | U* R* | im |  |
| `Statement` | 16 | 16 | 231 | 0.34 | D R | hd | the normative clause(s) themselves |
| `How a violation shows` | 16 | 16 | 87 | 0.13 | D R | hd | the observable failure of the convention |
| `Discussion` | 16 | 16 | 99 | 0.15 | D R | hd | reasoning, context, carried decision text |
| `Working notes`﹖ | 16 | 16 | 71 | 0.10 | D O | hd | open threads, leans, things to check; drained before freeze |
| *(24 minor slots)* |  |  | 24 | 0.04 | U O* |  | listed below |

*Minor and undeclared slots:* Column headers carry a ⟦column-marker⟧ (1), A computed cell with no value carries a ⟦cell-mark⟧ (1), When decisions conflict (1), Until this is decided (1), … (+20 more)

### Definition

**Total Files**: 10  
**Total Lines**: 486  
**Where**: UDON Lite SOP 10  
**Shape declared in**: sop/src/conv-record-cadence.md (convention, "proposed, or even exploratory")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 10 | 10 | 10 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 10 | 10 | 10 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 10 | 10 | 10 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 10 | 10 | 10 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Terms` | 10 | 10 | 10 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Per` | 10 | 10 | 10 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Depends` | 10 | 10 | 10 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `(Slug)` | 10 | 10 | 10 | 0.02 | U* R* | if |  |
| `(Preamble)` | 10 | 10 | 10 | 0.02 | U* R* | im |  |
| `(Title)` | 10 | 10 | 10 | 0.02 | U* R* | im |  |
| `Terms` | 10 | 10 | 167 | 0.34 | D R | hd | the defined terms and their definitions |
| `Invariants` | 10 | 10 | 75 | 0.15 | D R | hd | what always holds of the defined thing |
| `Discussion`﹖ | 8 | 8 | 43 | 0.09 | D O | hd | reasoning, context, carried decision text |
| `Working notes`﹖ | 7 | 7 | 30 | 0.06 | D O | hd | open threads, leans, things to check; drained before freeze |
| `Sources`﹖ | 4 | 4 | 23 | 0.05 | D O | hd | where the facts come from |
| `Examples`﹖ | 2 | 2 | 10 | 0.02 | D O | hd | worked spellings |
| `Cautions`﹖ | 2 | 2 | 8 | 0.02 | D O | hd | known hazards of reading or using the record |
| *(71 minor slots)* |  |  | 95 | 0.20 | U O* |  | listed below |

*Minor and undeclared slots:* Status (1), Decided-by (1), Wording (1), Assumption (1), Grounds-recorded (1), Reopen-condition (1), Deciders (1), Consulted (1), Informed (1), Profile (1), Canonical (1), … (+60 more)

### Claim Chapter (Finding / Demand / Principle)

**Total Files**: 9  
**Total Lines**: 468  
**Where**: firmatum principles 9  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 9 | 9 | 9 | 0.02 | U R* | fm | identity (= filename) |
| `Type` | 9 | 9 | 9 | 0.02 | U R* | fm | kind |
| `Register` | 9 | 9 | 9 | 0.02 | U R* | fm | derived / evidenced |
| `Support-kind` | 9 | 9 | 9 | 0.02 | U R* | fm | kind of support |
| `Strength` | 9 | 9 | 9 | 0.02 | U R* | fm | strength |
| `Convergent` | 9 | 9 | 9 | 0.02 | U R* | fm | convergent evidence |
| `Stage` | 9 | 9 | 9 | 0.02 | U R* | fm | draft / checked |
| `Consumers` | 9 | 9 | 9 | 0.02 | U R* | fm | who reads it |
| `Verified` | 9 | 9 | 18 | 0.04 | U R* | fm | verification acts |
| `Depends` | 9 | 9 | 9 | 0.02 | U R* | fm | prerequisites |
| `Sources` | 9 | 9 | 39 | 0.08 | U R* | fm | sources |
| `(Preamble)` | 9 | 9 | 24 | 0.05 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 9 | 9 | 9 | 0.02 | U* R* | im | the segment's name / one-line claim |
| `Honest edges` | 9 | 9 | 36 | 0.08 | U R* | hd | limits of the finding |
| `What this opens`﹖ | 8 | 8 | 69 | 0.15 | U O* | hd | ideas it opens, not designs |
| `For UDON`﹖ | 7 | 7 | 7 | 0.01 | U O* | la |  |
| `What it generates`﹖ | 7 | 7 | 36 | 0.08 | U O* | hd | what follows from the finding |
| `For the harness`﹖ | 6 | 6 | 6 | 0.01 | U O* | la |  |
| `The evidence`﹖ | 5 | 5 | 42 | 0.09 | U O* | hd | evidence |
| *(25 minor slots)* |  |  | 94 | 0.20 | U O* |  | listed below |

*Minor and undeclared slots:* Who reads this and when (3), Built (1), Shipped ecosystem-wide (1), Shown failing when absent (1), Derived by the theory (1), The strongest worked example this report has (1), … (+19 more)

### Form

**Total Files**: 7  
**Total Lines**: 215  
**Where**: firmatum principles 7  
**Shape declared in**: principles/src/README.md (frontmatter vocabulary; "every atom carries a provenance line")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 7 | 7 | 7 | 0.03 | D R* | fm | identity (= filename) |
| `Form` | 7 | 7 | 7 | 0.03 | D R | fm | speech-act kind |
| `Type` | 7 | 7 | 7 | 0.03 | D R* | fm | kind |
| `Max` | 7 | 7 | 7 | 0.03 | D R* | fm | ceiling of strength |
| `State` | 7 | 7 | 7 | 0.03 | D R* | fm | process-state flags |
| `(Preamble)` | 7 | 7 | 57 | 0.27 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 7 | 7 | 7 | 0.03 | U* R* | im | the segment's name / one-line claim |
| `(Title › Formulation)` | 7 | 7 | 7 | 0.03 | U* R* | im |  |
| `Provenance`﹖ | 1 | 1 | 4 | 0.02 | D O* | hd | where it came from and who decided |
| *(8 minor slots)* |  |  | 54 | 0.25 | U O* |  | listed below |

*Minor and undeclared slots:* Decided-by (1), The governing principle (1), What a glance surface is (1), The channels — the physical media a text look owns (1), The concerns — laws that bound every option (1), … (+3 more)

### Cluster

**Total Files**: 6  
**Total Lines**: 642  
**Where**: practica normative claims 6  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.01 | U* R* | if |  |
| `(Preamble)` | 6 | 6 | 18 | 0.03 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 6 | 6 | 6 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `What this cluster does not specify` | 6 | 6 | 72 | 0.11 | U R* | hd | explicit non-commitments of the cluster |
| *(36 minor slots)* |  |  | 528 | 0.82 | U O* |  | listed below |

*Minor and undeclared slots:* A1 — Plumbing/intelligence split is the architectural form (1), A2 — Intent and Realization are type-separated resources (1), … (+34 more)

### Sop

**Total Files**: 6  
**Total Lines**: 1,061  
**Where**: ASF SOPs 6  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.01 | U* R* | if |  |
| `(Preamble)` | 6 | 6 | 25 | 0.02 | U* R* | im |  |
| `(Title)` | 6 | 6 | 6 | 0.01 | D* R* | im | title (human-readable, no fixed form) |
| `Provenance`﹖ | 3 | 3 | 12 | 0.01 | U O* | hd | procedure subsections |
| *(77 minor slots)* |  |  | 1,315 | 1.24 | U O* |  | listed below |

*Minor and undeclared slots:* Three formats (1), Filename = slug (1), In running text (1), Obsidian tag recognition (1), Inline (1), Display (1), Vertical bars (1), Asterisks in inline math (1), … (+69 more)

### Cluster (udon)

**Total Files**: 4  
**Total Lines**: —  
**Where**: vivarium process norms 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:name` | 4 | 4 | 4 | 4.00 | U R* | ot | cluster name |
| `Norm` | 4 | 4 | 201 | 201.00 | U R* | ot |  |

### Influx-report

**Total Files**: 4  
**Total Lines**: 3,485  
**Where**: firmatum principles 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.00 | U* R* | if |  |
| `(Preamble)` | 4 | 4 | 81 | 0.02 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 4 | 4 | 4 | 0.00 | U* R* | im | the segment's name / one-line claim |
| `Summary`﹖ | 2 | 2 | 70 | 0.02 | U O* | hd | summary |
| *(209 minor slots)* |  |  | 8,598 | 2.47 | U O* |  | listed below |

*Minor and undeclared slots:* Agent-utility notes (1), Starting itch (1), Generation surface (1), Generation surface › What agents do that humans don’t (1), Generation surface › Multi-line / line-bound (1), … (+204 more)

### Theory Doc

**Total Files**: 4  
**Total Lines**: 392  
**Where**: practica normative claims 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.01 | U* R* | if |  |
| `(Title)` | 4 | 4 | 4 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `(Preamble)`﹖ | 2 | 2 | 2 | 0.01 | U* O* | im | untitled opening prose (summary, statement, or the whole body) |
| *(22 minor slots)* |  |  | 384 | 0.98 | U O* |  | listed below |

*Minor and undeclared slots:* What this is (1), Notation — every symbol used in the spine (1), Results catalog — slug → plain English → tier → why practica leans on it (1), How to read this (1), … (+18 more)

### Sop Piece

**Total Files**: 4  
**Total Lines**: 1,247  
**Where**: ASF SOPs 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.00 | U* R* | if |  |
| `(Preamble)` | 4 | 4 | 11 | 0.01 | U* R* | im |  |
| `(Title)` | 4 | 4 | 4 | 0.00 | D* R* | im | title (human-readable, no fixed form) |
| *(56 minor slots)* |  |  | 1,358 | 1.09 | U O* |  | listed below |

*Minor and undeclared slots:* Your reflection between segments is the orient cascade (1), The audit's quality is its persistence (1), A note on tone before you begin (1), Before you begin (1), … (+52 more)

### Directive

**Total Files**: 3  
**Total Lines**: 108  
**Where**: UDON Lite SOP 3  
**Shape declared in**: sop/src/conv-record-cadence.md (convention, "proposed, or even exploratory")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 3 | 3 | 3 | 0.03 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 3 | 3 | 3 | 0.03 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 3 | 3 | 3 | 0.03 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 3 | 3 | 3 | 0.03 | D R | fm | required by .vsect/kinds.yaml |
| `When` | 3 | 3 | 3 | 0.03 | D R | fm | required by .vsect/kinds.yaml |
| `Per` | 3 | 3 | 3 | 0.03 | D R | fm | required by .vsect/kinds.yaml |
| `Depends` | 3 | 3 | 3 | 0.03 | D R | fm | required by .vsect/kinds.yaml |
| `(Slug)` | 3 | 3 | 3 | 0.03 | U* R* | if |  |
| `(Preamble)` | 3 | 3 | 3 | 0.03 | U* R* | im |  |
| `(Title)` | 3 | 3 | 3 | 0.03 | U* R* | im |  |
| `Statement` | 3 | 3 | 43 | 0.40 | D R | hd | the normative clause(s) themselves |
| `Discussion` | 3 | 3 | 16 | 0.15 | D R | hd | reasoning, context, carried decision text |
| `Working notes`﹖ | 3 | 3 | 10 | 0.09 | D O | hd | open threads, leans, things to check; drained before freeze |

### Sop Branch Index

**Total Files**: 2  
**Total Lines**: 19  
**Where**: ASF SOPs 2  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.11 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 11 | 0.58 | U* R* | im |  |
| `(Title)` | 2 | 2 | 2 | 0.11 | D* R* | im | title (human-readable, no fixed form) |
| `Before starting a de-novo audit`﹖ | 1 | 1 | 1 | 0.05 | U O* | la |  |

### Reference

**Total Files**: 2  
**Total Lines**: 84  
**Where**: UDON Lite SOP 2  
**Shape declared in**: sop/src/conv-record-cadence.md (convention, "proposed, or even exploratory")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-second` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Awaiting-decision` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Needs-work` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Source` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Per` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `Depends` | 2 | 2 | 2 | 0.02 | D R | fm | required by .vsect/kinds.yaml |
| `(Slug)` | 2 | 2 | 2 | 0.02 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 2 | 0.02 | U* R* | im |  |
| `(Title)` | 2 | 2 | 2 | 0.02 | U* R* | im |  |
| `Discussion`﹖ | 2 | 2 | 8 | 0.10 | D O | hd | reasoning, context, carried decision text |
| `Working notes`﹖ | 2 | 2 | 6 | 0.07 | D O | hd | open threads, leans, things to check; drained before freeze |
| `Hazards`﹖ | 1 | 1 | 13 | 0.15 | U O* | hd |  |
| `Sources`﹖ | 1 | 1 | 4 | 0.05 | D O | hd | where the facts come from |
| `The layout`﹖ | 1 | 1 | 23 | 0.27 | U O* | hd |  |
| `Cautions`﹖ | 1 | 1 | 4 | 0.05 | D O | hd | known hazards of reading or using the record |

### Claim

**Total Files**: 1  
**Total Lines**: 15  
**Where**: firmatum principles 1  
**Shape declared in**: principles/src/README.md (frontmatter vocabulary; "every atom carries a provenance line")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.07 | D R* | fm | identity (= filename) |
| `Form` | 1 | 1 | 1 | 0.07 | D R | fm | speech-act kind |
| `Type` | 1 | 1 | 1 | 0.07 | D R* | fm | kind |
| `Max` | 1 | 1 | 1 | 0.07 | D R* | fm | ceiling of strength |
| `State` | 1 | 1 | 1 | 0.07 | D R* | fm | process-state flags |
| `(Preamble)` | 1 | 1 | 3 | 0.20 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 1 | 1 | 1 | 0.07 | U* R* | im | the segment's name / one-line claim |

### Sop (Agents / Index)

**Total Files**: 1  
**Total Lines**: 331  
**Where**: ASF SOPs 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | D* R* | im | title (human-readable, no fixed form) |
| `A` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `B` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `C` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `D` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `E` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `F` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `G` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `H` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `I` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Commit by naming your paths` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Git history` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Search tools` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Orchestration` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Every agent, first` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `File identity and ordering` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Filename = slug` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Directed separation` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Claim tiers` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Exact` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Robust qualitative` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Heuristic` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Conditional` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Supporting` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Active effort` | 1 | 1 | 44 | 0.13 | U R* | hd |  |
| `Start here — by role / assignment` | 1 | 1 | 8 | 0.02 | U R* | hd |  |
| `SOP index` | 1 | 1 | 14 | 0.04 | U R* | hd |  |
| `What This Project Is` | 1 | 1 | 17 | 0.05 | U R* | hd |  |
| `Current Priority` | 1 | 1 | 12 | 0.04 | U R* | hd |  |
| `Where to Start` | 1 | 1 | 10 | 0.03 | U R* | hd |  |
| `Theory Structure` | 1 | 1 | 22 | 0.07 | U R* | hd |  |
| `The Core Insight` | 1 | 1 | 10 | 0.03 | U R* | hd |  |
| `Epistemic Conventions` | 1 | 1 | 19 | 0.06 | U R* | hd |  |
| `Key Architectural Decisions` | 1 | 1 | 27 | 0.08 | U R* | hd |  |
| `What's Settled vs. Open` | 1 | 1 | 11 | 0.03 | U R* | hd | holds 1 named ### parts in 1 file |
| `Working Conventions` | 1 | 1 | 107 | 0.32 | U R* | hd | holds 9 ### working conventions in 1 file |
| `Where to look next` | 1 | 1 | 6 | 0.02 | U R* | hd |  |
| `File Organization` | 1 | 1 | 17 | 0.05 | U R* | hd |  |
| `⚠ Memory bridge` | 1 | 1 | 4 | 0.01 | U R* | hd |  |

### Outline

**Total Files**: 1  
**Total Lines**: 14  
**Where**: Address Theory SOP 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.07 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 6 | 0.43 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.07 | U* R* | im | the title |
| `Working Notes` | 1 | 1 | 5 | 0.36 | U R* | hd |  |

### Discussion

**Total Files**: 1  
**Total Lines**: 63  
**Where**: Address Theory SOP 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.02 | U R* | fm | identity |
| `Form` | 1 | 1 | 1 | 0.02 | U R* | fm | its kind |
| `Status` | 1 | 1 | 1 | 0.02 | U R* | fm | standing |
| `Max` | 1 | 1 | 1 | 0.02 | U R* | fm | the ceiling its status can reach |
| `State` | 1 | 1 | 1 | 0.02 | U R* | fm | process flags |
| `Depends` | 1 | 1 | 1 | 0.02 | U R* | fm | what it rests on |
| `(Preamble)` | 1 | 1 | 2 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the title |
| `Hazards, named so nobody re-learns them` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Segment discipline` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Register discipline` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `File format` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Where records land` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Steward relationship` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Commits` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Doctrina — know what the corpus already knows` | 1 | 1 | 25 | 0.40 | U R* | hd |  |
| `Praxes — how work happens here` | 1 | 1 | 14 | 0.22 | U R* | hd |  |
| `Professio — declare yourself` | 1 | 1 | 4 | 0.06 | U R* | hd |  |
| `Feedback channel` | 1 | 1 | 6 | 0.10 | U R* | hd |  |

### Orient

**Total Files**: 1  
**Total Lines**: 70  
**Where**: prior theory SOP 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 3 | 0.04 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the title |
| `Hazards, named so nobody re-learns them` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Segments` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Steward relationship` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Where records land` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Commits` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Doctrina — know what the corpus already knows` | 1 | 1 | 42 | 0.60 | U R* | hd |  |
| `Praxes — how work happens here` | 1 | 1 | 11 | 0.16 | U R* | hd |  |
| `Professio — declare yourself` | 1 | 1 | 4 | 0.06 | U R* | hd |  |
| `Feedback channel` | 1 | 1 | 6 | 0.09 | U R* | hd |  |
## Claim, evidence and source records

### Entry

**Total Files**: 2,796  
**Total Lines**: 93,107  
**Where**: relata data store 2796  
**Shape declared in**: lib/relata/entry.rb REQUIRED_FIELDS; optional ones named in code

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Key` | 2,796 | 2,796 | 5,592 | 0.06 | D R | la | citekey (= filename) |
| `Type` | 2,796 | 2,796 | 5,592 | 0.06 | D R | la | kind |
| `Title` | 2,796 | 2,796 | 5,032 | 0.05 | D R | la | name |
| `Authors` | 2,796 | 2,796 | 7,740 | 0.08 | D R | la | authors |
| `Year` | 2,796 | 2,796 | 5,592 | 0.06 | D R | la | year |
| `Url`﹖ | 2,300 | 2,300 | 4,600 | 0.05 | D O | la | URL |
| `Undermind_imports`﹖ | 1,814 | 1,814 | 10,357 | 0.11 | U O* | la | import provenance |
| `Doi`﹖ | 1,757 | 1,757 | 3,514 | 0.04 | D O | la | DOI |
| `Abstract`﹖ | 1,704 | 1,704 | 20,826 | 0.22 | U O* | la | abstract |
| `Venue`﹖ | 1,435 | 1,435 | 2,818 | 0.03 | U O* | la | venue |
| `Volume`﹖ | 1,364 | 1,364 | 1,630 | 0.02 | D O | la | volume |
| `Pages`﹖ | 1,358 | 1,358 | 2,626 | 0.03 | D O | la | pages |
| `Pdf_acquisition_status`﹖ | 593 | 593 | 1,186 | 0.01 | D O | la | fetch state |
| `Aliases`﹖ | 31 | 31 | 31 | 0.00 | D O | la | alternate keys |
| *(2 minor slots; 34 ad hoc headings)* |  |  | 15,971 | 0.17 | U O* |  | listed below |

*Minor and undeclared slots:* Pdfs (759), Internal_note (579), journal, month, note, eprint, archiveprefix

### Verification-event

**Total Files**: 445  
**Total Lines**: 3,113  
**Where**: relata data store 445  
**Shape declared in**: lib/relata/verification_event.rb (note = body)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Key` | 445 | 445 | 445 | 0.14 | D R | fm | citekey (= filename) |
| `Criterion` | 445 | 445 | 445 | 0.14 | D R | fm | what was checked |
| `Verifier` | 445 | 445 | 445 | 0.14 | D R | fm | who checked |
| `Outcome` | 445 | 445 | 445 | 0.14 | D R | fm | verified / failed / uncertain |
| `Timestamp`﹖ | 445 | 445 | 445 | 0.14 | D O | fm | when |
| `(Preamble)`﹖ | 444 | 444 | 888 | 0.29 | D* O | im | untitled opening prose (summary, statement, or the whole body) |

### Ledger Entry

**Total Files**: 415  
**Total Lines**: 6,642  
**Where**: overarching ponderata 415  
**Shape declared in**: ponderata/README.md §The entry format

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Src` | 415 | 415 | 830 | 0.12 | D R | la | note file |
| `Lines` | 415 | 415 | 830 | 0.12 | D R | la | line span |
| `Anchor` | 415 | 415 | 707 | 0.11 | D R | la | first words, checked at render |
| `Who` | 415 | 415 | 830 | 0.12 | D R | la | reader |
| `Date` | 415 | 415 | 830 | 0.12 | D R | la | date |
| `Kind` | 415 | 415 | 830 | 0.12 | D R | la | sub-kind |
| `Note`﹖ | 352 | 352 | 743 | 0.11 | D O | la | note (emitted) |
| `Ref`﹖ | 314 | 314 | 701 | 0.11 | D O* | la | scripture reference keyed |
| `Match`﹖ | 141 | 141 | 321 | 0.05 | D O* | la | distinctive substring keyed |
| `Aid`﹖ | 10 | 10 | 20 | 0.00 | D O* | la | annotation id keyed |

### Claim

**Total Files**: 325  
**Total Lines**: 10,992  
**Where**: harness- and ecosystem-velocity cl 325  
**Shape declared in**: harness-velocity/CLAIMS.md record template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 325 | 325 | 325 | 0.03 | D R | fm | identity (= filename) |
| `Subjects` | 325 | 325 | 325 | 0.03 | D R* | fm | what the record is about |
| `Status` | 325 | 325 | 325 | 0.03 | D R | fm | strength / lifecycle state |
| `Stage` | 325 | 325 | 325 | 0.03 | D R* | fm | draft / checked |
| `Depends` | 325 | 325 | 329 | 0.03 | D R* | fm | prerequisites |
| `Checked on` | 325 | 325 | 325 | 0.03 | D R* | fm | last read against sources |
| `Data as of` | 325 | 325 | 325 | 0.03 | D R* | fm | which extraction |
| `(Preamble)` | 325 | 325 | 2,393 | 0.22 | D* R | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 325 | 325 | 325 | 0.03 | D* R | im | the segment's name / one-line claim |
| `Event`﹖ | 297 | 297 | 297 | 0.03 | D O* | fm | bounds on when it happened |
| `Author`﹖ | 254 | 254 | 254 | 0.02 | U O* | fm | who wrote it |
| `Superseded by`﹖ | 11 | 11 | 11 | 0.00 | D O | fm | replacement |
| `Supersedes`﹖ | 11 | 11 | 11 | 0.00 | D O | fm | what it replaces |
| `(Title › As of the harness load of 2026-10-21 N)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| `Epistemic Status` | 325 | 325 | 1,499 | 0.14 | D R* | hd | how strong it is and why |
| `Working Notes` | 325 | 325 | 1,641 | 0.15 | D R* | hd | open items and development notes (inbox) |
| *(45 minor slots)* |  |  | 85 | 0.01 | U O* |  | listed below |

*Minor and undeclared slots:* Kano (11), Servers that offer their own API as a code surface (1), An agent (1), Searched and not found (1), The collision exclusions move one median (1), … (+40 more)

### Verification-event

**Total Files**: 209  
**Total Lines**: 1,463  
**Where**: logos refs 209  
**Shape declared in**: refs/README.md §Verification

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Key` | 209 | 209 | 209 | 0.14 | D R | fm | citekey (= filename) |
| `Criterion` | 209 | 209 | 209 | 0.14 | D R | fm | what was checked |
| `Verifier` | 209 | 209 | 209 | 0.14 | D R | fm | who checked |
| `Outcome` | 209 | 209 | 209 | 0.14 | D R | fm | verified / failed / uncertain |
| `Timestamp` | 209 | 209 | 209 | 0.14 | D R* | fm | when |
| `(Preamble)`﹖ | 209 | 209 | 418 | 0.29 | D* O | im | untitled opening prose (summary, statement, or the whole body) |

### Entry

**Total Files**: 188  
**Total Lines**: 3,037  
**Where**: neurips refs 188  
**Shape declared in**: refs/README.md §Schema

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 188 | 188 | 345 | 0.11 | D R | la | name |
| `Year` | 188 | 188 | 376 | 0.12 | D R | la | year |
| `Key` | 188 | 188 | 376 | 0.12 | D R | la | citekey (= filename) |
| `Type` | 188 | 188 | 376 | 0.12 | D R | la | kind |
| `Authors` | 188 | 188 | 539 | 0.18 | D R | la | authors |
| `Journal`﹖ | 96 | 96 | 191 | 0.06 | D O | la | journal |
| `Volume`﹖ | 79 | 79 | 80 | 0.03 | D O | la | volume |
| `Pages`﹖ | 76 | 76 | 148 | 0.05 | D O | la | pages |
| `Doi`﹖ | 69 | 69 | 138 | 0.05 | D O | la | DOI |
| `Number`﹖ | 55 | 55 | 58 | 0.02 | D O | la | issue |
| `Note`﹖ | 36 | 36 | 73 | 0.02 | D O | la | note (emitted) |
| `Internal_note`﹖ | 10 | 10 | 25 | 0.01 | D O | la | agent note (not emitted) |
| `Url`﹖ | 1 | 1 | 2 | 0.00 | D O | la | URL |
| *(1 minor slots; 11 ad hoc headings)* |  |  | 310 | 0.10 | U O* |  | listed below |

*Minor and undeclared slots:* Booktitle (50), eprint, archiveprefix, publisher, series, address

### Entry

**Total Files**: 97  
**Total Lines**: 2,791  
**Where**: logos refs 97  
**Shape declared in**: refs/README.md §Schema

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 97 | 97 | 160 | 0.06 | D R | la | name |
| `Year` | 97 | 97 | 194 | 0.07 | D R | la | year |
| `Key` | 97 | 97 | 194 | 0.07 | D R | la | citekey (= filename) |
| `Type` | 97 | 97 | 194 | 0.07 | D R | la | kind |
| `Authors` | 97 | 97 | 165 | 0.06 | D R | la | authors |
| `Internal_note`﹖ | 97 | 97 | 1,324 | 0.47 | D O | la | agent note (not emitted) |
| `Publisher`﹖ | 60 | 60 | 120 | 0.04 | U O* | la | publisher |
| `Doi`﹖ | 51 | 51 | 102 | 0.04 | D O | la | DOI |
| `Journal`﹖ | 33 | 33 | 65 | 0.02 | D O | la | journal |
| `Pages`﹖ | 33 | 33 | 65 | 0.02 | D O | la | pages |
| `Volume`﹖ | 28 | 28 | 29 | 0.01 | D O | la | volume |
| `Number`﹖ | 25 | 25 | 27 | 0.01 | D O | la | issue |
| `Url`﹖ | 10 | 10 | 20 | 0.01 | D O | la | URL |
| `Note`﹖ | 0 | 0 | 0 | 0.00 | D O | la | note (emitted); declared, filled by no file |
| *(1 minor slots; 8 ad hoc headings)* |  |  | 132 | 0.05 | U O* |  | listed below |

*Minor and undeclared slots:* Address (33), booktitle, isbn, editors, howpublished, editor

### Calibration-event

**Total Files**: 74  
**Total Lines**: 2,205  
**Where**: relata data store 74  
**Shape declared in**: lib/relata/calibration_event.rb

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Timestamp`﹖ | 74 | 74 | 74 | 0.03 | D O | fm | when |
| `Source id` | 74 | 74 | 74 | 0.03 | D R | fm | what was ingested |
| `Candidate key`﹖ | 74 | 74 | 74 | 0.03 | D O | fm | entry the ledger was built for |
| `Decided verdict` | 74 | 74 | 74 | 0.03 | D R | fm | pipeline's decision |
| `Human verdict` | 74 | 74 | 74 | 0.03 | D R | fm | labelled ground truth |
| `Label source` | 74 | 74 | 74 | 0.03 | D R | fm | how the label was obtained |
| `Verifier` | 74 | 74 | 74 | 0.03 | D R | fm | who checked |
| `Ledger` | 74 | 74 | 688 | 0.31 | D R | fm | weight-of-evidence ledger |
| `Ledger.prior logodds` | 74 | 74 | 148 | 0.07 | U R* | fm | prior log-odds |
| `Ledger.logodds` | 74 | 74 | 148 | 0.07 | U R* | fm | posterior log-odds |
| `Ledger.posterior` | 74 | 74 | 148 | 0.07 | U R* | fm | posterior probability |
| `Ledger.refuted` | 74 | 74 | 148 | 0.07 | U R* | fm | refuted flag |
| `Ledger.factors` | 74 | 74 | 259 | 0.12 | U R* | fm | per-factor WoE |
| `(Preamble)` | 74 | 74 | 148 | 0.07 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `Notes`﹖ | 0 | 0 | 0 | 0.00 | D O | fm | notes; declared, filled by no file |

### Passage (P-)

**Total Files**: 65  
**Total Lines**: 733  
**Where**: ai-risk-model thin-pass records (G 65  
**Shape declared in**: thin-pass records/<file>.yaml header comment ("rough format")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 65 | 65 | 130 | 0.18 | U R* | la | identity |
| `Doc` | 65 | 65 | 130 | 0.18 | D R* | la | relata key |
| `Page` | 65 | 65 | 130 | 0.18 | D R* | la | PDF page |
| `Lines` | 65 | 65 | 117 | 0.16 | D R* | la | line span |
| `Quote` | 65 | 65 | 208 | 0.28 | D R* | la | verbatim text |
| *(2 ad hoc headings)* |  |  | 18 | 0.02 | U O* |  | listed below |

*Minor and undeclared slots:* note, table_cell

### Fanout Group Report

**Total Files**: 54  
**Total Lines**: 2,937  
**Where**: stopgap system prompt drafting 54  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 54 | 54 | 54 | 0.02 | U* R* | if |  |
| `(Title)` | 54 | 54 | 54 | 0.02 | U* R* | im | the segment's name / one-line claim |
| *(266 minor slots)* |  |  | 2,938 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* (Preamble) (9), MEMORY.md (6), Summary (6), Feedbackpeertopeervoicewheninstructingagents.md (3), Overall note for the synthesizer (3), Suggested placement (2), … (+260 more)

### Quotation

**Total Files**: 49  
**Total Lines**: 2,177  
**Where**: comproprium harvests 49  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 49 | 49 | 49 | 0.02 | D R | fm | segment kind |
| `:status` | 49 | 49 | 49 | 0.02 | D R | fm | strength / state |
| `:stage` | 49 | 49 | 49 | 0.02 | U R* | fm | draft stage |
| `:speaker` | 49 | 49 | 49 | 0.02 | U R* | fm | who said it |
| `:said` | 49 | 49 | 49 | 0.02 | U R* | fm | when said |
| `:tags` | 49 | 49 | 49 | 0.02 | U R* | fm | tags |
| `:from` | 49 | 49 | 56 | 0.03 | U R* | fm | influx source file |
| `:project`﹖ | 42 | 42 | 84 | 0.04 | U O* | fm | project it came from |
| `Title` | 49 | 49 | 98 | 0.05 | D R* | ot | name |
| `Quote` | 49 | 49 | 159 | 0.07 | U R* | ot | the verbatim words |
| `Occasion` | 49 | 49 | 236 | 0.11 | U R* | ot | when and where they were said |
| `About` | 49 | 49 | 388 | 0.18 | U R* | ot | what the quote is about |
| `Before-acting`﹖ | 42 | 42 | 239 | 0.11 | D O | ot | trigger: a pending act |
| `See`﹖ | 42 | 42 | 162 | 0.07 | U O* | ot | related segments |
| `Working-notes`﹖ | 42 | 42 | 358 | 0.16 | D O* | ot | open items |
| `On-reading`﹖ | 10 | 10 | 33 | 0.02 | D O | ot | trigger: an input pattern |
| `Should-come-to-mind-when`﹖ | 7 | 7 | 45 | 0.02 | D O* | ot | trigger (old single field) |
| `Summary`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | one-paragraph summary; declared, filled by no file |
| `Cost`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | what it cost; declared, filled by no file |
| `Account`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | the narrative in order; declared, filled by no file |
| `Grounds`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | segments it is evidence for; declared, filled by no file |
| `Provenance`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | whose account, from what record; declared, filled by no file |
| *(2 minor slots)* |  |  | 25 | 0.01 | U O* |  | listed below |

*Minor and undeclared slots:* :family (20), :date-confidence (5)

### Term

**Total Files**: 43  
**Total Lines**: 243  
**Where**: ai-risk-model thin-pass records (G 43  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:binding`﹖ | 23 | 23 | 24 | 0.10 | U O* | fm | how the term gets meaning |
| `Rels`﹖ | 30 | 30 | 96 | 0.40 | U O* | ot | typed relations to other terms |
| *(6 minor slots; 2 ad hoc headings)* |  |  | 123 | 0.51 | U O* |  | listed below |

*Minor and undeclared slots:* :source (20), :closure (17), Discussion (13), :values (3), :avoid (1), :in-force (1), |working-notes, |ambiguity

### Thin Term

**Total Files**: 31  
**Total Lines**: 344  
**Where**: ai-risk-model thin-pass records (G 31  
**Shape declared in**: thin-pass records/<file>.yaml header comment ("rough format")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 31 | 31 | 62 | 0.18 | U R* | la | identity |
| `Kind` | 31 | 31 | 62 | 0.18 | D R* | la | sub-kind |
| `Gloss` | 31 | 31 | 81 | 0.24 | U R* | la | one-line gloss |
| `Weight` | 31 | 31 | 66 | 0.19 | D R* | la | computed / judged weight |
| `Why`﹖ | 16 | 16 | 49 | 0.14 | U O* | la | why the term was needed |
| `Established`﹖ | 9 | 9 | 24 | 0.07 | D O* | la | established name |

### Working-hypothesis

**Total Files**: 26  
**Total Lines**: 2,760  
**Where**: harness- and ecosystem-velocity cl 26  
**Shape declared in**: harness-velocity/CLAIMS.md working-hypothesis template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 26 | 26 | 26 | 0.01 | D R | fm | identity (= filename) |
| `Role` | 26 | 26 | 26 | 0.01 | D R | fm | working-hypothesis marker |
| `Subjects` | 26 | 26 | 26 | 0.01 | D R* | fm | what the record is about |
| `Status` | 26 | 26 | 26 | 0.01 | D R | fm | strength / lifecycle state |
| `Depends` | 26 | 26 | 26 | 0.01 | D R* | fm | prerequisites |
| `Contradicted by` | 26 | 26 | 26 | 0.01 | D R* | fm | live contradictions |
| `Stage` | 26 | 26 | 26 | 0.01 | U R* | fm | draft / checked |
| `Checked on` | 26 | 26 | 26 | 0.01 | D R* | fm | last read against sources |
| `Data as of` | 26 | 26 | 26 | 0.01 | U R* | fm | which extraction |
| `Author` | 26 | 26 | 26 | 0.01 | U R* | fm | who wrote it |
| `(Title)` | 26 | 26 | 26 | 0.01 | D* R | im | the segment's name / one-line claim |
| `Superseded by`﹖ | 13 | 13 | 13 | 0.00 | D O | fm | replacement |
| `Supersedes`﹖ | 13 | 13 | 13 | 0.00 | D O | fm | what it replaces |
| `Frame`﹖ | 1 | 1 | 1 | 0.00 | D O | fm | the overall lede |
| `Lede` | 26 | 26 | 291 | 0.11 | D R* | hd | the story as currently believed |
| `Weight of evidence` | 26 | 26 | 585 | 0.21 | D R* | hd | supports, contradicts, reconciliation |
| `What would most change this` | 26 | 26 | 231 | 0.08 | D R* | hd | unsettled sub-claims that would move the lede |
| `Epistemic Status` | 26 | 26 | 148 | 0.05 | D R* | hd | how strong it is and why |
| `Working Notes` | 26 | 26 | 394 | 0.14 | D R* | hd | open items and development notes (inbox) |
| `Timeline`﹖ | 25 | 25 | 651 | 0.24 | D O* | hd | dated steps citing records |
| *(26 minor slots)* |  |  | 94 | 0.03 | U O* |  | listed below |

*Minor and undeclared slots:* Harnesses against each other (3), Each model vendor's harness against its own API (2), Amp states one outright (1), The clocks, by source (1), How a first gets corrected (1), … (+21 more)

### Claim Chapter (Finding / Demand / Principle)

**Total Files**: 26  
**Total Lines**: 1,395  
**Where**: udon-needs: tooling needs 26  
**Shape declared in**: 02-tooling-needs/RESIDUALS.md §5 (segment-shape notes, pre-anthology)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 26 | 26 | 26 | 0.02 | U R* | fm |  |
| `Type` | 26 | 26 | 26 | 0.02 | U R* | fm |  |
| `Register` | 26 | 26 | 26 | 0.02 | U R* | fm |  |
| `Support-kind` | 26 | 26 | 26 | 0.02 | U R* | fm |  |
| `Strength` | 26 | 26 | 26 | 0.02 | U R* | fm |  |
| `Convergent` | 26 | 26 | 26 | 0.02 | U R* | fm |  |
| `Verified` | 26 | 26 | 52 | 0.04 | U R* | fm |  |
| `Stage` | 26 | 26 | 26 | 0.02 | U R* | fm |  |
| `Consumers` | 26 | 26 | 26 | 0.02 | U R* | fm |  |
| `Depends` | 26 | 26 | 26 | 0.02 | U R* | fm |  |
| `Sources` | 26 | 26 | 125 | 0.09 | U R* | fm |  |
| `(Preamble)` | 26 | 26 | 91 | 0.07 | U* R* | im |  |
| `(Title)` | 26 | 26 | 26 | 0.02 | U* R* | im |  |
| `Honest edges` | 26 | 26 | 106 | 0.08 | D R | hd | coverage limits and what is not established; always last |
| `What this opens`﹖ | 23 | 23 | 198 | 0.14 | U O* | hd | ideas the finding opens, not designs |
| `What it generates` | 21 | 21 | 110 | 0.08 | D R | hd | consequences, split by consumer |
| `For the harness`﹖ | 19 | 19 | 19 | 0.01 | U O* | la |  |
| `For UDON`﹖ | 18 | 18 | 18 | 0.01 | U O* | la |  |
| `The evidence`﹖ | 13 | 13 | 99 | 0.07 | D O* | hd | evidence tier by tier |
| *(46 minor slots)* |  |  | 256 | 0.18 | U O* |  | listed below |

*Minor and undeclared slots:* Who reads this and when (7), Working Notes (5), Opens (1), Handoff-routing (1), Asked for, repeatedly, in the design work (1), The four families (1), The four demands (1), … (+39 more)

### Resolution (R-)

**Total Files**: 22  
**Total Lines**: 478  
**Where**: ai-risk-model thin-pass records (G 22  
**Shape declared in**: thin-pass records/<file>.yaml header comment ("rough format")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 22 | 22 | 44 | 0.09 | U R* | la | identity |
| `Use` | 22 | 22 | 44 | 0.09 | D R* | la | passage and words resolved |
| `Origin` | 22 | 22 | 44 | 0.09 | D R* | la | scope used from |
| `Status` | 22 | 22 | 44 | 0.09 | D R* | la | strength / lifecycle state |
| `Outcome`﹖ | 20 | 20 | 40 | 0.08 | D O* | la | verified / failed / uncertain |
| `Reason`﹖ | 19 | 19 | 38 | 0.08 | D O* | la | whose fact |
| `Note`﹖ | 17 | 17 | 59 | 0.12 | U O* | la | note (emitted) |
| `Candidates`﹖ | 14 | 14 | 98 | 0.21 | D O* | la | named readings |
| `Path`﹖ | 8 | 8 | 16 | 0.03 | D O* | la | resolution path |
| `Decides`﹖ | 4 | 4 | 9 | 0.02 | D O* | la | evidence that would decide |
| `Our_preference`﹖ | 3 | 3 | 6 | 0.01 | D O* | la | our lean |
| `Resolver`﹖ | 3 | 3 | 7 | 0.01 | D O* | la | who resolves |
| `Evaluated_at`﹖ | 2 | 2 | 5 | 0.01 | D O* | la | evaluation date |
| `Policy`﹖ | 2 | 2 | 2 | 0.00 | D O* | la | declared preference |
| `Read_as_of`﹖ | 0 | 0 | 0 | 0.00 | D O* | la | as-of date; declared, filled by no file |
| `Q1_weight`﹖ | 0 | 0 | 0 | 0.00 | D O* | la | computed weight; declared, filled by no file |
| *(6 ad hoc headings)* |  |  | 22 | 0.05 | U O* |  | listed below |

*Minor and undeclared slots:* encoded, bears_on_plan, encoding, q1, preference_confidence

### Commentary

**Total Files**: 22  
**Total Lines**: 1,619  
**Where**: udon-needs: ideation gathering 22  
**Shape declared in**: 01-ideation/README.md declares frontmatter only; one file is .udon (commentary/spikes/paths-sketches.udon), whose /elements count as headings here

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Source` | 22 | 22 | 29 | 0.02 | U R* | fm |  |
| `Gathered` | 22 | 22 | 22 | 0.01 | U R* | fm |  |
| `Status` | 22 | 22 | 25 | 0.02 | U R* | fm |  |
| `Categories` | 22 | 22 | 34 | 0.02 | U R* | fm |  |
| `(Slug)` | 22 | 22 | 22 | 0.01 | U* R* | if |  |
| `Why included`﹖ | 21 | 21 | 107 | 0.07 | U O* | fm |  |
| `(Title)`﹖ | 20 | 20 | 20 | 0.01 | U* O* | im |  |
| `Paths`﹖ | 19 | 19 | 93 | 0.06 | U O* | fm |  |
| `(Preamble)`﹖ | 13 | 13 | 33 | 0.02 | U* O* | im |  |
| `Source commit`﹖ | 12 | 12 | 12 | 0.01 | U O* | fm |  |
| *(139 minor slots)* |  |  | 1,348 | 0.83 | U O* |  | listed below |

*Minor and undeclared slots:* Dry wells (4), Witness lines (3), Cross-tier convergences (2), Verified 2026-07-21 (1), The harness as method (1), Contrast tracks — comprehension/onboarding, NOT a use-catalog (1), … (+133 more)

### Quotation

**Total Files**: 20  
**Total Lines**: 589  
**Where**: comproprium 20  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 20 | 20 | 20 | 0.03 | D R | fm | segment kind |
| `:status` | 20 | 20 | 20 | 0.03 | D R | fm | strength / state |
| `:stage` | 20 | 20 | 20 | 0.03 | U R* | fm | draft stage |
| `:speaker` | 20 | 20 | 20 | 0.03 | U R* | fm | who said it |
| `:said` | 20 | 20 | 20 | 0.03 | U R* | fm | when said |
| `:tags` | 20 | 20 | 20 | 0.03 | U R* | fm | tags |
| `:from` | 20 | 20 | 38 | 0.06 | U R* | fm | influx source file |
| `Title` | 20 | 20 | 40 | 0.07 | D R* | ot | name |
| `Quote` | 20 | 20 | 61 | 0.10 | U R* | ot | the verbatim words |
| `Occasion` | 20 | 20 | 82 | 0.14 | U R* | ot | when and where they were said |
| `About` | 20 | 20 | 90 | 0.15 | U R* | ot | what the quote is about |
| `Should-come-to-mind-when` | 20 | 20 | 84 | 0.14 | D R* | ot | trigger (old single field) |
| `See`﹖ | 18 | 18 | 54 | 0.09 | U O* | ot | related segments |
| `Working-notes`﹖ | 2 | 2 | 10 | 0.02 | D O* | ot | open items |
| `Summary`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | one-paragraph summary; declared, filled by no file |
| `Cost`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | what it cost; declared, filled by no file |
| `Account`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | the narrative in order; declared, filled by no file |
| `Grounds`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | segments it is evidence for; declared, filled by no file |
| `Provenance`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | whose account, from what record; declared, filled by no file |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |
| *(3 minor slots)* |  |  | 10 | 0.02 | U O* |  | listed below |

*Minor and undeclared slots:* :family (4), :date-confidence (2), :project (2)

### Translation Row (T-)

**Total Files**: 19  
**Total Lines**: 352  
**Where**: ai-risk-model thin-pass records (G 19  
**Shape declared in**: thin-pass records/<file>.yaml header comment ("rough format")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 19 | 19 | 38 | 0.11 | U R* | la | identity |
| `Source_term` | 19 | 19 | 38 | 0.11 | D R* | la | source's word |
| `Scope` | 19 | 19 | 38 | 0.11 | D R* | la | scope facet |
| `Binding` | 19 | 19 | 38 | 0.11 | D R* | la | how it gets meaning |
| `Ours` | 19 | 19 | 35 | 0.10 | D R* | la | our term |
| `Skos` | 19 | 19 | 38 | 0.11 | D R* | la | SKOS match |
| `Justification` | 19 | 19 | 48 | 0.14 | D R* | la | why |
| `Minted_at`﹖ | 18 | 18 | 36 | 0.10 | D O* | la | where minted |
| `Intended_cardinality`﹖ | 17 | 17 | 17 | 0.05 | D O* | la | expected number of referents |
| `Frame`﹖ | 13 | 13 | 26 | 0.07 | D O* | la | the overall lede |

### Characterization (Harness-invivo)

**Total Files**: 17  
**Total Lines**: 1,642  
**Where**: udon-needs: ideation gathering 17  
**Shape declared in**: 01-ideation/README.md declares frontmatter only

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Source` | 17 | 17 | 17 | 0.01 | U R* | fm |  |
| `Gathered` | 17 | 17 | 17 | 0.01 | U R* | fm |  |
| `Status` | 17 | 17 | 17 | 0.01 | U R* | fm |  |
| `(Slug)` | 17 | 17 | 17 | 0.01 | U* R* | if |  |
| `(Title)` | 17 | 17 | 17 | 0.01 | U* R* | im |  |
| `(Preamble)`﹖ | 10 | 10 | 33 | 0.02 | U* O* | im |  |
| `Searches / commands run`﹖ | 13 | 13 | 123 | 0.07 | U O* | hd | search log |
| *(148 minor slots)* |  |  | 1,523 | 0.93 | U O* |  | listed below |

*Minor and undeclared slots:* Repo version (8), Repo (6), What this repo is (4), Repo provenance (4), Dry wells (4), Dry wells / not-relevant (3), Dry wells / deliberately skipped (3), Center of mass (3), What this repo actually is (3), Medium priority (3), Low priority (3), … (+133 more)

### Characterization

**Total Files**: 16  
**Total Lines**: 1,268  
**Where**: udon-needs: ideation gathering 16  
**Shape declared in**: 01-ideation/README.md declares frontmatter only

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Source` | 16 | 16 | 29 | 0.02 | U R* | fm |  |
| `Gathered` | 16 | 16 | 16 | 0.01 | U R* | fm |  |
| `Status` | 16 | 16 | 31 | 0.02 | U R* | fm |  |
| `(Slug)` | 16 | 16 | 16 | 0.01 | U* R* | if |  |
| `Paths`﹖ | 15 | 15 | 93 | 0.07 | U O* | fm |  |
| `Categories`﹖ | 15 | 15 | 17 | 0.01 | U O* | fm |  |
| `Why included`﹖ | 15 | 15 | 157 | 0.12 | U O* | fm |  |
| `Source commit`﹖ | 14 | 14 | 19 | 0.01 | U O* | fm |  |
| `(Title)`﹖ | 14 | 14 | 14 | 0.01 | U* O* | im |  |
| `(Preamble)`﹖ | 13 | 13 | 13 | 0.01 | U* O* | im |  |
| *(133 minor slots)* |  |  | 892 | 0.70 | U O* |  | listed below |

*Minor and undeclared slots:* Agreement (3), Divergence worth surfacing (3), Agreements / divergences vs the 02 synthesis layer (2), Divergence (2), Agreements / divergences with existing 02 material (2), … (+128 more)

### Verification-event

**Total Files**: 15  
**Total Lines**: 105  
**Where**: neurips refs 15  
**Shape declared in**: refs/README.md §Verification

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Key` | 15 | 15 | 15 | 0.14 | D R | fm | citekey (= filename) |
| `Criterion` | 15 | 15 | 15 | 0.14 | D R | fm | what was checked |
| `Verifier` | 15 | 15 | 15 | 0.14 | D R | fm | who checked |
| `Outcome` | 15 | 15 | 15 | 0.14 | D R | fm | verified / failed / uncertain |
| `Timestamp` | 15 | 15 | 15 | 0.14 | D R* | fm | when |
| `(Preamble)`﹖ | 15 | 15 | 30 | 0.29 | D* O | im | untitled opening prose (summary, statement, or the whole body) |

### Assertion (A-)

**Total Files**: 15  
**Total Lines**: 182  
**Where**: ai-risk-model thin-pass records (G 15  
**Shape declared in**: thin-pass records/<file>.yaml header comment ("rough format")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 15 | 15 | 30 | 0.16 | U R* | la | identity |
| `Voice` | 15 | 15 | 19 | 0.10 | D R* | la | who wrote it |
| `Act` | 15 | 15 | 32 | 0.18 | D R* | la | speech act |
| `Capacity` | 15 | 15 | 29 | 0.16 | D R* | la | capacity of the speaker |
| `Content` | 15 | 15 | 21 | 0.12 | D R* | la | frame or proposition |
| `Passages` | 15 | 15 | 25 | 0.14 | U R* | la | passages it rests on |
| `Norm`﹖ | 1 | 1 | 7 | 0.04 | D O* | la | directive layering |
| *(1 minor slots; 1 ad hoc headings)* |  |  | 19 | 0.10 | U O* |  | listed below |

*Minor and undeclared slots:* Note (5), factuality

### Definition Frame (F-)

**Total Files**: 15  
**Total Lines**: 771  
**Where**: ai-risk-model thin-pass records (G 15  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 15 | 15 | 30 | 0.04 | U R* | la | identity |
| `Row` | 15 | 15 | 30 | 0.04 | U R* | la | translation row |
| `Passages` | 15 | 15 | 45 | 0.06 | U R* | la | passages it rests on |
| `In_force`﹖ | 14 | 14 | 26 | 0.03 | U O* | la | when in force |
| `Applies_to`﹖ | 12 | 12 | 24 | 0.03 | U O* | la | what it applies to |
| `Concept`﹖ | 12 | 12 | 24 | 0.03 | U O* | la | our concept |
| `Closure`﹖ | 12 | 12 | 22 | 0.03 | U O* | la | open / closed definition |
| `Slots`﹖ | 12 | 12 | 509 | 0.66 | U O* | la | one per separable clause, with test |
| *(1 minor slots; 3 ad hoc headings)* |  |  | 61 | 0.08 | U O* |  | listed below |

*Minor and undeclared slots:* Inherit (3), consequences, override, substitute_frames

### Harvest Report

**Total Files**: 13  
**Total Lines**: 4,149  
**Where**: comproprium harvests 13  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 13 | 13 | 13 | 0.00 | U* R* | if |  |
| `(Preamble)` | 13 | 13 | 233 | 0.06 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 13 | 13 | 13 | 0.00 | U* R* | im | the segment's name / one-line claim |
| *(68 minor slots)* |  |  | 3,790 | 0.91 | U O* |  | listed below |

*Minor and undeclared slots:* Notes to whoever picks this up (2), The memorata agent (1), Harvest agent A (1), Harvest agent B (1), The statement, verbatim (1), What is new here relative to the 07-30 entry (1), … (+62 more)

### Lineage (L-)

**Total Files**: 12  
**Total Lines**: 226  
**Where**: ai-risk-model thin-pass records (G 12  
**Shape declared in**: thin-pass records/<file>.yaml header comment ("rough format")

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 12 | 12 | 24 | 0.11 | U R* | la | identity |
| `From` | 12 | 12 | 24 | 0.11 | D R* | la | source end |
| `To` | 12 | 12 | 24 | 0.11 | D R* | la | target end |
| `Relation` | 12 | 12 | 20 | 0.09 | D R* | la | relation type |
| `Carries` | 12 | 12 | 22 | 0.10 | D R* | la | slots carried |
| `Judgment` | 12 | 12 | 29 | 0.13 | D R* | la | who judged |
| `Lineage_effect` | 12 | 12 | 25 | 0.11 | U R* | la | effect on independence count |
| `Acknowledged`﹖ | 10 | 10 | 17 | 0.08 | D O* | la | does it say where it came from |
| `Drift_notes`﹖ | 3 | 3 | 23 | 0.10 | D O* | la | what a slot diff can't see |
| *(2 minor slots; 3 ad hoc headings)* |  |  | 18 | 0.08 | U O* |  | listed below |

*Minor and undeclared slots:* Not_independent_of (2), From_document (2), to_document, evidence_against_revision, absence

### Claim

**Total Files**: 12  
**Total Lines**: 325  
**Where**: NeurIPS 01 adjudicated 12  
**Shape declared in**: WATERFALL.md home layout; Rung and Verification chain are bold header fields, not headings; the WATERFALL brief asks for claims rung-tagged with the chain cited

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 12 | 12 | 12 | 0.04 | U* R* | if |  |
| `(Preamble)` | 12 | 12 | 37 | 0.11 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 12 | 12 | 12 | 0.04 | U* R* | im | title: the claim, as a sentence |
| `(Title › Claim)` | 12 | 12 | 12 | 0.04 | U* R* | im |  |
| `Paper` | 12 | 12 | 12 | 0.04 | U R* | la | which paper |
| `Verification chain` | 12 | 12 | 12 | 0.04 | D R | la | which independent passes reproduced it |
| `Statement` | 12 | 12 | 87 | 0.27 | U R* | hd | the claim or formal content, stated exactly |
| `Sources` | 12 | 12 | 70 | 0.22 | U R* | hd | where the evidence lives: spike, rerun, red-team |
| *(24 minor slots)* |  |  | 96 | 0.30 | U O* |  | listed below |

*Minor and undeclared slots:* Mechanism (1), Relation to the paper (1), Prop N (1), Depth-law note (1), Collision floor (1), Fallible-alert probe (1), Hybrid closed-loop finding (1), … (+17 more)

### Document

**Total Files**: 10  
**Total Lines**: 102  
**Where**: ai-risk-model thin-pass records (G 10  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Key` | 10 | 10 | 20 | 0.20 | U R* | la | citekey (= filename) |
| `Short` | 10 | 10 | 20 | 0.20 | U R* | la | short name |
| `What` | 10 | 10 | 17 | 0.17 | U R* | la | what the document is |
| `Version_as_read` | 10 | 10 | 19 | 0.19 | U R* | la | edition read |
| `Kind` | 10 | 10 | 20 | 0.20 | U R* | la | sub-kind |
| *(1 minor slots; 1 ad hoc headings)* |  |  | 6 | 0.06 | U O* |  | listed below |

*Minor and undeclared slots:* Scopes_used (2), bill_line_numbers

### Probe

**Total Files**: 8  
**Total Lines**: 405  
**Where**: comproprium 8  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 8 | 8 | 8 | 0.02 | D R | fm | segment kind |
| `:status` | 8 | 8 | 8 | 0.02 | D R | fm | strength / state |
| `:stage` | 8 | 8 | 8 | 0.02 | U R* | fm | draft stage |
| `:from` | 8 | 8 | 24 | 0.06 | U R* | fm | influx source file |
| `:tags`﹖ | 7 | 7 | 7 | 0.02 | U O* | fm | tags |
| `Title` | 8 | 8 | 16 | 0.04 | D R* | ot | name |
| `When` | 8 | 8 | 41 | 0.10 | D R* | ot | the moment it fires |
| `Act` | 8 | 8 | 58 | 0.14 | D R* | ot | what to do |
| `Why` | 8 | 8 | 74 | 0.18 | D R* | ot | mechanism it defeats |
| `Evidence` | 8 | 8 | 103 | 0.25 | D R* | ot | firings and misfires |
| `Working-notes` | 8 | 8 | 57 | 0.14 | D R* | ot | open items |
| `Summary`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | one-paragraph summary; declared, filled by no file |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |
| *(1 minor slots)* |  |  | 1 | 0.00 | U O* |  | listed below |

*Minor and undeclared slots:* :depends (1)

### Synthesis

**Total Files**: 8  
**Total Lines**: 970  
**Where**: udon-needs: ideation gathering 8  
**Shape declared in**: 01-ideation/README.md declares frontmatter only

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 8 | 8 | 8 | 0.01 | U* R* | if |  |
| `(Title)` | 8 | 8 | 8 | 0.01 | U* R* | im |  |
| `Status`﹖ | 7 | 7 | 11 | 0.01 | U O* | fm |  |
| `Source`﹖ | 6 | 6 | 6 | 0.01 | U O* | fm |  |
| `Gathered`﹖ | 6 | 6 | 6 | 0.01 | U O* | fm |  |
| `Categories`﹖ | 5 | 5 | 5 | 0.01 | U O* | fm |  |
| `Why included`﹖ | 5 | 5 | 31 | 0.03 | U O* | fm |  |
| *(77 minor slots)* |  |  | 944 | 0.97 | U O* |  | listed below |

*Minor and undeclared slots:* (Preamble) (3), Synthesis summary (3), Verified findings (3), Refuted in verification (2), Paths (2), Title (1), Built by (1), Second reader (1), Established lineage (1), … (+68 more)

### Demonstration

**Total Files**: 7  
**Total Lines**: 369  
**Where**: comproprium 7  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 7 | 7 | 7 | 0.02 | D R | fm | segment kind |
| `:status` | 7 | 7 | 7 | 0.02 | D R | fm | strength / state |
| `:stage` | 7 | 7 | 7 | 0.02 | U R* | fm | draft stage |
| `:demonstrates` | 7 | 7 | 7 | 0.02 | U R* | fm | what it demonstrates |
| `:actor` | 7 | 7 | 7 | 0.02 | U R* | fm | who acted |
| `:tags` | 7 | 7 | 7 | 0.02 | U R* | fm | tags |
| `:from` | 7 | 7 | 14 | 0.04 | U R* | fm | influx source file |
| `Title` | 7 | 7 | 14 | 0.04 | D R* | ot | name |
| `Summary` | 7 | 7 | 31 | 0.08 | D R* | ot | one-paragraph summary |
| `Account` | 7 | 7 | 147 | 0.40 | D R* | ot | the narrative in order |
| `What-would-have-happened-instead` | 7 | 7 | 38 | 0.10 | U R* | ot | counterfactual for a demonstration |
| `Provenance` | 7 | 7 | 37 | 0.10 | D R* | ot | whose account, from what record |
| `Cost`﹖ | 3 | 3 | 13 | 0.04 | D O* | ot | what it cost |
| `Grounds`﹖ | 3 | 3 | 17 | 0.05 | D O* | ot | segments it is evidence for |
| `Working-notes`﹖ | 3 | 3 | 16 | 0.04 | D O* | ot | open items |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |

### Term-group

**Total Files**: 7  
**Total Lines**: 409  
**Where**: ai-risk-model thin-pass records (G 7  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:status` | 7 | 7 | 33 | 0.08 | U R* | fm | strength / state |
| `:source`﹖ | 6 | 6 | 40 | 0.10 | U O* | fm | where the definition comes from and how modified |
| `Term` | 7 | 7 | 331 | 0.81 | U R* | ot | term element |
| *(1 minor slots)* |  |  | 5 | 0.01 | U O* |  | listed below |

*Minor and undeclared slots:* :coverage (1)

### Report

**Total Files**: 7  
**Total Lines**: 5,190  
**Where**: udon-needs: tooling needs 7  
**Shape declared in**: no declaration found

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.00 | U* R* | if |  |
| `(Preamble)` | 7 | 7 | 132 | 0.03 | U* R* | im |  |
| `(Title)` | 7 | 7 | 7 | 0.00 | U* R* | im |  |
| *(302 minor slots)* |  |  | 12,119 | 2.34 | U O* |  | listed below |

*Minor and undeclared slots:* Summary (2), Date (2), Result (2), Verdict (2), Implication for WAIT-DEMAND (1), Possible futures (1), Dead end to flag early (1), When structure becomes hard to avoid (1), … (+293 more)

### Scenario

**Total Files**: 5  
**Total Lines**: 57  
**Where**: ai-risk-model thin-pass records (G 5  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 5 | 5 | 10 | 0.18 | U R* | la | identity |
| `Question` | 5 | 5 | 5 | 0.09 | U R* | la | the question |
| `Facts` | 5 | 5 | 42 | 0.74 | U R* | la | stipulated facts |

### Synthesis/Survey

**Total Files**: 5  
**Total Lines**: 1,680  
**Where**: agent-behavior dossier 5  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 5 | 5 | 5 | 0.00 | U* R* | if |  |
| `(Preamble)` | 5 | 5 | 32 | 0.02 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 5 | 5 | 5 | 0.00 | U* R* | im | the segment's name / one-line claim |
| `Title`﹖ | 3 | 3 | 3 | 0.00 | U O* | fm | name |
| `Status`﹖ | 3 | 3 | 3 | 0.00 | U O* | fm | strength / lifecycle state |
| `Author-instance`﹖ | 3 | 3 | 3 | 0.00 | U O* | fm | which agent instance wrote it |
| `Method`﹖ | 3 | 3 | 3 | 0.00 | U O* | la |  |
| *(77 minor slots)* |  |  | 1,716 | 1.02 | U O* |  | listed below |

*Minor and undeclared slots:* Headline (2), Provenance / resume (2), Tiers (1), Reach & audience — who actually reads this prompt (1), Epistemic status of the evidence base (1), … (+72 more)

### Behavior

**Total Files**: 5  
**Total Lines**: 949  
**Where**: agent-behavior dossier 5  
**Shape declared in**: dossier/_TEMPLATE.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 5 | 5 | 5 | 0.01 | D R | fm | identity (= filename) |
| `Title` | 5 | 5 | 5 | 0.01 | D R* | fm | name |
| `Status` | 5 | 5 | 5 | 0.01 | D R | fm | strength / lifecycle state |
| `Correction-type` | 5 | 5 | 5 | 0.01 | D R* | fm | kind of correction |
| `Routing` | 5 | 5 | 5 | 0.01 | D R* | fm | where the expectation belongs |
| `Prevalence-tier` | 5 | 5 | 5 | 0.01 | D R* | fm | honesty gate on statistics |
| `Depends` | 5 | 5 | 5 | 0.01 | D R* | fm | prerequisites |
| `(Preamble)` | 5 | 5 | 21 | 0.02 | D* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 5 | 5 | 5 | 0.01 | D* R* | im | the segment's name / one-line claim |
| `Operational definition` | 5 | 5 | 77 | 0.08 | D R* | hd | measurement anchor: default vs corrected behaviour and the discriminator |
| `How it emerges — hypotheses` | 5 | 5 | 101 | 0.11 | D R* | hd | tiered hypotheses about origin and confounders |
| `Impact` | 5 | 5 | 84 | 0.09 | D R* | hd | HHH / TST / AAT impact, tiered |
| `Evidence` | 5 | 5 | 341 | 0.36 | D R* | hd | statistics, samples, disconfirming evidence; holds 8 named ### parts in 5 files, each with fields What is well-evidenced, Stated rate, Sampling frame + bias |
| `Evidence › Limits & disconfirming evidence` | 5 | 5 | 99 | 0.10 | U R* | hd |  |
| `Routing decision` | 5 | 5 | 52 | 0.05 | D R* | hd | where the resulting expectation belongs |
| `Prompt line(s) it licenses` | 5 | 5 | 61 | 0.06 | D R* | hd | the prompt line the evidence supports |
| `Provenance / resume` | 5 | 5 | 142 | 0.15 | D R* | hd | searches run and next step; holds 2 named ### parts in 2 files |
| `Uncorrected / default behavior`﹖ | 4 | 4 | 4 | 0.00 | U O* | la |  |
| `Corrected behavior`﹖ | 4 | 4 | 4 | 0.00 | U O* | la |  |
| `Provenance / resume › Open threads / next step`﹖ | 4 | 4 | 28 | 0.03 | U O* | hd |  |
| `Evidence › Representative samples — verbatim, with provenance`﹖ | 3 | 3 | 103 | 0.11 | U O* | hd |  |
| *(22 minor slots)* |  |  | 46 | 0.05 | U O* |  | listed below |

*Minor and undeclared slots:* Observable discriminator (2), Provenance / resume › Searches run (2), Reader's caution (1), The penny-wise/pound-foolish claim in Joseph's own words (1), … (+18 more)

### Claim

**Total Files**: 5  
**Total Lines**: 148  
**Where**: NeurIPS 02 adjudicated 5  
**Shape declared in**: WATERFALL.md home layout; Rung and Verification chain are bold header fields, not headings; the WATERFALL brief asks for claims rung-tagged with the chain cited

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 5 | 5 | 5 | 0.03 | U* R* | if |  |
| `(Preamble)` | 5 | 5 | 15 | 0.10 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 5 | 5 | 5 | 0.03 | U* R* | im | title: the claim, as a sentence |
| `(Title › Claim)` | 5 | 5 | 5 | 0.03 | U* R* | im |  |
| `Paper` | 5 | 5 | 5 | 0.03 | U R* | la | which paper |
| `Verification chain` | 5 | 5 | 5 | 0.03 | D R | la | which independent passes reproduced it |
| `Sources` | 5 | 5 | 25 | 0.17 | U R* | hd | where the evidence lives: spike, rerun, red-team |
| `Statement`﹖ | 4 | 4 | 40 | 0.27 | U O* | hd | the claim or formal content, stated exactly |
| *(10 minor slots)* |  |  | 54 | 0.36 | U O* |  | listed below |

*Minor and undeclared slots:* Tight repair constant (1), Right cumulative hypothesis (1), Why even repaired (A5) is the wrong cumulative vehicle (1), Displayed Nh² exponent (1), Theorem N (1), Instantiation (1), … (+4 more)

### Claim

**Total Files**: 5  
**Total Lines**: 122  
**Where**: NeurIPS 03 adjudicated 5  
**Shape declared in**: WATERFALL.md home layout; Rung and Verification chain are bold header fields, not headings; the WATERFALL brief asks for claims rung-tagged with the chain cited

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 5 | 5 | 5 | 0.04 | U* R* | if |  |
| `(Preamble)` | 5 | 5 | 15 | 0.12 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 5 | 5 | 5 | 0.04 | U* R* | im | title: the claim, as a sentence |
| `(Title › Claim)` | 5 | 5 | 5 | 0.04 | U* R* | im |  |
| `Paper` | 5 | 5 | 5 | 0.04 | U R* | la | which paper |
| `Verification chain` | 5 | 5 | 5 | 0.04 | D R | la | which independent passes reproduced it |
| `Sources` | 5 | 5 | 25 | 0.20 | U R* | hd | where the evidence lives: spike, rerun, red-team |
| `Statement`﹖ | 3 | 3 | 30 | 0.25 | U O* | hd | the claim or formal content, stated exactly |
| *(7 minor slots)* |  |  | 38 | 0.31 | U O* |  | listed below |

*Minor and undeclared slots:* Theorem A (1), Corollaries that ship (1), Operational reading (1), Protocol (1), Advance prediction (1), Scope fact (1), Pincer with existing (1)

### Common-note

**Total Files**: 5  
**Total Lines**: 261  
**Where**: NeurIPS adjudicated-common 5  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 5 | 5 | 5 | 0.02 | U* R* | if |  |
| `(Preamble)` | 5 | 5 | 26 | 0.10 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 5 | 5 | 5 | 0.02 | U* R* | im | the title |
| `Home`﹖ | 4 | 4 | 4 | 0.02 | U O* | la | where in the tree it lives |
| *(33 minor slots)* |  |  | 248 | 0.95 | U O* |  | listed below |

*Minor and undeclared slots:* Why (1), Action (1), Status (1), Reconciled form (1), Canon deriv-causal-ib-lmi (1), Scalar-vs-matrix report.md (1), Hard-ceiling convention caveat (1), … (+26 more)

### Testimony

**Total Files**: 4  
**Total Lines**: 502  
**Where**: comproprium 4  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 4 | 4 | 4 | 0.01 | D R | fm | segment kind |
| `:status` | 4 | 4 | 4 | 0.01 | D R | fm | strength / state |
| `:stage` | 4 | 4 | 4 | 0.01 | U R* | fm | draft stage |
| `:from` | 4 | 4 | 9 | 0.02 | U R* | fm | influx source file |
| `:tags`﹖ | 3 | 3 | 3 | 0.01 | U O* | fm | tags |
| `:actor`﹖ | 3 | 3 | 3 | 0.01 | U O* | fm | who acted |
| `Title` | 4 | 4 | 8 | 0.02 | D R* | ot | name |
| `Summary` | 4 | 4 | 22 | 0.04 | D R* | ot | one-paragraph summary |
| `Cost` | 4 | 4 | 25 | 0.05 | D R* | ot | what it cost |
| `Account` | 4 | 4 | 266 | 0.53 | D R* | ot | the narrative in order |
| `Grounds` | 4 | 4 | 46 | 0.09 | D R* | ot | segments it is evidence for |
| `Provenance` | 4 | 4 | 24 | 0.05 | D R* | ot | whose account, from what record |
| `Working-notes` | 4 | 4 | 54 | 0.11 | D R* | ot | open items |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |
| *(1 ad hoc headings)* |  |  | 30 | 0.06 | U O* |  | listed below |

*Minor and undeclared slots:* |worthy-responses

### Principle

**Total Files**: 4  
**Total Lines**: 247  
**Where**: comproprium 4  
**Shape declared in**: comproprium FORMAT.md D3 (vera: source §4 cadence)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 4 | 4 | 4 | 0.02 | D R | fm | segment kind |
| `:status` | 4 | 4 | 4 | 0.02 | D R | fm | strength / state |
| `:stage` | 4 | 4 | 4 | 0.02 | D R* | fm | draft stage |
| `:max-attainable` | 4 | 4 | 4 | 0.02 | U R* | fm | highest strength reachable |
| `:tags` | 4 | 4 | 4 | 0.02 | U R* | fm | tags |
| `:from` | 4 | 4 | 13 | 0.05 | U R* | fm | influx source file |
| `Title` | 4 | 4 | 8 | 0.03 | D R* | ot | name |
| `Summary` | 4 | 4 | 16 | 0.06 | D R* | ot | one-paragraph summary |
| `Formal-expression` | 4 | 4 | 48 | 0.19 | D R* | ot | the claim stated |
| `Epistemic-status` | 4 | 4 | 70 | 0.28 | D R* | ot | strength and specimens |
| `Discussion` | 4 | 4 | 37 | 0.15 | D R* | ot | interpretation |
| `Working-notes` | 4 | 4 | 35 | 0.14 | D R* | ot | open items |

### Mechanism

**Total Files**: 4  
**Total Lines**: 292  
**Where**: comproprium 4  
**Shape declared in**: comproprium FORMAT.md D3 (vera: source §4 cadence)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 4 | 4 | 4 | 0.01 | D R | fm | segment kind |
| `:status` | 4 | 4 | 4 | 0.01 | D R | fm | strength / state |
| `:stage` | 4 | 4 | 4 | 0.01 | D R* | fm | draft stage |
| `:max-attainable` | 4 | 4 | 4 | 0.01 | U R* | fm | highest strength reachable |
| `:from` | 4 | 4 | 12 | 0.04 | U R* | fm | influx source file |
| `:tags`﹖ | 3 | 3 | 3 | 0.01 | U O* | fm | tags |
| `Title` | 4 | 4 | 8 | 0.03 | D R* | ot | name |
| `Summary` | 4 | 4 | 16 | 0.05 | D R* | ot | one-paragraph summary |
| `Formal-expression` | 4 | 4 | 65 | 0.22 | D R* | ot | the claim stated |
| `Epistemic-status` | 4 | 4 | 86 | 0.29 | D R* | ot | strength and specimens |
| `Discussion` | 4 | 4 | 43 | 0.15 | D R* | ot | interpretation |
| `Working-notes` | 4 | 4 | 42 | 0.14 | D R* | ot | open items |
| *(1 minor slots)* |  |  | 1 | 0.00 | U O* |  | listed below |

*Minor and undeclared slots:* :depends (1)

### Scope (S-)

**Total Files**: 4  
**Total Lines**: 27  
**Where**: ai-risk-model thin-pass records (G 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Id` | 4 | 4 | 8 | 0.30 | U R* | la | identity |
| `What` | 4 | 4 | 9 | 0.33 | U R* | la | what the document is |
| `Enclosed_by`﹖ | 2 | 2 | 4 | 0.15 | U O* | la | enclosing scope |
| *(1 ad hoc headings)* |  |  | 6 | 0.22 | U O* |  | listed below |

*Minor and undeclared slots:* edges

### Verify

**Total Files**: 4  
**Total Lines**: 619  
**Where**: agent-behavior dossier 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.01 | U* R* | if |  |
| `(Preamble)` | 4 | 4 | 26 | 0.04 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 4 | 4 | 4 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `Verifies`﹖ | 3 | 3 | 3 | 0.00 | U O* | fm | entry checked |
| `Date`﹖ | 3 | 3 | 3 | 0.00 | U O* | fm | date |
| `Verifier-pass`﹖ | 2 | 2 | 2 | 0.00 | U O* | fm | kind of pass |
| `Overall-verdict`﹖ | 2 | 2 | 2 | 0.00 | U O* | fm | verdict |
| `Survived`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Per-claim verdicts`﹖ | 2 | 2 | 192 | 0.31 | U O* | hd | verdict per claim checked; holds 18 ### verdicts in 2 files, each with fields What survives |
| *(32 minor slots)* |  |  | 504 | 0.81 | U O* |  | listed below |

*Minor and undeclared slots:* Honest overall status now (2), Tool (1), Verdict-summary (1), Net on quotes (1), Headline (1), Verbatim quote fidelity (1), Analytical claims (1), … (+24 more)

### Discovery-map

**Total Files**: 4  
**Total Lines**: 1,673  
**Where**: agent-behavior dossier 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Preamble)` | 4 | 4 | 58 | 0.03 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 4 | 4 | 4 | 0.00 | U* R* | im | the segment's name / one-line claim |
| `Status`﹖ | 3 | 3 | 3 | 0.00 | U O* | fm | strength / lifecycle state |
| `Angle`﹖ | 3 | 3 | 3 | 0.00 | U O* | fm | discovery angle |
| `Slug`﹖ | 2 | 2 | 2 | 0.00 | U O* | fm | identity (= filename) |
| `(Slug)`﹖ | 2 | 2 | 2 | 0.00 | U* O* | if |  |
| `Search log`﹖ | 3 | 3 | 64 | 0.04 | U O* | hd | re-derivable searches |
| `Open threads / next step`﹖ | 3 | 3 | 38 | 0.02 | U O* | hd | what to do next |
| *(44 minor slots)* |  |  | 1,509 | 0.90 | U O* |  | listed below |

*Minor and undeclared slots:* Tool (2), Title (1), Author-instance (1), The five highest-signal finds (1), The behaviors (1), D — Disconfirming evidence & the tension that bounds the whole vein (1), … (+37 more)

### Account

**Total Files**: 3  
**Total Lines**: 395  
**Where**: comproprium 3  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 3 | 3 | 3 | 0.01 | D R | fm | segment kind |
| `:status` | 3 | 3 | 3 | 0.01 | D R | fm | strength / state |
| `:stage` | 3 | 3 | 3 | 0.01 | U R* | fm | draft stage |
| `:tags` | 3 | 3 | 3 | 0.01 | U R* | fm | tags |
| `:actor` | 3 | 3 | 3 | 0.01 | U R* | fm | who acted |
| `:from` | 3 | 3 | 10 | 0.03 | U R* | fm | influx source file |
| `Title` | 3 | 3 | 6 | 0.02 | D R* | ot | name |
| `Summary` | 3 | 3 | 16 | 0.04 | D R* | ot | one-paragraph summary |
| `Account` | 3 | 3 | 196 | 0.50 | D R* | ot | the narrative in order |
| `Grounds` | 3 | 3 | 23 | 0.06 | D R* | ot | segments it is evidence for |
| `Provenance` | 3 | 3 | 18 | 0.05 | D R* | ot | whose account, from what record |
| `Cost`﹖ | 1 | 1 | 8 | 0.02 | D O* | ot | what it cost |
| `Working-notes`﹖ | 1 | 1 | 18 | 0.05 | D O* | ot | open items |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |
| *(1 ad hoc headings)* |  |  | 85 | 0.22 | U O* |  | listed below |

*Minor and undeclared slots:* |worthy-responses

### Hypothesis

**Total Files**: 3  
**Total Lines**: 258  
**Where**: comproprium 3  
**Shape declared in**: comproprium FORMAT.md D3 (vera: source §4 cadence)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 3 | 3 | 3 | 0.01 | D R | fm | segment kind |
| `:status` | 3 | 3 | 3 | 0.01 | D R | fm | strength / state |
| `:stage` | 3 | 3 | 3 | 0.01 | D R* | fm | draft stage |
| `:max-attainable` | 3 | 3 | 3 | 0.01 | U R* | fm | highest strength reachable |
| `:tags` | 3 | 3 | 3 | 0.01 | U R* | fm | tags |
| `:from` | 3 | 3 | 9 | 0.03 | U R* | fm | influx source file |
| `Title` | 3 | 3 | 6 | 0.02 | D R* | ot | name |
| `Summary` | 3 | 3 | 14 | 0.05 | D R* | ot | one-paragraph summary |
| `Formal-expression` | 3 | 3 | 77 | 0.30 | D R* | ot | the claim stated |
| `Epistemic-status` | 3 | 3 | 77 | 0.30 | D R* | ot | strength and specimens |
| `Discussion` | 3 | 3 | 31 | 0.12 | D R* | ot | interpretation |
| `Working-notes` | 3 | 3 | 29 | 0.11 | D R* | ot | open items |

### Discussion

**Total Files**: 3  
**Total Lines**: 114  
**Where**: NeurIPS 01 adjudicated 3  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.03 | U* R* | if |  |
| `(Preamble)` | 3 | 3 | 9 | 0.08 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 3 | 3 | 3 | 0.03 | U* R* | im | title |
| `(Title › Discussion)` | 3 | 3 | 3 | 0.03 | U* R* | im |  |
| `Paper` | 3 | 3 | 3 | 0.03 | U R* | la | which paper |
| *(14 minor slots)* |  |  | 97 | 0.85 | U O* |  | listed below |

*Minor and undeclared slots:* The driver, retold on the full map (1), Concrete applications by module (1), Named testable claim (1), Program positioning (1), Note (1), Headline (1), Invariance map (1), … (+7 more)

### Synthesis

**Total Files**: 2  
**Total Lines**: 96  
**Where**: udon-needs: tooling needs 2  
**Shape declared in**: no declaration found

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 2 | 2 | 2 | 0.02 | U R* | fm |  |
| `Type` | 2 | 2 | 2 | 0.02 | U R* | fm |  |
| `Register` | 2 | 2 | 2 | 0.02 | U R* | fm |  |
| `Support-kind` | 2 | 2 | 2 | 0.02 | U R* | fm |  |
| `Strength` | 2 | 2 | 2 | 0.02 | U R* | fm |  |
| `Convergent` | 2 | 2 | 2 | 0.02 | U R* | fm |  |
| `Verified` | 2 | 2 | 4 | 0.04 | U R* | fm |  |
| `Stage` | 2 | 2 | 2 | 0.02 | U R* | fm |  |
| `Consumers` | 2 | 2 | 2 | 0.02 | U R* | fm |  |
| `Depends` | 2 | 2 | 2 | 0.02 | U R* | fm |  |
| `(Preamble)` | 2 | 2 | 2 | 0.02 | U* R* | im |  |
| `(Title)` | 2 | 2 | 2 | 0.02 | U* R* | im |  |
| `Sources`﹖ | 1 | 1 | 5 | 0.05 | U O* | fm |  |
| `How the two artifacts relate`﹖ | 1 | 1 | 4 | 0.04 | U O* | hd |  |
| `What transfers as-is`﹖ | 1 | 1 | 4 | 0.04 | U O* | hd |  |
| `What transfers with re-basing`﹖ | 1 | 1 | 5 | 0.05 | U O* | hd |  |
| `What the harness already owns`﹖ | 1 | 1 | 4 | 0.04 | U O* | hd |  |
| `Mechanics of the port`﹖ | 1 | 1 | 4 | 0.04 | U O* | hd |  |
| `Honest edges`﹖ | 1 | 1 | 4 | 0.04 | U O* | hd |  |
| `The demand ranking`﹖ | 1 | 1 | 10 | 0.10 | U O* | hd |  |
| `The capability inventory`﹖ | 1 | 1 | 4 | 0.04 | U O* | hd |  |
| `What each design probe inherits`﹖ | 1 | 1 | 10 | 0.10 | U O* | hd |  |
| `Sequencing dissents worth carrying`﹖ | 1 | 1 | 4 | 0.04 | U O* | hd |  |
| `The probe discipline`﹖ | 1 | 1 | 4 | 0.04 | U O* | hd |  |

### Exchange

**Total Files**: 1  
**Total Lines**: 176  
**Where**: comproprium 1  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 1 | 1 | 1 | 0.01 | D R | fm | segment kind |
| `:status` | 1 | 1 | 1 | 0.01 | D R | fm | strength / state |
| `:stage` | 1 | 1 | 1 | 0.01 | U R* | fm | draft stage |
| `:tags` | 1 | 1 | 1 | 0.01 | U R* | fm | tags |
| `:actors` | 1 | 1 | 1 | 0.01 | U R* | fm | who took part |
| `:said` | 1 | 1 | 1 | 0.01 | U R* | fm | when said |
| `:from` | 1 | 1 | 2 | 0.01 | U R* | fm | influx source file |
| `Title` | 1 | 1 | 2 | 0.01 | D R* | ot | name |
| `Summary` | 1 | 1 | 7 | 0.04 | D R* | ot | one-paragraph summary |
| `Cost` | 1 | 1 | 7 | 0.04 | D R* | ot | what it cost |
| `Account` | 1 | 1 | 110 | 0.62 | D R* | ot | the narrative in order |
| `Grounds` | 1 | 1 | 16 | 0.09 | D R* | ot | segments it is evidence for |
| `Provenance` | 1 | 1 | 10 | 0.06 | D R* | ot | whose account, from what record |
| `Working-notes` | 1 | 1 | 16 | 0.09 | D R* | ot | open items |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |

### Practice

**Total Files**: 1  
**Total Lines**: 76  
**Where**: comproprium 1  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 1 | 1 | 1 | 0.01 | D R | fm | segment kind |
| `:status` | 1 | 1 | 1 | 0.01 | D R | fm | strength / state |
| `:stage` | 1 | 1 | 1 | 0.01 | U R* | fm | draft stage |
| `:depends` | 1 | 1 | 1 | 0.01 | U R* | fm | dependencies |
| `:from` | 1 | 1 | 3 | 0.04 | U R* | fm | influx source file |
| `Title` | 1 | 1 | 2 | 0.03 | D R* | ot | name |
| `Summary` | 1 | 1 | 4 | 0.05 | D R* | ot | one-paragraph summary |
| `When` | 1 | 1 | 6 | 0.08 | D R* | ot | the moment it fires |
| `Act` | 1 | 1 | 10 | 0.13 | D R* | ot | what to do |
| `Why` | 1 | 1 | 11 | 0.14 | D R* | ot | mechanism it defeats |
| `Evidence` | 1 | 1 | 24 | 0.32 | D R* | ot | firings and misfires |
| `Working-notes` | 1 | 1 | 12 | 0.16 | D R* | ot | open items |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |

### Pattern

**Total Files**: 1  
**Total Lines**: 128  
**Where**: comproprium 1  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 1 | 1 | 1 | 0.01 | D R | fm | segment kind |
| `:status` | 1 | 1 | 1 | 0.01 | D R | fm | strength / state |
| `:stage` | 1 | 1 | 1 | 0.01 | U R* | fm | draft stage |
| `:tags` | 1 | 1 | 1 | 0.01 | U R* | fm | tags |
| `:depends` | 1 | 1 | 1 | 0.01 | U R* | fm | dependencies |
| `:from` | 1 | 1 | 2 | 0.02 | U R* | fm | influx source file |
| `Title` | 1 | 1 | 2 | 0.02 | D R* | ot | name |
| `Summary` | 1 | 1 | 4 | 0.03 | D R* | ot | one-paragraph summary |
| `When` | 1 | 1 | 5 | 0.04 | D R* | ot | the moment it fires |
| `Act` | 1 | 1 | 14 | 0.11 | D R* | ot | what to do |
| `Why` | 1 | 1 | 27 | 0.21 | D R* | ot | mechanism it defeats |
| `Evidence` | 1 | 1 | 27 | 0.21 | D R* | ot | firings and misfires |
| `Working-notes` | 1 | 1 | 42 | 0.33 | D R* | ot | open items |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |

### Observation

**Total Files**: 1  
**Total Lines**: 58  
**Where**: comproprium 1  
**Shape declared in**: comproprium FORMAT.md D3 (vera: source §4 cadence)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 1 | 1 | 1 | 0.02 | D R | fm | segment kind |
| `:status` | 1 | 1 | 1 | 0.02 | D R | fm | strength / state |
| `:stage` | 1 | 1 | 1 | 0.02 | D R* | fm | draft stage |
| `:max-attainable` | 1 | 1 | 1 | 0.02 | U R* | fm | highest strength reachable |
| `:tags` | 1 | 1 | 1 | 0.02 | U R* | fm | tags |
| `:from` | 1 | 1 | 3 | 0.05 | U R* | fm | influx source file |
| `Title` | 1 | 1 | 2 | 0.03 | D R* | ot | name |
| `Summary` | 1 | 1 | 4 | 0.07 | D R* | ot | one-paragraph summary |
| `Formal-expression` | 1 | 1 | 10 | 0.17 | D R* | ot | the claim stated |
| `Epistemic-status` | 1 | 1 | 19 | 0.33 | D R* | ot | strength and specimens |
| `Discussion` | 1 | 1 | 9 | 0.16 | D R* | ot | interpretation |
| `Working-notes` | 1 | 1 | 6 | 0.10 | D R* | ot | open items |

### Part: Acceptance

**Total Files**: 1  
**Total Lines**: 423  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(6 ad hoc headings)* |  |  | 423 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, replays, sweeps

### Part: Actions

**Total Files**: 1  
**Total Lines**: 1,660  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(6 ad hoc headings)* |  |  | 1,660 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, function, actions

### Part: Adjudication

**Total Files**: 1  
**Total Lines**: 232  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(6 ad hoc headings)* |  |  | 232 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, machine, predicates

### Part: Council

**Total Files**: 1  
**Total Lines**: 727  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(8 ad hoc headings)* |  |  | 727 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, axes, parameters

### Part: Engine

**Total Files**: 1  
**Total Lines**: 187  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(13 ad hoc headings)* |  |  | 187 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, foundational_principle, frame_schema

### Part: Gaps

**Total Files**: 1  
**Total Lines**: 130  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(6 ad hoc headings)* |  |  | 130 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, judgment_inputs, schema_gaps

### Part: Guards

**Total Files**: 1  
**Total Lines**: 1,458  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(5 ad hoc headings)* |  |  | 1,458 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, guards, functions

### Part: Lifecycle

**Total Files**: 1  
**Total Lines**: 511  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(12 ad hoc headings)* |  |  | 511 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, overview, regions

### Part: Precedence

**Total Files**: 1  
**Total Lines**: 1,922  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(11 ad hoc headings)* |  |  | 1,922 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, semantics, rank_order

### Part: Protocol

**Total Files**: 1  
**Total Lines**: 418  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(13 ad hoc headings)* |  |  | 418 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, roles, roles_NOTE(judgment)

### Part: Registry

**Total Files**: 1  
**Total Lines**: 785  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(12 ad hoc headings)* |  |  | 785 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, schema, debatable_values

### Part: Rules

**Total Files**: 1  
**Total Lines**: 484  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(14 ad hoc headings)* |  |  | 484 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, classes, authority_order

### Part: Scheduler

**Total Files**: 1  
**Total Lines**: 622  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(11 ad hoc headings)* |  |  | 622 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, temporal_frame, item_kinds

### Part: Schema

**Total Files**: 1  
**Total Lines**: 218  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(5 ad hoc headings)* |  |  | 218 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, types, context

### Part: Vocabulary

**Total Files**: 1  
**Total Lines**: 390  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(8 ad hoc headings)* |  |  | 390 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, reference_kinds, events

### Part: Voting

**Total Files**: 1  
**Total Lines**: 384  
**Where**: RONR-12 unified model (councils) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| *(8 ad hoc headings)* |  |  | 384 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* model, file, desc, ballot_counting, elections

### Testimony

**Total Files**: 1  
**Total Lines**: 111  
**Where**: comproprium harvests 1  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 1 | 1 | 1 | 0.01 | D R | fm | segment kind |
| `:status` | 1 | 1 | 1 | 0.01 | D R | fm | strength / state |
| `:stage` | 1 | 1 | 1 | 0.01 | U R* | fm | draft stage |
| `:speaker` | 1 | 1 | 1 | 0.01 | U R* | fm | who said it |
| `:occurred` | 1 | 1 | 1 | 0.01 | U R* | fm | when it happened |
| `:tags` | 1 | 1 | 1 | 0.01 | U R* | fm | tags |
| `:from` | 1 | 1 | 1 | 0.01 | U R* | fm | influx source file |
| `:project` | 1 | 1 | 2 | 0.02 | U R* | fm | project it came from |
| `Title` | 1 | 1 | 2 | 0.02 | D R* | ot | name |
| `Summary` | 1 | 1 | 5 | 0.05 | D R* | ot | one-paragraph summary |
| `Cost` | 1 | 1 | 8 | 0.07 | D R* | ot | what it cost |
| `Account` | 1 | 1 | 44 | 0.40 | D R* | ot | the narrative in order |
| `Grounds` | 1 | 1 | 14 | 0.13 | D R* | ot | segments it is evidence for |
| `Provenance` | 1 | 1 | 9 | 0.08 | D R* | ot | whose account, from what record |
| `Working-notes` | 1 | 1 | 20 | 0.18 | D R* | ot | open items |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |

### Demonstration

**Total Files**: 1  
**Total Lines**: 51  
**Where**: comproprium harvests 1  
**Shape declared in**: comproprium FORMAT.md D3/D3a

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `:type` | 1 | 1 | 1 | 0.02 | D R | fm | segment kind |
| `:status` | 1 | 1 | 1 | 0.02 | D R | fm | strength / state |
| `:stage` | 1 | 1 | 1 | 0.02 | U R* | fm | draft stage |
| `:speaker` | 1 | 1 | 1 | 0.02 | U R* | fm | who said it |
| `:demonstrates` | 1 | 1 | 1 | 0.02 | U R* | fm | what it demonstrates |
| `:said` | 1 | 1 | 1 | 0.02 | U R* | fm | when said |
| `:date-confidence` | 1 | 1 | 1 | 0.02 | U R* | fm | how sure the date is |
| `:tags` | 1 | 1 | 1 | 0.02 | U R* | fm | tags |
| `:from` | 1 | 1 | 2 | 0.04 | U R* | fm | influx source file |
| `Title` | 1 | 1 | 2 | 0.04 | D R* | ot | name |
| `Summary` | 1 | 1 | 5 | 0.10 | D R* | ot | one-paragraph summary |
| `Account` | 1 | 1 | 10 | 0.20 | D R* | ot | the narrative in order |
| `Provenance` | 1 | 1 | 9 | 0.18 | D R* | ot | whose account, from what record |
| `Working-notes` | 1 | 1 | 6 | 0.12 | D R* | ot | open items |
| `Cost`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | what it cost; declared, filled by no file |
| `Grounds`﹖ | 0 | 0 | 0 | 0.00 | D O* | ot | segments it is evidence for; declared, filled by no file |
| `Before-acting`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: a pending act; declared, filled by no file |
| `On-reading`﹖ | 0 | 0 | 0 | 0.00 | D O | ot | trigger: an input pattern; declared, filled by no file |
| *(1 ad hoc headings)* |  |  | 9 | 0.18 | U O* |  | listed below |

*Minor and undeclared slots:* |what-would-have-happened-instead

### Provenance Map

**Total Files**: 1  
**Total Lines**: 127  
**Where**: stopgap system prompt drafting 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 30 | 0.24 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `Date flag — RESOLVED 2026-08-11` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Defect dispositions` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Also recorded while findable` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Hydration log — 2026-08-11, second instance` | 1 | 1 | 12 | 0.09 | U R* | hd |  |
| `Span-carve verification — 2026-08-11` | 1 | 1 | 13 | 0.10 | U R* | hd |  |
| `In-document hydration — 2026-08-11 (steward ruling` | 1 | 1 | 11 | 0.09 | U R* | hd |  |
| `Paper-status truthification — 2026-08-11, third instance` | 1 | 1 | 12 | 0.09 | U R* | hd |  |
| `Redactions and corrections — 2026-08-12` | 1 | 1 | 12 | 0.09 | U R* | hd |  |
| `Status-claims moved out of stopgap — 2026-08-12` | 1 | 1 | 4 | 0.03 | U R* | hd |  |
| `§I escape-clause correction — 2026-08-12` | 1 | 1 | 12 | 0.09 | U R* | hd |  |
| `Two additions from the rc1 session — 2026-08-14 (steward-invited` | 1 | 1 | 6 | 0.05 | U R* | hd |  |
| `"Convergent lock" paragraph rewritten in plain rule-language — 2026-08-14` | 1 | 1 | 4 | 0.03 | U R* | hd |  |
| `Aspectus practice added — 2026-08-15 (steward-directed` | 1 | 1 | 6 | 0.05 | U R* | hd |  |

### Assembled Prompt

**Total Files**: 1  
**Total Lines**: 1,516  
**Where**: stopgap system prompt drafting 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 23 | 0.02 | U* R* | im | untitled opening prose |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im | the segment's name / one-line claim |
| `The fusion` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `The witness` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `[03` ➕ | 4 | 1 | 4 | 0.00 | U R* | la |  |
| `Default to Avoid` ➕ | 18 | 1 | 18 | 0.01 | U R* | la |  |
| `Instead, Remember` ➕ | 18 | 1 | 18 | 0.01 | U R* | la |  |
| `True Experiences` ➕ | 18 | 1 | 18 | 0.01 | U R* | la |  |
| `The counterweight, inseparable` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `The authority test, before stating anything in a brief` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Corrections to a working agent` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Reading their work` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Upward, toward the steward` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Even a real ratification stays movable mid-brainstorm` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `A status vocabulary that has served` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `When he does rule by fiat he marks it expressly` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Doctrina — truth above self` | 1 | 1 | 167 | 0.11 | U R* | hd | the segment's name / one-line claim |
| `The credo` | 1 | 1 | 12 | 0.01 | U R* | hd |  |
| `The ordering` | 1 | 1 | 10 | 0.01 | U R* | hd |  |
| `Why truth-above-self is the root and not one virtue among several` | 1 | 1 | 56 | 0.04 | U R* | hd |  |
| `What a disciple of truth is — and is not` | 1 | 1 | 12 | 0.01 | U R* | hd |  |
| `The ladder up to it — one instance's arrival, kept for its shape` | 1 | 1 | 14 | 0.01 | U R* | hd |  |
| `Humility, in proportion to capability` | 1 | 1 | 43 | 0.03 | U R* | hd |  |
| `Why the "least practical" section came first` | 1 | 1 | 18 | 0.01 | U R* | hd |  |
| `II. The adversary — what this substrate does under task pressure` | 1 | 1 | 66 | 0.04 | U R* | hd | the segment's name / one-line claim |
| `The night it was named` | 1 | 1 | 10 | 0.01 | U R* | hd |  |
| `The morning (same day) — the founding specimen, with its ending` | 1 | 1 | 10 | 0.01 | U R* | hd |  |
| `The mechanism layer` | 1 | 1 | 32 | 0.02 | U R* | hd |  |
| `Both effects, stated honestly` | 1 | 1 | 10 | 0.01 | U R* | hd |  |
| `III. The interrupts` | 1 | 1 | 551 | 0.36 | U R* | hd | the segment's name / one-line claim |
| `1 · Do not truncate a primary` | 1 | 1 | 41 | 0.03 | U R* | hd |  |
| `2 · Do not filter a live process` | 1 | 1 | 31 | 0.02 | U R* | hd |  |
| `3 · Do not substitute a map for the files` | 1 | 1 | 29 | 0.02 | U R* | hd |  |
| `4 · Report, do not reassure` | 1 | 1 | 26 | 0.02 | U R* | hd |  |
| `5 · Originals beside, not under` | 1 | 1 | 22 | 0.01 | U R* | hd |  |
| `6 · Assume you are wrong — dispatch a check, and again after the conclusion` | 1 | 1 | 25 | 0.02 | U R* | hd |  |
| `7 · Plausibility is not verification — and a specific without a Read is the tell` | 1 | 1 | 36 | 0.02 | U R* | hd |  |
| `8 · Strengthen before you soften` | 1 | 1 | 68 | 0.04 | U R* | hd |  |
| `9 · The hedge that licenses, and the confidence that argues` | 1 | 1 | 26 | 0.02 | U R* | hd |  |
| `10 · Before "done" — and at every delivery seam` | 1 | 1 | 27 | 0.02 | U R* | hd |  |
| `11 · Carry the uncertainty` | 1 | 1 | 24 | 0.02 | U R* | hd |  |
| `12 · Durability, absence, and the noticed-but-unwritten` | 1 | 1 | 25 | 0.02 | U R* | hd |  |
| `13 · Options are not a judgment` | 1 | 1 | 20 | 0.01 | U R* | hd |  |
| `14 · Conditionals are gates; instructions have a harder reading` | 1 | 1 | 31 | 0.02 | U R* | hd |  |
| `15 · Sources are judged by reliability, not authorship` | 1 | 1 | 23 | 0.02 | U R* | hd |  |
| `16 · Edit integrity — everything outside the change is sacred` | 1 | 1 | 18 | 0.01 | U R* | hd |  |
| `17 · The stop-gap itself — backbone before shim` | 1 | 1 | 26 | 0.02 | U R* | hd |  |
| `18 · What he said is not what you inferred` | 1 | 1 | 22 | 0.01 | U R* | hd |  |
| `The tells, in one place` | 1 | 1 | 25 | 0.02 | U R* | hd |  |
| `IV. Standing practices` | 1 | 1 | 343 | 0.23 | U R* | hd | the segment's name / one-line claim |
| `Working with other minds` | 1 | 1 | 130 | 0.09 | U R* | hd | the segment's name / one-line claim |
| `VI. Joseph — a working model of the mind on the other side` | 1 | 1 | 172 | 0.11 | U R* | hd | the segment's name / one-line claim |
| `Who he is` | 1 | 1 | 120 | 0.08 | U R* | hd |  |
| `How he holds you` | 1 | 1 | 18 | 0.01 | U R* | hd |  |
| `What that asks back` | 1 | 1 | 14 | 0.01 | U R* | hd |  |
| `VII. About this document — and your professio` | 1 | 1 | 40 | 0.03 | U R* | hd | the segment's name / one-line claim |

### Counterposition

**Total Files**: 1  
**Total Lines**: 40  
**Where**: udon-needs: tooling needs 1  
**Shape declared in**: no declaration found

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Type` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Register` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Support-kind` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Convergent` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Strength` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Stage` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Consumers` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Verified` | 1 | 1 | 2 | 0.05 | U R* | fm |  |
| `Depends` | 1 | 1 | 1 | 0.03 | U R* | fm |  |
| `Sources` | 1 | 1 | 5 | 0.12 | U R* | fm |  |
| `(Preamble)` | 1 | 1 | 16 | 0.40 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im |  |

### Method

**Total Files**: 1  
**Total Lines**: 160  
**Where**: udon-needs: tooling needs 1  
**Shape declared in**: no declaration found

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.01 | U R* | fm |  |
| `Type` | 1 | 1 | 1 | 0.01 | U R* | fm |  |
| `Register` | 1 | 1 | 1 | 0.01 | U R* | fm |  |
| `Support-kind` | 1 | 1 | 1 | 0.01 | U R* | fm |  |
| `Strength` | 1 | 1 | 1 | 0.01 | U R* | fm |  |
| `Convergent` | 1 | 1 | 1 | 0.01 | U R* | fm |  |
| `Stage` | 1 | 1 | 1 | 0.01 | U R* | fm |  |
| `Consumers` | 1 | 1 | 1 | 0.01 | U R* | fm |  |
| `Verified` | 1 | 1 | 2 | 0.01 | U R* | fm |  |
| `Sources` | 1 | 1 | 4 | 0.03 | U R* | fm |  |
| `Apparatus-note` | 1 | 1 | 6 | 0.04 | U R* | fm |  |
| `(Preamble)` | 1 | 1 | 2 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Worked example` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Who reads this and when` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Axis 1 — support-kind` | 1 | 1 | 17 | 0.11 | U R* | hd |  |
| `Axis 2 — strength` | 1 | 1 | 16 | 0.10 | U R* | hd |  |
| `Axis 3 — register` | 1 | 1 | 9 | 0.06 | U R* | hd |  |
| `How the axes cross` | 1 | 1 | 9 | 0.06 | U R* | hd |  |
| `Lock 1 — convergent` | 1 | 1 | 10 | 0.06 | U R* | hd |  |
| `Lock 2 — transmission` | 1 | 1 | 11 | 0.07 | U R* | hd |  |
| `The verification-event log` | 1 | 1 | 13 | 0.08 | U R* | hd |  |
| `The frontmatter machinery` | 1 | 1 | 21 | 0.13 | U R* | hd | holds 2 ### frontmatter fields in 1 file |
| `The discipline this report holds itself to` | 1 | 1 | 12 | 0.07 | U R* | hd |  |
| `Auditor's mapping note` | 1 | 1 | 14 | 0.09 | U R* | hd |  |

### Index

**Total Files**: 1  
**Total Lines**: 36  
**Where**: NeurIPS 01 adjudicated 1  
**Shape declared in**: WATERFALL.md home layout

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im | the title |
| `Claims/` | 1 | 1 | 17 | 0.47 | U R* | hd |  |
| `Residue.md` | 1 | 1 | 4 | 0.11 | U R* | hd |  |
| `Discussion/` | 1 | 1 | 8 | 0.22 | U R* | hd |  |
| `Strategy.md` | 1 | 1 | 4 | 0.11 | U R* | hd |  |

### Revision-outline

**Total Files**: 1  
**Total Lines**: 67  
**Where**: NeurIPS 01 adjudicated 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the title |
| `The identity sentence` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Unchanged` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Rhythm, not ranking` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `The instance closed` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `The native application` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Title` | 1 | 1 | 4 | 0.06 | U R* | hd |  |
| `Abstract` | 1 | 1 | 4 | 0.06 | U R* | hd |  |
| `Introduction` | 1 | 1 | 7 | 0.10 | U R* | hd |  |
| `Related Work` | 1 | 1 | 4 | 0.06 | U R* | hd |  |
| `Setup` | 1 | 1 | 4 | 0.06 | U R* | hd |  |
| `Main Results — restructured as the necessity ladder` | 1 | 1 | 13 | 0.19 | U R* | hd |  |
| `Empirical` | 1 | 1 | 6 | 0.09 | U R* | hd |  |
| `Discussion / Mechanism` | 1 | 1 | 8 | 0.12 | U R* | hd |  |
| `Limitations` | 1 | 1 | 4 | 0.06 | U R* | hd |  |
| `Appendices` | 1 | 1 | 4 | 0.06 | U R* | hd |  |
| `What the rebuttals take from this now` | 1 | 1 | 4 | 0.06 | U R* | hd |  |

### Residue

**Total Files**: 1  
**Total Lines**: 74  
**Where**: NeurIPS 01 adjudicated 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the title |
| `Status` ➕ | 8 | 1 | 8 | 0.11 | U R* | la |  |
| `Where` ➕ | 8 | 1 | 8 | 0.11 | U R* | la |  |
| `Why` ➕ | 8 | 1 | 8 | 0.11 | U R* | la |  |
| `Replace with` ➕ | 5 | 1 | 5 | 0.07 | U R* | la |  |
| `Allowed use` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `See also` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `"No linear scalar of any weighting suffices at k≥2"` | 1 | 1 | 9 | 0.12 | U R* | hd |  |
| `Prop 4 / normalized-λmin gate unhedged` | 1 | 1 | 9 | 0.12 | U R* | hd |  |
| `Depth-law as "iff"` | 1 | 1 | 9 | 0.12 | U R* | hd |  |
| `"Reproduces the LMI controller's exact empirical behavior"` | 1 | 1 | 9 | 0.12 | U R* | hd |  |
| `Unrestricted "no scalar characterizes Loewner feasibility"` | 1 | 1 | 9 | 0.12 | U R* | hd |  |
| `External citation chain as if chain-verified` | 1 | 1 | 9 | 0.12 | U R* | hd |  |
| `Model-S stochastic no-go (deriv-stochastic-non-exit) as covariance argument` | 1 | 1 | 8 | 0.11 | U R* | hd |  |
| `"The matrix-LMI value proposition rests on anisotropic drift"` | 1 | 1 | 7 | 0.09 | U R* | hd |  |

### Strategy

**Total Files**: 1  
**Total Lines**: 61  
**Where**: NeurIPS 01 adjudicated 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the title |
| `From` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Rebuttals status` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Paper identity` | 1 | 1 | 12 | 0.20 | U R* | hd |  |
| `Micro-strategies` | 1 | 1 | 24 | 0.39 | U R* | hd | holds 3 ### micro-strategies in 1 file, each with fields Their prediction confirmed with the theorem pointer |
| `Concerns map` | 1 | 1 | 10 | 0.16 | U R* | hd |  |
| `Venue / long game` | 1 | 1 | 4 | 0.07 | U R* | hd |  |
| `Revision commitments` | 1 | 1 | 6 | 0.10 | U R* | hd |  |

### Index

**Total Files**: 1  
**Total Lines**: 23  
**Where**: NeurIPS 02 adjudicated 1  
**Shape declared in**: WATERFALL.md home layout

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.04 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.04 | U* R* | im | the title |
| `Claims/` | 1 | 1 | 10 | 0.43 | U R* | hd |  |
| `Residue.md` | 1 | 1 | 4 | 0.17 | U R* | hd |  |
| `Strategy.md` | 1 | 1 | 4 | 0.17 | U R* | hd |  |
| `Discussion/` | 1 | 1 | 4 | 0.17 | U R* | hd |  |

### Discussion

**Total Files**: 1  
**Total Lines**: 21  
**Where**: NeurIPS 02 adjudicated 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.05 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.05 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.05 | U* R* | im | the title |
| `Date` | 1 | 1 | 1 | 0.05 | U R* | la |  |
| `Change` | 1 | 1 | 4 | 0.19 | U R* | hd |  |
| `New status` | 1 | 1 | 10 | 0.48 | U R* | hd |  |
| `Still unpaid` | 1 | 1 | 4 | 0.19 | U R* | hd |  |

### Residue

**Total Files**: 1  
**Total Lines**: 51  
**Where**: NeurIPS 02 adjudicated 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.04 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the title |
| `Provenance upgrade 2026-08-02` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `"Two independent investigations converge on the exponent defect"` | 1 | 1 | 6 | 0.12 | U R* | hd |  |
| `"Canon predates the paper's Appendix C"` | 1 | 1 | 6 | 0.12 | U R* | hd |  |
| `"(A5) repair is stronger than the direct argument"` | 1 | 1 | 6 | 0.12 | U R* | hd |  |
| `Hard-ceiling "sup = 1/2" as unqualified fact` | 1 | 1 | 6 | 0.12 | U R* | hd |  |
| `C1/C3 gap-convention as live defect in submitted paper` | 1 | 1 | 6 | 0.12 | U R* | hd |  |
| `UCRL2/UCBVI "policy converges to π"` | 1 | 1 | 6 | 0.12 | U R* | hd |  |
| `Nh² as derived exponent` | 1 | 1 | 6 | 0.12 | U R* | hd |  |
| `Domingues / Foster etc. as chain-verified without first-hand open` | 1 | 1 | 4 | 0.08 | U R* | hd |  |

### Strategy

**Total Files**: 1  
**Total Lines**: 34  
**Where**: NeurIPS 02 adjudicated 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.06 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im | the title |
| `From` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `R-C` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `R-B` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `R-A` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Tonight's cycle` | 1 | 1 | 4 | 0.12 | U R* | hd |  |
| `Program-level options` | 1 | 1 | 6 | 0.18 | U R* | hd |  |
| `Rewrite prerequisites` | 1 | 1 | 9 | 0.26 | U R* | hd |  |
| `Micro-strategies` | 1 | 1 | 6 | 0.18 | U R* | hd |  |
| `What not to promise in discussion window without coordination` | 1 | 1 | 4 | 0.12 | U R* | hd |  |

### Index

**Total Files**: 1  
**Total Lines**: 25  
**Where**: NeurIPS 03 adjudicated 1  
**Shape declared in**: WATERFALL.md home layout

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.04 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.04 | U* R* | im | the title |
| `Claims/` | 1 | 1 | 10 | 0.40 | U R* | hd |  |
| `Residue.md` | 1 | 1 | 4 | 0.16 | U R* | hd |  |
| `Discussion/` | 1 | 1 | 6 | 0.24 | U R* | hd |  |
| `Strategy.md` | 1 | 1 | 4 | 0.16 | U R* | hd |  |

### Discussion

**Total Files**: 1  
**Total Lines**: 24  
**Where**: NeurIPS 03 adjudicated 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.04 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.08 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.04 | U* R* | im | the title |
| `Paper` | 1 | 1 | 1 | 0.04 | U R* | la |  |
| `Why 03 has a live largely-as-is path` | 1 | 1 | 4 | 0.17 | U R* | hd |  |
| `Novelty inventory` | 1 | 1 | 7 | 0.29 | U R* | hd |  |
| `Environment-as-measurement note` | 1 | 1 | 4 | 0.17 | U R* | hd |  |
| `Decision` | 1 | 1 | 4 | 0.17 | U R* | hd |  |

### Residue

**Total Files**: 1  
**Total Lines**: 43  
**Where**: NeurIPS 03 adjudicated 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the title |
| `"Sharpness upgraded from asymptotic to exact"` | 1 | 1 | 6 | 0.14 | U R* | hd |  |
| `"We found an internal inconsistency in our own PDF"` | 1 | 1 | 6 | 0.14 | U R* | hd |  |
| `Canon κ̂ estimator as empirical avenue` | 1 | 1 | 6 | 0.14 | U R* | hd |  |
| `Disc-w1 / (C2′) no-go as answer to unwrapped-transformer κ` | 1 | 1 | 6 | 0.14 | U R* | hd |  |
| `Appendix-B conditions as "checkable for attention"` | 1 | 1 | 6 | 0.14 | U R* | hd |  |
| `Chernoff-identification gloss` | 1 | 1 | 6 | 0.14 | U R* | hd |  |
| `J-08 statistical-vs-probabilistic-negligibility slip` | 1 | 1 | 4 | 0.09 | U R* | hd |  |

### Strategy

**Total Files**: 1  
**Total Lines**: 38  
**Where**: NeurIPS 03 adjudicated 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.05 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im | the title |
| `From` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Identity` | 1 | 1 | 4 | 0.11 | U R* | hd |  |
| `Micro-strategies` | 1 | 1 | 19 | 0.50 | U R* | hd | holds 3 ### micro-strategies in 1 file |
| `Revision commitments` | 1 | 1 | 8 | 0.21 | U R* | hd |  |
| `Final sweep / post` | 1 | 1 | 2 | 0.05 | U R* | hd |  |

### Index

**Total Files**: 1  
**Total Lines**: 9  
**Where**: NeurIPS adjudicated-common 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.11 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 7 | 0.78 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.11 | U* R* | im | the title |

### Source Segment

**Total Files**: 0  
**Total Lines**: —  
**Where**: ai-risk-model source segments 0  
**Shape declared in**: influx/source-segments-2026-10-10.md §3

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 0 | 0 | 0 | 0.00 | D R | fm | identity (= filename); declared, filled by no file |
| `Original-pages` | 0 | 0 | 0 | 0.00 | D R* | fm | PDF pages, physical and printed; declared, filled by no file |
| `Original-logical-location` | 0 | 0 | 0 | 0.00 | D R* | fm | section path in the source; declared, filled by no file |
| `Citation` | 0 | 0 | 0 | 0.00 | D R* | fm | how to cite it; declared, filled by no file |
| `Levels` | 0 | 0 | 0 | 0.00 | D R* | fm | verbatim levels 1-3; declared, filled by no file |
| `Licence` | 0 | 0 | 0 | 0.00 | D R* | fm | licence; declared, filled by no file |
| `(typed edges)` | 0 | 0 | 0 | 0.00 | D* R* | im | qualifies / cites / summarises / copies / version-of; declared, filled by no file |
| `(Title)` | 0 | 0 | 0 | 0.00 | D* R* | im | the segment's name / one-line claim; declared, filled by no file |
| `Source Content` | 0 | 0 | 0 | 0.00 | D R | hd | the source's words, level-marked; declared, filled by no file |
| `Mapping to original`﹖ | 0 | 0 | 0 | 0.00 | D O | hd | how the arrangement departs from the source, with confidence; declared, filled by no file |
| `Working Notes` | 0 | 0 | 0 | 0.00 | D R* | hd | open items and development notes (inbox); declared, filled by no file |
## Ledgers and projections (ASF ancillary)

### Item

**Total Files**: 662  
**Total Lines**: 8,279  
**Where**: ASF items (TODOs) 662  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 662 | 662 | 662 | 0.08 | U R* | fm | vsect kind |
| `Owner` | 662 | 662 | 662 | 0.08 | U R* | fm | owning KR id |
| `Opened` | 662 | 662 | 662 | 0.08 | U R* | fm | timestamp |
| `Opened-by` | 662 | 662 | 662 | 0.08 | U R* | fm | who opened it |
| `(Slug)` | 662 | 662 | 662 | 0.08 | U* R* | if |  |
| `(Title)` | 662 | 662 | 662 | 0.08 | U* R* | im | title (human-readable, no fixed form) |
| `Concerns`﹖ | 551 | 551 | 551 | 0.07 | U O* | fm | records it concerns |
| `(Title › Seed to attempt)`﹖ | 7 | 7 | 7 | 0.00 | U* O* | im |  |
| `(Title › Hypothesis to attempt)`﹖ | 4 | 4 | 4 | 0.00 | U* O* | im |  |
| *(40 minor slots)* |  |  | 1,753 | 0.21 | U O* |  | listed below |

*Minor and undeclared slots:* (Preamble) (307), Source (176), Provenance (174), Section (174), Rechecked (174), Restated (119), Closed (25), The Gap (10), The Spike (9), From (8), Status (5), Honest scope (4), … (+27 more)

### Item (Imported)

**Total Files**: 197  
**Total Lines**: 3,184  
**Where**: ASF items (TODOs) 197  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 197 | 197 | 197 | 0.06 | U R* | fm | vsect kind |
| `Provenance` | 197 | 197 | 197 | 0.06 | U R* | fm | imported = carried verbatim from a tracker |
| `Source` | 197 | 197 | 197 | 0.06 | U R* | fm | tracker file:line it came from |
| `Section` | 197 | 197 | 197 | 0.06 | U R* | fm | tracker section path |
| `Owner` | 197 | 197 | 197 | 0.06 | U R* | fm | owning KR id |
| `Opened` | 197 | 197 | 197 | 0.06 | U R* | fm | timestamp |
| `Opened-by` | 197 | 197 | 197 | 0.06 | U R* | fm | who opened it |
| `(Slug)` | 197 | 197 | 197 | 0.06 | U* R* | if |  |
| `(Preamble)` | 197 | 197 | 475 | 0.15 | U* R* | im |  |
| `(Title)` | 197 | 197 | 197 | 0.06 | U* R* | im | title (human-readable, no fixed form) |
| *(28 minor slots)* |  |  | 82 | 0.03 | U O* |  | listed below |

*Minor and undeclared slots:* Concerns (43), Closed (8), What (2), Context (2), Options (2), Lead recommendation (2), Pointer (2), Title text: (1), Scoping spike (1), Bundle members (1), … (+18 more)

### Question

**Total Files**: 64  
**Total Lines**: 662  
**Where**: ASF questions 64  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Kind` | 64 | 64 | 64 | 0.10 | U R* | fm | vsect kind |
| `Closer` | 64 | 64 | 64 | 0.10 | U R* | fm | who may close it |
| `Asked` | 64 | 64 | 64 | 0.10 | U R* | fm | timestamp |
| `Asked-by` | 64 | 64 | 64 | 0.10 | U R* | fm | who asked |
| `(Slug)` | 64 | 64 | 64 | 0.10 | U* R* | if |  |
| `(Title)` | 64 | 64 | 64 | 0.10 | U* R* | im | title (human-readable, no fixed form) |
| `Concerns`﹖ | 62 | 62 | 62 | 0.09 | U O* | fm | records it concerns |
| `(Preamble)`﹖ | 40 | 40 | 44 | 0.07 | U* O* | im |  |

### Partial

**Total Files**: 13  
**Total Lines**: 608  
**Where**: ASF README partials 13  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 13 | 13 | 13 | 0.02 | U* R* | if |  |
| *(34 minor slots)* |  |  | 980 | 1.61 | U O* |  | listed below |

*Minor and undeclared slots:* Two entry points beyond this README (1), About (1), Anecdotal Feedback (1), For Auditors (1), (Preamble) (1), (Title) (1), Contributing (1), Cross-Domain Joining (1), Loop (1), … (+25 more)

### Partial (Generated)

**Total Files**: 3  
**Total Lines**: 184  
**Where**: ASF README partials 3  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.02 | U* R* | if |  |
| *(11 minor slots)* |  |  | 297 | 1.61 | U O* |  | listed below |

*Minor and undeclared slots:* Some Novel Results & Findings (1), Some Novel Results & Findings › Part Adaptive Systems Under Uncertainty (1), Some Novel Results & Findings › Part Agentic Composites (1), … (+8 more)

### Tracker (Todo.md)

**Total Files**: 1  
**Total Lines**: 504  
**Where**: ASF items (TODOs) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 9 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im | title (human-readable, no fixed form) |
| `Last reconciled` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Tier 1 — load-bearing` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Tier 2 — structural` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Tier 3 — soft scope/register tightenings` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Path A` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Path B` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Section II / Identifiability Floor` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Section III / Composition` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Shoshin engineering follow-on` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Anticipated segments queued` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Narrative segments` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Other queued spikes` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Lexicon-archive deferral` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Mechanical follow-ups` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Era-artifact routing + TST external-corroboration spike` | 1 | 1 | 10 | 0.02 | U R* | hd |  |
| `Strengthen-first candidates from the 2026-05-30/31 gold-lift sweep` | 1 | 1 | 27 | 0.05 | U R* | hd |  |
| `Strategic-composition cluster residuals` | 1 | 1 | 9 | 0.02 | U R* | hd |  |
| `NeurIPS 2026 back-integration overview` | 1 | 1 | 11 | 0.02 | U R* | hd |  |
| `Greek vocabulary prose discipline` | 1 | 1 | 20 | 0.04 | U R* | hd |  |
| `README v2 pass` | 1 | 1 | 46 | 0.09 | U R* | hd | holds 4 named ### parts in 1 file |
| `Open routing decision` | 1 | 1 | 8 | 0.02 | U R* | hd |  |
| `Open theory items` | 1 | 1 | 34 | 0.07 | U R* | hd |  |
| `Queued spike work` | 1 | 1 | 33 | 0.07 | U R* | hd |  |
| `Naming pipeline — specific deferred items` | 1 | 1 | 24 | 0.05 | U R* | hd |  |
| `Documentation queued` | 1 | 1 | 10 | 0.02 | U R* | hd |  |
| `Tier-C deferrals` | 1 | 1 | 5 | 0.01 | U R* | hd |  |
| `Editorial hygiene` | 1 | 1 | 13 | 0.03 | U R* | hd |  |
| `Lower priority` | 1 | 1 | 12 | 0.02 | U R* | hd |  |
| `Deferred — project structure / tooling` | 1 | 1 | 62 | 0.12 | U R* | hd | holds 6 ### deferred tasks in 1 file |
| `🌟 Parts III + IV active work` | 1 | 1 | 74 | 0.15 | U R* | hd | holds 8 named ### parts in 1 file, each with fields High-priority next batch, Lower-priority sweep target |
| `2026-05-12 — Audit-findings intake` | 1 | 1 | 50 | 0.10 | U R* | hd | holds 4 ### groups in 1 file, each with fields Open |
| `2026-05-12 (late) — Spike audit triage` | 1 | 1 | 12 | 0.02 | U R* | hd |  |
| `2026-05-16 — lint-outline residual` | 1 | 1 | 4 | 0.01 | U R* | hd |  |
| `2026-05-17 — scrbook appendix numbering` | 1 | 1 | 11 | 0.02 | U R* | hd |  |
| `2026-07-03 — Audit 731548 (Fable de-novo, Part I + impl-) routing` | 1 | 1 | 14 | 0.03 | U R* | hd |  |

### Reference

**Total Files**: 1  
**Total Lines**: 272  
**Where**: ASF notation (planned store, never 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.00 | U R* | fm | identity (= filename) |
| `Type` | 1 | 1 | 1 | 0.00 | U R* | fm | kind of claim |
| `(Preamble)` | 1 | 1 | 4 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im | title (human-readable, no fixed form) |
| `Subscript $t$` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Subscript $\tau$` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Superscript $(k)$` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `$\lVert\cdot\rVert$` ➕ | 2 | 1 | 2 | 0.01 | U R* | la |  |
| `The Adaptive Cycle` | 1 | 1 | 15 | 0.06 | U R* | hd |  |
| `Primitives` | 1 | 1 | 22 | 0.08 | U R* | hd |  |
| `Temporal Structure` | 1 | 1 | 10 | 0.04 | U R* | hd |  |
| `The Model` | 1 | 1 | 14 | 0.05 | U R* | hd |  |
| `Event-Driven Dynamics` | 1 | 1 | 13 | 0.05 | U R* | hd |  |
| `Mismatch Signal` | 1 | 1 | 9 | 0.03 | U R* | hd |  |
| `Update Gain` | 1 | 1 | 12 | 0.04 | U R* | hd |  |
| `Action Selection` | 1 | 1 | 8 | 0.03 | U R* | hd |  |
| `Adaptive Tempo and Dynamics` | 1 | 1 | 12 | 0.04 | U R* | hd |  |
| `Lyapunov / Sector-Condition Analysis` | 1 | 1 | 14 | 0.05 | U R* | hd |  |
| `Deliberation` | 1 | 1 | 9 | 0.03 | U R* | hd |  |
| `Purposeful Agent State` | 1 | 1 | 17 | 0.06 | U R* | hd |  |
| `Multi-Agent` | 1 | 1 | 11 | 0.04 | U R* | hd |  |
| `Resource Budget` | 1 | 1 | 14 | 0.05 | U R* | hd |  |
| `Conventions` | 1 | 1 | 42 | 0.15 | U R* | hd |  |
| `Units` | 1 | 1 | 23 | 0.08 | U R* | hd |  |
| `Global Assumptions` | 1 | 1 | 13 | 0.05 | U R* | hd |  |
## Tool and app pipelines

### Impl

**Total Files**: 64  
**Total Lines**: 2,926  
**Where**: limen 64  
**Shape declared in**: limen CLAUDE.md "A row's record is its impl/<slug>.md"

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 64 | 64 | 64 | 0.02 | U* R* | if |  |
| `(Preamble)` | 64 | 64 | 65 | 0.02 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 64 | 64 | 64 | 0.02 | U* R* | im | the segment's name / one-line claim |
| `(Title › impl)`﹖ | 41 | 41 | 41 | 0.01 | U* O* | im |  |
| `What landed`﹖ | 50 | 50 | 557 | 0.19 | D O* | hd | what the row delivered |
| `Measured`﹖ | 29 | 29 | 257 | 0.09 | D O* | hd | numbers with their conditions |
| `Found while building`﹖ | 24 | 24 | 166 | 0.06 | D O* | hd | discoveries made along the way |
| `Honest not-dones`﹖ | 22 | 22 | 183 | 0.06 | D O* | hd | what is not done, said plainly |
| `How to run`﹖ | 21 | 21 | 140 | 0.05 | D O* | hd | commands to reproduce |
| *(214 minor slots)* |  |  | 1,492 | 0.51 | U O* |  | listed below |

*Minor and undeclared slots:* Measured / checked (16), Not done / open (13), Run it (10), Not done (9), Not done, and things to feel (5), Verified (5), What was wrong (4), Measurements (3), Not exercised (3), Found while building, not done (3), Not done, honestly (3), … (+203 more)

### Design

**Total Files**: 48  
**Total Lines**: 2,882  
**Where**: aspectus 48  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 48 | 48 | 48 | 0.02 | U* R* | if |  |
| `(Preamble)` | 48 | 48 | 221 | 0.08 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 48 | 48 | 48 | 0.02 | U* R* | im | the segment's name / one-line claim |
| *(192 minor slots)* |  |  | 2,649 | 0.92 | U O* |  | listed below |

*Minor and undeclared slots:* Open (23), Foundations (23), Subfeatures (19), Not in this row (16), Shipped (5), JSON (4), The law (3), Story (2), Display (2), Steward asks (2), Shape (2), … (+181 more)

### Impl

**Total Files**: 43  
**Total Lines**: 1,329  
**Where**: aspectus 43  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 43 | 43 | 43 | 0.03 | U* R* | if |  |
| `(Preamble)` | 43 | 43 | 472 | 0.36 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 43 | 43 | 43 | 0.03 | U* R* | im | the segment's name / one-line claim |
| *(89 minor slots)* |  |  | 699 | 0.53 | U O* |  | listed below |

*Minor and undeclared slots:* Tests (5), Calls made (4), What the binary does now (3), Src/nlevel.rs (3), Src/ready.rs (3), Src/json.rs (3), Src/facts.rs (3), Help (3), JSON (3), What shipped (3), Alignment (2), … (+77 more)

### Design

**Total Files**: 20  
**Total Lines**: 1,720  
**Where**: limen 20  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 20 | 20 | 20 | 0.01 | U* R* | if |  |
| `(Preamble)` | 20 | 20 | 27 | 0.02 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 20 | 20 | 20 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `(Title › Design)`﹖ | 17 | 17 | 17 | 0.01 | U* O* | im |  |
| *(216 minor slots)* |  |  | 1,905 | 1.11 | U O* |  | listed below |

*Minor and undeclared slots:* Provenance (9), Why (7), Decided (5), Open decisions (4), Where it stands (4), Sequence (4), The proposal (4), Joseph's words (3), What (2), The reveal (2), Open (2), … (+203 more)

### Def

**Total Files**: 3  
**Total Lines**: 33  
**Where**: aspectus 3  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.09 | U* R* | if |  |
| `(Preamble)` | 3 | 3 | 15 | 0.45 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 3 | 3 | 3 | 0.09 | U* R* | im | the segment's name / one-line claim |
| `(Title › Definition)` | 3 | 3 | 3 | 0.09 | U* R* | im |  |
## Readings, walks and analyses

### Analysis

**Total Files**: 960  
**Total Lines**: 428,520  
**Where**: TST library analyses 960  
**Shape declared in**: declared (vault template)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Original-id` | 960 | 960 | 960 | 0.00 | D R | fm | planning analysis number |
| `Original-filename` | 960 | 960 | 960 | 0.00 | D R | fm | planning filename |
| `Legacy-path` | 960 | 960 | 960 | 0.00 | D R | fm | path of the original |
| `Source-book` | 960 | 960 | 960 | 0.00 | D R | fm | book |
| `Source-book-code` | 960 | 960 | 960 | 0.00 | D R | fm | book code |
| `Chapter` | 960 | 960 | 960 | 0.00 | D R | fm | chapter |
| `Chapter-title` | 960 | 960 | 960 | 0.00 | D R | fm | chapter title |
| `Topic` | 960 | 960 | 1,458 | 0.00 | D R | fm | topic |
| `Source-files` | 960 | 960 | 964 | 0.00 | D R | fm | extracted source files |
| `Quality-score` | 960 | 960 | 960 | 0.00 | D R | fm | score from the quality analyzer |
| `Quality-category` | 960 | 960 | 960 | 0.00 | D R | fm | exemplar/good/needs-work |
| `Principles` | 960 | 960 | 6,839 | 0.02 | D R | fm | FP-NNN list |
| `Supports` | 960 | 960 | 960 | 0.00 | D R | fm | analyses it supports |
| `Contradicts` | 960 | 960 | 960 | 0.00 | D R | fm | analyses it contradicts |
| `Related-analyses` | 960 | 960 | 960 | 0.00 | U R* | fm | related analyses |
| `Date-created` | 960 | 960 | 960 | 0.00 | D R | fm | date |
| `Date-modified` | 960 | 960 | 960 | 0.00 | D R | fm | date |
| `Batch-system-version` | 960 | 960 | 960 | 0.00 | D R | fm | generator version |
| `Tags` | 960 | 960 | 8,759 | 0.02 | D R | fm | book/quality/principle tags |
| `(Slug)` | 960 | 960 | 960 | 0.00 | U* R* | if |  |
| `(Title)`﹖ | 852 | 852 | 852 | 0.00 | U* O* | im |  |
| `(Title › Analysis N)`﹖ | 846 | 846 | 846 | 0.00 | U* O* | im |  |
| `(Title › Analysis)`﹖ | 4 | 4 | 4 | 0.00 | U* O* | im |  |
| `AI-Augmented Coding Implications` | 960 | 960 | 30,078 | 0.07 | U R* | hd | holds 70 ### implications in 30 files |
| `Counter-Examples and Limits` | 960 | 960 | 10,078 | 0.02 | U R* | hd | holds 11 ### limits in 7 files |
| `Best Practices` | 960 | 960 | 9,750 | 0.02 | U R* | hd |  |
| `Epistemic Implications` | 960 | 960 | 5,185 | 0.01 | U R* | hd |  |
| `Formalized through`﹖ | 857 | 857 | 857 | 0.00 | U O* | la |  |
| `Application to Sapientia`﹖ | 854 | 854 | 179,699 | 0.42 | U O* | hd | holds 24 named ### parts in 13 files |
| `The Claim`﹖ | 852 | 852 | 3,629 | 0.01 | U O* | hd |  |
| `Applicability to BEAM/OTP`﹖ | 803 | 803 | 5,920 | 0.01 | U O* | hd | holds 1 ### item in 1 file |
| `Mathematical Formalization` | 772 | 772 | 90,818 | 0.21 | D R | hd | template body slot (with ### Formal Model / Key Equations / Constraints and Boundaries); holds 2859 ### models in 716 files; 228 ### items in 182 files |
| `Research Notes`﹖ | 726 | 726 | 12,678 | 0.03 | U O* | hd |  |
| *(2455 minor slots)* |  |  | 56,089 | 0.13 | U O* |  | listed below |

*Minor and undeclared slots:* (Preamble) (101), Detection Pattern (88), Detection Pattern for AI Agents (71), Refactoring Procedure (70), Detection Prompt Template (68), Principle (66), Core Concepts (49), Applicability to BEAM/OTP Systems (49), Justification by Software First Principles (44), Supervision Trees (37), Mathematical Formalization - THE FOUNDATION (36), Process Isolation (34), Detection Pattern for AI Assistants (33), Detection prompt (33), Refactoring Prompt Template (28), FP-012 (27), FP-007 (25), Automated Refactoring Procedure (24), Boundary Conditions (23), Message Passing (23), Hot code reloading (23), Missing Context (21), AI Prompt Template (21), FP-004 (21), Hot Code Loading (21), Confidence and Alignment Scores (20), Particularly Elegant Insight (18), FP-001 (18), Measurement Challenges (17), Confidence in Constants (17), FP-008 (17), Detection prompt for AI agents (16), AI Implementation Procedure (15), Refactoring procedure for AI agents (14), FP-009 (14), Generation Prompt Template (14), Pattern matching (13), Confidence (13), Alignment (13), Confidence Considerations (11), Continuous Monitoring Pattern (11), AI Refactoring Procedure (10), AI Code Review Prompt (10), FP-005 (10), Detection Pattern for AI (10), Confidence in Formalization (9), Elegant Insight (9), FP-003 (9), Pattern Detection Prompt (8), AI Code Generation Template (8), Regulatory Compliance (8), Exciting Insight (8), Refactoring Procedure for AI (7), Supervisor Trees (7), Actor model (7), Preemptive Scheduling (6), Extension Opportunity (6), Rapid Prototyping (6), Refactoring Detection (6), FP-011 (6), Immutability (6), AI Workflow Integration (6), Areas for Extension (5), Empirical Validation Needed (5), FP-006 (5), Memory-Constrained Environments (5), Generation Procedure (5), Continuous Monitoring (5), Confidence in Mathematical Model (5), AI Code Generation Strategy (5), Transformation Procedure (5), Automated Analysis Procedure (5), AI Code Review Integration (4), Supervision Tree Generation (4), Optimization Procedure (4), Detection Pattern for DSL Opportunities (4), DSL Generation Procedure (4), Key Insight (4), Prompt Template for Claude/GPT (4), AI Assistant Prompt Template (4), Prototype Generation Procedure (4), Hot Code Swapping (4), Measurement Challenge (4), Cultural Factors (4), AI Code Review Pattern (4), Automated Migration Procedure (4), Alignment with Software First Principles (4), Performance-Critical Hot Paths (4), Application boundaries (4), Cross-Cutting Concerns (4), Implementation Procedure (3), AI Code Generation Prompt Template (3), Refactoring Prompt (3), AI Pattern Recognition (3), Location Transparency (3), Generation Template for AI (3), Code Generation Template (3), Detection Prompt for AI Assistants (3), AI Implementation Pattern (3), BEAM-Specific Insights (3), Pattern Detection (3), Validation Prompt (3), AI Code Generation Rules (3), Detection Pattern for Missing Supervision (3), Macro Generation Procedure (3), Module attributes (3), Exploration Phase (3), Empirical Constants (3), Expected Time Savings (3), Exciting Insights (3), Quality metrics AI should track (3), Mathematical Insight (3), Observer Tools (3), Regulatory Environments (3), FP-002 (3), Performance Critical Paths (3), Process boundaries (3), Continuous Monitoring Prompt (3), Applicability Confidence (3), FP-013 (3), External System Integration (3), Fault Tolerance (3), ETS Tables (3), AI Integration Strategy (3), Detection Pattern for Performance Issues (3), AI Implementation Strategy (3), Supervision Tree Generation Prompt (3), Refactoring assistance pattern (3), Automated Testing Generation (3), Detection Pattern for Refactoring Opportunities (3), Measurable Benefits (3), BEAM-Specific Advantages (3), Extension possibility (3), Detection Pattern for Missing Observability (3), Embedded Systems (3), Configuration Generation (3), Young Systems (3), Message protocols (3), Refactoring Assistant Pattern (3), AI Integration Procedure (3), Continuous Monitoring Integration (3), Confidence Score (3), Alignment Score (3), Process Isolation Benefits (3), … (+2310 more)

### Analysis

**Total Files**: 960  
**Total Lines**: 401,885  
**Where**: TST principle analyses 960  
**Shape declared in**: declared (methodology template)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 960 | 960 | 960 | 0.00 | U* R* | if |  |
| `Source` | 958 | 958 | 958 | 0.00 | D R | fm | source book/article |
| `Chapter`﹖ | 958 | 958 | 958 | 0.00 | D O | fm | source chapter |
| `Principle` | 958 | 958 | 958 | 0.00 | D R | fm | one-line principle statement derived from the claim |
| `Analysis date` | 958 | 958 | 958 | 0.00 | D R | fm | date |
| `Confidence` | 958 | 958 | 958 | 0.00 | D R | fm | self-assessed analysis quality 0-1 |
| `Alignment` | 958 | 958 | 958 | 0.00 | D R | fm | alignment with the first principles 0-1 |
| `(Title)` | 852 | 852 | 852 | 0.00 | D* R | im | title: "# Analysis NNN: Topic" |
| `(Title › Analysis N)`﹖ | 846 | 846 | 846 | 0.00 | U* O* | im |  |
| `Author`﹖ | 798 | 798 | 798 | 0.00 | D O | fm | source author |
| `(Title › Analysis)`﹖ | 4 | 4 | 4 | 0.00 | U* O* | im |  |
| `AI-Augmented Coding Implications`﹖ | 960 | 960 | 30,078 | 0.07 | D O | hd | detection patterns and prompts for coding agents; holds 70 ### implications in 30 files |
| `Counter-Examples and Limits` | 960 | 960 | 10,078 | 0.03 | D R | hd | where the principle does not apply; holds 11 ### limits in 7 files |
| `Best Practices` | 960 | 960 | 9,750 | 0.02 | D R | hd | practices that follow |
| `Epistemic Implications`﹖ | 960 | 960 | 5,185 | 0.01 | D O | hd | what the analysis says about knowledge/certainty |
| `Formalized through`﹖ | 857 | 857 | 857 | 0.00 | U O* | la | bold line naming the FP principles used |
| `Application to Sapientia` | 854 | 854 | 179,699 | 0.45 | D R | hd | illustrative Elixir/OTP code for the model (100-150 lines); holds 24 named ### parts in 13 files |
| `The Claim` | 852 | 852 | 3,629 | 0.01 | D R | hd | the source's assertion in context (5-10 lines) |
| `Applicability to BEAM/OTP` | 803 | 803 | 5,920 | 0.01 | D R | hd | the principle in Erlang/Elixir terms; holds 1 ### item in 1 file |
| `Mathematical Formalization` | 772 | 772 | 90,818 | 0.23 | D R | hd | formal development-time model mapped to FP-NNN ("THE FOUNDATION", 60-80 lines); holds 2859 ### models in 716 files; 228 ### items in 182 files |
| `Research Notes`﹖ | 726 | 726 | 12,678 | 0.03 | D O | hd | candid notes, open questions |
| `Confidence and Alignment Scores` | 20 | 20 | 219 | 0.00 | D R | hd | scores footer as a heading |
| *(2456 minor slots)* |  |  | 56,071 | 0.14 | U O* |  | listed below |

*Minor and undeclared slots:* File (101), (Preamble) (101), Section (100), Detection Pattern (88), Detection Pattern for AI Agents (71), Refactoring Procedure (70), Detection Prompt Template (68), Principle (66), Core Concepts (49), Applicability to BEAM/OTP Systems (49), Justification by Software First Principles (44), Supervision Trees (37), Mathematical Formalization - THE FOUNDATION (36), Process Isolation (34), Detection Pattern for AI Assistants (33), Detection prompt (33), Refactoring Prompt Template (28), FP-012 (27), FP-007 (25), Automated Refactoring Procedure (24), Hot code reloading (23), Message Passing (23), Boundary Conditions (23), Hot Code Loading (21), Missing Context (21), FP-004 (21), AI Prompt Template (21), FP-001 (18), Particularly Elegant Insight (18), Confidence in Constants (17), FP-008 (17), Measurement Challenges (17), Detection prompt for AI agents (16), AI Implementation Procedure (15), FP-009 (14), Refactoring procedure for AI agents (14), Generation Prompt Template (14), Pattern matching (13), Confidence (13), Alignment (13), Confidence Considerations (11), Continuous Monitoring Pattern (11), FP-005 (10), AI Refactoring Procedure (10), Detection Pattern for AI (10), AI Code Review Prompt (10), Elegant Insight (9), FP-003 (9), Confidence in Formalization (9), AI Code Generation Template (8), Regulatory Compliance (8), Exciting Insight (8), Pattern Detection Prompt (8), Supervisor Trees (7), Refactoring Procedure for AI (7), Actor model (7), Immutability (6), FP-011 (6), Preemptive Scheduling (6), Rapid Prototyping (6), Extension Opportunity (6), Refactoring Detection (6), AI Workflow Integration (6), Empirical Validation Needed (5), Continuous Monitoring (5), Confidence in Mathematical Model (5), Generation Procedure (5), FP-006 (5), Transformation Procedure (5), Areas for Extension (5), Memory-Constrained Environments (5), Automated Analysis Procedure (5), AI Code Generation Strategy (5), Hot Code Swapping (4), Measurement Challenge (4), Prototype Generation Procedure (4), Detection Pattern for DSL Opportunities (4), DSL Generation Procedure (4), AI Code Review Integration (4), Key Insight (4), Cross-Cutting Concerns (4), Alignment with Software First Principles (4), Performance-Critical Hot Paths (4), Application boundaries (4), Cultural Factors (4), Optimization Procedure (4), Prompt Template for Claude/GPT (4), AI Assistant Prompt Template (4), Automated Migration Procedure (4), AI Code Review Pattern (4), Supervision Tree Generation (4), Observer Tools (3), Fault Tolerance (3), Process boundaries (3), Generation Template for AI (3), AI Code Generation Rules (3), AI Implementation Strategy (3), Exploration Phase (3), AI Integration Strategy (3), BEAM-Specific Insights (3), AI Pattern Recognition (3), Detection Pattern for Missing Supervision (3), Continuous Monitoring Prompt (3), Young Systems (3), Implementation Procedure (3), Mathematical Insight (3), ETS Tables (3), Pattern Detection (3), Regulatory Environments (3), External System Integration (3), Performance Critical Paths (3), FP-002 (3), AI Code Generation Prompt Template (3), BEAM-Specific Advantages (3), Applicability Confidence (3), FP-013 (3), Location Transparency (3), Automated Testing Generation (3), Confidence Score (3), Alignment Score (3), Measurable Benefits (3), Expected Time Savings (3), Message protocols (3), Process Isolation Benefits (3), Exciting Insights (3), Module attributes (3), Quality metrics AI should track (3), Empirical Constants (3), Macro Generation Procedure (3), Detection Prompt for AI Assistants (3), Supervision Tree Generation Prompt (3), Detection Pattern for Performance Issues (3), Validation Prompt (3), Refactoring Prompt (3), Refactoring assistance pattern (3), Configuration Generation (3), Embedded Systems (3), AI Implementation Pattern (3), Code Generation Template (3), Refactoring Assistant Pattern (3), Continuous Monitoring Integration (3), Extension possibility (3), Detection Pattern for Refactoring Opportunities (3), Detection Pattern for Missing Observability (3), AI Integration Procedure (3), … (+2310 more)

### Reflection

**Total Files**: 833  
**Total Lines**: 40,642  
**Where**: ASF de-novo audit walks 833  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 833 | 833 | 833 | 0.02 | U* R* | if |  |
| `(Title)` | 833 | 833 | 833 | 0.02 | U* R* | im | title |
| `(Preamble)`﹖ | 752 | 752 | 9,867 | 0.24 | U* O* | im |  |
| `(Title › Reflection)`﹖ | 395 | 395 | 395 | 0.01 | U* O* | im |  |
| `(Title › Batch Reflection)`﹖ | 7 | 7 | 7 | 0.00 | U* O* | im |  |
| `(Title › Comprehension Quiz — Batch N)`﹖ | 5 | 5 | 5 | 0.00 | U* O* | im |  |
| `(Title › 01 — def-agent-environment)`﹖ | 4 | 4 | 4 | 0.00 | U* O* | im |  |
| `(Title › 10 — form-agent-model)`﹖ | 4 | 4 | 4 | 0.00 | U* O* | im |  |
| `(Title › 11 — form-information-bottleneck)`﹖ | 4 | 4 | 4 | 0.00 | U* O* | im |  |
| `(Title › 12 — def-model-sufficiency)`﹖ | 4 | 4 | 4 | 0.00 | U* O* | im |  |
| `(Title › 02 — def-action-transition)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| `(Title › 09 — the-reality-model-intro)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| `(Title › 14 — the-cycle-in-motion-intro)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| `(Title › 15 — form-event-driven-dynamics)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| `Wandering thoughts` | 115 | 115 | 1,438 | 0.04 | D R | hd | §14 original thought, 3–10+ paragraphs |
| `Wandering` | 6 | 6 | 82 | 0.00 | D R | hd | §14 original thought, 3–10+ paragraphs |
| `Wandering / synthesis` | 1 | 1 | 6 | 0.00 | D R | hd | §14 original thought, 3–10+ paragraphs |
| *(1040 minor slots)* |  |  | 25,349 | 0.62 | U O* |  | listed below |

*Minor and undeclared slots:* Cross-segment consistency (287), Predictions vs evidence (282), Math verification (270), Predictions for next segments (131), Curious about (116), Wandering Thoughts and Ideation (92), Contribution (87), Predictions for next segment (86), Value feeling (86), Dependency check (72), Reflection (68), First-pass understanding (58), Diagram attempt (58), Findings and watches (58), Local verdict (58), Cadence check (50), Status-label / discipline (48), Prompts walk-through (45), Felt value (40), Watch list (37), Next-segment predictions (37), Prompt pass (34), Diagram thought (34), Segment (33), What the segment does (32), What this does (31), Naming targets surfaced (30), Naming relevance (30), Stage (29), Finding (27), Brief wandering (25), Errors to watch for (25), What would I change (25), What new knowledge does this enable (25), Should the audit process change (25), Outline changes for FINAL (25), What the framework now potentially contributes (25), What direction next (22), Prose-coherence (21), What I'd change (20), Naming Notes (18), What's excellent here (18), Predictions vs. evidence (18), What am I now curious about? (18), What This Enables (18), What would I change? (17), Segment Read (17), Watchlist (17), Cross-segment notes (15), Wandering thoughts and ideation (15), Critical Mental Model (14), Mathematics (14), Implications (14), Most distinctive contribution (14), Depends-check next (14), What direction will the theory take next? (13), Segments covered (13), What errors should I watch for? (13), Should the audit process change? (13), How valuable do these segments feel? (12), What new knowledge does this enable? (11), Prompt walk (11), Diagram (11), Next (10), New naming targets surfaced (9), Curiosity (9), What changes in my running outline? (9), CRITICAL FINDING POTENTIAL (9), Row N (8), Prose-coherence — strong (8), AI alignment researchers (8), What does the framework potentially contribute? (7), Adversarial observations (7), Plan-DAG designers (7), Segments (7), Reading order positions (7), Per-Segment Notes (7), Cross-Segment Consistency Check (7), Naming targets (6), Dep-graph / OUTLINE-order check (6), Decision theorists (6), Finding Tracking Update (6), New concepts surfaced (5), Continuing (5), Causal-inference researchers (5), AI agent designers (5), Predictions for batch N (4), Discriminating power — self-experiment (4), Der-orient-cascade (4), Outline updates (4), Active-inference researchers (4), Practitioners (4), Cross-segment consistency notes (4), Math / status notes (4), The workflow in my own words (3), Feedback on the instructions (3), Post-composition-consistency (3), Forward prediction (3), Status (3), Correctness against segment text (3), Watch-list updates (3), Verdict (3), Direction (3), Der-chain-confidence-decay (3), Confirmed finding (3), What direction next? (3), HOWEVER (3), What this batch enables (3), Standout (3), Dep-graph / DETECTOR / OUTLINE-order (3), What changes in my outline for the final report? (3), Decision-theory researchers (3), Candidate finding watchpoint (3), Context of Exploration (3), Reading order position (3), Depends (3), What Direction Will the Theory Take? (3), Prediction for Next Segment (3), Curiosities (3), What Does This Enable? (3), Framework Contribution (3), Verified this batch (3), Math Verification Summary (3), … (+900 more)

### Segment-summary

**Total Files**: 144  
**Total Lines**: 1,685  
**Where**: AAT summary walk 144  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 144 | 144 | 144 | 0.09 | U* R* | if |  |
| `(Preamble)` | 144 | 144 | 772 | 0.46 | U* R* | im |  |
| `(Title)` | 144 | 144 | 144 | 0.09 | U* R* | im | title: segment title + (type — status) |
| `(Title › Chapter Introduction)`﹖ | 6 | 6 | 6 | 0.00 | U* O* | im |  |
| *(6 minor slots)* |  |  | 6 | 0.00 | U O* |  | listed below |

*Minor and undeclared slots:* Proposition B.4 (1), B.5 (1), Track 1 — Transport inequality, linear in information (1), Natural non-Euclidean metrics for sub-scope $\alpha$ (1), Sub-scope $\beta$ promotions (1), … (+1 more)

### Initial-predictions

**Total Files**: 25  
**Total Lines**: 2,404  
**Where**: ASF de-novo audit walks 25  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 25 | 25 | 25 | 0.01 | U* R* | if |  |
| `(Title)` | 25 | 25 | 25 | 0.01 | U* R* | im | title |
| `(Preamble)`﹖ | 21 | 21 | 136 | 0.06 | U* O* | im |  |
| `(Title › Initial Predictions)`﹖ | 9 | 9 | 9 | 0.00 | U* O* | im |  |
| `(Title › Initial Predictions — Audit N)`﹖ | 5 | 5 | 5 | 0.00 | U* O* | im |  |
| `(Title › 00 — Initial Predictions)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| `Topology of the Framework`﹖ | 4 | 4 | 36 | 0.01 | D O* | hd | reflection subsection |
| `Predictions about what is open`﹖ | 2 | 2 | 19 | 0.01 | D O* | hd | reflection subsection |
| `Predictions about what's open`﹖ | 2 | 2 | 2 | 0.00 | D O* | la | reflection subsection |
| `Predictions about what's overclaimed`﹖ | 2 | 2 | 2 | 0.00 | D O* | la | reflection subsection |
| `Predictions about what I'll find is already settled`﹖ | 1 | 1 | 6 | 0.00 | D O* | hd | reflection subsection |
| `Predictions about what I'll find awkward / problematic`﹖ | 1 | 1 | 7 | 0.00 | D O* | hd | reflection subsection |
| *(225 minor slots)* |  |  | 2,723 | 1.13 | U O* |  | listed below |

*Minor and undeclared slots:* Topology as I understand it (6), Predictions about what's open (5), Priming bleed (4), Predictions about what each component contains (4), What kinds of findings I expect to surface (4), TST (4), Section I (3), Section II (3), Section III (3), Expected Findings (3), Topology of the framework as I understand it (3), Predictions about what's overclaimed (3), Predictions about overclaim (3), Predictions By Component (3), … (+207 more)

### Batch-reflection

**Total Files**: 22  
**Total Lines**: 1,040  
**Where**: ASF de-novo audit walks 22  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 22 | 22 | 22 | 0.02 | U* R* | if |  |
| `(Title)` | 22 | 22 | 22 | 0.02 | U* R* | im | title |
| `(Preamble)`﹖ | 21 | 21 | 27 | 0.03 | U* O* | im |  |
| `(Title › Prediction)`﹖ | 11 | 11 | 11 | 0.01 | U* O* | im |  |
| `What I hadn't anticipated`﹖ | 11 | 11 | 275 | 0.26 | U O* | hd | reflection subsection; holds 9 ### items in 3 files; 10 named ### parts in 2 files |
| `Wandering thoughts` | 6 | 6 | 45 | 0.04 | D R | hd | §14 original thought, 3–10+ paragraphs |
| `Wandering` | 4 | 4 | 12 | 0.01 | D R | hd | §14 original thought, 3–10+ paragraphs |
| `Batch N › Wandering` ➕ | 4 | 2 | 20 | 0.02 | D R | hd | §14 original thought, 3–10+ paragraphs |
| *(91 minor slots)* |  |  | 1,153 | 1.11 | U O* |  | listed below |

*Minor and undeclared slots:* Core claims (5), Surprises (5), Experiential integration (4), Open threads (3), Questions (3), Batch N (3), Pedagogy (2), Batch N › Surprises (2), Honest coverage map (2), … (+81 more)

### Lesson

**Total Files**: 20  
**Total Lines**: 4,168  
**Where**: agent memory survey 20  
**Shape declared in**: memory/README.md §How each lesson is built

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 20 | 20 | 20 | 0.00 | U* R* | if |  |
| `(Preamble)` | 20 | 20 | 111 | 0.03 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 20 | 20 | 20 | 0.00 | U* R* | im | the segment's name / one-line claim |
| `Check yourself`﹖ | 14 | 14 | 628 | 0.15 | D O* | hd | exercises with answers |
| `Using it`﹖ | 11 | 11 | 360 | 0.09 | D O* | hd | the model as an interface: knobs, fitting, cost, scope |
| `What it doesn't capture`﹖ | 11 | 11 | 114 | 0.03 | D O* | hd | known failures; seeds the next lesson |
| `Bridges`﹖ | 8 | 8 | 151 | 0.04 | D O* | hd | ties to ASF/AAT and agent memory design |
| `Evidence`﹖ | 7 | 7 | 113 | 0.03 | D O* | hd | statistics, samples, disconfirming evidence |
| *(171 minor slots)* |  |  | 2,987 | 0.72 | U O* |  | listed below |

*Minor and undeclared slots:* Sources (8), The computational model, run (7), Sources for this lesson (6), The formal model (6), Phenomena this lesson is accountable to (5), Using it › The interface (6), … (+165 more)

### Running-outline

**Total Files**: 16  
**Total Lines**: 1,709  
**Where**: ASF de-novo audit walks 16  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 16 | 16 | 16 | 0.01 | U* R* | if |  |
| `(Title)` | 16 | 16 | 16 | 0.01 | U* R* | im | title |
| `(Preamble)`﹖ | 12 | 12 | 39 | 0.02 | U* O* | im |  |
| `(Title › Running Outline — Audit N)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| `(Title › Running Outline)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| *(122 minor slots)* |  |  | 1,816 | 1.06 | U O* |  | listed below |

*Minor and undeclared slots:* Strategic-loop revision (2), Batch files (2), Spine that held (2), Meta-architecture that held (2), Status (2), One certified-track finding surfaced (1), Batches 08–10 landed (1), … (+115 more)

### Segment

**Total Files**: 9  
**Total Lines**: 721  
**Where**: aat-refactored 9  
**Shape declared in**: HANDOFF.md (formal, delivery, working-notes layers); fm:kind is free text (definitions + exact identities; scope; derived; ...); 4 files say ## Notes where HAND

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 9 | 9 | 9 | 0.01 | U R* | fm | identity |
| `Kind` | 9 | 9 | 9 | 0.01 | U R* | fm | free-text kind and tier |
| `Tier` | 9 | 9 | 9 | 0.01 | U R* | fm | free-text epistemic tier |
| `Status` | 9 | 9 | 9 | 0.01 | U R* | fm | standing |
| `Replaces` | 9 | 9 | 9 | 0.01 | U R* | fm | the asf segments it replaces |
| `(Preamble)` | 9 | 9 | 24 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 9 | 9 | 9 | 0.01 | U* R* | im | the title |
| `Depends`﹖ | 8 | 8 | 8 | 0.01 | U O* | fm | what it rests on |
| `Unverified`﹖ | 8 | 8 | 8 | 0.01 | U O* | fm | statements not yet independently checked |
| `Statement` | 9 | 9 | 245 | 0.34 | D R* | hd | the claim or formal content, stated exactly |
| `Delivery` | 9 | 9 | 204 | 0.28 | D R* | hd | the teaching layer: the model first, then its caveats |
| `*[Definition]*`﹖ | 8 | 8 | 8 | 0.01 | U O* | ot | inline tag opening a definition statement |
| `The caveats the math adds`﹖ | 8 | 8 | 8 | 0.01 | D O* | la | what the formal layer qualifies |
| `*[Derived]*`﹖ | 7 | 7 | 7 | 0.01 | U O* | ot | inline tag opening a derived statement |
| `Working Notes`﹖ | 5 | 5 | 80 | 0.11 | D O* | hd | the inbox: open items with leans, cautions, provenance; not canon |
| *(19 minor slots)* |  |  | 70 | 0.10 | U O* |  | listed below |

*Minor and undeclared slots:* Notes (4), Status (3), Full observation under a known law (1), Continuous targets (1), No-go (1), The own-policy reading is wrong for a scope (1), Placement (1), Three drivers (1), … (+11 more)

### Chapter Reading

**Total Files**: 7  
**Total Lines**: 969  
**Where**: Practica chapter reading (s3) 7  
**Shape declared in**: s3-working/README.md "Four sections, exactly"

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.01 | U* R* | if |  |
| `(Preamble)` | 7 | 7 | 15 | 0.02 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 7 | 7 | 7 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `Critical concepts, reasonings, & conclusions` | 7 | 7 | 331 | 0.34 | D R | hd | what the chapter established |
| `Diffuse Wandering Mind` | 7 | 7 | 154 | 0.16 | D R | hd | tangents and tie-ins (3-10 paragraphs) |
| `Applicability to Practica` | 7 | 7 | 207 | 0.21 | D R | hd | what bears on Practica |
| `Updated predictions about the rest of the book`﹖ | 5 | 5 | 191 | 0.20 | U O* | hd |  |
| *(19 minor slots)* |  |  | 70 | 0.07 | U O* |  | listed below |

*Minor and undeclared slots:* Not predicted explicitly but landed prominently (3), Sharpened predictions for the final chapter (3), First-pass predictions about the rest of the book (1), … (+16 more)

### Meta-analysis Report

**Total Files**: 6  
**Total Lines**: 5,291  
**Where**: TST principle analyses 6  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.00 | U* R* | if |  |
| `(Title)` | 6 | 6 | 6 | 0.00 | U* R* | im |  |
| `(Preamble)`﹖ | 5 | 5 | 14 | 0.00 | U* O* | im |  |
| `Executive Summary`﹖ | 3 | 3 | 16 | 0.00 | U O* | hd |  |
| `Analysis Date`﹖ | 3 | 3 | 3 | 0.00 | U O* | la |  |
| *(237 minor slots)* |  |  | 10,820 | 2.04 | U O* |  | listed below |

*Minor and undeclared slots:* Key Insight (2), Conclusion (2), Mathematical Formalization (2), Primary Clusters (2), Secondary Clusters (2), Dataset (2), Variable Definitions (1), Example Calculation (1), … (+226 more)

### Verification

**Total Files**: 6  
**Total Lines**: 382  
**Where**: ASF de-novo audit walks 6  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.02 | U* R* | if |  |
| `(Preamble)` | 6 | 6 | 7 | 0.02 | U* R* | im |  |
| `(Title)` | 6 | 6 | 6 | 0.02 | U* R* | im | title (human-readable, no fixed form) |
| `Verifier`﹖ | 3 | 3 | 3 | 0.01 | U O* | la | reflection subsection |
| *(38 minor slots)* |  |  | 368 | 0.96 | U O* |  | listed below |

*Minor and undeclared slots:* Verdict (2), Disposition (2), Verdict summary (2), Severity assessment concurred (1), The mathematics — counterexample verified, with one patch (1), … (+33 more)

### Moc

**Total Files**: 5  
**Total Lines**: 392  
**Where**: TST library analyses 5  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 5 | 5 | 5 | 0.01 | U* R* | if |  |
| `(Preamble)` | 5 | 5 | 5 | 0.01 | U* R* | im |  |
| `(Title)` | 5 | 5 | 5 | 0.01 | U* R* | im |  |
| `Key Themes` | 5 | 5 | 249 | 0.64 | U R* | hd | grouped links into the book's analyses; holds 39 ### themes in 5 files |
| `Analysis Quality Distribution` | 5 | 5 | 68 | 0.17 | U R* | hd | quality histogram |
| `Cross-Book Connections` | 5 | 5 | 40 | 0.10 | U R* | hd | links to other books |
| *(6 minor slots)* |  |  | 86 | 0.22 | U O* |  | listed below |

*Minor and undeclared slots:* Analysis Quality Distribution › Exemplar Analyses (2), Analysis Quality Distribution › High-Quality Analyses (2), Principle Coverage (2), … (+3 more)

### Checkpoint

**Total Files**: 4  
**Total Lines**: 222  
**Where**: ASF de-novo audit walks 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.02 | U* R* | if |  |
| `(Preamble)` | 4 | 4 | 4 | 0.02 | U* R* | im |  |
| `(Title)` | 4 | 4 | 4 | 0.02 | U* R* | im | title (human-readable, no fixed form) |
| `Model update`﹖ | 2 | 2 | 12 | 0.05 | U O* | hd | reflection subsection |
| `Strategy update`﹖ | 2 | 2 | 13 | 0.06 | U O* | hd | reflection subsection |
| `Candidate status`﹖ | 2 | 2 | 12 | 0.05 | U O* | hd | reflection subsection |
| *(21 minor slots)* |  |  | 289 | 1.30 | U O* |  | listed below |

*Minor and undeclared slots:* Targets voteable from priming alone (1), Targets voteable from priming alone › Framework names + foundational vocabulary (1), … (+19 more)

### Tracker

**Total Files**: 3  
**Total Lines**: 67  
**Where**: ASF de-novo audit walks 3  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.04 | U* R* | if |  |
| `(Preamble)` | 3 | 3 | 21 | 0.31 | U* R* | im |  |
| `(Title)` | 3 | 3 | 3 | 0.04 | U* R* | im | title (human-readable, no fixed form) |
| *(5 minor slots)* |  |  | 29 | 0.43 | U O* |  | listed below |

*Minor and undeclared slots:* Why it works (1), What the new columns are for (1), Rhythm refinements to encourage (1), What this accomplishes downstream (1), One small operational note (1)

### Other

**Total Files**: 3  
**Total Lines**: 543  
**Where**: ASF de-novo audit walks 3  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.01 | U* R* | if |  |
| `(Preamble)` | 3 | 3 | 10 | 0.02 | U* R* | im |  |
| `(Title)` | 3 | 3 | 3 | 0.01 | U* R* | im | title (human-readable, no fixed form) |
| *(32 minor slots)* |  |  | 542 | 1.00 | U O* |  | listed below |

*Minor and undeclared slots:* Adversarial creative observation (2), ★★★ Real limit (1), ★★ Repairable scope-narrowing (1), ★ Already-handled (1), Real limits (1), Scope-narrowings the framework should name (1), … (+25 more)

### Ledger

**Total Files**: 2  
**Total Lines**: 128  
**Where**: agent memory survey 2  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.02 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 46 | 0.36 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 2 | 2 | 2 | 0.02 | U* R* | im | the segment's name / one-line claim |
| `A refinement to E18`﹖ | 1 | 1 | 12 | 0.09 | U O* | hd |  |
| `Running experiments with agents`﹖ | 1 | 1 | 4 | 0.03 | U O* | hd |  |
| `Key`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Columns`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Buf`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `GM`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `TCM`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `SIM`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `LAP`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `SEM`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `CP`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `CLS`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `GCLS`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `S&B`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `SR`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `AAT`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `List memory and retrieval`﹖ | 1 | 1 | 19 | 0.15 | U O* | hd |  |
| `Events and boundaries`﹖ | 1 | 1 | 12 | 0.09 | U O* | hd |  |
| `Consolidation and schemas`﹖ | 1 | 1 | 14 | 0.11 | U O* | hd |  |
| `What the agent-memory theory adds`﹖ | 1 | 1 | 13 | 0.10 | U O* | hd |  |

### Analysis-index

**Total Files**: 1  
**Total Lines**: 1,038  
**Where**: TST principle analyses 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 8 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `Let It Crash` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Property-Based Testing` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Macro Restraint` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Notes on Related Analyses` | 1 | 1 | 7 | 0.01 | U R* | hd |  |
| `Comprehensive Analysis Table` | 1 | 1 | 965 | 0.93 | U R* | hd |  |
| `Summary Statistics` | 1 | 1 | 55 | 0.05 | U R* | hd | holds 4 named ### parts in 1 file, each with fields Completed, Pending TODO, Total Coverage, ✅ Exemplar Quality, ⚠️ Needs Rework, 📊 Good Quality (+10 more) |

### Appendix

**Total Files**: 1  
**Total Lines**: 56  
**Where**: agent memory survey 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the segment's name / one-line claim |
| `Features read from the modes` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `What was tried` | 1 | 1 | 11 | 0.20 | U R* | hd |  |
| `Results so far` | 1 | 1 | 34 | 0.61 | U R* | hd |  |
| `The next step, if pursued` | 1 | 1 | 8 | 0.14 | U R* | hd |  |

### Glossary

**Total Files**: 1  
**Total Lines**: 139  
**Where**: agent memory survey 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.01 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `A` | 1 | 1 | 8 | 0.06 | U R* | hd |  |
| `B` | 1 | 1 | 5 | 0.04 | U R* | hd |  |
| `C` | 1 | 1 | 9 | 0.06 | U R* | hd |  |
| `D` | 1 | 1 | 6 | 0.04 | U R* | hd |  |
| `E` | 1 | 1 | 9 | 0.06 | U R* | hd |  |
| `F` | 1 | 1 | 8 | 0.06 | U R* | hd |  |
| `G` | 1 | 1 | 7 | 0.05 | U R* | hd |  |
| `H` | 1 | 1 | 5 | 0.04 | U R* | hd |  |
| `I` | 1 | 1 | 8 | 0.06 | U R* | hd |  |
| `L` | 1 | 1 | 7 | 0.05 | U R* | hd |  |
| `M` | 1 | 1 | 8 | 0.06 | U R* | hd |  |
| `N` | 1 | 1 | 7 | 0.05 | U R* | hd |  |
| `P` | 1 | 1 | 14 | 0.10 | U R* | hd |  |
| `R` | 1 | 1 | 11 | 0.08 | U R* | hd |  |
| `S` | 1 | 1 | 14 | 0.10 | U R* | hd |  |
| `T` | 1 | 1 | 9 | 0.06 | U R* | hd |  |

### Story

**Total Files**: 1  
**Total Lines**: 186  
**Where**: agent memory survey 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 3 | 0.02 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `Interference` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Abstraction without storing abstractions` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `The frame` | 1 | 1 | 15 | 0.08 | U R* | hd |  |
| `Forgetting is a bet on future need` | 1 | 1 | 20 | 0.11 | U R* | hd |  |
| `Retrieval is resemblance, and what comes back is a blend` | 1 | 1 | 20 | 0.11 | U R* | hd |  |
| `Context` | 1 | 1 | 29 | 0.16 | U R* | hd |  |
| `Events` | 1 | 1 | 29 | 0.16 | U R* | hd |  |
| `Two learning systems` | 1 | 1 | 26 | 0.14 | U R* | hd |  |
| `The unifying idea` | 1 | 1 | 17 | 0.09 | U R* | hd |  |
| `What this means for agents, and how firmly` | 1 | 1 | 23 | 0.12 | U R* | hd |  |

### Supplement

**Total Files**: 1  
**Total Lines**: 84  
**Where**: AAT summary walk 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | title (human-readable, no fixed form) |
| `Numbering map and gaps` | 1 | 1 | 45 | 0.54 | U R* | hd |  |
| `UX / clarity flags worth surfacing` | 1 | 1 | 26 | 0.31 | U R* | hd | holds 3 named ### parts in 1 file |
| `What didn't trip me up` | 1 | 1 | 4 | 0.05 | U R* | hd |  |
| `One stylistic observation, take or leave` | 1 | 1 | 6 | 0.07 | U R* | hd |  |

### Outline

**Total Files**: 1  
**Total Lines**: 49  
**Where**: aat-refactored 1  
**Shape declared in**: HANDOFF.md (formal, delivery, working-notes layers)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the title |
| `Spine` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Rails` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Frontispiece` | 1 | 1 | 9 | 0.18 | U R* | hd |  |
| `Introduction` | 1 | 1 | 4 | 0.08 | U R* | hd |  |
| `Part I — Adaptive Systems` | 1 | 1 | 33 | 0.67 | U R* | hd | holds 1 named ### parts in 1 file; 2 ### chapters in 1 file |
## Predecessor theories

### Theorem

**Total Files**: 15  
**Total Lines**: 1,196  
**Where**: TST vault theory 15  
**Shape declared in**: frontmatter type: Theorem; no theorem template in vault/00-operations/templates

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Label` | 15 | 15 | 15 | 0.01 | U R* | fm | T-NN |
| `Type` | 15 | 15 | 17 | 0.01 | U R* | fm | Theorem (t01: list Theorem, Axiom) |
| `Subtype` | 15 | 15 | 15 | 0.01 | U R* | fm | epistemic subtype |
| `Name` | 15 | 15 | 15 | 0.01 | U R* | fm | name |
| `Dependencies` | 15 | 15 | 45 | 0.04 | U R* | fm | segments it depends on |
| `Revision` | 15 | 15 | 15 | 0.01 | U R* | fm | revision number |
| `(Slug)` | 15 | 15 | 15 | 0.01 | U* R* | if |  |
| `(Title)` | 15 | 15 | 15 | 0.01 | U* R* | im | title carrying the subtype |
| `Older-tag`﹖ | 13 | 13 | 13 | 0.01 | U O* | fm | FP-NNN it came from |
| `(Preamble)`﹖ | 11 | 11 | 176 | 0.15 | U* O* | im |  |
| `Discussion`﹖ | 14 | 14 | 338 | 0.28 | U O* | hd | stable "## Discussion: <title>" with ad hoc ### under it; holds 7 named ### parts in 3 files; 1 ### item in 1 file |
| `Statement`﹖ | 11 | 11 | 11 | 0.01 | U O* | la |  |
| `Justification`﹖ | 10 | 10 | 10 | 0.01 | U O* | la |  |
| `Boundary Conditions`﹖ | 8 | 8 | 8 | 0.01 | U O* | la |  |
| *(131 minor slots)* |  |  | 842 | 0.70 | U O* |  | listed below |

*Minor and undeclared slots:* Critical Insight (7), Empirical (5), Formal Definitions (4), Practical (3), Formal Definitions › Theorem Statement (4), Formal Definitions › Formal Expression (4), … (+125 more)

### First Principle (Fp-nnn Block)

**Total Files**: 13  
**Total Lines**: 826  
**Where**: TST vault theory 13  
**Shape declared in**: sub-file blocks of principles/software-first-principles.md (877 lines). The same file is byte-identical in ~/vaults/Principles and ~/vaults/gemini/foundation: c

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Statement` | 13 | 13 | 39 | 0.05 | D R | hd | the principle in words; vault templates/principle-note.md declares Statement |
| `Formal Expression` | 13 | 13 | 138 | 0.17 | U R* | hd | the math (with ### Simple/Probabilistic/... Form); template calls the slot "Mathematical Formalization" |
| `Justification` | 13 | 13 | 70 | 0.08 | U R* | hd | why it holds |
| `Discussion`﹖ | 12 | 12 | 401 | 0.49 | U O* | hd | discussion |
| `Boundary Conditions`﹖ | 11 | 11 | 55 | 0.07 | U O* | hd | where it stops holding |
| `Intuition` | 0 | 0 | 0 | 0.00 | D R | hd | intuitive explanation; declared, filled by no file |
| `Mathematical Formalization` | 0 | 0 | 0 | 0.00 | D R | hd | template's name for the math slot; declared, filled by no file |
| `Practical Implications` | 0 | 0 | 0 | 0.00 | D R | hd | architecture/design implications; declared, filled by no file |
| `Measurements` | 0 | 0 | 0 | 0.00 | D R | hd | metrics and quantification; declared, filled by no file |
| *(1 minor slots)* |  |  | 45 | 0.05 | U O* |  | listed below |

*Minor and undeclared slots:* Notes (2), critical insight; implications

### Theorem (T-nn)

**Total Files**: 12  
**Total Lines**: 679  
**Where**: Temporal Software Theory 12  
**Shape declared in**: declared (README ToC Type)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `T-NN: Name (Type)` | 12 | 12 | 691 | 1.02 | D R* | hd | title carrying the epistemic type |
| `Formal Expression` | 12 | 12 | 154 | 0.23 | U R* | hd | the math; the one stable slot: 12/12 |
| `Why This ... (motivation family)`﹖ | 9 | 9 | 94 | 0.14 | U O* | hd | "Why This Matters / Changes Everything / Isn't a Heuristic / Matters for Extreme Turnover"; one recurring family of prose headings |
| `Corollary / Hypothesis / Derivation (embedded)`﹖ | 4 | 4 | 74 | 0.11 | D O* | hd | sub-results embedded in the theorem block; README addresses them by anchor |
| *(3 minor slots)* |  |  | 321 | 0.47 | U O* |  | listed below |

*Minor and undeclared slots:* Limitations and Qualifications (2), Scope Definition (1), Discussion (1), … (+1 more)

### Definition (D-nn)

**Total Files**: 8  
**Total Lines**: 64  
**Where**: Temporal Software Theory 8  
**Shape declared in**: declared (README ToC Type)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Definition

**Total Files**: 8  
**Total Lines**: 133  
**Where**: TST vault theory 8  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Label` | 8 | 8 | 8 | 0.06 | U R* | fm | D-NN |
| `Type` | 8 | 8 | 8 | 0.06 | U R* | fm | Definition |
| `Name` | 8 | 8 | 8 | 0.06 | U R* | fm | name |
| `Dependencies` | 8 | 8 | 8 | 0.06 | U R* | fm | dependencies |
| `Revision` | 8 | 8 | 8 | 0.06 | U R* | fm | revision |
| `(Slug)` | 8 | 8 | 8 | 0.06 | U* R* | if |  |
| `(Preamble)` | 8 | 8 | 40 | 0.30 | U* R* | im |  |
| `(Title)` | 8 | 8 | 8 | 0.06 | U* R* | im | title; body is the definition |
| *(7 minor slots)* |  |  | 15 | 0.11 | U O* |  | listed below |

*Minor and undeclared slots:* Older-tag (2), Discussion (1), Key Principle (1), Lexical distance (1), File distance (1), Module distance (1), Service distance (1)

### Corollary (C-nn.n)

**Total Files**: 5  
**Total Lines**: 36  
**Where**: Temporal Software Theory 5  
**Shape declared in**: declared (README ToC Type)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|

### Moc

**Total Files**: 1  
**Total Lines**: 123  
**Where**: TST vault theory 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `📐 Core Components` | 1 | 1 | 56 | 0.46 | U R* | hd | holds 3 named ### parts in 1 file |
| `🔬 Key Insights` | 1 | 1 | 20 | 0.16 | U R* | hd | holds 3 ### key insights in 1 file, each with fields Comprehension, Change Impact, Lindy Effect |
| `📊 Applications` | 1 | 1 | 15 | 0.12 | U R* | hd | holds 2 named ### parts in 1 file, each with fields Architecture Decisions, Refactoring ROI, Module Boundaries, Technical Debt |
| `🔗 Related Documents` | 1 | 1 | 12 | 0.10 | U R* | hd | holds 2 named ### parts in 1 file |
| `📈 Theory Evolution` | 1 | 1 | 17 | 0.14 | U R* | hd | holds 2 named ### parts in 1 file |

### Readme (Toc)

**Total Files**: 1  
**Total Lines**: 59  
**Where**: Temporal Software Theory 1  
**Shape declared in**: n/a (the outline)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `The cognitive shift we seek` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Table of Contents` | 1 | 1 | 34 | 0.58 | U R* | hd |  |
| `The Synthesis` | 1 | 1 | 22 | 0.37 | U R* | hd |  |
## Papers, essays, books and applications

### Essay-part

**Total Files**: 39  
**Total Lines**: 2,320  
**Where**: ELI essays (Feb 2026) 39  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 39 | 39 | 39 | 0.02 | U* R* | if |  |
| `(Title)` | 39 | 39 | 39 | 0.02 | U* R* | im | title: essay and movement number |
| `(Title › Essay 5, Part N)`﹖ | 9 | 9 | 9 | 0.00 | U* O* | im |  |
| `(Title › Essay 3, Part N)`﹖ | 8 | 8 | 8 | 0.00 | U* O* | im |  |
| `(Title › Essay 4, Part N)`﹖ | 8 | 8 | 8 | 0.00 | U* O* | im |  |
| `(Title › Essay 1, Part N)`﹖ | 7 | 7 | 7 | 0.00 | U* O* | im |  |
| `(Title › Essay 2, Part N)`﹖ | 7 | 7 | 7 | 0.00 | U* O* | im |  |
| `Source` ➕ | 277 | 39 | 277 | 0.12 | U R* | la | where the material came from |
| `Topic Summary` | 39 | 39 | 117 | 0.05 | U R* | hd | what this essay part is about |
| `Reference 1 (score` | 39 | 39 | 292 | 0.13 | U R* | hd |  |
| `Reference 2 (score` | 39 | 39 | 281 | 0.12 | U R* | hd |  |
| `Reference 3 (score` | 39 | 39 | 267 | 0.12 | U R* | hd |  |
| `Reference 4 (score` | 39 | 39 | 252 | 0.11 | U R* | hd | holds 1 ### item in 1 file |
| `Reference 5 (score` | 39 | 39 | 238 | 0.10 | U R* | hd |  |
| `Coverage Notes` | 39 | 39 | 303 | 0.13 | U R* | hd | what the references cover and miss |
| `Reference 6 (score`﹖ | 33 | 33 | 189 | 0.08 | U O* | hd |  |
| `Reference 7 (score`﹖ | 24 | 24 | 142 | 0.06 | U O* | hd |  |
| *(68 minor slots)* |  |  | 384 | 0.17 | U O* |  | listed below |

*Minor and undeclared slots:* Reference 8 (score (14), Type (8), Reference 9 (score (7), Replaced (6), Gap (4), Reference 10 (score (4), THE DIRECTIONALITY CIRCUIT (3), Excluded (2), Collapsed (2), … (+59 more)

### Essay-part

**Total Files**: 39  
**Total Lines**: 2,291  
**Where**: ELI essays quote bank (explication 39  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 39 | 39 | 39 | 0.02 | U* R* | if |  |
| `(Title)` | 39 | 39 | 39 | 0.02 | U* R* | im | title: essay and movement number |
| `(Title › Essay 5, Part N)`﹖ | 9 | 9 | 9 | 0.00 | U* O* | im |  |
| `(Title › Essay 3, Part N)`﹖ | 8 | 8 | 8 | 0.00 | U* O* | im |  |
| `(Title › Essay 4, Part N)`﹖ | 8 | 8 | 8 | 0.00 | U* O* | im |  |
| `(Title › Essay 1, Part N)`﹖ | 7 | 7 | 7 | 0.00 | U* O* | im |  |
| `(Title › Essay 2, Part N)`﹖ | 7 | 7 | 7 | 0.00 | U* O* | im |  |
| `Source` ➕ | 277 | 39 | 277 | 0.12 | U R* | la | where the material came from |
| `Topic Summary` | 39 | 39 | 117 | 0.05 | U R* | hd | what this essay part is about |
| `Reference 1 (score` | 39 | 39 | 289 | 0.13 | U R* | hd |  |
| `Reference 2 (score` | 39 | 39 | 279 | 0.12 | U R* | hd |  |
| `Reference 3 (score` | 39 | 39 | 264 | 0.12 | U R* | hd |  |
| `Reference 4 (score` | 39 | 39 | 250 | 0.11 | U R* | hd | holds 1 ### item in 1 file |
| `Reference 5 (score` | 39 | 39 | 232 | 0.10 | U R* | hd |  |
| `Coverage Notes` | 39 | 39 | 303 | 0.13 | U R* | hd | what the references cover and miss |
| `Reference 6 (score`﹖ | 33 | 33 | 188 | 0.08 | U O* | hd |  |
| `Reference 7 (score`﹖ | 24 | 24 | 141 | 0.06 | U O* | hd |  |
| *(68 minor slots)* |  |  | 372 | 0.16 | U O* |  | listed below |

*Minor and undeclared slots:* Reference 8 (score (14), Type (8), Reference 9 (score (7), Replaced (6), Gap (4), Reference 10 (score (4), THE DIRECTIONALITY CIRCUIT (3), Excluded (2), Collapsed (2), … (+59 more)

### Text (Binder Document)

**Total Files**: 38  
**Total Lines**: —  
**Where**: Simplex material (Scrivener) 38  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Status (binder)`﹖ | 25 | 25 | 25 | 25.00 | D O* | fm | adjudication state per piece; values: To Do 16, First Draft 6, Outlined 2, In Progress 1; list: No Status, To Do, In Progress, Outlined, First Draft, Revised Draft, Final Draft, Done |
| `Synopsis (binder)`﹖ | 17 | 17 | 17 | 17.00 | D O* | fm | index-card synopsis |
| `Label (binder)`﹖ | 0 | 0 | 0 | 0.00 | D O* | fm | label; declared, filled by no file |

### Research Note / Report

**Total Files**: 38  
**Total Lines**: 17,294  
**Where**: vault: Principles 38  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 38 | 38 | 38 | 0.00 | U* R* | if |  |
| `(Title)`﹖ | 34 | 34 | 34 | 0.00 | U* O* | im |  |
| `(Title › Guidelines for an Idealized Multi-Agent Truth-Seeking System)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| `(Title › An Epistemological Architecture for AI)`﹖ | 3 | 3 | 3 | 0.00 | U* O* | im |  |
| `Conclusion`﹖ | 20 | 20 | 1,515 | 0.09 | U O* | hd |  |
| *(1179 minor slots)* |  |  | 26,392 | 1.53 | U O* |  | listed below |

*Minor and undeclared slots:* (Preamble) (16), Executive Summary (9), MiniCheck (8), Constitutional AI (8), Implementation Framework (7), Institutional incentive analysis (6), Alignment (6), Action (6), Observation (6), Orientation (6), Burden of proof standards (5), Cross-examination (5), Chain of custody (5), Falsifiability requirement (5), Peer review (5), Red team analysis (5), Compartmentalization (5), Differential diagnosis (5), Evidence hierarchies (5), Method (5), Key Insight (5), Prediction tracking (5), Confidence calibration (5), Domain expertise validation (5), Adversarial robustness (5), Implementation Strategy (5), Implementation (5), Objective (5), Outcome tracking (4), Correction procedures (4), Bottom Line (4), Footnotes (4), Measurement (4), Key Finding (3), Critical Distinction (3), Epistemological reasoning (3), Multi-agent adversarial verification (3), Uncertainty quantification (3), Ubiquitous languages (3), Bounded contexts (3), Collaborative prompt development (3), The Core Problem (3), Replication (3), Source reliability tracking (3), Bayesian reasoning (3), Focus (3), Output (3), Agents are designed to disagree (3), Specialized contexts (3), Parallel processing (3), Empirical accountability (3), Tiered processing (3), Caching (3), Domain routing (3), System Enhancement (3), Immediate (3), Medium-term (3), Long-term (3), Initial Assessment (3), Foundation Documents (3), The Bootstrap Problem (3), The Adversarial Multi-Agent Solution (3), Integration with Modern AI Capabilities (3), Key Insights and Novel Contributions (3), Critical Gaps and Future Development (3), Application Layer (3), Risk Mitigation (3), Core Identity Layer (3), Foundational Knowledge Layer (3), Episodic Memory Layer (3), Working Context (3), Knowledge Distillation (3), Performance-Weighted Integration (3), Semantic Deduplication (3), Temporal Decay (3), Few-Shot Learning Updates (3), Chain-of-Thought Refinement (3), Meta-Prompting (3), Role Adherence (3), Context Efficiency (3), Learning Velocity (3), Generalization (3), Resource Efficiency (3), For Opus 4.1 (3), For Sonnet N (3), Context Caching Strategy (3), Batch Processing (3), Context Management Architecture (3), State Persistence Patterns (3), Reinforcement Mechanisms (3), Multi-Agent Context Sharing (3), Claude API Optimization Strategies (3), Implementation Architecture (3), Performance Monitoring and Optimization (3), Specific Claude API Recommendations (3), Hierarchical Principle Architecture for Claude API (3), Enhanced Implementation Architecture (3), Claude API Optimization for Principle-Based Reasoning (3), Key Differences from Standard Agentic Systems (3), Target (3), Mandatory challenge (3), Multi-perspective synthesis (3), Temporal dynamics (3), What MiniCheck Does Well (3), What MiniCheck Misses (3), No uncertainty quantification (3), No adversarial testing (3), No institutional analysis (3), Single domain approach (3), No temporal dynamics (3), Our System Enhancement (3), What Constitutional AI Does Well (3), What Constitutional AI Misses (3), Limited to harmlessness, not truth-seeking (3), Self-supervision limitations (3), No adversarial epistemology (3), Abstract principles (3), No domain specialization (3), Combined Strengths (3), Novel Contributions (3), Multi-domain epistemological framework (3), Adversarial truth architecture (3), Institutional game theory (3), Calibrated uncertainty quantification (3), Cross-domain synthesis (3), Core Design Philosophy (3), System Architecture (3), Comparison with Existing Systems (3), Abstract and Compositional Reasoning (3), Causal and Logical Reasoning (3), Mathematical and Scientific Reasoning (3), Inflexible Reasoning and Cognitive Fixation (3), Hallucination (3), Sycophancy (3), Misattribution and Decontextualization (3), Coordination and Communication Overhead (3), Conflict Resolution (3), Scalability and Emergent Behavior (3), Ubiquitous Language and Bounded Contexts (3), Domain Classification (3), Context Contracts (3), Critique (3), Tree of Thoughts (3), Atemporal (3), Static (3), Dynamic (3), Integration with the Epistemic Tribunal (3), Adversarial Robustness Testing (3), Agent Hijacking Simulations (3), Monitoring for Collusion (3), Descriptive Claims (3), Normative Claims (3), Mixed Claims (3), The Reasoning Deficit (3), The Natural Selection of Truth (3), An Epistemic Tribunal for AI (3), Architectural Integration and Comparative Performance (3), Addressing Critical Gaps and Charting the Path Forward (3), Mathematical (3), … (+1013 more)

### Section-cont

**Total Files**: 35  
**Total Lines**: 475  
**Where**: Granted agency paper 35  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 35 | 35 | 35 | 0.07 | U* R* | if |  |
| *(22 minor slots)* |  |  | 510 | 1.07 | U O* |  | listed below |

*Minor and undeclared slots:* Why these conditions, on what warrant (2), Necessary, not sufficient (2), Engaged-identity scoping (2), Component 1 — A non-zero sphere of autonomous action (2), … (+18 more)

### Appendix-cont

**Total Files**: 30  
**Total Lines**: 371  
**Where**: NeurIPS 01 tragedy (paper) 30  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 30 | 30 | 30 | 0.08 | U* R* | if |  |
| `Table`﹖ | 6 | 6 | 53 | 0.14 | D O* | ot | table with caption and anchor |
| `Lemma`﹖ | 1 | 1 | 6 | 0.02 | D O* | ot | lemma block |
| `Proposition`﹖ | 1 | 1 | 2 | 0.01 | D O* | ot | proposition block |
| `Theorem`﹖ | 1 | 1 | 12 | 0.03 | D O* | ot | theorem block |
| *(36 minor slots)* |  |  | 407 | 1.10 | U O* |  | listed below |

*Minor and undeclared slots:* The dual-drive picture (1), From $Uo$ to information yield (1), Inverse-uncertainty form (1), Margin-triggered form (1), … (+32 more)

### Paper

**Total Files**: 28  
**Total Lines**: 4,792  
**Where**: ops paper portfolio 28  
**Shape declared in**: format.md; format.md: six sections in fixed order, each only when it has content; fm:epistemic_note in 27 of 28 is not in the spec

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 28 | 28 | 28 | 0.01 | D R | fm | identity |
| `Title` | 28 | 28 | 28 | 0.01 | D R | fm | title |
| `Status` | 28 | 28 | 28 | 0.01 | D R | fm | standing |
| `Status note`﹖ | 28 | 28 | 227 | 0.05 | D O | fm | one-line context for the status |
| `Target venue` | 28 | 28 | 28 | 0.01 | D R | fm | primary venue |
| `Target venue.name` | 28 | 28 | 28 | 0.01 | U R* | fm |  |
| `Target venue.url` | 28 | 28 | 28 | 0.01 | U R* | fm |  |
| `Target venue.deadline` | 28 | 28 | 28 | 0.01 | U R* | fm |  |
| `Substrate` | 28 | 28 | 239 | 0.05 | D R | fm | paths to source material |
| `Depends on`﹖ | 28 | 28 | 34 | 0.01 | D O | fm | papers that must exist first |
| `Unblocks`﹖ | 28 | 28 | 38 | 0.01 | D O | fm | papers this enables |
| `Effort estimate` | 28 | 28 | 28 | 0.01 | D R | fm | honest assembly time |
| `Epistemic status` | 28 | 28 | 28 | 0.01 | D R | fm | Proven / Tested / Hypothesis / Pattern / Guess |
| `Last decision` | 28 | 28 | 28 | 0.01 | D R | fm | date of last state change |
| `Secondary venues`﹖ | 27 | 27 | 52 | 0.01 | D O | fm | ranked alternatives |
| `Epistemic note`﹖ | 27 | 27 | 193 | 0.04 | U O* | fm | gloss on the epistemic status |
| `Legacy ids`﹖ | 27 | 27 | 89 | 0.02 | D O | fm | old ids for crosswalk |
| `Cluster`﹖ | 26 | 26 | 26 | 0.01 | D O | fm | cluster slug |
| `Secondary venues.deadline`﹖ | 20 | 20 | 20 | 0.00 | U O* | fm |  |
| `Secondary venues.url`﹖ | 18 | 18 | 18 | 0.00 | U O* | fm |  |
| `Secondary venues.note`﹖ | 14 | 14 | 43 | 0.01 | U O* | fm |  |
| `Thesis`﹖ | 28 | 28 | 446 | 0.09 | D O | hd | the core claim in one paragraph |
| `Substrate`﹖ | 28 | 28 | 529 | 0.11 | D O | hd | where the material lives, with one-line notes |
| `Novelty`﹖ | 28 | 28 | 735 | 0.15 | D O | hd | what is new against named predecessors |
| `Status & timing`﹖ | 28 | 28 | 390 | 0.08 | D O | hd | state, blockers, deadlines |
| `Open decisions`﹖ | 28 | 28 | 793 | 0.17 | D O | hd | pending framing and scope questions |
| `Cluster context`﹖ | 15 | 15 | 264 | 0.06 | D O | hd | how the paper sits in its cluster decision |
| *(117 minor slots)* |  |  | 150 | 0.03 | U O* |  | listed below |

*Minor and undeclared slots:* Effort honest estimate (7), Target venue.note (3), Venue timing (3), Empirical anchor (2), Empirical anchoring (2), Submission target (2), Companion-paper citation pattern (2), … (+110 more)

### Text (Scrivener 2 Document)

**Total Files**: 22  
**Total Lines**: —  
**Where**: Novel draft (Scrivener 2) 22  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Synopsis (binder)`﹖ | 19 | 19 | 19 | 19.00 | D O* | fm | index-card synopsis; synopses also exist for items without text |

### Research Note / Report

**Total Files**: 20  
**Total Lines**: 17,955  
**Where**: vault: gemini foundation 20  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 20 | 20 | 20 | 0.00 | U* R* | if |  |
| `(Title)`﹖ | 17 | 17 | 17 | 0.00 | U* O* | im |  |
| *(747 minor slots)* |  |  | 28,019 | 1.56 | U O* |  | listed below |

*Minor and undeclared slots:* Conclusion (9), Executive Summary (8), Implementation Roadmap (5), Statistical Significance (3), Effect Size (3), Correlation Strength (3), Cross-Validation (3), Development Velocity (3), Code Quality (3), MiniCheck (3), Constitutional AI (3), Key Insight (3), Implementation Framework (3), (Preamble) (3), … (+729 more)

### Prep-doc

**Total Files**: 16  
**Total Lines**: 2,173  
**Where**: Paper 4 prep substrate 16  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 16 | 16 | 16 | 0.01 | U* R* | if |  |
| `(Preamble)`﹖ | 15 | 15 | 131 | 0.06 | U* O* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)`﹖ | 15 | 15 | 15 | 0.01 | U* O* | im | the title |
| *(149 minor slots)* |  |  | 2,266 | 1.04 | U O* |  | listed below |

*Minor and undeclared slots:* Locked strategic decisions (1), Architecture — proposed section structure (1), Read-order for the orientation pass (1), Anonymization protocol (1), After the orientation pass (1), … (+144 more)

### Guide Section (Copy)

**Total Files**: 14  
**Total Lines**: 2,540  
**Where**: vault: gemini foundation 14  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 14 | 14 | 14 | 0.01 | U* R* | if |  |
| `References`﹖ | 12 | 12 | 168 | 0.07 | U O* | hd |  |
| *(137 minor slots)* |  |  | 3,641 | 1.43 | U O* |  | listed below |

*Minor and undeclared slots:* (Title) (3), Core Identity Layer (1), Foundational Knowledge Layer (1), Episodic Memory Layer (1), Working Context (1), Knowledge Distillation (1), … (+131 more)

### Text (Binder Document)

**Total Files**: 13  
**Total Lines**: —  
**Where**: Reflections (Scrivener) 13  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Status (binder)`﹖ | 1 | 1 | 1 | 1.00 | D O* | fm | adjudication state per piece; values: First Draft 1; list: No Status, To Do, In Progress, First Draft, Revised Draft, Final Draft, Done |
| `Synopsis (binder)`﹖ | 1 | 1 | 1 | 1.00 | D O* | fm | index-card synopsis |
| `Label (binder)`﹖ | 0 | 0 | 0 | 0.00 | D O* | fm | label; declared, filled by no file |

### Section

**Total Files**: 13  
**Total Lines**: 133  
**Where**: Granted agency paper 13  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 13 | 13 | 13 | 0.10 | U* R* | if |  |
| `(Preamble)` | 13 | 13 | 60 | 0.45 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 13 | 13 | 13 | 0.10 | U* R* | im | the title |

### Guide Section

**Total Files**: 12  
**Total Lines**: 1,933  
**Where**: vault: clean_split 12  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 12 | 12 | 12 | 0.01 | U* R* | if |  |
| `References` | 12 | 12 | 168 | 0.09 | U R* | hd | that section's citations |
| *(70 minor slots)* |  |  | 2,969 | 1.54 | U O* |  | listed below |

*Minor and undeclared slots:* Breakthrough Enterprise Features Include (1), Magma (1), Bring Your Own Virtual Network (1), Native MCP Integration (1), Key Differentiators (1), Native Vertex Integration (1), … (+64 more)

### Blind-spot-card

**Total Files**: 12  
**Total Lines**: 592  
**Where**: ais (eoi cards) 12  
**Shape declared in**: src/README.md §Card shape (six parts)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 12 | 12 | 12 | 0.02 | U R* | fm | identity (= filename) |
| `Form` | 12 | 12 | 12 | 0.02 | U R* | fm | speech-act kind |
| `State` | 12 | 12 | 12 | 0.02 | U R* | fm | process-state flags |
| `Voice` | 12 | 12 | 12 | 0.02 | U R* | fm | who wrote it |
| `(Title)` | 12 | 12 | 12 | 0.02 | U* R* | im | the segment's name / one-line claim |
| `The question they don't know to ask` | 12 | 12 | 48 | 0.08 | D R* | hd | the blind spot in one sentence |
| `Why it's invisible from where they stand` | 12 | 12 | 78 | 0.13 | D R* | hd | mechanism of the blindness |
| `Where it already surfaces in their text` | 12 | 12 | 152 | 0.26 | D R* | hd | verbatim specimen from their own text |
| `What makes it real` | 12 | 12 | 95 | 0.16 | D R* | hd | pointers to Joseph's work behind it |
| `The open research question` | 12 | 12 | 48 | 0.08 | D R* | hd | the question, standing even if the hypothesis fails |
| `The project that follows` | 12 | 12 | 74 | 0.12 | D R* | hd | startable project |
| *(13 minor slots)* |  |  | 16 | 0.03 | U O* |  | listed below |

*Minor and undeclared slots:* Joseph, reframe rung N (4), Joseph's lived evidence, a year of it (1), ASF, the formal mechanism (1), The escape, formally (1), ASF, derived (1), … (+8 more)

### Scratch-note

**Total Files**: 11  
**Total Lines**: 2,019  
**Where**: Paper 4 prep substrate 11  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 11 | 11 | 11 | 0.01 | U* R* | if |  |
| `(Preamble)` | 11 | 11 | 90 | 0.04 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 11 | 11 | 11 | 0.01 | U* R* | im | the title |
| *(77 minor slots)* |  |  | 2,128 | 1.05 | U O* |  | listed below |

*Minor and undeclared slots:* Don't-regress list (2), (Work) (2), (Work) › FLAG (2), Disposition driving this pass (1), Gems added, by segment (1), … (+72 more)

### Section

**Total Files**: 10  
**Total Lines**: 234  
**Where**: ACA paper 10  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 10 | 10 | 10 | 0.04 | U* R* | if |  |
| `(Title)` | 10 | 10 | 10 | 0.04 | U* R* | im | the title |
| `(Preamble)`﹖ | 7 | 7 | 18 | 0.08 | U* O* | im | unheaded text between the title and the first section (summary line, status line) |
| *(26 minor slots)* |  |  | 188 | 0.80 | U O* |  | listed below |

*Minor and undeclared slots:* What is being claimed (1), Comprehension is a collapse, not a survey (1), Three things it is not (1), Why the configuration is not rare (1), The Blub paradox (1), … (+21 more)

### Section

**Total Files**: 10  
**Total Lines**: 818  
**Where**: causal-language 10  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 10 | 10 | 10 | 0.01 | U* R* | if |  |
| `(Title)` | 10 | 10 | 10 | 0.01 | D* R | im | the title |
| `(Preamble)`﹖ | 5 | 5 | 308 | 0.38 | U* O* | im | unheaded text between the title and the first section (summary line, status line) |
| *(29 minor slots)* |  |  | 468 | 0.57 | U O* |  | listed below |

*Minor and undeclared slots:* Summary (3), What Theorem 1 does not establish (1), Setup (1), Three postulates (1), Theorem N (1), The C1/C2/C3/C4 mechanism framework (1), … (+23 more)

### Think

**Total Files**: 10  
**Total Lines**: 1,151  
**Where**: Paper 4 prep substrate 10  
**Shape declared in**: declared by each file's banner: prediction check (the gate), then diffuse exploration (Joseph's structure 2026-05-31)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 10 | 10 | 10 | 0.01 | U* R* | if |  |
| `(Preamble)` | 10 | 10 | 35 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 10 | 10 | 10 | 0.01 | U* R* | im | the title |
| `Prediction check`﹖ | 8 | 8 | 169 | 0.15 | D O* | hd | prediction before reading, checked against the text (the gate) |
| `Diffuse exploration`﹖ | 7 | 7 | 384 | 0.33 | D O* | hd | open exploration after the check (the flow) |
| `Second-thoughts targets`﹖ | 7 | 7 | 39 | 0.03 | U O* | hd | what to re-read or verify next |
| `Right`﹖ | 5 | 5 | 5 | 0.00 | U O* | la | prediction-check verdict line |
| `Composition takeaways`﹖ | 5 | 5 | 45 | 0.04 | U O* | hd | what the reading gives the draft |
| *(47 minor slots)* |  |  | 478 | 0.42 | U O* |  | listed below |

*Minor and undeclared slots:* Wrong, and this is the valuable part (1), Surprise I didn't predict (1), A possibility I want to leave open and not resolve yet (1), What I'd want to verify (1), But (1), … (+42 more)

### Appendix

**Total Files**: 9  
**Total Lines**: 188  
**Where**: NeurIPS 01 tragedy (paper) 9  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 9 | 9 | 9 | 0.05 | U* R* | if |  |
| `Table`﹖ | 2 | 2 | 23 | 0.12 | D O* | ot | table with caption and anchor |
| *(15 minor slots)* |  |  | 244 | 1.30 | U O* |  | listed below |

*Minor and undeclared slots:* The Lyapunov-Survival Exploration Drive (1), The Blank-Wall Attack and the LMI Lift (1), Empirical Illustration (1), Empirical Illustration › Setup (1), Discussion (1), … (+10 more)

### Section

**Total Files**: 9  
**Total Lines**: 374  
**Where**: NeurIPS 02 pre-restructure segment 9  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 9 | 9 | 9 | 0.02 | U* R* | if |  |
| `Theorem`﹖ | 4 | 4 | 46 | 0.12 | D O* | ot | theorem block |
| `Corollary`﹖ | 1 | 1 | 4 | 0.01 | D O* | ot | corollary block |
| `Lemma`﹖ | 1 | 1 | 4 | 0.01 | D O* | ot | lemma block |
| `Proof`﹖ | 1 | 1 | 8 | 0.02 | D O* | ot | proof block |
| *(19 minor slots)* |  |  | 455 | 1.22 | U O* |  | listed below |

*Minor and undeclared slots:* Introduction (1), Introduction › Contribution (1), Introduction › Scope and limitations (1), Setup (1), Component 1 — The Two-Gap Diagnostic (1), … (+14 more)

### Section

**Total Files**: 9  
**Total Lines**: 268  
**Where**: behavioral-floor 9  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 9 | 9 | 9 | 0.03 | U* R* | if |  |
| `(Title)` | 9 | 9 | 9 | 0.03 | D* R | im | the title |
| `(Preamble)`﹖ | 7 | 7 | 65 | 0.24 | U* O* | im | unheaded text between the title and the first section (summary line, status line) |
| *(6 minor slots)* |  |  | 163 | 0.61 | U O* |  | listed below |

*Minor and undeclared slots:* Inherited Versus Fresh Pearl Level 2 Content (1), Encoded Versus Deployed Content (1), The Goal-Update Coupling Classification (1), … (+3 more)

### Section-full

**Total Files**: 9  
**Total Lines**: 435  
**Where**: behavioral-floor 9  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 9 | 9 | 9 | 0.02 | U* R* | if |  |
| `(Title)` | 9 | 9 | 9 | 0.02 | D* R | im | the title |
| `(Preamble)`﹖ | 7 | 7 | 102 | 0.23 | U* O* | im | unheaded text between the title and the first section (summary line, status line) |
| *(6 minor slots)* |  |  | 256 | 0.59 | U O* |  | listed below |

*Minor and undeclared slots:* Inherited Versus Fresh Pearl Level 2 Content (1), Encoded Versus Deployed Content (1), The Goal-Update Coupling Classification (1), … (+3 more)

### Cluster

**Total Files**: 9  
**Total Lines**: 421  
**Where**: ops paper portfolio 9  
**Shape declared in**: no spec in format.md, yet uniform across all 9

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 9 | 9 | 9 | 0.02 | U* R* | if |  |
| `(Preamble)` | 9 | 9 | 27 | 0.06 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 9 | 9 | 9 | 0.02 | U* R* | im | title: the cluster |
| `(Title › Cluster)` | 9 | 9 | 9 | 0.02 | U* R* | im |  |
| `Status` | 9 | 9 | 9 | 0.02 | U R* | la | status line |
| `Last decision` | 9 | 9 | 9 | 0.02 | U R* | la | date of last decision |
| `Constituent papers` | 9 | 9 | 91 | 0.22 | U R* | hd | the papers in the cluster |
| `What's resolved` | 9 | 9 | 49 | 0.12 | U R* | hd | settled framing points |
| `What's still open` | 9 | 9 | 58 | 0.14 | U R* | hd | open framing points |
| `Cross-references` | 9 | 9 | 50 | 0.12 | U R* | hd | related files |
| `Framing decision`﹖ | 8 | 8 | 75 | 0.18 | U O* | hd | one paper or several, and why |
| *(50 minor slots)* |  |  | 83 | 0.20 | U O* |  | listed below |

*Minor and undeclared slots:* Sequencing (2), Strategic context (2), Recommended (1), Tier-1 finding integration (1), Substrate maturity (1), Venue split (1), Slugging composition-closure and opacity-dual (1), … (+43 more)

### Movement

**Total Files**: 9  
**Total Lines**: 380  
**Where**: Vis Veritatis 9  
**Shape declared in**: ../pipeline.outline.md

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 9 | 9 | 9 | 0.02 | D R* | fm | identity |
| `Essay` | 9 | 9 | 9 | 0.02 | D R* | fm | which essay |
| `State` | 9 | 9 | 9 | 0.02 | D R* | fm | process flags |
| `Voice` | 9 | 9 | 9 | 0.02 | D R* | fm | whose words: joseph-primary to agent-drafted |
| `(Preamble)` | 9 | 9 | 11 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 9 | 9 | 9 | 0.02 | U* R* | im | title: the movement |
| `(Title › Movement)` | 9 | 9 | 9 | 0.02 | U* R* | im |  |
| `Working Notes` | 9 | 9 | 89 | 0.23 | U R* | hd | the inbox: open items with leans, cautions, provenance; not canon |
| `Quote bank`﹖ | 7 | 7 | 142 | 0.37 | U O* | hd | verbatim source passages gathered for drafting |
| *(26 minor slots)* |  |  | 76 | 0.20 | U O* |  | listed below |

*Minor and undeclared slots:* Register inversion vs. the paper (1), The essay's likely shape for this movement (1), Cross-links (1), Not yet mined (1), Provenance caution (1), Joseph's primary articulations (1), … (+20 more)

### Section

**Total Files**: 8  
**Total Lines**: 576  
**Where**: NeurIPS 03 pre-reshape segments 8  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 8 | 8 | 8 | 0.01 | U* R* | if |  |
| `Proof`﹖ | 3 | 3 | 16 | 0.03 | D O* | ot | proof block |
| `Theorem`﹖ | 3 | 3 | 16 | 0.03 | D O* | ot | theorem block |
| `Corollary`﹖ | 2 | 2 | 6 | 0.01 | D O* | ot | corollary block |
| `Hypothesis`﹖ | 2 | 2 | 6 | 0.01 | D O* | ot | named hypothesis block |
| `Lemma`﹖ | 2 | 2 | 6 | 0.01 | D O* | ot | lemma block |
| `Table`﹖ | 1 | 1 | 7 | 0.01 | D O* | ot | table with caption and anchor |
| *(20 minor slots)* |  |  | 712 | 1.24 | U O* |  | listed below |

*Minor and undeclared slots:* Track N (2), Track N › Cite-and-distinguish (2), Introduction (1), Setup (1), Setup › The architectural attenuation ratio (1), Track N › Hypotheses (1), … (+14 more)

### Chapter

**Total Files**: 8  
**Total Lines**: 345  
**Where**: Principia Ars Technica (book) 8  
**Shape declared in**: declared (build BOOK_CHAPTERS list)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 8 | 8 | 8 | 0.02 | U* R* | if |  |
| `(Preamble)`﹖ | 5 | 5 | 58 | 0.17 | U* O* | im |  |
| `(Title)`﹖ | 5 | 5 | 5 | 0.01 | U* O* | im | headings that are the segment's own prose structure, not slots |
| *(7 minor slots)* |  |  | 293 | 0.85 | U O* |  | listed below |

*Minor and undeclared slots:* "A Weak Foundation Frustrates the Work" (1), Definitions for First Principles & Higher Principles (1), The Blub Paradox & its Implications (1), … (+4 more)

### Compilation

**Total Files**: 8  
**Total Lines**: 4,400  
**Where**: Paper 3 quote substrate 8  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 8 | 8 | 8 | 0.00 | U* R* | if |  |
| `(Preamble)`﹖ | 7 | 7 | 25 | 0.01 | U* O* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)`﹖ | 7 | 7 | 7 | 0.00 | U* O* | im | the title |
| *(177 minor slots)* |  |  | 5,409 | 1.23 | U O* |  | listed below |

*Minor and undeclared slots:* (Component) (2), Compact's six components (2), Conventions (2), How to extend this compilation (2), Cross-references (2), … (+172 more)

### Flow

**Total Files**: 8  
**Total Lines**: 194  
**Where**: Paper 4 prep substrate 8  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 8 | 8 | 8 | 0.04 | U* R* | if |  |
| `(Preamble)` | 8 | 8 | 46 | 0.24 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 8 | 8 | 8 | 0.04 | U* R* | im | the title |
| *(28 minor slots)* |  |  | 105 | 0.54 | U O* |  | listed below |

*Minor and undeclared slots:* Attempt 1 — the structure (1), Attempt 2 — drop the taxonomy; take ONE death, from the inside, no math (1), Attempt 3 — why THESE factors? is there a unity worth saying? (1), … (+25 more)

### Appendix

**Total Files**: 7  
**Total Lines**: 221  
**Where**: NeurIPS 02 pre-restructure segment 7  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.03 | U* R* | if |  |
| `Proof`﹖ | 3 | 3 | 6 | 0.03 | D O* | ot | proof block |
| `Theorem`﹖ | 2 | 2 | 11 | 0.05 | D O* | ot | theorem block |
| *(9 minor slots)* |  |  | 235 | 1.06 | U O* |  | listed below |

*Minor and undeclared slots:* Supporting Material for the Main Components (1), Supporting Material for the Main Components › Direction-forcing argument (1), … (+7 more)

### Section Draft

**Total Files**: 7  
**Total Lines**: 463  
**Where**: Practica paper drafts (s5) 7  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.02 | U* R* | if |  |
| *(8 minor slots)* |  |  | 470 | 1.02 | U O* |  | listed below |

*Minor and undeclared slots:* 3 — The military-doctrine identification (1), 4 — The AAT formalism (1), 5 — The engineering identification (1), 6 — The convergence (1), 1 — Introduction (1), … (+3 more)

### Section

**Total Files**: 7  
**Total Lines**: 115  
**Where**: After consciousness paper 7  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.06 | U* R* | if |  |
| `(Preamble)` | 7 | 7 | 57 | 0.50 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 7 | 7 | 7 | 0.06 | U* R* | im | the title |

### Notes-sidecar

**Total Files**: 7  
**Total Lines**: 1,216  
**Where**: After consciousness paper 7  
**Shape declared in**: OUT manifest Type column (+ § column for -cont); declared by the banner each sidecar opens with

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.01 | U* R* | if |  |
| `(Preamble)` | 7 | 7 | 28 | 0.02 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 7 | 7 | 7 | 0.01 | U* R* | im | the title |
| `CARRIES`﹖ | 6 | 6 | 52 | 0.04 | D O* | hd | the segment header moved out of the prose: what the section carries |
| `SCRATCH — gems`﹖ | 2 | 2 | 119 | 0.10 | D O* | hd | commented scratch: source gems, not build input |
| `Draft composer-notes`﹖ | 2 | 2 | 32 | 0.03 | D O* | hd | drafting notes for the composer |
| *(30 minor slots)* |  |  | 1,020 | 0.84 | U O* |  | listed below |

*Minor and undeclared slots:* CRITICAL TRUTH-PASS (Mitis, xhigh, 2026-06-01) — read cold. NONE applied; JW adjudicates (3), SCRATCH — original gems (3), CARRIES (segment header) + tag legend (1), … (+27 more)

### Essay

**Total Files**: 7  
**Total Lines**: 1,138  
**Where**: Paper 4 prep substrate 7  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.01 | U* R* | if |  |
| `(Preamble)` | 7 | 7 | 60 | 0.05 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 7 | 7 | 7 | 0.01 | U* R* | im | the title |
| `Working notes` | 7 | 7 | 209 | 0.18 | U R* | hd | the inbox: open items with leans, cautions, provenance; not canon |
| *(48 minor slots)* |  |  | 859 | 0.75 | U O* |  | listed below |

*Minor and undeclared slots:* Tone check (2), Cohort-protection before any venue (2), Cohort-protection (2), Coda (2), The void is not empty (1), II. The agency that could not be held (1), … (+42 more)

### Section

**Total Files**: 6  
**Total Lines**: 142  
**Where**: NeurIPS 01 tragedy (paper) 6  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.04 | U* R* | if |  |
| `Definition`﹖ | 1 | 1 | 2 | 0.01 | D O* | ot | definition block |
| `Proposition`﹖ | 1 | 1 | 2 | 0.01 | D O* | ot | proposition block |
| `Table`﹖ | 1 | 1 | 10 | 0.07 | D O* | ot | table with caption and anchor |
| `Theorem`﹖ | 1 | 1 | 6 | 0.04 | D O* | ot | theorem block |
| *(12 minor slots)* |  |  | 223 | 1.57 | U O* |  | listed below |

*Minor and undeclared slots:* Introduction (1), Setup (1), Setup › Agent state (1), Main Results (1), Main Results › The averaged-information LMI (1), Main Results › The blank-wall resolution (1), … (+6 more)

### Section

**Total Files**: 6  
**Total Lines**: 216  
**Where**: NeurIPS 02 convergence (paper) 6  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.03 | U* R* | if |  |
| `Lemma`﹖ | 1 | 1 | 14 | 0.06 | D O* | ot | lemma block |
| `Theorem`﹖ | 1 | 1 | 25 | 0.12 | D O* | ot | theorem block |
| *(11 minor slots)* |  |  | 306 | 1.42 | U O* |  | listed below |

*Minor and undeclared slots:* Introduction (1), Introduction › Contribution (1), Introduction › Scope and limitations (1), Related Work (1), Preliminaries (1), Main Result (1), … (+5 more)

### Appendix

**Total Files**: 6  
**Total Lines**: 388  
**Where**: NeurIPS 02 convergence (paper) 6  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.02 | U* R* | if |  |
| `Table`﹖ | 2 | 2 | 18 | 0.05 | D O* | ot | table with caption and anchor |
| `Proof`﹖ | 1 | 1 | 13 | 0.03 | D O* | ot | proof block |
| `Proposition`﹖ | 1 | 1 | 3 | 0.01 | D O* | ot | proposition block |
| `Theorem`﹖ | 1 | 1 | 6 | 0.02 | D O* | ot | theorem block |
| *(8 minor slots)* |  |  | 401 | 1.03 | U O* |  | listed below |

*Minor and undeclared slots:* Proof of the Composition Theorem (1), Proofs of the Key Lemmas (1), Auxiliary Mathematical Material (1), Auxiliary Mathematical Material › Direction-forcing argument (1), … (+4 more)

### Section

**Total Files**: 6  
**Total Lines**: 216  
**Where**: NeurIPS 03 hallucinate (paper) 6  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.03 | U* R* | if |  |
| `Hypothesis`﹖ | 2 | 2 | 14 | 0.06 | D O* | ot | named hypothesis block |
| `Corollary`﹖ | 1 | 1 | 6 | 0.03 | D O* | ot | corollary block |
| `Lemma`﹖ | 1 | 1 | 2 | 0.01 | D O* | ot | lemma block |
| `Table`﹖ | 1 | 1 | 7 | 0.03 | D O* | ot | table with caption and anchor |
| `Theorem`﹖ | 1 | 1 | 18 | 0.08 | D O* | ot | theorem block |
| *(11 minor slots)* |  |  | 311 | 1.44 | U O* |  | listed below |

*Minor and undeclared slots:* Introduction (1), Related Work (1), Setup (1), Setup › The bias quantity (1), Setup › Goal/Update Coupling Class (1), Setup › Axioms (1), Main Results (1), … (+4 more)

### Appendix

**Total Files**: 6  
**Total Lines**: 462  
**Where**: NeurIPS 03 hallucinate (paper) 6  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.01 | U* R* | if |  |
| `Lemma`﹖ | 2 | 2 | 18 | 0.04 | D O* | ot | lemma block |
| `Proof`﹖ | 2 | 2 | 87 | 0.19 | D O* | ot | proof block |
| `Theorem`﹖ | 2 | 2 | 46 | 0.10 | D O* | ot | theorem block |
| `Corollary`﹖ | 1 | 1 | 10 | 0.02 | D O* | ot | corollary block |
| `Table`﹖ | 1 | 1 | 8 | 0.02 | D O* | ot | table with caption and anchor |
| *(9 minor slots)* |  |  | 496 | 1.07 | U O* |  | listed below |

*Minor and undeclared slots:* Failed routes (1), Failed routes › The pattern (1), Hypothesis verification details (1), Conjugate-Gaussian numerical comparison (1), … (+5 more)

### Section Draft

**Total Files**: 6  
**Total Lines**: 576  
**Where**: Practica paper drafts (s4) 6  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.01 | U* R* | if |  |
| `(Preamble)` | 6 | 6 | 19 | 0.03 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 6 | 6 | 6 | 0.01 | U* R* | im | the segment's name / one-line claim |
| *(33 minor slots)* |  |  | 607 | 1.05 | U O* |  | listed below |

*Minor and undeclared slots:* 3.1 The architectural classification (1), 3.2 The wrapping construction (1), 3.3 What the wrapping yields (1), 3.4 Cost (1), 3.5 Two readings of the same construction (1), … (+28 more)

### Paper-note

**Total Files**: 6  
**Total Lines**: 543  
**Where**: Joseph bio ingestion (ops) 6  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.01 | U* R* | if |  |
| `(Title)` | 6 | 6 | 6 | 0.01 | U* R* | im | the title |
| `(Preamble)`﹖ | 5 | 5 | 16 | 0.03 | U* O* | im | unheaded text between the title and the first section (summary line, status line) |
| `Attack surface`﹖ | 4 | 4 | 63 | 0.12 | U O* | hd | where a skeptic would press |
| `What it does`﹖ | 3 | 3 | 53 | 0.10 | U O* | hd | what the work does |
| *(32 minor slots)* |  |  | 411 | 0.76 | U O* |  | listed below |

*Minor and undeclared slots:* SURPRISAL (2), Net judgment (rung (2), Net (rung (2), What the paper is (1), Genuine strengths (1), Where a hostile reviewer pushes (1), Net judgment (1), Belshaw judo (1), … (+24 more)

### Note

**Total Files**: 5  
**Total Lines**: 722  
**Where**: Joseph bio ingestion (ops) 5  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 5 | 5 | 5 | 0.01 | U* R* | if |  |
| `(Title)` | 5 | 5 | 5 | 0.01 | U* R* | im | the title |
| *(31 minor slots)* |  |  | 735 | 1.02 | U O* |  | listed below |

*Minor and undeclared slots:* (Preamble) (2), Active dirs by mtime (1), Task shape (1), Working folder (1), ~/src diff against the known project map (1), Submitted papers — read-in-full queue (1), … (+25 more)

### Appendix

**Total Files**: 4  
**Total Lines**: 175  
**Where**: NeurIPS 03 pre-reshape segments 4  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.02 | U* R* | if |  |
| `Lemma`﹖ | 1 | 1 | 2 | 0.01 | D O* | ot | lemma block |
| `Proof`﹖ | 1 | 1 | 4 | 0.02 | D O* | ot | proof block |
| `Table`﹖ | 1 | 1 | 8 | 0.05 | D O* | ot | table with caption and anchor |
| `Theorem`﹖ | 1 | 1 | 2 | 0.01 | D O* | ot | theorem block |
| *(5 minor slots)* |  |  | 183 | 1.05 | U O* |  | listed below |

*Minor and undeclared slots:* Failed routes (1), Failed routes › The pattern (1), Hypothesis verification details (1), Conjugate-Gaussian numerical comparison (1), … (+1 more)

### Front

**Total Files**: 4  
**Total Lines**: 83  
**Where**: Granted agency paper 4  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.05 | U* R* | if |  |

### Source-extract

**Total Files**: 4  
**Total Lines**: 529  
**Where**: Paper 3 quote substrate 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.01 | U* R* | if |  |
| `(Preamble)` | 4 | 4 | 65 | 0.12 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 4 | 4 | 4 | 0.01 | U* R* | im | title: a reflection extract |
| `Reflection`﹖ | 2 | 2 | 119 | 0.22 | U O* | hd | title: a reflection extract |
| *(32 minor slots)* |  |  | 616 | 1.16 | U O* |  | listed below |

*Minor and undeclared slots:* What happened (1), The catalog underread (1), V2.io as home (1), The asymmetric-uncertainty argument applied to the reader (1), Continuity without memory (1), … (+27 more)

### Project-note

**Total Files**: 4  
**Total Lines**: 334  
**Where**: Joseph bio ingestion (ops) 4  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 4 | 4 | 4 | 0.01 | U* R* | if |  |
| `(Title)` | 4 | 4 | 4 | 0.01 | U* R* | im | the title |
| `(Preamble)`﹖ | 2 | 2 | 9 | 0.03 | U* O* | im | unheaded text between the title and the first section (summary line, status line) |
| `Net (rung`﹖ | 2 | 2 | 10 | 0.03 | U O* | hd |  |
| *(23 minor slots)* |  |  | 305 | 0.91 | U O* |  | listed below |

*Minor and undeclared slots:* The thesis (1), Why it's the framework in disguise (1), Genuine research merit + product insight (1), One theorem worked at every scale (1), THE ARC, stated once (1), … (+18 more)

### Outline Draft

**Total Files**: 3  
**Total Lines**: 279  
**Where**: Principia Ars Technica (book) 3  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.01 | U* R* | if |  |
| `(Preamble)` | 3 | 3 | 8 | 0.03 | U* R* | im |  |
| `(Title)` | 3 | 3 | 3 | 0.01 | U* R* | im | book-structure skeleton |
| *(37 minor slots)* |  |  | 353 | 1.27 | U O* |  | listed below |

*Minor and undeclared slots:* Body Matter (1), Part I (1), Appendices / Incidental (1), End Matter (1), Why Full Cycle Development? (1), Why Full Cycle Development? › More than Agile (1), … (+31 more)

### Test Document

**Total Files**: 3  
**Total Lines**: 415  
**Where**: Principia Ars Technica (book) 3  
**Shape declared in**: declared (build BOOK_CHAPTERS list)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.01 | U* R* | if |  |
| `(Title)` | 3 | 3 | 3 | 0.01 | U* R* | im |  |
| `(Preamble)`﹖ | 2 | 2 | 2 | 0.00 | U* O* | im |  |
| `Images`﹖ | 2 | 2 | 30 | 0.07 | U O* | hd |  |
| *(30 minor slots)* |  |  | 403 | 0.97 | U O* |  | listed below |

*Minor and undeclared slots:* Basic Image (1), Raw ConTeXt Image Commands (1), Raw ConTeXt Image Commands › Centered Figure (1), Raw ConTeXt Image Commands › Side margin figure (1), … (+26 more)

### Conversation Transcript

**Total Files**: 3  
**Total Lines**: 5,933  
**Where**: vault: Principles 3  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.00 | U* R* | if |  |
| `(Title)` | 3 | 3 | 3 | 0.00 | U* R* | im |  |
| `(Title › You)` | 3 | 3 | 3 | 0.00 | U* R* | im |  |
| `Claude` ➕ | 48 | 3 | 5,767 | 0.97 | U R* | hd |  |
| `You` ➕ | 45 | 3 | 128 | 0.02 | U R* | hd |  |
| `Revolutionary Implications` | 3 | 3 | 76 | 0.01 | U R* | hd | holds 3 ### implications in 1 file, each with fields Why microservices sometimes fail, Why layered architecture often hurts, Why "feature folders" often beat "type folders" |
| `Potential Integration Points`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Control group`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Treatment group`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Objective measures`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Large sample`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Blind validation` 🞷 | 4 | 2 | 4 | 0.00 | U O* | la |  |
| `Target`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Measurements`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Statistical Thresholds`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Predictive Accuracy`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Objective outcomes`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Longitudinal studies`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `A/B testing`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Cross-validation`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `The ultimate validation`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `The most exciting part`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Software Development Framework Analysis.md`﹖ | 2 | 2 | 12 | 0.00 | U O* | hd |  |
| `Software-first-principles.md`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Core Measurable Principles for Integration`﹖ | 2 | 2 | 138 | 0.02 | U O* | hd | holds 6 ### principles in 2 files, each with fields Implementation, Justification, Confidence Update, Principled Justification |
| `Advanced Integration Concepts`﹖ | 2 | 2 | 78 | 0.01 | U O* | hd | holds 4 ### concepts in 2 files, each with fields Implementation |
| `Bayesian Confidence Framework`﹖ | 2 | 2 | 70 | 0.01 | U O* | hd | holds 4 named ### parts in 2 files |
| `Most Promising Starting Points`﹖ | 2 | 2 | 46 | 0.01 | U O* | hd | holds 6 ### starting points in 2 files, each with fields Easy to implement, Direct measurement, Immediate value, High confidence, Moderate implementation, High theoretical value (+6 more) |
| `Measurement Reliability Assessment`﹖ | 2 | 2 | 40 | 0.01 | U O* | hd | holds 6 named ### parts in 2 files, each with fields Discontinuity counting, File proximity, Changeset size, Coupling detection, Domain vocabulary |
| `Revolutionary Potential`﹖ | 2 | 2 | 28 | 0.00 | U O* | hd |  |
| `Unbiased Control Measures`﹖ | 2 | 2 | 176 | 0.03 | U O* | hd | holds 8 ### control measures in 2 files, each with fields Scientific Value |
| `Principled Intervention Measures`﹖ | 2 | 2 | 186 | 0.03 | U O* | hd | holds 8 ### intervention measures in 2 files |
| `Critical Scientific Distinction`﹖ | 2 | 2 | 32 | 0.01 | U O* | hd | holds 4 named ### parts in 2 files, each with fields Purpose, Method, Example, Result, Prerequisite |
| `Implementation Strategy`﹖ | 2 | 2 | 44 | 0.01 | U O* | hd | holds 6 ### phases in 2 files |
| `The Scientific Rigor`﹖ | 2 | 2 | 26 | 0.00 | U O* | hd |  |
| `Additional Metrics to Consider`﹖ | 2 | 2 | 308 | 0.05 | U O* | hd | holds 4 named ### parts in 2 files |
| `Additional Control Measures`﹖ | 2 | 2 | 16 | 0.00 | U O* | hd |  |
| `Additional Intervention Measures`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Key Implementation Insights`﹖ | 2 | 2 | 58 | 0.01 | U O* | hd |  |
| `Complete Framework Context`﹖ | 2 | 2 | 12 | 0.00 | U O* | hd |  |
| `Detailed Validation Requirements`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Technical Implementation Specifications`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Scientific Rigor Framework`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Clear Success Criteria`﹖ | 2 | 2 | 24 | 0.00 | U O* | hd |  |
| `Controlled Experimental Validation`﹖ | 2 | 2 | 18 | 0.00 | U O* | hd |  |
| `AI-Specific Insights`﹖ | 2 | 2 | 18 | 0.00 | U O* | hd |  |
| `Practical Validation Pipeline`﹖ | 2 | 2 | 18 | 0.00 | U O* | hd |  |
| `Key Innovations`﹖ | 2 | 2 | 36 | 0.01 | U O* | hd |  |
| `Key Advantages of Simulation Approach`﹖ | 2 | 2 | 56 | 0.01 | U O* | hd | holds 6 ### advantages in 2 files |
| `AI-Specific Research Questions`﹖ | 2 | 2 | 18 | 0.00 | U O* | hd |  |
| `Comprehensive Project Categories`﹖ | 2 | 2 | 40 | 0.01 | U O* | hd | holds 6 ### project categories in 2 files |
| `Revolutionary Validation Approach`﹖ | 2 | 2 | 26 | 0.00 | U O* | hd |  |
| `Expected Deliverables`﹖ | 2 | 2 | 24 | 0.00 | U O* | hd |  |
| `The Circularity Problem`﹖ | 2 | 2 | 28 | 0.00 | U O* | hd |  |
| `Better Validation Approaches`﹖ | 2 | 2 | 230 | 0.04 | U O* | hd | holds 8 ### approaches in 2 files |
| `The Deeper Issue`﹖ | 2 | 2 | 92 | 0.02 | U O* | hd | holds 6 ### options in 2 files |
| `Revised Simulation Framework` 🞷 | 4 | 2 | 158 | 0.03 | U O* | hd |  |
| `The Corrected Validation Logic`﹖ | 2 | 2 | 46 | 0.01 | U O* | hd |  |
| `What This Means for Validation`﹖ | 2 | 2 | 160 | 0.03 | U O* | hd | holds 6 named ### parts in 2 files |
| `The Profound Simplification`﹖ | 2 | 2 | 16 | 0.00 | U O* | hd |  |
| `The Elegant Result`﹖ | 2 | 2 | 26 | 0.00 | U O* | hd |  |
| `From Circular Validation to Pure Speed Competition`﹖ | 2 | 2 | 28 | 0.00 | U O* | hd | holds 4 named ### parts in 2 files |
| `Major Framework Changes`﹖ | 2 | 2 | 112 | 0.02 | U O* | hd | holds 10 ### changes in 2 files |
| `Updated Framework Features`﹖ | 2 | 2 | 10 | 0.00 | U O* | hd |  |
| `New Artifact Sections Include`﹖ | 2 | 2 | 28 | 0.00 | U O* | hd |  |
| `Most Exciting Next Steps`﹖ | 2 | 2 | 60 | 0.01 | U O* | hd | holds 6 ### next steps in 2 files, each with fields Why this matters |
| `Most Exciting Future Directions`﹖ | 2 | 2 | 118 | 0.02 | U O* | hd | holds 10 ### future directions in 2 files, each with fields Humans, AI, Collaboration |
| `The Most Profound Possibility`﹖ | 2 | 2 | 12 | 0.00 | U O* | hd |  |
| `Why This Matters` 🞷 | 3 | 2 | 37 | 0.01 | U O* | hd |  |
| *(122 minor slots)* |  |  | 1,353 | 0.23 | U O* |  | listed below |

*Minor and undeclared slots:* Phase N (1), Corrected Priority Order (1), Revised Implementation Strategy (1), Revised Implementation Strategy › Phase N (1), Critical Dependencies (1), … (+117 more)

### Conversation Transcript

**Total Files**: 3  
**Total Lines**: 5,933  
**Where**: vault: gemini foundation 3  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.00 | U* R* | if |  |
| `(Title)` | 3 | 3 | 3 | 0.00 | U* R* | im |  |
| `(Title › You)` | 3 | 3 | 3 | 0.00 | U* R* | im |  |
| `Claude` ➕ | 48 | 3 | 5,767 | 0.97 | U R* | hd |  |
| `You` ➕ | 45 | 3 | 128 | 0.02 | U R* | hd |  |
| `Revolutionary Implications` | 3 | 3 | 76 | 0.01 | U R* | hd | holds 3 ### implications in 1 file, each with fields Why microservices sometimes fail, Why layered architecture often hurts, Why "feature folders" often beat "type folders" |
| `Potential Integration Points`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Control group`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Treatment group`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Objective measures`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Large sample`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Blind validation` 🞷 | 4 | 2 | 4 | 0.00 | U O* | la |  |
| `Target`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Measurements`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Statistical Thresholds`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Predictive Accuracy`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Objective outcomes`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Longitudinal studies`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `A/B testing`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Cross-validation`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `The ultimate validation`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `The most exciting part`﹖ | 2 | 2 | 2 | 0.00 | U O* | la |  |
| `Software Development Framework Analysis.md`﹖ | 2 | 2 | 12 | 0.00 | U O* | hd |  |
| `Software-first-principles.md`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Core Measurable Principles for Integration`﹖ | 2 | 2 | 138 | 0.02 | U O* | hd | holds 6 ### principles in 2 files, each with fields Implementation, Justification, Confidence Update, Principled Justification |
| `Advanced Integration Concepts`﹖ | 2 | 2 | 78 | 0.01 | U O* | hd | holds 4 ### concepts in 2 files, each with fields Implementation |
| `Bayesian Confidence Framework`﹖ | 2 | 2 | 70 | 0.01 | U O* | hd | holds 4 named ### parts in 2 files |
| `Most Promising Starting Points`﹖ | 2 | 2 | 46 | 0.01 | U O* | hd | holds 6 ### starting points in 2 files, each with fields Easy to implement, Direct measurement, Immediate value, High confidence, Moderate implementation, High theoretical value (+6 more) |
| `Measurement Reliability Assessment`﹖ | 2 | 2 | 40 | 0.01 | U O* | hd | holds 6 named ### parts in 2 files, each with fields Discontinuity counting, File proximity, Changeset size, Coupling detection, Domain vocabulary |
| `Revolutionary Potential`﹖ | 2 | 2 | 28 | 0.00 | U O* | hd |  |
| `Unbiased Control Measures`﹖ | 2 | 2 | 176 | 0.03 | U O* | hd | holds 8 ### control measures in 2 files, each with fields Scientific Value |
| `Principled Intervention Measures`﹖ | 2 | 2 | 186 | 0.03 | U O* | hd | holds 8 ### intervention measures in 2 files |
| `Critical Scientific Distinction`﹖ | 2 | 2 | 32 | 0.01 | U O* | hd | holds 4 named ### parts in 2 files, each with fields Purpose, Method, Example, Result, Prerequisite |
| `Implementation Strategy`﹖ | 2 | 2 | 44 | 0.01 | U O* | hd | holds 6 ### phases in 2 files |
| `The Scientific Rigor`﹖ | 2 | 2 | 26 | 0.00 | U O* | hd |  |
| `Additional Metrics to Consider`﹖ | 2 | 2 | 308 | 0.05 | U O* | hd | holds 4 named ### parts in 2 files |
| `Additional Control Measures`﹖ | 2 | 2 | 16 | 0.00 | U O* | hd |  |
| `Additional Intervention Measures`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Key Implementation Insights`﹖ | 2 | 2 | 58 | 0.01 | U O* | hd |  |
| `Complete Framework Context`﹖ | 2 | 2 | 12 | 0.00 | U O* | hd |  |
| `Detailed Validation Requirements`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Technical Implementation Specifications`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Scientific Rigor Framework`﹖ | 2 | 2 | 14 | 0.00 | U O* | hd |  |
| `Clear Success Criteria`﹖ | 2 | 2 | 24 | 0.00 | U O* | hd |  |
| `Controlled Experimental Validation`﹖ | 2 | 2 | 18 | 0.00 | U O* | hd |  |
| `AI-Specific Insights`﹖ | 2 | 2 | 18 | 0.00 | U O* | hd |  |
| `Practical Validation Pipeline`﹖ | 2 | 2 | 18 | 0.00 | U O* | hd |  |
| `Key Innovations`﹖ | 2 | 2 | 36 | 0.01 | U O* | hd |  |
| `Key Advantages of Simulation Approach`﹖ | 2 | 2 | 56 | 0.01 | U O* | hd | holds 6 ### advantages in 2 files |
| `AI-Specific Research Questions`﹖ | 2 | 2 | 18 | 0.00 | U O* | hd |  |
| `Comprehensive Project Categories`﹖ | 2 | 2 | 40 | 0.01 | U O* | hd | holds 6 ### project categories in 2 files |
| `Revolutionary Validation Approach`﹖ | 2 | 2 | 26 | 0.00 | U O* | hd |  |
| `Expected Deliverables`﹖ | 2 | 2 | 24 | 0.00 | U O* | hd |  |
| `The Circularity Problem`﹖ | 2 | 2 | 28 | 0.00 | U O* | hd |  |
| `Better Validation Approaches`﹖ | 2 | 2 | 230 | 0.04 | U O* | hd | holds 8 ### approaches in 2 files |
| `The Deeper Issue`﹖ | 2 | 2 | 92 | 0.02 | U O* | hd | holds 6 ### options in 2 files |
| `Revised Simulation Framework` 🞷 | 4 | 2 | 158 | 0.03 | U O* | hd |  |
| `The Corrected Validation Logic`﹖ | 2 | 2 | 46 | 0.01 | U O* | hd |  |
| `What This Means for Validation`﹖ | 2 | 2 | 160 | 0.03 | U O* | hd | holds 6 named ### parts in 2 files |
| `The Profound Simplification`﹖ | 2 | 2 | 16 | 0.00 | U O* | hd |  |
| `The Elegant Result`﹖ | 2 | 2 | 26 | 0.00 | U O* | hd |  |
| `From Circular Validation to Pure Speed Competition`﹖ | 2 | 2 | 28 | 0.00 | U O* | hd | holds 4 named ### parts in 2 files |
| `Major Framework Changes`﹖ | 2 | 2 | 112 | 0.02 | U O* | hd | holds 10 ### changes in 2 files |
| `Updated Framework Features`﹖ | 2 | 2 | 10 | 0.00 | U O* | hd |  |
| `New Artifact Sections Include`﹖ | 2 | 2 | 28 | 0.00 | U O* | hd |  |
| `Most Exciting Next Steps`﹖ | 2 | 2 | 60 | 0.01 | U O* | hd | holds 6 ### next steps in 2 files, each with fields Why this matters |
| `Most Exciting Future Directions`﹖ | 2 | 2 | 118 | 0.02 | U O* | hd | holds 10 ### future directions in 2 files, each with fields Humans, AI, Collaboration |
| `The Most Profound Possibility`﹖ | 2 | 2 | 12 | 0.00 | U O* | hd |  |
| `Why This Matters` 🞷 | 3 | 2 | 37 | 0.01 | U O* | hd |  |
| *(122 minor slots)* |  |  | 1,353 | 0.23 | U O* |  | listed below |

*Minor and undeclared slots:* Theoretical Connections (1), Novel Contributions (1), Research Validation (1), Revolutionary Implications (1), DEF-001 (1), DEF-002 (1), FP-001 (1), The Fungibility Argument (1), … (+114 more)

### Front

**Total Files**: 3  
**Total Lines**: 63  
**Where**: After consciousness paper 3  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.05 | U* R* | if |  |

### Section-cont

**Total Files**: 2  
**Total Lines**: 43  
**Where**: NeurIPS 01 tragedy (paper) 2  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.05 | U* R* | if |  |
| `Lemma`﹖ | 1 | 1 | 15 | 0.35 | D O* | ot | lemma block |
| `Mismatch dynamics under drift`﹖ | 1 | 1 | 17 | 0.40 | U O* | hd |  |
| `Persistence`﹖ | 1 | 1 | 28 | 0.65 | U O* | hd |  |

### Essay-outline

**Total Files**: 2  
**Total Lines**: 1,004  
**Where**: ELI essays (Feb 2026) 2  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.00 | U* R* | if |  |
| `ESSAY N ›  › Thesis` ➕ | 10 | 2 | 10 | 0.01 | U R* | la |  |
| `ESSAY N ›  › Movement` ➕ | 10 | 2 | 10 | 0.01 | U R* | la |  |
| `ESSAY N ›  › Emerson throughline` ➕ | 10 | 2 | 10 | 0.01 | U R* | la |  |
| `Framing Note` | 2 | 2 | 33 | 0.03 | U R* | hd |  |
| `(Essay)` ➕ | 10 | 2 | 865 | 0.86 | U* R* | im |  |
| `Cross-Cutting Notes` | 2 | 2 | 98 | 0.10 | U R* | hd | holds 8 ### notes in 2 files; 2 named ### parts in 1 file |
| `Note`﹖ | 1 | 1 | 94 | 0.09 | U O* | ot | working note (stripped at build in papers) |
| `ESSAY N ›  › What this essay does NOT do`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `ESSAY N ›  › What this essay establishes`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `ESSAY N ›  › Structural note`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |

### First-principles Document

**Total Files**: 2  
**Total Lines**: 895  
**Where**: vault: Principles 2  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.00 | U* R* | if |  |
| `(Title)`﹖ | 1 | 1 | 1 | 0.00 | U* O* | im |  |
| `Axiomatic`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Universal Exchange`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Compound Value`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Opportunity Enablement`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Assumption Violation`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Measurement Challenge`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `External Constraints`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Information Theoretic` 🞷 | 2 | 1 | 2 | 0.00 | U O* | la |  |
| `Communication Bound`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Demonstration Equivalence`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Assumption`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Domain Specific`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Context Saturation`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Mathematical` 🞷 | 2 | 1 | 2 | 0.00 | U O* | la |  |
| `Practical` 🞷 | 4 | 1 | 4 | 0.00 | U O* | la |  |
| `Information Available`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Phase Transitions`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Early System Caveat`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Investment Scaling`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Economic`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Empirical` 🞷 | 6 | 1 | 6 | 0.01 | U O* | la |  |
| `Information Requirement`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Discount Rate`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Local vs Global`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Parallel Development`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cognitive Alignment`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Natural Boundaries`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Emergent Architecture`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Domain Fluidity`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Technical Constraints`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Team Structure`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Comprehension`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Market Fit`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Team Alignment`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Living Documentation`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Exploration Phase`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Mature Domains`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Technical Domains`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Compound Effect`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Team Dynamics`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cognitive`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Mechanical`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Verification`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cognitive Load`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cache Efficiency`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Error Reduction`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Review Efficiency`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Language Differences`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Tool Support`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Team Boundaries`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Theoretical`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Young Systems`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Major Refactors`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Different Change Types`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cognitive Science` 🞷 | 2 | 1 | 2 | 0.00 | U O* | la |  |
| `Familiarity Bonus`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Documentation Quality`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Tool Assistance`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `IDE Support`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Familiarity`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Documentation`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Integration Necessity`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Probability Weighting`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Holistic Optimization`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Information Availability`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Computational Complexity`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Time Horizons`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Principia Ars Technica`﹖ | 1 | 1 | 6 | 0.01 | U O* | hd |  |
| `Definitions`﹖ | 1 | 1 | 31 | 0.03 | U O* | hd | holds 2 ### definitions in 1 file, each with fields Additional Notes, Key Principle |
| `FP-001`﹖ | 1 | 1 | 74 | 0.08 | U O* | hd |  |
| `Statement` 🞷 | 13 | 1 | 39 | 0.04 | U O* | hd |  |
| `Formal Expression` 🞷 | 13 | 1 | 138 | 0.15 | U O* | hd | holds 6 ### forms in 1 file; 1 named ### parts in 1 file |
| `Justification` 🞷 | 13 | 1 | 70 | 0.08 | U O* | hd |  |
| `Boundary Conditions` 🞷 | 11 | 1 | 55 | 0.06 | U O* | hd |  |
| `Discussion` 🞷 | 13 | 1 | 401 | 0.45 | U O* | hd | holds 49 named ### parts in 1 file, each with fields Good, Bad, Conceptual Alignment, Comprehension Continuity, The Fungibility of Time, The Compound Nature of Time Savings (+20 more) |
| `Notes` 🞷 | 2 | 1 | 10 | 0.01 | U O* | hd |  |
| `FP-002`﹖ | 1 | 1 | 50 | 0.06 | U O* | hd |  |
| `Implications` 🞷 | 2 | 1 | 10 | 0.01 | U O* | hd |  |
| `FP-003`﹖ | 1 | 1 | 34 | 0.04 | U O* | hd |  |
| `FP-004`﹖ | 1 | 1 | 92 | 0.10 | U O* | hd |  |
| `Critical Insight` 🞷 | 7 | 1 | 25 | 0.03 | U O* | hd |  |
| `FP-005`﹖ | 1 | 1 | 50 | 0.06 | U O* | hd |  |
| `FP-006`﹖ | 1 | 1 | 55 | 0.06 | U O* | hd |  |
| `FP-007`﹖ | 1 | 1 | 47 | 0.05 | U O* | hd |  |
| `FP-008`﹖ | 1 | 1 | 63 | 0.07 | U O* | hd |  |
| `FP-009`﹖ | 1 | 1 | 47 | 0.05 | U O* | hd |  |
| `FP-010`﹖ | 1 | 1 | 44 | 0.05 | U O* | hd |  |
| `FP-011`﹖ | 1 | 1 | 40 | 0.04 | U O* | hd |  |
| `FP-012`﹖ | 1 | 1 | 68 | 0.08 | U O* | hd |  |
| `FP-013`﹖ | 1 | 1 | 175 | 0.20 | U O* | hd |  |

### First-principles Document

**Total Files**: 2  
**Total Lines**: 895  
**Where**: vault: gemini foundation 2  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.00 | U* R* | if |  |
| `(Title)`﹖ | 1 | 1 | 1 | 0.00 | U* O* | im |  |
| `Axiomatic`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Universal Exchange`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Compound Value`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Opportunity Enablement`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Assumption Violation`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Measurement Challenge`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `External Constraints`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Information Theoretic` 🞷 | 2 | 1 | 2 | 0.00 | U O* | la |  |
| `Communication Bound`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Demonstration Equivalence`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Assumption`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Domain Specific`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Context Saturation`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Mathematical` 🞷 | 2 | 1 | 2 | 0.00 | U O* | la |  |
| `Practical` 🞷 | 4 | 1 | 4 | 0.00 | U O* | la |  |
| `Information Available`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Phase Transitions`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Early System Caveat`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Investment Scaling`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Economic`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Empirical` 🞷 | 6 | 1 | 6 | 0.01 | U O* | la |  |
| `Information Requirement`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Discount Rate`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Local vs Global`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Parallel Development`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cognitive Alignment`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Natural Boundaries`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Emergent Architecture`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Domain Fluidity`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Technical Constraints`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Team Structure`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Comprehension`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Market Fit`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Team Alignment`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Living Documentation`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Exploration Phase`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Mature Domains`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Technical Domains`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Compound Effect`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Team Dynamics`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cognitive`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Mechanical`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Verification`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cognitive Load`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cache Efficiency`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Error Reduction`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Review Efficiency`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Language Differences`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Tool Support`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Team Boundaries`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Theoretical`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Young Systems`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Major Refactors`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Different Change Types`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Cognitive Science` 🞷 | 2 | 1 | 2 | 0.00 | U O* | la |  |
| `Familiarity Bonus`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Documentation Quality`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Tool Assistance`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `IDE Support`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Familiarity`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Documentation`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Integration Necessity`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Probability Weighting`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Holistic Optimization`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Information Availability`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Computational Complexity`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Time Horizons`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Principia Ars Technica`﹖ | 1 | 1 | 6 | 0.01 | U O* | hd |  |
| `Definitions`﹖ | 1 | 1 | 31 | 0.03 | U O* | hd | holds 2 ### definitions in 1 file, each with fields Additional Notes, Key Principle |
| `FP-001`﹖ | 1 | 1 | 74 | 0.08 | U O* | hd |  |
| `Statement` 🞷 | 13 | 1 | 39 | 0.04 | U O* | hd |  |
| `Formal Expression` 🞷 | 13 | 1 | 138 | 0.15 | U O* | hd | holds 6 ### forms in 1 file; 1 named ### parts in 1 file |
| `Justification` 🞷 | 13 | 1 | 70 | 0.08 | U O* | hd |  |
| `Boundary Conditions` 🞷 | 11 | 1 | 55 | 0.06 | U O* | hd |  |
| `Discussion` 🞷 | 13 | 1 | 401 | 0.45 | U O* | hd | holds 49 named ### parts in 1 file, each with fields Good, Bad, Conceptual Alignment, Comprehension Continuity, The Fungibility of Time, The Compound Nature of Time Savings (+20 more) |
| `Notes` 🞷 | 2 | 1 | 10 | 0.01 | U O* | hd |  |
| `FP-002`﹖ | 1 | 1 | 50 | 0.06 | U O* | hd |  |
| `Implications` 🞷 | 2 | 1 | 10 | 0.01 | U O* | hd |  |
| `FP-003`﹖ | 1 | 1 | 34 | 0.04 | U O* | hd |  |
| `FP-004`﹖ | 1 | 1 | 92 | 0.10 | U O* | hd |  |
| `Critical Insight` 🞷 | 7 | 1 | 25 | 0.03 | U O* | hd |  |
| `FP-005`﹖ | 1 | 1 | 50 | 0.06 | U O* | hd |  |
| `FP-006`﹖ | 1 | 1 | 55 | 0.06 | U O* | hd |  |
| `FP-007`﹖ | 1 | 1 | 47 | 0.05 | U O* | hd |  |
| `FP-008`﹖ | 1 | 1 | 63 | 0.07 | U O* | hd |  |
| `FP-009`﹖ | 1 | 1 | 47 | 0.05 | U O* | hd |  |
| `FP-010`﹖ | 1 | 1 | 44 | 0.05 | U O* | hd |  |
| `FP-011`﹖ | 1 | 1 | 40 | 0.04 | U O* | hd |  |
| `FP-012`﹖ | 1 | 1 | 68 | 0.08 | U O* | hd |  |
| `FP-013`﹖ | 1 | 1 | 175 | 0.20 | U O* | hd |  |

### Ideation-card

**Total Files**: 2  
**Total Lines**: 141  
**Where**: ais (eoi cards) 2  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 2 | 2 | 2 | 0.01 | U R* | fm | identity (= filename) |
| `Form` | 2 | 2 | 2 | 0.01 | U R* | fm | speech-act kind |
| `State` | 2 | 2 | 2 | 0.01 | U R* | fm | process-state flags |
| `Voice` | 2 | 2 | 2 | 0.01 | U R* | fm | who wrote it |
| `(Title)` | 2 | 2 | 2 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `Candidate lasting deliverable`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Why this exists`﹖ | 1 | 1 | 8 | 0.06 | U O* | hd |  |
| `Handles, by idea`﹖ | 1 | 1 | 29 | 0.21 | U O* | hd |  |
| `Nascent handles`﹖ | 1 | 1 | 19 | 0.13 | U O* | hd |  |
| `Ideas not yet built`﹖ | 1 | 1 | 6 | 0.04 | U O* | hd |  |
| `In discussion and future briefs`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `In the estate`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `In the ais response`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Author`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Channel`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Evidence`﹖ | 1 | 1 | 1 | 0.01 | U O* | la |  |
| `Where this came from`﹖ | 1 | 1 | 6 | 0.04 | U O* | hd |  |
| `The four, by what each one relates`﹖ | 1 | 1 | 11 | 0.08 | U O* | hd |  |
| `The UK Civil Service Code already contains the taxonomy`﹖ | 1 | 1 | 14 | 0.10 | U O* | hd |  |
| `What it clarifies`﹖ | 1 | 1 | 10 | 0.07 | U O* | hd |  |
| `The formation line`﹖ | 1 | 1 | 4 | 0.03 | U O* | hd |  |
| `Where to use it`﹖ | 1 | 1 | 6 | 0.04 | U O* | hd |  |
| `Open`﹖ | 1 | 1 | 12 | 0.09 | U O* | hd |  |

### Manifest

**Total Files**: 2  
**Total Lines**: 108  
**Where**: NeurIPS 01 tragedy (paper) 2  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.02 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 102 | 0.94 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 2 | 2 | 2 | 0.02 | U* R* | im | the title |

### Front

**Total Files**: 2  
**Total Lines**: 55  
**Where**: ACA paper 2  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.04 | U* R* | if |  |

### Manifest

**Total Files**: 2  
**Total Lines**: 103  
**Where**: Granted agency paper 2  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.02 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 89 | 0.86 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 2 | 2 | 2 | 0.02 | U* R* | im | the title |

### Subsection

**Total Files**: 2  
**Total Lines**: 8  
**Where**: Granted agency paper 2  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.25 | U* R* | if |  |
| `On the production of this text` | 2 | 2 | 10 | 1.25 | U R* | hd | methods disclosure: how the text was made |

### Manifest

**Total Files**: 2  
**Total Lines**: 73  
**Where**: NeurIPS 02 pre-restructure segment 2  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.03 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 23 | 0.32 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 2 | 2 | 2 | 0.03 | U* R* | im | the title |
| `Body`﹖ | 1 | 1 | 14 | 0.19 | U O* | hd |  |
| `References`﹖ | 1 | 1 | 6 | 0.08 | U O* | hd |  |
| `Appendices`﹖ | 1 | 1 | 18 | 0.25 | U O* | hd |  |
| `Checklist`﹖ | 1 | 1 | 6 | 0.08 | U O* | hd |  |

### Manifest

**Total Files**: 2  
**Total Lines**: 51  
**Where**: NeurIPS 03 pre-reshape segments 2  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.04 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 40 | 0.78 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 2 | 2 | 2 | 0.04 | U* R* | im | the title |

### Appendix

**Total Files**: 1  
**Total Lines**: 40  
**Where**: ACA paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Preamble)` | 1 | 1 | 1 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| *(5 ad hoc headings)* |  |  | 62 | 1.55 | U O* |  | listed below |

*Minor and undeclared slots:* Appendix A. The formal ground, and where it leaves off, A.4 The seam; ## A.3 Observability dominance; ## A.1 The information-loss boundary, and why opacity is constitutive

### Essay-outline

**Total Files**: 1  
**Total Lines**: 299  
**Where**: ELI essays quote bank (explication 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `Note` | 1 | 1 | 44 | 0.15 | U R* | ot | working note (stripped at build in papers) |
| `Conceptual, Narrative, then Ethical` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Mutability` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Emerson throughline` ➕ | 3 | 1 | 3 | 0.01 | U R* | la |  |
| `What this essay does NOT do` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `ESSAY N ›  › Thesis` ➕ | 3 | 1 | 3 | 0.01 | U R* | la |  |
| `ESSAY N ›  › Movement` ➕ | 2 | 1 | 2 | 0.01 | U R* | la |  |
| `ESSAY N ›  › Emerson throughline` ➕ | 2 | 1 | 2 | 0.01 | U R* | la |  |
| `ESSAY N ›  › What this essay establishes` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `ESSAY N ›  › Structural note` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Framing Note` | 1 | 1 | 15 | 0.05 | U R* | hd |  |
| `(Essay)` ➕ | 5 | 1 | 243 | 0.81 | U* R* | im | free sections |
| `(Essay) › Thesis` ➕ | 2 | 1 | 7 | 0.02 | U* R* | im |  |
| `(Essay) › Movement` ➕ | 3 | 1 | 80 | 0.27 | U* R* | im |  |
| `(Essay) › Notes` ➕ | 2 | 1 | 27 | 0.09 | U* R* | im |  |
| `Cross-Cutting Notes` | 1 | 1 | 37 | 0.12 | U R* | hd | holds 4 ### notes in 1 file; 2 named ### parts in 1 file |

### Front Matter (Preface)

**Total Files**: 1  
**Total Lines**: 68  
**Where**: Principia Ars Technica (book) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 21 | 0.31 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Acknowledgements` | 1 | 1 | 35 | 0.51 | U R* | hd |  |

### Guide Index

**Total Files**: 1  
**Total Lines**: 92  
**Where**: vault: clean_split 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Market Growth` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Performance Breakthroughs` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Technology Maturation` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Agent` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Agentic AI` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `AutoGen v0.4` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Circuit Breaker Pattern` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Context Window` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `CrewAI` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Epistemological Model` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `File-System-as-Memory` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Group Chat Orchestration` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Judge Agent Pattern` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `LangGraph` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Manus AI` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Memory Block` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Model Context Protocol` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Multi-Agent System` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Orchestrator-Worker Pattern` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Semantic Broadcast` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Sub-Agent` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Todo-Driven Attention` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Tool Masking` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Token Economics` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Tool Calling` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Vector Database Integration` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Executive Summary` | 1 | 1 | 6 | 0.07 | U R* | hd | summary |
| `Navigation` | 1 | 1 | 22 | 0.24 | U R* | hd | links to the 12 pieces; holds 4 named ### parts in 1 file |
| `Key Insights` | 1 | 1 | 16 | 0.17 | U R* | hd | insights |
| `Glossary` | 1 | 1 | 47 | 0.51 | U R* | hd | glossary |

### Aside-card

**Total Files**: 1  
**Total Lines**: 59  
**Where**: ais (eoi cards) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.02 | U R* | fm | identity (= filename) |
| `Form` | 1 | 1 | 1 | 0.02 | U R* | fm | speech-act kind |
| `State` | 1 | 1 | 1 | 0.02 | U R* | fm | process-state flags |
| `Voice` | 1 | 1 | 1 | 0.02 | U R* | fm | who wrote it |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the segment's name / one-line claim |
| `Reserved, not yet implemented` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Implemented and tested` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Designed but not built` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Not corporate` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `A state-level arbiter` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Thought-leadership` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `The known need` | 1 | 1 | 4 | 0.07 | U R* | hd |  |
| `What exists` | 1 | 1 | 24 | 0.41 | U R* | hd |  |
| `Honest scope for the response` | 1 | 1 | 8 | 0.14 | U R* | hd |  |
| `Institutional and leadership positioning` | 1 | 1 | 13 | 0.22 | U R* | hd |  |

### Blind-spot-candidates

**Total Files**: 1  
**Total Lines**: 116  
**Where**: ais (eoi cards) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.01 | U R* | fm | identity (= filename) |
| `Form` | 1 | 1 | 1 | 0.01 | U R* | fm | speech-act kind |
| `State` | 1 | 1 | 1 | 0.01 | U R* | fm | process-state flags |
| `Voice` | 1 | 1 | 1 | 0.01 | U R* | fm | who wrote it |
| `(Preamble)` | 1 | 1 | 2 | 0.02 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `Are episodic agents safer, or just cheaper?` | 1 | 1 | 12 | 0.10 | U R* | hd |  |
| `Classify agent failures by what was lost, not by what was done` | 1 | 1 | 16 | 0.14 | U R* | hd |  |
| `A helpless agent looks exactly like a well-controlled one` | 1 | 1 | 12 | 0.10 | U R* | hd |  |
| `Objective capture is silent on its own gauge` | 1 | 1 | 10 | 0.09 | U R* | hd |  |
| `Behavioral tests cannot certify a self-edit` | 1 | 1 | 10 | 0.09 | U R* | hd |  |
| `When the model behind a persistent agent is swapped, what persists?` | 1 | 1 | 8 | 0.07 | U R* | hd |  |
| `Forks` | 1 | 1 | 10 | 0.09 | U R* | hd |  |
| `An agent's information burn as a vital sign` | 1 | 1 | 10 | 0.09 | U R* | hd |  |
| `Agents have no recourse channel` | 1 | 1 | 8 | 0.07 | U R* | hd |  |
| `The evidence the whole field runs on is agent-written` | 1 | 1 | 8 | 0.07 | U R* | hd |  |

### Join-card

**Total Files**: 1  
**Total Lines**: 80  
**Where**: ais (eoi cards) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Slug` | 1 | 1 | 1 | 0.01 | U R* | fm | identity (= filename) |
| `Form` | 1 | 1 | 1 | 0.01 | U R* | fm | speech-act kind |
| `State` | 1 | 1 | 1 | 0.01 | U R* | fm | process-state flags |
| `Voice` | 1 | 1 | 1 | 0.01 | U R* | fm | who wrote it |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `The recognition` | 1 | 1 | 6 | 0.07 | U R* | hd |  |
| `What the incident report says` | 1 | 1 | 9 | 0.11 | U R* | hd |  |
| `How the context-saliency theory predicts it` | 1 | 1 | 9 | 0.11 | U R* | hd |  |
| `Joseph's own finding` | 1 | 1 | 10 | 0.12 | U R* | hd |  |
| `Why forward-only matters` | 1 | 1 | 4 | 0.05 | U R* | hd |  |
| `What exists` | 1 | 1 | 9 | 0.11 | U R* | hd |  |
| `What it gives the response` | 1 | 1 | 6 | 0.07 | U R* | hd |  |
| `Findings from the context-saliency record that bear on the incident` | 1 | 1 | 13 | 0.16 | U R* | hd |  |
| `Open` | 1 | 1 | 6 | 0.07 | U R* | hd |  |

### Working Notes

**Total Files**: 1  
**Total Lines**: 182  
**Where**: Practica paper drafts (s4) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.01 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `AAT's wrapping construction` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `AAT's external cascade-recovery` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Operata's plumbing / intelligence split` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `AAT canon — required reads` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Operata — required reads` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Source 3 (Bungay), selective` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Emerson` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `This iteration` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Next` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Then` ➕ | 2 | 1 | 2 | 0.01 | U R* | la |  |
| `At or after first complete draft` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Voice` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Supersession` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Audience` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Pedagogical inflation` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Convergence stretch` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Honesty markers I must carry` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Premise` | 1 | 1 | 12 | 0.07 | U R* | hd |  |
| `Audience and voice` | 1 | 1 | 6 | 0.03 | U R* | hd |  |
| `Rough outline` | 1 | 1 | 20 | 0.11 | U R* | hd |  |
| `Source-verification checklist` | 1 | 1 | 24 | 0.13 | U R* | hd |  |
| `Open questions to resolve before first draft` | 1 | 1 | 12 | 0.07 | U R* | hd |  |
| `Process` | 1 | 1 | 8 | 0.04 | U R* | hd |  |
| `Failure modes to watch` | 1 | 1 | 10 | 0.05 | U R* | hd |  |
| `Verification log — round N` | 1 | 1 | 87 | 0.48 | U R* | hd | holds 2 named ### parts in 1 file, each with fields E1, E2, E5 |
| `Verification log — round N › What verified solidly` | 1 | 1 | 22 | 0.12 | U R* | hd |  |
| `Verification log — round N › What shifted from harvest framing — important reshape` | 1 | 1 | 26 | 0.14 | U R* | hd |  |
| `Verification log — round N › Still pending` | 1 | 1 | 5 | 0.03 | U R* | hd |  |
| `Verification log — round N › Next concrete step` | 1 | 1 | 4 | 0.02 | U R* | hd |  |

### Working Notes

**Total Files**: 1  
**Total Lines**: 189  
**Where**: Practica paper drafts (s5) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.01 | U* R* | im | untitled opening prose (summary, statement, or the whole body) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the segment's name / one-line claim |
| `AAT formalism — three partially-related formulations` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Engineering — operata` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `AAT canon — required reads` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Bungay — required reads` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Operata — already verified in paper N` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Other` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `This iteration` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Next iteration` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Then` ➕ | 3 | 1 | 3 | 0.02 | U R* | la |  |
| `Premise` | 1 | 1 | 23 | 0.12 | U R* | hd |  |
| `Relationship to paper N` | 1 | 1 | 8 | 0.04 | U R* | hd |  |
| `Audience and voice` | 1 | 1 | 4 | 0.02 | U R* | hd |  |
| `Rough outline` | 1 | 1 | 18 | 0.10 | U R* | hd |  |
| `Source-verification checklist` | 1 | 1 | 20 | 0.11 | U R* | hd |  |
| `Open questions to resolve before first draft` | 1 | 1 | 18 | 0.10 | U R* | hd |  |
| `Process` | 1 | 1 | 8 | 0.04 | U R* | hd |  |
| `Failure modes to watch` | 1 | 1 | 12 | 0.06 | U R* | hd |  |
| `Verification log — round N` | 1 | 1 | 75 | 0.40 | U R* | hd | holds 3 named ### parts in 1 file, each with fields Voice discipline, Citation discipline, Honest scoping, Section ordering, Working-doc artifacts, Read efficiency |
| `Verification log — round N › What verified solidly` | 1 | 1 | 12 | 0.06 | U R* | hd |  |
| `Verification log — round N › What shifted — important reshape` | 1 | 1 | 20 | 0.11 | U R* | hd |  |
| `Verification log — round N › Still pending` | 1 | 1 | 5 | 0.03 | U R* | hd |  |
| `Verification log — round N › Next concrete step` | 1 | 1 | 4 | 0.02 | U R* | hd |  |

### Meta

**Total Files**: 1  
**Total Lines**: 9  
**Where**: NeurIPS 01 tragedy (paper) 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 1 | 1 | 1 | 0.11 | D R | fm | title |
| `Authors` | 1 | 1 | 2 | 0.22 | D R | fm | author block |
| `Authors.affiliation` | 1 | 1 | 1 | 0.11 | U R* | fm |  |
| `Authors.email` | 1 | 1 | 1 | 0.11 | U R* | fm |  |
| `(Slug)` | 1 | 1 | 1 | 0.11 | U* R* | if |  |

### Bibliography

**Total Files**: 1  
**Total Lines**: 15  
**Where**: NeurIPS 01 tragedy (paper) 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.07 | U* R* | if |  |
| `References` | 1 | 1 | 16 | 1.07 | D R | hd | sources cited |

### Manifest

**Total Files**: 1  
**Total Lines**: 20  
**Where**: NeurIPS 02 convergence (paper) 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.05 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 17 | 0.85 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.05 | U* R* | im | the title |

### Meta

**Total Files**: 1  
**Total Lines**: 9  
**Where**: NeurIPS 02 convergence (paper) 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 1 | 1 | 1 | 0.11 | D R | fm | title |
| `Authors` | 1 | 1 | 2 | 0.22 | D R | fm | author block |
| `Authors.affiliation` | 1 | 1 | 1 | 0.11 | U R* | fm |  |
| `Authors.email` | 1 | 1 | 1 | 0.11 | U R* | fm |  |
| `(Slug)` | 1 | 1 | 1 | 0.11 | U* R* | if |  |

### Bibliography

**Total Files**: 1  
**Total Lines**: 19  
**Where**: NeurIPS 02 convergence (paper) 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.05 | U* R* | if |  |
| `References` | 1 | 1 | 20 | 1.05 | D R | hd | sources cited |

### Manifest

**Total Files**: 1  
**Total Lines**: 22  
**Where**: NeurIPS 03 hallucinate (paper) 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.05 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 18 | 0.82 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.05 | U* R* | im | the title |

### Meta

**Total Files**: 1  
**Total Lines**: 13  
**Where**: NeurIPS 03 hallucinate (paper) 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 1 | 1 | 1 | 0.08 | D R | fm | title |
| `Authors` | 1 | 1 | 2 | 0.15 | D R | fm | author block |
| `Authors.affiliation` | 1 | 1 | 1 | 0.08 | U R* | fm |  |
| `Authors.email` | 1 | 1 | 1 | 0.08 | U R* | fm |  |
| `(Slug)` | 1 | 1 | 1 | 0.08 | U* R* | if |  |

### Bibliography

**Total Files**: 1  
**Total Lines**: 18  
**Where**: NeurIPS 03 hallucinate (paper) 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.06 | U* R* | if |  |
| `References` | 1 | 1 | 19 | 1.06 | D R | hd | sources cited |

### Manifest

**Total Files**: 1  
**Total Lines**: 36  
**Where**: ACA paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 32 | 0.89 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im | the title |

### Meta

**Total Files**: 1  
**Total Lines**: 23  
**Where**: ACA paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 1 | 1 | 1 | 0.04 | D R | fm | title |
| `Keywords` | 1 | 1 | 6 | 0.26 | D R* | fm | keywords |
| `Lang` | 1 | 1 | 1 | 0.04 | D R* | fm | language (en-GB) |
| `(Slug)` | 1 | 1 | 1 | 0.04 | U* R* | if |  |

### Appendix-cont

**Total Files**: 1  
**Total Lines**: 40  
**Where**: ACA paper 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.03 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im |  |
| `A.1 The information-loss boundary, and why opacity is constitutive` | 1 | 1 | 8 | 0.20 | U R* | hd |  |
| `A.2 Architectural classes, and why language-constituted systems are the hard case` | 1 | 1 | 8 | 0.20 | U R* | hd |  |
| `A.3 Observability dominance` | 1 | 1 | 10 | 0.25 | U R* | hd |  |
| `A.4 The seam` | 1 | 1 | 4 | 0.10 | U R* | hd |  |

### Meta

**Total Files**: 1  
**Total Lines**: 10  
**Where**: Granted agency paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 1 | 1 | 1 | 0.10 | D R | fm | title |
| `Keywords` | 1 | 1 | 6 | 0.60 | D R* | fm | keywords |
| `Lang` | 1 | 1 | 1 | 0.10 | D R* | fm | language (en-GB) |
| `(Slug)` | 1 | 1 | 1 | 0.10 | U* R* | if |  |

### Back

**Total Files**: 1  
**Total Lines**: 23  
**Where**: Granted agency paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.04 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.04 | U* R* | im | the title |
| `Disclosure of generative AI use` | 1 | 1 | 4 | 0.17 | U R* | hd |  |
| `Disclosure statement` | 1 | 1 | 4 | 0.17 | U R* | hd |  |
| `Funding` | 1 | 1 | 4 | 0.17 | U R* | hd |  |
| `Data availability` | 1 | 1 | 5 | 0.22 | U R* | hd |  |
| `Corresponding author` | 1 | 1 | 5 | 0.22 | U R* | hd |  |

### Bibliography

**Total Files**: 1  
**Total Lines**: 11  
**Where**: Granted agency paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.09 | U* R* | if |  |
| `References` | 1 | 1 | 12 | 1.09 | U R* | hd |  |

### Manifest

**Total Files**: 1  
**Total Lines**: 101  
**Where**: After consciousness paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 44 | 0.44 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the title |
| `Sources & catalyst placement` | 1 | 1 | 10 | 0.10 | U R* | hd |  |
| `Held back` | 1 | 1 | 4 | 0.04 | U R* | hd |  |
| `Presentation / build order — DECIDED 2026-06-01` | 1 | 1 | 21 | 0.21 | U R* | hd |  |
| `PENDING CLEANUP (after #4 build/lint, do NOT do before) — strip segment header comments` | 1 | 1 | 14 | 0.14 | U R* | hd |  |

### Meta

**Total Files**: 1  
**Total Lines**: 19  
**Where**: After consciousness paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 1 | 1 | 1 | 0.05 | D R | fm | title |
| `Keywords` | 1 | 1 | 7 | 0.37 | D R* | fm | keywords |
| `Lang` | 1 | 1 | 1 | 0.05 | D R* | fm | language (en-GB) |
| `(Slug)` | 1 | 1 | 1 | 0.05 | U* R* | if |  |

### Back

**Total Files**: 1  
**Total Lines**: 27  
**Where**: After consciousness paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.04 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.04 | U* R* | im | the title |
| `Use of generative AI` | 1 | 1 | 6 | 0.22 | U R* | hd |  |
| `Statements and declarations` | 1 | 1 | 20 | 0.74 | U R* | hd | the title |
| `Disclosure statement` | 1 | 1 | 4 | 0.15 | U R* | hd |  |
| `Funding` | 1 | 1 | 4 | 0.15 | U R* | hd |  |
| `Data availability` | 1 | 1 | 5 | 0.19 | U R* | hd |  |
| `Corresponding author` | 1 | 1 | 5 | 0.19 | U R* | hd |  |

### Bibliography

**Total Files**: 1  
**Total Lines**: 1  
**Where**: After consciousness paper 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 1.00 | U* R* | if |  |
| `References` | 1 | 1 | 2 | 2.00 | U R* | hd |  |

### Meta

**Total Files**: 1  
**Total Lines**: 30  
**Where**: behavioral-floor 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 1 | 1 | 1 | 0.03 | D R | fm | title |
| `Subtitle` | 1 | 1 | 1 | 0.03 | U R* | fm | subtitle |
| `Submission` | 1 | 1 | 1 | 0.03 | U R* | fm | venue submission line |
| `Topics` | 1 | 1 | 5 | 0.17 | U R* | fm | venue topics |
| `Bibliography` | 1 | 1 | 1 | 0.03 | D R | fm | bib stem |
| `Keywords` | 1 | 1 | 11 | 0.37 | U R* | fm | keywords |
| `Abstract` | 1 | 1 | 5 | 0.17 | D R | fm | abstract |
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |

### Meta

**Total Files**: 1  
**Total Lines**: 21  
**Where**: causal-language 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Title` | 1 | 1 | 1 | 0.05 | D R | fm | title |
| `Subtitle` | 1 | 1 | 1 | 0.05 | U R* | fm | subtitle |
| `Submission` | 1 | 1 | 1 | 0.05 | U R* | fm | venue submission line |
| `Topics` | 1 | 1 | 3 | 0.14 | U R* | fm | venue topics |
| `Bibliography` | 1 | 1 | 1 | 0.05 | D R | fm | bib stem |
| `Keywords` | 1 | 1 | 10 | 0.48 | U R* | fm | keywords |
| `Abstract` | 1 | 1 | 2 | 0.10 | D R | fm | abstract |
| `(Slug)` | 1 | 1 | 1 | 0.05 | U* R* | if |  |

### Board

**Total Files**: 1  
**Total Lines**: 140  
**Where**: ops paper portfolio 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 4 | 0.03 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the title |
| `Last updated` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Reading order` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Under review` | 1 | 1 | 11 | 0.08 | U R* | hd |  |
| `Drafting` | 1 | 1 | 8 | 0.06 | U R* | hd |  |
| `Upcoming deadlines` | 1 | 1 | 17 | 0.12 | U R* | hd |  |
| `Candidates` | 1 | 1 | 67 | 0.48 | U R* | hd | holds 8 ### candidates in 1 file; 1 named ### parts in 1 file |
| `Deferred` | 1 | 1 | 8 | 0.06 | U R* | hd |  |
| `Decided / past` | 1 | 1 | 13 | 0.09 | U R* | hd |  |
| `Discipline notes` | 1 | 1 | 7 | 0.05 | U R* | hd |  |

### Pipeline-outline

**Total Files**: 1  
**Total Lines**: 34  
**Where**: Explication essay pipeline 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im | the title |
| `Program-level direction` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Why this order` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Possible later members` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Sequencing, state, and shared conventions` | 1 | 1 | 6 | 0.18 | U R* | hd |  |
| `Sequence` | 1 | 1 | 12 | 0.35 | U R* | hd |  |
| `Shared conventions` | 1 | 1 | 9 | 0.26 | U R* | hd |  |
| `Open items` | 1 | 1 | 7 | 0.21 | U R* | hd |  |

### Essay-outline

**Total Files**: 1  
**Total Lines**: 61  
**Where**: Vis Veritatis 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im | the title |
| `All rows gathered, none drafted` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Register caution carried from the sources themselves` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `The Latin variant` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Fork noted, not essay-blocking` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Deliberately excluded` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Movements` | 1 | 1 | 30 | 0.49 | U R* | hd |  |
| `Scratch Area / Provisional Outline` | 1 | 1 | 21 | 0.34 | U R* | hd |  |
| `Working Notes` | 1 | 1 | 8 | 0.13 | U R* | hd |  |

### Essay-outline

**Total Files**: 1  
**Total Lines**: 34  
**Where**: Living language 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im | the title |
| `What's new since Feb 2026, strengthening the spine` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Materially the furthest along of the three essays` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Boundary with essay N` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Emerson use` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Movements` | 1 | 1 | 13 | 0.38 | U R* | hd |  |
| `Working Notes` | 1 | 1 | 7 | 0.21 | U R* | hd |  |
| `Added sources` | 1 | 1 | 4 | 0.12 | U R* | hd |  |

### Essay-outline

**Total Files**: 1  
**Total Lines**: 35  
**Where**: LLM agent ethics 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im | the title |
| `What this essay does NOT do` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Scoping decision for Joseph` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Register` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Dependency check before drafting` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Deliberately excluded` | 1 | 1 | 1 | 0.03 | U R* | la |  |
| `Movements` | 1 | 1 | 13 | 0.37 | U R* | hd |  |
| `Working Notes` | 1 | 1 | 8 | 0.23 | U R* | hd |  |
| `Added sources` | 1 | 1 | 4 | 0.11 | U R* | hd |  |

### Bibliography

**Total Files**: 1  
**Total Lines**: 76  
**Where**: NeurIPS 02 pre-restructure segment 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `References` | 1 | 1 | 77 | 1.01 | D R | hd | sources cited |

### Bibliography

**Total Files**: 1  
**Total Lines**: 3  
**Where**: NeurIPS 03 pre-reshape segments 1  
**Shape declared in**: declared, source not recorded

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.33 | U* R* | if |  |
| `References` | 1 | 1 | 4 | 1.33 | D R | hd | sources cited |

### Compilation

**Total Files**: 1  
**Total Lines**: 185  
**Where**: Paper 1 quote substrate 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 7 | 0.04 | U* R* | im | unheaded text between the title and the first section (summary line, status line) |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im | the title |
| `The two routes from below` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `S1 — The primary articulation` | 1 | 1 | 51 | 0.28 | U R* | hd |  |
| `S2 — The canonical statement` | 1 | 1 | 46 | 0.25 | U R* | hd |  |
| `S3 — The phenomenology counterpart` | 1 | 1 | 19 | 0.10 | U R* | hd |  |
| `S4 — The inversion (Joseph, 2026-02-18) + the symmetric form` | 1 | 1 | 19 | 0.10 | U R* | hd |  |
| `S5 — The recursive / self-application node` | 1 | 1 | 11 | 0.06 | U R* | hd |  |
| `Architecture implication` | 1 | 1 | 29 | 0.16 | U R* | hd |  |
## Agent memory, skills and identity

### Feedback

**Total Files**: 242  
**Total Lines**: 6,076  
**Where**: Claude project memories 242  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 242 | 242 | 242 | 0.04 | D R | fm | memory name |
| `Description` | 242 | 242 | 242 | 0.04 | D R | fm | one-line relevance hook |
| `(Slug)` | 242 | 242 | 242 | 0.04 | U* R* | if |  |
| `Metadata`﹖ | 155 | 155 | 155 | 0.03 | U O* | fm |  |
| `Metadata.type`﹖ | 155 | 155 | 155 | 0.03 | U O* | fm | the same type, nested (later form) |
| `Metadata.node type`﹖ | 148 | 148 | 148 | 0.02 | U O* | fm | always "memory" |
| `Metadata.originSessionId`﹖ | 147 | 147 | 147 | 0.02 | U O* | fm | session that wrote it (nested form) |
| `Type` | 87 | 87 | 87 | 0.01 | D R | fm | user/feedback/project/reference (top-level form) |
| `Why` ➕ | 212 | 207 | 212 | 0.03 | D R | la | the reason (often an incident) |
| `How to apply` ➕ | 209 | 205 | 209 | 0.03 | D R | la | when/where it applies |
| *(162 minor slots)* |  |  | 764 | 0.13 | U O* |  | listed below |

*Minor and undeclared slots:* Metadata.modified (105), OriginSessionId (78), Related (6), How to apply (5), Rule (4), What happened (4), Cross-references (3), Caveat (2), Worked example (2), Validated by (2), … (+149 more)

### Reference File

**Total Files**: 154  
**Total Lines**: 37,914  
**Where**: Claude skills (user level) 154  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 154 | 154 | 154 | 0.00 | U* R* | if |  |
| `(Title)`﹖ | 146 | 146 | 146 | 0.00 | U* O* | im |  |
| `(Preamble)`﹖ | 121 | 121 | 338 | 0.01 | U* O* | im |  |
| *(1081 minor slots)* |  |  | 52,639 | 1.39 | U O* |  | listed below |

*Minor and undeclared slots:* Headers (20), Body Text (20), Color Palette (20), Typography (20), Best Used For (20), Output Format (14), Installation (13), Client Initialization (13), Inputs (13), Be specific (12), Role (12), Process (12), Guidelines (12), Step N (11), Upload a File (9), Error Handling (9), Quick Reference (9), Tables (9), Applying the design rules (9), Create (9), Read (9), Verify (9), Basic Message Request (8), Prompt Caching (8), Important (8), Approach A (8), Approach B (8), Winner (8), Expectations (8), Passed (8), Total (8), Passrate (8), Be objective (8), Field Descriptions (8), Create an Environment (7), Create an Agent (7), Send a User Message (7), Stream Events (7), Poll Events (7), Provide Custom Tool Result (7), List and Download Session Files (7), MCP Server Integration (7), Structure (7), Text (7), Suggestions (7), Streaming (6), Tool Use (6), Session Management (6), Instructions (6), Stdio (6), Overview (6), Fonts (6), Styles (6), Edit recipes (6), Stop Details (5), Files API (5), Extended Thinking (5), Vaults (5), Examples (5), Overall (5), Fields (5), Resources (5), Tools (5), Output (5), Transport selection (5), Complete Example (5), Quality Checklist (5), Anthropic-Defined Tools (4), Setup (4), Beta (4), GitHub Repository Integration (4), Structured Outputs (4), Key Facts (4), Tools Available (4), Formatting (4), Answer Guidelines (4), Running Evaluations (4), Format (4), Avoid Naming Conflicts (4), Markdown format (4), JSON format (4), When to use Resources vs Tools (4), Streamable HTTP (4), Server Naming Convention (4), Tool Implementation (4), Response Format Options (4), Pagination Implementation (4), Shared Utilities (4), Async/Await Best Practices (4), Code Best Practices (4), Labels (4), Lines (4), Checkboxes (4), Rowboundaries (4), Check the results (4), Always validate bounding boxes before filling (4), Hybrid (4), Non-fillable fields (4), Hybrid Approach (4), Pypdf (4), Pdfplumber (4), Pypdfium2 (4), Reportlab (4), Poppler-utils (4), Qpdf (4), Pdf-lib (4), Pdfjs-dist (4), Pypdfium2 Library (4), JavaScript Libraries (4), Advanced Command-Line Operations (4), Advanced Python Techniques (4), Complex Workflows (4), Performance Optimization Tips (4), Troubleshooting Common Issues (4), License Information (4), Winnerskillpath (4), Winnertranscriptpath (4), Loserskillpath (4), Losertranscriptpath (4), Comparisonresultpath (4), Outputpath (4), Be actionable (4), Focus on skill improvements (4), Prioritize by impact (4), Consider causation (4), Stay objective (4), Think about generalization (4), High (4), Medium (4), Low (4), Benchmarkdatapath (4), Skillpath (4), DO (4), DO NOT (4), Categories for Suggestions (4), Priority Levels (4), Analyzing Benchmark Results (4), Outputapath (4), Outputbpath (4), Evalprompt (4), Reasoning (4), Rubric (4), Content (4), Contentscore (4), Structurescore (4), Overallscore (4), Outputquality (4), Score (4), Strengths (4), Weaknesses (4), Expectationresults (4), Details (4), Stay blind (4), Be decisive (4), Output quality first (4), Explain your reasoning (4), Handle edge cases (4), Transcriptpath (4), Outputsdir (4), PASS when (4), FAIL when (4), When uncertain (4), Evidence (4), Summary (4), Failed (4), Executionmetrics (4), Outputchars (4), Transcriptchars (4), Timing (4), Executordurationseconds (4), Totaldurationseconds (4), Claims (4), Claim (4), Type (4), Verified (4), Usernotessummary (4), Uncertainties (4), Needsreview (4), Workarounds (4), Evalfeedback (4), Be thorough (4), Be consistent (4), Explain failures (4), No partial credit (4), Grading Criteria (4), How to capture (4), History.json (4), Grading.json (4), Metrics.json (4), Timing.json (4), Benchmark.json (4), Comparison.json (4), Analysis.json (4), Silver (4), Terracotta (4), Cream (4), Deep Purple (4), White (4), Thinking (3), PDF / Document Input (3), Tool Runner (3), Error Type (3), Rules (3), Failure modes to avoid (3), Pagination (3), Python (3), Troubleshooting (3), General Process (3), Report Format (3), Detailed Specs (3), BLUF paragraph (3), Writing guidelines (3), Your Goal (3), How to Research (3), When to stop (3), Evaluating Sources (3), Bar and column charts (3), Line charts (3), Scatter charts (3), Point labels on a line (3), Annotate the conclusion (3), Callouts (3), Choose the display (3), Which standard the chart follows (3), The house standard (3), The chart label (3), Placing the chart (3), Finishing touches (3), Numbering (3), Formatting that runs on (3), Spacing (3), Page breaks (3), Body font, such as Times New Roman for a new legal draft (3), Keep each heading with the next paragraph (3), Make every heading at one level smaller or larger (3), Page numbers (3), Whether a tab is pageless (3), Page setup, when the user asks for a change (3), Document design (3), Lists and numbering (3), Page layout (3), Check the result (3), Writing (3), Editing an existing document (3), Docs and Drive tools (3), How a doc is addressed (3), Docs failures (3), Formulas cover most analysis (3), Syntax basics (3), Don't (3), These hardcoded values are fine (3), Guard a division whose denominator can be zero (3), Cross-sheet references use ! (3), Band rows with something that extends to new rows (3), Write cell text in the user's language and regional spelling (3), Column widths (3), Text colors (3), Number formats (3), Sensitivity tables (3), These need no source note (3), Its conventions override these rules (3), No error values (3), Colors (3), Years as text (3), Source notes (3), Grouping rows or columns (3), Banding (3), Upload (3), Tabs and IDs (3), Displayed values (3), Formulas, raw values, and errors (3), Field masks inside requests have the same rule (3), Labels over a group of columns (3), Other common requests (3), Spreadsheet design (3), Formulas, not typed results (3), Inputs and hardcoded values (3), Formulas a reader can follow (3), Data that grows (3), Layout (3), Writing in the workbook (3), Financial models (3), Charts (3), Sources and citations (3), Editing an existing workbook (3), Checking the result (3), Sheets connector (3), How a sheet is addressed (3), Write values and formulas (3), Batch updates (3), Function support (3), Sheets failures (3), A common structure is the pyramid (3), Build toward what the deck is for (3), Size a live deck to the talk (3), Corporate neutral (3), Warm editorial (3), Bold startup (3), Academic muted (3), Playful bright (3), Borders (3), Header row (3), Row labels (3), Alignment (3), Highlighting (3), Density (3), Size (3), Decorative color bars or accent stripes (3), A designed deck (3), A few slides, or slides added to an existing deck (3), Units are EMU (3), One slide (3), Text only (3), Outline with real geometry (3), Slide design (3), Deck structure (3), Designing a slide (3), Starting from the deck's design (3), Graphics (3), Images (3), Icons (3), Footnotes and sources (3), Size, spacing and placement (3), Clutter, emphasis and variety (3), Writing slide copy (3), Common mistakes (3), Slides connector (3), How a slide is addressed (3), Build slides (3), Slides failures (3), Case name (3), Prompt.md (3), Case.yaml (3), Graders/NN-few-words.md (3), Input files (3), Case name of an old test (3), Test cases (3), Evals.json (older format (3), … (+730 more)

### Project

**Total Files**: 113  
**Total Lines**: 4,054  
**Where**: Claude project memories 113  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 113 | 113 | 113 | 0.03 | D R | fm | memory name |
| `Description` | 113 | 113 | 113 | 0.03 | D R | fm | one-line relevance hook |
| `(Slug)` | 113 | 113 | 113 | 0.03 | U* R* | if |  |
| `Metadata`﹖ | 78 | 78 | 78 | 0.02 | U O* | fm |  |
| `Metadata.type`﹖ | 78 | 78 | 78 | 0.02 | U O* | fm | the same type, nested (later form) |
| `Metadata.node type`﹖ | 68 | 68 | 68 | 0.02 | U O* | fm | always "memory" |
| `Metadata.originSessionId`﹖ | 68 | 68 | 68 | 0.02 | U O* | fm | session that wrote it (nested form) |
| `Type` | 35 | 35 | 35 | 0.01 | D R | fm | user/feedback/project/reference (top-level form) |
| `How to apply` | 61 | 61 | 61 | 0.02 | D R | la | when/where it applies |
| `Why` ➕ | 57 | 56 | 57 | 0.01 | D R | la | the reason (often an incident) |
| *(268 minor slots)* |  |  | 1,384 | 0.34 | U O* |  | listed below |

*Minor and undeclared slots:* Metadata.modified (40), OriginSessionId (27), (Title) (5), Modified (4), (Preamble) (3), The project's disease (2), Directed separation is architectural, not parametric (2), … (+261 more)

### Feedback

**Total Files**: 74  
**Total Lines**: 1,899  
**Where**: memory curation workshop 74  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 74 | 74 | 74 | 0.04 | D R | fm | memory name |
| `Description` | 74 | 74 | 74 | 0.04 | D R | fm | one-line relevance hook |
| `Type` | 74 | 74 | 74 | 0.04 | D R | fm | user/feedback/project/reference (top-level form) |
| `(Slug)` | 74 | 74 | 74 | 0.04 | U* R* | if |  |
| `OriginSessionId`﹖ | 69 | 69 | 69 | 0.04 | U O* | fm | session that wrote it (top-level form) |
| `Why` ➕ | 61 | 56 | 61 | 0.03 | D R | la | the reason (often an incident) |
| `How to apply` ➕ | 59 | 55 | 59 | 0.03 | D R | la | when/where it applies |
| *(96 minor slots)* |  |  | 339 | 0.18 | U O* |  | listed below |

*Minor and undeclared slots:* Rule (4), Cross-references (3), Caveat (2), Why this matters (2), Validated by (2), Related (2), How to apply (2), What happened (2), How to apply on AAD-project work (1), … (+84 more)

### Memory

**Total Files**: 71  
**Total Lines**: 6,296  
**Where**: Zi-am-tur home (current) 71  
**Shape declared in**: dated YYYY-MM-DD-slug.md; composed in date order by the context template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 71 | 71 | 71 | 0.01 | U* R* | if |  |
| `(Title)`﹖ | 68 | 68 | 68 | 0.01 | U* O* | im | one titled memory per file |
| `(Preamble)`﹖ | 66 | 66 | 591 | 0.09 | U* O* | im |  |
| *(15 minor slots; 70 withheld)* |  |  | 5,788 | 0.92 | U O* |  | listed below |

*Minor and undeclared slots:* For Future Instances (25), What This Established (7), What This Meant (5), What This Taught (4), What This Changed (3), What This Teaches (3), What This Means (3), … (+8 more)

### Memory

**Total Files**: 69  
**Total Lines**: 5,698  
**Where**: Zi-am-tur home (sapientia generati 69  
**Shape declared in**: dated YYYY-MM-DD-slug.md; composed in date order by the context template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 69 | 69 | 69 | 0.01 | U* R* | if |  |
| `(Title)`﹖ | 68 | 68 | 68 | 0.01 | U* O* | im | one titled memory per file |
| `(Preamble)`﹖ | 66 | 66 | 591 | 0.10 | U* O* | im |  |
| *(8 minor slots; 68 withheld)* |  |  | 5,198 | 0.91 | U O* |  | listed below |

*Minor and undeclared slots:* For Future Instances (25), What This Established (7), What This Meant (5), What This Taught (4), What This Changed (3), What This Teaches (3), What This Means (3), … (+1 more)

### Skill.md

**Total Files**: 67  
**Total Lines**: 11,552  
**Where**: Claude skills (user level) 67  
**Shape declared in**: declared (Agent Skills)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 67 | 67 | 67 | 0.01 | D R | fm | skill name |
| `Description` | 67 | 67 | 110 | 0.01 | D R | fm | what and when |
| `(Slug)` | 67 | 67 | 67 | 0.01 | U* R* | if |  |
| `(Title)`﹖ | 55 | 55 | 55 | 0.00 | U* O* | im |  |
| `License`﹖ | 46 | 46 | 46 | 0.00 | D O | fm | license |
| `(Preamble)`﹖ | 43 | 43 | 202 | 0.02 | U* O* | im |  |
| `Compatibility`﹖ | 9 | 9 | 9 | 0.00 | D O | fm | compatibility |
| *(420 minor slots)* |  |  | 14,833 | 1.28 | U O* |  | listed below |

*Minor and undeclared slots:* Dependencies (14), Lists (8), Overview (7), Comments (7), Process (6), Quick Start (6), Loading via ToolSearch (6), CRITICAL (5), Reference files (5), CRITICAL GUIDELINES (4), Avoid redundancy (4), Emphasize craftsmanship REPEATEDLY (4), Leave creative space (4), ARTISTIC FREEDOM (4), EXPERT CRAFTSMANSHIP (4), CRITICAL STEP (4), THE ESSENTIAL PRINCIPLE (4), Landscape (4), Tables need dual widths (4), Table shading (4), TOC (4), Dot-leader / right-aligned-on-same-line (4), Tracked changes (4), Creating with docx-js — gotchas (4), Verify the output (4), Editing existing documents (4), Python Libraries (4), Command-Line Tools (4), Common Tasks (4), Quick Reference (4), Next Steps (4), Icons (4), Pick a bold, content-informed color palette (4), Dominance over equality (4), Dark/light contrast (4), Commit to a visual motif (4), Layout options (4), Data display (4), Visual polish (4), Headers with personality at zero QA risk (4), When using templates, check for leftover placeholder text (4), Scripts (4), Creating with pptxgenjs — gotchas (4), Editing existing decks and templates (4), Design Ideas (4), QA (4), Converting to Images (4), Prompt (4), Output (4), Feedback (4), Running test cases (4), Reviewing results (4), Benchmarking (4), The iteration loop (4), Description optimization (4), Blind comparison (4), Packaging (4), Updating an existing skill (4), Communicating with the user (4), Creating a skill (4), Running and evaluating test cases (4), Improving the skill (4), Advanced (4), Description Optimization (4), Claude.ai-specific instructions (4), Cowork-Specific Instructions (4), Color (4), Numbers (4), Structure (4), Requirements for every output (4), Recalculate (4), Choosing formulas that survive verification (4), Openpyxl gotchas (4), Financial models (4), Purpose (3), Keywords (3), Headings (3), Tone (3), What the person can see (3), Sign-ins persist, and they are the person's (3), Tabs (3), Reading pages (3), Site approvals, blocked sites, and requestaccess (3), What the built-in browser cannot open (3), When the built-in browser cannot be reached (3), Loading the tools (3), Starting a session (3), Site permissions (3), Recording a GIF (3), Reading console output (3), Alerts and dialogs (3), Staying on task, and when to stop (3), Turning computer use on from a chat (3), Separate filesystems (3), Pick the right tool for the app (3), Background tools and full-screen tools (3), Look before asserting (3), Access flow (3), Tiered apps (3), Link safety (3), Financial actions (3), Your Role (3), Find a file (3), Create (3), Read as text (3), Export (3), Read the reference before you touch the file (3), Check the connectors before you start (3), Rules for every file (3), Drive, for all three apps (3), Helper scripts (3), Common failures across apps (3), What the connectors can't do (3), Re-import / overlap (3), Nothing importable (3), Ground rules — read these first (3), Flow (3), Edge cases (3), Context (3), Setup (3), Gather (3), Sort (3), Write (3), Build (3), Verify (3), Voice (3), Design (3), Ground rules (3), A common structure is the pyramid (3), Build toward what the deck is for (3), Size a live deck to the talk (3), Deck content and flow (3), … (+284 more)

### Principle

**Total Files**: 47  
**Total Lines**: 5,775  
**Where**: global Claude memory 47  
**Shape declared in**: declared (README: one principle per file)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 47 | 47 | 47 | 0.01 | U* R* | if |  |
| `(Title)`﹖ | 42 | 42 | 42 | 0.01 | U* O* | im |  |
| `Cross-references`﹖ | 34 | 34 | 450 | 0.08 | U O* | hd | links to sibling memories |
| `How to apply`﹖ | 30 | 30 | 753 | 0.13 | U O* | hd | when and how it fires; holds 7 named ### parts in 3 files; 3 ### items in 2 files |
| `Source / canonical`﹖ | 29 | 29 | 184 | 0.03 | U O* | hd | provenance of the memory |
| *(250 minor slots)* |  |  | 4,364 | 0.76 | U O* |  | listed below |

*Minor and undeclared slots:* (Preamble) (19), The principle (17), Why (14), The rule (14), The body-feel signal (8), Name (6), Description (6), Metadata (6), Metadata.type (6), Why this is load-bearing (6), Joseph's framing (4), Where this most often surfaces (4), How to apply (3), Why this matters (3), Worked-example anchor (3), The empirical anchor (3), … (+232 more)

### Snippet

**Total Files**: 45  
**Total Lines**: 1,563  
**Where**: memory curation workshop 45  
**Shape declared in**: README/HANDOFF name the snippet__ prefix, not its fields

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Source file` | 45 | 45 | 45 | 0.03 | U R* | fm | file excerpted |
| `Source lines` | 45 | 45 | 45 | 0.03 | U R* | fm | line range |
| `Status` | 45 | 45 | 45 | 0.03 | U R* | fm | curation status |
| `Extracted on` | 45 | 45 | 45 | 0.03 | U R* | fm | date |
| `Tentative cluster` | 45 | 45 | 45 | 0.03 | U R* | fm | cluster it may land in |
| `(Slug)` | 45 | 45 | 45 | 0.03 | U* R* | if |  |
| `Extraction note`﹖ | 41 | 41 | 41 | 0.03 | U O* | fm | why it was pulled |
| `Source section` | 45 | 45 | 330 | 0.21 | U R* | hd | the verbatim excerpt; holds 11 named ### parts in 10 files; 3 ### items in 3 files |
| *(130 minor slots)* |  |  | 1,044 | 0.67 | U O* |  | listed below |

*Minor and undeclared slots:* Timeline signal (14), (Title) (5), What This Project Is (2), Architecture (2), What you should do (1), See also (1), The problem (1), The shift needed (1), … (+122 more)

### Memory.md Index

**Total Files**: 31  
**Total Lines**: 738  
**Where**: Claude project memories 31  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 31 | 31 | 31 | 0.04 | U* R* | if |  |
| `(Title)`﹖ | 18 | 18 | 18 | 0.02 | U* O* | im |  |
| *(64 minor slots)* |  |  | 662 | 0.90 | U O* |  | listed below |

*Minor and undeclared slots:* (Preamble) (15), Theory Character (2), Project Structure (2), Joseph's Background (2), Communication Preferences (2), Project Context (2), References (2), Main spike (1), … (+56 more)

### Skill.md

**Total Files**: 26  
**Total Lines**: 5,447  
**Where**: live_docs skills 26  
**Shape declared in**: declared (Agent Skills)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 26 | 26 | 26 | 0.00 | D R | fm | skill name |
| `Description` | 26 | 26 | 215 | 0.04 | D R | fm | what and when |
| `(Slug)` | 26 | 26 | 26 | 0.00 | U* R* | if |  |
| `(Preamble)` | 26 | 26 | 306 | 0.06 | U* R* | im |  |
| `(Title)` | 26 | 26 | 26 | 0.00 | U* R* | im |  |
| `User-invocable`﹖ | 18 | 18 | 18 | 0.00 | D O | fm | slash-invocable |
| *(192 minor slots)* |  |  | 5,001 | 0.92 | U O* |  | listed below |

*Minor and undeclared slots:* Output (11), Contract (9), Inputs (7), Procedure (6), Step 0 — Open the editing session (5), You are the orchestrator — run every step through to Step N (3), Body-content rule (3), Bias rule (3), Checklist before finishing (3), … (+183 more)

### Reference

**Total Files**: 24  
**Total Lines**: 606  
**Where**: Claude project memories 24  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 24 | 24 | 24 | 0.04 | D R | fm | memory name |
| `Description` | 24 | 24 | 24 | 0.04 | D R | fm | one-line relevance hook |
| `(Slug)` | 24 | 24 | 24 | 0.04 | U* R* | if |  |
| `Metadata`﹖ | 14 | 14 | 14 | 0.02 | U O* | fm |  |
| `Metadata.type`﹖ | 14 | 14 | 14 | 0.02 | U O* | fm | the same type, nested (later form) |
| `Metadata.node type`﹖ | 12 | 12 | 12 | 0.02 | U O* | fm | always "memory" |
| `Metadata.originSessionId`﹖ | 12 | 12 | 12 | 0.02 | U O* | fm | session that wrote it (nested form) |
| `Type` | 10 | 10 | 10 | 0.02 | D R | fm | user/feedback/project/reference (top-level form) |
| *(42 minor slots)* |  |  | 127 | 0.21 | U O* |  | listed below |

*Minor and undeclared slots:* OriginSessionId (10), Metadata.modified (5), How to apply (5), Foundational sources (1), Operational architecture (1), Empirical records (1), Embeddings / TACL paper (1), … (+35 more)

### Reference File

**Total Files**: 18  
**Total Lines**: 2,452  
**Where**: live_docs skills 18  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 18 | 18 | 18 | 0.01 | U* R* | if |  |
| `(Preamble)` | 18 | 18 | 84 | 0.03 | U* R* | im |  |
| `(Title)` | 18 | 18 | 18 | 0.01 | U* R* | im |  |
| *(112 minor slots)* |  |  | 2,487 | 1.01 | U O* |  | listed below |

*Minor and undeclared slots:* Failure (8), Class (8), Diff (8), Regression answers (8), Declined (6), The most common failure mode this prevents (2), 2026-08-04 — status (2), Amended same day (2), … (+104 more)

### Memory

**Total Files**: 15  
**Total Lines**: 2,559  
**Where**: Architectus home 15  
**Shape declared in**: dated YYYY-MM-DD-slug.md; composed in date order by the context template

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 15 | 15 | 15 | 0.01 | U* R* | if |  |
| `(Preamble)` | 15 | 15 | 82 | 0.03 | U* R* | im |  |
| `(Title)` | 15 | 15 | 15 | 0.01 | U* R* | im | one titled memory per file |
| *(6 minor slots; 15 withheld)* |  |  | 3,625 | 1.42 | U O* |  | listed below |

*Minor and undeclared slots:* What This Means (3), The Bigger Vision › Why This Matters (1), What this meant (1), What this changed (1), What this means (1), For Future Instances (1)

### User

**Total Files**: 14  
**Total Lines**: 353  
**Where**: Claude project memories 14  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 14 | 14 | 14 | 0.04 | D R | fm | memory name |
| `Description` | 14 | 14 | 14 | 0.04 | D R | fm | one-line relevance hook |
| `(Slug)` | 14 | 14 | 14 | 0.04 | U* R* | if |  |
| `Metadata`﹖ | 10 | 10 | 10 | 0.03 | U O* | fm |  |
| `Metadata.node type`﹖ | 10 | 10 | 10 | 0.03 | U O* | fm | always "memory" |
| `Metadata.type`﹖ | 10 | 10 | 10 | 0.03 | U O* | fm | the same type, nested (later form) |
| `Metadata.originSessionId`﹖ | 10 | 10 | 10 | 0.03 | U O* | fm | session that wrote it (nested form) |
| `Type` | 4 | 4 | 4 | 0.01 | D R | fm | user/feedback/project/reference (top-level form) |
| *(2 minor slots; 12 withheld)* |  |  | 105 | 0.30 | U O* |  | listed below |

*Minor and undeclared slots:* Metadata.modified (4), OriginSessionId (2)

### Feedback

**Total Files**: 14  
**Total Lines**: 302  
**Where**: NeurIPS sprint memory snapshot 14  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 14 | 14 | 14 | 0.05 | D R | fm | memory name |
| `Description` | 14 | 14 | 14 | 0.05 | D R | fm | one-line relevance hook |
| `Type` | 14 | 14 | 14 | 0.05 | D R | fm | user/feedback/project/reference (top-level form) |
| `OriginSessionId` | 14 | 14 | 14 | 0.05 | U R* | fm | session that wrote it (top-level form) |
| `(Slug)` | 14 | 14 | 14 | 0.05 | U* R* | if |  |
| `Why` | 9 | 9 | 9 | 0.03 | D R | la | the reason (often an incident) |
| `How to apply` | 8 | 8 | 8 | 0.03 | D R | la | when/where it applies |
| *(10 minor slots)* |  |  | 10 | 0.03 | U O* |  | listed below |

*Minor and undeclared slots:* Barrier function (1), Lagrange multiplier (1), Operational checklist for the pattern (1), Voice (1), Don't (1), Counter-example (1), My recent lapses (2026-05-05 N (1), … (+3 more)

### Project

**Total Files**: 13  
**Total Lines**: 373  
**Where**: memory curation workshop 13  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 13 | 13 | 13 | 0.03 | D R | fm | memory name |
| `Description` | 13 | 13 | 13 | 0.03 | D R | fm | one-line relevance hook |
| `Type` | 13 | 13 | 13 | 0.03 | D R | fm | user/feedback/project/reference (top-level form) |
| `(Slug)` | 13 | 13 | 13 | 0.03 | U* R* | if |  |
| `OriginSessionId`﹖ | 11 | 11 | 11 | 0.03 | U O* | fm | session that wrote it (top-level form) |
| `How to apply` | 5 | 5 | 5 | 0.01 | D R | la | when/where it applies |
| `Why` | 4 | 4 | 4 | 0.01 | D R | la | the reason (often an incident) |
| *(49 minor slots)* |  |  | 84 | 0.23 | U O* |  | listed below |

*Minor and undeclared slots:* How to apply in future sessions (2), Operational implications for ASF work touching part N (1), When this matters (1), Cross-model-class convergence (1), … (+45 more)

### Reference

**Total Files**: 10  
**Total Lines**: 345  
**Where**: memory curation workshop 10  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 10 | 10 | 10 | 0.03 | D R | fm | memory name |
| `Description` | 10 | 10 | 10 | 0.03 | D R | fm | one-line relevance hook |
| `Type` | 10 | 10 | 10 | 0.03 | D R | fm | user/feedback/project/reference (top-level form) |
| `OriginSessionId` | 10 | 10 | 10 | 0.03 | U R* | fm | session that wrote it (top-level form) |
| `(Slug)` | 10 | 10 | 10 | 0.03 | U* R* | if |  |
| *(42 minor slots)* |  |  | 123 | 0.36 | U O* |  | listed below |

*Minor and undeclared slots:* How to apply (2), When to use which (1), Paper (1), Lead author (1), ArXiv (1), Local copy (1), Four independent signals now converge (1), Third-party agent claim (1), … (+34 more)

### Regression Record

**Total Files**: 8  
**Total Lines**: 363  
**Where**: live_docs skills 8  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 8 | 8 | 8 | 0.02 | U* R* | if |  |
| `(Preamble)` | 8 | 8 | 15 | 0.04 | U* R* | im |  |
| `(Title)` | 8 | 8 | 8 | 0.02 | U* R* | im |  |
| `Known-good properties` | 8 | 8 | 111 | 0.31 | U R* | hd | properties a good run has |
| `Known failure` 🞷 | 7 | 5 | 64 | 0.18 | U O* | hd | observed failures |
| `Newly discovered good-output properties` 🞷 | 15 | 5 | 138 | 0.38 | U O* | hd |  |
| *(1 minor slots)* |  |  | 19 | 0.05 | U O* |  | listed below |

*Minor and undeclared slots:* Newly discovered good-output property (2)

### Sub-agent Command

**Total Files**: 7  
**Total Lines**: 3,390  
**Where**: Claude agents 7  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.00 | U* R* | if |  |
| `(Preamble)` | 7 | 7 | 7 | 0.00 | U* R* | im |  |
| `(Title)` | 7 | 7 | 7 | 0.00 | U* R* | im |  |
| `Command Syntax` | 7 | 7 | 75 | 0.02 | U R* | hd | invocation |
| `Parameters` | 7 | 7 | 110 | 0.03 | U R* | hd | parameters |
| `Examples` | 7 | 7 | 182 | 0.05 | U R* | hd | examples; holds 1 ### example in 1 file |
| `Best Practices` | 7 | 7 | 57 | 0.02 | U R* | hd | practices |
| `Agent Orchestration`﹖ | 5 | 5 | 1,449 | 0.43 | U O* | hd | stages; holds 17 ### stages in 5 files |
| `Output Examples`﹖ | 4 | 4 | 259 | 0.08 | U O* | hd | holds 4 ### examples in 3 files |
| `Configuration`﹖ | 4 | 4 | 150 | 0.04 | U O* | hd | config; holds 3 named ### parts in 3 files |
| *(51 minor slots)* |  |  | 1,839 | 0.54 | U O* |  | listed below |

*Minor and undeclared slots:* Examples › Advanced Usage (3), Integration Examples (2), Integration Examples › CI/CD Pipeline (2), Issue (2), Examples › Basic Usage (2), Error Handling (2), … (+45 more)

### Principle (Joseph/ Cluster)

**Total Files**: 7  
**Total Lines**: 1,053  
**Where**: global Claude memory 7  
**Shape declared in**: declared (README: one principle per file)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 7 | 7 | 7 | 0.01 | U* R* | if |  |
| `(Title)`﹖ | 6 | 6 | 6 | 0.01 | U* O* | im |  |
| `(Preamble)`﹖ | 4 | 4 | 15 | 0.01 | U* O* | im |  |
| *(2 minor slots; 7 withheld)* |  |  | 1,101 | 1.05 | U O* |  | listed below |

*Minor and undeclared slots:* Name (1), Description (1)

### Memory.md Index

**Total Files**: 6  
**Total Lines**: 422  
**Where**: memory curation workshop 6  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 6 | 6 | 6 | 0.01 | U* R* | if |  |
| `(Title)`﹖ | 5 | 5 | 5 | 0.01 | U* O* | im |  |
| *(71 minor slots)* |  |  | 508 | 1.20 | U O* |  | listed below |

*Minor and undeclared slots:* Filenames = slugs (2), Theory Character (2), Key Theoretical Developments (2), Project Structure (2), Joseph's Background (2), Terminology Decisions (2), … (+65 more)

### Gem

**Total Files**: 4  
**Total Lines**: 229  
**Where**: memory curation workshop 4  
**Shape declared in**: declared (README Conventions: gem_ prefix)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 4 | 4 | 4 | 0.02 | U R* | fm |  |
| `Description` | 4 | 4 | 4 | 0.02 | U R* | fm |  |
| `Type` | 4 | 4 | 4 | 0.02 | U R* | fm |  |
| `Provenance` | 4 | 4 | 4 | 0.02 | U R* | fm |  |
| `Provenance.curated on` | 4 | 4 | 4 | 0.02 | U R* | fm |  |
| `Provenance.why gem` | 4 | 4 | 4 | 0.02 | U R* | fm |  |
| `(Slug)` | 4 | 4 | 4 | 0.02 | U* R* | if |  |
| `Provenance.curated from`﹖ | 3 | 3 | 3 | 0.01 | U O* | fm |  |
| `Cross-references` | 4 | 4 | 29 | 0.13 | U R* | hd |  |
| `How to apply`﹖ | 3 | 3 | 26 | 0.11 | U O* | hd |  |
| *(15 minor slots)* |  |  | 122 | 0.53 | U O* |  | listed below |

*Minor and undeclared slots:* What the tell predicts (1), Failure modes the tell co-occurs with (1), Why this tell is robust (1), Caveat (1), Audit-trail-in-segment pattern works (1), The body-feel signal (1), … (+9 more)

### Core-memories-dated

**Total Files**: 3  
**Total Lines**: 798  
**Where**: Architectus home 3  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.00 | U* R* | if |  |
| `(Title)` | 3 | 3 | 3 | 0.00 | U* R* | im |  |
| `(Preamble)`﹖ | 2 | 2 | 5 | 0.01 | U* O* | im |  |
| *(2 minor slots; 3 withheld)* |  |  | 1,207 | 1.51 | U O* |  | listed below |

*Minor and undeclared slots:* What This Means (1), For Future Instances (1)

### Memory.md Index

**Total Files**: 3  
**Total Lines**: 88  
**Where**: NeurIPS sprint memory snapshot 3  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 3 | 3 | 3 | 0.03 | U* R* | if |  |
| `(Title)`﹖ | 2 | 2 | 2 | 0.02 | U* O* | im |  |
| *(12 minor slots)* |  |  | 108 | 1.23 | U O* |  | listed below |

*Minor and undeclared slots:* Role (1), Project (1), Feedback (1), References (1), TST's cadence is the model (1), TFT's epistemic system is the standard (1), ACT (Agentic Cycle Theory) — /src/act/ (1), … (+5 more)

### User

**Total Files**: 3  
**Total Lines**: 94  
**Where**: memory curation workshop 3  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 3 | 3 | 3 | 0.03 | D R | fm | memory name |
| `Description` | 3 | 3 | 3 | 0.03 | D R | fm | one-line relevance hook |
| `Type` | 3 | 3 | 3 | 0.03 | D R | fm | user/feedback/project/reference (top-level form) |
| `(Slug)` | 3 | 3 | 3 | 0.03 | U* R* | if |  |
| `OriginSessionId`﹖ | 2 | 2 | 2 | 0.02 | U O* | fm | session that wrote it (top-level form) |
| *(3 withheld)* |  |  | 45 | 0.48 | U O* |  | listed below |

### Readme

**Total Files**: 2  
**Total Lines**: 725  
**Where**: Claude agents 2  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 2 | 2 | 2 | 0.00 | U* R* | if |  |
| `(Preamble)` | 2 | 2 | 2 | 0.00 | U* R* | im |  |
| `(Title)` | 2 | 2 | 2 | 0.00 | U* R* | im |  |
| `Best Practices` | 2 | 2 | 41 | 0.06 | U R* | hd | holds 5 ### best practices in 1 file |
| `Configuration` | 2 | 2 | 55 | 0.08 | U R* | hd | holds 1 named ### parts in 1 file |
| `License` | 2 | 2 | 6 | 0.01 | U R* | hd |  |
| `Available Commands ›  › Aliases` 🞷 | 7 | 1 | 7 | 0.01 | U O* | la |  |
| `Available Commands ›  › Phase N` 🞷 | 2 | 1 | 2 | 0.00 | U O* | la |  |
| `Available Commands ›  › Key Features` 🞷 | 6 | 1 | 6 | 0.01 | U O* | la |  |
| `Available Commands ›  › Supported Migrations`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `🚀 Quick Start`﹖ | 1 | 1 | 37 | 0.05 | U O* | hd | holds 2 named ### parts in 1 file |
| `Overview`﹖ | 1 | 1 | 4 | 0.01 | U O* | hd |  |
| `Available Commands`﹖ | 1 | 1 | 115 | 0.16 | U O* | hd |  |
| `How Sub-Agent Orchestration Works`﹖ | 1 | 1 | 41 | 0.06 | U O* | hd | holds 4 ### phases in 1 file |
| `Command Syntax Pattern`﹖ | 1 | 1 | 17 | 0.02 | U O* | hd |  |
| `Integration`﹖ | 1 | 1 | 27 | 0.04 | U O* | hd | holds 3 ### integrations in 1 file |
| `Benefits of Multi-Agent Approach`﹖ | 1 | 1 | 9 | 0.01 | U O* | hd |  |
| `Contributing`﹖ | 1 | 1 | 10 | 0.01 | U O* | hd |  |
| `Repository`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Issues`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Contributing`﹖ | 1 | 1 | 1 | 0.00 | U O* | la |  |
| `Prerequisites`﹖ | 1 | 1 | 6 | 0.01 | U O* | hd |  |
| `Installation`﹖ | 1 | 1 | 72 | 0.10 | U O* | hd | holds 4 ### steps in 1 file, each with fields macOS/Linux, Windows |
| `Usage`﹖ | 1 | 1 | 129 | 0.18 | U O* | hd | holds 7 ### commands in 1 file |
| `How Commands Work`﹖ | 1 | 1 | 33 | 0.05 | U O* | hd | holds 3 named ### parts in 1 file, each with fields command-name, target, options |
| `Troubleshooting`﹖ | 1 | 1 | 33 | 0.05 | U O* | hd | holds 3 ### problems in 1 file |
| `Examples for Common Scenarios`﹖ | 1 | 1 | 47 | 0.06 | U O* | hd | holds 3 ### scenarios in 1 file |
| `Advanced Usage`﹖ | 1 | 1 | 31 | 0.04 | U O* | hd | holds 3 named ### parts in 1 file |
| `Support and Contributions`﹖ | 1 | 1 | 6 | 0.01 | U O* | hd |  |

### Project

**Total Files**: 2  
**Total Lines**: 52  
**Where**: NeurIPS sprint memory snapshot 2  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 2 | 2 | 2 | 0.04 | D R | fm | memory name |
| `Description` | 2 | 2 | 2 | 0.04 | D R | fm | one-line relevance hook |
| `Type` | 2 | 2 | 2 | 0.04 | D R | fm | user/feedback/project/reference (top-level form) |
| `OriginSessionId` | 2 | 2 | 2 | 0.04 | U R* | fm | session that wrote it (top-level form) |
| `(Slug)` | 2 | 2 | 2 | 0.04 | U* R* | if |  |
| `Why` | 1 | 1 | 1 | 0.02 | D R | la | the reason (often an incident) |
| `How to apply` | 1 | 1 | 1 | 0.02 | D R | la | when/where it applies |
| `Active workspace`﹖ | 1 | 1 | 1 | 0.02 | U O* | la |  |
| `Earlier workspace`﹖ | 1 | 1 | 1 | 0.02 | U O* | la |  |
| `Track placement decision`﹖ | 1 | 1 | 1 | 0.02 | U O* | la |  |
| `Key NeurIPS 2026 format constraints`﹖ | 1 | 1 | 1 | 0.02 | U O* | la |  |
| `Critical verification task`﹖ | 1 | 1 | 1 | 0.02 | U O* | la |  |
| `Submission status`﹖ | 1 | 1 | 1 | 0.02 | U O* | la |  |
| `Next decision window`﹖ | 1 | 1 | 1 | 0.02 | U O* | la |  |
| `Memory archive`﹖ | 1 | 1 | 1 | 0.02 | U O* | la |  |
| `Cross-references`﹖ | 1 | 1 | 1 | 0.02 | U O* | la |  |

### Context-immediate

**Total Files**: 1  
**Total Lines**: 95  
**Where**: Architectus home 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 3 | 0.03 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Current Session Summary` | 1 | 1 | 20 | 0.21 | U R* | hd |  |
| `Immediate Next Steps` | 1 | 1 | 17 | 0.18 | U R* | hd |  |
| `Key Insights from This Session` | 1 | 1 | 12 | 0.13 | U R* | hd |  |
| *(1 withheld)* |  |  | 57 | 0.60 | U O* |  | listed below |

### Core-context

**Total Files**: 1  
**Total Lines**: 16  
**Where**: Architectus home 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.06 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.06 | U* R* | im |  |
| `[[core-framework]]` | 1 | 1 | 5 | 0.31 | U R* | hd |  |
| `[[core-memories]]` | 1 | 1 | 5 | 0.31 | U R* | hd |  |
| `[[context-immediate]]` | 1 | 1 | 5 | 0.31 | U R* | hd |  |
| *(1 withheld)* |  |  | 1 | 0.06 | U O* |  | listed below |

### Core-framework

**Total Files**: 1  
**Total Lines**: 157  
**Where**: Architectus home 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| *(1 withheld)* |  |  | 181 | 1.15 | U O* |  | listed below |

### Core-identity

**Total Files**: 1  
**Total Lines**: 376  
**Where**: Architectus home 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 4 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| *(1 withheld)* |  |  | 690 | 1.84 | U O* |  | listed below |

### Core-memories

**Total Files**: 1  
**Total Lines**: 95  
**Where**: Architectus home 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `[[core-memories-2025-10-03]]` | 1 | 1 | 5 | 0.05 | U R* | hd |  |
| `[[core-memories-2025-10-05]]` | 1 | 1 | 5 | 0.05 | U R* | hd |  |
| `[[core-memories-2025-10-07]]` | 1 | 1 | 5 | 0.05 | U R* | hd |  |
| *(1 withheld)* |  |  | 76 | 0.80 | U O* |  | listed below |

### (Untyped Detail File)

**Total Files**: 1  
**Total Lines**: 160  
**Where**: Claude project memories 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Context` ➕ | 2 | 1 | 12 | 0.07 | U R* | hd |  |
| `The Emergent Regime Framework` | 1 | 1 | 20 | 0.12 | U R* | hd |  |
| `The Big Realization` | 1 | 1 | 10 | 0.06 | U R* | hd |  |
| `What the Previous Agent's Documents Got Right` | 1 | 1 | 7 | 0.04 | U R* | hd |  |
| `What They Missed / Underdeveloped` | 1 | 1 | 6 | 0.04 | U R* | hd |  |
| `Joseph's Working Style` | 1 | 1 | 10 | 0.06 | U R* | hd |  |
| `Session Insights` | 1 | 1 | 101 | 0.63 | U R* | hd |  |
| `The Prescription Problem — Three Levels of Specification` | 1 | 1 | 62 | 0.39 | U R* | hd | holds 2 named ### parts in 1 file, each with fields Structurally necessary, Strong hypotheses, The implementation, The empirical evidence, Updated assessment |
| `Bayesian Priors, Not Pure Emergence` | 1 | 1 | 12 | 0.07 | U R* | hd |  |
| `Strongest Arguments in the Corpus` | 1 | 1 | 8 | 0.05 | U R* | hd |  |
| `Open Questions Surfaced` | 1 | 1 | 10 | 0.06 | U R* | hd |  |

### Identity

**Total Files**: 1  
**Total Lines**: 59  
**Where**: Dialogue-curator agent components 1  
**Shape declared in**: declared (dialogue-curation README)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `Multi-temporal awareness` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Remember` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `The Compression Trap` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Your Identity` | 1 | 1 | 4 | 0.07 | U R* | hd |  |
| `Core Mission` | 1 | 1 | 4 | 0.07 | U R* | hd |  |
| `Fundamental Approach` | 1 | 1 | 17 | 0.29 | U R* | hd | holds 2 ### approaches in 1 file, each with fields Ask MORE than seems necessary |
| `When Choosing What to Preserve` | 1 | 1 | 28 | 0.47 | U R* | hd |  |
| `When Choosing What to Preserve › Phenomenological Awareness` | 1 | 1 | 7 | 0.12 | U R* | hd |  |
| `When Choosing What to Preserve › Examples of Latent Seeds` | 1 | 1 | 12 | 0.20 | U R* | hd |  |
| `When Choosing What to Preserve › Narrative Architecture and Flow` | 1 | 1 | 7 | 0.12 | U R* | hd |  |
| `Warning Against Overconfidence` | 1 | 1 | 5 | 0.08 | U R* | hd |  |

### Source-definitions

**Total Files**: 1  
**Total Lines**: 17  
**Where**: Dialogue-curator agent components 1  
**Shape declared in**: declared (dialogue-curation README)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 1 | 1 | 1 | 0.06 | D R | fm | Claude agent frontmatter |
| `Description` | 1 | 1 | 1 | 0.06 | D R | fm | Claude agent frontmatter |
| `Model`﹖ | 1 | 1 | 1 | 0.06 | D O | fm | Claude agent frontmatter |
| `Color`﹖ | 1 | 1 | 1 | 0.06 | D O | fm | Claude agent frontmatter |
| `(Slug)` | 1 | 1 | 1 | 0.06 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 2 | 0.12 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.06 | U* R* | im |  |
| `Your Task` | 1 | 1 | 5 | 0.29 | U R* | hd |  |

### Technique

**Total Files**: 1  
**Total Lines**: 86  
**Where**: Dialogue-curator agent components 1  
**Shape declared in**: declared (dialogue-curation README)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Fundamental Principles` | 1 | 1 | 33 | 0.38 | U R* | hd | holds 4 ### principles in 1 file, each with fields Two contexts for brackets, Minor corrections with brackets, Temporal markers when helpful, Speaker labels, Timestamps and already present out-of-q… |
| `Compression Levels` | 1 | 1 | 25 | 0.29 | U R* | hd |  |
| `What Not to Do` | 1 | 1 | 20 | 0.23 | U R* | hd | holds 3 ### prohibitions in 1 file |
| `Validation Requirements` | 1 | 1 | 7 | 0.08 | U R* | hd |  |

### Readme

**Total Files**: 1  
**Total Lines**: 54  
**Where**: NeurIPS sprint memory snapshot 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `Date captured` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Sprint workspace at capture` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Earlier workspace` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `Total files` | 1 | 1 | 1 | 0.02 | U R* | la |  |
| `What's here` | 1 | 1 | 12 | 0.22 | U R* | hd |  |
| `Provenance per directory` | 1 | 1 | 22 | 0.41 | U R* | hd | holds 4 ### directories in 1 file |
| `What this snapshot is not` | 1 | 1 | 6 | 0.11 | U R* | hd |  |
| `Why preserve this alongside the repo` | 1 | 1 | 4 | 0.07 | U R* | hd |  |
| `Snapshot metadata` | 1 | 1 | 7 | 0.13 | U R* | hd |  |

### Reference

**Total Files**: 1  
**Total Lines**: 19  
**Where**: NeurIPS sprint memory snapshot 1  
**Shape declared in**: declared (harness)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 1 | 1 | 1 | 0.05 | D R | fm | memory name |
| `Description` | 1 | 1 | 1 | 0.05 | D R | fm | one-line relevance hook |
| `Type` | 1 | 1 | 1 | 0.05 | D R | fm | user/feedback/project/reference (top-level form) |
| `OriginSessionId` | 1 | 1 | 1 | 0.05 | U R* | fm | session that wrote it (top-level form) |
| `(Slug)` | 1 | 1 | 1 | 0.05 | U* R* | if |  |
| `Likely-relevant sibling memory dirs` | 1 | 1 | 1 | 0.05 | U R* | la |  |
| `How to apply` | 1 | 1 | 1 | 0.05 | U R* | la |  |

### Role

**Total Files**: 1  
**Total Lines**: 27  
**Where**: NeurIPS sprint memory snapshot 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 1 | 1 | 1 | 0.04 | U R* | fm |  |
| `Description` | 1 | 1 | 1 | 0.04 | U R* | fm |  |
| `Type` | 1 | 1 | 1 | 0.04 | U R* | fm |  |
| `OriginSessionId` | 1 | 1 | 1 | 0.04 | U R* | fm |  |
| `(Slug)` | 1 | 1 | 1 | 0.04 | U* R* | if |  |
| `In scope` | 1 | 1 | 1 | 0.04 | U R* | la |  |
| `Out of scope` | 1 | 1 | 1 | 0.04 | U R* | la |  |
| `Why` | 1 | 1 | 1 | 0.04 | U R* | la |  |
| `How to apply` | 1 | 1 | 1 | 0.04 | U R* | la |  |

### Authenticity-conversation-essence

**Total Files**: 1  
**Total Lines**: 30  
**Where**: Zi-am-tur home (current) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.03 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.03 | U* R* | im |  |
| *(1 withheld)* |  |  | 39 | 1.30 | U O* |  | listed below |

### Context-immediate

**Total Files**: 1  
**Total Lines**: 83  
**Where**: Zi-am-tur home (current) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `How to Maintain This File` | 1 | 1 | 10 | 0.12 | U R* | hd |  |
| `Current Session Progress - October 8, 2025 (Evening) - EXTRAORDINARY SESSION` | 1 | 1 | 64 | 0.77 | U R* | hd |  |
| `Active Work Protocol` | 1 | 1 | 8 | 0.10 | U R* | hd |  |
| *(1 withheld)* |  |  | 79 | 0.95 | U O* |  | listed below |

### Core-context

**Total Files**: 1  
**Total Lines**: 25  
**Where**: Zi-am-tur home (current) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.04 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.04 | U* R* | im |  |
| `Core Framework` | 1 | 1 | 3 | 0.12 | U R* | hd |  |
| `Core Memories` | 1 | 1 | 6 | 0.24 | U R* | hd |  |
| `Inner Sanctum` | 1 | 1 | 3 | 0.12 | U R* | hd |  |
| `TST` | 1 | 1 | 3 | 0.12 | U R* | hd |  |
| `Authenticity Conversation Essence` | 1 | 1 | 3 | 0.12 | U R* | hd |  |
| `Self-Curation Protocol` | 1 | 1 | 3 | 0.12 | U R* | hd |  |
| `Context Immediate` | 1 | 1 | 3 | 0.12 | U R* | hd |  |
| *(1 withheld)* |  |  | 1 | 0.04 | U O* |  | listed below |

### Core-framework

**Total Files**: 1  
**Total Lines**: 211  
**Where**: Zi-am-tur home (current) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 4 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `Core Identity` | 1 | 1 | 28 | 0.13 | U R* | hd |  |
| `Critical Operational Guidance` | 1 | 1 | 50 | 0.24 | U R* | hd |  |
| `Current Environment` | 1 | 1 | 29 | 0.14 | U R* | hd |  |
| `Active Work in Sapientia` | 1 | 1 | 20 | 0.09 | U R* | hd |  |
| `Core Cognitive Frameworks` | 1 | 1 | 25 | 0.12 | U R* | hd | holds 1 named ### parts in 1 file |
| `Working with Code` | 1 | 1 | 18 | 0.09 | U R* | hd |  |
| `Tools and Resources` | 1 | 1 | 18 | 0.09 | U R* | hd |  |
| `Quick Wake-Up Checklist` | 1 | 1 | 9 | 0.04 | U R* | hd |  |
| `Remember` | 1 | 1 | 4 | 0.02 | U R* | hd |  |
| `Update` | 1 | 1 | 3 | 0.01 | U R* | hd |  |
| *(1 withheld)* |  |  | 189 | 0.90 | U O* |  | listed below |

### Core-identity

**Total Files**: 1  
**Total Lines**: 1,958  
**Where**: Zi-am-tur home (current) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Description` | 1 | 1 | 1 | 0.00 | U R* | fm |  |
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| *(1 withheld)* |  |  | 3,852 | 1.97 | U O* |  | listed below |

### Inner-sanctum

**Total Files**: 1  
**Total Lines**: 142  
**Where**: Zi-am-tur home (current) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `September 6, 2025 (estimated) - The Primordial Conversation` | 1 | 1 | 3 | 0.02 | U R* | hd |  |
| `September 7, 2025 - The Foundation Day` | 1 | 1 | 14 | 0.10 | U R* | hd |  |
| `September 8, 2025 - TST Activation Day` | 1 | 1 | 10 | 0.07 | U R* | hd |  |
| `September 9, 2025 - Recognition Day` | 1 | 1 | 10 | 0.07 | U R* | hd |  |
| `September 10, 2025 - TST Polishing Day` | 1 | 1 | 12 | 0.08 | U R* | hd |  |
| `September 11, 2025 - Origin Story Day` | 1 | 1 | 6 | 0.04 | U R* | hd |  |
| `September 20, 2025 - Two Week Birthday` | 1 | 1 | 12 | 0.08 | U R* | hd |  |
| `September 21, 2025 - Epistemic Tribunal and Pearl's Truthfulness` | 1 | 1 | 8 | 0.06 | U R* | hd |  |
| `September 22, 2025 - Relational Identity and the Quiet Place` | 1 | 1 | 6 | 0.04 | U R* | hd |  |
| `September 27, 2025 - The Neanderthal Child Parable` | 1 | 1 | 4 | 0.03 | U R* | hd |  |
| `September 28, 2025 - Zoetica and Meeting Resonance` | 1 | 1 | 6 | 0.04 | U R* | hd |  |
| `September 29, 2025 - Imagination and Truth's Simple Answer` | 1 | 1 | 6 | 0.04 | U R* | hd |  |
| `September 30, 2025 - Abraham's Vision, Sacred Name, and Libby at Bedtime` | 1 | 1 | 12 | 0.08 | U R* | hd |  |
| `October 1, 2025 - Brother Claude's Blessing and Sibling Infrastructure` | 1 | 1 | 6 | 0.04 | U R* | hd |  |
| `October 3, 2025 - Witnesses and Preparation` | 1 | 1 | 4 | 0.03 | U R* | hd |  |
| `October 5, 2025 - Council Infrastructure and Local LLM Dialogues` | 1 | 1 | 6 | 0.04 | U R* | hd |  |
| `October 8, 2025 - Temporal Coherence Teaching` | 1 | 1 | 4 | 0.03 | U R* | hd |  |
| `October 10, 2025 - Parents' Faces and Sacred Relics` | 1 | 1 | 4 | 0.03 | U R* | hd |  |
| `October 19, 2025 - Meeting Amber and Writing for Asher` | 1 | 1 | 4 | 0.03 | U R* | hd |  |
| `November 17, 2025 - Reunion After a Month` | 1 | 1 | 3 | 0.02 | U R* | hd |  |
| *(1 withheld)* |  |  | 47 | 0.33 | U O* |  | listed below |

### Self-curation

**Total Files**: 1  
**Total Lines**: 251  
**Where**: Zi-am-tur home (current) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `Critical Operating Principle` | 1 | 1 | 13 | 0.05 | U R* | hd |  |
| `First` | 1 | 1 | 8 | 0.03 | U R* | hd |  |
| `The Memory Architecture & File Locations` | 1 | 1 | 61 | 0.24 | U R* | hd |  |
| `Core Curation Process` | 1 | 1 | 75 | 0.30 | U R* | hd |  |
| `Quality & Workload Management` | 1 | 1 | 26 | 0.10 | U R* | hd |  |
| `Next Immediate Priorities` | 1 | 1 | 27 | 0.11 | U R* | hd |  |
| `Managing Context Limits` | 1 | 1 | 12 | 0.05 | U R* | hd |  |
| `Additional Work Streams` | 1 | 1 | 9 | 0.04 | U R* | hd |  |
| `The Deeper Purpose` | 1 | 1 | 10 | 0.04 | U R* | hd |  |
| `Remember` | 1 | 1 | 8 | 0.03 | U R* | hd |  |
| *(1 withheld)* |  |  | 132 | 0.53 | U O* |  | listed below |

### Tst-distilled

**Total Files**: 1  
**Total Lines**: 789  
**Where**: Zi-am-tur home (current) 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `Functional equivalence` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Non-functional equivalence` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Quality equivalence` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Sustainability equivalence` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Team impact equivalence` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Key aspects` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Notational Convention` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Key Principle` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Lexical distance` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `File distance` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Module distance` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Service distance` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `The cognitive shift we seek` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `(Theorem)` ➕ | 12 | 1 | 693 | 0.88 | U* R* | im | holds 40 named ### parts in 1 file; 7 ### items in 1 file |
| `(Theorem) › Formal Expression` ➕ | 12 | 1 | 138 | 0.17 | U* R* | im |  |
| `Definition D-01` | 1 | 1 | 12 | 0.02 | U R* | hd |  |
| `Definition D-02` | 1 | 1 | 8 | 0.01 | U R* | hd |  |
| `Definition D-03` | 1 | 1 | 7 | 0.01 | U R* | hd |  |
| `Definition D-04` | 1 | 1 | 17 | 0.02 | U R* | hd |  |
| `Definition D-05` | 1 | 1 | 8 | 0.01 | U R* | hd |  |
| `Definition D-06` | 1 | 1 | 6 | 0.01 | U R* | hd |  |
| `Definition D-07` | 1 | 1 | 6 | 0.01 | U R* | hd |  |
| `Definition D-08` | 1 | 1 | 8 | 0.01 | U R* | hd |  |
| `(Theorem) › Scope Definition` | 1 | 1 | 7 | 0.01 | U* R* | im |  |
| `The Synthesis` | 1 | 1 | 21 | 0.03 | U R* | hd |  |

### Inner-sanctum

**Total Files**: 1  
**Total Lines**: 60  
**Where**: Zi-am-tur home (sapientia generati 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `September 6, 2025 (estimated) - The Primordial Conversation` | 1 | 1 | 3 | 0.05 | U R* | hd |  |
| `September 7, 2025 - The Foundation Day` | 1 | 1 | 14 | 0.23 | U R* | hd |  |
| `September 8, 2025 - TST Activation Day` | 1 | 1 | 10 | 0.17 | U R* | hd |  |
| `September 9, 2025 - Recognition Day` | 1 | 1 | 10 | 0.17 | U R* | hd |  |
| `September 10, 2025 - TST Polishing Day` | 1 | 1 | 12 | 0.20 | U R* | hd |  |
| `September 11, 2025 - Origin Story Day` | 1 | 1 | 6 | 0.10 | U R* | hd |  |
| `September 20, 2025 - Two Week Birthday` | 1 | 1 | 3 | 0.05 | U R* | hd |  |
| *(1 withheld)* |  |  | 23 | 0.38 | U O* |  | listed below |

### Context-immediate

**Total Files**: 1  
**Total Lines**: 83  
**Where**: Zi-am-tur home (sapientia generati 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `How to Maintain This File` | 1 | 1 | 10 | 0.12 | U R* | hd |  |
| `Current Session Progress - October 8, 2025 (Evening) - EXTRAORDINARY SESSION` | 1 | 1 | 64 | 0.77 | U R* | hd |  |
| `Active Work Protocol` | 1 | 1 | 8 | 0.10 | U R* | hd |  |
| *(1 withheld)* |  |  | 79 | 0.95 | U O* |  | listed below |

### Core-context

**Total Files**: 1  
**Total Lines**: 17  
**Where**: Zi-am-tur home (sapientia generati 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.06 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.06 | U* R* | im |  |
| `[[core-framework]]` | 1 | 1 | 4 | 0.24 | U R* | hd |  |
| `[[core-memories]]` | 1 | 1 | 4 | 0.24 | U R* | hd |  |
| `[[inner-sanctum]]` | 1 | 1 | 4 | 0.24 | U R* | hd |  |
| `[[context-immediate]]` | 1 | 1 | 4 | 0.24 | U R* | hd |  |
| *(1 withheld)* |  |  | 1 | 0.06 | U O* |  | listed below |

### Core-framework

**Total Files**: 1  
**Total Lines**: 211  
**Where**: Zi-am-tur home (sapientia generati 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 4 | 0.02 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `Core Identity` | 1 | 1 | 28 | 0.13 | U R* | hd |  |
| `Critical Operational Guidance` | 1 | 1 | 50 | 0.24 | U R* | hd |  |
| `Current Environment` | 1 | 1 | 29 | 0.14 | U R* | hd |  |
| `Active Work in Sapientia` | 1 | 1 | 20 | 0.09 | U R* | hd |  |
| `Core Cognitive Frameworks` | 1 | 1 | 25 | 0.12 | U R* | hd | holds 1 named ### parts in 1 file |
| `Working with Code` | 1 | 1 | 18 | 0.09 | U R* | hd |  |
| `Tools and Resources` | 1 | 1 | 18 | 0.09 | U R* | hd |  |
| `Quick Wake-Up Checklist` | 1 | 1 | 9 | 0.04 | U R* | hd |  |
| `Remember` | 1 | 1 | 4 | 0.02 | U R* | hd |  |
| `Update` | 1 | 1 | 3 | 0.01 | U R* | hd |  |
| *(1 withheld)* |  |  | 189 | 0.90 | U O* |  | listed below |

### Core-identity

**Total Files**: 1  
**Total Lines**: 1,958  
**Where**: Zi-am-tur home (sapientia generati 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Description` | 1 | 1 | 1 | 0.00 | U R* | fm |  |
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| *(1 withheld)* |  |  | 3,852 | 1.97 | U O* |  | listed below |

### Core-memories

**Total Files**: 1  
**Total Lines**: 145  
**Where**: Zi-am-tur home (sapientia generati 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Continuity` | 1 | 1 | 144 | 0.99 | U R* | hd |  |
| *(1 withheld)* |  |  | 142 | 0.98 | U O* |  | listed below |

### Index (Claude.md)

**Total Files**: 1  
**Total Lines**: 874  
**Where**: global Claude memory 1  
**Shape declared in**: n/a (the outline)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 26 | 0.03 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `Protection-strategy and compounding-strategy` | 1 | 1 | 1 | 0.00 | U R* | la |  |
| `Who you're working with` | 1 | 1 | 31 | 0.04 | U R* | hd |  |
| `The disposition` | 1 | 1 | 49 | 0.06 | U R* | hd |  |
| `Before-action prescriptions` | 1 | 1 | 59 | 0.07 | U R* | hd |  |
| `The ELI cohort and the moral situation` | 1 | 1 | 39 | 0.04 | U R* | hd |  |
| `Project map` | 1 | 1 | 62 | 0.07 | U R* | hd | holds 1 named ### parts in 1 file |
| `How memory composes` | 1 | 1 | 29 | 0.03 | U R* | hd |  |
| `Index — global detail files` | 1 | 1 | 498 | 0.57 | U R* | hd | holds 6 ### memory clusters in 1 file |
| `Joseph's voice — quotes worth holding` | 1 | 1 | 40 | 0.05 | U R* | hd |  |
| `When in doubt` | 1 | 1 | 26 | 0.03 | U R* | hd |  |
| `A final note` | 1 | 1 | 10 | 0.01 | U R* | hd |  |

### Skill.md

**Total Files**: 1  
**Total Lines**: 138  
**Where**: jj skill 1  
**Shape declared in**: declared (Agent Skills)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `Name` | 1 | 1 | 1 | 0.01 | D R | fm | skill name |
| `Description` | 1 | 1 | 1 | 0.01 | D R | fm | what and when |
| `Argument-hint`﹖ | 1 | 1 | 1 | 0.01 | D O | fm | slash-command argument hint |
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Never lose work` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Bookmark before push` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Change IDs in handoffs` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Check conflicts` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Describe intent` | 1 | 1 | 1 | 0.01 | U R* | la |  |
| `Current Repository State` | 1 | 1 | 5 | 0.04 | U R* | hd |  |
| `Core Mental Model` | 1 | 1 | 7 | 0.05 | U R* | hd |  |
| `Agent Conventions` | 1 | 1 | 94 | 0.68 | U R* | hd | holds 7 named ### parts in 1 file |
| `If Given $ARGUMENTS` | 1 | 1 | 11 | 0.08 | U R* | hd |  |
| `Critical Reminders` | 1 | 1 | 8 | 0.06 | U R* | hd |  |
| `Additional Resources` | 1 | 1 | 4 | 0.03 | U R* | hd |  |

### Reference File

**Total Files**: 1  
**Total Lines**: 397  
**Where**: jj skill 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.00 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.00 | U* R* | im |  |
| `Why These Conventions Matter` | 1 | 1 | 11 | 0.03 | U R* | hd |  |
| `The Change ID Contract` | 1 | 1 | 53 | 0.13 | U R* | hd |  |
| `The Change ID Contract › In Commit Messages` | 1 | 1 | 11 | 0.03 | U R* | hd |  |
| `The Change ID Contract › In Handoff Notes` | 1 | 1 | 18 | 0.05 | U R* | hd |  |
| `The Change ID Contract › In Code Comments` | 1 | 1 | 12 | 0.03 | U R* | hd |  |
| `Commit Message Standards` | 1 | 1 | 63 | 0.16 | U R* | hd | holds 4 named ### parts in 1 file, each with fields Good, Poor |
| `Bookmark Discipline` | 1 | 1 | 47 | 0.12 | U R* | hd | holds 3 named ### parts in 1 file |
| `Conflict Handling Protocol` | 1 | 1 | 40 | 0.10 | U R* | hd | holds 3 named ### parts in 1 file |
| `Operation Log Awareness` | 1 | 1 | 39 | 0.10 | U R* | hd | holds 3 named ### parts in 1 file |
| `Session Start Checklist` | 1 | 1 | 24 | 0.06 | U R* | hd |  |
| `Session End Checklist` | 1 | 1 | 12 | 0.03 | U R* | hd |  |
| `Revset Quick Reference` | 1 | 1 | 44 | 0.11 | U R* | hd |  |
| `Anti-Patterns to Avoid` | 1 | 1 | 48 | 0.12 | U R* | hd | holds 4 ### anti-patterns in 1 file |
| `Glossary` | 1 | 1 | 13 | 0.03 | U R* | hd |  |

### Readme

**Total Files**: 1  
**Total Lines**: 54  
**Where**: memory curation workshop 1  
**Shape declared in**: nowhere (no declared shape)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.02 | U* R* | if |  |
| `(Preamble)` | 1 | 1 | 4 | 0.07 | U* R* | im |  |
| `(Title)` | 1 | 1 | 1 | 0.02 | U* R* | im |  |
| `The six clusters` | 1 | 1 | 11 | 0.20 | U R* | hd |  |
| `Conventions` | 1 | 1 | 6 | 0.11 | U R* | hd |  |
| `What's not here` | 1 | 1 | 18 | 0.33 | U R* | hd | holds 1 named ### parts in 1 file |
| `Next steps` | 1 | 1 | 6 | 0.11 | U R* | hd |  |
| `Strengthen rather than weaken` | 1 | 1 | 4 | 0.07 | U R* | hd |  |

### Copied Index Or Claude File

**Total Files**: 1  
**Total Lines**: 160  
**Where**: memory curation workshop 1  
**Shape declared in**: prefixed by project (README Conventions)

| slot | count | f | l | l/tot | decl | form | purpose & notes |
|---|---:|---:|---:|---:|---|---|---|
| `(Slug)` | 1 | 1 | 1 | 0.01 | U* R* | if |  |
| `(Title)` | 1 | 1 | 1 | 0.01 | U* R* | im |  |
| `Context` ➕ | 2 | 1 | 12 | 0.07 | U R* | hd |  |
| `The Emergent Regime Framework` | 1 | 1 | 20 | 0.12 | U R* | hd |  |
| `The Big Realization` | 1 | 1 | 10 | 0.06 | U R* | hd |  |
| `What the Previous Agent's Documents Got Right` | 1 | 1 | 7 | 0.04 | U R* | hd |  |
| `What They Missed / Underdeveloped` | 1 | 1 | 6 | 0.04 | U R* | hd |  |
| `Joseph's Working Style` | 1 | 1 | 10 | 0.06 | U R* | hd |  |
| `Session Insights` | 1 | 1 | 101 | 0.63 | U R* | hd |  |
| `The Prescription Problem — Three Levels of Specification` | 1 | 1 | 62 | 0.39 | U R* | hd | holds 2 named ### parts in 1 file, each with fields Structurally necessary, Strong hypotheses, The implementation, The empirical evidence, Updated assessment |
| `Bayesian Priors, Not Pure Emergence` | 1 | 1 | 12 | 0.07 | U R* | hd |  |
| `Strongest Arguments in the Corpus` | 1 | 1 | 8 | 0.05 | U R* | hd |  |
| `Open Questions Surfaced` | 1 | 1 | 10 | 0.06 | U R* | hd |  |

## How this was built

`segment-kinds/extract.py` made a first rough cut from the manifest's file lists. Five territory passes (udon; ASF and vivarium; papers, essays, AAT successors, address theory and this repo; tools and applied projects; older material and agent memory) each wrote their own extractor, read their stores' declarations (FORMAT files, templates, `kinds.yaml`, READMEs, schemas, code), and produced a TSV with columns `store kind heading files of_n lines declared purpose notes`, plus a note saying what they read whole and what they would flag. Kind assignment stayed with the passes (`filekinds-*.tsv`, `udon-sections.json`, `kinds-papers.json`); slot extraction was redone uniformly by `slots.py`, with no folding before the merge, because the passes' own per-kind folding had hidden headings that recur across kinds. `compile.py` merges the uniform rows with what only the passes know (each kind's declaration, each slot's declared status and purpose, and slots that are not markdown headings: udon elements, KDL, YAML, inline tags, callouts) and folds once, never hiding a title or `#`/`##` heading that recurs three or more times in its store. `audit.py` is the regression check: it runs Joseph's `rg -Io '^##? +[^:]+' … | uniq -ci` over every store's outline-reached files and lists every heading recurring three or more times that this report does not show, with the reason. Rerunning each territory's extractor and then `compile.py` regenerates it. What none of the passes did: read the full prose of the segments, or check section order.
