source("src/_common/data.r")

# Shape of each dataset from `_common/data.r`, at a small N
n <- 250
set.seed(1)
datasets <- rbindlist(lapply(names(data_list), function(name) {
  y <- data_list[[name]](n)
  data.table(DATA = name, index = seq_along(y), y = y)
}))
datasets[, DATA := factor(DATA, names(data_list))]

png(
  "src/_validation/figures/datasets.png",
  width = 9,
  height = 5,
  units = "in",
  res = 200
)
print(
  ggplot(datasets, aes(index, y)) +
    geom_line(linewidth = 0.3) +
    geom_point(size = 0.6) +
    facet_wrap(~DATA, scales = "free_y") +
    labs(title = glue("Datasets at N = {n}")) +
    theme_bw()
)
dev.off()
