# Intégration Continue : compilation

## 1. Concepts et définition

🚀 L’intégration continue : un atout essentiel pour les développeurs

L’intégration continue (CI) est une pratique qui automatise les étapes de vérification, test et analyse du code à chaque modification du projet, dans l’optique de détecter les erreurs et de réduire les temps de
déploiement.

💡 **Pourquoi la mettre en place ?**

✅ Qualité du code garantie
Chaque commit déclenche automatiquement des contrôles : tests unitaires, analyse statique et vérification du style (Lint).
Cela permet de repérer les erreurs avant qu’elles ne soient déployées.

🤝 Travail d’équipe facilité
Plusieurs développeurs peuvent travailler sur le même projet.
La CI vérifie que le code de chacun s’intègre sans casser les fonctionnalités existantes.

⚡ Détection rapide des problèmes
Les bugs ou incohérences sont détectés dès leur apparition, ce qui réduit le temps de correction et évite les mauvaises surprises en production.

🧩 Gain de temps et professionnalisation
Moins de tests manuels, plus de rigueur automatisée.
Les étudiants découvrent les mêmes outils et processus utilisés dans les entreprises (GitHub Actions, GitLab CI, Jenkins…).

🔧 Des outils intégrés aux processus
On défini des **pipelines** qui sont des enchaînements d’actions réalisées sur le projet de façon scriptée et automatique. <br />
Chaque exécution du pipeline est appelée **build**.

![illustration](./data/CI_principes.png){: .center width=50%}

Il existe plusieurs outils sur le marché pour gérer l'intégration continue

- Jenkins : un outil open-source d'intégration et de livraison continues, qui automatise tests et déploiements, détecte rapidement les bugs, et s'intègre facilement à divers outils grâce à son système de plugins. Coder en Java et Gratuit.
- Github Actions
- GitLab CI

👉 Nous utiliserons **Github Actions**.

GitHub Actions est une plateforme d’intégration continue et livraison continue (CI/CD) qui vous permet d’automatiser votre pipeline de génération, de test et de déploiement. Vous pouvez créer des workflows qui créent et testent chaque demande de pull request. 

Vous pouvez configurer un **workflow** GitHub Actions à déclencher quand un événement se produit dans votre dépôt, par exemple l'ouverture d'une pull request ou la création d'un problème. Un workflow est un processus automatisé configurable qui exécutera un ou plusieurs travaux. Les workflows sont définis par un fichier **YAML** archivé dans votre dépôt et s’exécutent lorsqu’ils sont déclenchés par un événement dans votre dépôt, ou ils peuvent être déclenchés manuellement ou selon une planification définie. [documentation Github](https://docs.github.com/fr/actions/get-started/continuous-integration){target="_blank"}
L’intégration continue, c’est un garde-fou automatique qui assure la qualité, la fiabilité et la cohérence du code tout au long du développement.

En résumé 🎯<br />
L’intégration continue, c’est un garde-fou automatique qui assure la qualité, la fiabilité et la cohérence du code tout au long du développement.
  

## 2. Création du repositorie Github

Première étape : initialiser un dépôt git en local et le lier  à un repositorie sur Github.

### 2.1 En local
Se postionner dans le bon répertoire local ``C:\wamp64\www> cd todo2026``

```prompt
git init
git branch -M main

echo "/vendor
/node_modules
/public/build
/storage/*.key
/storage/app/*
/storage/framework/*
/storage/logs/*
.env
database/*.sqlite
" >> .gitignore

git add .
git commit -m "Initial commit: Laravel ToDo"
```

### 2.2 Sur Github

Sur GitHub, créer un ``New repository`` avec pour nom ``laravel-todo``.

Récupère l’URL HTTPS du dépôt, puis:

```
git remote add origin https://github.com/<ton-compte>/laravel-todo.git
git push -u origin main
```

### 2.3 Gérer l’environnement

Met à jour .env.example pour refléter ta config locale minimale.
💡 enlever le APP_KEY et les infos DB

Génére ta clé et vérifie en local:
```
cp .env.example .env
php artisan key:generate
php artisan serve
```

### 2.4 Fichier d’environnement CI MySQL

Ajoute .env.ci (spécifique aux jobs GitHub Actions) :
```
APP_ENV=testing
APP_DEBUG=false
# clef générée en CI, pas besoin ici
CACHE_DRIVER=array
SESSION_DRIVER=array
QUEUE_CONNECTION=sync

# MySQL fourni par le job CI
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=app_test
DB_USERNAME=laravel
DB_PASSWORD=laravel
```
Puis pousser le fichier sur github

```
git add .env.ci
git commit -m "Add CI env for MySQL"
git push origin main
```
### 2.5 Workflow GitHub Actions (CI)

Créer un nouveau fichier ``.github/workflows/ci.yml`` :

```
name: CI

on:
  push:
  pull_request:

jobs:
  build-test:
    runs-on: ubuntu-latest
    timeout-minutes: 20

    services:
      mysql:
        image: mysql:8.0
        env:
          MYSQL_ROOT_PASSWORD: root
          MYSQL_DATABASE: todo2025
          MYSQL_USER: todo
          MYSQL_PASSWORD: todo
        ports:
          - 3306:3306
        options: >-
          --health-cmd="mysqladmin ping -h 127.0.0.1 -proot"
          --health-interval=10s
          --health-timeout=5s
          --health-retries=10

    steps:
      - uses: actions/checkout@v4

      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: '8.3'
          extensions: mbstring, xml, ctype, curl, dom, fileinfo, gd, pdo_mysql
          coverage: xdebug

      - name: Cache Composer
        uses: actions/cache@v4
        with:
          path: ~/.composer/cache/files
          key: composer-${{ hashFiles('**/composer.lock') }}

      - name: Install Composer deps
        run: composer install --no-interaction --no-progress --prefer-dist

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install Node deps
        run: npm ci

      - name: Build front
        run: npm run build --if-present

      - name: Prepare CI .env and key
        run: cp .env.ci .env && php artisan key:generate

      - name: Wait for MySQL
        run: |
          for i in {1..30}; do
            (echo > /dev/tcp/127.0.0.1/3306) >/dev/null 2>&1 && break
            sleep 2
          done

      - name: Migrate database
        env:
          DB_CONNECTION: mysql
          DB_HOST: 127.0.0.1
          DB_PORT: 3306
          DB_DATABASE: todo2025
          DB_USERNAME: todo
          DB_PASSWORD: todo
        run: php artisan migrate --no-interaction --force

      - name: Lint PHP (Pint)
        run: |
            if [ ! -f vendor/bin/pint ]; then composer require --dev laravel/pint; fi
            vendor/bin/pint --test

      - name: Static analysis (Larastan)
        run: |
          if [ ! -f vendor/bin/phpstan ]; then composer require --dev phpstan/phpstan nunomaduro/larastan; fi
          vendor/bin/phpstan analyse --memory-limit=1G --no-progress
        continue-on-error: true


      - name: Upload build artifacts
        uses: actions/upload-artifact@v4
        with:
          name: build-${{ github.sha }}
          path: public/build
          if-no-files-found: ignore

```
Pousser vos modifications.
```
git add .github/workflows/ci.yml
git commit -m "CI MySQL: build + migrate + lint + analyse + tests"
git push origin main
```

## 3. Vérifier la CI

### 3.1 Github actions 

GitHub → Actions → “CI”. Ouvrer les logs en cas d'échec. 

![illustration](./data/CI1.png)

Les causes usuelles :

- Migrations dépendant de données seed manquantes → ajoute --seed si utile.
- Tests qui supposent un stockage non configuré → ajuste drivers en .env.ci.
- Erreurs de schéma → vérifie tes dernières migrations.

La CI ne passe pas car ...

```
- name: Lint PHP (Pint)
        run: |
            if [ ! -f vendor/bin/pint ]; then composer require --dev laravel/pint; fi
            vendor/bin/pint --test
```

### 3.2 Installer pint

📌 But de pint :

- Imposer un style de code homogène dans toute la base Laravel.
- Empêcher un merge si le code est mal indenté ou s’il y a des violations de style.
- Garantir la lisibilité et éviter que chaque développeur formate le code à sa manière.

Les Étapes pour installer le module pint :

- Installer Pint en local (dev dependency) : ``composer require --dev laravel/pint``
- Analyser ton code sans corriger (équivalent du --test en CI) : ``vendor/bin/pint --test`` #Vérifie et corrige le code
→ ça liste les fichiers non conformes.

![illustration](./data/pintFail.png)

- Corriger automatiquement : ``vendor/bin/pint``
→ ça reformate tout ton projet selon les règles par défaut (style Laravel, basé sur PSR-12).

- Termine la mise en place de pint en poussant les modifications vers github :
```
git add .
git commit -m "Fix code style with Pint"
git push origin main
```

🔓 Vérifier sur GitHub Actions : la CI devrait passer le job **Lint PHP** (Pint).

### 3.3 Règles minimales pour le style de code 

On va figer les règles de bases dans le projet dans un fichier ``pint.json`` minimal que tu peux placer à la racine du projet.

```
{
    "preset": "laravel",
    "rules": {
        "binary_operator_spaces": {
            "default": "single_space"
        },
        "concat_space": {
            "spacing": "one"
        },
        "ordered_imports": {
            "sort_algorithm": "alpha"
        },
        "single_quote": true,
        "no_unused_imports": true
    }
}
```

🎓 Explications :

- "preset": "laravel" → applique le style officiel Laravel (basé sur PSR-12).
- "binary_operator_spaces" → garantit un espace autour des opérateurs (=, +, =>).
- "concat_space" → impose un espace avant/après l’opérateur de concaténation ..
- "ordered_imports" → trie les use par ordre alphabétique.
- "single_quote": true → privilégie '...' sauf si les guillemets doubles sont nécessaires.
- "no_unused_imports": true → supprime les use inutiles.

lien vers la [Documentation](https://laravel.com/docs/12.x/pint)

??? tip "`Synthèse Utilisation"

  - Crée ``pint.json`` à la racine du projet.
  - Corrige ton code avec : ``vendor/bin/pint``
  - Vérifie ensuite avec : ``vendor/bin/pint --test``
  - Commit & push.


et la CI passe 🎉🎉🎉

![illustation](./data/CI_ok.png)

## 4. Standardiser les commandes avec les scripts Composer 🧩

Pour faciliter l’exécution des vérifications de qualité, on centralise les commandes clés dans le fichier **`composer.json`**, section **`scripts`**.<br />
Cela permet à chaque développeur (ou à la CI) d’utiliser des commandes uniformes.

```json
"scripts": {
  "lint": "vendor/bin/pint --test",
  "analyse": "vendor/bin/phpstan analyse",
  "test": "php artisan test --coverage --min=80"
}
```

🔍 **Explications**

* **`composer lint`** → vérifie le format du code selon les règles de *Laravel Pint*.
* **`composer analyse`** → lance l’analyse statique avec *PHPStan/Larastan* pour détecter les erreurs potentielles.
* **`composer test`** → exécute la suite de tests et contrôle la couverture minimale exigée (ici 80 %).

💡 Ces scripts standardisent les pratiques : que le code soit testé localement ou par la CI, les mêmes commandes sont utilisées. Ainsi, tout le monde parle le même “langage de validation” du projet.


## 5. Protection de la branche principale 🔐

Une fois la **CI** opérationnelle, il est important de protéger la branche **`main`** afin d’éviter que du code non validé soit fusionné.

▶️ **Étapes sur GitHub**

1. Ouvre ton dépôt → **Settings** → **Branches**.
2. Ajoute une **Branch protection rule** pour `main`.
3. Active :

   * ✅ *Require a pull request before merging* (oblige à passer par une PR).
   * ✅ *Require status checks to pass before merging* et sélectionne ton workflow CI (ex. `CI / build-test`).
4. Enregistre.

Ainsi, **aucun code ne sera intégré dans `main` si les tests, l’analyse et le lint ne passent pas**.
👉 C’est une garantie de stabilité et une excellente pratique à inculquer dès la formation.
