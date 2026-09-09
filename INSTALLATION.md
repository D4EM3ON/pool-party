## How i installed some archived packages

### SAGx
```r
install.packages("BiocManager")
BiocManager::install(c("Biobase", "multtest"))
install.packages(
  "https://bioconductor.statistik.tu-dortmund.de/packages/3.12/bioc/src/contrib/SAGx_1.64.0.tar.gz",
  repos = NULL, type = "source"
)
```

### intcox
```r
install.packages(
  "https://cran.r-project.org/src/contrib/Archive/intcox/intcox_0.9.3.tar.gz",
  repos = NULL, type = "source"
)
```