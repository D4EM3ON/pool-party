source("src/_common/data.r")

package_names <- "directlabels"

isotonic_functions <- list(
  directlabels = directlabels::isoreg_dp
)

make_data(package_names, isotonic_functions)
