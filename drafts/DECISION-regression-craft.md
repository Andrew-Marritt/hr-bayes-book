# Decision: where the regression-craft material goes

> ## ✅ DONE — integrated
>
> Written and folded in as **Chapter 13, "Model Building as Craft: The
> Decisions Software Won't Make For You"**. Part IV is now 11, 12, 13;
> Part V shifted to 14–23; the book is 23 chapters.
>
> **The chapter grew beyond this plan.** Two ideas Andrew added at
> drafting turned out to be the spine: Rubin/Holland's *no causation
> without manipulation* (Part 1 — can this variable be a treatment?) and
> pre-committing to what you would do with each possible result (Part 5).
> Interactions, non-linearity and correlated predictors sit between them.
> The unifying frame is **decisions the software never prompts you for**,
> which is stronger than "craft" alone and serves readers who commission
> analysis as well as those who do it.
>
> Both one-paragraph flags are in: Chapter 6 (straight line was a
> choice) and Chapter 7 (the interaction this chapter assumed away).

Working from the reading-path principle: **Chapters 1–10 plus the Welcome
are the beginner path — read *and do*. From 13 onward the material is
read for awareness, tried when the problem calls for it.** Plus the
second principle: you don't apply all of these on every project, starting
simple is often where the value is, and the point of knowing a technique
is to be able to skip it *by design rather than by default* — and to
temper what you claim when you have.

---

## The decision

**A new chapter in Part IV: *Model Building as Craft*, sitting after
Richer Models.** Not distributed sections in Chapters 6 and 7, which is
what I proposed in the change list. That proposal is superseded.

With one qualification that does the real work:

> **The flag goes in the beginner path. The treatment goes in the craft
> chapter.**

Chapter 6 gains one short paragraph saying that we fitted a straight
line, that "straight" was a decision rather than a default, and where
it's known to bite. Chapter 7 gains a similar paragraph where the first
categorical × continuous model appears. Neither gets a section, code, or
a worked example. Two paragraphs total, across two chapters, each
pointing forward.

---

## Why I changed my mind

**The change list had it backwards.** Putting interactions into Chapter 7
and non-linearity into Chapter 6 loads the beginner path with material a
first project doesn't need, in the two chapters that are already the
longest in Part II/III (733 and 537 lines). It also quietly contradicts
the "start simple" principle by demonstrating sophistication at exactly
the moment the reader should be doing the plain version and shipping it.

**But the gotchas can't wait until Chapter 13.** A practitioner who fits
a linear tenure term to an attrition model gets a wrong answer and no
warning. That's not an advanced refinement, it's a trap, and Chapter 6 is
where they'll walk into it. The flag has to be early even though the
treatment shouldn't be.

**The split is already how the book handles this.** Chapter 6's causal
caveat is exactly this pattern — one paragraph naming a problem, with the
full treatment deferred to Chapter 20. It works, and it's the model to
copy rather than invent something new.

---

## Why Part IV rather than Part V

Part V is *People Analytics deep dives* — its identity is domain
problems, not general method. Interactions and non-linearity aren't PA
techniques; they're modelling judgement that a reader needs before the
Part V chapters, several of which use them implicitly.

Part IV is already defined as the optional zone: *"Read Chapter 11 when
you want to know what the sampler is doing; read Chapter 12 when your
outcome stops fitting the standard shapes."* A craft chapter extends that
sentence naturally: *read Chapter 13 when your predictors need more
thought than a straight line.*

That also gives Part IV a clean internal logic it doesn't currently have:

| | |
|---|---|
| **11 — Under the Hood** | when you don't trust the sampler |
| **12 — Richer Models** | when the **outcome** doesn't fit |
| **13 — Model Building as Craft** | when the **predictors** need more thought |

Outcome side, predictor side. That split also settles a loose end from
the change list: **multinomial belongs in 12** (an outcome type), and
**crossed / repeated-measures structure belongs in 12 too** (still
outcome structure), leaving 13 for interactions, non-linearity and
correlated predictors. Chapter 12 stays coherent instead of becoming a
grab-bag of six unrelated extensions.

---

## The cost, stated plainly

Another renumber. Part V shifts by one on top of the shift from inserting
measurement error, so the book lands at **23 chapters** and almost every
Part V number moves.

I don't think this should change the decision. The change list already
says do the renumbering last, in a single sweep, once everything else has
settled — and one sweep covering three insertions costs barely more than
one covering two. It's mechanical and scriptable. Choosing a worse
structure to avoid a find-and-replace would be the wrong trade.

---

## The bigger opportunity in your second principle

The "I don't do all of these on every project" point is worth more than a
line in one chapter. It is, as far as I can tell, **absent from every
statistics book aimed at practitioners** — they all implicitly assume you
will do the thorough thing, every time, and leave you to work out on your
own that the thorough thing frequently isn't worth it.

Recommendation: make it **a fourth recurring callout type**, alongside
*A different lens*, *For the ML/DS crowd*, and the Bayes Factor note, and
add it to `BOOK_PLAN.md` §1a.

It has two jobs, and the second is the one that makes it more than
permission to be lazy:

1.  **When to skip this** — the conditions under which the plain version
    is good enough, stated concretely enough to act on.
2.  **What to say if you skipped it** — because knowing the technique
    changes what you're entitled to claim even when you don't use it.

### Naming it

| Candidate | Notes |
|---|---|
| **"When you can skip this"** *(recommended)* | Plain and slightly wry, which matches the book's existing headers ("The mistake everyone makes once", "What to say when someone asks why the number changed"). Reads as confidence rather than permission — only someone who knows the technique well gets to say this. |
| "Is this worth it?" | Neutral, a bit limp. Doesn't carry the second job. |
| "By design, not by default" | Your phrase, and the best *content* of the three — but long as a repeating header and slightly abstract as a signpost. Better used as a line *inside* the callouts than as their title. |

Suggested type: `::: callout-tip`, matching *For the ML/DS crowd* — it's
guidance rather than a warning.

### A worked example, so you can judge the voice

For the measurement error chapter:

```markdown
::: callout-tip
## When you can skip this

Most of this chapter is unnecessary most of the time, and it's worth
being able to say why rather than skipping it out of habit.

**Skip it when your predictor is system-generated.** Tenure, absence
days, headcount and salary come out of a system of record with a
reliability close to 1. Nothing here applies to them.

**Skip it when you're ranking rather than estimating.** Attenuation
shrinks every coefficient by roughly the same factor, so if the question
is "which of these matters most?" the order is largely unaffected. If the
question is "how much would a one-point improvement be worth?", it isn't.

**Don't skip it when a number is going to be acted on** — a business case
built on the estimated return to an engagement programme, or an effect
size going into a model that allocates budget. That's where a coefficient
halved by measurement error turns into a real decision made on a wrong
number.

And if you skip it, say so. "This uses the engagement score as recorded;
because that measure is only moderately reliable, the effect here is more
likely understated than overstated" costs one sentence, and it's the
difference between a simplification and an omission.
:::
```

### Where it would earn its place

Best-fit chapters, on a first pass — used where genuinely relevant, not
everywhere, consistent with the existing convention:

- **Measurement error** — as above; possibly the strongest instance.
- **Empirical Bayes / Shrinkage** — when a raw league table is fine
  because the groups are large and similar.
- **Multilevel models** — when complete pooling genuinely suffices.
- **Causal designs** — when the association is all the decision needs,
  because nobody is going to intervene on it anyway.
- **Model Building as Craft** — where the principle is stated in full,
  since the whole chapter is about judgement.

Probably *not* in Chapters 1–10. In the beginner path, "you can skip
this" is noise — they should be doing the simple thing, and the book is
already telling them to.

---

## Proposed `BOOK_PLAN.md` §1a addition

```markdown
- **`::: callout-tip` — "When you can skip this".** The counterweight to the
  rest of the book. Practitioners cannot apply every technique on every
  project, and starting simple is frequently where the value is — the
  thorough version often can't be justified by the extra value it
  creates. The purpose of teaching a technique is therefore as much to
  let a reader skip it *by design rather than by default* as to have them
  use it. Each instance does two things: states the conditions under
  which the plain version is good enough, and gives the sentence to say
  when reporting a result produced without it. Belongs in Part IV and
  Part V, where the reader is choosing what to do; not in Chapters 1–10,
  where they should be doing the simple thing anyway.
```

---

## Summary of what changes

| Item | Was | Now |
|---|---|---|
| Interactions | section in Ch. 7 | one flag paragraph in Ch. 7; treatment in the craft chapter |
| Non-linearity | section in Ch. 6 | one flag paragraph in Ch. 6; treatment in the craft chapter |
| Correlated predictors | "somewhere in 6/7" | craft chapter |
| Multinomial | Ch. 12 | Ch. 12 — unchanged |
| Crossed / repeated measures | "Ch. 8 or Ch. 12" | Ch. 12, resolved |
| Craft as a whole | distributed | new Part IV chapter |
| Proportionality principle | not planned | fourth recurring callout, book-wide |
| Chapter count | 22 | 23 |

Items 18 and 19 in `CHANGE-LIST-welcome-to-ch08.md` should be treated as
superseded by this; items 15 and 16 shrink from **L** to **S**.
