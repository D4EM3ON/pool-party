source("src/_common/data.r")

package_names <- "iso"

isotonic_functions <- list(
  iso = Iso:::pava
)

make_data(package_names, isotonic_functions)