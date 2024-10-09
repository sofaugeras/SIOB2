# TP Découverte phpMyAdmin
PhpMyAdmin est une application web gratuite et open source qui permet de gérer les bases de données MySQL via une interface graphique web.

Elle facilite la gestion des bases de données, des tables, etc., sans nécessiter de connaissances en commandes SQL.

Elle est particulièrement utile pour ceux qui préfèrent une interface visuelle plutôt que la ligne de commande pour gérer leurs bases de données. 

!!! note "Source"
    contexte issu du [réseau certa](https://www.reseaucerta.org/content/fiche-outil-phpmyadmin-mysql) de 2006, adapté et remanié. Auteur : Valérie EMIN

## 1 Mais d'abord WAMP

WampServer ou WAMP est une compilation du serveur web Apache, de PHP et de MySQL lotée pour les ordinateurs Windows.
WampServer est disponible gratuitement (sous licence GPL) en deux versions : 32 et 64 bits.
vous devez télécharger le logiciel WAMP et l’installer sur votre ordinateur. Il vous suffit de vous rendre sur le site de [WampServer](https://www.wampserver.com/fr/) et de télécharger puis executer ensuite l'archive du logiciel sur votre poste (en 32 ou 64 bits selon votre poste.)

Attention, le logiciel est peut-être (surement) déjà installer sur vos postes. Vérifiez avant de télécharger !! 
Pour savoir si il est déjà installer, regardez l'existence du répertoire `C:\wamp64`.

Une fois installé, vous pouvez lancer le WampServer à partir du raccourci de votre ordinateur ou de l’emplacement de destination où vous avez installé le logiciel.

![icone WAMP](./data/iconeWamp.png){: width=30% .center}

Quand tout se passe bien, l'icône est verte sinon elle est orange ou rouge ...

Lancer phpMyAdmin avec l'url suivante [http://localhost/phpmyadmin/](http://localhost/phpmyadmin/)

Vous obtenez la page suivante :

![phpMyAdmin accueil](./data/myadmin.png){: width=60% .center}

Connectez vous avec le user `root` et ici sur les postes de la salle sans mot de passe. 
Vous arrivez sur l'écran suivant :

![accueil](./data/acceuilPHPMyAdmin.png){: width=30% .center}

La parte importante dans un premier temps va être à gauche avec la liste des tables et le lien pour créer une nouvelle base.

![accueil liste des bases](./data/listeBase.png){: width=50% .center}

## 2. Bonnetable

nous allons créer une nouvelle base de données, appelée `bonnetable`.<br />
Cliquez sur `Nouvelle Base` et Saisissez le nom de la base, exemple `bonnetable` et déroulez la liste interclassement pour choisir `utf8_bin`.<br />
Il suffit de cliquer sur le bouton "créer" pour déclencher l'opération de création de la base.<br />
Une fois l'opération effectuée la page suivante affiche la base créée dans le menu a gauche.<br />

![bonnetable](./data/creationBase.png){: width=50% .center}

- :arrow_forward: Le nom de la base apparaît dans la liste des bases de données <br />
- :arrow_forward: De nouveaux menus horizontaux apparaissent : <br />
    * le menu "Structure" gère les tables de la base<br />
    * "SQL" permet de créer des requêtes<br />
    * "Exporter" génère un script SQL de création de tables et données qui permet de recréer une base<br />
    * "Rechercher" trouve des enregistrements qui correspondent à un ou plusieurs critères sans passer par une requête SQ <br />
    * "Opérations" réalise des tâches de maintenance <br />
    * "Supprimer" supprime des objets sélectionnés auparavant.<br />

![menu base](./data/menuBase.png){: width=80% .center}

La base de données étant vide, phpMyAdmin propose naturellement de Créer une nouvelle table sur la base "bonnetable"

## 3. Création d'une table en mode graphique

:arrow_forward: Entrer le nom de la table `PRODUIT` et indiquer le nombre de champs à créer ici `5`, puis cliquer sur Exécuter. Il sera bien sûr possible de revenir plus tard sur la structure de la table pour ajouter/modifier/supprimer des champs. 

Il suffit de compléter les différentes zones de saisie pour créer les champs de la table :<br />
•	**nom** : correspond au nom du champ dans la table<br />
•	**Type** : type de données (cf : annexe 1 – les types de données)<br />
•	**Taille/Valeurs** : associé à la colonne Type, vient apporté une précision sur le type<br />
•	**Valeur par défaut** : permet d'indiquer une valeur par défaut<br />
•	**Interclassement** : jeu de caractères pour les comparaisons et les tris. Prend la valeur du jeu de caractères par défaut de la base s’il n’est pas précisé<br />
•	**Attributs** : options pour certains champs numériques ou date<br />
•	**Null** : autorise ou non les valeurs nulles (NULL signifie ‘pas de valeur affectée’)<br />
•	  **index**  pour accélérer le temps d’accès aux enregistrements en utilisant la valeur de ce champ comme critère dans une requête <br />

![table produit](./data/produit.png){: width=550% .center}

!!! question "A faire"

    ![relations](./data/bonnetableRelations.png){: width=60% .center}

    1. Donner le schéma "en intention" de la base bonneTable<br />
    2. Continuer la création de la base à l'aide du schéma suivant. Vous veillerez à choisir les types adéquates à chaque fois. <br /> Si deux champs portent le même nom, ce n'est pas un souci mais veillez à ce qu'ils aient le ==même== type. Ajoutez bien les clés primaires lors de la création de la table<br /> 
    4. Ajoutez les clés étrangères en passant par l'interface concepteur (drag en drop de la clé primaire vers la clé étrangère)

   
Une fois terminé, vous pouvez visualiser vos tables en sélectionnant la Base bonnetable (liste à gauche) et en allant dans le menu déroulant complètement à droite en choisissant `concepteur`.


## 4. Insertion des données dans une table

:arrow_forward: Choisissez la base de données Bonnetable dans la liste à gauche<br />

![liste Tables](./data/listeTable.png){: width=55% .center}

:arrow_forward: Cliquer sur `Insérer` de la ligne correspondant à la table Produit<br />

Pour chacun des enregistrements présentés, il est possible de les :<br />
:pencil2: Modifier<br />
:scissors: Supprimer<br />
:arrow_down: exporter<br />
en cliquant sur le lien adéquat et en cochant la case située devant les enregistrements.

!!! question "A Faire"

    Compléter la table GAMME avec les valeurs suivantes

    |CodeGamme|	LibelleGamme|
    |:--:|:--:|
    |CC|	Coup de coeur|
    |PP|	Premier prix|
    |SG|	Soirée de gala|
    

### Importation de données
Si vous disposez de données dans un fichier texte ou dans une feuille de calculs, vous pouvez les importer directement dans la table à condition que les données respectent les types des champs que vous avez préalablement définis. <br />
Nous allons remplir la table `PRODUIT` avec les données contenues dans un fichier texte.<br />

[Télécharger fichier Produit :arrow_down:](./data/produit.csv){ .md-button .md-button--primary }

:arrow_forward: Ouvrez le fichier `produit.csv`. Il contient de quoi alimenter la table `PRODUIT`<br />
:arrow_forward: Sous phpMyAdmin, sélectionnez la table `PRODUIT` dans le volet de gauche puis dans le menu sélectionnez `Importer`<br />

![importer](./data/produitImportation.png){: width=55% .center}

!!! question "A faire"

    Alimenter également les tables lot, composant et composition.<br />
    :warning: Attention à respecter l'ordre d'importation des fichiers.<br />

    [Télécharger fichier lot :arrow_down:](./data/lot.csv){ .md-button .md-button--primary }<br /><br />

    [Télécharger fichier Composant :arrow_down:](./data/composant.csv){ .md-button .md-button--primary }<br /><br />

    [Télécharger fichier Composition :arrow_down:](./data/composition.csv){ .md-button .md-button--primary }


## 5 Interrogation des tables

Sous phpMyAdmin, vous pouvez visualisez le contenu des tables en cliquant sur le nom de la table dans le volet de gauche.<bt />
Une requête SQL de type projection avec SELECT s’affiche et le contenu de la table apparaît en dessous.

![produit affichage](./data/produitInterrogation.png){: width=70% .center}

On peut faire des interrogations de la base plus finement sur une ou plusieurs tables. Mais c'est l'objet du chapitre suivant ... 

![a suivre](./data/to-be.gif){: width=30% .center}