# Draft: making the reading design explicit in the Welcome

Three insertions into `index.qmd`. They're separable — you can take any
one without the others — but they work together, because the reading
paths only make sense once the reader knows what the advanced chapters
are *for*.

| # | What | Where |
|---|---|---|
| 1 | **Statistical thinking is the point** — the thesis | New section, after "Not a special case", before "Why I wrote it" |
| 2 | **How to read this** — the three modes | Inside "How the book is organised", after the part listings |
| 3 | **"When not to bother"** — fifth callout type | Inside "About this book" → "The boxes" |

Chapter numbers below use the 23-chapter scheme from
`DECISION-regression-craft.md`.

---

## 1. Statistical thinking is the point

**Placement:** as its own `##` section immediately after "Not a special
case" and before "Why I wrote it".

**Why there.** The AF447 story has just finished, and it is not really a
story about a technique — it's a story about somebody noticing that a
buried assumption ("two failed searches told us nothing") was wrong. That
is the thesis, already demonstrated, and this section names it while the
example is still warm. It also hands off cleanly into "Why I wrote it",
which is personal.

**Header alternatives:** "The part that lasts" · "What I actually want
you to take away". The version below is the most direct and matches the
book's declarative header style ("Not a special case", "The point").

```markdown
## Statistical thinking is the point {.unnumbered}

I said earlier that this is a book to learn statistical thinking rather
than tools. It's worth being specific about what I mean, because it's the
thing I care most about and it isn't what most statistics books are
actually for.

Go back to the search for AF447. The mathematics that found the plane was
not exotic; you'll have met most of it by Chapter 5. What had gone wrong
for two years was not a calculation. It was an assumption nobody had
written down — that a search which finds nothing has told you nothing.
Once somebody questioned that, the answer took a week.

That's the shape of almost every analysis that matters. The technique is
rarely the hard part. The hard part is noticing the assumption you didn't
know you were making.

::: callout-important
If you take one thing from this book, I'd rather it were a habit than a
technique: **the reflex to ask what your numbers are quietly assuming,
and to be genuinely willing to find out you were wrong.**
:::

Bayesian statistics is unusually good at teaching that habit, and I think
this is the real reason it clicks for people in the way the earlier
chapters describe. It makes you write your assumptions down. You cannot
fit a model without stating what you believed beforehand and how strongly
— and once a belief is on the page as a distribution rather than lurking
in a default setting, it becomes something you can look at, argue about,
and change your mind on. That is a very different experience from
applying a test and reading a p-value, where the assumptions are real but
invisible.

The pay-off shows up in ordinary work, well before you're fitting
anything complicated. It's the analyst who asks where a sample came from
before asking what it says. Who wonders how much of a difference between
two teams is measurement noise before writing the recommendation. Who
notices that "we control for performance rating" is a claim about cause
and effect, not a technical detail. None of those are advanced. All of
them are the difference between an analysis that survives contact with a
sceptical room and one that doesn't.

It's also, if I'm honest, the reason I write a newsletter. Techniques are
easy to look up and I have nothing to add to the documentation. Watching
a familiar thing turn out to work differently than everybody assumed —
that's the part worth writing about, and the part worth reading for.
```

---

## 2. How to read this

**Placement:** inside "How the book is organised", after the five part
listings and immediately before the existing "If you only have time for
four chapters" callout.

**Why there.** The reader has just seen twenty-three chapter titles, which
is intimidating without a way to interpret them. This tells them which
ones they're expected to *do*, and — the part that matters to you — why
the rest are still worth reading even if they never run the code.

```markdown
### How to read this {.unnumbered}

Twenty-three chapters is more than anyone needs at once, and they are not
all asking the same thing of you.

**Chapters 1–10 are meant to be done.** Read them in order, with R open,
and type the code out. This is the working path: by the end of Chapter 10
you can take a real question, fit a model that suits it, check it, and
put a defensible answer in front of a stakeholder. That is a complete
skill and for a long time it may be all you need.

**Chapters 11–13 are for when something goes wrong or gets awkward.**
Read Chapter 11 when a model misbehaves and you want to know what the
sampler is doing. Chapter 12 when your outcome stops being a number or a
yes/no. Chapter 13 when a straight line stops looking like the right
shape. Dip in when the problem arrives; there's no need to read them
speculatively.

**Chapters 14–23 are meant to be read, and only sometimes done.** This is
the part I'd push back on if you were planning to skip it until you felt
ready. These chapters cover techniques you may not use this year and
possibly not next — but each one hands you a question that changes how
you read everybody's analysis, including your own:

| Chapter | The question it leaves you with |
|---|---|
| 14–16 | Is this difference real, or is that group just small? |
| 17 | Am I treating "hasn't happened yet" as "didn't happen"? |
| 18 | Is this scale a number, or a set of ordered labels I'm averaging? |
| 19 | How much of this measure is noise — and who's missing from it? |
| 20–22 | Would this still be true if we changed it on purpose? |
| 23 | Whose beliefs went into this, and did anyone check them? |

You can take every one of those questions away without fitting a single
model in those chapters. They cost an evening of reading each and they
change what you notice for good. Fitting the models is the smaller half.

::: callout-tip
Reading a chapter you don't yet need is not wasted. The most useful
outcome is often the ability to recognise a problem you're not going to
solve today — and to say so out loud, which is worth more than a
confident answer that quietly assumed the problem away.
:::
```

**Then keep the existing "If you only have time for four chapters"
callout as-is**, with the one-line addition already in the change list:

> *"and if the question on your desk is whether something caused
> something else, add Chapter 21."*

---

## 3. "When not to bother" — the fifth callout

**Placement:** in "About this book" → "The boxes, and which ones you can
skip", after the *For the ML/DS crowd* example. The lead-in sentence
needs its count updated: "Four kinds recur, and two of them are aimed at
specific readers" → **"Five kinds recur"**.

```markdown
::: callout-tip
## When not to bother

The counterweight to everything else. Nobody applies every technique in
this book to every project, and starting simple is very often where the
value is — a thorough job can't always be justified by the extra it
tells you. These boxes say when the plain version is good enough, and
give you the sentence to use when reporting a result you produced
without the full treatment. **The aim is to skip things by design rather
than by default.**
:::
```

---

## Notes

**This makes the craft decision visible to the reader.** The three
reading modes are the same distinction that decided where the craft
material goes, so the book's structure and its stated reading advice now
agree. That's worth having: a reader who follows the advice is following
the design rather than working around it.

**The table of questions is the load-bearing part of #2.** It's what
converts "read the advanced chapters" from an instruction into an
argument, and it's the thing to attack if any of it feels wrong — each
row should be a question you'd actually want a junior analyst asking in a
meeting, phrased in language they'd use. Worth rewriting in your own
words even if the structure stays.

**One thing I've deliberately not done** is claim the advanced chapters
are easy, or that reading without doing is as good as doing. It isn't,
and saying so would undercut the point. The claim is narrower and I think
defensible: the *question* each chapter raises is separable from the
technique, transfers immediately, and is worth having on its own.

**Filename knock-on.** Under the 23-chapter scheme the drafts need
renaming before integration: `18-measurement-error-missing-data` → 19,
`20-causal-structure-dags` → 21, `21-causal-designs` → 22. Worth doing at
the same time as the renumbering sweep rather than now, since the numbers
are still moving.
