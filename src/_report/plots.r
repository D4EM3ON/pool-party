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

complexity_packages <- c("monotone", "stats", "quadprog")
aref_list <- lapply(complexity_packages, function(package_name) {
  ares <- readRDS(glue("src/{package_name}/data/figure-data.rds"))
  meas <- ares$measurements[PKG == package_name & !is.na(median)]
  common_n <- meas[, max(N), by = DATA][, min(V1)]
  worst <- meas[N == common_n][which.max(median), DATA]
  ares$measurements <- meas[DATA == worst][
    , expr.name := glue("{package_name}\n{worst}")
  ]
  if (package_name != "monotone") return(make_references(ares))
  aref <- make_references(ares, fun_exclude = "N^3")
  aref$plot.references <- rbind(
    aref$plot.references[unit != "seconds"],
    aref$references[unit == "seconds"]
  )
  aref
})
aref <- aref_list[[1]]
for (name in c("measurements", "references", "plot.references")) {
  aref[[name]] <- rbindlist(lapply(aref_list, `[[`, name), fill = TRUE)
  aref[[name]][, expr.name := factor(expr.name, unique(expr.name))]
}
png(
  glue("{figure_path}/figure-complexity-worst-ref.png"),
  width = 8,
  height = 5,
  units = "in",
  res = 200
)
print(plot(aref))
dev.off()
