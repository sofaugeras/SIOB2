# Modification base VOL 

Attention, les modifications de la structure des tables ne doit pas entraîner de pertes de données : 
- Le champ NumVol doit être de taille fixe (10 caractères). 
- On souhaite que les champs NumPilote et NumAvion deviennent des numéros séquentiels. 
- On souhaite reprendre la structure de la table des pilotes en décomposant l’adresse en 3 champs : Rue, Ville et CodePostal. 
- On souhaite pouvoir réaliser une suppression en cascade pour les pilotes. 
 
-- Le champ NumVol doit être de taille fixe (10 caractères). 
ALTER TABLE VOL MODIFY`NUMVOL` char(10) NOT NULL DEFAULT '' 
-- On souhaite que les champs NumPilote et NumAvion deviennent des numéros séquentiels. 
ALTER TABLE VOL 
DROP FOREIGN KEY fk_vol_numpilote;

ALTER TABLE PILOTE
DROP PRIMARY KEY;

ALTER TABLE PILOTE 
MODIFY `NUMPILOTE` INT(11) AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE VOL
ADD CONSTRAINT `fk_vol_numpilote` FOREIGN KEY (`numpilote`) REFERENCES `PILOTE` (`numpilote`);
-- On souhaite reprendre la structure de la table des pilotes en décomposant l’adresse en 3 champs : Rue, Ville et CodePostal. 
ALTER TABLE PILOTE
ADD `Rue` varchar(40) DEFAULT NULL,
ADD CodePostal INT(5) DEFAULT NULL, 
ADD `Ville` varchar(40) DEFAULT NULL;
-- On souhaite pouvoir réaliser une suppression en cascade pour les pilotes. 
ALTER TABLE VOL
DROP FOREIGN KEY `fk_vol_numpilote`;
ALTER TABLE VOL
ADD CONSTRAINT `fk_vol_numpilote` FOREIGN KEY (`NUMPILOTE`) 
	REFERENCES `pilote` (`NUMPILOTE`)ON DELETE CASCADE ON UPDATE CASCADE;