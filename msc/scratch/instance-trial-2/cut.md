# The segment, cut

*`~/src/arch/asf/02-tst-core/src/der-change-expectation-baseline.md` at asf HEAD `68f68644` (vsect `v:16e38e57`, the text landed by `bbd5f3c9`, 2026-10-30 21:03 −0600), cut under `ontology.md`. I read the file whole, and its six earlier versions on 10-30 as word-diffs. The ids are mine, minted for this exercise; nothing in asf names any of these pieces. The cut is one mind's and has not been checked by another.*

Frontmatter, which is not content: the name `der-change-expectation-baseline`; kind `derived`; `status: exact` and `stage: draft`, typed; one reference, `depends: scope-evolving-software`, from the whole segment to a whole segment.

Sixty-five veritoids in the segment and six notes in its inbox.

## headline (the paragraph under the title)

| id | kind | says | references, as relied on |
|---|---|---|---|
| h1 | explanation | absent specific information about a software system's future, the uninformed median baseline for remaining feature count equals the past count | restates c3 |
| h2 | explanation | not a heuristic: follows exactly, at every age, from knowing no time scale for the system in front of you, and at large age from an unknown constant hazard whose prior density at zero is finite and positive; both give the same $1/t$ tail | restates c1, c2, a1, z4, z7 |
| h3 | claim | under proper informative priors with finite first moment the expected count is the prediction; the uninformed baseline gives a median (Pareto(1) has undefined mean) | second half restates e10; **the first half is stated nowhere else and derived nowhere** |
| h4 | explanation | the baseline preserves accountability: a deviation needs information that justifies it | narrates c3, b2 |

## formal·expression

### Unit U1, tag *[Derived (change-expectation-baseline, from scale ignorance)]*

| id | kind | says | references |
|---|---|---|---|
| o1 | premise | found in progress at age $t_0$; given its lifetime, equally likely at any age: $p(t_0 \mid T) = 1/T$ | |
| o2 | claim | that likelihood holds under per-system sampling and under being met alive with a constant birth rate | predicated-on w4 ("next subsection") |
| a1 | premise | no time scale is known for the lifetime of the system in front of you | |
| a2 | choice | Jeffreys' prior, the scale-invariant prior for a positive scale parameter, is placed on that lifetime: $\pi(T) \propto 1/T$ | holds an import with no citation (Jeffreys); alternative weighed: w6 |
| c1 | claim | Bayes' rule gives $\pi(T \mid t_0) = t_0/T^2$ and $P(T \gt t_0 + u \mid t_0) = t_0/(t_0+u)$ | assumes o1, a2 |
| c2 | claim | Pareto with shape 1, at every age; median remaining lifetime equals current age | predicated-on c1 |
| u1 | premise | features arrive at an approximately uniform rate (a phrase here; spelled out in e13) | |
| c3 | claim | $\hat n_{\text{future}} = n_{\text{past}}$, a median prediction. Sub-tag *[Derived (Conditional on uniform feature rate)]* | predicated-on c2; assumes u1; assumes the scope predicate of `scope-evolving-software`; uses-term $n_{\text{future}}$, feature (unwritten) |

c1's statement and its one-line derivation are one display equation.

### Unit U2, "Whose lifetime the prior is about", tag *[Derived (conditional on a constant birth rate)]*

| id | kind | says | references |
|---|---|---|---|
| w0 | explanation | a system met because it is alive now is not a typical system | |
| b1 | premise | $w$ the lifetime density over all systems, $Q$ its survival function; systems begin at a constant rate $r$ | |
| w1 | claim | expected number alive with age in $dt_0$ and lifetime in $dT$ is $r\,w(T)\,dT\,dt_0$ for $T \ge t_0$, finite whatever the mean lifetime | assumes b1 |
| w2 | claim | found at age $t_0$, the lifetime has density $w(T)/Q(t_0)$; about $w$, survival is the whole observation | predicated-on w1 |
| w3 | claim | any $w$ with $Q \sim c/t$ gives $P \to t_0/(t_0+u)$ and median remaining $\sim t_0$ at large age | predicated-on w2 |
| w4 | claim | the lifetime of a system found in progress has density $\propto T\,w(T)$, and its age is uniform given its lifetime | predicated-on w1; "which is the likelihood above" (o1) |
| w5 | claim | Jeffreys' prior on the system in progress is $w \propto T^{-2}$, $Q = 1/t$ exactly, and item 1 gives $t_0/T^2$ at every age | predicated-on w4, w2; assumes a2; restates c1 |
| i1 | import | the same $w$ follows from invariance under rescaling past and future together | cites Caves 2000, Eqs. 31–32 |
| w6 | claim | Jeffreys' prior placed on $w$ instead leaves, conditioned on survival, a density $\propto 1/T$ that does not normalize | predicated-on w2 |
| w7 | explanation | scale ignorance gives the baseline when it concerns the system in front of you | narrates w5, w6 |
| w8 | claim | both $\pi \propto 1/T$ and $w \propto T^{-2}$ are improper near zero; the posterior is proper | |

### Unit U3, "A proper prior with the same tail", tag *[Derived (change-expectation-baseline, hazard-mixture form)]*

| id | kind | says | references |
|---|---|---|---|
| k1 | premise | a constant termination hazard $k$, lifetime exponential given $k$; $k$ unknown with prior density $f$ | |
| z1 | claim | the survival function is the Laplace transform of the prior | assumes k1 |
| z2 | claim | if $f \sim c\,k^{a-1}$ at $0^+$ then $S(t) \sim c\,\Gamma(a)\,t^{-a}$ | predicated-on z1 and an import with no citation (Watson's lemma) |
| z3 | claim | at large age $P(T \gt t_0+u \mid T \gt t_0) \to (t_0/(t_0+u))^a$, median remaining $\sim (2^{1/a}-1)\,t_0$ | predicated-on z2. **It conditions on survival alone and names no observation premise** |
| z4 | claim | $a = 1$ is $0 \lt f(0) \lt \infty$; every such prior gives $S \sim f(0)/t$, "the tail of item 1 above", and median remaining equal to age asymptotically | predicated-on z2, z3, w3 |
| z5 | claim | the exponential prior gives it at every age: $S = b/(b+t)$, median remaining exactly $t_0 + b$ | predicated-on z1 |
| z6 | claim | $a \gt 1$ a shorter future, $a \lt 1$ a longer one; a lognormal, slower than age | predicated-on z3 |
| z7 | claim | so $\hat n_{\text{future}} = n_{\text{past}}$ "also follows from a proper prior and an ignorance assumption that can be checked" | predicated-on z4; assumes u1, k1 |
| z8 | explanation | the exponent $a$ is the one thing an informed analyst needs to move the multiplier | narrates z3 |
| i3 | import | the qualitative mechanism is Ord's | cites Ord 2023 |
| n1 | priority·claim | the asymptotic form and the dependence on $a$ are stated here | |

### Unit U4, tag *[Derived (change-expectation-baseline)]*

| id | kind | says | references |
|---|---|---|---|
| b2 | claim | with further information $I$ the baseline is the prior in Bayes' rule | predicated-on c3 |
| x1 | explanation | rarely used directly; it creates accountability | narrates b2 |

## epistemic·status

| id | kind | says | references |
|---|---|---|---|
| e1 | explanation | the scale-ignorance derivation is exact at every age, given its premise | restates c1, c2, a1 |
| e2 | explanation | its prior is improper and its posterior proper | restates w8 |
| e3 | import and non·claim | whether the premise fits is judged case by case; a system with an evident time scale is not scale-free and the baseline does not apply | cites Caves 2000 |
| e4 | explanation | that the ignorance concerns the system in front of them is this segment's reading, not derived | restates a2's standing as a choice |
| e5 | explanation | the reading as $w \propto T^{-2}$ is exact given a constant birth rate | restates w5, b1 |
| e6 | explanation | the hazard-mixture form is a proper prior with the same tail; exact asymptotically, and at every age for the exponential prior | restates z2 to z5 |
| e7 | numeric·report | numerical integration agrees with the limits to three decimals for five priors by age $10^3$ to $10^4$ | run-of: nothing written |
| e8 | non·claim | predictive; no normative content about investment | |
| e9 | explanation | the investment-scaling consequence needs a decision model and is derived in `#der-change-investment` | narrates der-change-investment (a dependent) |
| e10 | claim | for Pareto(1) the mean is undefined; the result is a median; this matters through nonlinear functions | predicated-on c2 |
| e11 | account | TST's original statement used "expected" loosely | |
| e12 | explanation | downstream claims that use $n_{\text{future}}$ are to be read as using the median | narrates der-change-investment, der-dual-optimization |
| e13 | explanation | the derivation gives lifetime, not feature count; the mapping needs a uniform rate, and is biased otherwise | restates u1 |
| e14 | explanation | the assumption should be stated wherever the result is applied | a condition on those who reference c3 |
| e15 | non·claim | Laplace's succession formula comes from a different model | holds an import with no citation |

## discussion

| id | kind | says | references |
|---|---|---|---|
| d1 | explanation | intellectual accountability: without an answer the abstraction is premature, "mathematically, not aesthetically" | narrates c3 |
| d2 | explanation | domain knowledge as a Bayesian update, five examples | narrates b2; `#scope-evolving-software`'s stable-subsystem regime |
| d3 | explanation | each is an observation updating $M_t$; the gain depends on the source's reliability | narrates `#emp-update-gain`; uses-term $M_t$, $\eta^\ast$ (unwritten) |
| d4 | explanation | investment scaling, tagged *[Discussion]*; the $n_{\text{past}} \lesssim 3$ rule is "heuristic-grade" | narrates der-change-investment |
| l1 | import | Gott 1993 reasoned from a uniform age fraction without a prior | cites Gott 1993 |
| l2 | import | the Bayesian form was put forward by Buch and endorsed by Gott | cites Buch 1994, Gott 1994 |
| l3 | import | Caves read that prior as the density over all phenomena, showed what a time-translation-invariant observation yields, and found $w_g = 1/T^2$ | cites Caves 2000 |
| l4 | import | Caves showed $w_g$ has the scale-free status for a phenomenon in progress, and cautioned case by case | cites Caves 2000 |
| l5 | explanation | read as the prior on the system in progress, Jeffreys' prior is that same assumption, "which is how this segment states it" | restates a2, e4 |
| l6 | explanation | the hazard-mixture prior is a proper prior with the same tail | restates z4 |
| l7 | import | Ord surveys the mechanisms, including this one | cites Ord 2023 |
| l8 | explanation | the Lindy effect names the empirical regularity | |
| n2 | priority·claim | what this segment adds is its use as the default predictor for feature count and the requirement that departures be justified | |
| d6 | explanation | connection to AAT: the maximum-ignorance prediction is that $\rho$ continues at about its observed rate | uses-term $M_t$, $\rho$ (unwritten) |

## The inbox (Working Notes)

| id | what it is | recorded disposition |
|---|---|---|
| g1 | discrete-form and tooling-optimum seeds, with pointers to two spike directories; carries a fate marker "(F2 disposition, 2026-07-16)" | delete |
| g2 | the median against expectation "should be propagated carefully"; adds that the baseline underestimates the case for investment | delete |
| g3 | the uniform-rate assumption is the weakest link; a refinement, open | delete; its substance went to `item:tst-cheap-falsifiers-and-measurement-design` |
| g4 | velocity inflection, unformalized | delete; likewise |
| g5 | the former C-04.1 corollary is not to be re-promoted without deriving the threshold | keep, as a regression guard |
| g6 | "I've folded" the C-04.2 corollary into the exposition | delete |

The dispositions are in `item:wn-02-04-keep-list-after-drain` (owner I.5, open): routing decisions for all six, recorded as one sentence of an item's prose, not yet carried out in the file.

## What the file writes, against what the pieces rely on

| | written today | relied on |
|---|---|---|
| across segments, declared | 1 (`depends:` to one whole segment) | c3 and h1 on the scope's predicate; nothing else in the segment reads it |
| across segments, in prose | 6 `#slug` sites, to four segments | plus the definitions of feature, $n_{\text{future}}$, $M_t$, $\rho$, $\eta^\ast$: unwritten |
| within the segment | 7 prose pointers ("item 1 above", "next subsection", "the likelihood above", "derived above", …) | about 60, a third of them restates from the summary and Epistemic Status to the Formal Expression, none of those written |
| to outside works | author-year prose at 8 sites for five works | plus Watson's lemma, Jeffreys' prior and Laplace's formula, with no citation |
| inbound, declared | 3 segments `depends:` on this one | all three rely on c3; two restate e10 and u1 as inherited assumptions; one restates z7 |
| inbound, in prose only | 5 more segments name it | c3 (three of them), u1 (two); one calls $\hat n_{\text{future}}$ "the expected number of future changes" |

Addressing in the record is by quotation. No act names a piece; each criterion quotes or paraphrases the sentences it is about ("the summary paraphrase (…)", "item 1's $w(T)/Q(t_0)$", "the Epistemic Status's '[the Jeffreys derivation] does not apply …'"). The *concerns* sets in `record.md` are my mapping of those criteria onto the ids above.
