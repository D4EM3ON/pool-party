# Extra PAVA functions

R and Python functions implementing PAVA (or close variants) that are **not** already in the [README](README.md) table. Found on 2026-10-10 through GitHub code search on the `cran/`, `bioc/` and `r-forge/` mirrors, r-universe, PyPI sdists, and reading the actual source.

- `:::` = internal (not exported). "nested" = closure defined inside another function (not callable directly).
- Dates are first → last release of the package, not of the function.
- Links to `github.com/cran/...` point to the latest CRAN version (read-only mirror).

*These were all found via Claude agents, and are results to be checked*

**Complexities** are *theoretical*, derived by one agent per function reading its source on 2026-10-11 (not measured). $N$ = input length; Space = auxiliary memory. They include hidden costs (sorting the input, R vector copies, rescans). Most $N^2$ worst cases are hit by a "cliff" (increasing run, then one very low last value) or a strictly decreasing input. Rows that share code with another row (e.g. `gof`/targeted, `ReAD`/STAREG, `lmap`/fmds, `homals`/aspect, `icrf`/`iwtp`/glrt) were not analysed separately.

## R — own implementations of plain PAVA

| Lang | Code | Function | Weights | Time (worst) | Time (best) | Space | Status | Source | Notes |
| --- | --- | --- | :-: | :-: | :-: | :-: | --- | --- | --- |
| R | C | `timereg::pava()`, `timereg::pava.pred()` (C `pava`/`wpava`/`upava`) | yes | $N^2$ | $N$ | $1$ | CRAN, 2008–2025 | [src/pava.c](https://github.com/cran/timereg/blob/HEAD/src/pava.c) | By Bahjat Qaqish. Multi-pass, pools maximal non-increasing runs; unweighted fast path |
| R | C++ | `icenReg` `weighted_pava`, `pava`, `pavaForOptim` (internal, `.Call`) | yes | $N^2$ | $N$ | $1$ | CRAN, 2015–2024 | [src/icenReg_files/myPAVAalgorithm.cpp](https://github.com/cran/icenReg/blob/HEAD/src/icenReg_files/myPAVAalgorithm.cpp) | Near-copy of the timereg/Qaqish code |
| R | C++ | `targeted::pava()`, `targeted:::isoregw` (C++ `target::pava`) | yes | $N^2$ | $N$ | $N$ | CRAN, 2020–2026 | [src/target/src/pava.cpp](https://github.com/cran/targeted/blob/HEAD/src/target/src/pava.cpp) | By K. Holst. Returns jump indices + values |
| R | C++ | `gof` `target::pava` (internal) | yes | $N^2$ | $N$ | $N$ | CRAN archived 2020 (2009–2020) | [src/pava.cpp](https://github.com/cran/gof/blob/HEAD/src/pava.cpp) | Older copy of the targeted code |
| R | C++ | `STAREG` `my_pava(values, weight, decreasing)` (internal) | yes | $N$ | $N$ | $N$ | CRAN, 2023–2025 | [src/em_lfdr.cpp L222](https://github.com/cran/STAREG/blob/HEAD/src/em_lfdr.cpp#L222) | Stack-based, single pass |
| R | C++ | `ReAD` `my_pava` (internal) | yes | $N$ | $N$ | $N$ | CRAN, 2023 | [src/em_hmm.cpp L267](https://github.com/cran/ReAD/blob/HEAD/src/em_hmm.cpp#L267) | Same code as STAREG |
| R | C++ | `sffdr::monoSmooth_pava()` | no | $N$ | $N$ | $N$ | CRAN, 2024–2026 | [src/monoSmooth.cpp](https://github.com/cran/sffdr/blob/HEAD/src/monoSmooth.cpp) | Grouped by stratum, decreasing, stack-based |
| R | C++ | `sirt::monoreg.rowwise()`, `sirt::monoreg.colwise()` | yes | $N$ per row | $N$ per row | $N$ | CRAN, 2013–2025 | [src/sirt_rcpp_monoreg.cpp](https://github.com/cran/sirt/blob/HEAD/src/sirt_rcpp_monoreg.cpp) | Port of fdrtool's isomean |
| R | C++ | `CORElearn` `Calibrate::isoRegCal` (via `calibrate(method = "isoReg")`) | yes | $N^2$ (quicksort; expected $N \log N$) | $N \log N$ | $N$ | CRAN archived 2026 (2009–2024) | [src/calibrate.cpp L45](https://github.com/cran/CORElearn/blob/HEAD/src/calibrate.cpp#L45) | Port of Dümbgen's code (same algorithm as `logcondens::isoMean`) |
| R | C++ | `orQA` `Rcpp_isomean` (behind `misoreg`) | yes | $N$ | $N$ | $N$ | CRAN archived 2022 (2010) | [src/orQA.cpp](https://github.com/cran/orQA/blob/HEAD/src/orQA.cpp) | Dümbgen isoMean port, row-wise |
| R | C | `fmds` `monotone(n, x, w)` (internal) | yes | $N$ | $N$ | $N$ | CRAN, 2025 | [src/flib.c L5582](https://github.com/cran/fmds/blob/HEAD/src/flib.c#L5582) | By F. Busing, his O(n) algorithm. Variant of `monotone::monotone` |
| R | C | `lmap` `monotone` (internal) | yes | $N$ | $N$ | $N$ | CRAN, 2022–2025 | [src/flib.c L5255](https://github.com/cran/lmap/blob/HEAD/src/flib.c#L5255) | Same Busing code as fmds |
| R | Fortran | `PMCMRplus` `pava` (used by `williamsTest`, `chackoTest`, `frdHouseTest`) | yes | $N^2$ | $N$ | $N$ | CRAN, 2018–2024 | [src/pava.f](https://github.com/cran/PMCMRplus/blob/HEAD/src/pava.f) | Ratfor modification of AS 206 (copy of Iso's). O(n²) relabelling |
| R | R | `bmd:::.pava` | yes | $N^2$ | $N$ | $N$ | CRAN archived; [GitHub](https://github.com/DoseResponse/bmd) | [R/pava.R](https://github.com/DoseResponse/bmd/blob/HEAD/R/pava.R) | Line-by-line R port of the Ratfor `pava.f` |
| R | Fortran / R | `Gifi` `AMALGM`, `Gifi:::amalgm1`, `Gifi:::isotone` | yes | $N^2$ | $N$ (AMALGM) | $N$ | CRAN, 2018–2025 | [src/pava.f](https://github.com/cran/Gifi/blob/HEAD/src/pava.f), [R/coneRegression.R](https://github.com/cran/Gifi/blob/HEAD/R/coneRegression.R) | AS 149 (Kruskal up-and-down blocks) — the original `amalgm()` |
| R | Fortran | `vegan` `MONREG` (inside `monoMDS`) | ties only | $N$ | $N$ | $N$ | CRAN, 2001–2026 | [src/monoMDS.f L775](https://github.com/cran/vegan/blob/HEAD/src/monoMDS.f#L775) | Kruskal up-and-down blocks, by P. Minchin |
| R | Fortran | `timsac` `POOLAV` | no | $N^2$ | $N$ | $N$ | CRAN, 2007–2026 | [src/bayseaf.f L1762](https://github.com/cran/timsac/blob/HEAD/src/bayseaf.f#L1762) | Akaike's BAYSEA, repeated passes |
| R | C | `mcmc` PAVA inlined in `initseq` | counts | $N$ | $N$ | $N$ | CRAN, 2005–2023 | [src/initseq.c L66](https://github.com/cran/mcmc/blob/HEAD/src/initseq.c#L66) | Convex initial-sequence estimator (PAVA on autocovariance differences) |
| R | R / C | `DDHFm::isotone` (C `isotoneC`) | yes | $N^2$ | $N$ | $N$ | CRAN, 2005–2024 | [src/DDHFm.c L191](https://github.com/cran/DDHFm/blob/HEAD/src/DDHFm.c#L191) | Repeated-pass pooling (Silverman style) |
| R | R | `aspect:::pava(x, w, block = weighted.mean)` | yes | $N^2$ | $N$ | $N$ | CRAN, 2009–2025 | [R/pava.R](https://github.com/cran/aspect/blob/HEAD/R/pava.R) | De Leeuw up/down blocks. Predecessor of `smacof:::pavasmacof` |
| R | R | `homals:::pava` | yes | $N^2$ | $N$ | $N$ | CRAN, 2002–2025 | [R/pava.R](https://github.com/cran/homals/blob/HEAD/R/pava.R) | Same code as aspect |
| R | R | `provenance:::pavasmacof`, `:::monregP/S/T` | yes | $N^2$ | $N$ | $N$ | CRAN, 2015–2025 | [R/indscal.R L355](https://github.com/cran/provenance/blob/HEAD/R/indscal.R#L355) | Copy of `smacof:::pavasmacof` (already in README) |
| R | R | `EbayesThresh::isotone(x, wt, increasing)` | yes | $N^2$ | $N$ | $N$ | CRAN, 2005–2017 | [R/isotone.R](https://github.com/cran/EbayesThresh/blob/HEAD/R/isotone.R) | Parallel PAV steps over local max/min |
| R | R | `fda:::isotone(y)` | no | $N^2$ | $N$ | $N$ | CRAN, 2003–2025 | [R/isotone.R](https://github.com/cran/fda/blob/HEAD/R/isotone.R) | Up/down pooling loop |
| R | R | `exametrika:::pava_up(y, w)` | yes | $N^2$ | $N$ | $N$ | CRAN, 2024–2026 | [R/00_isotonic_CORE.R L14](https://github.com/cran/exametrika/blob/HEAD/R/00_isotonic_CORE.R#L14) | Backtracking pairwise, returns number of blocks |
| R | R | `np:::.np_condist_weighted_pava` | yes | $N^2$ | $N$ | $N$ | CRAN, 2006–2026 | [R/np.condistribution.proper.R L111](https://github.com/cran/np/blob/HEAD/R/np.condistribution.proper.R#L111) | Recent addition, backtracking block merge, tolerance |
| R | R | `propensity:::pava_weighted(x, y, w)` | yes | $N^2$ | $N \log N$ | $N$ | CRAN, 2026 | [R/ps_calibration.R L12](https://github.com/cran/propensity/blob/HEAD/R/ps_calibration.R#L12) | No tie grouping (unlike isoreg) |
| R | R | `serosv::pava(pos, tot)` | yes (counts) | $N^3$ | $N$ | $N$ | CRAN, 2024–2026 | [R/utils.R L36](https://github.com/cran/serosv/blob/HEAD/R/utils.R#L36) | Ad hoc backward pooling, recomputes pooled means from raw data. Agent re-implemented it and found it matched weighted PAVA on 23,000 random cases |
| R | R | `MultBiplotR::MonotoneRegression` | yes | $N^3$ | $N \log N$ | $N$ | CRAN, 2021–2025 | [R/MonotoneRegression.R](https://github.com/cran/MultBiplotR/blob/HEAD/R/MonotoneRegression.R) | Port of MATLAB `lsqisotonic`. Own code (does not call `stats::isoreg`). Each pass is $B^2$ because of `idx == i` scans |
| R | R | `glrt::PMGA(est, ww)` | yes | $N^2$ | $N$ | $N$ | CRAN archived 2022 (2010–2015) | [R/PMGA.R](https://github.com/cran/glrt/blob/HEAD/R/PMGA.R) | "Pool monotone groups", copy of Bioconductor `Icens::PMGA` |
| R | R | `icrf:::PMGA` | yes | $N^2$ | $N$ | $N$ | CRAN archived 2024 (2020–2022) | [R/Icens.R L128](https://github.com/cran/icrf/blob/HEAD/R/Icens.R#L128) | Icens copy |
| R | R | `iwtp:::PMGA` | yes | $N^2$ | $N$ | $N$ | CRAN archived 2014 (2012) | [R/icmle.R L127](https://github.com/cran/iwtp/blob/HEAD/R/icmle.R#L127) | Icens copy |
| R | R | `gcrma:::PAV` (+ `average.for.PAV`) | yes | $N^2$ | $N$ | $N$ | Bioconductor, active | [R/PAV.R](https://github.com/bioc/gcrma/blob/HEAD/R/PAV.R) | "Modification of Derick's PAV program". Decreasing fit |
| R | C++ / Rust | `isodistrreg` v0.1.0 `pavaCorrect`, `isoCdf_sequential`; v0.6.0 `tonic_regression::algorithm` | v0.1: no / v0.6: yes | v0.6: $N \log N$ (sort); v0.1 `pavaCorrect`: $N$ per row, `isoCdf`: $N^2$ | v0.6: $N$ | $N$ | CRAN, 2021–2026 | [tonic_regression.rs](https://github.com/cran/isodistrreg/blob/HEAD/src/rust/isodistrreg/src/total_order/tonic_regression.rs) | v0.1 `isoCdf` = abridged sequential PAVA (Henzi–Mösching–Dümbgen). v0.6 Rust rewrite |
| R | C++ | `OptimalBinningWoE` `applyIsotonicRegression` (OBN_IR) | yes (bin counts) | $N$ | $N$ | $N$ | CRAN, 2026 | [src/OBN_IR_v5.cpp L643](https://github.com/evandeilton/OptimalBinningWoE/blob/HEAD/src/OBN_IR_v5.cpp#L643) | Stack PAVA on bin rates |
| R | C++ | `simFastBOIN` `pava` | yes | $N^2$ | $N$ | $N$ | CRAN, 2025–2026 | [src/boin_core.h L49](https://github.com/cran/simFastBOIN/blob/HEAD/src/boin_core.h#L49) | Bit-for-bit C++ port of the Harding/BOIN R code below |

### Copies of the Ted Harding (R-help, 2007) `pava`

All R, weighted. Time: worst $N^2$, best $N$; space $N$ (merges the leftmost violating pair of blocks, then rescans the whole array; analysed on `kyotil::pava`, confirmed same algorithm as `escalation`). `simFastBOIN` (above) is the C++ port. `kyotil` credits the R-help post; `escalation` says "copied from BOIN".

| Package | Function | Status | Source |
| ------- | -------- | ------ | ------ |
| kyotil | `kyotil::pava(x, wt)` (exported) | CRAN, 2013–2024 | [R/misc.R L120](https://github.com/cran/kyotil/blob/HEAD/R/misc.R#L120) |
| escalation | `escalation:::pava` | CRAN, 2020–2025 | [R/helpers.R L121](https://github.com/cran/escalation/blob/HEAD/R/helpers.R#L121) |
| TEQR | `TEQR:::pava` | CRAN, 2010–2016 | [R/TEQR.R L27](https://github.com/cran/TEQR/blob/HEAD/R/TEQR.R#L27) |
| UnifiedDoseFinding | `:::pava_binary`, `:::pava_continuous` + nested | CRAN, 2020–2022 | [cran/UnifiedDoseFinding](https://github.com/cran/UnifiedDoseFinding) |
| SKBD | `SKBD::pava` | CRAN, 2026 | [cran/SKBD](https://github.com/cran/SKBD) |
| BOIN | nested in `select.mtd`, `next.subtrial`, `get.oc.comb` | CRAN, 2014–2021 | [R/select.mtd.R L79](https://github.com/cran/BOIN/blob/HEAD/R/select.mtd.R#L79) |
| Keyboard | nested in `select.mtd.kb`, `select.obd.kb` | CRAN, 2020–2022 | [cran/Keyboard](https://github.com/cran/Keyboard) |
| bfboinet | nested in `select_mtd` | CRAN, 2024–2026 | [cran/bfboinet](https://github.com/cran/bfboinet) |
| CFO | nested in `CFO.selectmtd`, `CFO2d` | CRAN, 2024 | [cran/CFO](https://github.com/cran/CFO) |
| HybridDesign | nested | CRAN, 2022 | [cran/HybridDesign](https://github.com/cran/HybridDesign) |
| PoPdesign | nested | CRAN, 2021–2024 | [cran/PoPdesign](https://github.com/cran/PoPdesign) |
| TITEgBOIN | nested | CRAN, 2023–2025 | [cran/TITEgBOIN](https://github.com/cran/TITEgBOIN) |
| FIND | nested in `select_mtd` | CRAN | [cran/FIND](https://github.com/cran/FIND) |
| GitHub only | haoluns/ModelAssistedPhase12, xiaohanchi/backfilling, ruitaolin/TODO, qingxiaa/titegboin | — | — |

### GitHub-only / paper supplements (R)

| Lang | Code | Repo | Function | Weights | Time (worst) | Time (best) | Space | Notes |
| --- | --- | --- | --- | :-: | :-: | :-: | :-: | --- |
| R | R | [AlexanderHenzi/abridgedPava](https://github.com/AlexanderHenzi/abridgedPava) | `PAVA`, `PAVA2`, `isoCdf` (`isoCDF.R`) | yes | `PAVA`: $N$; `isoCdf`: $N^2$ | `PAVA`: $N$ | $N$ | Code for the "Accelerating the PAVA" paper. Antitonic |
| R | R / C++ | [Kristof-K/PAVA-Comparison](https://github.com/Kristof-K/PAVA-Comparison) | own R + `pava_mean.cpp` | ? | $N \log N$ (sort; PAVA core $N$) | $N \log N$ | $N$ | Benchmark repo (2023) — useful to compare with ours |
| R | R | [open-AIMS/toxstats](https://github.com/open-AIMS/toxstats) | internal `pava`, `smooth_monotone` (`R/smooth.R`) | yes | $N$ | $N$ | $N$ | Stack-based |
| R | R | [rootcoder007/rmorie](https://github.com/rootcoder007/rmorie) | `.isotn_pava`, `isotn` (`R/isotn.R`) | yes | | $N^2$ | $N$ | $N$ |
| R | R | [cregouby/TabICL2](https://github.com/cregouby/TabICL2) | `.pava_single`, `isotonic_regression_pava` (`R/quantile_dist.R`) | yes | | $N$ | $N$ | $N$ |
| R | C++ | [Marcosjnez/cm](https://github.com/Marcosjnez/cm) | `int_pava`, `pava` (`src/cm.cpp` L44, L120) | yes | $N^3$ | $N$ (`int_pava`), $N \log N$ (`pava`) | $N$ | Armadillo |
| R | C | [slwu89/RC](https://github.com/slwu89/RC) | `mcsm_pava` → `mcsm_pava_c` | yes | — | — | — | **Not a PAVA**: the C function is an unimplemented stub (checks lengths, returns `NULL`) |
| R | R | [szcf-weiya/MonteCarlo](https://github.com/szcf-weiya/MonteCarlo) | `pooladv` (`Misc/pool-adjacent-violators.R`) | yes | unbounded (no finite iteration bound), $N$ per iteration | $N$ | $N$ | Teaching code. **Not a PAVA**: averages one pair at a time, never pools blocks; may not terminate, weights not accumulated |
| R | R | [janhove/GeneralLinearModel](https://github.com/janhove/GeneralLinearModel) | `pava(x, y)` (`functions/pava.R`) | no | $N \log N$ (sort; PAVA core $N$) | $N \log N$ | $N$ | Teaching code |

## R — PAVA variants and generalisations

| Lang | Code | Function | Weights | Time (worst) | Time (best) | Space | Status | Source | Notes |
| --- | --- | --- | :-: | :-: | :-: | :-: | --- | --- | --- |
| R | R | `OrdMonReg::BoundedIsoMean`, `BoundedAntiMean` | yes | $N^2$ | $N^2$ | $N$ | CRAN, 2009–2026 | [R/BoundedIsoMean.r](https://github.com/cran/OrdMonReg/blob/HEAD/R/BoundedIsoMean.r) | PAVA with lower/upper bounds |
| R | R | `cir::cirPAVA` | yes | $N^2$ | $N$ | $N$ | CRAN, 2008–2025 | [R/cir.R L37](https://github.com/cran/cir/blob/HEAD/R/cir.R#L37) | Centered isotonic regression (modified PAVA). Not `oldPAVA` |
| R | C++ | `HEMDAG::gpav` (`gpav_cpp`) | yes | $N^3 + N E \log N$ ($N^3$ even on a chain) | $N^2$ | $N^2$ | CRAN archived 2025 (2017–2021) | [R/gpav.R](https://github.com/cran/HEMDAG/blob/HEAD/R/gpav.R) | Burdakov generalized PAV on a DAG (partial order) |
| R | C / R | `isocir` C `cirPAVA` (behind `CIRE`), R `cirPAVA` nested in `CLM` | no | $N^2$ | $N$ | $N$ | CRAN, 2011–2025 | [src/auxiliary.c L52](https://github.com/cran/isocir/blob/HEAD/src/auxiliary.c#L52) | Circular-order PAVA |
| R | R | `liso:::pavareg`, `liso:::pavaregorig` | ? | $N^2$ | $N$ | $N$ | CRAN archived 2018 (2011) | [R/backfit.R L185](https://github.com/cran/liso/blob/HEAD/R/backfit.R#L185) | Lasso-penalised PAVA. Calls `Iso::pava` (no own PAVA) then a linear soft-threshold pass |
| R | R | `RPEXE.RPEXT::pava_dfr`, `pava_ifr` | implicit (ratio) | $N^2$ | $N$ | $N$ | CRAN, 2017–2020 | [R/pava_dfr.R](https://github.com/cran/RPEXE.RPEXT/blob/HEAD/R/pava_dfr.R) | Pools death / time-at-risk ratios for change-points |
| R | R | LCLRDistReg (GitHub, philipstange) `BimonoReg` | ? | unknown (iterative; $N \log N$ per iteration, $N = nm$) | $N$ | $N$ | GitHub only | — | "Modified PAVA", bimonotone |
| R | ? | Novartis/orthoMTL `nnmaxheap_C` | ? | $N$ | $N$ | $N$ | GitHub only | — | Single-pass right-to-left PAVA (non-increasing, clipped at 0). Plain R (`R/nnmaxheap.R`) despite the `_C` name |

## R — isotonic regression, but not PAVA

| Package | Function | Time (worst) | Time (best) | Space | Notes |
| ------- | -------- | :-: | :-: | :-: | ----- |
| MASS | C `VR_mds_fn` (used by `isoMDS`) | $N^2$ | $N$ | $N$ | Greatest convex minorant / min-slope on cumsums, unweighted, O(n²) |
| MixSemiRob | `MixSemiRob:::MINLOWSET` | $N^2$ | $N$ | $N$ | Minimum lower sets; code says "alternative to PAVA" |
| ed50 / ed50simulation | `preparePava` | $N^3$ | $N^3$ | $N^2$ | Min-max formula (Max Kuhn s-news, 1999), not iterative |
| ORCME | `isotonicmeans` | $N^5$ | $N^5$ | $N^2$ | Min-max formula with GLS covariance; main path uses `Iso::pava` |
| SDBP | `SDBP:::mypava` | $N$ | $N$ | $N$ | Special-purpose max-projection, not PAVA despite the name |
| GeneF | `flexisoreg` | $N^3$ | $N^3$ | $N$ | Dynamic-programming reduced isotonic regression |
| exametrika | `iso_dual_map` (C++) | $N$ × sweeps (≤ 1000 by default) | $N$ | $N$ | Dual / bisection method |
| ICRanks | `PAVACheck` (C++) | — | — | — | Only checks / partial PAVA inside a ranking CI algorithm |
| image.dlib | dlib C++ `isotonic_regression` class | $N$ | $N$ | $N$ | Bundled dlib code (block/stack PAV, appears unweighted). Archived 2024 |

## Python — own implementations (not sklearn / scipy)

| Lang | Code | Function | Weights | Time (worst) | Time (best) | Space | Bounds / extras | Status | Source | Notes |
| --- | --- | --- | :-: | :-: | :-: | :-: | --- | --- | --- | --- |
| Python | Python | `model_diagnostics._utils.isotonic.pava`, `gpava`, `isotonic_regression` | yes | `pava`: $N$; `gpava` (quantile): $N^2$ | $N$ | $N$ | increasing flag; mean/quantile/expectile | 2022–2026 | [isotonic.py](https://github.com/lorentzenchr/model-diagnostics/blob/main/src/model_diagnostics/_utils/isotonic.py) | Docstring says Busing (2022) O(n) PAVA |
| Python | numba | `jaxopt.isotonic.isotonic_l2_pav` | no | $N$ | $N$ | $N$ | `y_min`/`y_max` (clipped after PAV); increasing flag | maintenance (0.8.5) | [isotonic.py](https://github.com/google/jaxopt/blob/main/jaxopt/_src/isotonic.py) | Called via `jax.pure_callback`, custom JVP. Not in optax |
| Python | numba | `fast_soft_sort.third_party.isotonic.isotonic_l2`, `isotonic_kl` | KL only | $N$ | $N$ | $N$ | decreasing only | archived, not on PyPI | [isotonic.py](https://github.com/google-research/fast-soft-sort/blob/master/fast_soft_sort/third_party/isotonic.py) | Google Research |
| Python | C++ / CUDA | `torchsort` `isotonic_l2`, `isotonic_kl` | KL only | $N$ | $N$ | $N$ | — | 2021–2025 | [isotonic_cpu.cpp](https://github.com/teddykoker/torchsort/blob/main/torchsort/isotonic_cpu.cpp) | |
| Python | Scala | `pyspark.ml.regression.IsotonicRegression`, `pyspark.mllib.regression.IsotonicRegression` | yes | $N$ (PAV core); $N \log N$ with the sorts | $N$ | $N$ | `isotonic` flag | active | [IsotonicRegression.scala](https://github.com/apache/spark/blob/master/mllib/src/main/scala/org/apache/spark/mllib/regression/IsotonicRegression.scala) | `poolAdjacentViolators` per partition, then again on merged result. Also used by R `sparklyr` / `SparkR` |
| Python | Java | `h2o.estimators.isotonicregression.H2OIsotonicRegressionEstimator` | yes | $N$ (PAV core); $N \log N$ with the sort | $N$ | $N$ | `out_of_bounds` | 2018–2026 | [hex/isotonic](https://github.com/h2oai/h2o-3/tree/master/h2o-algos/src/main/java/hex/isotonic) | Single-pass PAVA with backtracking, per chunk then global; pre-sort by (x, y) |
| Python | Rust | `isodistrreg.isotonic_regression`, `IsotonicDistributionalRegressor` | yes | $N$; $N \log N$ with covariate `X` (sort) | $N$ | $N$ | decreasing; partial orders | 2026 | [AlexanderHenzi/isodistrreg](https://github.com/AlexanderHenzi/isodistrreg) | PAVA for total orders; ADMM/Hildreth for partial orders |
| Python | Rust | `polars_statistics.Isotonic` | ? | $N^2$ | $N$ | $N$ | increasing; clip | 2025–2026 | [DataZooDE/polars-statistics](https://github.com/DataZooDE/polars-statistics) | Crate `anofox-regression`: multi-pass pairwise pooling (not stack-based), plus a sort on x |
| Python | Python | `pwlfit.isotonic.isotonic_regression` → `_pool_adjacent_violators` | yes | $N$ | $N$ | $N$ | increasing flag | GitHub only | [isotonic.py](https://github.com/google/pwlfit/blob/master/pwlfit/isotonic.py) | google/pwlfit (not the PyPI `pwlfit`) |
| Python | Python | `calibre._core.weighted_pava` (+ `RelaxedPAVACalibrator`, `nearly_isotonic_path`) | yes | $N$ | $N$ | $N$ | relaxed: min increment | 2025–2026 | [_core.py](https://github.com/finite-sample/calibre/blob/main/calibre/_core.py) | `calibre.IsotonicCalibrator` itself wraps sklearn |
| Python | Python | `MOBPY.core.pava.PAVA` | implicit | $N^2$ | $N \log N$ | $N$ | sign +/−/auto | 2023–2026 | [pava.py](https://github.com/ChenTaHung/Monotonic-Optimal-Binning/blob/main/src/MOBPY/core/pava.py) | Monotone optimal binning |
| Python | numba | `online_cp.venn._pava_inplace(y, w)` | yes | $N$ | $N$ | $N$ | — | 2024–2026 | [venn.py](https://github.com/egonmedhatten/online-cp/blob/main/src/online_cp/venn.py) | |
| Python | Python | `remeta.util._pav_isotonic(y, w=None)` | yes | $N$ | $N$ | $N$ | — | 2022–2026 | `remeta/util.py:415` (PyPI) | Stack-based single pass |
| Python | numpy | `bayesian_bm25.calibration.IsotonicCalibrator` | ? | $N^2$ | $N \log N$ | $N$ | — | 2026 | [calibration.py](https://github.com/cognica-io/bayesian-bm25/blob/main/bayesian_bm25/calibration.py) | |
| Python | Python | `netcal.binning.NearIsotonicRegression`, `ENIR` | no | $N^2$ (path); $N^3$ (`ENIR.fit`) | $N \log N$ | $N^2$ | — | 2019–2026 | [NearIsotonicRegression.py](https://github.com/EFS-OpenSource/calibration-framework/blob/main/netcal/binning/NearIsotonicRegression.py) | Modified PAVA (near-isotonic). `netcal`'s `IsotonicRegression` wraps sklearn |
| Python | Python | `sidekit.bosaris.detplot.pavx(y)` | no | $N$ | $N$ | $N$ | — | dead (2021) | `sidekit/bosaris/detplot.py:289` | Port of BOSARIS Matlab |
| Python | Python | `hyperion.metrics.utils.pavx(y)` | no | $N$ | $N$ | $N$ | — | dead (2019), GitHub only | [utils.py](https://github.com/jsalt2019-diadet/hyperion/blob/master/hyperion/metrics/utils.py) | BOSARIS port |
| Python | Cython | `torchsparseattn._isotonic._inplace_contiguous_isotonic_regression` | yes | $N$ | $N$ | $N$ | — | dead (2019) | [_isotonic.pyx](https://github.com/vene/sparse-structured-attention/blob/master/pytorch/torchsparseattn/_isotonic.pyx) | Vendored copy of sklearn's `_isotonic.pyx` |

### Python — same result, different algorithm

- `venn_abers.calc_p0p1` ([ip200/venn-abers](https://github.com/ip200/venn-abers)): greatest convex minorant of the cumulative sum diagram (Barlow 1972), not a pooling loop. Vendored by MAPIE in `mapie/_venn_abers.py`. Time: worst $N^2$ (repeated min/max-slope scans), best $N \log N$; space $N$.

## Other languages (GitHub only)

- [schulzch/pava](https://github.com/schulzch/pava) — Rust (2019)
- [maxdan94/pava](https://github.com/maxdan94/pava) — C
- [dschrempf/pava](https://github.com/dschrempf/pava) — Haskell

## Wrappers only (no own PAVA — excluded)

- **`Iso::pava` / `Iso::ufit` / `Iso::biviso`**: dacc, gren, hisemi, imp4p, isoph, aisoph, isoSurv, MinEDfind, NMTox, ORCME, orderedLasso, pi0, IsoGene, IsoGeneGUI (Bioc), GRridge (Bioc), survML, admix, titeIR, GSSE, isoboost, drcHelper, mISO, boinet, LCLRDistReg; BOIN / Keyboard / escalation combination designs
- **`isotone::gpava` / `activeSet`**: twostageTE, CLME, L2E, comparison, lmtp, rankrate, gpmap, RDS, grpSLOPE, tsk
- **`stats::isoreg`**: probably, probcal, cobs, csci, mob, monobin, varbin, qeML, reliabilitydiag, statip, bgms, CAGEfightR, htSeqTools, ecodist, stcov, rtemis, RFGeneRank (Bioc), IV_dist, TLPR, SBC, ftnonpar
- **`fdrtool::monoreg`**: ggisotonic
- **`cir`**: upndown
- **Spark MLlib**: sparklyr, SparkR
- **sklearn / scipy (Python)**: arviz-stats, statsmodels (local FDR), lir, PYLLR, mapie, pycalib, uncertainty-toolbox, skpro, netcal `IsotonicRegression`, calibre `IsotonicCalibrator`

## Checked, nothing found

- **R**: Rfast, Rfast2, MonoPoly, scar, bnpmr, coneproj, ic.infer, stepR, kernlab, pROC, calibrate, logconcens, logcondens.mode, OrdFacReg, DTDA, binGroup, asbio, npsp, restriktor, cgam, rms, ordinal, Rfit, interval, MLEcens, LogConcDEAD, logcondiscr, monreg (kernel method), bisoreg (Bayesian), scam, isotonic.pen, dfcrm, bcrm, pocrm, crmPack, trialr, DoseFinding, ordcrm, dfpk, MTDrh, icensmis, ICsurv, intcensROC, ICE, icRSF, CalibratR, classifierplots, locfdr, twilight, qvalue, limma, McMiso, meta.shrinkage
- **Python**: tensorflow-lattice (Dykstra projections), pygam (penalties), LightGBM / XGBoost / CatBoost (split constraints), cvxpy (generic QP), stucchio/isotonic (LP), cuML, betacal, ml-insights, crepes, river, calibra, optax
- **Not checked**: pymc, pyts, tslearn, skglm, celer, modAL, fairlearn, pymoo; SLOPE

## Caveats

- GitHub code search caps results at 100 hits per query, so archived and GitHub-only packages may be missing.
- Complexities are from reading the code, not from benchmarks; confirm the interesting ones with `atime` as in the README.
- `LCLRDistReg::BimonoReg` (medium confidence) and `exametrika` `iso_dual_map` (medium) are iterative solvers without a clean bound.
- `CORElearn`'s $N^2$ worst case comes only from its quicksort; the PAVA part is $N$.
- `vegan` `MONREG` can reach $N^2$ only with primary tie treatment on a large tied group (Shell sort in `ASORT4`).
