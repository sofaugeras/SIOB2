# 3. TP Docker — WordPress 🐳

Projet : déploiement WordPress avec Docker sur `srv-debian`

!!! success "🎯 Objectifs du TP"

    - Se connecter à un serveur Linux distant via **SSH**
    - Comprendre la structure d'un **docker-compose.yml** fourni
    - Démarrer une stack **WordPress + MySQL** avec Docker Compose## 
    - Accéder à son WordPress via un **vhost** personnalisé
    - Manipuler les **commandes Docker de base** sur un vrai serveur

!!! info "Vue d'ensemble 🗺️"

    Chaque étudiant dispose d'un compte sur le serveur `srv-debian`.  
    Son espace de travail est **isolé** : ses conteneurs, son réseau Docker, son port, son URL.

    | 👤 Étudiant  | 🔌 Port | 🌐 URL d'accès                        |
    |:    -|:  --|:            --|
    | elouan       | :8081   | http://elouan.srv-debian.local        |
    | alexandre    | :8082   | http://alexandre.srv-debian.local     |
    | mael         | :8083   | http://mael.srv-debian.local          |

    !!! warning "Avant de commencer"
        Votre poste doit connaître l'adresse de `srv-debian.local`.  
        Votre professeur vous communiquera l'IP du serveur.  
        Il faudra l'ajouter dans votre fichier `hosts` (étape 0 ci-dessous).

## 0. Étape 0 — Configurer le DNS local sur votre PC Windows 🖥️

Pour que votre navigateur comprenne ` prenom.srv-debian.local`, il faut déclarer
l'adresse IP du serveur dans le fichier `hosts` de Windows.

**Ouvrir le fichier hosts en administrateur :**

1. Tapez `Notepad` dans le menu Démarrer
2. Clic droit → **"Exécuter en tant qu'administrateur"**
3. Ouvrir le fichier : `C:\Windows\System32\drivers\etc\hosts`
4. Ajouter la ligne suivante **tout en bas** (remplacez l'IP par celle donnée par le prof) :

```
192.168.X.X    prenom.srv-debian.local
```

5. Sauvegarder (`Ctrl+S`)

??? question "Comment tester que ça fonctionne ?"
    Ouvrez un **PowerShell** et tapez :
    ```powershell
    ping  prenom.srv-debian.local
    ```
    Vous devez voir l'IP du serveur répondre.  
    Si ce n'est pas le cas, vérifiez que vous avez bien sauvegardé en **administrateur**.

## Étape 1 — Se connecter au serveur en SSH 🔐

!!! info "C'est quoi SSH ?"
    **SSH** (Secure Shell) permet de contrôler un serveur Linux **à distance**,
    via un terminal chiffré. C'est l'outil quotidien de tout administrateur système.

Ouvrez **PowerShell** (ou Windows Terminal) sur votre PC et tapez :

```powershell
ssh VOTRE_PRENOM@srv-debian.local
```

Il vous sera demandé un mot de passe. **Le mot de passe initial est votre prénom.**

??? question "C'est normal d'avoir ce message ?"
    ```
    The authenticity of host 'srv-debian.local' can't be established.
    Are you sure you want to continue connecting (yes/no)?
    ```
    **Oui, c'est normal** la première fois. Tapez `yes` et appuyez sur Entrée.  
    SSH mémorise l'empreinte du serveur pour les connexions suivantes.

### 🔑 Changer son mot de passe (obligatoire)

Une fois connecté, changez immédiatement votre mot de passe :

```bash
passwd
```

Suivez les instructions : ancien mot de passe (votre prénom), puis nouveau mot de passe x2.

 

## Étape 2 — Découvrir son espace de travail 📁

Une fois connecté, vous êtes dans votre dossier personnel (`/home/VOTRE_PRENOM`).  
Le professeur a pré-créé votre dossier projet. Explorons-le :

```bash
# Savoir où on est
pwd
```

```bash
# Lister les fichiers de son dossier home
ls -la
```

```bash
# Entrer dans le dossier wordpress
cd wordpress
```

```bash
# Voir son contenu
ls -la
```

Vous devriez voir deux fichiers :

```
docker-compose.yml   ← la configuration de votre stack
README.md            ← vos infos personnalisées
```

Affichez le contenu de votre `docker-compose.yml` :

```bash
cat docker-compose.yml
```

!!! question "📝 Questions de compréhension"
    Lisez attentivement le fichier `docker-compose.yml` et répondez :
    
    1. Combien de **services** (conteneurs) sont définis ?
    2. Quel **port** de votre machine est associé au port 80 de WordPress ?
    3. Comment s'appelle le **réseau** Docker de votre stack ?
    4. Combien de **volumes** sont définis ? À quoi servent-ils ?

??? question "Correction"
    1. **2 services** : `wordpress` et `mysql`
    2. Le port **808X** selon votre prénom (8081 pour  prenom, 8082 pour alexandre, 8083 pour mael)
    3. Le réseau s'appelle `wp_network_VOTRE_PRENOM`
    4. **2 volumes** : `wp_content` (fichiers WordPress) et `mysql_data` (données de la BDD)

 

## Étape 3 — Démarrer la stack WordPress 🚀

Assurez-vous d'être dans le bon dossier :

```bash
cd ~/wordpress
```

Démarrez tous les conteneurs **en arrière-plan** (`-d` = detached) :

```bash
docker compose up -d
```

Docker va télécharger les images `wordpress:latest` et `mysql:8.0` si elles ne sont
pas encore présentes. **La première fois, cela peut prendre 2 à 3 minutes.**

Vous verrez défiler des lignes du type :
```
✔ Container mysql_elouan      Started
✔ Container wordpress_elouan  Started
```

!!! success "C'est bon quand vous voyez les deux lignes 'Started' !"

 

## Étape 4 — Vérifier que les conteneurs tournent 👀

```bash
docker compose ps
```

Résultat attendu :

```
NAME                  STATUS          PORTS
mysql_elouan          running         3306/tcp
wordpress_elouan      running         0.0.0.0:8081->80/tcp
```

!!! info "Comprendre les colonnes"
    - **NAME** : nom du conteneur (défini dans `docker-compose.yml`)
    - **STATUS** : `running` = en cours d'exécution ✅
    - **PORTS** : `0.0.0.0:8081->80/tcp` signifie que le port 8081 du serveur  
      est redirigé vers le port 80 du conteneur WordPress

??? warning "Un conteneur est en status 'Exiting' ou 'Restarting' ?"
    Regardez les logs pour comprendre l'erreur :
    ```bash
    docker compose logs mysql
    docker compose logs wordpress
    ```
    Le problème est souvent que MySQL n'a pas encore fini de démarrer.
    Attendez 30 secondes et relancez `docker compose ps`.

 

## Étape 5 — Installer WordPress depuis le navigateur 🌐

Sur votre PC Windows, ouvrez votre navigateur et accédez à **votre** URL :

| 👤 Étudiant  | 🌐 URL à ouvrir                        |
|:    -|:             |
| elouan       | http://elouan.srv-debian.local:8081    |
| alexandre    | http://alexandre.srv-debian.local:8082 |
| mael         | http://mael.srv-debian.local:8083      |

!!! tip "Le port est nécessaire dans l'URL car Nginx n'est pas encore configuré devant."

Vous arrivez sur l'**assistant d'installation WordPress** :

**1. Choisir la langue** → Français → Continuer

**2. Renseigner les informations du site :**

| Champ                | Valeur suggérée              |
|:       |:         --|
| Titre du site        | `Mon WordPress - VOTRE_PRENOM` |
| Identifiant          | `admin`                      |
| Mot de passe         | Choisissez-en un solide      |
| Adresse e-mail       | votre email (fictif ok)      |

**3. Cliquer sur "Installer WordPress"**

!!! success "🎉 WordPress est installé !"
    Vous pouvez maintenant vous connecter à l'administration :  
    `http://VOTRE_PRENOM.srv-debian.local:PORT/wp-admin`

 

## Étape 6 — Explorer les commandes Docker 🔍

Maintenant que votre stack tourne, explorons les commandes essentielles.

### Voir les logs en temps réel

```bash
# Logs de tous les services (Ctrl+C pour quitter)
docker compose logs -f

# Logs uniquement de WordPress
docker compose logs -f wordpress

# Logs uniquement de MySQL
docker compose logs -f mysql
```

### Entrer dans un conteneur

```bash
# Ouvrir un shell dans le conteneur WordPress
docker compose exec wordpress bash
```

Une fois à l'intérieur, vous êtes dans `/var/www/html` — le dossier WordPress.

```bash
# Lister les fichiers WordPress
ls

# Voir la version PHP
php --version

# Quitter le conteneur
exit
```

### Inspecter les ressources Docker

```bash
# Voir toutes les images téléchargées sur le serveur
docker images

# Voir l'espace disque utilisé par Docker
docker system df

# Voir tous les conteneurs (y compris arrêtés)
docker ps -a
```

!!! question "📝 Questions"
    1. Quelle version de PHP est utilisée dans le conteneur WordPress ?
    2. Quelle taille fait l'image `wordpress:latest` ?
    3. Quels fichiers reconnaissez-vous dans `/var/www/html` ?

 

## Étape 7 — Tester la persistance des données 💾

!!! info "Rappel"
    Sans volume, les données d'un conteneur disparaissent à sa suppression.  
    Votre `docker-compose.yml` définit des **volumes** pour éviter ça.

**Test pratique :**

1. Créez un article dans votre WordPress (`wp-admin` → Articles → Ajouter)
2. Revenez dans le terminal et **redémarrez** la stack :

```bash
docker compose down
docker compose up -d
```

3. Retournez sur votre WordPress dans le navigateur
4. Votre article est toujours là ? ✅ C'est la magie des volumes !

??? question "Que se passe-t-il si on supprime aussi les volumes ?"
    ```bash
    # ⚠️ ATTENTION : ceci supprime TOUTES vos données
    docker compose down -v
    ```
    Avec le flag `-v`, Docker supprime également les volumes.  
    La prochaine fois que vous faites `docker compose up -d`,  
    WordPress recommence depuis zéro (assistant d'installation).

 

## Étape 8 — Arrêter proprement sa stack 🛑

En fin de TP, arrêtez vos conteneurs pour libérer les ressources du serveur :

```bash
cd ~/wordpress
docker compose down
```

Vérifiez que les conteneurs sont bien arrêtés :

```bash
docker compose ps
```

La liste doit être **vide**.

 

## 🧾 Synthèse — Ce que vous avez fait

| ✅ Action | Commande utilisée |
|:   -|:     --|
| Se connecter au serveur | `ssh PRENOM@srv-debian.local` |
| Démarrer la stack | `docker compose up -d` |
| Vérifier les conteneurs | `docker compose ps` |
| Lire les logs | `docker compose logs -f` |
| Entrer dans un conteneur | `docker compose exec SERVICE bash` |
| Arrêter la stack | `docker compose down` |

 

## 🚀 Pour aller plus loin

!!! tip "Bonus — Personnaliser WordPress"
    Connectez-vous à l'admin WordPress et explorez :
    
    - **Apparence → Thèmes** : changez le thème de votre site
    - **Extensions → Ajouter** : installez une extension (ex: Contact Form 7)
    - **Réglages → Général** : changez le titre et le slogan du site

!!! tip "Bonus — Inspecter la base de données"
    Vous pouvez entrer dans le conteneur MySQL et explorer la BDD :
    ```bash
    docker compose exec mysql bash
    mysql -u wp_VOTRE_PRENOM -p
    # mot de passe : wp_pass_VOTRE_PRENOM
    SHOW DATABASES;
    USE wp_VOTRE_PRENOM;
    SHOW TABLES;
    EXIT;
    ```

!!! tip "Bonus — Modifier le docker-compose.yml"
    Ajoutez la variable d'environnement suivante dans le service `wordpress` :
    ```yaml
    WORDPRESS_DEBUG: "1"
    ```
    Puis relancez avec `docker compose up -d`.  
    Qu'est-ce qui change dans le comportement de WordPress ?
