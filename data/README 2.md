# data/

## turnover.csv (used by Chapter 15, Survival Analysis)

Not committed to the repo (see `.gitignore`) — download it yourself and
place it here before rendering Chapter 15.

- **Get it from:** <https://www.kaggle.com/datasets/davinwijaya/employee-turnover>
  (free Kaggle account required to download).
- **License:** CC BY-NC-SA 4.0 — attribution required, non-commercial use
  only, any shared adaptation must carry the same license. That's why this
  book doesn't redistribute a copy itself; each reader gets their own copy
  directly from Kaggle under the same terms.
- **Original source:** Edward Babushkin, real anonymised HR data from a
  Russian company. Andrew has emailed Edward to ask permission to bundle
  the data directly with the book — if that comes through, this file can
  move from "download it yourself" to "included," and this note (and the
  `.gitignore` entry) should be updated accordingly.
- **Known quirk:** the `profession` column contains one non-UTF-8 byte
  (0xF1, Latin-1 "ñ") in the value "Finanñe" — almost certainly a corrupted
  "Finance" from whatever process originally exported this file from
  Russian source data. The chapter's `read_csv()` call handles this with
  `locale = locale(encoding = "latin1")`, and recodes that one value back
  to "Finance" for readability.
