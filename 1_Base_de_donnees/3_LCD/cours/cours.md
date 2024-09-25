# Langage de description des données

## 1. Introduction 

Dans le précédant chapitre, nous avons étudié les commandes ``SQL`` qui permettent d’interroger et de mettre à jour une base de données. Ces commandes appartiennent au langage de manipulation de données (LMD). Dans ce chapitre, nous étudierons le **langage de description de données** (LDD). Ce langage représente l’ensemble des instructions ``SQL`` qui permettent la création et la modification de la structure de bases de données. <br />
La conception d’une base de données, comme tout objet technique, nécessite une phase de conception. Concernant les données, cette étape consiste à modéliser à l’aide de schémas le système d’information étudié. De ce schéma on déduit le schéma relationnel que nous avons abordé dans les précédents chapitres.
>Le schéma relationnel est « universel » et ne dépend pas du SGBDR utilisé. C’est un peu le même principe concernant les algorithmes et leur mise en œuvre dans tel ou tel langage. 


:warning: Le ``SQL`` lié au LDD possède plus de variations syntaxiques lié au SGBD. La plupart des instructions se retrouvent mais leur syntaxe diffère parfois. Il est nécessaire de consulter la documentation. Dans ce cours nous aborderons la syntaxe de MySQL .
 
## 2. Présentation du thème 

Pour illustrer les commandes de base du langage de description des données, nous utiliserons la base de données bibliothèque du chapitre LMD. Pour rappel, voici les différentes représentations possibles de son schéma relationnel :

### Représentation graphique 

![representation graphique base bibli](./data/lecteur.png)

### Représentation en intention 

**LECTEUR**(^^NumLecteur^^, NomLecteur, PrenomLecteur) 
**OUVRAGE**(^^NumOuvrage^^, TitreOuvrage, AnneeParution) 
**EMPRUNTER**(^^#NumLecteur, #NumOuvrage, DateEmprunt^^, DateRetour) 

### Représentation en intention détaillée 

**LECTEUR**(NumLecteur, NomLecteur, PrenomLecteur) 
> NumLecteur : Clé primaire 

**OUVRAGE**(NumOuvrage, TitreOuvrage, AnneeParution) 
> NumOuvrage : Clé primaire 

**EMPRUNTER**(NumLecteur, NumOuvrage, DateEmprunt, DateRetour) 
> NumLecteur, NumOuvrage, DateEmprunt : Clé primaire 
> NumLecteur : Clé étrangère en référence à NumLecteur de LECTEUR 
> NumOuvrage : Clé étrangère en référence à NumOuvrage de OUVRAGE

Comme vous le constaterez par la suite, la représentation détaillée est très proche de ce que l’on retrouvera pour créer une table en SQL. Elle permet également de mettre en avant sans ambiguïté des liens entre tables à partir de champs ne portant pas le même nom dans l'intégrité référentielle. 
 
## 2. Les types de données 

En programmation, lorsque l’on déclare une variable, la plupart des langages nécessitent que l’on précise son type (Entier, Chaîne de caractères…) On parle alors de typage explicite. En SQL, le type des colonnes doit obligatoirement être renseigné. 

### 2.1 Les types numériques 

##### 2.1.1	Types numériques exacts 

**Les types « Entier » **

Le tableau ci-dessous présente les intervalles de valeurs en fonction des types entiers proposés par ``MySQL`` :
|Type| 	Octets |	De |	A |
|TINYINT| 	1 |	-128 |	127 |
|SMALLINT| 	2 |	-32768 |	32767| 
|MEDIUMINT| 	3 |	-8388608 |	8388607| 
|INT (ou INTEGER)| 	4 |	-2147483648 |	2147483647 |
|BIGINT| 	8 |	-9223372036854775808 |	9223372036854775807| 

Par défaut, ``MySQL`` gère les nombres négatifs. Il possible de préciser à l’aide du mot clé ``UNSIGNED`` (non signé) que les nombres seront exclusivement positifs (ou nuls). Ce qui diminue du même coup, la plage de valeur.

Exemple : Quel est l’intervalle de valeurs du champ QteCmde déclaré comme ci-dessous : 
??? question "QteCmde TINYINT UNSIGNED"
    de 0 à 255. le bit de poids fort de l'octet etant utilisé pour coder une puissance supplémentaire.

**Le type « décimal » **

Le type dédié aux nombres décimaux est : ``DECIMAL``
Lors de la déclaration, on précisera le nombre total de chiffres nécessaires suivi du nombre de chiffres après la virgule. Lorsqu'une valeur ayant trop de décimales est affectée à une colonne, la valeur est arrondie. 

Exemple : 
```sql
prixHT DECIMAL(10,2)
```

#### 2.1.2 Types numériques non exacts 

Il s’agit ici de stocker des données numériques approchées appelées **nombres à virgule flottante**.

|Type |	Octets| 	De| 	A |
|FLOAT signé |	8 |	-3.402823466E+38 |	-1.175494351E-38 |
|FLOAT non signé|8|	1.175494351E-38 	|3.402823466E+38|

Le nombre de décimales peut être précisé. Consultez le [manuel de référence](https://dev.mysql.com/doc/refman/8.4/en/floating-point-types.html) en cas de besoin.

### 2.2 Les types chaînes de caractères 

Certainement le type de données le plus utilisé en informatique de gestion. Il correspond au type ``String`` ou ``str`` de nombreux langages de programmation. 

Voici les principaux types utilisés :

|Type |	Octets |
|CHAR(M) |	**M** octets, 1 <= M <= 255 |
|VARCHAR(M)| 	**L =M+1** octets, avec L <= M et 1 <= M <= 255 |
|BLOB, TEXT |	**M+2** octets, avec L < 2^16 (65536) |
|MEDIUMBLOB, MEDIUMTEXT|	**M+3**, avec L < 2^24 (16 777 216)|
|LONGBLOB, LONGTEXT|	**M+4**, avec L < 2^32 (4 294 967 296)|

Dans ce tableau, **M** représente la longueur maximale de la chaîne et **L** sa longueur effective. 
Ainsi une colonne déclarée en ``VARCHAR(30)`` nécessitera au maximum ``31`` octets. 

Note : Une donnée déclarée ``CHAR(30)`` sera complétée par des espaces si $L < 30$. Ce type est utilisé généralement pour stocker des valeurs dont la ==longueur est toujours fixe== (exemple : code ISO, numéro de téléphone, code postal, ....)

L’option **BINARY** permet de tenir compte de la casse.
 
### 2.3 Les types temporels 

Ils permettent de stocker les **dates** et les **heures**. De nombreuses *fonctions* sont dédiées à ces types de données. (Exemple : Extraction du mois dans une date, ajout d’un nombre de jours, différence entre dates, etc…)

|Type	|Octets 	|Format |	De 	A |
|DATE 	|3 	|AAAA-MM-JJ| 	1000-01-01 	9999-12-31 |
|DATETIME |	8 	|AAAA-MM-JJ HH:MM:SS |	1000-01-01 00:00:00 	9999-12-31 23:59:59 
|TIMESTAMP 	|4 	|AAAA-MM-JJ HH:MM:SS |	1970-01-01 00:00:00 	Une date en 2037… |
|TIME |	3 |	HH:MM:SS |	-838:59:59 	838:59:59 |

Une colonne **TIMESTAMP** est utile pour enregistrer les dates et heures des opérations INSERT et UPDATE, car elle prend automatiquement la date actuelle (date du système) si vous ne lui assignez pas de valeur par vous-même.<br />
> Exemple : Horodater une  commande sur un système de gestion de commande en ligne.

## 3.	Création d’une base de données 

Une table est contenue dans une base de données. Pour pouvoir créer une table, il faut tout d’abord créer la base de données. 

### 3.1	Création de la base de données 

Une base de données est créée à l’aide de la commande SQL suivante : 

```SQL
CREATE DATABASE [IF NOT EXISTS] db_name 
      [create_specification , 
      create_specification, ...]
```
!!! info "Application"
  ```SQL
  CREATE DATABASE Bibliotheque ; 
  ```

Les options ``create_specification`` peuvent être données pour spécifier des caractéristiques de la base. Cela concerne essentiellement le jeu de caractères utilisé. 

exemple : 
```SQL
CREATE DATABASE Bibliotheque
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
```

``utf8mb4`` est une version améliorée de utf8 supportant plus de caractères (comme les emojis).

!!! note "IF NOT ExISTS"
  Il est fréquent de devoir relancer un script de création de base pour ajouter une précision, une table. Si la base existe déjà, cela provoquera une erreur. On peut alors ignorer la clause ``CREATE DATABASE``, en ajoutant la précision ``IF NOT EXISTS``.
  ```SQL
  CREATE DATABASE IF NOT EXISTS Bibliotheque
  ```


Les bases de données MySQL sont implémentées comme des répertoires contenant des fichiers qui correspondent aux tables dans les bases de données. Dans le cas d’une installation par défaut de WampServer, les bases sont stockées dans le dossier C:\wamp\bin\mysql\mysqlX.X.X\data\
 
2	Création des tables 

La création d’une table est réalisée à l’aide de l’instruction CREATE TABLE. 
Les informations minimales à préciser sont : 
- Le nom de la table 
- Les champs (colonnes) de la table 
o Pour chaque champ, on précisera son type et si la valeur Null est acceptée. 
- Le ou les champ(s) de la clé primaire 
- Les colonnes clés étrangères 
o Pour chaque clé on précisera à quel autre champ et table elle est reliée. 
o Pour chaque clé on précisera éventuellement les actions à réaliser lors de mise à jour ou suppression pour respecter l’intégrité référentielle. 

Voici un extrait de la syntaxe MySQL : 

CREATE TABLE tbl_name 
[(create_definition,...)] 
[table_options]
create_definition: 
column_definition 
| [CONSTRAINT [symbol]] PRIMARY KEY [index_type] (index_col_name,...) 
| [CONSTRAINT [symbol]] FOREIGN KEY 
[index_name] (index_col_name,...) [reference_definition] 

column_definition: 
col_name type [NOT NULL | NULL] [DEFAULT default_value] 
[AUTO_INCREMENT] [[PRIMARY] KEY] [COMMENT 'string'] 
[reference_definition] 
reference_definition:
REFERENCES tbl_name [(index_col_name,...)] 
[ON DELETE CASCADE | SET NULL | SET DEFAULT] 
[ON UPDATE CASCADE | SET NULL | SET DEFAULT] 
table_option: 
{ENGINE|TYPE} = {BDB|HEAP|ISAM|InnoDB|MERGE|MRG_MYISAM|MYISAM} 
| AUTO_INCREMENT = value
Exemple pour la table Lecteur : 
CREATE TABLE Lecteur(
NumLecteur INT NOT NULL, 
NomLecteur VARCHAR(30) NOT NULL, 
PrenomLecteur VARCHAR(30), 
CONSTRAINT lecteur_pk PRIMARY KEY (NumLecteur) 
); 

Pour la table Ouvrage, on ne souhaite pas gérer NumOuvrage (un numéro automatique devra être généré). Donnez la commande SQL de création de la table en utilisant l’autre syntaxe pour préciser la clé primaire :



 Dans la définition de la colonne :
CONSTRAINT lecteur_pk PRIMARY KEY (NumLecteur) 
La partie CONSTRAINT lecteur_pk est optionnelle,  MAIS obligatoire dans ce cours. Cette méthode d’écriture permet de mieux comprendre la structure de la base et de pouvoir nommer ce que l’on manipule

Exemple pour la table Emprunter : 
CREATE TABLE Emprunter( 
NumLecteur INT NOT NULL, 
NumOuvrage INT NOT NULL, 
DateEmprunt DATE NOT NULL, 
DateRetour DATE, 
CONSTRAINT emprunter_pk PRIMARY KEY (NumLecteur, NumOuvrage, DateEmprunt),
CONSTRAINT emprunter_numlecteur_fk FOREIGN KEY (NumLecteur) 
           REFERENCES Lecteur(NumLecteur), 
CONSTRAINT emprunter_numouvrage_fk FOREIGN KEY (NumOuvrage) 
           REFERENCES Ouvrage(NumOuvrage) 
) ;

 A retenir : 
- Le nommage des contraintes devra respecter les conventions suivantes : 
o nomdetable_champcléprimaire_pk 
o nomdetable_champcléétrangère_fk 
- MySQL ne conserve pas le nom donnée à une contrainte de clé primaire mais la syntaxe est acceptée   par soucis de compatibilité avec les autres SGBD. 
- Afin de respecter l’intégrité référentielle, les tables contenant exclusivement des clés primaires doivent être crées en premier. 
- Pour obtenir l’instruction de création d’une table MySQL, utiliser la commande : 
SHOW CREATE TABLE tbl_name

4.	Suppression d’une base de données (et/ou) de table 

La suppression d’une base de données est réalisée à l’aide de la commande : 

DROP DATABASE [IF EXISTS] db_name 

La suppression d’une table est réalisée comme ci-dessous : 

DROP TABLE [IF EXISTS] tbl_name [, tbl_name] ... 

L’option IF EXISTS évite l’affichage d’une erreur si l’élément n’existe pas. 
La suppression d’une table liée par une contrainte d’intégrité référentielle ne sera pas possible et ce même si les tables sont vides. 
Dans le cas de la base bibliothèque, seule la table . . . . . . . . . . . . . . . . . . pourra être effacée sans conditions préalables.
 
5.	Modification des tables 

La modification d’une table consiste ici à modifier son nom, sa structure ou bien ses champs. Les opérations consisteront à : 
- Ajouter ou supprimer un champ 
- Modifier le nom, le type ou les propriétés d’un champ 
- Supprimer ou modifier une clé primaire 
- Supprimer ou modifier une contrainte d’intégrité référentielle 

La syntaxe de la commande est (extraits) :

ALTER TABLE tbl_name 
alter_specification [, alter_specification] ... 

alter_specification: 
  ADD [COLUMN] column_definition [FIRST | AFTER col_name ] 
| ADD [COLUMN] (column_definition,...) 
| ADD [CONSTRAINT [symbol]] 
PRIMARY KEY [index_type] (index_col_name,...) 
| ADD [CONSTRAINT [symbol]] 
FOREIGN KEY [index_name] (index_col_name,...)    
[reference_definition] 
| CHANGE [COLUMN] old_col_name column_definition 
[FIRST|AFTER col_name] 
| MODIFY [COLUMN] column_definition [FIRST | AFTER col_name] 
| DROP [COLUMN] col_name 
| DROP PRIMARY KEY 
| DROP FOREIGN KEY fk_symbol 
| RENAME [TO] new_tbl_name
