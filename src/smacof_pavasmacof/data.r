source("src/_common/data.r")

package_names <- "smacof_pavasmacof"

isotonic_functions <- list(
  smacof_pavasmacof = smacof:::pavasmacof
)

make_data(package_names, isotonic_functions)
