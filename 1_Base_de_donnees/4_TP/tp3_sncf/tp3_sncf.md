# TP3 Contexte SNCF

![gif](./data/tp3/99Ug.gif){: width=50% .center}

Soient les relations suivantes :<br />

**GARE** (^^CodeGare^^, NomGare, NomVille)<br />
**TRAIN** (^^NumTrain^^, #CodGareDep, #CodGareArr, Hdep, Harr, CodTrf)<br />
**COMPOSITION** (^^#NumTrain, DatDep^^, Ass1, Ass2, Cch1, Cch2)<br />
**EXCEPTION** (^^#NumTrain, DatDep^^)<br />


:arrow_forward: **CodTrf** : Code trafic (Q: quotidien, D: samedi, dimanche et fêtes)<br />
:arrow_forward: **Ass1, Ass2** : nombre de wagons place assise en 1° classe et 2°classe<br />
:arrow_forward: **Cch1, Cch2** : nombre de wagons couchette en 1° classe et 2° classe<br />
:arrow_forward: La présence d'un tuple dans l'objet **EXCEPTION** indique que le train ne roulera pas ce jour là, quel que soit son code trafic.


Réalisez le script SQL pour :

1) Créez les tables correspondantes.

2) Ajoutez au moins un enregistrement par table, l’ordre des ajouts doit être cohérent.

3) Supprimez la clé primaire d’EXCEPTION.

4) Ajoutez le tuple (‘G05’, ‘Montparnasse’, ‘Paris’) dans GARE.

5) Ajoutez deux trains partant de la gare ‘G05’.

6) Modifiez le tuple (‘G05’, ‘Montparnasse’, ‘Paris’) en (‘G05’, ‘Paris Montparnasse’, ‘Paris’), quelles sont les mises à jour à effectuer sur la base ?

7) Modifiez le tuple (‘G05’, ‘Paris Montparnasse’, ‘Paris’) en (‘G15’, ‘Paris Montparnasse’, ‘Paris’), quelles sont les mises à jour à effectuer sur la base ?

8) Créez un jeu de donnée pour des trains partant de Questembert. 
Puis modifiez les données pour que Tous les trains qui partent de Questembert soient de type quotidien.

9) Effacez tous les enregistrements de TRAIN. Quelles instructions complémentaires faut-il rajouter ?

10) Effacez tous les enregistrements de TRAIN qui partent de Rennes. Pas de données dans les tables connexes. Quelles informations vous manquent-t-il ? Réalisez le script en imaginant la(les) valeur(s) souhaitée(s).

11) Effacez tous les enregistrements de TRAIN en supposant que ce soit la seule table remplie avec GARE

12) Supprimez la table TRAIN en supposant que les tables connexes soient remplies.

