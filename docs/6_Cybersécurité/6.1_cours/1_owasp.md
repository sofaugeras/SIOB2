# 1. Securité des applications (OWASP) 

!!! info "Sources"

    - [Cours SIO Valentin Brosseau ](https://cours.brosseau.ovh/)
    - [Cours SIO David Roumanet](https://nuage03.apps.education.fr/index.php/s/cLFoMwBEFce9wiH?path=%2FBloc%203%20(cybers%C3%A9curit%C3%A9))
    - [Réseau CERTA] Côté Cours "Exploitation d'une plateforme d’apprentissage des vulnérabilités
    des applications web" de 2018 de Patrice DIGNAN, avec la relecture, les tests et les suggestions de Pierre François

!!! tip "Compétences 🎯"

    B3.1 SLAM : Assurer la cybersécurité d’une solution applicative et de son développement
    > Participer à la vérification des éléments contribuant à la qualité d’un développement informatique
    > Analyser des incidents de sécurité, proposer et mettre en oeuvre des contre-mesures

    **Objectif pédagogique :** Comprendre les vulnérabilités critiques des applications web selon le classement OWASP Top 10, savoir les identifier et proposer des contre-mesures.

## 1. Introduction à l'OWASP

### 1.2 🛡️ Qu’est-ce que l’OWASP ?

![logo OWASP](./data/logoOWASP.png){: width=40% .center}

**OWASP** signifie **Open Web Application Security Project**. C'est une communauté travaillant sur la sécurité des
applications web. Elle a pour but de publier des recommandations de sécurisation des sites web et
propose des outils permettant de tester la sécurité des applications web.<br />

- Caractéristiques clés : Fondée en 2001.<br />
- Communauté ouverte : tout le monde peut participer (développeurs, pentesters, enseignants…).<br />
- Fournit des ressources libres et gratuites : outils, documentations, guides, logiciels, formations, etc.<br />
- Référence majeure dans le domaine de la cybersécurité des applications.

*🔎 Exemples de ressources OWASP :*

- OWASP Top 10
- OWASP ZAP (outil d’analyse de vulnérabilités)
- OWASP Juice Shop (application volontairement vulnérable à des fins pédagogiques)

Le [OWASP Top 10](https://owasp.org/www-project-top-ten/) est le classement des 10 principales vulnérabilités rencontrées dans les applications web, mis à jour tous les 3 à 4 ans.

![2017-2021](./data/mappinghistory.png){: width=60% .center}

## 2. Présentation du Top 10 OWASP (version 2021)

Voici les failles classées par l’OWASP 2021 (la dernière version en date) :

| Rang | Vulnérabilité                                  | Description rapide                                                              |
| ---- | ---------------------------------------------- | ------------------------------------------------------------------------------- |
| A01  | **Broken Access Control**                      | Accès non autorisé à des ressources ou fonctions                                |
| A02  | **Cryptographic Failures**                     | Mauvaise gestion des données sensibles (anciennement "Sensitive Data Exposure") |
| A03  | **Injection**                                  | Code injecté dans des champs (ex : SQL, NoSQL, LDAP, etc.)                      |
| A04  | **Insecure Design**                            | Défauts structurels dès la conception                                           |
| A05  | **Security Misconfiguration**                  | Mauvaises configurations ou défauts de sécurité                                 |
| A06  | **Vulnerable and Outdated Components**         | Dépendances obsolètes ou vulnérables                                            |
| A07  | **Identification and Authentication Failures** | Mauvaise gestion des sessions et des identifiants                               |
| A08  | **Software and Data Integrity Failures**       | Problèmes d'intégrité logicielle (ex : mises à jour non signées)                |
| A09  | **Security Logging and Monitoring Failures**   | Manque de journalisation ou d'alertes efficaces                                 |
| A10  | **Server-Side Request Forgery (SSRF)**         | Détournement de requêtes côté serveur                                           |
