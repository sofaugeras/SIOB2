# Application base bibliothèque

Exemples : Donner les instructions SQL pour réaliser les traitements qui suivent. On considérera ici que toutes les tables sont vides. 
a) Renommer la table « emprunter » en « emprunt ». 
b) Ajouter un champ TelLecteur (taille 10) à la table des lecteurs. 
c) Ajouter un champ RefLecteur (taille fixe de 8 caractères) juste avant NumLecteur (ce champ deviendra clé primaire par la suite) 

d) Modifier la taille de la colonne NomLecteur pour la passer à 40 caractères. 

e) Supprimer le champ TelLecteur 

f) Indiquer les opérations nécessaires pour supprimer la clé primaire sur NumLecteur et définir RefLecteur comme nouvelle clé primaire. Le champ NumLecteur de la table « emprunt » conservera son nom mais sera lié à RefLecteur de Lecteur. 

 
--Question a
ALTER TABLE EMPRUNTER
RENAME TO EMPRUNT;

--Question b 
ALTER TABLE LECTEUR
ADD TelLecteur INT(10);

-- Question c
ALTER TABLE LECTEUR
ADD RefLecteur CHAR(8) FIRST ;

-- Question d 
ALTER TABLE LECTEUR
MODIFY NomLecteur VARCHAR(40);

-- Question e 
ALTER TABLE LECTEUR
DROP TelLecteur;

--Question f
--> Etape 1 : Supprimmer le lien/clé étrangère
ALTER TABLE EMPRUNT 
DROP FOREIGN KEY FK_emprunter_numlecteur;

--> Etape 2 : supprimmer la clé primaire
ALTER TABLE LECTEUR
DROP PRIMARY KEY;

--> Etape 3 : créer la nouvelle clé primaire de lecteur
ALTER TABLE LECTEUR DROP RefLecteur;
ALTER TABLE LECTEUR ADD RefLecteur INT(11) NOT NULL FIRST;
UPDATE LECTEUR SET RefLecteur = numLecteur ;
ALTER TABLE LECTEUR ADD CONSTRAINT pk_lecteur PRIMARY KEY (`RefLecteur`) ;
--> Etape 4 : Recréer le lien clé étangère
ALTER TABLE EMPRUNT
ADD CONSTRAINT `FK_emprunter_Reflecteur` FOREIGN KEY (`numlecteur`) REFERENCES `lecteur` (`RefLecteur`);
