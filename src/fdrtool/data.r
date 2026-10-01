source("src/_common/data.r")

package_names <- "fdrtool"

isotonic_functions <- list(
  fdrtool = function(x) fdrtool::monoreg(x)$yf
)

make_data(package_names, isotonic_functions)