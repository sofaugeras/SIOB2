# Recommandations de l'ANSII 

!!! info "Compétences"

    Activité 1.1. Gestion du patrimoine informatique :

    - Exploitation des référentiels, normes et standards adoptés par le prestataire informatique
    - Vérification du respect des règles d’utilisation des ressources numériques

[lien vers le document](./data/guide_hygiene_informatique_anssi.pdf)

Le guide vous présente les 42 mesures d’hygiène informatique essentielles pour assurer la sécurité de votre système d’information et les moyens de les mettre en œuvre, outils pratiques à l’appui.


## 1. 🧼 Synthèse du guide d’hygiène informatique (ANSSI)

**Titre officiel :** *Renforcer la sécurité de son système d’information en 42 mesures*<br />
**Public visé :** organisations publiques et privées, DSI, prestataires informatiques.<br />
**Objectif :** réduire significativement les risques d’attaques en appliquant des mesures simples et concrètes.<br />
**Date :** V2 - 2017

### 1.1 Sensibiliser et former

* Former les équipes techniques (admins, devs, RSSI) aux bonnes pratiques de sécurité.
* Sensibiliser **tous les utilisateurs** aux règles de base (mots de passe, vigilance mails, verrouillage de session).
* Mettre en place une **charte informatique** claire.
* Maîtriser les risques liés à l’externalisation (infogérance, cloud).

### 1.2 Connaître son système d’information

* Identifier les **données sensibles** et les serveurs critiques.
* Maintenir une **cartographie réseau** à jour.
* Tenir un inventaire des **comptes privilégiés** (admin, service).
* Gérer les arrivées/départs des utilisateurs (création/suppression de comptes, restitution du matériel).
* N’autoriser que les **équipements maîtrisés** à se connecter (pas de BYOD sauvage).

### 1.3 Authentifier et contrôler les accès

* Utiliser des **comptes nominatifs**, pas de comptes génériques partagés.
* Définir et contrôler les **droits d’accès** aux ressources sensibles.
* Imposer des **mots de passe robustes** (longueur, complexité, non-réutilisation).
* Protéger les mots de passe stockés (coffre-fort numérique).
* Modifier les **mots de passe par défaut** des équipements.
* Favoriser l’**authentification forte** (MFA : mot de passe + carte, token, biométrie).

### 1.4 Sécuriser les postes de travail

* Configurer un **socle minimal de sécurité** (antivirus, pare-feu, chiffrement, blocage d’auto-run).
* Gérer l’usage des **supports amovibles** (USB).
* Utiliser une **gestion centralisée** des politiques de sécurité (ex. Active Directory).
* Activer le **pare-feu local** sur tous les postes.
* Chiffrer les données sensibles transmises par Internet.

### 1.5 Sécuriser le réseau

* Segmenter le réseau (VLAN, pare-feu, cloisonnement).
* Sécuriser le Wi-Fi (WPA2/3, SSID distincts pour invités).
* Utiliser des **protocoles sécurisés** (HTTPS, SSH, SMTPS…).
* Passer par une **passerelle sécurisée** (pare-feu + proxy) pour l’accès Internet.
* Cloisonner les services exposés à Internet (DMZ).
* Protéger la messagerie professionnelle (anti-spam, TLS, SPF/DKIM/DMARC).
* Sécuriser les interconnexions avec les partenaires (VPN, filtrage IP).
* Contrôler l’accès physique aux salles serveurs et prises réseau.

### 1.6 Sécuriser l’administration

* Interdire l’accès Internet aux postes d’administration.
* Dédier un réseau spécifique pour l’administration (physique ou IPsec).
* Limiter strictement les droits d’administration aux seuls besoins.

### 1.7 Gérer le nomadisme

* Sécuriser physiquement les terminaux nomades (PC portables, smartphones).
* Chiffrer les données stockées sur supports nomades (disques, clés USB).
* Sécuriser la connexion des nomades (VPN IPsec obligatoire).
* Appliquer des politiques dédiées aux terminaux mobiles (MDM, restriction applis).

### 1.8 Maintenir le système à jour

* Définir une **politique de mises à jour** (délai max : 1 mois après correctif).
* Suivre la fin de vie des logiciels/systèmes (obsolescence).

### 1.9 Superviser, auditer, réagir

* Activer et conserver les **journaux d’événements** (SIEM possible).
* Définir une **politique de sauvegardes** (tests réguliers de restauration).
* Procéder à des **audits de sécurité** réguliers et appliquer les correctifs.

!!! warning "Compléments"
    L’ANSSI propose des [**référentiels complémentaires**](https://cyber.gouv.fr/guides-essentiels-et-bonnes-pratiques-de-cybersecurite-par-ou-commencer) (guides techniques, PAS, recommandations pour Active Directory, Wi-Fi, etc.).

## 2. ✅ En résumé

Le guide ANSSI est une **checklist opérationnelle** en 42 points couvrant :

1. **Organisation et sensibilisation**.
2. **Gestion des accès et des comptes**.
3. **Sécurisation des postes et réseaux**.
4. **Administration et nomadisme**.
5. **Mises à jour, sauvegardes et supervision**.

➡️ Si toutes les mesures étaient appliquées, **la majorité des cyberattaques seraient évitées**. La couverture à 100% du risque Cyber est impossible, dans un cout/moyens/temps contraints.

| Domaine ANSSI | Mesure clé(exemples)                                                                                                           | Compétence BTS liée                                                        | 
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | 
| **Sensibilisation & référentiels**   | Charte informatique (M2), Formation des utilisateurs (M1)                                                                       | Exploitation des référentiels et standards (charte, PAS, ISO 27001)        | 
| **Gestion des accès**                | Comptes nominatifs (M8), Gestion des arrivées/départs (M6), Inventaire des comptes privilégiés (M5)                             | Vérification du respect des règles d’utilisation des ressources numériques | 
| **Mots de passe & authentification** | Politique de mots de passe robustes (M10), Protection des mots de passe stockés (M11), MFA (M13)                                | Vérification des règles d’utilisation                                      | 
| **Postes de travail**                | Pare-feu et antivirus (M14, M17), Supports amovibles sécurisés (M15), Chiffrement des données (M18)                             | Vérification des règles d’utilisation                                      | 
| **Réseau**                           | Segmentation réseau (M19), Wi-Fi sécurisé (M20), Protocoles sécurisés (M21), Passerelle Internet (M22), Cloisonnement DMZ (M23) | Exploitation des standards (ANSSI, bonnes pratiques réseau)                | 
| **Messagerie**                       | Protection contre phishing et spam (M24), SPF/DKIM/DMARC                                                                        | Vérification de l’usage correct des ressources                             |
| **Administration**                   | Postes d’admin sans Internet (M27), Réseau dédié admin (M28), Limiter privilèges admin (M29)                                    | Exploitation des référentiels                                              | 
| **Nomadisme**                        | Sécurisation des PC portables et smartphones (M30–M33), VPN obligatoire                                                         | Vérification des règles d’utilisation                                      | 
| **Mises à jour**                     | Politique de patch management (M34), Anticipation obsolescence (M35)                                                            | Exploitation des référentiels (politique de mise à jour)                   | 
| **Supervision & sauvegardes**        | Journaux d’événements (M36), Sauvegardes testées (M37), Audits réguliers (M38)                                                  | Exploitation des référentiels + Vérification                               | 

## 3. 🎲 Applications

Pour chaque situation proposée, donner la réponse à la question posée pour réduire le risque Cyber ?

| Situation proposée                                                                              | Question posée à l’élève                                          |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| Un nouvel employé arrive et n’a reçu aucune information sur la sécurité ni charte informatique. | Que faudrait-il mettre en place pour qu’il connaisse les règles ? |
| Une PME externalise son SI à un prestataire sans clauses particulières.                         | Quels risques ? Quelles exigences doivent être précisées ?        |
| L’entreprise n’a pas de cartographie réseau ni d’inventaire des comptes admin.                  | Quelles actions mettre en place ?                                 |
| Un utilisateur part sans que ses comptes et accès soient supprimés.                             | Quels risques ? Que faire ?                                       |
| Des employés connectent leurs PC personnels au réseau de l’entreprise.                          | Est-ce acceptable ? Que faudrait-il faire ?                       |
| Tous les admins utilisent le compte « admin » générique.                                        | Pourquoi est-ce dangereux ? Quelle solution ?                     |
| Un utilisateur utilise « azerty123 » sur tous ses comptes, y compris pro et perso.              | Pourquoi est-ce un problème ? Quelles règles appliquer ?          |
| Un salarié branche une clé USB trouvée dans le parking.                                         | Quels risques ? Quelle bonne pratique ?                           |
| Certains postes n’ont pas d’antivirus ni de pare-feu activés.                                   | Est-ce conforme ? Que faire ?                                     |
| Le réseau de l’entreprise est « à plat » : tous les postes peuvent accéder à tous les serveurs. | Quels risques ? Quelle solution ?                                 |
| Le Wi-Fi pro utilise un mot de passe simple partagé par tous.                                   | Quels risques ? Comment sécuriser ?                               |
| Un salarié reçoit un mail suspect d’un faux dirigeant demandant un virement.                    | Que doit-il faire ?                                               |
| Un administrateur utilise son poste bureautique habituel pour gérer les serveurs.               | Est-ce conforme ? Quelles mesures appliquer ?                     |
| Un commercial stocke des fichiers sensibles non chiffrés sur son PC portable.                   | Quels risques ? Que faire ?                                       |
| Plusieurs serveurs tournent sur Windows Server 2008 (obsolète).                                 | Quels risques ? Quelles actions ?                                 |
| Une PME a des sauvegardes mais n’a jamais testé leur restauration.                              | Est-ce suffisant ? Quelles bonnes pratiques ?                     |
| L’entreprise n’a jamais fait d’audit de sécurité.                                               | Est-ce problématique ? Pourquoi ?                                 |


??? tip "Correction"

    | Situation proposée                                                                              | Question posée à l’élève                                          | Préconisations attendues (ANSSI)                                                                          | Commentaire enseignant                                                                                                   |
    | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
    | Un nouvel employé arrive et n’a reçu aucune information sur la sécurité ni charte informatique. | Que faudrait-il mettre en place pour qu’il connaisse les règles ? | Sensibilisation dès l’arrivée, formation régulière, charte informatique.                                  | Les utilisateurs sont le **premier maillon de la sécurité** : une charte + sensibilisation évitent beaucoup d’incidents. |
    | Une PME externalise son SI à un prestataire sans clauses particulières.                         | Quels risques ? Quelles exigences doivent être précisées ?        | Exiger un Plan d’assurance sécurité, clauses de réversibilité, sauvegardes, audits réguliers.             | Externaliser ≠ déléguer la responsabilité : l’entreprise reste responsable de sa sécurité.                               |
    | L’entreprise n’a pas de cartographie réseau ni d’inventaire des comptes admin.                  | Quelles actions mettre en place ?                                 | Maintenir une cartographie réseau, identifier les serveurs critiques, inventaire des comptes privilégiés. | Sans inventaire, impossible de savoir ce qui doit être protégé en priorité.                                              |
    | Un utilisateur part sans que ses comptes et accès soient supprimés.                             | Quels risques ? Que faire ?                                       | Procédure d’arrivée/départ formalisée, suppression immédiate des comptes, restitution matériels/badges.   | Risque classique : **compte orphelin** exploité par un attaquant.                                                        |
    | Des employés connectent leurs PC personnels au réseau de l’entreprise.                          | Est-ce acceptable ? Que faudrait-il faire ?                       | N’autoriser que les équipements maîtrisés, Wi-Fi invité séparé.                                           | BYOD non contrôlé = risque de malware et de perte de données.                                                            |
    | Tous les admins utilisent le compte « admin » générique.                                        | Pourquoi est-ce dangereux ? Quelle solution ?                     | Comptes nominatifs, séparation user/admin, suivi des connexions.                                          | Le compte « admin » partagé empêche toute traçabilité.                                                                   |
    | Un utilisateur utilise « azerty123 » sur tous ses comptes, y compris pro et perso.              | Pourquoi est-ce un problème ? Quelles règles appliquer ?          | Politique de robustesse, non-réutilisation, audit de mots de passe.                                       | Faiblesse classique : réutilisation entre sphère perso et pro.                                                           |
    | Un salarié branche une clé USB trouvée dans le parking.                                         | Quels risques ? Quelle bonne pratique ?                           | Interdire clés USB inconnues, antivirus obligatoire, restrictions logicielles.                            | Les attaques par **clé USB piégée** sont courantes (ex. Stuxnet).                                                        |
    | Certains postes n’ont pas d’antivirus ni de pare-feu activés.                                   | Est-ce conforme ? Que faire ?                                     | Antivirus et pare-feu activés, chiffrement, blocage autorun.                                              | Le poste utilisateur est souvent **la première cible d’attaque**.                                                        |
    | Le réseau de l’entreprise est « à plat » : tous les postes peuvent accéder à tous les serveurs. | Quels risques ? Quelle solution ?                                 | Segmenter le réseau (VLAN, DMZ), cloisonner admin/bureautique.                                            | Un réseau « à plat » = un seul poste compromis met tout en danger.                                                       |
    | Le Wi-Fi pro utilise un mot de passe simple partagé par tous.                                   | Quels risques ? Comment sécuriser ?                               | WPA2/3, certificats clients, séparation invités/pro, mot de passe complexe.                               | Le Wi-Fi est une **porte d’entrée externe** : il doit être cloisonné.                                                    |
    | Un salarié reçoit un mail suspect d’un faux dirigeant demandant un virement.                    | Que doit-il faire ?                                               | Vérifier l’expéditeur, appliquer procédure anti-fraude (double validation), SPF/DKIM/DMARC.               | 80 % des cyberattaques passent par la messagerie.                                                                        |
    | Un administrateur utilise son poste bureautique habituel pour gérer les serveurs.               | Est-ce conforme ? Quelles mesures appliquer ?                     | Poste admin dédié sans Internet, réseau d’admin séparé, droits minimisés.                                 | Séparer clairement usage bureautique et usage admin.                                                                     |
    | Un commercial stocke des fichiers sensibles non chiffrés sur son PC portable.                   | Quels risques ? Que faire ?                                       | Chiffrement complet du disque, VPN IPsec obligatoire, MDM pour mobiles.                                   | Les portables sont **faciles à voler** → protection des données critique.                                                |
    | Plusieurs serveurs tournent sur Windows Server 2008 (obsolète).                                 | Quels risques ? Quelles actions ?                                 | Politique de patch management, migration avant fin de support, suivi CERT-FR.                             | Les systèmes obsolètes sont des **failles ouvertes** (ex. WannaCry).                                                     |
    | Une PME a des sauvegardes mais n’a jamais testé leur restauration.                              | Est-ce suffisant ? Quelles bonnes pratiques ?                     | Politique de sauvegarde claire, tests réguliers de restauration, sauvegardes hors ligne.                  | Une sauvegarde jamais testée = **sauvegarde inutile**. Doit être associé à un PRA impérativement.         |
    | L’entreprise n’a jamais fait d’audit de sécurité.                                               | Est-ce problématique ? Pourquoi ?                                 | Audits réguliers (au moins annuels), actions correctives planifiées.                                      | Vérifier la conformité permet de **corriger avant qu’un attaquant n’exploite**.                                          |
