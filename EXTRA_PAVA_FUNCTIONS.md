# Extra PAVA functions

R and Python functions implementing PAVA (or close variants) that are **not** already in the [README](README.md) table. Found on 2026-10-10 through GitHub code search on the `cran/`, `bioc/` and `r-forge/` mirrors, r-universe, PyPI sdists, and reading the actual source.

- `:::` = internal (not exported). "nested" = closure defined inside another function (not callable directly).
- Dates are first → last release of the package, not of the function.
- Links to `github.com/cran/...` point to the latest CRAN version (read-only mirror).

*These were all found via Claude agents, and are results to be checked*

**Complexities** are *theoretical*, derived by one agent per function reading its source on 2026-10-11 (not measured). $N$ = input length; Space = auxiliary memory. They include hidden costs (sorting the input, R vector copies, rescans). Most $N^2$ worst cases are hit by a "cliff" (increasing run, then one very low last value) or a strictly decreasing input. Functions whose code is identical to, a trivial copy of, a wrapper around, or a line-by-line port of an implementation already in the README were removed on 2026-10-11 after a side-by-side source comparison (see the end of the file).

## R — own implementations of plain PAVA

| Lang | Code | Function | Weights | Time (worst) | Time (best) | Space | Status | Source | Notes |
| --- | --- | --- | :-: | :-: | :-: | :-: | --- | --- | --- |
| R | C++ | `icenReg` `weighted_pava`, `pava`, `pavaForOptim` (internal, `.Call`) | yes | $N^2$ | $N$ | $1$ | CRAN, 2015–2024 | [src/icenReg_files/myPAVAalgorithm.cpp](https://github.com/cran/icenReg/blob/HEAD/src/icenReg_files/myPAVAalgorithm.cpp) | Near-copy of the timereg/Qaqish code |
| R | C++ | `targeted::pava()`, `targeted:::isoregw` (C++ `target::pava`) | yes | $N^2$ | $N$ | $N$ | CRAN, 2020–2026 | [src/target/src/pava.cpp](https://github.com/cran/targeted/blob/HEAD/src/target/src/pava.cpp) | By K. Holst. Returns jump indices + values |
| R | C++ | `gof` `target::pava` (internal) | yes | $N^2$ | $N$ | $N$ | CRAN archived 2020 (2009–2020) | [src/pava.cpp](https://github.com/cran/gof/blob/HEAD/src/pava.cpp) | Older copy of the targeted code |
| R | C++ | `sffdr::monoSmooth_pava()` | no | $N$ | $N$ | $N$ | CRAN, 2024–2026 | [src/monoSmooth.cpp](https://github.com/cran/sffdr/blob/HEAD/src/monoSmooth.cpp) | Grouped by stratum, decreasing, stack-based |
| R | Fortran | `vegan` `MONREG` (inside `monoMDS`) | ties only | $N$ | $N$ | $N$ | CRAN, 2001–2026 | [src/monoMDS.f L775](https://github.com/cran/vegan/blob/HEAD/src/monoMDS.f#L775) | Kruskal up-and-down blocks, by P. Minchin |
| R | Fortran | `timsac` `POOLAV` | no | $N^2$ | $N$ | $N$ | CRAN, 2007–2026 | [src/bayseaf.f L1762](https://github.com/cran/timsac/blob/HEAD/src/bayseaf.f#L1762) | Akaike's BAYSEA, repeated passes |
| R | C | `mcmc` PAVA inlined in `initseq` | counts | $N$ | $N$ | $N$ | CRAN, 2005–2023 | [src/initseq.c L66](https://github.com/cran/mcmc/blob/HEAD/src/initseq.c#L66) | Convex initial-sequence estimator (PAVA on autocovariance differences) |
| R | R / C | `DDHFm::isotone` (C `isotoneC`) | yes | $N^2$ | $N$ | $N$ | CRAN, 2005–2024 | [src/DDHFm.c L191](https://github.com/cran/DDHFm/blob/HEAD/src/DDHFm.c#L191) | Repeated-pass pooling (Silverman style) |
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
| R | C++ / Rust | `isodistrreg` v0.6.0 `tonic_regression::algorithm`; v0.1.0 `isoCdf_sequential` | yes | v0.6: $N \log N$ (sort); v0.1 `isoCdf`: $N^2$ | v0.6: $N$ | $N$ | CRAN, 2021–2026 | [tonic_regression.rs](https://github.com/cran/isodistrreg/blob/HEAD/src/rust/isodistrreg/src/total_order/tonic_regression.rs) | v0.1 `isoCdf` = abridged sequential PAVA (Henzi–Mösching–Dümbgen). v0.6 Rust rewrite. (v0.1 `pavaCorrect` removed: port of `logcondens::isoMean`) |
| R | C++ | `OptimalBinningWoE` `applyIsotonicRegression` (OBN_IR) | yes (bin counts) | $N$ | $N$ | $N$ | CRAN, 2026 | [src/OBN_IR_v5.cpp L643](https://github.com/evandeilton/OptimalBinningWoE/blob/HEAD/src/OBN_IR_v5.cpp#L643) | Stack PAVA on bin rates |

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
| R | R | `RPEXE.RPEXT::pava_dfr`, `pava_ifr` | implicit (ratio) | $N^2$ | $N$ | $N$ | CRAN, 2017–2020 | [R/pava_dfr.R](https://github.com/cran/RPEXE.RPEXT/blob/HEAD/R/pava_dfr.R) | Pools death / time-at-risk ratios for change-points |
| R | R | LCLRDistReg (GitHub, philipstange) `BimonoReg` | ? | unknown (iterative; $N \log N$ per iteration, $N = nm$) | $N$ | $N$ | GitHub only | — | "Modified PAVA", bimonotone |
| R | ? | Novartis/orthoMTL `nnmaxheap_C` | ? | $N$ | $N$ | $N$ | GitHub only | — | Single-pass right-to-left PAVA (non-increasing, clipped at 0). Plain R (`R/nnmaxheap.R`) despite the `_C` name |

## R — isotonic regression, but not PAVA

| Package | Function | Time (worst) | Time (best) | Space | Notes |
| ------- | -------- | :-: | :-: | :-: | ----- |
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

## Removed — same as an implementation already in the README

| Removed | Same as | How |
| ------- | ------- | --- |
| `PMCMRplus` `pava` (Fortran) | `Iso::pava` | identical |
| `torchsparseattn` `_inplace_contiguous_isotonic_regression` | `sklearn` `_isotonic.pyx` | identical |
| `fmds` / `lmap` `monotone` (`flib.c`) | `monotone::monotone` | trivial copy (1-based arrays, `size_t n`) |
| `timereg` `pava`/`wpava`/`upava` | `monotone::legacy()` `linear_pava` | trivial copy (core loop matches; adds unweighted fast path) |
| `ReAD` `my_pava` | `monotone::legacy()` `pooled_pava` | trivial copy (C++/Armadillo, 0-based) |
| `STAREG` `my_pava` (same code as ReAD) | `monotone::legacy()` `pooled_pava` | port C → C++ |
| `sirt::monoreg.rowwise()` / `orQA` `Rcpp_isomean` | `fdrtool::monoreg` (`C_isomean`) | trivial copy (Rcpp glue, loop over rows) |
| `aspect:::pava`, `homals:::pava`, `provenance:::pavasmacof` | `smacof:::pavasmacof` | trivial copy (renamed helpers) |
| `MASS` `VR_mds_fn` monotone step | `stats::isoreg` | trivial copy (same variables; isoreg derived from it) |
| Ted Harding `pava` (`kyotil`, `escalation`, `TEQR`, `UnifiedDoseFinding`, `SKBD`, BOIN family nested copies) | `SAGx::pava` (Raubertas, 1994) | trivial copy (comments and NA check removed) |
| `simFastBOIN` `pava` | `SAGx::pava` (via BOIN) | port R → C++ |
| `bmd:::.pava` | `Iso::pava` | port Fortran → R |
| `Gifi` `AMALGM` (Fortran), `Gifi:::amalgm1` | `monotone::legacy()` `amalgm` | port (AS 149; the Fortran is the original of the C version) |
| `CORElearn` `Calibrate::isoRegCal` | `logcondens::isoMean` | port R → C++ (adds a sort/unify step) |
| `isodistrreg` v0.1 `pavaCorrect` | `logcondens::isoMean` | port R → C++ |
| `sidekit` / `hyperion` `pavx` | `logcondens::isoMean` (Dümbgen `IsoMeans.m`) | port → Python, unweighted |
| `jaxopt` `isotonic_l2_pav`, `torchsort` `isotonic_l2`/`isotonic_kl` | `sklearn` `_isotonic.pyx` | port → numba / C++ |
| `fast_soft_sort` `isotonic_l2`/`isotonic_kl` | `sklearn` `_isotonic.pyx` | trivial copy ("Copied from scikit-learn", numba) |
| `model_diagnostics` `pava` / `gpava` | `monotone::monotone` | port C → Python (`gpava` generalises it to quantiles) |
| `liso:::pavareg` | `Iso::pava` | wrapper |

## Caveats

- GitHub code search caps results at 100 hits per query, so archived and GitHub-only packages may be missing.
- Complexities are from reading the code, not from benchmarks; confirm the interesting ones with `atime` as in the README.
- `LCLRDistReg::BimonoReg` (medium confidence) and `exametrika` `iso_dual_map` (medium) are iterative solvers without a clean bound.
- "Port" removals are a judgement call: a port runs the same algorithm in another language, so its constant factors (and R copy overheads) can differ. The originals are listed in the Removed table if you want to restore any.
- `vegan` `MONREG` can reach $N^2$ only with primary tie treatment on a large tied group (Shell sort in `ASORT4`).
