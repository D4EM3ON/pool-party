library(data.table)
library(ggplot2)
library(glue)

package_names <- "isotone"

ares <- atime::atime(
  N = 10^seq(1, 7, by = 0.2),
  setup = {
    set.seed(1)
    target <- sort(runif(N, 0, 2 * N))
    half_size <- 0.5
    h_vec <- rep(half_size, N)
    lower_bound <- -100
    upper_bound <- 200
    x_values <- 1:N
  },
  isoreg = {
    l_vec <- cumsum(c(lower_bound, h_vec[-N]) + h_vec)
    data.table(solution = list(isotone::gpava(x_values, target - l_vec)$x + l_vec))
  },
  quadprog = {
    k <- length(target)
    identity <- diag(rep(1, k))
    ik <- diag(rep(1, k - 1))
    a <- rbind(0, ik) - rbind(ik, 0)
    y_up <- target + half_size
    y_lo <- target - half_size
    b0 <- (y_up - target)[-k] + (target - y_lo)[-1]
    sol <- quadprog::solve.QP(identity, target, a, b0)
    data.table(solution = list(sol$solution))
  },
  seconds.limit = 0.01,
  result = TRUE
)
plot(ares)

# Plots only need the measurements without the result column
# (dropped for space savings)
ares$measurements[, result := NULL]

# Next line for comparison for 
# dcast(ares$measurements, N ~ expr.name, value.var = "solution")[, eq := list(list(all.equal(isoreg,quadprog))), by=N][!sapply(quadprog, is.null), all(eq)]

saveRDS(ares, glue("src/r/{package_names}/data/figure-data.rds"))
