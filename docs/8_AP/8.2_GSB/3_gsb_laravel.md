# 3. GSB Laravel

!!! info "Compétences exploitées"

    - A.1.1.1 – Analyse du cahier des charges d’un service à produire 
    - A.1.2.4 – Détermination des tests nécessaires à la validation d’un service 
    - A.4.1.1 – Proposition d’une solution applicative 
    - A.4.1.2 – Conception ou adaptation de l’interface utilisateur d’une solution applicative 
    - A.4.1.8 – Réalisation des tests nécessaires à la validation d’éléments adaptés ou développés

Le contexte GSB Laravel reprend le cahier des charges défini en première année sur le contexte [GSB Compte rendu de visite](1_gsb_v1.md). L'environnement technologique évolue. La DSI vous demande de faire évoluer votre application vers une [architecture MVC](../../7_Programmation/7.3_MVC/cours.md), utilisant le [framework Laravel](../../4_Laravel/sommaire.md).

**Environnement technologique :** 

L’application web est développée en PHP sous le framework Laravel, complétée par les frameworks Bootstrap. La base de donnée est sous MySQL. Vous développerez en local avec WAMP et dans la mesure du possible avec une base de donnée partagée sur un poste distant.

Les cas d'utilisations suivants devront être présent : 

- Migration de la base de donnée existante avec reprise des données.
- Ajouter la fonctionnalité d’authentification du visiteur (voir user story 1 ci-dessous)
- Consultation de la liste des praticiens.
- Affichage des détails sur un praticien. A l’exception de son identifiant, toutes les informations sur le praticien sont à afficher, ainsi que son type.
- Recherche de praticiens à partir de leur type.
- Ajouter la possibilité de consulter les comptes-rendus du visiteur connecté.
- Ajouter la possibilité d’ajouter un nouveau rapport de visite, automatiquement affecté à l'utilisateur connecté.
- Recherche avancée de praticiens à partir de leurs nom et ville.
- Edition PDF d’un rapport de visite

## 2. Evolutions

⚠️ Vous veillerez pour chacune des Users Story Suivantes à rédiger un scénario de tests au debut de l'évolution, puis de réaliser ce scénario en le complétant des résultats obtenus.

### User Story 1

**User story :** Ajouter la fonctionnalité d’authentification du visiteur. (Bonus) Permettre au visiteur connecté de mettre à jour ses informations personnelles.

**Description 🎯 :**

**En tant que** visiteur médical<br />
**Je souhaite** m’authentifier à l’aide d’un nom d’utilisateur et d’un mot de passe<br />
**Afin de** accéder de manière sécurisée à l’application et à mes données professionnelles.

L’application actuelle ne comporte aucun mécanisme d’authentification, ce qui permet un accès libre à l’ensemble des fonctionnalités. Il est nécessaire d’ajouter un système d’authentification afin que seules les personnes disposant d’un compte puissent accéder à l’application. La barre de navigation devra afficher l’état de connexion de l’utilisateur.

- Si l’utilisateur n’est pas authentifié, le menu affiche “Non connecté” avec un lien “Se connecter” menant au formulaire d’authentification.
- Si l’utilisateur est authentifié, le menu affiche un message de bienvenue avec son prénom et son nom, ainsi qu’un lien “Se déconnecter” permettant de fermer la session.

**Critères d’acceptation 📌**

| ID  | Critère                                                                                                             |
| --- | ------------------------------------------------------------------------------------------------------------------- |
| AC1 | L’accès à l’application est réservé aux utilisateurs authentifiés.                                                  |
| AC2 | Une page de connexion permet de saisir **nom d’utilisateur** et **mot de passe**.                                   |
| AC3 | Si l’utilisateur n’est pas connecté, la barre de navigation affiche **“Non connecté”** et un lien **Se connecter**. |
| AC4 | Après authentification, la barre de navigation affiche **Bienvenue [Prénom Nom]**.                                  |
| AC5 | Un lien **Se déconnecter** permet de fermer la session utilisateur.                                                 |
| AC6 | Après déconnexion, l’utilisateur revient à l’état **Non connecté**.                                                 |

⭐ Fonctionnalité optionnelle (bonus) – Gestion du profil utilisateur

**En tant que** visiteur connecté<br />
**Je souhaite** consulter et modifier mes informations personnelles<br />
**Afin de** maintenir mes données à jour dans l’application.

Un lien “Profil” est accessible dans la barre de navigation pour les utilisateurs authentifiés.

Les informations affichées et modifiables sont :

- adresse
- code postal
- ville
- mot de passe

Après modification et validation du formulaire, un message de confirmation indique que les informations ont été correctement enregistrées.

### User Story 2

**User story :** Ajouter la fonctionnalité de modification d'un compte rendu de visite.

**Description 🎯 :**

**En tant que** visiteur médical<br />
**Je souhaite** pouvoir modifier un compte rendu de visite déjà enregistré<br />
**Afin de** corriger ou compléter les informations saisies après sa création.

Actuellement, la consultation d’un compte rendu est strictement en lecture seule. Les utilisateurs souhaitent disposer d’un bouton ✏️ “Modifier” permettant de passer un compte rendu en mode édition.

Dans une logique de traçabilité des actions, il est également nécessaire d’enregistrer :

- la date de création du compte rendu
- la date de dernière modification

Ces informations permettront de suivre l’historique des modifications réalisées par les visiteurs médicaux.

**Critères d’acceptation 📌**

| ID  | Critère                                                                           |
| --- | --------------------------------------------------------------------------------- |
| AC1 | Lors de la consultation d’un compte rendu, un bouton ✏️ **Modifier** est visible. |
| AC2 | Le clic sur ce bouton ouvre le compte rendu en **mode édition**.                  |
| AC3 | Les champs du compte rendu peuvent être modifiés puis enregistrés.                |
| AC4 | La **date de création** du compte rendu est enregistrée lors de sa création.      |
| AC5 | La **date de dernière modification** est mise à jour à chaque modification.       |
| AC6 | Les dates doivent être visibles lors de la consultation du compte rendu.          |


### User story 3 

**User story :** Journalisation des connexions utilisateurs

**Description 🎯 :**

**En tant qu’** administrateur de l’application GSB<br />
**Je souhaite** disposer d’un historique des connexions des utilisateurs<br />
**Afin de** assurer la traçabilité des accès à l’application et détecter d’éventuels usages anormaux.

Cette fonctionnalité s’inscrit dans une démarche de sécurité et d’audit permettant de conserver un journal des connexions (logs) consultable par les administrateurs.

**Critères d’acceptation 📌**

| ID  | Critère                                                                                                 |
| --- | ------------------------------------------------------------------------------------------------------- |
| AC1 | À chaque authentification réussie, une entrée est enregistrée dans une table `journal_connexions`.      |
| AC2 | Les informations enregistrées comprennent : l’identifiant utilisateur, la date et l’heure de connexion. |
| AC3 | L’adresse IP du client est également enregistrée.                                                       |
| AC4 | Les données doivent être conservées même si l’utilisateur se déconnecte.                                |
| AC5 | Les administrateurs peuvent consulter la liste des connexions via une interface dédiée.                 |
| AC6 | L’historique peut être trié par utilisateur et par date.                                                |

**Données à stocker**

| Champ         | Type         | Description                     |
| ------------- | ------------ | ------------------------------- |
| idConnexion   | INT (PK)     | Identifiant de la connexion     |
| idUtilisateur | INT          | Identifiant de l’utilisateur    |
| dateConnexion | DATETIME     | Date et heure de connexion      |
| adresseIP     | VARCHAR(45)  | Adresse IP du client            |
| userAgent     | VARCHAR(255) | Navigateur ou agent utilisateur |




