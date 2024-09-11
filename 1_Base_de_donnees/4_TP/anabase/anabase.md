# Révision SIO2 : Cas Anabase

Pour illustrer ces révisions, j’ai décidé de m’appuyer sur un cas créé dans les années 80 et bien connu des enseignants en informatique : le cas « **Anabase** » dont voici quelques extraits :

!!! success "Cas Anabase"
    Le congrès se déroule sur une semaine de 5 jours ouvrables. Il comporte différentes sessions d’une demi-journée chacune, consacrées à des conférences, débats sur un thème donné.<br />
    Un congressiste peut participer à ce congrès envoyé par un organisme (entreprise, administration, université ou lycée) ou non.
    Il peut éventuellement être accompagné d’une personne. On suppose qu’un congressiste ne peut pas avoir plus d’un accompagnateur.<br />
    Le congressiste est affecté à un hôtel. Chaque hôtel a proposé un prix par participant et un supplément pour l’accompagnateur. Ces prix sont valables pour toutes les chambres d'un même hôtel.<br />
    Le bureau d’animation propose des activités culturelles (spectacles, excursions, concerts, visites de monuments...) pour meubler le temps des accompagnateurs et des congressistes qui ont des disponibilités dans leur emploi du temps. Chaque activité est repérée par un code activité, une désignation et un horaire de début et de fin.<br />
    Les congressistes et les accompagnateurs peuvent s’inscrire jusqu'à la veille au soir aux activités souhaitées.<br />

## 1. Modélisation
:bulb: Etablissez un modèle de donnée à partir des informations données ci-dessus.

??? info "Diagramme de classe"

    ![Diagramme de classe](./data/anabase/diagClasseAnabase.png){: width=100% .center}

??? info "MPD"
    Le modèle relationnel obtenu est le suivant :

    ![MPD](./data/anabase/anabaseConcepteur.png){: width=100% .center}

[Télécharger fichier Création de la base Anabase :arrow_down:](./data/anabase/anabase_mysql.sql){ .md-button .md-button--primary }

## 2. Exercices de requêtes de projection

!!! question "R1"
    === "Enoncé"
        Afficher le nom, la date et l’heure de chaque activité.
    === "Correction"
        ```sql
        SELECT NOM_ACTIVITE, DATE_ACTIVITE, HEURE_ACTIVITE 
        FROM ACTIVITE;
        ```

!!! question "R2"
    === "Enoncé"
        Afficher les villes dont sont originaires les congressistes 
    === "Correction"
        ```sql
        SELECT distinct ADRESSE_CONGRESSISTE  
        FROM  CONGRESSISTE;
        ```

## 3. Exercices de requêtes de sélection

!!! question "R3"
    === "Enoncé"
        Donner la liste des organismes limougeauds.
    === "Correction"
        ```sql
        SELECT * 
        FROM ORGANISME_PAYEUR 
        WHERE ADRESSE_ORGANISME = 'Limoges';
        ```

!!! question "R4"
    === "Enoncé"
        Donner les noms et prénoms de congressistes ne dépendant pas d’un organisme.
    === "Correction"
        ```sql
        SELECT NOM_CONGRESSISTE, PRENOM_CONGRESSISTE 
        FROM CONGRESSISTE 
        WHERE N_ORGANISME IS NULL;
        ```

!!! question "R5"
    === "Enoncé"
        Donner la liste des congressistes situés dans les hôtels 2 ou 4.
    === "Correction"
        ```sql
        SELECT * FROM CONGRESSISTE WHERE N_HOTEL in (2,3,4);
        ```

!!! question "R6"
    === "Enoncé"
        Donner la liste des activités ayant lieu le 5 ou le 7 juin 2008.
    === "Correction"
        ```sql
        SELECT * 
        FROM ACTIVITE 
        WHERE DATE_ACTIVITE = {D '2008-06-05' } 
            OR DATE_ACTIVITE = {D '2008-06-07' };
        ```

!!! question "R7"
    === "Enoncé"
        Donner la liste des congressistes (nom et prénom) par ordre alphabétique.
    === "Correction"
        ```sql
        SELECT NOM_CONGRESSISTE, PRENOM_CONGRESSISTE 
        FROM CONGRESSISTE 
        ORDER BY NOM_CONGRESSISTE, PRENOM_CONGRESSISTE;
        ```

!!! question "R8"
    === "Enoncé"
        Donner la liste des hôtels dont le prix participant est compris entre 35 et 52 €.
    === "Correction"
        ```sql
        SELECT NOM_HOTEL, PRIX_PARTICIPANT 
        FROM HOTEL 
        WHERE  PRIX_PARTICIPANT between 35 and 52;
        ```

!!! question "R9"
    === "Enoncé"
        Donner la liste des congressistes (nom, prénom) dont le nom commence par un « M ».
    === "Correction"
        ```sql
        SELECT NOM_CONGRESSISTE, PRENOM_CONGRESSISTE 
        FROM CONGRESSISTE 
        WHERE  NOM_CONGRESSISTE like 'M%';
        ```

!!! question "R10"
    === "Enoncé"
        Donner la liste des congressistes (nom, prénom) dont le nom contient un « A ».
    === "Correction"
        ```sql
        SELECT NOM_CONGRESSISTE, PRENOM_CONGRESSISTE 
        FROM CONGRESSISTE 
        WHERE NOM_CONGRESSISTE LIKE '%A%';
        ```

!!! question "R11"
    === "Enoncé"
        Donner la liste des congressistes (nom, prénom) dont le nom finit par un « T ».
    === "Correction"
        ```sql
        SELECT NOM_CONGRESSISTE, PRENOM_CONGRESSISTE 
        FROM CONGRESSISTE 
        WHERE NOM_CONGRESSISTE LIKE '%T';
        ```

!!! question "R12"
    === "Enoncé"
        Donner la liste des hôtels dont le prix participant varie entre 35 et 55 € et dont le prix supplément varie entre 20 et 30 €.
    === "Correction"
        ```sql
        SELECT NOM_HOTEL, PRIX_PARTICIPANT, PRIX_SUPPL 
        FROM  HOTEL 
        WHERE  PRIX_PARTICIPANT between 35 and 55 
            AND PRIX_SUPPL between 20 and 30;
        ```

!!! question "R13"
    === "Enoncé"
        Donner pour chaque hôtel  la somme des deux prix (prix participant + prix supplément).
    === "Correction"
        ```sql
        SELECT NOM_HOTEL, PRIX_PARTICIPANT, PRIX_SUPPL, PRIX_PARTICIPANT + PRIX_SUPPL as PRIX_TOTAL 
        FROM HOTEL;
        ```

## 4. Exercices de requêtes avec fonctions

!!! question "R14"
    === "Enoncé"
        Afficher le nombre total de congressistes.
    === "Correction"
        ```sql
        SELECT count(*) as nombre 
        FROM CONGRESSISTE;
        ```

!!! question "R15"
    === "Enoncé"
        Afficher le prix moyen d’une chambre à Biarritz et la même chose pour les suppléments.
    === "Correction"
        ```sql
        SELECT AVG(PRIX_PARTICIPANT) as MOY_PARTICIPANT, AVG( PRIX_SUPPL ) as MOY_ SUPPL 
        FROM HOTEL 
        WHERE ADRESSE_HOTEL = 'Biarritz';
        ```

!!! question "R16"
    === "Enoncé"
        Afficher pour chaque activité le nombre de personnes l’ayant choisie.
    === "Correction"
        ```sql
        SELECT N_ACTIVITE, COUNT(*) as NB_FOIS  
        FROM PARTICIPATION 
        GROUP BY N_ACTIVITE;
        ```

!!! question "R17"
    === "Enoncé"
        Pour chaque congressiste participant à plus de 2 activités, afficher la moyenne du nombre de personnes
    === "Correction"
        ```sql
        SELECT N_CONGRESSISTE,AVG(NBRE_PERSONNES) as moyenne 
        FROM PARTICIPATION 
        GROUP BY N_CONGRESSISTE
        HAVING COUNT(*) > 2;
        ```


## 5. Exercices de requêtes de jointure

!!! question "R18"
    === "Enoncé"
        Afficher pour chaque congressiste son numéro, son nom et le nom de l’hôtel où il loge.
    === "Correction"
        ```sql
        SELECT N_CONGRESSISTE, NOM_CONGRESSISTE, NOM_HOTEL 
        FROM CONGRESSISTE INNER JOIN HOTEL
        ON CONGRESSISTE.N_HOTEL = HOTEL.N_HOTEL ;
        ```

!!! question "R19"
    === "Enoncé"
        Même résultat que dans R18, mais afficher en plus le nom de l’organisme dont il dépend. Que remarquez-vous ?
    === "Correction"
        ```sql
        SELECT N_CONGRESSISTE, NOM_CONGRESSISTE, NOM_HOTEL, NOM_ORGANISME 
        FROM CONGRESSISTE INNER JOIN HOTEL
        ON CONGRESSISTE.N_HOTEL = HOTEL.N_HOTEL 
        INNER JOIN  ORGANISME_PAYEUR O 
        ONCONGRESSISTE.N_ORGANISME = O.N_ORGANISME ;
        
        Il faut remarquer que les congressistes ne dépendant d’aucun organisme ne figure pas comme résultat de cette requête basée sur l’égalité des numéros d’organisme.
        ```

!!! question "R20"
    === "Enoncé"
        Afficher pour chaque congressiste son numéro, son nom et le nom de l’hôtel. Restituer cette liste par hôtel et par ordre alphabétique des congressistes.
    === "Correction"
        ```sql
        SELECT NOM_HOTEL, N_CONGRESSISTE, NOM_CONGRESSISTE  
        FROM CONGRESSISTE INNER JOIN HOTEL 
        ON CONGRESSISTE.N_HOTEL = HOTEL.N_HOTEL 
        ORDER BY  CONGRESSISTE.N_HOTEL ,  NOM_CONGRESSISTE;
        ```

!!! question "R21"
    === "Enoncé"
        Même chose que pour R20, mais uniquement pour les congressistes des hôtels de Biarritz.
    === "Correction"
        ```sql
        SELECT NOM_HOTEL, N_CONGRESSISTE, NOM_CONGRESSISTE  
        FROM CONGRESSISTE INNER JOIN HOTEL 
        ON CONGRESSISTE.N_HOTEL = HOTEL.N_HOTEL 
        AND ADRESSE_HOTEL ='Biarritz'
        ORDER BY  CONGRESSISTE.N_HOTEL ,  NOM_CONGRESSISTE
        ```
## 6. Exercices de requêtes de requêtes imbriquées

!!! question "R22"
    === "Enoncé"
        Afficher le nom et le prénom des congressistes allant au concert de Jazz.
    === "Correction"
        ```sql
        SELECT Nom_congressiste, prénom_congressiste 
        FROM CONGRESSISTE 
        WHERE N_congressiste 
            IN ( SELECT N_congressiste 
                FROM PARTICIPATION 
                WHERE N_activité 
                IN ( SELECT N_ACTIVITE 
                    FROM ACTIVITE 
                    WHERE NOM_ACTIVITE = 'Concert Jazz' ) );
        ```

!!! question "R23"
    === "Enoncé"
        Afficher le nom et le prénom des congressistes n’allant pas au tournoi de pelote basque.
    === "Correction"
        ```sql
        SELECT Nom_congressiste, prénom_congressiste 
        FROM CONGRESSISTE 
        WHERE N_congressiste NOT  IN ( SELECT N_congressiste 
                                    FROM PARTICIPATION 
                                    WHERE N_activité IN ( SELECT N_ACTIVITE 
                                                        FROM ACTIVITE 
                                                        WHERE NOM_ACTIVITE = 'Tournoi Pelote basque' ) );
        ```

!!! question "R24"
    === "Enoncé"
        Afficher le nom et le prénom des congressistes ayant choisi une chambre d’hôtel dont le montant par jour est supérieur à 70 euros (prix chambre + prix supplémentaire).
    === "Correction"
        ```sql
        SELECT Nom_congressiste, prénom_congressiste 
        FROM CONGRESSISTE 
        WHERE N_hôtel IN ( SELECT N_hôtel 
                            FROM HOTEL 
                            WHERE Prix_Participant + Prix_Suppl > 70 );
        ```

!!! question "R25"
    === "Enoncé"
        Afficher le nom et le prénom des congressistes ayant choisi l’activité la moins chère.
    === "Correction"
        ```sql
        SELECT Nom_congressiste, prénom_congressiste 
        FROM CONGRESSISTE 
        WHERE N_congressiste IN ( SELECT N_congressiste 
                                FROM PARTICIPATION WHERE N_activité IN ( SELECT N_ACTIVITE 1                
                                                                        FROM ACTIVITE 
                                                                        WHERE PRIX_ACTIVITE = (SELECT MIN(PRIX_ACTIVITE) 
                                                                                                FROM ACTIVITE)) );
        ```