source("src/_common/data.r")

package_names <- "stats"

isotonic_functions <- list(
  stats = function(x) isoreg(x)$yf,
  stats_legacy = function(x) monotone::legacy(x, number = 5)
)

make_data(package_names, isotonic_functions)