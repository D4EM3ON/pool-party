library(data.table)
library(ggplot2)
library(glue)
library(reticulate)

py_require("scikit-learn")
py_require("scipy")
py_require("numpy")

np <- import("numpy")
tracemalloc <- import("tracemalloc")
sklearn_isotonic <- import("sklearn.isotonic")
scipy_isotonic <- import("scipy.optimize")

package_names <- "sklearn-scipy"

half_size <- 0.5
lower_bound <- -100
upper_bound <- 200

make_target <- function(n) {
  set.seed(1)
  sort(runif(n, 0, 2 * n))
}
make_h_vec <- function(n) rep(half_size, n)

isotonic_functions <- list(
  sklearn = function(x) sklearn_isotonic$isotonic_regression(x),
  scipy = function(x) scipy_isotonic$isotonic_regression(x)$x
)
(expr_list <- atime::atime_grid(
  list(PKG = names(isotonic_functions)),
  isoreg = {
    l_vec <- cumsum(c(lower_bound, h_vec[-N]) + h_vec)
    fun <- isotonic_functions[[PKG]]
    fun(target - l_vec) + l_vec
  }
))
ares <- atime::atime(
  N = 10^seq(0, 7, by = 0.2) + 1,
  setup = {
    target <- make_target(N)
    h_vec <- make_h_vec(N)
  },
  expr.list = expr_list,
  "solve.QP PKG=quadprog" = {
    k <- length(target)
    identity <- diag(rep(1, k))
    ik <- diag(rep(1, k - 1))
    a <- rbind(0, ik) - rbind(ik, 0)
    y_up <- target + half_size
    y_lo <- target - half_size
    b0 <- (y_up - target)[-k] + (target - y_lo)[-1]
    sol <- quadprog::solve.QP(identity, target, a, b0)
    data.table(iteration = sol$iterations[1], solution = list(sol$solution))
  },
  seconds.limit = 1,
  result = TRUE
)
plot(ares)

peak_kb <- function(fun, x_py) {
  tracemalloc$start()
  base <- tracemalloc$get_traced_memory()[[1]]
  invisible(fun(x_py))
  peak <- tracemalloc$get_traced_memory()[[2]]
  tracemalloc$stop()
  (peak - base) / 1024
}

deterministic_memory <-
  rbindlist(lapply(sort(unique(ares$measurements$N)),
                   function(N)
{ # nolint
  target <- make_target(N)
  h_vec <- make_h_vec(N)
  # Same formula as the isoreg grid expression above.
  l_vec <- cumsum(c(lower_bound, h_vec[-N]) + h_vec)
  x_py <- np$array(target - l_vec)
  rbindlist(lapply(names(isotonic_functions), function(pkg) {
    data.table(
      expr.name = paste0("isoreg PKG=", pkg),
      N = N,
      py_kilobytes = peak_kb(isotonic_functions[[pkg]], x_py)
    )
  }))
}))

ares$measurements[
                  deterministic_memory,
                  on = .(N, expr.name),
                  py_kilobytes := i.py_kilobytes]

ares$unit.col.vec <- c(ares$unit.col.vec, "py_kilobytes")

# Plots only need the measurements without the result column
# (dropped for space savings)
ares$measurements[, result := NULL]

saveRDS(ares, glue("src/python/{package_names}/data/figure-data.rds"))
