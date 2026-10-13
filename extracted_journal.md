# Journal entries for the Pool Party project

## Total hours currently worked : 91 h (33.7 %)

## Total hours worked this week : 7 h

## 2026-10-13: 3h
### Description:
- Check all $\approx O(N)$ (time complexity-wise) functions against each other to find the best function overall. Add the results here
- Fix PR comment on PR done yesterday on monotone.iterations
- Add dataset visualisation

### Annex:
Functions tested: 
```r
density_friendly_pava,
directlabels::isoreg_dp,
fdrtool::monoreg,
intcox:::intcox.pavaC,
jbkpava,
logcondens::isoMean,
monotone::monotone,
monotone::legacy,
monotone::legacy,
monotone::legacy,
UniIsoRegression::reg_1d
```

Results are against these datasets:
![alt text](entries/images/image-75.png)

The plots are always relative to the function that was the lowest at that N, which is why they are at 1x-3x. We only plot the best 5 functions for each dataset. If three functions are tied for fifth, the algorithm chooses arbitrarily one of them. 

#### cliff
![alt text](entries/images/image-63.png)
![alt text](entries/images/image-67.png)

#### down
![alt text](entries/images/image-68.png)
![alt text](entries/images/image-69.png)

#### normal
![alt text](entries/images/image-70.png)
![alt text](entries/images/image-71.png)

#### up-down
![alt text](entries/images/image-72.png)
![alt text](entries/images/image-73.png)

#### up
![alt text](entries/images/image-74.png)
![alt text](entries/images/image-64.png)

#### zigzag
![alt text](entries/images/image-65.png)
![alt text](entries/images/image-66.png)

## 2026-10-12: 4h
### Description:
- Extend table 2 from Busing (2022) with intcox

## 2026-10-11: 4h
### Description:
- Add a bunch of extra PAVA functions from Claude research agents
- Wrap up adding information to README table
- Look into Van Waning WE (1976) but to no avail

### Annex:
### Results for Busing (2022) functions:

#### `density-friendly`

![alt text](entries/images/image-38.png)
![alt text](entries/images/image-39.png)

#### `fdrtool` (addition of monotone::legacy comparison)
![alt text](entries/images/image-40.png)

#### `iso` (addition of monotone::legacy comparison)
![alt text](entries/images/image-41.png)

#### `jbkpava`
![alt text](entries/images/image-61.png)
![alt text](entries/images/image-43.png)

#### `monotone_amalgm`
![alt text](entries/images/image-57.png)
![alt text](entries/images/image-45.png)

#### `monotone_fitm`
![alt text](entries/images/image-46.png)
![alt text](entries/images/image-47.png)

#### `monotone_inplacepava`
![alt text](entries/images/image-48.png)
![alt text](entries/images/image-44.png)

#### `monotone_linearpava`
![alt text](entries/images/image-42.png)
![alt text](entries/images/image-51.png)

#### `monotone_pav`
![alt text](entries/images/image-52.png)
![alt text](entries/images/image-53.png)

#### `monotone_pooledpava`
![alt text](entries/images/image-54.png)
![alt text](entries/images/image-51.png)

#### `smacof_wmonreg`
![alt text](entries/images/image-56.png)
![alt text](entries/images/image-55.png)

#### `spsurvey`
![alt text](entries/images/image-58.png)
![alt text](entries/images/image-59.png)

#### `stats` (addition of monotone::legacy comparison)
![alt text](entries/images/image-60.png)

#### `uniisoregression`
![alt text](entries/images/image-49.png)
![alt text](entries/images/image-62.png)

## 2026-10-10: 1h
### Description:
- Continuation d'ajout des résultats des fonctions qu'on avait pas un peu partout (principalement des ajouts au readme)
- Rouler la validation sur tous les nouveaux algos

## 2026-10-09: 6h
### Description:
- Rencontre Pr. Hocking
- Finalisation d'ajout des fonctions du papier de Busing (2022) que nous n'avions pas
- Ajout des résultats de ces fonctions un peu partout

## 2026-10-02: 6h
### Description:
- Rencontre Pr. Hocking
- Ajout des heures dans le gestionnaire de projet web
- Ajout de plusieurs fonctions que nous n'avions pas du papier de Busing (2022)

## 2026-10-01: 3h
### Description:
- Present results in FUNCTIONS.md for $O$, $\Omega$ and $\Theta$ for the cases we looked at

### Annex:
### Results for all R packages according to different datasets on entry

#### `cir`
![alt text](entries/images/image-25.png)

#### `clue`
![alt text](entries/images/image-26.png)

#### `directlabels`
![alt text](entries/images/image-27.png)

#### `fdrtool`
![alt text](entries/images/image-28.png)

#### `intcox`
![alt text](entries/images/image-29.png)

#### `iso`
![alt text](entries/images/image-30.png)

#### `isotone`
![alt text](entries/images/image-31.png)

#### `logcondens`
![alt text](entries/images/image-32.png)

#### `monotone`
![alt text](entries/images/image-33.png)

#### `sagx`
![alt text](entries/images/image-34.png)

#### `sandwich`
![alt text](entries/images/image-35.png)

#### `smacof`
![alt text](entries/images/image-36.png)

#### `stats`
![alt text](entries/images/image-37.png)

## 2026-09-29: 4h
### Description:
- Wrap up versions
- Refactor all the "new" code
- Generate data for multiple functions to see $\Omega(n)$ and $O(n)$ for best and worse-case scenarios

## 2026-09-25: 3h
### Description:
- Meeting with Pr. Hocking
- Continue working on versions and dates for documented VERSIONS.md

## 2026-09-24: 2h
### Description:
- Check all documentation and add if complexity is documented for each function
- Look at monreg, what it is, if it is relevant (it is not, it does not calculate the same thing as the others)
- Start documenting every version and every year

## 2026-09-23: 2h
### Description:
- Reading of paper O(n) 2022, understanding, answering questions and asking others

## 2026-09-18: 6h
### Description:
- Wrap up switching over to old function
- Add all results for old packages, both here and in the README
- Meeting with Pr. Hocking
- Start reading paper

### Annex:
### Full results for older packages

#### `sklearn/scipy`
scipy is not present here, as it's `isotonic_regression` function arrived later.
![alt text](entries/images/image-23.png)

#### `cir/iso/clue/sagx`
`SAGx` is not present in these results, as it was already a deprecated package
![alt text](entries/images/image-24.png)

#### `fdrtool`
![alt text](entries/images/image-22.png)

#### `intcox`
Not present here, as intcox was already a deprecated package

#### `isotone`
![alt text](entries/images/image-21.png)

#### `logcondens`
![alt text](entries/images/image-20.png)

#### `sandwich`
![alt text](entries/images/image-19.png)
#### `stats/directlabels/monotone/smacof`
`directlabels` is not present here, as it's `isoreg` function only appeared in `directlabels` release 2026.8.27

![alt text](entries/images/image-18.png)

## 2026-09-17: 3.5h
### Description:
- Add full results after rerunning everything
- Add installation instructions for pre-2022 packages
- Add isoreg file from 2021 (as it is shipped directly with R)

### Annex:
### Full results (current-day, latest versions)

`sklearn/scipy`
![alt text](entries/images/image-10.png)

`cir/iso/clue/sagx`
![alt text](entries/images/image-11.png)

`fdrtool`
![alt text](entries/images/image-12.png)

`intcox`
![alt text](entries/images/image-13.png)

`isotone`
![alt text](entries/images/image-14.png)

`logcondens`
![alt text](entries/images/image-15.png)

`sandwich`
![alt text](entries/images/image-16.png)

`stats/directlabels/monotone/smacof`
![alt text](entries/images/image-17.png)

## 2026-09-16: 1.5h
### Description:
- Start checking if all functions return correct results

## 2026-09-15: 2h
### Description:
- Work on project plan
- Add questions to do to TODO.md
- Add results for isotone

### Annex:
### `isotone`
![alt text](entries/images/image-9.png)

## 2026-09-11: 1h
### Description:
- Rencontre avec Pr. Hocking (jaser du mandat de projet et questions overall que j'avais)

## 2026-09-09: 7h
### Description:
- Wrap up mandat de projet
- Add `SAGx` to cir/iso/clue extraction - last one that is dead simple, others will be slightly more complicated
- Add `fdrtool`, `logcondens`, `sandwich`, `intcox`, `smacof` results
- Make scripts for and add Python's `scipy` and `sklearn`

### Annex:
### `SAGx`
![alt text](entries/images/image-2.png)

### `fdrtool`
![alt text](entries/images/image-3.png)

### `logcondens`
![alt text](entries/images/image-4.png)

### `sandwich`
![alt text](entries/images/image-5.png)

### `intcox`
![alt text](entries/images/image-6.png)

### `smacof`
![alt text](entries/images/image-7.png)

### `scipy` and `sklearn`
![alt text](entries/images/image-8.png)

## 2026-09-08: 3h
### Description:
- Add weights and bounds to all columns in table
- Add `cir`, `iso`, as well as `clue` PAVA functions results

### Annex:
![alt text](entries/images/image-1.png)

## 2026-09-07: 4h
### Description:
- Implement mirror for GitHub
- Implement partitioning, template for adding functions, reproducibility
- Start working on table, added results for `stats`, `monotone`, `directlabels` packages

### Annex:
![alt text](entries/images/image.png)

## 2026-09-04: 2h
### Description:
- Continuing adding links to table
- Meeting with Pr. Hocking

## 2026-09-02: 3h
### Description:
- Completion of the "contrat d'equipe"
- Work on the "mandat d'equipe"
- Initialization of the repository and CI for journalization
- Start looking at code, start putting links to functions

## 2026-08-01: 20h
### Description:
- Choosing project
- Meetings with Pr. Hocking
- Written description of the project, iterating over the one-pager
