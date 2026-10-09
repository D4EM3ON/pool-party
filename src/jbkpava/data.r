source("src/_common/data.r")
source("src/jbkpava/src/jbkpava.r")

package_names <- "jbkpava"

isotonic_functions <- list(
  jbkpava = jbkpava,
  jbk_legacy = function(x) monotone::legacy(x, number = 14)
)

make_data(package_names, isotonic_functions)
