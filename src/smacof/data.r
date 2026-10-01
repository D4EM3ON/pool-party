source("src/_common/data.r")

package_names <- "smacof"

isotonic_functions <- list(
  smacof = smacof:::pavasmacof
)

make_data(package_names, isotonic_functions)
