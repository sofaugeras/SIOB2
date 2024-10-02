# Application base bibliothèque

![base bibliothèque](../2_LMD/data/bibli.png)

[Télécharger fichier Création de la base BIBLI :arrow_down:](./data/script_creation_bibli.sql){ .md-button .md-button--primary }

Donner les instructions SQL pour réaliser les traitements qui suivent. On considérera ici que toutes les tables sont vides. 

- M1 : Renommer la table « emprunter » en « emprunt ». 
- M2 : Ajouter un champ TelLecteur (taille 10) à la table des lecteurs. 
- M3 : Ajouter un champ RefLecteur (taille fixe de 8 caractères) juste avant NumLecteur (ce champ deviendra clé primaire par la suite) 
- M4 : Modifier la taille de la colonne NomLecteur pour la passer à 40 caractères. 
- M5 : Supprimer le champ TelLecteur 
- M6 : Indiquer les opérations nécessaires pour supprimer la clé primaire sur NumLecteur et définir RefLecteur comme nouvelle clé primaire. Le champ NumLecteur de la table « emprunt » conservera son nom mais sera lié à RefLecteur de Lecteur. 

 
!!! question "M1" 
    === "Enoncé"
        Renommer la table « emprunter » en « emprunt ». 
    
    === "Requête"

		```SQL
		ALTER TABLE EMPRUNTER
        RENAME TO EMPRUNT;
		```

!!! question "M2" 
    === "Enoncé"
        Ajouter un champ TelLecteur (type entier) à la table des lecteurs. 
    
    === "Requête"

		```SQL
		ALTER TABLE LECTEUR
        ADD TelLecteur INT;
        /*ou*/
        ALTER TABLE LECTEUR
        ADD TelLecteur INT;
		```

!!! question "M3" 
    === "Enoncé"
        Ajouter un champ RefLecteur (taille fixe de 8 caractères) juste avant NumLecteur (ce champ deviendra clé primaire par la suite) 
    
    === "Requête"

		```SQL
		ALTER TABLE LECTEUR
        ADD RefLecteur CHAR(8) FIRST ;
		```

!!! question "M4" 
    === "Enoncé"
        Modifier la taille de la colonne NomLecteur pour la passer à 40 caractères. 
    
    === "Requête"

		```SQL
		ALTER TABLE LECTEUR
        MODIFY NomLecteur VARCHAR(40);
        ```

!!! question "M5"
    === "Enoncé"
        Supprimer le champ TelLecteur 
    
    === "Requête"

		```SQL
		ALTER TABLE LECTEUR
        DROP TelLecteur;
        ```

!!! question "M6"
    === "Enoncé"
        Indiquer les opérations nécessaires pour supprimer la clé primaire sur NumLecteur et définir RefLecteur comme nouvelle clé primaire. Le champ NumLecteur de la table « emprunt » conservera son nom mais sera lié à RefLecteur de Lecteur. 
    
    === "Requête"

		```SQL
        /* Etape 1 : Supprimmer le lien/clé étrangère */
        ALTER TABLE EMPRUNT 
        DROP FOREIGN KEY FK_emprunter_numlecteur;

        /* Etape 2 : supprimmer la clé primaire */
        ALTER TABLE LECTEUR
        DROP PRIMARY KEY;

        /* Etape 3 : créer la nouvelle clé primaire de lecteur */
        ALTER TABLE LECTEUR DROP RefLecteur;
        ALTER TABLE LECTEUR ADD RefLecteur INT(11) NOT NULL FIRST;
        UPDATE LECTEUR SET RefLecteur = numLecteur ;
        ALTER TABLE LECTEUR ADD CONSTRAINT pk_lecteur PRIMARY KEY (`RefLecteur`) ;

        /* Etape 4 : Recréer le lien clé étangère*/
        ALTER TABLE EMPRUNT
        ADD CONSTRAINT `FK_emprunter_Reflecteur` FOREIGN KEY (`numlecteur`) REFERENCES `lecteur` (`RefLecteur`);
        ```

