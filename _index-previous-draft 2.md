# Welcome {.unnumbered}

This book is an introduction to **Bayesian thinking for People Analytics** —
written for practitioners, not statisticians. If you work with employee
data and want to move beyond point estimates and p-values toward
statements like *"there's about an 85% chance this manager's team is
genuinely below average, but the raw number overstates it"*, this book is
for you.

No prior statistics background is assumed. If you can write a
`group_by()` and `summarise()` in R, you're ready to start at Chapter 1.

## Why Bayesian, and why for People Analytics specifically {.unnumbered}

People Analytics data has a few recurring features that make Bayesian
methods a particularly good fit, more than a stylistic alternative to
classical statistics:

- **Small groups, everywhere.** Teams, managers, offices, and cohorts
  come in wildly different sizes. A five-person team's average
  engagement score is much noisier than a two-hundred-person
  department's — but a raw league table treats them the same. Bayesian
  partial pooling (Chapters 8, 12 and 13) fixes this directly.
- **You almost always know something before you look at the data.**
  Industry attrition benchmarks, last year's survey results, a
  colleague's informed guess about a plausible effect size — Bayesian
  methods give you a principled way to use that knowledge instead of
  discarding it (Chapters 4, 5, 12 and 18).
- **Ordinal, bounded, and time-to-event outcomes are the norm, not the
  exception.** Engagement surveys are Likert scales, not continuous
  numbers; attrition is a time-to-event question, not a single yes/no.
  Treating them as if they were ordinary continuous outcomes (a very
  common shortcut) quietly produces wrong answers. Chapters 15 and 16
  deal with this properly.
- **The questions are inherently about uncertainty and decisions**, not
  abstract hypothesis tests. "How confident should we be that this
  intervention worked?" and "Is this manager's team really
  underperforming, or is that just five people?" are Bayesian questions
  by nature.

<!-- TODO (Andrew): personal anecdote goes here — being taught to *think*
     like a Bayesian in statistics and econometrics, then made to *analyse*
     like a frequentist, because the computational methods weren't
     practically available yet. Two or three short paragraphs, first
     person, same register as the Chapter 5 detour.

     Chapter 5 ("A short detour: why nobody taught me this") currently
     tells this story in full, including the Mac LC (2MB RAM, 40MB hard
     drive) and the 1990 Gelfand & Smith coincidence. If the anecdote
     lands here first, trim Chapter 5's opening to a one-line callback
     — e.g. "I mentioned in the introduction that I was taught to think
     like a Bayesian and analyse like a frequentist. Here's the reason."
     — and let Chapter 5 keep only the algorithmic history from 1953
     onwards. Don't let both versions run at full length. -->

## One recipe, not a toolbox of tests {.unnumbered}

Classical statistics tends to hand you a different named tool for
every situation: a t-test for two means, ANOVA for several, a
chi-square test for two categorical variables, Cox regression for
time-to-event data, proportional-odds regression for a Likert scale —
each with its own formula, its own assumptions, and often its own R
function. Learning statistics this way means learning a long menu of
special cases before you can recognise which one applies.

The Bayesian approach used throughout this book collapses that menu
into one recipe: write down a model — an outcome, a formula, a
distributional family — state your priors, and hand it to `brms`.
`brm(formula, family = ..., prior = ...)` is *the same call* whether
the outcome is continuous sales, a yes/no promotion, a count of
transfers, an ordinal survey response, or a time until someone leaves —
only the `family` and the `prior` ever change, never the underlying
machinery or the workflow around it (state the model, visualise the
prior, fit, check the chains, read the posterior). Part V's chapters
each apply this same recipe to a new People Analytics situation, one
family/prior combination at a time, and Chapter 9's "matching model to
outcome" table makes the pattern explicit once several examples are on
the table at once.

::: callout-note
This is a genuine practical advantage, not just a stylistic preference:
once you've learned to read *one* `brms` model, you can read every
other model in this book, because it's the same tool with different
settings — not a new tool each time.
:::

::: callout-tip
## The deliberate exceptions

A handful of the simplest examples (Chapters 4, 12, and 17) skip
`brms` entirely, in favour of an exact conjugate shortcut — direct grid
approximation or Beta-Binomial updating. That's a teaching choice, not
a break from the recipe: it lets you see the raw prior-times-likelihood
mechanics with nothing hidden, before `brms` takes over as the one tool
for everything more complex than these simplest cases can handle on
their own.
:::

## How the book is organised {.unnumbered}

- **Part I -- Foundations.** Describing data, probability, distributions
  and sampling. Start here if you're new to statistics.
- **Part II -- Bayesian core.** Bayes' theorem, priors and posteriors,
  credible intervals, and Bayesian regression.
- **Part III -- Applied workflow.** Comparing groups, multilevel models,
  and a full worked project end to end.
- **Part IV -- Going further.** MCMC internals and richer model families,
  for when you want to understand what's happening under the hood or
  your outcome doesn't fit the standard shapes.
- **Part V -- People Analytics deep dives.** Seven chapters built
  specifically for this audience: empirical Bayes, shrinkage for fair
  manager/team comparisons, hierarchical models for pay and variance,
  survival analysis for the employee lifecycle, analysing Likert/survey
  data properly, Bayesian A/B testing, and a closing chapter on running
  the whole process with your stakeholders.

Each chapter is self-contained enough to read on its own if you already
know the basics, but the running examples build on each other, so
reading in order rewards you with familiarity.

## The data used throughout this book {.unnumbered}

Rather than invent People Analytics data from scratch, this book uses
the **`peopleanalyticsdata`** R package — a collection of realistic,
freely available datasets created by **Keith McNulty** to accompany his
book:

> Keith McNulty (2026). *Handbook of Regression Modeling in People
> Analytics: With Examples in R, Python and Julia* (2nd edition).
> Chapman & Hall/CRC Press. Free online edition:
> [peopleanalytics-regression-book.org](https://peopleanalytics-regression-book.org/)

Keith's book is the definitive treatment of regression modelling for
People Analytics — linear, logistic, multinomial, ordinal, count,
multilevel, survival, and (in its closing chapters) Bayesian regression,
all with real worked examples. If this book teaches you the Bayesian
*mindset* and a handful of PA-specific extensions, his book is where you
go to go deep on the regression frameworks themselves. The two pair
naturally — several chapters here (multilevel models, survival analysis,
ordinal/Likert regression, Bayesian regression) cover ground his book
also covers, from a specifically Bayesian angle.

The `peopleanalyticsdata` package is MIT licensed and installable
directly from CRAN:

```r
install.packages("peopleanalyticsdata")
library(peopleanalyticsdata)

# see everything available
data(package = "peopleanalyticsdata")
```

Every dataset used in this book is credited at the point it's
introduced, and the full list is in the [Data Sources](#data-appendix)
appendix. Our thanks to Keith for making this data freely available —
it's the reason every example in this book looks like a scenario a
People Analytics practitioner would actually recognise, rather than an
invented toy problem.

## Software {.unnumbered}

Every example runs in R using `tidyverse`, `rstanarm`, `brms`,
`tidybayes`, and `bayesplot`. Install the full stack once:

```r
install.packages(c(
  "tidyverse", "rstanarm", "brms", "tidybayes",
  "bayesplot", "peopleanalyticsdata"
))
```

`brms` fits models via Stan and will compile the first time you use a
new model specification — this can take a minute or two per chapter the
first time, but is worth the flexibility it buys you for the ordinal,
survival, and custom models in Part V.

## A note on this book's origins {.unnumbered}

This book began as a course, *Bayesian Statistics for Hospitality
Research*, and was adapted for the People Analytics community — same
Bayesian arc, same emphasis on visualising every assumption before
defending it, rebuilt around scenarios and data a People Analytics
practitioner will recognise on day one.
