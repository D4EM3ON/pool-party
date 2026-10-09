source("src/_common/data.r")

package_names <- "monotone_pooledpava"

isotonic_functions <- list(
  pooledpava = function(x) monotone::legacy(x, number = 9)
)
make_data(package_names, isotonic_functions)
