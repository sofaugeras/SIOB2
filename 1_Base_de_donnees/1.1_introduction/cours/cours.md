# 1. Généralités 

## 1.1 Définition 

**Définition générale :** Une Base de données est un ensemble organisé d'informations avec un objectif commun. <br />

Peu importe le support utilisé pour rassembler et stocker les données (papier, fichiers, etc.), dès lors que des données sont rassemblées et stockées d'une manière organisée dans un but spécifique, on parle de base de données.<br />

**Définition informatique :** Une Base de Données (BdD), en anglais Data Base (DB), est une collection d’informations structurées, cohérentes, persistantes, partagées.<br />
<br />
^^Structurée :^^ les données sont organisées. Elles donnent un sens/une vue du système d’information qu’elles représentent.<br />
^^Persistante :^^ La durée de vie des données doivent être supérieure à la durée des programmes qui les manipulent. La persistance peut être obtenue en effectuant un stockage permanent (sur le disque).<br />
^^Cohérente :^^ la base de données sert pour prendre un ensemble de décision. Les données doivent être juste et non redondante.<br />
^^Partagée :^^ L'un des avantages d'une base de données est que les informations qui la constituent peuvent être accessibles aisément par plusieurs programmes qui les utilisent simultanément avec des objectifs différents. <br />
exemple : Application de gestion RH (paye, congés, …)
<br />
Une base de données peut être locale ou répartie. Elle est dite *locale* quand elle est utilisée sur une machine par un utilisateur et *repartie* quand les informations sont stockées sur des machines distantes (serveur) et accessibles par réseau.<br />


:arrow_forward: Conséquence : Il faut un « pilote », un administrateur de base de données (DBA).

 
## 1.2 Historique 

Au  début de l'informatique, on a voulu construire des systèmes pour effectuer des calculs (équations différentielles, calcul matriciel, ...). L’approche classique de mise en place d’une application informatique dans une entreprise, consistait le plus souvent à l’écriture d’un certain nombre de programmes destinés à l’exploitation d’un ensemble de fichiers qu’il fallait aussi créer. 
 
[Données organisées en fichier (jusqu'au années 60)](./data/archi_fichier.png)
Légende : D pour données, F pour Fichiers

Les systèmes classiques de fichiers posent les problèmes suivants:<br />
:arrow_lower_right: La dépendance des données et des traitements<br />
:arrow_lower_right: Lors de la mise à jour d'un fichier, la totalité du fichier est rendue indisponible pour les autres utilisateurs (seuls certains systèmes disposent d'utilitaires spécifiques pour la gestion des accès concurrents),<br />
:arrow_lower_right: Les procédures de sécurité (confidentialité et reprise après panne) doivent être programmées.
Ce système par fichier est toujours exploité dans les grandes entreprises. Système VSAM sous IBM.<br />

Aujourd’hui, la tendance actuelle est la gestion de grandes voire très grandes1 quantités d'informations. Cela revient à stocker des données et manipuler ces données. Notons que les données peuvent être de natures diverses, les opérations plus ou moins compliquées et nombre d’utilisateurs plus ou moins important. <br />

Exemples d'applications : Applications de gestion (paye, stock, ...), applications transactionnelles (banque, réservation...), applications de documentation (bibliothèque, cartographie, ...), Ingénierie (PAO, CAO, ... ). 
 Les entrepôts de données (data warehouse) contiennent plusieurs téraoctets (1 To = 1024 Go) de données. 
Le 7° youtube, c’est 45 Terabytes de données et le 1er le centre mondial pour le climat, c’est 330 terabytes

Ordre de grandeur : Un octet est une suite de 8 bits. C’est ce qu’il faut pour coder 1 caractère ‘A’. 
: kilo > mega > giga > tera > peta > exa …
3	Le système de gestion de base de données SGDB

Une base de données est un ensemble d’informations stocké sur un système informatique. 
Cet ensemble est implanté physiquement (généralement sur disque dur) sous la forme d’un ou plusieurs fichiers. 
Cette organisation est assurée par un logiciel spécialisé : Le SGBD (Système de Gestion de Base de Données) Les fonctionnalités élémentaires d’un SGBD sont : 
- Structurer/organiser les données 
- Stocker les données 
- Mettre à jour les données (ajout, modification et suppression d’informations) 
- Interroger les données 

 
Figure 2 : Principes de fonctionnement des SGBD

La construction d’une base de données passe tout d’abord par la réalisation d’un « plan » : un schéma conceptuel. Cette phase de conception est généralement guidée par une méthode (ex. MERISE).
L’objectif est de modéliser* le domaine étudié. 

* On n’abordera pas les méthodes de modélisation dans ce module. Prévu au 2nd semestre en SLAM1.

Exemple : Dans une entreprise on souhaite réaliser une base de données « fournisseurs » La modélisation consistera à recenser les informations nécessaires concernant les fournisseurs (raison sociale, téléphone, e-mail…) et les produits (référence, désignation, prix…) ainsi que les liens entre ces deux entités (Qui fournit quoi ?) L’organisation sémantique des informations peut être réalisée suivant plusieurs modèles de données. Les principaux modèles de base de données sont les suivants : 
- Le modèle hiérarchique 
- Le modèle réseau 
- Le modèle relationnel 
- Le modèle objet 

Notons cependant que le modèle relationnel est aujourd’hui utilisé par la grande majorité des SGBD (environ ¾) et que l’on retrouve également d’autres modèles (ex. : navigationnel et déductif)

2.	Les modèles de base de données 
1	Le modèle hiérarchique 

Conçu à la NASA pour la gestion des données du programme spatial Apollo, les données sont classées hiérarchiquement, selon une arborescence descendante. Ce modèle utilise des pointeurs entre les différents enregistrements. Bien adapté à des données de type nomenclatures avec une relation 1 vers N mais inapproprié aux structures de données complexes. 

Les fichiers XML constituent une réminiscence des bases de données hiérarchiques. 
 
Figure 4 : exemple d'arborescence et de contenu de fichier XML
Exemples : 
	La classification du vivant relève du modèle hiérarchique de base de données : Le chat appartient à la famille des félidés, du sous-ordre féliformes de l’ordre des carnivores, de la classe des mammifères, du sous-embranchement des vertébrés du règne animal. 

	Vu de l’utilisateur, un système de fichiers s’apparente à une base de données hiérarchique (arborescence des dossiers) 

Le point d’accès de l’information est unique (la racine). Il faut parfois parcourir toute l’arborescence pour trouver une information.

 
2	Le modèle réseau

Ce modèle constitue une extension du modèle hiérarchique, il utilise des pointeurs vers des enregistrements selon une structure arborescente. Il est cependant possible d’établir des liens sans restriction entre les différents éléments.
 Imaginé par Charles Bachman, sa spécification a été publiée en 1969 par le consortium Codasyl, à l’origine du langage Cobol. Plus que le modèle hiérarchique, le modèle réseau implique une connaissance de la structure de la base de données pour permettre l’accès aux données : les logiciels sont dépendants de la structure de la base. 

Exemple : 
Des données généalogiques peuvent être organisées selon le modèle réseau. 
Un enregistrement de type parent dispose d’un pointeur vers chacun des membres de sa descendance. Chaque membre de la descendance dispose d’un pointeur vers son aîné et d’un autre vers son cadet.

Pour retrouver une donnée dans une telle représentation, il faut connaître le chemin d'accès (les liens) ce qui rend les programmes dépendants de la structure de données

3	Le modèle relationnel

Ce modèle est fondé sur la théorie mathématique des relations. Le schéma conceptuel peut être vu comme un ensemble de tables (ou relations) à n colonnes, n désignant le degré de la relation. 
Avec le modèle relationnel, une table sert à représenter aussi bien une classe d’objets qu’une association entre des classes d’objets. Chaque élément d’une table est appelé un n-uplet (ou tupple). 
Le terme objet représente ici un élément, un acteur du système d’information (une facture, un produit, un client …)
 
Figure 6 : Modèle relationnel
A partir des années 70
Dans l’exemple de la Fig. 6, la table INSCRIPTION décrit l’association entre la classe d’objets ETUDIANT et la classe MODULE. Elle permet de modéliser le fait qu’un étudiant peut s’inscrire à 0, 1 ou plusieurs modules. Ce modèle est le plus fréquent, il fera l’objet d’un paragraphe un peu plus loin.
 Les logiciels qui s’appuient sur ce modèle sont les SGBDR (R pour relationnel) 
Le langage dédié aux opérations sur les données est le SQL (Structured Query Language)

 
4	Le modèle objet

La notion de bases de données objet ou relationnel-objet est plus récente. 
Les données sont représentées sous forme d'objets. Comme en programmation orientée objet, les objets contiennent les données qui les décrivent ainsi que la logique qui permet de les utiliser ou de les modifier. Chaque enregistrement de la base de données constitue une instance de la classe d’objets correspondante. Ces instances sont classées de manière hiérarchique dans la base de données. 

Les SGBDO (Systèmes de Gestion de Bases de Données orientés Objet) sont recommandés pour les applications nécessitant des performances élevées dans la manipulation de données complexes. 
Ils ont pour inconvénient principal une très 'importante quantité de ressources (mémoire et temps de calcul. Ils sont par conséquent cantonnés à des niches telles que l’ingénierie, les études spatiales, ou encore la recherche fondamentale en physique et en biologie moléculaire.

 
3.	Les SGBDR



 



Définition SGBD : Ensemble des programmes permettant la gestion et l’accès à une base de données
Elle est dite SGBDR, lorsqu’elle concerne une base de données relationnelle.
Les SGBD relationnels sont à l’heure actuelle les plus diffusés sur le marché.
 Ils permettent d’organiser les données sous formes de tables. La description de la base de données est faite grâce à un schéma conceptuel ou relationnel permettant de décrire toutes les tables (relations) implantées sur disque. 
Un SGBDR sert à effectuer des opérations ordinaires telles que consulter, modifier, construire, organiser, transformer, copier, sauvegarder ou restaurer des bases de données.
 
1	Les objectifs d’un SGBDR

Indépendance physique : un remaniement de l’organisation physique des données n’entraîne pas de modification des programmes d’application (traitements)
Exemple : indépendante des structures de stockage utilisées. Changement de serveur.
Indépendance logique : un remaniement de l’organisation logique des fichiers n’entraîne pas de  modification dans les programmes d’application non concernés. 
Exemple : ajout d’une rubrique (date de naissance d’un étudiant)
Manipulation facile des données : un utilisateur non-informaticien doit pouvoir manipuler simplement les données (interrogation et mise à jour)
Administration facile des données : un SGBD doit fournir des outils pour décrire les données, permettre le suivi de ces structures et autoriser leur évolution.
Efficacité des accès aux données : garantie d’un bon débit (nombre de transactions par seconde) et d’un bon temps de réponse (temps d’attente moyen pour une transaction)
Redondance contrôlée des données : diminution du volume de stockage, pas de mise à jour multiple ni d’incohérence.
Cohérence des données : exemple : L’âge d’une personne doit être un nombre entier positif. Le SGBD doit veiller à ce que les applications respectent cette règle. 
Partage des données : utilisation simultanée des données par différentes applications
Sécurité des données : les données doivent être protégées contre les accès non-autorisés ou en cas de panne.
2	Les composants d’un SGBDR

Un SGBD est un ensemble de logiciels parmi lesquels il y a un moteur de base de données, un interprète du langage SQL, une interface de programmation, et diverses interfaces utilisateur. 
Le moteur de base de données : C’est le composant central du SGBD qui effectue la majorité des traitements de manipulation du contenu des bases de données. 
Interprète SQL : SQL est un langage informatique qui sert à exprimer des requêtes d'opérations sur les bases de données. L'interprète SQL décode les requêtes, et les transforme en un plan d'exécution détaillé, qui est alors transmis au moteur de base de données. 
Interface de programmation : C’est une bibliothèque logicielle qui permet à un programme tiers de communiquer avec le SGBD, de demander des opérations et de récupérer des données provenant des bases de données. Le détail des demandes est souvent formulé en langage SQL. 
ODBC est un logiciel médiateur (middleware) qui permet à des logiciels, par l'intermédiaire d'une interface de programmation unique de communiquer avec différents SGBD ayant chacun une interface de programmation différente. C'est un logiciel souvent utilisé avec les SGBD. 
 Interface utilisateur : C’est l’interface graphique (homme-machine) qui permet de mettre en oeuvre toutes les fonctionnalités proposées par le SGBD. On retrouve parfois une interface dédiée à l’interrogation des données appelée QBE (Query By Example) : Le principe est que l'utilisateur présente un exemple du résultat de recherche attendu (sous forme d'une matrice), puis le soumet au SGBD.
3	Les fonctions d’un SGDBR

Description des données LDD : Langage de définition de Données : permet de décrire et de maintenir le structure des données (nom, longueur, type …) constituant la base.
A une base de données est associée un schéma, appelé MPD (Modèle physique de Donnée), qui décrit la structure et le type des données qu'elle contient et éventuellement quelques règles (ou contraintes) qui doivent être toujours vérifiées.
Manipulation de données LMD : Langage de manipulation de Données : recherche, mise à jour, transformation des données.
Contrôle de l’intégrité des données LCD : respect des contraintes d’intégrité (Il ne peut y avoir qu’un seul fournisseur f1, unicité d’une ligne)
Gestion des transactions : atomicité des transactions (pas de mélange entre transactions), accès simultané aux mêmes données rendu possible grâce à des techniques de verrou et sécurité (mot de passe, etc …)
Ces langages permettent :
	l'utilisation par des « non-informaticiens », c'est-à-dire n'ayant pas besoin de connaissance en système ou en programmation (mais l'apprentissage du langage d'extraction des données est lui indispensable) 
	l'écriture de programmes indépendants de la structure des données.

4	Les différents type d’utilisateurs

On peut distinguer plusieurs rôles que doivent jouer un individu ou un groupe d’individus pour concevoir, créer, mettre en œuvre et exploiter une base de données. 
Le développeur d’applications (ou analyste programmeur) : Après modélisation du système d’information étudié, c’est lui qui propose le modèle relationnel de la future base de données. Il est chargé ensuite d’élaborer les programmes pour exploiter la base de données. 
L’administrateur de la base de données : C’est lui qui (à partir du modèle relationnel) est chargé de l’aspect plus technique de la création de la base. Il assure les fonctionnalités d’administration et de sécurité des données. 
L’utilisateur : Il s’agit de caractériser ici la personne qui se sert simplement de la base de données et qu’on appelle couramment l’utilisateur final (End User en anglais). Ces personnes ne sont pas des informaticiens, elles utilisent les ressources logicielles mises à disposition par le développeur et l’administrateur. L’utilisateur « averti » est capable d’interroger la base en utilisant le langage SQL.
 
4.	Le modèle relationnel

1	Notions de table et de relation

L’unité de stockage dans une base de données relationnelle est la table.
Une table regroupe un ensemble de données qui décrivent un même objet. On la représente graphiquement sous une forme de tableau dans lequel les lignes sont appelés enregistrements (ou tupple) et l’intitulé des colonnes les champs.
A l’intersection d’une ligne et d’une colonne figure une valeur.






Au niveau relationnel, ces tables correspondent aux relations ci-dessous : 
GARCON(dossard, nom, prenom, datenais, enseigne) 
PRODUIT(refproduit, designproduit, commentaireproduit, prixttcproduit, codegamme) 
Ce mode de représentation est appelé « en intention », il représente la structure de la base de données (son schéma, son plan…). Par convention, le nom d’une table s’écrit en MAJUSCULE.
Au niveau relationnel, on parlera d’occurrences pour désigner les enregistrements et d’attributs pour parler des champs.
Chaque propriété de l’objet contenu dans la table doit être décrit par :
Son nom
Son type de données
Champ	Type
numCla	Numérique
libelléCla	Texte
	

2	Attributs et clés

Un attribut est une information, une donnée élémentaire, une rubrique désignant le plus petit élément d’information manipulable. Il est caractérisé par un nom et un type. 
Exemples : 
nomClient : attribut de type alphabétique (ex. de valeur : "DUPOND", "PAYET", ...) 
qteCmdee : attribut de type entier (ex. de valeurs : 5, 10, 2, ...)
Soit la relation Lecteur(nomLecteur, prenomLecteur) et le contenu de la table correspondante : 







Que pensez-vous de l’exemple ci-dessus ? 
Réponse : 


Il faut définir une clé pour cette relation. 
La clé est un attribut qui permet de distinguer chaque occurrence d’une relation par rapport à tous les autres. Toutes les valeurs de cet attribut doivent être uniques. 
 Une relation doit posséder au moins un attribut et si c’est le cas, ce doit être la clé. 
A faire : Représentez une table valide avec deux attributs exactement, pourvu de 6 occurrences.

 
3	Clé candidate et clé primaire

Les clés candidates sont des attributs susceptibles de pouvoir jouer le rôle de clé. 
Dans le cas de la « Fig. 10 : Table lecteur », aucun des champs ne peut jouer le rôle de clé. On rajoute alors un champ supplémentaire qui permettra de distinguer chaque lecteur : 
LECTEUR (numLecteur, nomLecteur, prenomLecteur) 

Le champ numLecteur devient alors la clé primaire de la relation. Par convention, ce doit être le premier attribut de la relation et il doit être souligné. Dans la plupart des SGBDR, un type numérique spécial est dédié à ce type clé. Appelé NuméroAuto, AutoIncrement… il est géré automatiquement par le SGBDR.





Dans l’exemple ci-dessous, précisez pour chaque champ s’il peut ou non être clé candidate. Justifiez.
 
Figure 12 : Table Eleve

Réponse :





 
4	Clé étrangère

Ce type d’attribut permet de matérialiser les liens entre les différentes tables. 
 Une clé étrangère correspond à la clé primaire d’une autre table. 
Dans l’exemple de la « Figure 9 : Une table MySQL » le dernier champ appelé codeGamme correspond en fait à une valeur existante dans une autre table : GAMME.





Le champ codeGamme assure la liaison entre les deux tables. Ainsi, dans la table Produit, on note que le produit désigné par « Lit 140x 190 cm » fait partie de la gamme n°3.
 Dans la table Gamme on trouvera que la gamme n°3 correspond aux produits fabriqué en teck. 
Le schéma relationnel de cette base peut s’écrire comme ci-dessous : 
GAMME (codegamme, libellegamme) 
PRODUIT (refproduit, designproduit, commentaireproduit, prixttcproduit, #codegamme) 
Par convention, une clé étrangère est précédée d’un # et est placée en dernier dans la liste des attributs d’une relation.

 
 
5	Notions d’intégrité

Dans le paragraphe «3.1 Les objectifs d’un SGBDR» nous avons vu que l’un des principaux objectifs d’un SGBDR était d’assurer la cohérence des données appelée également intégrité des données. 
Cette cohérence est en partie assurée par la mise en place de contraintes d’intégrité. 
a) Intégrité de « niveau table » 
Dans la plupart des cas, chaque table dispose d’une clé primaire. 
Les contraintes de domaines sont liées aux colonnes des tables (attribut non nul, entier positif, valeurs comprises dans un intervalle…) 
b) Intégrité référentielle 
Il s’agit ici pour le SGBDR de vérifier la cohérence clé étrangère/clé primaire. 
La définition d’une telle contrainte forcera le SGBDR à faire les contrôles suivants : 
o	Dans un champ clé étrangère il est impossible de renseigner une valeur qui n’existe pas dans la clé primaire (Le code gamme n° 4 ne peut être affecté à un produit si la gamme n’existe pas) 
o	Impossible de supprimer un enregistrement de la table contenant la clé primaire s’il existe des enregistrements liés (Dans la table gamme, l’enregistrement correspondant au code gamme n°2 ne pourra être supprimé car il existe, dans la table produit, des enregistrements liés. 
o	Impossible de modifier une valeur de clé primaire dans la table primaire si cet enregistrement a des enregistrements liés. 
