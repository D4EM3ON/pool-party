source("src/_common/data.r")

package_names <- "monotone_fitm"
isotonic_functions <- list(
  fitm = function(x) monotone::legacy(x, number = 1)
)
make_data(package_names, isotonic_functions)
