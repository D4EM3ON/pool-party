source("src/_common/data.r")

package_names <- "intcox"

isotonic_functions <- list(
  intcox = function(x) intcox:::intcox.pavaC(rep(1, length(x)), x)
)

make_data(package_names, isotonic_functions)