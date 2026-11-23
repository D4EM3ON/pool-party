source("src/_common/data.r")

package_names <- "_best"
isotonic_functions <- list(
  directlabels = directlabels::isoreg_dp,
  fdrtool = function(x) fdrtool::monoreg(x)$yf,
  intcox = function(x) intcox:::intcox.pavaC(rep(1, length(x)), x),
  logcondens = function(x) logcondens::isoMean(x, rep(1, length(x))),
  monotone_fitm = function(x) monotone::legacy(x, number = 1),
  monotone_inplacepava = function(x) monotone::legacy(x, number = 11),
  monotone_pooledpava = function(x) monotone::legacy(x, number = 9),
  monotone = monotone::monotone,
  orthomtl = function(x) {
    shift <- min(x) - 1
    rev(orthoMTL::nnmaxheap_C(rev(x) - shift)) + shift
  },
  sffdr = function(x) {
    n <- length(x)
    -sffdr::monoSmooth_pava(seq_len(n) / n, -x, rep(1L, n))
  },
  uniisoregression = function(x) {
    UniIsoRegression::reg_1d(x, rep(1, length(x)), metric = 2)
  }
)

make_data(
  package_names,
  isotonic_functions,
  add_n = 1,
  keep_result = FALSE,
  reps = 10
)
