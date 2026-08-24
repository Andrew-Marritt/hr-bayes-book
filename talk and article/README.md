# Elicit — a stakeholder elicitation app

A lightweight Shiny front end for SHELF's quartile method, built for the moment
you are sitting opposite a Head of L&D or a finance business partner and want
their judgement in a form a model can use — with the feedback loop that makes it
worth doing.

Companion to Chapter 23. Four things it does that a generic tool doesn't:

**It enforces the order.** The median and quartile inputs stay locked until the
plausible limits are entered. That is not decoration — asking for a central
estimate first anchors everything after it, and the whole point of the quartile
method is that the range comes first. The app makes it impossible to get wrong
in front of a stakeholder.

**It marks what they didn't say.** The feedback table flags which percentiles
came from them and which are the fit's interpolation. The interpolated ones are
what you read back: *"this says a one-in-ten chance it comes in below £4,000 —
does that sound right?"* If they balk, change a number and watch it move. That
loop is where the value is; skipping it defeats the exercise.

**It shades.** A "chance it's above ___" box, answered from draws. This is the
question stakeholders actually ask, and it makes the point that once you have a
distribution, every new question is a new shading rather than a new analysis.

**It argues for bounded families.** By default it only offers families that
respect the limits, and when your choice isn't the closest fit it says so and
explains the trade. A family that fits three points beautifully and then puts
mass on impossible values is worse than a slightly looser one that can't.

---

## Running it

```r
install.packages(c("shiny", "SHELF", "ggplot2"))
shiny::runApp("app.R")
```

For a client meeting, host it rather than running locally — `shinyapps.io`'s
free tier is more than enough and it means you don't need R on whichever laptop
is plugged into the projector.

---

## Before you rely on it — a five-minute check

I wrote this without a working SHELF install, so the SHELF-facing calls are
written from the documented API and defensively (the app matches family names
loosely and degrades rather than erroring if something is named differently in
your version). The pure logic is unit-tested and passes. **The SHELF-dependent
parts need one run on your machine.**

Paste this and send me the output — it tells me everything I can't see:

```r
library(SHELF)
f <- fitdist(vals = c(10000, 15000, 23000), probs = c(0.25, 0.5, 0.75),
             lower = -20000, upper = 90000)
names(f)                              # which parameter tables exist, and their casing
str(f$ssq)                            # is ssq a data.frame? what are its columns?
colnames(sampleFit(f, n = 10))        # the sampleFit alias names
packageVersion("SHELF")
```

If `names(f)` or the `sampleFit` columns differ from what I assumed, the app
should still work — but the "this isn't the closest fit" note may go quiet, and
that note is doing real work. One line fixes it once I see the output.

Two other things worth trying by hand before a live demo:

- Enter limits with a **negative** lower bound (the net-cost case: some
  departures save you money). The app should be fine; the plot's x-axis
  formatting is the bit I'd eyeball.
- Save three experts with deliberately **conflicting confident** views — say
  medians of 3, 12 and 3.5 with tight ranges. You should get the two-humps
  warning. That warning is the most useful thing in the Compare tab.

---

## Note: SHELF has its own app

`SHELF::elicit()` launches a Shiny interface that does the fitting. It's good,
and for your own work it may be all you need. It is not built for a stakeholder
meeting: it's laid out as a statistical tool, it doesn't enforce limits-first,
it doesn't frame the questions in the words you'd actually say out loud, and it
has no "what's the chance it's above X" box. Worth mentioning from the stage
that the underlying package ships one — it makes the point that none of this is
proprietary.

---

## The demo, and my recommendation

**Do it live, with the room — don't play a recording of yourself using it.**

A screen recording of someone typing five numbers into a form is dull, and it
shows the wrong thing. The interesting moment in an elicitation is not the
fitting. It's the human beat where somebody sees their own belief drawn as a
curve and says *"no, that's not what I meant."* On a recording, that happens to
a stranger. Live, it happens to them.

It costs ninety seconds and it's the single most memorable thing you can do in a
meetup talk. It also does more for your "conversations about work" goal than any
slide: people remember the person who ran an exercise with them.

### The protocol — hard-capped at 90 seconds

Elicit **the net cost of one departure**. Two reasons: everyone in the room has
an opinion, and it is the exact quantity Chapter 24 needs — so when the cost
distribution appears in your finale at minute 21, *it is theirs*. That loop is
free and it is worth a lot.

1. **Set it up (10s).** *"Think about your own organisation. A mid-level person
   resigns and you replace them. What does it cost you, net of what you stop
   paying them?"*
2. **Limits first (25s).** *"Don't tell me your best guess. Tell me a number
   you'd be astonished to be below — and one you'd be astonished to be above."*
   Take two shouted numbers. Don't negotiate, don't average, just take them.
3. **Median (15s).** *"Now — what's the figure it's equally likely to be above
   or below?"* Take one. Type all three in.
4. **Show the curve (10s).** Say nothing for a beat and let them look at it.
5. **The payoff (30s).** Shade it. *"So what you've just told me is there's a
   one-in-four chance it's above £X. Hands up if that feels too high."* Hands
   will go up. That is the feedback loop happening in public, and it's the whole
   argument for the method.
6. **Land it.** *"That took ninety seconds. It isn't a guess and it isn't a
   spreadsheet — and it's now a number your finance partner can argue with,
   which is the only kind worth having."*

### Fallbacks, in order

- **A screenshot slide** of the fitted result using plausible numbers, sitting
  in the deck as the next slide. If the app doesn't launch, you talk over the
  screenshot and nobody knows.
- **A 45-second recording** of the same flow, muted, as a backup slide. Make it
  anyway — you'll want it for LinkedIn regardless.
- **Do it on paper.** Ask the three questions, sketch the curve on a flipchart.
  The method is the point, not the software.

### If you'd rather not do it live

Then record it as a **conversation**, not a screencast — you asking someone the
three questions, their face when the curve appears, and them changing an answer.
Two minutes of that is worth ten of a cursor moving around a form. But it's more
production work than a talk this size justifies, which is the other argument for
doing it live.

---

## What's deliberately not in here

- **The roulette/chips method.** Better with a whiteboard and a group, and it
  doesn't need software.
- **Prior predictive checks.** Chapter 23 is right that you should show the
  expert what their prior implies about an actual outcome, not just about the
  parameter — but that needs the model attached, so it belongs in the analysis,
  not in the elicitation tool.
- **Cooke's classical model** (weighting experts by calibration against seed
  questions). It's the most interesting idea in the area and it would be a good
  v2 — but it needs a seed-question bank, and "the most senior voice in the room
  can be formally worth nothing" is a conversation to have before you build the
  feature, not after.
