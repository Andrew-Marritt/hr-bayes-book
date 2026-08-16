# Draft: the McNulty / `peopleanalyticsdata` section for `index.qmd`

Fills the TODO at `index.qmd` line ~182 (Acknowledgements), replacing the
version in `_index-previous-draft.md` lines 121–158.

**One change of direction from the earlier gap analysis.** That document
proposed a "here's how the two books differ" framing — handbook vs.
workshop, what's only here, what's only there. That was written as
internal competitor analysis and it should stay internal. Putting it in
the book would make this read as though it were positioned against his,
which it isn't. The draft below credits and recommends, and does no
comparing beyond what genuinely helps a reader decide where to go next.

Change #3 in `CHANGE-LIST-welcome-to-ch08.md` should be treated as
superseded by this.

---

## The draft

```markdown
## The data used throughout this book {.unnumbered}

Almost every example in this book runs on real-shaped People Analytics
data rather than numbers I made up, and that is entirely down to
**Keith McNulty**, who created the `peopleanalyticsdata` package and
released it freely for anyone to use:

> Keith McNulty (2026). *Handbook of Regression Modeling in People
> Analytics: With Examples in R and Python* (2nd edition). Chapman &
> Hall/CRC Press. Free online edition:
> [peopleanalytics-regression-book.org](https://peopleanalytics-regression-book.org/)

The package is MIT licensed and on CRAN:

```r
install.packages("peopleanalyticsdata")
library(peopleanalyticsdata)

# see everything available
data(package = "peopleanalyticsdata")
```

It is hard to overstate how much difference this makes to a book like
this one. Teaching statistics on invented data has a particular failure
mode: the examples come out too clean, the effects are exactly as large
as the author needed them to be, and the reader learns a technique
without ever meeting the ambiguity that makes it necessary. Keith's
datasets have the texture of the real thing — small groups, unbalanced
categories, missing values, relationships that are there but not
overwhelming — because they were built by someone who has spent a career
looking at the real thing. Every dataset used here is credited where it
first appears, and the full list is in the [Data
Sources](#data-appendix) appendix.

**And you should read his book.** *Handbook of Regression Modeling in
People Analytics* is the most complete treatment of regression for this
field that exists: linear, logistic, multinomial, ordinal, count,
hierarchical and survival models, each developed properly from first
principles, with worked examples in both R and Python and a free online
edition. If you want to go deeper on any model family than a chapter here
takes you — and at some point you will — that is where to go. Several
topics appear in both books, and where they do I've said so at the point
it comes up, so you can read across.

My thanks to Keith, both for the data and for writing the reference book
this field needed.
```

---

## Notes on the choices

**Leads with the data, not with a comparison.** The first thing a reader
learns is that he made the examples possible.

**The recommendation is unqualified.** No "if this book does X, his does
Y" symmetry — that construction implies two things competing for the same
slot, and invites the reader to pick one. "At some point you will want to
go deeper, and that's where to go" makes them companions.

**Nothing about what his book doesn't cover.** The earlier draft's "if
this book teaches you the Bayesian *mindset*…" has gone, for two reasons:
it quietly stakes a claim, and the 2nd edition has three Bayesian chapters
of its own, so it isn't accurate any more either.

**No explanation of why this book exists.** It doesn't need one here.
"Who this book is for" and "Why I wrote it" already answer that, and the
answer is a course you taught — which has nothing to do with his book and
shouldn't be made to look like it does. Any justification placed *next to*
a recommendation reads as a comparison whether or not it's meant as one.

**The praise is specific.** "The most complete treatment of regression for
this field that exists" and the list of model families are checkable
claims rather than politeness. Generic praise reads as obligatory;
specific praise reads as meant.

---

## Placement

The current TODO sits under **Acknowledgements**, and the previous draft
had this as its own section headed "The data used throughout this book".
Both work, and they want slightly different things:

- **As its own section** (recommended) it can carry the install code and
  the appendix pointer, which are practical information a reader needs
  before Chapter 1 rather than acknowledgement material.
- **Under Acknowledgements** it sits alongside other thanks, which is
  more conventional but buries the `install.packages()` line somewhere
  nobody looks for setup instructions.

Suggestion: keep it as its own section immediately before or after
Acknowledgements, and have Acknowledgements carry a one-line pointer if
other people are being thanked there too.

---

## One related question, outside this section

Chapter 5's Bayes Factor note (line ~837) and Chapter 19's A/B testing
callback both name his book as the place Bayes Factors are covered, while
explaining that this book prefers estimation. That's the right call and
the right place for it — it's a methodological preference, argued on the
merits.

Worth a read-through with fresh eyes, though, for whether the framing is
"here are two approaches, here's why this book picks one" or drifts into
"here is where the other book goes wrong". The first is useful to a
reader. The second would be the only place in the book where the
comparison turns adversarial, and it would undercut everything the
section above is doing.
