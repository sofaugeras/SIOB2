# 1. GSB Compte rendu de visite

![Logo GSB](./data/gsb.png){: .center width=50%}

## 1. Contexte

Vous travaillez pour la DSI du laboratoire pharmaceutique GSB. L’entreprise souhaite moderniser une application permettant aux visiteurs médicaux de saisir et consulter leurs comptes rendus de visite. Votre mission consiste à développer une nouvelle version web de cette application.

Le laboratoire Galaxy Swiss Bourdin (GSB) est issu de la fusion entre le géant américain Galaxy (spécialisé dans le secteur des maladies virales dont le SIDA et les hépatites) et le conglomérat européen Swiss Bourdin (travaillant sur des médicaments plus conventionnels), lui-même déjà union de trois petits laboratoires. Le laboratoire Galaxy Swiss Bourdin (GSB) désire à disposition des **visiteurs médicaux** une application Web permettant de centraliser les **comptes-rendus (rapports) de visite**. L’application web reprendra le périmètre applicatif de l’application Access 2003. L’application fournira ainsi une description des produits du laboratoire, les coordonnées des praticiens et des informations détaillées concernant les rapports des visites.

[Télécharger le Cahier des charges](./data/GSB-AppliCRv2026.pdf){ .md-button .md-button--primary }

## 2. Travail demandé

Vous devez réaliser une application web en PHP permettant :

- 1️⃣ l’authentification d’un visiteur
- 2️⃣ la consultation des visiteurs médicaux
- 3️⃣ la consultation des praticiens
- 4️⃣ la création d’un compte rendu de visite
- 5️⃣ la consultation des comptes rendus du visiteur connecté
- 6️⃣ l’export d’un compte rendu

## 3. Contraintes techniques

Vous devez respecter les exigences suivantes :

- Sécurité (utilisation de requêtes préparées, protection contre les injections SQL, validation des données saisies)
- Qualité du code

Votre code devra être :

- structuré
- lisible
- correctement indenté
- commenté lorsque nécessaire

L'Interface devra :

- respecter la charte graphique fournie
- proposer une interface claire et ergonomique

## 4. Organisation du projet

**Durée :** 7 séances de 4 heures

Vous pouvez :

- travailler en groupe, mais votre projet vous appartient. Chacun devra developper une version.
- utiliser l’IA comme outil d’assistance

⚠️ L’IA doit être utilisée comme aide, pas comme substitut au travail de compréhension.

Vous devez être capables d’expliquer :

- votre code
- vos choix techniques
- votre organisation du projet

## 5. Ressources fournies

Vous disposez de :

- [la base de données GSB](./data/gsb_modernise_2026.sql)
- un jeu de données
- la charte graphique

✔️ L’application doit être fonctionnelle et testable.

## 6. Compétences

Cet AP pourra être utiliser dans votre portefeuille de compétences de BTS SIO. 

Exemples de preuves pouvant être collectées pour l'AP GSB Compte Rendu de visite.

| Compétence | Indicateurs observables dans le projet GSB  | Preuves concernées  | 
|:--|:--|:--|
| **Analyser les objectifs et les modalités d’organisation d’un projet** | L’étudiant comprend le cahier des charges, identifie les fonctionnalités de l’application (authentification, consultation, création de compte rendu, export). |documentation technique issu du cahier des charges fourni|
| **Planifier les activités du projet** | Organisation du travail sur les 7 séances : découpage des tâches, gestion du temps, répartition du travail. |Gantt, Trello|
| **Produire les livrables du projet** | Code source structuré, documentation, respect du cahier des charges.  | Web map, documentation technique |  
| **Participer à l’évolution d’un site web exploitant les données de l’organisation** | Développement de l’application PHP connectée à la base GSB.||  
| **Respecter les normes et standards de développement** | Utilisation de requêtes préparées, organisation MVC, nommage cohérent, indentation du code. | audit de code, lint |
| **Réaliser les tests d’intégration et d’acceptation**   | Vérification du fonctionnement des fonctionnalités : connexion, recherche, création de rapport, export. |cahier de recettes avec capture d'écran |
| **Déployer un service informatique**    | Application fonctionnelle et testable sur l’environnement fourni.  | Fiche technique de déploiement, fichiers de configuration |
| **Collecter et traiter des demandes d’évolution**  | L’étudiant corrige les bugs et améliore l’application au fil du projet.| Fiche de rédaction d'un incident|
| **Communiquer sur le travail réalisé** | L’étudiant explique son code, ses choix techniques et sa contribution personnelle.  | Déroulé de la fiche synthèse de démonstration |
| **Organiser son développement professionnel**  | Utilisation pertinente de ressources (documentation PHP, IA, recherche technique). |Traces des prompts IA, liste des outils utilisés, liste des sites web ressources |