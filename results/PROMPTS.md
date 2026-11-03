# Prompts

The questions and follow-ups, taken from the Claude Code conversations, that produced [`EXTRA_PAVA_FUNCTIONS.md`](../EXTRA_PAVA_FUNCTIONS.md) and the plots under [`src/_best/`](../src/_best/). Prompts are quoted as written, in order. Dates are local time.

## `EXTRA_PAVA_FUNCTIONS.md`

### 2026-10-10 / 2026-10-11 — Search, complexities, deduplication

1. Initial research:
   > research, spawn a bunch of subagents, to help with this task:
   >
   > - [ ] Check if there are more functions in R or in Python that implement pava other than what there currently is in the README.

   Three subagents ran: a CRAN search, a Bioconductor/GitHub R search, and a Python search.

2. Writing the results to a file:
   > can you output all of these in a new markdown file titled "extra pava functions"

3. Adding complexities:
   > do you have the order of complexity of these functions? if so, do you think you could add them?

   > yeah spawn a subagent per function, go read the code, and shell out a theoretical complexity please

   Sent while that was running:
   > then add it to the extra pava functions file

4. Removing duplicates of functions already in the repo:
   > reading the code, things like https://github.com/cran/lmap/blob/HEAD/src/flib.c#L5255 are implemented by Busing as well - are they not the same thing as monotone::monotone? double check every function, and remove it from the markdown file if they are exactly the same thing as something we already have

   A second workflow (one agent per function) compared each source with the known implementations, and the identical copies, trivial copies, ports and wrappers were removed.

### 2026-10-14 / 2026-10-15 — Condensing, and picking what to implement

5. Condensing the file:
   > alright great thanks. next up, what i would like to do for the EXTRA_PAVA_FUNCTIONS is condense it. i want a single header table that tells me O(n) pava functions in R that i can implement directly like everything else i do in this repo. after that, i want a table with just function, Time (worst), and a why it was not chosen to be used further. you can remove the pava variants and generalisations, as well as the isotonic regression but not pava that would not pass the _validation. we can leave python as is, but condense it like everything else.

6. Run instructions for the $O(N)$ candidates:
   > for all the O(N) PAVA to implement, please replace everything in yeet.md with instructions on h ow to run them please. if you find they cannot run as easily, tell me why, and let me decide what to do with them

   > go for dlib, tablcl2, drop the others please

   > sorry dont install them, just modify yeet.md, and modify installation.md please. let me do the modifying and running please

   > how would i install on windows?

7. Moving what was not implemented to the "not chosen" table:
   > finally, i did not choose dlib. can you move everything that is not currently implemented in our repo to the not chosen, under EXTRA_PAVA_FUNCTIONS? add why as well (too complicated installation)

## `src/_best/` plots

### 2026-10-13 — Comparing the best functions per dataset

1. Initial request:
   > for the src/_best/ folder, can we make it so that we run all of these:
   >
   > density_friendly_pava
   > directlabels
   > fdrtool
   > intcox
   > jbkpava
   > logcondens
   > monotone
   > legacy fitm
   > legacy inplace pava
   > pooled_pava
   > uniisoregression
   >
   > for each of these, i want to see a diagram comparing their times and space one against the other, kind of like figure.png overall, for each dataset we generate in the _common/data.r
   >
   > ask me questions if need be

2. Separating time and space:
   > for the plots, i would like to plot in one the time, and in the other the space - would you be able to do this?

3. Debugging the benchmark run:
   > why does this not work here, but worked when i last ran _validation/data.r?

4. Keeping only the best functions:
   > for the plots, can we keep at most the 5 best (5 lowest)?

5. Changing the scale:
   > can we make the scale even more logarithmic please?

The result is one `figure-<dataset>-seconds.png` and one `figure-<dataset>-kilobytes.png` per dataset (committed in `7788089`).

### 2026-11-03 — figure-pred for the best functions, and an overall figure

1. Replacing the baseline comparison:
   > peux tu faire ceci pour moi svp? - [ ] Remove comparison to baseline in _best, take the 5 best and plot them
   >
   > on parle donc de faire la figure-pred pour tout le monde, au lieu de nouvelles fonctions. fait en sorte que ce soit le plus proche possible de plots.r disponible partout

   `make_references` and `make_pred_plot` were extracted from `make_plots` in `_common/plots.r`, and `_best/plots.r` now writes one `figure-<dataset>-pred.png` per dataset for the 5 best functions, at `seconds = 0.01`. The old `-seconds` and `-kilobytes` figures were removed.

2. Fixing `make_plots`, broken by an `expr_name` argument added to `make_references` in the meantime:
   > yeah it was meant for that, can you do it please?

3. Fixing the overall figure (a block added by hand to average every dataset), by pasting the error from `source("src/_best/plots.r")`:
   > Error in vecseq(f__, len__, limit) :
   > Join results in 6480 rows; more than 1110 = nrow(x)+nrow(i). Check for duplicate key values in i each of which join to the same group in x over and over again. [...]

   The overall block had not averaged the datasets, so each (PKG, N) pair appeared once per dataset and the atime join duplicated the rows. The fix averaged the measurements over `DATA` first.

4. Simplifying the fix:
   > is there no simpler way to do this?

   The averaging was reduced to the mean of `median`, `min`, `max` and `kilobytes` per (PKG, N), keeping only N reached on every dataset.

The result is one `figure-<dataset>-pred.png` per dataset, plus `figure-overall-pred.png`.
