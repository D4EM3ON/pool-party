source("src/_common/data.r")

package_names <- "stats"

isotonic_functions <- list(
  stats = function(x) isoreg(x)$yf
)

make_data(package_names, isotonic_functions)