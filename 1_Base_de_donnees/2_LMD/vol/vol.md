# Application Base « Vols » 

Écrire les requêtes suivantes : <br/>
R25 : Quels sont les vols (NumVol) triés par ordre croissant, assurés par Toto ? <br/>
R26 : Combien de vols y a-t-il au départ de Gillot ? <br/>
R27 : Combien de vols sont assurés par des ATR ? <br/>
R28 : Liste des vols (NumVol et NumAvion) au départ de Paris dont la capacité est supérieure à 400 places ? <br/>
R29 : Liste des avions (NumAvion et NomAvion) pilotés par le pilote nommé Hoareau au départ de Gillot ? <br/>

!!! question "R25" 
    === "Enoncé"
        Quels sont les vols (NumVol) triés par ordre croissant, assurés par Toto ? 
    
    === "Requête"
        ```SQL
        SELECT NumVol 
        FROM VOL
        INNER JOIN PILOTE
        ON VOL.NumPilote = PILOTE.NumPilote
        Where NomPilote = "Toto";
        ```

!!! question "R26" 
    === "Enoncé"
        Combien de vols y a-t-il au départ de Gillot ? 
    === "Requête"
        ```SQL
        SELECT Count(NumVol) AS NbVolGillot
        FROM VOL
        WHERE VilleDepart = "Gillot" ;

        ```

!!! question "R27" 
    === "Enoncé"
        Combien de vols sont assurés par des ATR ? 
    === "Requête"
        ```SQL
        SELECT Count(VOL.NumVol) AS NbATR
        FROM VOL INNER JOIN AVION ON AVION.NumAvion = VOL.NumAvion
        WHERE AVION.NomAvion Like "ATR*";
        ```

!!! question "R28" 
    === "Enoncé"
        Liste des vols (NumVol et NumAvion) au départ de Paris dont la capacité est supérieure à 400 places ? 
    === "Requête"
        ```SQL
        SELECT VOL.NumVol, AVION.NumAvion
        FROM VOL
        INNER JOIN AVION
        ON VOL.NumAvion = AVION.NumAvion
        WHERE AVION.Capacite > 400;
        ```

!!! question "R29" 
    === "Enoncé"
        Liste des avions (NumAvion et NomAvion) pilotés par le pilote nommé Hoareau au départ de Gillot ? 
    === "Requête"
        ```SQL
        SELECT AVION.NumAVion, AVION.NomAvion
        FROM ((AVION INNER JOIN VOL
        ON AVION.NumAvion = Vol.NumAvion)
        INNER JOIN PILOTE
        ON VOL.NumPilote = PILOTE.NumPilote)
        WHERE  PILOTE.NomPilote = "Hoareau"
        AND VOL.VilleDepart = "Gillot" ;
        ```

[Télécharger fichier Correction des requêtes :arrow_down:](./data/chap2_corrige_requete_suiteVOL.txt){ .md-button .md-button--primary }
