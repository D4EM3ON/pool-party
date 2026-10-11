# Pool Party

| Lang | Code | Function | Updates | Weights | Bounds | Documented?\* |
| ------ | ------- | ------------------------------------ | ----------------------- | :-----: | :----: | :-: |
| R | R | [`cir::oldPAVA()`](https://www.rdocumentation.org/packages/cir/versions/2.5.1/topics/oldPAVA) | [2008–2025](https://cran.r-project.org/web/packages/cir/index.html) | yes | no | no |
| R | R | `clue:::pava()` | [2004–2026](https://cran.r-project.org/web/packages/clue/index.html) | yes | no | no |
| R | C++ | [`density_friendly_pava()`](https://github.com/maxdan94/Density-Friendly) | [2017-2020](https://github.com/maxdan94/Density-Friendly/commits/master/exactDF.cpp) | no | no | no |
| R | C | [`directlabels::isoreg_dp()`](https://github.com/tdhock/directlabels) | [2010-2026](https://cran.r-project.org/web/packages/directlabels/index.html) | no | no | no |
| R | C | [`fdrtool::monoreg()`](https://rdrr.io/cran/fdrtool/man/monoreg.html) | [2006–2024](https://cran.r-project.org/web/packages/fdrtool/index.html) | yes | no | no |
| R | Fortran | [`Iso::pava()`](https://www.rdocumentation.org/packages/Iso/versions/0.0-21/topics/pava) | [2008–2023](https://cran.r-project.org/web/packages/Iso/index.html) | yes | no | no |
| R | C | `intcox:::intcox.pavaC()` | [2006–2013](https://cran.r-project.org/src/contrib/Archive/intcox/)\*\* | yes | no | no |
| R | R | [`isotone::gpava()`](https://www.rdocumentation.org/packages/isotone/versions/1.1-1/topics/gpava) | [2009–2025](https://cran.r-project.org/web/packages/isotone/index.html) | yes | no | no |
| R | C | [`jbkpava()`](https://rpubs.com/deleeuw/262795) | NA | yes | no | no |
| R | R | [`logcondens::isoMean()`](https://cran.r-project.org/web/packages/logcondens/refman/logcondens.html#isoMean) | [2006–2026](https://cran.r-project.org/web/packages/logcondens/index.html) | yes | no | no |
| R | C | [`monotone::legacy(number = 3)` (`amalgm()`)][monotone-doc] | [2021-2022][monotone-date] | yes | no | no |
| R | C | [`monotone::legacy(number = 1)` (`fitm()`)][monotone-doc] | [2021-2022][monotone-date] | yes | no | no |
| R | C | [`monotone::legacy(number = 11)` (`inplace_pava()`)][monotone-doc] | [2021-2022][monotone-date] | yes | no | no |
| R | C | [`monotone::legacy(number = 10)` (`linear_pava()`)][monotone-doc] | [2021-2022][monotone-date] | yes | no | no |
| R | C | [`monotone::legacy(number = 4)` (`pav()`)][monotone-doc] | [2021-2022][monotone-date] | yes | no | no |
| R | C | [`monotone::legacy(number = 9)` (`pooled_pava()`)][monotone-doc] | [2021-2022][monotone-date] | yes | no | no |
| R | C | [`monotone::monotone()`][monotone-doc] | [2021-2022][monotone-date] | yes | no | no |
| Python | Python | [`sklearn.isotonic.isotonic_regression`](https://scikit-learn.org/stable/modules/generated/sklearn.isotonic.isotonic_regression.html) | [2020-2025](https://github.com/scikit-learn/scikit-learn/commits/afe5bcd80ce17fd8ca88c33beb17534bd36423bc/sklearn/isotonic.py) | yes | yes | no |
| Python | C | [`scipy.optimize.isotonic_regression`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.isotonic_regression.html) | [2023-2024](https://github.com/scipy/scipy/commits/v1.18.0/scipy/optimize/_isotonic.py) | yes | no | yes |
| R | R | [`SAGx::pava()`](https://bioconductor.org/about/removed-packages/) | 2005–2006\*\* | yes | no | no |
| R | Fortran | [`quadprog::solve.QP()`](https://www.rdocumentation.org/packages/quadprog/versions/1.5-8/topics/solve.QP) | [1999–2019](https://cran.r-project.org/web/packages/quadprog/index.html) | yes | yes | no |
| R | R | [`sandwich::pava.blocks()`](https://zeileis.codeberg.page/sandwich/) | [2004–2026](https://cran.r-project.org/web/packages/sandwich/index.html) | no | no | no |
| R | R | [`smacof:::pavasmacof()`][smacof-doc] | [2008–2024][smacof-doc] | yes | no | no |
| R | C | [`smacof:::wmonreg()`][smacof-doc] | [2008-2024][smacof-doc] | yes | no | no |
| R | C | [`stats::isoreg()`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/isoreg) | [2003–2024](https://github.com/r-devel/r-svn/commits/e0a0729f02927b7f479898db1dbf89f13e3aecba/src/library/stats/src/isoreg.c) | no | no | no |
| R | R | [`spsurvey::isotonic()`](https://github.com/USEPA/spsurvey) | [2019-2021](https://github.com/USEPA/spsurvey/commits/main/R/isotonic.R) | no | yes | no |
| R | C | [`UniIsoRegression::reg_1d()`](https://rdrr.io/cran/UniIsoRegression/man/reg_1d.html) | [2017](https://cran.r-project.org/web/packages/UniIsoRegression/index.html)\*\* | yes | no | no |

Space and time complexities for each function are listed in [FUNCTIONS.md](FUNCTIONS.md).

NA in complexities column means either the function was not available pre-2021, or we already use the 

\* Is the complexity (either space- or time-wise) talked about in the documentation for this function?

\*\* Packages were removed/archived

### Notes:
- The `sandwich` package, with a specific set of data (notably, a cliff - see [`src/_common/data.r`](src/_common/data.r), line 16) produces a stack overflow: `sandwich::pava.blocks()` fails with `Error: node stack overflow` from around $N = 2500$.
- Both `UniIsoRegression::reg_1d` and `monotone::legacy(number = 13)` (the latter being supposed to be an implementation of the earlier under the `monotone` package) have errors. See them in action under [`src/_validation/error-visualisation.r`](src/_validation/error-visualisation.r)
  - The original seems to count the first element twice whenever a pooled block reaches the start of the vector. This seems to be corrected in the `monotone` package, but makes the original wrong whenever a pooled block reaches the first element.
  - The legacy version initializes a vector with all zeros (`mean_vec`), and never sets it out to what it is supposed to be originally (`x`). This causes values that are already in order, in some cases, to be pooled together, becoming wrong whenever the data has values that should not be ppoled.


We assume `quadprog::solve.QP` to be the source of truth here. For all of its results, all functions in all packages have (within approximately $1.5\times 10^{-8}$) the same results.

Versions and dates for the packages and functions used for the results are available in [VERSIONS.md](VERSIONS.md)

[monotone-doc]: https://cran.r-project.org/web/packages/monotone/refman/monotone.html
[monotone-date]: https://cran.r-project.org/web/packages/monotone/index.html
[smacof-doc]: https://cran.r-project.org/web/packages/smacof/refman/smacof.html
[smacof-date]: https://cran.r-project.org/web/packages/smacof/index.html