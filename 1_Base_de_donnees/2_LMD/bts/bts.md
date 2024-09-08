# TD «Moyennes de BTS»

A partir des données suivantes de la table ETUDIANTS :

|N°Etu	|Prénom	|Nom	|Moy. Gen.|	Classe|
|:--:|:--:|:--:|:--:|:--:|
|1	|Mickael|	Dupond|	6|	SIO1|
|2|	Nolwen|	Durand	|12|	SIO1|
|3|	Vincent	|Durand|	14	|SISR2|
|4|	Mickael	|Dupond	|10	|SLAM2|
|5|	Patrick	|Durand	|8|	SLAM2|
|6|	Stéphane|	Durand	|15|	SISR2|
|7|	Vincent	|Dupond|	9	|SIO1|
|8|	Vincent	|Martin	|8|SIO1|
|9|	Benjamin|	Durand	|14	|SISR2|
|10|	Teddy|	Dupond	|9	|SLAM2|
|11|	Delphine	|Martin	|10|	SIO1|
|12|	Mickael|	Dupond	|12	|SIO1|
|13|	Sandrine|	Dupond	|10	|SISR2|

```SQL
/*Code SQL pour créer la table */
CREATE TABLE ETUDIANT(
    numEtu	INT PRIMARY KEY,
    prenom VARCHAR(50),	
    nom VARCHAR(50),
    moyenneGen DECIMAL(10,2),
    classe VARCHAR(5)
    );
```

[Télécharger fichier CSV des données :arrow_down:](./data/bts.csv){ .md-button .md-button--primary }

Indiquez le code SQL :

!!! question "Q1"
    === "Enoncé"
        Liste des étudiants (nom, prénom) de SIO1

    === "Correction"

        ```SQL
        SELECT nom, prenom
        FROM etudiant
        WHERE classe ="SIO1";
        ```

!!! question "Q2"
    === "Enoncé"
        Liste de tous les étudiants d'abord de SLAM2 puis de SISR2

    === "Correction"

        ```SQL
        SELECT nom, prenom
        FROM etudiant
        WHERE classe LIKE "%2"
        ORDER BY classe DESC;
        ```

!!! question "Q3"
    === "Enoncé"
        Liste des étudiants d'abord de SIO1 par ordre décroissant de moyenne puis des 2ème années par option aussi par ordre décroissant des moyenne. <br />
        Est-il possible d'avoir les étudiants d'une classe par ordre décroissant de moyenne puis une autre classe par ordre croissant ?

    === "Correction"

        ```SQL
        SELECT nom, prenom, moyenneGen, classe
        FROM etudiant
        ORDER BY classe ASC, moyenneGen DESC;
        ```

        non, la fonction de tri ne le permet.

!!! question "Q4"
    === "Enoncé"
        Nombre d'étudiants en SIO1

    === "Correction"

        ```SQL
        SELECT COUNT(*)
        FROM etudiant
        WHERE classe='SIO1';
        ```

!!! question "Q5"
    === "Enoncé"
        Nombre d'étudiants en SISR2 et SLAM2

    === "Correction"

        ```SQL
        SELECT COUNT(*), classe
        FROM etudiant
        WHERE classe LIKE '%2'
        GROUP BY classe;
        ```

!!! question "Q6"
    === "Enoncé"
        Moyenne générale des SIO1 et SISR2

    === "Correction"

        ```SQL
        SELECT classe, AVG(moyenneGen)
        FROM etudiant
        WHERE classe LIKE '%2'
        GROUP BY classe;
        ```

!!! question "Q7"
    === "Enoncé"
        Moyenne maximale par classe

    === "Correction"

        ```SQL
        SELECT max(moyenneGen), nom FROM etudiant; 
        ```

!!! question "Q8"
    === "Enoncé"
        Liste des classes dont la moyenne est supérieure ou égale à 10

    === "Correction"

        ```SQL
        SELECT classe
        FROM etudiant
        GROUP BY classe
        HAVING AVG(moyenneGen) >= 10 ;
        ```

!!! question "Q9"
    === "Enoncé"
        Comptez le nombre d'étudiants par moyenne, rangés par ordre croissant des moyennes

    === "Correction"

        ```SQL
        SELECT moyenneGen, COUNT(*)
        FROM etudiant
        GROUP BY moyenneGen
        ORDER BY moyenneGen ; 
        ```

!!! question "Q10"
    === "Enoncé"
        Indiquez une requête donnant le même résultat que :

        ```SQL
        SELECT Nom, prenom, moyenneGen
        FROM Etudiants
        GROUP BY numEtudiant, Nom, prenom, moyenneGen
        ```
    === "Correction"

        ```SQL
         SELECT Nom, Prénom, moyenneGen
        FROM Etudiants
        ```
        Le numEtudiant (ici clé primaire) étnt unique, inutile de grouper sur cet attribut.

!!! question "Q11"
    Quel est le résultat de 3 requêtes suivantes ?
        ```SQL
        SELECT SUM(moyenneGen)
        FROM Etudiants
        GROUP BY Nom;

        SELECT SUM(moyenneGen)
        FROM Etudiants
        GROUP BY Nom, prenom;

        SELECT COUNT(*)
        FROM Etudiants
        GROUP BY Classe, moyenneGen
        ORDER BY Classe, moyenneGen;
        ```

!!! question "Q12"
    === "Enoncé"
        Quel est l’intérêt de faire des calculs par nom de famille

    === "Correction"
        Aucun à cause des homonymes

!!! question "Q13"
    === "Enoncé"
        Moyenne générale des classes qui ont plus de 10 étudiants

    === "Correction"
        ```SQL
        SELECT classe, AVG(moyenneGen)
        FROM etudiant
        GROUP BY classe
        HAVING COUNT(*) >= 10; 
        ```
        Pour tester, ajouter quelques étudiants à l'une des classes.

!!! question "Q14"
    Imaginez une requêtes avec toutes les clauses que vous connaissez

