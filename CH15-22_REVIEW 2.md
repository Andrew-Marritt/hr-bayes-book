# Chapters 15–22: pre-review audit and fixes

Reviewed against the standard Chapter 10 sets out (the nine-step workflow and
the "one chart, one sentence" deliverable), using Chapter 12's *"Reading the
output, line by line"* section as the house idiom for interpretation.

**All fixes are applied in the `.qmd` files.** Nothing has been rendered — the
review container has no Stan toolchain, so every R chunk was syntax-checked
with `parse()` but not executed. See "What still needs your machine" at the end.

---

## The systemic findings

### 1. Posterior predictive checks were almost entirely absent

Chapter 10 step 7 is stated as one of "the two steps everyone skips, and the
ones a technical reviewer asks about first." Across chapters 12–22 there was
exactly **one** `pp_check()` in the book (Chapter 12's Poisson bars).

Added, each chosen to be the *right* check for the model family rather than a
box-tick, and each with a "what to look for / what failure looks like" reading:

| Ch | Check added | What it's there to catch |
|---|---|---|
| 15 | `pp_check()` density overlay | Normal model vs right-skewed real pay |
| 16 | `pp_check(type = "km_overlay")` | Single-`shape` Weibull vs a real two-phase hazard |
| 17 | `pp_check(type = "bars")` | Misfit in the **top** Likert category — the one that reaches the business |
| 20 | `pp_check()` density overlay | Deliberately: to show it passes for *both* specifications |
| 21 | `pp_check()` density overlay | Closes the loop on the prior that allowed impossible scores |

Chapter 20's is the one worth reading — it's framed as the chapter's most
important negative result, because a passing check there proves nothing about
whether the adjustment set is right.

Two chapters legitimately don't need one, and now **say so explicitly** rather
than appearing to skip a step: Chapter 19 (conjugate — no sampler to diagnose,
and the model has as many parameters as data points) and Chapter 17's prior
predictive (a four-category outcome can't predict anything absurd).

### 2. Model summaries were dumped raw and never read

`summary(fit)` / `fixef()` / `prop.test()` output appeared with no
interpretation in chapters 15, 16, 17, 19 and 22. Chapter 12 does this properly;
nothing after it did.

Added a **"Reading the output, line by line"** section to 15, 16, 17 and 22, and
a line-by-line reading of `prop.test()` to 19. Each one now names the blocks and
explains what each does — including the things a reader will otherwise be
puzzled by:

- **Ch 16** — the `shape` parameter, and what values above/below 1 mean about
  whether attrition risk rises or falls with tenure. It was never mentioned.
- **Ch 17** — that `Intercept[1..3]` are *the thresholds* the chapter draws as a
  diagram, and why there's no `sigma`. The chapter explained thresholds
  conceptually then never pointed at them in the output.
- **Ch 22** — the difference between `judgements$Normal` (what you feed `brms`)
  and `judgements$best.fitting` (which reveals the expert's belief is *skewed*,
  something a Normal prior discards), plus how to read a `feedback()` table.
- **Ch 19** — that a p-value and a credible interval land in the same place here
  but licence different sentences.

Convergence (step 6) is now covered inside those sections rather than as a
separate ritual, and Chapter 18 gets a proper diagnostics callout because its
`me()`/`mi()` models add one latent parameter *per observation* and are by far
the hardest fits in the book.

### 3. Headline findings were tables that should have been charts

The pattern: the most important comparison in a chapter presented as two or
three rows of numbers, inviting the reader to compare point estimates and skip
the interval widths — which in three cases inverts the lesson.

- **Ch 18** — both headline findings. The `me()` comparison ("the estimate gets
  bigger *and* the interval gets wider, and both are correct") and the three-way
  `mi()` comparison against a known truth are now interval plots. The `me()`
  chart is the shape of an honest correction and worth being able to recognise.
- **Ch 20** — "the number doesn't move" is now visibly two overlapping
  intervals. As a table it invited a stakeholder to seize on a difference that
  is noise.
- **Ch 22** — the prior-sensitivity analysis is now three experts' priors paired
  with the posteriors they produced, with a reading order: how far each moved,
  how much they overlap, and whether any one of them crosses zero while others
  don't.
- **Ch 16** — the section headed "Predicted survival curves by group" contained
  no curve, only a table of quantiles. Now has the curves, built by counting
  predictive draws.

### 4. Real chart-design errors

- **Ch 17 (the significant one).** The stacked category chart used
  `c(light blue, mid blue, RED, navy)` for an *ordered* four-point scale. A
  highlight colour in the middle of a sequence tells the eye that "somewhat
  happy" is a different kind of thing from its neighbours — it contradicts the
  ordinal model the chart is illustrating. Replaced with a monotonic four-step
  ramp (`likert_pal`), applied to every Likert chart in the chapter so "darker
  means more positive" is stable.
- **Ch 15.** Red jittered points over navy boxes — two data series fighting, and
  poor contrast. Now navy points on light-navy boxes, with red demoted to a
  reference line. Also `outlier.shape = NA`, since every major was already drawn
  as a point and extremes were plotted twice.
- **Salary and rate axes** had no `scales::dollar` / `scales::percent`
  formatting anywhere in 15 or 19. Added.
- **Ch 19.** Legend and axis labels showed raw variable values
  (`diverse_group`, `comparison_group`). Added a `label` column: raw coding for
  the code, readable labels for the reader.
- **Palette consistency.** `_setup.R` defines `navy` / `navy_light` / `red` but
  no chapter sources it, so all hex values were inline literals. 15–22 now
  define the tokens in their setup chunk and reference them by name — same
  colours, but the palette is legible and consistent, and each chapter still
  renders standalone from `drafts/`. **A convention is now stated and followed:
  the navy ramp carries data, red is only ever a reference line or annotation.**

### 5. Priors were plotted but rarely checked

Every chapter visualised its priors (your recent pass shows). Chapter 10 step 4
asks for *both* the visualisation and a prior predictive check, and only
Chapter 21 had one.

- **Ch 15 — this one found a real problem.** `Normal(45000, 15000)` for the
  intercept plus `Exponential(0.0001)` on both variance components implies a
  meaningful share of prior mass on **negative salaries**. Each prior is
  entirely reasonable on its own; only simulating them together reveals it.
  Added as a worked check with the honest flag (it doesn't matter at n=173, it
  would at n=9) and two fixes.
- **Ch 22 — the ironic gap.** The chapter *about priors* never checked its
  elicited one. Added, with the point that this chart is the third and best
  feedback loop to show the expert: she answered three percentile questions, and
  nobody translates that into a distribution of outcomes in their head.
- **Ch 16** — reframed rather than added: because an AFT model's intercept prior
  exponentiates straight into *expected months*, that one chart already **is**
  both halves of step 4. Worth saying, and a real argument for AFT over
  proportional hazards.

### 6. Missing PA narrative

Chapters 15, 16 and 17 opened topic-first — "here is a technique" — with no
stakeholder, no scene, and no destination, against Chapter 10's model of the VP
of Sales with twenty minutes on the agenda.

Added a *"The request, as it actually arrives"* scene to each, with a named role
and a quote that contains the actual analytical trap:

- **Ch 15** — the Reward Director: *is pay determined by structure, or by who
  negotiated well? Those are different projects.* Closed the loop at the ICC,
  where a high vs low value maps onto her two options.
- **Ch 16** — the COO: *budget for one thing, onboarding or the two-year mark —
  which?* The point being that an 18% annual rate cannot answer it, and neither
  can a classifier, because both discard the timing.
- **Ch 17** — the CHRO: *management scored 3.1, benefits 3.4, so which do I
  fund?* Sets up why "which scores highest" ≠ "which matters most", and why a
  regression answer in happiness-points-per-management-point can't be said to a
  board.

Chapters 15 and 17 also now **state their finding as a sentence with the number
in it**, via inline R so the prose can't drift from the model. Chapter 15's
learning objectives promised the reader would interpret *"40% of variance sits
at the discipline level"* and the chapter never produced the number.

---

## Bugs found along the way

| Where | Issue |
|---|---|
| **Ch 18** | `fit_mi` was fitted with **no `prior =` argument** while the two models it's compared against used the Chapter 6 priors. The three-way comparison was not like-for-like and nothing warned about it. Fixed with `resp = "sales"`-qualified priors, and the trap documented — it's easy to hit because a multivariate `brms` formula needs the response named. |
| **Ch 15** | The illustrative crossed-factor model used `(1 \| function)`. `function` is a **reserved word in R**. It's in a non-executed block so it never errored, but it's broken code being shown as a pattern. Changed to `job_family` with a note, since HRIS extracts really do arrive with that column name. |
| **Ch 10** | The model-selection table pointed "Comparing two rates → Bayesian A/B test" at **Chapter 18**; it's Chapter 19. (The callout immediately below it says 19 correctly.) Also added the missing `me()` and `mi()` rows so Chapter 18 appears in the book's own map at all. |
| **Ch 19** | The chapter frames itself as A/B testing and its "Next chapter" says *"an A/B test is the easy case, because you controlled who went into which group"* — but the worked example is **`diverse` group membership, which nobody assigned**. The arithmetic is identical; the licence to interpret it is not. Added an explicit callout, because the output ("an 87% chance one rate is higher") sounds equally authoritative in both cases. |
| **Ch 21** | Your revision note flagged the `_setup.R` refactor as a separate pass. Updated to reflect what's now done (15–22) and what blocks the full version: `_setup.R` loads `skimr` and `rstanarm`, which no chapter in 15–22 uses and which would break every chapter if either is missing. Trim that list first and it really is one line per chapter. |

Also added a ROPE **chart** to Chapter 19 (the band drawn on the posterior, not
described in a table), and the procedural point that the ROPE width must be
chosen before seeing the posterior — otherwise it's p-hacking with different
vocabulary.

---

## What still needs your machine

I could not execute R. Base R 4.3.3 was available so **every chunk in every
chapter parses cleanly** and every inline `` `r ` `` expression is
syntactically valid, with no duplicate chunk labels. But the following need a
real render to confirm:

1. **`pp_check(fit_surv, type = "km_overlay", status_y = turnover$event)`** in
   Ch 16 needs `bayesplot` ≥ 1.9. This is the one addition I'd check first.
2. **`cross_join()`** in Ch 16's predicted-curves chunk needs dplyr ≥ 1.1.
3. **Ch 22's `feedback()` reading** describes the table's structure in prose. I
   removed an inline call that indexed into `$fitted.quantiles` because I
   couldn't verify SHELF's exact return shape — you may want to name the actual
   0.25 value once you've seen it render.
4. **Ch 22's sensitivity chart** derives prior intervals from
   `group_fit$Normal`'s `mean`/`sd` columns via `qnorm()`. Worth eyeballing that
   the three prior bars match the `plotfit()` curves above them.
5. **Render times.** Ch 18 now has a `#| eval: false` diagnostics chunk (no
   cost), but Ch 20's new `pp_check` and Ch 15/16/17/21's checks all reuse
   existing fits, so no new model fitting was added anywhere.

## Two things I deliberately did not do

- **`source("_setup.R")` in each chapter.** It's the right end state and your
  own note says so, but `_setup.R`'s library list needs trimming first, and
  doing it now would have coupled a review pass to a change that can break
  eight chapters at once. The tokens are defined locally instead — same visual
  result, and the refactor is still one line per chapter when you want it.
- **Chapters 12–14.** Still have inline hex literals (12: 6 instances, 13: 10,
  14: 5) and Ch 12 is the only one of the three with a `pp_check`. Chapters 13
  and 14 have no prior predictive checks either. They weren't in scope but
  they're the same three findings.
