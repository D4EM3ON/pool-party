source("src/_common/data.r")

package_names <- "sagx"

isotonic_functions <- list(
  sagx = SAGx::pava
)

make_data(package_names, isotonic_functions)
