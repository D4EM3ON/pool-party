source("src/_common/data.r")

package_names <- "monotone_inplacepava"
isotonic_functions <- list(
  inplacepava = function(x) monotone::legacy(x, number = 11)
)
make_data(
  package_names, isotonic_functions, max_n = 10^8.4, keep_result = FALSE
)
