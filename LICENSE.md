# Licence

*Bayesian Thinking for People Analytics* © 2026 Andrew Marritt
<https://bayesian-thinking.andrewmarritt.ch>

This repository contains three kinds of material, and they are licensed
differently. In short: **the writing is share-alike and non-commercial, the
code is free to use anywhere, and the data belongs to whoever published it.**

---

## 1. The book text, figures and diagrams

The prose, illustrations, hand-built figures and the structure of the book are
licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International
Licence](https://creativecommons.org/licenses/by-nc-sa/4.0/) (CC BY-NC-SA 4.0).

You are free to **share** (copy and redistribute in any medium or format) and
**adapt** (remix, transform, and build upon the material), under these terms:

- **Attribution** — give appropriate credit, link to the licence, and indicate
  if changes were made.
- **NonCommercial** — not for commercial purposes.
- **ShareAlike** — distribute your contributions under the same licence.

A suggested attribution line:

> Marritt, A. (2026). *Bayesian Thinking for People Analytics*.
> <https://bayesian-thinking.andrewmarritt.ch>. Licensed under CC BY-NC-SA 4.0.

**What NonCommercial does not stop.** The licence governs copying and
redistributing *the book*. It places no restriction on applying the methods it
teaches — in your job, in paid consulting work, or in a commercial product.
What you may not do is sell the book, or reproduce substantial parts of it
inside something you sell, without asking first.

As copyright holder, the author retains the right to license this work
separately on other terms, including commercially. Enquiries welcome:
andrew@andrewmarritt.ch

## 2. The code

All R code in this repository — code chunks in the chapters, scripts in
`figures/` and `data/`, and the setup files — is licensed under the **MIT
Licence**, reproduced below. Use it in commercial work without restriction.

This is deliberate. Code in a technical book exists to be copied into real
analyses, most of which happen inside companies, and a NonCommercial term over
code would defeat the purpose of writing it down.

```
MIT Licence

Copyright (c) 2026 Andrew Marritt

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 3. The data

The datasets used in the book are **not** covered by the licences above. They
remain under the terms set by whoever published them, and none of them are
redistributed in this repository. See `appendices/A3-data-sources.qmd` for the
full list. The two that matter:

- **`peopleanalyticsdata`**, by Keith McNulty, supplies most of the data used
  here. It is MIT licensed and available on CRAN; readers install it
  themselves.

- **`turnover`**, used in Chapter 17, is real anonymised data shared by Edward
  Babushkin and redistributed on Kaggle under CC BY-NC-SA 4.0. It is not
  bundled with this book, because it is not ours to redistribute. Readers
  download it themselves — see `data/README.md`.

## Relationship to other work

This book draws on Keith McNulty's *Handbook of Regression Modeling in People
Analytics*, which is itself published under CC BY-NC-SA 4.0. No text from that
book is reproduced here — it is cited and discussed, which creates no licence
obligation — but adopting the same licence is deliberate. It keeps the two
books compatible for anyone teaching from both, and it matches the terms of the
`turnover` dataset that Chapter 17 depends on.
