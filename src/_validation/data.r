library(data.table)
library(ggplot2)
library(glue)

# Folder to validate that all isotonic functions produce consistent results

package_names <- "validation"


isotonic_functions <- list(
  cir = cir::oldPAVA,
  clue = clue:::pava,
  directlabels = directlabels::isoreg_dp,
  fdrtool = function(x) fdrtool::monoreg(x)$yf,
  intcox = function(x) intcox:::intcox.pavaC(rep(1, length(x)), x),
  iso = Iso:::pava,
  isotone = function(x) isotone::gpava(seq_along(x), x)$x,
  logcondens = function(x) logcondens::isoMean(x, rep(1, length(x))),
  monotone = monotone::monotone,
  sagx = SAGx::pava,
  sandwich = function(x, w) {
    fit <- sandwich::pava.blocks(x)
    rep(fit$x, fit$blocks) # not exactly what i want to do
  },
  smacof = smacof:::pavasmacof,
  stats = function(x) isoreg(x)$yf
)
(expr_list <- atime::atime_grid(
  list(PKG = names(isotonic_functions)),
  isoreg = {
    l_vec <- cumsum(c(lower_bound, h_vec[-N]) + h_vec)
    fun <- isotonic_functions[[PKG]]
    sol <- fun(target - l_vec) + l_vec
    data.table(solution = list(sol))
  }
))
ares <- atime::atime(
  N = 10^seq(1, 7, by = 0.2),
  setup = {
    set.seed(1)
    target <- sort(runif(N, 0, 2 * N))
    half_size <- 0.5
    h_vec <- rep(half_size, N)
    lower_bound <- -100
    upper_bound <- 200
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
ares$measurements[, result := NULL]
saveRDS(ares, glue("src/{package_names}/data/figure-data.rds"))
