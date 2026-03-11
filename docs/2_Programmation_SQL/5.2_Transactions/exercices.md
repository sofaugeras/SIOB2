# Exercice

**Objectif 🎯 :**  Sécuriser une insertion avec une transaction

## Contexte

On travaille sur la base `gescom` dont voici le schéma :

```sql
USE gescom;

CREATE TABLE COMMANDE (
    Numcom INT PRIMARY KEY,
    Datcom DATETIME
) ENGINE=InnoDB;

CREATE TABLE ARTICLE (
    Numart     INT PRIMARY KEY,
    Desart     VARCHAR(50),
    PUart      DECIMAL(10,2),
    QteEnStock INT,
    SeuilMin   INT,
    SeuilMax   INT
) ENGINE=InnoDB;

CREATE TABLE LIGNECOMMANDE (
    Numcom       INT,
    Numart       INT,
    QteCommandee INT,
    CONSTRAINT pk_lc     PRIMARY KEY (Numcom, Numart),
    CONSTRAINT fk_lc_com FOREIGN KEY (Numcom) REFERENCES COMMANDE(Numcom),
    CONSTRAINT fk_lc_art FOREIGN KEY (Numart) REFERENCES ARTICLE(Numart)
) ENGINE=InnoDB;
```

## Etape 1 — Analyse du script sans transaction

Voici un script qui insère un jeu de données dans la base `gescom`. Ce script contient **une erreur volontaire** qui provoquera une interruption en cours d'exécution.

**Exécutez ce script tel quel**, observez ce qui se passe, puis répondez aux questions.

```sql
USE gescom;

-- Insertion de deux articles
INSERT INTO ARTICLE VALUES (1, 'Clavier', 29.90, 100, 10, 200);
INSERT INTO ARTICLE VALUES (2, 'Souris',  19.90,  80, 10, 150);

-- Insertion d'une commande
INSERT INTO COMMANDE VALUES (1001, '2024-03-01 09:00:00');

-- Insertion de lignes de commande pour la commande 1001
INSERT INTO LIGNECOMMANDE VALUES (1001, 1, 3);
INSERT INTO LIGNECOMMANDE VALUES (1001, 2, 5);
INSERT INTO LIGNECOMMANDE VALUES (9999, 1, 2);

-- Insertion d'une seconde commande et de ses lignes
INSERT INTO COMMANDE VALUES (1002, '2024-03-02 14:00:00');
INSERT INTO LIGNECOMMANDE VALUES (1002, 1, 1);
INSERT INTO LIGNECOMMANDE VALUES (1002, 2, 4);
```

**Questions :**

1. Quelle instruction provoque l'erreur ? Pour quelle raison ?
2. Vérifiez l'état de la base après exécution. Quelles données ont été insérées ? Lesquelles sont manquantes ?
3. La base est-elle dans un état cohérent ? Justifiez.

??? question "Correction"

    **1. Instruction fautive**

    ```sql
    INSERT INTO LIGNECOMMANDE VALUES (9999, 1, 2);
    ```
    La commande numéro `9999` n'existe pas dans la table `COMMANDE`. La contrainte de clé étrangère `fk_lc_com` est violée : MySQL rejette l'insertion et lève une erreur.

    **2. État de la base après exécution**

    Les instructions exécutées *avant* l'erreur ont été validées automatiquement (MySQL est en mode `autocommit = 1` par défaut) :

    | Table          | Données insérées                        |
    |----------------|-----------------------------------------|
    | ARTICLE        | Articles 1 et 2 ✔                       |
    | COMMANDE       | Commande 1001 ✔                         |
    | LIGNECOMMANDE  | Lignes (1001,1) et (1001,2) ✔           |
    | COMMANDE       | Commande 1002 ✘ (non atteinte)          |
    | LIGNECOMMANDE  | Lignes de 1002 ✘ (non atteintes)        |

    **3. Cohérence de la base**

    La base est **partiellement incohérente** : la commande `1002` et ses lignes n'ont pas été insérées à cause de l'arrêt du script. Si ce script représentait une opération métier complète, le résultat est incomplet et potentiellement trompeur.

---

## Etape 2 — Sécurisation avec une transaction

Réécrivez le script précédent en l'encadrant avec les instructions transactionnelles adaptées, de façon à ce que :

- Si **toutes** les insertions réussissent → les données sont validées (`COMMIT`)
- Si **une seule** insertion échoue → **toutes** les insertions sont annulées (`ROLLBACK`)

!!! tip "Indice"
    Pensez à désactiver l'autocommit ou à utiliser `START TRANSACTION` avant vos insertions.

??? question "Correction"

    ```sql
    USE gescom;

    START TRANSACTION;

    -- Insertion de deux articles
    INSERT INTO ARTICLE VALUES (1, 'Clavier', 29.90, 100, 10, 200);
    INSERT INTO ARTICLE VALUES (2, 'Souris',  19.90,  80, 10, 150);

    -- Insertion d'une commande
    INSERT INTO COMMANDE VALUES (1001, '2024-03-01 09:00:00');

    -- Insertion de lignes de commande pour la commande 1001
    INSERT INTO LIGNECOMMANDE VALUES (1001, 1, 3);
    INSERT INTO LIGNECOMMANDE VALUES (1001, 2, 5);

    -- ⚠️ ERREUR VOLONTAIRE : la commande 9999 n'existe pas (violation de clé étrangère)
    INSERT INTO LIGNECOMMANDE VALUES (9999, 1, 2);

    -- Insertion d'une seconde commande et de ses lignes
    INSERT INTO COMMANDE VALUES (1002, '2024-03-02 14:00:00');
    INSERT INTO LIGNECOMMANDE VALUES (1002, 1, 1);
    INSERT INTO LIGNECOMMANDE VALUES (1002, 2, 4);

    COMMIT;
    ```

    Avec `START TRANSACTION`, aucune donnée n'est écrite définitivement avant le `COMMIT`. Lorsque l'erreur sur `LIGNECOMMANDE (9999, 1, 2)` survient, MySQL interrompt le script. Le `COMMIT` n'est jamais atteint.

    En exécutant ensuite un `ROLLBACK` (ou en fermant la session), **toutes les insertions précédentes sont annulées**. La base reste vide et cohérente.

    ```sql
    -- À exécuter après l'erreur pour annuler toutes les insertions :
    ROLLBACK;

    -- Vérification : les tables doivent être vides
    SELECT * FROM ARTICLE;
    SELECT * FROM COMMANDE;
    SELECT * FROM LIGNECOMMANDE;
    ```

## Etape 3 — Validation

Corrigez maintenant le script en **supprimant l'instruction fautive** et relancez-le dans une transaction. Vérifiez que toutes les données sont bien insérées après le `COMMIT`.

??? question "Correction"

    ```sql
    USE gescom;

    START TRANSACTION;

    -- Insertion des articles
    INSERT INTO ARTICLE VALUES (1, 'Clavier', 29.90, 100, 10, 200);
    INSERT INTO ARTICLE VALUES (2, 'Souris',  19.90,  80, 10, 150);

    -- Commande 1001 et ses lignes
    INSERT INTO COMMANDE VALUES (1001, '2024-03-01 09:00:00');
    INSERT INTO LIGNECOMMANDE VALUES (1001, 1, 3);
    INSERT INTO LIGNECOMMANDE VALUES (1001, 2, 5);

    -- Commande 1002 et ses lignes
    INSERT INTO COMMANDE VALUES (1002, '2024-03-02 14:00:00');
    INSERT INTO LIGNECOMMANDE VALUES (1002, 1, 1);
    INSERT INTO LIGNECOMMANDE VALUES (1002, 2, 4);

    -- Validation de toutes les insertions
    COMMIT;

    -- Vérification
    SELECT * FROM ARTICLE;
    SELECT * FROM COMMANDE;
    SELECT * FROM LIGNECOMMANDE;
    ```

    Toutes les insertions sont maintenant validées en une seule opération atomique. Si une erreur survenait à n'importe quelle étape, un `ROLLBACK` ramènerait la base à son état initial, garantissant l'intégrité des données.

    !!! success "Principe clé"
        Une transaction garantit le principe du **tout ou rien** : soit toutes les opérations réussissent et sont validées ensemble, soit aucune ne l'est. C'est le fondement de l'intégrité transactionnelle.
