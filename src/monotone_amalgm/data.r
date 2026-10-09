source("src/_common/data.r")

package_names <- "monotone_amalgm"
isotonic_functions <- list(
  amalgm = function(x) monotone::legacy(x, number = 3)
)
make_data(package_names, isotonic_functions)
