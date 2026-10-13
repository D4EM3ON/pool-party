library(data.table)
library(ggplot2)
library(glue)

data_list <- list(
  up_down = function(n) {
    half <- n / 2
    c(1:half, half:1)
  },
  up = function(n) {
    1:n
  },
  down = function(n) {
    n:1
  },
  cliff = function(n) {
    c(seq_len(n - 1), -n^2)
  },
  zigzag = function(n) {
    rep_len(c(1, 0), n)
  },
  normal = function(n) rnorm(n)
)

make_data <- function(
  package_names,
  isotonic_functions,
  add_n = 0,
  seconds_limit = 1,
  max_n = 10^7,
  keep_result = TRUE
) {
  (expr_list <- atime::atime_grid(
    list(PKG = names(isotonic_functions), DATA = names(data_list)),
    isoreg = {
      x <- data_n_list[[DATA]]
      fun <- isotonic_functions[[PKG]]
      fun(x)
    }
  ))
  ares <- atime::atime(
    N = 10^seq(0, log10(max_n), by = 0.2) + add_n,
    setup = {
      set.seed(1)
      data_n_list <- list()
      for (name in names(data_list)) {
        gen_fun <- data_list[[name]]
        data_n_list[[name]] <- gen_fun(N)
      }
    },
    expr.list = expr_list,
    seconds.limit = seconds_limit,
    result = keep_result
  )
  plot(ares)


  # Plots only need the measurements without the result and solution columns
  # (dropped for space savings)
  if (keep_result) ares$measurements[, result := NULL]
  saveRDS(ares, glue("src/{package_names}/data/figure-data.rds"))
}
