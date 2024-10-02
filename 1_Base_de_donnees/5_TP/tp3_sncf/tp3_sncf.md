# TP3 Contexte SNCF

![gif](./data/tp3/99Ug.gif){: width=50% .center}

Soient les relations suivantes :<br />

**GARE** (^^CodeGare^^, NomGare, NomVille)<br />
**TRAIN** (^^NumTrain^^, #CodGareDep, #CodGareArr, Hdep, Harr, CodTrf)<br />
**COMPOSITION** (^^#NumTrain, DatDep^^, Ass1, Ass2, Cch1, Cch2)<br />
**EXCEPTION** (^^#NumTrain, DatDep^^)<br />


:arrow_forward: **CodTrf** : Code trafic (Q: quotidien, D: samedi, dimanche et fêtes)<br />
:arrow_forward: **Ass1, Ass2** : nombre de wagons place assise en 1° classe et 2°classe<br />
:arrow_forward: **Cch1, Cch2** : nombre de wagons couchette en 1° classe et 2° classe<br />
:arrow_forward: La présence d'un tuple dans l'objet **EXCEPTION** indique que le train ne roulera pas ce jour là, quel que soit son code trafic.

```SQL
CREATE DATABASE IF NOT EXISTS sncf ;
```

??? info "Complément de cours"

    **Expression de contraintes d'intégrité** <br />
    Une contrainte d'intégrité est une clause permettant de contraindre la modification de tables, faite par l'intermédiaire de requêtes d'utilisateurs, afin que les données saisies dans la base soient conformes aux données attendues. Ces contraintes doivent être exprimées dès la création de la table grâce aux mots clés suivants : 

        ```SQL
        CONSTRAINT 
        DEFAULT 
        NOT NULL 
    	UNIQUE 
    	CHECK 
        ```

    ** Définir une valeur par défaut**<br />
    Le langage SQL permet de définir une valeur par défaut lorsqu'un champ de la base n'est pas renseigné grâce à la clause ``DEFAULT``. Cela permet notamment de faciliter la création de tables, ainsi que de garantir qu'un champ ne sera pas vide. 
    La clause ``DEFAULT`` doit être suivie par la valeur à affecter. Cette valeur peut être un des types suivants : <br />

        - constante numérique 
        - constante alphanumérique (chaîne de caractères) 
        - le mot clé ``USER`` (nom de l'utilisateur) 
        - le mot clé ``NULL`` 
        - le mot clé ``CURRENT_DATE`` (date de saisie) 
        - le mot clé ``CURRENT_TIME`` (heure de saisie) 
        - le mot clé ``CURRENT_TIMESTAMP`` (date et heure de saisie) 

    **Forcer la saisie d'un champ**<br />
    Le mot clé ``NOT NULL`` permet de spécifier qu'un champ doit être saisi, c'est-à-dire que le SGBD refusera d'insérer des tuples dont un champ comportant la clause ``NOT NULL`` n'est pas renseigné. <br />

    **Emettre une condition sur un champ**<br />
    Il est possible de faire un test sur un champ grâce à la clause ``CHECK()`` comportant une condition logique portant sur une valeur entre les parenthèses. Si la valeur saisie est différente de ``NULL``, le SGBD va effectuer un test grâce à la condition logique. Celui-ci peut évenutellement être une condition avec des ordres ``SELECT...`` <br />

    **Tester l'unicité d'une valeur**<br />
    La clause ``UNIQUE`` permet de vérifier que la valeur saisie pour un champ n'existe pas déjà dans la table. Cela permet de garantir que toutes les valeurs d'une colonne d'une table seront différentes. 


**R1 :** Créez les tables correspondantes.:warning: L'ordre de création des tables doit être cohérent.

??? question "Correction"

    [Télécharger fichier Création de la base :arrow_down:](./data/tp5/sncf.sql){ .md-button .md-button--primary }

**R2 :** Ajoutez au moins un enregistrement par table. :warning: L’ordre des ajouts doit être cohérent.

??? question "Correction"
    
    [Télécharger fichier Création de la base :arrow_down:](./data/tp5/sncf_insert.sql){ .md-button .md-button--primary }

**R3 :** Supprimez la clé primaire d’EXCEPTION. (puis remettez-la :innocent:)

??? question "Correction"

    ```SQL
    ALTER TABLE EXCEPTION
        DROP FOREIGN KEY fk_trainExcep ;

    ALTER TABLE EXCEPTION
        DROP PRIMARY KEY ;

    --Pour les remettre
    ALTER TABLE EXCEPTION
        ADD CONSTRAINT pk_exception PRIMARY KEY (numTrain, dateDep);
    
    ALTER TABLE EXCEPTION
        ADD CONSTRAINt fk_trainExcep FOREIGN KEY (numTrain)  REFERENCES TRAIN(numTrain) ;
    ```

**R4 :** Ajoutez le tuple (‘5’, ‘Montparnasse’, ‘Paris’) dans GARE.

??? question "Correction"

    ```SQL
    INSERT INTO gare (codeGare, nomGare, nomVille) VALUES 
    ('5', 'Montparnasse', 'Paris');
    ```

**R5 :** Ajoutez deux trains partant de la gare ‘5’.

??? question "Correction"

    ```SQL
    INSERT INTO `train` (`numTrain`, `codeGareDep`, `CodeGareARR`, `HDep`, `HArr`, `CodeTrf`) VALUES 
        ('133', '5', '3', '2024-10-01 11:41:44', '2024-10-01 15:41:44', 'Q'),
        ('134', '5', '1', '2024-10-01 11:41:44', '2024-10-01 15:41:44', 'Q');
    ```

**R6 :** Modifiez le tuple (‘5’, ‘Montparnasse’, ‘Paris’) en (‘5’, ‘Paris Montparnasse’, ‘Paris’), quelles sont les mises à jour à effectuer sur la base ?

??? question "Correction"

    ```SQL
    UPDATE gare SET nomGare = 'Paris Montparnasse' WHERE gare.codeGare = 5; 
    ```

**R7 :** Modifiez le tuple (‘5’, ‘Paris Montparnasse’, ‘Paris’) en (‘15’, ‘Paris Montparnasse’, ‘Paris’), quelles sont les mises à jour à effectuer sur la base ?

??? question "Correction"

    ```SQL
    
    ```

**R8 :** Créez un jeu de donnée pour des trains partant de Questembert. 
Puis modifiez les données pour que Tous les trains qui partent de Questembert soient de type quotidien.

??? question "Correction"
    ```SQL
    
    ```

**R9 :** Effacez tous les enregistrements de TRAIN. Quelles instructions complémentaires faut-il rajouter ?

??? question "Correction"
    ```SQL
    
    ```

**R10 :** Effacez tous les enregistrements de TRAIN qui partent de Rennes. Pas de données dans les tables connexes. Quelles informations vous manquent-t-il ? Réalisez le script en imaginant la(les) valeur(s) souhaitée(s).

??? question "Correction"
    ```SQL
    
    ```

**R11 :** Effacez tous les enregistrements de TRAIN en supposant que ce soit la seule table remplie avec GARE

??? question "Correction"
    ```SQL
    
    ```

**R12 :** Supprimez la table TRAIN en supposant que les tables connexes soient remplies.

??? question "Correction"
    ```SQL
    
    ```

