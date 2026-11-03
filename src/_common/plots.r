library(data.table)
library(ggplot2)
library(glue)

make_references <- function(ares, ref_exclude = "_legacy") {
  rfuns <- list(
    N = function(x) log10(x),
    "N log N" = function(x) log10(x) + log10(log10(x)),
    "N^2" = function(x) 2 * log10(x),
    "N^3" = function(x) 3 * log10(x) # add more functions here if need be
  )
  ares_ref <- ares
  if (!is.null(ref_exclude)) {
    ares_ref$measurements <- ares_ref$measurements[
      !grepl(ref_exclude, expr.name)
    ]
  }
  atime::references_best(ares_ref, rfuns)
}

make_pred_plot <- function(aref, file, seconds = 0.1, kilobytes = 1000) {
  apred <- predict(aref, seconds = seconds, kilobytes = kilobytes)
  png(file, width = 9, height = 5, units = "in", res = 200)
  print(
    plot(apred) + geom_blank(aes(10, 5), data = data.table(unit = "seconds"))
  )
  dev.off()
  apred
}

make_plots <- function(package_names, ref_exclude = "_legacy") {
  figure_path <- glue("src/{package_names}/figures")

  atime::atime
  ares <- readRDS(glue("src/{package_names}/data/figure-data.rds"))

  png(
    glue("{figure_path}/figure.png"),
    width = 7,
    height = 5,
    units = "in",
    res = 200
  )
  print(
    plot(ares) +
      scale_y_log10(breaks = 10^seq(-10, 10))
  )
  dev.off()

  aref <- make_references(ares, ref_exclude)
  png(
    glue("{figure_path}/figure-ref.png"),
    width = 12,
    height = 5,
    units = "in",
    res = 200
  )
  print(plot(aref))
  dev.off()

  apred <- make_pred_plot(aref, glue("{figure_path}/figure-pred.png"))

  png(
    glue("{figure_path}/figure-err.png"),
    width = 5,
    height = 5,
    units = "in",
    res = 200
  )
  print(
    plot(apred) + geom_blank(aes(10, 5), data = data.table(unit = "seconds"))
  )
  dev.off()
}
