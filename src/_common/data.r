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
  labels = function(n) {
    target <- sort(runif(n, 0, 2 * n))
    b_lo <- 0
    h_vec <- rep(0.5, n)
    l_vec <- cumsum(c(b_lo, h_vec[-n]) + h_vec)
    target - l_vec
  },
  normal = function(n) rnorm(n)
)

make_data <- function(
  package_names,
  isotonic_functions,
  add_n = 0,
  seconds_limit = 1,
  max_n = 10^7,
  keep_result = TRUE,
  reps = 1
) {
  (expr_list <- atime::atime_grid(
    list(PKG = names(isotonic_functions), DATA = names(data_list)),
    isoreg = {
      x <- data_n_list[[DATA]]
      fun <- isotonic_functions[[PKG]]
      fun(x)
    }
  ))
  ares_list <- list()
  for (rep in seq_len(reps)) {
    ares_list[[rep]] <- atime::atime(
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
  }
  ares <- ares_list[[1]]
  plot(ares)

  if (reps > 1) {
    # Average the numeric columns over the repetitions, keeping only the N
    # reached by every repetition (list columns are dropped)
    meas <- rbindlist(lapply(ares_list, function(a) a$measurements))
    num_cols <- setdiff(names(meas)[sapply(meas, is.numeric)], "N")
    ares$measurements <- meas[,
      c(lapply(.SD, mean), .(n_reps = .N)),
      by = c(ares$by.vec, "N"),
      .SDcols = num_cols
    ][n_reps == reps][, n_reps := NULL]
  } else if (keep_result) {
    # Plots only need the measurements without the result and solution columns
    # (dropped for space savings)
    ares$measurements[, result := NULL]
  }
  saveRDS(ares, glue("src/{package_names}/data/figure-data.rds"))
}
