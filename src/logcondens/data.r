source("src/_common/data.r")

package_names <- "logcondens"

isotonic_functions <- list(
  logcondens = function(x) logcondens::isoMean(x, rep(1, length(x)))
)

make_data(package_names, isotonic_functions, add_n = 1)
