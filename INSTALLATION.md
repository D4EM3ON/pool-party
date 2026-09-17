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


### R 

(newer packages that could've been updated with the paper published in 2022)

#### `stats`
<!-- TODO: make this work (with github)```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/intcox/intcox_0.9.3.tar.gz",
  repos = NULL, type = "source"
)
``` -->

#### `fdrtool`
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/fdrtool/fdrtool_1.2.17.tar.gz",
  repos = NULL, type = "source"
)
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
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/clue/clue_0.3-60.tar.gz",
  repos = NULL, type = "source"
)
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


### Python

#### `scipy`
Pin version to 1.7.3

#### `sklearn`
Pin version to 1.0.2