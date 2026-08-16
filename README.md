# Bayesian Thinking for People Analytics

A Quarto book adapting Andrew Marritt's *Bayesian Statistics for
Hospitality Research* course for the People Analytics community, with
seven new chapters on Empirical Bayes, Bayesian shrinkage, hierarchical
pay/variance models, survival analysis, Likert/survey analysis, Bayesian
A/B testing, and stakeholder prior elicitation.

See `BOOK_PLAN.md` for the full chapter list, dataset mapping, and
editorial notes.

## Note for AI assistants

All source files for this book (chapters, `index.qmd`, `BOOK_PLAN.md`,
`_quarto.yml`, etc.) live in this local folder — **not** in Google
Drive or any other connector. The "Welcome" chapter is `index.qmd` at
the project root (Quarto renders it as the book's index page; Andrew
may refer to it as "Index.md"). Read/search this folder directly
rather than searching Drive first.

## Build locally

```bash
quarto render
```

Requires R with `tidyverse`, `rstanarm`, `brms`, `tidybayes`,
`bayesplot`, and `peopleanalyticsdata` installed (see `index.qmd`).
Rendered output goes to `docs/`.

## Publish

Push to `main`; `.github/workflows/publish.yml` renders the book and
publishes `docs/` to GitHub Pages. If this folder becomes the *root* of
its own repository (rather than a subfolder of a larger repo), remove
the `people-analytics-book/` path prefixes in that workflow file and its
`paths:` trigger filter.

## Data credit

Example data throughout is from Keith McNulty's `peopleanalyticsdata` R
package (MIT licensed), accompanying his *Handbook of Regression
Modeling in People Analytics*. See `index.qmd` for the full credit and
overview.
