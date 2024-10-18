# TD Gestion d’un Hôpital

!!! note "Objectif du TP"

	- Savoir créer une vue. 
    - Utiliser une vue, en regroupement d’informations
    - Révision sur les dates

![hopital](./data/hopital.png){: width=30% .center}

**Contexte :** Vous travaillez pour un hôpital qui souhaite mieux gérer ses patients, ses médecins, et les traitements administrés. La base de données de l’hôpital contient les tables suivantes :

- Patients : Informations sur les patients.
- Medecins : Informations sur les médecins.
- Consultations : Enregistrements des consultations des patients par les médecins.
- Traitements : Enregistrements des traitements administrés aux patients.

^^schéma relationnel :^^
**PATIENT**(^^patient_id^^, nom, prenom, date_naissance, adresse)<br />
**MEDECIN** (^^medecin_id^^, nom, prenom, specialite)<br />
**CONSULTATION**(^^consultation_id^^, #patient_id, #medecin_id, date_consultation, diagnostic)<br />
**TRAITEMENT**(^^traitement_id^^, #consultation_id, description, cout, date_traitement)


??? note "Script de création de base"

    ```SQL
    CREATE TABLE Patients (
        patient_id INT PRIMARY KEY,
        nom VARCHAR(255),
        prenom VARCHAR(255),
        date_naissance DATE,
        adresse VARCHAR(255)
    );

    CREATE TABLE Medecins (
        medecin_id INT PRIMARY KEY,
        nom VARCHAR(255),
        prenom VARCHAR(255),
        specialite VARCHAR(100)
    );

    CREATE TABLE Consultations (
        consultation_id INT PRIMARY KEY,
        patient_id INT,
        medecin_id INT,
        date_consultation DATE,
        diagnostic VARCHAR(255),
        FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
        FOREIGN KEY (medecin_id) REFERENCES Medecins(medecin_id)
    );

    CREATE TABLE Traitements (
        traitement_id INT PRIMARY KEY,
        consultation_id INT,
        description VARCHAR(255),
        cout DECIMAL(10, 2),
        date_traitement DATE,
        FOREIGN KEY (consultation_id) REFERENCES Consultations(consultation_id)
    );
    ```

## 1. Création des vues

:question: 1. Créer une vue pour afficher les informations détaillées des consultations, y compris les informations sur les patients et les médecins.

??? question "Correction"

    ```SQL
    CREATE VIEW ConsultationsDetaillees AS
    SELECT c.consultation_id, p.nom AS patient_nom, p.prenom AS patient_prenom, m.nom AS medecin_nom, m.prenom AS medecin_prenom, m.specialite, c.date_consultation, c.diagnostic
    FROM Consultations c
    JOIN Patients p ON c.patient_id = p.patient_id
    JOIN Medecins m ON c.medecin_id = m.medecin_id;
    ```

:question: 2. Créer une vue pour afficher les coûts totaux des traitements par patient.

??? question "Correction"

    ```SQL
    CREATE VIEW CoutTotalParPatient AS
    SELECT p.nom, p.prenom, SUM(t.cout) AS total_cout
    FROM Patients p
    JOIN Consultations c ON p.patient_id = c.patient_id
    JOIN Traitements t ON c.consultation_id = t.consultation_id
    GROUP BY p.nom, p.prenom;
    ```

## 2. Utilisation des vues
:question: 3. Quelles sont les consultations en cours (traitements non terminés) ?

??? question "Correction"

    ```SQL
    SELECT * FROM ConsultationsDetaillees
    WHERE consultation_id IN (SELECT consultation_id FROM Traitements WHERE date_traitement IS NULL);
    ```

:question: 4. Quels patients ont les coûts de traitement les plus élevés ?

??? question "Correction"

    ```SQL
    SELECT * FROM CoutTotalParPatient
    ORDER BY total_cout DESC;
    ```

:question: 5. Quels médecins ont le plus de consultations ?

??? question "Correction"

    ```SQL
    SELECT m.nom, m.prenom, COUNT(c.consultation_id) AS nombre_consultations
    FROM Medecins m
    JOIN Consultations c ON m.medecin_id = c.medecin_id
    GROUP BY m.nom, m.prenom
    ORDER BY nombre_consultations DESC;
    ```

## 3. Questions de réflexion

:question: 6. Quels sont les avantages d’utiliser des vues pour ces types de requêtes ?

??? question "correction"
    
    - Simplification des requêtes : Les vues permettent de simplifier des requêtes complexes en encapsulant la logique dans une vue. Cela rend les requêtes plus lisibles et plus faciles à maintenir.
    - Sécurité : Les vues peuvent restreindre l’accès aux données sensibles en exposant uniquement certaines colonnes ou lignes. Par exemple, une vue peut masquer des informations personnelles des patients tout en permettant l’accès aux données nécessaires pour les analyses.
    - Réutilisabilité : Une fois définie, une vue peut être réutilisée dans d’autres requêtes sans avoir à réécrire la logique. Cela permet de standardiser les accès aux données et de réduire les erreurs.
    - Abstraction : Les vues fournissent une couche d’abstraction qui peut masquer la complexité des tables sous-jacentes. Cela permet aux utilisateurs de travailler avec des données de manière plus intuitive.

:question: 7. Comment les vues peuvent-elles améliorer la sécurité des données ?

??? question "Correction"

    - Contrôle d’accès : Les vues peuvent être utilisées pour limiter l’accès aux données sensibles. Par exemple, une vue peut être créée pour n’afficher que les informations nécessaires à un groupe spécifique d’utilisateurs, empêchant ainsi l’accès direct aux tables sous-jacentes.
    - Masquage des données : Les vues peuvent masquer des colonnes ou des lignes spécifiques contenant des informations sensibles. Par exemple, une vue peut exclure les adresses des patients ou les diagnostics sensibles.
    - Audit et conformité : Les vues peuvent aider à garantir que seules les données nécessaires sont accessibles, ce qui est important pour la conformité aux réglementations sur la protection des données (comme le RGPD en Europe).

:question: 8. Quels seraient les impacts sur les performances si les tables contenaient des millions d’enregistrements ?

??? question "Correction"

    - Performance des requêtes : Les vues peuvent améliorer la lisibilité et la maintenance du code, mais elles peuvent aussi avoir un impact sur les performances si elles sont mal utilisées. Les vues complexes ou celles qui impliquent des jointures multiples peuvent ralentir les requêtes.
    - Indexation : L’utilisation d’index appropriés sur les tables sous-jacentes peut améliorer les performances des vues. Cependant, les vues elles-mêmes ne peuvent pas être indexées directement.
    - Vues matérialisées : Pour les grandes tables, les vues matérialisées peuvent être utilisées pour stocker les résultats de la vue et améliorer les performances des requêtes. Les vues matérialisées nécessitent cependant des mises à jour périodiques pour refléter les changements dans les données sous-jacentes.
    - Cache : Les SGBD modernes utilisent des mécanismes de cache pour améliorer les performances des vues. Cependant, les vues très dynamiques ou celles qui changent fréquemment peuvent ne pas bénéficier autant du cache.


## 4. Questions sur les Dates

Profitons en pour s'entraîner sur les dates :watch: ...

lien vers la documentation MySQL : [ici](https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html)

Voici quelques questions supplémentaires pour traiter des dates dans le contexte de la gestion d'un hôpital :

:question: 9. Quels patients ont eu des consultations au cours des 30 derniers jours ?

??? question "Correction"

    ```sql
    SELECT p.nom, p.prenom, c.date_consultation
    FROM Patients p
    JOIN Consultations c ON p.patient_id = c.patient_id
    WHERE c.date_consultation >= DATEADD(DAY, -30, GETDATE());
    ```

:question: 10. Quels médecins ont effectué des consultations au cours de la dernière semaine ?

??? question "Correction"

    ```SQL
    SELECT m.nom, m.prenom, c.date_consultation
    FROM Medecins m
    JOIN Consultations c ON m.medecin_id = c.medecin_id
    WHERE c.date_consultation >= DATEADD(DAY, -7, GETDATE());
    ```

:question: 11. Quels traitements ont été administrés au cours du mois de septembre 2024 ?

??? question "Correction"

    ```sql
    SELECT t.description, t.date_traitement
    FROM Traitements t
    WHERE t.date_traitement BETWEEN '2024-09-01' AND '2024-09-30';
    ```

:question: 12. Quels patients n'ont pas eu de consultations depuis plus d'un an ?

??? question "Correction"

    ```sql
    SELECT p.nom, p.prenom
    FROM Patients p
    WHERE p.patient_id NOT IN (
        SELECT c.patient_id
        FROM Consultations c
        WHERE c.date_consultation >= DATEADD(YEAR, -1, GETDATE())
    );
    ```

:question: 13. Combien de consultations ont été effectuées chaque mois au cours de l'année 2024 ?

??? question "Correction"

    ```sql
    SELECT YEAR(c.date_consultation) AS annee, MONTH(c.date_consultation) AS mois, COUNT(*) AS nombre_consultations
    FROM Consultations c
    WHERE YEAR(c.date_consultation) = 2024
    GROUP BY YEAR(c.date_consultation), MONTH(c.date_consultation)
    ORDER BY annee, mois;
    ```

:question: 14. Quels traitements ont été administrés plus de 6 mois après la consultation correspondante ?

??? question "Correction"

    ```sql
    SELECT t.description, t.date_traitement, c.date_consultation
    FROM Traitements t
    JOIN Consultations c ON t.consultation_id = c.consultation_id
    WHERE t.date_traitement > DATEADD(MONTH, 6, c.date_consultation);
    ```

![date](./data/date.webp){: width=30% .center}

!!! tip "Gestion des dates"
    Gérer les formats de date dans une base de données est crucial pour assurer la cohérence, la précision et la performance des requêtes. Voici quelques meilleures pratiques à suivre :

    1. Utiliser des types de données appropriés

    **DATE** : Utilisez ce type pour stocker uniquement des dates (année, mois, jour).
    **DATETIME** ou **TIMESTAMP** : Utilisez ces types pour stocker des dates et des heures complètes (année, mois, jour, heure, minute, seconde).
    *TIME** : Utilisez ce type pour stocker uniquement des heures (heure, minute, seconde).

    2. Normaliser les formats de date

    **Format ISO 8601** : Utilisez le format ISO 8601 (YYYY-MM-DD) pour stocker les dates. Ce format est standardisé et évite les ambiguïtés liées aux formats régionaux.
    ```sql
    '2024-10-15'  -- Format ISO 8601
    ```

    3. Indexer les colonnes de date

    **Indexation** : Créez des index sur les colonnes de date pour améliorer les performances des requêtes qui filtrent ou trient par date.
    ```sql
    CREATE INDEX idx_date_consultation ON Consultations(date_consultation);
    ```

    4. Gérer les fuseaux horaires

    **Stockage en UTC** : Stockez les dates et heures en temps universel coordonné (UTC) pour éviter les problèmes liés aux fuseaux horaires.
    **Conversion locale** : Convertissez les dates et heures en fuseau horaire local au moment de l'affichage ou de l'utilisation.

    5. Valider les entrées de date

    **Validation** : Validez les entrées de date au niveau de l'application pour éviter les erreurs de format et les dates invalides.
    **Contraintes** : Utilisez des contraintes de base de données pour garantir l'intégrité des dates (par exemple, une date de naissance ne peut pas être dans le futur).

    6. Utiliser des fonctions de date

    **Fonctions intégrées** : Utilisez les fonctions de date intégrées du SGBD pour manipuler et formater les dates (par exemple, `DATEADD`, `DATEDIFF`, `YEAR`, `MONTH`, `DAY`).
    ```sql
    SELECT DATEADD(DAY, 30, GETDATE());  -- Ajoute 30 jours à la date actuelle
    ```

    7. Stocker les dates de manière cohérente

    **Consistance** : Assurez-vous que toutes les dates dans la base de données sont stockées de manière cohérente, en utilisant les mêmes types de données et formats.

    8. Documenter les conventions de date

    **Documentation** : Documentez les conventions de date utilisées dans votre base de données pour que tous les développeurs et utilisateurs soient au courant des pratiques standard.

    9. Gérer les dates nulles

    **Valeurs NULL** : Définissez clairement comment gérer les dates nulles (par exemple, une date de fin de contrat non définie) et utilisez des valeurs par défaut appropriées si nécessaire.

    10. Tester les performances

    **Tests** : Testez les performances des requêtes impliquant des dates, surtout pour les grandes tables, et optimisez les index et les requêtes en conséquence.

