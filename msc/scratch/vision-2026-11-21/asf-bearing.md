# What ASF says that bears on a corpus kept true by many short-lived minds

*Written 2026-11-21 (evening, MST) by a delegated Claude (Opus 5.5) for the verisectorium session, against asf at `68f6864`, and revised the same night (see "What changed in this revision" just below). Sources are cited in footnotes in Joseph's project-path form: `(arch/asf)/01-aat-core/src/slug.md:N` means line `N` of that file under `$(pd arch/asf)`. Several segments write each paragraph as one long line, so a line number often names a paragraph. Each footnote gives the segment's typed status, the quoted words, and what surrounds them. Status words are what each segment's author typed in its frontmatter. Where I looked, I also give what `vsect` records about independent checks, because in asf the typed word is not computed from evidence. In each section, "In canon" is what the theory says at the strength it says it, and "Bearing" is my own reading, which nothing in asf has checked. Section 6 says what I read whole, in part, and not at all. A footnote that rests on a segment I know only through another document says so.*

## What changed in this revision

Adding footnotes took me back into the segments, and five things in the first version were wrong or loose. They are corrected in the body.

1. **Re-deriving is not reinjection.**
   - *What I first wrote.* My first list of what "reinjects" information into a corpus across mind-boundaries included "a re-derivation".
   - *Why it was wrong.* `der-turnover-information-recursion` defines reinjection as information about what has to be predicted that is "not derivable from the compressed state".[^tir-c3] A derivation is a function of what the mind already holds. By the data-processing inequality, a function of held content carries no information about the world beyond that content. In this sense re-deriving undoes processing errors (it raises the fidelity of what is carried) and brings nothing new in. For mathematical claims the recursion does not apply anyway: by `scope-adaptive-system` their correctness is computation.[^sas-prover]
   - *Primaries.* "A primary read whole" counts as reinjection only *relative to what the mind's opening reconstruction held*. It is bounded by what the stored primaries themselves carry, and it stops helping if the primaries are themselves rewritten. Only contact outside the corpus (new sources, runs, the steward's knowledge, the world) lifts that bound, and only it keeps up with a subject that moves.
   - *Where the change shows.* §0, §2.1 and §3 item 1 now say this. The coordinator's §3c (A8) inherited my list; see the note to the coordinator in my reply.
2. **The directed-separation requirement was stated backwards in one clause.**
   - *What I first wrote.* That recording a decision alone "leaves every claim conditioned on it miscalibrated".
   - *What the segment says.* The beliefs that are *not* conditioned on the goal, the goal-blind ones, are miscalibrated when the goal carries world information. Conditioning them on the goal would make them calibrated, but goal-coupled.[^ds-nwi] Recording the knowledge as an event restores both calibration and separation. §2.5 and §3 item 6 are corrected.
3. **`emp-update-gain`, now read whole.** In the first version I knew it only through quotations.
   - *Stronger than I had it.* Its body itself says model uncertainty "should spike" after structural change, and that an agent whose gain does not reset "continues trusting a stale model".[^eug-reset]
   - *Weaker than I had it.* "Behaviorally identical" for the two collapse modes, which I quoted as canon, is in its Working Notes (audit gold), not its body; the body says both produce "confirmation bias or a decoupled reality model".[^eug-collapse] Its Working Notes also flag that the ratio is defined only when the two uncertainties are in the same metric, and that for language models without per-token parameter updates the gain principle "reaches sketch-level".[^eug-caveats] So the mapping of a corpus's recorded statuses onto the gain is an analogy, not an instance.
   - §2.5 is corrected.
4. **Two phrases quoted from `def-adaptive-tempo` came from its Working Notes, not its body.** "Four times the readings buy twice the tempo" and "no number of readings gets past a shared bias" are audit-gold wording. The body's own words, now quoted instead, say the same thing.[^tempo-gating]
5. **Reinjection need not happen at every boundary.** §0 said something new must be "fed in at every boundary". The segment's necessity is that reinjection does not vanish in the limit. Sporadic reinjection can suffice.[^tir-r2]

## 0. The short answer

A good deal of ASF bears on the system you describe. Most of it is not in the central persistence inequality, where one would look first. It is in three less prominent places, plus the software volume:

1. **A result in the language-agent volume.** Across a reset, persistence is *imported, not intrinsic* (`der-turnover-information-recursion`).[^tir-summary] A state that is destroyed and rebuilt from a lossy store loses its information geometrically, unless information not derivable from what was carried over keeps being fed in. The segment proves that the rate-style persistence machinery does not carry over to this case.[^tir-r1] Joseph's dynamical system therefore has two kinds of dynamics, and the theory says they do not reduce to one inequality: drift against correction while a mind is working (a rate regime), and destroy-and-reconstruct as one mind follows another (a reinjection regime).
2. **Two results about finite attention.** The first is the evidence-allocation ceiling (`deriv-evidence-allocation-ceiling`). When $K$ items must all stay calibrated and share one stream of checking, they tolerate drift of at most $1/K$ of the error tolerance per step, and no averaging update rule beats that.[^ea-summary] The second is observability dominance with its companion (`der-observability-dominance`, `hyp-solicitable-escape`). What no observation bears on freezes at its prior and reads as settled.[^od-freeze] From inside such a region, the only escape an agent can choose is a differently-positioned observer.[^se-claim]
3. **Results on correlated channels** (`deriv-tempo-additivity`). Channels that share a source saturate at the shared-bias floor however many there are. A filter that treats them as independent becomes more confident while its error stalls.[^ta-saturation] Minds of one model family, given one briefing and reading the same summaries, are the textbook case.
4. **The software volume (TST)** prices the reader's side. Understanding is rebuilt by every fresh reader, so under total turnover it dominates the cost.[^dual-k] The legibility of the text acts as observation noise for every later reader.[^cq-shared]

The theory also already contains a sentence about exactly this architecture. `scope-agent-identity` says that sessions reading and writing one store at once are two agents whose writes merge lossily, that the system carrying the store is one agent only as a composite of them, and that the store is "the place where continuity is decided".[^sai-store]

**Where it does not apply** (§4). The central inequality needs four things a corpus has not been shown to have:

- **A measurable error and a well-behaved correction.** Its numbers need an error that can be measured as a distance and a correction that meets a sector condition.
- **Disturbance from outside.** It excludes agents "whose disturbance rises with their own correction effort",[^pc-neighbours] which is the nearest thing in it to a corpus's main disturbance, the fluent errors of the very minds that correct it. That mapping is mine.
- **Adaptation rather than computation.** The correctness of derivations is computation, which `scope-adaptive-system` places outside the adaptive scope.[^sas-prover]
- **A measurement on a real system.** No ASF result has been measured on any system the theory did not build.[^pc-instantiated]

**"Nobody has checked" is not quite true.** Three partial attempts exist, none of them on this question as you pose it (§5):

- Joseph has already named the question in asf's orientation file.[^joseph-worthy]
- asf's own system review applied Part I's inequality to asf's maintenance in one paragraph.[^sr-part1]
- `disc-framework-self-diagnostic` claims the theory applies to the agents building it.[^fsd]

## 1. First, what the agent is

The theory forces a modeling choice before anything else applies.

**Two levels.**

- **To each arriving mind, the corpus is environment.** This is TST's reading of a codebase: comprehension is building a model $M_t$ of it,[^ct-mt] and the corpus is fully inspectable in principle, with partial observability coming from the reader's bandwidth.[^sep-p1]
- **To the system as a whole, the corpus is its externalized model.** This is the language-agent volume's reading: the store $\mathcal E_{\text{ext}}$ from which each session's state is reconstructed.[^oct-finit] Sources are its observations, integration is its update, outputs are its actions.

ASF requires that its results not contradict each other across levels of description. I know that commitment only from an outline row.[^dcc-outline] My reading is that both levels hold at once, and that Joseph's "dynamical system" is the composite-level view.

**Who is a continuation, and who is a new agent** (`scope-agent-identity`, robust-qualitative).[^sai-continuation]

- A loop whose opening state is built from the store before it takes events of its own continues the trajectory.
- A loop that has already worked on a task of its own and then reads is observing; it does not continue anyone.
- Two continuations taking events at once are a fork.
- Merging diverged models is lossy by construction, with "no generally optimal merge".[^sai-merge]

The whole system counts as a composite agent, rather than a mere multi-agent system, only if one of four alignment routes holds. For a steward with delegated minds, the natural routes are sub-objectives derived from the steward's and a shared objective.[^sca-routes]

**What part of "keeping it true" is adaptation at all.** `scope-adaptive-system` sorts four ways of being behind:[^sas-table]

| Behind on | Remedy | In the adaptive scope? |
| --- | --- | --- |
| State | observe, probe | yes |
| Law | accumulate experience, intervene | yes |
| Chance | accept it | no |
| Speed | think faster | no; priced by tempo |

It places a theorem prover that knows its rules outside, "and its errors are computation".[^sas-prover]

*Bearing.* Whether a derivation in the corpus is correct is mostly the speed row: computation. Part I does not cover it, and neither does the turnover recursion. What does fall inside the adaptive scope:

- what the corpus currently says, and what is open in it, to a mind that has not read it;
- what incoming sources show;
- what other minds wrote;
- what the steward intends.

A fluent mistake is either a computation error or a state error, a claim made about a corpus not read. The remedies differ: re-derive in the first case, read in the second.

**The two atoms.** I know them only from the memory index line.[^two-atoms] They map onto AAT's split of agent state, $X_t = (M_t, G_t)$: truth claims are $M_t$, the reality model, and decisions are $G_t = (O_t, \Sigma_t)$, objectives and strategy. That makes directed separation (§2.5) apply to the relation between them.

## 2. What the theory says, by Joseph's variables

### 2.1 The corpus over time: two regimes

**In canon.**

- **`result-persistence-condition`** (exact under its assumptions).
  - *The threshold.* Correction strength $\alpha$ must beat disturbance $\rho$ relative to the region $R$ where correction works: $\alpha \gt \rho/R$.[^pc-threshold]
  - *Task adequacy.* A separate condition with a domain tolerance that AAT does not derive.[^pc-task]
  - *Two levers.* A gain raised past the optimum on the same observations enlarges the error; only more information raises tempo.[^pc-levers]
  - *Its own limits.* The cross-domain claim is "descriptive" and not instantiated, and agents whose disturbance rises with their correction effort are outside it.[^pc-neighbours][^pc-instantiated]
- **`obs-context-turnover`** (empirical: architecturally guaranteed). At a session boundary the state is "destroyed and reconstructed". The condition becomes reconstruction adequacy, "not a rate condition".[^oct-destroy] The first events of a session are "disproportionately important".[^oct-first] The strategy, the beliefs and the task description share one fixed context budget.[^oct-budget]
- **`der-turnover-information-recursion`** (conditional; R1 exact given its commitments (C1) and (C4); an independent verifier re-derived it and recorded "narrowed: the mathematics is right", with one residue).[^tir-check]
  - *The recursion.* Write $I_k$ for the reconstructed state's information about what it must predict, $\rho_k$ for the fresh information reinjected at boundary $k$, and $\eta_k \lt 1$ for the fraction each lossy reconstruction keeps. Then $I_{k+1} \le \eta_k (I_k + \rho_k)$.[^tir-box]
  - *No reinjection.* Then $I_k$ decays geometrically, and the rate template "provably does not transfer".[^tir-r1]
  - *Persistence requires reinjection.* Reinjection must not vanish, and the level reached is at most reinjection over the contraction gap. Non-vanishing reinjection suffices only under a further fidelity floor.[^tir-r2]
  - *What reinjection is.* "Exactly the part not derivable from the compressed state".[^tir-c3]
  - *Open edges.* The contraction coefficient has been computed for no real architecture. Adversarially correlated reinjection, re-grounding that fails exactly when there is little left, is a candidate second no-go.[^tir-adversarial]
  - *Prior art.* A ledger item says the result is formally iterated learning, or serial reproduction, and at text level model collapse. That is unverified and canon does not cite it.[^ledger-names]

**Bearing.** Corpus maintenance has both regimes, and they need different repairs.

- **The reinjection regime.** What crosses each mind-boundary is what minds write. A part of the corpus that a mind rewrites from its own partial reconstruction is the self-compressing walk. Examples are summaries, front pages, regenerated outlines, and restatements of restatements. The recursion predicts that such parts lose information about their subject each time they are rewritten from a lossy reading, however good the mind, unless each round brings in something not derivable from what that mind's reconstruction held.
- **Three different repairs.** The recursion distinguishes them, which I ran together in the first version.
  - *Reading what the store still holds verbatim* (primaries, unrewritten originals). This is reinjection relative to the mind's partial start, but bounded by what those originals carry. It works only while they stay unrewritten, which argues for keeping originals verbatim and tying rewritten surfaces back to them.
  - *Contact outside the corpus* (new sources, runs or measurements, the steward's knowledge, the world). This is the only kind that lifts the bound set by the originals, and the only kind that keeps up with a subject that moves.
  - *Re-deriving.* This reinjects nothing about the world (data processing). It raises the fidelity of what is carried by undoing processing errors, and for mathematical claims it addresses computation, which the recursion does not model.
- **The rate regime.** Parts nobody rewrites do not contract. They go stale against a moving truth instead.
- **Two signals already in the estate.** asf's own system review names the walk in its own words: "a prose surface with no binding to the record will be rewritten from recollection".[^sr-recollection] The adversarial-correlation edge has a natural reading here: a degraded corpus also degrades a new mind's ability to see what needs re-grounding.
- **The extent of the transfer.** The recursion is stated for one agent's predictive information across its own sessions. Carrying it to a store shared by many minds, partly read and partly untouched, is my step.

### 2.2 Readers' limited attention

**In canon.**

- **`deriv-evidence-allocation-ceiling`** (exact under five named conditions; its integrator's derivation and simulation checks are recorded as confirmed and have since lapsed).[^ea-checks]
  - *The lag.* Items observed with probability $\pi_i$ per step lag a drifting truth by at least $\rho_\Sigma/\pi_i$, where $\rho_\Sigma$ is the drift per step.[^ea-lag]
  - *The ceiling.* $K$ items that must all stay calibrated are reachable only if $\rho_\Sigma \lt R_\Sigma/K$, where $R_\Sigma$ is the tolerance.[^ea-cap] Past it the remedies are structural.[^ea-remedies]
  - *Outside the result.* Allocation that depends on outcomes.[^ea-outside]
- **`der-observability-dominance`** (robust-qualitative). Edges into nodes no observation bears on are frozen at their prior, and such regions are absorbing.[^od-freeze] Its basis is the three readings of near-zero mismatch: the model fits; the agent looks only where its model works; the channel is too noisy. "Silence can mean peace, or it can mean deafness."[^ms-trichotomy] Three things qualify it:
  - an independent check recorded one of its Claim Records as broken;
  - an open question says its investment tradeoff may be wrong-signed;
  - an open item says "cannot recognize" is unscoped.[^od-defects]
- **`hyp-solicitable-escape`** (discussion-grade; no recorded act). The only choosable escape from an absorbing region is a differently-positioned observer.[^se-claim] If an agent knows by construction where it has no sensor, aiming its own instrumentation becomes possible, "a design opportunity, not a trap".[^se-scope] The segment disclaims any transfer to comprehension between agents.[^se-disclaim]
- **`def-adaptive-tempo`** (conditional). Tempo is event rate times gain. Against noise, more events buy tempo only as a square root, and nothing gets past a bias shared across events.[^tempo-gating]
- **`disc-deferred-observation-processing`** (discussion-grade).
  - *The pipeline.* Capture, then triage on statistics, then processing.
  - *The capacity triple.* Retention, continuity and attention capacity. With finite retention and an intended long life, "the compression strategy *is* the agent's long-term intelligence."[^dop-triple]
  - *Retrospective attention.* A buffered, unprocessed event can become salient later.[^dop-retro]

**Bearing.**

- **The ceiling.** Read claims as the items, checking attention as the allocation, a check as a fresh observation, and staleness as drift. The ceiling then says a corpus whose checking attention is spread over $K$ claims keeps them all calibrated only while drift per step stays below tolerance divided by $K$. Past that, the only remedies are:
  - more independent checking per unit time;
  - fewer claims held as maintained, said openly;
  - checking deep claims directly, rather than only when their whole dependency chain upstream has been checked.
- **What the corpus actually does is outside the proof.** Corpus maintenance allocates on outcomes (minds read what is flagged), which the proof excludes.
- **Two different moves.** Marking a check as lapsed when its basis changes does not shrink the lag. It turns hidden lag into reported uncertainty (§2.5).
- **Frozen regions and the cold read.** Unread regions are frozen and look settled. The cold read is the differently-positioned observer. A record of which claims have no check is close to the scope clause's "known by construction" case, in which aiming one's own instrumentation becomes possible.
- **A related ledger item.** It quotes Joseph on success silencing its own evidence.[^ledger-warrant]
- **Influx as a buffer.** Unintegrated influx is a capture buffer, and retrospective attention is a reason to keep it rather than delete it.

### 2.3 Many minds

**In canon.**

- **`deriv-tempo-additivity`** (conditional; exact within a stated Gaussian regime; no recorded act in vsect).
  - *Common source.* Correlated channels sharing a source saturate at the shared-bias floor however many there are.[^ta-saturation]
  - *False confidence.* Modeling them as independent manufactures false confidence.[^ta-false]
  - *Synergy.* A nearly useless channel can be very valuable jointly when its errors are correlated with a good channel's failure modes.[^ta-synergy]
- **`hyp-communication-gain`** (discussion-grade).
  - *Three discounts.* Channel noise, the source's calibration, and alignment uncertainty.[^cg-terms]
  - *Repeated messages saturate.* One miscalibrated source's repeated messages saturate at its floor. The miscalibration belongs in a persistent trust meta-model that ground truth updates.[^cg-persistent]
- **`der-team-persistence`** (conditional; the diagnostic below is tagged Discussion). Low disagreement with high external error means the team is wrong together; keep direct observation live; weight members by calibration, not by stated confidence.[^tp-diag]
- **`der-tempo-composition`** (conditional; the closure-defect link is sketch-grade).
  - *Brooks's Law.* An echoing new member is "the sharpest Brooks case".[^tc-brooks]
  - *Heterogeneity costs.* Differences between members drive internal mismatch (a Working Note).[^tc-hetero]
  - *Open defects.* Two open ledger items say the segment states inconsistent conditions.[^tc-defects]
- **`def-shared-intent` and `hyp-auftragstaktik-principle`** (discussion-grade). Under bandwidth limits, share objectives over strategy over models: $B_O \gt B_\Sigma \gt B_M$. This reverses "when the environment is genuinely ambiguous and local observations are insufficient".[^at-reversal] A Working Note says AI teams may have the opposite cost structure.[^at-ai]

**Bearing.**

- **Echo-chamber agreement.** Minds of one model family, briefed alike, reading the same summaries, are common-source channels, and their shared fluent mistakes are the persistent shared bias. Two practices get a formal shape here: "same-author agreement is coherence, not corroboration", and "read primaries, not summaries". What the theory asks for is diversity of *source*. A count of readers does not substitute.
- **Counting confirmations.** A status rule that counts $N$ confirmations as $N$ pieces of evidence is the filter that manufactures false confidence.
- **The tradeoff the theory implies.** Diversity buys information and costs coordination, which implies an optimum in how different the working minds should be and in how many work at once. No segment derives it.
- **A divergence worth Joseph's eye.** The estate's delegation practice sends intent and context, which in the theory's terms is $B_O$ and $B_M$ high, and holds back the *how*, $B_\Sigma$ low. The headline ordering puts strategy above model, which the practice inverts. The theory's own reversal clause covers the practice's case: a fresh mind in a corpus it can read only in part.

### 2.4 Integration effort

**In canon.**

- **`form-consolidation-dynamics`** (robust-qualitative; existence of the window is conditional; its upper bound is open).
  - *The regime.* Consolidation is offline closing of the gap to the best compression.
  - *When it is necessary.* When a fast/slow split of the model's sub-states meets a per-event budget too small for cross-episode integration.[^cd-necessity]
  - *A window.* Forget fast enough to track change, slow enough to integrate patterns before they are discarded; an empty window is catastrophic forgetting.[^cd-window]
  - *Structural change.* It needs consolidation.[^cd-structural]
  - *A refinement.* An audit off-ramp note says replay from an archive is a channel bringing information, unlike internal replay.[^cd-offramp]
- **`der-temporal-nesting`** (robust-qualitative). A slower process acting before a faster one converges makes the system oscillate.[^tn-oscillate]
- **`result-structural-adaptation-necessity`** (conditional). Parametric tuning cannot close a floor set by an inadequate model class. The diagnostic is *patterned* residuals; the level of mismatch alone is not diagnostic.[^sa-diag]

**Bearing.**

- **Integration is consolidation.** Integrating influx is consolidation in this sense. For minds holding a fraction of the corpus, both necessity conditions hold, so integration needs its own passes, with a window.
- **A ladder for a corpus.** A mind's edits within a session, then claim revision, then integration passes, then structural change (terms, segment boundaries, the outline), then architecture (the praxis itself). Changing vocabulary or structure while claims settle is the slower level acting on transients.
- **Patterned residuals in a corpus.** Recurring same-kind findings read as patterned residuals: the structure is wrong, not the sentences. asf's system review records exactly such recurrence.[^sr-recur] It is my reading, not the review's, that this is the structural-adaptation symptom.
- **The gain window and fluent mistakes.** The window[^pc-levers] is the closest in-theory analog of a confident edit on a partial read. The analogy is loose, because fluent mistakes are more like bias than white noise.

### 2.5 "All tied to the epistemology"

**In canon.**

- **`emp-update-gain`** (robust-qualitative; exact in the Fisher-local regime; read whole for this revision).
  - *The gain.* $\eta^\ast = U_M/(U_M + U_o)$, model uncertainty over model plus observation uncertainty.[^eug-ratio]
  - *Gain collapse.* Underestimating model uncertainty or overestimating observation noise sends the gain to zero: the corrective phase stops and "mismatches are ignored, producing confirmation bias or a decoupled reality model".[^eug-collapse]
  - *Reset.* After structural change, model uncertainty "should spike"; an agent whose gain does not reset "will continue trusting a stale model".[^eug-reset]
  - *Caveats in its Working Notes (audit gold).* The ratio needs both uncertainties in the same metric, and for language models without per-token parameter updates the principle "reaches sketch-level".[^eug-caveats]
- **`der-directed-separation`** (conditional; many checks recorded).
  - *The invariant is calibration.* Choosing what to observe and what to encode is permitted; distorting the reported belief is not.[^ds-calibration]
  - *The premise (NWI).* The goal carries no information about the world beyond the agent's model. It fails "when the goal was set by a principal who knows what the agent's model does not". Then the goal-blind report is miscalibrated under each goal's law. The remedy is to "record the goal-setting, or the retained content, as an event the update conditions on".[^ds-nwi]
  - *LLMs.* They are coupled by construction: goals and observations go through one mechanism.[^ds-classes]
- **`hyp-truth-serving-loophole`** (sketch). It proposes "goal-*declared*" rather than goal-blind as the achievable discipline for agents whose actions cascade from their goals,[^tsl-declared] and cites the estate's own practice as an instance.[^tsl-estate]
- **`def-chronica`** (axiomatic) and **`scope-agent-identity`**. The record is append-only.[^chron-append] Rolling back a record with the state makes it no longer a record of what the agent did.[^sai-rollback]

**Bearing.** These are the parts I think most worth testing, now as an analogy rather than an instance (correction 3).

- **The recorded uncertainty plays the role of the gain.** A corpus's recorded uncertainty, its statuses and check state, plays the role of $U_M$. Through the gain it would set how much weight a new source gets. A corpus that overstates its certainty is in gain collapse: influx stops moving it, and a confident-wrong corpus looks settled. Lapse-marking when a claim's basis changes is the corpus analog of the reset the segment's body prescribes after structural change.
- **The analogy's limit.** The segment's own caveat applies. A corpus has no scalar $U_M$ in the same metric as the noise of its sources, so this is a structural reading, not a computation.
- **The two atoms and directed separation.** Truth claims should be calibrated under every decision: a decision may choose what to look at, not what is true. When the steward decides from knowledge the corpus lacks, the corpus is left with two bad options:
  - claims kept blind to the decision are miscalibrated, because the decision carries world information they lack;
  - claims that lean on the decision are calibrated but goal-coupled, their truth depending on a choice.

  Recording the knowledge itself as an event the claims condition on removes both. This is the sharpest concrete requirement I found.
- **Records as the wrapper.** Every mind is a coupled agent. Record architecture is what could make the composite separated: claims kept apart from decisions, goals declared out of band, checks by a different mind. The construction that does this is `der-class-coercion-via-wrapping`, which I know only from an outline row.[^wrap-outline]
- **The acta.** Append-only, corrected by later entries, as `def-chronica` requires.

### 2.6 The reader's side (TST)

**In canon.**

- **`def-comprehension-time`** (axiomatic definition; its AAT reading not derived). Under total context turnover, every session pays the full comprehension cost.[^ct-turnover]
- **`der-dual-optimization`** (conditional). Comprehension cost compounds per reader, a turnover multiplier $k$; implementation cost does not.[^dual-k]
- **`der-code-quality-as-observation-infrastructure`** (conditional on one empirical premise; no recorded act).
  - *The investment rule.* An improvement pays when $t_{\text{invest}} \lt \hat n_{\text{future}} \cdot \Delta t_{\text{comp}} \cdot k$: its cost now must be less than the future changes expected, times comprehension time saved per change, times the number of readers.[^cq-invest]
  - *Shared bias.* A misleading name misleads every reading the same way.[^cq-shared]
  - *Bad text hides misunderstanding.*[^cq-hides]
  - *Tests.* Tests are reusable interventional probes.[^cq-tests]
- **`impl-developer-agent`** (discussion-grade). For AI-maintained text, comprehension dominance is the normal case.[^ida-normal]

**Bearing.** Swap "corpus" for "codebase" and these transfer with little strain. Legibility is the main lever. Misleading prose is shared bias, which more readers will not catch. Recorded checks are the corpus's reusable probes.

## 3. What it would predict or require (my extensions)

These are ranked by how directly a segment supports them. None has been checked by anyone.

1. **Persistence across minds must be fed.** Rewritten parts decay unless each round brings in information not derivable from what the rewriting mind's reconstruction held. Reading unrewritten originals supplies that only up to what the originals carry. Only contact outside the corpus lifts that bound or keeps up with a moving subject. Re-deriving guards fidelity and brings nothing new in.
   - *Support:* `der-turnover-information-recursion`, exact within its commitments.
   - *Stretch:* from one agent to a shared, partly-read store.
   - *Refuted if:* a corpus maintained only by re-reading and rewriting its own summaries kept its accuracy against primaries over many generations of minds.
2. **Breadth costs drift tolerance.**
   - *Support:* `deriv-evidence-allocation-ceiling`, exact for fixed allocation.
   - *Stretch:* corpus allocation depends on outcomes.
   - *Refuted if:* staleness per claim stayed flat as claims were added at fixed attention.
3. **Agreement among like minds saturates.** Independent sources buy more than additional like readers.
   - *Support:* `deriv-tempo-additivity`; `der-team-persistence`.
   - *Refuted if:* same-model confirmations kept lowering the error rate against primaries without limit.
4. **Self-locking regions need an outside observer.** A record of which claims lack a check makes the trap aimable.
   - *Support:* `der-observability-dominance` (open defects); `hyp-solicitable-escape` (discussion-grade, not transferred by its author).
5. **Recorded uncertainty acts like a gain.** Overstated status suppresses integration of new sources, and status should rise when a claim's basis changes.
   - *Support:* `emp-update-gain`, by analogy, with the commensurability caveat.
   - *Refuted if:* how influx is taken up proved insensitive to recorded status.
6. **Record the knowledge behind decisions.** When a decision rests on the steward's knowledge, record the knowledge as an event, not only the decision. Otherwise the claims are either miscalibrated or goal-coupled.
   - *Support:* `der-directed-separation` (NWI).
7. **Integration needs its own passes, and the passes have a window.**
   - *Support:* `form-consolidation-dynamics`.
8. **Structural change goes slower than claim edits.** Recurring same-kind findings point to structure, not sentences.
   - *Support:* `der-temporal-nesting`; `result-structural-adaptation-necessity`.
9. **More minds help only on two conditions.** A new mind must bring non-echoing information, and must not raise coordination cost past its contribution. Concurrent writers merge lossily.
   - *Support:* `der-tempo-composition` (open defects); `scope-agent-identity`.
10. **Legibility is the leverage.** It is priced by the investment rule with the reader count $k$.
    - *Support:* TST.

## 4. Where it does not apply, or only by a stretch

- **No metric, no sector condition.** The persistence thresholds need an error measured as a distance and a correction meeting a sector condition. Nothing shows a corpus has either. Only the shapes transfer.
- **Endogenous disturbance is excluded.**[^pc-neighbours] The nearest neighbors are the gain window and `der-resource-bounded-destabilization`, which is exploratory and which I did not read.
- **Computation is out of scope.** The correctness of derivations is computation.[^sas-prover] It is outside Part I and outside the turnover recursion too.
- **Nothing is instantiated outside built systems.**[^pc-instantiated] asf's objective E, a measurement on an agent the theory did not construct, is unmet.[^intent-e]
- **Several results I lean on are scoped narrower than my use.** The turnover recursion is about one agent. The allocation ceiling excludes outcome-dependent allocation. The solicitable-escape hypothesis disclaims comprehension between agents.
- **There is no first-class theory of finite attention.**[^attn-spike] Later segments supply pieces. Nothing unifies them.
- **Population dynamics are open.** The Part III gaps on latent structural diversity and endogenous coupling are open.[^pop-gaps]
- **The steward as accountable principal.** ASF's principal-side segments may bear on "one person accountable". I know them only from outline rows.[^vfg-outline]
- **Open defects in what I cite.**
  - `der-tempo-composition`.[^tc-defects]
  - `der-observability-dominance`.[^od-defects]
  - `deriv-tempo-additivity`, `hyp-solicitable-escape` and the code-quality chain have no recorded independent check.[^no-checks]

## 5. Precedents and context

- **The archived file.** Read whole; it is about labeling fields, not these dynamics, and carries its own premature-synthesis marker.[^archive]
- **asf's system review.** Read whole; its §2 applies Part I to asf's maintenance.[^sr-part1] Its measured history is a case study of your system.
- **`disc-framework-self-diagnostic`.** Discussion-grade; read whole.[^fsd]
- **Open ledger items in asf close to your question.**
  - *"Self-silencing floors across volumes"*, where the repair term vanishes at the failure state.[^ledger-silencing]
  - *Joseph's "confidence and warrant diverge"*, and a scout's unchecked guess at its rate.[^ledger-warrant]

## 6. What I read

**Whole**

- *01-aat-core:* `scope-adaptive-system`, `result-persistence-condition`, `def-adaptive-tempo`, `deriv-evidence-allocation-ceiling`, `der-observability-dominance`, `hyp-solicitable-escape`, `deriv-tempo-additivity`, `hyp-communication-gain`, `def-shared-intent`, `hyp-auftragstaktik-principle`, `hyp-truth-serving-loophole`, `scope-composite-agent`, `der-team-persistence`, `der-tempo-composition`, `form-consolidation-dynamics`, `result-structural-adaptation-necessity`, `der-temporal-nesting`, `def-chronica`, `scope-agent-identity`, and `emp-update-gain` (added in this revision).
- *03-llm-core:* `der-turnover-information-recursion`, `obs-context-turnover`, `disc-m-preservation`, `disc-deferred-observation-processing`, `hyp-behavioral-self-knowledge-insufficiency`, `disc-framework-self-diagnostic`.
- *02-tst-core:* `def-comprehension-time`, `der-code-quality-as-observation-infrastructure`, `impl-developer-agent`, `der-dual-optimization`.
- *Other:* the 01 and 02 outlines, asf `CLAUDE.md`, the system review, the archived verisectorium file, and the coordinator's §3c in `00-working.md`.

**In part**

- `der-directed-separation`: lines 1–70 of 323.
- `def-mismatch-signal`: lines 1–60.
- `obs-software-epistemic-properties`: lines 1–60.
- `der-causal-insufficiency-detection`: lines 1–30.
- `INTENT.md`: objectives E and I.
- `03-llm-core/OUTLINE.md`: by grep.
- The two attention spikes: openings only.
- `vsect` records for eleven segments.

**Not at all**

- `deriv-persistence-cost`, `der-multi-timescale-stability`, `disc-composition-consistency`, `form-composition-closure`, `der-class-coercion-via-wrapping`, `disc-modularity-state-dynamics`.
- The principal-side segments.
- The 04 volume, the rest of TST, spikes, audits, reviews and CHANGELOG.

## 7. Feedback on the brief

The brief worked. Three things helped most:

- the honest "I haven't read it";
- the request to keep canon and extension apart;
- naming the prior file without vouching for it.

One thing I'd add for a future brief of this kind: a pointer to where checks are recorded (`vsect why/open`). In asf the status words are typed, and the check record changed how I'd weigh several results. On Joseph's footnote invitation: going back to the sources to cite them is what surfaced corrections 1–4. That is evidence for the practice, at least for reports like this one.

[^tir-summary]: `(arch/asf)/03-llm-core/src/der-turnover-information-recursion.md:14` (conditional). "Persistence across turnover is therefore not a property the composite can possess intrinsically: it is wholly imported through a non-vanishing reinjection channel — structurally, the §03.II scaffold — at a level set by reinjection over the contraction gap." This is the segment's summary paragraph. The "§03.II scaffold" is the scaffolded-agent sub-scope's external persistent state.

[^tir-r1]: `…/der-turnover-information-recursion.md:68–72`. "$I_n \leq (\prod \eta_j) I_0 \leq \bar\eta^{\,n} I_0 \to 0$ geometrically … There is **no inter-session persistence condition** … No $(\alpha,\rho,R)$ instantiation exists, because the template's structural ingredients have no counterpart in an unforced contraction." This is R1, exact under (C1) multiplicative contraction and (C4) uniform $\bar\eta \lt 1$. The segment's line 112 stresses that per-boundary lossiness alone does not force decay; uniformity is an added commitment.

[^tir-r2]: `…/der-turnover-information-recursion.md:82–84`. "Persistence across turnover … *requires* a reinjection channel that does not vanish, $\limsup_k a_k \gt 0$ … sporadic reinjection ($a_k = 1, 0, 1, 0, \ldots$) is compatible with $\liminf_n I_n \gt 0$ … Under (C5) … a reinjection channel bounded away from zero suffices." The upper recursion gives necessity, not sufficiency; sufficiency needs the fidelity floor (C5).

[^tir-c3]: `…/der-turnover-information-recursion.md:44`. "(C3) Reinjection is the conditional fresh information $\rho_k := I(X_k; Y \mid M_k^+) \geq 0$ — the $Y$-information in the end-of-session content $X_k$ *conditional on* the reconstructed start state, i.e. exactly the part not derivable from the compressed state." $Y$ is the future-observation target (line 22). Because $\rho_k$ is mutual information with $Y$, a computation on content the session already holds cannot raise it (data processing). That is the basis of correction 1, and the inference is mine, not the segment's.

[^tir-box]: `…/der-turnover-information-recursion.md:58`. The boxed recursion $I_{k+1} \le \eta_k (I_k + \rho_k)$. The surrounding paragraph (line 56) stresses it is exact by the chain rule, "not a sub-additivity claim".

[^tir-check]: `vsect why segment:der-turnover-information-recursion`, event of 2026-10-31T02:58 by "C.1 Vol-4 checker 3 (independent verifier)", outcome narrowed. The linked finding begins "The mathematics is right. Narrowed for one residue in the segment: line 112, 'Max attainabl…'". I did not open the review file `reviews/vol4-c1-check-3.md` itself.

[^tir-adversarial]: `…/der-turnover-information-recursion.md:131`. "If $\rho_k$ is state-correlated so as to vanish exactly when $I_k$ is low (re-grounding fails precisely when there is little left to re-ground), then $\bar a \gt 0$ marginally is *not* sufficient and R1 can reassert … the single most valuable follow-on." This is in Working Notes: an open edge, not a result.

[^ledger-names]: `vsect open segment:der-turnover-information-recursion`, item `item:standard-names-canon-s-memory-machinery-lacks-fo`, part (c). "#der-turnover-information-recursion (geometric loss through repeated lossy reconstruction unless re-injected) is formally the iterated-learning / serial-reproduction result (Bartlett 1932; Griffiths & Kalish 2007, convergence to the prior) and, at text level, model collapse (Shumailov et al.); 0 hits for any." The item says these names come "from the sources' or the scout's training knowledge unless marked, verify before adopting". I have read none of these works.

[^ea-summary]: `(arch/asf)/01-aat-core/src/deriv-evidence-allocation-ceiling.md:15` (exact). "A $K$-alternative OR node can therefore keep every alternative calibrated only if $\rho_\Sigma \lt R_\Sigma/K$ … The cap comes from how evidence is allocated, so no update rule of that averaging kind removes it." This is the summary paragraph; the scope sentence that follows excludes drift-extrapolating rules and outcome-dependent allocation.

[^ea-lag]: `…/deriv-evidence-allocation-ceiling.md:35–37`. Proposition EA.1, $m_{i,t} \le -\rho_\Sigma \mathbb E[A_{i,t}]$ with $\mathbb E[A_{i,t}] \uparrow 1/\pi_i$. The last-observation rule attains the bound.

[^ea-cap]: `…/deriv-evidence-allocation-ceiling.md:49–53`. Corollary EA.2, "$\sup \rho_\Sigma/R_\Sigma = 1/K$, attained by uniform allocation with the last-observation rule."

[^ea-remedies]: `…/deriv-evidence-allocation-ceiling.md:80–84`. "More evidence per step … Fewer alternatives held in calibration … direct observation of deeper links." This is in the Discussion, under "Parametric tuning cannot cross the ceiling; structural change can."

[^ea-outside]: `…/deriv-evidence-allocation-ceiling.md:74`. "Under state-dependent allocation (greedy switching, UCB, Thompson sampling) the observation history depends on outcomes … the proof does not apply as written." This is from the Epistemic Status, "Outside the conditions".

[^ea-checks]: `vsect read segment:deriv-evidence-allocation-ceiling`. "↻ run confirmed by f72-integrator as integrator on 2026-10-30 · simulation · stale: own text changed" and "↻ rederive confirmed … stale: own text changed". An open question asks whether EA.1 extends beyond averaging estimators. The confirmer was the integrator, not an independent verifier.

[^od-freeze]: `(arch/asf)/01-aat-core/src/der-observability-dominance.md:14–16` (robust-qualitative). "An edge into a node on which no observation bears cannot be updated … it is *frozen at its prior* … **unobservable regions of strategy are absorbing** … the agent *cannot learn, and cannot recognize that it cannot learn*." The setting is strategy-DAG edges updated by the gain principle, not text; the transfer to a corpus is mine.

[^od-defects]: `vsect read`/`vsect open segment:der-observability-dominance`. An independent "bare brief" checker recorded check C14 as broken on the Claim Record (`review:b1-part-ii-check-1#C14`). An open question asks whether the "observability investment tradeoff" is wrong-signed; it argues that with equal counts the per-edge minimum $\theta_1/(n+1)$ is below the plan-level $1/(n+1)$. Item `observability-dominance-cannot-recognize-unscoped` says "cannot recognize" holds only where observability is estimated.

[^ms-trichotomy]: `(arch/asf)/01-aat-core/src/def-mismatch-signal.md:19` (axiomatic). "A near-zero $\delta_t$ can mean (a) the model genuinely reflects reality … (b) … confirmation bias; or (c) the observation channel is too noisy to detect model errors … silence can mean peace, or it can mean deafness."

[^se-claim]: `(arch/asf)/01-aat-core/src/hyp-solicitable-escape.md:36` (discussion-grade, exploratory). "**Within an absorbing region, the only escape that is both untargeted and choosable is a differently-positioned observer.** Shock escapes but cannot be chosen; self-instrumentation can be chosen but — under estimated observability — not aimed."

[^se-scope]: `…/hyp-solicitable-escape.md:32`. "It fails where $\sigma_v$ is known **architecturally** … the interesting case is the estimated one … the architecturally-known case is a design opportunity, not a trap."

[^se-disclaim]: `…/hyp-solicitable-escape.md:46`. "It says nothing directly about comprehension between agents, and any transfer to that setting is a further step this segment does not take." Line 70 of its Working Notes records that the insight came from an agent's first-person experience of the condition.

[^tempo-gating]: `(arch/asf)/01-aat-core/src/def-adaptive-tempo.md:52` (conditional). "Four times the events buy twice the tempo a noisy channel supports. Iterating faster buys nothing against noise that more readings do not average away: a persistent bias shared across events saturates." The first version quoted the audit-gold paraphrase at line 72 as if it were the body (correction 4).

[^dop-triple]: `(arch/asf)/03-llm-core/src/disc-deferred-observation-processing.md:37` (discussion-grade). "Finite retention with unbounded intended continuity forces compression, and the compression strategy *is* the agent's long-term intelligence."

[^dop-retro]: `…/disc-deferred-observation-processing.md:51`. "When strategy or context shifts, previously irrelevant buffered signal can *become* salient, and the agent can mine its own buffer."

[^ledger-warrant]: `vsect open segment:der-observability-dominance`, item `joseph-s-confidence-and-warrant-diverge-and-the`. Joseph is quoted from `~/src/AISI-responses/influx/distillation/jaw-thoughts-aisi.md`, which I have not read: "Confidence and warrant move in opposite directions, and the divergence is produced by success … The picture stabilises -- which reads as understanding, and is actually the sensor going quiet." The rate guess in the item is marked "the scout's inference, unchecked".

[^ledger-silencing]: `vsect open segment:der-observability-dominance`, item `self-silencing-floors-cross-volume`. "Results where the repair term vanishes at the failure state, so every escape is exogenous; Volume 4 names a three-way version in prose, the Volume 1 instance is not connected, and the property sweep that would test it was never run."

[^ta-saturation]: `(arch/asf)/01-aat-core/src/deriv-tempo-additivity.md:74` (conditional). "Additive accounting claims precision growing without bound; the true joint information **saturates** at the shared-bias floor. No number of common-source channels, at any event rate, buys information past $1/\sigma_s^2$." The setting is the common-source noise model at lines 66–70, Fisher-local Gaussian.

[^ta-false]: `…/deriv-tempo-additivity.md:94`. "A filter that *models* the channels as independent additionally manufactures false confidence — its internal $U_M$ shrinks at the additive rate while true error stalls at the bias floor." This sentence is tagged *[Discussion]* in the segment.

[^ta-synergy]: `…/deriv-tempo-additivity.md:92`. "A channel that is nearly useless in isolation (huge $U_o$, negligible $\eta^\ast$) can be extremely valuable jointly — a reason to retain 'bad' sensors that are correlated with good ones' failure modes."

[^cg-terms]: `(arch/asf)/01-aat-core/src/hyp-communication-gain.md:15` (discussion-grade). "Channel noise is a property of the *channel* … Source quality is a property of the *source* … Alignment uncertainty is a property of the *relationship* … the framework's prescription is to track them separately."

[^cg-persistent]: `…/hyp-communication-gain.md:37`. "Repeated messages from $j$ are then #deriv-tempo-additivity's persistent-bias regime: what they tell $i$ about the quantity saturates at precision $1/U_{\text{src},j}$ … It belongs in the trust meta-model (Discussion) as a persistent state that ground truth updates, not in each event's noise." This is in a block tagged Derived, conditional on the Gaussian location regime.

[^tp-diag]: `(arch/asf)/01-aat-core/src/der-team-persistence.md:107–109` (conditional; these paragraphs tagged *[Discussion]*). "Low disagreement with high external mismatch points to a shared structural limitation: the team is wrong together … The remedy is to keep each member's direct-observation channel live even when the group is confident … An aggregator should weight members by their calibration rather than their stated confidence."

[^tc-brooks]: `(arch/asf)/01-aat-core/src/der-tempo-composition.md:116` (conditional). "A new member whose observation noise echoes the existing team's contributes almost nothing to $\mathcal T_{\text{joint}}$ while still adding coordination links, the sharpest Brooks case. Whether this specific mechanism … is the dominant cause in practice is an empirical question."

[^tc-hetero]: `…/der-tempo-composition.md:125` (Working Notes). "For agents with different correction rates, $\varepsilon^\ast \propto \lvert\alpha_1 - \alpha_2\rvert$ — heterogeneity drives closure defect, confirmed analytically in the 2-agent toy case."

[^tc-defects]: `vsect open segment:der-tempo-composition`. Item `todo-der-tempo-composition-a12-f116-119-closu-4424`: ":100 and :118 state two different composite persistence conditions; :100 charges the closure defect twice." Item `t1-tempo-composition-c-coord-baseline`: "inconsistent about C_coord."

[^at-reversal]: `(arch/asf)/01-aat-core/src/hyp-auftragstaktik-principle.md:45` (discussion-grade). "When the environment is genuinely ambiguous and local observations are insufficient (fog of war, novel codebase, unprecedented market conditions), model synchronization may be worth more than objective sharing." Its Epistemic Status (line 41) says the reversal conditions "are not characterized" and that the evidence is primarily from military command.

[^at-ai]: `…/hyp-auftragstaktik-principle.md:60` (Working Notes). "The principle may need qualification for AI agent teams where model synchronization is cheap … but objective alignment is hard."

[^cd-necessity]: `(arch/asf)/01-aat-core/src/form-consolidation-dynamics.md:54–60` (robust-qualitative). (N1) sub-state factorization and (N2) bounded per-event budget. "When (N1) *and* (N2) both hold, consolidation is a *necessity*." Line 106 notes neither condition is individually necessary.

[^cd-window]: `…/form-consolidation-dynamics.md:74–76`. "Empty window … is the catastrophic-forgetting regime … The upper bound's exact form depends on the consolidation mechanism and is not derived here."

[^cd-structural]: `…/form-consolidation-dynamics.md:82–84`. "Under (N1)+(N2), structural adaptation … cannot be executed online … All finite-budget agents require consolidation for quality-preserving structural change." The audit note at line 186 calls the last sentence an overstatement (it needs (N1)+(N2), not a finite budget alone).

[^cd-offramp]: `…/form-consolidation-dynamics.md:186` (Working Notes, audit off-ramp, Codex/526815 F75). "$I(e_{\text{replay}}\mid M_{\tau^-})=0$ holds only for *internally-generated* replay, not replay-buffer / archive / re-read retrieval (which is a channel from auxiliary memory into active $M$)." It parallels correction 1: re-reading stored originals brings information in; internal re-working does not.

[^tn-oscillate]: `(arch/asf)/01-aat-core/src/der-temporal-nesting.md:13` (robust-qualitative). "If a slower process acts before the faster process beneath it has converged, the slower process is adjusting based on transient behavior rather than settled dynamics, and the system oscillates." The basis is singular-perturbation reasoning (Tikhonov), line 45.

[^sa-diag]: `(arch/asf)/01-aat-core/src/result-structural-adaptation-necessity.md:17` (conditional). "Persistent *systematic* residual structure — surviving parametric convergence, after excluding channel-noise, disturbance, nonstationarity, and gain-miscalibration causes — is diagnostic of model-class inadequacy … the mismatch *level* alone is not."

[^sr-recur]: `(arch/asf)/msc/inside-out-2026-10/system-review/00-system.md:83`. "The named failures (routed to nothing; breadcrumbs; hand-offs to a cycle; a `[Verified]` whose object is what a file says) recur in June, July, August and today, with the text present and loaded."

[^sr-recollection]: `…/system-review/00-system.md:73`. "A prose surface with no binding to the record will be rewritten from recollection." This is the review's account of why the front surfaces went stale.

[^sr-part1]: `…/system-review/00-system.md:49`. "Read in the theory's own terms, the system fails the persistence shape it proves: the checks are its correction … a correction that no event fires has rate zero against a drift that never stops; by Part I's own inequality the mismatch leaves every bounded region." A Fable 5.1 owner's review, 2026-10-30.

[^eug-ratio]: `(arch/asf)/01-aat-core/src/emp-update-gain.md:25, 42–44` (robust-qualitative; exact in the Fisher-local regime). The formula $\eta^\ast = U_M/(U_M+U_o)$. "The qualitative direction is the load-bearing claim for downstream tempo and persistence machinery."

[^eug-collapse]: `…/emp-update-gain.md:52` (body). "When the agent incorrectly estimates $U_M \to 0$ (spurious confidence) or $U_o \to \infty$ (spurious distrust of sensors), $\eta^\ast \to 0$ and epistrophe ceases … Mismatches are ignored, producing confirmation bias or a decoupled reality model." "Both pathologies produce identical behavior" is at line 92, in Working Notes audit gold; `hyp-solicitable-escape` cites it as canon (correction 3).

[^eug-reset]: `…/emp-update-gain.md:61` (body, Discussion). "When the environment changes in ways the model cannot track incrementally … $U_M$ should spike — the model 'admits' its uncertainty … An agent whose gain does NOT reset after structural change will continue trusting a stale model."

[^eug-caveats]: `…/emp-update-gain.md:103, 111` (Working Notes, audit gold). "$\eta^\ast = U_M/(U_M+U_o)$ is meaningful only when $U_M$ and $U_o$ are comparable uncertainty quantities in the same space/metric" (Codex/526815). "In-context learning has no parameter update, so the gain principle reaches sketch-level for LLMs" (Claude/266847).

[^ds-calibration]: `(arch/asf)/01-aat-core/src/der-directed-separation.md:16` (conditional). "The invariant is calibration; selection and allocation move *which* information the belief conditions on (resolution), distortion is a report that is the conditional law given no information the agent holds (reliability), and only the third is a defect."

[^ds-nwi]: `…/der-directed-separation.md:55`. "(NWI) fails when the goal was set by a principal who knows what the agent's model does not … for any goal-blind report … its log-score reliability under goal $g$'s law is $\mathrm{KL}(P(\Omega \mid \mathcal I, g) \Vert P(\Omega \mid \mathcal I))$ … the goal-blind prior report $0.5$ carries $0.19$ nats of reliability under each goal's law, and the agent that uses the goal is calibrated and scores better. The restoration when (NWI) fails is to record the goal-setting, or the retained content, as an event the update conditions on; (NWI) then holds for the residual and no goal port is needed." What is miscalibrated is the goal-blind report, which is the basis of correction 2.

[^ds-classes]: `…/der-directed-separation.md:18`. "**GUC Class 3: Coupled** — a single mechanism handles both epistemic and strategic processing … directed separation fails by construction (transformer LLMs are the canonical case)."

[^tsl-declared]: `(arch/asf)/01-aat-core/src/hyp-truth-serving-loophole.md:15` (sketch). "The achievable discipline is not goal-*blind* but goal-*declared*: $G_t$ explicit, recorded, out-of-band, so that the update's dependence on it is *auditable* rather than *absent*." The segment records the root claims as Joseph's (line 43).

[^tsl-estate]: `…/hyp-truth-serving-loophole.md:49`. "The declared-goal discipline is what this research program already does everywhere — peer briefs state intent, the navigator holds the goal, decisions record who decided and how firmly, provenance marks travel with claims."

[^chron-append]: `(arch/asf)/01-aat-core/src/def-chronica.md:28` (axiomatic). "$\mathcal C_t$ is monotonically growing — events are added but never removed. It is the agent's *only* raw material for constructing a model."

[^sai-rollback]: `(arch/asf)/01-aat-core/src/scope-agent-identity.md:42`, the final sentence of the long "Not excluded" bullet. "Rolling back a *record* of the trajectory along with the state does not roll back the trajectory … it makes the agent's record no longer a record of what it did."

[^sai-store]: `…/scope-agent-identity.md:64` (robust-qualitative). "Two sessions that read and write one store at once are two continuations of it, so at the level of sessions they are two agents, whose writes merge through the store lossily (consequence 2); the system that carries the store is one agent only as a composite of them ( #scope-composite-agent). The singular-trajectory framing makes the store the place where continuity is decided." This is in the Discussion's "Connection to logogenic agents".

[^sai-continuation]: `…/scope-agent-identity.md:42`. "A *continuation* of an agent is a loop whose starting state is built from that agent's history … before the loop takes events of its own … a loop already taking events on a trajectory of its own, which another agent's events then reach, is not that agent's continuation, since every reader of anything an agent wrote would otherwise continue it." vsect records an independent check of this segment that came back narrowed (`review:vol4-c1-check-1#C4`).

[^sai-merge]: `…/scope-agent-identity.md:31`. "Model merging is lossy by construction … no generally optimal merge exists." The audit note at line 93 says this depends on the optimality criterion.

[^sca-routes]: `(arch/asf)/01-aat-core/src/scope-composite-agent.md:16` (robust-qualitative). The four disjunctive routes, (C-i) shared objective through (C-iv) equilibrium convergence. "Only one is required for scope-satisfaction."

[^sas-table]: `(arch/asf)/01-aat-core/src/scope-adaptive-system.md:88–93` (axiomatic scope; membership items exact). This is the "collapse map" table: state, law, chance, speed.

[^sas-prover]: `…/scope-adaptive-system.md:19`. "A theorem prover built knowing its rules and its checker, reading its proof state exactly, is outside on the first count, and its errors are computation; it is inside where its declared world holds something its design did not fix and later observations can show, such as the behavior of a library or a collaborator it was not given."

[^two-atoms]: `~/.claude/projects/-Users-josephwecker-v2-src-verisectorium/memory/MEMORY.md:12`. "Truth claims with evidence and decisions with backing are the spine." I have not read the memory file it indexes, nor verisectorium's core.

[^dcc-outline]: `(arch/asf)/01-aat-core/OUTLINE.md:212` (outline preamble; I have not read the segment). "The framework's scope conditions … do not restrict which level of description AAT applies to … the theory must not return contradictory answers across those analyses."

[^ct-mt]: `(arch/asf)/02-tst-core/src/def-comprehension-time.md:35` (axiomatic definition; its Epistemic Status says the AAT reading "is structurally motivated but not formally derived"). "In AAT terms, comprehension is constructing $M_t$."

[^ct-turnover]: `…/def-comprehension-time.md:37`. "With 100% context turnover per AI instance, every session pays the full comprehension cost."

[^sep-p1]: `(arch/asf)/02-tst-core/src/obs-software-epistemic-properties.md:22` (discussion-grade). "Partial observability *of the codebase* arises from the agent's limited attention and comprehension bandwidth, not from the environment hiding state."

[^oct-finit]: `(arch/asf)/03-llm-core/src/obs-context-turnover.md:27`. $X_{\tau_{k+1}} = f_{\text{init}}(\mathcal{E}_{\text{ext}}, p_{k+1}, M_0^{\text{weights}})$: the state is reconstructed from external memory, the new prompt and the frozen weights.

[^oct-destroy]: `…/obs-context-turnover.md:68–72` (empirical). "The state is not perturbed, it is *destroyed and reconstructed* … This is a reconstruction adequacy condition, not a rate condition."

[^oct-first]: `…/obs-context-turnover.md:86`. "The first events in a new session are disproportionately important — they populate the context with the information needed for subsequent cascade steps."

[^oct-budget]: `…/obs-context-turnover.md:82`. $\mathrm{DL}(\Sigma_t) + \mathrm{DL}(M_t) + \mathrm{DL}(\text{task}) \lt C_{\text{context}}$.

[^pc-threshold]: `(arch/asf)/01-aat-core/src/result-persistence-condition.md:39–41` (exact under GA-2, GA-3). "Each condition is sufficient for the individual agent and tight at class level."

[^pc-task]: `…/result-persistence-condition.md:19`. "Task adequacy is the separate condition … Set by the application, not derived by AAT."

[^pc-levers]: `…/result-persistence-condition.md:95–98`. "So 'faster adaptation improves persistence' is true of tempo raised by information and false of a gain raised past the optimum on a fixed channel." This is exact for linear correction under white channel noise.

[^pc-neighbours]: `…/result-persistence-condition.md:204`, from the Claim Record for "The same inequality governs a Kalman filter, a development team, an organization, an immune system and an evolving organism" (register: descriptive). "Two neighbours fall outside the hypotheses: systems that cross the threshold at different values in each direction, whose correction depends on history, and agents whose disturbance rises with their own correction effort, against the fixed $\rho$ the conditions assume." Mapping fluent mistakes onto this clause is mine.

[^pc-instantiated]: `…/result-persistence-condition.md:208`. "**Instantiated:** no, for every class the theory did not build." The same Claim Record lists only the Kalman filter as "True of", where the hypotheses are built in.

[^joseph-worthy]: `(arch/asf)/doc/sop/agents.sop.md:9` (symlinked as asf `CLAUDE.md`). "Thoughts about this as a system in and of itself-- a system of agentic truthification about agentic theory, is wholely worthy." It follows his statement of the in-place refactor's frame, "This effort is to *serve TRUTH*".

[^fsd]: `(arch/asf)/03-llm-core/src/disc-framework-self-diagnostic.md:15, 76` (discussion-grade). "AAT applies recursively to agents building it." Line 76 is its own open question: "Are there documented *negative* cases where the framework's vocabulary should have caught a failure but didn't?"

[^dual-k]: `(arch/asf)/02-tst-core/src/der-dual-optimization.md:36–38` (conditional). "Total comprehension cost $\approx t_{\text{comp}} \times k$ … With 100% AI context turnover, $k$ equals the number of sessions that touch the relevant code. Comprehension cost compounds per-reader; implementation cost does not."

[^cq-invest]: `(arch/asf)/02-tst-core/src/der-code-quality-as-observation-infrastructure.md:57–61` (conditional on the premise that $U_o$ falls with quality, stated at line 85 as "empirically motivated, not formally derived"). The investment inequality, with $k$ "the number of distinct agents who will read this code".

[^cq-shared]: `…/der-code-quality-as-observation-infrastructure.md:101`. "A misleading name or a hidden coupling misleads every reading the same way, which is the shared-bias case where more readings stop helping."

[^cq-hides]: `…/der-code-quality-as-observation-infrastructure.md:103`. "Bad code does not just slow comprehension — it *hides* miscomprehension."

[^cq-tests]: `…/der-code-quality-as-observation-infrastructure.md:105`. "Writing a test creates a *permanent, reusable* interventional probe channel … paid once but collected indefinitely."

[^ida-normal]: `(arch/asf)/02-tst-core/src/impl-developer-agent.md:25` (discussion-grade). "Comprehension dominance is not an edge case but the *normal* case for AI-maintained code … codebases that are 'good enough' for a stable human team may be structurally inadequate for an AI-agent workforce operating under 100% turnover."

[^wrap-outline]: `(arch/asf)/01-aat-core/OUTLINE.md:247` (outline row only; I have not read the segment). "Constructive route from Class 2 (Partial)/Class 3 (Coupled) component to Class 1 (Separated) composite via external scaffold."

[^vfg-outline]: `(arch/asf)/01-aat-core/OUTLINE.md:111, 121` (outline text only; I have not read these segments). It names `disc-value-functional-grounding-floor`'s "two-routes-exhausts" headline: the agent-side persistence route and the "principal-side protocol-commitment route".

[^intent-e]: `(arch/asf)/msc/inside-out-2026-10/INTENT.md:44–48`. E.1 and E.2 are "not started". E.3 ran a survival analysis whose unit "is not the claim's, … so it tests nothing `#der-change-expectation-baseline` states".

[^attn-spike]: `(arch/asf)/spikes/spike-attention-governance.md:7` (spike, exploratory, 2026-03-13; I read the opening only). "AAT's scope condition requires observations exist … but says nothing about **finite channel capacity**."

[^pop-gaps]: `(arch/asf)/01-aat-core/OUTLINE.md:306–309`. These are four `--GAP--` rows: latent structural diversity, endogenous coupling, composition transition dynamics, computational thresholds for social behavior.

[^no-checks]: `vsect why` for each segment: "no recorded act … No check, finding, question or refutation names it" (`deriv-tempo-additivity`, in the tree since 2026-07-15; `hyp-solicitable-escape`, since 2026-07-29; `der-code-quality-as-observation-infrastructure`, since 2026-04-07).

[^archive]: `(verisectorium)/.archive/prior-incarnation/theory/influx/segment-research/asf-implications-2026-08-14.md:3`. "Treat as one agent's dated testimony — usable as input, never as synthesis-of-record. Withhold from any de-novo synthesis pass so it cannot anchor a fresh mind."
