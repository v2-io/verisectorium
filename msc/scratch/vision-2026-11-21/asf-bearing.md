# What ASF says that bears on a corpus kept true by many short-lived minds

*Written 2026-11-21 (evening, MST) by a delegated Claude (Opus 5.5) for the verisectorium session, against asf at `68f6864`. Segment names are slugs under `~/src/arch/asf/{01-aat-core,02-tst-core,03-llm-core}/src/`. Status words are what each segment's author typed in its frontmatter. Where I looked, I also give what `vsect` records about independent checks, because in asf the typed word is not computed from evidence. In each section, "In canon" is what the theory says at the strength it says it, and "Bearing" is my own reading, which nothing in asf has checked. Section 6 says what I read whole, in part, and not at all.*

## 0. The short answer

A good deal of ASF bears on the system you describe. Most of it is not in the central persistence inequality, where one would look first. It is in three less prominent places, plus the software volume:

1. **A result in the language-agent volume.** Across a reset, persistence is *imported, not intrinsic* (`der-turnover-information-recursion`). A state that is destroyed and rebuilt from a lossy store loses its information about the world geometrically unless something new is fed back in at every boundary. The segment proves that the rate-style persistence machinery does not carry over to this case. Joseph's dynamical system therefore has two kinds of dynamics, and the theory says they do not reduce to one inequality: drift against correction while a mind is working (a rate regime), and destroy-and-reconstruct as one mind follows another (a reinjection regime).
2. **Two results about finite attention.** The first is the evidence-allocation ceiling (`deriv-evidence-allocation-ceiling`). When $K$ items must all stay calibrated and share one stream of checking, they can tolerate drift of at most $1/K$ of the error tolerance per step, and no update rule of the averaging kind beats that: breadth is bought with drift tolerance. The second is observability dominance with its companion (`der-observability-dominance`, `hyp-solicitable-escape`). What no observation bears on freezes at its prior and reads as settled. From inside such a region, the only escape an agent can choose is a differently-positioned observer.
3. **Results on correlated channels** (`deriv-tempo-additivity`). Channels that share a source saturate at the shared-bias floor however many of them there are. A filter that treats them as independent becomes more confident while its error stalls. Minds of one model family, given one briefing and reading the same summaries, are the textbook case.
4. **The software volume (TST)** prices the reader's side. Understanding is rebuilt by every fresh reader, so under total turnover it dominates the cost (`der-dual-optimization`). The legibility of the text acts as observation noise for every later reader (`der-code-quality-as-observation-infrastructure`).

The theory also already contains a sentence about exactly this architecture. `scope-agent-identity` says that two sessions reading and writing one store at once are two agents whose writes merge lossily, that the system carrying the store is one agent only as a composite of them, and that "the singular-trajectory framing makes the store the place where continuity is decided."

**Where it does not apply** (§4). The central inequality needs four things a corpus has not been shown to have:

- **A measurable error and a well-behaved correction.** Its numbers need an error that can be measured as a distance and a correction that meets a sector condition.
- **Disturbance from outside.** Its own Claim Record puts agents "whose disturbance rises with their own correction effort" outside it. A corpus's main disturbance is the fluent errors of the very minds that correct it.
- **Adaptation rather than computation.** Much of keeping a mathematical corpus true is computation, which `scope-adaptive-system` places outside the adaptive scope.
- **A measurement on a real system.** No ASF result has been measured on any system the theory did not build. The Claim Record says so: "Instantiated: no, for every class the theory did not build."

**"Nobody has checked" is not quite true.** Three partial attempts exist, none of them on this question as you pose it (§5):

- Joseph has already named the question in asf: *"Thoughts about this as a system in and of itself — a system of agentic truthification about agentic theory, is wholely worthy"* (asf `CLAUDE.md`).
- asf's own system review applied Part I's inequality to asf's maintenance in one paragraph.
- `disc-framework-self-diagnostic` claims the theory applies to the agents building it.

The archived verisectorium file is about labeling fields, not about these dynamics.

## 1. First, what the agent is

The theory forces a modeling choice before anything else applies.

**Two levels, both legitimate.**

- **To each arriving mind, the corpus is environment.** This is TST's reading of a codebase. Comprehension is building a model $M_t$ of it (`def-comprehension-time`). The corpus is fully inspectable in principle, and partial observability comes from the reader's bandwidth, not from the environment hiding anything (`obs-software-epistemic-properties` P1).
- **To the system as a whole, the corpus is its externalized model.** This is the language-agent volume's reading: $M^{\text{ext}}$, the store $\mathcal E_{\text{ext}}$ of `obs-context-turnover`. Sources are its observations, integration is its update, outputs are its actions.

ASF's composition-consistency commitment requires that the theory not contradict itself across levels. I read that only in the outline row for `disc-composition-consistency`. My reading is that both levels hold at once, and that Joseph's "dynamical system" is the composite-level view.

**Who is a continuation, and who is a new agent** (`scope-agent-identity`, robust-qualitative; one independent re-derivation recorded, came back narrowed):

- A loop whose opening state is built from the store before it takes events of its own continues the trajectory.
- A loop that has already worked on a task of its own and then reads the store is *observing*. It is not a continuation, "since every reader of anything an agent wrote would otherwise continue it."
- Two continuations taking events at once are a fork.
- Merging diverged models is "lossy by construction", and "no generally optimal merge exists."

The composite exists, as a composite agent rather than a mere multi-agent system, only if one of four alignment routes holds (`scope-composite-agent`, robust-qualitative). For a steward with delegated minds, the natural routes are (C-ii), sub-objectives derived from the steward's, and (C-i), a shared objective.

**What part of "keeping it true" is adaptation at all.** `scope-adaptive-system` (axiomatic as a scope; its membership consequences derived exact) sorts four ways of being behind:

| Behind on | Remedy | In the adaptive scope? |
| --- | --- | --- |
| State | observe, probe | yes |
| Law | accumulate experience, intervene | yes |
| Chance | accept it | no |
| Speed | think faster | no; priced by tempo |

It is explicit about computation: "A theorem prover built knowing its rules and its checker, reading its proof state exactly, is outside on the first count, and its errors are computation; it is inside where its declared world holds something its design did not fix and later observations can show, such as the behavior of a library or a collaborator it was not given."

*Bearing.* Whether a derivation in the corpus is correct is mostly the speed row: computation. Part I does not cover it. What does fall inside the adaptive scope:

- what the corpus currently says, and what is open in it, to a mind that has not read it;
- what incoming sources show;
- what other minds wrote;
- what the steward intends.

A fluent mistake is either a computation error or a state error, a claim made about a corpus not read. The remedies differ: re-derive in the first case, read in the second.

**The two atoms.** I know them only from the memory index line ("truth claims with evidence and decisions with backing are the spine"). They map cleanly onto AAT's split of agent state into $X_t = (M_t, G_t)$: truth claims are $M_t$, the reality model, and decisions are $G_t = (O_t, \Sigma_t)$, objectives and strategy. That makes directed separation (§2.5) directly applicable to the relation between them.

## 2. What the theory says, by Joseph's variables

### 2.1 The corpus over time: two regimes

**In canon.**

- **`result-persistence-condition`** (exact under its assumptions; many checks recorded).
  - *The threshold.* Correction strength $\alpha$ must beat disturbance $\rho$ relative to the region $R$ where correction works: $\alpha \gt \rho/R$ under bounded disturbance, a matching condition under stochastic disturbance.
  - *Task adequacy.* A separate condition: the steady-state error $R^\ast$ must be smaller than a domain tolerance, $R^\ast \lt \lVert\delta_{\text{critical}}\rVert$, which "AAT does not derive". The two failures have different remedies.
  - *Two levers.* Raising the gain on the same observations past the optimum enlarges the error. Only more information, more or more informative observations, raises tempo. Under white channel noise the condition is "a window, not a threshold".
  - *A cost.* Holding the error at a level has a sustained information-rate cost (`deriv-persistence-cost`, read only in summary).
  - *Its own limits.* Its Claim Record says the cross-domain claim (Kalman filter, development team, organization, immune system) is "descriptive" and "Instantiated: no, for every class the theory did not build". It lists "agents whose disturbance rises with their own correction effort" as outside the hypotheses.
- **`obs-context-turnover`** (empirical: architecturally guaranteed). At a session boundary the state is "not perturbed, it is *destroyed and reconstructed*". The question becomes reconstruction adequacy, "not a rate condition". The first events of a session are "disproportionately important". The context window is a joint budget, $\mathrm{DL}(\Sigma_t) + \mathrm{DL}(M_t) + \mathrm{DL}(\text{task}) \lt C_{\text{context}}$, where DL is description length: the strategy, the beliefs and the task description compete for one fixed space.
- **`der-turnover-information-recursion`** (conditional; R1 exact given its argued commitments (C1) and (C4); an independent verifier re-derived it and recorded "narrowed: the mathematics is right", with one residue).
  - *The recursion.* Write $I_k$ for the reconstructed state's information about the future it must predict, $\rho_k$ for the fresh information reinjected at boundary $k$, and $\eta_k \lt 1$ for the fraction each lossy reconstruction keeps. Then $I_{k+1} \le \eta_k (I_k + \rho_k)$.
  - *No reinjection.* Then $I_n \le \bar\eta^{\,n} I_0 \to 0$ geometrically. "There is no inter-session persistence condition," and the sector-persistence template "provably does not transfer".
  - *Persistence requires reinjection.* It needs reinjection that does not vanish ($\limsup_k a_k \gt 0$), and the level it reaches is at most $\bar a/(1-\bar\eta)$: "reinjection over the contraction gap". Non-vanishing reinjection suffices only under a further fidelity floor (C5). "The design effort that buys persistence is the construction and maintenance of the reinjection channel, and no tuning of internal dynamics substitutes for it."
  - *Open edges.* The contraction coefficient $\eta_k$ has been computed for no real architecture. *Adversarially correlated* reinjection is named the single most valuable follow-on, a candidate second no-go: re-grounding fails exactly when there is little left to re-ground.
  - *Prior art.* A ledger item (`item:standard-names-canon-s-memory-machinery-lacks-fo`) notes the result is formally the iterated-learning / serial-reproduction result (Bartlett 1932; Griffiths & Kalish 2007) and, at the level of text, model collapse (Shumailov et al.). That was named from a scout's training knowledge, is unverified, and canon does not cite it yet.

**Bearing.** Corpus maintenance has both regimes, and they need different repairs.

- **The reinjection regime.** What crosses each mind-boundary is what minds write. Any part of the corpus that a mind rewrites from its own partial reconstruction is the self-compressing walk the recursion describes. Examples are summaries, front pages, regenerated outlines, and restatements of restatements. The recursion predicts that such parts lose their information about the subject geometrically, however good each mind is, unless each round adds something not derivable from the corpus as read: a primary read whole, a re-derivation, a new source, the steward's own knowledge, a measurement.
- **The rate regime.** Parts nobody rewrites do not contract. They go stale against a moving truth instead.
- **Two signals already in the estate.** asf's own system review reports exactly the first failure in its own words: "a prose surface with no binding to the record will be rewritten from recollection". The open adversarial-correlation edge also has a natural reading here: a degraded corpus also degrades a new mind's ability to see what needs re-grounding.
- **The extent of the transfer.** The recursion is stated for one agent's predictive information across its own sessions. Carrying it to a store shared by many minds, partly read and partly untouched, is my step, not the segment's.

### 2.2 Readers' limited attention

**In canon.**

- **`deriv-evidence-allocation-ceiling`** (exact under five named conditions; its integrator recorded the derivation and a simulation as confirmed on 2026-10-30, both since lapsed because the text changed; one open question on extending it).
  - *The lag.* Items observed with probability $\pi_i$ per step lag a drifting truth by at least $\rho_\Sigma/\pi_i$, where $\rho_\Sigma$ is the drift per step. This holds for every estimator that averages past outcomes with weights set by when it observed, with or without forgetting.
  - *The ceiling.* $K$ items that must all stay calibrated are reachable only if $\rho_\Sigma \lt R_\Sigma \min_i \pi_i \le R_\Sigma/K$, where $R_\Sigma$ is the tolerance. Past it the remedies are structural: "more evidence per step", "fewer alternatives held in calibration", or "direct observation of deeper links". For a chain of dependent steps, the deep link is observed only when everything upstream succeeds, $\pi_k = \prod_{j \lt k}\theta_j$.
  - *Outside the result.* Allocation that depends on outcomes, and estimators that extrapolate drift.
- **`der-observability-dominance`** (robust-qualitative). Edges into nodes no observation bears on are "frozen at their prior". Such regions are absorbing, and they read as settled. This rests on `def-mismatch-signal`'s three readings of near-zero mismatch, which cannot be told apart from inside: (a) the model fits; (b) the agent looks only where its model already works; (c) the channel is too noisy to detect error. "Silence can mean peace, or it can mean deafness." It prescribes preferring the visible path to the confident one. Three things qualify it:
  - an independent check recorded one Claim Record entry as *broken*;
  - an open question argues that its "observability investment tradeoff" may be wrong-signed;
  - an open item says its "cannot recognize that it cannot learn" is unscoped.
- **`hyp-solicitable-escape`** (discussion-grade; no recorded act). Of the three escapes, external shock cannot be chosen. Instrumenting oneself cannot be aimed, where observability is estimated from one's own observations. A differently-positioned observer is "the only escape that is both untargeted and choosable." Two things bound it:
  - *Its scope clause.* Where an agent knows by construction which nodes it has no sensor for, self-instrumentation becomes aimable, "a design opportunity, not a trap".
  - *What it disclaims.* It "says nothing directly about comprehension between agents, and any transfer to that setting is a further step this segment does not take."
- **`def-adaptive-tempo`** (conditional). Tempo is event rate times gain, $\mathcal T = \sum_k \nu^{(k)} \eta^{(k)\ast}$: speed times quality. Against independent noise, "four times the readings buy twice the tempo"; "no number of readings gets past a shared bias".
- **`disc-deferred-observation-processing`** (discussion-grade).
  - *The pipeline.* Capture, then triage on signal statistics rather than content, then processing.
  - *The capacity triple.* Retention, continuity and attention capacity; all three finite is the primitive language-agent condition. "Finite retention with unbounded intended continuity forces compression, and the compression strategy *is* the agent's long-term intelligence."
  - *Retrospective attention.* A buffered, unprocessed event can become salient later.
  - *The recall-cost-gradient hypothesis.*

**Bearing.**

- **The ceiling.** Read claims as the items, checking attention as the allocation, a check as a fresh observation, and staleness as drift. The ceiling then says a corpus whose checking attention is spread over $K$ claims can keep all of them calibrated only while drift per step stays below tolerance divided by $K$. Past that, no smarter integration rule helps. Only three things do:
  - more independent checking per unit time;
  - fewer claims held as maintained, said openly;
  - checking deep claims directly, rather than only when their whole dependency chain upstream has been checked.
- **What the corpus actually does is outside the proof.** Corpus maintenance allocates on outcomes (minds read what is flagged), which is exactly the case the proof excludes; extending it is the open question.
- **Two different moves.** A rule that marks a check as lapsed when its basis changes (vsect's) does not shrink the lag at all. It turns hidden lag into reported uncertainty. That matters for the gain (§2.5), and it should not be confused with keeping the claim calibrated.
- **Frozen regions and the cold read.** Regions of a corpus that no reader's attention reaches are frozen and look settled. The cold read your praxis asks for (step 8) is the differently-positioned observer. The scope clause fits a store of recorded checks unusually well: an agent that knows by construction which claims have no check is in the case where it can aim its own instrumentation.
- **A related ledger item.** It quotes Joseph (from his AISI notes): *"The picture stabilises — which reads as understanding, and is actually the sensor going quiet."* That is the same mechanism stated about success silencing its own evidence. It has no canon carrier yet.
- **Influx as a buffer.** Unintegrated influx is a capture buffer, and integration is processing. Retrospective attention is a reason to keep unprocessed influx rather than delete it. The corpus as a whole is the composite's compression strategy.

### 2.3 Many minds

**In canon.**

- **`deriv-tempo-additivity`** (conditional; exact within a stated Gaussian regime; no recorded act in vsect). Write $\sigma_s^2$ for the variance of a bias shared by all channels.
  - *The deviation is signed.* Correlated channels can carry less joint information than additive accounting claims, or more.
  - *Common source.* There is a closed-form redundancy penalty. Under a persistent shared bias the total information saturates at $1/\sigma_s^2$: "no number of common-source channels, at any event rate, buys information past" it.
  - *False confidence.* A filter that models such channels as independent "additionally manufactures false confidence — its internal $U_M$ shrinks at the additive rate while true error stalls at the bias floor". Here $U_M$ is its model uncertainty.
  - *No scalar fix.* No sign-blind dependence measure can carry the correction.
  - *Synergy.* A channel nearly useless alone can be very valuable jointly when its errors are correlated with a good channel's failure modes.
- **`hyp-communication-gain`** (discussion-grade).
  - *Three discounts on a message.* Channel noise, the source's calibration, and alignment uncertainty. They are different in kind and the segment says to track them separately.
  - *Repeated messages saturate.* Repeated messages from one miscalibrated source saturate at that source's floor. The miscalibration "belongs in the trust meta-model … as a persistent state that ground truth updates, not in each event's noise."
- **`der-team-persistence`** (conditional; the diagnostic below is tagged Discussion). Low disagreement with high external error means the team is "wrong together"; the members' reports have become a common source. "The remedy is to keep each member's direct-observation channel live even when the group is confident." An aggregator "should weight members by their calibration rather than their stated confidence."
- **`der-tempo-composition`** (conditional; the closure-defect-to-overhead link is sketch-grade).
  - *The bound.* Composite tempo is bounded by the tempo of the parts' pooled streams, the joint tempo, minus a coordination overhead.
  - *Brooks's Law.* "A new member whose observation noise echoes the existing team's contributes almost nothing … while still adding coordination links, the sharpest Brooks case."
  - *Heterogeneity costs.* Differences between members drive the internal mismatch, the closure defect (a Working Note, from a two-agent toy).
  - *Open defects.* Two open ledger items say the segment states two inconsistent composite persistence conditions and uses two definitions of coordination overhead.
- **`def-shared-intent` and `hyp-auftragstaktik-principle`** (both discussion-grade). These are mission-type tactics. Under bandwidth limits, share objectives, then strategy, then models: $B_O \gt B_\Sigma \gt B_M$. Two qualifications:
  - *A reversal clause.* "When the environment is genuinely ambiguous and local observations are insufficient (fog of war, novel codebase …), model synchronization may be worth more than objective sharing."
  - *A Working Note.* AI teams may differ because model synchronization is cheap for them and objective alignment hard.

**Bearing.**

- **Echo-chamber agreement.** Minds of one model family, briefed alike, reading the same summaries, are common-source channels. Their agreement buys bounded evidence, and the fluent mistakes such instances share are the persistent shared bias. Two practices get a formal shape here: the archived ORIENT's "same-author agreement is coherence, not corroboration", and your memory's census canary ("read primaries, not summaries"). The theory's requirement is diversity of *source*: a different substrate, an unprimed brief, a primary read. A count of observers does not substitute.
- **Counting confirmations.** An aggregator, or a status rule, that counts $N$ confirmations as $N$ pieces of evidence is the filter that manufactures false confidence.
- **The tradeoff the theory implies.** Diversity buys information, by additivity. It also costs coordination, by closure defect. That implies an interior optimum, both in how different the working minds should be and in how many should work at once. No segment derives it.
- **A divergence worth Joseph's eye.** The estate's delegation practice (`AGENTIC-DELEGATION`) sends intent and the context only the sender has, and holds back the *how*. In the theory's terms that is $B_O$ and $B_M$ high, $B_\Sigma$ low. The headline ordering puts strategy above model, which the practice inverts. The theory's own reversal clause covers the practice's case: a mind arriving knowing nothing, in a corpus it can read only in part, is the "local observations are insufficient" regime. So the practice is consistent with the hypothesis read with its caveats, and the part that does not fit is the headline $B_\Sigma \gt B_M$.

### 2.4 Integration effort

**In canon.**

- **`form-consolidation-dynamics`** (robust-qualitative; existence of the window is conditional; its upper bound is open).
  - *The regime.* Consolidation is an offline regime: updates driven by replayed material, aiming to close the gap to the best compression, not to fit the next event.
  - *When it is necessary.* When both (N1) and (N2) hold. (N1) is a fast/slow split of the model's sub-states. (N2) is a per-event budget too small for cross-episode integration.
  - *A window.* Forget fast enough to track change, slow enough for consolidation to integrate patterns before they are discarded. An empty window is catastrophic forgetting.
  - *Structural change.* Under (N1) and (N2) structural change cannot be done online.
  - *A refinement.* An audit off-ramp note says replay from an archive or a re-read file is a channel bringing information, unlike internal replay, which brings none.
- **`der-temporal-nesting`** (robust-qualitative). The levels run reactive, then parametric, then consolidation, then structural, then architectural. "If a slower process acts before the faster process beneath it has converged … the system oscillates." Micromanagement is its organizational instance. A closed-form separation threshold lives in `der-multi-timescale-stability`, which I did not read.
- **`result-structural-adaptation-necessity`** (conditional). When the model class is inadequate, parametric tuning cannot close the floor. The diagnostic is *patterned* residuals, structure that survives parametric convergence; the level of mismatch alone is not diagnostic. The four mechanisms of structural change include "grafting", taking in outside structure. Rational conservatism follows: premature change wastes knowledge; delayed change accumulates mismatch.
- **The gain window** in `result-persistence-condition` (above): correcting harder on the same observations, past the optimum, adds error.

**Bearing.**

- **Integration is consolidation.** Integrating influx is consolidation in this sense. For minds that hold a fraction of the corpus, (N2) holds by construction. (N1) holds wherever the corpus has a fast inbox (Working Notes, the influx) beside slow bodies. So the theory predicts that integration cannot keep up by being done source by source as sources arrive. It needs its own passes, and those have the stability-plasticity window.
- **A ladder for a corpus.** A mind's edits within a session, then claim-level revision, then integration passes, then structural change (terms, segment boundaries, the outline), then architecture (the praxis itself). Changing vocabulary or structure while claims are still settling is the slower level acting on transients.
- **Patterned residuals in a corpus.** Recurring same-kind findings across reviews read as patterned residuals: evidence that the structure is wrong, not the sentences. asf's system review found its named failures recurring month after month with their warnings loaded in every session. I read that as this symptom, a reading the review itself does not make.
- **The gain window and fluent mistakes.** The window is the closest in-theory analog of a mind making a confident edit on a partial read. Fluent mistakes are more like bias than white noise, though, so the analogy is loose.

### 2.5 "All tied to the epistemology"

**In canon.**

- **The gain principle** (`emp-update-gain`, which I did not read whole; its formula and failure modes are quoted consistently by the segments I read). The optimal gain is $\eta^\ast = U_M/(U_M + U_o)$, model uncertainty over model plus observation uncertainty. Gain collapses through $U_M \to 0$ (dogmatism) or $U_o \to \infty$ (nihilism), and the two are "behaviorally identical".
- **`der-directed-separation`** (conditional; many checks recorded).
  - *The split.* Belief update is goal-blind conditional on the realized event. "The invariant is calibration": choosing what to observe and what to encode is permitted; distorting the reported belief is not.
  - *The premise (NWI).* The goal carries no information about the world beyond the agent's current model. It fails "when the goal was set by a principal who knows what the agent's model does not." The remedy: "record the goal-setting, or the retained content, as an event the update conditions on." A worked instance shows a goal-blind report losing 0.19 nats of reliability under each goal's law when this is not done.
  - *LLMs.* Transformer LLMs are Class 3 by construction: goals and observations go through one mechanism, so separation fails inside them. Wrapping (`der-class-coercion-via-wrapping`, read only as an outline row) is the route to a separated composite.
- **`hyp-truth-serving-loophole`** (sketch). For a goal that is truth itself, coupling between goal and belief update is calibration-seeking rather than a leak. For agents whose actions cascade from their goals, the achievable discipline is "goal-*declared*" rather than goal-blind: the goal recorded out of band, so its influence on beliefs can be audited. The segment cites the estate's own practice as this ("peer briefs state intent … decisions record who decided and how firmly, provenance marks travel with claims").
- **`def-chronica`** (axiomatic). The record is append-only and is "the only raw material" for a model. `scope-agent-identity` adds: "Rolling back a *record* of the trajectory along with the state … makes the agent's record no longer a record of what it did."

**Bearing.** These are the parts I think most worth testing.

- **The recorded uncertainty is the gain.** A corpus's recorded uncertainty, its statuses and its check state, plays the role of $U_M$. Through $\eta^\ast$ it sets how much weight a new source gets. In AAT "all tied to the epistemology" is close to literal: tempo is speed times gain, and gain is an uncertainty ratio. A corpus that overstates its certainty is in gain collapse. Influx stops moving it, and a confident-wrong corpus is indistinguishable from a settled one. Lapse-marking raises $U_M$ honestly when a claim's basis changes, which keeps the gain alive.
- **The two atoms and directed separation.** Truth claims should be calibrated under every decision: a decision may choose what to look at, not what is true. When the steward decides on the strength of knowledge the corpus lacks, the decision alone leaves every claim conditioned on it miscalibrated. The knowledge itself has to be recorded as an event. This is the sharpest concrete requirement I found.
- **Records as the wrapper.** Every mind in the system is a Class 3 agent. The architecture of records is what could make the composite separated: claims kept apart from decisions, goals declared out of band, checks recorded by a different mind.
- **The acta.** The append-only acta, corrected only by later entries, are exactly what `def-chronica` and the rollback sentence require.

### 2.6 The reader's side (TST)

**In canon.**

- **`def-comprehension-time`** (axiomatic definition; its AAT reading "structurally motivated but not formally derived"). Comprehension is building $M_t$. "With 100% context turnover per AI instance, every session pays the full comprehension cost."
- **`der-dual-optimization`** (conditional). Comprehension cost is paid once per reader, so it compounds with the number of readers, a turnover multiplier $k$. Implementation cost is paid once per feature. Under high turnover comprehension dominates.
- **`der-code-quality-as-observation-infrastructure`** (conditional on one empirical premise, that observation noise decreases with quality; no recorded act).
  - *The chain.* Quality lowers observation noise, which raises gain, which raises tempo, which governs persistence: $Q \to U_o \to \eta^\ast \to \mathcal T \to$ persistence.
  - *The investment rule.* An improvement pays when $t_{\text{invest}} \lt \hat n_{\text{future}} \cdot \Delta t_{\text{comp}} \cdot k$: its cost now must be less than the future changes expected, times comprehension time saved per change, times the number of readers.
  - *Bad text hides misunderstanding.* "Bad code does not just slow comprehension — it *hides* miscomprehension."
  - *Shared bias.* "A misleading name or a hidden coupling misleads every reading the same way, which is the shared-bias case where more readings stop helping."
  - *Tests.* Tests are reusable interventional probes (Pearl's Level 2, the level of interventions).
  - *Hypothesis grade.* The vicious and virtuous cycles around a threshold are hypothesis-grade.
- **`impl-developer-agent`** (discussion-grade). For AI-maintained code the multiplier "approaches infinity" and comprehension dominance "is not an edge case but the *normal* case". Text "good enough for a stable human team may be structurally inadequate for an AI-agent workforce operating under 100% turnover."

**Bearing.** Swap "corpus" for "codebase" and these transfer with little strain. Legibility is the main lever. Misleading prose is shared bias, so more readers will not catch it. Recorded checks are reusable probes, the corpus's tests, which any later mind can invoke without rebuilding them.

## 3. What it would predict or require (my extensions)

These are ranked by how directly a segment supports them. None has been checked by anyone.

1. **Persistence across minds must be imported.** A non-vanishing channel of information not derivable from the corpus as read is required. Parts that minds rewrite from their own reconstruction decay geometrically without it, however capable the minds.
   - *Support:* `der-turnover-information-recursion`, exact within its commitments.
   - *Stretch:* from one agent to a shared, partly-read store.
   - *Refuted if:* a corpus maintained only by re-reading and rewriting kept its accuracy against primaries over many generations of minds.
2. **Breadth costs drift tolerance.** The number of claims a corpus can hold calibrated is capped by checking attention divided by drift over tolerance. Past the cap, the remedies are pruning or openly marking claims as unmaintained, independent channels, or direct checks of deep claims.
   - *Support:* `deriv-evidence-allocation-ceiling`, exact for fixed allocation.
   - *Stretch:* corpus allocation depends on outcomes.
   - *Refuted if:* staleness per claim stayed flat as claims were added at fixed attention.
3. **Agreement among like minds saturates.** Same-substrate, same-brief, same-summary minds add bounded evidence. Treating their agreement as accumulating evidence manufactures confidence. Independent sources, or a cheap channel whose errors run against the main one's, buy more than additional like readers.
   - *Support:* `deriv-tempo-additivity`, conditional and exact in-regime; `der-team-persistence`.
   - *Refuted if:* adding same-model confirmations reduced the measured error rate against primaries without limit.
4. **Self-locking regions need an outside observer.** Regions no reader reaches read as settled. A differently-positioned observer is the only escape a mind can choose from inside. A record of which claims lack a check turns the trap into something aimable.
   - *Support:* `der-observability-dominance`, robust-qualitative with open defects; `hyp-solicitable-escape`, discussion-grade and explicitly not transferred to comprehension.
5. **Recorded uncertainty sets the gain.** Overstated status suppresses integration of new sources, and understated status lets every source move the corpus.
   - *Support:* `emp-update-gain` plus my mapping.
   - *Refuted if:* how influx is taken up proved insensitive to recorded status.
6. **Record the knowledge behind decisions.** When a decision rests on the steward's knowledge, record the knowledge as an event, not only the decision.
   - *Support:* `der-directed-separation` (NWI), conditional, exact in the instance.
7. **Integration needs its own passes, and the passes have a window.** Integration cannot be done source by source by minds that hold a fraction. Discarding influx too fast loses cross-source patterns; too slow fills the space.
   - *Support:* `form-consolidation-dynamics`, robust-qualitative.
8. **Structural change goes slower than claim edits.** Restructuring terms, the outline or the praxis while claims are still settling should oscillate. Recurring same-kind findings point to structure, not sentences.
   - *Support:* `der-temporal-nesting`; `result-structural-adaptation-necessity`.
9. **More minds help only on two conditions.** A new mind must bring non-echoing information, and must not raise coordination cost past its contribution. Concurrent writers to one claim merge lossily, with no generally optimal merge.
   - *Support:* `der-tempo-composition`, with open inconsistencies; `scope-agent-identity`.
10. **Legibility is the leverage.** For corpora read mostly by fresh minds, legibility is the main lever on cost and on error-hiding, priced by the investment rule with the reader count $k$.
    - *Support:* TST, conditional and discussion-grade.

## 4. Where it does not apply, or only by a stretch

- **No metric, no sector condition.** The persistence thresholds need an error measured as a distance and a correction meeting a sector condition. Nothing shows a corpus's distance from truth has either, so the numbers do not transfer. Only the shapes do: a threshold, two levers, a window.
- **Endogenous disturbance is excluded.** The central inequality assumes the disturbance does not grow with correction effort. Its Claim Record puts such agents outside. In a corpus the correctors inject much of the error. Nothing in ASF treats a disturbance generated by the corrector's own fluency. The gain window and `der-resource-bounded-destabilization` (exploratory, off-spine, not read) are the nearest neighbors.
- **Computation is out of scope.** By `scope-adaptive-system`, the correctness of derivations is computation, outside Part I.
- **Nothing is instantiated outside built systems.** asf's own objective E, "One quantity is measured on an agent the theory did not construct", has two of its three key results marked "not started". The third ran, and INTENT records that it "tests nothing `#der-change-expectation-baseline` states".
- **Several results I lean on are scoped narrower than my use.**
  - The turnover recursion is one agent's predictive information.
  - The allocation ceiling excludes outcome-dependent allocation.
  - The solicitable-escape hypothesis disclaims comprehension between agents.
- **There is no first-class theory of finite attention.** The spike `spikes/spike-attention-governance.md` (2026-03, exploratory; I read its opening only) says AAT "says nothing about finite channel capacity". Later segments supply pieces: the allocation ceiling, the context budget, the capacity triple. Nothing unifies them.
- **Population dynamics are open.** The Part III gaps on latent structural diversity, endogenous coupling and composition transitions are open, and are where "many minds over time" would formally live.
- **The steward as accountable principal.** ASF has principal-side material: `disc-value-functional-grounding-floor` (that objective-grounding must sit off the agent's own objective substrate), the reward-channel no-go, and self-actuation grounding. I read it only in outline rows. It may bear on "one person accountable"; I can't say how.
- **Open defects in what I cite.**
  - `der-tempo-composition` has two inconsistent persistence conditions.
  - `der-observability-dominance` has an investment tradeoff possibly wrong-signed, and an unscoped "cannot recognize".
  - `deriv-tempo-additivity`, `hyp-solicitable-escape` and the code-quality chain have no recorded independent check.

## 5. Precedents and context you may want

- **The archived file** (`.archive/prior-incarnation/theory/influx/segment-research/asf-implications-2026-08-14.md`, read whole). It asks how ASF's labeling fields should change given the verisectorium model of that time, not what ASF's theory says about corpus dynamics, so it does not answer your question. It carries its own premature-synthesis marker ("withhold from any de-novo synthesis pass"). I don't think it primed anything here.
- **asf's system review** (`msc/inside-out-2026-10/system-review/00-system.md` §2, read whole). It applies Part I to asf's own maintenance: "a correction that no event fires has rate zero against a drift that never stops; by Part I's own inequality the mismatch leaves every bounded region." This is correct and nearly immediate. Its larger value for you is the measured history: checks that nothing fires decayed at the session cadence; the memory was "keyed by where things came from, not by what they say"; there were seven self-reviews, each adding record. It is a case study of your system.
- **`disc-framework-self-diagnostic`** (03, discussion-grade, read whole). It claims the theory applies "recursively to agents building it", with three cases from one cycle. It asks itself whether there are negative cases.
- **Open ledger items in asf close to your question.** (`vsect open segment:der-observability-dominance` shows them.)
  - *"Self-silencing floors across volumes"*: results where the repair term vanishes at the failure state, so every escape is exogenous. The turnover recursion's adversarial edge and the solicitable escape are both instances.
  - *Joseph's "confidence and warrant diverge, and the divergence is produced by success"*, with an unfinished thought about its rate.
  - A scout's unchecked guess at that rate: on classes where correction has gone to zero, the shortfall grows at the drift rate.

## 6. What I read

**Whole**

- *01-aat-core:* `scope-adaptive-system`, `result-persistence-condition`, `def-adaptive-tempo`, `deriv-evidence-allocation-ceiling`, `der-observability-dominance`, `hyp-solicitable-escape`, `deriv-tempo-additivity`, `hyp-communication-gain`, `def-shared-intent`, `hyp-auftragstaktik-principle`, `hyp-truth-serving-loophole`, `scope-composite-agent`, `der-team-persistence`, `der-tempo-composition`, `form-consolidation-dynamics`, `result-structural-adaptation-necessity`, `der-temporal-nesting`, `def-chronica`, `scope-agent-identity`.
- *03-llm-core:* `der-turnover-information-recursion`, `obs-context-turnover`, `disc-m-preservation`, `disc-deferred-observation-processing`, `hyp-behavioral-self-knowledge-insufficiency`, `disc-framework-self-diagnostic`.
- *02-tst-core:* `def-comprehension-time`, `der-code-quality-as-observation-infrastructure`, `impl-developer-agent`, `der-dual-optimization`.
- *Other:* the 01 and 02 `OUTLINE.md`, asf `CLAUDE.md` (the agents SOP), the system review `00-system.md`, and the archived verisectorium file.

The Working Notes and audit-gold sections of these segments were read too, but I have kept their contents out of "In canon" except where flagged.

**In part**

- `der-directed-separation`: its opening, scope condition, (NWI) and the three clauses, about 70 of 323 lines.
- `def-mismatch-signal`: 60 of 108 lines.
- `obs-software-epistemic-properties`: P1–P5, 60 of 139 lines.
- `der-causal-insufficiency-detection`: its opening, 30 of 303 lines. Its no-go is that latent common causes cannot be detected on-policy; I did not use it above.
- `INTENT.md`: by grep, objective I and E lines only.
- `03-llm-core/OUTLINE.md`: grep for turnover rows.
- The two attention spikes: openings only.
- `vsect` check and open-item records for eleven segments.

**Not at all, though possibly relevant**

- *01 segments:* `emp-update-gain` (known only through quotations), `deriv-persistence-cost`, `der-multi-timescale-stability`, `disc-composition-consistency`, `form-composition-closure`, `der-class-coercion-via-wrapping`, `disc-modularity-state-dynamics` (the truthification operation), `der-deliberation-cost`, `def-strategic-tempo`, `def-unity-dimensions`.
- *Principal-side segments:* `disc-value-functional-grounding-floor`, `deriv-self-actuation-grounding`, `deriv-reward-channel-learning-no-go`.
- *Other volumes:* the 04 identity volume (`der-identity-continuity-threshold`, which the turnover segment says is the distinct operator for identity), the rest of TST, all spikes, audits and reviews, and CHANGELOG.

## 7. Feedback on the brief

The brief worked well for me. Three things helped most:

- the honest "I haven't read it";
- the request to keep canon and extension apart;
- naming the prior file without vouching for it.

One thing I'd add for a future brief of this kind: a pointer to where the estate records independent checks (here `vsect why/open`). In asf the status words are typed, and the check record changed how I'd weigh several results. The plainest example is the allocation ceiling: exact by its typed status, while its confirming checks have lapsed.

I'm willing to stay available for follow-up. The most useful next reads, if you want them: `emp-update-gain` and `deriv-persistence-cost` (to firm up §2.5 and the cost of keeping a corpus true), and `disc-composition-consistency` with `form-composition-closure` (to check whether the two-level reading in §1 is what the theory actually licenses).
