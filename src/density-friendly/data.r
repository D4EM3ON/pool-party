source("src/_common/data.r")
Rcpp::sourceCpp("src/density-friendly/src/exactDF.cpp")

package_names <- "density-friendly"

isotonic_functions <- list(
  density_friendly = density_friendly_pava,
  density_friendly_legacy = function(x) monotone::legacy(x, number = 12)
)

make_data(package_names, isotonic_functions)
