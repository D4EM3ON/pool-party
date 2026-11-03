source("src/_common/plots.r")

package_names <- "_best"

# For each dataset, one figure-pred (same as make_plots) for the n_best
# functions
n_best <- 5
ares <- readRDS(glue("src/{package_names}/data/figure-data.rds"))
meas <- ares$measurements
for (data_name in unique(meas$DATA)) {
  dt <- meas[DATA == data_name]
  # Best = reached the largest N, then lowest median time at that N
  last <- dt[!is.na(median), .SD[which.max(N)], by = PKG]
  best <- last[order(-N, median)][seq_len(min(n_best, .N)), PKG]
  ares_best <- ares
  # Short labels: one figure per dataset, so the PKG alone is enough
  ares_best$measurements <- dt[PKG %in% best][, expr.name := PKG]
  aref <- make_references(ares_best)
  # The best all reach max N in ~0.03s, so 0.1s would never be reached
  make_pred_plot(
    aref,
    glue("src/{package_names}/figures/figure-{data_name}-pred.png"),
    seconds = 0.01
  )
}

# Average all and make a figure-pred for the overall best functions
# Mean over DATA per (PKG, N), keeping only N reached on every dataset
avg <- meas[!is.na(median), .(
  median = mean(median), min = mean(min), max = mean(max),
  kilobytes = mean(kilobytes), n_ds = .N
), by = .(PKG, N)][n_ds == uniqueN(meas$DATA)]
last <- avg[, .SD[which.max(N)], by = PKG]
best <- last[order(-N, median)][seq_len(min(n_best, .N)), PKG]
ares_best <- ares
ares_best$measurements <- avg[PKG %in% best][, `:=`(
  expr.name = PKG, expr.grid = PKG, DATA = "overall"
)]
aref <- make_references(ares_best)
make_pred_plot(
  aref,
  glue("src/{package_names}/figures/figure-overall-pred.png"),
  seconds = 0.01
)