# data-sources/

**Superseded.** Chapter 15 now uses the fuller, original-schema Kaggle
extract of this same dataset (`stag`, `traffic`, `coach`, etc.) — see
`data/README.md` for that one; it's what the chapter actually reads.

This folder is **not** used by the book at render time and nothing here
is wired into any chapter. It's kept purely as a historical record and an
extra fallback, in case the Kaggle listing ever disappears too.

## turnover_aihr_backup.csv

- **What it is:** a backup copy of the file Chapter 15 (Survival Analysis)
  reads live from `https://www.aihr.com/wp-content/uploads/2018/01/turnover.csv`.
  1,785 rows, 4 columns: `exp` (years of tenure), `event` (1 = left),
  `branch` (one of five company branches), `pipeline` (recruitment channel).
- **Saved:** 30 July 2026, fetched directly from the AIHR URL above.
- **Original source:** Edward Babushkin (Russian people analyst), real
  anonymised data from a company with five branches. Babushkin's own blog
  post — <https://edwvb.blogspot.com/2017/10/employee-turnover-how-to-predict-individual-risks-of-quitting.html>
  — links to a fuller ~16-column version of this dataset (`stag`, `event`,
  `gender`, `age`, `industry`, `profession`, `traffic`, `coach`,
  `head_gender`, `greywage`, `way`, plus five Big-Five personality scores)
  via a Dropbox link. **That Dropbox link is dead as of this check** (empty
  response, both `dl=0` and `dl=1`) — likely expired after ~9 years, which
  is exactly the kind of link rot this backup exists to guard against.
- **Relationship to Babushkin's original:** AIHR's 4-column file is a
  simplified, recoded teaching excerpt, not a byte-identical copy of
  Babushkin's raw data — the recruitment-channel categories are recoded
  (`js`/`ref`/`ea`/`cs`/`sm` here vs. Babushkin's original `advert`/
  `referal`/`youjs`/`KA`/`empjs`/etc.), and the `branch` column isn't in
  Babushkin's own published variable list. Both trace back to the same
  real underlying company data; AIHR's is the one actually usable today.
- **License:** the CC BY-NC-SA 4.0 label is what appears on the Kaggle
  listing of this dataset (uploaded by a third party, "davinwijaya") —
  not something stated on Babushkin's own blog post, which carries no
  explicit license at all. Treat CC BY-NC-SA 4.0 as the operative
  assumption: attribution required, non-commercial use only, share-alike
  on any redistributed adaptation.
- **Why it's not wired into the book:** per that license, the chapter
  reads the file live from AIHR rather than bundling a copy — so the
  book's own distribution/licensing doesn't have to extend to
  redistributing someone else's dataset. This file is purely a private
  fallback if `aihr.com` ever takes the file down; if Ch. 15's live fetch
  ever needs to fall back to a local copy, revisit the license question
  first (a local copy used only for your own testing is one thing; a copy
  that starts shipping with the book is another).
