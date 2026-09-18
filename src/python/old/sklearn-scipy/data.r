library(data.table)
library(ggplot2)
library(glue)
library(reticulate)

virtualenv_create(
  "r-reticulate-old",
  version = "3.10",
  packages = c("scikit-learn==1.0.2", "scipy==1.7.3", "numpy==1.22.4")
)

use_virtualenv("r-reticulate-old", required = TRUE)

np <- import("numpy")
tracemalloc <- import("tracemalloc")
sklearn_isotonic <- import("sklearn.isotonic")
# scipy.optimize.isotonic_regression only landed in scipy 1.12 (2023-2024), so the
# pre-2022 snapshot has no scipy implementation to benchmark - sklearn only here.

package_names <- "old/sklearn-scipy"

half_size <- 0.5
lower_bound <- -100
upper_bound <- 200

make_target <- function(n) {
  set.seed(1)
  sort(runif(n, 0, 2 * n))
}
make_h_vec <- function(n) rep(half_size, n)

isotonic_functions <- list(
  sklearn = function(x) sklearn_isotonic$isotonic_regression(x)
)
(expr_list <- atime::atime_grid(
  list(PKG = names(isotonic_functions)),
  isoreg = {
    l_vec <- cumsum(c(lower_bound, h_vec[-N]) + h_vec)
    fun <- isotonic_functions[[PKG]]
    sol <- as.numeric(fun(target - l_vec) + l_vec)
    data.table(solution = list(sol))
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
    data.table(solution = list(sol$solution))
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

# Comparison of solutions - make sure the solutions match
ref <- "solve.QP PKG=quadprog"
expected <- c(names(expr_list), ref)
wide <- dcast(ares$measurements, N ~ expr.name, value.var = "solution")
# Ensure all expected columns are present
stopifnot(all(expected %in% colnames(wide)))
for (col in setdiff(expected, ref)) {
  # Identify the indices where both columns have non-NULL values
  both <- !sapply(wide[[col]], is.null) & !sapply(wide[[ref]], is.null)
  stopifnot(any(both))

  # Extract the values and references for the shared indices
  vals <- wide[[col]][both]
  refs <- wide[[ref]][both]
  ns <- wide$N[both]

  # Compare the extracted values to the reference solutions
  ok <- mapply(function(x, y) isTRUE(all.equal(x, y)), vals, refs)

  if (!all(ok)) {
    i <- which(!ok)[1]
    value <- vals[[i]]
    reference <- refs[[i]]
    detail <- if (length(value) != length(reference)) {
      glue("  length {length(value)} vs reference length {length(reference)}")
    } else {
      d <- head(which(value != reference), 5)
      paste(sprintf("  [%d] value = %.12g  vs  reference = %.12g",
                    d, value[d], reference[d]), collapse = "\n")
    }
    stop(glue(
      "Mismatch in '{col}' vs reference '{ref}' ",
      "({sum(!ok)} of {length(ok)} shared N values differ;",
      "first at N = {ns[i]})\n",
      "{detail}\n",
      "  all.equal: {paste(all.equal(value, reference), collapse = '; ')}"
    ))
  }
}

# Plots only need the measurements without the result and solution columns
# (dropped for space savings)
ares$measurements[, c("result", "solution") := NULL]
saveRDS(ares, glue("src/python/{package_names}/data/figure-data.rds"))
