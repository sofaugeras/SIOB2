# 3. La vue 🖼️

La **vue** a pour rôle unique d'**afficher les données** à l'utilisateur. Elle utilise des variables créées ou récupérées par le contrôleur, sans effectuer de traitement.

> 💡 Une vue contient essentiellement du code **HTML qui intègre du PHP** (et non l'inverse). Cela permet d'éviter les multiples `echo` et les concaténations complexes.

[Download zip du projet Resto avant ce TP si besoin ⤵️](./data/vue.zip){ .md-button }

## 1. Analyse d'une vue existante `vueDetailResto.php` 🔍

*note :* la vue `vueDetailResto.php`est appelée par le contrôleur `detailResto.php`.

### 1.1 Les photos (`vueDetailResto.php`) 📷

**Documents à utiliser :** fichiers du projet, annexes 1, 2, 5 et 6

??? info "Annexe 1 - vueDetailResto.php 📄"

    ```php
    <h1><?= $unResto['nomR']; ?>
    </h1>

    <span id="note">
    </span>
    <section>
        Cuisine <br />
        <ul id="tagFood">		
            <?php for ($j = 0; $j < count($lesTypesCuisine); $j++) { ?>
                <li class="tag"><span class="tag">#</span>
            <?= $lesTypesCuisine[$j]["libelleTC"] ?></li>
            <?php } ?>
        </ul>

    </section>
    <p id="principal">
        <?php if (count($lesPhotos) > 0) { ?>
            <img src="photos/<?= $lesPhotos[0]["cheminP"] ?>" alt="photo du restaurant" />
        <?php } ?>
        <br />
        <?= $unResto['descR']; ?>
    </p>
    <h2 id="adresse">
        Adresse
    </h2>
    <p>
        <?= $unResto['numAdrR']; ?>
        <?= $unResto['voieAdrR']; ?><br />
        <?= $unResto['cpR']; ?>
        <?= $unResto['villeR']; ?>
    </p>

    <h2 id="photos">
        Photos
    </h2>
    <ul id="galerie">
        <?php for ($i = 0; $i < count($lesPhotos); $i++) { ?>
        <li>
        <img class="galerie" src="photos/<?= $lesPhotos[$i]["cheminP"] ?>" 			   alt="" />
        </li>
        <?php } ?>

    </ul>
    <h2 id="horaires">
        Horaires
    </h2>
    <?= $unResto['horairesR']; ?>

    <h2 id="crit">Critiques</h2>

    <ul id="critiques">
    </ul>
    ```

??? info "Annexe 2 - controleur detailResto.php 📄"

    ```php
    <?php

    if ($_SERVER["SCRIPT_FILENAME"] == __FILE__) {
        $racine = "..";
    }
    include_once "$racine/modele/bd.resto.inc.php";
    include_once "$racine/modele/bd.typecuisine.inc.php";
    include_once "$racine/modele/bd.photo.inc.php";

    // creation du menu burger
    $menuBurger = array();
    $menuBurger[] = Array("url"=>"#top","label"=>"Le restaurant");
    $menuBurger[] = Array("url"=>"#adresse","label"=>"Adresse");
    $menuBurger[] = Array("url"=>"#photos","label"=>"Photos");
    $menuBurger[] = Array("url"=>"#horaires","label"=>"Horaires");
    $menuBurger[] = Array("url"=>"#crit","label"=>"Critiques");

    // recuperation des donnees GET, POST, et SESSION
    $idR = $_GET["idR"];

    // appel des fonctions permettant de recuperer les donnees utiles a l'affichage
    $unResto = getRestoByIdR($idR);
    $lesTypesCuisine = getTypesCuisineByIdR($idR);
    $lesPhotos = getPhotosByIdR($idR);


    // traitement si necessaire des donnees recuperees
    ;

    // appel du script de vue qui permet de gerer l'affichage des donnees
    $titre = "detail d'un restaurant";
    include "$racine/vue/entete.html.php";
    include "$racine/vue/vueDetailResto.php";
    include "$racine/vue/pied.html.php";
    ?>
    ```

??? info "Annexe 5 - extrait du modele bd.photo.inc.php 📄"

    ```php
    <?php
    include_once "bd.inc.php";
    function getPhotosByIdR($idR) {
        $resultat = array();
        try {
            $cnx = connexionPDO();
            $req = $cnx->prepare("select * from photo where idR=:idR");
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

    if ($_SERVER["SCRIPT_FILENAME"] == __FILE__) {
        // prog principal de test
        header('Content-Type:text/plain');
    ...
        echo "\n getPhotosByIdR(4) : \n";
        print_r(getPhotosByIdR(4));
    ...
    }
    ?>
    ```

??? info "Annexe 6 - extrait du résultat d'exécution de bd.photo.inc.php 📄"

    ```php
    getPhotosByIdR(4) :
    Array
    (
        [0] => Array
            (
                [idP] => 6
                [cheminP] => cidrerieDuFronton.jpg
                [idR] => 4
            )

        [1] => Array
            (
                [idP] => 14
                [cheminP] => cidrerieDuFronton2.jpg
                [idR] => 4
            )

        [2] => Array
            (
                [idP] => 15
                [cheminP] => cidrerieDuFronton3.jpg
                [idR] => 4
            )
    )
    ```

❓ **Quelles fonctions définies dans le modèle sont utilisées dans le contrôleur** `detailResto.php` ? ⚙️

??? question "Éléments de réponses ✅"
    Trois fonctions du modèle sont utilisées dans `detailResto.php` :

    - `getRestoByIdR($idR)` — récupère les informations du restaurant
    - `getTypesCuisineByIdR($idR)` — récupère les types de cuisine associés
    - `getPhotosByIdR($idR)` — récupère les photos du restaurant

❓ **Quelles annexes présentent le résultat d'exécution des fonctions trouvées à la question précédente ?** 📄

??? question "Éléments de réponses ✅"
    On trouve les résultats d'exécution dans les **annexes 4, 6 et 8**, respectivement pour `getRestoByIdR()`, `getPhotosByIdR()` et `getTypesCuisineByIdR()`.

❓ **Comment est composée chacune des cellules du tableau** `$lesPhotos` ? 🔎

??? question "Éléments de réponses ✅"
    Chaque cellule du tableau `$lesPhotos` est un **tableau associatif** contenant les informations d'une photo : `idP` (identifiant), `cheminP` (nom du fichier) et `idR` (identifiant du restaurant associé).

??? tip "Rappel : tableaux associatifs PHP"

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

    ```php
    $lesPhotos
    ├── [0] → ['idP' => 1, 'cheminP' => 'entrepote.jpg', 'idR' => 1]
    ├── [1] → ['idP' => 2, 'cheminP' => 'entrepote2.jpg', 'idR' => 1]
    └── [2] → ['idP' => 3, 'cheminP' => 'entrepote3.jpg', 'idR' => 1]
    ```

❓ **Quelle est l'instruction permettant d'accéder au chemin de la **première** photo ?** 🔎

Repérer dans le code de `vueDetailResto.php` l'instruction PHP permettant d'afficher le chemin de la première photo.

```php
// Extrait de vueDetailResto.php
<?php if (count($lesPhotos) > 0) { ?>
    <img src="photos/<?= $lesPhotos[0]["cheminP"] ?>" alt="photo du restaurant" />
<?php } ?>
```

??? question "Éléments de réponses ✅"
    ```php
    <?= $lesPhotos[0]["cheminP"] ?>
    ```
    L'indice `0` désigne la première photo du tableau, et la clé `"cheminP"` donne accès au nom du fichier image.

❓ **Quel est le rôle de la condition `if(count($lesPhotos) > 0)` dans le code de la vue ?** 🤔

??? question "Éléments de réponses ✅"
    Cette condition **vérifie que le tableau contient au moins une photo** avant d'essayer de l'afficher. Si aucune photo n'a été associée au restaurant, le tableau serait vide et accéder à `$lesPhotos[0]` provoquerait une erreur.

🔨 **Quelle est la syntaxe générale permettant d'accéder à un champ (`idP`, `cheminP` ou `idR`) contenu dans la variable `$lesPhotos` ?** ⌨️

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

### 1.2 Les types de cuisine (`vueDetailResto.php`) 🍽️

**Documents à utiliser :** fichiers du projet, annexes 1, 2, 7 et 8

??? info "Annexe 1 - vueDetailResto.php 📄"

    ```php
    <h1><?= $unResto['nomR']; ?>
    </h1>

    <span id="note">
    </span>
    <section>
        Cuisine <br />
        <ul id="tagFood">		
            <?php for ($j = 0; $j < count($lesTypesCuisine); $j++) { ?>
                <li class="tag"><span class="tag">#</span>
            <?= $lesTypesCuisine[$j]["libelleTC"] ?></li>
            <?php } ?>
        </ul>

    </section>
    <p id="principal">
        <?php if (count($lesPhotos) > 0) { ?>
            <img src="photos/<?= $lesPhotos[0]["cheminP"] ?>" alt="photo du restaurant" />
        <?php } ?>
        <br />
        <?= $unResto['descR']; ?>
    </p>
    <h2 id="adresse">
        Adresse
    </h2>
    <p>
        <?= $unResto['numAdrR']; ?>
        <?= $unResto['voieAdrR']; ?><br />
        <?= $unResto['cpR']; ?>
        <?= $unResto['villeR']; ?>
    </p>

    <h2 id="photos">
        Photos
    </h2>
    <ul id="galerie">
        <?php for ($i = 0; $i < count($lesPhotos); $i++) { ?>
        <li>
        <img class="galerie" src="photos/<?= $lesPhotos[$i]["cheminP"] ?>" 			   alt="" />
        </li>
        <?php } ?>

    </ul>
    <h2 id="horaires">
        Horaires
    </h2>
    <?= $unResto['horairesR']; ?>

    <h2 id="crit">Critiques</h2>

    <ul id="critiques">
    </ul>
    ```

??? info "Annexe 2 - controleur detailResto.php 📄"

    ```php
    <?php

    if ($_SERVER["SCRIPT_FILENAME"] == __FILE__) {
        $racine = "..";
    }
    include_once "$racine/modele/bd.resto.inc.php";
    include_once "$racine/modele/bd.typecuisine.inc.php";
    include_once "$racine/modele/bd.photo.inc.php";

    // creation du menu burger
    $menuBurger = array();
    $menuBurger[] = Array("url"=>"#top","label"=>"Le restaurant");
    $menuBurger[] = Array("url"=>"#adresse","label"=>"Adresse");
    $menuBurger[] = Array("url"=>"#photos","label"=>"Photos");
    $menuBurger[] = Array("url"=>"#horaires","label"=>"Horaires");
    $menuBurger[] = Array("url"=>"#crit","label"=>"Critiques");

    // recuperation des donnees GET, POST, et SESSION
    $idR = $_GET["idR"];

    // appel des fonctions permettant de recuperer les donnees utiles a l'affichage
    $unResto = getRestoByIdR($idR);
    $lesTypesCuisine = getTypesCuisineByIdR($idR);
    $lesPhotos = getPhotosByIdR($idR);


    // traitement si necessaire des donnees recuperees
    ;

    // appel du script de vue qui permet de gerer l'affichage des donnees
    $titre = "detail d'un restaurant";
    include "$racine/vue/entete.html.php";
    include "$racine/vue/vueDetailResto.php";
    include "$racine/vue/pied.html.php";
    ?>
    ```
??? info "Annexe 7 - extrait du modele bd.typecuisine.inc.php 📄"

    ```php
    <?php
    include_once "bd.inc.php";
    function getTypesCuisineByIdR($idR){
        $resultat = array();
        try {
            $cnx = connexionPDO();
            $req = $cnx->prepare("select typeCuisine.* from typeCuisine,proposer where typeCuisine.idTC = proposer.idTC and proposer.idR = :idR");
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

    if ($_SERVER["SCRIPT_FILENAME"] == __FILE__) {
        // prog principal de test
        header('Content-Type:text/plain');
    ...
        echo "getTypesCuisineByIdR(idR) : \n";
        print_r(getTypesCuisineByIdR(4));
    ...
    }
    ?>
    ```

??? info "Annexe 8 - extrait du résultat d'exécution de bd.typecuisine.inc.php 📄"

    ```php
    getTypesCuisineByIdR(idR) :
    Array
    (
        [0] => Array
            (
                [idTC] => 1
                [libelleTC] => sud ouest
            )

        [1] => Array
            (
                [idTC] => 8
                [libelleTC] => sandwich
            )

        [2] => Array
            (
                [idTC] => 11
                [libelleTC] => grillade
            )
    )
    ```

❓ **Quel contrôleur produit la variable** `$lesTypesCuisine` ? 🎯 Préciser le nom de la fonction et du modèle utilisés.

??? question "Éléments de réponses ✅"
    C'est le contrôleur **`detailResto.php`** qui produit `$lesTypesCuisine` via l'appel :
    ```php
    $lesTypesCuisine = getTypesCuisineByIdR($idR);
    ```
    La fonction `getTypesCuisineByIdR()` est définie dans le modèle `bd.typeCuisine.inc.php`.

❓ **Schématiser le contenu de la variable** `$lesTypesCuisine` (sur le modèle du schéma de `$lesPhotos`). 🗺️

```text
$lesTypesCuisine
├── [0] → [...]
├── [1] → [...]
└── [...]
```

??? question "Éléments de réponses ✅"
    Comme `$lesPhotos`, il s'agit d'un **tableau de tableaux associatifs** :

    ```text
    $lesTypesCuisine
    ├── [0] → ['idTC' => 1, 'libelleTC' => 'Sud-Ouest']
    ├── [1] → ['idTC' => 3, 'libelleTC' => 'Viande']
    └── [2] → ['idTC' => 5, 'libelleTC' => 'Grillade']
    ```

❓ **Combien de types de cuisine sont contenus dans cette variable pour le restaurant consulté ?** 🔢

??? question "Éléments de réponses ✅"
    Il y a **3 types de cuisine** pour le restaurant de l'exemple (l'entrepote).

❓ **Quelle est la syntaxe permettant d'accéder au libellé d'un type de cuisine contenu dans la variable ?** ⌨️

??? question "Éléments de réponses ✅"
    ```php
    $lesTypesCuisine[$i]['libelleTC']
    ```
    Où `$i` est l'indice de l'élément dans le tableau.

### 1.3 Le restaurant (`vueDetailResto.php`) 🏠

**Documents à utiliser :** fichiers du projet, annexes 1, 2, 3 et 4

??? info "Annexe 1 - vueDetailResto.php 📄"

    ```php
    <h1><?= $unResto['nomR']; ?>
    </h1>

    <span id="note">
    </span>
    <section>
        Cuisine <br />
        <ul id="tagFood">		
            <?php for ($j = 0; $j < count($lesTypesCuisine); $j++) { ?>
                <li class="tag"><span class="tag">#</span>
            <?= $lesTypesCuisine[$j]["libelleTC"] ?></li>
            <?php } ?>
        </ul>

    </section>
    <p id="principal">
        <?php if (count($lesPhotos) > 0) { ?>
            <img src="photos/<?= $lesPhotos[0]["cheminP"] ?>" alt="photo du restaurant" />
        <?php } ?>
        <br />
        <?= $unResto['descR']; ?>
    </p>
    <h2 id="adresse">
        Adresse
    </h2>
    <p>
        <?= $unResto['numAdrR']; ?>
        <?= $unResto['voieAdrR']; ?><br />
        <?= $unResto['cpR']; ?>
        <?= $unResto['villeR']; ?>
    </p>

    <h2 id="photos">
        Photos
    </h2>
    <ul id="galerie">
        <?php for ($i = 0; $i < count($lesPhotos); $i++) { ?>
        <li>
        <img class="galerie" src="photos/<?= $lesPhotos[$i]["cheminP"] ?>" 			   alt="" />
        </li>
        <?php } ?>

    </ul>
    <h2 id="horaires">
        Horaires
    </h2>
    <?= $unResto['horairesR']; ?>

    <h2 id="crit">Critiques</h2>

    <ul id="critiques">
    </ul>
    ```

??? info "Annexe 2 - controleur detailResto.php 📄"

    ```php
    <?php

    if ($_SERVER["SCRIPT_FILENAME"] == __FILE__) {
        $racine = "..";
    }
    include_once "$racine/modele/bd.resto.inc.php";
    include_once "$racine/modele/bd.typecuisine.inc.php";
    include_once "$racine/modele/bd.photo.inc.php";

    // creation du menu burger
    $menuBurger = array();
    $menuBurger[] = Array("url"=>"#top","label"=>"Le restaurant");
    $menuBurger[] = Array("url"=>"#adresse","label"=>"Adresse");
    $menuBurger[] = Array("url"=>"#photos","label"=>"Photos");
    $menuBurger[] = Array("url"=>"#horaires","label"=>"Horaires");
    $menuBurger[] = Array("url"=>"#crit","label"=>"Critiques");

    // recuperation des donnees GET, POST, et SESSION
    $idR = $_GET["idR"];

    // appel des fonctions permettant de recuperer les donnees utiles a l'affichage
    $unResto = getRestoByIdR($idR);
    $lesTypesCuisine = getTypesCuisineByIdR($idR);
    $lesPhotos = getPhotosByIdR($idR);


    // traitement si necessaire des donnees recuperees
    ;

    // appel du script de vue qui permet de gerer l'affichage des donnees
    $titre = "detail d'un restaurant";
    include "$racine/vue/entete.html.php";
    include "$racine/vue/vueDetailResto.php";
    include "$racine/vue/pied.html.php";
    ?>
    ```
??? info "Annexe 3 - extrait du modele bd.resto.inc.php 📄"

    ```php
    <?php
    include_once "bd.inc.php";

    function getRestoByIdR($idR) {
        try {
            $cnx = connexionPDO();
            $req = $cnx->prepare("select * from resto where idR=:idR");
            $req->bindValue(':idR', $idR, PDO::PARAM_INT);

            $req->execute();

            $resultat = $req->fetch(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            print "Erreur !: " . $e->getMessage();
            die();
        }
        return $resultat;
    }

    ...

    if ($_SERVER["SCRIPT_FILENAME"] == __FILE__) {
        // prog principal de test
        header('Content-Type:text/plain');
    ...
    
        echo "getRestoByIdR(idR) : \n";
        print_r(getRestoByIdR(1));

    ...
    }
    ?>
    ```

??? info "Annexe 4 - extrait du résultat d'exécution de bd.resto.inc.php 📄"

    ```php
    getRestoByIdR(idR) :
    Array
    (
        [idR] => 1
        [nomR] => l'entrepote
        [numAdrR] => 2
        [voieAdrR] => rue Maurice Ravel
        [cpR] => 33000
        [villeR] => Bordeaux
        [latitudeDegR] => 44.7948
        [longitudeDegR] => -0.58754
        [descR] => description
        [horairesR] => <table>...</table>
    )
    ```

❓ **Quel contrôleur produit la variable** `$unResto` ? 🎯 Préciser le nom de la fonction et du modèle.

??? question "Éléments de réponses ✅"
    C'est le contrôleur **`detailResto.php`** qui produit `$unResto` via :
    ```php
    $unResto = getRestoByIdR($idR);
    ```
    La fonction `getRestoByIdR()` est définie dans le modèle **`bd.resto.inc.php`**.

❓ **Schématiser le contenu de la variable** `$unResto`.🗺️

```
$unResto → ['idR'    => ...,
             'nomR'   => ...,
             ...
            ]
```

??? question "Éléments de réponses ✅"
    Contrairement à `$lesPhotos` ou `$lesTypesCuisine`, `$unResto` est un **tableau associatif simple** (une seule dimension) :

    ```php
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

❓ **Quelles sections de code dans la vue utilisent la variable** `$unResto` ? 🔎

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

❓ **Combien de restaurants sont contenus dans la variable** `$unResto` ? 🔢

??? question "Éléments de réponses ✅"
    **Un seul restaurant.** Contrairement aux autres variables (`$lesPhotos`, `$lesTypesCuisine`), `$unResto` est un tableau associatif à une dimension — il ne représente qu'une seule occurrence de la table `resto`.

❓ **Quelle est la syntaxe permettant d'accéder au nom d'un restaurant contenu dans** `$unResto` ? ⌨️

??? question "Éléments de réponses ✅"
    ```php
    $unResto['nomR']
    ```

### 1.4 Synthèse — Rôle de la vue 📌

| Principe | Détail |
|----------|--------|
| La vue utilise les données du contrôleur | Variables préparées et transmises par le contrôleur |
| Pas de logique applicative dans la vue | Pas de traitement, uniquement de l'affichage |
| Pas d'accès direct à la BD | Les requêtes sont dans le modèle |
| Code PHP limité au minimum | `for`, `if`, `echo` pour l'affichage dynamique |

> 💡 Le choix de PHP dans la vue n'est qu'un exemple. Des moteurs de templates comme **Twig** ou **blade** (utilisé dans Laravel et Symfony) permettent d'écrire des vues encore plus propres (en SIO2).

## 2. Adaptation de vues ✏️

### 2.1 Adaptation du menu général 🌐

**Documents à utiliser :** fichiers du projet, annexe 9

??? info "Annexe 9 - extrait de la vue entete.html.php - menu général 📄"

    ```html
    <ul id="menuGeneral">
    <li><a href="./?action=accueil">Accueil</a></li>
    <li><a href="./?action=recherche"><img src="images/rechercher.png" alt="loupe" />Recherche</a></li>
    <li></li>
    <li id="logo"><a href="./?action=accueil"><img src="images/logoBarre.png" alt="logo" /></a></li>
    <li></li>
    <li><a href="./?action=cgu">CGU</a></li>
    <li><a href="./?action=connexion"><img src="images/profil.png" alt="loupe" />Connexion</a></li>
    </ul>
    ```

Lorsqu'un utilisateur est connecté, le lien **"Connexion"** du menu doit être remplacé par **"Mon Profil"**.

Le menu se trouve dans la vue `entete.html.php`.

❓ **Quelle fonction du modèle `authentification.inc.php` permet de connaître l'état de connexion du visiteur ?** 🎯

??? question "Éléments de réponses ✅"
    Il s'agit de la fonction **`isLoggedOn()`**, déjà utilisée dans la partie contrôleur. Elle retourne `true` si un utilisateur est connecté, `false` sinon.

❓ **Quel type de donnée est renvoyé par cette fonction ?** Donner des exemples de valeurs. 🔎

??? question "Éléments de réponses ✅"
    La fonction `isLoggedOn()` retourne un **booléen** : `true` ou `false`.

❓ **Quel élément de la liste du menu général est affiché lorsque l'utilisateur *n'est pas* connecté ?** 🖼️

??? question "Éléments de réponses ✅"
    Par défaut (utilisateur non connecté), le dernier élément du menu est affiché :
    ```php
    <li>
        <a href="./?action=connexion">
            <img src="images/profil.png" alt="loupe" />Connexion
        </a>
    </li>
    ```

🔨 **Adapter le menu** ✏️

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

### 2.2 Profil : types de cuisine préférés 🍽️

**Documents à utiliser :** fichiers du projet, annexes 10 et 12

??? info "Annexe 10 - extrait code code généré affichant les types de cuisine préférés par l'utilisateur 📋"

    ```php
    <ul id="tagFood">		
        <li class="tag"><span class="tag">#</span>sud ouest</li>
        <li class="tag"><span class="tag">#</span>viande</li>
        <li class="tag"><span class="tag">#</span>grillade</li>
    </ul>
    ```

??? info "Annexe 11 - extrait code code généré affichant les restaurants aimés par l'utilisateur 📋"

    ```html
    les restaurants que j'aime : <br />
        <a href="./?action=detail&idR=4">Cidrerie du fronton</a><br />
        <a href="./?action=detail&idR=6">Le Bistrot Sainte Cluque</a><br />
        <a href="./?action=detail
    ```

⚠️ Pour tester ce code, vous devez être **connecté** sur le site, puis accéder à la page "Mon Profil".

Le contrôleur `monProfil.php` crée la variable :

```php
$mesTypeCuisineAimes = getTypesCuisinePreferesByMailU($mailU);
```

❓ **Afficher la variable dans le contrôleur avec** `print_r($mesTypeCuisineAimes)`**, puis schématiser sa structure.** 🗺️

??? question "Éléments de réponses ✅"
    C'est un **tableau de tableaux associatifs**, identique à la structure de `$lesTypesCuisine` :
    ```
    $mesTypeCuisineAimes
    ├── [0] → ['idTC' => 2, 'libelleTC' => 'Sud-Ouest']
    ├── [1] → ['idTC' => 4, 'libelleTC' => 'Viande']
    └── [2] → ['idTC' => 7, 'libelleTC' => 'Grillade']
    ```

❓ **Quelle syntaxe permet d'atteindre le libellé d'un type de cuisine dans** `$mesTypeCuisineAimes` ? ⌨️

??? question "Éléments de réponses ✅"
    ```php
    $mesTypeCuisineAimes[$i]['libelleTC']
    ```

❓ Repérer dans `vueMonProfil.php` le code HTML permettant d'afficher les types de cuisine.  **Quelle partie de code est répétée ?**

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

🔨 **Écrire le code PHP permettant de parcourir `$mesTypeCuisineAimes` et d'afficher pour chaque type le libellé associé :**

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

🔨 **Modifier le code pour respecter les balises HTML trouvées en 5.3, et intégrer ce code dans** `vueMonProfil.php`.

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

### 2.3 Profil : restaurants aimés ⭐

**Documents à utiliser :** fichiers du projet, annexes 11 et 12

??? info "Annexe 11 - extrait code code généré affichant les restaurants aimés par l'utilisateur 📄"

    ```html
    les restaurants que j'aime : <br />
    <a href="./?action=detail&idR=4">Cidrerie du fronton</a><br />
    <a href="./?action=detail&idR=6">Le Bistrot Sainte Cluque</a><br />
    <a href="./?action=detail&idR=8">La table de POTTOKA</a><br />
    ```

??? info "Annexe 12 - vue à modifier : vueMonProfil.php 📄"

    ```html
    <h1>Mon profil</h1>

    Mon adresse électronique : <?= $util["mailU"] ?> <br />
    Mon pseudo : <?= $util["pseudoU"] ?> <br />

    <hr>

    les restaurants que j'aime : <br>
        <a href="./?action=detail&idR=4">Cidrerie du fronton</a><br>
        <a href="./?action=detail&idR=6">Le Bistrot Sainte Cluque</a><br>
        <a href="./?action=detail&idR=8">La table de POTTOKA</a><br>
    <hr>
    les types de cuisine que j'aime :
    <ul id="tagFood">		
        <li class="tag"><span class="tag">#</span>sud ouest</li>
        <li class="tag"><span class="tag">#</span>viande</li>
        <li class="tag"><span class="tag">#</span>grillade</li>
    </ul>
    <hr>
    <a href="./?action=deconnexion">se deconnecter</a>
    ```

Le contrôleur `monProfil.php` crée la variable :

```php
$mesRestosAimes = getRestosAimesByMailU($mailU);
```

L'objectif : afficher la liste des restaurants aimés sous forme de **liens cliquables** vers la fiche de chaque restaurant.

**Structure d'un lien attendu :**

```html
<a href="./?action=detail&idR=4">Cidrerie du fronton</a>
```

❓ **Accès aux données dans** `$mesRestosAimes` 🔎

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

🔨 **Écrire le code PHP permettant de parcourir `$mesRestosAimes` et d'afficher le nom de chaque restaurant.**

??? question "Éléments de réponses ✅"
    ```php
    <?php for ($i = 0; $i < count($mesRestosAimes); $i++) { ?>
        <?= $mesRestosAimes[$i]["nomR"] ?>
    <?php } ?>
    ```

🔨 **Adapter la vue : affichage dynamique** ✏️

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

*[Partie 4 — Modèle →](./04_modele.md)*
