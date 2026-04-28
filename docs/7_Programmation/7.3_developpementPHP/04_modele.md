# 4. Le modèle et accès aux données (PDO) 🗄️

![en construction](../../images/enConstruction.png){: .center width=50%}

## Introduction

Le **modèle** est la couche de l'architecture MVC dédiée à l'**accès aux données**. Dans ce TP, nous étudions comment PHP dialogue avec la base de données MariaDB/MySQL via l'interface **PDO** (PHP Data Objects).

### PDO : interface universelle d'accès aux données

PDO fonctionne avec de multiples SGBDR : MySQL, MariaDB, PostgreSQL, SQLite…

> 💡 L'avantage de PDO : si vous changez de SGBDR, vous n'avez pas à réécrire toutes les fonctions d'accès aux données.

### Fonctions de base PDO

| Étape | Fonction PDO | Rôle |
|-------|-------------|------|
| 1 | `new PDO(...)` | Connexion à la base de données |
| 2 | `$cnx->prepare($sql)` | Prépare la requête SQL |
| 3 | `$req->bindValue(...)` | Associe une valeur à un paramètre |
| 4 | `$req->execute()` | Exécute la requête |
| 5 | `$req->fetch(PDO::FETCH_ASSOC)` | Récupère une ligne de résultat |

## A — Analyse du fonctionnement du modèle 🔍

## Question 1 — Analyse de `getRestoByIdR()` dans `bd.resto.inc.php` 🔎

**Documents à utiliser :** fichiers du projet, annexes 1, 2, 4, 5 et 7

### Requêtes préparées

```php
function getRestoByIdR($idR) {
    $cnx = connexionPDO();
    $req = $cnx->prepare("SELECT * FROM resto WHERE idR = :idR");
    $req->bindValue(':idR', $idR, PDO::PARAM_INT);
    $req->execute();
    $resultat = $req->fetch(PDO::FETCH_ASSOC);
    return $resultat;
}
```

Le tag `:idR` dans la requête est un **paramètre nommé**. La fonction `bindValue()` l'associe à la variable PHP.

La constante `PDO::PARAM_INT` vérifie que la valeur est bien un entier. S'il y avait plusieurs paramètres, on ferait plusieurs appels à `bindValue()`.

### 1.1 — Paramètre de la fonction 🔎

Indiquer le nom du paramètre de la fonction et sa valeur dans l'exemple d'utilisation de l'annexe 4.

??? question "Éléments de réponses ✅"
    Le paramètre de la fonction est **`$idR`**. Dans l'exemple de l'annexe 4, cet appel est `getRestoByIdR(1)` donc `$idR` vaut **1**.

### 1.2 — Requête exécutée 🗄️

À l'aide des annexes, retrouver la requête SQL exécutée par la fonction `getRestoByIdR()`.

??? question "Éléments de réponses ✅"
    ```sql
    SELECT * FROM resto WHERE idR = :idR
    ```
    Après l'appel à `bindValue()`, la requête réellement exécutée avec l'exemple est :
    ```sql
    SELECT * FROM resto WHERE idR = 1
    ```

### 1.3 — Pourquoi une seule ligne ? 🤔

Expliquer pourquoi cette requête SQL ne retourne qu'une seule ligne.

??? question "Éléments de réponses ✅"
    La requête ne retourne qu'une seule ligne car la condition `WHERE idR = :idR` est basée sur la valeur de la **clé primaire** de la table `resto`. Par définition, la clé primaire est unique : il ne peut exister qu'un seul restaurant avec un `idR` donné.

### Le curseur et `fetch()`

Quand une requête SQL est exécutée, le SGBDR renvoie un **curseur** : un ensemble de lignes et de colonnes organisées comme un tableau.

**Exemple pour `SELECT idR, nomR, villeR FROM resto` :**

| idR | nomR | villeR |
|-----|------|--------|
| 1 | l'entrepote | Bordeaux |
| 2 | le bar du charcutier | Bordeaux |
| 3 | Sapporo | Bordeaux |

Ce curseur contient 3 lignes et 3 colonnes. Il est lu **ligne par ligne** avec `fetch()`.

```php
$resultat = $req->fetch(PDO::FETCH_ASSOC);
// Résultat : ['idR' => 1, 'nomR' => "l'entrepote", 'villeR' => 'Bordeaux']
```

### Parcours complet d'un curseur (`while`)

```php
$ligne = $req->fetch(PDO::FETCH_ASSOC);
while ($ligne) {
    $resultat[] = $ligne;
    $ligne = $req->fetch(PDO::FETCH_ASSOC);
}
// Quand fetch() retourne false, la boucle s'arrête
```

### 1.4 — Syntaxe d'accès à un tableau associatif ⌨️

Rappeler la syntaxe utilisée pour accéder à un champ d'un tableau associatif.

??? question "Éléments de réponses ✅"
    ```php
    $nomTableauAssociatif['nomDuChamp']
    ```
    Par exemple : `$unResto['nomR']`

### 1.5 — Accès au nom du restaurant ⌨️

Rappeler comment accéder au nom du restaurant dans la variable retournée par `getRestoByIdR()`.

??? question "Éléments de réponses ✅"
    ```php
    $unResto['nomR']
    ```

## Question 2 — Analyse de `getRestosByNomR()` 🔎

**Documents à utiliser :** fichiers du projet, annexes 2, 4, 6 et 7

### 2.1 — Requête SQL dans `getRestosByNomR()` 🗄️

Quelle requête SQL est envoyée à `prepare()` dans `getRestosByNomR()` ?

??? question "Éléments de réponses ✅"
    ```sql
    SELECT * FROM resto WHERE nomR LIKE :nomR
    ```

### 2.2 — Requête réellement exécutée 🗄️

Si on appelle `getRestosByNomR('charcut')`, quelle requête SQL est réellement exécutée après l'appel à `bindValue()` ?

> 💡 Penser à l'opérateur SQL `LIKE` et aux wildcards `%`.

??? question "Éléments de réponses ✅"
    ```sql
    SELECT * FROM resto WHERE nomR LIKE '%charcut%'
    ```
    Le `bindValue()` associe `"%charcut%"` au paramètre `:nomR`. Les `%` permettent de trouver tous les restaurants dont le nom **contient** la chaîne `charcut`.

### 2.3 — Résultats multiples 🤔

Cette requête est-elle susceptible de retourner **plusieurs lignes** ?

??? question "Éléments de réponses ✅"
    **Oui.** Le symbole `%` dans la clause `LIKE` permet de trouver tous les restaurants dont le nom contient `charcut`. Plusieurs restaurants peuvent correspondre à ce critère.

### 2.4 — Type de retour de la fonction 🤔

Parmi les deux propositions, laquelle est correcte ? Justifier à l'aide du code et de vos connaissances.

**a)** La variable `$resultat` retournée est un **tableau associatif** contenant les informations d'un restaurant.

**b)** La variable `$resultat` retournée est un **tableau de tableaux associatifs**. Chaque case contient les informations d'un restaurant.

??? question "Éléments de réponses ✅"
    La proposition **b)** est correcte. Dans le code de `getRestosByNomR()`, une boucle `while` parcourt le curseur et construit un **tableau de tableaux associatifs** :
    ```php
    while ($ligne = $req->fetch(PDO::FETCH_ASSOC)) {
        $resultat[] = $ligne;
    }
    ```
    Chaque `$ligne` est un tableau associatif (un restaurant), et `$resultat[]` accumule toutes les lignes. La requête pouvant retourner plusieurs restaurants, `$resultat` peut donc contenir plusieurs tableaux associatifs.

## Question 3 — Analyse de `getNoteMoyenneByIdR()` dans `bd.critiquer.inc.php` 📊

**Documents à utiliser :** fichiers du projet, annexe 8

### 3.1 — Rôle de la requête 🤔

Expliquer le rôle de cette requête :

```sql
SELECT AVG(note) FROM critiquer WHERE idR = :idR
```

??? question "Éléments de réponses ✅"
    Cette requête **calcule la note moyenne** d'un restaurant en faisant la moyenne de toutes les critiques reçues (colonne `note` de la table `critiquer`), pour le restaurant dont l'identifiant `idR` est passé en paramètre.

### 3.2 — Nombre de résultats attendus 🔢

Combien de résultats cette requête SQL retourne-t-elle ?

??? question "Éléments de réponses ✅"
    La fonction `AVG()` est une fonction d'agrégation : elle retourne **un seul résultat** (la moyenne calculée), peu importe le nombre de critiques du restaurant.

### 3.3 — Nom de la colonne dans le résultat 🔎

Exécuter la requête (en remplaçant `:idR` par `2`) dans phpMyAdmin. Comment est nommée la colonne affichée dans le résultat ?

??? question "Éléments de réponses ✅"
    La colonne est nommée **`avg(note)`** — SQL utilise le nom de la fonction comme nom de colonne par défaut lorsqu'aucun alias n'est défini. C'est pourquoi dans le code PHP on accède au résultat via `$resultat["avg(note)"]`.

### 3.4 — Valeurs retournées 🔎

Exécuter la requête avec un identifiant **existant**, puis avec un identifiant **impossible** (ex: `0` ou `-1`).

| Cas | Valeur retournée |
|-----|-----------------|
| Restaurant existant avec critiques | |
| Restaurant sans critiques ou inexistant | |

??? question "Éléments de réponses ✅"
    | Cas | Valeur retournée |
    |-----|-----------------|
    | Restaurant existant avec critiques | Un **nombre réel** (ex: `3.67`) |
    | Restaurant sans critiques ou inexistant | **`NULL`** |

### 3.5 — Résultat retourné par la fonction 🔎

À partir des questions précédentes, indiquer quel résultat sera retourné par la fonction selon les cas.

??? question "Éléments de réponses ✅"
    - Si le restaurant a des critiques → la fonction retourne sa **note moyenne** (nombre réel).
    - Si le restaurant n'a pas de critiques ou n'existe pas → la fonction retourne **`0`** (grâce à la condition finale qui intercepte le `NULL`).

### 3.6 — Explication de la condition finale 🤔

Expliquer la condition suivante en fin de fonction :

```php
if ($resultat["avg(note)"] != NULL) {
    return $resultat["avg(note)"];
} else {
    return 0;
}
```

??? question "Éléments de réponses ✅"
    `$resultat["avg(note)"]` contient la valeur renvoyée par la requête SQL :

    - Si le restaurant a des critiques, `AVG()` retourne un nombre → la condition est vraie → on retourne ce nombre.
    - Si le restaurant n'a pas de critiques (ou n'existe pas), `AVG()` retourne `NULL` → la condition est fausse → on retourne `0` pour éviter d'afficher `NULL` dans la vue.

## Question 4 — Insertion de données : `addAimer()` dans `bd.aimer.inc.php` ⭐

**Documents à utiliser :** fichiers du projet, annexes 9, 10 et 11

### Contexte

Dans la base, la table `aimer` indique qu'un utilisateur aime un restaurant. Pour "aimer" un restaurant, l'utilisateur clique sur l'étoile ⭐ dans la fiche du restaurant.

```php
function addAimer($idR, $mailU) {
    $cnx = connexionPDO();
    $req = $cnx->prepare("INSERT INTO aimer (idR, mailU) VALUES (:idR, :mailU)");
    $req->bindValue(':idR',   $idR,   PDO::PARAM_INT);
    $req->bindValue(':mailU', $mailU, PDO::PARAM_STR);
    return $req->execute();
}
```

### 4.1 — Rôle de la requête 🗄️

Expliquer le rôle de la requête présente dans `addAimer()`.

??? question "Éléments de réponses ✅"
    La requête `INSERT INTO aimer (idR, mailU) VALUES (:idR, :mailU)` **insère une nouvelle ligne** dans la table `aimer`. Cette ligne signifie qu'un utilisateur (identifié par son `mailU`) aime un restaurant (identifié par son `idR`).

### 4.2 — Différentes constantes PDO 🤔

Pourquoi les deux appels à `bindValue()` n'utilisent-ils pas la même constante PDO en 3ème paramètre ?

| Paramètre | Constante PDO | Raison |
|-----------|--------------|--------|
| `:idR` | `PDO::PARAM_INT` | |
| `:mailU` | `PDO::PARAM_STR` | |

??? question "Éléments de réponses ✅"
    | Paramètre | Constante PDO | Raison |
    |-----------|--------------|--------|
    | `:idR` | `PDO::PARAM_INT` | `idR` est un **entier** dans la base de données (clé primaire numérique). |
    | `:mailU` | `PDO::PARAM_STR` | `mailU` est une **chaîne de caractères** (adresse email). |

    La constante PDO indique à la bibliothèque le type de la valeur, afin de valider et formater correctement les paramètres avant exécution.

### 4.3 — Valeur retournée par `execute()` 🔎

À l'aide de l'annexe 11 (documentation PHP), déterminer quelle valeur est retournée par `execute()` en cas de réussite ou d'échec.

??? question "Éléments de réponses ✅"
    La fonction `execute()` retourne :
    - **`true`** en cas de réussite de l'exécution
    - **`false`** en cas d'échec

### 4.4 — Type de retour de `addAimer()` 🔎

Déduire de la question précédente le type de données retourné par `addAimer()`.

??? question "Éléments de réponses ✅"
    La fonction `addAimer()` retourne directement la valeur renvoyée par `execute()`. Elle retourne donc un **booléen** (`true` ou `false`).

### 4.5 — Double insertion 🤔

Si un utilisateur tente d'aimer un restaurant qu'il **aime déjà**, quelle sera la valeur retournée par `addAimer()` ? Pourquoi ?

> 💡 Rappel : `(idR, mailU)` est la clé primaire de la table `aimer`.

??? question "Éléments de réponses ✅"
    La fonction retournera **`false`**. En effet, `(idR, mailU)` est la clé primaire de la table `aimer` : il est impossible d'insérer deux fois la même paire de valeurs. La tentative d'insertion échoue avec une violation de contrainte de clé primaire, et `execute()` retourne `false`.

    > ⚠️ En mode debug PDO (`PDO::ERRMODE_EXCEPTION`), une **exception est levée** et le programme s'arrête au lieu de retourner `false`.

## Synthèse — PDO et connexion 📌

### Connexion à la base de données

```php
function connexionPDO() {
    global $login, $mdp, $bd, $serveur;
    $conn = new PDO("mysql:host=$serveur;dbname=$bd", $login, $mdp);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    return $conn;
}
```

| Paramètre `new PDO()` | Rôle |
|----------------------|------|
| `mysql:host=$serveur` | Driver et adresse du serveur |
| `dbname=$bd` | Nom de la base de données |
| `$login` | Utilisateur MySQL |
| `$mdp` | Mot de passe |

> ⚠️ `PDO::ERRMODE_EXCEPTION` est utile en **développement**. En production, il est préférable de le désactiver pour ne pas exposer les informations de la base de données.

### Gestion des exceptions

| Bloc | Rôle |
|------|------|
| `try` | Code à exécuter sous condition d'absence d'erreur |
| `catch (PDOException $e)` | Interception des erreurs PDO : affichage et arrêt |

## B — Ajout de fonctionnalités au modèle ✏️

## Question 5 — Créer la fonction `delAimer()` 🗑️

**Documents à utiliser :** fichiers du projet, annexes 9 et 10

### 5.1 — Clé primaire de `aimer` 🔎

Quelle est la clé primaire de la table `aimer` ?

??? question "Éléments de réponses ✅"
    La clé primaire est **composée** de deux champs : **`idR`** et **`mailU`**. Les deux ensemble identifient de façon unique qu'un utilisateur aime un restaurant précis.

### 5.2 — Syntaxe SQL de suppression 🗄️

Rappeler la syntaxe de la requête de suppression en SQL.

??? question "Éléments de réponses ✅"
    ```sql
    DELETE FROM table WHERE condition;
    ```
    Avec clé primaire composée :
    ```sql
    DELETE FROM table WHERE champ1 = valeur1 AND champ2 = valeur2;
    ```

### 5.3 — Requête de suppression 🗄️

Écrire la requête SQL permettant de supprimer **une occurrence précise** de la table `aimer`.

??? question "Éléments de réponses ✅"
    ```sql
    DELETE FROM aimer WHERE idR = 1 AND mailU = 'test@bts.sio';
    ```
    Avec des paramètres PDO :
    ```sql
    DELETE FROM aimer WHERE idR = :idR AND mailU = :mailU
    ```

### 5.4 — Test dans phpMyAdmin 🧪

Se connecter à phpMyAdmin et tester la requête avec un exemple concret.

### 5.5 — Emplacement de la fonction 📁

Dans quel script du modèle doit être placée la fonction `delAimer()` ? Justifier.

??? question "Éléments de réponses ✅"
    La fonction `delAimer()` doit être placée dans le script **`bd.aimer.inc.php`**. C'est dans ce fichier que se trouvent toutes les fonctions d'accès à la table `aimer` (`addAimer()`…). Regrouper les fonctions d'accès à une même table dans un même fichier est un principe fondamental du MVC.

### 5.6 — Prototype de la fonction ⌨️

Quels paramètres sont nécessaires à `delAimer()` pour supprimer précisément une occurrence ? En déduire le prototype :

```php
function delAimer(_____, _____) {
    // ...
}
```

??? question "Éléments de réponses ✅"
    La fonction a besoin des deux champs de la clé primaire pour cibler une occurrence précise :

    ```
    fonction delAimer(mailU : chaîne, idR : entier) : booléen
    ```

    En PHP :
    ```php
    function delAimer($mailU, $idR) { ... }
    ```

### 5.7 — Écrire le code de `delAimer()` ✏️

Écrire le code complet de la fonction, en vous inspirant de `addAimer()`. Ajouter un appel de test dans la section de test du script.

```php
function delAimer($idR, $mailU) {
    $cnx = connexionPDO();

    $req = $cnx->prepare("/* requête à compléter */");

    // bindValue à compléter

    return $req->execute();
}
```

??? question "Éléments de réponses ✅"
    ```php
    function delAimer($mailU, $idR) {
        $resultat = -1;
        try {
            $cnx = connexionPDO();
            $req = $cnx->prepare("DELETE FROM aimer WHERE idR = :idR AND mailU = :mailU");
            $req->bindValue(':idR',   $idR,   PDO::PARAM_INT);
            $req->bindValue(':mailU', $mailU, PDO::PARAM_STR);
            $resultat = $req->execute();
        } catch (PDOException $e) {
            print "Erreur !: " . $e->getMessage();
            die();
        }
        return $resultat;
    }
    ```

    Dans la section de test :
    ```php
    echo "\n delAimer(\"test@bts.sio\", 2) : \n";
    print_r(delAimer("test@bts.sio", 2));
    ```

## Question 6 — Consultation des critiques d'un restaurant 💬

**Documents à utiliser :** fichiers du projet, annexe 12

La fiche descriptive d'un restaurant doit afficher en bas de page la **liste des critiques** (notes et commentaires) laissées par les utilisateurs.

La vue et le contrôleur sont déjà codés, mais la fonction du modèle retourne pour l'instant une liste vide.

### Travail à réaliser

À partir de la structure de la table `critiquer` :

```
critiquer (idR, mailU, note, commentaire)
```

??? question "Éléments de réponses ✅"
    **Prototype de la fonction :**
    ```
    fonction getCritiquerByIdR(idR : entier) : tableau de tableaux associatifs
    ```

    **Requête SQL :**
    ```sql
    SELECT * FROM critiquer WHERE idR = 1
    ```

    **Structure de données retournée :**
    ```
    $critiques
    ├── [0] → ['idR' => 1, 'mailU' => 'user@mail.com', 'note' => 4, 'commentaire' => '...']
    ├── [1] → ['idR' => 1, 'mailU' => 'autre@mail.com', 'note' => 3, 'commentaire' => '...']
    └── ...
    ```

    **Code complet de `getCritiquerByIdR()` :**
    ```php
    function getCritiquerByIdR($idR) {
        $resultat = array();
        try {
            $cnx = connexionPDO();
            $req = $cnx->prepare("SELECT * FROM critiquer WHERE idR = :idR");
            $req->bindValue(':idR', $idR, PDO::PARAM_INT);
            $req->execute();
            $ligne = $req->fetch(PDO::FETCH_ASSOC);
            while ($ligne) {
                $resultat[] = $ligne;
                $ligne = $req->fetch(PDO::FETCH_ASSOC);
            }
        } catch (PDOException $e) {
            print "Erreur !: " . $e->getMessage();
            die();
        }
        return $resultat;
    }
    ```

    Dans la section de test :
    ```php
    echo "\n getCritiquerByIdR(1) : \n";
    print_r(getCritiquerByIdR(1));
    ```

*[← Partie 3](./03_vue.md) | [Partie 5 — Contrôleur principal →](./05_controleur_principal.md)*
