# Journal entries for the Pool Party project

## Total hours currently worked : 177 h (65.6 %)

## Total hours worked this week : 4 h

## 2026-11-17: 4h
### Description:
- Work on report:
  - remove graphic
  - 

## 2026-11-13: 4h
### Description:
- Pass through all $O(N\log N)$ functions we had to truly see if they were $O(N)$ or really $O(N\log N)$
- Continue report
- Rencontre Pr. Hocking

## 2026-11-12: 4h
### Description:
- Continue report
- Start rerunning functions

## 2026-11-11: 5h
### Description:
- Add functions, data used, start on results for report

## 2026-11-10: 2h
### Description:
- Work on report (mainly background, references)

## 2026-11-08: 1h
### Description:
- Add hours for everything that was missing in the project manager

## 2026-11-06: 6h
### Description:
- Work on monotone.iterations
- Start working on report

## 2026-11-05: 4h
### Description:
- Work on monotone iterations

## 2026-11-04: 3h
### Description:
- Examine what will need to be done to adapt monotone.iterations to what we want
- Make list of things we want to do for monotone.iterations
- Start contemplating background work

## 2026-11-03: 6h
### Description:
- update versions.md
- remove comparison to baseline in _best/ and regenerate everything
- add directlabels to paper comparison

### Annex:
### Best results overall
![alt text](entries/images/image-89.png)

### Best results with top 5 functions for each dataset

#### Cliff:
![alt text](entries/images/image-90.png)

#### Down:
![alt text](entries/images/image-84.png)

#### Normal:
![alt text](entries/images/image-85.png)

#### Up-down:
![alt text](entries/images/image-86.png)

#### Up:
![alt text](entries/images/image-87.png)

#### Zigzag:
![alt text](entries/images/image-88.png)

## 2026-10-23: 2h
### Description:
- Rencontre avec Pr. Hocking

## 2026-10-22: 4h
### Description:
- Add no/absent to paper comparison
- Modify O/Omega in FUNCTIONS.md to best and worse time/space
- Wrap up documentation for new functions
- Note prompts used to get results for _best and for EXTRA_PAVA_FUNCTIONS.md
- Add latex base

## 2026-10-15: 3h
### Description:
- Prepare meeting
- Meeting with Pr. Hocking
- Follow up with TODOs throughout the day

## 2026-10-14: 5h
### Description:
- Look at all functions that were described in EXTRA_PAVA_FUNCTIONS.md
- Condense the above-mentioned md file
- Fix comments on PR for adding intcox to monotone.iterations
- Add all relevant O(N) functions from EXTRA_PAVA_FUNCTIONS.md as code, as well as results here, as well as results in FUNCTIONS.md, as well as validating their return in _validation/, running them via _best/
- Describe in the README the steps necessary to adding a function and its results

### Annex:
### `orthomtl`
![alt text](entries/images/image-83.png)
![alt text](entries/images/image-76.png)

### `sffdr`
![alt text](entries/images/image-77.png)
![alt text](entries/images/image-78.png)

### `tabicl2`
![alt text](entries/images/image-79.png)
![alt text](entries/images/image-80.png)

### `toxstats`
![alt text](entries/images/image-81.png)
![alt text](entries/images/image-82.png)

## 2026-10-13: 4h
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

## 2026-10-12: 5h
### Description:
- Extend table 2 from Busing (2022) with intcox

## 2026-10-11: 5h
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

## 2026-10-10: 2h
### Description:
- Continuation d'ajout des résultats des fonctions qu'on avait pas un peu partout (principalement des ajouts au readme)
- Rouler la validation sur tous les nouveaux algos

## 2026-10-09: 8h
### Description:
- Rencontre Pr. Hocking
- Finalisation d'ajout des fonctions du papier de Busing (2022) que nous n'avions pas
- Ajout des résultats de ces fonctions un peu partout

## 2026-10-02: 8h
### Description:
- Rencontre Pr. Hocking
- Ajout des heures dans le gestionnaire de projet web
- Ajout de plusieurs fonctions que nous n'avions pas du papier de Busing (2022)

## 2026-10-01: 4h
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

## 2026-09-29: 5h
### Description:
- Wrap up versions
- Refactor all the "new" code
- Generate data for multiple functions to see $\Omega(n)$ and $O(n)$ for best and worse-case scenarios

## 2026-09-25: 4h
### Description:
- Meeting with Pr. Hocking
- Continue working on versions and dates for documented VERSIONS.md

## 2026-09-24: 3h
### Description:
- Check all documentation and add if complexity is documented for each function
- Look at monreg, what it is, if it is relevant (it is not, it does not calculate the same thing as the others)
- Start documenting every version and every year

## 2026-09-23: 3h
### Description:
- Reading of paper O(n) 2022, understanding, answering questions and asking others

## 2026-09-18: 8h
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

## 2026-09-17: 4h
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

## 2026-09-16: 2h
### Description:
- Start checking if all functions return correct results

## 2026-09-15: 3h
### Description:
- Work on project plan
- Add questions to do to TODO.md
- Add results for isotone

### Annex:
### `isotone`
![alt text](entries/images/image-9.png)

## 2026-09-11: 2h
### Description:
- Rencontre avec Pr. Hocking (jaser du mandat de projet et questions overall que j'avais)

## 2026-09-09: 8h
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

## 2026-09-08: 4h
### Description:
- Add weights and bounds to all columns in table
- Add `cir`, `iso`, as well as `clue` PAVA functions results

### Annex:
![alt text](entries/images/image-1.png)

## 2026-09-07: 5h
### Description:
- Implement mirror for GitHub
- Implement partitioning, template for adding functions, reproducibility
- Start working on table, added results for `stats`, `monotone`, `directlabels` packages

### Annex:
![alt text](entries/images/image.png)

## 2026-09-04: 3h
### Description:
- Continuing adding links to table
- Meeting with Pr. Hocking

## 2026-09-02: 4h
### Description:
- Completion of the "contrat d'equipe"
- Work on the "mandat d'equipe"
- Initialization of the repository and CI for journalization
- Start looking at code, start putting links to functions

## 2026-08-01: 30h
### Description:
- Choosing project
- Meetings with Pr. Hocking
- Written description of the project, iterating over the one-pager
