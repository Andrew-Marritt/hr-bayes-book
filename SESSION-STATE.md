# Session state — Chapters 23 & 24, figures, Appendix B

Written to let a fresh session pick up without re-deriving anything.
Everything below is **done and in the files** unless marked otherwise.

---

## 1. Structure now

24 chapters. New **Part VI — "From analysis to decision"**, one chapter,
appended so nothing renumbered.

```
Part V   … 23-elicitation-workflow.qmd
Part VI     24-posterior-to-decision.qmd     ← new
appendices  A1-llms, A2-further-reading, A3-data-sources
```

`_quarto.yml` also gained `project: resources: [figures/]`.

`index.qmd` updated: Part VI section, chapter 24 entry, "Twenty-four
chapters", reading table row 24, "Chapters 14 to 24".

Chapter 23 is no longer the finale — its "closes the book" line and its
old `Where to go from here` stub are gone, replaced by a `Next chapter`
pointer.

---

## 2. Verified R facts — do not re-derive

Confirmed by Andrew running code in his console. `SHELF` under R 4.5.2.

**`fitdist()` return object.** `names()` gives: `Normal`, `Student.t`,
`Skewnormal`, `Gamma`, `Log.normal`, `Log.Student.t`, `Beta`,
`mirrorgamma`, `mirrorlognormal`, `mirrorlogt`, `ssq`, `best.fitting`,
`vals`, `probs`, `limits`, `notes`.

**`sampleFit()` column names differ from those** — lowercase and
abbreviated: `normal`, `t`, `skewnormal`, `gamma`, `lognormal`, `logt`,
`beta`, `hist`, `mirrorgamma`, `mirrorlognormal`, `mirrorlogt`. A
misspelt name returns `NULL` silently. This trap is documented in a Ch 24
callout.

**Beta samples come back on the ORIGINAL scale**, not rescaled to [0,1].
With `lower = -20000, upper = 90000`, `sampleFit(...)[, "beta"]` returned
quartiles 9,458 / 15,563 / 22,409 and a range of −10,491 to 53,928. No
rescaling step is needed, and negative draws appear naturally.

**`best.fitting` is not Beta** in either of our cases — `logt` for the
effect, `skewnormal` for the net cost. Taking Beta is a deliberate
override, justified on boundedness, and the chapter says so.

**`ssq`, effect fit** (vals 0.12/0.20/0.35, probs .25/.5/.75, 0–1):
logt 8.13e-05, lognormal 8.41e-05, gamma 6.86e-04, skewnormal 1.14e-03,
**beta 1.26e-03**, t 3.57e-03, normal 3.67e-03. Beta ≈ 15× the best.

**`ssq`, net cost fit** (10000/15000/23000, −20000 to 90000):
skewnormal 3.24e-04, logt 8.05e-04, lognormal 8.31e-04, gamma 1.20e-03,
**beta 1.62e-03**, t 2.07e-03, normal 2.13e-03. Beta ≈ 5× the best.

**Diagnostics on the manager posteriors** (571 managers × 4,000 draws
= 2.28M values):

| | |
|---|---|
| `rate` | min 0.00029, Q1 0.0259, med 0.0481, mean 0.0678, Q3 0.0882, max 1.181 |
| `rate × group_size` | min 0.0026, Q1 0.288, med 0.553, mean 0.800, Q3 1.044, max 15.36 |
| top-5 rates | teams of 13, 8, 5, 5, 12 — small teams, as expected |
| top 30 by mean | min team 10, median 13, none under 10 |
| mean-vs-median top-30 overlap | **28 of 30** |
| `selected` | total_expected_net £118,114, worst_p_positive 0.468, expected_wrong 13.9 |

Implied log-scale σ for `rate` ≈ 0.91 around median 0.048. A lognormal of
that shape sampled 2.28M times would be *expected* to produce a max near
4.2; the observed 1.18 is tamer than that. **The model is not
misbehaving** and nothing needs bounding — unlike the effect, a rate
above 1 is possible (transfers per average head, people can move twice).

---

## 3. Chapter 24 — what it is

`chapters/24-posterior-to-decision.qmd`, "From Posterior to Decision:
What an Analysis Is Worth". Built on Ch 15's `managers` model, refitted.

Six parts: the missing multiplication → pricing outcomes with elicited
distributions → the decision tree run on draws → thresholds and the
selected set → EVPI/EVPPI from draws → option value.

**Positions settled, do not relitigate:**

- **You can price outcomes** — Andrew's position, adopted. Not with a
  number, with an elicited *distribution*. My earlier "you can't price
  it" hedge was wrong and is gone.
- **The elicited quantity is a NET cost** and may be negative (a poor
  performer leaving is worth something). Lower limit −£20,000.
- **The "vouch"**: ask finance to accept the *range* in a business case,
  not to certify a number. In writing, before the result is known.
- **Uncertainty ≠ disagreement about values.** Pool the first; run the
  decision twice for the second.
- **Beta over `best.fitting`**, for boundedness, with the `ssq` cost
  stated honestly.
- **A `pmin()` guard is a sign the family is wrong.** Kept as a
  `callout-caution` recording the earlier lognormal failure: 2.1% of
  draws above 1.0, 85 in 4,000 clipped to exactly 1, dragging ~8% of the
  mean effect and producing the long tail.
- **The tail is cosmetic.** Plot clipped at the 99th percentile with the
  off-screen fraction printed; `coord_cartesian()` not `xlim()`.
- **Never clip an axis without saying so.**
- **A high `expected_wrong` and a low action threshold are the same fact
  stated twice.** No threshold on the miss count; the stopping rule is
  the marginal unit's expected net benefit. Two things that *should*
  stop you: concentration (`top_3_share`), and a cost left out of the
  loss function (reputational).
- **Mean is the right quantity** (expected value is what decision theory
  maximises); median is a robustness check, not a replacement.
- EVSI/ENBS named but not computed — EVSI needs Ch 22's simulated study.

---

## 4. Chapter 23 — four corrections

All from Andrew's own Block 5 literature review in the wiki.

1. **EVPPI was defined as EVSI.** Now a table: EVPI screens, EVPPI
   triages which parameter carries the decision, EVSI prices a specific
   study, ENBS decides.
2. **SHELF attribution.** The chapter now separates SHELF-the-protocol
   from SHELF-the-package, and **teaches the quartile method** (limits →
   median → quartiles) as the recommendation.
3. **The 10/90 method is demoted to a callout** — "Why I no longer ask
   for the 10th and 90th percentiles" — naming it as Andrew's adaptation
   of Hubbard's 90% interval, explaining that both ask for tail quantiles
   which is what SHELF refuses, and giving Hubbard his due (his answer is
   calibration training, which works; most organisations won't run it).
   Code moved to `probs = c(0.25, 0.5, 0.75)`; single expert now
   2.5/5/10, three-expert matrix converted to match.
4. **Delphi framing.** "Calibration not consensus" is now labelled as
   Andrew's departure (Delphi aimed at consensus), with Sackman 1974 and
   Rowe & Wright's 12–2 tally. New warning on averaging confident
   disagreement into a **bimodal** prior nobody holds, with the Rational
   Impartial Observer as the fix. Cooke's classical model named.

---

## 5. Figures

`figures/build-decision-trees.py` — geometry defined **once** in
`tree_skeleton()`; the classical and draws figures are the same skeleton
with different text and a `fan` flag, so they cannot drift. Staged tree
has its own geometry. Regenerate with:

```
python3 figures/build-decision-trees.py
```

Outputs (committed): `decision-tree-classical.svg`,
`decision-tree-draws.svg`, `decision-tree-staged.svg`.
Referenced as `@fig-tree-classical`, `@fig-tree-draws`,
`@fig-tree-staged`.

Style: navy structure, amber annotations, red reserved for break-even,
Inter, transparent background. Square/circle/triangle notation with a
legend on the first figure only.

---

## 6. Appendix B

`appendices/A2-further-reading.qmd` — full entries written for McElreath,
Kruschke, Rossi/Allenby/Misra, Gelman BDA3, McNulty, Robinson, Angrist &
Pischke ×2, Huntington-Klein, Hubbard, Wainer, Kahneman/Sibony/Sunstein,
McGrayne. All bibliographic details web-verified.

---

## 7. Outstanding

**Nothing in this session has been rendered.** No R in the working
sandbox. Highest-risk chunks: Ch 24's `fitdist()`/`sampleFit()` calls,
`refit-shrink`, the 2.3M-row `manager_draws` frame, and Ch 23's
`plotfit()` on the group fit — the fitted tails now run further past the
elicited values than before, so `xu = 20` is the line to check first if
the axis misbehaves.

**Duplicate files.** `chapters/` and `appendices/` contain sync
duplicates named `… 2.qmd` (09, 10, 13, 19, 21, 22, 24, A1, A2, A3).
Same byte sizes but unreadable from the sandbox ("Resource deadlock
avoided"). They are **not** in `_quarto.yml` so they won't render, but
they pollute grep. Andrew to delete once he's confirmed they're stale.

**Backlog carried from earlier sessions:**

- `drafts/CALLOUT-DENSITY-PROPOSALS.md` — sections A/B/C for ch 19–23
- `drafts/CHANGE-LIST-welcome-to-ch08.md` — ~15 items unapplied
- `appendices/A2-further-reading.qmd:198` — papers section still TODO
- `appendices/A3-data-sources.qmd:29` — row counts to confirm
- `index.qmd:255` — reviewer names
- Boundary sentence between Ch 13 Part 1 (treatments) and Ch 21
  (adjustment sets)
- Ch 11 filename is still `11-mcmc-under-the-hood.qmd` despite the
  retitle to "Inside the Sampler"
- Ch 13's `s()` and interaction models have never been run

---

## 8. Conventions worth not rediscovering

- `##` inside a chapter is ambiguous — it is used for **callout titles**
  as well as section headings. Never anchor a block move on `##` text
  without checking which it is.
- Callout colours: important = coral-red, note = navy, tip = teal,
  caution = amber, warning = slate. `BOOK_PLAN.md` §1a.
- Chart house rules in `BOOK_PLAN.md` §1c. Red is reserved for the value
  an estimate is argued against; never a category. No grey darker than
  `grey70` next to navy.
- brms special terms (`me()`, `mi()`, `mo()`) use the **`bsp_`** prefix,
  not `b_`.
- British spelling. Plain English — many readers are non-native
  speakers; avoid metaphor where a plain sentence works.
- Check `::: callout` / `:::` / fence counts after any structural edit.
