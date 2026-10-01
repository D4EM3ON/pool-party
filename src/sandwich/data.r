source("src/_common/data.r")

package_names <- "sandwich"

isotonic_functions <- list(
  sandwich = function(x) {
    tryCatch({
      fit <- sandwich::pava.blocks(x)
      rep(fit$x, fit$blocks)
    }, error = function(e) {
      if (!grepl("stack", conditionMessage(e))) stop(e)
      message(glue("sandwich failed at N = {length(x)}: {conditionMessage(e)}"))
      NULL
    })
  }
)

make_data(package_names, isotonic_functions)