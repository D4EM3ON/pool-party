# Pool Party

| Lang   | Code    | Function                             | Updates                 | Space | Time | Weights | Bounds |
| ------ | ------- | ------------------------------------ | ----------------------- | :---: | :--: | :-----: | :----: |
| R      | C       | [`isoreg()`](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/isoreg)                           | [2003–2024][isoreg-src] |   N   | N^2  |   no    |   no   |
| R      | C       | [`monreg::monreg()`](https://www.rdocumentation.org/packages/monreg/versions/0.1.4.1/topics/monreg)                   | 2006–2020               |       |      |         |        |
| R      | C       | [`fdrtool::monoreg()`](https://rdrr.io/cran/fdrtool/man/monoreg.html)                 | 2006–2021               |       |      |         |        |
| R      | R       | [`cir::pava()`](https://www.rdocumentation.org/packages/cir/versions/2.5.1/topics/cirPAVA)                        | 2008–2024               |       |      |         |        |
| R      | Fortran | [`Iso::pava()`](https://www.rdocumentation.org/packages/Iso/versions/0.0-21/topics/pava)                        | 2008–2020               |       |      |   yes   |   no   |
| R      | R       | `clue::pava()` ??                      | 2004–2026               |       |      |         |        |
| R      | R       | [`logcondens::isoMean()`](https://cran.r-project.org/web/packages/logcondens/refman/logcondens.html#isoMean)             | 2006–2023               |       |      |         |        |
| R      | R       | [`sandwich::pava.blocks()`](https://zeileis.codeberg.page/sandwich/) ??            | 2004–2026               |       |      |         |        |
| R      | C       | [`intcox::intcox.pavaC()`](https://cran.r-project.org/src/contrib/Archive/intcox/) - archived             | 2006–2013\*             |       |      |         |        |
| R      | R       | `SAGx::pava.fdr()`                   | 2005–2006\*             |       |      |         |        |
| R      | R       | `smacof::pavasmacof()`               | 2008–2024               |       |      |         |        |
| R      | R       | `isotone::gpava()`                   | 2009–2023               |       |      |   yes   |        |
| R      | Fortran | `quadprog::solve.QP()`               | 1999–2019               |  N^2  | N^3  |   yes   |  yes   |
| Python | Python  | [`IsotonicRegression`][sklearn]      |                         |       |  N?  |   yes   |  yes   |
| Python | C       | [`isotonic_regression`][scipy]       |                         |       |  N   |   yes   |   no   |
| R      | C       | `monotone::monotone()`               |                         |       |  N   |   yes   |        |
| R      | C       | [`directlabels::isoreg_dp()`][dl-pr] | 2026                    |   N   |  N   |   no    |   no   |

[isoreg-src]: https://github.com/r-devel/r-svn/commits/e0a0729f02927b7f479898db1dbf89f13e3aecba/src/library/stats/src/isoreg.c
[sklearn]: https://scikit-learn.org/stable/modules/generated/sklearn.isotonic.IsotonicRegression.html
[scipy]: https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.isotonic_regression.html
[dl-pr]: https://github.com/tdhock/directlabels/pull/65
