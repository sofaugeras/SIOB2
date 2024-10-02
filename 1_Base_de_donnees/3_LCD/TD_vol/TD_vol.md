# Modification base VOL 

[Télécharger fichier Création de la base VOL :arrow_down:](./data/script_creation_vols.sql){ .md-button .md-button--primary }

Attention, les modifications de la structure des tables ne doit pas entraîner de pertes de données : 

- M1 : Le champ NumVol doit être de taille fixe (10 caractères). 
- M2 : On souhaite que les champs NumPilote et NumAvion deviennent des numéros séquentiels. 
- M3 : On souhaite reprendre la structure de la table des pilotes en décomposant l’adresse en 3 champs : Rue, Ville et CodePostal. 
- M4 : On souhaite pouvoir réaliser une suppression en cascade pour les pilotes. 

!!! question "M1" 
    === "Enoncé"
        Le champ NumVol doit être de taille fixe (10 caractères). 
    
    === "Requête"

		```SQL
		ALTER TABLE VOL MODIFY`NUMVOL` char(10) NOT NULL DEFAULT '' 
		```

!!! question "M2" 
    === "Enoncé"
        On souhaite que les champs NumPilote et NumAvion deviennent des numéros séquentiels. 
    
    === "Requête"
	
		```SQL
		ALTER TABLE VOL 
		DROP FOREIGN KEY fk_vol_numpilote;

		ALTER TABLE PILOTE
		DROP PRIMARY KEY;

		ALTER TABLE PILOTE 
		MODIFY `NUMPILOTE` INT(11) AUTO_INCREMENT PRIMARY KEY;

		ALTER TABLE VOL
		ADD CONSTRAINT `fk_vol_numpilote` FOREIGN KEY (`numpilote`) REFERENCES `PILOTE` (`numpilote`);
		```

!!! question "M3" 
    === "Enoncé"
        On souhaite reprendre la structure de la table des pilotes en décomposant l’adresse en 3 champs : Rue, Ville et CodePostal. 
    
    === "Requête"

		```SQL
		ALTER TABLE PILOTE
		ADD `Rue` varchar(40) DEFAULT NULL,
		ADD CodePostal INT(5) DEFAULT NULL, 
		ADD `Ville` varchar(40) DEFAULT NULL;
		```

!!! question "M4" 
    === "Enoncé"
        On souhaite pouvoir réaliser une suppression en cascade pour les pilotes. 
    
    === "Requête"

		```SQL
		ALTER TABLE VOL
		DROP FOREIGN KEY `fk_vol_numpilote`;
		
		ALTER TABLE VOL
		ADD CONSTRAINT `fk_vol_numpilote` FOREIGN KEY (`NUMPILOTE`) 
			REFERENCES `pilote` (`NUMPILOTE`)ON DELETE CASCADE ON UPDATE CASCADE;
		```
