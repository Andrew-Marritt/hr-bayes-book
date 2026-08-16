# Callout density: proposed changes

Following the Chapter 5 note — "too many callouts isn't pleasant to
read". Nothing here has been applied. IDs for accept / change / decline.

---

## The finding

64 places in the book where one callout closes and another opens within
three lines. But they are not 64 independent problems. **Half of them are
one structural habit, repeated.**

The test I've used, taken from the decision you made in Chapter 5:

> **A definition or an aside stays in a box. An argument becomes prose.**

Plus a size rule: two boxes together are only a problem when *both* are
long. A 20-word "the point" after a 150-word note is fine — it's the
punchline, and the contrast is doing work.

Counting only pairs where both callouts are 55+ words: **34 pairs**, and
32 of those are in Chapters 6 onward.

---

## A. The dominant pattern — and the one worth fixing first

**"A different lens" immediately followed by "For the ML/DS crowd".**

| ID | Chapter | Lines | Words |
|---|---|---|---|
| A1 | 13 Empirical Bayes | 181–218 | 142 + 151 |
| A2 | 15 Pay and Variance | 211–241 | 105 + 115 |
| A3 | 16 Survival | 310–342 | 128 + 111 |
| A4 | 17 Likert | 235–265 | 95 + 120 |
| A5 | 18 Measurement Error | 205–241 | 135 + 126 |
| A6 | 20 DAGs | 306–345 | 144 + 146 |
| A7 | 21 Causal Designs | 610–650 | 167 + 126 |
| A8 | 22 Elicitation | 475–501 | 67 + 92 |

Eight chapters, same shape every time: roughly 250 words of unbroken
boxed text, of which — by design — **at least one box is addressed to
somebody who isn't this reader.** A frequentist reader is told to skip
the ML box; an ML reader is told to skip the lens box. Placing them
together means every reader meets a wall of boxes and is invited to skip
half of it.

**Proposed fix: separate them rather than remove either.** Neither box is
the problem; the pairing is. Each should sit at the point in the chapter
where its content is relevant:

- *"A different lens"* belongs where the classical reader's instinct
  would fire — usually just after the model is fitted and interpreted,
  where they'd be thinking "isn't this just a t-test?"
- *"For the ML/DS crowd"* belongs where the ML analogy actually helps —
  often earlier, at the point the mechanism is introduced, since these
  boxes generally explain *how the technique works* by analogy.

In most of the eight, moving the ML box **earlier** by one or two
sections does it. No words change.
AGREE

**A9 — the same problem with a different first box.** Four more chapters
put a long callout immediately before "For the ML/DS crowd": Ch. 4
(709–742), Ch. 7 (463–491), Ch. 19 (244–276), Ch. 22 (145–171). Same
remedy.

If you accept the principle, I'd treat A1–A9 as one decision and apply it
across all twelve.
AGREE
---

## B. Long "important" followed by long anything

`callout-important` is defined in the Welcome as *"if you read nothing
else on a page, read these"*. That promise weakens when the box is 150+
words and is immediately followed by another box.

| ID | Chapter | Lines | The pair | Proposal |
|---|---|---|---|---|
| B1 | 8 | 348–383 | 58w note → **168w important** ("Six groups is not many") | The important is an argument, not a punchline. Convert to prose under a `###`; keep the note boxed. |
| B2 | 8 | 361–398 | 168w important → 93w tip | Resolved by B1. |
| B3 | 18 | 326–363 | **192w important** ("Noise and bias…") → 82w note | This is the chapter's central argument. It should be body text, with maybe one sentence pulled out as a short `important`. |
| B4 | 20 | 481–520 | **158w important** ("So the adjustment was pointless?") → 118w note | Mine. The first is the chapter's payoff and should be prose; the second ("What to say when it *does* move") is genuinely an aside and stays boxed. |
| B5 | 21 | 755–787 | **153w important** ("The two columns nobody reports") → 97w tip | Same: the important is the argument. Prose. |
| B6 | 4 | 445–474 | **175w important** ("Theory in, scepticism intact") → 24w note | The 24-word note is fine as a box. Convert the 175-word important to prose. |
| B7 | 5 | 372–399 | **184w important** ("Plotting is how you audit yourself") → 24w note | Same shape as B6. |
| B8 | 6 | 429–466 | **151w important** ("Which number is load-bearing") → 99w tip | Convert the important to prose; the tip is a genuine forward-pointing aside. |

Common thread: **a long `important` is almost always an argument that has
been boxed for emphasis.** Emphasis by boxing works when the box is
short. At 150+ words it just moves the argument into a coloured
rectangle.
AGREE - PLEASE CHANGE
---

## C. Individual cases

| ID | Chapter | Lines | Issue | Proposal |
|---|---|---|---|---|
| C1 | 18 | 427–548 | 183w important → **483w note** ("A worked (illustrative) example") | 483 words is the longest box in the book. The "worked example" device is established in Ch. 13, so the device is fine — but at this length it should be a `###` section with the callout reserved for the setup. Mine. |

CHANGE
| C2 | 18 | 454–572 | that 483w note → 138w note ("A naming trap") | Resolved by C1. |

| C3 | 22 | 219–259 | 147w important → 139w note → 90w tip | **Three long boxes in a row**, the worst run in the book. At least one should be prose; I'd suggest the middle ("The fuller version: a Delphi-style round"), which is a description of a method rather than an aside. | AGREE
| C4 | 22 | 345–384 | 89w tip → 98w important → 85w note | Also three in a row. "Reading this table" reads like body text that lost its heading. | AGREE
| C5 | 21 | 775–803 | 97w tip → 107w tip ("Try it yourself") | Two tips together blurs the type. Put prose between them, or make the first one prose. |AGREE
| C6 | 7 | 283–313 | 59w tip → 87w note → 63w note | Three boxes; the two notes are both about classical equivalents and could merge into one. | AGREE
| C7 | 13 | 199–231 | 151w tip → 89w note | Resolved if A1 is applied. | AGREE
| C8 | 14 | 173–214 | 74w note → 133w note → 73w tip | "Reading this formula" is explanation of the code above it — that's body text. | AGREE
| C9 | 17 | 105–124 | 69w important → 75w note ("To be fair to the shortcut") | The note is a fair-minded qualification of the important. Reads better as the next paragraph. |
| C10 | 3 | 481–501 | 56w important → 84w note | Borderline; lowest priority here. |

---

## D. Deliberate — leave alone

**D1 — `index.qmd` lines 247–282, four consecutive callouts.** This is
the "About this book" section *demonstrating* each callout type. They
have to be adjacent; that's the point. **Keep.** IS IT POSSIBLE TO HAVE 4 DIFFERENT COLOURS (SO ADD A YELLOW OR ORANGE FOR EXAMPLE?) THIS WOULD THEN APPLY THROUGHOUT

**D2 — every pair where one box is under ~35 words.** Roughly 20 of the
64. A short box next to a long one is a rhythm change, not a wall. This
covers Ch. 1 (166–191), Ch. 10 (71–95), Ch. 11 (144–160), Ch. 16
(145–163), Ch. 15 (247–270) and others. **Keep.**
AGREE
---

## E. The underlying question

Worth deciding once, because it would prevent this recurring:

The book currently has **~290 callouts across 22 chapters** — a mean of
13 per chapter, with Chapter 5 at 27 and Chapter 3 at 23. That is a lot
of boxed text, and boxing is the book's main emphasis device, so its
power is inversely proportional to how often it's used.

A rule of the kind already in `BOOK_PLAN.md` §1a would settle it. My
suggestion:

> **A callout is for something the reader can skip without losing the
> thread**: a definition, an aside, a translation for a particular
> background, an exercise, or one sentence of emphasis. If a box is
> carrying an argument the chapter depends on, it is body text with a
> heading. As a rough size guide, an `important` over about 60 words is
> probably an argument.

If you accept that, A and B follow almost mechanically, and I can apply
both in one pass.
AGREE
---

## Summary

| Section | Items | Effort |
|---|---|---|
| A — separate the two audience boxes | 9 (12 chapters) | Moving blocks; no rewriting |
| B — long `important` → prose | 8 | Unwrap, add `###` heading |
| C — individual | 10 | Case by case |
| D — leave | ~21 | none |

A is the highest value for the least work, and it's the one your Chapter
5 instinct points at most directly.

---

# F. The colour idea — and what the theme is actually doing

Answering D1: **yes, and it matters more than the demo section.**

## What I found in `theme/academicdesign-doc.scss`

```scss
.callout-note   { border-left-color: $navy-800 }   // #122a52
.callout-note   .callout-title { background: $navy-50 }

.callout-tip    { border-left-color: #3d68a8 }     // also navy
.callout-tip    .callout-title { background: $navy-50 }   // SAME as note

.callout-important { border-left-color: $red-600 }
.callout-important .callout-title { background: $red-50 }

.callout-warning { border-left-color: $red-600 }          // SAME as important
.callout-warning .callout-title { background: $red-50 }   // SAME as important
```

Two collisions, both invisible in the source and obvious on the page:

1. **`note` and `tip` have identical title backgrounds** and two shades of
   navy for the border. On screen they are very nearly the same box.
2. **`warning` is a byte-for-byte clone of `important`.** A fifth type is
   already wired up and currently indistinguishable from the red one.

**This is a contributing cause of the density complaint.** When "A
different lens" (note) is followed by "For the ML/DS crowd" (tip) — the
A1–A8 pattern — the reader sees one continuous pale-navy slab, not two
boxes. The wall is partly a colour problem, not only a length problem.

## What the boxes are actually being asked to do

Quarto gives five types. The book uses three, and those three carry five
distinct roles:

| Role | Count | Currently |
|---|---|---|
| "The point" — read this if nothing else | 147 | `important` |
| "A different lens" — frequentist translation | ~20 | `note` |
| "For the ML/DS crowd" | 16 | `tip` |
| "Try it yourself" — exercises | 10 | `tip` ← collides |
| "When you can skip this" — new | 1 | `tip` ← would collide |
| Plain aside, no header | ~100 | `note` |

Two recurring roles share green, and the new one would have made three.

## Proposed mapping

Semantics chosen so the colour means something rather than being
arbitrary:

| Role | Type | Colour | Why |
|---|---|---|---|
| The point | `important` | coral-red | Unchanged. The book's accent, highest emphasis. |
| A different lens | `note` | navy | Unchanged. The "quiet background" colour. |
| For the ML/DS crowd | `tip` | **teal** | Sits beside navy without merging into it. |
| Try it yourself | `caution` | **amber** | Warm, forward. Says *do something*. |
| When you can skip this | `warning` | **warm grey** | The quietest box in the book, because it is permission to do less. Grey earns its place semantically rather than being a leftover. |

Plain headerless asides stay `note` — sharing navy with "A different
lens" is fine, because the presence or absence of a bold title bar
already separates them.

## The SCSS

Tokens to add near the existing ones:

```scss
$teal-700:  #1a6b5f;
$teal-50:   #eef6f4;
$amber-700: #8a5a00;
$amber-50:  #fdf6e8;
$slate-600: #5b6470;
$slate-50:  #f2f3f5;
```

Replacing the callout block:

```scss
.callout-note      { border-left-color: $navy-800 !important; }
.callout-note      .callout-title { background-color: $navy-50 !important;  color: $navy-900; }

.callout-tip       { border-left-color: $teal-700 !important; }
.callout-tip       .callout-title { background-color: $teal-50 !important;  color: $teal-700; }

.callout-important { border-left-color: $red-600 !important; }
.callout-important .callout-title { background-color: $red-50 !important;   color: $red-700; }

.callout-caution   { border-left-color: $amber-700 !important; }
.callout-caution   .callout-title { background-color: $amber-50 !important; color: $amber-700; }

.callout-warning   { border-left-color: $slate-600 !important; }
.callout-warning   .callout-title { background-color: $slate-50 !important; color: $slate-600; }
```

## Three things to weigh

**The icons will be wrong.** Quarto ships a warning triangle for
`warning` and an exclamation for `caution`, which is odd on "Try it
yourself" and actively misleading on "When you can skip this". Custom
titles already replace the default word, but not the icon. Fix per box
with `::: {.callout-caution icon=false}`, or accept the icons and pick
types to suit them.

**Five colours is the ceiling.** The reader is already learning a
three-colour chart palette (prior / likelihood / posterior). Five box
colours plus three chart colours is a lot of visual vocabulary, and only
works because four of the five have a fixed, repeated, named header. I
would not add a sixth.

**`important` is used 147 times.** No palette fixes that. Sections B and
E are what restore its force; the colours make the remaining boxes
distinguishable from each other.

## Knock-on

- `index.qmd` "About this book" demonstrates the box types. It would
  gain two more, which is exactly the D1 section — and with five genuinely
  different colours, four or five adjacent demo boxes stop looking like a
  wall.
- The ~10 "Try it yourself" boxes change type from `tip` to `caution`.
- `BOOK_PLAN.md` §1a gains the mapping table.
- Nothing else in the book changes.
