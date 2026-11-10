# The part of an ontology this segment needs

*Declared for `02-tst-core/src/der-change-expectation-baseline.md` and the 39 acts recorded on it. Written from `core/` alone plus the asf material; a sketch by one mind, and every choice in it that core did not settle for me is marked **(guess)** and taken up in `README.md`. Where asf already declares something (`FORMAT.md`, `.vsect/kinds.yaml`) I say so and keep its word.*

## 1. Kinds

### Veritoid kinds

| kind | content | opens | may hold | asf's own word for it |
|---|---|---|---|---|
| **premise** | a condition stated for claims to be conditional on: an observation model, an ignorance assumption, a regularity assumed of the world | holds-of, ratified | cites, assumes (a premise may refine another) | `*[Assumption]*`, "**Observation.**", "**Assumption.**", "conditional on …" inside a tag |
| **choice** | a modelling choice that could have been otherwise: the wording of the choice; its alternatives and grounds are pieces of their own | ratified | predicated-on (grounds), supersedes | `formulation`; "this segment's reading of the situation, not something derived" |
| **claim** | a statement with a conclusion, naming its hypotheses by reference; its own conditions ("at every age", "$\sim$", "asymptotically") are content | validity, holds-of (when it is asserted of the world), accepted | predicated-on, assumes, uses-term, restates | `*[Derived (…)]*`, `*[Result]*` |
| **import** | a borrowed result as used here, or a statement of what a cited work says | source | cites | "Watson's lemma gives …", "(Caves 2000, Eqs. 31–32)", the Lineage sentences |
| **priority·claim** | a statement that something is first stated here | novelty | cites, narrates | "the asymptotic form and the dependence on $a$ are stated here"; asf's Findings schema has the same field |
| **numeric·report** | a statement that a computation gave certain numbers | reproduces | run-of | "Numerical integration agrees with the stated limits to three decimals …"; asf's `*[Empirical Claim]*` with an `empirica:` citation |
| **explanation** | prose that says what other pieces say, or what follows for a reader | fidelity, comprehension | narrates, restates | summary paragraph, most of Epistemic Status and Discussion |
| **non·claim** | a statement of what is not claimed, or where the result does not apply | fidelity | narrates | "it carries no normative content about investment"; "is not derived from the same prior" |
| **account** | prose about how the segment came to be | fidelity to the record | references outward | "TST's original statement as … uses 'expected' loosely" |
| **guard** | a standing prohibition on a future edit, with its reason and what would lift it | ratified **(guess: core says a guard opens *still false*, a check; see README §9)** | narrates | "Don't re-promote it without deriving the threshold" |
| **chunk** | a span cut from material brought in | where-did-it-go | bears-on | each Working Notes bullet; each typed item and each paragraph of a review write-up |

Not declared, because nothing in this segment needed it: a derivation·step kind. The segment has no derivation apart from its claims: each "derivation" is a chain of short claims, and in one place a claim and its one-line derivation share a single display equation (README §12).

### Segment kinds

**derived** (asf `type: derived`). Slots, in order:

| slot | filled by | how many | required | from the file |
|---|---|---|---|---|
| headline | explanation, claim | 1..N | yes | the paragraph under the title |
| formal·expression | **unit** (an assembly, held) | 1..N | yes | each tagged block or `###` subsection of `## Formal Expression` |
| epistemic·status | explanation, non·claim, claim, numeric·report, account | 1..N | yes | `## Epistemic Status` |
| claim·record | (asf's six-field record) | 0..N | "for load-bearing apparatus" | absent here |
| discussion | explanation, import, priority·claim | 0..N | no | `## Discussion` |
| findings | (asf's Findings entry) | 0..N | no | absent here |

Working Notes is not a slot; it is the rendering of the segment's inbox.

**unit**: one tagged run of a Formal Expression. Slots: premises (premise or choice, 0..N, held, or pointing at a premise another unit of the same segment holds); claims (claim, import, 1..N, held, in order); remarks (explanation, 0..N). Its tag (`*[Derived (name, condition)]*`) is rendered from the kind of its claims and the conditions they carry; it is not content.

Inner dependencies of **derived**: epistemic·status → formal·expression; headline → formal·expression; discussion → formal·expression. Of **unit**: claims → premises. **(guess)** Whether one claim's dependence on another claim, or on a premise held by a different unit, is an inner dependency or a reference, core does not say; I wrote those as references (README §6).

How the segment's own dimensions are read: validity *aliased* to the headline claim (here `c3`); holds-of aliased likewise; freshness derived as the minimum; coherence own. asf's frontmatter `status:` is a rendering of that alias. **(guess)** core's example kind has one formal-claim slot; this segment has three derivations reaching one conclusion under three premise sets, so "the" claim had to be chosen (README §11).

## 2. Dimensions

Each with everything `def/dimension.md` says a dimension declares.

### validity ‹determinant›
1. **asks**: does the statement, as written, follow from the premises it names?
2. **of**: claim.
3. **against**: logic, under the claim's hypotheses. A claim names its hypotheses by `assumes` references to premise and choice veritoids, and carries its own conditions in its content. A check reads what those references point at.
4. **found out.**
5. **produced by**: a ‹check› by a ‹mind› that inherited nothing about the claim from its author, criterion fixed before the outcome. Means: *following* (the written derivation, step by step); *afresh* (deriving the statement without it); *collision* (setting the statement against the other claims and premises of its own segment, its neighbours, or an import); *instance* (a number computed or simulated, by a script that is kept). **(guess)** whether a mind that read the author's account of the change before fixing its criterion "inherited" it (README §5).
6. **read as**: *never asked* < *derived once* (one binding independent line by following or afresh) < *corroborated* (that, and a binding independent line by collision or instance). A binding contradiction wins. **(guess)** a binding *narrowed* reads as contradicted for the statement as written, until answered; core files it under *raised* (README §3).
- **passes along**: caps along predicated-on. Along `assumes`: nothing (a conditional claim is not made less valid by a doubtful hypothesis). **(guess)** where the predicated-on target is an import, the cap takes the import's *source* warrant, mapped: checked-at-primary does not cap, anything less caps at *derived once*. Core's cap is stated within one dimension and gives no rule for a target of a kind that does not open it (README §7).

### holds-of ‹determinant›
1. **asks**: is this true of the systems it is said of?
2. **of**: premise; claim when asserted of the world.
3. **against**: evolving software systems, as `scope-evolving-software`'s predicate names them (by an `assumes` reference to that predicate).
4. **found out**, by degree.
5. **produced by**: a run of a registered experiment (asf: an `empirica:` entry with a recorded run), or the ‹testimony› of a cited empirical study brought in as an import. Means: a survival analysis of repository histories; a measured feature-arrival rate; a case with a known time scale.
6. **read as**: *never asked*; otherwise the latest outcome per means, with its sample.
- **passes along**: caps along `assumes` and predicated-on (a claim holds of the world no better than its hypotheses do).

### source ‹determinant›
1. **asks**: does the cited work say this, and is the borrowed result stated as it is there?
2. **of**: import.
3. **against**: the cited work, named by a `cites` reference.
4. **found out.**
5. **produced by**: a read-check by a mind not the author of the import. Means: *recalled*; *at a secondary* (as another work reports it); *at the primary*, with a locator.
6. **read as**: the highest means reached by a binding check; contradicted wins.
- **passes along**: see validity. Stales along narrates.

### reproduces
1. **asks**: do the reported numbers come out again?
2. **of**: numeric·report.
3. **against**: a script at a version, named by a `run-of` reference.
4. **found out.**
5. **produced by**: a run by that ‹instrument›, or by a mind's independent re-implementation (means: *same script*, *independent re-implementation*).
6. **read as**: the latest outcome; lapses when the script's version or the claims it computes change.
- **passes along**: nothing. **(guess)** determinant or fitness; I left it fitness, since the numbers corroborate claims that stand by derivation.

### fidelity
1. **asks**: does this say what the pieces it speaks for say, no more and no less?
2. **of**: explanation, non·claim, account.
3. **against**: the veritoids it narrates or restates, by reference; for an account, the acta.
4. **found out.**
5. **produced by**: a read of both by a mind not the author. Means: *read against the target*; *a case the paraphrase admits and the target excludes* (how the one real fidelity defect here was found).
6. **read as**: the latest outcome.
- **passes along**: stales along narrates and restates.

Declared a ‹determinant› for headline and epistemic·status (a wrong summary is the work being wrong, to its most-read sentence) and fitness for discussion. **(guess)** core lets the mark be the ontology's; whether one dimension may be a determinant in one slot and not in another it does not say. The weighting "over segment kind × determinant" would need slot as well.

### novelty
asks whether the piece is first stated here; of priority·claim; against the literature as searched on a date; found out, by search (means: recalled, searched, searched with the nearest neighbours read); read as the highest means reached with its date; passes nothing. Never asked of either priority·claim here; declared only so they have a home.

### ratified (decided)
1. **asks**: who stands behind this choice, and how revisitably?
2. **of**: choice, premise, guard.
3. **against**: the accountable party.
4. **decided.**
5. **produced by**: the steward, for a choice or guard in the theory; the author seat may *propose*.
6. **read as**: the standing decision (none, proposed, ratified).
- **passes along**: nothing.

### accepted (decided)
asks whether the piece is part of canon; of anything; against the verisectorium's standard for canon; decided; read as the standing decision. **Who or what produces it is the one thing I could not declare from asf as it is.** Three candidates are in §4, and `record.md` runs all three.

### where-did-it-go (decided), answered (decided)
As core has them; of chunk and of question. The six Working Notes bullets are chunks; none is a question with a closer.

### Attributes
reach (pieces resting on this one, by reference kind); age; churn (versions per day; this segment had six in six hours, all to the premises of one derivation and to one subsection added that day).

## 3. Reference kinds

| kind | from → to | what passes along it | cycles | written in the file today as |
|---|---|---|---|---|
| **predicated-on** | claim → claim, import | validity caps; staleness | none | "item 1 then gives", "the tail of item 1 above", "Hence"; across segments, `depends:` |
| **assumes** **(added)** | claim → premise, choice | fills validity's *against* (a change lapses checks); caps holds-of; staleness | none | "under the same uniform-feature-rate mapping"; a tag's "conditional on …"; across segments, `depends:` on a scope |
| **uses-term** **(added)** | any → the defining veritoid | staleness only | allowed | nothing: $n_{\text{future}}$, "feature", $M_t$, $\rho$, $\eta^\ast$ are used and their definitions are not referenced |
| **cites** **(added)** | import → a work, outside this verisectorium | source's *against* | n/a | author-year prose; no key |
| **run-of** **(added)** | numeric·report → a script at a version | reproduces' *against* | n/a | nothing; the script is described in a review |
| **restates** | explanation → claim, premise | fidelity; staleness | allowed | nothing; the summary and Epistemic Status restate the Formal Expression with no pointer |
| **narrates** | explanation → anything | staleness | allowed | `#slug` in prose |
| **bears-on** | chunk → segment or veritoid | nothing | n/a | a finding's `target:`; an item's `concerns:` |
| slot pointing | assembly → segment | what the kind says a whole read relies on | n/a | an OUTLINE row |

asf writes one cross-segment kind, `depends:`, from segment to segment, and says the sort of each is "derivable from the referenced file's own `type`". Here that one edge (`depends: scope-evolving-software`) is an `assumes` from `c3` and `h1` to the scope's predicate and a `uses-term` to its $n_{\text{future}}$; nothing in the derivations reads it.

## 4. Rules

- **R-accept**, three candidates, because asf has no acceptance today:
  - **D, as declared.** asf's `stage:` ladder (draft, deps-verified, claims-verified, format-clean, candidate) by its gates. `FORMAT.md` says the layer "is currently ignored in practice"; this segment is `draft`; the ladder's top rung is "ready for external challenge", and no rung is called accepted.
  - **L, landing.** A piece is accepted while it is on `main` in a `src/` file an OUTLINE row points at. This is what asf's own prose means by "in canon". The basis is the piece at its version; a rewrite that lands is accepted again by the rule.
  - **E, evidence.** A claim or import is accepted while a check with standing on its determinant, criterion first, binds at its current version and no finding, contradiction or narrowing stands against it unanswered; an explanation likewise on fidelity. Withdrawn never by failing; reopened when the rule would not now make it. This is the rule core's worked examples use.
- **R-status.** The segment's printed status word is computed from the headline claim's conditions and warrant; a typed `status:` is shown as typed.
- **R-premise-moved.** A segment changeset that changes a premise or choice raises a question on every claim, in any segment, that `assumes` it.
- **R-import-uncited.** An import with no `cites` reference is raised on source.
- **R-report-unregistered.** A numeric·report with no `run-of` reference is raised on reproduces.
- **R-status-vs-headline** (asf's Gate 2 label audit, as a rule): a printed status stronger than the headline claim's own conditions is raised.

## 5. Standing and seats

| seat | held on 2026-10-30/31 by | standing |
|---|---|---|
| steward | Joseph (`steward: joseph`, `decider: joseph` in `kinds.yaml`) | ratified; waivers; the ontology; acceptance under D |
| lead | the sprint lead the lane write-ups are addressed to | dispatch (who holds an author seat); merging a lane |
| author of the segment | four different actors in turn: the TST lane integrator, then the round-2, round-3 and round-4 integrators | writes segment changesets; affirms; proposes a choice; no standing on validity, source or fidelity of what it wrote |
| checker | TST lane checkers 1 to 4 | validity, source, fidelity, reproduces, where the producer's inheritance clause is met |
| answerer, carrier | checkers 2 and 4 | answering (not the repairer); carrying (not the editor) |
| owner of an item | a key result (C.1, H.2, E.3, I.5 in asf's objectives tree) | **(guess)** core has no seat that work is owed *by*; see README §10 |

Vacant at HEAD: the author seat (the round-4 integrator ended on 10-31; nothing assigns a successor), so core's "the piece's last author first where a repair is wanted" addresses an actor that no longer exists.
