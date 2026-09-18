# Pool Party

| Lang | Code | Function | Updates | Space | Time | Weights | Bounds | Documented?\* | Same complexities before 2022? |
| ------ | ------- | ------------------------------------ | ----------------------- | :---: | :--: | :-----: | :----: | :-: | :-: |
| R | C | [`stats::isoreg()`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/isoreg) | [2003–2024][isoreg-src] | $N$ | $N^2$ | no | no | | no - space was $N^2$ and time was $N^3$ |
| R | C | [`monreg::monreg()`](https://www.rdocumentation.org/packages/monreg/versions/0.1.4.1/topics/monreg) | [2006–2023](https://cran.r-project.org/web/packages/monreg/index.html) | | | no | ? | | |
| R | C | [`fdrtool::monoreg()`](https://rdrr.io/cran/fdrtool/man/monoreg.html) | [2006–2024](https://cran.r-project.org/web/packages/fdrtool/index.html) | $N$ | $N$ | yes | no | | yes |
| R | R | [`cir::oldPAVA()`](https://www.rdocumentation.org/packages/cir/versions/2.5.1/topics/oldPAVA) | [2008–2025](https://cran.r-project.org/web/packages/cir/index.html) | $N^2$ | $N^2$ | yes | no | | yes |
| R | Fortran | [`Iso::pava()`](https://www.rdocumentation.org/packages/Iso/versions/0.0-21/topics/pava) | [2008–2023](https://cran.r-project.org/web/packages/Iso/index.html) | $N$ | $N^2$ | yes | no | | yes |
| R | R | `clue:::pava()` | [2004–2026](https://cran.r-project.org/web/packages/clue/index.html) | $N^2$ | $N^2$ | yes | no | | yes |
| R | R | [`logcondens::isoMean()`](https://cran.r-project.org/web/packages/logcondens/refman/logcondens.html#isoMean) | [2006–2026](https://cran.r-project.org/web/packages/logcondens/index.html) | $N$ | $N$ | yes | no | | yes |
| R | R | [`sandwich::pava.blocks()`](https://zeileis.codeberg.page/sandwich/) | [2004–2026](https://cran.r-project.org/web/packages/sandwich/index.html) | $N \log N$ | $N \log N$ | no | no | | yes |
| R | C | `intcox::intcox.pavaC()` | [2006–2013]([intcox](https://cran.r-project.org/src/contrib/Archive/intcox/))\*\* | $N$ | $N$ | yes | no | | NA |
| R | R | [`SAGx::pava()`](https://bioconductor.org/about/removed-packages/) | 2005–2006\*\* | $N^2$ | $N^2$ | yes | no | | NA |
| R | R | [`smacof:::pavasmacof()`](https://cran.r-project.org/web/packages/smacof/refman/smacof.html) | [2008–2024](https://cran.r-project.org/web/packages/smacof/index.html) | $N^2$ | $N^2$ | yes | no | | yes |
| R | R | [`isotone::gpava()`](https://www.rdocumentation.org/packages/isotone/versions/1.1-1/topics/gpava) | [2009–2025](https://cran.r-project.org/web/packages/isotone/index.html) | $N^2$ | $N^2$ | yes | no | | yes |
| R | Fortran | [`quadprog::solve.QP()`](https://www.rdocumentation.org/packages/quadprog/versions/1.5-8/topics/solve.QP) | [1999–2019](https://cran.r-project.org/web/packages/quadprog/index.html) | $N^2$ | $N^3$ | yes | yes | | NA |
| R | C | [`monotone::monotone()`](https://cran.r-project.org/web/packages/monotone/refman/monotone.html) | [2021-2022](https://cran.r-project.org/web/packages/monotone/index.html) | $N$ | $N$ | yes | no | | no - time is $N\log N$|
| R | C | [`directlabels::isoreg_dp()`][dl-pr] | [2010-2026](https://cran.r-project.org/web/packages/directlabels/index.html) | $N$ | $N$ | no | no | | NA |
| Python | Python | [`sklearn.IsotonicRegression`][sklearn] | [2020-2025](https://github.com/scikit-learn/scikit-learn/commits/afe5bcd80ce17fd8ca88c33beb17534bd36423bc/sklearn/isotonic.py) | $N$ | $N$ | yes | yes | | yes |
| Python | C | [`scipy.optimize.isotonic_regression`][scipy] | [2023-2024](https://github.com/scipy/scipy/commits/v1.18.0/scipy/optimize/_isotonic.py) | $N$ | $N$ | yes | no | | NA |

NA in complexities column means either the function was not available pre-2021, 

\* Is the complexity (either space- or time-wise) talked about in the documentation for this function?

\*\* Packages were removed/archived


We assume `quadprog::solve.QP` to be the source of truth here. For all of its results, all functions in all packages have (within approximately $1.5\times 10^{-8}$) the same results.

[isoreg-src]: https://github.com/r-devel/r-svn/commits/e0a0729f02927b7f479898db1dbf89f13e3aecba/src/library/stats/src/isoreg.c
[sklearn]: https://scikit-learn.org/stable/modules/generated/sklearn.isotonic.IsotonicRegression.html
[scipy]: https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.isotonic_regression.html
[dl-pr]: https://github.com/tdhock/directlabels