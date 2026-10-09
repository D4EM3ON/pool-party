source("src/_common/data.r")

package_names <- "uniisoregression"
isotonic_functions <- list(
  uniisoregression = function(x) {
    UniIsoRegression::reg_1d(x, rep(1, length(x)), metric = 2)
  },
  uniisoregression_legacy = function(x) monotone::legacy(x, number = 13)
)
make_data(package_names, isotonic_functions)
