source("src/_common/data.r")

package_names <- "monotone_pav"
isotonic_functions <- list(
  pav = function(x) monotone::legacy(x, number = 4)
)
make_data(package_names, isotonic_functions)
