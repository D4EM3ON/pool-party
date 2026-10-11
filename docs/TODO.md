# Todo

- [ ] Add tous les algos du papier de 2022 qu'on a pas, partout
  - [x] Ajouter code non existant sauf sous monotone::legacy
  - [ ] Comparer tout ce qu'on a avec les monotone::legacy() (qui sont disponibles)

- [ ] Trouver (??) et lire Van Waning (1976)

- [ ] Pour colonne Busing 2022 ajouter complexite temporelle dite

- [ ] Trouver les informations nécessaires pour intcox comme si on remplissait la Table 2 de Busing (2022)
  - [ ] Add intcox to monotone.iterations public package from Pr. Hocking (réfléchir, regarder ce que ça fait, pourquoi et comment, comment la convertir)

- [ ] Check if there are more functions in R or in Python that implement pava other than what there currently is in the README.

- [ ] Look at section 4 of the 2022 O(n) paper and compare with our results - are they the same?
  - [ ] Look at the $n^2$ codes in section 4.1, analyze if some are $n$ vs $n^2$ in some cases (with different data in). See more info about data comparison in this case here: https://github.com/tdhock/sparse-label-positions/blob/main/figure-atime-cases-data.R
  - [ ] Look at the legacy code in the appendix of the paper (monotone::legacy), and compare them to their current-day implementations - do they give the same results?

- [ ] Regarder pour amalgm() si on a un pire cas pour lui que les direct updates n'ont pas

- [ ] Faire tourner tout ceux qu'on a qui sont lineaires pour trouver celui avec le meilleur temps constant

# Completed

- [x] Confirm if all of them give the same result (compare all results to quadprog)

- [x] For all linear methods that were updated after 2022 (https://www.jstatsoft.org/article/view/v102c01/4306), were they linear before?

- [x] Lire le papier 2022 au grand complet !! 

- [x] Add column if talked about complexity in documentation or not

- [x] Does monreg do what all the other functions do?

- [x] Add version that was tested as well as year the version was released

- [x] Pire et meilleur cas pour tous les algos

- [x] Ecrire a Frank du papier de 2022 pour demander les trucs supplementaires, + lui demander s'il y a des algos qui sont dans le pire cas quadratique et dans le meilleur cas lineaire
  - "A tes connaissances, ecq tous les algos ont la meme complexite asymptotique dans le pire et dans le meilleur cas, ou connais tu un algo qui est lineaire dans le meilleur et quadratique dans le pire cas."

- [x] Add errors if there are any (for sandwich for example)

- [x] Jaser semaine prochaine: comment compter le nombre d'iterations pour les algos de monotone.iterations::
