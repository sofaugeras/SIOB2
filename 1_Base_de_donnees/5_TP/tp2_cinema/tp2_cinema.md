# TP Cinéma

!!! note "Objectif du TP"
	travailler sur la manipulation des données à l'aide d'un langage de requêtes SANS Jointure.

![gif](./data/tp2/cinema.gif){: width=50% .center}

[Télécharger fichier Création de la base :arrow_down:](./data/tp2/Cinema.sql){ .md-button .md-button--primary }

!!! tip "Crédit"
    Adaptation d'un TP SIO de [Stéphane Guyon](http://guyonst.free.fr)

##  Schéma conceptuel "en intention" : 
ARTISTE (^^idActeur, nom, prenom, anneeNaiss)<br />
FILM (^^idFilm^^, titre, annee, prenom_realisateur, nom_realisateur, #genre, sortie, recettes)<br />
GENRE (^^id^^, nomGenre)<br />
ROLE (^^#idFilm, #idActeur^^, nomRole)<br />

## Modèle Physique des données

![MPD](./data/tp2/MPD.png){: width=75% .center}


!!! question "Q1"
    === "Enoncé"
        Sélectionner tous les films dont les recettes sont supérieures à 1000

    === "Correction"

        ```SQL
        SELECT titre,recettes
        FROM Film
        WHERE recettes > 1000 ;
        ```

!!! question "Q2"
    === "Enoncé"
        Sélectionner tous les films de George Lucas

    === "Correction"

        ```SQL
        SELECT titre
        FROM Film
        WHERE nom_realisateur = 'Lucas' AND prenom_realisateur='Georges';
        ```

!!! question "Q3"
    === "Enoncé"
        Sélectionner tous les films dont les recettes sont supérieures à 1000 et inférieures ou égale à 1500. (Ecrire la requête de deux manières différentes)

    === "Correction"

        ```SQL
        SELECT titre,recettes
        FROM Film
        WHERE recettes BETWEEN 1000 AND 1500;
        /*ou*/
        SELECT titre,recettes
        FROM Film
        WHERE recettes > 1000 AND recettes <= 1500;
        ```

!!! question "Q4"
    === "Enoncé"
        Afficher les films entre 2000 et 2005<br />

        Est-ce que les bornes du BETWEEN sont inclusives ou exclusives ?

    === "Correction"

        ```SQL
        SELECT titre,annee
        FROM Film
        WHERE annee BETWEEN 2000 AND 2005;
        ```

!!! question "Q5"
    === "Enoncé"
        Sélectionner tous les films de Harry Potter

    === "Correction"

        ```SQL
        SELECT titre
        FROM Film
        WHERE titre LIKE 'Harry Potter%';
        ```

!!! question "Q6"
    === "Enoncé"
        Afficher le titre des films par ordre décroissant des recettes

    === "Correction"

        ```SQL
        SELECT titre,recettes
        FROM Film
        ORDER BY recettes DESC;
        ```


!!! question "Q7"
    === "Enoncé"
        Quels sont les films fantastiques réalisés par Steven Spielberg ?

    === "Correction"

        ```SQL
        SELECT titre
        FROM Film 
        WHERE nom_realisateur = "Spielberg";
        ```

!!! question "Q8"
    === "Enoncé"
        Afficher le titre des films d'animation par ordre décroissant des recettes.

    === "Correction"

        ```SQL
        SELECT titre, recettes
        FROM Film 
        WHERE genre = 3
        ORDER BY recettes DESC 
        ```

## Point de cours sur les dates 

![date](./data/tp2/date.png){: width=75% .center}

Les dates sont un type complexe en SQL. et même si ils ressemblent à une chaîne de caractère, on ne peut pas les manipuler en tant que telle. Les SGBD ([documentation MySQL](https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html)) mettent à notre disposition des fonctions de manipulations dédiés.<br />
^^exemple :^^ <br />

- la date du jour : ``CURRENT_DATE``<br />
- l'heure : ``CURRENT_TIME``<br />
- ``YEAR(nom_attribut) ``: la partie année de la date<br />
- ``MONTH(attribut)`` : la partie mois de la date<br />
- ``DAY(attribut) ``: la parte jour de la date<br />
etc.....

Combien de film ont été réalisés en 2005 ?
```SQL
SELECT titre
FROM Film
WHERE YEAR(sortie)='2005';
```

!!! question "Q9"
    === "Enoncé"
        Afficher tous les films fantastiques réalisés entre 2000 et 2010 .

    === "Correction"

        ```SQL
        SELECT * 
        FROM Film 
        WHERE genre = 4
        AND YEAR( sortie ) BETWEEN 2000 AND 2010 
        ```

!!! question "Q10"
    === "Enoncé"
        Afficher tous les films dont le titre commence par « T ».

    === "Correction"

        ```SQL
        SELECT * 
        FROM Film 
        WHERE titre LIKE "T%"
        ```
!!! question "Q11"
    === "Enoncé"
        Afficher tous les films dont le titre comporte le mot « Monde ».

    === "Correction"

        ```SQL
        SELECT * 
        FROM Film 
        WHERE titre LIKE "%Monde%"
        ```

!!! question "Q12"
    === "Enoncé"
        Affichez pour chaque acteur le nombre de ses films présents dans la base

    === "Correction"

        ```SQL
        SELECT COUNT(*), idacteur
        FROM role 
        GROUP BY idActeur;
        ```

!!! question "Q13"
    === "Enoncé"
        Affichez le nombre de film pour chaque catégorie

    === "Correction"

        ```SQL
        SELECT COUNT(*), genre
        FROM film 
        GROUP BY genre;
        ```

!!! question "Q14"
    === "Enoncé"
        Affichez pour chaque année le film qui a réalisé le plus de recettes

    === "Correction"

        ```SQL
        SELECT MAX(recettes),titre 
        FROM film
        GROUP BY annee ;
        ```

!!! question "Q15"
    === "Enoncé"
        afficher le nom et la date de naissance des acteurs qui ont moins de 45 ans. (essayer dans un premier temps de trouver comment afficher l'année en cours)

    === "Correction"

        ```SQL
        SELECT nom, anneeNaiss
        FROM artiste
        WHere (YEAR(CURRENT_DATE)- anneeNaiss ) <= 45
        ```

!!! question "Q16"
    === "Enoncé"
        Combien de films sont sortie au mois de septembre ?

    === "Correction"

        ```SQL
        SELECT * 
        FROM FILM
        WHERE MONTH(sortie) = 9;
        ```

!!! question "Q17"
    === "Enoncé"
        afficher les réalisateurs et la somme des recettes générées par leurs films classés par ordre décroissant des recettes ?

    === "Correction"

        ```SQL
        SELECT nom_realisateur, SUM(recettes)
        FROM FILM
        GROUP BY nom_realisateur
        ORDER BY SUM(recettes) DESC ;
        ```

