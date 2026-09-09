library(data.table)
library(ggplot2)
library(glue)

package_names <- "sklearn-scipy"
figure_path <- glue("src/python/{package_names}/figures")

atime::atime
ares <- readRDS(glue("src/python/{package_names}/data/figure-data.rds"))

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

rfuns <- list(
  N = function(x) log10(x),
  "N log N" = function(x) log10(x) + log10(log10(x)),
  "N^1.5" = function(x) 1.5 * log10(x),
  "N^2" = function(x) 2 * log10(x),
  "N^3" = function(x) 3 * log10(x) # add more functions here if need be
)
aref <- atime::references_best(ares, rfuns)
png(
  glue("{figure_path}/figure-ref.png"),
  width = 12,
  height = 5,
  units = "in",
  res = 200
)
print(plot(aref))
dev.off()

apred <- predict(aref, seconds = 0.1, kilobytes = 1000, py_kilobytes = 1000)
png(
  glue("{figure_path}/figure-pred.png"),
  width = 9,
  height = 5,
  units = "in",
  res = 200
)
print(plot(apred) + geom_blank(aes(10, 5), data = data.table(unit = "seconds")))
dev.off()

png(
  glue("{figure_path}/figure-err.png"),
  width = 5,
  height = 5,
  units = "in",
  res = 200
)
print(plot(apred) + geom_blank(aes(10, 5), data = data.table(unit = "seconds")))
dev.off()
