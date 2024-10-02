

DROP SCHEMA IF EXISTS CONFERENCE;
CREATE SCHEMA CONFERENCE;
USE CONFERENCE;

CREATE TABLE ARTICLE (
    idArticle int primary key,
    nomArticle varchar(50)
);

CREATE TABLE UNIVERSITE (
    idUniversite int primary key,
    nomUniversite varchar(50)
);


CREATE TABLE CHERCHEUR (
    idChercheur int primary key,
    nomChercheur varchar(50),
    idArticle int,
    idUniversite int,
    FOREIGN KEY (idArticle)
        REFERENCES ARTICLE (idArticle),
    FOREIGN KEY (idUniversite)
        REFERENCES UNIVERSITE (idUniversite)
);

INSERT INTO ARTICLE VALUES (1, 'Article1');
INSERT INTO ARTICLE VALUES (2, 'Article2');
INSERT INTO ARTICLE VALUES (3, 'Article3');
INSERT INTO ARTICLE VALUES (4, 'Article4');
INSERT INTO ARTICLE VALUES (5, 'Article5');

INSERT INTO UNIVERSITE VALUES (6, 'Paris6');
INSERT INTO UNIVERSITE VALUES (9, 'Paris9');
INSERT INTO UNIVERSITE VALUES (13, 'Paris13');

INSERT INTO CHERCHEUR VALUES (1, 'Pierre', 1, 13);
INSERT INTO CHERCHEUR VALUES (2, 'Boutaine', 2, 9);
INSERT INTO CHERCHEUR VALUES (3, 'Laura', 3, 13);
INSERT INTO CHERCHEUR VALUES (4, 'Kais', 4, 6);

-- Cr ́eer une vue Paris13 qui affiche 
-- les chercheurs de l’universit ́e 13.

CREATE VIEW Paris13 as
    SELECT 
        *
    FROM
        CHERCHEUR
    WHERE
        idUniversite = 13;

-- Retourner le contenu de la vue.
SELECT 
    *
FROM
    (SELECT 
        *
    FROM
        CHERCHEUR
    WHERE
        idUniversite = 13) as Paris13;

-- Modifier le nom du chercheur “Pierre” en “Ali” 
-- dans la table CHERCHEUR. 
-- V ́erifier que la vue Paris13 a change.

UPDATE CHERCHEUR 
SET 
    nomChercheur = 'Ali'
WHERE
    nomChercheur = 'Pierre';

SELECT 
    *
FROM
    Paris13;

-- Inserer un nouveau chercheur de l’universite Paris 13 
-- dans la table CHERCHEUR 
-- et v ́erifier le contenu de Paris13 a bien change.

INSERT INTO CHERCHEUR VALUES (5, 'Annie', 5, 13);
SELECT 
    *
FROM
    Paris13;

-- Donner les noms de tous les chercheurs de Paris 13 
-- `a partir de la vue Paris13
SELECT 
    nomChercheur
FROM
    Paris13;

-- Modifier le nom du chercheur “Ali” en “Pierre” dans la vue.
UPDATE Paris13 
SET 
    nomChercheur = 'Pierre'
WHERE
    nomChercheur = 'Ali';

SELECT 
    *
FROM
    CHERCHEUR;

-- Reponse: La table CHERCHEUR a été mise à jour 
-- à partir de la mise à jour effectuée sur la vue Paris13

CREATE VIEW Universites AS
    SELECT 
        nomChercheur, nomUniversite, idArticle
    FROM
        CHERCHEUR,
        UNIVERSITE
    WHERE
        CHERCHEUR.idUniversite = UNIVERSITE.idUniversite;

SELECT 
    *
FROM
    Universites;

-- Afficher les noms des chercheurs
-- ayant contribue `a l’article 01 `a partir de la vue.

SELECT 
    nomChercheur
FROM
    Universites
WHERE
    idArticle = 1;

-- Afficher les noms des chercheurs travaillant `a Paris6.

SELECT 
    nomChercheur
FROM
    Universites
WHERE
    nomUniversite = 'Paris6';

-- Afficher les noms des articles des chercheurs de Paris 6 
-- a partir de la vue Universites et de la table ARTICLE.

SELECT 
    nomArticle
FROM
    Universites,
    ARTICLE
WHERE
    Universites.idArticle = ARTICLE.idArticle
	AND nomUniversite = 'Paris6'
	;

-- Cr ́eer une vue `a partir de Universites 
-- qui affiche les noms des chercheurs, 
-- les noms de leurs univer- sites, ainsi que les noms de leurs articles.

CREATE VIEW Details AS
    SELECT 
        nomChercheur, nomUniversite, nomArticle
    FROM
        Universites,
        ARTICLE
    WHERE
        Universites.idArticle = ARTICLE.idArticle;

-- Contenu

SELECT 
    *
FROM
    Details;

-- Cr ́eer une vue ArticlesChercheur qui affiche le nombre d’articles par 
-- chercheur et une autre vue
-- ArticlesUniversite, le nombre d’articles par universit ́e . 

CREATE VIEW ArticlesChercheur AS
    SELECT 
        nomChercheur, count(idArticle)
    FROM
        CHERCHEUR
    GROUP BY idChercheur;

DROP VIEW IF EXISTS ArticlesUniversite;

CREATE VIEW ArticlesUniversite (nomUniversite , nombreArticles) AS
    SELECT 
        nomUniversite, count(idArticle)
    FROM
        CHERCHEUR,
        UNIVERSITE
    WHERE
        CHERCHEUR.idUniversite = UNIVERSITE.idUniversite
    GROUP BY CHERCHEUR.idUniversite;

-- 18. Afficher le nombre d’articles de l’universit ́e Paris 13 `a partir de la vue.
SELECT 
    *
FROM
    ArticlesUniversite
WHERE
    nomUniversite = 'Paris13';