# TP 

!!! note "Objectif du TP"
	travailler sur la manipulation des données à l'aide d'un langage de requêtes AVEC Jointure.

![gif](./data/tp2/cinema.gif){: width=50% .center}

[Télécharger fichier Création de la base :arrow_down:](./data/tp2/cinema2.sql){ .md-button .md-button--primary }

!!! tip "Crédit"
	Adaptation d'un TP SIO de [Stéphane Guyon](http://guyonst.free.fr)

##  Schéma conceptuel "en intention" : 
REALISATEUR (^^idrealisateur^^, nom, prenom, date_naissance, #nation)<br />
FILM (^^idFilm^^, titre, annee, genre, sortie, recettes, idrealisateur, "idnation")<br />
NATION (^^idnation^^, )

## Modèle Physique des données

![MPD](./data/tp2/MPD2.png){: width=75% .center}


!!! question "Q1"
    === "Enoncé"
        afficher le titre des films réalisés par George Lucas.

    === "Correction"

        ```SQL
        SELECT Film.titre, Realisateur.nom
		FROM Film INNER JOIN Realisateur
		ON Film.idrealisateur = Realisateur.idrealisateur
		WHERE Realisateur.nom = 'Lucas';
        ```

!!! question "Q2"
    === "Enoncé"
        afficher le titre et le nom des réalisateurs des films « Harry Potter »

    === "Correction"

        ```SQL
        SELECT Film.titre, Realisateur.nom
		FROM Film INNER JOIN Realisateur
		ON Film.idrealisateur = Realisateur.idrealisateur
		WHERE Film.titre LIKE 'Harry%';
        ```

!!! question "Q3"
    === "Enoncé"
        afficher le nombre de film par nation

    === "Correction"

        ```SQL
        SELECT COUNT(*) as nombre, nation.nation
        FROM Film INNER JOIN Realisateur
        ON Film.idrealisateur = Realisateur.idrealisateur
        INNER JOIN nation
        ON realisateur.nation = nation.idnation
        GROUP BY nation.idnation
        ```

!!! question "Q4"
    === "Enoncé"
        afficher le titre et le nom du réalisateur du film réalisé par le réalisateur mexicain

    === "Correction"

        ```SQL
        SELECT Film.titre, Realisateur.nom
        FROM Film INNER JOIN Realisateur
            ON Film.idrealisateur = Realisateur.idrealisateur
            INNER JOIN nation
            ON realisateur.nation = nation.idnation
        HERE nation.nation = 'Mexique'
        ```

!!! question "Q5"
    === "Enoncé"
        afficher les différentes nationalité des réalisateurs

    === "Correction"

        ```SQL
        SELECT DISTINCT nation.nation
        FROM nation INNER JOIN realisateur
        ON nation.idnation = realisateur.nation ;
        ```
         note : la jointure est ici obligatoire. On ne doit afficher que les nations ayant des réalisateurs. Or dans la base, le canada n'a pas de réalisateur associé, il ne doit donc pas apparaître.

!!! question "Q6"
    === "Enoncé"
        Qui est le réalisateur du film « 2012 » ?

    === "Correction"

        ```SQL
        SELECT Film.titre, Realisateur.nom
        FROM Film INNER JOIN Realisateur
        ON Film.idrealisateur = Realisateur.idrealisateur
        WHERE Film.titre = '2012';
        ```

!!! question "Q7"
    === "Enoncé"
        afficher le nom et la date de naissance des réalisateurs qui ont moins de 55 ans . ( essayer dans un premier temps de trouver comment afficher l'année en cours)

    === "Correction"

        ```SQL
        SELECT Realisateur.nom
        FROM Realisateur
        WHERE ( YEAR(NOW()) - YEAR(Realisateur.date_naissance) ) <= 55;
        ```

!!! question "Q8"
    === "Enoncé"
        afficher les réalisateurs et la somme des recettes générées par leurs films classés par ordre décroissant des recettes ?

    === "Correction"

        ```SQL
        SELECT SUM(Film.recettes) as recettes, Realisateur.nom
        FROM Film INNER JOIN Realisateur
        ON Film.idrealisateur = Realisateur.idrealisateur
        GROUP BY Realisateur.nom
        ORDER BY recettes DESC
        ```
<!--

ficher le nom des acteurs qui ont jou é dans Avatar.
2 – Afficher le nom des acteurs qui ont joué sous la direction de Georges Lucas.
3 – Afficher le nom des acteurs qui ont joué dans des films Fantastique.
4 – Indiquer dans quel film a joué Dicaprio.
5 – Afficher le nom des acteurs qui ont joué dans des films dont le réalisateur est américain.
6 – Afficher le nom et la date de naissance de l'acteur le plus jeune dans la base.
7 – Afficher le nom de l'acteur et le nombre de films dans lequel ils ont joué.
8 – Afficher le nom de l'acteur qui a joué dans le plus grand nombre de films présents dans la base.-->