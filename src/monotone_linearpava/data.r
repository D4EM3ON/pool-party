source("src/_common/data.r")

package_names <- "monotone_linearpava"
isotonic_functions <- list(
  linearpava = function(x) monotone::legacy(x, number = 10)
)
make_data(package_names, isotonic_functions)
