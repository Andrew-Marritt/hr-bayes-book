# Swiss People Analytics Meetup — 25 minutes

## Structure and narrative arc, v2

*Working document. Step 1 of 3 (structure → script → slides). v2 adds the recurring
visual device and gives every example an explicit Bayesian mechanism.*

---

## What changed from v1, and why you were right

v1 gave the audience five better *statistics*. It did not give them one *method*. A
practitioner could have left with "use shrinkage for league tables, survival curves
for attrition" and never connected those to each other or to Bayes — which fails
your goal (b), opening their eyes to a different way of working, and undercuts (c),
because the book is one argument and the talk would have been five tips.

Two changes fix it.

**Every example now names its Bayesian mechanism out loud**, and the five mechanisms
turn out to walk straight through the engine — two of them are about the *prior*, two
about the *likelihood*, one about *what is allowed to be a parameter at all*. That's
a hidden spine the audience will feel without you having to name it.

**One recurring visual grammar**, introduced properly at minute five and then called
back five times. Mockup attached separately — open that alongside this.

---

## The spine, in one sentence

**Every People Analytics decision ends in a yes/no about money, and the number we hand
over can't survive contact with the person who controls it — because we were taught a
method that refuses to put a probability on the thing we don't know.**

---

## The recurring image

### Motif A — the engine (shown once in full, then a small strip)

Three panels: **prior** (pale blue) **+ likelihood** (red) **→ posterior** (navy).

Use the book's own colours — #8fabd0, #d32f2f, #122a52 — which are already the
convention in Chapter 4. That means the deck and the book look like one artefact,
which is worth more than it sounds when someone opens the book that evening and
recognises the pictures.

After minute five this shrinks to a strip in the corner of each of the five examples,
with only the labels changing. It is making one claim visually, and it's the claim
your talk depends on: **every model in here is the same three steps.**

*(One projector note: the pale prior sits at 2.3:1 against white. Keep its outline at
full weight and label the curve directly rather than using a legend key. Red-vs-navy
is comfortably clear under colour blindness — I checked, worst adjacent pair ΔE 21.)*

### Motif B — the payload: shade the bit you care about

This is the ninety seconds that makes the rest of the talk work. One posterior,
revealed four times with different shading:

| | The question | The shading | The sentence |
|---|---|---|---|
| 1 | How much, and how sure? | The middle 95% | *"About $578k a head, and we're 95% sure it's between $525k and $631k."* |
| 2 | Will we clear the bar? | Everything above $600k | *"There's a 21% chance they average above $600k."* |
| 3 | Is the trained group genuinely higher? | Two posteriors; subtract draw by draw | *"A 95% chance they're genuinely ahead, by about $58k."* |
| 4 | Is the gap big enough to act on? | Beyond the $25k you set in advance | *"An 82% chance the uplift beats the $25k we said we'd need."* |

Then the line that carries it:

> **You build the shape once. Every business question after that is a different way of
> shading it.**

And Ch 5's version, which is the one to say out loud because it names the practical
prize your audience actually wants:

> "**If you can phrase a question about that vector, you can answer it** — and you can
> do it after the fact without refitting anything."

Say what that means in a meeting: *someone asks a question you didn't anticipate, and
you answer it while they're still asking, instead of saying you'll come back to them.*
That is the "huge opportunity post-analysis" you were pointing at, and it's the thing
practitioners in the room will most want.

### The contrast slide — put a p-value next to it

Show `p = 0.03` on its own, large, with "Significant. Reject the null." underneath.
Then the shaded posterior beside it. The line:

> **There is nothing here to shade.**

Backed by Ch 20, verbatim:

> "There is no way to ask it 'how likely is the gap bigger than three percentage
> points,' because it only ever tests against exactly zero."

This is the single most efficient "why Bayesian" you have, and it wins the argument
without ever having one — you're not saying the test is wrong, you're showing there's
less of it.

### One caution on "recurring"

Make the **grammar** recurring, not the picture. Five density plots in a row will read
as one slide shown five times and the audience will stop looking. What repeats is: the
palette, the engine strip, the act of shading, and the sentence underneath. What varies
is the form — item 2 is a curve over time, item 3 is stacked category bars, item 4 is
two intervals side by side. Same verb, different noun.

---

## Timed structure

| | | |
|---|---|---|
| **0:00 – 3:30** | The room you have all been in | Ch 24's complaint, the HR Director's question, the shape of the answer |
| **3:30 – 8:00** | The engine, and the shading | AF447 → the two sentences → Motif A → Motif B → the p-value contrast |
| **8:00 – 20:00** | Five things | Four at ~2:45, one deliberately quick |
| **20:00 – 23:30** | Back to the thirty managers | Elicited cost × posterior → impact, shaded above zero |
| **23:30 – 25:00** | The book, and the ask | |

---

## 1. The room you have all been in (0:00 – 3:30)

Unchanged from v1, and it's the right open. Cold, on the slide everybody has made.

> "The first is a correlation dressed as a consequence: *engaged teams sell 21% more*,
> with no account of what would happen if you intervened."
>
> "The second is worse, and more common in board packs: a single confident number.
> *This programme delivered a 3.2x return.* It is arrived at by multiplying point
> estimates together, it carries no uncertainty, and everybody in the room knows it is
> decorative. **The finance function knows it best of all, which is why the number is
> politely received and quietly discounted.**"

Then the HR Director:

> *"We can afford to put about thirty managers through the coaching programme. Which
> thirty, and is it worth doing at all?"*

Then **flash the finale slide** — the impact distribution, shaded above break-even —
for about eight seconds, without explaining it. *"That's where we're going to end up.
There's a 61% chance this pays for itself, and here's the shape of what happens if it
doesn't."* Then take it away.

That flash is worth doing. It plants the image you'll close on, and it makes the
shading device feel like a destination rather than a teaching aid when it arrives at
minute six.

**Then the park**, with Ch 24's own claim doing the work:

> "Expected loss is an average over a probability distribution for the unknown quantity.
> A frequentist analysis does not produce one — a confidence interval is a statement
> about the procedure, not a distribution over the parameter. **So the classical route
> has to substitute a point estimate and lose the uncertainty at exactly the moment it
> matters most.**"

And the number nobody puts on the slide, from Ch 24: of the chosen thirty,
`expected_wrong` comes out near **fourteen**. Close to half the programme is expected
to be money that didn't come back — *said in advance*. Use it here or hold it for the
close; it's your strongest single demonstration that this is a different kind of
honesty.

---

## 2. The engine, and the shading (3:30 – 8:00)

**AF447, told short (90s).** 228 people, two miles down, a search area the size of a
small country. Two sonar searches came back empty. Two years. Then a small team was
asked to build one probability map from everything known — **including the fact that
two previous searches had failed.**

> "A search that finds nothing is not a wasted search. It's evidence — it should make
> you *less* confident that the plane is where you just looked, and by exactly how much
> depends on how thoroughly you looked and how good your sonar was."

Payoff on its own slide: **within one week, they found the wreckage.**

> "'We looked and found nothing' is exactly as much evidence as 'we looked and found
> something.'"

**The two sentences (45s).**

> "A frequentist can tell you that a procedure would bookend the truth 95% of the time,
> and cannot tell you there's a 95% chance the truth lies inside the particular interval
> now in front of you. **Read aloud, those two sentences sound identical. Only one of
> them answers the question that was asked.**"

**Motif A (30s).** Prior, likelihood, posterior — using AF447's own three pieces, which
the book already defines that way (the map before the sweep; this region was swept and
nothing was found; the updated map). Then say the sentence that licenses the next
seventeen minutes: *everything I'm about to show you is these three steps. The only
thing that changes is what goes in the first two boxes.*

**Motif B (90s).** The four shadings. Then the p-value contrast.

**Defuse the prior objection (20s)**, because it will otherwise sit in the room:

> "A Bayesian prior isn't the introduction of bias into a neutral process — it's the act
> of stating the expectation you were carrying anyway, in a form that can be inspected,
> challenged and overruled by data. Compare that with the alternative on offer: **a
> method that claims to use no prior information at all, run by an analyst who has
> plenty and no legitimate place to declare it.**"

**And the naive-historic-reporting point**, which is what most of the room actually
does — 20 seconds, Ch 3:

> "'Our attrition was 14% last year' is a complete and exact description of a year that
> has finished and cannot be changed. **Nobody needs it.**"
>
> "**You have the whole population of people, and a sample of one year from the process
> that generated them.**"

Say explicitly you're not arguing classical statistics is broken — the book doesn't.
You're arguing it answers a different question from the one being asked.

**Transition**, then the Ch 1 licence line before the first example:

> "None of this is stupidity, and pointing it out to stakeholders doesn't help. These
> are the default settings of human intuition working on incomplete information, **and
> analysts have them too**."

---

## 3. Five things (8:00 – 20:00)

Each item now carries four things: the artefact, **the Bayesian mechanism**, **what you
shade**, and the sentence you hand over.

| # | The artefact | The Bayesian move | What you shade | Ch |
|---|---|---|---|---|
| 1 | The manager league table | **Partial pooling** — the prior is *the other managers* | Each manager's posterior against the org line → tiers | 8, 14, 15 |
| 2 | The annual attrition rate | **A posterior over the whole curve**; censored people give partial information | Area under the curve, months 0–9 vs 24–36 | 17 |
| 3 | The survey score | **An ordinal likelihood** — categories modelled as categories | The two "happy" bands → % favourable, with an interval | 18 |
| 4 | The performance rating | **The unmeasured thing becomes a parameter** | Naive vs corrected posterior, side by side | 19 |
| 5 | The number nobody has | **Elicitation — the prior is a person** | The elicited shape → then × the posterior | 23 |

The hidden spine, worth noticing even if you never say it: **1 and 5 are about where a
prior comes from. 2 and 3 are about getting the likelihood right. 4 is about what is
allowed to be a parameter at all.** That's the whole engine, taken apart across five
business problems.

---

### 1 — The league table is partly a league table of team sizes (2:45)

**The number**, which needs no explanation at all:

> "A manager with 3 reports and 1 transfer request has a raw rate of **33%** — worse
> than almost anyone else in the company on paper. A manager with 80 reports and 5
> transfer requests has a raw rate of just **6%**. **Is the first manager really eight
> times worse?**"

**The scale of it** (Ch 8):

> "Around **2%** of the variation in test scores sits between offices. The other **98%**
> sits between people working in the same office. A league table of office averages is
> **a ranking of the 2%, presented as though it were the whole story.**"

**The mechanism, said plainly.** This is where the engine strip earns its place — the
prior here isn't a guess, it's the other 570 managers:

> "The model doesn't just ask how much data each office has — **it also learns from the
> offices collectively how different offices tend to be**, and uses that to judge how
> seriously to take any individual one. **No single office could work this out alone.**"

And the consequence, which is the bit people find magic:

> "**Nobody set a threshold, nobody dropped a small office, and nobody had to argue
> about where the cut-off should sit.**"

**The shading.** Every manager now has their own posterior. Shade the part that sits
below the organisation-wide line, and that probability *is* the tier. Three tiers —
clearly above / not distinguishable / clearly below — are four hundred shadings, done
at once.

> "**Most managers, once you're honest about uncertainty, are not distinguishable from
> average — and that's a finding, not a disappointment.**"

**The twist, 20 seconds, and nobody will have thought of it:**

> "Sorting descending puts whichever group got the luckiest draw at the top, and small
> groups get lucky more often than large ones. **The top of a league table is therefore
> *systematically* enriched with small groups — and they are the ones most likely to
> look ordinary again next year.**"

…which is why the worst team improves after your intervention, and you get the credit.

**The constructive close:** *"You can have a league table — just not one built from raw
averages."*

**One line for the doctorates**, if you want it: no multiple-comparisons correction is
needed here, because "**a credible interval doesn't change when you look at another
one.**" Fifteen pairwise comparisons and nothing to correct. It's a real technical
difference and it costs you fifteen seconds.

---

### 2 — The annual rate has averaged away the only thing that mattered (2:45)

**The scene, verbatim — the COO who has already decided what to do:**

> *"We're at 18% and I want it under 12. I've got budget for one thing — either we fix
> onboarding or we fix the two-to-three year mark where I'm told people get itchy.
> Which one?"*

**The demolition, verbatim:**

> "**The 18% is a single annual rate, and it cannot answer his question, because it has
> averaged away the only thing that distinguishes the two options: *when* people
> leave.** A model that predicts *whether* someone leaves can't answer it either — it
> has thrown the timing away too."

**The mechanism.** Two parts, and the second is the one practitioners haven't met.
First: you don't get a curve, you get thousands of curves — a posterior over the whole
shape. Second: everyone still employed when you pulled the data is **censored, not a
clean zero**. Coding them "didn't leave" quietly assumes you know they never will. The
three-employee table from Ch 17 makes this visible in fifteen seconds.

**This is your best shading demonstration, and I'd give it the extra thirty seconds.**
The COO's question — onboarding or the two-year mark — is answered by shading two
regions under the curve, computing the difference on every draw, and reading off a
probability. *"There's an 84% chance more departures sit in the first nine months than
in months 24 to 36. Fund onboarding."*

Then land the general point:

> Nobody specified that question when the model was fitted. **The model didn't know he
> was going to ask. You can answer it in the meeting.**

That is the payload sequence arriving in a real decision, and it's the moment the
audience understands why the shading grammar matters rather than just following it.

---

### 3 — "3.6" is not an answer anybody gave (1:30 — the quick one)

By now the audience has the pattern, so this one doesn't need the full treatment. Run
it fast.

**The scene, verbatim — the CHRO:**

> *"Management came out at 3.1 and benefits at 3.4, so the deck says benefits are in
> better shape. Fine. But I have money for one programme next year. Which of these
> actually moves how people feel about working here?"*

**One line of demolition:** *"which scores highest" is not the same as "which matters
most"* — and:

> "**The deeper problem is that '3.6' is not an answer anybody gave. There is no
> response category between 'somewhat happy' and 'very happy'.**"

**The mechanism, one sentence:** model the categories as categories, and the posterior
comes back as a probability for each answer people actually chose.

**The shading, and here the form changes — stacked bars, not a density.** Shade the two
happy categories. That's "% favourable" — the number everyone in the room already
reports — except now it has an interval on it, and you can watch the whole distribution
shift as management perception improves.

**The caveat, which costs one sentence and buys you the doctorates:**

> "Treating a Likert item as continuous **isn't always wrong in practice** … **The risk
> rises exactly where engagement data usually sits: few categories, heavily skewed
> toward the positive end.**"

---

### 4 — Half of your performance rating isn't about the person (2:45)

The most arresting item, and the one to handle most carefully — it lands on people's own
managers.

> "The meta-analytic literature puts the inter-rater reliability of supervisor
> performance ratings at around **0.52** — meaning that when two managers rate the same
> person, **roughly half the variance in the rating has nothing to do with the person
> being rated.**"
>
> "**The error is the same size as the signal.** … **a one-rating-point gap between two
> employees is close to a coin flip.**"

**The mechanism, and this is the purest statement of the Bayesian move in the whole
book:**

> "**An unobserved quantity is just another parameter — give it a model rather than a
> guess.**"

Spell out what that means, because it's the moment the method stops being about
statistics and becomes about honesty. You have three options for something you didn't
measure properly: pretend the column is the truth, delete the rows, or **give it a
distribution and carry the uncertainty through**. Only the third one is available to
you, and it's the same move as the prior — a thing you don't know, represented as a
shape rather than a number.

**The shading, and again the form changes — two intervals side by side, not a density.**
The naive estimate and the corrected one:

> "the coefficient is **larger** than the naive version … And the interval is
> **wider** … **Both directions are correct. A method that made the estimate bigger
> *and* more precise would be selling you something.**"

**The consequence — pick one.** I'd take the first; it's more surprising and less
personal:

- "'**Engagement explains surprisingly little of performance' is one of the most-repeated
  findings in the field. Some of it is real. A good deal of it is arithmetic.**" The
  attenuation is exact: 0.5 × 0.52 = 0.26.
- Or the harder one: calibration sessions target **bias**, and they work; **noise** is
  typically larger and calibration does nothing about it. "**The bottom 5% of a rating
  distribution is not the bottom 5% of performers.**"

**The fix is a question, not a technique**, which is why this item travels furthest:

> "**'What's the reliability of this measure?'** Ask it about every survey scale and
> every rating before you model with it. **Half the time nobody knows, which is itself
> the finding.**"

---

### 5 — The number nobody has measured (2:45)

**This is the change I'd most like you to sign off on: swap the causal/controls item
out and put elicitation in.**

The reasoning. Your instinct was right that the five needed Bayesian mechanisms, and the
causal item is the one where there isn't one — DAGs aren't Bayesian, the argument in
Ch 21 is a causal argument that would be identical under any statistical tradition. It
was the best *content* in v1 and the worst *fit* for the talk you're now building. Every
other item runs the engine; that one doesn't, and after four callbacks the audience will
feel the break even if they can't name it.

Elicitation, by contrast, **is** the engine's first box. And it sets up the finale so
cleanly that item 5 and the close become a single move rather than two.

**The scene** (Ch 23): you're modelling the effect of a manager-training programme
nobody has run yet. There is no historical data. A weakly-informative default throws
away the one real source of information in the building.

> "The Head of L&D's judgement **is** data — it's just data in someone's head instead of
> a spreadsheet. **Elicitation is the structured process for getting it out in a form a
> model can use.**"

**The mechanism — and this is where you run the live demo.** Nobody can answer "what's
your prior distribution?" — but everybody can answer three questions:

1. *"What's the lowest it could plausibly be? And the highest?"* — the range you'd be
   astonished to fall outside.
2. *"Given that range, what value is it equally likely to be above or below?"*
3. *"Now think only about the lower half. What splits that in two?"*

> "**The limits come before the best guess.** Ask for a central estimate first and
> everything afterwards gets anchored to it. **Ask for the range first and the expert
> has to think about how wrong they could be before they commit to being right.**"

**The shading:** fit a distribution to the three answers, show it back to them, and ask
*"does this look like what you meant?"* Then shade the quartile they *didn't* give you —
*"this says there's a one-in-four chance it comes in below here. Does that sound right?"*

> "**adjusting the elicited numbers until the fitted curve actually matches their belief
> is where the real value of this process lives.**"

### Run this on the room, live — 90 seconds

There is a working app for this (delivered separately, with the full protocol). The
recommendation in one line: **elicit from the audience rather than playing a recording
of yourself using the tool.** A screencast of someone typing five numbers into a form is
dull and shows the wrong thing — the interesting beat in an elicitation is the human
moment where somebody sees their own belief drawn as a curve and says *"no, that's not
what I meant."* On a recording that happens to a stranger. Live, it happens to them.

**Elicit the net cost of one departure.** Everyone has a view, and it is the exact
quantity the finale needs — so when the cost distribution appears at minute 21, *it is
theirs*. That loop costs nothing and is worth a great deal.

The beats: set it up (10s) → **limits first**, two shouted numbers, don't negotiate (25s)
→ the median (15s) → show the curve and say nothing for a beat (10s) → **shade it**:
*"so there's a one-in-four chance it's above £X. Hands up if that feels too high"* (30s).
Hands will go up. That is the feedback loop happening in public, and it's the entire
argument for the method.

Close the demo on: *"Ninety seconds. That isn't a guess and it isn't a spreadsheet — and
it's now a number your finance partner can argue with, which is the only kind worth
having."*

**Have a screenshot of the fitted result as the next slide**, so that if the app doesn't
launch you talk over the picture and nobody knows. Make the 45-second recording anyway —
you'll want it for LinkedIn regardless.

*Timing note: this makes item 5 the one item that can genuinely overrun, because it
involves other people. Hard-cap it. If the room is slow to shout numbers, seed it
yourself — "I'll start: I'd say fifteen thousand" — and move.*

**Two payoffs, both of which serve your goal (d) directly.**

*Disagreement becomes a finding.* If three experts barely overlap, "**it says the
organisation doesn't actually have a shared view of what to expect, which is worth
surfacing *before* the training programme launches, not after it underperforms
someone's private expectation.**" And the warning that makes it feel expert:
**averaging confident disagreement produces a prior nobody holds** — two humps and a
valley, a claim neither expert made.

*It's stakeholder management, not statistics.* "**Running the elicitation session *is*
stakeholder management, not a detour from it.**" A stakeholder who contributed to the
prior has a different relationship to the answer than one seeing a results deck.

**And the aphorism to end the item on**, which is the most quietly radical idea in the
book and will get at least one person to email you:

> "**The parameter everyone argues about is, mechanically, the one worth
> investigating.**"

*(If the pooled prior is already narrow, everyone agrees and the analysis can't change
anyone's mind. A wide one on a high-stakes question is where analyst time pays.)*

**Don't lose the causal material — convert it into a book-driver.** Fifteen seconds,
right at the end of item 5 or in the close:

> *"There's a whole chapter I'm not going to touch, and it's the one I'd read first.
> It's about why controlling for more variables often makes your answer worse — and why
> every dataset on your laptop is already distorted by who your organisation hired and
> who hasn't left yet."*

That's a better use of the collider than a rushed two minutes, and it does real work for
goal (c).

---

## 4. Back to the thirty managers (20:00 – 23:30)

The finale is now a single image, and the audience has been trained on every part of it.

**The objection first:** *"you cannot put a number on somebody resigning."*

> "You cannot put **a** number on it. That was never the requirement. … A cost is no
> different. **The demand for a single defensible figure is what makes the exercise feel
> impossible, and it is a demand nobody made.**"

**Then the picture, built in three moves:**

1. **The elicited cost** — a pale blue prior, on the left. Same shape as item 5, pointed
   at a price instead of an effect. *"This is the distribution from ten minutes ago. The
   only difference is who I asked and what I asked about."*
2. **× the posterior** — the effect you modelled. Multiply draw by draw.
3. **→ the impact distribution**, in money, shaded above zero. *"A 61% chance it pays
   for itself, median return £102k, and a real chance of losing £200k."*

The multiplication is the only genuinely new idea on the slide, and after five callbacks
it arrives as the obvious next move rather than as new machinery. That's the whole
argument for having made the device recurring.

**The political move that makes it work in a real organisation** — say this, it's the
most immediately usable thing in the talk for anyone senior:

> "**Get finance to agree to the range, not to certify the number.** … That is a
> question a finance partner can say yes to, because it commits them to nothing they
> don't already believe, and it converts your analysis from 'HR's estimate' into 'the
> number finance already signed off'. **Do it in writing, do it before you see the
> result, and record who said it.**"

**Then the threshold**, 20 seconds:

> "**Anybody who sets it at 0.5, or at 0.05, without writing those costs down has made a
> financial decision by accident.**"

**Then the surprise ending** — and this is still the freshest idea you have, so land it
properly. You can compute what it would be worth to *learn more* about each uncertain
input, from the draws you already have. The programme's effect comes top, as any analyst
would guess. But:

> "The **net cost is barely behind it** … Resolving the effect means running a pilot:
> months, a budget, and design work. **Resolving the cost means a better afternoon with
> finance. Almost the same value, at a fraction of the cost — and it is the one nobody
> puts on a research plan.**"
>
> "**A People Analytics function that asked that before commissioning work would reorder
> its own queue.**"

**Then the one habit:**

> "**Before you analyse, ask what you would do differently depending on the answer, and
> what each wrong turn would cost.** Ask it out loud, in the meeting, before anyone
> opens R."

**Then close the AF447 loop, and stop:**

> "What had gone wrong for two years was not a calculation. **It was an assumption that
> nobody had written down: that a search which finds nothing tells you nothing.** Once
> somebody questioned that assumption, the answer took a week."
>
> "**The technique is rarely the difficult part. The difficult part is noticing an
> assumption you did not know you were making.**"

---

## 5. The book, and the ask (23:30 – 25:00)

1. **It's free and it stays free.** The online edition is the edition.
2. **You don't have to fit any of the models.** Put the book's own "question each
   chapter leaves you with" table on the final slide — eight questions an HR manager can
   ask their analyst on Monday, none requiring R. It's the most shareable thing in the
   book and it makes forwarding the link the obvious move.
3. **The soft ask**, one sentence, from the book's own framing: you teach this inside
   organisations, and "the company version is usually the more interesting one, because
   we can run it on your problems rather than on the `salespeople` dataset."

Then: *"Typos are welcome. Arguments are more welcome."* — a natural handover to Q&A.

---

## Timing reality check

| Section | Budget |
|---|---|
| Open | 3:30 |
| Engine + shading | 4:30 |
| Item 1 — league table | 2:45 |
| Item 2 — attrition curve | 2:45 |
| Item 3 — Likert (quick) | 1:30 |
| Item 4 — reliability | 2:45 |
| Item 5 — elicitation | 2:45 |
| Finale | 3:30 |
| Book + ask | 1:00 |
| **Total** | **25:00** |

No slack at all. If you need some, in order: cut item 3 entirely (it's the quick one
because it's the most droppable), then cut the multiple-comparisons line in item 1, then
compress the finale's threshold point. Do not cut the payload sequence at minute six or
the EVPPI surprise at the end — the first makes the whole talk cohere and the second is
what makes people want to talk to you afterwards.

---

## Numbers you'll need to run the book to get

The mockup uses illustrative figures throughout. For real slides:

| Where | What's needed |
|---|---|
| Ch 24 | One-manager expected value, 95% range, P(pays for itself); the three EVPPI bar values |
| Ch 15 | The three tier counts across the 571 managers |
| Ch 17 | Median tenure; and the months 0–9 vs 24–36 comparison, which isn't in the book — you'd need to compute it |
| Ch 18 | The two shift percentages (bottom vs top of the management scale) |
| Ch 23 | The fitted quartiles from the L&D elicitation, if you show the feedback loop |

Everything quoted in this document is a literal number in the source and I've checked
each one.

---

## Three things I'd like your call on

**The item 5 swap (causal → elicitation).** Argued above. It's the biggest change in v2
and the one I'd most like you to push back on if you disagree — the collider material is
genuinely the most striking content in the book and I'm proposing to reduce it to a
fifteen-second trailer.

**Whether item 2 gets the extra thirty seconds.** I've given it the fullest shading
demonstration because the COO's question maps onto a shaded region so exactly. That
makes it the second-longest item. The alternative is spreading that time evenly and
letting the shading point land more lightly in each.

**Whether the finale's numbers should be real or clean.** Ch 24's actual figures will be
whatever they are; illustrative round numbers are more legible on a slide. My instinct is
real numbers with the caveat that the data is a teaching dataset — but it's your
credibility and your call.
