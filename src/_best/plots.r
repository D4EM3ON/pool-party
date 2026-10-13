source("src/_common/plots.r")

package_names <- "_best"

# For each dataset, one figure for time and one for memory, comparing the
# n_best functions
n_best <- 5
ares <- readRDS(glue("src/{package_names}/data/figure-data.rds"))
meas <- ares$measurements
units <- list(
  seconds = meas[, .(DATA, PKG, N, median, lo = q25, hi = q75)],
  kilobytes = meas[, .(DATA, PKG, N, median = kilobytes, lo = NA, hi = NA)]
)
for (data_name in unique(meas$DATA)) {
  for (unit in names(units)) {
    dt <- units[[unit]][DATA == data_name]
    # Best = reached the largest N, then lowest median at that N
    last <- dt[!is.na(median), .SD[which.max(N)], by = PKG]
    best <- last[order(-N, median)][seq_len(min(n_best, .N)), PKG]
    dt <- dt[PKG %in% best]
    # Relative to the best of the shown functions at each N, so small gaps
    # stay visible
    dt[, ref := min(median, na.rm = TRUE), by = N]
    dt <- dt[ref > 0]
    dt[, `:=`(median = median / ref, lo = lo / ref, hi = hi / ref)]
    p <- ggplot(dt, aes(N, median, color = PKG)) +
      geom_line() +
      scale_x_log10(breaks = 10^seq(0, 10)) +
      scale_y_log10(
        breaks = c(1, 1.25, 1.5, 2, 3, 5, 10, 20, 50, 100),
        labels = function(x) paste0(x, "x")
      ) +
      labs(
        title = glue("DATA = {data_name}"),
        y = glue("median {unit} relative to best at each N")
      ) +
      theme_bw() +
      theme(legend.position = "none") +
      directlabels::geom_dl(
        aes(label = PKG),
        method = list("right.polygons", cex = 0.7)
      ) +
      coord_cartesian(xlim = c(1, 10^9))
    if (unit == "seconds") {
      p <- p + geom_ribbon(
        aes(ymin = lo, ymax = hi, fill = PKG),
        alpha = 0.3,
        color = NA
      )
    }
    png(
      glue("src/{package_names}/figures/figure-{data_name}-{unit}.png"),
      width = 9,
      height = 5,
      units = "in",
      res = 200
    )
    print(p)
    dev.off()
  }
}
