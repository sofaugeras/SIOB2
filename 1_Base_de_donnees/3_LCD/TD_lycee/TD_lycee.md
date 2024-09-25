# Application Gestion du Lycée Denis Dormand

1)	Vous allez écrire le script qui créé les tables afin de stocker les données suivantes. 
Les clés primaires sont en gras, vous ne gérez pas (pas tout de suite !) les clés étrangères.

Elève
NumEtu	Nom	Prénom	NumCla
E01	Kervadec	Karine	1
E02	Deschamps	Albert	2
E03	Albertini	Michel	1
CLASSE
NumCla	LibelléCla
1	Première A
2	Première B
3	Seconde A

PROFESSEUR
NumProf	Nom	Prénom	Echelon
P01	Rouxel	Monique	4
P02	Deschamps	Corinne	5
P03	Gauthier	Jean-Paul	4

Il y a au maximum :
	99 professeurs
	999 élèves
	15 classes
	10 échelons
Par défaut, l'échelon est à 1.
Les noms et prénoms des deux tables doivent être obligatoirement renseignés.

2)	Ajoutez par script les dates de naissance pour les professeurs et les élèves. Ecrivez le script correspondant.
MATIERE
NumMat	Libellé
M01	Français
M02	Anglais
M03	Histoire-Géographie

3)	Ecrivez la création de la table suivante et insérez par script les données ci-dessous.



Elève_stage
NumEtu	Nom	Prénom	NumCla	Entreprise
E01	Kervadec	Karine	1	StSau
E03	Albertini	Michel	1	Beaumon

4)	Ecrivez la création de la table suivante.


Et insérez (par script) tous les élèves dont le NumCla est 1.
 
5)	Supprimez l’échelon du professeur. Ecrivez le script correspondant.

6)	Imaginez le MLD complet du lycée.
Indiquez l’ordre de création des tables

7)	Complétez votre script afin de rajouter les clés étrangères sous forme de contraintes; les 2 variantes doivent apparaître.

8)	Supprimer la clé étrangère d'Eleve_stagiaire.

9)	Ecrivez le script pour supprimer toutes les tables.
Ecrivez le script pour supprimer la base de données

/*Question 1 */
CREATE TABLE IF NOT EXISTS ETUDIANT(
NumEtu CHAR(3),
NomEtu CHAR(30) NOT NULL,
PrénomEtu CHAR(30) NOT NULL,
NumCla TINYINT
);

CREATE TABLE IF NOT EXISTS CLASSE (
NumCla TINYINT,
LibelléCla CHAR(30) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS PROFESSEUR(
NumProf CHAR(2),
NomProf CHAR(30) NOT NULL,
PrénomProf CHAR(30) NOT NULL,
Echelon TINYINT DEFAULT 1
);

/*Question 2 */
ALTER TABLE Etudiant ADD DateNaisEtu DATETIME;
ALTER TABLE Professeur ADD DateNaisProf DATETIME;

/*Question 3 */
CREATE TABLE MATIERE (
NumMat CHAR(3),
Libellé CHAR(30)
);

INSERT INTO matiere (NumMat, Libellé) VALUES
('M01', 'Francais'),
('M02', 'Anglais'),
('M03', 'Histoire-geographie');

/*Question 4 */
CREATE TABLE IF NOT EXISTS ETUDIANT_stagiaire(
NumEtu CHAR(3),
NomEtu CHAR(30) NOT NULL,
PrénomEtu CHAR(30) NOT NULL,
NumCla TINYINT,
Entreprise Varchar(35) DEFAULT NULL
);
INSERT INTO `etudiant_stagiaire`(`NumEtu`, `NomEtu`, `PrénomEtu`, `NumCla`)
Select `NumEtu`, `NomEtu`, `PrénomEtu`, `NumCla` FROM etudiant WHERE etudiant.numCla = 1;

/*Question 5 */
ALTER TABLE professeur DROP COLUMN Echelon;

/*Question 6 */
CLASSE (NumCla, LibelléCla)
	Clé primaire : NumCla
PROFESSEUR (NumProf, NomProf,PrénomProf, DateNaisProf)
	Clé primaire : NumProf
MATIERE (NumMat, Libellé )
	Clé primaire : NumMat
ETUDIANT (numEtu, NomEtu, PrénomEtu,NumCla, DateNaisEtu)
	Clé primaire : NumEtu
	Clé étrangère : NumMat en référence à NumCla de la table MATIERE
ETUDIANT_STAGIAIRE (numEtu, NomEtu, PrénomEtu,NumCla, Entreprise)
	Clé primaire : NumEtu
	Clé étrangère : NumMat en référence à NumCla de la table MATIERE
COURS (NumCla, NumMat, NumProf)
	Clé primaire : NumCla, NumMat, NumProf
	Clé étrangère : NumCla en référence à NumCla de la table CLASSE
					NumMat en référence à NumMat de la table MATIERE
					NumProf en référence à NumProf de la table PROFESSEUR		
/* Ordre de création des tables 
CLASSE, PROFESSEUR, MATIERE
Puis ETUDIANT et ETUDIANT_STAGIAIRE
Pour finir par COURS
*/
-- On créé la table de relation Cours
CREATE TABLE Cours (
    NumCla TINYINT, 
    NumMat CHAR(3),
    NumProf CHAR(2)
    );
	
/*Question 7 */
-- On ajoute toutes les contraintes de clés primaires
ALTER TABLE Classe 
ADD CONSTRAINT pk_classe PRIMARY KEY (NumCla);
ALTER TABLE professeur 
ADD CONSTRAINT pk_professeur PRIMARY KEY (NumProf);
ALTER TABLE Matiere 
ADD CONSTRAINT pk_matiere PRIMARY KEY (NumMat);
ALTER TABLE Etudiant 
ADD CONSTRAINT pk_etudiant PRIMARY KEY (NumEtu);
ALTER TABLE Etudiant_stagiaire
ADD CONSTRAINT pk_etudiant_stagiaire PRIMARY KEY (NumEtu);
ALTER TABLE cours 
ADD CONSTRAINT pk_cours PRIMARY KEY (NumCla,NumProf,NumMat);
--On ajoute les contraintes de clés étrangères
ALTER TABLE ETUDIANT
ADD CONSTRAINT fk_etudiant_classe FOREIGN KEY (NumCla) REFERENCES  Classe(NumCla);
ALTER TABLE ETUDIANT_STAGIAIRE
ADD CONSTRAINT fk_etudiant_stagiaire_classe FOREIGN KEY (NumCla) REFERENCES  Classe(NumCla);
ALTER TABLE COURS
ADD CONSTRAINT fk_cours_classe FOREIGN KEY (NumCla) REFERENCES  Classe(NumCla);
ALTER TABLE COURS
ADD CONSTRAINT fk_cours_mat FOREIGN KEY (NumMat) REFERENCES  Classe(NumMat);
ALTER TABLE COURS
ADD CONSTRAINT fk_cours_professeur FOREIGN KEY (NumProf) REFERENCES  Classe(NumProf);

/*Question 8 */
ALTER TABLE Etudiant_stagiaire 
DROP FOREIGN KEY fk_etudiant_stagiaire_classe;
-- Note : MySQL ne supporte pas le DROP CONSTRAINT

/*Question 9 */
DROP TABLE Etudiant_stagiaire ;
-- ETC ...