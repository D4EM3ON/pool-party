source("src/_common/data.r")

package_names <- "isotone"

isotonic_functions <- list(
  isotone = function(x) isotone::gpava(seq_along(x), x)$x
)

make_data(package_names, isotonic_functions)
