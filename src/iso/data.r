source("src/_common/data.r")

package_names <- "iso"

isotonic_functions <- list(
  iso = Iso:::pava,
  iso_legacy = function(x) monotone::legacy(x, number = 6)
)

make_data(package_names, isotonic_functions)
