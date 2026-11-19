# The slot census, read through the model

*Fable 5.2 session, 2026-11-18. Joseph put the category key of `slot-rollup.md` in front of me as "a concrete segment (or slot / veritoid) kind census to work with", with two criticisms of it: it "tends to under-emphasize how distinct 'content' + 'kind' can really end up being", and "it could be more orderly with the slots that are edges / relationships / dependencies". This is a re-sort of the same twenty-six categories and 239 slot names by what the model in note 27 would do with each. I read `slot-rollup.md` whole for it. I did not read `slot-rollup-once.md` (names seen in one kind only) or `segment-kinds.md`, so everything here is about names seen in two or more kinds. The census is evidence of what was done by hand, not an exemplar.*

## 1. The twenty-six, in six groups

| The model's question | Census categories | What the model does with it |
|---|---|---|
| **What is this piece?** | Identity and name · Kind · The content itself · Scope and limits · Summary and short form | Written. Scope and limits are part of what is claimed. A summary is the content said again, and so has to agree with it. |
| **What is it tied to?** | Rests on · Connections · Locators · part of Provenance (`source`, `from`) · part of Consequences · part of Open work (`closes`, `reopen when`) | Written, as references. Section 3 puts these in an order. |
| **What was done about it?** | Work done and what it found · Provenance and history (who, when, how it changed) · Reader's reflection · the verification fields now filed under Standing (`verifier`, `criterion`, `outcome`, `timestamp`) | Recorded, and as far as possible captured from what a mind did. A reader's reflection is two things: evidence that a reader got it or did not, and new material coming in. |
| **How does it stand?** | Standing | Computed from the row above, by a rule each kind states. Never typed. |
| **What is not settled?** | Open work · Planning · Options and alternatives | The inbox, the open questions at the edge, and, for a decision, the alternatives it weighed. |
| **What does a reader or user need around it?** | Explanation and discussion · Examples and application · Composition · Apparatus and navigation · Triggers and invocation · Instructions and setup · Purpose and problem | Mostly pieces of their own kinds (an explanation, an example) held beside the content. Composition and apparatus belong to an assembly, not a piece. |

Tags, Bibliographic and Model structure are fields particular to one kind of content and do not need a row.

## 2. Content and kind

"The content itself" is one category of twenty-six in the key, and it is where the kinds differ most. Its slot names are a census of kinds in their own right, because each names what a piece of that kind exists to carry. From the names seen in two or more kinds:

| The piece exists to carry | Slot names in the wild | What would have to be asked of it |
|---|---|---|
| a claim | `formal expression`, `theorem`, `lemma`, `proposition`, `corollary`, `claim`, `derived`, `hypothesis` | does it follow; under what it assumes |
| a rule or norm | `statement`, `norm`, `invariants` | who stands behind it; is it consistent with the others |
| a definition | `term`, `definition` | is it used the way it is defined; does it collide with another |
| a decision | `decision`, `decision outcome`, `wording`, `intent`, `last decision` | who decided, on what grounds, what would reopen it |
| a quotation | `quote` | does it match its source at that place |
| a question | `the question`, `questions` | has it been answered, and by what |
| a finding | `findings` | was it borne out; has it been answered |
| an argument | `thesis` | does the piece built on it make that argument |
| a practice | `act` | does it come to mind when it should, and does following it help |
| a proof or working | `proof`, `mathematical formalization`, `process`, `table` | is each step right; does it deliver what it is attached to |

Ten kinds of content, each with a different thing to be asked. That is the per-kind part of the model, drawn from what the estate already distinguishes. The paragraph in note 27 names four of them (theorem, design rule, quotation, measurement). Measurement is the one of those four the census does not show under content: where it appears, it is under "Rests on" and "Work done".

Two things the names show that the key's one line does not. First, the same word names the kind and the slot (`claim`, `decision`, `definition`, `hypothesis`), so in the wild kind and content are often one field doing two jobs. Second, `status` is carried by 129 kinds and `type` by 97, but what `status` can honestly mean differs for every row of this table. One word, ten questions.

## 3. The edges, in an order

In the key, slots that point at something else are spread over at least six categories. Ordered by one question, *does anything rely along this, and for what*:

| Relied on for | Slot names in the wild | Census category today | If the target moves |
|---|---|---|---|
| **being true or justified** | `depends`, `grounds`, `per`, `why`, `evidence`, `requires`, `assumptions`, `justification`, `decision drivers`, `dependencies`, `intent basis`, `measurements`, `what discharges it` | Rests on | the piece has to be looked at again |
| **saying what something else says** | `narrates`, `about`, `of`, `demonstrates`, and a quotation's `source` with `pages`, `loc`, `lines`, `doc`, `src`, `url`, `doi` | Connections · Locators · Provenance | the telling, or the match, has to be looked at again |
| **where it came from** | `source`, `from`, `provenance`, `source files`, `source commit`, `passages`, `originsessionid` | Provenance · Connections · Work done | nothing, unless what was delivered from it is later dropped |
| **what it belongs to** | `belongs to`, `group`, `paper`, `term group`, `domain` | Connections · Tags · Planning · Model structure | nothing; this is a slot pointing |
| **what it replaces or closes** | `supersedes`, `superseded by`, `closes`, `leaves open`, `reopen when` | Connections · Open work | `reopen when` is a condition: the decision is looked at again |
| **who uses it** | `consumers`, `concerns`, `target` | Connections · Purpose | nothing; it says who to tell |
| **nothing; it is a way in** | `relates`, `see also`, `see`, `cross references`, `references`, `rels`, `term/rel`, `interactions`, `bibliography` | Connections · Options | nothing |

Three observations.

- **The first two rows are the model's references** (predicated-on and assumes; narrates). Everything a disturbance has to reach travels along them.
- **The third row is intake seen from the piece's side.** A piece naming its source is the same fact as a chunk naming where it went.
- **The last row relies on nothing and is not waste.** It is the estate's hand-kept form of the neighbourhood map: where a mind should look that no dependency would take it. If the unwritten reliance that bites is found by building such a map, these are the notes left by those who built one before.

## 4. What the census says about the model

1. **The five commonest slots are the model's skeleton.** `status` (129 kinds), `working notes` (125), `slug` (98), `type` (97), `depends` (96): how it stands, what is open, what it is called, what kind it is, what it rests on. With the content itself these are what nearly every hand-kept verisectorium converged on. The one-paragraph statement has the same six and little else.
2. **The commonest slot of all is the one the model says is never typed.** If a tool does not put a computed answer where `status` sits, minds will type one. This is the first thing the porcelain has to get right.
3. **"Standing" is five things under one heading.** Records of checking (`verifier`, `criterion`, `outcome`, `verified`, `verification chain`): these are the model's evidence, already being written by hand. Strength (`status`, `strength`, `epistemic status`). Where the work is in a process and who moves next (`stage`, `state`, `awaiting decision`, `awaiting second`, `needs work`). How current it is (`checked on`, `data as of`). And two that are content and not standing at all: `force` (must, should, may) and `realization` (built or not).
4. **Pieces in the wild carry where they are headed as well as where they are.** `max`, `max attainable` and `type expected` appear in some forty kinds between them: the strongest a piece could ever be, and what it is expected to become. Note 27 has open questions at the edge of the whole. The estate has been writing the same thing on single pieces.
5. **A decision's backing is spread over five categories**: who (Provenance: `deciders`, `consulted`, `informed`, `decided by`), grounds (Rests on: `assumptions`, `decision drivers`, `grounds recorded`), alternatives (Options), what follows (Consequences), and what would reopen it (Open work: `reopen when`). The key is cut by what a slot is about. The two kinds of answer cut across it.
6. **"Triggers and invocation" has no place in the model.** `before acting`, `on reading`, `when`, `should come to mind when`: a piece saying when it ought to be relied on. It bears on getting a mind to the locus of action, and on reliance nobody wrote. I have no proposal for it.
7. **A short form is nearly universal** (`summary`, `description`, `abstract`, `synopsis`, `executive summary`). It is the estate's existing answer to the denominator: the piece at the size a passing reader needs.
8. **Who and when are typed by hand in dozens of kinds** (`authors`, `speaker`, `said`, `created`, `updated`, `originsessionid`, `opened by`, `verifier`, `timestamp`). All of it is what a harness could capture.

## 5. The ten kinds of content, after sampling `segment-kinds.md`

*Added the same day, at Joseph's suggestion. I did not read `segment-kinds.md` whole (he recommended against it). I read its head, its ten summary findings, its at-a-glance table and its list of some 430 kind headings, and then 32 kind sections chosen to cover the ten rows of section 2: slot name, whether declared, form, and purpose. So what follows is from a sample I chose, about one kind section in thirteen.*

| The piece carries | Sampled | What the sample adds |
|---|---|---|
| **a claim** | Derived and Claim (ASF lineage), Claim (velocity, 325 files), Claim (NeurIPS adjudicated) | "`claim` has four shapes in four stores" (the report's own words), and what is asked differs with each. A derived claim: does it follow, with a per-claim record of population, true-of, false-of, falsifier. A velocity claim: is it still so, with `checked on` ("last read against sources") and `data as of`. An adjudicated claim: `verification chain` ("which independent passes reproduced it"). A response claim: "In Joseph's words", Gloss, Backing, which is someone's statement and what backs it. |
| **a rule or norm** | Rule (udon, 81), Normative (ASF lineage), Norm (firmatum) | `Grounds`: "what the card rests on (decisions, objectives, or forced-by)". `Epistemic status`: "what is checked, what is chosen". Thirty rule cards carry test fixtures nobody declared. A firmatum norm has a section "Why this is a law and not taste". |
| **a definition** | Definition (udon, 40), Term-entry (ASF, 177) | About half a udon definition's lines are working notes holding "My lean", "Precedents", "Candidates", "A collision to weigh", "Readings of his usage". A definition in the making is mostly a naming decision with its alternatives. Both stores keep what not to say (`Avoid`, "rejected words, with who used them when"; `Do not confuse`). |
| **a decision** | Decision (udon ADR, 18), Decision (live_docs, 129), ADR (autopax) | Three stores, three shapes, one core: the context, the choice, what follows, who. udon adds `Assumptions` ("what must stay true; each becomes a reopen trigger"), `Reopen when`, and `Closes` with `Leaves-open`. live_docs adds `Intent` (requested, chosen, incidental) and `Realization` (built or not). In live_docs the heading that holds the decision itself is undeclared and present in 128 of 129. |
| **a quotation** | Quotation (comproprium), Passage (airm) | Two kinds under one word. A passage of a document: document, page, lines, text. A person's saying: speaker, when said, occasion, what it is about, and when it should come to mind. Five sayings carry a confidence in their date. |
| **a question** | Question (udon pre-design), Question (ASF) | Two kinds again. A design question: the question "neutrally", its alternatives, and `Interactions` ("other questions this couples to"); it is a decision before it is made. An open item: who asked, when, what it concerns, and `Closer` ("who may close it"). |
| **a finding** | Findings slot (ASF claims), Claim chapter (udon-needs), Reflection (833 audit files), Item (662) | My row in section 2 was too narrow. Four different things are called this. A result worth cataloguing, with Impact, Novelty Claim, Related Work, Search Log. A research finding with `Honest edges` ("coverage limits and what is not established; always last") and "What it generates", split by who will use it. An auditor's reflection: 833 files, no declared shape, and the commonest headings are "Cross-segment consistency", "Predictions vs evidence", "Math verification". And an item of work, titled "Seed to attempt" or "Hypothesis to attempt". |
| **an argument** | Essay-outline, Paper (ops, 28), Movement | `Thesis`; "What this essay establishes" and "What this essay does NOT do"; `Novelty` ("what is new against named predecessors"); `Substrate` and a quote bank (where the material comes from); `Voice` ("whose words: joseph-primary to agent-drafted"). |
| **a practice** | Probe, Practice, Directive, Feedback memory (242) | The steadiest shape in the sample: `When` ("the moment it fires"), `Act`, `Why` ("mechanism it defeats"; in memories, "the reason (often an incident)"), `Evidence` ("firings and misfires"). |
| **a proof or working** | Derivation (37), Theorem (TST vault) | A table, "What Is Derived vs. What Is Chosen" ("each claim, its source, its strength"). `Max attainable`. Named parts inside the formal expression, "No-go" among them. |

One kind section 2 missed, and the sample shows clearly: **an account of something that happened.** Testimony (`Account`, `Cost`, `Grounds`: "segments it is evidence for", `Provenance`: "whose account, from what record"); Demonstration (the same, with "What would have happened instead"); and relata's verification event, 445 of them, five fields: what was checked, who checked, the outcome, when, and a note. That last is the model's evidence, already running, at the size it should be.

### What the sample shows across kinds

1. **Found out and decided are being told apart inside pieces, by hand, in at least five places.** "What Is Derived vs. What Is Chosen" (claims, derivations). Grounds that are "decisions, objectives, or forced-by" (rules). "What is checked, what is chosen" (rules). `Register`: derived or evidenced (findings). Decision drivers "each tied to an objective or marked inferred". The two kinds of answer are not only the model's claim about the estate; stores that never saw the model keep a column for them.
2. **The open edge is written on pieces everywhere.** `Leaves-open`, `Reopen when`, "What this opens", `Open decisions`, `Honest edges`, `Max attainable`, `Type-expected`, "What would strengthen this", "Seed to attempt", "The Gap", "The Spike". The second list is real, and it lives on single pieces as much as at the edge of the whole.
3. **What gets filled without being declared, and what is declared and never filled.** Filled, undeclared: the decision itself, `Avoid`, `Why` and `How to apply`, test fixtures, "Joseph's words" or "In Joseph's words" (in rules, definitions and claims). Declared, filled by none: several templates' slots, and comproprium's `Summary`, `Cost`, `Account` and `Grounds` on quotations. A slot survives when a mind at work needs it and dies when only the format does. The words of whoever decided, kept beside the thing decided, were invented at least three times.
4. **Who moves next is typed on every card of one store.** udon's `Awaiting-second`, `Awaiting-decision` and `Needs-work`, required on 235 cards. That is the frontier, addressed to seats, kept by hand.
5. **Time is already a slot where a claim is about the world.** `Checked on`, `Data as of`, `Event` ("bounds on when it happened"), `Said`, a date's confidence. The velocity store is the outside-referent case, built.
6. **The maker says who will use it.** `Consumers`, "What it generates" split by consumer, "Who reads this and when". That is the proposed integration, written by the author and executed by someone else.
7. **The same shape was copied for different kinds.** ASF's four sections (Formal Expression, Epistemic Status, Discussion, Working Notes) carry claims, norms, measurements and derivations alike across thirteen stores. Where a store made its own shape for a kind (udon's decision, comproprium's probe, relata's verification event) the slots are few and each is used.
