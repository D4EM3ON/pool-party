source("src/_common/data.r")

package_names <- "smacof_wmonreg"
isotonic_functions <- list(
  smacof_wmonreg = function(x) {
    .C(smacof:::wmonreg, as.double(x), as.double(rep(1, length(x))),
       as.integer(length(x)))[[1]]
  },
  wmonreg_legacy = function(x) monotone::legacy(x, number = 2)
)
make_data(package_names, isotonic_functions)
