# Book Feedback Tracker

*Reader and reviewer feedback, prioritised and logged as it comes in.*

Every item below is tagged with who raised it. Items are sorted into four tiers:

- **Bugs — fix immediately:** objective errors — broken or confusing references, inconsistencies in the book’s own conventions.
- **Statistical & methodological — review before publication:** a result that contradicts its own printed output, a prior that doesn’t match its description, a cost attached to the wrong event. Kept apart from bugs because most need a model re-run rather than an edit.
- **Clarity & accessibility — recommended:** not errors, but they affect whether the target reader can actually follow the book. Kept separate from style because legibility outranks preserving style.
- **Style & structure — hold for review:** editorial and voice calls. Logged for your judgement, not acted on automatically.

A “What’s working” section keeps praise on record so it isn’t lost during revision, and a raw feedback log at the end preserves each reviewer’s original wording.

## Status at a glance

| Tier | Items | Open | Fixed |
| --- | --- | --- | --- |
| 1. Bugs — Fix Immediately | 17 | 0 | 17 |
| 2. Statistical & Methodological — Review Before Publication | 29 | 28 | 1 |
| 3. Clarity & Accessibility — Recommended | 30 | 3 | 27 |
| 4. Style & Structure — Hold for Review | 19 | 18 | 1 |

## 1. Bugs — Fix Immediately

### 1.1 · Sara Ridley · Fixed

The “Note” box type has no explanatory text, unlike every other box style — readers aren’t told what it means or whether it can be skipped.

> Done: the box key in the Welcome now names the plain note as a sixth kind and says outright whether it can be skipped — “**Nothing critical ever hides in a plain note.** Read one if the aside interests you; skip it if it doesn’t.” Worth knowing that the explanatory paragraph itself landed on 16 August, after Sara’s read, so part of this was already resolved by the time she raised it.

### 1.2 · Sara Ridley · Fixed

The welcome section’s reference to “section 24.8.1” is unclear — Sara couldn’t tell if it’s in Chapter 24, or whether reviewers need to read that far before giving feedback. Needs your call: confirm whether this is a book cross-reference or a reviewer instruction, then fix or reword it.

> Your call: you think this is fixed — you replaced “section 24.8.1” with “the last page of Chapter 24”. Reviewed: that resolves Sara’s ambiguity — it was a book cross-reference (to the support section at the end of Chapter 24), not a reviewer instruction. Done: upgraded to a live link so it can’t drift again. Chapter 24’s “Free, and how to support it if you want to” heading now carries an explicit anchor, and the Welcome links to it directly. Used a plain anchor rather than a @sec- cross-reference because the section sits under an unnumbered parent, and Quarto renders @sec- references to unnumbered sections as “?sec-…” — the same silent failure mode as the appendix link.

### 1.3 · Xiaoji Zhang · Fixed

The “edit this page” link on review pages leads to a 404, so reviewers can’t use it to leave feedback in place — needs fixing or removing.

> Your call: remove it. Done: root cause was _quarto.yml — repo-url pointed at github.com/andrewmarritt/bayesian-people-analytics, but the real repo is Andrew-Marritt/hr-bayes-book, so every "Edit this page" link 404’d. The "Report an issue" link was breaking the same way. repo-actions is now removed (both links gone), repo-url corrected, and a comment left in the file explaining how to restore the issue link if the repo is ever made public.

### 1.4 · Max Blumberg · Fixed

Intro — “The Economist and … Nate Silver are openly Bayesian” is contestable (Max, INT-02). The Economist's model (Gelman & Morris) is explicitly Bayesian; Silver's is widely described, including by him, as a Monte Carlo simulation blending polls with a fundamentals component rather than a formal Bayesian model. You agreed on 19 Aug — “far from clear he built a Bayesian model.” Attribute the Bayesian description to The Economist and soften Silver's to “in a similar spirit”, or check his current methodology notes.

> Done: index.qmd now attributes the Bayesian description to *The Economist*’s forecast alone, and adds that other well-known forecasters, “Nate Silver among them, work in a recognisably similar spirit, blending prior expectation with incoming polls, though they do not all describe their models in Bayesian terms.” Matches your 19 August call.

### 1.5 · Max Blumberg · Fixed

Ch2, 2.3.3 — “roughly 25% of salespeople are top performers” does not match the data (Max, CH2-01). Verified in your source: `performance == 4` is 55 of 350, which is 15.7%. The code two lines below prints the independent prediction as 0.0507 using the real rate, so the prose “0.25 × 0.30 ≈ 0.075” clashes with the output directly beneath it. “About 30% promoted” is fine (32.3%). The conclusion is unaffected — the real joint rate 0.0857 is still clearly above the independent prediction. Change to “about 16%” and “0.16 × 0.32 ≈ 0.05”.

> Done: Ch2 now reads “about 16% of salespeople are top performers (`performance == 4`) and about 32% get promoted overall”, with “0.16 × 0.32 ≈ 0.05” — which agrees with the 0.0507 printed two lines below.

### 1.6 · Max Blumberg · Fixed

Ch2, 2.5.2 — the “5+ more” label does not match the code threshold (Max, CH2-02). The label reads “P(5+ more candidates promoted than roles available)” while the code computes `mean(promoted_count > roles_open + 5)`; `> 15` counts 16 or more, which is 6 or more beyond the 10 roles. The printed 0.006 is right for the code as written; read as a true “5 or more extra” it would be 0.017, nearly three times larger. Either reword the label to “6+ more” or change the code to `>=`. Note this is the same section Ludek flags for allowing more promotions than there are roles (Stat item on Ch2) — worth fixing together.

> Done: the label now reads “P(6+ more candidates promoted than roles available)”, matching the `> roles_open + 5` in the code. The code is unchanged, so the printed 0.006 still stands. Ludek’s related point — that the simulation can promote more people than there are roles — is Statistical item 2.5 and still open.

### 1.7 · Max Blumberg · Fixed

Ch4, 4.4.6 — the vector-recycling Tip understates the danger (Max, CH4-04). The text says that with mismatched lengths “R doesn't complain — it recycles the shorter one”. R is silent only when the longer length is an exact multiple of the shorter; otherwise it warns “longer object length is not a multiple of shorter object length”. So outside the exact-multiple case you get a warning as well as a wrong answer.

> Done: the Tip now reads “R still hands you an answer — it recycles the shorter one from the start and pairs it up again. If the longer length is an exact multiple of the shorter it does this silently; otherwise you get a warning, but a result all the same.”

### 1.8 · Max Blumberg · Fixed

Ch10 Summary — one root-cause numbering error that four later chapters have inherited (Max, CH10-01 / CH19-03 / CH20-01 / CH21-01 / CH23-02). Verified in your source: 10-complete-workflow.qmd line 103 says “Steps 7 and 8 are the ones people skip”; line 207 says “Steps 6 and 7 — diagnose and check — are the ones people skip”. The Summary recaps only nine steps, dropping Claim and Temper, which shifts every number after Fit — and Claim and Temper are the two the body singles out as the ones no software prompts for, so the Summary commits the exact omission 10.2 warns against. Downstream: Ch19 calls the sampler-diagnostics step 6 (it is 7) and the checks step 7 (they are 7 and 8); Ch20 says “nine steps”, diagnose “step 6”, check “step 7”; Ch21 §21.5.3 says step 7 for the posterior predictive check while §21.5.2 four lines earlier correctly says step 8; Ch23 §23.6.1 says step 4 for the prior while §23.9.2 says step 5. Fix the Summary and all five resolve.

> Done, root cause and every inheritance. Ch10’s Summary now reads “**Steps 7 and 8 — diagnose and check — are the ones people skip**”. Fixed with it: Ch19 (sampler diagnostics step 7, checks 7 and 8), Ch20 (“eleven steps”, step 7, step 8), Ch21 (step 8), Ch23 (step 5) — plus three chapters Max did not find, Ch16 (steps 5 and 7), Ch17 (step 7) and Ch18 (steps 5 and 7).

### 1.9 · Max Blumberg · Fixed

Ch10 and Ch12 — the later-part chapter numbers in the model-family table and the forward pointers are one low (Max, CH10-02 / CH12-03). The 10.3 table lists Empirical Bayes as Chapter 13, while the note directly below it says “Chapters 4, 14, and 19” and Chapter 8 says “Chapter 14 applies this exact idea in closed form”. The same one-chapter gap runs through the neighbouring rows (pay-variance 15 vs 16, survival 16 vs 17), and on the 6 Sept re-read every Part V row was still one low, including A/B testing as 19 (it is 20) and both measurement-error rows as 18 (they are 19). Chapter 12's forward pointers (offsets → 15, ordered outcomes → 18, measurement error → 19) want checking against the same settled numbering.

> Done: all eight wrong rows in Ch10’s model-family table corrected — empirical Bayes 13→14, shrinkage/partial pooling 14→15, hierarchical variance components 15→16, survival 16→17, ordinal 17→18, A/B test 19→20, and both the measurement-error and in-model-imputation rows 18→19. Ch12’s forward pointers were checked against the settled numbering and are already right (offsets → 15, ordered outcomes → 18, measurement error → 19), as is Ch10’s “Part V, from Chapter 14”.

### 1.10 · Max Blumberg · Fixed

Ch12, after 12.2.4 — a section heading is rendering as raw Markdown (Max, CH12-02). The text “### Reading the output, line by line” appears on the page literally, hashes and all, because the heading has been pulled into the preceding code-annotation footnote so Quarto treats it as body text. Cosmetic, but visible to every reader at that point.

> Done: a blank line inserted before “### Reading the output, line by line” so Quarto no longer absorbs it into the preceding code annotation.

### 1.11 · Max Blumberg · Fixed

Ch14, 14.6 — the comparison table's right-hand column header reads “MULTILEVEL MODEL (CH. 8, 14)” (Max, CH14-03). Chapter 14 is this empirical Bayes chapter, shown in the left column as “THIS CHAPTER”. The multilevel model is Chapters 8 and 15. Should read “(CH. 8, 15)”.

> Done: the header now reads “**Multilevel model (Ch. 8, 15)**”.

### 1.12 · Max Blumberg · Fixed

Ch14, 14.3.2 — the Stein note dates the result to the 1960s (Max, CH14-05). Stein's inadmissibility result is 1956 and the James–Stein estimator is 1961, so the surprising proof is the mid-1950s and the practical estimator the early 1960s. Max flags this as from memory rather than a checked source, so worth confirming — but the dates are right. Something like “In the 1950s and 60s, Charles Stein and Willard James showed” would fix it.

> Done: now “In the 1950s and 60s, Charles Stein and Willard James proved…”. Max flagged this as from memory; the dates check out — Stein’s inadmissibility result is 1956, the James–Stein estimator 1961.

### 1.13 · Max Blumberg · Fixed

Ch16 — the chapter says “nine disciplines” where the data has sixteen (Max, CH16-02). Verified in your source: the frozen model output prints “Number of levels: 16”, and the prose says nine in **four** places, not the three Max counted — 16-hierarchical-pay-variance.qmd lines 248, 270, 362 and 433 (“like our 9 disciplines”). The point each sentence makes, that the ICC interval is wide because the number of groups is modest, still holds at sixteen; only the number is wrong.

> Done: the four discipline counts corrected to sixteen (lines 248, 270, 362 and 433 of 16-hierarchical-pay-variance.qmd). Line 212’s “nine data points” is a different, hypothetical use and left alone. Confirmed against the chapter’s own frozen output, which prints “Number of levels: 16”.

### 1.14 · Max Blumberg · Fixed

Ch17, 17.5.3 — “Partial pooling handles the manager with four reports the same way Chapter 15 handled the small office” credits the wrong chapter (Max, CH17-03). The small-office example is Chapter 8; Chapter 15 ranks managers and teams, not offices. Either point to Chapter 8 or change “office” to the manager example Chapter 15 actually used.

> Done: now reads “the way Chapter 8 handled the small office”.

### 1.15 · Max Blumberg · Fixed

Ch19 — the three “Part” headings render as Chapters 20, 21 and 22, colliding with the real later chapters (Max, CH19-02). The Part dividers sit one heading level too high, so Quarto numbers them as new chapters: the contents shows “20 Part 1”, “21 Part 2”, “22 Part 3”, with subsections numbered 20.1, 21.3, 22.1 and so on, while 19.1 Setup is correct. Those are also the numbers of the real Chapters 20, 21 and 22. This is the recurrence of GAP-01 from the August gap analysis, which was closed as “fixed by re-rendering, a stale GitHub push” — it is back on the live site as of 6 Sept, so it is worth checking whether the local fix ever actually landed.

> Done: the three Part dividers demoted from `#` to `##`. Investigated first — the book’s own convention in Ch12, Ch13 and Ch24 is `## Part N`, and there is no `####` anywhere in the book, so demoting only the dividers was the minimal fix that does not cascade. **Needs a re-render and push to clear from the live site**, which is probably why Max still sees it: the earlier fix may never have been deployed.

### 1.16 · Max Blumberg · Fixed

Ch20, 20.5 — the classical interval is shown with its subtraction reversed, so it reads as disagreeing with the Bayesian one (Max, CH20-02). The chapter tells the reader to compare the two directly and says they “will land in nearly the same place”. The Bayesian difference is diversity minus comparison, so its credible interval runs −0.182 to −0.103; `prop.test()` reports comparison minus diversity, so its confidence interval runs +0.104 to +0.186. Same size, opposite sign. A reader doing what the chapter says sees one interval below zero and one above and can read the two methods as disagreeing — the opposite of the section's point. One clause noting the subtraction runs the other way fixes it.

> Done: the bullet now says outright that `prop.test()` works down the rows of `group_rates` and reports comparison group *minus* diversity group while `samples$diff` runs the other way, that the two intervals are therefore mirror images, and that you flip the sign on one before lining them up.

### 1.17 · Max Blumberg · Fixed

Ch23, 23.3.1 — the paragraph reading the `feedback()` table is a leftover from an earlier draft (Max, CH23-01). It tells the reader to “find the 0.1, 0.5 and 0.9 rows and compare them back to the 1, 5 and 12 she actually said”, and calls 0.25 and 0.75 “the ones she didn't give you”. In the current worked example the Head of L&D gives a lower quartile of 2.5, a median of 5 and an upper quartile of 10, fitted at probabilities 0.25, 0.5 and 0.75 — so three things are wrong together: the numbers are not what she said, the rows to compare are 0.25/0.5/0.75 not 0.1/0.5/0.9, and 0.25 is described as “a claim she never made” when it is her stated lower quartile. Read against an earlier 10th/50th/90th elicitation giving 1, 5 and 12 the paragraph is internally correct; your own callout “Why I no longer ask for the 10th and 90th percentiles” records the switch, and this paragraph was left behind. It sits on top of the chapter's own “the feedback loop is the whole point” lesson, which is why it earns a fix.

## 2. Statistical & Methodological — Review Before Publication

*Correctness of the analysis itself, raised in technical review. These are not presentation problems: each one affects whether a number in the book is right, or whether an example supports the conclusion drawn from it. The first two are local corrections; several of the rest need a model re-run.*

> Done: the paragraph is rewritten for the current quartile example. It now sends the reader to the `0.25`, `0.5` and `0.75` rows and compares them to the 2.5, 5 and 10 she actually gave; `0.1` and `0.9` are named as the rows that earn their keep, correctly described as the fit’s own extrapolation into the tails, and the sample question is now a one-in-ten upside check.

### 2.1 · Ludek Stehlik · Open

Ch19 — the comparisons described in the prose run in the opposite direction from the numbers printed in the output. Ludek flags this as a straightforward local correction.

> **Corroborated and quantified by Max Blumberg (CH19-01), and it is worse than a local correction.** Two verified problems in the `mi()` worked example. The interval-width claim is backwards: the text says the in-model interval is wider than complete-case, the printed table has it narrower (46.3 against 47.4), and the stated rationale — that complete-case “bought its narrower interval by discarding rows” — is the wrong way round, since discarding rows leaves less data and a wider interval. Imputation usually recovers precision; that is the standard multiple-imputation result. Second, the example does not show the bias it claims: complete-case is 1.4 off the truth and the imputed estimate further off at 2.1, so the chart shows neither the biased midpoint nor its recovery. A 1000-draw study puts the true complete-case bias at about −3.4, real but smaller than run-to-run noise (sd 5.0). Max offers three routes and recommends a synthetic replacement example with outcome-dependent missingness, keeping salespeople for `me()`. The Summary line and the closing shapes bullet need to match whichever is chosen.

### 2.2 · Ludek Stehlik · Open

Ch20 — the calculation answers “Is A higher than B?” when the text asks “Do the groups differ?”. A one-sided probability is being presented as the answer to a two-sided question. Also a local correction.

> **Half done — the labelling error is fixed, the substantive choice is yours.** Ch20’s “Reporting this properly” box no longer describes `p_higher` as “the probability the groups genuinely differ”; it now reads “the probability that the difference runs in the direction you asked about (here … that the diversity group’s rate is the *higher* of the two)”. The main plain-English callout was already worded correctly. What remains is Ludek’s underlying question — whether the chapter should also offer a two-sided quantity — which is in the decisions note.

### 2.3 · Ludek Stehlik · Open

Ch12 — the priors in the code appear to differ from those described in the text, which should match Chapter 8’s. As coded they may shrink the city differences strongly towards zero. Worth a sensitivity check.

> **Corroborated and quantified by Max Blumberg (CH12-01), and upgraded to a confirmed error.** Verified in your source: 12-richer-models.qmd line 125 says “The intercept, `sd`, and `sigma` priors are the same ones from Chapter 8”, then sets `normal(75, 15)`; Chapter 8 line 136 sets `normal(200, 100)`, and Chapter 13 uses `normal(200, 100)` on the same managers outcome. Manager test scores average about 240, so a prior centred at 75 with sd 15 sits roughly eleven of its own standard deviations below the data. Max refit three ways in real brms: as printed it reproduces your numbers but predicts about 136 at mean tenure against a data mean of 240; with `normal(240, 50)` the tenure slope falls from about −9.8 to about −1, the between-office slope spread falls from 12 to about 1.4, and every city’s slope interval crosses zero; with the Chapter 8 priors the text claims, the same picture, and the offices differ in starting point by about 11 points, which is what Chapter 8 itself found. So the Part 1 headline — that the tenure effect “does completely different things in different offices” — is an artifact: the off-scale prior forces the intercept down and the model moves the between-office variation into the slope. `fit_vs` also throws divergent transitions, which Chapter 8’s own diagnostics box names as a signal to check prior scale.

### 2.4 · Ludek Stehlik · Open

Ch14 — the prior is fitted directly to observed city rates, which mixes sampling noise with genuine between-city variation. Ludek suggests estimating it from counts and sample sizes instead.

> **Corroborated and quantified by Max Blumberg (CH14-01).** He checked three ways on the same six cities. The observed variance of the raw rates (0.0020) is smaller than the average within-city sampling variance (0.0025) on its own, so the between-city variance left over is about −0.0005, i.e. zero. A marginal maximum-likelihood fit of the beta-binomial to the counts — how the Robinson baseball example the chapter cites is done — gives a prior strength of about 1,540 rather than the method-of-moments 50, and shrinks every city to about 0.10. And a partial-pooling model in brms, the book’s own tool from Chapters 8 and 15, puts the between-city sd’s 95% interval near 0.01 with every city overlapping the overall rate. So on this data no city is distinguishable from average — which is the stronger version of the chapter’s own point, and matches what Chapter 15 lands for managers. Note this also breaks the promise in 14.3.2 that the reader will see empirical Bayes and the full model agree (see Bugs/Stat items on CH14-04).

### 2.5 · Ludek Stehlik · Open

Ch2 — the bench simulation allows more candidates to be promoted than there are roles: the scenario has 10 openings, but `rbinom()` on a 28-person bench regularly returns more than 10. Ludek’s fix keeps the teaching point intact — let the simulated count be candidates who are ready for promotion, and cap actual promotions at 10.

### 2.6 · Ludek Stehlik · Open

Ch15 — exposure problem in the transfer-request rate. Requests accumulate over a manager’s tenure but are divided by their current team size, so longer-serving managers can look worse purely for having been observed longer. Shrinkage is the chapter’s point, so Ludek suggests either acknowledging the limitation explicitly, or stating a simplifying assumption: equal observation windows and roughly stable team sizes.

### 2.7 · Ludek Stehlik · Open

Ch24 — the savings calculation prices the wrong event. Avoided transfer requests are costed as avoided resignations, but an internal move isn’t necessarily an exit. Either use costs that match the event actually modelled, or make the resignation example explicitly hypothetical — otherwise readers will take the money figure more literally than intended.

### 2.8 · Ludek Stehlik · Open

Ch24, decision rules — the probability threshold conflicts with the expected-net-benefit rule. Expected net benefit already accounts for unequal gains and losses, so it does not require the two error types to cost the same, and the proposed cutoff can produce a different recommendation. Ludek suggests dropping the threshold and staying with expected net benefit.

### 2.9 · Ludek Stehlik · Open

Ch24, value of a pilot — the calculation appears to assume the pilot always reveals the correct decision. Better labelled explicitly as an idealised upper bound than presented as the value of a realistic pilot, consistent with the distinction drawn earlier in the chapter.

### 2.10 · Ludek Stehlik · Open

Ch22 — the simulation generates repeated observations within offices, but the analysis treats them as independent: no office effects, no cluster-aware uncertainty. That likely affects the recommended study size. Worth re-running the simulation with an analysis that respects the office structure.

### 2.11 · Ludek Stehlik · Open

Ch18/21 — some passages move from an observed relationship to a claim about what a programme would cause. Ludek suggests separating what the model itself shows from the additional assumptions needed before recommending an intervention.

### 2.12 · Ludek Stehlik · Open

Ch21 — adjusting for an imperfect performance rating may leave some underlying confounding unresolved. Worth saying so where the adjustment is made.

### 2.13 · Ludek Stehlik · Open

Ch4/17 — “eventually promoted” needs a defined follow-up period, since “not promoted yet” is not “never promoted”. Ludek’s teaching suggestion: assume everyone has been observed over the same complete three-year period.

### 2.14 · Ludek Stehlik · Open

Ch17 — soften the reading of a flat survival curve. A plateau can mean some people never experience the event, but limited follow-up, or very few people still at risk, produces the same shape.

### 2.15 · Sara Ridley · Open

Ch7 — the performance-rating example never says what the ratings measure or how they are assigned, and the right reading of the result depends on it. If ratings are derived from sales figures the analysis is circular. If they take in customer complaints, coaching effectiveness or team behaviour, then a weak relationship with sales is perfectly reasonable and is not evidence of a broken rating system. Readers can’t tell which they are looking at.

### 2.16 · Sara Ridley · Open

Ch7 — two timeline questions go unanswered. What period do the sales figures cover (quarterly, annual, something else)? And what is the gap between the rating and the outcome it is being used to predict? Predictive validity decays, so a rating from 18 months ago carries far less information than one from last quarter. Sara notes these are exactly the questions a sceptical HR director or finance partner asks first, so the example should model the precision the book asks readers to adopt.

### 2.17 · Sara Ridley · Open

Ch7 — inter-rater reliability is not acknowledged. Ratings are assigned by different managers with different standards; one manager’s 3 is another’s 4. Pooling them assumes an equivalence that may not hold. Sara points out this is precisely the grouped structure Chapter 8 exists to handle, so either note that manager-level variation is being ignored for teaching purposes, or say that a more rigorous analysis would model manager as a grouping variable — which doubles as a bridge into Chapter 8.

### 2.18 · Sara Ridley · Open

Ch9 — the inter-rater reliability limitation raised in Chapter 7 is not revisited, even though the performance rating is now a predictor in a promotion model. Readers who spotted it earlier can’t tell whether it was addressed or quietly dropped. A sentence accepting ratings as given for modelling purposes, plus a pointer to multilevel approaches for a more rigorous treatment, closes the loop.

### 2.19 · Xiaoji Zhang · Open

Ch3, 3.2 — the Poisson example may be misfiled. It is offered under “a count of events with no natural maximum”, but Xiaoji asks the obvious question: isn’t the natural maximum the size of the team? If each person can request a transfer at most once in a year, transfer requests per team are bounded by headcount, which is a binomial situation rather than a Poisson one. Either pick an example that genuinely has no ceiling, or say explicitly why the ceiling is far enough away not to matter.

### 2.20 · Max Blumberg · Fixed

Ch4, 4.6.2 — “the peak sits slightly inside the dashed line” confuses the mode with the mean (Max, CH4-01). Each panel is Beta(1+k, 1+n−k), whose mode is exactly k/n — the dashed raw-rate line — so the plotted peak sits *on* the line, not inside it. What is pulled toward 0.5 is the mean: 0.222, 0.417, 0.406 and 0.402 against raw rates 0.143, 0.400, 0.400 and 0.400. The teaching point (a flat prior pulls belief toward 0.5 at small counts, fading as data grows) is right; only “peak” is wrong. Suggested: “at small counts the mean sits slightly inside the dashed line, pulled towards 0.5 — the peak stays on the raw rate.”

> Done: Ch4 now reads “at small counts the distribution’s *centre of mass* sits slightly inside the dashed line, pulled towards 0.5. The peak itself stays right on the raw rate — it is the lopsidedness of the curve that shifts the average, with more of the weight lying on the 0.5 side.” Max’s arithmetic checks out: each panel is Beta(1+k, 1+n−k), whose mode is exactly k/n, so the peak sits *on* the dashed line.

### 2.21 · Max Blumberg · Open

Ch5 — 5.2.4's “tiny” negative fraction and 5.3.10's 0.115 are two different quantities presented as one (Max, CH5-01). The “tiny” fraction is the FITTED model below zero, about 0.2% (Normal with mean 527, sd 185). The prior predictive check measures the fraction implied by the loose PRIOR before any data, which comes back at 11.5% because the prior on the mean is deliberately wide. 5.2.4 says it will “measure it” in the prior predictive check, which invites the reader to expect the tiny number and get the much larger one, described as “a small fraction”. Distinguish the two: name 0.2% as the fitted model's, and 11.5% as the price of a deliberately loose prior rather than of the Normal likelihood.

### 2.22 · Max Blumberg · Open

Ch13, 13.4.1–13.4.2 — the interaction worked example holds no interaction the data supports (Max, CH13-01). Refit in brms with your printed priors and seed: every interaction term's 95% interval includes zero (f2 about 45 [−15, 105], f3 about 11 [−48, 71], f4 about 39 [−29, 111]), the per-tier slopes come out about 45, 90, 56 and 84 with heavily overlapping intervals and no order by tier, and by LOO the interaction model is 1.5 worse with a standard error of 2.0 — it earns nothing. Your method (ask the model for predictions, look at whether the lines are parallel) is correct, but on this data the lines look non-parallel while the separation is inside the noise, which is the outcome your own fishing warning describes. A reader taking “read it from the lines, it needs no coefficient table” at face value could treat the visible non-parallelism as a result. Either add a clause that here the honest reading is “no clear interaction” — which shows the reader what an absent interaction looks like — or move the teaching point to data that holds one. Either way foreground the ribbon widths.

### 2.23 · Max Blumberg · Open

Ch13, 13.3.2 — the smooth worked example is a case where the straight line wins, and the fit throws divergences (Max, CH13-02). Refit in brms: LOO keeps the line, with the smooth 0.2 worse at a standard error of 0.3. That agrees with your own “when you can skip this” box (skip a smooth when the range is narrow; managers tenure runs 2 to 6 years), but a reader arriving from the bendy tenure-and-attrition example in 13.3.1 sees no bend in the worked one. Separately `fit_smooth` produces about 23 divergent transitions from the smooth's variance term, which Chapters 8 and 11 name as a signal to check before trusting a model; raising `adapt_delta` usually clears them.

### 2.24 · Max Blumberg · Open

Ch14, 14.3 — the worked prior is built from six groups, which 14.4 says is too few (Max, CH14-02). The flagship example estimates alpha0 and beta0 from six cities, and the next section opens “Empirical Bayes needs enough groups to estimate a sensible prior. If your organisation has five offices, estimating a Beta distribution from five raw rates is itself unreliable.” Six is barely above the line the chapter draws, and the shakiness of a six-group estimate is part of why the prior comes out as weak as it does. One line in 14.3 acknowledging six is on the low side, and that this is part of why 14.4 offers the benchmark route, settles it.

### 2.25 · Max Blumberg · Open

Ch14, 14.3.2 — the forward reference promises a comparison Chapter 15 never makes (Max, CH14-04). The text says empirical Bayes “works extremely well as an approximation to a full hierarchical model (Chapter 15 fits the ‘proper’ version and you'll see the answers are very close)”. Chapter 15 fits a Poisson multilevel model of transfer requests across individual managers — a different example — and never re-runs the city complaint rates or sets an empirical Bayes estimate beside a full-model one. And on the one example where the two can be compared, they do not agree. Either soften the promise or deliver it on the city data, which is also the fix for the empirical Bayes estimator item.

### 2.26 · Max Blumberg · Open

Ch15, 15.4.1 — with one row per manager, sd(Intercept) is an overdispersion term, so “how much managers truly vary” claims more than the data can isolate (Max, CH15-01). The reproduction is exact (0.88 [0.71, 1.07]). The interpretation is the issue: with exactly one observation per manager the manager-specific intercept is an observation-level random effect, which is mathematically an overdispersion term — it absorbs every way a manager's single count can depart from the Poisson mean, not only a difference in their underlying rate. The model does strip out the sampling noise team size creates, as the text says, but what is left is dispersion from any source, which bounds how much managers truly vary rather than isolating it. The tell: a plain negative binomial with no manager term describes the counts about as well. None of this touches the shrinkage or the ranking. The chapter already hedges once in the same paragraph (“or at least whatever drives transfer requests”) — carry that hedge into the headline sentence.

### 2.27 · Max Blumberg · Open

Ch16 — the 49% ICC is computed on major medians, so it overstates how much structure explains on individual pay (Max, CH16-01). The dataset has one row per major and the outcome is that major's median salary, so the within-group variance the model sees is only the spread between medians, not between people. The 49% is therefore the between-discipline share of variation in major medians. Section 16.4 then sends the reader to point the same model at an internal comp file with one row per employee, where person-to-person spread re-enters the within-group term and usually dominates. Max simulated it to your own structure: the ICC on medians stays near 0.43–0.51, while the ICC on individuals falls to about 0.40, then 0.17, then 0.09 as the within-major spread rises from $12k to $20k to $28k. At a realistic person-level spread “about half the variation is between disciplines” becomes about a sixth. The computation is correct for its data; the gap is that the number does not carry to the file the reader is sent to build. One caveat in 16.4 — read it as close to an upper bound — costs a sentence.

### 2.28 · Max Blumberg · Open

Ch17 — the fitted Weibull shape contradicts the chapter's reading of the Kaplan-Meier curve (Max, CH17-01). **Verified in your own frozen output:** `shape 1.08 [1.01, 1.15]`, and the frailty model `1.11 [1.04, 1.18]` — both intervals entirely above 1, meaning a flat-to-slightly-rising per-month risk. But 17.4.1 describes the “shape below 1 — the hazard decreases over time” case as “the usual pattern in employment data, and it's the shape the Kaplan-Meier curve above already hinted at”. Two linked problems. First, a survival curve falling fastest early does not on its own mean the hazard is highest early: with constant per-month risk the curve still falls fastest at the start, simply because the most people are still present to leave. Max simulated a constant-risk population and the curve fell about two and a half times as fast in year one as in a later year, while the recovered shape was 1.02 — so 17.3 reads a stock effect as a hazard effect. Second, by the chapter's own rule (“if the model says the hazard is flat and the raw curve plainly drops off a cliff in year one, the Weibull's shape assumption is fighting your data”), a shape near 1 beside that curve is exactly the signal to report. The chapter states the rule and then does not apply it to its own output. Connecting 17.3 and 17.4.1 turns a contradiction into the chapter's best teaching point.

### 2.29 · Max Blumberg · Open

Ch22, 22.4 — the low-ESS warning quoted in the “model that strains” box did not reproduce (Max, CH22-01). On data generated with your own `set.seed(21)`, across five sampler seeds in brms 2.20.4, the bulk effective sample size stayed between about 500 and 960 and the sampler was quiet each time. The mechanism the box explains is correct and confirmed — the treated main effect was the worst-mixing parameter in every run, because it competes with the office-level intercepts, exactly as described. So the explanation stands; the specific warning quoted as its outcome appears to depend on brms/Stan version, iteration count or seed. Max is explicit that your own version may legitimately produce it (he rates only 60% that this warrants a change). Safest fix: keep the explanation and, in place of the quoted warning, show the treated coefficient's reduced effective sample size, so the point holds whatever the version does.

## 3. Clarity & Accessibility — Recommended

*These affect whether readers unfamiliar with the terms can follow the book — flagged separately from style per your note that legibility should win over preserving style.*

### 3.1 · Sara Ridley · Fixed

The book is pitched at a broad range of readers but assumes they already know what “Bayesian” means. Consider a short explainer near the start.

### 3.2 · Sara Ridley · Fixed

“SEM” is used as an acronym without explanation. Consider spelling it out, at least on first use.

### 3.3 · Sara Ridley · Fixed

“I/O” is used as an acronym without explanation. Consider spelling it out in full.

### 3.4 · Sara Ridley · Fixed

Readers who want to follow along with the code aren’t pointed to an R environment. Consider a brief signpost in the Welcome section — Sara found Posit Cloud, a free browser-based setup requiring no installation.

> Your call: give a short reference on downloading R and RStudio/Positron, plus a few resources. Done: new appendix, "Getting started with R" (appendices/A0-getting-started-with-r.qmd), listed first in _quarto.yml. Covers installing R from CRAN, RStudio Desktop vs Positron, installing packages, the C++ toolchain note for brms, and Posit Cloud for readers who’d rather not install anything. Includes a warning to check you’re on the real download site and to check your org’s software catalogue first — both straight from Xiaoji’s experience. Resources section points at the Posit cheatsheets, R for Data Science, McNulty’s regression book, and ?help.

### 3.5 · Sara Ridley · Fixed

“tidyverse” and “brms” are both mentioned without much context for the uninitiated. Consider a short explanation of what each actually is.

> Your call: as above. Done: "The packages this book leans on" section in the new R appendix explains what the tidyverse is (a collection, not one package, with a table of the five you’ll actually see) and what brms is and does. Chapter 1’s setup callout now points there.

### 3.6 · Sara Ridley · Fixed

It’s not clear upfront who the Foundations section is aimed at — readers new to statistics, new to R, or both — or whether readers should get hands-on with R now given it reappears in later chapters. Sara (experienced with stats, new to R) wasn’t sure how much to engage with the code versus read past it.

> Your call: new to stats or R → run the code for practice; otherwise read. Key point: someone experienced with stats but new to Bayesian still needs Foundations to start the mental jump. Done: the Welcome now carries all three reader paths in “How to read this”, in your terms — run it if you’re new to stats or R; read past it if you know stats but don’t write R (noting those readers aren’t getting a lesser version of the book); and a paragraph headed “What nobody should skip is Part I” making your mental-jump argument explicitly. Also fixed a contradiction found while doing it: the Part I blurb told stats-experienced readers to “skim it if you’re not [new to statistics]” — the opposite of your instruction. It now says start here whatever you arrive with, read it faster but don’t skip it. The appendix section covering the same ground is cross-linked.

### 3.7 · Sara Ridley; Xiaoji Zhang · Fixed

`na.rm = TRUE` (1.3.3) is introduced without explanation of what it does (excludes missing values) — confusing on first read for a non-R reader. Flagged independently by two reviewers. Xiaoji’s suggestion: spell out what it stands for (“NA Remove”) — once readers know commands are usually word shorthand, they get better at guessing meaning even where it isn’t explained every time.

> Your call: agreed, add a small note. Done: 1.3.3 now expands na.rm at first mention — "NA remove", NA being R’s marker for a missing value, so the argument reads as remove the missing values before calculating. Followed by a short callout making Xiaoji’s more general point: most R names are squashed-up words (sd, cumsum, IQR, rbinom), reading them that way lets you guess new ones, and ?name gives the documentation when a guess fails.

### 3.8 · Xiaoji Zhang · Fixed

1.1 Setup doesn’t cover installing RStudio. Add install instructions and a link to the official download site — Xiaoji had to check with her analyst to confirm it wasn’t a phishing site, and only then learned her org has an enterprise version available via the software center.

> Your call: see the RStudio note above. Done: 1.1 Setup opens with a "Before you start" callout pointing to the new R appendix for install instructions, and to the reader-paths section for those who’d rather read than type. The "package not found" tip now also explains what a package is and links to the install section.

### 3.9 · Xiaoji Zhang · Fixed

1.2 doesn’t tell the reader to have RStudio installed and open before they start following along — add that instruction (ties to item 8).

> Your call: as above. Done: covered by the same "Before you start" callout, which sits at the end of 1.1 immediately before 1.2 and tells the reader to have R and an editor installed and open before going further.

### 3.10 · Xiaoji Zhang · Fixed

2.2.4’s note on set.seed(202) uses “seeded” without explaining what seeding is. Suggestion: explain in plain language first — this code generates random numbers, and a “seed” is just the starting number; its specific value doesn’t matter, only that reusing it reproduces the same results on every run. As written, a reader is left wondering what 202 means.

> Your call: as point 7. Done: a callout before the 2.2.4 simulation, "What set.seed() is doing, and why 202" — explains that the code invents random numbers, that R’s randomness comes from a formula whose starting number is the seed, and that the specific value is arbitrary (202 and 7 work identically); only fixing it matters. Ends by inviting the reader to change the number and re-run.

### 3.11 · Xiaoji Zhang · Fixed

The 2.4.2 “Your Turn” exercise (P(promoted | customer rating above median)) assumes the reader can use `mutate()` to bucket a numeric variable, which has only appeared once before and wasn’t taught as a technique. Xiaoji could follow AI-generated code but couldn’t derive the median-split approach unaided. Suggestion: give `mutate()` more scaffolding, or a worked example, before this exercise.

> Your call: push to the R/RStudio appendix and point readers at Posit’s content, e.g. the cheatsheets. Done: the appendix’s "Where to learn R properly" section leads with the Posit cheatsheets and calls out the dplyr one specifically, naming mutate() as the verb the book uses without ever teaching. The 2.4.2 exercise is also reframed to lead with the thinking — it now asks how you would examine whether a higher customer rating changes the odds, explains why a numeric variable has no group to condition on until you make one and that where to cut is a business judgement, then offers the median split. A closing tip names mutate() and sends the reader to the cheatsheets. This also covers Style #11.’D PREFER TO POINT READERS THERE (EG THE CHEATSHEETS)

### 3.12 · Xiaoji Zhang · Fixed

The simulation code in 2.5.1 (`rbinom()`, the `cat()` shortfall calculation) isn’t walked through, and Xiaoji found it hard to work out what it was doing. Suggestion: add a plain-language explanation of what each function/line does, at least on first appearance.

> Your call: as point 7. Done: the 2.5.1 bench simulation now carries code annotations in the book’s existing style. rbinom() is explained as "random draws from a binomial" running one bench through one cycle, with each argument named; the cat() line is unpacked as the answer — the comparison produces 10,000 TRUE/FALSE values, mean() of them is the proportion of years you came up short, the same 0/1-mean trick from Chapter 1 doing real work.

### 3.13 · Sara Ridley · Fixed

Ch7 — LOO appears in the chapter’s opening summary before it is explained in 7.5.2, which is disorienting for anyone reading sequentially. A brief signpost at first mention would fix it.

> **Related, from Max Blumberg (CH7-02):** 7.5.2 describes LOO as leaving out each observation and refitting, which is exact leave-one-out cross-validation. What `loo()` actually does is approximate that from the single full-data posterior using Pareto-smoothed importance sampling — it does not refit 350 times, which is precisely what PSIS-LOO exists to avoid. The 7.5.4 ML/DS tip says this correctly, so the chapter is consistent taken whole, but a reader who stops at 7.5.2 is left with the wrong mechanism. Half a sentence in 7.5.2 aligns them.

> Done, both halves. Ch7’s opening summary now glosses LOO at first mention — “a way of scoring a model on data it has not seen, introduced properly later in this chapter”. And 7.5.2 now says outright that `loo()` does **not** refit the model 350 times but approximates what those refits would have said, from the single posterior, using Pareto-smoothed importance sampling, pointing on to the ML/DS note that already had it right.

### 3.14 · Xiaoji Zhang · Open

Ch3, 3.2 — the shorthand descriptions of the three distributions are helpful but not plain-language enough to choose between them quickly. Xiaoji wants a decision tree: something that gets a beginner to the right model, or lets them sanity-check an analyst’s claim, without having to hold all three definitions in mind. She built one with an AI assistant from her reading, tested it against examples from her own work, and reports it works better for her than the prose. Worth asking her for it — the book already ships hand-built SVGs in figures/, so a decision tree would sit naturally there.

### 3.15 · Xiaoji Zhang · Fixed

Ch3, 3.3 — “Add lots of little nudges together and you almost always get a bell” uses two words that don’t carry their meaning. “Nudge” is never defined and isn’t plain language — Xiaoji suggests “contributing factors”. And “add” turns out to be literal (it becomes `sum()` in the example), but reads as the general English “add”, so the connection to the code isn’t obvious until you get there.

> Done: “nudge” is replaced by “contributing factor” through the CLT section — the callout, the walkthrough line, the code annotation and the chart’s x-axis label. The callout now also settles the second half of Xiaoji’s point: “Read ‘add’ literally, not figuratively — it is the `sum()` in the code below.”

### 3.16 · Xiaoji Zhang · Open

Ch3, 3.3 — the `runif()` walkthrough lands well, but the flat distribution it describes is never actually plotted. Xiaoji wants to see it: the contrast between the flat inputs and the bell that emerges is what drives the point home, and right now the reader has to take the flatness on trust.

### 3.17 · Xiaoji Zhang · Fixed

Ch3, 3.3 — the preconditions for the Central Limit Theorem aren’t stated plainly enough to act on. Xiaoji’s reflection: “In reality, it seems difficult to know if I have considered all contributing factors, and if all the contributing factors are actually independent, and lastly if they can be ‘added’ up. So is it the lesson here to not assume a distribution is normal by default?” That is exactly the right takeaway, and the fact she had to ask suggests the chapter should say it outright.

> Done: the central-limit-theorem note now names the four conditions *as* conditions — many, small, independent, added — gives a way each can break (one dominant factor, contributions that move together, an outcome built by multiplying), and states the working rule outright: check the shape rather than assume it. Which is exactly the conclusion Xiaoji reached unaided.

### 3.18 · Xiaoji Zhang · Fixed

Ch3, 3.3.6 — `after_stat(density)` is explained as rescaling the histogram so its total area is 1, but not why the area needs to be 1. One more sentence closes it.

> Done: the annotation now says why the area has to be 1 — the value has to land somewhere, so the total probability, and therefore the area under any density curve, is 1 by definition — before going on to the scale problem.

### 3.19 · Xiaoji Zhang · Fixed

Ch3, 3.4.2 — the range “anywhere from about 9 to 21 is unremarkable” arrives without derivation. Xiaoji asks: why 9 to 21, is that two SDs, and how would I know what the SD is here? Either show the arithmetic or say where the numbers came from — the chapter is otherwise careful to do so.

> **Independently flagged by Max Blumberg (CH3-01), who supplies the answer.** The Tip rounds the real promotion rate of 0.3229 down to “30%”, while the chart directly above it shows 0.32. That pulls both numbers low: at 0.32 the expected count is 16.1, not 15, and the 95% unremarkable range is about 10 to 23 (qbinom at 2.5% and 97.5%), not 9 to 21. Everywhere else in the chapter uses the precise figure. Two reviewers at opposite ends of the expertise range landing on the same Tip — one asking where the numbers came from, one showing they are a notch low — makes this worth fixing rather than leaving as a deliberate round number.

> Done: the Tip now uses the real 32% rate, expects about 16 promotions, gives 10 to 23 as the unremarkable range, and shows the derivation on the page (`qbinom(c(0.025, 0.975), size = 50, prob = 0.32)`). That answers Xiaoji’s “where did these numbers come from” and Max’s arithmetic in one edit.

### 3.20 · Xiaoji Zhang · Fixed

Ch3, 3.4.2 — a forward signpost to Chapter 18 would help. Xiaoji recognised that the binomial framing doesn’t fit a Likert item and asked what does: “A lot of divisions asked what it means when an item’s average changed from 4.5 to 4.3. My gut feeling is there may not be any meaningful change… A separate question is for the Likert scale question, what is a statistical method to apply to tell when it’s meaningful change, when it just may be noise?” She reasoned her way to the right conclusion unaided; a pointer to Chapter 18 would reward that.

> Done: a note directly after the Binomial Tip says the framing works because promotion is a countable yes/no event, that a Likert item is not — “even though its average looks like a number you could treat the same way” — and that whether a move from 4.5 to 4.3 means anything needs the ordered-category model in Chapter 18.

### 3.21 · Max Blumberg · Fixed

Ch4, 4.5.3 — “a method that claims to use no prior information at all … no legitimate place to declare it” overstates the classical position (Max, CH4-03). The rhetorical point stands, but a reader from ML would note that classical regularisation does have a place for prior-like information: ridge regression is a Gaussian prior on the coefficients, the LASSO a Laplace prior, and empirical Bayes estimates the prior from the data. A half-sentence acknowledging that penalised methods encode a prior implicitly would actually strengthen your case that everyone has one.

> Done: Ch4 now adds that classical practice does let prior-like information in without calling it a prior — ridge as a Gaussian prior on the coefficients, the LASSO as a Laplace one, empirical Bayes estimating the prior from the data itself — and turns it into support for the argument rather than a concession: everyone has a prior, the question is only whether it is written down where you can argue with it.

### 3.22 · Max Blumberg · Fixed

Ch5, 5.6.3 — “there is a 100% probability their underlying average is genuinely the higher of the two” teaches a habit that overstates certainty (Max, CH5-02). `mean(difference > 0)` counts posterior draws above zero; none of the 4,000 fell below, so it prints 1.00. Here the true probability really is extremely close to 1, so the claim is not misleading in this example. But it teaches the reader to report a Monte Carlo 1.00 as “100% probability”, and where the true probability were 0.999, 4,000 draws could still all land above zero. “Essentially 100% — none of the 4,000 draws fell below zero” carries the honest habit into cases where the margin is thinner.

> Done: the plain-English box now reads “their underlying average is almost certainly the higher of the two — X% of the posterior points that way”, and a following paragraph teaches the habit: read a printed 100% as *essentially* 100%, because 4,000 draws cannot tell 0.999 from 0.99999.

### 3.23 · Max Blumberg · Fixed

Ch5, 5.6.3 — the promoted-versus-not comparison is a selected one, worth one clause (Max, CH5-03). The worked comparison concludes that promoted staff sell about 336 more, which is almost certainly because people are promoted partly for selling well — so it describes two groups rather than estimating an effect of promotion. The technique is taught correctly and the causal reading is not the point, but the example invites it, and the book is careful about causation from Chapter 21 on. One clause noting this is a comparison between selected groups, not the effect of promoting someone, stops a reader carrying the wrong reading forward.

> Done: a note now says promoted and not-promoted are **selected** groups, that people are promoted partly for selling well, and that the gap therefore describes a difference between two groups rather than the effect of promoting someone — with a pointer to Chapter 21.

### 3.24 · Max Blumberg · Fixed

Ch6 — customer rating is used as a continuous number while performance gets a caveat, with nothing explaining the difference (Max, CH6-01). The main model treats `customer_rate` as continuous, which is right: it is an averaged customer-satisfaction score carrying decimals, not a single 1-to-5 tick. But “Your turn” exercise 1 flags performance — an integer 1-to-4 rating — as something that “deserves a second look” as a plain number, pointing to Chapter 18. A reader new to statistics may not see why one rating is used without comment and the other carries a health warning. One clause where `customer_rate` is introduced, distinguishing an averaged continuous score from a single ordinal item, closes the gap and shows the measurement care underneath. (Related to Sara's Ch7 items on what the ratings measure.)

> Done: a note by the Ch6 scatter explains that `customer_rate` is an *averaged* satisfaction score carrying real decimals, so a step from 3.2 to 3.4 means much the same as one from 4.2 to 4.4, while a single ordinal tick like the 1-to-4 performance rating carries no guarantee of equal gaps. That is why the “Your turn” exercise flags one and not the other, and why Chapter 18 exists.

### 3.25 · Max Blumberg · Fixed

Ch7, 7.2.4 — the “mistake everyone makes once” callout uses an invented number that clashes with the table above it (Max, CH7-01). The callout teaches the single most useful point in the chapter — a categorical coefficient is a difference from the reference, not a level — using an illustrative `performance_f3` of 210. The model output a few lines earlier gives `performance_f3` as 83.39. A beginner, the reader this callout is written for, may flip back, see 83 where the callout says 210, and think they have misread one or the other. Either use a round version of the real coefficient (about 83) or mark 210 as hypothetical (“say the output had read 210”).

> Done: the callout now uses the real coefficient — “Read `performance_f3 = 83.39` as ‘tier 3 sells about 83 more than tier 1’, never as ‘tier 3 sells 83’” — so it no longer clashes with the output a few lines above it.

### 3.26 · Max Blumberg · Fixed

Ch7, 7.5.4 — the “two to four times its se_diff” rule is sound working practice, and se_diff is itself uncertain (Max, CH7-03). The chapter's caution around it is right (“resist the urge to declare a winner from a difference of 1.2 with a standard error of 3”). Worth a reader knowing that se_diff is an estimate, and that the normal approximation behind the rule can be optimistic when two models are close and one nests inside the other (Sivula, Magnusson & Vehtari, 2020) — which is exactly the `fit_simple`-inside-`fit_combined` case here, where the ratio sits near 2.4. Your own “smaller than its own standard error means pick the simpler one” already protects against the main error; this is only about not over-trusting a ratio of 2 to 3.

> Done: the “Don’t just read the top row” box gains a refinement for ratios near the bottom of the range — `se_diff` is itself an estimate, and the normal approximation behind the rule can be optimistic when two models are close and one nests inside the other, which is exactly `fit_simple` inside `fit_combined` (Sivula, Magnusson and Vehtari, 2020). Framed as a reason not to treat a ratio of 2 or 3 as settling the matter, with the existing “smaller than its own standard error, pick the simpler one” rule left as the main guard.

### 3.27 · Max Blumberg · Fixed

Ch8, 8.2.1–8.2.2 — reliability quoted as one standard error, then drawn as two (Max, CH8-01). 8.2.1 describes an office average as “worth about ±5 points” for Toronto and “±15” for Houston, which are the standard errors themselves. One paragraph later the plot draws its error bars at two standard errors, subtitled “Bars ≈ 95% range”. Both are right and an expert reads the shift without trouble, but a beginner may take the ±5 and ±15 as the bars they are about to see, then meet bars twice as wide. Half a sentence noting the figures are one SE and the bars are two keeps them aligned.

> Done: Ch8 now reads “One standard error is about 5 points for Toronto and about 15 for Houston — and because a 95% range runs roughly two standard errors either side, that is ±11 against ±31”, so the quoted figures and the plotted bars line up. The three-times-less-reliable conclusion is unchanged.

### 3.28 · Max Blumberg · Open

Ch9, 9.4.2 — “we're confident in that gap” is read from non-overlapping intervals, where Chapter 7 took the difference (Max, CH9-01). The claim rests on the top tier at 0.51 [0.38, 0.64] and the mid tier at 0.21 [0.14, 0.29] — two separate credible intervals that happen not to overlap. Chapter 7 was careful to make exactly this comparison by taking the posterior of the difference draw by draw (`compare_levels`), because the two groups' draws are correlated and summarising each first then subtracting throws that correlation away. Here the intervals are far enough apart that the conclusion is safe either way, but a reader who took the Chapter 7 lesson to heart will expect the gap stated as its own posterior — which is also the number the stakeholder is really being told is reliable.

### 3.29 · Max Blumberg · Fixed

Ch11, 11.2.2 — the accept-a-downhill-step rule is described by the size of the drop, where it is really the ratio of heights (Max, CH11-01). The text reads “with a chance equal to how much lower it is”. The Metropolis rule accepts with probability min(1, p_new / p_current) — a ratio, not a difference. On a log-plausibility scale the two coincide (acceptance = exp(−drop)), which may be the intended picture, but the text does not say the height is logged. The beginner intuition and the direction are right; if a half-sentence is wanted: a spot half as plausible is accepted about half the time.

> Done: the pseudocode now reads “with a chance equal to how much lower it is *in proportion* (half as plausible: move about half the time; far less plausible: rarely move)”, which is the Metropolis ratio rather than the size of the drop.

### 3.30 · Max Blumberg · Fixed

Ch11, 11.5 — divergent transitions appear only in the list of fixes, never shown (Max, CH11-02). The chapter's method throughout is to show a broken fit rather than assert it — the trace plot, the R-hat plot and the summary table of `fit_bad` all appear. Divergences are named only among the fixes, so a reader meets the term and the `adapt_delta` remedy without seeing what one looks like or which diagnostic surfaces it. The broken model here trips max-treedepth and BFMI warnings rather than divergences, so the chapter never displays one. A one-line note that divergences are a separate warning, most common in hierarchical models (Chapter 8's world), would give the reader the missing example. Worth pairing with the divergences Max found in Ch12's `fit_vs` and Ch13's `fit_smooth`.

## 4. Style & Structure — Hold for Review

*Editorial and voice calls — worth weighing against your own intentions for the book rather than acting on immediately.*

> Done: the divergences bullet now says this is a *separate* warning from the ones the broken model on that page produced — which is why the reader has not seen one — and that divergences turn up most often in hierarchical models, Chapter 8’s territory, where a group-level standard deviation is pushed towards zero and the sampler has to work down a narrowing funnel.

### 4.1 · Sara Ridley · Open

The “Why I wrote it” and “Who this book is for” sections feel lengthy to Sara; she thinks they could be condensed without losing anything important.

### 4.2 · Sara Ridley · Open

In “How the book is organised”, consider noting each Part’s relative size/scope (e.g. “the heart of the book, in three chapters”) so readers can calibrate expectations before starting.

### 4.3 · Sara Ridley · Open

Part 5 reads as structurally uneven — some chapters carry more supplementary detail than others. Worth reconsidering the structure.

### 4.4 · Sara Ridley · Open

Median vs mean: the case for the median is statistically sound, but many stakeholders won’t know what a median is and may not be receptive to it. Consider acknowledging that the median is often more useful to the analyst than to the audience. Sara’s own practice: publish the mean, address outliers explicitly in the narrative (recalculate without them, or show the percentage achieving a target).

### 4.5 · Sara Ridley · Open

The “why the difference matters” example would land better if the mean value were actually stated.

### 4.6 · Sara Ridley · Open

The promotion statistic’s binary 0/1 framing feels abstract without a timeframe attached (e.g. does a 1 capture a promotion from 18 years ago for someone who joined 20 years ago?). Sara notes promotion data isn’t usually handled this way in practice.

### 4.7 · Sara Ridley · Open

Performance ratings are often subjective in real-world settings unless based on specific, consistently applied, measurable criteria — worth acknowledging that limitation.

### 4.8 · Sara Ridley · Open

Pushback on “a request for historical data is usually a question about the future” — in Sara’s experience the motivation is more often establishing a baseline (where things stand, to decide whether to act, celebrate, or leave alone), which isn’t quite the same as future-orientation.

### 4.9 · Xiaoji Zhang · Open

“Your Turn” exercises have no answer key. Xiaoji suggests adding one — e.g. at the end of the book — so readers can check their own understanding.

### 4.10 · Xiaoji Zhang · Open

2.4.1’s promotion-by-performance table could use a reflective prompt straight after it — e.g. “what story is your mind already forming after seeing this table?” — to build the habit of catching an unstated causal story before the book makes the point explicitly. Xiaoji’s own reaction to the table (“as performance goes up, people are more likely to be promoted… but I don’t actually know that”) is a good illustration of exactly the instinct worth naming.

### 4.11 · Xiaoji Zhang · Fixed

2.4.2’s “Your Turn” raises a goal question worth settling: is it teaching readers to write the R code, or to apply the conditional-probability concept to a numeric variable? For a reader like Xiaoji — focused on the concept, not on writing R herself — the code-first framing was a jump in difficulty. Her suggested alternative wording: “Apply this to customer rating. How would you examine whether a higher customer rating changes the promotion odds?”, with more unpacking of how to think about numeric variables in categories. Actioned: the exercise is reframed to lead with the concept — it now asks how you would examine whether a higher customer rating changes the promotion odds, explains why a numeric variable has no group to condition on until you make one, and notes that where to cut is a business judgement rather than a statistical rule. The median split follows as one answer, not the answer. See Clarity #11.

### 4.12 · Xiaoji Zhang · Open

In a few places — most notably 2.5.1, the succession-pipeline bench-size problem — the R code appears right after the question is posed, handing readers the answer before they’ve worked through their own approach. Two suggestions from Xiaoji: (1) after “How big should the bench be?”, add a pause prompting readers to think about their own approach before the simulation solution is introduced; (2) before showing any code, prompt readers to think through their approach in plain language first — if they know their approach, they can get an AI tool or colleague to help write the R. Xiaoji’s own worked-through reasoning on 2.5.1 (see raw log below) is a good example of the thinking this would protect.

### 4.13 · Xiaoji Zhang · Open

2.5.1 stops once a bench size is chosen, but Xiaoji’s real use case is translating that number into a recommendation leadership will accept — especially when it isn’t the intuitive answer (naively: “need 10, p=0.3, so ~30 should do it”). Suggestion: add sample leadership-ready language for a result like this, or point to a later chapter/section that covers it.

### 4.14 · Sara Ridley · Open

Part III as a whole — the statistical framework is rigorous and the methods are explained well, but the examples don’t always make their contextual assumptions explicit, and those assumptions are the first thing a practitioner has to establish in real use. Sara is explicit that she is not asking for every variation to be explored — well-defined examples are what a teaching text needs — but being clearer about how ratings are generated, what timeframes apply, and what underlies the data-generating process would make the examples usable as practical templates. Where a different real-world situation would need a different approach, a brief signpost elsewhere in the book would add more. This is the editorial call sitting behind Statistical & Methodological items 15-18.

> **Adjacent, from Max Blumberg (INT-04):** for audience 1, genuine beginners, the introduction runs long and name-checks SEM, SPSS, STATA, econometrics, game theory and decision science before any statistics has been met, which may read as in-group to the reader it most wants to reassure. He rates it Low priority at 60% confidence and calls it your call. Filed here alongside Sara’s length note since both concern the same two sections.

### 4.15 · Xiaoji Zhang · Open

Ch3, 3.7.3 — the “small samples improve cheaply, large samples improve expensively” framing is valued, but Xiaoji raises what it leaves out for small teams, and flags it herself as “a side-step for a statistics book”. For a 15-person team, pushing response rate from 50% to 100% may not buy reliability worth having. The effort may matter more than the number: better communication, manager engagement and visible action on the last survey may already have addressed the problem. A sharp year-on-year jump can also be a warning sign — pressure to complete produces dishonest answers and a more misleading result than a low response rate would. Her practitioner’s conclusion is that small divisions often need a different diagnostic altogether (focus groups, skip-levels, observable behavioural signals), not a harder push, especially where they fall below the privacy threshold for releasing results at all. Your call whether a statistics book carries this, but it is the conversation she has constantly.

### 4.16 · Max Blumberg · Open

Intro — the AF447 opening could signal its link to Chapter 24 (Max, INT-03). The search is formally an application of Bayesian search theory and decision analysis — minimising expected time to detection — which is the same decision-under-uncertainty machinery the book reaches in Chapter 24. One line connecting the opening story to the loss/decision framing would frame the whole arc for the advanced reader. Explicitly optional.

### 4.17 · Max Blumberg · Open

Ch4, 4.4.7 / 4.6.3 — the posterior mean is the Bayes estimator under squared-error loss, which Chapter 24 later formalises (Max, CH4-02). An opportunity rather than an error: one line connecting the posterior mean here to the loss framing later would tie the two together for a reader who has met Bayesian estimation formally. Low priority, and it competes with the book's deliberate choice to save decision theory for Chapter 24.

### 4.18 · Max Blumberg · Open

Ch4, 4.8 — “Direct probability answers are the Bayesian superpower” (Max, CH4-05). Minor tone note: “superpower” sits a little against the even-handed “right tool for the job” stance the Welcome now takes. Once is fine if you want the lift; flagged only so it is a choice. Max rates his own confidence at 60%.

### 4.19 · Max Blumberg · Open

Ch6, 6.4.1 and 6.4.3 — “confident” in the payoff sentences, for the reader being weaned off confidence intervals (Max, CH6-02). The Bayesian reading of a credible interval really does support “95% probability the value lies here”, so the sentences are not wrong. But one of your two target readers is the frequentist-trained analyst you are trying to move off the phrase “confidence interval”, and “confident” in the very sentence that delivers the result sits a shade against that aim. The chapter elsewhere draws the contrast cleanly (“No p-values, no ‘fail to reject’”). Optional: “we put 95% probability on”, or “the interval is credibly above zero”. Max rates it 55% — keep as-is if the plain register is intended.

## What’s Working

*Context to keep, not action items.*

- The airplane example as an opening hook — compelling, and makes the book’s subject clear immediately. *(Sara Ridley)*
- The logical organisation of the book — smooths the reader’s journey before they make it. *(Sara Ridley)*
- The “why people analytics” section — resonated personally and built excitement to keep reading. *(Sara Ridley)*
- “People Are Not Good at This” — very relatable, well explained, ties in well with the book’s broader message. *(Sara Ridley)*
- “Thinking in Chances” and “Distributions, Sampling and the Idea of a Model” sections — both excellent, no suggestions at this stage. *(Sara Ridley)*
- 1.5.1 (“Meet the engagement survey”) — the note that skewed-positive results are the normal shape of an engagement survey gives Xiaoji language she’s wanted for years: being able to say “that’s the norm” when leaders ask what good looks like, and helping HR practitioners notice when a shape is genuinely unusual. *(Xiaoji Zhang)*
- “Always ask why they’re asking” — resonates directly with what Xiaoji sees from some analysts, who answer the literal data request without addressing the underlying problem, leaving HR leaders with data they still can’t use. *(Xiaoji Zhang)*
- Overall verdict: “a really good book”, and particularly strong at connecting the theory to the practical side of using Bayesian methods to reason about uncertainty in models and data. *(Ludek Stehlik)*
- “I only wish something like this had been available when I was entering the field” — Ludek expects the People Analytics community to find it useful. *(Ludek Stehlik)*
- Ch7 — the LOO explanation, and especially the random-noise demonstration, which makes it obvious that good fit is not evidence in itself. *(Sara Ridley)*
- Ch8 — the league-table example landed immediately: Sara currently excludes teams with fewer than 40 respondents from engagement analysis, and the chapter showed her partial pooling largely removes the need for that threshold. *(Sara Ridley)*
- Ch8 — the shrinkage explanation, the suggested stakeholder framing (“practical and easy to apply”), and funnel plots as a way to bring a sceptical audience along before the full model arrives. *(Sara Ridley)*
- Ch9 — “clear, well-paced, and highly practical”. The odds-ratio warning especially: Sara has seen that mistake repeatedly in promotion and pay-equity analyses, and the worked example makes the scale of it tangible. *(Sara Ridley)*
- Ch9 — the predicted-probability chart is “exactly the sort of output practitioners need”, and the guidance on summarising results verbally is well judged. *(Sara Ridley)*
- Ch10 — the outcome-family table works as a standing reference Sara expects to return to, and the observation that steps 7 and 8 get skipped rang true: time pressure is exactly where analytical discipline erodes. *(Sara Ridley)*
- Ch8 applied to real data — Sara ran the multilevel model on her own engagement survey (600+ employees, eight directorates). Clean diagnostics, an immediately interpretable shrinkage plot, and a finding that changed how she reads directorate league tables. *(Sara Ridley)*
- Ch3, 3.4.2 — “A distribution is a model — a useful approximation, never the literal truth. The skill is knowing when the approximation is good enough.” Xiaoji calls this the most helpful framing in the chapter: “Most decisions I make or support leadership to make in the end rest on knowing what/when it’s good enough.” *(Xiaoji Zhang)*
- Ch3, 3.7.3 — the small-samples-improve-cheaply / large-samples-improve-expensively contrast, which Xiaoji found “a very helpful practical framing”. *(Xiaoji Zhang)*
- Ch3, 3.3 — the “read this from the inside out” walkthrough of the `runif()` call, which she singles out as a helpful way to unpack nested code. *(Xiaoji Zhang)*
- The whole book's arithmetic, independently verified. Max reproduced essentially every printed number — in Python where R wasn't available, then in real brms — across the Introduction and Chapters 1 to 23. Chapters 1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 15, 16, 17, 18, 20, 21, 22 and 23 each carry a “verified correct” entry with no change requested; Chapter 18 came back completely clean. Where a finding exists it is almost always in the prose, not the code. *(Max Blumberg)*
- Ch1, 1.8 “What they're really asking for” — the move from a request for history to a question about the future, and the biases listed under it, called the strongest part of the chapter and what sets up the rest of the book. *(Max Blumberg)*
- Ch4, 4.2 — negotiating the VP's “I don't think we're promoting enough” down to one unknown number, and saying it “matters more than anything statistical you'll do afterwards”. Max calls it the strongest practitioner move in the book. *(Max Blumberg)*
- Ch8, 8.6.2 — the multiple-comparisons argument, that partial pooling does structurally what a Bonferroni correction does by decree, carefully bounded to the multilevel model rather than to Bayes in general, with the Gelman, Hill & Yajima citation for a reviewer who pushes. “The strongest passage in the chapter and the one an expert reader will most want to argue with and then concede.” *(Max Blumberg)*
- Ch21, 21.5.3 “Both models fit, and that is exactly the problem” — the posterior predictive check passes for both specifications, so it cannot choose the adjustment set. Max calls it the most important negative result in the chapter, because it corrects an instinct the first twenty chapters built. *(Max Blumberg)*
- Ch17, 17.6 — naming the cured (immune) fraction in promotion analysis, that a standard survival model assumes away the people who will never experience the event, with the Kaplan-Meier plateau as the tell. “Most People Analytics survival writing ignores this entirely.” *(Max Blumberg)*

## Raw Feedback Log

*Original wording, kept for reference. Add new entries below as more feedback arrives.*

### Sara Ridley — Welcome section

> Scope: read on mobile; welcome section only. Overall reaction: very positive, keen to continue.

> “Thanks so much for sending this through – I’ve just read the welcome section on my phone and thought it would be worthwhile sending over my thoughts at this point before I get carried away with the rest of the book! Firstly, it’s definitely piqued my interest and I plan to start reading the rest tomorrow from a larger screen.”

> “I’m not sure of exactly what you are looking for from people reviewing and the reference to section 24.8.1 was a little opaque to me – is that in chapter 24? And do I have to get that far before I send any feedback?”

> Good: the airplane example as a hook; the logical organisation of the book; the “why” for people analytics.

> Areas to improve: “Why I wrote it” and “Who this book is for” are a bit lengthy and could be condensed; the book assumes readers know “Bayesian” and “SEM”, and “I/O” should be written in full — “I’m not a fan of acronyms as you can probably tell!”; every box has explanatory text except the “note” box, which was confusing; the “How the book is organised” section would benefit from noting each Part’s relative size; Part 5 seems chunky, with some chapters having extra detail and others not.

### Sara Ridley — Foundations section

> Scope: Foundations section — Welcome-section signposting, ‘Meeting your data’, ‘Thinking in Chances’, ‘Distributions, Sampling and the Idea of a Model’. Overall reaction: very positive, continuing to Bayesian Core next.

> “I have now read the next section (Foundations) and have some more observations which I hope you find useful.”

> General observations: “Although the book isn’t about learning R, I think many readers, particularly those who are logically minded or have used similar tools, would benefit from being pointed towards an R environment. I did some googling and found Posit Cloud, which offers a free browser-based setup requiring no installation. I’d suggest a brief signpost to something like this sits in the Welcome section, alongside short explanations of what tidyverse and brms actually are — both are mentioned without much context for the uninitiated.”

> “Related to this: it would help to clarify upfront who the Foundations section is aimed at. Is it for readers new to statistics, new to R, or both? And if R features in later chapters, is there value in the reader getting hands-on with it now? As someone who isn’t new to statistics but hasn’t used R before, I wasn’t sure how much I should be engaging with the code versus reading past it.”

> ‘Meeting your data’ section: “This is a strong section — well written, well structured, and mostly very well explained.” A few specific points:

> “Median vs mean. The case for using the median is statistically sound, but in practice many stakeholders won’t know what a median is and won’t be receptive to it. It might be worth acknowledging that the median is often more useful to the analyst than to the audience of the analysis. For what it’s worth, my own approach is to publish the mean but address outliers explicitly in the narrative — either recalculating without them or showing the percentage achieving a target.”

> “‘Why the difference matters’ example. Good, but I think it would land better if the mean value were actually stated.”

> “na.rm = TRUE. This was introduced without explicit explanation of what it does (excludes missing values) which I found a bit confusing on first read.”

> “The promotion statistic. The binary 0/1 framing felt a little abstract without a timeframe attached. If someone joined 20 years ago, does a 1 capture a promotion from 18 years ago? Without that context it’s difficult to relate to the scenario, and in my experience promotion data isn’t handled this way in practice.”

> “Performance ratings. These tend to be subjective in real-world settings unless they’re based on specific, consistently applied measurable criteria and I think it’s worth acknowledging that limitation.”

> “‘A request for historical data is usually a question about the future.’ I’d push back on this one. In my experience, the motivation is more often about establishing a baseline; understanding where things stand so a decision can be made about whether to act, celebrate, or leave well alone. That’s not quite the same as being oriented towards the future.”

> “‘People Are Not Good at This’ — Very relatable and very well explained and ties in well with the broader message of the book.”

> “‘Thinking in Chances’ and ‘Distributions, Sampling and the Idea of a Model’ sections — Both excellent. No suggestions at this stage.” — “Bayesian Core tomorrow!”

### Xiaoji Zhang — Chapters 1–2

> Background: recently moved into a role managing the enterprise employee survey and divisions’ survey action accountability; previously in employee/workforce development. Studied social science statistics in a counseling grad program (t-tests, p-values, correlation vs. causation) but rusty, with no prior Bayesian training. Goal: build a Bayesian framework for reasoning about survey data, inform leadership on survey decisions, guide division HR on interpreting results, and know enough to collaborate with — and push back on — her people analytics specialist. Scope: Chapters 1–2, Week 1. Note: the “edit this page” link led to a 404.

> 1.1 Setup — suggestion: “Add RStudio installation instructions here, and include a link to the official site. I wasn’t familiar — I had to check with our analyst to make sure I’m not downloading from a phishing site. I also learned our org has an enterprise version in the software center.”

> 1.2 What is a dataset? — “Add instruction: before you start, have RStudio installed and open to follow along.”

> 1.3.3 The numbers for sales — “na.rm = TRUE — suggestion: explain what this is. na.rm stands for ‘NA Remove’. It’s referenced a few times later but not immediately clear what it means. Once I know a command/formula is usually a shorthand of a word, I found myself better at guessing what the code means, even when it’s not explained every time.”

> 1.5.1 Meet the engagement survey — reflection: “This is very helpful. I can’t tell you how many times I was asked what does good look like from leaders and HR when it seems most items are leaning towards the top range. Being able to say that is the norm will help HR practitioners notice when the shape is unusual and take a closer look.”

> “Your Turn” (Chapter 1) — “Is there supposed to be a place to look for an answer for ‘Your Turn’ questions? Will be helpful to include at the end of the book, so I can check my understanding.”

> “Always ask why they’re asking” — reflection: “This section is such a good call out. I’ve noticed this with some of our analysts, who tend to focus on just the data requested but not the underlying problem — which sometimes leaves HR leaders and practitioners with the data, but still not something usable for the problem they’re trying to solve.”

> 2.2.4 Watch a probability settle — “‘Seeded’ is an unfamiliar term. Tell me first this code generates random numbers. The ‘seed’ is the random starting number. Doesn’t matter what it is, just so that when the same test is re-run, the same set of random figures will show up. Otherwise, I’m wondering what is 202.”

> 2.4.1 The idea — reflection on the performance/promotion table: “That makes sense. As performance goes up, people are more likely to be promoted. But I don’t actually know that. My assumption filled the gap based on the numbers increasing along each other and created a causation. Maybe all the top sales performers happen to be in a growing market, maybe they have longer tenure — the table didn’t have any of that context.” Suggestion: ask readers, under the table, what story their mind is already forming. “As I reflect on the core idea of Bayesian [thinking] — that what I know currently informs how I think about a probability, and a responsible analyst should adjust their understanding as new information gets in — it seems important to train beginners to examine what lens and assumptions we bring to a dataset. Otherwise I could be unconsciously seeking new information confirming what I already believe the data is saying.”

> 2.4.2 Knowing something changes everything — “If the goal is teaching how to write the R code, there seems to be a jump in difficulty. I tried to write it, but had to have Claude help me critique what I was doing wrong. Claude suggests using mutate() first to create the rate group by median. I can read and understand the code Claude created, but I’m not familiar enough with mutate() to know that’s the right one to use on my own… May need more scaffolding to introduce mutate() and reference an example before this exercise.” Alternative, if the goal is the concept rather than the code: “Apply this to customer rating. How would you examine whether a higher customer rating changes the promotion odds? Using the median to create a category is something I wouldn’t have come up with on my own — I’d love a bit more unpacking here on how to think about numerical variables in categories.”

> 2.5.1 The succession-pipeline problem — thought process, working through it unaided: “The question to solve is what’s the probability of the promotion [being] unfilled given the size of the bench. If I get to a probability I’m comfortable with, that’s the bench size I go with(?) This is a conditional probability — what’s the probability of 10 people promoted given a bench size of 28, knowing the overall promotion probability is mean(salespeople$promoted) = 0.3. The simulation unit I run is each selection cycle, randomly generating how many people get promoted each cycle. From the randomly generated number of people promoted, I can calculate the promotion probability of that simulation. Start to get fuzzy — I know it will eventually get very close to 0.3 if I run many rounds of simulation, so what am I doing here? Skipping that part, what I think happens next is: adjust the bench size and re-run the simulation until I find a bench size with an acceptable success rate where I’m fairly confident we won’t end up with a unit-supervisor shortage.”

> Feedback: “As a beginner, upon seeing the bench-size question my instinct is that I need 10 people, p = 0.3, so a 30-ish bench should be good enough. Knowing what thought process I need to correct is helpful.” Suggestion: add a pause after “How big should the bench be?” to prompt readers to think through their own approach before the book introduces simulation as the solution.

> “Similarly, I’m noticing a couple of places where, once the R code is provided, it feels like I’m handed the answer right away and the actual problem-solving friction is skipped. When the code is straightforward enough I’m gaining comprehension fluency, but not necessarily being forced to apply the concept and think through the problem myself first. This particular one forced me to pause because I didn’t understand parts of the code (rbinom, and the cat(‘P(fewer than 10 promoted — roles left unfilled):’, round(mean(promoted_count < roles_open), 3)) line) — which forced me to think through the approach myself, and I realised some of my comprehension so far is shaky.” Suggestion: add a prompt, before reviewing the code, to think through the approach in plain language, not R — “if I know how to approach it, I can probably have an AI tool help write out the code.”

> Final thoughts: “Once a confident bench size is chosen, it still needs to translate into plain language for leadership, especially if the recommended number isn’t the intuitive ~30. Being able to land that recommendation is what matters in the end.” Suggestion: provide sample leadership-ready language for a sample result, or point to a later chapter/section that covers this — “I believe that’s part of the gap this book is trying to address.”

### Ludek Stehlik — Full manuscript

> Scope: full manuscript, read with attention to statistical and methodological correctness. Overall reaction: strongly positive — “Overall, I think it’s a really good book. It does a particularly strong job of connecting the theory with the practical side of using Bayesian methods to reason about uncertainty in models and data. I’m sure the PA community will find it useful — I only wish something like this had been available when I was entering the field.” Everything below was offered as “a few things that may be worth another look before publication”.

> Ch15: “Transfer requests accumulate over a manager’s tenure, but the calculation divides them by current team size. Longer-serving managers could therefore appear worse simply because they’ve been observed for longer. I understand that the main point here is shrinkage, but it may be worth acknowledging this limitation explicitly, or framing the example around a simplifying assumption that everyone was observed over the same period with roughly stable team sizes.”

> Ch24: “The savings calculation treats avoided transfer requests as avoided resignations, although an internal move doesn’t necessarily mean someone leaves the company. I understand that the aim is to show how a model can inform a financial decision, but it may be better to use costs that correspond to the event being modelled, or to introduce a clearly hypothetical resignation example. Otherwise, readers may take the resulting savings more literally than intended.”

> Ch24, decision rules: “I’d revisit the probability threshold. Expected net benefit already accounts for unequal gains and losses, so it doesn’t require the two types of error to have the same cost. The proposed cutoff can lead to a different recommendation, so sticking with the expected-net-benefit rule may be simpler. I also understand the point about being able to stop after a pilot, but the calculation appears to assume that the pilot always reveals the correct decision. It may be clearer to present this explicitly as an idealised upper bound rather than the value of a realistic pilot, consistent with the distinction you make earlier in the chapter.”

> Ch12/14: “The priors may be affecting the examples in unintended ways. In Ch12, the code appears to differ from the priors described in the text (which should be the same as in Ch8) and may shrink city differences quite strongly towards zero. In Ch14, fitting a prior directly to observed city rates mixes sampling noise with genuine between-city variation. It may be worth checking sensitivity in Ch12 and using counts and sample sizes when estimating the prior in Ch14.”

> Ch19/20: “A couple of explanations seem inconsistent with the displayed results. In Ch19, the comparisons described in the text go in the opposite direction from the printed numbers. In Ch20, the calculation answers ‘Is A higher than B?’ rather than ‘Do the groups differ?’ These should be straightforward local corrections.”

> Ch22: “The simulation creates repeated observations within offices, but the analysis treats them as independent, without office effects or cluster-aware uncertainty. That could affect the recommended study size. It may be worth rerunning the simulation with an analysis that accounts for the office structure.”

> Ch18/21: “Some passages move from an observed relationship to claims about what a programme would cause. I understand that the business decision is what makes the example useful, but it may help to distinguish what the model itself shows from the additional assumptions needed to recommend an intervention. In Ch21, I’d also mention that adjusting for an imperfect performance rating may leave some underlying confounding unresolved.”

> Ch4/17: “‘Eventually promoted’ needs a defined follow-up period, since ‘not promoted yet’ doesn’t mean ‘never promoted.’ A simple teaching assumption could be that everyone has been observed for the same complete three-year period. In Ch17, I’d also soften the interpretation of a flat survival curve. It could suggest that some people will never experience the event, but limited follow-up or having very few people remaining under observation can produce the same pattern.”

> Ch2: “The simulation allows more promotions than the ten available jobs. I understand that the point is to demonstrate uncertainty, but perhaps the simulated count could instead represent candidates who are ready for promotion, with actual promotions capped at ten. That would keep the example simple while making it consistent with the scenario.”

> “Hope this is useful, and feel free to reach out if anything needs clarification.”

### Sara Ridley — Chapters 7 to 10

> Scope: Chapters 7 to 10 (Part III), plus an applied test of the Chapter 8 multilevel model on her own engagement survey data. Overall reaction: strongly positive, with one broader observation about contextual assumptions in the examples, and a worked application at the end.

> Ch7: “The explanation of LOO is excellent, particularly the random-noise demonstration, which clearly shows that good fit is not evidence in itself. One small issue is that LOO appears in the opening chapter summary before it is explained in Section 7.5.2. Readers working through the book sequentially may find this slightly disorienting; a brief signpost at first mention would help.”

> Ch7, the performance-rating example: “The example never defines what the ratings measure or how they are assigned. That distinction matters because it affects how any relationship between ratings and sales should be interpreted. If ratings are derived from sales figures, the analysis becomes circular. If they incorporate broader factors such as customer complaints, coaching effectiveness, or team behaviour, a weak relationship with sales may be entirely reasonable and would not necessarily indicate a flawed rating system.”

> Ch7, timelines: “First, what period do the sales figures cover — quarterly, annual, or something else? Second, what is the gap between the rating and the outcome being predicted? If ratings are intended to predict future performance, that interval needs to be clear. Predictive validity declines over time, and a rating from 18 months ago tells us far less than one from the previous quarter. These are exactly the questions a sceptical HR director or finance partner would ask, so the example would be even stronger if it demonstrated the same level of precision it encourages readers to adopt.”

> Ch7, inter-rater reliability: “In practice, ratings are assigned by different managers with different standards; one manager’s 3 may be another’s 4. Pooling ratings without acknowledging this assumes equivalence that may not exist. This is precisely the kind of grouped structure that Chapter 8’s multilevel framework is designed to address. It may be worth either noting that manager-level variation is being ignored for teaching purposes or pointing out that a more rigorous analysis would model manager as a grouping variable. That would also provide a useful bridge into Chapter 8.”

> Ch8: “This was the chapter I found most directly relevant to my own work. The league-table example immediately resonated because I face the same issue in engagement-score analysis, where I currently exclude teams with fewer than 40 respondents. The chapter made clear that partial pooling largely removes the need for such a blunt threshold. The explanation of shrinkage is particularly effective, and the suggested stakeholder framing is practical and easy to apply. I also appreciated the inclusion of funnel plots as a way of bringing a sceptical audience along before introducing the full model.”

> Ch9: “This chapter is clear, well-paced, and highly practical. The warning about odds ratios is especially valuable. I’ve seen this mistake made repeatedly in promotion and pay-equity analyses, and the worked example makes the scale of the misunderstanding very tangible. The performance-rating variable continues from Chapter 7, but the inter-rater reliability issue is no longer mentioned. By this stage it is being used as a predictor in a promotion model, and readers who noticed the earlier limitation may wonder whether it has been addressed or simply set aside. A short acknowledgement that ratings are accepted as given for modelling purposes, together with a reference to multilevel approaches for a more rigorous treatment, would neatly close that loop. The predicted-probability chart is exactly the sort of output practitioners need, and the guidance on summarising results verbally is particularly well judged.”

> Ch10: “A satisfying conclusion to the section. The outcome-family table is genuinely useful as a reference and is something I expect to revisit. The observation that steps 7 and 8 are often skipped also rang true; in my experience, pressure to reach conclusions quickly is exactly where analytical discipline tends to erode. I also noticed that survival modelling appears later in the book and am looking forward to those chapters, as employee attrition analysis is directly relevant to my work.”

> A broader reflection on Part III: “The statistical framework is rigorous, and the methods are explained very well. My concern is that the examples do not always make their underlying contextual assumptions explicit, yet those assumptions are often the first thing a practitioner would need to establish when applying the techniques in practice. I am not suggesting that every possible variation should be explored. Well-defined examples are exactly what a teaching text needs. However, being clearer about factors such as how ratings are generated, what timeframes apply, and what assumptions underlie the data-generating process would make the examples more useful as practical templates. Where alternative real-world situations require different approaches, brief signposts to relevant sections elsewhere in the book would add further value.”

> Applying it to her own data: “To test the ideas properly, I applied the Chapter 8 multilevel model to last year’s engagement survey data, covering more than 600 employees across eight directorates. The model performed well, diagnostics were clean, and the shrinkage plot was immediately interpretable. The key finding was that individual-level variation (sigma = 2.41) was nearly three times greater than between-directorate variation (sd(Intercept) = 0.88). That result changes how I think about directorate-level league tables. I then examined our largest directorate and identified a team of 26 people that sat credibly below the mean, a group I would previously have excluded under my 40-person threshold. That alone demonstrated the practical value of the approach.”

> “I’m also looking forward to this year’s survey results, which will be available in a few weeks. At that point I’ll be able to use last year’s directorate estimates as informative priors, turning the book’s argument about sequential updating from an abstract concept into something directly applicable. Looking forward to Part IV.”

### Xiaoji Zhang — Chapter 3

> Scope: Chapter 3 only — “Busy week, only got through one, but had fun with it.” Also asks a question that needs your answer: she uses an AI assistant on three things — checking her understanding of a concept, understanding R code, and summarising her questions into these review notes — and never pastes the chapter text into it. “Please let me know if this acceptable to you.” Note: her notes reference an image.png (the decision tree she built) that did not come through with the email.

> 3.2, on the Poisson row (“A count of events with no natural maximum… Transfer requests per team per year”): “Wouldn’t the natural maximum be the size of the team for the transfer example?”

> 3.2, choosing between the three: “After going through the 3 distribution models, I found the shorthand description here helpful, but still not plain language enough for me to quickly decide which model to pick. Something like a decision tree would help make decisions faster as a beginner. For my use case, being able to identify the right way to think about a problem or check analyst claims without [getting] bogged down on details is helpful. Based on my understanding from the reading, I asked Claude to create a visual, and tested with a couple examples in my work, this visual works better for me.” [image.png — not received]

> 3.3, on “Add lots of little nudges together and you almost always get a bell”: “Two concepts not clear here: Nudge — this concept was introduced without explanation. Doesn’t seem like plain language. Contributing factors? Add — this one turned out to be actually very literal in the following example, as in Sum(). But in description, that wasn’t clear. ‘Add’ has a general meaning, not just mathematically.”

> 3.3, on the runif walkthrough: “This explanation is helpful. Will be better if we can run a code to see the actual flatline distribution. Having the comparison/contrast with the bell-curve help drive the message home.”

> 3.3, reflection: “In reality, it seems difficult to know if I have considered all contributing factors, and if all the contributing factors are actually independent, and lastly if they can be ‘added’ up. So is it the lesson here to not assume a distribution is normal by default?”

> 3.3.6: “Add to existing explanation why the total area needs to equal to 1.”

> 3.4.2: “Why 9 to 21? Is that 2 SD out? How do I know what’s the SD here?”

> 3.4.2, reflection: “Broadly, this seems a very helpful concept for survey work. A lot of divisions asked what it means when an item’s average changed from 4.5 to 4.3. My gut feeling is there may not be any meaningful change, it could be a flute of how people felt on that day, at that moment. But I’m not sure if this is the right place to apply this distribution concept. From the definition, probably not binomial, since the likert scale is not yes/no. A separate question is for the likert scale question, what is a statistical method to apply to tell when it’s meaningful change, when it just may be noise?”

> 3.4.2, on “A distribution is a model — a useful approximation, never the literal truth”: “The most helpful framing in this chapter. Most decisions I make or support leadership to make in the end rest on: knowing what/when it’s good enough.”

> 3.7.3: “This is a very helpful practical framing, but for a small division, how meaningful is it to push a 15-ppl team’s response rate from 50% to 100%, when the team is so small that the result may still not be reliable anyway? The effort itself might be a more useful signal than the survey result/response rate. If a small team’s response rate jumps sharply year over year, the process of improving the response rate, better internal communication, manager engagement, visible and meaningful action from the last survey, etc. may have already addressed the underlying engagement issue.”

> 3.7.3, continued: “A sharp response increase could also be alarming. Is there possible coercion/pressure to complete the survey? In this situation, ppl r not honest, and the result is still not helpful, even more misleading. From an OD/practical perspective, small divisions may just need a different diagnostic approach, not just a harder push on response rate: focus groups, skip-level conversations, or other observable behavioral signals may be more meaningful than survey data alone. This is a conversation I constantly have with smaller teams, especially a lot of times they don’t meet the data privacy threshold for us to release results in the first place. This is a side-step for a statistics book. But want to name it for people analytics practitioners when they actually work with HR, to be aware of other practical considerations beyond statistical models.”

### Max Blumberg — Introduction and Chapters 1 to 23

> Scope: a full verification pass, 130 findings, delivered as a change log with Priority / Impact / Confidence scores per finding (bayesianbookchangelog260906.04.md, retained separately — only the ~49 actionable ones are folded in here). Method: every chapter read live from the site with the read date and exact text stamped, and every printed number reproduced independently — in Python where R was unavailable, then in real brms for Chapters 12 onward. Roughly 60% of the findings are “verified correct” entries logging a check that passed. On the question of whether Max applies a frequentist lens: reviewed and largely not borne out. The maximum-likelihood suggestion in CH14-01 is marginal MLE, the canonical empirical Bayes estimator, offered inside a method that is itself a point-estimate-the-prior technique, and it is corroborated there by a brms partial-pooling model — the book's own tool — so the finding does not depend on it. Two small drifts: a likelihood-ratio test used as a supporting check in CH14-01, and an interval-includes-zero reflex in CH13-01 where the LOO evidence is the stronger argument. The real caution is different: the review is structured around an “advanced reader” persona (OU M347 / econometrics) who is neither of the book's stated audiences, so weight the priorities accordingly — though Max polices this himself throughout.

> On method: “Confidence – our own probability that the finding is right and the suggestion sound, as a percentage. Given in the book's own spirit: quantify the uncertainty rather than sound certain and be wrong.”

> Ch1 verification: “Code verified against the real data (R + peopleanalyticsdata): every number is correct.”

> Ch12, on the varying-slopes prior: “A prior centered at 75 with a standard deviation of 15 sits roughly eleven of its own standard deviations below the data, so it pulls the fit down… With a prior on the right scale the heterogeneity is not there.”

> Ch14, on the estimator: “So on this data no city is distinguishable from the average. That is the strongest version of the chapter's own point, and it matches what Chapter 15 lands for managers, that most groups are not distinguishable from average and that is the finding.”

> Ch17, on the hazard: “A survival curve falling fastest early does not on its own mean the hazard is highest early. With a constant per-month risk the curve still drops fastest at the start, simply because the most people are still present to leave then.”

> Ch19, on the imputation example: “The stated rationale, that complete-case ‘bought its narrower interval by discarding rows’, is the wrong way round, because discarding rows leaves less data and a wider interval, which is why complete-case is the wider of the two here.”

> Ch10, on the root-cause numbering slip: “Chapter 10's Summary renumbers the workflow, and later chapters pick up whichever number they read.” Chapters 19, 20, 21 and 23 have each inherited it.

> Ch18, in full: “The whole chapter reproduces exactly in real brms, and no error of correctness, argument or consistency was found; this is a clean chapter.”
