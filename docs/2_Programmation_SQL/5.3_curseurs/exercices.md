# Exercices

## Exercice 1
Ecrire un programme qui pour chaque commande affiche le numéro et la date de commande sous la forme : <br />
*Commande N° : …… Effectuée le : …Pour un montant de …*

??? question "Correction"

    ```sql
    DELIMITER |
    CREATE PROCEDURE afficher_commandes()
    BEGIN
        DECLARE v_numCom INT;
        DECLARE v_datCom DATE;
        DECLARE v_montant DECIMAL(10,2);
        DECLARE fin INT DEFAULT 0;

        DECLARE cur_commandes CURSOR FOR
            SELECT C.NumCom, DatCom, SUM(QteCommandee * PUArt) AS montant
            FROM Commande C, LigneCommande LC, Article A
            WHERE C.NumCom = LC.NumCom
            AND LC.NumArt = A.NumArt
            GROUP BY C.NumCom, DatCom;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

        OPEN cur_commandes;

        boucle: LOOP
            FETCH cur_commandes INTO v_numCom, v_datCom, v_montant;
            IF fin = 1 THEN
                LEAVE boucle;
            END IF;
            SELECT CONCAT(
                'Commande N° : ', v_numCom,
                ' Effectuée le : ', DATE_FORMAT(v_datCom, '%d/%m/%Y'),
                ' Pour un montant de : ', v_montant, ' €'
            ) AS resultat;
        END LOOP;

        CLOSE cur_commandes;
    END |
    DELIMITER ;

    CALL afficher_commandes();
    ```

## Exercice 2
Ecrire un programme qui pour chaque commande vérifie si cette commande a au moins un article. Si c'est le cas affiche son numéro et la liste de ses articles sinon affiche un message d'erreur (Attention ce cours ne contient pas la gestion des erreurs) :<br />
*Aucun article pour la commande …. Elle sera supprimée et supprime cette commande*

??? question "Correction"

    ```sql
    DELIMITER |
    CREATE PROCEDURE verifier_commandes()
    BEGIN
        DECLARE v_numCom INT;
        DECLARE v_nbArt INT;
        DECLARE fin INT DEFAULT 0;

        DECLARE cur_commandes CURSOR FOR
            SELECT NumCom FROM Commande;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

        OPEN cur_commandes;

        boucle: LOOP
            FETCH cur_commandes INTO v_numCom;
            IF fin = 1 THEN
                LEAVE boucle;
            END IF;

            -- Compter le nombre d'articles pour cette commande
            SELECT COUNT(NumArt) INTO v_nbArt
            FROM LigneCommande
            WHERE NumCom = v_numCom;

            IF v_nbArt > 0 THEN
                -- Afficher le numéro de commande et la liste de ses articles
                SELECT CONCAT('Commande N° : ', v_numCom) AS commande;
                SELECT LC.NumArt, DesArt, PUArt, QteCommandee
                FROM LigneCommande LC, Article A
                WHERE LC.NumArt = A.NumArt
                AND LC.NumCom = v_numCom;
            ELSE
                -- Afficher le message d'erreur et supprimer la commande
                SELECT CONCAT(
                    'Aucun article pour la commande ', v_numCom,
                    '. Elle sera supprimée.'
                ) AS message;
                DELETE FROM Commande WHERE NumCom = v_numCom;
            END IF;

        END LOOP;

        CLOSE cur_commandes;
    END |
    DELIMITER ;

    CALL verifier_commandes();
    ```
