source("src/_common/data.r")

package_names <- "tabicl2"
isotonic_functions <- list(
  tabicl2 = function(x) {
    y <- torch::torch_tensor(x, dtype = torch::torch_float64())
    as.numeric(TabICL2:::.pava_single(y))
  }
)
make_data(package_names, isotonic_functions)
