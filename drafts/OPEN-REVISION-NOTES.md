# Open revision notes, moved out of the chapters

These were `<!-- NOTE FOR REVISION -->` blocks sitting at the foot of
chapter files. They are working notes, not content, so they belong here
rather than inside the book. Nothing has been changed except location.


---

## Chapter 19 — Modelling What You Can't See

This chapter draws on *The performance distribution in your organisation
is not the one you think it is* (Working Ideas, May 2026), particularly
the reliability arithmetic, the noise-versus-bias framing, and the
four-stage selection argument. The simulation in that article — PQ run
through selection, differential attrition, performance management and
retention — is a strong candidate for adaptation here or in Chapter 21,
and would make the collider point on real organisational mechanics rather
than an abstract hiring threshold.

References to add to `references.bib` if these stay: Kahneman, Sibony &
Sunstein (2021) *Noise*; Viswesvaran, Ones & Schmidt (1996) on rating
reliability; Heckman (1979) for the selection point.


---

## Chapter 22 — Causal Designs

Two open questions for a later pass:

**A real dataset.** Everything here is simulated, which is defensible
(and Chapter 21 sets the precedent) but means the chapter never touches
organisational data. If a public panel with a policy change can be found —
or if an anonymised extract becomes available, as with `turnover` in
Chapter 17 — the difference-in-differences section would be stronger with
it. The simulation should stay regardless; it's what lets us check the
method against a known answer.

**Housekeeping item, now resolved.** The YAML header that used to sit at
the top of this file (`warning: false` / `message: false`) has been removed
— `_quarto.yml` sets both project-wide.

**A book-wide refactor, half done.** `_setup.R` defines the colour tokens
(`navy`, `red`, `navy_light`) and the shared `theme_set()`, but no chapter
sources it. Chapters 16–23 now define the tokens in their own setup chunk
and reference them by name instead of repeating hex literals inline, which
gets most of the benefit — the palette is legible and consistent, and each
chapter still renders standalone from `drafts/`. Chapters 1–15 still have
the hex values inline and should be brought into line.

The fully tidy arrangement is still the standard Quarto book pattern: one
`source("_setup.R")` line per chapter, which works because `_quarto.yml`
sets `execute-dir: project`. Two things to sort out before doing it:
`_setup.R` currently loads `skimr` and `rstanarm`, which most chapters
don't need and which would make every chapter fail if either package is
missing; and sourcing it breaks standalone rendering from `drafts/`. Trim
the library list first, then it's genuinely a one-line change per chapter.

**Where the design section belongs.** It sits here because experiments
only entered scope with this chapter, and because it shares the
simulation machinery. But it's equally at home in Chapter 20 (A/B
testing), which is where a reader planning a people experiment would
naturally look. Worth revisiting once both chapters are integrated —
splitting it would duplicate the machinery, so it's one or the other.
