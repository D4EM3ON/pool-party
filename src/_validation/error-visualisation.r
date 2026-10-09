# Validate reg_1d_l2: UniIsoRegression (original)
# vs monotone::legacy(number = 13)
# Reference: monotone::monotone(), which matches quadprog in src/_validation

original <- function(x) {
  UniIsoRegression::reg_1d(x, rep(1, length(x)), metric = 2)
}
legacy <- function(x) monotone::legacy(x, number = 13)
correct <- function(x) monotone::monotone(x)

# 1. Small examples, side by side
examples <- list(
  c(8, 4, 8, 2, 2, 0, 8), # example from ?monotone::legacy
  c(3, 1),
  c(1, 3), # already sorted: nothing should be pooled
  c(2, 1, 3, 0)
)
for (x in examples) {
  cat("x       :", x, "\n")
  cat("original:", round(original(x), 3), "\n")
  cat("legacy  :", round(legacy(x), 3), "\n")
  cat("correct :", round(correct(x), 3), "\n\n")
}

# 2. Larger data (same generators as src/_common/data.r)
set.seed(1)
n <- 10000
data_list <- list(
  up_down = c(1:(n / 2), (n / 2):1),
  up = 1:n,
  down = n:1,
  cliff = c(seq_len(n - 1), -n^2),
  zigzag = rep_len(c(1, 0), n),
  normal = rnorm(n)
)
results <- data.frame(
  data = names(data_list),
  original_ok = sapply(
    data_list,
    function(x) isTRUE(all.equal(original(x), correct(x)))
  ),
  legacy_ok = sapply(
    data_list,
    function(x) isTRUE(all.equal(legacy(x), correct(x)))
  )
)
print(results, row.names = FALSE)

# 3. Original's bug: it behaves as if the first element had weight 2
# If this prints TRUE everywhere, the original double-counts x[1]
double_first <- function(x) monotone::monotone(x, c(2, rep(1, length(x) - 1)))
cat("\noriginal == fit with w[1] = 2:\n")
print(
  sapply(
    c(examples, data_list),
    function(x) isTRUE(all.equal(original(x), double_first(x)))
  )
)
