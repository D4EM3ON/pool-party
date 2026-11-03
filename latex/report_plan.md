Question de base: si on améliore le package pour la position des étiquettes, on peut faire appel à un algorithme de PAVA. Cependant, lequel est le plus efficace? Nous avons regardé des papiers, des implémentations. 

Présenter l'enjeu: algorithme 

Avantages + inconvénients

Quelles informations disponibles avant qu'on entreprenne les démarches:
- Papier de 2022
- Caractérisation des algos
- Papier de 2009, pas testé en 2022, même genre de comparaisons pour savoir si un de ces algos convient aussi bien que les autres présentés en 2022

Parmi tous les codes existants, voici les 2-3 plus efficaces pour utilisation générale, ainsi que 1-2 spécifique si pas celui qui est global

Pourquoi ecq ces algos sont les plus performants? On voit ici les algos empiriques, mais côté complexité du code théorique, pourquoi sont-ils bien? S'ils ne font pas les mêmes choses, quelles sont les différences? 

Quel critère donne un algorithme efficace? Donner références au papier de 2022. Est-ce qu'on fait des _direct updates_, combien d'extras tableaux faut-il utiliser? Ecq nos résultats sont consistants avec l'analyse théorique, et l'analyse qu'il a fait?

Il faut une recommandation à la fin: nous recommandons d'utiliser cet algorithme, par exemple "à cause de XYZ dans le code source" est meilleur que les autres.


On cherche à tirer quelque chose du papier de plus général, une leçon - qu'a-t-on appris de ce projet là par rapport à l'efficacité. par exemple, dans ce cas ci, si on voulait un algorithme efficace, il fallait faire X, Y et/ou Z (si on réussi à faire cela dans ce contexte.)


Planifier papier en fonction des figures/tableaux
- Faire une liste de tous les tableaux et figures qu'on veut mettre dans le papier, et planifier l'écriture en conséquence

Liste:
1. Paper comparison 1
2. Montrer résultats empiriques de Busing legacy par rapport à ce qu'on a
3. Montrer table de comparaison augmentée qu'on a (Table 2 Busing)
4. dans les résultats: FUNCTIONS.md

10. En annexe: version des fonctions qu'on a utilisés

À mettre en note que Scikit-Learn appelle Scipy, et scipy appelle monotone (mettre source qui le mentionne)