# OWASP

L’Open Web Application Security (OWASP) est un organisme à but non lucratif mondial qui milite pour l’amélioration de la  écurité des logiciels. L’objectif est d’informer les individus ainsi que les entreprises sur les risques liés à la sécurité des systèmes d’information.

## les principales failles OWASP

Le [Top 10 de l’OWASP](https://owasp.org/Top10/) est un rapport régulièrement mis à jour qui expose les préoccupations en matière de sécurité des applications web, en se concentrant sur les 10 risques les plus critiques. Le rapport est élaboré par une équipe d’experts en sécurité du monde entier. L’OWASP qualifie le Top 10 de «document de sensibilisation » et recommande à toutes les entreprises d’intégrer le rapport dans leurs processus afin de minimiser et/ou d’atténuer les risques de sécurité

??? note "Top ten OWASP 2021"

    **A1 XSS (Cross Site Scripting)**

    Exécution de code malveillant dans le navigateur vol de session, défiguration, redirection vers une page similaire (phishing).

    **A2 Failles d’injection**

    Injection de données à un interpréteur de commandes/requêtes (SQL, …) altération de données, révélation d’informations, déni de service.

    **A3 Exécution de fichiers malicieux**

    Exécution de code malveillant sur le serveur (Remote File Inclusion, upload, …) intégrité, confidentialité, disponibilité, prise de contrôle du système.

    **A4 Référence directe non sécurisée à un objet**

    Manipulation de références à un objet (exemple : numéro de compte d’un client passé en paramètre à l’application, numéro de session entier incrémenté) rupture de confidentialité, vol de session.

    **A5 CSRF - Cross Site Request Forgery**

    Force un client authentifié à envoyer une requête à l’application web altération de données (exemple : post dans un forum).

    **A6 Fuite d’information et traitement d’erreur incorrect**

    Obtention d’informations de configuration, de données privées confidentialité (numéro CB, INSEE), aide à la détection de failles.

    **A7 Violation de gestion d’authentification de sessions**

    Obtention d’un accès à une application web avec authentification vol d’identité, rupture de confidentialité, perte d’intégrité.

    **A8 Stockage de données cryptographiques non sécurisé**

    Obtention de données sensibles non chiffrées, ou avec chiffrement faible (md5, sha-1, algorithmes maison) perte de confidentialité, vol d’identité.

    **A9 Communications non sécurisées**

    Interception du trafic réseau non chiffré (navigateur->serveur, web- >SGBD) perte de confidentialité (numéro CB, INSEE), vol d’identité.

    **A10 Défaillance dans la restriction des accès URL**

    Accès à une ressource dont l’URL est protégé par l’obscurité, rupture de confidentialité, perte d’intégrité.

### Injection SQL 
Les attaques par injection SQL se produisent lorsque des
données non fiables sont envoyées à un interpréteur de code par
le biais d’une saisie de formulaire ou d’une autre soumission de
données à une application web. Par exemple, un attaquant
pourrait entrer du code de base de données SQL dans un
formulaire qui attend un nom d’utilisateur en clair. Si la saisie de
ce formulaire n’est pas correctement sécurisée, le code SQL sera
exécuté. C’est ce qu’on appelle une attaque par injection SQL

^^Comment l'éviter ?^^

Les attaques par injection peuvent être évitées en validant et/ou
en assainissant les données soumises par les utilisateurs. (La
validation signifie le rejet des données suspectes, tandis que
l’assainissement consiste à nettoyer les parties suspectes des
données). En outre, un administrateur de base de données peut
définir des contrôles pour minimiser la quantité d’informations
qu’une attaque par injection peut exposer

### Authentification frauduleuse

Les vulnérabilités des systèmes d’authentification (login)
peuvent donner aux attaquants l’accès à des comptes
d’utilisateurs et même la possibilité de compromettre un système
entier en utilisant un compte d’administrateur. Par exemple, un
attaquant peut prendre une liste contenant des milliers de
combinaisons connues de noms d’utilisateur et de mots de passe
obtenues lors d’une violation de données et utiliser un script
pour essayer toutes ces combinaisons sur un système de
connexion afin de voir si certaines fonctionnent 

^^Comment l'éviter ?^^

Certaines stratégies visant à atténuer les vulnérabilités de
l’authentification consistent à exiger une authentification à deux
facteurs (2FA) ainsi qu’à limiter ou à retarder les tentatives de
connexion répétées en utilisant la limitation du débit.

### Exposition aux deonnées sensibles

Le risque d’exposition aux données peut être minimisé en
cryptant toutes les données sensibles et en désactivant la mise
en cache* de toute information sensible. En outre, les
développeurs d’applications web doivent veiller à ne pas stocker
inutilement des données sensibles

### Mauvaise configuration de la sécurité

La mauvaise configuration de la sécurité est la vulnérabilité la
plus courante de la liste, et est souvent le résultat de l’utilisation
de configurations par défaut ou de l’affichage d’erreurs
excessivement verbeuses. Par exemple, une application peut
présenter à l’utilisateur des erreurs trop descriptives qui peuvent
révéler des vulnérabilités dans l’application. Il est possible
d’atténuer ce problème en supprimant toutes les fonctionnalités
inutilisées dans le code et en veillant à ce que les messages
d’erreur soient plus généraux