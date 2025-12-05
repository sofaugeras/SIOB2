# CI - Tests unitaires et fonctionnels sous Laravel + CI GitHub Actions  🧪

![en connstruction](../../images/enConstruction.png)

L’exécution de tests unitaires et d’intégrations est au coeur de la démarche DevOps et d’intégration continue. C’est eux qui vont permettre de détecter les anomalies dans les développements réalisés. Github Actions, si un ou plusieurs tests sont en erreur, va fournir les rapports détaillés permettant d’identifier l’origine de l’erreur, et va signaler que la tâche est en erreur. Cela peut par exemple empêcher un merge de se réaliser dans Github.

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

## 🏗️ Étape 1 — Initialisation de l’environnement de test

Crée un environnement dédié aux tests.

```bash
cp .env .env.testing
php artisan key:generate
````

### ⚙️ Configure `.env.testing`

Option rapide (SQLite en mémoire) :

```env
DB_CONNECTION=sqlite
DB_DATABASE=:memory:
```

??? question "💡 Solution"
L’utilisation d’une base **SQLite en mémoire** permet d’exécuter les tests très rapidement, sans dépendre d’un serveur MySQL.
Laravel crée la base à chaque test et la supprime automatiquement.

 

## 🧩 Étape 2 — Premier test “Smoke test”

Crée un test pour vérifier que la page d’accueil est accessible.

```bash
php artisan make:test AccueilTest
```

Modifie `tests/Feature/AccueilTest.php` :

```php
public function test_accueil_est_accessible()
{
    $response = $this->get('/');
    $response->assertStatus(200);
    $response->assertSee('Bienvenue');
}
```

Lance les tests :

```bash
php artisan test
```

??? question "💡 Solution"
Le test `assertStatus(200)` confirme que la route `/` fonctionne correctement.
`assertSee('Bienvenue')` vérifie que le mot “Bienvenue” est affiché dans la page.

 

## 🧱 Étape 3 — Tests Unitaires : modèle Eloquent

Créons un test pour vérifier la relation entre `Todo` et `Liste`.

```bash
php artisan make:test TodoModelTest --unit
```

Modifie `tests/Unit/TodoModelTest.php` :

```php
use App\Models\Liste;
use App\Models\Todo;

public function test_un_todo_appartient_a_une_liste()
{
    $liste = Liste::factory()->create();
    $todo  = Todo::factory()->for($liste)->create();

    $this->assertTrue($todo->liste->is($liste));
}
```

??? question "💡 Solution"
Le test vérifie la **relation belongsTo()** définie dans le modèle `Todo`.
Si `$todo->liste` retourne bien l’objet `Liste` associé, la relation est correctement configurée.

 

## 🧮 Étape 4 — Tests de validation

Crée un test pour s’assurer qu’un champ requis est bien validé dans ton contrôleur.

```php
public function test_store_valide_le_champ_texte()
{
    $response = $this->post('/todos', ['texte' => '']);
    $response->assertSessionHasErrors('texte');
}
```

??? question "💡 Solution"
`assertSessionHasErrors('texte')` permet de confirmer que Laravel renvoie une erreur de validation sur le champ `texte`.

 

## 🧰 Étape 5 — Gestion de la base de données pendant les tests

Ajoute le trait suivant dans ta classe de test :

```php
use Illuminate\Foundation\Testing\RefreshDatabase;

class TodosTest extends TestCase
{
    use RefreshDatabase;
}
```

Exemple de test :

```php
public function test_store_cree_un_todo()
{
    $payload = ['texte' => 'Acheter du café'];
    $this->post('/todos', $payload)->assertRedirect();
    $this->assertDatabaseHas('todos', $payload);
}
```

??? question "💡 Solution"
`RefreshDatabase` relance les migrations avant chaque test.
`assertDatabaseHas` vérifie la présence du nouvel enregistrement dans la table `todos`.

 

## 🔒 Étape 6 — Tests d’authentification et de politique d’accès

### Cas 1 : utilisateur invité

```php
public function test_invite_redirige_vers_login()
{
    $this->post('/todos', ['texte'=>'x'])->assertRedirect('/login');
}
```

### Cas 2 : un utilisateur ne peut pas modifier le Todo d’un autre

```php
public function test_un_user_ne_modifie_pas_le_todo_d_un_autre()
{
    $owner = User::factory()->create();
    $other = User::factory()->create();
    $todo  = Todo::factory()->for($owner, 'user')->create();

    $this->actingAs($other)
         ->patch("/todos/{$todo->id}", ['texte'=>'hack'])
         ->assertForbidden();
}
```

??? question "💡 Solution"
Ces tests valident la **policy Laravel** associée à l’action `update`.
L’utilisateur connecté ne doit pas pouvoir modifier le todo d’un autre.

 

## 📬 Étape 7 — Tests avec *Fakes* (Mail, Queue, Storage)

### Exemple : Mail fake

```php
use Illuminate\Support\Facades\Mail;

Mail::fake();

public function test_envoi_mail_confirmation()
{
    $user = User::factory()->create();
    $this->actingAs($user)->post('/todos', ['texte'=>'test']);
    Mail::assertQueued(TodoCreeMail::class);
}
```

??? question "💡 Solution"
`Mail::fake()` empêche l’envoi réel d’e-mails.
`assertQueued()` vérifie que le mail a bien été planifié dans la file d’envoi.

 

## 🌐 Étape 8 — Tests d’API JSON

Crée un test API avec `Sanctum` :

```bash
php artisan make:test ApiTodosTest
```

```php
use Laravel\Sanctum\Sanctum;

public function test_api_liste_renvoie_json()
{
    Sanctum::actingAs(User::factory()->create());
    Todo::factory()->count(2)->create();

    $this->getJson('/api/todos')
         ->assertOk()
         ->assertJsonStructure([['id','texte','done']]);
}
```

??? question "💡 Solution"
`Sanctum::actingAs()` simule une authentification API.
`assertJsonStructure()` vérifie la structure du JSON renvoyé.

 

## 📊 Étape 9 — Mesure de la couverture

Active Xdebug localement :

```bash
XDEBUG_MODE=coverage php artisan test --coverage --min=80
```

??? question "💡 Solution"
L’option `--min=80` force la commande à échouer si la couverture descend sous 80 %.
Cela aide à maintenir un haut niveau de qualité dans le code.

 

## ⚙️ Étape 10 — Intégration dans GitHub Actions

Crée un fichier `.github/workflows/tests.yml` :

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
          cp .env .env.testing
          printf "DB_CONNECTION=sqlite\nDB_DATABASE=:memory:\n" >> .env.testing
          php artisan key:generate

      - name: Run tests with coverage
        env:
          XDEBUG_MODE: coverage
        run: php artisan test --coverage --min=80
```

??? question "💡 Solution"
Ce workflow :
- installe PHP et SQLite,
- configure un `.env.testing`,
- exécute tous les tests,
- vérifie que la couverture dépasse **80 %**.

 

## ✅ Conclusion

Tu as maintenant :

* Un environnement de test Laravel fonctionnel.
* Des tests unitaires, fonctionnels et API.
* Une mesure automatique de couverture.
* Une exécution automatisée en CI GitHub Actions.

 

## 🧭 Pour aller plus loin

* Générer un rapport HTML :

  ```bash
  php artisan test --coverage-html=build/coverage
  ```
* Ajouter `phpstan` et `laravel/pint` à la CI pour vérifier la qualité du code.
* Fixer des seuils de qualité et des *badges* dans le README.
