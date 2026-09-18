library(data.table)
library(ggplot2)
library(glue)

package_names <- "new/sandwich"

ares <- atime::atime(
  N = 10^seq(0, 7, by = 0.2),
  setup = {
    set.seed(1)
    target <- sort(runif(N, 0, 2 * N))
    half_size <- 0.5
    h_vec <- rep(half_size, N)
    lower_bound <- -100
    upper_bound <- 200
  },
  sandwich = {
    l_vec <- cumsum(c(lower_bound, h_vec[-N]) + h_vec)
    fit <- sandwich::pava.blocks(target - l_vec)
    data.table(
      solution = list(rep(fit$x, fit$blocks) + l_vec)
    )
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
  seconds.limit = 1,
  result = TRUE
)
plot(ares)

# Comparison of solutions - make sure the solutions match
cmp <- dcast(
  ares$measurements, N ~ expr.name, value.var = "solution"
)[
  !sapply(quadprog, is.null)
][, ok := mapply(function(i, q) isTRUE(all.equal(i, q)), sandwich, quadprog)]
stopifnot(nrow(cmp) > 0, all(cmp$ok))

# Plots only need the measurements without the result and solution columns
# (dropped for space savings)
ares$measurements[, c("result", "solution") := NULL]
saveRDS(ares, glue("src/r/{package_names}/data/figure-data.rds"))
