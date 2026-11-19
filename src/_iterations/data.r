source("src/_common/data.r")
# Loads the C routines of the package (they are called through .C())
requireNamespace("monotone.iterations")

package_names <- "_iterations"

# Calls the instrumented C routine, which fills a vector with the number of
# iterations done at each element of x. For a given N, we keep the highest
# number of iterations reached at a single element, and the total.
count_iterations <- function(c_fun_name) {
  function(x) {
    n <- length(x)
    iterations <- .C(
      c_fun_name,
      n = as.integer(n),
      x = as.double(x),
      w = as.double(rep(1, n)),
      iterations = integer(n),
      PACKAGE = "monotone.iterations"
    )$iterations
    data.table(
      max_iterations = max(iterations),
      total_iterations = sum(as.numeric(iterations))
    )
  }
}

# Functions of src/_best that have an instrumented version in
# monotone.iterations (in comments: their name in src/_best)
isotonic_functions <- list(
  monotone_fitm = count_iterations("fitm_iterations"),
  monotone_inplacepava = count_iterations("inplace_pava_iterations"),
  monotone_intcoxpava = count_iterations("intcox_pava_iterations"), # intcox
  monotone_isomean = count_iterations("isomean_iterations"), # fdrtool
  # directlabels
  monotone_isoregdp = count_iterations("isoreg_dp_weights_iterations"),
  monotone_jbkpava = count_iterations("jbkpava_iterations"), # jbkpava
  # density_friendly_pava
  monotone_mdpava = count_iterations("md_pava_iterations"),
  monotone_pooledpava = count_iterations("pooled_pava_iterations"),
  monotone = count_iterations("monotoneC_iterations")
)

# keep_result needs to be TRUE: atime adds the columns of the returned
# data.table as units, next to seconds and kilobytes
make_data(package_names, isotonic_functions, add_n = 1)
