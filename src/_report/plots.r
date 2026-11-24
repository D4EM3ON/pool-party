source("src/_common/plots.r")

package_names <- "_report"
figure_path <- glue("src/{package_names}/figures")

# Show exponents as superscripts (N², N³) in the reference labels.
superscript_refs <- function(aref) {
  for (name in c("measurements", "references", "plot.references")) {
    aref[[name]][, fun.name := chartr("23", "²³", gsub("^", "", fun.name, fixed = TRUE))]
  }
  aref
}

# text size in points (ggplot2 default is 11)
text_size <- 13

# one color per function, shared by every figure
function_colors <- c(
  "monotone::monotone()" = "#0072B2",
  "stats::isoreg()" = "#009E73",
  "Iso::pava()" = "#D55E00",
  "quadprog::solve.QP()" = "#E69F00"
)
function_scales <- list(
  scale_color_manual("Function", values = function_colors),
  scale_fill_manual("Function", values = function_colors)
)

up_down_packages <- c(
  iso = "Iso::pava()",
  stats = "stats::isoreg()",
  monotone = "monotone::monotone()"
)
aref_list <- lapply(names(up_down_packages), function(package_name) {
  ares <- readRDS(glue("src/{package_name}/data/figure-data.rds"))
  ares$measurements <- ares$measurements[
    PKG == package_name & DATA %in% c("up", "down")
  ]
  aref <- make_references(ares, fun_exclude = c("N^3"))
  for (name in c("measurements", "references")) {
    aref[[name]] <- aref[[name]][
      unit == "seconds"
    ][, Function := up_down_packages[[package_name]]]
  }
  aref
})
aref <- aref_list[[1]]
for (name in c("measurements", "references")) {
  aref[[name]] <- rbindlist(lapply(aref_list, `[[`, name), fill = TRUE)
  aref[[name]][, Function := factor(Function, up_down_packages)]
}
# one N and one N² reference per dataset: N from the fastest function
# (largest N reached), N² from the slowest (smallest N reached)
max_n <- aref$measurements[, .(max_n = max(N)), by = .(DATA, Function)]
ref_funs <- rbind(
  max_n[, .(Function = Function[which.max(max_n)], fun.name = "N"), by = DATA],
  max_n[, .(Function = Function[which.min(max_n)], fun.name = "N^2"), by = DATA]
)
aref$plot.references <- aref$references[
  ref_funs,
  on = .(DATA, Function, fun.name)
]
aref <- superscript_refs(aref)
png(
  glue("{figure_path}/figure-up-down-ref.png"),
  width = 8,
  height = 4,
  units = "in",
  res = 200
)
print(
  ggplot() +
    facet_grid(unit ~ DATA, scales = "free") +
    theme_bw(base_size = text_size) +
    theme(legend.position = "bottom") +
    geom_hline(
      aes(yintercept = seconds.limit),
      color = "grey",
      data = data.frame(seconds.limit = aref$seconds.limit, unit = "seconds")
    ) +
    geom_ribbon(
      aes(N, ymin = min, ymax = max, fill = Function),
      alpha = 0.3,
      data = aref$measurements
    ) +
    geom_line(
      aes(N, empirical, color = Function),
      linewidth = 2,
      data = aref$measurements
    ) +
    geom_line(
      aes(N, reference, group = Function),
      color = "violet",
      linewidth = 1,
      data = aref$plot.references
    ) +
    directlabels::geom_dl(
      aes(N, reference, label.group = Function, label = fun.name),
      data = aref$plot.references,
      color = "violet",
      method = list(cex = text_size / 11, "bottom.polygons")
    ) +
    function_scales +
    scale_y_log10("") +
    scale_x_log10()
)
dev.off()

# function, space and time complexity reference shown for each package
# (NA: no reference, monotone already shows the N space reference)
complexity_packages <- list(
  monotone = c("monotone::monotone()", kilobytes = "N", seconds = "N"),
  stats = c("stats::isoreg()", kilobytes = NA, seconds = "N^2"),
  quadprog = c("quadprog::solve.QP()", kilobytes = "N^2", seconds = "N^3")
)
complexity_data <- "up"
aref_list <- lapply(names(complexity_packages), function(package_name) {
  ares <- readRDS(glue("src/{package_name}/data/figure-data.rds"))
  ares$measurements <- ares$measurements[
    PKG == package_name & DATA == complexity_data & !is.na(median)
  ]
  aref <- make_references(ares)
  for (name in c("measurements", "references")) {
    aref[[name]][, Function := complexity_packages[[package_name]][1]]
  }
  aref$plot.references <- aref$references[
    fun.name == complexity_packages[[package_name]][unit]
  ]
  aref
})
aref <- aref_list[[1]]
function_names <- sapply(complexity_packages, `[`, 1)
for (name in c("measurements", "references", "plot.references")) {
  aref[[name]] <- rbindlist(lapply(aref_list, `[[`, name), fill = TRUE)
  aref[[name]][, Function := factor(Function, function_names)]
}
aref <- superscript_refs(aref)
png(
  glue("{figure_path}/figure-complexity-worst-ref.png"),
  width = 8,
  height = 4,
  units = "in",
  res = 200
)
print(
  ggplot() +
    theme_bw(base_size = text_size) +
    theme(legend.position = "bottom") +
    facet_wrap(~unit, scales = "free") +
    geom_hline(
      aes(yintercept = seconds.limit),
      color = "grey",
      data = data.frame(seconds.limit = aref$seconds.limit, unit = "seconds")
    ) +
    geom_ribbon(
      aes(N, ymin = min, ymax = max, fill = Function),
      alpha = 0.3,
      data = aref$measurements[unit == "seconds"]
    ) +
    geom_line(
      aes(N, empirical, color = Function),
      linewidth = 2,
      data = aref$measurements
    ) +
    geom_line(
      aes(N, reference, group = Function),
      color = "violet",
      linewidth = 1,
      data = aref$plot.references
    ) +
    directlabels::geom_dl(
      aes(N, reference, label.group = Function, label = fun.name),
      data = aref$plot.references,
      color = "violet",
      method = list(cex = text_size / 11, "bottom.polygons")
    ) +
    function_scales +
    scale_y_log10("") +
    scale_x_log10()
)
dev.off()
