# Exercices

## Exercice 1
Créer une procédure stockée nommée `SP_ListeArticles` qui affiche la liste des articles d'une commande dont le numéro est donné en paramètre 

??? question "Correction"

    ```sql
    DELIMITER |
    CREATE PROCEDURE SP_ListeArticles (IN NumCom INT)
    BEGIN
        SELECT A.NumArt, NomArt, PUArt, QteCommandee
        FROM Article A, LigneCommande LC
        WHERE LC.NumArt = A.NumArt
        AND LC.NumCom = NumCom;
    END |
    DELIMITER ;

    -- Exécuter cette procédure pour afficher la liste des articles de la commande numéro 1 :
    CALL SP_ListeArticles(1);

    -- Ou avec une variable :
    SET @nc = 1;
    CALL SP_ListeArticles(@nc);
    ```

## Exercice 2 

Créer une procédure stockée nommée `SP_NbrCommandes` qui retourne le nombre de commandes 

??? question "Correction"

    ```sql
    DELIMITER |
    CREATE PROCEDURE SP_NbrCommandes (OUT Nbr INT)
    BEGIN
        SET Nbr = (SELECT COUNT(NumCom) FROM Commande);
    END |
    DELIMITER ;

    -- Exécuter cette procédure pour afficher le nombre des commandes :
    CALL SP_NbrCommandes(@n);
    SELECT CONCAT('Le nombre de commandes : ', @n);
    ```

## Exercice 3

Créer une procédure stockée nommée `SP_NbrArtCom` qui retourne le nombre d'articles d'une commande dont le numéro est donné en paramètre 

??? question "Correction"

    ```sql
    DELIMITER |
    CREATE PROCEDURE SP_NbrArtCom (IN Num INT, OUT Nbr INT)
    BEGIN
        SELECT COUNT(NumArt) INTO Nbr
        FROM LigneCommande
        WHERE NumCom = Num;
    END |
    DELIMITER ;

    -- Exécuter cette procédure pour afficher le nombre d'articles de la commande numéro 1 :
    CALL SP_NbrArtCom(1, @n);
    SELECT CONCAT('Le nombre d\'articles de la commande numéro 1 est : ', @n);

    -- Ou avec une variable :
    SET @nc = 1;
    CALL SP_NbrArtCom(@nc, @n);
    SELECT CONCAT('Le nombre d\'articles de la commande numéro ', @nc, ' est : ', @n);
    ```

## Exercice 4
Créer une procédure stockée `SP_NbrArticlesParCommande` qui calcule le nombre d'articles par commande

??? question "Correction"

    ```sql
    DELIMITER |
    CREATE PROCEDURE SP_NbrArticlesParCommande ()
    BEGIN
        SELECT Commande.NumCom, DatCom, COUNT(NumArt)
        FROM Commande, LigneCommande
        WHERE Commande.NumCom = LigneCommande.NumCom
        GROUP BY Commande.NumCom, DatCom;
    END |
    DELIMITER ;

    -- Exécuter cette procédure :
    CALL SP_NbrArticlesParCommande();
    ```

## Exercice 5

Créer une procédure stockée nommée `SP_ComPeriode` qui affiche la liste des commandes effectuées entre deux dates données en paramètre 

??? question "Correction"

    ```sql
    DELIMITER |
    CREATE PROCEDURE SP_ComPeriode (IN dateD DATE, IN dateF DATE)
    BEGIN
        SELECT * FROM Commande
        WHERE datcom BETWEEN dateD AND dateF;
    END |
    DELIMITER ;

    -- Exécuter cette procédure pour afficher la liste des commandes effectuées entre le
    -- 10/10/2006 et le 14/12/2006 :
    CALL SP_ComPeriode('2006-10-10', '2006-12-14');

    -- Ou avec des variables :
    SET @dd = '2006-10-10';
    SET @df = '2006-12-14';
    CALL SP_ComPeriode(@dd, @df);
    ```

## Exercice 6

Créer une procédure stockée nommée `SP_TypeComPeriode` qui affiche la liste des commandes effectuées entre deux dates passées en paramètres. En plus si le nombre de ces commandes est supérieur à 100, afficher *Période rouge*. Si le nombre de ces commandes est entre 50 et 100 afficher *Période jaune* sinon afficher *Période blanche* (exploiter la procédure précédente)

??? question "Correction"

    ```sql
    DELIMITER |
    CREATE PROCEDURE SP_TypeComPeriode (IN dateD DATE, IN dateF DATE)
    BEGIN
        CALL SP_ComPeriode(dateD, dateF);

        SET @nbr = (SELECT COUNT(NumCom) FROM Commande
                    WHERE datcom BETWEEN dateD AND dateF);

        IF @nbr > 100 THEN
            SELECT 'Période Rouge' AS periode;
        ELSE
            IF @nbr < 50 THEN
                SELECT 'Période Blanche' AS periode;
            ELSE
                SELECT 'Période Jaune' AS periode;
            END IF;
        END IF;
    END |
    DELIMITER ;
    ```

## Exercice 7

Créer une procédure stockée nommée `SP_EnregistrerLigneCom` qui reçoit un numéro de commande, un numéro d'article et la quantité commandée :<br />
- Si l'article n'existe pas ou si la quantité demandée n'est pas disponible afficher un message d'erreur <br />
- Si la commande introduite en paramètre n'existe pas, la créer <br />
- Ajoute ensuite la ligne de commande et met le stock à jour

??? question "Correction"

    ```sql
    DELIMITER |
    CREATE PROCEDURE SP_EnregistrerLigneCom (IN numCom INT, IN numart INT, IN qte DECIMAL)
    BEGIN
        -- Vérification de l'existence de l'article et de la disponibilité du stock
        IF NOT EXISTS (SELECT numart FROM article WHERE numart = numart)
            OR (SELECT QteEnStock FROM article WHERE numart = numart) < qte THEN
            SELECT 'Cet article n\'existe pas ou le stock est insuffisant' AS message;
        ELSE
            START TRANSACTION;

            -- Création de la commande si elle n'existe pas
            IF NOT EXISTS (SELECT numcom FROM Commande WHERE numCom = numCom) THEN
                INSERT INTO commande VALUES (numCom, NOW());
            END IF;

            -- Ajout de la ligne de commande et mise à jour du stock
            INSERT INTO ligneCommande VALUES (numCom, numart, qte);
            UPDATE article SET QteEnStock = QteEnStock - qte WHERE NumArt = numart;

            COMMIT;
        END IF;
    END |
    DELIMITER ;
    ```
