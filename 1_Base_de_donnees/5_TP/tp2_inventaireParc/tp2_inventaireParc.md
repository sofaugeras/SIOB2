# 💻 TP – Gestion d’un parc informatique

!!! note "🎯 Objectif du TP"
	- Manipuler les principales instructions du langage SQL (LMD).  
    - Interroger et modifier les données d’une base 
    - Comprendre et utiliser les **jointures** entre plusieurs tables.

## 🧠 Contexte du TP

Le service informatique du **lycée TechPlus** gère un **inventaire du matériel informatique** installé dans les différentes salles du campus.

Chaque **poste** appartient à une **salle**, héberge un **système d’exploitation**, et est attribué à un **utilisateur** (enseignant, personnel administratif, étudiant, etc.).  
Le service suit également les **pannes** signalées sur les équipements afin d’assurer la maintenance.

---

## 1. Schéma de la base de données 🧩

![schéma de la base](./data/parcInfo.png){: .center width=100%}

**SALLE** (^^idsalle^^, nomSalle, capacite)<br />
clé primaire : ^^idsalle^^<br />
^^idSalle^^ : INT : Identifiant de la salle<br />
nomSalle : VARCHAR(30) : Nom de la salle (ex : B201, A104…) <br />
capacite : INT : Nombre de postes possibles 

**POSTE**(^^idPoste^^, nomPoste, systeme, dateAchat, #idsalle)<br />
clé primaire : ^^idPoste^^<br />
^^idPoste^^ : INT : Identifiant du poste <br />
nomPoste : VARCHAR(30) : Nom du poste (ex : PC-B201-01) <br />
systeme : VARCHAR(20) : Système d’exploitation (Windows 10, Linux Debian…) <br />
dateAchat : DATE : Date d’achat du poste <br />
idSalle : INT : Référence à la salle où se trouve le poste<br />
clé étrangère : #idSalle : en référence à idSalle de Salle <br />

**UTILISATEUR**(^^idUtilisateur^^, nom, prenom, fonction)<br />
clé primaire : ^^idUtilisateur^^<br />
^^idUtilisateur^^ : INT : Identifiant de l’utilisateur<br />
nom : VARCHAR(30) : Nom de l’utilisateur <br />
prenom : VARCHAR(30) : Prénom <br />
fonction : VARCHAR(30) : Rôle dans l’établissement (Enseignant, Étudiant, Technicien, etc.) 

**AFFECTATION**(^^#idPoste,#idUtilisateur^^, dateAffectation)<br />
clé primaire : ^^#idPoste^^, ^^#idUtilisateur^^<br />
^^#idPoste^^ : INT : Référence au poste <br />
^^#idUtilisateur^^ : INT : Référence à l’utilisateur <br />
dateAffectation : DATE : Date d’affectation du poste à l’utilisateur <br />
dateFin : DATE : Date de fin d'affectation à l'utilisateur <br />
clé étrangère : #idPoste : en référence à idPoste de POSTE<br />
clé étrangère : #idUtilisateur : en référence à idUtilisateur de UTILISATEUR

**INCIDENT**(^^idIncident^^, idPoste, dateIncident, description, statut)<br />
clé primaire : ^^idIncident^^<br />
^^idIncident^^ : INT : Identifiant de l’incident (PK) <br />
idPoste : INT : Poste concerné (FK en référence à idPoste de Poste) <br />
dateIncident : DATE : Date de la panne <br />
description : VARCHAR(100) | Description du problème <br />
statut : VARCHAR(20) : Statut du ticket (ouvert, en cours, résolu) <br />
clé étrangère : #idPoste : en référence à idPoste de POSTE

[Télécharger fichier Création de la base :arrow_down:](./data/inventaire.sql){ .md-button .md-button--primary }

??? info "💾 Jeu de Données"

    ```sql
    INSERT INTO Salle VALUES (1, 'B201', 15);
    INSERT INTO Salle VALUES (2, 'A104', 20);

    INSERT INTO Poste VALUES (1, 'PC-B201-01', 'Windows 10', '2023-01-10', 1);
    INSERT INTO Poste VALUES (2, 'PC-B201-02', 'Linux Debian', '2022-05-12', 1);
    INSERT INTO Poste VALUES (3, 'PC-A104-01', 'Windows 11', '2024-03-15', 2);

    INSERT INTO Utilisateur VALUES (1, 'Martin', 'Sophie', 'Enseignant');
    INSERT INTO Utilisateur VALUES (2, 'Durand', 'Lucas', 'Technicien');
    INSERT INTO Utilisateur VALUES (3, 'Lemoine', 'Camille', 'Étudiant');

    INSERT INTO Affectation VALUES (1, 1, '2024-09-01', '2025-09-01');
    INSERT INTO Affectation VALUES (2, 3, '2025-01-10');

    INSERT INTO Incident VALUES (1, 1, '2025-02-12', 'Écran noir au démarrage', 'Résolu');
    INSERT INTO Incident VALUES (2, 2, '2025-04-05', 'Problème de réseau', 'En cours');
    INSERT INTO Incident VALUES (3,2, '2025-06-20', 'Blue screen', 'En cours')
    ```

## 2. Requêtes sur une seule table 🧩

!!! question "Q1"
    === "Enoncé"
        Lister toutes les salles avec leur capacité.

    === "Correction"

        ```sql
        SELECT nomSalle, capacite 
        FROM salle; 
        ```

!!! question "Q2"
    === "Enoncé"
        Afficher les postes sous Windows.

    === "Correction"

        ```sql
        SELECT *
        FROM poste
        WHERE systeme LIKE "Windows%";
        ```
!!! question "Q3"
    === "Enoncé"
        Afficher les postes achetés avant 2023.

    === "Correction"

        ```sql
        SELECT *
        FROM poste
        WHERE dateAchat < '2023-01-01' ;
        /* ou */
        SELECT *
        FROM poste
        WHERE YEAR(dateAchat) < 2023 ;
        ```

!!! question "Q4"
    === "Enoncé"
        Afficher les utilisateurs dont la fonction est “Technicien”.

    === "Correction"

        ```sql
        SELECT *
        FROM utilisateur
        WHERE fonction="Technicien"
        ```

!!! question "Q5_1"
    === "Enoncé"
        Insérer un nouvel incident toujours **en Cours** ayant eu lieu le 20 juin 2025 sur le poste 5 avec comme symptôme un blue screen.

    === "Correction"

        ```sql
        INSERT INTO Incident VALUES (6,2, '2025-06-20', 'Blue screen', 'En cours')
        ```

!!! question "Q5_2"
    === "Enoncé"
        Afficher la date et la description des incidents ayant le statut “En cours” classé par ordre decroissant (du plus récent au plus ancien).

    === "Correction"

        ```sql
        SELECT dateIncident, description
        FROM incident
        WHERE statut="En cours"
        ORDER by dateIncident DESC ;
        ```

!!! question "Q6"
    === "Enoncé"
        Afficher le nombre total de postes.

    === "Correction"

        ```sql
        SELECT COUNT(*) AS nbTotalPoste
        FROM poste
        ```

!!! question "Q7"
    === "Enoncé"
        Afficher le nombre d’incidents par statut.

    === "Correction"

        ```sql
        SELECT statut, COUNT(*) AS nbIncident
        FROM incident
        GROUP BY statut ;
        ```
!!! question "Q8"
    === "Enconcé"
        Le poste 'PC-B201-02' a été passé sous Linux Mint. Mettez à jour la donnée dans la base.

    === "Correction"

        ```sql
        UPDATE poste
        SET systeme = "Linux Mint"
        WHERE nomPoste = "PC-B201-02" ;
        ```

## 3. Requêtes avec jointures 🔗

!!! question "Q9"
    === "Enoncé"
        Lister les postes avec le nom de leur salle.

    === "Correction"

        ```sql
        SELECT POSTE.nomPoste, SALLE.nomSalle
        FROM POSTE INNER JOIN SALLE
        ON POSTE.idSalle = SALLE.idSalle
        ```

!!! question "Q10"
    === "Enoncé"
        Lister les postes et le nom de l’utilisateur affecté à l'instant de la requête.

    === "Correction"

        ```sql
        SELECT p.nomPoste, u.nom, max(a.idPoste)
        FROM POSTE p INNER JOIN AFFECTATION a
        ON p.idPoste = a.idPoste
        INNER JOIN UTILISATEUR u
        ON a.idUtilisateur=u.idUtilisateur
        WHERE dateFin IS NULL ;
        ```
!!! question "Q11"
    === "Enoncé"
        Afficher pour chaque incident, le nom du poste et le nom de la salle concernée.

    === "Correction"

        ```sql
        SELECT i.idIncident, p.nomPoste, s.idSalle
        FROM POSTE p INNER JOIN INCIDENT i 
        ON p.idPoste = i.idPoste
        INNER JOIN SALLE s
        on p.idSalle = s.idSalle ;
        ```

!!! question "Q12"
    === "Enoncé"
        Afficher les utilisateurs qui ont **actuellement** un poste affecté sous Linux.

    === "Correction"

        ```sql
        SELECT nom, prenom
        FROM UTILISATEUR u INNER JOIN AFFECTATION a
        ON u.idUtilisateur = a.idUtilisateur
        INNER JOIN POSTE p
        ON a.idPoste = p.idPoste
        WHERE P.systeme LIKE "Linux%"
        AND a.dateFin IS NULL ;
        ```

!!! question "Q13"
    === "Enoncé"
        Afficher les postes sans incident.

    === "Correction"

        difficile non ???<br />
        La seule chose que l'on sait est que si un poste à un incident, alors il est présent dans la table INCIDENT

        ```sql
        SELECT nomPoste	
        FROM POSTE p INNER JOIN INCIDENT i 
        ON p.idPoste = i.idPoste ;
        ```
        et on sait gérer avec NOT IN quand qqch n'appartient par à une liste.

        ```sql
        SELECT nomPoste	
        FROM POSTE 
        WHERE nomPoste NOT IN ('PC-B201-01', 'PC-B201-02', 'PC-A104-01', 'PC-A104-02','PC-C312-01')
        ```
        Note : on obtient deux postes : PC-D010-01 et PC-D010-02

        et si on assemblait les deux requêtes ...

        ```sql
        SELECT nomPoste	
        FROM POSTE 
        WHERE nomPoste NOT IN (SELECT nomPoste	
        FROM POSTE p INNER JOIN INCIDENT i 
        ON p.idPoste = i.idPoste )
        ```
        Bravo, vous venez de faire votre première requête imbriquée !

!!! question "Q14"
    === "Enoncé"
        Afficher pour chaque salle le nombre de postes.

    === "Correction"

        ```sql
        SELECT nomSalle, COUNT( DISTINCT p.idPoste)
        FROM POSTE p INNER JOIN SALLE s
        ON p.idSalle = s.idSalle
        GROUP BY nomSalle
        ```
!!! question "Q15"
    === "Enoncé"
        Afficher pour chaque utilisateur, la date de début d'affectation, la date de fin d'affectation et le nom du poste.

    === "Correction"

        ```sql
        SELECT u.nom, u.prenom, p.nomPoste, a.dateAffectation, a.dateFin
        FROM AFFECTATION a INNER JOIN UTILISATEUR u 
            ON u.idUtilisateur = a.idUtilisateur
        INNER JOIN POSTE p       
            ON p.idPoste = a.idPoste
        ORDER BY u.nom, u.prenom, a.dateAffectation;
        ```

!!! question "Q16"
    === "Enoncé"
        Supprimer les incidents “résolus” antérieurs à 2024.

    === "Correction"

        ```sql
        DELETE FROM Incident
        WHERE statut = 'Résolu'
        AND dateIncident < '2024-01-01';

        ```
