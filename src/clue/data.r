source("src/_common/data.r")

package_names <- "clue"

isotonic_functions <- list(
  clue = clue:::pava
)

make_data(package_names, isotonic_functions)