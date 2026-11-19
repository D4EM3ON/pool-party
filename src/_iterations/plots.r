source("src/_common/plots.r")

package_names <- "_iterations"

make_plots(package_names, fun_exclude = c("N^3"))
