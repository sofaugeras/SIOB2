# 💻 Application POO en PHP

!!! note "note"
    création à l'aide de ChatGPT5

## 🏦 Exercice 1 – Classe `CompteBancaire`

#### 🎯 Objectifs 

* Définir une **classe simple** en PHP
* Manipuler les notions : **attributs privés**, **constructeur**, **getters** et **méthodes métier simples**
* Introduire la **notion d’encapsulation**

#### 📋 Énoncé

On souhaite modéliser un **compte bancaire** en PHP.

1. Créer une classe `CompteBancaire` avec les attributs suivants (tous **privés**) :

   * `titulaire : string` → nom du titulaire du compte
   * `solde : float` → solde du compte

2. Le **constructeur** initialise le titulaire et le solde initial (qui ne peut pas être négatif).

3. Ajouter les méthodes suivantes :

   * `getSolde()` : retourne le solde actuel
   * `deposer(float $montant)` : ajoute de l’argent au solde (uniquement si le montant est positif)
   * `retirer(float $montant)` : retire de l’argent (uniquement si le montant est positif et ≤ solde actuel)
   * `afficher()` : affiche le titulaire et le solde du compte

✅ Attendus

* Encapsulation respectée (`private`)
* Contrôle des valeurs (pas de solde négatif, pas de dépôt/retrait impossible)
* Affichage clair du titulaire et du solde

#### 💻 Squelette de code à compléter

```php
<?php
declare(strict_types=1);

class CompteBancaire {
    // 1. Définir les attributs privés

    // 2. Constructeur

    // 3. getSolde()

    // 4. deposer()

    // 5. retirer()

    // 6. afficher()
}

// --- Tests ---
$c1 = new CompteBancaire("Alice", 200);
$c1->deposer(50);
$c1->retirer(100);
$c1->afficher(); // Devrait afficher : Alice - Solde : 150 €
```

??? tip "Correction"

    ```php
    <?php
    declare(strict_types=1);

    class CompteBancaire {
        // 🔒 Attributs privés
        private string $titulaire;
        private float $solde;

        // ⚙️ Constructeur
        public function __construct(string $titulaire, float $soldeInitial = 0) {
            $this->titulaire = $titulaire;
            // On s'assure que le solde n'est pas négatif
            $this->solde = max(0, $soldeInitial);
        }

        // 👀 Getter
        public function getSolde(): float {
            return $this->solde;
        }

        // 💰 Dépôt
        public function deposer(float $montant): void {
            if ($montant > 0) {
                $this->solde += $montant;
            }
        }

        // 💸 Retrait
        public function retirer(float $montant): void {
            if ($montant > 0 && $montant <= $this->solde) {
                $this->solde -= $montant;
            } else {
                echo "Retrait impossible !\n";
            }
        }

        // 📢 Affichage
        public function afficher(): void {
            echo "{$this->titulaire} - Solde : {$this->solde} €\n";
        }
    }

    // --- 🔎 Tests ---
    $c1 = new CompteBancaire("Alice", 200);
    $c1->deposer(50);     // solde = 250
    $c1->retirer(100);    // solde = 150
    $c1->afficher();      // Alice - Solde : 150 €

    ```

    📝 Commentaires :

    - Les attributs sont privés → on applique l’encapsulation.
    - Le constructeur contrôle que le solde initial n’est pas négatif.
    - Les méthodes métier (deposer, retirer) contiennent des règles de validation.
    - afficher() sert de méthode utilitaire simple.

---

## 🧬 Exercice 2 – Héritage : `CompteEpargne` & `CompteCourant`

#### 🎯 Objectifs 

* Mettre en œuvre **l’héritage** à partir de `CompteBancaire`
* Utiliser les **visibilités** (`private`, `protected`) intelligemment
* Pratiquer la **redéfinition** (override) de méthodes
* Approcher un début de **polymorphisme** (même interface d’usage)

#### 📋 Énoncé

À partir de la classe `CompteBancaire` (Exercice 1), créer deux classes filles :

1. **`CompteEpargne`**

* Attribut privé : `tauxInteret: float` (ex : `0.03` pour 3%)
* Méthode : `appliquerInteret()` → augmente le solde de `solde * tauxInteret`
* Redéfinir `afficher()` pour indiquer le taux

2. **`CompteCourant`**

* Attributs privés :

  * `decouvertAutorise: float` (ex : 200.0)
  * `fraisDecouvert: float` (ex : 8.0)
* Redéfinir `retirer(float $montant)` :

  * autoriser un solde **jusqu’à `-decouvertAutorise`**
  * si le solde passe **strictement négatif** après le retrait, **appliquer** `fraisDecouvert` immédiatement
* Redéfinir `afficher()` pour indiquer découvert et éventuel solde négatif

**Contraintes générales**

* Conserver l’**encapsulation** : les nouveaux attributs restent **privés**
* Utiliser `parent::__construct(...)` dans les constructeurs des classes filles
* Lever une `InvalidArgumentException` si :

  * `tauxInteret < 0`
  * `decouvertAutorise < 0` ou `fraisDecouvert < 0`
* PHP ≥ 8.0, **propriétés typées**, `declare(strict_types=1);`

??? question "💻 Squelette de code à compléter"

    ```php
    <?php
    declare(strict_types=1);

    class CompteBancaire {
        // Reprends la version validée de l’Exercice 1
        protected string $titulaire;
        protected float $solde;

        public function __construct(string $titulaire, float $soldeInitial = 0) {
            $this->titulaire = $titulaire;
            $this->solde = max(0, $soldeInitial);
        }

        public function getSolde(): float { return $this->solde; }

        public function deposer(float $montant): void {
            if ($montant > 0) $this->solde += $montant;
        }

        public function retirer(float $montant): void {
            if ($montant > 0 && $montant <= $this->solde) {
                $this->solde -= $montant;
            } else {
                echo "Retrait impossible !\n";
            }
        }

        public function afficher(): void {
            echo "{$this->titulaire} - Solde : {$this->solde} €\n";
        }
    }

    // --- À compléter ---

    class CompteEpargne extends CompteBancaire {
        // TODO: attribut privé $tauxInteret

        public function __construct(string $titulaire, float $soldeInitial, float $tauxInteret) {
            // TODO: valider $tauxInteret >= 0
            parent::__construct($titulaire, $soldeInitial);
            // TODO: affecter $tauxInteret
        }

        public function appliquerInteret(): void {
            // TODO: augmenter $this->solde de $this->solde * $this->tauxInteret
        }

        public function afficher(): void {
            // TODO: afficher avec indication du taux
        }
    }

    class CompteCourant extends CompteBancaire {
        // TODO: attributs privés $decouvertAutorise, $fraisDecouvert

        public function __construct(
            string $titulaire,
            float $soldeInitial,
            float $decouvertAutorise = 0,
            float $fraisDecouvert = 0
        ) {
            // TODO: valider >= 0
            parent::__construct($titulaire, $soldeInitial);
            // TODO: affecter les attributs
        }

        public function retirer(float $montant): void {
            // TODO:
            // - autoriser dépassement jusque -$decouvertAutorise
            // - si solde devient < 0 après retrait, appliquer fraisDecouvert (et
            //   vérifier qu'on reste >= -$decouvertAutorise après frais)
        }

        public function afficher(): void {
            // TODO: afficher avec découvert autorisé et frais
        }
    }
    ```

    ---

#### 🔎 Scénarios de test (scripts rapides)

```php
// 1) Épargne
$e = new CompteEpargne("Alice", 1000, 0.05);
$e->appliquerInteret();           // solde attendu: 1050
$e->afficher();                   // doit indiquer le taux

// 2) Courant sans découvert
$c1 = new CompteCourant("Bob", 200, 0, 0);
$c1->retirer(250);                // devrait refuser (pas de découvert)
$c1->afficher();

// 3) Courant avec découvert autorisé
$c2 = new CompteCourant("Chloe", 100, 200, 8);
$c2->retirer(250);                // passe à -150 => appliquer 8€ de frais => -158
$c2->afficher();                  // solde attendu: -158

// 4) Dépassement du découvert autorisé
$c2->retirer(60);                 // -158 - 60 = -218 -> refuser si dépasse -200 (ou tenir compte de nouveaux frais)
$c2->afficher();

// 5) Cas invalides (doivent lever exception)
try { new CompteEpargne("Dan", 500, -0.01); } catch (InvalidArgumentException $e) { echo "OK\n"; }
try { new CompteCourant("Eve", 500, -100, 5); } catch (InvalidArgumentException $e) { echo "OK\n"; }
try { new CompteCourant("Fay", 500, 100, -2); } catch (InvalidArgumentException $e) { echo "OK\n"; }
```


#### 🧠 Points d’attention / erreurs fréquentes : Conseils

* Oublier d’appeler `parent::__construct(...)` dans les classes filles
* Laisser passer des valeurs négatives pour `tauxInteret`, `decouvertAutorise`, `fraisDecouvert`
* Ne pas gérer le cas où l’application des **frais** ferait **dépasser** le découvert autorisé
* Redéfinir `retirer()` mais ne pas respecter la **signature** (retour `void` attendu)

#### ⭐ Pour aller plus loin 

* Ajouter `getTauxInteret()`, `setTauxInteret()` avec validation
* Ajouter dans `CompteCourant` une méthode `estADecouvert(): bool`
* Ajouter une méthode **commune** `resume()` (même nom dans les deux classes) → tester un **tableau polymorphe** de comptes et appeler `resume()` en boucle

??? tip "Correction"

    ```php
    <?php
    declare(strict_types=1);

    /**
    * Base : CompteBancaire (version adaptée pour l'héritage)
    */
    class CompteBancaire {
        // Protégés pour un accès direct (contrôlé) dans les classes filles
        protected string $titulaire;
        protected float $solde;

        public function __construct(string $titulaire, float $soldeInitial = 0) {
            $this->titulaire = $titulaire;
            $this->solde = max(0, $soldeInitial); // pas de solde initial négatif
        }

        public function getSolde(): float { return $this->solde; }

        public function deposer(float $montant): void {
            if ($montant > 0) {
                $this->solde += $montant;
            }
        }

        public function retirer(float $montant): void {
            if ($montant > 0 && $montant <= $this->solde) {
                $this->solde -= $montant;
            } else {
                echo "Retrait impossible !\n";
            }
        }

        public function afficher(): void {
            echo "{$this->titulaire} - Solde : {$this->solde} €\n";
        }
    }

    /**
    * CompteEpargne : ajoute un taux d'intérêt et appliqueInteret()
    */
    class CompteEpargne extends CompteBancaire {
        private float $tauxInteret; // ex: 0.05 pour 5%

        public function __construct(string $titulaire, float $soldeInitial, float $tauxInteret) {
            if ($tauxInteret < 0) {
                throw new InvalidArgumentException("Le taux d'intérêt doit être >= 0");
            }
            parent::__construct($titulaire, $soldeInitial);
            $this->tauxInteret = $tauxInteret;
        }

        public function appliquerInteret(): void {
            $this->solde += $this->solde * $this->tauxInteret;
        }

        public function afficher(): void {
            $pct = $this->tauxInteret * 100;
            echo "{$this->titulaire} - Solde (épargne) : {$this->solde} € — Taux : {$pct}%\n";
        }
    }

    /**
    * CompteCourant : découvert autorisé + frais si solde devient négatif
    */
    class CompteCourant extends CompteBancaire {
        private float $decouvertAutorise; // ex: 200.0
        private float $fraisDecouvert;    // ex: 8.0

        public function __construct(
            string $titulaire,
            float $soldeInitial,
            float $decouvertAutorise = 0,
            float $fraisDecouvert = 0
        ) {
            if ($decouvertAutorise < 0) {
                throw new InvalidArgumentException("Le découvert autorisé doit être >= 0");
            }
            if ($fraisDecouvert < 0) {
                throw new InvalidArgumentException("Les frais de découvert doivent être >= 0");
            }
            parent::__construct($titulaire, $soldeInitial);
            $this->decouvertAutorise = $decouvertAutorise;
            $this->fraisDecouvert = $fraisDecouvert;
        }

        /**
        * Retrait :
        * - autorisé si le solde après retrait ET frais éventuels reste >= -decouvertAutorise
        * - si le solde devient négatif suite au retrait, on applique immédiatement les frais
        * - sinon, on refuse l'opération (aucune modification)
        */
        public function retirer(float $montant): void {
            if ($montant <= 0) {
                echo "Retrait impossible !\n";
                return;
            }

            // Simulation pour vérifier les limites AVANT d'appliquer réellement
            $soldeApresRetrait = $this->solde - $montant;
            $soldeFinal = $soldeApresRetrait;

            if ($soldeApresRetrait < 0) {
                $soldeFinal -= $this->fraisDecouvert; // application des frais
            }

            if ($soldeFinal < -$this->decouvertAutorise) {
                echo "Retrait refusé : dépassement du découvert autorisé.\n";
                return;
            }

            // Appliquer réellement
            $this->solde = $soldeApresRetrait;
            if ($this->solde < 0) {
                $this->solde -= $this->fraisDecouvert;
            }
        }

        public function afficher(): void {
            $infoDecouvert = "Découvert autorisé : {$this->decouvertAutorise} €";
            $infoFrais     = "Frais de découvert : {$this->fraisDecouvert} €";
            echo "{$this->titulaire} - Solde (courant) : {$this->solde} € — {$infoDecouvert} — {$infoFrais}\n";
        }
    }

    /* ---------------------------
    *             TESTS
    * --------------------------- */

    // Épargne
    $e = new CompteEpargne("Alice", 1000, 0.05);
    $e->appliquerInteret();           // 1000 -> 1050
    $e->afficher();                   // doit indiquer le taux

    // Courant sans découvert
    $c1 = new CompteCourant("Bob", 200, 0, 0);
    $c1->retirer(250);                // doit refuser (pas de découvert)
    $c1->afficher();

    // Courant avec découvert
    $c2 = new CompteCourant("Chloe", 100, 200, 8);
    $c2->retirer(250);                // 100 - 250 = -150 -> frais 8 => -158 (OK, >= -200)
    $c2->afficher();

    $c2->retirer(60);                 // tester dépassement: -158 - 60 = -218 -> frais potentiels rendraient < -200 => refus
    $c2->afficher();

    // Cas invalides
    try { new CompteEpargne("Dan", 500, -0.01); } catch (InvalidArgumentException $ex) { echo "OK (taux invalide)\n"; }
    try { new CompteCourant("Eve", 500, -100, 5); } catch (InvalidArgumentException $ex) { echo "OK (découvert invalide)\n"; }
    try { new CompteCourant("Fay", 500, 100, -2); } catch (InvalidArgumentException $ex) { echo "OK (frais invalides)\n"; }

    ```