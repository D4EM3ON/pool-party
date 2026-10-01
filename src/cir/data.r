source("src/_common/data.r")

package_names <- "cir"

isotonic_functions <- list(
  cir = cir::oldPAVA
)

make_data(package_names, isotonic_functions)