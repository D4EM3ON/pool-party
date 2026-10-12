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

# Busing (2022) Table 2 - extended

| Implementation | Year | Original language | Allows weights | Auxiliary floats | Auxiliary integers | Direct updates | Forward checks | Backward checks |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| `fitm()` | 1964 | Fortran | Yes | $n$ | $n$ | No | 1 | $k$ |
| `wmrmnh()` | 1978 | Fortran | Yes | - | - | Yes | 1 | $k$ |
| `amalgm()` | 1980 | Fortran | Yes | $2n$ | - | No | 1 | $k$ |
| `pav()` | 1984 | Fortran | Yes | $4n$ | $n$ | No | 1 | 0 |
| `isoreg()` | 1995 | C | No | $n$ | - | Yes | $k$ | 0 |
| `isopava()` | 1997 | Fortran | Yes | - | $n$ | Yes | 1 | 0 |
| `isotonic()` | 2001 | C | No | - | - | Yes | $k$ | 0 |
| `isomean()` | 2010 | C | Yes | $2n$ | $n$ | No | 0 | $k$ |
| `pooledpava()` | 2013 | Python | Yes | $2n$ | $n$ | No | 0 | $k$ |
| `linearpava()` | 2014 | Julia | Yes | - | - | Yes | $k$ | 0 |
| `inplacepava()` | 2016 | Python | Yes | - | $n$ | No | 1 | $k$ |
| `mdpava()` | 2016 | C++ | No | $n$ | $n$ | No | 1 | $k$ |
| `reg1dl2()` | 2017 | C++ | Yes | $3n$ | $2n$ | No | 0 | $k$ |
| `jbkpava()` | 2017 | C | Yes | $2n$ | $3n$ | No | 1 | $k$ |
| `monotone()` | 2019 | C | Yes | - | $n$ | No | $k$ | $k$ |
| `intcox()` | 2005 | C | Yes | $2n$ | $n$ | No | 0 | $k$ |