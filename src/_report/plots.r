source("src/_common/plots.r")

package_names <- "_report"
figure_path <- glue("src/{package_names}/figures")

up_down_packages <- c("iso", "stats", "monotone")
for (package_name in up_down_packages) {
  ares <- readRDS(glue("src/{package_name}/data/figure-data.rds"))
  ares$measurements <- ares$measurements[
    PKG == package_name & DATA %in% c("up", "down")
  ][, expr.name := DATA]
  aref <- make_references(ares, fun_exclude = c("N^3"))
  png(
    glue("{figure_path}/figure-{package_name}-up-down-ref.png"),
    width = 6,
    height = 5,
    units = "in",
    res = 200
  )
  print(plot(aref))
  dev.off()
}
