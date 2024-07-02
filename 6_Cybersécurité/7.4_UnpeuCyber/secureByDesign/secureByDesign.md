# La Cyber en NSI

> "La cybersécurité est un domaine à part entière, il sera donc nécessaire de continuer d'en faire [note en : en BTS SIO], mais peut-être moins sur les aspects "attaquer" mais sur le **"security by design"**, la qualité du code, la gestion des frameworks... bref, la sécurité en amont plutôt qu'en aval. " David Roumanet, Lycée Louise Michel. Professeur BTS SIO.

!!! info "Définition"
    "Secure by Design" (ou "sécurité par conception" en français) est une approche de développement de systèmes informatiques et de logiciels qui intègre des principes de sécurité dès les premières étapes de la conception et tout au long du cycle de vie du produit. L'objectif est de minimiser les vulnérabilités et les risques de sécurité en adoptant des pratiques et des technologies de sécurité robustes dès le départ, plutôt que d'ajouter des mesures de sécurité après coup.

Quelques principes : <br />
- Limitation des droits et des accès des utilisateurs et des systèmes à ce qui est strictement nécessaire pour réduire les surfaces d'attaque potentielles.
- Mise en place de processus rigoureux de tests et de validations de la sécurité tout au long du cycle de vie du développement

et plus globalement, coder propre :<br />
- Vérification des types dans les paramètres de fonction
- Requêtes préparées uniquement ou utilisation d'un ORM
- Supprimer le code "mort" (exemple getter/setter non utilisé)
- Limiter les fonctions/méthodes à une seule tâche
- Documenter les fonctions, méthodes, classes et modules
- Utiliser des exceptions spécifiques plutôt que des exceptions générales
- Toujours nettoyer les ressources dans un bloc finally dans la gestion des exceptions
- Fermer les ressources au fur et à mesure (fichier par exemple)