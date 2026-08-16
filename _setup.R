# Shared setup, sourced (or copy-pasted into the setup chunk) at the top of
# every chapter. Keeping one copy here means the whole book stays visually
# and technically consistent.

library(tidyverse)
library(peopleanalyticsdata)   # install.packages("peopleanalyticsdata")
library(skimr)                 # one-look data summaries (Chapter 1)
library(rstanarm)              # fast hierarchical / shrinkage models
library(brms)                  # ordinal, survival, and flexible specifications
library(tidybayes)
library(bayesplot)

theme_set(theme_minimal(base_size = 13))
set.seed(2026)

# Shared colour tokens (match theme/academicdesign*.scss)
navy  <- "#122a52"
red   <- "#d32f2f"
navy_light <- "#8fabd0"

bayesplot::color_scheme_set("blue")
options(mc.cores = parallel::detectCores())
