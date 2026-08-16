# Bayesian People Analytics — Book Plan (v1)

**Working title:** *Bayesian Thinking for People Analytics*
**Format:** Quarto book → rendered to static HTML → published on GitHub Pages
**Audience:** People Analytics practitioners (not academic statisticians) — HRBPs-turned-analysts, PA team members, People Analytics leaders who want to go beyond descriptive dashboards
**Language/tooling:** R, `tidyverse`, `rstanarm` (fast hierarchical/shrinkage models) + `brms` (ordinal, survival, more flexible specifications), `tidybayes`, `bayesplot`, `skimr` (data summaries in Ch. 1)
**Source material:** adapted from Andrew Marritt's *Bayesian Statistics for Hospitality Research* course (11 sessions: `slides/`, `workbook/`, `homework/` in the parent project folder)

---

## 1. What changes going from course → book

The original is a **live-taught course**: revealjs slides + a workbook + a separately-submitted weekly homework file, aimed at MBA hospitality students building thesis confidence. A book has a different job — a practitioner reads it alone, dips in and out by topic, and never submits homework. Concretely:

- **One file per chapter**, not three. Each chapter folds the workbook's narrative + code with the best of the slide framing and turns "Your turn" prompts into inline **Try it yourself** boxes (with a collapsed hint/solution). No separate slides or homework files.
- **"Thesis connection" → "On the job"**. Every chapter keeps the callout box that lands the technique in a real decision, but reframed from *what your examiner wants to see* to *what your VP of People / a business stakeholder wants to see*.
- **New running datasets.** The hospitality `bookings` / `guest_satisfaction` pair is replaced by real People Analytics data (below) — chosen so the same "two spines" structure (a yes/no outcome + a survey/Likert outcome) still works.
- **New Part V.** Seven new chapters cover the topics Andrew wants front and centre for this audience: Empirical Bayes, Bayesian shrinkage for manager comparisons, hierarchical pay/variance models, survival analysis, Likert/survey analysis, Bayesian A/B testing, and a closing chapter on the elicitation workflow.
- **Same visual identity, re-branded.** The navy/coral "AcademicDesign" theme carries over (it's generic, not hospitality-specific) with the "Bayesian Statistics for Hospitality Research" subtitle removed.

---

## 1a. Voice, tone, and house-style callouts

**Not a textbook.** Confirmed after comparing against Keith McNulty's book directly: his is a formal, numbered, first-principles handbook aimed at readers who'll sit with it like a course text. This book stays a friendly, workshop-style read — short paragraphs, callouts doing the emphasis work, intuition and a plot before the formula, "on the job" rather than "learning exercises" at the close of each chapter. Andrew teaches complete beginners with this material and expects to revise chapters over time as related newsletter articles are published, so each chapter should stand on its own well enough to be edited in isolation later. References to papers/other books are welcome where they genuinely help (as with the McNulty cross-references), but the prose itself should never read like a citation-dense literature review.

**One colour per role.** Quarto offers five callout types; the book uses all five, each tied to exactly one job, so a reader can tell what a box is for before reading a word of it. Defined in `theme/academicdesign-doc.scss`.

| Role | Type | Accent |
|---|---|---|
| **The point** — read this if nothing else | `callout-important` | coral-red `#d32f2f` |
| **A different lens** — frequentist translation | `callout-note` | navy `#122a52` |
| **For the ML/DS crowd** | `callout-tip` | teal `#1a6b5f` |
| **Try it yourself** — the end-of-chapter exercise | `callout-caution` | amber `#8a5a00` |
| **When you can skip this** — proportionality | `callout-warning` | slate grey `#5b6470` |

Plain asides with no header stay `callout-note`; the absence of a title bar separates them from "A different lens". Quarto's warning-triangle icon is hidden for `caution` and `warning` in the SCSS, because it is wrong on an exercise and misleading on permission to do less. **Do not add a sixth role** — five box colours alongside the three-colour chart palette is the ceiling of what a reader will learn.

**A callout is for something the reader can skip without losing the thread**: a definition, an aside, a translation for a particular background, an exercise, or one sentence of emphasis. If a box is carrying an argument the chapter depends on, it is body text with a heading. As a rough size guide, an `important` over about 60 words is probably an argument that has been boxed for emphasis, and boxing stops working at that length.

Four recurring callout types, used **where genuinely relevant, not in every chapter**:

- **`::: callout-note` — "A different lens" (frequentist comparison).** Most of this book's readers come from a frequentist background (t-tests, p-values, confidence intervals, `lm()`/`glm()`), so at the point a Bayesian technique has a well-known classical analog, a short box names it and explains the *mental model* shift — never "frequentist = wrong." E.g. Ch. 8/13's partial pooling ↔ `lme4::lmer()` random effects and BLUPs; Ch. 12's empirical Bayes ↔ the James-Stein estimator (Stein's paradox); Ch. 17's Beta-Binomial A/B test ↔ the chi-square/proportions test it would replace.
- **Bayes Factors — a single well-developed note, not scattered everywhere.** McNulty's book has a full Bayesian-hypothesis-testing arc built on Bayes Factors (Bayesian t-test, correlation test, chi-square test); this book deliberately favours estimation (posteriors + credible intervals, and LOO for model comparison) over Bayes Factor hypothesis testing. The core explanation of *why*, with the honest trade-offs of each approach, belongs in **Chapter 5** (right where credible intervals are introduced as this book's primary reporting tool) with a shorter callback in **Chapter 7** (group comparison — where a reader would otherwise reach for a significance test) and **Chapter 18** (A/B testing — same instinct, sharpest business framing).
- **`::: callout-tip` — "For the ML/DS crowd."** Some readers arrive strong on ML, light on formal stats. Short boxes connect the technique to something they already know: empirical Bayes/shrinkage ↔ regularisation (L1/L2 priors, hyperparameter tuning as prior-strength selection); multilevel models ↔ mixed-effects models and shrinkage in recommender systems; Bayesian A/B testing ↔ Thompson sampling / multi-armed bandits; naive Bayes classifiers as a *related-but-different* namesake worth disambiguating; MCMC (Ch. 10) ↔ why this isn't gradient descent even though both are iterative.

Both new chapters written so far (12, 13) have been retrofitted with at least one instance of the frequentist-lens and ML/DS callouts as the reference implementation — see those files for the exact tone/format to replicate.

---

## 1b. Code style and how code gets explained

**These are binding house rules, applied during each chapter's first revision pass.** If a request would break one of them, say so and explain the conflict before complying — don't silently comply. They are not immovable, but they should be changed deliberately here rather than eroded chapter by chapter.

### The governing principle

The tidyverse style guide's rule is *"use comments to explain the why, not the what."* Paired with a stronger claim: if a comment is needed to explain *what* code does, rewrite the code instead. That's right for production code, and incomplete here — because it assumes the reader's difficulty is the code. In this book it usually isn't.

`prior(exponential(0.005), class = sigma)` is flawless R with nothing to rewrite, and three things about it are opaque: why exponential, what 0.005 means, and how you'd choose it for your own data. None of them are R questions. So the rule for this book inverts in one specific place:

> **Comment density tracks statistical novelty, not R novelty.**

Never `# fit the model` above a `brm()` call. But `# rate = 1/expected spread` earns its place — and earns it for a reader with fifteen years of R as much as for a beginner.

This also dissolves the apparent two-audiences problem. Experienced R programmers and complete beginners need the *same* explanations here (why this prior, why this family, what this diagnostic means) and are equally unserved by explanations of what `mutate()` does. There is one audience with one shared gap. This is not an R primer and should never drift into becoming one.

### Three channels, three jobs

Quarto is literate programming, so comments are only one of the available surfaces. Each carries a different load:

1. **Prose above the chunk — the *why*.** Concept, motivation, the decision being made. Read by everyone, including someone skimming without R open. The bulk of explanation lives here; this is already the book's instinct and it's the correct one.
2. **The code itself — the *what*.** Carried by names, one pipeline step per line, and named arguments. If the code needs a comment to say what it does, rewrite it.
3. **Inline comments — the residue.** Only what neither channel can carry at the point of reading: a parameter encoding a judgment call, or a "you'd change this in your own work" flag.

### Specific rules

1. **Concept and motivation go in prose above the chunk**, never in comments.
2. **Name every distribution parameter**: `rate =`, `mean =`, `sd =`, `.width =`. Free documentation, and it settles genuine ambiguities — is the exponential parameterised by rate or scale? Positional arguments make the reader guess.
3. **Inline comments explain statistics, never R.** A comment that restates the R gets deleted.
4. **Quarto code annotations for the classroom voiceover.** Numbered `# <1>` markers with an ordered list below the chunk (`code-annotations: below` is set in `_quarto.yml`). Use on the *first appearance of each new pattern* — the first `brm()`, the first `spread_draws()`, the first prior predictive simulation — then plain chunks thereafter. Once a pattern recurs, the absence of annotation is itself the signal that nothing new is happening. Sparing use is what keeps them meaningful, and an experienced reader's eye slides past the markers at no cost.
5. **Keep the `brm()` skeleton argument-identical across every chapter** — same arguments, same order, same line breaks, so readers can *diff* successive models rather than reread them. This is the "one recipe, not a toolbox of tests" promise from the index made visible in the code, and it is worth real effort to maintain.
6. **`#| code-fold: true` for chunks that produce a figure but teach nothing new.** Plot cosmetics shouldn't compete with statistics for attention.

**Chapter 5 is the reference implementation** for this section, the way Chapters 13 and 14 are for the callout conventions in 1a.

---

## 1c. Chart house style

Also binding, also applied during each chapter's first revision pass. This book shows a distribution on nearly every page; if they don't look like a family, readers will assume the differences mean something.

### Continuous distributions

**Single distribution → light fill plus a solid outline.** The fill justifies itself (the area under a density is 1, and it reads as a *quantity of belief* rather than a line on a chart), but a heavy fill dominates the page and makes two charts hard to compare. The idiom is two layers:

```r
geom_area(fill = <colour>, alpha = 0.30) +
geom_line(colour = <colour>, linewidth = 1)
```

**Two or more distributions on shared axes → lines only**, no fill. Overlapping translucent areas turn to mud and the colours stop being readable. `geom_line(linewidth = 1)` plus `scale_colour_manual()`.

`stat_halfeye()` from `ggdist` is the exception and stays as-is — it is a deliberately different object (density *plus* interval), and looking different is the point.

### Discrete distributions

`geom_col(alpha = 0.45, width = 0.7)` — bars, never a smoothed curve. The visual break from continuous densities is doing real teaching work (you can promote 11 people or 12, never 11.5). See Chapter 4's Binomial panel.

### Semantic palette

When prior, likelihood and posterior appear in the same chapter, the colours are fixed and must not be reassigned:

| Role | Hex | Notes |
|---------------|--------------|-------------------------------------------|
| **Prior** | `#8fabd0` | Light blue — deliberately the quietest of the three |
| **Likelihood** | `#d32f2f` | Red — what the data alone says |
| **Posterior** | `#122a52` | Navy — the conclusion, and the heaviest weight on the page |

Navy `#122a52` is also the default for any standalone distribution that isn't one of the three roles (e.g. Chapter 5's posterior-only plots). `#7f9ac0` is available for de-emphasised background lines, such as the individual simulated datasets in a prior predictive check.

### Categorical groups

Comparing groups of *people* — promoted vs not, one team against another — is not the same as comparing distributions of belief, and must not borrow the semantic colours. **Red is reserved and never used for a category.** Use the theme's navy ramp instead:

**Two or three unordered groups** — take them in this order: `#122a52`, `#3d68a8`, `#8fabd0`.

**Four ordered levels** (a 1–4 performance tier, a seniority band) need a proper sequential ramp, light for low and dark for high, so the reader can rank the series without the legend:

`#9db4d4` → `#5a83b8` → `#2f5389` → `#122a52`

Do **not** extend the unordered list to four by adding `#1c3a68`: it and `#122a52` are both dark navy and are indistinguishable at line weight, while `#8fabd0` is too pale to see as a line on white. That combination was used in Chapter 9's predicted-probability chart and failed on exactly those two counts. Four shades of one hue is close to the limit; if you ever need five ordered levels, use a shape or a facet as well, not a fifth shade.

### De-emphasised greys — the contrast rule

**Never use a grey darker than `grey70` for an element that sits next to navy `#122a52`.** Raised by Andrew during the Chapter 8 review and binding from here on: `grey40` is dark enough that at small point sizes it reads as navy, and the whole point of the shrinkage-style plots is that the reader can tell "raw" from "model estimate" at a glance.

The convention for a raw-vs-model pair (Ch. 8 and Ch. 13's shrinkage plots are the reference implementations):

```r
geom_segment(..., colour = "grey80") +          # connector: context only
geom_point(aes(y = <raw>),   colour = "grey70", size = 2.5) +
geom_point(aes(y = <model>), colour = "#122a52", size = 2.5)
```

Both points at the same size, so the *colour* carries the distinction rather than colour plus weight. For a grey **fill** (a translucent ribbon, e.g. Ch. 6's prediction band) use `grey70` at `alpha = 0.35` — lighter ink, more of it, so it stays visible under the navy band without competing.

Grey used as a plain **reference line** away from navy (Ch. 9's 0/1 dotted rules, Ch. 19's elicited limits) is unaffected; `grey40` is fine there and the darker line is doing useful work.

**QA sweep still outstanding:** every remaining `grey40`/`grey50` in the chapters should be checked against this rule during each chapter's revision pass. Fixed so far: Ch. 6, Ch. 8, Ch. 13.

### Reference lines

- **Descriptive markers** — a mean or median on a histogram, a group average — use amber `#8a5a00`, with **linetype** carrying the distinction between two of them (solid vs dashed) rather than a second colour. See Chapter 1's sales histogram. Amber replaced ink-soft `#3a4048` because a soft grey is unreadable against navy bars, which is where these markers almost always sit; the same contrast argument as the grey70 rule below. Amber is already in the palette as the `callout-caution` accent, and it is deliberately *not* red — red stays reserved for a value the estimate is being argued against.
- **Critical reference values** — zero on a slope plot, an observed rate the model is being compared against, a target — use red `#d32f2f` dashed. This is the one legitimate extension of the likelihood colour: in both cases red marks *the thing the estimate is being argued against*. See Chapters 4 and 6.

### Reference implementations

Chapter 4 for the semantic trio, the Beta facet panel and the discrete Binomial; Chapter 5 for standalone densities and `stat_halfeye()`.

---

## 2. Data — the Keith McNulty `peopleanalyticsdata` package

Rather than invent synthetic People Analytics data, this book uses the **`peopleanalyticsdata`** R package, which supplies every dataset used in Keith McNulty's *Handbook of Regression Modeling in People Analytics* (2nd edition, forthcoming from Chapman & Hall/CRC Press in 2026; free to read online).

> **Credit.** All example datasets in this book (unless noted) are from the `peopleanalyticsdata` R package (MIT licence), created by **Keith McNulty** to accompany his book:
> Keith McNulty (2026). *Handbook of Regression Modeling in People Analytics: With Examples in R, Python and Julia* (2nd ed.). Chapman & Hall/CRC Press.
> Book & free online edition: <https://peopleanalytics-regression-book.org/>
> Package: <https://cran.r-project.org/package=peopleanalyticsdata> · install with `install.packages("peopleanalyticsdata")`
> The book itself is licensed CC BY-NC-SA 4.0; the package and its data are MIT licensed. We are enormously grateful to Keith for making this real-world-shaped data freely available — it's the reason this book can use scenarios People Analytics practitioners actually recognise instead of invented toy data.

This gets a proper writeup with a short overview of McNulty's book (chapter list, what it covers, how it complements this one — his book teaches the regression frameworks in depth; this book teaches the Bayesian mindset and a handful of PA-specific extensions) in `index.qmd`.

### Dataset → chapter mapping

| Dataset | Shape | Used for |
|---|---|---|
| **`salespeople`** (351 rows: `promoted`, `sales`, `customer_rate`, `performance`) | Primary running dataset | Ch. 1–9 (foundations → regression → logistic capstone). Plays the role `hotel_bookings` played: a continuous outcome (`sales`, ~ADR) and a binary outcome (`promoted`, ~cancellation). |
| **`employee_survey`** (2,833 rows, 4-pt Likert: `Happiness`, `Ben1-3`, `Work1-3`, `Man1-3`, `Car1-4`) | Survey spine | Ch. 1–3 (description), Ch. 16 (ordinal/Likert regression, dedicated chapter). Plays the role `guest_satisfaction` played. |
| **`managers`** (571 rows: `performance_group`, `test_score`, `group_size`, `city`, `concern_flag`, …) | Grouped/hierarchical companion | Ch. 8 (multilevel intro), Ch. 12 (Empirical Bayes), Ch. 13 (Bayesian shrinkage — **the flagship "ranking managers fairly" chapter**). `city` is the grouping variable; `group_size` is what makes small-team managers' raw numbers unstable — directly parallels `lakeside_chain.csv`'s varying review counts. |
| **`turnover`** (1,129 rows: `stag` [months of tenure], `event`, `traffic`, `coach`, plus `industry`/`profession`/`age`/`gender`/`greywage`/`way`/5 personality scores) — real, anonymised company data via Edward Babushkin, redistributed on Kaggle (davinwijaya/employee-turnover), CC BY-NC-SA 4.0. Not bundled — downloaded by the reader into `data/turnover.csv` (see `data/README.md`); Andrew has asked Babushkin for permission to bundle it directly. | Time-to-event | Ch. 15 (Survival analysis) — genuine join-to-departure tenure in months, right-censored for those still employed. Replaced `job_retention` (fixed 12-month observation window, not true tenure-from-hire); superseded an interim AIHR-hosted 4-column version (see `data-sources/README.md`) once Andrew located the richer original Kaggle extract. |
| **`promotion`** (1,134 rows: `promoted`, `year` [years to promotion], `diverse`, `flexible`, `store`) | Time-to-event (positive framing) + A/B | Ch. 15 (alternate/exercise: time-to-*promotion* survival model) and Ch. 17 (Bayesian A/B test: are promotion rates equal for flexible vs non-flexible workers?). |
| **`recruiting`** (966 rows: `hired`, `sat`, `gpa`, `apttest`, `int1-3`) | Extra logistic + multi-rater Likert example | Ch. 7 exercise / Ch. 16 aside (three interviewers' 1–5 ratings as an inter-rater angle on ordinal data). |
| **`graduates`** (173 rows, aggregated by `Major`/`Discipline`: `Median_salary`, `Unemployment_rate`) | Aggregate hierarchical | Ch. 14 (Hierarchical models for pay & variance) — how much salary variation sits at the discipline level vs. the major-within-discipline level. |

All loaded directly via `library(peopleanalyticsdata)` in each chapter's setup chunk — no CSVs to vendor, and it keeps the provenance obvious every time the data is touched.

---

## 3. Full chapter list

### Part I — Foundations
*(adapted from Sessions 1–3; no prior stats assumed)*

1. **Meeting Your Data** — describing `salespeople` and `employee_survey`; numeric vs categorical; histograms, boxplots, bar charts. *(from `session01`)*
2. **Thinking in Chances** — probability, conditional probability, using promotion rate as the running example. *(from `session02`)*
3. **Distributions, Sampling & the Idea of a Model** — Normal/Binomial/Poisson with PA meaning (engagement scores, promoted/not, complaints per month); sampling variation. *(from `session03`)*

### Part II — Bayesian Core
*(adapted from Sessions 4–6)*

4. **Bayesian Thinking: Bayes' Theorem & Your First Inference** — grid approximation + Beta-Binomial on the promotion rate. *(from `session04`)*
5. **Posteriors, Priors & Credible Intervals** — weakly-informative priors, prior predictive checks, first `brms`/`rstanarm` model on average sales. *(from `session05`)*
6. **Bayesian Regression: Explaining & Predicting** — does `customer_rate` predict `sales`? Parameter vs. prediction uncertainty. *(from `session06`)*

### Part III — Applied Workflow
*(adapted from Sessions 7–9)*

7. **Groups & Categories: Comparing and Choosing Models** — does promotion rate differ by region/field; LOO model comparison. *(from `session07`)*
8. **When Data Has Structure: Multilevel Models** — `managers` by `city`; partial pooling introduced gently. *(from `session08`)*
9. **The Complete Workflow: From Question to Recommendation** — logistic regression capstone (`promoted ~ …`); full workflow; renamed "thesis bridge" → **"stakeholder bridge."** *(from `session09`)*

### Part IV — Going Further
*(adapted from optional Sessions 10–11)*

10. **Under the Hood: MCMC & Trustworthy Models** — trace plots, R-hat, ESS, diagnosing a broken model. *(from `session10`)*
11. **Richer Models: Varying Slopes & Count Outcomes** — varying slopes; Poisson/negative binomial for counts (e.g. complaints, transfer requests). *(from `session11`)*

### Part V — People Analytics Deep Dives *(all new)*

12. **Empirical Bayes: Estimating Rates You Don't Have Enough Data For** — the "baseball batting average" problem applied to e.g. manager complaint rates or hire rates by channel; deriving a prior from the population of groups itself; includes a section on **using external/industry benchmarks as an informative prior** when you don't want to (or can't) estimate the prior from your own data.
13. **Bayesian Shrinkage: Ranking Managers and Teams Fairly** — the flagship chapter tying directly to the newsletter: why raw league tables of small teams are misleading, partial pooling as the fix, before/after ranking comparison, how to present this to a business audience who wants a league table anyway.
14. **Hierarchical Models for Pay and Variance** — extending the shrinkage idea to compensation: how much pay variation sits at discipline vs. major-within-discipline level (and by extension: level, function, geography in a real comp dataset); variance components as a finding in their own right.
15. **Survival Analysis: Time-to-Event in the Employee Lifecycle** — time-to-attrition (`turnover`, real anonymised company data with genuine tenure-in-months, downloaded from Kaggle) and time-to-promotion (`promotion`) as two sides of the same technique; censoring explained for an audience that's never met it; Bayesian parametric survival models in `brms`.
16. **Analysing Likert and Survey Data the Bayesian Way** — why treating a 1–5 or 1–10 scale as continuous is often wrong; ordinal/proportional-odds regression (`brms::cumulative()`); worked on `employee_survey`; ties directly to Keith McNulty's Chapter 7 (Proportional Odds Logistic Regression).
17. **Bayesian A/B Testing for People Experiments** — Beta-Binomial comparison of two groups (e.g. promotion rate for flexible vs. non-flexible workers using `promotion`); why this beats a chi-square test for the sample sizes PA teams actually have; reading a "probability A beats B" instead of a p-value.
18. **The Elicitation Workflow: Building Priors With Your Stakeholders** *(closing/capstone chapter)* — a repeatable process for eliciting priors from subject-matter experts/HRBPs before you model anything: why it produces better priors than a default, and why it turns stakeholders into co-owners of the analysis rather than an audience for it at the end. Mirrors Ch. 9's "complete workflow" role for Part V.

**18 chapters total** (11 adapted + 7 new).

---

## 4. Open editorial calls (flag if you'd prefer different)

- Chapters 13 and 15 both use "the small sample problem" as a hook — kept deliberately, since Empirical Bayes → Shrinkage → Hierarchical pay is a genuine escalating arc (estimate one rate → rank many groups → decompose variance across levels), not repetition.
- "External benchmarks as priors" folded into Ch. 12 as a section rather than a standalone chapter — same mechanism (build an informative prior), different data source (industry number vs. your own other groups). Easy to split out later if you'd rather it stood alone.
- Ch. 18 placed last as a capstone (parallels how the original course closes on the "thesis bridge"). Could equally open Part V if you'd rather practitioners see the *process* before the *techniques* — flag if you want it moved.

---

## 5. Build/publish

- `_quarto.yml` sets `project: type: book`, chapters listed in the order above, output to `docs/` (the conventional folder GitHub Pages serves from `main` branch without needing a `gh-pages` branch).
- `.github/workflows/publish.yml` renders the book and deploys `docs/` on every push to `main` — R + Quarto + the handful of packages (`tidyverse`, `rstanarm`, `brms`, `tidybayes`, `bayesplot`, `skimr`, `peopleanalyticsdata`) installed via a cached `renv`/`r-lib` action. **Note:** `brms` compiles Stan models, so CI renders will be slower than a local render; chapters use low `iter`/`chains` where the point is pedagogical rather than needing high precision, and cache `.rds` fits where practical so CI doesn't refit on every push.
- Local development: open the `people-analytics-book/` folder in RStudio, `quarto render`.
