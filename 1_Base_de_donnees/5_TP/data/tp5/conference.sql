DROP SCHEMA IF EXISTS CONFERENCE;

CREATE DATABASE CONFERENCE;
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