# 🛠️ TP 2 : Mauvaise gestion de configuration 

## 1. Présentation

!!! info "Définition (OWASP Top 10 – A05 :2021)"
    Une **mauvaise gestion de configuration de sécurité** se produit lorsqu’un logiciel, un serveur, un service ou une application n’est pas correctement configuré pour être sécurisé, ce qui peut laisser des portes ouvertes à des attaques.

🔍 Exemples concrets<br />
Voici des situations courantes considérées comme des mauvaises configurations :

| Cas concret                                                                            | Conséquences possibles                                                    |
| -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| 🔓 Serveur web laisse visible sa version et son OS                                     | Un attaquant peut chercher des vulnérabilités spécifiques à cette version |
| 📂 Répertoires sans index.html                                                         | Le contenu des dossiers est listé (fichiers accessibles publiquement)     |
| 🗂️ Fichiers de config ou de sauvegarde accessibles (ex: `.git`, `.bak`, `config.php`) | Accès à des infos sensibles (mots de passe, chemins système…)             |
| 🔁 Paramètres par défaut non changés (mot de passe, clés API, ports)                   | Accès non autorisé possible avec les infos d’usine                        |
| 🧪 Environnements de test laissés accessibles en production                            | Fichiers non sécurisés ou en mode debug exposés au public                 |
| 🚫 Modules inutiles laissés activés (Apache, PHP...)                                   | Surface d’attaque élargie inutilement                                     |
| ❌ Mauvaises permissions sur les fichiers (777)                                         | Tout le monde peut lire/modifier des fichiers critiques                   |
| 🛑 Pas de limitation de tentatives de connexion                                        | Favorise les attaques par force brute                                     |
| 🔄 Mises à jour de sécurité non appliquées                                             | Logiciels vulnérables, facilement exploitables                            |

📌 Pourquoi c’est fréquent ?

- Par oubli, manque de temps, ou méconnaissance.<br />
- Beaucoup de services sont livrés avec des réglages non sécurisés par défaut.<br />
- En phase de test, on ouvre souvent des accès… qu’on oublie de refermer en production.<br />

🛠️ Comment l’éviter ? (Bonnes pratiques)

| Bonne pratique                                | Explication                                                           |
| --------------------------------------------- | --------------------------------------------------------------------- |
| 🔐 **Désactiver ce qui n'est pas utilisé**    | Moins de services actifs = moins de failles potentielles              |
| 🔄 **Appliquer les mises à jour de sécurité** | Corrige les failles connues                                           |
| 🔒 **Masquer les informations sensibles**     | En-têtes HTTP, erreurs détaillées, version du logiciel…               |
| 🔍 **Effectuer des audits réguliers**         | Vérifier les ports ouverts, les fichiers exposés, les permissions     |
| 🔧 **Configurer des permissions strictes**    | Utiliser les bons droits (lecture seule, pas d’exécution si inutile…) |
| 📈 **Surveiller les logs**                    | Détecter des comportements anormaux ou des intrusions                 |

💡 À retenir
> La sécurité ne dépend pas que du code : mal configurer un serveur ou laisser les réglages par défaut, c’est comme laisser  la porte ouverte avec l’alarme désactivée.
> Les scanners automatisés peuvent détecter les erreurs de configurations. L’utilisation de comptes ou de configurations par défaut, les services inutiles, les options hérité de configurations précédentes,…

🐛 Même une application sans bug peut être compromise si l'environnement qui l'héberge est mal sécurisé.

## 2. Application sur Bijoo

#### 🔍 Partie 1

•	Inspectez l'URL suivante : http://localhost/breizhsecu/admin/config/  , que voyez-vous ?  Arrivez-vous à ouvrir le fichier qui s'y trouve ? 
•	Sachant qu'une base de données MySQL s'installe très souvent avec un utilisateur qui a pour accès par défaut root/root ou root et aucun mot de passe, avez-vous pensé à changer les accès par défaut pour mettre le site web en production ? 

Mais encore : [https://www.google.fr/search?dcr=0&q=intitle%3A%22Index%20of%22](https://www.google.fr/search?dcr=0&q=intitle%3A%22Index%20of%22)


Faites une recherche sur les dernières failles Apache

??? info "par exemple"

    - [https://www.frandroid.com/culture-tech/securite-applications/](https://www.zdnet.fr/actualites/le-projet-de-serveur-http-apache-corrige-une-vulnerabilite-zero-day-39930399.htm)
    - [https://www.frandroid.com/culture-tech/securite-applications/1155133_log4shell-la-faille-de-securite-decrite-comme-le-plus-grand-piratage-de-lhistoire-dinternet](https://www.zdnet.fr/actualites/le-projet-de-serveur-http-apache-corrige-une-vulnerabilite-zero-day-39930399.htm)

    

??? question "💊 Mesures préventives et curatives"

    ⚠️ Afin d'éviter des attaques, il est important de vérifier chacun de vos composants régulièrement.

    - Mettre à jour les composants sur votre serveur, si besoin


#### 🔐 Partie 2 - Config Apache

•	Allez dans le répertoire d'installation de votre serveur Apache local, celui que vous avez installé avec Xamp, Easyphp ou autres. Il se trouve dans un répertoire de nom apache, comme ceci : C:\Program Files (x86)\EasyPHP-12.1\apache
•	Placez-vous dans le répertoire bin et lancez une invite de commande puis tapez : apache –version
•	Vous connaitrez ainsi la version d'Apache qui fait tourner votre site, comparez le numéro de version avec la dernière qui se trouve sur le site officiel d'apache https://httpd.apache.org/download.cgi 
•	Vous pouvez consulter la rubrique "Security et official patches" pour vous donner un avant-goût des failles auxquelles vous êtes exposés avec une version inférieure. 

??? question "💊 Mesures préventives et curatives"

    Attention à vérifier champ statut dans Commande varchar(40)<br />

    0. Vérifier version apache et MySQL, MAJ si nécessaire
    1. Créer un user spécifique Base de Données [tuto](https://www.hostinger.com/fr/tutoriels/creer-un-utilisateur-mysql)
    2. Lui attribuer uniquement l'acces à la base bijoo
    2. Mettre à jour admin/config/bdd_config.inc
    3. Créer un .htacess pour le répertoire admin [tuto](https://www.keycdn.com/support/popular-htaccess-examples)

## 3. Configuration sécurisée d’un serveur web Apache

🎯 Objectifs pédagogiques
- Sécuriser un serveur Apache en masquant les informations sensibles.
- Désactiver les fonctionnalités à risque (indexation de répertoires, etc.).
- Ajouter des en-têtes de sécurité HTTP.
- Activer HTTPS via Let’s Encrypt (optionnel).

🖥️ Environnement requis
Machine virtuelle Debian/Ubuntu
Serveur Apache installé :

```prompt
sudo apt update && sudo apt install apache2
```
### 📚 Déroulement du TP

#### 🔍 Partie 1 – Vérification du serveur web

Lancer Apache si besoin :
```bash
sudo systemctl start apache2
```
Vérifier son état :
```bash
systemctl status apache2
```
Tester l’accès depuis le navigateur : Naviguer à http://[adresse IP] ou http://localhost

Tester la réponse HTTP avec curl :
```bash
curl -I http://localhost
```
> Observez les en-têtes, notamment le champ Server: (ex. Apache/2.4.57 (Ubuntu))

#### 🔐 Partie 2 – Masquer les informations du serveur

Éditer le fichier :
```bash
sudo nano /etc/apache2/conf-available/security.conf
```
Modifier ou ajouter :
```text
ServerTokens Prod
ServerSignature Off
```
Enregistrer, puis redémarrer Apache :
```bash
sudo systemctl restart apache2
```
Refaire un curl -I http://localhost pour vérifier :

⚠️ Le champ Server ne doit plus afficher la version ni l’OS.

#### 🧱 Partie 3 – Désactiver l’indexation de répertoires

🎯 Empêche un visiteur d’accéder à la liste des fichiers d’un dossier sans index.html.

Éditer la configuration principale :
```bash
sudo nano /etc/apache2/apache2.conf
```
Trouver la section :
```text
<Directory /var/www/>
    Options Indexes FollowSymLinks
```

Modifier en :
```text
Options -Indexes +FollowSymLinks
```
Redémarrer Apache :
```bash
sudo systemctl restart apache2
```
Créer un dossier de test :
```bash
sudo mkdir /var/www/html/test
sudo touch /var/www/html/test/fichier.txt
```
Naviguer dans le navigateur vers http://localhost/test/

⚠️ Vous devez obtenir une erreur 403 au lieu de la liste des fichiers.

#### 🛡️ Partie 4 – Ajouter des en-têtes de sécurité HTTP

Activer le module Apache headers :
```bash
sudo a2enmod headers
```

Éditer le fichier du site par défaut :
```bash
sudo nano /etc/apache2/sites-available/000-default.conf
```

Ajouter dans le bloc <VirtualHost *:80> :
```text
Header always set X-Content-Type-Options "nosniff"
Header always set X-Frame-Options "SAMEORIGIN"
Header always set X-XSS-Protection "1; mode=block"
```
Redémarrer Apache :
```bash
sudo systemctl restart apache2
```
Vérifier les en-têtes avec curl :
```bash
curl -I http://localhost
```

#### 🔒 Partie 5 – (Optionnel) Activer HTTPS avec Let's Encrypt

Installer Certbot :
```bash
sudo apt install certbot python3-certbot-apache
```
Exécuter la commande pour configurer automatiquement le certificat :
```bash
sudo certbot --apache
```
⚠️ Nécessite un nom de domaine et que le port 80/443 soit ouvert.
