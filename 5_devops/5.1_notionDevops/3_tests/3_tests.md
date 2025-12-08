# CI - Tests unitaires 🧪

L’exécution de tests unitaires et d’intégrations est au coeur de la démarche DevOps et d’intégration continue. C’est eux qui vont permettre de détecter les anomalies dans les développements réalisés. **Github Actions**, si un ou plusieurs tests sont en erreur, va fournir les rapports détaillés permettant d’identifier l’origine de l’erreur, et va signaler que la tâche est en erreur. Cela peut par exemple empêcher un merge de se réaliser dans Github.

```
- name: Run tests with coverage
  env: 
    XDEBUG_MODE: coverage 
    run: php artisan test --coverage --min=80
```

!!! info  "🎯 Objectifs pédagogiques"

  - Comprendre la structure des tests **Unit** et **Feature** dans Laravel.  
  - Écrire, exécuter et interpréter des tests automatisés.  
  - Intégrer les tests dans une **pipeline d’intégration continue (CI)**.  
  - Mesurer la **couverture de code** et fixer un seuil minimal de qualité.

##  1. Initialisation de l’environnement de test 🏗️

Crée un environnement dédié aux tests.

```bash
cp .env .env.testing
php artisan key:generate
```

▶️ Configure `.env.testing` ⚙️

D'abord la base de données de Test :

```php
CREATE DATABASE todo_test;
CREATE USER 'laravel_test'@'localhost' IDENTIFIED BY 'secret';
GRANT ALL PRIVILEGES ON todo_test.* TO 'laravel_test'@'localhost';
FLUSH PRIVILEGES;
```
puis la configuration

```php
DB_CONNECTION=mysql 
DB_HOST=127.0.0.1 
DB_PORT=3306 
DB_DATABASE=todo_test 
DB_USERNAME=laravel_test 
DB_PASSWORD=secret
```

??? warning "💡 fix probléme sqlite"
  dans le fichier `phpunit.xml` à la racine du projet
  ```
    <!--
    <server name="DB_CONNECTION" value="sqlite"/>
    <server name="DB_DATABASE" value=":memory:"/>
    -->
    <server name="DB_CONNECTION" value="mysql"/>
    <server name="DB_DATABASE" value="todo_test"/>
    <server name="DB_USERNAME" value="laravel_test"/>
    <server name="DB_PASSWORD" value="secret"/>
  ```

##  2. Premier test “Smoke test” 🧩

Crée un test pour vérifier que la page d’accueil est accessible.

```bash
php artisan make:test AccueilTest
```

Cela créé un nouveau répertoire `tests`, modifions à présent `tests/Feature/AccueilTest.php` :


```php
public function test_invite_est_redirige_depuis_accueil_vers_login()
{
    $response = $this->get('/');
    $response->assertRedirect(route('login'));
}

public function test_utilisateur_auth_peut_acceder_a_l_accueil()
{
    $user = User::factory()->create();

    $response = $this->actingAs($user)
                     ->followingRedirects()
                     ->get('/');

    $response->assertOk();
    // On vérifiera qu'on voit bien le texte "Ma Todo List" dans la page
    $response->assertSee('Ma Todo List');
}
```

- ``assertRedirect(route('login'))`` montre le comportement pour un invité.
- ``actingAs($user)`` + ``followingRedirects()`` illustre le scénario d’un utilisateur authentifié.
- L’assertion porte sur un texte réel de la vue, pas sur le nom de la route.

🏃 Lançons les tests :

```bash
php artisan test
```

??? warning "💡 fix probléme"

  - Mettre en commentaire le contenu de exampleTest.php
  - Réparer le test d'authentification

    ```php
     FAILED  Tests\Feature\Auth\AuthenticationTest > users can authenticate using the login screen
    Failed asserting that two strings are equal.
    --- Expected
    +++ Actual
    @@ @@
    -'http://localhost/dashboard'
    +'http://localhost'
    +++ Actual
    @@ @@
    -'http://localhost/dashboard'
    +'http://localhost'
    @@ @@
    -'http://localhost/dashboard'
    +'http://localhost'
    -'http://localhost/dashboard'
    +'http://localhost'
    +'http://localhost'
    ```

???  success "résultats"
  ```prompt
  (base) PS C:\wamp64\www\todo2026> php artisan test

   PASS  Tests\Unit\ExampleTest
  ✓ that true is true                                                                                                           0.02s  

   PASS  Tests\Feature\AccueilTest
  ✓ invite est redirige depuis accueil vers login                                                                               0.63s  
  ✓ utilisateur auth peut acceder a l accueil                                                                                   0.58s  

   PASS  Tests\Feature\Auth\AuthenticationTest
  ✓ login screen can be rendered                                                                                                3.22s  
  ✓ users can authenticate using the login screen                                                                               0.17s  
  ✓ users can not authenticate with invalid password                                                                            0.29s  
  ✓ users can logout                                                                                                            0.10s  

   PASS  Tests\Feature\Auth\EmailVerificationTest
  ✓ email verification screen can be rendered                                                                                   0.14s  
  ✓ email can be verified                                                                                                       0.08s  
  ✓ email is not verified with invalid hash                                                                                     0.10s  

   PASS  Tests\Feature\Auth\PasswordConfirmationTest
  ✓ confirm password screen can be rendered                                                                                     0.12s  
  ✓ password can be confirmed                                                                                                   0.07s  
  ✓ password is not confirmed with invalid password                                                                             0.30s  

   PASS  Tests\Feature\Auth\PasswordResetTest
  ✓ reset password link screen can be rendered                                                                                  0.07s  
  ✓ reset password link can be requested                                                                                        0.27s  
  ✓ reset password screen can be rendered                                                                                       0.38s  
  ✓ password can be reset with valid token                                                                                      0.33s  

   PASS  Tests\Feature\Auth\PasswordUpdateTest
  ✓ password can be updated                                                                                                     0.08s  
  ✓ correct password must be provided to update password                                                                        0.08s  

   PASS  Tests\Feature\Auth\RegistrationTest
  ✓ registration screen can be rendered                                                                                         0.07s  
  ✓ new users can register                                                                                                      0.07s  

   PASS  Tests\Feature\ProfileTest
  ✓ profile page is displayed                                                                                                   0.19s  
  ✓ profile information can be updated                                                                                          0.07s  
  ✓ email verification status is unchanged when the email address is unchanged                                                  0.08s  
  ✓ user can delete their account                                                                                               0.08s  
  ✓ correct password must be provided to delete account                                                                         0.10s  

  Tests:    26 passed (64 assertions)
  Duration: 8.40s
  ```

## 3. Les factories Eloquent 🏭

🧩 Qu’est-ce qu’une Factory Laravel ?

Une factory est un outil fourni par Laravel pour **générer automatiquement des données de test réalistes**. 

Elle permet de créer facilement :

- des objets Eloquent cohérents (User, Todo, Liste, etc.),
- avec des valeurs aléatoires mais crédibles (texte, dates, booléens…),
- et surtout sans écrire manuellement chaque champ.

Les factories sont essentielles pour les tests, car elles permettent :

- de simplifier la création d’entrées en base,
- d’éviter de dupliquer du code,
- d’isoler les tests (chaque test crée ses propres données),

et d’obtenir des tests précis, reproductibles et rapides.

Les fichiers de factories se trouvent dans le dossier :

```text
database/factories/
```

**note :**Laravel fournit déjà une factory pour User : ``UserFactory.php``.

### 3.1. Vérifier la factory User 🧑‍💻

Ouvre le fichier suivant : ``database/factories/UserFactory.php``

Tu dois y trouver une méthode ``definition()`` qui ressemble à ceci :

```php
public function definition(): array
{
    return [
        'name' => fake()->name(),
        'email' => fake()->unique()->safeEmail(),
        'email_verified_at' => now(),
        'password' => '$2y$10$'.strtr('password-hash', ['.' => '/']), // ou Hash::make(...)
        'remember_token' => Str::random(10),
    ];
}
```

L’important pour nous est :

👉 ``User::factory()->create()`` permet de créer facilement un utilisateur de test valide.

### 3.2. Créer une factory pour Listes 📂

On veut pouvoir générer des listes de Todos pour les tests (ex. “Maison”, “Travail”, etc.).

Crée la factory : ``php artisan make:factory ListesFactory --model=Listes``

Puis complète ``database/factories/ListesFactory.php`` :

```php
use App\Models\Listes;
use Illuminate\Database\Eloquent\Factories\Factory;

class ListesFactory extends Factory
{
   protected $model = Listes::class;

    public function definition(): array
    {
        return [
            'titre' => fake()->words(2, true), // par ex. "Maison", "Bureau perso"
        ];
    }

}
```

??? question "💡 Explication ListeFactory"
  Ici, on utilise ``fake()->words(2, true)`` pour générer un nom de liste avec 2 mots.<br />
  À partir de là, un simple ``Listes::factory()->create()`` dans un test insérera une ligne dans la table ``listes`` avec un champ ``titre`` cohérent.

!!! question "A faire"
  === "Enoncé"
    ✅ Créer une factory pour Todo (sans relations)
  === "Solution"

    ```php
      <?php

      namespace Database\Factories;

      use Illuminate\Database\Eloquent\Factories\Factory;
      use App\Models\Todos;
      use App\Models\Listes;
      use App\Models\User;    

      /**
       * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Todos>
       */
      class TodosFactory extends Factory
      {
          protected $model = Todos::class;

          public function definition(): array
          {
              return [
                  'texte'     => fake()->sentence(3),
                  'termine'   => false,
                  'important' => false,
                  'date_fin'  => null,
                  'listes_id' => Listes::factory(), // crée une Liste associée
                  'user_id'   => User::factory(),  // crée un User associé
              ];
          }
      }

      ```
      
    Avec cette factory, on peut déjà écrire :

    ```php
    $todos = Todos::factory()->create();
    ```
    Laravel créera un enregistrement dans la table `todos` avec :

    - un `texte` réaliste,  
    - `termine = false`,  
    - `important = false`,  
    - les FK `listes_id` et `user_id` à `null` (non associées pour l’instant).

    C’est suffisant pour des **premiers tests** sur les attributs du modèle `Todo`.

### 3.3. Todo lié à une Liste et à un User 🔗

Pour des tests plus complets (relations Eloquent), on peut demander à la factory Todo de **créer automatiquement** une Liste et un User associés.

??? tip "code TodoFactory"

    ```php
    use App\Models\Todos;
    use App\Models\Listes;
    use App\Models\User;
    use Illuminate\Database\Eloquent\Factories\Factory;

    class TodosFactory extends Factory
    {
        protected $model = Todos::class;

        public function definition(): array
        {
            return [
                'texte'     => fake()->sentence(3),
                'termine'   => false,
                'important' => false,
                'date_fin'  => null,
                'listes_id' => Listes::factory(), // crée une Liste associée
                'user_id'   => User::factory(),  // crée un User associé
            ];
        }
    }


    ```
En configurant ``listes_id`` et ``user_id`` avec ``Liste::factory()`` et ``User::factory()``, on obtient un comportement très puissant :

```php
$todo = Todos::factory()->create();
```

réalise en réalité :

1. création d’un `User` de test,  
2. création d’une `Listes` de test,  
3. création du `Todos` lié à ces deux enregistrements.

Cela simplifie énormément les tests qui portent à la fois sur `Todos` et sur ses relations (ex. `todos->listes`, `todos->user`).

✔️ Tester une factory
```
> App\Models\Listes::factory()->create();
= App\Models\Listes {#6211
    titre: "eos ut",
    updated_at: "2025-12-06 13:09:32",
    created_at: "2025-12-06 13:09:32",
    id: 4,
  }
```

Résultat : un nouvel enregistrement todos est inséré dans la base de développement.
✔️ Créer un utilisateur
```
> App\Models\User::factory()->create();
= App\Models\User {#6632
    name: "Diane Lambert",
    email: "pauline27@example.net",
    email_verified_at: "2025-12-06 13:14:50",
    #password: "$2y$12$mynJ8kscphRfl1KCdRRVR.XS8hKU0dxzQvaBkTWWc8P9TkgonEgEq",
    #remember_token: "nNiqZwe2AN",
    updated_at: "2025-12-06 13:14:51",
    created_at: "2025-12-06 13:14:51",
    id: 3,
  }
```

✔️ Tester la factory Todos

```prompt
> App\Models\Todos::factory()->create();
= App\Models\Todos {#5520
    texte: "Ut rerum praesentium fugit.",
    termine: false,
    important: false,
    date_fin: null,
    listes_id: 5,
    user_id: 4,
    updated_at: "2025-12-06 13:22:15",
    created_at: "2025-12-06 13:22:15",
    id: 9,
  }
```

✔️ Lister les enregistrements existants
>>> App\Models\Todos::all();

### 3.4. Vérifier le bon fonctionnement des factories 🎢

**Tinker** est une console interactive fournie par Laravel, basée sur ``PsySH``, qui permet d’exécuter du code PHP en direct au sein de ton application.

C’est un outil extrêmement pratique pour :

- tester rapidement des modèles Eloquent,
- manipuler la base de données depuis le shell,
- vérifier le fonctionnement d’une factory,
- expérimenter un morceau de logique métier,
- déboguer un comportement sans écrire de route ni de test.

▶️ Ouvrir **Tinker**

Dans ton terminal (à la racine du projet) : ``php artisan tinker``

Tu obtiens alors une console interactive :

```prompt
Psy Shell v0.11.8 (PHP 8.2 …)
>>>
```
Tout ce que tu écris ici est exécuté dans le contexte de ton application Laravel.


??? warning "Fix"
  
  - penser à ajouter ``use HasFactory;`` dans le model de Todos
  - Vider le cache Laravel
    ```
    php artisan optimize:clear
    composer dump-autoload
    ```

## 4. Tests Unitaires : modèle Eloquent 🧱 

Dans cette étape, nous allons vérifier le comportement du modèle **`Todos`** à l’aide de **tests unitaires** :

- relations `Todos → Listes` et `Todos → User`,  
- valeurs par défaut de certains attributs (`termine`, `important`, etc.).

L’objectif est de valider le modèle **sans passer par les routes ni les vues**.

### 4.1 Création du test de modèle 🧪

Génère un test unitaire dédié au modèle `Todos` :

```bash
php artisan make:test TodosModelTest --unit
```
Cela crée le fichier ``tests/Unit/TodosModelTest.php``

Modifier l’en-tête du fichier pour qu’il étende bien la classe de test Laravel (et pas le TestCase brut de PHPUnit), afin de pouvoir utiliser les factories et la base de données de test.

```php
<?php

namespace Tests\Unit;

use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;
use App\Models\Todos;
use App\Models\Listes;
use App\Models\User;

class TodosModelTest extends TestCase
{
    use RefreshDatabase;

    // Les tests viendront ici
}
```
??? question "💡 Pourquoi utiliser Tests\TestCase et RefreshDatabase ?"

  - ``Tests\TestCase ``charge le contexte Laravel complet (config, Eloquent, etc.) dans les tests, même dans tests/Unit.
  - ``RefreshDatabase`` relance les migrations pour chaque test afin de garantir une base de test propre (pas de pollution entre tests).

### 4.2 Tester la relation Todos → Listes 🔗

Ton modèle Todos déclare une relation :

```php
public function listes(): BelongsTo
{
    return $this->belongsTo(Listes::class)->withDefault();
}
```
Nous allons vérifier que cette relation fonctionne bien.

Dans ``TodosModelTest`` :

```php
public function test_un_todos_appartient_a_une_liste()
{
    // Arrange : création d'une liste
    $liste = Listes::factory()->create();

    // Act : création d'un Todos lié à cette liste
    $todo = Todos::factory()->for($liste, 'listes')->create();

    // Assert : la relation renvoie bien la bonne liste
    $this->assertTrue($todo->listes->is($liste));
}
```

??? question "💡 Détail sur for($liste, 'listes')"

  - ``Listes::factory()->create()`` crée une ligne dans la table listes.
  - ``Todos::factory()->for($liste, 'listes')->create()`` demande à Laravel de remplir la clé étrangère correspondant à la relation **listes** dans le modèle **Todos**.
  - L’assertion ``is()`` vérifie que ``$todo->listes`` et ``$liste`` représentent le même enregistrement.

🏃 Relancer les tests : ``php artisan test``

!!! question "A faire"
  === "Enoncé"
    Tester la relation Todos → User 👤
  === "Solution"

    ```php
    public function test_un_todos_appartient_a_un_utilisateur()
    {
        // Arrange : création d'un utilisateur
        $user = User::factory()->create();

        // Act : création d'un Todos lié à cet utilisateur
        $todo = Todos::factory()->for($user, 'user')->create();

        // Assert : la relation renvoie bien le bon utilisateur
        $this->assertTrue($todo->user->is($user));
    }
    ```

??? question "💡 Pourquoi tester les relations ?"
  Ces tests garantissent que :

  - les clés étrangères (listes_id, user_id) sont correctement utilisées,
  - les méthodes listes() et user() renvoient bien les modèles attendus.

  En cas de renommage de colonne, de modèle ou de relation, ces tests serviront de garde-fous.

!!! question "A faire"
  === "Enoncé"
    Tester les valeurs par défaut (termine, important) ✅
  === "Solution" 

    ```php
      public function test_un_todos_est_non_termine_et_non_important_par_defaut()
      {
          // Act : création d'un Todos sans préciser termine/important
          $todo = Todos::factory()->create();

          // Assert : les valeurs par défaut sont respectées
          $this->assertFalse($todo->termine);
          $this->assertFalse($todo->important);
      }   
    ```

##  5.Tests de validation 🧮

Nous allons maintenant écrire des **tests de validation** pour le formulaire d’ajout d’un Todo.

🎯 **Objectifs** :

- Vérifier que certains champs sont **obligatoires** (`texte` notamment).  
- Vérifier que certains champs respectent des **contraintes** (longueur minimale, format de date…).  
- Vérifier qu’un Todo **valide** est bien créé en base.

### 5.1 Préparer un test dédié 📄

Crée un test de type **Feature** ``php artisan make:test TodosValidationTest``

Cela créé un fichier dans ``tests/Feature/TodosValidationTest.php``, modifier le code ainsi :

```php
<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Listes;
use App\Models\Todos;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class TodosValidationTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Méthode utilitaire pour poster un Todo avec des données par défaut
     */
    private function postTodo(array $overrides = [])
    {
        $user = User::factory()->create();
        $this->actingAs($user);

        $liste = Listes::factory()->create();

        $data = array_merge([
            'texte'      => 'Acheter du café',
            'date_fin'   => now()->addDay()->format('Y-m-d\TH:i'),
            'priority'   => 0,              // bouton radio importance
            'categories' => [],             // tableau de catégories (checkbox)
            'liste'      => $liste->id,     // correspond à $request->input('liste')
        ], $overrides);

        return $this->post('/action/add', $data);
    }
```

??? question "💡 Pourquoi une méthode postTodo() ?"
  Cette méthode permet de : 

  - centralise la construction d’un **jeu de données valide**,  
  - permet d’écrire des tests plus courts en ne modifiant que les champs à tester,  
  - garantit que tous les autres champs restent cohérents (liste existante, user connecté, etc.).

### 5.2 texte est obligatoire ✏️

Premier cas : le champ texte doit être obligatoire.

```php
public function test_texte_est_obligatoire()
{
    $response = $this->postTodo(['texte' => '']);

    $response->assertSessionHasErrors('texte');
    $this->assertDatabaseCount('todos', 0);
}
```
??? question "💡 Comportement attendu côté contrôleur"

  Dans ton contrôleur qui traite ``/action/add``, tu dois avoir quelque chose comme :

  ```php
  $validated = $request->validate([
      'texte' => ['required', 'string'],
      // autres règles…
  ]);
  ```
  Le test vérifie que :

  - si `texte` est vide, Laravel renvoie une **erreur de validation** sur ce champ,  
  - aucun `Todos` n’est créé en base.

  mais 

```
     FAIL  Tests\Feature\TodosValidationTest
  ⨯ texte est obligatoire                                                                                                       0.11s  
  ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────  
   FAILED  Tests\Feature\TodosValidationTest > texte est obligatoire
  Session is missing expected key [errors].
Failed asserting that false is true.

  at tests\Feature\TodosValidationTest.php:40
     36▕     public function test_texte_est_obligatoire()
     37▕     {
     38▕         $response = $this->postTodo(['texte' => '']);
     39▕
  ➜  40▕         $response->assertSessionHasErrors('texte');
     41▕         $this->assertDatabaseCount('todos', 0);
     42▕     }
     43▕ }
     44▕
```

Il faut adapter le test au contrôleur actuel !
Le contrôleur, en cas de texte vide, ne renvoie pas d’errors bag, mais :

+ déclenche une ValidationException,
+ la catch renvoie un redirect()->route('todo.liste')->with('message', "...").

Donc le test doit vérifier :

- la redirection vers la route,
- la présence du message en session,
- l’absence de nouvelle ligne dans todos.

```php
public function test_texte_est_obligatoire()
{
    $response = $this->postTodo(['texte' => '']);

    $response->assertRedirect(route('todo.liste'));

    $response->assertSessionHas('message', "Veuillez saisir un ToDo d'une longueur max de 255 caractères");

    $this->assertDatabaseCount('todos', 0);
}
```
et ca passe beaucoup mieux ...

```
   PASS  Tests\Feature\TodosValidationTest
  ✓ texte est obligatoire                                                                                                       0.11s  

  Tests:    28 passed (69 assertions)
  Duration: 6.48s
```

🚩 Mais quel est la bonne pratique ?

!!! question "A faire : longueur minimale"
  === "Enoncé"
    Actuellement, la règle est ``'texte' => 'required|string|max:255',``
    ▶️ La règle doit à présent être d'avoir une contrainte supplémentaire, une longueur minimale de 3 caractères

    - Implémenter cette règle
    - Faites en sorte qu'elle soit bien prise en compte dans votre interface
    - Tester cette règle dans les features de tests.

  === "Solution"
    dans le controleur : 

    ```php
    $request->validate([
    'texte' => 'required|string|min:3|max:255',
    ]);
    ```
    dans les tests : 

    ```php
    public function test_texte_doit_avoir_une_longueur_minimale()
    {
        $response = $this->postTodo(['texte' => 'ab']); // 2 caractères

        $response->assertSessionHasErrors('texte');
        $this->assertDatabaseCount('todos', 0);
    }
    ```

!!! tip "Exécution ciblée des tests de validation ▶️"
  Pour exécuter uniquement cette classe de tests :

  ```bash
  php artisan test --filter=TodosValidationTest
  ```
### 5.3 Cas nominal : données valides ➕✔️

Il est important de tester aussi le scénario heureux :<br />
quand toutes les données sont valides, le Todo doit être créé.

```php
public function test_un_todos_valide_est_cree()
{
    $response = $this->postTodo(); // toutes les valeurs par défaut sont valides

    $response->assertSessionDoesntHaveErrors();
    $response->assertRedirect(); // ou ->assertRedirect('/'); selon ton contrôleur

    $this->assertDatabaseCount('todos', 1);

    $this->assertDatabaseHas('todos', [
        'texte'   => 'Acheter du café',
        'termine' => 0,
        'important' => 0,
    ]);
}
```

??? question "💡 Pourquoi ce test est essentiel ?"
  - Il vérifie que la création fonctionne en cas de données valides.
  - Il sert de référence pour les autres tests de validation : ils ne doivent empêcher que les données invalides.
  - En cas de modification ultérieure du contrôleur, ce test permet de détecter une régression sur le CAS NOMINAL.

!!! info "Available assertions 📕"
  Il existe de nombreuses assertions différentes. Elles sont disponible dans la [documentation](https://laravel.com/docs/12.x/database-testing#available-assertions) de Laravel.

## 6. Gestion de la base de données pendant les tests 🧰

Jusqu’ici, nous avons écrit des tests qui créent des utilisateurs, des listes et des todos à l’aide des **factories**.  
Il est maintenant important de bien comprendre comment Laravel gère la **base de données** pendant les tests.

🎯 **Objectifs** :

- Comprendre comment **isoler** chaque test (pas de pollution entre tests).  
- Savoir sur **quelle base** s’exécutent les tests (`.env.testing`).  
- Utiliser les assertions `assertDatabaseHas`, `assertDatabaseMissing`, `assertDatabaseCount`.

### 6.1 Le trait `RefreshDatabase` 🔄

[documentation](https://laravel.com/docs/12.x/database-testing)

Laravel fournit le trait ``use Illuminate\Foundation\Testing\RefreshDatabase;``

Ce trait, utilisé dans une classe de test, garantit que :

- les migrations sont exécutées pour la base de test,
- la base est remise à zéro entre les tests (soit par migrate:fresh, soit par transactions selon le driver).

**Exemple** (déjà utilisé dans tes tests) :

```php
use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class TodosValidationTest extends TestCase
{
    use RefreshDatabase;

    // ...
}
```
??? question "💡 Que fait RefreshDatabase exactement ?"
  - Avant le premier test, Laravel exécute php artisan migrate sur la connexion de test.
  - Entre les tests, il remet la base dans un état propre (rollback ou migrate:fresh selon le driver).
  - Cela permet de s’assurer que chaque test est indépendant des autres :
  aucun enregistrement laissé par un test ne doit influencer un autre test.

### 6.2 Quelle base est utilisée pour les tests ? 🗄️

Laravel choisit la base de données de test via Le fichier ``.env.testing`` ou éventuellement des variables dans ``phpunit.xml``

Dans ton cas, tu as configuré une base MySQL dédiée, par exemple :

dans ``.env.testing``

```php
APP_ENV=testing
APP_DEBUG=true

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=todo_test
DB_USERNAME=laravel_test
DB_PASSWORD=secret
```

Pendant les tests, on ne touche jamais à la base de développement (``todo2025``) :
tout se passe dans la base ``todo_test``.

??? question "💡 Comment vérifier que Laravel utilise bien la bonne base ?"
  - Tu peux temporairement ajouter un test “de debug” :
  ```php
  public function test_voir_la_connexion_de_test() { 
    $this->assertSame('mysql', config('database.default')); 
    $this->assertSame('todo_test', config('database.connections.mysql.database'));
  }
  ```
  - Puis le supprimer une fois que tu es sûre de ta configuration.


### 6.3 Exécuter les tests ▶️

En général, tu n’as pas besoin de te soucier manuellement des migrations : ``RefreshDatabase`` s’en charge.

Mais si tu modifies les migrations ou la structure de la base, tu peux forcer un reset complet :

```bash
php artisan migrate:fresh --env=testing
php artisan test
```

??? question "💡 Quand utiliser ``migrate:fresh --env=testing`` ?"

  - Quand tu as modifié une migration existante (ajout/suppression de colonnes).
  - Quand tu veux repartir d’une base de test complètement propre.
  - À éviter en production, bien sûr : cela supprime toutes les tables avant de les recréer.

## 7. Tests d’authentification 🔐

Laravel génère automatiquement une série complète de **tests d’authentification et de sécurité**, via Breeze ou Jetstream.  
Ces tests couvrent déjà toutes les fonctionnalités essentielles :

- affichage des formulaires de connexion / inscription,  
- validation des identifiants,  
- impossibilité de se connecter avec un mot de passe incorrect,  
- confirmation de mot de passe,  
- mise à jour du mot de passe,  
- réinitialisation de mot de passe,  
- vérification d’e-mail,  
- déconnexion de l’utilisateur.

Ces tests se trouvent dans ``tests/Feature/Auth/``

??? question "Pourquoi conserver ces tests ? 🛡️"

  Ces tests assurent automatiquement :

  - que l’authentification reste fonctionnelle après une mise à jour,
  - que les étudiants ne cassent pas la sécurité en modifiant une vue ou une route,
  - que chaque changement sur les routes ou les middlewares continue de respecter les règles Laravel (auth, verified, etc.).
  - Ils constituent une base solide pour éviter les régressions pendant le développement.

### 7.2 Tests d’accès aux routes protégées (middleware auth) 🔒

Il peut être utile d’ajouter un seul test d'exemple dans ton TP pour illustrer comment vérifier qu’une route est bien protégée par auth.

```php
public function test_invite_ne_peut_pas_acceder_aux_todos()
{
    $response = $this->get('/todos');

    $response->assertRedirect(route('login'));
}
```
### 7.3 Tests liés à l'autorisation (Policies) 🧭

Lorsque tu ajoutes une policy pour restreindre l’accès aux Todos :

- un utilisateur ne peut modifier que ses propres Todos,
- un utilisateur ne peut supprimer que ses Todos, etc.,

tu peux tester ces règles simplement avec :

```php
public function test_un_utilisateur_ne_peut_pas_modifier_le_todo_d_un_autre()
{
    $a = User::factory()->create();
    $b = User::factory()->create();
    $todo = Todos::factory()->for($a, 'user')->create();

    $response = $this->actingAs($b)->post("/todos/{$todo->id}/edit", [
        'texte' => 'H4ck',
    ]);

    $response->assertForbidden();
}
```

Laravel renverra automatiquement 403 Forbidden si la policy refuse l’accès.

![en connstruction](../../images/enConstruction.png){: .center width=50%}

## 8. Intégration dans GitHub Actions ⚙️

🎯 Objectif : exécuter automatiquement les tests Laravel à chaque **push** ou **pull request** sur GitHub, avec un **seuil de couverture** minimal.

🔑 **Idée clé** :

- En **local**, tu peux utiliser MySQL (`todo_test`).
- En **CI GitHub Actions**, on va utiliser **SQLite en mémoire** (plus simple, plus rapide), en écrivant un `.env.testing` spécifique dans le workflow.
- On active la **couverture de tests** pour mesurer la part du code réellement exécutée par les tests, et on impose un seuil minimal (**80 %**).

### 8.1. Créer le workflow `tests.yml` 🧾

Dans ton projet, crée un fichier :  

`.github/workflows/tests.yml`  

Avec le contenu suivant :

```yaml
name: tests

on:
  push:
  pull_request:

jobs:
  laravel-tests:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - uses: shivammathur/setup-php@v2
        with:
          php-version: '8.3'
          extensions: mbstring, dom, sqlite, pdo_sqlite
          coverage: xdebug

      - name: Install dependencies
        run: composer install --no-interaction --prefer-dist

      - name: Prepare env
        run: |
          echo "APP_ENV=testing" > .env.testing
          echo "APP_KEY=" >> .env.testing
          echo "DB_CONNECTION=sqlite" >> .env.testing
          echo "DB_DATABASE=:memory:" >> .env.testing
          php artisan key:generate --env=testing

      - name: Run tests with coverage
        env:
          XDEBUG_MODE: coverage
        run: php artisan test --coverage --min=80
```
🔍 **Points importants** :

En CI, on écrase la config de test pour utiliser ``DB_CONNECTION=sqlite`` et ``DB_DATABASE=:memory:``, même si en local tu es sur MySQL.

``coverage: xdebug et XDEBUG_MODE=coverage permettent d’utiliser --coverage --min=80``.

### 8.2. Mesurer la couverture en local 📊

En local, tu peux également mesurer la couverture ``XDEBUG_MODE=coverage php artisan test --coverage``

Pour imposer le même seuil qu’en CI : ``XDEBUG_MODE=coverage php artisan test --coverage --min=80``

Si la couverture est inférieure à 80 %, la commande échoue (code de retour ≠ 0).

!!! question "💡 Notion de couverture"
  La **couverture de tests** mesure la part du code exécutée pendant les tests.

Dans notre CI :

- le job GitHub Actions **réussit** si la couverture est ≥ 80 % 
- il **échoue** si la couverture descend sous 80 %.

Cela transforme la couverture en **garde-fou qualité** :  <br />
si un développeur commente des tests ou ajoute beaucoup de code non testé, la CI refusera la PR ou signalera le problème sur le push.

### 8.3. Lancer la CI après les modifications ✅

Une fois le workflow en place, tu peux tester le pipeline complet :

```bash
vendor/bin/pint
php artisan test

git add .
git commit -m "Intégration de l'environnement de tests et de la couverture"
git push -u origin main
```

Sur **GitHub**, onglet Actions, tu dois voir le workflow tests s’exécuter automatiquement à chaque push / pull request.

!!! warning "Conclusion ✅"

  * Un environnement de test Laravel fonctionnel.
  * Des tests unitaires, fonctionnels et API.
  * Une mesure automatique de couverture.
  * Une exécution automatisée en CI GitHub Actions.

 


