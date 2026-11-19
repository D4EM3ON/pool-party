source("src/_common/data.r")

package_names <- "quadprog"

isotonic_functions <- list(
  quadprog = function(target) {
    k <- length(target)
    if (k < 2) return(target)
    identity <- diag(rep(1, k))
    ik <- diag(rep(1, k - 1))
    a <- rbind(0, ik) - rbind(ik, 0)
    b0 <- rep(0, k - 1)
    sol <- quadprog::solve.QP(identity, target, a, b0)
    sol$solution
  }
)

make_data(package_names, isotonic_functions)
