source("src/_common/plots.r")

package_names <- "_best"

ares <- readRDS(glue("src/{package_names}/data/figure-data.rds"))
meas <- ares$measurements
for (data_name in unique(meas$DATA)) {
  ares_data <- ares
  ares_data$measurements <- meas[DATA == data_name][, expr.name := PKG]
  aref <- make_references(ares_data)
  make_pred_plot(
    aref,
    glue("src/{package_names}/figures/figure-{data_name}-pred.png"),
    seconds = 0.01
  )
}

avg <- meas[!is.na(median), .(
  median = mean(median), min = mean(min), max = mean(max),
  kilobytes = mean(kilobytes), n_ds = .N
), by = .(PKG, N)][n_ds == uniqueN(meas$DATA)]
ares_avg <- ares
ares_avg$measurements <- avg[, `:=`(
  expr.name = PKG, expr.grid = PKG, DATA = "overall"
)]
aref <- make_references(ares_avg)
make_pred_plot(
  aref,
  glue("src/{package_names}/figures/figure-overall-pred.png"),
  seconds = 0.01
)
