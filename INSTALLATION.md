## How I installed some archived packages

### R (archived)

#### `SAGx`
```r
install.packages("BiocManager")
BiocManager::install(c("Biobase", "multtest"))
install.packages(
  "https://bioconductor.statistik.tu-dortmund.de/packages/3.12/bioc/src/contrib/SAGx_1.64.0.tar.gz",
  repos = NULL, type = "source"
)
```

#### `intcox`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/intcox/intcox_0.9.3.tar.gz",
  repos = NULL, type = "source"
)
```

#### `spsurvey`
```r
tmp <- tempfile(); dir.create(tmp)
tgz <- file.path(tmp, "spsurvey_4.1.4.tar.gz")
download.file(
  "https://cran.r-project.org/src/contrib/Archive/spsurvey/spsurvey_4.1.4.tar.gz",
  tgz
)
untar(tgz, exdir = tmp)
pkg <- file.path(tmp, "spsurvey")
desc <- file.path(pkg, "DESCRIPTION")
writeLines(sub("rgeos, ", "", readLines(desc)), desc)
ns <- file.path(pkg, "NAMESPACE")
writeLines(grep("rgeos", readLines(ns), value = TRUE, invert = TRUE), ns)
install.packages(pkg, repos = NULL, type = "source")
```

#### `UniIsoRegression`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/UniIsoRegression/UniIsoRegression_0.0-0.tar.gz",
  repos = NULL, type = "source"
)
```

### R 

(newer packages that could've been updated with the paper published in 2022)

#### `stats`
Nothing to install — just source the wrapper:

```r
source("src/_archive/old/vendor/isoreg.r")

# Then use it like
isoreg_old(y)$yf
```

#### `fdrtool`

```r
Sys.setenv(PKG_CPPFLAGS = "-DCalloc=R_Calloc -DFree=R_Free -DRealloc=R_Realloc")
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/fdrtool/fdrtool_1.2.17.tar.gz",
  repos = NULL, type = "source"
)
Sys.unsetenv("PKG_CPPFLAGS")
```

#### `cir`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/cir/cir_2.2.0.tar.gz",
  repos = NULL, type = "source"
)
```

#### `Iso`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/Iso/Iso_0.0-18.1.tar.gz",
  repos = NULL, type = "source"
)
```

#### `clue`

```r
Sys.setenv(PKG_CPPFLAGS = "-DSint=int")
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/clue/clue_0.3-60.tar.gz",
  repos = NULL, type = "source"
)
Sys.unsetenv("PKG_CPPFLAGS")
```

#### `logcondens`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/logcondens/logcondens_2.1.6.tar.gz",
  repos = NULL, type = "source"
)
```

#### `sandwich`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/sandwich/sandwich_3.0-1.tar.gz",
  repos = NULL, type = "source"
)
```

#### `smacof`

```r
# If using macOS Tahoe 26.1 or newer, you need the following line, otherwise, you'll (probably) be fine
install.packages("rgl", type = "source", configure.args = "--disable-opengl")

install.packages("candisc") # needed 1 time for the old project
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/smacof/smacof_2.1-3.tar.gz",
  repos = NULL, type = "source"
)
```

#### `isotone`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/isotone/isotone_1.1-0.tar.gz",
  repos = NULL, type = "source"
)
```

#### `monotone`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/monotone/monotone_0.1.0.tar.gz",
  repos = NULL, type = "source"
)
```

#### `directlabels`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/directlabels/directlabels_2021.1.13.tar.gz",
  repos = NULL, type = "source"
)
```


### Vendored code

`density-friendly` and `jbkpava` are not packages: their sources are vendored in
`src/density-friendly/src/` and `src/jbkpava/src/`, so there is nothing to
install. `density-friendly` is compiled on the fly with `Rcpp::sourceCpp`;
`jbkpava` needs `R CMD SHLIB src/jbkpava/src/jbkpava.c` once to build
`jbkpava.so`.

### Python

Nothing to do, all is already in the current-day code.

## Check that all R packages are installed correctly

### Old packages (installed from here)

```r
expected <- c(
  SAGx             = "1.64.0",
  intcox           = "0.9.3",
  spsurvey         = "4.1.4",
  UniIsoRegression = "0.0-0",
  fdrtool          = "1.2.17",
  cir              = "2.2.0",
  Iso              = "0.0-18.1",
  clue             = "0.3-60",
  logcondens       = "2.1.6",
  sandwich         = "3.0-1",
  smacof           = "2.1-3",
  isotone          = "1.1-0",
  monotone         = "0.1.0",
  directlabels     = "2021.1.13"
)

check <- data.frame(package = names(expected), expected = unname(expected))
check$installed <- vapply(check$package, function(p)
  tryCatch(as.character(packageVersion(p)), error = function(e) NA_character_),
  character(1))
check$loads <- vapply(check$package, function(p)
  isTRUE(suppressWarnings(suppressMessages(requireNamespace(p, quietly = TRUE)))),
  logical(1))
check$ok <- !is.na(check$installed) & check$loads &
  package_version(ifelse(is.na(check$installed), "0", check$installed)) ==
    package_version(check$expected)

print(check, row.names = FALSE)
stopifnot(all(check$ok))
cat("\nAll", nrow(check), "R packages present at the pinned versions.\n")
```

Expected output:

```r
          package  expected installed loads   ok
             SAGx    1.64.0    1.64.0  TRUE TRUE
           intcox     0.9.3     0.9.3  TRUE TRUE
         spsurvey     4.1.4     4.1.4  TRUE TRUE
 UniIsoRegression     0.0-0     0.0.0  TRUE TRUE
          fdrtool    1.2.17    1.2.17  TRUE TRUE
              cir     2.2.0     2.2.0  TRUE TRUE
              Iso  0.0-18.1  0.0.18.1  TRUE TRUE
             clue    0.3-60    0.3.60  TRUE TRUE
       logcondens     2.1.6     2.1.6  TRUE TRUE
         sandwich     3.0-1     3.0.1  TRUE TRUE
           smacof     2.1-3     2.1.3  TRUE TRUE
          isotone     1.1-0     1.1.0  TRUE TRUE
         monotone     0.1.0     0.1.0  TRUE TRUE
     directlabels 2021.1.13 2021.1.13  TRUE TRUE
```

### New packages

```r
expected_greater <- c(
  fdrtool      = "1.2.17",
  cir          = "2.2.0",
  Iso          = "0.0-18.1",
  clue         = "0.3-60",
  logcondens   = "2.1.6",
  sandwich     = "3.0-1",
  smacof       = "2.1-3",
  isotone      = "1.1-0",
  monotone     = "0.1.0",
  directlabels = "2021.1.13"
)

check <- data.frame(package = names(expected_greater), expected_greater = unname(expected_greater))
check$installed <- vapply(check$package, function(p)
  tryCatch(as.character(packageVersion(p)), error = function(e) NA_character_),
  character(1))
check$loads <- vapply(check$package, function(p)
  isTRUE(suppressWarnings(suppressMessages(requireNamespace(p, quietly = TRUE)))),
  logical(1))
check$ok <- !is.na(check$installed) & check$loads &
  package_version(ifelse(is.na(check$installed), "0", check$installed)) >
    package_version(check$expected_greater)

print(check, row.names = FALSE)
stopifnot(all(check$ok))
cat("\nAll", nrow(check), "R packages are newer than the archived pins.\n")
```

Every row must read `TRUE` in `ok`. `SAGx`, `intcox`, `spsurvey` and
`UniIsoRegression` are absent from this list on purpose: `SAGx`, `intcox` and
`UniIsoRegression` were removed from their repositories, so there is no newer
version to compare against, and `spsurvey` is only used at its archived
version.

Expected output (versions can differ in `installed`, the important part is that they are all `ok = TRUE`):
```r
      package expected_greater installed loads   ok
      fdrtool           1.2.17    1.2.18  TRUE TRUE
          cir            2.2.0     2.5.1  TRUE TRUE
          Iso         0.0-18.1    0.0.21  TRUE TRUE
         clue           0.3-60    0.3.68  TRUE TRUE
   logcondens            2.1.6     2.1.9  TRUE TRUE
     sandwich            3.0-1     3.1.3  TRUE TRUE
       smacof            2.1-3     2.1.7  TRUE TRUE
      isotone            1.1-0     1.1.2  TRUE TRUE
     monotone            0.1.0     0.1.2  TRUE TRUE
 directlabels        2021.1.13 2026.8.27  TRUE TRUE
```