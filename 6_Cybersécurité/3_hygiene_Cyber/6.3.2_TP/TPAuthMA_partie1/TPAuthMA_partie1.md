# TP MFA avec TOTP 🔐

!!! info "🎯 Objectifs pédagogiques"

    * Comprendre le fonctionnement d’un second facteur **TOTP** (Time‑based One‑Time Password).
    * Implémenter un **parcours d’authentification Web** : login/mot de passe → saisie du code TOTP.
    * Générer un **secret TOTP**, un **QR Code** et vérifier les codes côté serveur.
    * Appliquer des **bonnes pratiques** (hash de mot de passe, sessions, contrôle d’accès).

## 1. Travail Guidé

### 1.1 Préparation du projet

1. Créez un dossier `mfa-php/` avec la structure :

   ```
   mfa-php/
   ├─ config.php
   ├─ schema.sql
   ├─ register.php
   ├─ login.php
   ├─ mfa_setup.php
   ├─ mfa_verify.php
   ├─ dashboard.php
   ├─ logout.php
   └─ helpers/
      └─ totp.php
   ```
2. Installez la librairie OTPHP avec Composer 

👉 Placez vous dans `mfa-php/` et exécutez la commande suivante : <br />
``composer require spomky-labs/otphp``

3. Dans MySQL, créez une base `mfa_demo` et exécutez `schema.sql`.

### 1.2 Modèle de données

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

### 1.3 Sécurité minimale attendue

* **Hash** des mots de passe avec `password_hash()` + vérif via `password_verify()`.
* **Sessions** sécurisées (`session_start()` en début de chaque page, vérifs d’accès).
* Ne **jamais** stocker le mot de passe en clair, ni afficher le secret TOTP à l’écran (sauf pour debug en local si besoin).

### 1.4 Parcours utilisateur à implémenter

1.**Inscription** (`register.php`) : email + mot de passe → crée l’utilisateur.
2.**Connexion (étape 1)** (`login.php`) : vérifie email + mot de passe.

    - Si mfa_enabled = 0 → redirection vers mfa_setup.php.
    - Sinon → redirection vers mfa_verify.php.
3.**Activation MFA** (`mfa_setup.php`) :

    - Génère un secret TOTP.
    - Affiche un QR Code à scanner dans l’application mobile (URI `otpauth://`).
    - Vérifie un premier code entré par l’utilisateur.
    - Si valide → `mfa_enabled=1`.

4.Vérification MFA (`mfa_verify.php`) : demande le code TOTP à chaque connexion.
5.Une fois validé, accès à `dashboard.php` (zone protégée). `logout.php` termine la session.

### 1.5 Liste des fichiers

* **register.php** → formulaire email + mot de passe (POST) → redirection login.
* **login.php** : formulaire email + mot de passe (POST). Si OK et `mfa_enabled=1` ⇒ redirection `mfa_verify.php`, sinon `mfa_setup.php`.
* **mfa_setup.php** : affiche QR + champ "Code TOTP" → si valide, enregistre `mfa_enabled=1` et redirige `dashboard.php`.
* **mfa_verify.php** : champ "Code TOTP" → si valide, session authentifiée complète → `dashboard.php`.
* **dashboard.php** → page protégée avec “Bienvenue <email>”.

✅ Fonctionnel : inscription, login, setup MFA, vérification MFA, déconnexion.<br />
✅ Code : séparation logique, vérifs d’erreurs, messages clairs.

## 2. Tests & Validation

- [ ] **Créer un compte**, puis **se connecter**.
- [ ]  À la première connexion, la page **MFA Setup** affiche le **QR Code** : scannez‑le avec votre appli.
- [ ]  Saisissez un **code TOTP** : l’activation doit réussir et vous envoyer au **dashboard**.
- [ ]  Déconnectez‑vous, reconnectez‑vous : après le mot de passe, la page **MFA Verify** est demandée ; entrez le code.
- [ ]  Vérifiez que l’accès direct à `dashboard.php` **sans** TOTP n’est pas possible (contrôles de session).

!!! info "Bonnes pratiques & Extensions"

    * **Sécurité** :

        * Utiliser `password_hash()`/`password_verify()` (déjà fait).
        * Protéger les pages par des **contrôles de session** stricts.
        * Limiter les **tentatives de connexion** (ex. compteur + délai).
        * Masquer le **secret** côté interface (affiché ici pour pédagogie seulement).

    * **Codes de secours** (bonus) : générer 5× codes aléatoires hashés en BDD pour récupération.
    * **Souvenir d’appareil** (bonus) : cookie signé (HMAC) valide X jours, pour éviter le TOTP à chaque login.
    * **Décalage d’horloge** : afficher l’heure serveur et recommander la **synchronisation** de l’horloge client.

!!! danger "🧪 Dépannage (FAQ rapide)"

    * **Le QR ne s’affiche pas** : vérifiez l’URL (encodage de l’URI `otpauth://`).
    * **Redirections bizarres** : sessions non démarrées ? `session_start()` doit être **tout en haut** de chaque script (via `config.php`).

## 3. Correction

??? question "Corrigé & Code de référence"

    ```php
    <?php
    // ===== config.php =====
    ini_set('display_errors', 1);
    error_reporting(E_ALL);
    session_start();

    $DB_HOST = '127.0.0.1';
    $DB_NAME = 'mfa_demo';
    $DB_USER = 'root';
    $DB_PASS = '';

    try {
        $pdo = new PDO("mysql:host=$DB_HOST;dbname=$DB_NAME;charset=utf8mb4", $DB_USER, $DB_PASS, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]);
    } catch (PDOException $e) {
        die("Erreur de connexion DB : " . $e->getMessage());
    }

    function require_login() {
        if (!isset($_SESSION['user_id'])) {
            header("Location: login.php");
            exit;
        }
    }

    function is_fully_authenticated() {
        return isset($_SESSION['user_id']) && (!($_SESSION['mfa_required'] ?? false));
    }

    // ===== mfa_setup.php =====
    require __DIR__ . '/config.php';
    require __DIR__ . '/vendor/autoload.php';

    use OTPHP\TOTP;

    require_login();

    $stmt = $pdo->prepare("SELECT * FROM users WHERE id=?");
    $stmt->execute([$_SESSION['user_id']]);
    $user = $stmt->fetch();

    if (!$user) { header("Location: login.php"); exit; }

    if ($user['mfa_enabled']) {
        header("Location: dashboard.php");
        exit;
    }

    if (empty($user['mfa_secret'])) {
        $totp = TOTP::create();
        $secret = $totp->getSecret();
        $pdo->prepare("UPDATE users SET mfa_secret=? WHERE id=?")->execute([$secret, $user['id']]);
        $user['mfa_secret'] = $secret;
    }

    $totp = TOTP::create($user['mfa_secret']);
    $totp->setLabel($user['email']);
    $totp->setIssuer("DemoMFA");
    $uri = $totp->getProvisioningUri();
    $qr = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=".urlencode($uri);

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $code = trim($_POST['code'] ?? '');
        if ($totp->verify($code)) {
            $pdo->prepare("UPDATE users SET mfa_enabled=1 WHERE id=?")->execute([$user['id']]);
            $_SESSION['mfa_required'] = false;
            header("Location: dashboard.php");
            exit;
        } else {
            $error = "Code invalide.";
        }
    }
    ?>
    <!DOCTYPE html>
    <html lang="fr">
    <head><meta charset="UTF-8"><title>Setup MFA</title></head>
    <body>
    <h1>Activer MFA</h1>
    <p>Scannez ce QR Code avec Google Authenticator :</p>
    <img src="<?= $qr ?>" alt="QR Code"><br>
    <form method="post">
    <label>Entrez le code: <input type="text" name="code" required></label>
    <button type="submit">Activer</button>
    </form>
    <?php if (!empty($error)) echo "<p style='color:red'>$error</p>"; ?>
    </body>
    </html>

    // ===== mfa_verify.php =====
    require __DIR__ . '/config.php';
    require __DIR__ . '/vendor/autoload.php';

    use OTPHP\TOTP;

    require_login();

    if (!($_SESSION['mfa_required'] ?? false)) {
        header("Location: dashboard.php");
        exit;
    }

    $stmt = $pdo->prepare("SELECT * FROM users WHERE id=?");
    $stmt->execute([$_SESSION['user_id']]);
    $user = $stmt->fetch();

    if (!$user || !$user['mfa_enabled']) {
        header("Location: login.php");
        exit;
    }

    $totp = TOTP::create($user['mfa_secret']);

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $code = trim($_POST['code'] ?? '');
        if ($totp->verify($code)) {
            $_SESSION['mfa_required'] = false;
            header("Location: dashboard.php");
            exit;
        } else {
            $error = "Code invalide.";
        }
    }
    ?>
    <!DOCTYPE html>
    <html lang="fr">
    <head><meta charset="UTF-8"><title>Vérification MFA</title></head>
    <body>
    <h1>Vérification du code MFA</h1>
    <form method="post">
    <input type="text" name="code" required>
    <button type="submit">Vérifier</button>
    </form>
    <?php if (!empty($error)) echo "<p style='color:red'>$error</p>"; ?>
    </body>
    </html>

    // ===== dashboard.php =====
    require __DIR__ . '/config.php';
    require_login();
    if (!is_fully_authenticated()) {
        header('Location: mfa_verify.php');
        exit;
    }
    ?>
    <!DOCTYPE html>
    <html lang="fr">
    <head><meta charset="UTF-8"><title>Dashboard</title></head>
    <body>
    <h1>Bienvenue, <?= htmlspecialchars($_SESSION['user_email'] ?? '') ?></h1>
    <p>Votre compte est protégé par la MFA TOTP ✅</p>
    <p><a href="logout.php">Se déconnecter</a></p>
    </body>
    </html>
    ```