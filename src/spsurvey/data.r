source("src/_common/data.r")

package_names <- "spsurvey"

isotonic_functions <- list(
  spsurvey_isotonic = function(x) spsurvey::isotonic(x, -Inf, Inf),
  isotonic_legacy = function(x) monotone::legacy(x, number = 7)
)
make_data(package_names, isotonic_functions)
