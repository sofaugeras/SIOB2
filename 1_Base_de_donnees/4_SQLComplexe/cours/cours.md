# SQL avancé

## 1. Les requêtes imbriquées
Les requêtes imbriquées sont basées sur le mot-clé IN (vu au III) qui permet de sélectionner des enregistrements parmi une liste.
Le principe consiste à construire une sous-requête qui donne un résultat équivalent à une liste. Ensuite la requête principale permet de sélectionner des lignes dans la liste précédemment construite.

![requete imbriquée](./data/imbricataionIN.png){: width=50% .center}

Le mot-clé IN peut-être remplacé par un opérateur de comparaison (=, <>, <,<=,>, >=). Dans ce cas, le résultat de la sous-requête ne consiste qu’en une seule valeur
1 Utilisation des requêtes imbriquées pour réaliser des jointures
Lorsque le résultat d’une requête ne se trouve que dans une seule table, il est conseillé de la réaliser avec des requêtes imbriquées. En effet, pour le SGBD, cette solution est beaucoup plus rapide.
Exemple : si je veux connaître le nom et le prénom des congressistes envoyés par l’organisme : le Lycée Valadon de Limoges, je peux écrire la requête suivante :
SELECT nom_congressiste, prénom_congressiste FROM CONGRESSISTE WHERE N°_organisme IN ( SELECT N°_organisme FROM ORGANISME_PAYEUR WHERE nom_organisme = 'Lycée Valadon' AND adresse_organisme = 'Limoges')
La requête imbriquée renvoie le n° organisme payeur recherché et la première requête permet de sélectionner les congressistes dépendant de l’organisme payeur ainsi obtenu.
Requête principale
Sous-requête
BTS2 SIO Bases de données - Révisions SQL
19/
Le SGBD exécute toujours en premier la requête imbriquée. Si l’on avait voulu la même requête en faisant afficher le nom de l’organisme payeur, cette solution n’aurait pas été adéquate. Il aurait fallu écrire une jointure comme décrite au chapitre 5.
2 Utilisation des requêtes imbriquées avec des fonctions
Les requêtes utilisant les fonctions AVG, COUNT, SUM, MAX et MIN ne renvoient qu’une seule valeur. Ces requêtes peuvent être utilisées comme sous requêtes afin que l’on puisse faire des comparaisons en utilisant les opérateurs classiques : =, < ,>, <>…
Exemple : select N°_Produit, nom_Produit , prix_produit = (select max(prix_produit) from Produit)
→Permet d’afficher les caractéristiques du produit le plus cher.


## 2. OPérateurs ensemblistes

## 3. Les vues

## 4. les différents types de jointures
