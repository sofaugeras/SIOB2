# TP Exposition aux données sensibles

!!! info "Définition (OWASP Top 10 – A02 :2021)"
    **A02:2021 Cryptographic Failures**, qui englobe l’exposition des données sensibles, le mauvais chiffrement, les transferts non sécurisés et le stockage non protégé des données critiques.

# 1. Introduction 🧩

L’exposition de données sensibles correspond à toute situation où des informations confidentielles deviennent accessibles à un acteur non autorisé. Cette vulnérabilité fait partie de l’OWASP Top 10 et constitue un risque majeur pour les organisations.

🔐 **Exemples de données sensibles** :

- Mots de passe, tokens de session
- Données personnelles (nom, email, adresse, téléphone)
- Données financières (IBAN, carte bancaire)
- Données médicales
- Clés API, secrets d’application
- Fichiers de configuration contenant des identifiants

# 2. Pourquoi cette vulnérabilité survient-elle ? ⚠️

🔎 **Causes principales** :

- 📡 Données en clair lors de la transmission (HTTP, FTP, SMTP non sécurisé)
- 💾 Stockage non chiffré ou hachage faible (MD5, SHA1…)
- 🗂️ Exposition de fichiers sensibles (.env, .sql, .bak, logs)
- 🧩 Upload de fichiers non contrôlé, permettant d’exécuter du code
- 🛠️ Mauvaise configuration serveur (directory listing, absence de headers)
- 🧪 Messages d'erreur trop bavards
- 🔑 Gestion défaillante des clés et certificats

# 3. Impacts possibles 🎯

- Compromission de comptes
- Déchiffrement ou vol de données sensibles
- Escalade de privilèges
- Intrusion totale dans le système
- Sanctions réglementaires (RGPD)
- Perte de confiance, atteinte à l’image de l’organisation

# 4. Méthodologie d’analyse 🧭

📝 **Questions à se poser** :

- Les données circulent-elles en clair ? HTTP, SMTP, et FTP ...
- Les mots de passe sont-ils hachés avec un algorithme robuste ?
- Y a-t-il des fichiers sensibles accessibles ?
- Le serveur expose-t-il trop d’informations ?
- Les uploads sont-ils contrôlés ?
- Les réponses API contiennent-elles des informations inutiles ?
- Les certificats et clés sont-ils bien gérés ?

# 🛡️ 5. Bonnes pratiques

🔐 **Chiffrement**

- Utiliser HTTPS (TLS 1.2 minimum)
- Activer HSTS
- Désactiver les protocoles obsolètes
- Utiliser des certificats valides

🔑 **Mots de passe**

- Hachage via bcrypt, Argon2
- Jamais en clair, jamais en MD5/SHA1
- Utilisation d’un sel automatique
- Politique de robustesse

🗃️ **Stockage**

- Chiffrement des données sensibles
- Rotation des clés
- Coffre-fort (Vault, Keyring, AWS Secrets Manager…)

🔒 **Application**

- Interdire l’exécution des fichiers uploadés
- Valider strictement les extensions
- Ajouter les en-têtes HTTP :
- Content-Security-Policy
- X-Frame-Options: DENY
- X-Content-Type-Options: nosniff
- Referrer-Policy

##  6. Application📘

!!! note "🎯 Objectifs pédagogiques"

    * Comprendre les mécanismes d’exposition de données sensibles
    * Observer concrètement ce qu’un attaquant peut intercepter
    * Sécuriser une application web (HTTPS, hachage, filtrage d’upload)
    * Manipuler mkcert, password_hash, John The Ripper
    * Identifier et appliquer les bonnes pratiques

### 🔎 6.1. Analyse de l’exposition des données sensibles

Cette première partie vise à comprendre **comment** des données sensibles peuvent fuiter ou être récupérées par un attaquant.

#### 6.1.1 Analyse du trafic réseau 🔍 

1. Ouvrir Firefox → **Outils supplémentaires → Outils de développement → Réseau**
2. Naviguer sur le site bijoo
3. Tenter une connexion (login / mot de passe)
4. Observer les requêtes HTTP

!!! question "❓ Questions"
    === "Enoncé"

        * Q1 : Que voyez-vous dans les requêtes ? Les données sont-elles en clair ?
        * Q2 : Le site utilise-t-il HTTPS ? Comment le confirmer ?
        * Q3 : Quel est le risque si un attaquant est connecté au même Wi-Fi ?
    === "Réponse Q1"
        Oui.
        Sur un site en HTTP, les informations comme :

        - identifiant,
        - mot de passe,
        - cookie de session,

        transitent en clair dans la requête.
        Elles apparaissent dans l’onglet Réseau **sans aucune protection**.

        ![connexion](./data/tp3_1.png)
        ![header](./data/tp3_2.png)

        Un pirate se connectant à un réseau sans-fil en libre accès peut collecter les mêmes informations. Il peut récupérer le jeton de session et accède ainsi aux données, sauf si les données sont cryptées avec du SSL.

    === "Réponse Q2"
        Vérifications possibles :

        - la barre d’adresse comporte http:// et pas de cadenas,
        - Firefox affiche une mention « Connexion non sécurisée »,
        - dans l’onglet Sécurité, aucun certificat n’est chargé.

        **Conclusion** : non, le site n’utilise pas HTTPS.

    === "Réponse Q3"
        Un attaquant peut réaliser :

        - du sniffing (Wireshark, tcpdump),
        - du vol de session (session hijacking),
        - du vol de mot de passe,
        - de l’usurpation d'identité.

        Risque majeur : prise de contrôle du compte.

#### 6.1.2 Exploitation d’un upload non sécurisé 🗂️

1. Repérer un champ d’upload sur le site
2. Voir quel type de fichier est accepté
3. Essayer d’envoyer un fichier contenant :

```php
<?php echo "Exploit OK"; ?>
```

4. Tenter d’accéder au fichier via l’URL
5. Modifier le fichier pour afficher l’arborescence :

```php
<?php print_r(scandir(".")); ?>
```

6. Rechercher les fichiers sensibles (config, accès base, etc.)

??? question "éléments"
    === "Point 1"
        ![mon compte](./data/tp3_3.png)

### ❓ Questions

* Q4 : Le fichier s’exécute-t-il côté serveur ?
* Q5 : Quels fichiers intéressants pouvez-vous identifier ?
* Q6 : Quel risque représente l’exécution d’un fichier uploadé ?

??? question "Solutions"
    === "Q4"
        Oui, si l’upload n’est pas filtré et que le fichier est placé dans un répertoire accessible.<br />
        Un fichier .php appelé via l’URL est exécuté par Apache → Cela prouve une exécution de code à distance (RCE).

    === "Q5"
        Quels fichiers sensibles peut-on identifier ?<br />

        **Fichiers généralement trouvés :**

        - ``config.php``
        - ``connexion.php``
        - ``db.php``
        - backups ``.sql``
        - fichiers contenant des identifiants SQL
        - fichiers ``.env``

        **Ils peuvent contenir :**

        - login SQL
        - mot de passe SQL
        - nom de serveur
        - structure BDD

    === "Q6"
        **Risque maximal :**

        - exécution de commandes serveur
        - lecture / suppression / modification de fichiers
        - récupération complète de la base de données
        - pivot vers d’autres services
        - compromission totale du serveur (ROOT TAKEOVER)

        C’est l’une des failles les plus critiques.

#### 6.1.3 Extraction de fichiers sensibles 🧩 

1. Repérer les fichiers contenant des informations critiques

   * fichiers `.php` de configuration
   * fichiers contenant des identifiants SQL

2. Utiliser `highlight_file()` pour les afficher :

```php
<?php highlight_file('config.php'); ?>
```

3. Tenter d’afficher la BDD via un script PHP
4. Noter les informations obtenues

!!! tip "A faire"
    Modifier l'ensemble des scripts d'enregistrement et de connexion du site pour que les formulaires soient en POST.

### ❓ Questions

* Q7 : Quelles données sensibles avez-vous pu extraire ?
* Q8 : Quel serait l’impact d’une telle fuite ?

??? question "Solutions"
    === "Q7"
        Selon l'application, on peut souvent obtenir :

        - identifiants SQL (host / user / password)
        - nom de la base
        - configuration SMTP
        - chemins internes du serveur
        - contenu de tables sensibles (via script PHP)

        Ce type de fuite est **catastrophique**.

    === "Q8"

        - prise de contrôle de la base
        - vol massif de données personnelles
        - altération des données
        - injection de faux comptes / transactions
        - pertes financières
        - violation RGPD

###  6.2. Mise en place des mesures de protection 🛡️

Votre serveur web est accessible depuis l’adresse ``http://localhost`` ainsi, si votre ordinateur est accessible sur le port 80 dans votre navigateur, le site qui s’affiche considère votre ordinateur comme un serveur.  Votre serveur peut héberger plusieurs applications notamment le site Bijoo sur l'url http://localhost/breizhsecu <br />
Un **certificat SSL** sert à identifier un site unique, on passe la plupart du temps par un tiers de confiance auprès duquel on achète un certificat, ou on génère un certificat SSL pour son site que l'on installe sur le serveur. <br />
Nous allons profiter d'utiliser le protocole ``https`` en local pour pouvoir coder en local dans les conditions les plus proches de ce que vous devrez avoir en production.

####  6.2.1 Installation du HTTPS en local 🔐

Nous allons utiliser **mkcert** pour créer un certificat reconnu par votre navigateur.

Mkcert est un logiciel qui va nous permettre de créer un certificat personnel en respectant les étapes suivantes :

•	Télécharger et installer mkcert.
•	Produire un certificat pour notre site.
•	Activer le https sur notre apache local.
•	L'activer pour localhost.

Téléchargez **mkcert** depuis Github depuis l'adresse  https://github.com/FiloSottile/mkcert  et récupérez le contenu dans un répertoire mkcert.

Nous allons également installer **Certutil**, un utilitaire en ligne de commande qui va nous permettre de répertorier, générer, modifier ou supprimer des certificats. Il peut même être utilisé pour créer ou modifier le mot de passe, générer de nouvelles paires de clés publiques et privées.


🧪 **Étapes**

1. Installer mkcert
2. Exécuter :

```bash
mkcert -install
mkcert localhost
```

→ génère :

* `localhost.pem`
* `localhost-key.pem`

3. Activer SSL dans Apache (port 443) :

```bash
a2enmod ssl
```

4. Modifier `default-ssl.conf` pour y placer les chemins des certificats
5. Redémarrer Apache

❓ **Questions**

* Q9 : Pourquoi HTTPS ne protège-t-il pas des attaques côté serveur (upload, injections…) ?

??? question "Q9"
    HTTPS ne chiffre que le transport entre client et serveur.

    Il n’empêche pas :

    - les injections SQL,
    - l’upload malveillant,
    - l’accès à des fichiers sensibles,
    - les mauvaises configurations,
    - l’énumération de répertoires.

    HTTPS ≠ Sécurité applicative.<br />
    Il protège uniquement le transit, pas le serveur.

####  6.2.2 Hachage robuste des mots de passe 🔑

Les mots de passe **ne doivent jamais** être stockés en clair ou hachés via MD5/SHA1.

🧪 **Étape 1 : hachage sécurisé**

```php
$password = "monMotDePasse";
$hash = password_hash($password, PASSWORD_DEFAULT);
```

🧪 **Étape 2 : vérification**

```php
password_verify($passwordSaisi, $hash);
```

❓ **Questions**

* Q10 : Pourquoi le hachage produit-il toujours un résultat différent ?
* Q11 : Pourquoi MD5 n’est-il plus fiable aujourd’hui ?

??? question "Solutions"
    === "Q10"
        Parce que password_hash() génère :

        - un sel aléatoire (unique par hachage),
        - un paramètre de coût,
        - un formatage différent à chaque appel.

        Même mot de passe → hachage toujours différent → protection contre attaques par dictionnaire.

    === "Q11"

        - extrêmement rapide (bon pour les GPU)
        - vulnérable au brute-force massif
        - collisions connues
        - dictionnaires géants disponibles en ligne
        - peu résistant aux attaques modernes

        **Conclusion** : obsolète et dangereux.

#### 6.2.3 Test de robustesse avec John The Ripper (optionnel) ⚙️ 

Téléchargez l'application jTr sur https://www.openwall.com/john/

* Tester un fichier contenant des hachages MD5

```bash
john --show passwordfile
```

* Tester avec un dictionnaire (ex : rockyou)

```bash
john --wordlist=rockyou.txt passwordfile
```

### ❓ Questions

* Q12 : Que constatez-vous ?
* Q13 : Pourquoi les fonctions rapides sont-elles une mauvaise idée ?

??? question "Solutions"
    === "Q12"
        - craqué en quelques secondes
        - attaque par dictionnaire souvent suffisante
        - rapidité extrême des tests

        **Conclusion** : MD5 est instantanément cassable.

    === "Q13"
        Un hachage rapide = → un pirate peut tester des millions à milliards de combinaisons par seconde.<br />
        Les fonctions modernes (bcrypt, Argon2) sont lentes volontairement.

####  6.2.4 Sécurisation de l’upload 📁

🧪 **Actions à réaliser**

* Restreindre les extensions autorisées
* Générer des noms aléatoires
* Placer les fichiers **en dehors du répertoire public**
* Interdire l’exécution via la configuration serveur

❓ **Questions**

* Q14 : Pourquoi un simple fichier image peut-il être dangereux ?

??? question "Q14"

    Les attaques typiques :

    * fichier image.jpg.php → exécution PHP
    * fichier contenant un payload malveillant (polyglots)
    * malware déguisé en image
    * exploitation de failles dans les librairies d’images

    Même une image peut être un **vecteur d’exécution**.


#### 6.2.5 Renforcement des en-têtes HTTP 🛡️

À ajouter dans ``Apache`` :

```
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Content-Security-Policy: default-src 'self';
Referrer-Policy: strict-origin
```

### ❓ Questions

* Q15 : Quelle directive empêche le clickjacking ?

??? question "Q15"

    👉 X-Frame-Options: DENY <br />
    Il empêche le site d’être chargé dans un <iframe>, ce qui bloque les attaques de type clickjacking.

