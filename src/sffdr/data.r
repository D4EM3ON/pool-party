source("src/_common/data.r")

package_names <- "sffdr"
isotonic_functions <- list(
  sffdr = function(x) {
    n <- length(x)
    -sffdr::monoSmooth_pava(seq_len(n) / n, -x, rep(1L, n))
  }
)
make_data(package_names, isotonic_functions)
