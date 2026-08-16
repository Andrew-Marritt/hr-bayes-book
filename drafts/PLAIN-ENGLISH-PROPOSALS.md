# Plain English: proposed changes

A full-book scan for language that a reader with English as a second
language has to stop and decode. Nothing here has been applied.

Each item has an ID. Reply with accept / change / decline against the
IDs, and I'll apply the accepted ones in one pass.

---

## The test I applied

Not "remove all figurative language" — that would flatten the voice, and
the voice is doing real work.

The test is narrower:

> **Does the reader have to understand the metaphor in order to
> understand the point?**

If the meaning is also stated plainly nearby, the metaphor is decoration
and it stays. If the metaphor *is* the explanation, it goes. That's the
distinction that made "Fitting the models is the smaller half" worth
changing and "under the hood of a car" not worth panicking about.

Two secondary tests:

- **Frequency.** A phrase in a recurring header or chapter title costs
  the reader every time it appears. Higher bar.
- **Culture-specific origin.** Idioms from British sport, American
  sport, cricket, baseball, war or hunting are opaque even to fluent
  speakers from another country.

---

## A. Recurring and structural

These affect many places at once, so they're worth deciding first.

### A1 — Chapter 11's title: "Under the Hood"

**Currently:** `# Under the Hood: MCMC & Trustworthy Models`
(also in `index.qmd` line 411 and the sidebar navigation)

**Proposed:** `# Inside the Sampler: MCMC & Trustworthy Models`

A car-engine metaphor, and American English at that — British English
would be "under the bonnet", which tells you how localised it is. It
appears in the navigation on every page of the book.

*Lowest confidence item in this document.* "Under the hood" is very
widely used in software English and you may simply like it. But it's a
chapter title, so it's the single most-repeated phrase in the book.

CHANGE

### A2 — The "On the job" recurring header (23 chapters)

**Proposed: keep.** Two words, appears in every chapter, and `index.qmd`
explains it on first encounter. Repetition makes it learnable — by
Chapter 3 it's a label, not an idiom.

Listed here so you know it was considered rather than missed.

KEEP

### A3 — The sentence in `index.qmd` that explains it

`index.qmd:344`

**Currently:**

> **"On the job"** closes each chapter by landing the technique in a real
> decision — what you'd actually say to a stakeholder…

**Proposed:**

> **"On the job"** closes each chapter by connecting the technique to a
> real decision — what you'd actually say to a stakeholder…

This is the sentence that teaches the reader what the header means, so
it's the one place it should be unambiguous.
AGREE

### A4 — "league table" (21 uses, Chapters 8 and 14)

**Proposed: keep.** British English, and the American equivalent would be
"leaderboard" — but Chapter 8 introduces it with a full worked
description before using it as a term:

> Someone runs the numbers on manager assessment scores by office, sorts
> them descending, and puts the table on a slide…

That's a definition by example, and it arrives before the phrase is
relied on. It's also central to the framing of two chapters and has no
neutral synonym that isn't clumsy ("ranked table of group averages").

KEEP

### A5 — "rule of thumb" (4 uses)

`04:405` · `05:287` (a header) · `08:150` · `11:159`

**Proposed:** replace with "rough rule" or "a simple rule".

- `05:287` header: "The rule of thumb for a `sigma` prior" → **"A simple
  rule for a `sigma` prior"**
- `11:159`: "Rule of thumb: anything above **1.01** deserves attention."
  → **"As a rough rule: anything above 1.01 deserves attention."**
- `08:150`: "using the range ÷ 4 rule of thumb from Chapter 5" → **"using
  the range ÷ 4 rule from Chapter 5"**
- `04:405`: "inferring one from a rule of thumb" → **"inferring one from
  a rough rule"**

Extremely common in English, and completely opaque if you haven't met
it — there is no thumb involved, and the folk etymology is unpleasant.
Cheap to remove.

SIMPLE RULE

---

## B. Metaphors carrying the meaning

The main list. In each of these, the figure of speech *is* the
explanation.

### B1 — `01:268` "it feels every value"

**Currently:**

> -   The **mean** adds everything and divides — it feels every value,
>     including extreme ones

**Proposed:**

> -   The **mean** adds everything and divides — every value affects it,
>     including extreme ones
CHANGE

### B2 — `01:410` and `01:414` the SD/IQR pair

**Currently:**

> -   **Standard deviation (SD)** — roughly the typical distance from the
>     mean. It pairs with the mean, and like the mean it feels every
>     extreme value.
> -   **Interquartile range (IQR)** — the range covering the middle 50%
>     of the data… It pairs with the median, and like the median it
>     shrugs off extremes.

**Proposed:**

> -   **Standard deviation (SD)** — roughly the typical distance from the
>     mean. It pairs with the mean, and like the mean it is pulled by
>     every extreme value.
> -   **Interquartile range (IQR)** — the range covering the middle 50%
>     of the data… It pairs with the median, and like the median it is
>     barely affected by extremes.

"Shrugs off" is a gesture a reader has to picture and interpret. The
parallel structure survives, which is what makes the pair memorable.
CHANGE

### B3 — `01:721` "eyeballing history"

**Currently:** "That last step — eyeballing history and inferring the
future — is one of the most thoroughly documented weak spots…"

**Proposed:** "That last step — looking at history and inferring the
future — is one of the most thoroughly documented weaknesses…"

Also changes "weak spots" → "weaknesses". Both are mild; this sentence
carries an important argument so it's worth it being effortless.

CHANGE

### B4 — "eyeball" elsewhere (3 more)

- `09:176` "A prior on the log-odds scale is hard to eyeball directly" →
  **"hard to judge by eye"**
- `15:282` "a quantified answer instead of an eyeballed one" → **"instead
  of one based on looking at a chart"**
- `16:308` "not just eyeball predicted numbers" → **"not just look at
  predicted numbers"**

"By eye" is transparent in a way "eyeball" as a verb isn't.
CHANGE

### B5 — `02:259` "trips up almost everybody"

**Currently:** "Both have a catch, and the second catch trips up almost
everybody."

**Proposed:** "Both have a catch, and almost everybody gets the second
one wrong."

("Catch" meaning "hidden difficulty" I'd keep — it's introduced twice in
the same sentence and the section that follows explains exactly what the
catch is.)
CHANGE

### B6 — `03:307` "wearing different clothes"

**Currently:** "…which is the Manchester survey problem again, wearing
different clothes."

**Proposed:** "…which is the Manchester survey problem again, in a
different form."
CHANGE

### B7 — `04:69` "three questions wearing a single coat"

**Currently:**

> "Are we promoting enough?" is really at least three questions wearing
> a single coat:

**Proposed:**

> "Are we promoting enough?" is really at least three separate questions
> hidden inside one:

CHANGE

### B8 — `07:478` "wearing a more technical outfit"

**Currently:** "That's the same overconfidence the whole chapter is
warning about, just wearing a more technical outfit."

**Proposed:** "That's the same overconfidence the whole chapter is
warning about, just described in more technical language."

*Note on B6–B8:* the clothing metaphor recurs three times across three
chapters, which suggests it's a habit rather than a choice. Worth
deciding as a set.
CHANGE


### B9 — `05:398` "in the right ballpark"

**Currently:** "…and asks: *is this in the right ballpark?*"

**Proposed:** "…and asks: *are these numbers roughly the right size?*"

American baseball. One of the least transportable idioms in the book,
and it's carrying the whole meaning of a prior predictive check.
CHANGE

### B10 — `06:430` header "Which number is actually load-bearing"

**Proposed:** **"Which number the decision actually rests on"**

Architectural metaphor. The section is about which part of the estimate
the recommendation depends on, which the proposed header says directly.
CHANGE

### B11 — `06:36` "$1,500 a head"

**Currently:** "There's a proposal attached, and it isn't cheap:
**$1,500 a head**, for every salesperson on the team."

**Proposed:** "There's a proposal attached, and it isn't cheap:
**$1,500 per person**, for every salesperson on the team."
CHANGE

"A head" for "per person" is idiomatic and slightly odd out of context.
"Per person" also removes the redundancy with the clause that follows.

### B12 — `06:18` "does it start to bite"

**Currently:** "Do larger teams perform worse than small ones, and from
what size does it start to bite?"

**Proposed:** "Do larger teams perform worse than small ones, and from
what size does it start to matter?"
CHANGE

### B13 — "bite" elsewhere (2 more)

- `04:329` "Worth knowing before it bites you" → **"Worth knowing before
  it catches you out"** … or, plainer, **"Worth knowing before it causes
  a problem"**
- `20:191` "This one bites constantly in People Analytics" → **"This one
  causes problems constantly in People Analytics"**
CHANGE. PICK THE SIMPLESE

### B14 — `13:147` "swamps them"

**Currently:** "A small city's real data gets outweighed by these
imaginary managers; a large city's real data swamps them."

**Proposed:** "A small city's real data gets outweighed by these
imaginary managers; a large city's real data overwhelms them."

"Outweighed / overwhelms" keeps the escalation without the flood image.
I'M OK WITH SWAMPS - KEEP

### B15 — `14:70` header "The problem: a league table that lies"

**Proposed:** **"The problem: a league table that misleads"**

A table cannot lie — lying requires intent. "Misleads" is both plainer
and more accurate, since the chapter's argument is that the table is
*arithmetically correct* and still wrong.

CHANGE

### B16 — `05:720` "The flip side of this flexibility"

**Currently:** "The flip side of this flexibility is the temptation to go
hunting — trying widths and thresholds until one looks decisive."

**Proposed:** "The risk that comes with this flexibility is the
temptation to go looking — trying widths and thresholds until one looks
decisive."

Two changes: "flip side" (coin metaphor) and "go hunting". The second is
borderline — "go looking" is plainer and loses very little.
CHANGE

### B17 — `22:220` "A practical gotcha"

**Currently:** "## A practical gotcha: don't let an elicited value sit
exactly on the bound"

**Proposed:** "## A practical trap: don't let an elicited value sit
exactly on the bound"

"Gotcha" is informal American English and won't be in most
second-language vocabularies. "Trap" is used elsewhere in the book for
the same idea, so this also improves consistency.
CHANGE

### B18 — `16:444` "out of the box"

**Currently:** "…isn't a `brms` family out of the box — `flexsurvcure`
is the standard R…"

**Proposed:** "…isn't a `brms` family as standard — `flexsurvcure` is
the standard R…"

Or "…isn't built into `brms` —" to avoid repeating "standard".
CHANGE

### B19 — `07:209` "nobody in the room catches it"

**Currently:** "…and because the numbers look plausible either way,
nobody in the room catches it."

**Proposed:** "…and because the numbers look plausible either way, nobody
in the meeting notices."
CHANGE

### B20 — `13:359` "the most persuasive one in the room"

**Currently:** "…and it's usually the most persuasive one in the room —
**your own history**."

**Proposed:** "…and it's usually the most persuasive one in a meeting —
**your own history**."

*Note on B19–B20:* "in the room" appears four times. `09:343` ("axes
anyone in the room can read") and `13:395` ("defensible to anyone in the
room") are clear enough from context — the room is obviously a meeting —
so I'd leave those two.
ACCEPT CHANGES NOT SURE I LIKE AXES THOUGH

---

## C. Borderline: flagged, but I'd leave them

Listed so the decision is explicit rather than accidental. Say the word
on any of these and I'll change them too.

### C1 — `11:130` "Look for the fuzzy caterpillar"

Genuinely opaque as an image, *and* it is the established term of art
that every other MCMC resource uses. A reader who learns it here can
follow a Stan forum thread tomorrow. The callout also explains what
healthy chains look like in plain terms immediately below, so the
metaphor is a label, not the explanation.

**Keep** — but worth adding four words on first use: "…what practitioners
call a *fuzzy caterpillar*", to signal it's borrowed jargon rather than
your description.
KEEP

### C2 — `03:578` "The square root is why precision is expensive"

Economic metaphor, but the section immediately quantifies the cost in
sample sizes, so the metaphor is introduced and then cashed out. **Keep.**
KEEP
### C3 — `01:747` "The story arrives before the evidence"

A deliberate rhetorical line in a section about human judgement, and the
sentences after it explain exactly what it means. **Keep.**
KEEP
### C4 — "recipe", "toolkit", "shortcut", "trap", "bridge chapter"

All are dead metaphors — so conventional that they function as ordinary
vocabulary, and all appear in intermediate ESL vocabulary lists.
**Keep all.**
KEEP
### C5 — "warmup", "chains", "sampler", "shrinkage", "pooling"

Technical terms that happen to be metaphors. Every one is defined at
first use and is the word the wider literature uses. **Keep all.**
TECHNICAL - KEEP
---

## D. One pattern worth noticing

Three of the proposals above (B6, B7, B8) are the same clothing metaphor
in three different chapters, and two more (B12, B13) are "bite". Neither
is a problem in a single instance; both become a small stylistic tic
across a whole book, and a reader who doesn't have the idiom meets it
repeatedly.

If you'd rather not change them individually, the alternative is to
change two of the three and leave one — the repetition is more of an
issue than any single use.
CAN YOU CHANGE
---

## Summary

| Section | Items | If all accepted |
|---|---|---|
| A — recurring/structural | 5 | 1 chapter title, 1 sentence, 4 phrase swaps |
| B — metaphor carries meaning | 20 | ~26 individual edits |
| C — flagged, recommend keeping | 5 | 0 (plus 4 words added at C1) |

None of the B items touches code, chunk labels, chart titles or
technical terms. All are prose.
