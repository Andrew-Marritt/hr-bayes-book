# Decisions To Be Made

*Companion to the Book Feedback Tracker. Everything in here was deliberately **not** actioned, because it needs a call from you rather than an edit from me. Each entry says what the decision is, what the options are, and what I'd do — so you can answer most of them with a yes or a number.*

**Where things stand after this pass:** all 17 Bugs are fixed, 27 of 30 Clarity items are fixed. What's left is 28 Statistical & Methodological items, 3 Clarity items, and 18 Style items. Not one of them is a typo.

⚠️ **Nothing below is in the rendered site yet, and neither are today's fixes.** Quarto isn't installed on the machine I can reach, so I've edited the `.qmd` sources but couldn't render. You'll need to `quarto render` and push before any of it is visible to reviewers.

---

## 1. The one that matters most

### D1 · Ch12 — the Part 1 headline may be an artifact of a mis-set prior

**Tracker 2.3 (Ludek + Max, both independently).**

`12-richer-models.qmd` line 125 says the intercept, `sd` and `sigma` priors "are the same ones from Chapter 8", then sets `normal(75, 15)`. Chapter 8 sets `normal(200, 100)`. Manager test scores average about 240, so the prior sits roughly eleven of its own standard deviations below the data. Max refit it three ways: as printed it reproduces your numbers but predicts ~136 at mean tenure against a data mean of 240. With the Chapter 8 priors the text *claims*, the tenure slope falls from about −9.8 to about −1, the between-office slope spread collapses from 12 to about 1.4, and every city's slope interval crosses zero.

So the Part 1 conclusion — that the tenure effect "does completely different things in different offices" — appears to be the off-scale prior pushing the intercept down and the model relocating the between-office variation into the slope. `fit_vs` also throws divergent transitions, which Chapter 8's own diagnostics box names as the signal to check prior scale.

**Decision:** re-run with `normal(200, 100)` and rewrite Part 1 around whatever comes back?

**My recommendation:** yes, and treat it as the priority. It is the only item in the tracker where a stated *finding* may not survive. There's a silver lining: a varying-slopes model that turns out to have almost no varying slope, next to the prior that manufactured one, is a better lesson than the current version — and it lands your own prior-predictive-check argument with a real example.

---

## 2. Confirmed errors where the fix depends on your intent

### D2 · Ch14 — which empirical Bayes estimator, and the promise to Chapter 15

**Tracker 2.4 and 2.25 (Ludek + Max).**

Two linked things.

*The estimator.* The prior is fitted by method of moments to the six observed city rates. Ludek and Max both note this mixes sampling noise with genuine between-city variation. On this data the observed variance of the raw rates (0.0020) is *smaller* than the average within-city sampling variance (0.0025), so the between-city variance left over is about −0.0005 — i.e. zero. A marginal MLE fit to the counts gives a prior strength of ~1,540 rather than 50 and shrinks every city to about 0.10. A brms partial-pooling model — your own tool from Chapters 8 and 15 — agrees: every city overlaps the overall rate.

*A note on Max's lens here, since you asked me to watch for it.* Your frequentist suspicion doesn't hold up on this one. Marginal MLE **is** the canonical empirical Bayes estimator (Robbins, Efron–Morris), and it's how the Robinson baseball example the chapter cites is actually done. And his conclusion is corroborated by a brms model, so it doesn't rest on MLE at all.

**Options:** (a) keep method of moments and add a sensitivity note; (b) switch to marginal MLE; (c) keep MoM as the teaching version and show the MLE and brms answers alongside.

**My recommendation:** (c). Method of moments is what a reader can do on paper, which is the chapter's whole pedagogic point — don't lose it. But add the check, because "on this data no city is distinguishable from average" is the *stronger* version of the chapter's own message, and it matches where Chapter 15 lands for managers.

*The promise.* 14.3.2 tells the reader Chapter 15 "fits the 'proper' version and you'll see the answers are very close". Chapter 15 fits a Poisson multilevel model of transfer requests across individual managers — different example, different data — and never re-runs the city rates. And on the one comparison that can be made, the two don't agree.

**Decision:** soften the promise, or deliver it on the city data?

**My recommendation:** deliver it. Fitting the six cities in brms is about ten lines, and it resolves this *and* the estimator question in one move.

---

### D3 · Ch17 — the fitted Weibull shape contradicts the chapter's reading of the KM curve

**Tracker 2.28 (Max). Verified in your own frozen output.**

`shape 1.08 [1.01, 1.15]`, frailty model `1.11 [1.04, 1.18]` — both intervals entirely above 1, so flat-to-slightly-rising per-month risk. But 17.4.1 describes the shape-below-1 case as "the usual pattern in employment data, and it's the shape the Kaplan-Meier curve above already hinted at."

Two things are tangled. First, a survival curve falling fastest early does **not** on its own mean the hazard is highest early — with constant per-month risk the curve still falls fastest at the start, simply because the most people are still present to leave. So 17.3 reads a stock effect as a hazard effect. Second, by the chapter's own rule ("if the model says the hazard is flat and the raw curve plainly drops off a cliff in year one, the Weibull's shape assumption is fighting your data"), a shape near 1 beside that curve is exactly the signal to report — and the chapter states the rule, then doesn't apply it to its own output.

**Decision:** fix the reading in 17.3/17.4.1, or change the example?

**My recommendation:** fix the reading. No re-run needed, and the stock-versus-hazard distinction is a genuinely good passage that the chapter currently doesn't have. This is probably the best value-per-hour item on the whole list.

---

### D4 · Ch13 — the interaction example holds no interaction the data supports

**Tracker 2.22 (Max).**

Refit with your printed priors and seed: every interaction term's 95% interval includes zero (f2 ≈ 45 [−15, 105], f3 ≈ 11 [−48, 71], f4 ≈ 39 [−29, 111]). Per-tier slopes come out ≈45, 90, 56, 84 — heavily overlapping, no order by tier. By LOO the interaction model is 1.5 worse with a standard error of 2.0.

Your *method* is right — ask the model for predictions, look at whether the lines are parallel. But on this data the lines look non-parallel while the separation sits inside the noise, which is precisely the outcome your own fishing warning describes. A reader taking "read it from the lines, it needs no coefficient table" at face value could treat the visible non-parallelism as a result.

**Decision:** add a clause saying the honest reading here is "no clear interaction", or move the teaching point to data that holds one?

**My recommendation:** keep the data, add the clause, and foreground the ribbon widths. Showing a reader what an *absent* interaction looks like is more useful than manufacturing a present one, and it turns the chapter's own warning into a demonstration rather than an assertion.

---

### D5 · Ch19 — the `mi()` worked example says two things the output doesn't support

**Tracker 2.1 (Ludek, quantified by Max). The largest work item on the list.**

Two verified problems. The interval-width claim is backwards: the text says the in-model interval is wider than complete-case, the printed table has it *narrower* (46.3 against 47.4) — and the stated rationale, that complete-case "bought its narrower interval by discarding rows", is inverted, since discarding rows leaves less data and a *wider* interval. Imputation usually recovers precision; that's the standard multiple-imputation result. Second, the example doesn't show the bias it claims: complete-case is 1.4 off the truth and the imputed estimate further off at 2.1, so the chart shows neither the biased midpoint nor its recovery. A 1,000-draw study puts the true complete-case bias at about −3.4 — real, but smaller than run-to-run noise (sd 5.0).

**Options:** (a) correct the prose to describe what the output actually shows; (b) replace with a synthetic example built with outcome-dependent missingness, keeping `salespeople` for `me()`; (c) keep the example, add a note that this draw doesn't show the effect.

**My recommendation:** (b). (a) leaves you with a section that demonstrates nothing, and (c) is an admission dressed as a lesson. A synthetic example is a couple of hours and makes the section actually work. The Summary line and the closing shapes bullet need to match whichever you pick.

---

### D6 · Ch13 — the smooth example is a case where the line wins, and it throws divergences

**Tracker 2.23 (Max).** LOO keeps the line (smooth 0.2 worse, se 0.3). That agrees with your own "when you can skip this" box — managers' tenure runs 2 to 6 years, a narrow range — but a reader arriving from the bendy tenure-and-attrition example in 13.3.1 sees no bend in the worked one. Separately `fit_smooth` produces ~23 divergent transitions from the smooth's variance term.

**My recommendation:** raise `adapt_delta` to clear the divergences, and say in the text that the line wins here and why. Low cost, and it makes 13.3.1 and 13.3.2 agree.

---

### D7 · Four small caveats, each about one sentence

None of these need a re-run. Each changes what a sentence claims, which is why I've left them.

| # | Chapter | The issue | Suggested fix |
|---|---|---|---|
| 2.21 | Ch5 | 5.2.4's "tiny" negative fraction (~0.2%, the *fitted* model) and 5.3.10's 0.115 (the *prior* predictive check) are two different quantities presented as one. 5.2.4 promises to "measure it", then delivers a number 50× larger. | Name both: 0.2% as the fitted model's, 11.5% as the price of a deliberately loose prior — not of the Normal likelihood. |
| 2.24 | Ch14 | The worked prior is built from six cities; 14.4 opens by saying five is too few. | One line acknowledging six is on the low side, and that this is part of why 14.4 offers the benchmark route. |
| 2.26 | Ch15 | With one row per manager, `sd(Intercept)` is an observation-level random effect — mathematically an overdispersion term. It bounds how much managers truly vary rather than isolating it. Shrinkage and ranking are untouched. | Carry the hedge you already have in that paragraph ("or at least whatever drives transfer requests") into the headline sentence. |
| 2.27 | Ch16 | The 49% ICC is computed on major *medians*, so it's the between-discipline share of variation in medians. 16.4 sends the reader to an employee-level comp file, where simulation puts the ICC nearer 0.09–0.40. | One caveat in 16.4: read 49% as close to an upper bound for individual-level data. |

**My recommendation:** take all four. They're cheap, and each is the kind of thing a hostile reviewer finds first.

---

### D8 · Ch22 — the low-ESS warning didn't reproduce

**Tracker 2.29 (Max, 60% confidence — he's explicit your version may legitimately produce it).** Across five sampler seeds in brms 2.20.4 on data from your own `set.seed(21)`, bulk ESS stayed between ~500 and ~960 and the sampler was quiet. The *mechanism* the box explains is confirmed — the treated main effect was the worst-mixing parameter every run, competing with the office-level intercepts, exactly as you describe.

**My recommendation:** keep the explanation, and in place of the quoted warning show the treated coefficient's reduced effective sample size. Then the point holds whatever version the reader is on.

---

## 3. Assumptions to state (cheap edits, but they change what the example claims)

Ludek's framing throughout is "acknowledge the limitation, or state a simplifying assumption". Both are legitimate for a teaching text; which one you pick is a voice decision.

| # | Chapter | Issue | Ludek's suggested teaching assumption |
|---|---|---|---|
| 2.5 | Ch2 | The bench simulation can promote more people than there are roles — 10 openings, but `rbinom()` on a 28-person bench regularly returns more than 10. | Let the simulated count be candidates *ready* for promotion; cap actual promotions at 10. *(Note: fixing this touches the same code as Bug 1.6, now closed — worth doing together.)* |
| 2.6 | Ch15 | Transfer requests accumulate over a manager's tenure but are divided by *current* team size, so longer-serving managers look worse for having been observed longer. | State equal observation windows and roughly stable team sizes. |
| 2.13 | Ch4/17 | "Eventually promoted" has no defined follow-up period; "not promoted yet" isn't "never promoted". | Assume everyone observed over the same complete three-year period. |
| 2.14 | Ch17 | A flat survival curve is read as "some people never experience the event". Limited follow-up, or few people still at risk, produces the same shape. | Soften the reading. *(Pairs naturally with D3.)* |
| 2.19 | Ch3 | The Poisson example is filed under "no natural maximum", but transfer requests per team are bounded by headcount — Xiaoji's question, and a fair one. | Either pick an example with a genuine ceiling-free count, or say why the ceiling is far enough away not to matter. |
| 2.10 | Ch22 | The simulation generates repeated observations within offices; the analysis treats them as independent. Likely affects the recommended study size. | Re-run the simulation with an analysis that respects the office structure. *(The one item here that needs real work.)* |
| 2.12 | Ch21 | Adjusting for an imperfect performance rating may leave residual confounding. | Say so where the adjustment is made. |

**My recommendation:** state the assumption rather than acknowledge the limitation, in every case except 2.14 and 2.12 where the limitation *is* the teaching point. A teaching example that says "assume X" is honest and stays simple; one that lists caveats gets heavier every draft.

**2.10 is the exception** — it's a real re-run, and the recommended study size is a number a reader might act on. Worth doing properly.

---

## 4. Causal language

### D9 · Ch18/21 — observed relationship vs. what a programme would cause

**Tracker 2.11 (Ludek).** Some passages move from an observed relationship to a claim about what an intervention would do. Ludek is sympathetic — the business decision is what makes the example useful — but suggests separating what the model shows from the additional assumptions needed before recommending an intervention.

**My recommendation:** take it, and take it seriously. The book is careful about this from Chapter 21 onward, which makes the earlier slips more conspicuous rather than less. A standard formula you can reuse — "the model says X; recommending Y additionally assumes Z" — would cost a sentence per site and would be a strength of the book rather than a hedge.

---

## 5. Chapter 24 — the decision chapter (three items, one theme)

Ludek's three Ch24 items all point the same way: the chapter's arithmetic is more optimistic than its own framing warrants.

- **2.7 — the savings calculation prices the wrong event.** Avoided transfer requests are costed as avoided resignations, but an internal move isn't an exit. Either use costs matching the event modelled, or make the resignation example explicitly hypothetical.
- **2.8 — the probability threshold conflicts with the expected-net-benefit rule.** Expected net benefit already accounts for unequal gains and losses, so it doesn't require the two error types to cost the same; the proposed cutoff can produce a different recommendation.
- **2.9 — the value-of-a-pilot calculation assumes the pilot always reveals the correct decision.** Better labelled as an idealised upper bound.

**Decision:** these are three separate calls, but I'd take them as one revision pass.

**My recommendation:** accept all three. 2.8 in particular — Ludek is right that the threshold is redundant once you have expected net benefit, and having both invites a reader to get two answers from one framework. Dropping it makes the chapter shorter *and* more correct, which is rare. On 2.7, "make it explicitly hypothetical" is the cheaper of the two routes and preserves the worked example.

---

## 6. Sara's Part III question (four tracker items, one decision)

**Tracker 2.15, 2.16, 2.17, 2.18 and 4.14.**

Sara's point, made four ways: the performance-rating examples never say what the ratings measure, how they're assigned, what period the sales figures cover, or how far apart the rating and the outcome sit. And inter-rater reliability is never acknowledged — one manager's 3 is another's 4 — which she notes is exactly the grouped structure Chapter 8 exists to handle.

She's explicit she isn't asking you to explore every variation; she wants the examples to be usable as practical templates.

**Why this is one decision, not four:** it's really the question of how much real-world scaffolding a teaching example carries. Add it everywhere and the book gets heavier and slower. Add it nowhere and a practitioner can't lift the examples into their own work — which is what Sara is telling you she'd want to do.

**My recommendation:** a middle route. Add a short data-provenance note to the Chapter 7 example only — what the ratings measure, who assigns them, what period the sales cover — and make it explicit that it's a stated assumption for teaching, not a claim about the dataset. Then in Chapter 8, use inter-rater variation as the *motivating* example for grouping (2.17's own suggestion), which turns Sara's objection into a bridge you already need. Chapter 9 (2.18) then only needs one sentence closing the loop.

That's one new paragraph, one reframed opening, and one sentence — against four items.

**One flag on 4.14's attached note:** Max's INT-04 says the introduction name-checks SEM, SPSS, STATA, econometrics, game theory and decision science before any statistics has been met, which may read as in-group to the beginner it most wants to reassure. He rates it low priority. I'd add a caution about his review generally: it's structured around an "advanced reader" persona (OU M347, econometrics) who is neither of your two stated audiences. His *technical* findings are excellent and I verified four of the biggest directly in your source. His *audience* judgements are worth more scepticism than his arithmetic.

---

## 7. Clarity items I didn't action

### D10 · 3.14 — Xiaoji's distribution decision tree

She built one with an AI assistant, tested it against her own work, and reports it works better for her than the prose. She hasn't sent it. **Blocked on her** — worth asking. The book already ships hand-built SVGs in `figures/`, so it would sit naturally.

### D11 · 3.16 — plot the flat `runif()` distribution in Ch3

The walkthrough describes the flat inputs, but they're never plotted; the reader takes the flatness on trust, which is exactly the contrast that makes the CLT land. **This is a new code chunk and a re-render** — cheap, but it's a content addition rather than a correction, so it's your call. **I'd do it.** It's the highest ratio of pedagogic value to effort in Xiaoji's whole list.

### D12 · 3.28 — Ch9 reads confidence from non-overlapping intervals

**Tracker 3.28 (Max).** 9.4.2 concludes "we're confident in that gap" from the top tier at 0.51 [0.38, 0.64] and the mid tier at 0.21 [0.14, 0.29] — two separate intervals that happen not to overlap. Chapter 7 was careful to make exactly this comparison by taking the posterior of the difference draw by draw (`compare_levels`), because the two groups' draws are correlated and summarising each first then subtracting throws that correlation away.

Here the intervals are far enough apart that the conclusion is safe either way. But a reader who took the Chapter 7 lesson to heart will expect the gap stated as its own posterior — which is also the number the stakeholder is being told is reliable.

**Decision:** re-run with `compare_levels` and state the gap's own posterior, or add a sentence acknowledging the shortcut?

**My recommendation:** re-run. It's a small change, the machinery is already in the book, and the alternative is a chapter that teaches a habit in Chapter 7 and quietly drops it in Chapter 9.

---

## 8. Style & structure — 18 items held for your judgement

These are voice and structure calls. I've grouped them and given a one-line view on each, but none should be actioned without you.

**Introduction and front matter**

- **4.1** — Sara finds "Why I wrote it" and "Who this book is for" lengthy. *Max's INT-04 says the same thing from the opposite direction (see §6). Two reviewers agreeing is worth a re-read.*
- **4.2** — note each Part's relative size in "How the book is organised" ("the heart of the book, in three chapters"). *Cheap; I'd take it.*
- **4.16** — connect the AF447 opening to Chapter 24's loss/decision framing. *Explicitly optional. One line, and it does frame the arc.*
- **4.18** — "Direct probability answers are the Bayesian superpower" sits against the even-handed "right tool for the job" stance. *Max at 60%. Once is fine if you want the lift — flagged only so it's a choice.*

**Structure**

- **4.3** — Part 5 reads as structurally uneven; some chapters carry more supplementary detail. *The biggest item here, and the vaguest. Worth asking Sara which chapters specifically.*
- **4.9** — no answer key for "Your Turn" exercises. *Real work (24 chapters), real value. A separate appendix would do it. Your call on scope.*

**Statistical framing**

- **4.4** — median vs mean: stakeholders often don't know what a median is. Sara's practice is to publish the mean and address outliers in the narrative. *Reasonable, and it's a genuine disagreement rather than an error. I'd note her view in the text rather than adopt it.*
- **4.5** — the "why the difference matters" example would land better with the mean value actually stated. *Take it.*
- **4.17** — connect the posterior mean to squared-error loss / Chapter 24. *Competes with your deliberate choice to save decision theory for Ch24. I'd leave it.*
- **4.19** — "confident" in the Ch6 payoff sentences, for the reader being weaned off confidence intervals. *Max at 55%. Not wrong Bayesian-ly; just slightly against the aim. Alternatives offered: "we put 95% probability on".*

**Data realism**

- **4.6** — the binary 0/1 promotion framing has no timeframe. *Overlaps 2.13. Fix them together.*
- **4.7** — performance ratings are subjective unless based on consistently applied criteria. *Overlaps 2.15/2.17. Fix together.*
- **4.8** — pushback on "a request for historical data is usually a question about the future"; Sara says the motivation is more often establishing a baseline. *She's describing her own experience against yours. I'd acknowledge both readings in a clause rather than replace yours.*

**Teaching approach (Xiaoji)**

- **4.10** — add a reflective prompt after 2.4.1's table ("what story is your mind already forming?"). *Cheap and good. Her own reaction is the illustration.*
- **4.12** — code appears immediately after the question, handing readers the answer before they've formed their own approach. *A real pedagogic point, and it recurs. Adopting it would mean a pattern change across chapters — hence a decision, not an edit.*
- **4.13** — 2.5.1 stops at a bench size and doesn't translate it into leadership-ready language. *She's naming a gap between the book and her actual job. Sample language would be a differentiator.*
- **4.15** — response rates for small teams: pushing 50%→100% on a 15-person team may not buy reliability worth having, and a sharp jump can signal pressure to complete. She flags it herself as "a side-step for a statistics book". *Her call on that is right — but it's the conversation she has constantly, which is an argument for a short box.*

---

## 9. Still outstanding from earlier (not feedback items)

- `Book-Feedback-Tracker.docx` is still on disk at `~/Developer/people-analytics-book/`. I can't delete files on your machine — you'll need to `rm` it.
- The TLS certificate for `bayesian-thinking.andrewmarritt.ch` needs re-saving in **Settings → Pages**.
- ~29 iCloud conflict copies are still tracked in git.
- Xiaoji's decision-tree image never arrived (D10), and her question about her own AI use still needs an answer from you.
- **Everything from today needs `quarto render` and a push before reviewers see it.**
