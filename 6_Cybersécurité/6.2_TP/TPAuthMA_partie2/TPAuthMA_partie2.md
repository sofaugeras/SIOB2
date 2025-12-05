# TP Protection contre la force brute 🔐 

!!! info "🎯 Objectifs pédagogiques"

    * Comprendre comment détecter une attaque par force brute.
    * Implémenter des **mécanismes de défense progressifs** sur la page de login.
    * Appliquer des **bonnes pratiques de sécurité** sans dégrader l’expérience utilisateur.

## 1. Contexte

Vous disposez déjà d’une application Web avec :

* un système d’inscription / connexion,
* une authentification multi-facteur (MFA) par TOTP.

Mais actuellement, un attaquant pourrait tenter **des milliers de mots de passe** sur un même compte sans contrainte.<br />
👉 Vous devez **protéger la page de login** contre les attaques par force brute.

## 2. Travail guidé

1.**Modifier la base de données `users`** pour ajouter des colonnes de sécurité :

```sql
   ALTER TABLE users
   ADD failed_attempts INT NOT NULL DEFAULT 0,
   ADD last_failed_at TIMESTAMP NULL DEFAULT NULL,
   ADD lock_until TIMESTAMP NULL DEFAULT NULL;
```

2.**Mettre à jour `login.php`** pour :

* Vérifier si le compte est verrouillé (`lock_until > NOW()`) → refuser la connexion.
* En cas d’échec de login :

    * Incrémenter `failed_attempts` et mettre à jour `last_failed_at`.
    * Appliquer une politique : après 5 échecs consécutifs → ajouter un délai (sleep) Puis après 10 échecs → verrouiller le compte 15 minutes (`lock_until`).

* En cas de succès → réinitialiser `failed_attempts`.

3.**Bonus (optionnel)** :

* Protection par **IP** : créer une table `login_attempts (ip, attempts, last_attempt)`.
* Après 100 tentatives depuis une IP → bloquer 1 h. (utiliser un script python avec ``requests` pour lancer les 100 requêtes HTTP)
* Afficher un **message générique** (« Identifiants incorrects ») sans indiquer si l’email existe.

**Comportement attendu :**

* Si un utilisateur se trompe 3 fois → toujours possible de réessayer.
* S’il se trompe 8 fois → délai progressif (ex. +2 s).
* S’il se trompe 12 fois → compte bloqué 15 minutes.
* Après un login correct → compteur réinitialisé.


* ✅ Sécurité : **messages neutres**, verrous effectifs, remise à zéro après succès.
* ✅ Bonus : prise en compte IP, captcha ou notification utilisateur.

!!! bug "Checklist de Tests 📋"

    - [ ] Créez un compte test.
    - [ ] Essayez 3 mauvais mots de passe → pas de blocage.
    - [ ] Faites 6 échecs → délai avant réponse visible.
    - [ ] Faites 12 échecs → verrouillage 15 min.
    - [ ] Après un bon mot de passe → compteur réinitialisé.

## 3. Jeu de tests

|  ID | Test                             | Préconditions                                      | Étapes                                              | Résultat attendu                                                  | Résultat obtenu                                     |
| --: | -------------------------------- | -------------------------------------------------- | --------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------- |
|  B1 | Login success             | Compte existant, mdp correct           | Ecran d'accueil  |     |          |
|  B2 | Échec simple incrémente compteur | Compte existant                                    | Tenter login avec mot de passe incorrect 1 fois     | `failed_attempts` = 1, `last_failed_at` mis à jour, message erreur "Identifiants incorrects"                |                          |
|  B3 | Délai progressif (backoff)       | Après 5 échecs                                     | Tenter 6ᵉ échec et mesurer latence                  | Réponse retardée (≥1s et augmentant)                              |         |
|  B4 | Verrouillage temporaire          | Après 10 échecs consécutifs                        | Faire 10ᵉ puis 11ᵉ échec                            | `lock_until` défini (NOW + 15min), messages appropriés            |   |
|  B5 | Tentative pendant lock           | Compte verrouillé                                  | Essayer de se connecter pendant lock                | Refus immédiat avec message verrou                                |  |
|  B6 | Réinitialisation après succès    | Compte avec `failed_attempts`>0                    | Réussir login avec mot de passe correct             | `failed_attempts` remis à 0, `lock_until` NULL                    |                       |
|  B7 | Message générique                | N'importe quel échec (user inconnu ou mdp mauvais) | Essayer login email inexistant                      | Affichage toujours "Identifiants incorrects"                      |           |
|  B8 | Limite IP (soft) — bonus         | Table `login_attempts` présente                    | Simuler >100 tentatives depuis même IP en 1h        | Réponse : message "Trop de tentatives" ou blocage                 |   |
|  B9 | Interaction MFA + lock           | Compte MFA activé et `failed_attempts` élevé       | Après verrouillage, tenter bypass MFA               | Impossible d'atteindre `mfa_verify.php` sans mot de passe correct |        |
| B10 | Logs & traçabilité (manuel)      | Logging activé si prévu                            | Réaliser échecs et succès                           | Entrées logs avec IP, timestamp, user, résultat                   |       |
| B11 | Remédiation utilisateur          | Compte verrouillé                                  | Suivre procédure (mail ou support) — si implémentée | Utilisateur reçoit notification / peut débloquer via procédure    |  |


??? question "Corrigé"

    **Exemple `login.php` (simplifié avec anti-bruteforce)**

    ```php
    <?php require __DIR__ . '/config.php'; ?>
    <!DOCTYPE html>
    <html lang="fr">
    <head><meta charset="UTF-8"><title>Connexion sécurisée</title></head>
    <body>
    <h1>Connexion</h1>
    <?php
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);
        $password = $_POST['password'] ?? '';
        if ($email && $password) {
            $stmt = $pdo->prepare('SELECT * FROM users WHERE email = ?');
            $stmt->execute([$email]);
            $user = $stmt->fetch();

            if ($user) {
                // Vérifier si verrouillé
                if ($user['lock_until'] && strtotime($user['lock_until']) > time()) {
                    echo '<p style="color:red">Compte temporairement verrouillé. Réessayez plus tard.</p>';
                } elseif (password_verify($password, $user['password_hash'])) {
                    // Succès → reset compteur
                    $pdo->prepare('UPDATE users SET failed_attempts=0, lock_until=NULL WHERE id=?')
                        ->execute([$user['id']]);
                    $_SESSION['user_id'] = $user['id'];
                    $_SESSION['user_email'] = $user['email'];
                    if ($user['mfa_enabled']) {
                        $_SESSION['mfa_required'] = true;
                        header('Location: mfa_verify.php');
                    } else {
                        header('Location: mfa_setup.php');
                    }
                    exit;
                } else {
                    // Échec → incrémenter
                    $failed = $user['failed_attempts'] + 1;
                    $pdo->prepare('UPDATE users SET failed_attempts=?, last_failed_at=NOW() WHERE id=?')
                        ->execute([$failed, $user['id']]);

                    if ($failed >= 10) {
                        // Verrouillage 15 minutes
                        $pdo->prepare('UPDATE users SET lock_until=? WHERE id=?')
                            ->execute([date('Y-m-d H:i:s', time() + 15*60), $user['id']]);
                        echo '<p style="color:red">Compte verrouillé 15 minutes.</p>';
                    } else {
                        // Délai progressif (anti-bruteforce)
                        $delay = max(0, $failed - 4); // à partir du 5e échec
                        if ($delay > 0) sleep($delay);
                        echo '<p style="color:red">Identifiants incorrects.</p>';
                    }
                }
            } else {
                // Compte inexistant → message neutre
                echo '<p style="color:red">Identifiants incorrects.</p>';
            }
        }
    }
    ?>
    <form method="post">
        <label>Email <input type="email" name="email" required></label><br>
        <label>Mot de passe <input type="password" name="password" required></label><br>
        <button type="submit">Se connecter</button>
    </form>
    <p><a href="register.php">Créer un compte</a></p>
    </body></html>
    ```


