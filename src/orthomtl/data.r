source("src/_common/data.r")

package_names <- "orthomtl"
isotonic_functions <- list(
  orthomtl = function(x) {
    shift <- min(x) - 1
    rev(orthoMTL::nnmaxheap_C(rev(x) - shift)) + shift
  }
)
make_data(package_names, isotonic_functions)
