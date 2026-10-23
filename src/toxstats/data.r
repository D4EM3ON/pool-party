source("src/_common/data.r")

package_names <- "toxstats"
isotonic_functions <- list(
  toxstats = function(x) toxstats:::pava(x, rep(1, length(x)))
)
make_data(package_names, isotonic_functions)
