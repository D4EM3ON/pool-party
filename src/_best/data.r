source("src/_common/data.r")
Rcpp::sourceCpp("src/density-friendly/src/exactDF.cpp")
source("src/jbkpava/src/jbkpava.r")

package_names <- "_best"
isotonic_functions <- list(
  density_friendly_pava = density_friendly_pava,
  directlabels = directlabels::isoreg_dp,
  fdrtool = function(x) fdrtool::monoreg(x)$yf,
  intcox = function(x) intcox:::intcox.pavaC(rep(1, length(x)), x),
  jbkpava = jbkpava,
  logcondens = function(x) logcondens::isoMean(x, rep(1, length(x))),
  monotone = monotone::monotone,
  legacy_fitm = function(x) monotone::legacy(x, number = 1),
  legacy_inplacepava = function(x) monotone::legacy(x, number = 11),
  pooled_pava = function(x) monotone::legacy(x, number = 9),
  uniisoregression = function(x) {
    UniIsoRegression::reg_1d(x, rep(1, length(x)), metric = 2)
  }
)

make_data(package_names, isotonic_functions, add_n = 1, keep_result = FALSE)
