# Base Bibliothèque
Soit le système d’information simplifié d’une bibliothèque dont voici le schéma relationnel :
 
![base bibliothèque](./data/bibli.png)

[Télécharger fichier Création de la base BIBLI :arrow_down:](./data/script_creation_bibli.sql){ .md-button .md-button--primary }

1. Ecrire le schéma relationnel "en intention" ou détaillé de la base bibilothèque
2. Expliquer pourquoi le champ `dateemprunt` fait partie de la clé primaire. <br/>
3. Écrire les requêtes suivantes : <br/>

R1 : Qui est le lecteur n°30 ? <br/>
R2 : Liste des lecteurs dont le nom de famille commence par la lettre « S » <br/>
R3 : Liste des ouvrages qui traitent de la méthode Merise. <br/>
R4 : Liste des ouvrages qui traitent du « registre » à partir de l’année 2000. <br/>
R5 : Liste des lecteurs qui portent le nom (ou le prénom) « BERTRAND » <br/>
R6 : Quels sont le titre et l’année de parution de l’ouvrage le plus ancien ?<br/>
R7 : Titre des ouvrages actuellement empruntés ou ayant déjà été empruntés <br/>
R8 : Nom des lecteurs ayant effectué au moins un emprunt depuis le début de l’année 2012. <br/>
R9 : Liste des emprunts (titres et dates) réalisés par le lecteur nommé « HAMSI » <br/>
R10 : Liste des emprunts en cours. Pour chaque emprunt, nom du lecteur, titre de l’ouvrage et date d’emprunt. <br/>
R11 : Nombre total d’emprunts enregistrés à ce jour. <br/>
R12 : Ajouter l’ouvrage suivant dans la base : N°40, Titre ouvrage : « Réseaux de neurones », Année de parution : 2004 <br/>
R13 : Enregistrer le retour de l’ouvrage n°17 à la date du jour. La fonction date() retourne la date du système. <br/>
R14 : Supprimer tous les emprunts régularisés (ouvrages restitués) de l’année 2010. <br/>
R15 : Combien reste t-il d’emprunts non régularisés pour l’année 2011 ? <br/>
R16 : Nombre total d’emprunts réalisés par lecteurs.<br/>

Un nouveau lecteur souhaite emprunter un livre sur l’intelligence artificielle. La bibilothèque n’est dispose. Elle le commande pour que ce lecteur puisse l’emprunter dès que possible.<br/>
Comment cela se matérialise dans la base de donnée ?<br/>
R17 : Insérer le nouveau lecteur<br/>
R18 : Insérer le livre <br/>
R19 : Insérer l’emprunt<br/>
R20 :Il y a une faute d’écriture sur le nom de ce client. Corrigez là.<br/>
R21 : On introduit un nouvel attribut à la table lecteur, le nombre de livre autorisé en emprunt. Mettez cette valeur à jour à 4.<br/>
R22 : Une mise à jour de la bibliothèque est nécessaire. Faites sortir du stock tous les livres antérieur à 2000.<br/>

[Télécharger fichier Correction de la base BIBLI :arrow_down:](./data/chap2_corrige_requete_bibli.txt){ .md-button .md-button--primary }

??? question "R1 : Qui est le lecteur n°30 ?"
    ```SQL
    SELECT*
    FROM LECTEUR
    WHERE NumLecteur = 30;
    ```

??? question "R2 : Liste des lecteurs dont le nom de famille commence par la lettre « S »"
    ```SQL
    SELECT*
    FROM LECTEUR
    WHERE NomLecteur LIKE "S*";
    ```

??? question "R3 : Liste des ouvrages qui traitent de la méthode Merise."
    ```SQL
    SELECT*
    FROM OUVRAGE
    WHERE TitreOuvrage LIKE "*Merise*";
    ```

??? question "R4 : Liste des ouvrages qui traitent du « registre » à partir de l’année 2000."
    ```SQL
    SELECT*
    FROM OUVRAGE
    WHERE TitreOuvrage LIKE "*Registre*"
    AND AnneeParution > 2000;
    ```

??? question "R5 : Liste des lecteurs qui portent le nom (ou le prénom) « BERTRAND »"
    ```SQL
    SELECT*
    FROM LECTEUR
    WHERE NomLecteur = "BERTRAND"
    OR PrenomLecteur = "Bertrand";
    ```

??? question "R6 : Quels sont le titre et l’année de parution de l’ouvrage le plus ancien ?"
    ```SQL
    SELECT  TitreOuvrage, AnneeParution
    FROM OUVRAGE
    WHERE AnneeParution = (SELECT MAX(AnneeParution)
    FROM OUVRAGE)
    ORDER BY TitreOuvrage ASC;
    ```

??? question "R7 : Titre des ouvrages actuellement empruntés ou ayant déjà été empruntés"
    ```SQL
    SELECT DISTINCT TitreOuvrage
    FROM OUVRAGE
    INNER JOIN EMPRUNTER
    ON OUVRAGE.NumOuvrage = EMPRUNTER.NumOuvrage
    WHERE DateEmprunt IS NOT NULL; /* La clause WHERE est ici facultative*/
    ```

??? question "R8 : Nom des lecteurs ayant effectué au moins un emprunt depuis le début de l’année 2012."
    ```SQL
    SELECT DISTINCT NomLecteur
    FROM LECTEUR
    INNER JOIN EMPRUNTER
    ON LECTEUR.NumLecteur = EMPRUNTER.NumLecteur
    WHERE DateEmprunt LIKE  "*/*/2012";
    ```

??? question "R9 : Liste des emprunts (titres et dates) réalisés par le lecteur nommé « HAMSI »"
    ```SQL
    SELECT OUVRAGE.TitreOUvrage, OUVRAGE.AnneeParution
    FROM ((LECTEUR
    INNER JOIN EMPRUNTER
    ON LECTEUR.NumLecteur = EMPRUNTER.NumLecteur)
    INNER JOIN OUVRAGE
    ON OUVRAGE.NumOuvrage = EMPRUNTER.NumOuvrage)
    WHERE NomLecteur ="HAMSI";
    ```

??? question "R10 : Liste des emprunts en cours. Pour chaque emprunt, nom du lecteur, titre de l’ouvrage et date d’emprunt."
    ```SQL
    SELECT LECTEUR.NomLecteur, OUVRAGE.TitreOUvrage, EMPRUNTER.DateEmprunt
    FROM ((LECTEUR
    INNER JOIN EMPRUNTER
    ON LECTEUR.NumLecteur = EMPRUNTER.NumLecteur)
    INNER JOIN OUVRAGE
    ON OUVRAGE.NumOuvrage = EMPRUNTER.NumOuvrage)
    WHERE DateRetour IS NULL;
    ```

??? question "R11 : Nombre total d’emprunts enregistrés à ce jour."
    ```SQL
    SELECT COUNT(DateEmprunt) AS NbEmprunt
    FROM EMPRUNTER;
    ```

??? question "R12 : Ajouter l’ouvrage suivant dans la base : N°40, Titre ouvrage : « Réseaux de neurones », Année de parution : 2004"
    ```SQL
    INSERT INTO OUVRAGE (NumOuvrage, TitreOuvrage, AnneeParution )
    VALUES (40,"Réseaux de neurones",2004);
    ```

??? question "  R13 : Enregistrer le retour de l’ouvrage n°17 à la date du jour. La fonction date() retourne la date du système."
    ```SQL
    UPDATE EMPRUNTER 
    SET  DateRetour = Date ()
    WHERE NumOUvrage = 17
    AND DateRetour IS NULL ;
    ```

??? question "R14 : Supprimer tous les emprunts régularisés (ouvrages restitués) de l’année 2010."
    ```SQL
    DELETE FROM EMPRUNTER
    WHERE DateEmprunt LIKE "*/*/2010"
    AND DateRetour IS NOT NULL;
    ```

??? question "R15 : Combien reste t-il d’emprunts non régularisés pour l’année 2011 ?"
    ```SQL
    SELECT COUNT (DateEmprunt) AS NbOK2011
    FROM EMPRUNTER
    WHERE DateEmprunt LIKE "*/*/2011"
    AND DateRetour IS NULL;
    ```

??? question "R16 : Nombre total d’emprunts réalisés par lecteurs."
    ```SQL
    SELECT COUNT(EMPRUNTER.DateEmprunt), LECTEUR.NomLecteur
    FROM EMPRUNTER
    INNER JOIN LECTEUR
    ON LECTEUR.NumLecteur = EMPRUNTER.NumLecteur
    GROUP BY LECTEUR.NomLecteur ;
    ```
 
??? question "R17 : Insérer le nouveau lecteur"
    ```SQL
    INSERT INTO LECTEUR (`numlecteur`, `nomlecteur`, `prenomlecteur`) VALUES
    (13, 'ALAMARD', 'Frédéric') ;
    ```

??? question "R18 : Insérer le livre"
    ```SQL
    INSERT INTO OUVRAGE (`numouvrage`, `titreouvrage`, `anneeparution`) VALUES
    (1, 'Passeport pour l''algorithmique objet', 1998) ;
    ```

??? question "R19 : Insérer l’emprunt"
    ```SQL
    INTO EMPRUNTER (`numlecteur`, `numouvrage`, `dateemprunt`, `dateretour`) VALUES (13, 17, '2012-01-18', NULL) ;
    ```

??? question "R20 :Il y a une faute d’écriture sur le nom de ce client. Corrigez là."
    ```SQL
    UPDATE LECTEUR 
    SET ‘nomlecteur’= ‘ALAMART’
    WHERE ‘nomlecteur’= ‘ALAMARD’ AND `prenomlecteur` = ‘'Frédéric' ;
    ```

??? question "R21 : On introduit un nouvel attribut à la table lecteur, le nombre de livre autorisé en emprunt. Mettez cette valeur à jour à 4."
    ```SQL
    UPDATE LECTEUR 
    SET nbLibreSorti = 4 ;
    ```

??? question "R22 : Une mise à jour de la bibliothèque est nécessaire. Faites sortir du stock tous les livres antérieur à 2000."
    ```SQL
    DELETE FROM OUVRAGE 
    WHERE anneeparution < 2000 ;
    ```




