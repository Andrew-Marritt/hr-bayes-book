# Change list: Welcome → Chapter 8

Changes to already-reviewed chapters implied by the three new chapters and
the four adaptations. Nothing here has been applied — this is the review
list.

Effort: **S** = a sentence or two · **M** = a subsection · **L** = new
section with code.

Priority: **must** = the book is now inconsistent without it · **should**
= materially better · **could** = optional polish.

---

## Cross-cutting: the renumbering — ✅ DONE

> Applied during integration. The three new chapters are in `chapters/`
> and `_quarto.yml`; A/B testing moved 18→19, elicitation 19→22; the four
> cross-references below are fixed; the `Ch. 8, 13` typo is fixed;
> `index.qmd` chapter counts, the Part V listing and the reading-path
> table are updated; and the "Next chapter" tails of Chapters 17 and 19
> now point at their new neighbours. Nothing else in this list has been
> applied.

**Priority: must.** Inserting measurement error at 18 pushes A/B testing
to 19 and elicitation to 22. Four existing cross-references break:

| File | Line | Currently | Becomes |
|---|---|---|---|
| `chapters/04-bayes-theorem.qmd` | 403 | Chapter 19 | Chapter 22 |
| `chapters/04-bayes-theorem.qmd` | 486 | Chapter 19 | Chapter 22 |
| `chapters/06-bayesian-regression.qmd` | 439 | Chapter 19 | Chapter 22 |
| `chapters/10-complete-workflow.qmd` | 107 | Chapter 19 | Chapter 22 |

Worth doing as a single sweep rather than chapter by chapter, and worth
doing *last*, after the content edits, so it only has to happen once.

**Separately — an existing bug, unrelated to any of this.**
`chapters/13-empirical-bayes.qmd` line 590 says the multilevel model is in
"Ch. 8, 13" — 13 is that chapter itself, and it means 14. The same file
correctly says "Chapter 14" at lines 34, 117, 226 and 600. One-character
fix. **S / must.**

---

## `index.qmd`

### 1. Chapter count and Part V listing — **S / must**

"Five parts, eighteen chapters" is already wrong (nineteen are listed) and
becomes 22. Part V's intro says "Seven chapters built specifically for
this audience" → ten.

New Part V listing:

```
13. Empirical Bayes
14. Bayesian Shrinkage
15. Hierarchical Models for Pay and Variance
16. Survival Analysis
17. Analysing Likert and Survey Data the Bayesian Way
18. Measurement Error and Missing Data                      ← new
19. Bayesian A/B Testing for People Experiments
20. Causal Structure: Drawing the Graph                     ← new
21. Causal Designs: Finding Variation You Didn't Create     ← new
22. The Elicitation Workflow                                ← capstone
```

Also worth revisiting the Part V blurb: "these are largely independent of
each other — go straight to whichever matches the problem on your desk"
is no longer quite true. 20 → 21 is a genuine sequence, and 22 now depends
on 20 for the DAG-elicitation section. Suggest: *"mostly independent —
the exceptions are 20→21, which is a sequence, and 22, which draws on
both."*

### 2. What a model is for — **M / should**

New short subsection, most naturally at the end of "Why Bayesian, and why
for People Analytics" or as the opening of "How the book is organised".

Three goals — **prediction**, **inference**, **causal explanation** — and
the observation that People Analytics questions are usually the third
while People Analytics *models* are usually built as if they were the
second. This is McNulty's ch. 1.2 framing and it's genuinely useful; it
gives Chapters 20 and 21 somewhere to land instead of arriving from
nowhere in Part V, and it sets up Chapter 7's LOO caution (below).

Half a page. No code.

### 3. The McNulty writeup — **M / must** — ⚠️ SUPERSEDED

> **This item has been replaced.** See `drafts/index-mcnulty-section.md`
> for the drafted text. The differentiation framing proposed below was
> written as internal competitor analysis and should stay internal —
> putting it in the book would make it read as positioned against his,
> which it isn't. Kept here only so the reasoning isn't lost.

Line 182 is still `<!-- TODO (Andrew): Keith McNulty and the
peopleanalyticsdata package — ... -->`. It has to be written anyway, but
the framing planned in `BOOK_PLAN.md` §2 needs updating before it is:

> *"his book teaches the regression frameworks in depth; this book
> teaches the Bayesian mindset and a handful of PA-specific extensions"*

That was true of the 1st edition. The 2nd edition (published 2026) has
three Bayesian chapters of its own (12–14) plus causal inference (15), so
"we do Bayesian, he doesn't" no longer differentiates. The honest
differentiation now:

- **He is a handbook, organised by outcome type** — look up your outcome,
  find the model. Formal, mathematical, dual-language R/Python.
- **This is a workshop, organised by problem** — small samples, unequal
  groups, noisy measures, stakeholders who want a league table. Single
  recipe, repeated; R only.
- **Genuinely only here:** empirical Bayes, shrinkage as a presentation
  and fairness problem, variance decomposition as a finding, prior
  elicitation with stakeholders, measurement error at length.
- **Genuinely only there:** multinomial (until Ch. 12 gains it),
  structural equation modelling, classical power analysis, Python.

One line on R-only belongs here too, since the reader most likely to
notice is the reader arriving from his book.

### 4. "If you only have time for four chapters" — **S / could**

Keep 4, 5, 6, 10. Add one line after: *"and if the question on your desk
is whether something caused something else, add Chapter 20."*

---

## `chapters/01-meeting-your-data.qmd`

### 5. "Messy reality: missing values" (from line 634) — **S / must**

The section currently establishes the `na.rm = TRUE` / `drop_na()` habit
and stops. Add a forward pointer, because Chapter 18 argues that habit is
only safe under one of three conditions:

> Dropping incomplete rows is the right call here — three values out of
> 351, and no reason to think they're missing for a reason. That last
> clause is doing more work than it looks like, and Chapter 18 is about
> when it fails.

### 6. "Knowing your gaps" — **M / should**

The natural home for *why is it missing* as a question, informally and
with no machinery. Two or three PA examples — contractors have no
performance rating; the disengaged didn't answer the engagement survey —
and the point that the reason matters more than the count. Names the
distinction without naming MCAR/MAR/MNAR, which Chapter 18 can then
formalise.

### 7. A measurement seed — **S / could**

Somewhere around "The sentence you must always be able to finish": one
line noting that every column here is a *measurement* of something, taken
with an instrument of some quality, and that the quality varies a lot
between `sales` (a system-of-record number) and `performance` (a human
judgement). Cheap, and it makes Chapter 18's opening land harder.

---

## `chapters/02-thinking-in-chances.qmd`

### 8. Conditional probability — **S / could**

The chapter teaches that conditioning changes what you know. Chapter 20
needs the reader to accept that conditioning can also *create*
associations that weren't there. One sentence flagging that the surprise
is still to come would set it up, but the chapter is fine without it.

Lowest priority on this list.

---

## `chapters/03-distributions-sampling.qmd`

### 9. "Population vs sample" — **M / should**

This is the highest-value edit outside Chapter 6. The chapter currently
treats the sample as a random draw from a population, which is the right
teaching simplification at that point and is false for every dataset a PA
practitioner will ever touch.

Add a short callout: your sample is not a random draw from the labour
market — it is the people who applied, were selected, accepted, and
haven't yet left. Four filters, none random, all correlated with the
things you're studying. Point forward to Chapter 20 for what to do about
it and Chapter 18 for the related range-restriction problem.

This also pre-empts a reader objection that currently has no answer, and
it's the natural place to plant it because "sampling variation" is
already the topic.

### 10. "A different lens: this is a frequentist idea, on purpose" — **S / could**

Fine as is. Optionally add that the sampling-distribution mental model
assumes the random draw discussed above, which is a second reason it
strains in this field.

---

## `chapters/04-bayes-theorem.qmd`

### 11. No content changes — **must (renumber only)**

Lines 403 and 486 renumber to Chapter 22. Nothing else.

---

## `chapters/05-posteriors-priors-credible-intervals.qmd`

### 12. Prior predictive checks — **S / should**

Add one sentence connecting this machinery forward to study design:
simulating from the prior to see what data the model considers plausible
is the *same operation* as simulating a study before you run it, which is
how Chapter 21 answers "is this pilot worth doing?".

Worth doing because it makes the design section in 21 a callback rather
than new apparatus, which is how the rest of the book handles second
appearances.

### 13. Bayes Factor note — **no change**

Still correct, still the right place for it.

---

## `chapters/06-bayesian-regression.qmd`

### 14. The causal caveat, lines 442–449 — **S / must**

The seed for the whole causal arc. It currently ends on the problem:

> …Treating it as what *would* happen if you intervened to raise ratings
> is a causal claim the data alone doesn't support. Worth stating plainly
> in the recommendation rather than leaving the reader to assume it.

Add one sentence:

> Stating it plainly is the minimum. Chapter 20 is about what it would
> take to say more — and, on this exact model, arrives at a different
> number.

Draft Chapter 20 quotes this passage verbatim in its opening, so if the
wording changes here, change it there too.

### 15. Non-linearity — **S / should** — ⚠️ REVISED

> Reduced from **L** to **S**: one flag paragraph only, treatment moved to
> the new craft chapter. See `drafts/DECISION-regression-craft.md`.

Regression craft, part one. The chapter fits a straight line and never
says that "straight" was a decision. A subsection on when the line should
bend — with tenure-and-attrition as the canonical PA case, where the
hazard is famously non-monotonic — plus `s()` in a `brm()` formula.

Placement: after "Does the model fit?", since posterior predictive checks
are how you'd notice the problem. Keeps the diagnostic and the fix
adjacent.

### 16. "Where this goes next: Bayesian decision analysis" — **S / could**

Sits immediately after the causal caveat, which now points at Chapter 20.
Two forward pointers in consecutive callouts is slightly cluttered. Check
the ordering reads well once 14 is applied; may want to swap them.

---

## `chapters/07-groups-and-categories.qmd`

### 17. LOO and what it does *not* answer — **M / must** *(unaffected by the craft decision — this is a flag, and flags stay in the beginner path)*

Chapter 20 leans on this and it isn't established anywhere yet. After the
LOO comparison, add a paragraph: LOO tells you which model predicts
held-out data better, and that is not the same question as which model
gives the right answer about an intervention. A model can win on LOO and
be the wrong model to read a coefficient from.

Marked *must* because without it, Chapter 20's central argument ("fit
statistics can't choose your controls") contradicts the reader's
reasonable inference from this chapter.

### 18. Interactions — **S / should** — ⚠️ REVISED

> Reduced from **L** to **S**: one flag paragraph only, treatment moved to
> the new craft chapter. See `drafts/DECISION-regression-craft.md`.

Regression craft, part two. This is where the first categorical ×
continuous model appears, so it's the natural home. What an interaction
claims, how to read one on the outcome scale rather than the coefficient
scale, and the trap of interpreting main effects in the presence of one.

Note the interaction with change 17: adding an interaction because it
improves LOO is a prediction decision; adding one because you believe the
effect genuinely differs by group is a causal one. Worth saying explicitly
now that both sections are in the same chapter.

---

## `chapters/08-multilevel-models.qmd`

### 19. Crossed and repeated measures — **L / should** — ⚠️ RESOLVED

> Placement settled: **Chapter 12**, not Chapter 8. Crossed structure is
> outcome-side, and Chapter 8 is in the read-and-do beginner path. See
> `drafts/DECISION-regression-craft.md`.

Currently all grouping is single-factor. Add a section, or at minimum a
worked aside, on `(1|participant) + (1|programme)` — the same person
observed several times, or rated by several raters. `learning` in
`peopleanalyticsdata` is purpose-built for it (4,974 rows, 326
participants, multiple programmes each).

Alternative placement: Chapter 12, alongside varying slopes. Chapter 8 is
the better home conceptually — it's still "when data has structure" — but
12 is where the other extensions live, and 8 is already 640 lines.

### 20. "Where this goes next" — **S / should**

The section exists; extend it. It should now point at three descendants
rather than one: shrinkage for ranking (14), variance decomposition (15),
and **frailty models in Chapter 16** — hierarchical survival, where the
grouping factor varies the *hazard*. That last one is the payoff of the
whole arc and currently isn't signposted from here.

### 21. Groups as nuisance vs groups as cause — **S / could**

Chapter 8 treats the grouping factor as structure to be accounted for.
Sometimes the group *is* the causal question ("do managers differ?" is
Chapter 14; "does this manager cause the difference?" is Chapter 20). One
line distinguishing them would help, but it can wait until 20 exists.

---

## Suggested order of work

1. **Change 14** (Ch. 6 caveat) — one sentence, and it's the hinge the
   whole causal arc hangs on.
2. **Changes 17, 9, 5** — the three places where an existing chapter
   currently implies something the new chapters contradict. Cheap, and
   they remove genuine inconsistencies.
3. **Changes 1, 2, 3** (`index.qmd`) — the structural rewrite. Do after
   the new chapters are settled, since the blurbs describe them.
4. **Changes 15, 18, 19** — the three regression-craft / structure
   sections. Real writing, independent of each other, can be spread over
   revision passes.
5. **The renumbering sweep** — last, once nothing else is moving.
