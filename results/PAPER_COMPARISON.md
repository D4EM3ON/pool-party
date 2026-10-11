# Paper Comparison

| Function | Busing 2022?\* | Mair 2009? |
| :-: | :-: | :-: |
| `cir::oldPAVA()` | | yes |
| `clue:::pava()` | | yes |
| `density_friendly_pava()` | $N$ | |
| `directlabels::isoreg_dp()` | | |
| `fdrtool::monoreg()` | $N$ | yes |
| `Iso::pava()` | $N^2$ | yes |
| `intcox:::intcox.pavaC()` | | yes |
| `isotone::gpava()` | | |
| `jbkpava()` | $N$ | |
| `logcondens::isoMean()` | | yes |
| `monotone::legacy(number = 3)` (`amalgm()`) | $N^2$ | |
| `monotone::legacy(number = 1)` (`fitm()`) | $N$ | |
| `monotone::legacy(number = 11)` (`inplace_pava()`) | $N$ | |
| `monotone::legacy(number = 10)` (`linear_pava()`) | $N^2$ | |
| `monotone::legacy(number = 4)` (`pav()`) | $N^2$ | |
| `monotone::legacy(number = 9)` (`pooled_pava()`) | $N$ | |
| `monotone::monotone()` | $N$ | |
| `sklearn.isotonic.isotonic_regression` | | |
| `scipy.optimize.isotonic_regression` | | |
| `SAGx::pava()` | | yes |
| `quadprog::solve.QP()` | | |
| `sandwich::pava.blocks()` | | yes |
| `smacof:::pavasmacof()` | | yes |
| `smacof:::wmonreg()` | $N^2$ | |
| `stats::isoreg()` | $N^2$ | yes |
| `spsurvey::isotonic()` | $N^2$ | |
| `UniIsoRegression::reg_1d()` | $N$ | |

\* If present, will represent the big O notation that was used in the paper