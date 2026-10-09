source("src/_common/data.r")

package_names <- "fdrtool"

isotonic_functions <- list(
  fdrtool = function(x) fdrtool::monoreg(x)$yf,
  fdrtool_legacy = function(x) monotone::legacy(x, number = 8)
)

make_data(package_names, isotonic_functions)