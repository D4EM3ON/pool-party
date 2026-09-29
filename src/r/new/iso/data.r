library(data.table)
library(ggplot2)
library(glue)

package_names <- "new/iso"

data_list <- list(
  up_down = function(n) {
    half <- n/2
    c(1:half, half:1)
  },
  up = function(n) {
    1:n
  },
  down = function(n) {
    n:1
  }
)

isotonic_functions <- list(
  iso = Iso:::pava,
  iso_legacy = function(x) monotone::legacy(x, number = 6)
)
(expr_list <- atime::atime_grid(
  list(PKG = names(isotonic_functions), DATA = names(data_list)),
  isoreg = {
    x <- data_n_list[[DATA]]
    fun <- isotonic_functions[[PKG]]
    fun(x)
  }
))
ares <- atime::atime(
  N = 10^seq(0, 7, by = 0.2),
  setup = {
    set.seed(1)
    data_n_list <- list()
    for (name in names(data_list)) {
      gen_fun <- data_list[[name]]
      data_n_list[[name]] <- gen_fun(N)
    }
  },
  expr.list = expr_list,
  seconds.limit = 1,
  result = TRUE
)
plot(ares)


# Plots only need the measurements without the result and solution columns
# (dropped for space savings)
# ares$measurements[, c("result", "solution") := NULL]
saveRDS(ares, glue("src/r/{package_names}/data/figure-data.rds"))
