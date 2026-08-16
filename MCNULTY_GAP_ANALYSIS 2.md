# Theme comparison vs. McNulty, and the resulting plan

> ## STATUS — checked against the book, August 2026
>
> **Done (3 of 7 gaps):**
>
> - **Gap 1 — Causal inference.** Chapters 20 and 21 written and integrated.
> - **Gap 2 — Measurement error and missing data.** Chapter 18 written and integrated.
> - **Gap 4 — Study design / sample size.** Inside Ch. 21, as agreed.
>
> **Partly done:**
>
> - **Gap 5 — Survival.** Cox *is* covered (Ch. 16 has "A different lens:
>   how this compares to a Cox model"). **Frailty is not** — no
>   hierarchical survival section, so the Ch. 8 → 14 → 15 shrinkage arc
>   still has no payoff in the survival chapter.
>
> **Not started:**
>
> - **Gap 3 — Multinomial outcomes.** Nothing in Ch. 12. The only McNulty
>   regression family with no counterpart in this book.
> - ~~**Gap 6 — Regression craft.**~~ **DONE** — written and integrated as
>   Chapter 13, with the Ch. 6 and Ch. 7 flags now in place. **All seven
>   gaps are now closed.**
> - **Gap 7 — Crossed / repeated measures.** Nothing in Ch. 12 or Ch. 8.
>
> **Related workstreams:** `drafts/CHANGE-LIST-welcome-to-ch08.md` — the
> renumbering is done, items 1 and 11 are done, the other ~17 are not,
> including both marked *must*. `drafts/CALLOUT-DENSITY-PROPOSALS.md` —
> only section F (colours) applied; A, B and C untouched.
> `drafts/PLAIN-ENGLISH-PROPOSALS.md` — fully applied.
> `drafts/index-mcnulty-section.md` and `index-reading-design.md` — the
> reading design is applied; the McNulty credit is drafted but the TODO at
> `index.qmd:230` is still there.


**Purpose:** identify People Analytics themes McNulty's *Handbook of Regression Modeling in People Analytics* (2nd ed., 2026) covers that this book leaves on the table, and record what we've decided to do about each.

**Basis of comparison:** McNulty's live 2nd-edition text at <https://peopleanalytics-regression-book.org/> (16 chapters, last updated 2 July 2026), read at chapter and section-heading level, against this repo's `_quarto.yml`, `BOOK_PLAN.md`, `index.qmd` and all 19 chapter files.

---

## 1. Where the two books already agree

Every classical regression family McNulty treats has a Bayesian counterpart here:

| McNulty | This book |
|---|---|
| 3 Statistics Foundations | 1–3 (Foundations) |
| 4 Linear Regression | 6 Bayesian Regression |
| 5 Binomial Logistic Regression | 9 Logistic Regression |
| 7 Proportional Odds Logistic Regression | 17 Likert & Survey Data |
| 8 Poisson / Quasi-Poisson / Negative Binomial | 12 Richer Models (Part 2) |
| 9.1 Mixed models for explicit hierarchy | 8 Multilevel, 14 Shrinkage, 15 Pay & Variance |
| 10 Survival Analysis | 16 Survival Analysis |
| 12 Bayesian Inference | 4–5 |
| 13 Bayesian Linear Regression (MCMC) | 6, 11 |
| 14 Fitting Other Models Bayesianly | 9, 12, 16, 17 |

This book goes further than McNulty in four places he doesn't cover at all: Empirical Bayes (13), shrinkage as a *presentation and fairness* problem (14), variance decomposition as a finding in its own right (15), and formal prior elicitation (19). Worth stating in the front matter.

---

## 2. Gaps and decisions

### Gap 1 — Causal inference → **two new chapters**

**Status:** entirely absent. Zero hits across all 19 chapters for *confound*, *DAG*, *counterfactual*, *propensity*, *instrument*, *difference-in-difference*.

The seed is already planted. Chapter 6 currently says:

> "…the slope describes an association between rating and sales among current salespeople. Treating it as what would happen if you intervened to raise ratings is a causal claim the data alone doesn't support."

That sentence is the opening of the causal chapter: what *would* it take to earn the intervention claim?

Two chapters were chosen over one, playing to the personnel-economics tradition rather than reproducing McElreath:

**Chapter A — Causal structure: drawing the graph.** DAGs as the language for stating causal beliefs. Confounders, colliders, mediators. Paths and the backdoor criterion at a practitioner level. The control-variable trap — why "adjust for everything you have" is wrong, and why a collider is worse than an omitted confounder. Tooling: `ggdag` / `dagitty`.

**Chapter B — Causal designs: finding variation you didn't create.** Difference-in-differences as the workhorse, plus event studies, and a lighter treatment of IV and RDD. PA settings are concrete and under-served in the literature: RTO mandates, comp policy changes, staggered rollout of manager training, benefits changes, office closures. **Simulation-based design analysis lives here** — simulate the study, fit the model you'd fit, read the posterior width you'd get. Same machinery as Ch. 5's prior predictive checks, so it lands as a callback rather than new apparatus, and it answers "is this pilot worth running?" better than Cohen's rules of thumb.

**The elicitation link.** A DAG is an elicited object. Chapter A and Chapter 19 are the same move — get the stakeholder's beliefs on paper *before* modelling — one producing an identification strategy, the other producing priors. Neither McElreath nor McNulty frames it this way for a PA audience. Ch. 19 should be extended with a DAG-elicitation section so Part V closes on elicitation as the process that generates both.

**Knock-on:** Ch. 15's disclaimer ("this is not, on its own, a pay equity audit") can be softened to a forward reference once the adjustment-set logic exists in the book.

---

### Gap 2 — Measurement error and missing data → **one new chapter**

**Status:** absent. No hits for *factor analys*, *structural equation*, *cronbach*; *latent* appears once.

Deliberately broader than McNulty's latent-variable treatment. The unifying idea is McElreath's: **measurement error and missing data are the same problem** — you don't observe the variable exactly, so put a model on it. That's one chapter, and it's among the most distinctively Bayesian things the book can offer.

Contents:

- **Measurement error.** Attenuation bias — econometrics-native, and the reason "engagement doesn't predict much" is sometimes an artefact. Error-in-variables models in `brms` (`me()`). PA examples where it bites hardest: engagement and pulse scores, performance ratings, 360 scores, self-reported anything, small-team aggregates.
- **Missing data.** MCAR / MAR / MNAR, and Bayesian imputation as a first-class part of the model rather than a preprocessing step. This completes Ch. 1, which currently describes missingness honestly and then offers nothing to do about it. Non-response in surveys is the obvious PA case, and it's rarely MCAR.
- **Latent variables — short closing section.** Names the psychometric tradition, shows the idea on the `employee_survey` item blocks (`Ben1-3`, `Work1-3`, `Man1-3`, `Car1-4`), and points readers at McNulty ch. 9.2 for depth. Written without overclaiming; the honest framing is that this is standard practice in psychology and rarer in econometrics, and the reader should know it exists.

**Source material:** Andrew's newsletter has already covered measurement error — worth mining for the framing and examples rather than starting cold.

**Placement:** directly after Ch. 17 (Likert/survey), which sets it up naturally — survey scores are the clearest case of a number everyone treats as exact.

---

### Gap 3 — Multinomial / nominal outcomes → **adapt Ch. 12**

Binary is covered (Ch. 9), ordered categories are covered (Ch. 17), unordered categories are not. PA uses: reason-for-leaving codes, benefits election, next-move type (promotion / lateral / exit / stay), offer-decline reasons.

Add as **Part 3 of Ch. 12 "Richer Models"** — that chapter is already a pair of extensions, so a third is architecturally free. `brms::categorical()` is a one-line change from the Ch. 9 skeleton, which suits the "diff successive models" rule in `BOOK_PLAN.md` §1b.

---

### Gap 4 — Study design and sample size → **folded into causal Chapter B**

Covered above. Note the shift in the book's stance: the original design used found data partly *because* sample-size planning was out of scope. Once experiments and quasi-experiments are in, that constraint lifts, and simulation-based design becomes the natural default rather than a classical-power substitute.

---

### Gap 5 — Cox proportional hazards and frailty → **extend Ch. 16**

Ch. 16 does Kaplan-Meier plus a Bayesian parametric model. Two additions:

- A "different lens" callout on **Cox / semi-parametric vs. parametric** — Cox is what readers will meet in other people's decks, so not naming it leaves a translation gap.
- A **frailty** section. Frailty models *are* hierarchical survival models — hazard varying by manager, office or function — which is exactly what the Ch. 8 → 13 → 14 → 15 shrinkage arc has been building toward. "Which managers lose people faster than their team composition explains" is a flagship-quality question and the book is 90% of the way to it already. `turnover` has `industry` and `profession` as ready-made grouping variables.

---

### Gap 6 — Regression craft → **distributed across revision passes**

No hits for *collinear*; *interaction* appears in one chapter; no polynomial or spline terms anywhere. Diagnostics coverage is strong where it's Bayesian-specific (posterior predictive checks, R-hat, ESS, LOO) and absent where it's model-specification craft.

Handled during revision passes rather than as a chapter:

- **Interactions** → Ch. 7, where the first categorical × continuous model already appears.
- **Non-linearity** (tenure effects on attrition are the canonical PA case) → Ch. 6 or Ch. 12.
- **Correlated predictors** → in a Bayesian setting this is a *prior* conversation, not a VIF conversation, which makes it interesting rather than remedial.

The "this is as much art as science" argument gets made in the places it bites rather than in one essay. Cross-reference the causal chapters throughout: *which* variables go in the model is a causal question, not a statistical one, and the craft sections should say so rather than implying it's a matter of taste.

---

### Gap 7 — Crossed and repeated-measures structure → **adapt Ch. 8 or Ch. 12**

Ch. 8, 14 and 15 all use a single grouping factor. Repeated observations per person — participant × programme, employee × pulse wave, ratee × rater — aren't shown. Rising PA relevance: pulse surveys, 360 feedback, multi-rater assessment. `(1|participant) + (1|programme)` is a small step from Ch. 8, and the `learning` dataset in `peopleanalyticsdata` is purpose-built for it.

---

## 3. Deliberate non-gaps

- **Bayes Factors** — decided, documented in `BOOK_PLAN.md` §1a, implemented in Ch. 5 / 7 / 18.
- **Python** — McNulty is dual-language; this book is R-only. Worth one line in `index.qmd` for readers arriving from his book.
- **R primer** — explicitly ruled out by the house style.
- **Formal mathematical exposition** — his house style, deliberately not ours.
- **Predictive / ML modelling** — neither book does it.

---

## 4. Resulting structure

19 → 22 chapters. Proposed Part V ordering:

| # | Chapter | Status |
|---|---|---|
| 13 | Empirical Bayes | existing |
| 14 | Bayesian Shrinkage: ranking managers fairly | existing |
| 15 | Hierarchical models for pay and variance | existing (disclaimer softened) |
| 16 | Survival analysis | existing + Cox lens, + frailty |
| 17 | Likert and survey data | existing |
| **18** | **Measurement error and missing data** | **new** |
| 19 | Bayesian A/B testing for people experiments | existing (was 18) |
| **20** | **Causal structure: drawing the graph** | **new** |
| **21** | **Causal designs: DiD, event studies, IV** (+ simulation-based design) | **new** |
| 22 | The elicitation workflow | existing (was 19) + DAG elicitation |

The A/B → DAGs → designs ordering gives Part V an escalating arc: *randomise if you can → if you can't, draw the graph → then find variation you didn't create.* Elicitation still closes, and now closes on both priors and DAGs.

Also worth adding regardless: McNulty ch. 1.2 opens by distinguishing **prediction vs. inference vs. causation** as three different modelling goals. `index.qmd` explains *why Bayesian* but never sets out *what a model is for*. It's a paragraph, and it gives the causal chapters somewhere to land.

---

*Sources: <https://peopleanalytics-regression-book.org/> (2nd edition, accessed 11 August 2026); this repository's `_quarto.yml`, `BOOK_PLAN.md`, `index.qmd`, `chapters/01–19`.*
