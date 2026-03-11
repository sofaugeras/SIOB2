# Exercices

## Exercice 1

Le trigger suivant interdit la modification des commandes

??? question "Correction"

    ```sql
    DELIMITER //
    CREATE TRIGGER Tr_Empecher_Modif
    BEFORE UPDATE ON Commande
    FOR EACH ROW
    BEGIN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La modification des commandes est interdite';
    END //
    DELIMITER ;
    ```

## Exercice 2

Le trigger suivant interdit la modification du numéro de commande et vérifie si la date saisie pour la date de commande est supérieure ou égale à la date du jour

??? question "Correction"

    ```sql
    DELIMITER //
    CREATE TRIGGER Tr_Empecher_Modif_Numcom
    BEFORE UPDATE ON Commande
    FOR EACH ROW
    BEGIN
        IF NEW.NumCom <> OLD.NumCom THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Le numéro de commande ne peut être modifié';
        END IF;

        IF NEW.DatCom <> OLD.DatCom THEN
            IF NEW.DatCom < CURDATE() THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'La date de commande ne peut pas être inférieure à la date en cours';
            END IF;
        END IF;
    END //
    DELIMITER ;
    ```

## Exercice 3

Le trigger suivant empêche la suppression des commandes ayant des articles associés
Remarque : Ce trigger ne se déclenchera pas s'il existe une contrainte clé étrangère entre le champ NumCom de la table ligneCommande et le champ NumCom de la table commande.

??? question "Correction"

    ```sql
    DELIMITER //
    CREATE TRIGGER Tr_Empecher_Suppr
    BEFORE DELETE ON Commande
    FOR EACH ROW
    BEGIN
        DECLARE nb INT;
        SELECT COUNT(numart) INTO nb
        FROM lignecommande
        WHERE lignecommande.numcom = OLD.numcom;

        IF nb > 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Opération annulée. Une ou plusieurs commandes ont des articles enregistrés';
        END IF;
    END //
    DELIMITER ;
    ```

## Exercice 4

Le trigger suivant à l'ajout d'une ligne de commande vérifie si les quantités sont disponibles et met le stock à jour

??? question "Correction"

    ```sql
    DELIMITER //
    CREATE TRIGGER Tr_Ajouter_Ligne
    BEFORE INSERT ON LigneCommande
    FOR EACH ROW
    BEGIN
        DECLARE stock INT;
        SELECT QteEnStock INTO stock
        FROM article
        WHERE article.numart = NEW.numart;

        IF NEW.QteCommandee > stock THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Ajout refusé. Quantités demandées non disponibles en stock';
        ELSE
            UPDATE article
            SET QteEnStock = QteEnStock - NEW.QteCommandee
            WHERE NumArt = NEW.NumArt;
        END IF;
    END //
    DELIMITER ;
    ```

## Exercice 5

Le trigger suivant à la modification d'une ligne de commande vérifie si les quantités sont disponibles et met le stock à jour

??? question "Correction"

    ```sql
    DELIMITER //
    CREATE TRIGGER Tr_Modifier_Ligne
    BEFORE UPDATE ON LigneCommande
    FOR EACH ROW
    BEGIN
        DECLARE stock INT;
        SELECT QteEnStock INTO stock
        FROM article
        WHERE article.numart = NEW.numart;

        IF NEW.QteCommandee > stock + OLD.QteCommandee THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Modification refusée. Quantités demandées non disponibles en stock';
        ELSE
            UPDATE article
            SET QteEnStock = QteEnStock + OLD.QteCommandee - NEW.QteCommandee
            WHERE NumArt = NEW.NumArt;
        END IF;
    END //
    DELIMITER ;
    ```
    *Remarque :* Si le trigger déclenché effectue une opération sur une autre table, les triggers associés à cette
    table sont alors déclenchés (principe de cascade)
