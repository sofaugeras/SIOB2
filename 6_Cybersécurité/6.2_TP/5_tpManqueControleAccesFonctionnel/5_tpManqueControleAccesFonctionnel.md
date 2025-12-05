# TP Manque de contrôle d'accès au niveau fonctionnel 📘

!!! info "Définition (OWASP Top 10 – A07 :2021)"
    A07:2021 – Identification and Authentication Failures désigne l’ensemble des failles liées à l’identification et à la gestion de l’authentification, permettant à un attaquant de contourner ou de compromettre les mécanismes de connexion d’une application.

!!! info "🎯 Objectifs pédagogiques"

    * Identifier et exploiter des **failles d’autorisation insuffisante**
    * Démontrer l’impact d’un **manque de contrôle d’accès au niveau fonctionnel**
    * Comprendre les risques : IDOR, accès directs, escalade de privilèges
    * Proposer des **contre-mesures robustes**

## 1. 🔐 Accès direct aux pages d’administration

❓ Q1. Tenter d’accéder directement à des pages administrateur :

```
/admin/
/admin/gestion_produits.php
```

Décrire le comportement observé.

??? question "Solution Q1"
    Plusieurs pages d’administration s’ouvrent sans contrôle préalable.<br />
    L’application n’effectue pas de test de session ni de rôle.<br />
    C’est un exemple typique de **Broken Access Control – A07:2021**.

## 2. 📝 Modification de produits sans authentification

❓ Q2. Accéder à ``/admin/modif_produit.php?id=3`` et Tester :

* affichage du formulaire
* validation d’une modification
* impact en base

??? question "Solution Q2"
    Le formulaire est accessible sans authentification.<br />
    La modification est possible et appliquée.<br />
    Cela révèle un **contrôle d’accès absents sur les actions de gestion des produits**.



### 2.3 🛒 Consultation ou vol de commandes d’autres utilisateurs

❓Q3. Tester l’accès à ``/compte/commande.php?id=1`` Puis changer l’ID ``/compte/commande.php?id=2``

Comparer les résultats.

??? question "Solution Q3"
    L’application affiche les commandes d’autres utilisateurs.<br />
    Elle ne vérifie pas que l’ID de la commande correspond à l’utilisateur connecté.<br />
    C’est une **IDOR (Insecure Direct Object Reference)**.


### 2.4 🗑️ Suppression de produit via URL

❓Q4. Tester ``/admin/delete_produit.php?id=4`` Même sans être connecté.

??? question "Solution Qn°4"
    L’action fonctionne sans authentification.<br />
    La suppression se fait via une simple requête GET.<br />
    Double problème de sécurité :<br />

    - pas de contrôle d’accès
    - utilisation d’un GET pour une action destructive

### 2.5 📤 Exécution d’actions sensibles par paramètre

❓Q5. Identifier une fonctionnalité reposant sur un paramètre (ex : `?delete=true`, `?action=valid`), puis l’appeler directement par l’URL sans passer par le bouton.

??? question "Solution Qn°5"
    L’action s’exécute même sans vérifier que l’utilisateur est autorisé.<br />
    L’application associe naïvement une action à un paramètre GET.<br />
    Cela rend **toutes les actions sensibles exploitables via accès direct**.

### 2.6 🧑‍💼 Escalade de privilèges

❓Q6. Depuis un compte utilisateur simple :

* repérer une action réservée à l’administrateur
* copier l’URL
* la tester directement

??? question "Solution Q6"
    L’accès est autorisé même pour un utilisateur standard.<br />
    L’application ne vérifie pas le rôle dans les pages sensibles.<br />
    Cela permet une **montée en privilège**.


## 3. 🛡️ Partie corrective : bonnes pratiques

❓Q7. Citer trois contre-mesures essentielles permettant de corriger ce type de vulnérabilité.

??? question "Solution Q7"

    - Vérification systématique d’une session valide avant d’accéder à toute page sensible.
    - Vérification stricte du rôle (RBAC) pour chaque action.
    - Interdiction des actions critiques via GET ; utiliser POST + jeton CSRF.
