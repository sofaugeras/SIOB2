# 2. Le contrôleur 🎛️

![en construction](../../images/enConstruction.png){: .center width=50%}

!!! info "Rappel sur les contrôleurs"

Un contrôleur est l'élément **central** d'une fonctionnalité sur un site MVC. Chaque fonctionnalité est gérée par un contrôleur qui :

1. **Récupère** les données transmises par un formulaire (GET/POST)
2. **Appelle** les fonctions du modèle pour lire ou écrire en base de données
3. **Traite** les données (logique applicative)
4. **Appelle** la vue pour afficher le résultat à l'utilisateur

## Question 1 — Contrôleur de connexion : `connexion.php` 🔐

**Documents à utiliser :** fichiers du projet, annexes 1, 2, 3, 4

### Contexte

Le contrôleur de connexion gère **deux cas** :

**Cas 1 — Affichage du formulaire**
L'utilisateur clique sur "Connexion" dans le menu. Le contrôleur est appelé **sans paramètre** → il affiche le formulaire de connexion.

**Cas 2 — Traitement du formulaire**
L'utilisateur a saisi son login et mot de passe et validé le formulaire. Le contrôleur reçoit ces données → il tente la connexion.

```
Contrôleur connexion.php
        │
        ├─ [Pas de paramètre] ──────────────────► vue : vueAuthentification.php
        │                                          (affiche le formulaire)
        │
        └─ [login + mdp transmis]
                    │
                    ├─ [connexion OK] ────────────► vue : vueConfirmationAuth.php
                    │
                    └─ [connexion KO] ────────────► vue : vueAuthentification.php
                                                    (formulaire affiché de nouveau)
```

Deux scripts modèle sont utilisés :
- `authentification.inc.php`
- `bd.utilisateur.inc.php`

### Observation du modèle d'authentification (annexes 1 et 2)

La section de test du fichier `authentification.inc.php` :

```php
if ($_SERVER["SCRIPT_FILENAME"] == __FILE__) {
    header('Content-Type:text/plain');

    if (isLoggedOn()) {
        echo "logged\n";
    } else {
        echo "not logged\n";
    }

    login("test@bts.sio", "sio");

    if (isLoggedOn()) {
        echo "logged\n";
    } else {
        echo "not logged\n";
    }

    $mail = getMailULoggedOn();
    // ...
}
```

### 1.1 — Premier appel à `isLoggedOn()` 🔎

Lors du **1er appel** à `isLoggedOn()`, l'utilisateur est-il connecté ?

??? question "Éléments de réponses ✅"
    Non. Au premier appel à `isLoggedOn()`, aucune connexion n'a encore eu lieu. La fonction retourne **`false`**, l'utilisateur n'est pas connecté.

### 1.2 — Deuxième appel à `isLoggedOn()` 🔎

Lors du **2ème appel** à `isLoggedOn()` (après l'appel à `login()`), l'utilisateur est-il connecté ?

??? question "Éléments de réponses ✅"
    Oui. Après l'appel à `login("test@bts.sio", "sio")`, l'utilisateur est connecté. La fonction `isLoggedOn()` retourne **`true`**.

### 1.3 — Fonction de connexion 🎯

Quelle fonction permet la connexion de l'utilisateur ? Donner sa définition (signature/prototype).

??? question "Éléments de réponses ✅"
    Il s'agit de la fonction `login()`.

    Prototype :
    ```
    fonction login(utilisateur : chaîne, motDePasse : chaîne) : booléen
    ```

    En PHP :
    ```php
    login($mailU, $mdpU);
    ```

### 1.4 — Rôle des fonctions du modèle ⚙️

| Fonction | Rôle |
|-||
| `login($mail, $mdp)` | |
| `isLoggedOn()` | |
| `getMailULoggedOn()` | |
| `logout()` | |

??? question "Éléments de réponses ✅"
    | Fonction | Rôle |
    |-|-|
    | `login($mail, $mdp)` | Connecte l'utilisateur dont le mail et le mot de passe sont passés en paramètre. |
    | `isLoggedOn()` | Retourne `true` si un utilisateur est connecté, `false` sinon. |
    | `getMailULoggedOn()` | Retourne l'adresse mail de l'utilisateur actuellement connecté (son identifiant). |
    | `logout()` | Déconnecte l'utilisateur actuellement connecté. |

### 1.5 — Schéma d'authentification 🗺️

À l'aide des annexes 2 et 3, compléter le schéma ci-dessous :

```
Formulaire de connexion
        │
        │  méthode : ___________
        │  indices du tableau : $_POST['________'] et $_POST['________']
        │
        ▼
Contrôleur connexion.php
        │
        │  isLoggedOn() == _______ ?
        │
   OUI ─┴─ NON
    │           │
    ▼           ▼
vueConfirmation  vueAuthentification
```

??? question "Éléments de réponses ✅"
    ```
    Formulaire de connexion
            │
            │  méthode : POST
            │  indices du tableau : $_POST['mailU'] et $_POST['mdpU']
            │
            ▼
    Contrôleur connexion.php
            │
            │  isLoggedOn() == true ?
            │
       OUI ─┴─ NON
        │           │
        ▼           ▼
    vueConfirmationAuth.php    vueAuthentification.php
    ```

### 1.6 — Compléter le contrôleur `connexion.php` ✏️

En vous inspirant de la section de test du modèle, compléter le code du contrôleur en respectant les étapes suivantes :

```php
<?php
// Étape 1 : inclure les modèles nécessaires
include_once "$racine/modele/authentification.inc.php";
include_once "$racine/modele/bd.utilisateur.inc.php";

// Étape 2 : récupérer les données POST si elles existent
if (/* condition : des données sont transmises */) {

    // Récupérer login et mot de passe depuis $_POST
    $mail = /* à compléter */;
    $mdp  = /* à compléter */;

    // Tenter la connexion
    /* à compléter */;

    // Tester si la connexion a réussi
    if (/* à compléter */) {
        // Afficher la confirmation
        include "$racine/vue/entete.html.php";
        include "$racine/vue/vueConfirmationAuth.php";
        include "$racine/vue/pied.html.php";
    } else {
        // Afficher le formulaire à nouveau
        include "$racine/vue/entete.html.php";
        include "$racine/vue/vueAuthentification.php";
        include "$racine/vue/pied.html.php";
    }

} else {
    // Étape déjà faite : afficher le formulaire de connexion
    include "$racine/vue/entete.html.php";
    include "$racine/vue/vueAuthentification.php";
    include "$racine/vue/pied.html.php";
}
?>
```

??? question "Éléments de réponses ✅"
    ```php
    <?php
    if ($_SERVER["SCRIPT_FILENAME"] == __FILE__) {
        $racine = "..";
    }
    include_once "$racine/modele/authentification.inc.php";

    // recuperation des donnees GET, POST, et SESSION
    if (!isset($_POST["mailU"]) || !isset($_POST["mdpU"])) {
        // Pas de données → afficher le formulaire
        $titre = "authentification";
        include "$racine/vue/entete.html.php";
        include "$racine/vue/vueAuthentification.php";
        include "$racine/vue/pied.html.php";
    } else {
        $mailU = $_POST["mailU"];
        $mdpU  = $_POST["mdpU"];

        login($mailU, $mdpU);

        if (isLoggedOn()) {
            // Connexion réussie
            $titre = "confirmation";
            include "$racine/vue/entete.html.php";
            include "$racine/vue/vueConfirmationAuth.php";
            include "$racine/vue/pied.html.php";
        } else {
            // Échec : réafficher le formulaire
            $titre = "authentification";
            include "$racine/vue/entete.html.php";
            include "$racine/vue/vueAuthentification.php";
            include "$racine/vue/pied.html.php";
        }
    }
    ?>
    ```

## Question 2 — Contrôleur de déconnexion : `deconnexion.php` 🚪

**Documents à utiliser :** fichiers du projet, annexes 1, 2 et 5

### 2.1 — Fonction de déconnexion 🎯

Quelle fonction du modèle permet de déconnecter l'utilisateur actuellement connecté ?

??? question "Éléments de réponses ✅"
    C'est la fonction **`logout()`**. Elle ne prend aucun paramètre.

### 2.2 — Vue de confirmation 🖼️

Quelle vue permettant de confirmer la déconnexion devra être appelée par ce contrôleur ?

??? question "Éléments de réponses ✅"
    C'est le script **`vueDeconnexion.php`** (ou `vueAuthentification.php` selon la version du projet).

### 2.3 — Donnée à transmettre 📨

Lors de la déconnexion, est-il utile de transmettre une donnée au contrôleur ?

??? question "Éléments de réponses ✅"
    **Non.** Aucune donnée n'est nécessaire. La fonction `logout()` ne prend pas de paramètre : elle déconnecte l'utilisateur actuellement en session, sans avoir besoin d'identifiant.

### 2.4 — Compléter `deconnexion.php` ✏️

Compléter le code du contrôleur. Il doit :
- Appeler la fonction appropriée du modèle
- Afficher un message de confirmation

```php
<?php
include_once "$racine/modele/authentification.inc.php";

// Déconnecter l'utilisateur
/* à compléter */;

// Afficher la confirmation
include "$racine/vue/entete.html.php";
include "$racine/vue//* à compléter */";
include "$racine/vue/pied.html.php";
?>
```

??? question "Éléments de réponses ✅"
    ```php
    <?php
    if ($_SERVER["SCRIPT_FILENAME"] == __FILE__) {
        $racine = "..";
    }
    include_once "$racine/modele/authentification.inc.php";

    // Déconnecter l'utilisateur
    logout();

    // Afficher la confirmation
    $titre = "authentification";
    include "$racine/vue/entete.html.php";
    include "$racine/vue/vueAuthentification.php";
    include "$racine/vue/pied.html.php";
    ?>
    ```

## Question 3 — Contrôleur de recherche : `rechercheResto.php` 🔍

**Documents à utiliser :** fichiers du projet, annexes 6, 7, 8 et 9

### Contexte

Le contrôleur `rechercheResto.php` gère **deux situations** :

1. Affichage du formulaire de recherche (`vueRechercheResto.php`)
2. Exécution de la recherche et affichage des résultats (`vueResultRecherche.php`)

La vue `vueResultRecherche.php` affiche la variable `$listeRestos`.

### 3.1 — Signatures des fonctions du modèle ⚙️

En consultant `bd.resto.inc.php`, donner la signature de chacune de ces fonctions :

| Fonction | Signature complète |
|-|-|
| `getRestos()` | |
| `getRestosByNomR($nomR)` | |
| `getRestosByAdresse($voie, $cp, $ville)` | |

??? question "Éléments de réponses ✅"
    | Fonction | Signature |
    |-|-|
    | `getRestos()` | `fonction getRestos() : tableau` |
    | `getRestosByNomR($nomR)` | `fonction getRestosByNomR(nomR : chaîne) : tableau` |
    | `getRestosByAdresse($voie, $cp, $ville)` | `fonction getRestosByAdresse(voieAdrR : chaîne, cpR : chaîne, villeR : chaîne) : tableau` |

### 3.2 — Contenu de `$_POST` 📨

Afficher le contenu de `$_POST` dans le contrôleur avec `print_r($_POST)`.

Quelle est sa valeur dans les deux cas suivants :

| Situation | Contenu de `$_POST` |
|--||
| Recherche par nom | |
| Recherche par adresse (ex: "rue saint rémi 33000 bordeaux") | |

??? question "Éléments de réponses ✅"
    **Recherche par nom** (ex: "entrepote") :
    ```
    Array (
        [nomR] => entrepote
    )
    ```

    **Recherche par adresse** (rue saint remi 33000 bordeaux) :
    ```
    Array (
        [voieAdrR] => rue saint remi
        [cpR]      => 33000
        [villeR]   => bordeaux
    )
    ```

### 3.3 — Noms des variables transmises en POST 📋

Quels sont les noms des variables transmises au contrôleur en méthode POST lors d'une recherche ?

??? question "Éléments de réponses ✅"
    Les variables suivantes sont transmises en méthode POST : **`nomR`**, **`voieAdrR`**, **`cpR`** et **`villeR`**.
    Elles correspondent aux champs des deux formulaires de recherche (par nom et par adresse).

### 3.4 — Récupérer les données POST 📥

Compléter la section de récupération des données POST pour valoriser `$nomR`, `$voieAdrR`, `$cpR` et `$villeR` :

```php
// Initialisation par défaut
$nomR     = "";
$voieAdrR = "";
$cpR      = "";
$villeR   = "";

// Récupération conditionnelle (exemple pour $nomR)
if (isset($_POST['nomR'])) {
    $nomR = $_POST['nomR'];
}

// À compléter pour les autres variables :
/* ... */
```

??? question "Éléments de réponses ✅"
    ```php
    $nomR = "";
    if (isset($_POST["nomR"])) {
        $nomR = $_POST["nomR"];
    }

    $voieAdrR = "";
    if (isset($_POST["voieAdrR"])) {
        $voieAdrR = $_POST["voieAdrR"];
    }

    $cpR = "";
    if (isset($_POST["cpR"])) {
        $cpR = $_POST["cpR"];
    }

    $villeR = "";
    if (isset($_POST["villeR"])) {
        $villeR = $_POST["villeR"];
    }
    ```

### 3.5 — Compléter le `switch` du contrôleur ✏️

Compléter le code de chaque cas en faisant appel à la fonction appropriée du modèle. Les données récupérées doivent être placées dans `$listeRestos`.

```php
if (!empty($_POST)) {
    $typeRecherche = $_POST['typeRecherche'] ?? '';

    switch ($typeRecherche) {
        case 'nom':
            $listeRestos = /* à compléter */;
            break;

        case 'adresse':
            $listeRestos = /* à compléter */;
            break;

        default:
            $listeRestos = getRestos();
    }
}
```

??? question "Éléments de réponses ✅"
    ```php
    switch ($critere) {
        case 'nom':
            $listeRestos = getRestosByNomR($nomR);
            break;

        case 'adresse':
            $listeRestos = getRestosByAdresse($voieAdrR, $cpR, $villeR);
            break;
    }
    ```

### 3.6 — Pourquoi tester `!empty($_POST)` ? 🤔

Pourquoi l'appel aux fonctions du modèle est-il conditionné par `!empty($_POST)` ?

??? question "Éléments de réponses ✅"
    On ne peut pas effectuer de recherche si aucune donnée n'est transmise par le formulaire. Si `$_POST` est vide, c'est que l'utilisateur n'a pas encore soumis de formulaire : on affiche simplement le formulaire vide, sans lancer de requête en base de données.

### 3.7 — Ajouter l'appel à la vue de résultats 🖼️

La vue `vueResultRecherche.php` ne doit être affichée que si des données ont été trouvées. Ajouter son inclusion en fin de contrôleur.

```php
// En fin de contrôleur
include "$racine/vue/entete.html.php";

// Toujours afficher le formulaire de recherche
include "$racine/vue/vueRechercheResto.php";

// Afficher les résultats uniquement si une recherche a été faite
if (/* condition à compléter */) {
    include "$racine/vue/vueResultRecherche.php";
}

include "$racine/vue/pied.html.php";
```

??? question "Éléments de réponses ✅"
    ```php
    $titre = "Recherche d'un restaurant";
    include "$racine/vue/entete.html.php";
    include "$racine/vue/vueRechercheResto.php";

    if (!empty($_POST)) {
        // Afficher les résultats uniquement si une recherche a été soumise
        include "$racine/vue/vueResultRecherche.php";
    }

    include "$racine/vue/pied.html.php";
    ```

## Question 4 — Analyse de `rechercheResto.php` : gestion de l'affichage 🔍

**Documents à utiliser :** fichiers du projet, annexes 6, 7 et 8

### 4.1 — Variable de choix du formulaire 🔎

Dans le code source de `vueRechercheResto.php`, quelle variable permet de choisir l'affichage du formulaire de recherche par **nom** ou par **adresse** ?

??? question "Éléments de réponses ✅"
    C'est la variable **`$critere`**. Selon sa valeur (`'nom'` ou `'adresse'`), la vue affiche le bon formulaire de recherche.

### 4.2 — Variable GET pour le type de recherche 📨

Quelle variable transmise en méthode GET au contrôleur permet de connaître le type de recherche souhaité ?

??? question "Éléments de réponses ✅"
    C'est la variable **`critere`** (sans `$`, car on parle de la variable transmise dans l'URL en méthode GET). Elle est récupérée dans le contrôleur via `$_GET["critere"]`.

### 4.3 — Où est faite cette transmission ? 🗺️

Rechercher où est faite cette transmission : quel script ? quelle ligne ?

??? question "Éléments de réponses ✅"
    La transmission se fait dans le champ `action` du formulaire de recherche dans `vueRechercheResto.php` :

    ```php
    <form action="./?action=recherche&critere=<?= $critere ?>" method="POST">
    ```

    La valeur de `$critere` est ainsi ajoutée à l'URL en méthode GET à chaque soumission du formulaire.

### 4.4 et 4.5 — Sans cette transmission 🤔

- Sans cette information, le contrôleur pourrait-il savoir quelle recherche effectuer ?
- Sans cette information, la vue pourrait-elle savoir quel formulaire afficher ?

??? question "Éléments de réponses ✅"
    **4.4 — Le contrôleur :** Oui, en théorie on pourrait analyser le contenu des variables transmises en POST (si `$nomR` n'est pas vide → recherche par nom, sinon → recherche par adresse). Mais cette approche est moins fiable et moins lisible.

    **4.5 — La vue :** Non. La vue ne pourrait pas savoir quel formulaire afficher si la variable `$critere` n'est pas transmise. Il faut toujours afficher le bon formulaire (par nom ou par adresse), même quand aucune donnée POST n'est présente.

### 4.6 — Variables pré-remplies 📋

Lorsqu'une recherche est effectuée, la vue affiche à nouveau le formulaire avec des valeurs pré-remplies. Quelles variables sont alors utilisées ?

??? question "Éléments de réponses ✅"
    Les variables **`$nomR`**, **`$voieAdrR`**, **`$cpR`** et **`$villeR`** sont utilisées pour pré-remplir les champs de recherche. Elles ont été valorisées dans le contrôleur à partir de `$_POST`, et la vue les utilise comme valeurs par défaut des champs `<input>`.

## Synthèse — Rôle et fonctionnement du contrôleur 📌

Le contrôleur est l'élément central des fonctionnalités d'une application MVC. Il permet de :

| Rôle | Description |
||-|
| Récupérer les actions utilisateur | Données GET, POST (saisies, choix, sélections) |
| Interroger le modèle | Appel aux fonctions pour lire ou écrire en base |
| Traiter les données | Logique applicative, calculs, validations |
| Commander l'affichage | Appel aux vues avec les données préparées |

### Schéma du fonctionnement de `rechercheResto.php` (recherche par nom)

```
Utilisateur ──[POST : nomR]──► rechercheResto.php
                                        │
                    include_once  ──────┤
                    bd.resto.inc.php    │
                                        │
                                        ├──► getRestosByNomR($nomR)
                                        │         │
                                        │    [base de données]
                                        │         │
                                        │    $listeRestos ◄────────
                                        │
                                        ├──► include entete.html.php
                                        ├──► include vueRechercheResto.php
                                        ├──► include vueResultRecherche.php
                                        └──► include pied.html.php
```

### Règles d'organisation

- Les **fonctions du modèle** sont accessibles grâce à `include_once` en début de contrôleur
- Les **vues** sont incluses **en fin** de contrôleur, une fois toute la logique applicative traitée

*[← Partie 1](./01_generalites.md) | [Partie 3 — Vue →](./03_vue.md)*
