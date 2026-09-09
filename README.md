# Pool Party

| Lang | Code | Function | Updates | Space | Time | Weights | Bounds |
| ------ | ------- | ------------------------------------ | ----------------------- | :---: | :--: | :-----: | :----: |
| R | C | [`stats::isoreg()`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/isoreg) | [2003–2024][isoreg-src] | N | $N^2$ | no | no |
| R | C | [`monreg::monreg()`](https://www.rdocumentation.org/packages/monreg/versions/0.1.4.1/topics/monreg) | [2006–2023](https://cran.r-project.org/web/packages/monreg/index.html) | | | no | ? |
| R | C | [`fdrtool::monoreg()`](https://rdrr.io/cran/fdrtool/man/monoreg.html) | [2006–2024](https://cran.r-project.org/web/packages/fdrtool/index.html) | | | yes | no |
| R | R | [`cir::cirPAVA()`](https://www.rdocumentation.org/packages/cir/versions/2.5.1/topics/cirPAVA) | [2008–2025](https://cran.r-project.org/web/packages/cir/index.html) | $N^2$ | $N^{1.5}$ | yes | no |
| R | Fortran | [`Iso::pava()`](https://www.rdocumentation.org/packages/Iso/versions/0.0-21/topics/pava) | [2008–2023](https://cran.r-project.org/web/packages/Iso/index.html) | $N$ | $N^2$ | yes | no |
| R | R | `clue::pava()` | [2004–2026](https://cran.r-project.org/web/packages/clue/index.html) | $N^2$ | $N^2$ | yes | no |
| R | R | [`logcondens::isoMean()`](https://cran.r-project.org/web/packages/logcondens/refman/logcondens.html#isoMean) | [2006–2026]() | | | yes | no |
| R | R | [`sandwich::pava.blocks()`](https://zeileis.codeberg.page/sandwich/) | [2004–2026](https://cran.r-project.org/web/packages/sandwich/index.html) | | | no | no |
| R | C | [`intcox::intcox.pavaC()`](https://cran.r-project.org/src/contrib/Archive/intcox/) | [2006–2013](intcox)\* | | | yes | no |
| R | R | [`SAGx::pava()`](https://bioconductor.org/about/removed-packages/) | [2005–2006](https://cran.r-project.org/src/contrib/Archive/SAGx/)\* | | | yes | no |
| R | R | [`smacof::pavasmacof()`](https://cran.r-project.org/web/packages/smacof/refman/smacof.html) | [2008–2024](https://cran.r-project.org/web/packages/smacof/index.html) | | | yes | no |
| R | R | [`isotone::gpava()`](https://www.rdocumentation.org/packages/isotone/versions/1.1-1/topics/gpava) | [2009–2025](https://cran.r-project.org/web/packages/smacof/index.html) | | | yes | no |
| R | Fortran | [`quadprog::solve.QP()`](https://www.rdocumentation.org/packages/quadprog/versions/1.5-8/topics/solve.QP) | [1999–2019](https://cran.r-project.org/web/packages/quadprog/index.html) | $N^2$ | $N^3$ | yes | yes |
| R | C | [`monotone::monotone()`](https://cran.r-project.org/web/packages/monotone/refman/monotone.html) | [2021-2022](https://cran.r-project.org/web/packages/monotone/index.html) | N | N | yes | no |
| R | C | [`directlabels::isoreg_dp()`][dl-pr] | [2010-2026](https://cran.r-project.org/web/packages/directlabels/index.html) | N | N | no | no |
| Python | Python | [`sklearn.IsotonicRegression`][sklearn] | [2011-2026](https://pypi.org/project/scikit-learn/#history) | | N? | yes | yes |
| Python | C | [`scipy.optimize.isotonic_regression`][scipy] | [2006-2026](https://pypi.org/project/scipy/#history) | | N | yes | no |

\* Packages were removed/archived

[isoreg-src]: https://github.com/r-devel/r-svn/commits/e0a0729f02927b7f479898db1dbf89f13e3aecba/src/library/stats/src/isoreg.c
[sklearn]: https://scikit-learn.org/stable/modules/generated/sklearn.isotonic.IsotonicRegression.html
[scipy]: https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.isotonic_regression.html
[dl-pr]: https://github.com/tdhock/directlabels