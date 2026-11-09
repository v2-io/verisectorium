```kdl
term "dimension" pos=noun pl="-s" {
  subtypes "determinant"
  synonyms "question"
  avoid "aspect" "used for the declared question and for one thing's answer to it at once; also an earlier candidate for this very word"
  avoid "truth determinant" "a role some dimensions play, declared in the ontology; not a thing beside them"
  avoid "ladder" "one way of reading the acts; the shape of an answer is the shape of its reading"
  rel opened-by term="kind" card="{1,N}"
  rel answered-by term="act" card="{0,N}" note="an act answers exactly one dimension"
  rel passes-along term="reference" card="{0,N}" note="what this dimension does to pieces that reference the piece, per reference kind" informal=#true
}
status provisional
```

# «dimension»
One question asked of a piece, declared with what it asks, of which kinds, against what, what act produces its answer, how the warrant is read from the acts that still bind, and what passes along references; a dimension is a constraint.

## Definition
The ontology declares each dimension with five things:

1. **asks**: the question, in plain words.
2. **of**: which «kinds|def/kind» it is opened for; a dimension may be of an «actor» (its orientations) as well as of a piece.
3. **against**: what a piece is held to. Where that is the same for every piece (logic; the world; its own canon) it is named once. Where it varies per piece (the source this quotes; the segment this explains; the party accountable for this decision; the target this is important for) the dimension says how a piece names it, usually by a «reference» of a declared kind. An act answering the dimension reads what fills this slot, which is why a change in it lapses the answer.
4. **produced by**: what sort of «act» answers it, and whose acts have standing, read from the «actor»'s record (orientation warranted; not the author; a ‹mind› rather than an ‹instrument›, or the reverse): a ‹check› by a mind re-deriving, not the author; a script comparing two texts; a run against an instrument at a version; a reader of a stated kind; an ‹attestation› by the accountable party; a ‹rule·firing› over attributes; the graph.
5. **read as**: how the warrant for a piece is read from the acts that still bind and concern it: the highest rung a confirming check reached, broken winning; the latest outcome; a conjunction of named checks; the latest word of the entitled party; a count; a declared numeric projection (a credence, where a verisectorium wants one).

And optionally **passes along**: for each reference kind, what this dimension does to pieces that reference the piece. Validity *caps* along predicated-on (nothing is warranted above what it rests on); freshness *stales* along narrates; most dimensions pass nothing.

For each piece and dimension its kind opens, two things are kept apart: the piece's **assertion**, written, and its **warrant**, computed. A ‹determinant› is a dimension the ontology names as part of what being right consists of for this verisectorium; in aggregate the determinants are the truth factors the verisectorium adjudicates, and better is read over them and over nothing else, but not in equal part: a projection declares, over segment kind × determinant, how much each pair weighs for its purpose, and the canonical projection's declaration is the verisectorium's default. The mark says only that a question is about rightness; the weight is the purpose's, and never a property of a piece. The other dimensions (importance for a target, freshness, who stands behind a decision, who moves next, an actor's orientation) are fitness: adjudicated as carefully, organizing the work, and saying nothing about whether a piece is right. The mark is set per dimension by the ontology, and the same question may be a determinant in one verisectorium and fitness in another: comprehension is what being right comes to for an explanation and is fitness for a claim. A dimension is distinct from an attribute, which is a plain measurement with no judgment and no warrant; a rule may read attributes and raise a question on a dimension, and that is the only place the two meet.

### Invariants
- Two things that can move independently never share a dimension. The tell for a fused one is a scale whose steps are combinations of two other scales' steps.
- No dimension's answer ever stands in for another's. Ruled does not make it true; a clear explanation is not support; a passing step-check does not deliver the statement.
- A dimension has a producer, or the ontology checker refuses it. A question nothing will ever answer is a wish.
- For every piece: assertion ≤ warrant, on the dimension's own ordering. Where it fails the piece is overclaimed and the «frontier» owes it.
- "Never asked" is a warrant, and a dimension not opened for a kind is a fact; neither is a gap.
- The ontology may declare that one dimension is a prerequisite for the meaning of another, takes precedence over it in a conflict, or vetoes it. Nothing combines dimensions into one score on a piece.

## Discussion
- Why five things and not two. The census of what the estate's verisectoria adjudicate found that nearly every question has a second argument (faithful *to*, understood *by*, important *for*) and that it is the filler that moves; that the questions recorded most are those whose producer is cheap, while a question with no producer silently dies; and that the shape of an answer is the shape of its reading, with ladders, conjunctions, per-judge verdicts and open lists all in use. Those are *against*, *produced by* and *read as*.
- Why a dimension is a constraint. Assertion ≤ warrant is the whole honesty rule, and the frontier is the list of its violations, with what passes along references and the ontology's own constraints beside it. Joseph: dimensions across segments and veritoids "become or are used as logical correctness constraints, or constraints for optimization more generally". A steady state is a feasible point; better is a direction within feasibility.
- Why determinants are a role and not a term. Joseph's aspect × standard carve of "truth determinant" (11-08) asked of a determinant exactly what *asks* and *against* say of every dimension, and it had no composition law. What is left once that is seen is one declaration: these dimensions are the ones "right" is measured by. Importance, freshness, who decided and who moves next are adjudicated just as carefully and are not among them.
- The two regimes. A theory claim's determinant dimensions read true or false, and its doubt is a list of named open checks beside it. An empirical fact or a proposed model reads by degree. They join at the hypothesis. A verisectorium that wants numeric credence declares a *read as* that computes one.
- One field, several questions. ASF's "valid" was at least eight questions in its recorded errors, and its `exact`/`conditional` word recorded the *outcome* of a judgment (is this premise inside the chain or outside it) with no place for the judgment itself. A dimension declared with its producer, and an act that names the dimension it answers, is what lets a later reader disagree with the judgment and not only the outcome.

## Examples
| asks | of | against | produced by | read as | passes along |
|---|---|---|---|---|---|
| does the statement as written follow from its premises? | claim | logic under the claim's hypotheses | a ‹check› by a mind re-deriving, not the author | highest confirmed rung; broken wins; narrowed is a split signal | caps along predicated-on |
| do the numbers reproduce? | claim with a run | a simulator at a version | a run act | latest outcome | none |
| is the imported result stated faithfully and checked at its source? | import | the cited work, named by reference | a read-check | rung: named, recalled, checked at secondary, checked at primary | none |
| does this explanation say what it explains says? | explanation | the veritoids it narrates, by reference | a read against both | latest outcome | stales along narrates |
| does a reader come away with it? | explanation | a reader of a stated kind | a reader event | count of confirming readers | none |
| who stands behind this, and how revisitably? | decision | the accountable party | an ‹attestation› by that party | that party's latest word: proposed, supported, ratified, ruled | none |
| how much rests on this, for what? | anything | a stated target | the graph | computed reach | none |

The first four and the fifth are determinants in AAT's sketch; the last two organize the work.

## Historical Context
### Etymology
From *dimetiri*, to measure out: one independently measurable question. Joseph's word since August 2026 for the orthogonal questions asked of a piece ("the thing that is orthogonal as it is created"); *aspect*, *axis* and *facet* were candidates that each collapsed the declared question with one thing's answer to it. The geometric overtone is accepted because orthogonality is the invariant.

### Adjudication
- "Truth determinant" was a term of its own in the first core (2026-11-06/07; `msc/notes/17b-2026-11-07-first-core/`), carved as aspect × standard on 11-08 and found on the same day to be non-composable ("authenticity to logic" never arises; "self-consistency" has no standard). Joseph's lean that it is a synonym for or subset of dimensions, and his observation that "aspect" had itself been a candidate name for dimension, led to the role declaration here. The five-slot declaration came from his 11-04 "what builds/founds/sustains this axis" and the census of the estate's verisectoria (`msc/notes/18`).
- Adjudicated against msc/notes 02 A0–A2, 08/09 (RC1's dimension), 09 §2.2, 12, 18 families A–G and findings 1–8, 19 §3, and Joseph's 11-08 turns on aspect × standard, on dimensions as constraints, and on determinants as a subset.

## Working Notes
- **Decide (Joseph).** "Assertion" is two things (cold read §2.1): *claimed standing* ("ratified"; "exact" as proven), comparable with a warrant, and *content scope* ("conditional on (S1)–(S5)"; "axiomatic" as definitional), which says what is claimed and is confirmed as written by any check. ASF's "exact" straddles both. If a dimension declares *asserts as* (which assertion values a piece may carry and where each sits on the *read as* ordering, or that they are content scope and exempt), the constraint applies only where it makes sense. Under the standing reading every fresh claim is an overclaim until a second mind checks it; under the scope reading it is a never-asked determinant in every steady state's conditions. Both are visible; they are different mechanisms, and the stopped-bound example depends on which. Lean: a sixth declared slot, *asserts as*; ASF's "exact" read as scope (the statement as written, hypotheses included, is what is claimed) with standing asserted implicitly by presence in canon, which matches Joseph's "state the currently known truth, doubt goes beside it".
- Why ‹determinant› is declared as a subtype although the body calls it a role: the lexicon has no mark form, and `‹determinant›` beside a dimension is how a marked dimension is written; it adds no fields and no file. If that reads as a different kind of thing, the body is right and the KDL should change.
- [M] The five-part declaration is mine, assembled from Joseph's "what builds/founds/sustains this axis" (11-04), the census's second-argument and producer findings (18), and note 19 §3. Untested on a declared ontology.
- Open. Whether *against* can carry every second argument, or whether some (importance for a target; comprehension by a reader) belong to the act rather than the dimension. Lean: the dimension names how a piece fills it; the act reads what fills it.
- Open. Whether a dimension that a ‹finding› answers (something is broken, no criterion) is the same dimension the checks answer. Lean: yes; a finding is a broken outcome without weight as a confirmation.
- From the vivarium research read (2026-11-09): an orientation dimension is of an actor, produced by a check concerning the actor; whether the three orientations Joseph named are one dimension with a varying *against* or three is open, lean one. See «actor».
- Open, from the first core's term "truth·determinant": whether at least one determinant must be held *against* something no write to the verisectorium can change (logic, the world, a source outside it). Every example so far has one; a verisectorium whose determinants are all against its own canon could improve by its own lights without limit. It would still not settle whether the work is pointed the right way.
- Open. Whether prerequisite, precedence and veto among dimensions are core machinery or only something the ontology may state. Lean: stated only, until a verisectorium needs the engine to enforce one.
