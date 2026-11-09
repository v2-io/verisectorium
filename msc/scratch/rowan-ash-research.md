# Rowan and Ash on schema definition, schema evolution, and spellings

*Research read for the verisectorium v2 engine, 2026-11-08, at Joseph's request ("a careful look at rowan and ... the latest full view of Ash ... what they innovate as far as schema definition and schema evolution and spellings"). Scratch material: findings and my reading of them, not a proposal adopted by anyone.*

I took "spellings" to mean the written surface of a definition: how a declaration is spelled, what alternate or retired spellings exist, and how anyone finds out which spelling is right. That is how the word is used in `msc/notes/11-.../def/README.md` ("udon's spelling is still moving"). If Joseph meant something narrower, section 4 is the part to redirect.

## In brief

1. **Ash's real invention is Spark, not the migrations.** Spark makes a DSL's grammar into data (sections, entities, option schemas), and validation, docs, autocomplete, formatting and deprecation all follow from that. Ash's resource language is one client of it. Ash existed for almost three years before Spark was pulled out of it.
2. **Ash's evolution story is competent and narrow.** It covers the SQL table shape: snapshot, diff, prompt, generate. Its most relevant idea for you sits off to the side, in AshEvents, where an old event names the version of the action that made it and is routed to code that still understands it.
3. **Rowan's real contributions are all in evolution**: `was:` in the definition, a self-describing `_schema: type/version` stamp in documents, read-time upcasting across stores, a vocabulary of change operations (rename, split, merge, transform), and the idea of a decision log recording who resolved an ambiguity and why. Its method for testing spellings on naive agents is the other thing worth having.
4. **Rowan's docs run ahead of its code, and it has been frozen since December 2025.** The decision log is read but nothing writes it. Branch safety and expand/contract are not built. `was:` reaches back one rename and silently drops older data. Section 3.3 lists these with evidence. Rowan's own comparison document (`docs/msc/archema-ash-comparison-research.md`, 2025-12-20) inherits several of the errors.
5. **Neither system faces your hard case.** Both define success as "old data still loads". A verisectorium's records include acts, which are claims about what was checked under what question. Whether an old act survives a definition change is a question about meaning that neither machinery asks. Section 5 is my reading of what follows.

## Where each claim comes from

Tags used throughout: **[ran]** I executed it. **[code]** I read the source at the version below. **[docs]** the project's own documentation at that version. **[hex]** hex.pm or hexdocs, fetched 2026-11-08. **[training]** from my training, not checked in this session.

| Subject | Version | Date | How I looked |
|---|---|---|---|
| Rowan (directory and GitHub renamed; gem, module, CLI, `.archema/` still `archema`) | 0.7.2, commit `d91397e` | Last change under `lib/` 2025-12-19; last work commits 2025-12-22 (research docs, usability results). Since then only a README rename banner (2026-07-08), a revert pair, a gitignore change (2026-10-22) | Read `lib/archema/resource/`, `lib/archema/schema/`, store-adapter read paths, ADRs, user docs, plans. Ran three probe scripts against the code on Ruby 3.3.10. Did not run its test suite |
| Ash | 3.37.3 (tag, `529d480`) | 2026-11-05, latest on Hex | Cloned the tag, read docs and selected source |
| Spark | 2.7.9 (tag, `e9e21a9`) | 2026-10-25, latest | Cloned, read entity, section, extension, transformer, verifier, options |
| AshPostgres | 2.15.2 (tag, `825c40c`) | 2026-10-25, latest | Cloned, read migration generator's rename logic and task docs |
| AshEvents | 0.8.2 (tag, `b248e37`) | 2026-09-19, latest | Cloned, read README and DSL docs |
| Igniter | `main`, `236747b`, 0.8.5 | 2026-11-05 | Read upgrades doc |
| AshStateMachine | 0.3.0 | 2026-10-25 | [hex] DSL docs only |
| Rowan's vendored Ash, `tmp/ash` | 3.11.1 | 2025-12-06 | Used only for git history (it is a full clone) |

No Ash 4 exists yet; `backwards-compatibility-config.md` refers to it as future. Since Rowan's December comparison, Ash has added two things that matter here: `Ash.Info.Manifest` (3.25.0, 2026-05-17) and Signals (3.36.0, 2026-10-14). AshPostgres gained more generic table renaming in 2.10.0 (2026-06-14). [code, changelogs]

## 1. Schema definition: what Ash does

**A resource is a configuration file.** `design-principles.md` says so plainly: "A resource, for example, is really just a configuration file. On its own it does nothing. It is provided to code that reads that configuration and acts accordingly." Attributes, relationships, actions, policies, calculations and aggregates are declarations; other code derives behaviour from them. [docs]

**Spark makes the grammar of such a file into data.** An extension declares `%Spark.Dsl.Section{}` and `%Spark.Dsl.Entity{}` values. An entity has a name, positional `args`, an option `schema`, nested `entities`, an `identifier` (unique within its section, enforced), `singleton_entity_keys` (at most one), `recursive_as`, `examples`, `deprecations`, and a target struct. [code: `spark/lib/spark/dsl/entity.ex`] From that one description Spark produces the builder macros, compile-time validation of every option, reference docs and cheat sheets, editor autocomplete, and formatter rules. An unknown option is an error naming the valid ones. [code: `options.ex:931`]

**Compilation has phases, and they are distinct.** Build the entities; run **transformers**, which may rewrite the definition and declare their ordering against each other with `before?/1` and `after?/1`; then run **verifiers**, which only read, and run after the module compiles, so that checking a relationship target does not create a compile dependency. [code: `transformer.ex`, `verifier.ex`] Shorthand is expansion: `uuid_primary_key :id` and `create_timestamp` are documented as equivalent to a spelled-out `attribute` block. [docs: `attributes.md`]

**Definitions are extended by addition, with the reach controlled.** An extension adds sections. To add an entity to *another* extension's section it supplies a `Spark.Dsl.Patch.AddEntity`, which is refused unless the target section is `patchable?` or already holds compatible entities. [code: `extension.ex:1816`] `Spark.Dsl.Fragment` splits one definition across files. Extensions bring others with them through `add_extensions`.

**Everything can be read back, and now as plain data.** `Ash.Resource.Info` has always answered questions about a resource. `Ash.Info.Manifest` (2026) goes further: one normalized structure holding reachable resources, named types, entrypoints and capabilities, serializable to JSON for non-Elixir tools. Its docs name the idea worth lifting: "The split between 'build + verify' and 'compile/introspect' is the load-bearing idea: you do all the cross-checking once, then either path operates against a pre-validated artifact." Three details matter. Short-name aliases are resolved at construction and never appear in the output, so consumers cannot be misled by a per-app naming convention. Each struct has a `custom` map, namespaced per extension, for data that is "data, not behavior", with the note that functions "don't serialize and prevent persistence". And the IR's format has its own `schema_version`, separate from anything the resources say. [code, docs: `code-generation.md`, `lib/ash/info/manifest.ex`]

**Other pieces that bear on a verisectorium.** Actions are named, each with accepted inputs, arguments, validations and changes. Policies are declarations, and `Ash.Error.Forbidden.Policy.report/2` will explain a denial. [docs] Attributes are stored; calculations and aggregates are computed by declaration, which is your ‹written›/‹computed› line drawn in the grammar. AshStateMachine declares `transition :action, from:, to:` and has `deprecated_states`: still valid, excluded from `:*`. That is close to retiring a rung. [hex]

**How much of this is new.** Declarative resources are old. What I have not seen done this thoroughly elsewhere is grammar-as-data with phases and controlled extension. Snapshot-diff migration generation is not Ash's invention; Django and others have done it for years, including asking whether a removed and an added column are a rename. [training]

## 2. Schema definition: what Rowan adds

Rowan ports the Resource/action/policy shape. It has no meta-layer: each DSL is hand-written, and extensions are only "Planned" (`MAP.md`). [code, docs] Its additions are these.

- **`ValueResource`**, a sharp separation of things with identity (Resource) from things compared by value and only ever embedded, with the forbidden operations (`actions`, `store`, primary keys) raising. [code] Ash's embedded resources are less strict on this: they can have primary keys and be created and updated like resources. [docs]
- **Document-schema-first constraints.** ADR-003 takes JSON Schema's composition vocabulary as the constraint model: `one_of`, `any_of`, `when_value`, `dependent_required`, each validating and exporting to JSON Schema, with SQL getting what it can hold. Four of the six planned constructs are implemented. [code: `constraints.rb`]
- **Multi-store and markdown as a store.** A resource can sit on YAML-frontmatter-plus-body files, JSONL with an optional hash chain, memory, or SQL, with the same definition. [code] Of direct interest because your defs are already markdown with a structured head.

## 3. Schema evolution

### 3.1 Ash

Resources are authoritative; migrations are derived. `mix ash.codegen` runs every extension's `codegen/1`, so generation is a protocol rather than a Postgres feature. [code] In AshPostgres, each table gets timestamped JSON snapshots, the current resources are diffed against the latest, and migrations are emitted. The workflow details are good: `--dev` migrations that are later rolled back and squashed into one named migration, `--check` for CI, `--dont-drop-columns`, `--snapshots-only`, and `custom_statements` as a declared, named, up-and-down escape hatch inside the DSL. [docs, code]

Ambiguity is resolved by asking, and only by asking. `resolve_renames` calls `yes?("Are you renaming ...")`, and with no shell it raises `"Unimplemented: cannot determine..."`. Nothing records the answer except the migration it produces. [code: `migration_generator.ex:3590ff`]

Ash has `source:` on an attribute, a permanent mapping from logical name to stored name. It is not a rename history. There is no upcast mechanism in Ash, AshPostgres or AshEvents (I searched the source). The closest thing is `cast_stored`, a per-type hook for reading a stored value. [code]

**AshEvents takes a different approach and is the most relevant thing in the ecosystem for you.** Actions carry versions (`current_action_versions create: 2, update: 3`). Each event records the version of the action that produced it. When the log is replayed, `replay_override` routes old versions to a kept-around action, or even to a different resource: `versions [1]; route_to MyApp.Accounts.User, :old_create_v1`. Old facts are not transformed into new shapes. They are sent to the code that still knows what they meant. It also records action inputs separately from auto-generated attribute changes, so replay can tell given from derived. [docs: README, DSL]

**The language itself evolves through three mechanisms.** Spark's `deprecations:` on entities and sections and `deprecated:` on options warn at use. `backwards-compatibility-config.md` lists behaviour changes as named flags: the installer sets every new value for new apps, and in 4.0 some flags go away and the rest change default. Igniter's `mix igniter.upgrade` runs a package's upgrader with `from` and `to` versions, which rewrites the user's source. Spark also records source locations for every declaration (`:erl_anno`, since 2.3.0, 2025-09). Worth noticing is 3.0's flip from `private?: true` to `public?: true`, made because "It was too easy to add an attribute and not realize that you had exposed it". The default was reversed so the dangerous state needs spelling out. [docs]

### 3.2 Rowan

Rowan's aim is stated well in `docs/usr/10-schema-evolution.md`: migrations transform a database, while schema evolution has to transform a data model across all backends, including old files nobody will ever migrate. What it built toward that:

- **`was:` in the definition.** `field :full_name, :string, was: :name`, or `was: { name: :config, type: :string }` for a type change. The differ treats it as a settled rename and generates `rename_column`; document adapters rewrite old keys at read time. The rename is in the changed line of the diff, where a reviewer sees it. [code, ran]
- **Self-describing records.** Document stores write `_schema: type/version` into each record. [code, ran: `_schema: e3/1.0.0` in the file]
- **`upcast from: "1.2.0" do |data| ... end`**, read-time transformation, non-destructive: the old file stays as it was. Blocks chain through known versions. Also applied when rebuilding projections from event logs. [code]
- **An evolution vocabulary.** `Resource.evolve` offers `add_field`, `rename_field`, `split_field into:, using:`, `merge_fields into:, using:`, `transform_field`, `remove_field`. As far as I know this is the most directly useful thing in Rowan to read: the operations a schema actually undergoes, named. [code]
- **Classified change history.** `Schema::Watcher` diffs definition against `History`, types each change (`add_attribute`, `rename_attribute`, `change_type`, ...), separates unambiguous changes from ambiguities, and suggests a semver bump. [code]
- **The decision log, as designed.** Each resolution of an ambiguity records resource, type, decision, context, `source` (`:interactive`, `:agent_comment`, `:config`, `:cli`, `:auto`), `agent_id` and `reason`. See 3.3 for its state.
- **An empirical base.** `docs/ref/migration-survey/` (23 Rails projects, 6,201 migrations, 12,072 operations) finds expansions outnumber contractions about 5:1, and `docs/exp/schema-evolution-patterns.md` sorts changes into ladders with direction and asymmetry (blob to columns to table; one to many to many-to-many; loose to strict types). Only 8.5% of the 1,950 migrations in that second sample were hard to reverse. [docs; I did not recheck the counts]

Precedent, for calibration: Avro readers carry a list of `aliases` for each field, so a rename is declared in the definition and old names keep resolving. [Avro 1.12 specification, fetched 2026-11-08] Upcasting is standard event-sourcing practice. [training] `was:` is a good spelling of a known idea. The combination of it with cross-store read-time evolution in one definition is what is distinctive.

### 3.3 What Rowan documents versus what runs

| Documented | What I found |
|---|---|
| README: "Automatic expand-contract transitions — rename a field, both names work during transition" | Not built. `docs/dev/open-questions.md` #18 says so. [code] |
| `docs/usr/10`: branch safety, a `CONFLICT: Field 'name' has divergent evolutions` message | No such code in `lib/`. Open question #3 lists it as proposed. [code] |
| `docs/usr/10`: `field ..., upcast: ->(old) {...}` | Option accepted and silently discarded: no error, no block registered. [ran] |
| `was:` makes old data readable | True for one step only. After `a_name` → `b_name` → `c_name` with `was: :b_name`, a file holding `a_name` reads with `c_name` empty and no error, while the file holding `b_name` reads fine. [ran] `History#all_renames` has the full chain, but the read path does not use it. [code] |
| `since:`, `deprecated:`, `removed:` metadata | Stored, and `exists_in_version?` answers. Nothing on read or write consults them. A field marked `removed: "1.0.0"` still accepts writes. [ran] |
| Decision log "records your decision"; `--resolve=rename` logs it | Read by `auto_resolve_from_log!`, never written: `DecisionLog#record!` has no caller outside tests, and the CLI's "Is this a rename?" answer is not saved. `:agent_comment` (`# {{replaces: ...}}`) has no parser. [code] Lookup matches by resource and names only, with no version, so a recorded answer would re-fire on any later same-named ambiguity. [code] |
| `Resource.evolve` "All goals achieved" (plan); "Integrate with schema history" (ADR-004 Phase 3) | Not integrated: after `evolve`, history is unchanged and the watcher reports the rename as an unresolved ambiguity. [ran] `rename_field` drops nullability, constraints, default and description. `split_field` and `merge_fields` targets are forced to `:string`. [ran] |
| `upcast from: "1"` means "Upcast from v1 to current" | Applied once per known 1.x version: with 1.0.0, 1.1.0 and 2.0.0 known, the block runs twice on 1.0.0 data. [ran] |
| One diff | Two engines, `Differ` for SQL and `Watcher` for history, with different rename rules. For two removed and two added columns of matching types, `Differ` silently emits drops and adds while `Watcher` flags two possible renames. [ran] |
| Order of rename, coerce, upcast | Differs by adapter. YAML coerces to the new type *before* upcast blocks see the value; JSONL does not. [code] |
| `docs/usr/10`: history in `user/v1.0.0.yaml` | One file per resource. [code] |
| Quick reference, "empirically validated": `field :profile, Profile  # has_one` | Produces `:belongs_to`. [ran] |

Corrections this forces in `docs/msc/archema-ash-comparison-research.md`, whose evolution table is marked "High confidence": decision log as "Implemented"; "Schema history: Ash ❌" (the timestamped snapshots are a history of states, without recorded change kinds); and "Deprecation tracking: Ash ❌" (at the DSL level Spark does this, and AshStateMachine has `deprecated_states`). It also says Ash has no event persistence with replay, which was a fair reading of Ash core but does not mention AshEvents, the `ash-project` extension that provides it (now 0.8.2).

A note on transformations: upcast and split functions in Rowan are Ruby closures, and the history records only that a change of some kind happened. Old data can be read only with the code of the time. Snapshots note a default function as `{type: "proc"}` and nothing more. [code]

## 4. Spellings

**Ash's conventions** [docs, code]:

- Positional arguments carry only what is always present; everything else is named. `attribute :title, :string` and then options.
- Any option can be written inline or in a block, by construction, because both are generated from the same entity: `attribute :a, :string, allow_nil?: false` or `attribute :a, :string do allow_nil? false end`. Two spellings, one meaning, guaranteed by the framework.
- Booleans end in `?`.
- Shorthand has a published desugaring.
- "Configuration over Convention": "we never do things like assume that files with a given name are a certain type of thing." Your `avoid "filename prefix"` on `veritoid⸱kind` is the same rule.
- Names that the IR must not leak are resolved early. `Ash.Info.Manifest` keeps operator `aliases` separately "for tools that historically rendered the module-derived spelling". The word is theirs.

**Rowan's conventions** [code, docs]:

- `field` is the one word, and its second argument decides what kind of thing you declared: a symbol is a scalar; a `ValueResource` class embeds; a `Resource` class is a `belongs_to`; `[Comment]` is `has_many`; `[Tag], :shared` is many-to-many; a block is an inline value. Rowan's rationale is that documents have fields and the word is short.
- Flags are bare symbols, `field :bio, :text, :optional, :private`, and required is the default.
- Evolution reads as prose with prepositions: `rename_field :name, to: :full_name`, `split_field :name, into: [...], using: ...`.

The overloaded `field` has a cost: the direction of a reference is implied, and the quick reference got it wrong (table above). The loose handling of unknowns has a cost too: an unknown flag warns and is ignored, so `:optonal` leaves the field required [ran], and an unknown keyword is swallowed without comment [ran]. Against Spark's "unknown options ... valid options are", this is the difference that shows up when the author is an agent.

**Rowan's method for testing spellings is its best idea here.** `docs/dev/hallway-usability-at-scale.md` and `bin/dx usability` hand a task to a naive agent and look at what it writes (zero-shot), what several agents converge on, how success rises with examples (the learning cost `k*`), and, in reverse, what agents think a given line means (`interpret`). "The modal guess across agents is what your API 'should' be." It changed the API: `includes` and `find_by` came from it. 127 results are in `test/usability/results/`. Three limits on those results. The "success" judge is a regular-expression check for expected patterns, not execution (`usability_tester.rb:320ff`), so "~95% API discoverability" means something weaker than it sounds. Runs were 91 Haiku 4.5 and 36 Sonnet 4, one model family. And the 28/28 zero-context successes sit beside 45/58 on the example-count runs, which I did not untangle by task. [code, ran the tally]

## 5. What I think this means for verisectorium

This section is my inference. Nothing here has been tried.

**The question neither system asks.** Rowan's and Ash's classifications of change are about shape: additive, breaking, ambiguous. Upcasting is sound when the record is data and the question is "can this still be loaded". But some of your records are acts, and `core/def/ontology.md` already says that a definition change can alter "what stability can even mean". If a dimension splits, an upcast of an old answer onto one of the halves would produce a value no act ever warranted, which is what the model exists to prevent. So I would expect each ontology change to need a second classification, stating what happens to the acts bound to the thing changed. Something like: *carried* (a pure rename, the question is unchanged); *carried by decision* (someone with standing says the old answer still answers the new question, recorded as an act); *lapsed* (the acts no longer bind and the frontier grows); *unanswered* (a new required thing with no answer yet). Rowan's `evolve` vocabulary and its diff-classifier are the template, and note 13's "relations with consequences" is the same move applied to change operations: `split_dimension` declared once, with what it does to the acts. I would not expect this classification to be derivable from shape alone.

**AshEvents' routing is the nearest precedent for the mechanism.** An act could name the version of the move and criterion it was made under, and a later definition could declare how old versions are read, rather than rewriting them. That fits an append-only log better than upcasting does.

**Say it in the definition, remember it in the log.** Rowan shows both halves. `was:` is a fine way to *say* a rename: it is in the diff and it removes the ambiguity. But a definition cannot be the *memory* of renames, because it holds one step, and your `«name»` row wants old names to resolve indefinitely. I would let an author write `was:`, have the engine turn it into a logged rename against the identity, and let the source shed it afterwards. Avro's list of aliases is the intermediate design, if a list in the definition is wanted.

**The decision log is worth building, with the binding it lacks.** It is the one place in either system where who resolved a schema ambiguity, by what route, and why is a first-class record. As built it has no writers and no binding, so a decision outlives what it decided about. Your `act` already says what it should have been: bound to exactly what it read. `DecisionLog::SOURCES` is a usable starting list for the attestation question, and its comment on trust levels ("Auto decisions are system-verified; agent decisions may warrant scrutiny") is the same concern.

**Transformations should not be closures.** Whatever rewrites content on a definition change must be something a check can bind to and a second mind can read: named, versioned, ideally hashable. Rowan's Ruby blocks and the Manifest's rule against storing functions point the same way: a closure cannot be logged, hashed, or read by the next mind. Most useful transformations may be declarative (renames, moves between slots), with the remainder being a logged act of rewriting content, not a function.

**Take Spark's design, not its code.** Spark depends on Elixir macros, and your kernels are Rust and Ada. What carries over: the grammar of a store definition as data; distinct build, transform, verify phases; verifiers as read-only checks after everything is known; declared ordering among aspects; controlled patch points for note 13's `aspect ... on ...`; deprecations in the grammar; source locations on every declaration. A KDL node (name, arguments, properties, children) maps nearly one-to-one onto a Spark entity (name, `args`, `schema`, nested `entities`) [training on KDL], and your defs already use KDL blocks with `rel declares term=... card=...`. The Manifest's lessons also carry: compile local names to canonical identities so two stores' `rests-on` are recognizably the same, keep a namespaced slot for what an aspect adds, and version the IR's format separately from the content it carries. I would give each ontology version an identity from a hash of that normalized form, in keeping with the kernel lean on versions. A semver number is a shape heuristic's opinion, as `suggest_version_bump` shows. Keep it, if at all, as a label.

**When to build the language.** Note 13 leans toward two or three hand-written store definitions first, with the language extracted afterward. Ash's history is the supporting case: `init` in October 2019, Spark on Hex in August 2022, and on 2022-08-14 the Ash commit "replace Ash DSL underpinnings with Spark". [ran git log on Rowan's clone; hex] The meta-language came out of a working language. Rowan, which skipped that step, has hand-written DSLs and no extensions.

**Run the hallway test on note 13's sketches.** Agents are your first readers, and `interpret` is cheap: show a `store` block, ask what it commits to, see whether the guesses agree. Use a real judge rather than regular expressions, and treat agreement across one model family as a measure of that family's prior. That is your open «independence of acts» gap appearing in miniature.

**What I would leave.** Expand/contract exists because old code and new code run at once during a deploy; your atomic changesets at a logical instant address a different problem, though the punted parallel-changesets gap may eventually want something like it. Runtime `evolve` was motivated by long-running processes, not by anything you have. SQL migration generation and multi-store routing are off the path. The `field` overload loses direction, which a relation with consequences cannot afford. Rowan's closed-by-default habit (`required` unless `:optional`) is worth keeping; the warn-and-ignore handling of unknown words is not.

## 6. Limits of this read

- Ash and Spark were read selectively: the DSL machinery, the codegen and rename path, the docs named above. I did not read the expression engine, the action pipeline source, or AshPaperTrail.
- Rowan's test suite was not run, so "works" above means I read it or probed it, not that its specs pass today.
- The ecosystem-history point about extraction rests on one commit and two dates, which seems enough for the order of events but says nothing about why.
- For verisectorium I read the README, the model outline, notes 00 and 13, and the `ontology` and `veritoid-kind` defs, and searched notes 09, 12, 16 and `COMPARISON.md` for this topic. I did not read the kernel spikes. Section 5 has not been tried against AAT material.
