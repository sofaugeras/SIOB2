---
description: Le meilleur moyen de comprendre la sécurisation d’une application / site Internet, c’est de
---

# TP Sécurité

## 1.  🚧 

## 2. 🧪 Accès et découverte de DVWA

Lancer DVWA dans le navigateur à l’adresse : http://localhost/dvwa

S’authentifier avec les identifiants par défaut :

Login : admin
Password : password

Aller dans l’onglet **DVWA Security** et régler le niveau de sécurité sur ==Low==


## 3. 💍 Site bijoo

### 3.1	Installation du site web Bijoo

Vous allez prendre en main le site web Bijoo qui est la version 1 d'un site web de vente de bijoux.

![site bijoo](./data/bijoo1.png){: width=40% .center}
 
•	Pour cela, récupérez l'archive TP-breizhsecu.zip et dé-zippez-là. Placez le répertoire "breizhsecu" à la racine de votre serveur web à l'emplacement localhost, l'url d'appel du site sera donc la suivante : http://localhost/breizhsecu
•	Récupérez dans le répertoire "data" à la racine, le fichier bzh.sql pour l'importer dans la base de données de votre choix.
•	Modifier le fichier admin/config/bdd_config.inc pour connecter votre base de données MySQL

### 3.2	Découverte de l'application

Le site Bijoo comporte plusieurs catégories de produits :

-	Montres
-	Bagues
-	Colliers
-	Bracelets
-	Boucles d'oreilles

Il est possible de consulter les produits de chaque catégorie depuis les pages du même nom.

![site bijoo menu](./data/bijoo2.png){: width=40% .center}
 
Un visiteur du site peut déposer un avis sur un ou plusieurs produits, il peut également les placer dans son panier et les commander. 
Pour vous familiariser avec ce site, nous vous proposons le parcours suivant - prenez bien soin de regarder les URL d'appel de chaque page sur lesquelles vous vous retrouverez :

-	Allez dans la catégorie Montres et laissez un avis sur la montre HighWay sans être connecté.
-	Continuez ensuite votre visite et placez dans votre panier la bague Dragon (facilement reconnaissable grâce à son design rappelant facilement le dessin d'animation), ainsi que les boucles d'oreille Améthia.
-	Visualisez ensuite votre panier.
Vous pouvez constater qu'à ce stade, vous ne pouvez pas finaliser votre commande.
-	Créez alors un compte avec les login et mot de passe suivant :  test / test, puis connectez-vous et enfin validez votre panier pour "payer". La version de ce site ne prévoit pas le système de paiement mais cette version est suffisante pour explorer les points indispensables à étudier pour appréhender les enjeux de la sécurité des sites web.
-	Familiarisez-vous ensuite avec l'onglet "Mon compte" en visualisant vos informations personnelles, vos commandes et vos avis si vous en avez postés en étant identifié.
