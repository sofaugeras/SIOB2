# 3. La vue 🖼️

![en construction](../../images/enConstruction.png){: .center width=50%}

## Introduction

La **vue** a pour rôle unique d'**afficher les données** à l'utilisateur. Elle utilise des variables créées ou récupérées par le contrôleur, sans effectuer de traitement.

> 💡 Une vue contient essentiellement du code **HTML qui intègre du PHP** (et non l'inverse). Cela permet d'éviter les multiples `echo` et les concaténations complexes.

Cette partie étudie la vue `vueDetailResto.php`, appelée par le contrôleur `detailResto.php`.

## Partie A — Analyse d'une vue existante 🔍

## Question 1 — Les photos (`vueDetailResto.php`) 📷

**Documents à utiliser :** fichiers du projet, annexes 1, 2, 5 et 6

### 1.1 — Fonctions du modèle utilisées ⚙️

Quelles fonctions définies dans le modèle sont utilisées dans le contrôleur `detailResto.php` ?

??? question "Éléments de réponses ✅"
    Trois fonctions du modèle sont utilisées dans `detailResto.php` :

    - `getRestoByIdR($idR)` — récupère les informations du restaurant
    - `getTypesCuisineByIdR($idR)` — récupère les types de cuisine associés
    - `getPhotosByIdR($idR)` — récupère les photos du restaurant

### 1.2 — Annexes correspondantes 📄

Quelles annexes présentent le résultat d'exécution des fonctions trouvées à la question précédente ?

??? question "Éléments de réponses ✅"
    On trouve les résultats d'exécution dans les **annexes 4, 6 et 8**, respectivement pour `getRestoByIdR()`, `getPhotosByIdR()` et `getTypesCuisineByIdR()`.

### Rappel : tableaux associatifs PHP

Un tableau associatif permet de stocker plusieurs informations dans une seule variable. L'accès aux données se fait via des **clés** (chaînes de caractères) plutôt que des indices numériques.

**Exemple :**

```php
// Déclaration
$tabEtudiant = [
    'prenom' => 'Lionel',
    'nom'    => 'Romain',
    'age'    => 48
];

// Accès en lecture
echo $tabEtudiant['prenom'];   // affiche : Lionel

// Modification
$tabEtudiant['prenom'] = 'Patrice';
```

Après l'appel à `getPhotosByIdR()`, la variable `$lesPhotos` contient un tableau dont chaque case est un tableau associatif :

```
$lesPhotos
├── [0] → ['idP' => 1, 'cheminP' => 'entrepote.jpg', 'idR' => 1]
├── [1] → ['idP' => 2, 'cheminP' => 'entrepote2.jpg', 'idR' => 1]
└── [2] → ['idP' => 3, 'cheminP' => 'entrepote3.jpg', 'idR' => 1]
```

### 1.3 — Composition de chaque cellule de `$lesPhotos` 🔎

Comment est composée chacune des cellules du tableau `$lesPhotos` ?

??? question "Éléments de réponses ✅"
    Chaque cellule du tableau `$lesPhotos` est un **tableau associatif** contenant les informations d'une photo : `idP` (identifiant), `cheminP` (nom du fichier) et `idR` (identifiant du restaurant associé).

### 1.4 — Accès au nom du fichier de la première photo 🔎

Repérer dans le code de `vueDetailResto.php` l'instruction PHP permettant d'afficher le chemin de la première photo.

```php
// Extrait de vueDetailResto.php
<?php if (count($lesPhotos) > 0) { ?>
    <img src="photos/<?= $lesPhotos[0]["cheminP"] ?>" alt="photo du restaurant" />
<?php } ?>
```

Quelle est l'instruction permettant d'accéder au chemin de la **première** photo ?

??? question "Éléments de réponses ✅"
    ```php
    <?= $lesPhotos[0]["cheminP"] ?>
    ```
    L'indice `0` désigne la première photo du tableau, et la clé `"cheminP"` donne accès au nom du fichier image.

### 1.5 — Rôle de `count($lesPhotos) > 0` 🤔

Quel est le rôle de la condition `if(count($lesPhotos) > 0)` dans le code de la vue ?

??? question "Éléments de réponses ✅"
    Cette condition **vérifie que le tableau contient au moins une photo** avant d'essayer de l'afficher. Si aucune photo n'a été associée au restaurant, le tableau serait vide et accéder à `$lesPhotos[0]` provoquerait une erreur.

### 1.6 — Syntaxe générale d'accès aux champs ⌨️

Quelle est la syntaxe générale permettant d'accéder à un champ (`idP`, `cheminP` ou `idR`) contenu dans la variable `$lesPhotos` ?

Compléter :

```php
// Pour accéder à idP de la photo à l'indice $i :
$lesPhotos[___]["___"]

// Pour accéder à cheminP de la photo à l'indice $i :
___________

// Pour afficher toutes les photos avec une boucle :
for ($i = 0; $i < count($lesPhotos); $i++) {
    echo $lesPhotos[___]["___"];
}
```

??? question "Éléments de réponses ✅"
    La syntaxe générale est :
    ```php
    $lesPhotos[indice]["nom du champ"]
    ```

    Exemples complétés :
    ```php
    // idP de la photo à l'indice $i :
    $lesPhotos[$i]["idP"]

    // cheminP de la photo à l'indice $i :
    $lesPhotos[$i]["cheminP"]

    // Afficher le cheminP de toutes les photos :
    for ($i = 0; $i < count($lesPhotos); $i++) {
        echo $lesPhotos[$i]["cheminP"];
    }
    ```

## Question 2 — Les types de cuisine (`vueDetailResto.php`) 🍽️

**Documents à utiliser :** fichiers du projet, annexes 1, 2, 7 et 8

### 2.1 — Origine de `$lesTypesCuisine` 🎯

Quel contrôleur produit la variable `$lesTypesCuisine` ? Préciser le nom de la fonction et du modèle utilisés.

??? question "Éléments de réponses ✅"
    C'est le contrôleur **`detailResto.php`** qui produit `$lesTypesCuisine` via l'appel :
    ```php
    $lesTypesCuisine = getTypesCuisineByIdR($idR);
    ```
    La fonction `getTypesCuisineByIdR()` est définie dans le modèle `bd.typeCuisine.inc.php`.

### 2.2 — Schéma de `$lesTypesCuisine` 🗺️

Schématiser le contenu de la variable `$lesTypesCuisine` (sur le modèle du schéma de `$lesPhotos`).

```
$lesTypesCuisine
├── [0] → [...]
├── [1] → [...]
└── [...]
```

??? question "Éléments de réponses ✅"
    Comme `$lesPhotos`, il s'agit d'un **tableau de tableaux associatifs** :
    ```
    $lesTypesCuisine
    ├── [0] → ['idTC' => 1, 'libelleTC' => 'Sud-Ouest']
    ├── [1] → ['idTC' => 3, 'libelleTC' => 'Viande']
    └── [2] → ['idTC' => 5, 'libelleTC' => 'Grillade']
    ```

### 2.3 — Nombre de types de cuisine 🔢

Combien de types de cuisine sont contenus dans cette variable pour le restaurant consulté ?

??? question "Éléments de réponses ✅"
    Il y a **3 types de cuisine** pour le restaurant de l'exemple (l'entrepote).

### 2.4 — Accès au libellé ⌨️

Quelle est la syntaxe permettant d'accéder au libellé d'un type de cuisine contenu dans la variable ?

??? question "Éléments de réponses ✅"
    ```php
    $lesTypesCuisine[$i]['libelleTC']
    ```
    Où `$i` est l'indice de l'élément dans le tableau.

## Question 3 — Le restaurant (`vueDetailResto.php`) 🏠

**Documents à utiliser :** fichiers du projet, annexes 1, 2, 3 et 4

### 3.1 — Origine de `$unResto` 🎯

Quel contrôleur produit la variable `$unResto` ? Préciser le nom de la fonction et du modèle.

??? question "Éléments de réponses ✅"
    C'est le contrôleur **`detailResto.php`** qui produit `$unResto` via :
    ```php
    $unResto = getRestoByIdR($idR);
    ```
    La fonction `getRestoByIdR()` est définie dans le modèle **`bd.resto.inc.php`**.

### 3.2 — Schéma de `$unResto` 🗺️

Schématiser le contenu de la variable `$unResto`.

```
$unResto → ['idR'    => ...,
             'nomR'   => ...,
             ...
            ]
```

??? question "Éléments de réponses ✅"
    Contrairement à `$lesPhotos` ou `$lesTypesCuisine`, `$unResto` est un **tableau associatif simple** (une seule dimension) :
    ```
    $unResto → [
        'idR'          => 1,
        'nomR'         => "l'entrepote",
        'numAdrR'      => 2,
        'voieAdrR'     => "rue Maurice Ravel",
        'cpR'          => "33000",
        'villeR'       => "Bordeaux",
        'latitudeDegR' => 44.7948,
        'longitudeDegR'=> -0.58754,
        'descR'        => "description",
        'horairesR'    => "<table>...</table>"
    ]
    ```

### 3.3 — Utilisation dans la vue 🔎

Quelles sections de code dans la vue utilisent la variable `$unResto` ?

Voici un extrait de `vueDetailResto.php` :

```php
<h1><?= $unResto['nomR']; ?></h1>

<p id="principal">
    <?php if (count($lesPhotos) > 0) { ?>
        <img src="photos/<?= $lesPhotos[0]["cheminP"] ?>" alt="photo du restaurant" />
    <?php } ?>
    <?= $unResto['descR']; ?>
</p>

<h2 id="adresse">Adresse</h2>
<p>
    <?= $unResto['numAdrR']; ?>
    <?= $unResto['voieAdrR']; ?><br />
    <?= $unResto['cpR']; ?>
    <?= $unResto['villeR']; ?>
</p>
```

??? question "Éléments de réponses ✅"
    La variable `$unResto` est utilisée dans plusieurs sections de la vue :

    - **Titre** : `$unResto['nomR']`
    - **Description** : `$unResto['descR']`
    - **Adresse** : `$unResto['numAdrR']`, `$unResto['voieAdrR']`, `$unResto['cpR']`, `$unResto['villeR']`
    - **Horaires** : `$unResto['horairesR']`

### 3.4 — Nombre de restaurants dans la variable 🔢

Combien de restaurants sont contenus dans la variable `$unResto` ?

??? question "Éléments de réponses ✅"
    **Un seul restaurant.** Contrairement aux autres variables (`$lesPhotos`, `$lesTypesCuisine`), `$unResto` est un tableau associatif à une dimension — il ne représente qu'une seule occurrence de la table `resto`.

### 3.5 — Accès au nom du restaurant ⌨️

Quelle est la syntaxe permettant d'accéder au nom d'un restaurant contenu dans `$unResto` ?

??? question "Éléments de réponses ✅"
    ```php
    $unResto['nomR']
    ```

## Synthèse — Rôle de la vue 📌

| Principe | Détail |
|----------|--------|
| La vue utilise les données du contrôleur | Variables préparées et transmises par le contrôleur |
| Pas de logique applicative dans la vue | Pas de traitement, uniquement de l'affichage |
| Pas d'accès direct à la BD | Les requêtes sont dans le modèle |
| Code PHP limité au minimum | `for`, `if`, `echo` pour l'affichage dynamique |

> 💡 Le choix de PHP dans la vue n'est qu'un exemple. Des moteurs de templates comme **Twig** (utilisé dans Laravel et Symfony) permettent d'écrire des vues encore plus propres.

## Partie B — Adaptation de vues ✏️

## Question 4 — Adaptation du menu général 🌐

**Documents à utiliser :** fichiers du projet, annexe 9

Lorsqu'un utilisateur est connecté, le lien **"Connexion"** du menu doit être remplacé par **"Mon Profil"**.

Le menu se trouve dans la vue `entete.html.php`.

### 4.1 — Fonction pour connaître l'état de connexion 🎯

Quelle fonction du modèle `authentification.inc.php` permet de connaître l'état de connexion du visiteur ?

??? question "Éléments de réponses ✅"
    Il s'agit de la fonction **`isLoggedOn()`**, déjà utilisée dans la partie contrôleur. Elle retourne `true` si un utilisateur est connecté, `false` sinon.

### 4.2 — Type de donnée retourné 🔎

Quel type de donnée est renvoyé par cette fonction ? Donner des exemples de valeurs.

??? question "Éléments de réponses ✅"
    La fonction `isLoggedOn()` retourne un **booléen** : `true` ou `false`.

### 4.3 — Élément affiché par défaut 🖼️

Quel élément de la liste du menu général est affiché lorsque l'utilisateur **n'est pas** connecté ?

??? question "Éléments de réponses ✅"
    Par défaut (utilisateur non connecté), le dernier élément du menu est affiché :
    ```php
    <li>
        <a href="./?action=connexion">
            <img src="images/profil.png" alt="loupe" />Connexion
        </a>
    </li>
    ```

### 4.4 — Adapter le menu ✏️

Modifier le code de `entete.html.php` pour afficher alternativement "Mon Profil" ou "Connexion" :

```php
<!-- Menu général - extrait de entete.html.php -->
<ul>
    <!-- ... autres items du menu ... -->

    <?php if (/* à compléter */) { ?>
        <li>
            <a href="./?action=profil">
                <img src="images/profil.png" alt="profil" />
                Mon Profil
            </a>
        </li>
    <?php } else { ?>
        <li>
            <a href="./?action=connexion">
                <img src="images/connexion.png" alt="connexion" />
                Connexion
            </a>
        </li>
    <?php } ?>
</ul>
```

??? question "Éléments de réponses ✅"
    ```php
    <?php if (isLoggedOn()) { ?>
        <li>
            <a href="./?action=profil">
                <img src="images/profil.png" alt="loupe" />Mon Profil
            </a>
        </li>
    <?php } else { ?>
        <li>
            <a href="./?action=connexion">
                <img src="images/profil.png" alt="loupe" />Connexion
            </a>
        </li>
    <?php } ?>
    ```

## Question 5 — Profil : types de cuisine préférés 🍽️

**Documents à utiliser :** fichiers du projet, annexes 10 et 12

Pour tester ce code, vous devez être **connecté** sur le site, puis accéder à la page "Mon Profil".

Le contrôleur `monProfil.php` crée la variable :

```php
$mesTypeCuisineAimes = getTypesCuisinePreferesByMailU($mailU);
```

### 5.1 — Structure de `$mesTypeCuisineAimes` 🗺️

Afficher la variable dans le contrôleur avec `print_r($mesTypeCuisineAimes)`, puis schématiser sa structure.

??? question "Éléments de réponses ✅"
    C'est un **tableau de tableaux associatifs**, identique à la structure de `$lesTypesCuisine` :
    ```
    $mesTypeCuisineAimes
    ├── [0] → ['idTC' => 2, 'libelleTC' => 'Sud-Ouest']
    ├── [1] → ['idTC' => 4, 'libelleTC' => 'Viande']
    └── [2] → ['idTC' => 7, 'libelleTC' => 'Grillade']
    ```

### 5.2 — Syntaxe d'accès au libellé ⌨️

Quelle syntaxe permet d'atteindre le libellé d'un type de cuisine dans `$mesTypeCuisineAimes` ?

??? question "Éléments de réponses ✅"
    ```php
    $mesTypeCuisineAimes[$i]['libelleTC']
    ```

### 5.3 et 5.4 — Code HTML dans la vue 🔎

Repérer dans `vueMonProfil.php` le code HTML permettant d'afficher les types de cuisine. Quelle partie de code est répétée ?

??? question "Éléments de réponses ✅"
    Le code HTML statique contient des éléments `<li>` répétés :
    ```html
    <ul id="tagFood">
        <li class="tag"><span class="tag">#</span>sud ouest</li>
        <li class="tag"><span class="tag">#</span>viande</li>
        <li class="tag"><span class="tag">#</span>grillade</li>
    </ul>
    ```
    C'est la balise `<li class="tag">` et son contenu qui est répétée pour chaque type de cuisine.

### 5.5 — Parcourir et afficher les types de cuisine ✏️

Écrire le code PHP permettant de parcourir `$mesTypeCuisineAimes` et d'afficher pour chaque type le libellé associé :

```php
<?php foreach ($mesTypeCuisineAimes as /* à compléter */) { ?>
    <?= /* afficher le libellé */ ?>
<?php } ?>
```

??? question "Éléments de réponses ✅"
    ```php
    <?php for ($i = 0; $i < count($mesTypeCuisineAimes); $i++) { ?>
        <?= $mesTypeCuisineAimes[$i]['libelleTC'] ?>
    <?php } ?>
    ```

### 5.6 — Intégration dans la vue ✏️

Modifier le code pour respecter les balises HTML trouvées en 5.3, et intégrer ce code dans `vueMonProfil.php`.

```php
<!-- Exemple de structure HTML attendue -->
<ul id="typesCuisineAimes">
    <li>Japonaise</li>
    <li>Française</li>
    <!-- ... -->
</ul>
```

??? question "Éléments de réponses ✅"
    ```php
    <ul id="tagFood">
        <?php for ($i = 0; $i < count($mesTypeCuisineAimes); $i++) { ?>
            <li class="tag">
                <span class="tag">#</span><?= $mesTypeCuisineAimes[$i]["libelleTC"] ?>
            </li>
        <?php } ?>
    </ul>
    ```

## Question 6 — Profil : restaurants aimés ⭐

**Documents à utiliser :** fichiers du projet, annexes 11 et 12

Le contrôleur `monProfil.php` crée la variable :

```php
$mesRestosAimes = getRestosAimesByMailU($mailU);
```

L'objectif : afficher la liste des restaurants aimés sous forme de **liens cliquables** vers la fiche de chaque restaurant.

Structure d'un lien attendu :

```html
<a href="./?action=detail&idR=4">Cidrerie du fronton</a>
```

### 6.1 — Accès aux données dans `$mesRestosAimes` 🔎

En procédant comme pour l'exercice précédent, expliquer comment accéder à :
- l'**identifiant** de chaque restaurant
- le **nom** de chaque restaurant

??? question "Éléments de réponses ✅"
    ```php
    // Accès à l'identifiant :
    $mesRestosAimes[$i]['idR']

    // Accès au nom :
    $mesRestosAimes[$i]['nomR']
    ```

### 6.2 — Parcourir et afficher les noms ✏️

Écrire le code PHP permettant de parcourir `$mesRestosAimes` et d'afficher le nom de chaque restaurant.

??? question "Éléments de réponses ✅"
    ```php
    <?php for ($i = 0; $i < count($mesRestosAimes); $i++) { ?>
        <?= $mesRestosAimes[$i]["nomR"] ?>
    <?php } ?>
    ```

### 6.3 — Adapter la vue : affichage dynamique ✏️

Modifier `vueMonProfil.php` pour remplacer l'affichage statique par un affichage dynamique. Chaque restaurant doit être un lien vers sa fiche :

```php
<ul id="restosAimes">
    <?php foreach ($mesRestosAimes as /* à compléter */) { ?>
        <li>
            <a href="./?action=detail&idR=<?= /* identifiant */ ?>">
                <?= /* nom */ ?>
            </a>
        </li>
    <?php } ?>
</ul>
```

??? question "Éléments de réponses ✅"
    ```php
    <?php for ($i = 0; $i < count($mesRestosAimes); $i++) { ?>
        <a href="./?action=detail&idR=<?= $mesRestosAimes[$i]["idR"] ?>">
            <?= $mesRestosAimes[$i]["nomR"] ?>
        </a><br />
    <?php } ?>
    ```

*[← Partie 2](./02_controleur.md) | [Partie 4 — Modèle →](./04_modele.md)*
