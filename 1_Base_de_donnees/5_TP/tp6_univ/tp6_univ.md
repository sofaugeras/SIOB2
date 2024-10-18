# TP Conférence

!!! note "Objectif du TP"

	- Savoir créer une vue. 
    - Utiliser une vue, en regroupement d’informations, calculs complexes

![gif](./data/tp5/giphy.webp){: width=50% .center}


Soient les relations suivantes :<br /> 

```text
ARTICLE (idArticle, nomArticle)
        clé primaire : idArticle
UNIVERSITE (idUniversite, nomUniversite)
 		clé primaire : idUniversite
CHERCHEUR (idChercheur, nomChercheur, idArticle, idUniversite)
        clé primaire : idChercheur
        clé étrangère : idArticle référence ARTICLE(idArticle)
                        idUniversite référence UNIVERSITE(idUniversite).
```
![contenu](./data/tp5/contenu.png){: width=80% .center}

**R1 :** Créez les tables correspondantes.:warning: L'ordre de création des tables doit être cohérent.

??? question "Correction"

    [Télécharger fichier Création de la base :arrow_down:](./data/tp5/conference.sql){ .md-button .md-button--primary }

**R2 :** Créer une vue ``Paris13`` qui affiche les chercheurs de l’université 13.

??? question "Correction"

    ```sql
    CREATE VIEW Paris13 as
        SELECT *
        FROM CHERCHEUR
        WHERE idUniversite = 13;
    ```

**R3 :** Retourner le contenu de la vue.

??? question "Correction"

    ```sql
    SELECT *
    FROM (SELECT *
            FROM CHERCHEUR
            WHERE idUniversite = 13) 
        as Paris13;
    ```

**R4 :** Modifier le nom du chercheur “Pierre” en “Ali” dans la table CHERCHEUR. Vérifier que la vue ``Paris13`` a change.

??? question "Correction"

    ```sql
    UPDATE CHERCHEUR 
    SET nomChercheur = 'Ali'
    WHERE nomChercheur = 'Pierre';
    -- Vérification de la modification
    SELECT *
    FROM Paris13;
    ```


**R5 :** Inserer un nouveau chercheur de l’universite Paris 13 dans la table CHERCHEUR et vérifier le contenu de ``Paris13`` a bien change.

??? question "Correction"

    ```sql
    INSERT INTO CHERCHEUR VALUES (5, 'Annie', 5, 13);    
    -- Vérification de la modification
    SELECT *
    FROM Paris13;
    ```

**R6 :** Donner les noms de tous les chercheurs de Paris 13 a partir de la vue ``Paris13``

??? question "Correction"

    ```sql
    SELECT nomChercheur
    FROM Paris13;
    ```


**R7 :** Modifier le nom du chercheur “Ali” en “Pierre” dans la vue.

??? question "Correction"

    ```sql
    UPDATE Paris13 
    SET nomChercheur = 'Pierre'
    WHERE nomChercheur = 'Ali';
    -- Vérification de la modification
    SELECT *
    FROM CHERCHEUR;
    ```
    La **table** CHERCHEUR a été mise à jour à partir de la mise à jour effectuée sur la vue ``Paris13``


**R8 :** Créer une vue ``Universites`` qui affiche les noms des chercheurs avec les noms de leurs universités et les identifiants de leurs articles.

??? question "Correction"

    ```sql
    CREATE VIEW Universites AS
        SELECT nomChercheur, nomUniversite, idArticle
        FROM CHERCHEUR INNER JOIN UNIVERSITE
            ON CHERCHEUR.idUniversite = UNIVERSITE.idUniversite;
    -- appel de la vue
    SELECT *
    FROM Universites;
    ```


**R9 :** Afficher les noms des chercheurs ayant contribue à l’article 01 à partir de la vue.

??? question "Correction"

    ```sql
    SELECT nomChercheur
    FROM Universites
    WHERE idArticle = 1;
    ```

**R10 :** Afficher les noms des chercheurs travaillant à ``Paris6``.

??? question "Correction"

    ```sql
    SELECT nomChercheur
    FROM Universites
    WHERE nomUniversite = 'Paris6';
    ```


**R11 :** Afficher les noms des articles des chercheurs de Paris 6 à partir de la vue ``Universites`` et de la table ``ARTICLE``.

??? question "Correction"

    ```sql
    SELECT nomArticle
    FROM Universites INNER JOIN ARTICLE
        ON Universites.idArticle = ARTICLE.idArticle
    WHERE nomUniversite = 'Paris6' ;
    ```


**R12 :** Créer une vue à partir de ``Universites`` qui affiche les noms des chercheurs, les noms de leurs univer- sites, ainsi que les noms de leurs articles.

??? question "Correction"

    ```sql
    CREATE VIEW Details AS
        SELECT nomChercheur, nomUniversite, nomArticle
        FROM Universites INNER JOIN ARTICLE
        ON Universites.idArticle = ARTICLE.idArticle;

    -- Contenu
    SELECT * FROM Details;
    ```


**R13 :** Créer une vue ``ArticlesChercheur`` qui affiche le nombre d’articles par chercheur et une autre vue``ArticlesUniversite``qui affiche le nombre d’articles par université. 

??? question "Correction"

    ```sql
    CREATE VIEW ArticlesChercheur AS
        SELECT 
            nomChercheur, count(idArticle)
        FROM
            CHERCHEUR
        GROUP BY idChercheur;

    CREATE VIEW ArticlesUniversite (nomUniversite , nombreArticles) AS
        SELECT 
            nomUniversite, count(idArticle)
        FROM
            CHERCHEUR,
            UNIVERSITE
        WHERE
            CHERCHEUR.idUniversite = UNIVERSITE.idUniversite
        GROUP BY CHERCHEUR.idUniversite;

    ```

**R14 :** Afficher le nombre d’articles de l’université Paris 13 à partir de la vue.

??? question "Correction"

    ```sql
    SELECT *
    FROM ArticlesUniversite
    WHERE nomUniversite = 'Paris13';
    ```
