# Extra PAVA functions

R and Python functions implementing PAVA that are **not** already in the [README](README.md) table. Found on 2026-10-10 through GitHub code search on the `cran/`, `bioc/` and `r-forge/` mirrors, r-universe, PyPI sdists, and reading the actual source.

*These were all found via Claude agents, and are results to be checked.* Complexities are *theoretical*, from reading the source (not measured). $N$ = input length. `:::` = internal (not exported).

## R — $O(N)$ PAVA, implemented

| Code | Function | Weights | Status | Source | How to call |
| --- | --- | :-: | --- | --- | --- |
| C++ | `sffdr::monoSmooth_pava()` | no | CRAN, 2024–2026 | [src/monoSmooth.cpp](https://github.com/cran/sffdr/blob/HEAD/src/monoSmooth.cpp) | Non-increasing, by stratum: negate in and out, one group |
| R | [open-AIMS/toxstats](https://github.com/open-AIMS/toxstats) internal `pava` (`R/smooth.R`) | yes | GitHub only | [R/smooth.R](https://github.com/open-AIMS/toxstats/blob/HEAD/R/smooth.R) | Stack-based |
| R | [cregouby/TabICL2](https://github.com/cregouby/TabICL2) `.pava_single` (`R/quantile_dist.R`) | yes | GitHub only | [R/quantile_dist.R](https://github.com/cregouby/TabICL2/blob/HEAD/R/quantile_dist.R) | |
| R | [Novartis/orthoMTL](https://github.com/Novartis/orthoMTL) `nnmaxheap_C` | no | CRAN, 2026 | [R/nnmaxheap.R](https://github.com/Novartis/orthoMTL/blob/HEAD/R/nnmaxheap.R) | Non-increasing, clipped at 0: reverse and shift above 0 |

## R — not chosen

| Function | Time (worst) | Why not chosen |
| --- | :-: | --- |
| `icenReg` `weighted_pava`, `pava`, `pavaForOptim` | $N^2$ | Quadratic. Near-copy of the timereg/Qaqish code |
| `targeted::pava()`, `targeted:::isoregw` | $N^2$ | Quadratic |
| `gof` `target::pava` | $N^2$ | Quadratic. Older copy of `targeted`, archived |
| `timsac` `POOLAV` | $N^2$ | Quadratic (repeated passes) |
| `DDHFm::isotone` (`isotoneC`) | $N^2$ | Quadratic (repeated passes) |
| `EbayesThresh::isotone` | $N^2$ | Quadratic |
| `fda:::isotone` | $N^2$ | Quadratic |
| `exametrika:::pava_up` | $N^2$ | Quadratic |
| `np:::.np_condist_weighted_pava` | $N^2$ | Quadratic |
| `propensity:::pava_weighted` | $N^2$ | Quadratic |
| `serosv::pava` | $N^3$ | Cubic (recomputes pooled means from raw data) |
| `MultBiplotR::MonotoneRegression` | $N^3$ | Cubic |
| `glrt::PMGA`, `icrf:::PMGA`, `iwtp:::PMGA` | $N^2$ | Quadratic. Copies of `Icens::PMGA` |
| `gcrma:::PAV` | $N^2$ | Quadratic |
| `isodistrreg` v0.6 `tonic_regression::algorithm` | $N \log N$ | Sorts the covariate first |
| `isodistrreg` v0.1 `isoCdf_sequential` | $N^2$ | Quadratic |
| `mcmc` PAVA inlined in `initseq` | $N$ | Inlined in the estimator, cannot be called alone |
| `OptimalBinningWoE` `applyIsotonicRegression` (OBN_IR) | $N$ | Private C++ method, only runs on ≤ 20 bins |
| [Kristof-K/PAVA-Comparison](https://github.com/Kristof-K/PAVA-Comparison) `pava_mean.cpp` | $N \log N$ | Sorts first. Benchmark repo, useful to compare with ours |
| [rootcoder007/rmorie](https://github.com/rootcoder007/rmorie) `.isotn_pava` | $N^2$ | Quadratic |
| [Marcosjnez/cm](https://github.com/Marcosjnez/cm) `int_pava`, `pava` | $N^3$ | Cubic |
| [janhove/GeneralLinearModel](https://github.com/janhove/GeneralLinearModel) `pava` | $N \log N$ | Sorts first. Teaching code |
| `MixSemiRob:::MINLOWSET` | $N^2$ | Not PAVA (minimum lower sets), quadratic |
| `ed50` `preparePava` | $N^3$ | Not PAVA (min-max formula), cubic |
| `ORCME` `isotonicmeans` | $N^5$ | Not PAVA (min-max formula), main path uses `Iso::pava` |
| `vegan` `MONREG` (inside `monoMDS`) | $N$ | Too complicated installation: not callable from R (only `monoMDS` is registered), would need copying `MONREG` + `ASORT4` from `src/monoMDS.f` and compiling them with `gfortran` |
| [AlexanderHenzi/abridgedPava](https://github.com/AlexanderHenzi/abridgedPava) `PAVA` | $N$ | Too complicated installation: script only (not a package) and no license, so it would have to be copied into the repo |
| dlib `isotonic_regression` class (bundled in `image.dlib`) | $N$ | Too complicated installation: not exposed by `image.dlib`, needs the dlib headers (`brew install dlib`, or the source on Windows) and compiling with `Rcpp::sourceCpp` |

## Python — own implementations (not sklearn / scipy)

| Code | Function | Weights | Time (worst) | Source | Notes |
| --- | --- | :-: | :-: | --- | --- |
| Scala | `pyspark.ml.regression.IsotonicRegression` | yes | $N \log N$ | [IsotonicRegression.scala](https://github.com/apache/spark/blob/master/mllib/src/main/scala/org/apache/spark/mllib/regression/IsotonicRegression.scala) | PAV core $N$, plus sorts. Also used by `sparklyr` / `SparkR` |
| Java | `h2o` `H2OIsotonicRegressionEstimator` | yes | $N \log N$ | [hex/isotonic](https://github.com/h2oai/h2o-3/tree/master/h2o-algos/src/main/java/hex/isotonic) | PAV core $N$, plus sort |
| Rust | `isodistrreg.isotonic_regression` | yes | $N$ | [AlexanderHenzi/isodistrreg](https://github.com/AlexanderHenzi/isodistrreg) | $N \log N$ with covariate `X` |
| Rust | `polars_statistics.Isotonic` | ? | $N^2$ | [DataZooDE/polars-statistics](https://github.com/DataZooDE/polars-statistics) | Multi-pass pairwise pooling |
| Python | `pwlfit.isotonic.isotonic_regression` | yes | $N$ | [isotonic.py](https://github.com/google/pwlfit/blob/master/pwlfit/isotonic.py) | google/pwlfit, GitHub only |
| Python | `calibre._core.weighted_pava` | yes | $N$ | [_core.py](https://github.com/finite-sample/calibre/blob/main/calibre/_core.py) | |
| Python | `MOBPY.core.pava.PAVA` | implicit | $N^2$ | [pava.py](https://github.com/ChenTaHung/Monotonic-Optimal-Binning/blob/main/src/MOBPY/core/pava.py) | Monotone optimal binning |
| numba | `online_cp.venn._pava_inplace` | yes | $N$ | [venn.py](https://github.com/egonmedhatten/online-cp/blob/main/src/online_cp/venn.py) | |
| Python | `remeta.util._pav_isotonic` | yes | $N$ | `remeta/util.py:415` (PyPI) | Stack-based |
| numpy | `bayesian_bm25.calibration.IsotonicCalibrator` | ? | $N^2$ | [calibration.py](https://github.com/cognica-io/bayesian-bm25/blob/main/bayesian_bm25/calibration.py) | |
| Python | `netcal.binning.NearIsotonicRegression`, `ENIR` | no | $N^3$ | [NearIsotonicRegression.py](https://github.com/EFS-OpenSource/calibration-framework/blob/main/netcal/binning/NearIsotonicRegression.py) | Near-isotonic (modified PAVA) |
| Python | `venn_abers.calc_p0p1` | ? | $N^2$ | [ip200/venn-abers](https://github.com/ip200/venn-abers) | Not PAVA (greatest convex minorant). Vendored by MAPIE |

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
| `fmds` / `lmap` `monotone` (`flib.c`) | `monotone::monotone` | trivial copy |
| `timereg` `pava`/`wpava`/`upava` | `monotone::legacy()` `linear_pava` | trivial copy |
| `ReAD` `my_pava`, `STAREG` `my_pava` | `monotone::legacy()` `pooled_pava` | trivial copy / port C → C++ |
| `sirt::monoreg.rowwise()` / `orQA` `Rcpp_isomean` | `fdrtool::monoreg` (`C_isomean`) | trivial copy |
| `aspect:::pava`, `homals:::pava`, `provenance:::pavasmacof` | `smacof:::pavasmacof` | trivial copy |
| `MASS` `VR_mds_fn` monotone step | `stats::isoreg` | trivial copy |
| Ted Harding `pava` (`kyotil`, `escalation`, `TEQR`, `UnifiedDoseFinding`, `SKBD`, BOIN family) | `SAGx::pava` | trivial copy |
| `simFastBOIN` `pava` | `SAGx::pava` | port R → C++ |
| `bmd:::.pava`, `liso:::pavareg` | `Iso::pava` | port Fortran → R / wrapper |
| `Gifi` `AMALGM`, `Gifi:::amalgm1` | `monotone::legacy()` `amalgm` | port |
| `CORElearn` `Calibrate::isoRegCal`, `isodistrreg` v0.1 `pavaCorrect`, `sidekit` / `hyperion` `pavx` | `logcondens::isoMean` | port |
| `jaxopt` `isotonic_l2_pav`, `torchsort`, `fast_soft_sort` | `sklearn` `_isotonic.pyx` | port / trivial copy |
| `model_diagnostics` `pava` / `gpava` | `monotone::monotone` | port C → Python |
