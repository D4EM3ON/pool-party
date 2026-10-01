source("src/_common/data.r")

package_names <- "monotone"

isotonic_functions <- list(
  monotone = monotone::monotone
)

make_data(package_names, isotonic_functions, max_n = 10^8)