library(data.table)
library(ggplot2)
library(glue)

package_names <- "logcondens"

isotonic_functions <- list(
  logcondens = logcondens::isoMean,
)
(expr_list <- atime::atime_grid(
  list(PKG = names(isotonic_functions)),
  isoreg = {
    l_vec <- cumsum(c(lower_bound, h_vec[-N]) + h_vec)
    fun <- isotonic_functions[[PKG]]
    fun(target - l_vec, weights) + l_vec
  }
))
ares <- atime::atime(
  N = 10^seq(0, 7, by = 0.2) + 1,
  setup = {
    set.seed(1)
    target <- sort(runif(N, 0, 2 * N))
    half_size <- 0.5
    h_vec <- rep(half_size, N)
    lower_bound <- -100
    upper_bound <- 200
    weights <- rep(1, N)
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

# Plots only need the measurements without the result column
# (dropped for space savings)
ares$measurements[, result := NULL]

saveRDS(ares, glue("src/r/{package_names}/data/figure-data.rds"))
