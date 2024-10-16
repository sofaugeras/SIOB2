# TP VOL complexe

!!! note "Objectif du TP"
	travailler sur les requêtes imbriquées et les opérateurs ensemblistes

On va travailler sur le modèle suivant : 

[Télécharger fichier Création de la base :arrow_down:](./data/tp4/vol2.sql){ .md-button .md-button--primary }

```SQL
PILOTE (pil_no, pil_nom, pil_prenom, pil_datnais, pil_ville)
		Clé primaire : pil_no
AVION (av_no, av_type, av_capacité, av_ville)
		Clé primaire : av_no
VOL (vol_no, #vol_pilote, #vol_avion, vol_nbpassagerA, vol_nbpassagerB, vol_prixClasseA, vol_prixClasseB)
		Clé primaire : vol_no
		Clé étrangère : vol_pilote références à PILOTE(pil_no)
					    Vol_avion références à AVION(vol_avion)
```

![base vol MPD](./data/tp4/vol2.png){: witdh=50% .center}

## 1. Interrogation de la base SANS jointure

Que fait la requête suivante :

```SQL
SELECT *
FROM AVION
WHERE av_capacite = (SELECT MAX(av_capacite)
					FROM AVION)
```

??? question "Correction"
	Elle affiche les infos de l'avion à la plus grande capacité.

Répondez aux besoins suivants par des requêtes SANS jointure.

**R1 :** Numéro du vol qui propose le plus de places en tarifs réduits (Classe B).

??? question "Correction"
	```SQL
	SELECT vol_no
	FROM vol
	WHERE vol_NbPassagerB = (SELECT MAX(vol_NbPassagerB)
						FROM vol);
	```

**R2 :** Liste des avions dont la capacité est supérieure à celle de l'avion n°2.
 
??? question "Correction"
	```SQL
	SELECT *
	FROM avion
	WHERE av_capacite > (SELECT av_capacite
					FROM AVION
					WHERE av_no = 2);
	```


**R3 :** Liste des avions (numéro) qui ont au moins 3 vols.

??? question "Correction"
	```SQL
	SELECT vol_avion
	FROM VOL
	GROUP BY vol_avion
	HAVING COUNT(*)>=3;
	```

**R4 :** Numéro de l'avion le plus utilisé. 

??? question "Correction"
	```SQL
	/* On veut l'avion qui a réalisé le plus de vol.
	On détermine d'abord le nombre de vol par avion */
	(SELECT COUNT(*)
	FROM vol
	GROUP BY vol_avion)

	/*L'avion qui a le plus volé sera celui dont son nombre de vol est égale au maximun des nombres de vols de tous les avions.
	On ne peut pas faire MAX(COUNT()) donc on écrit >= ALL COUNT

	Donc, le nombre de vols pour un avion doit être  >= à tous les nombres de vols par avion: */
	SELECT vol_avion
	FROM vol
	GROUP BY vol_avion
	HAVING COUNT(*) >= ALL (SELECT COUNT(*)
						FROM vol
						GROUP BY vol_avion);
	```

**R5 :** Le nom de la ville où sont stockés le plus d'avions.

??? question "Correction"
	```SQL
	On décompte le nombre d'avion par ville
	SELECT COUNT(*)
	FROM avion
	GROUP BY av_ville

	On veut le maximun de ces décomptes >= ALL

	Puis, on affiche la ville dont le décompte d'avion est égal à ce maximun
	SELECT av_ville
	FROM avion
	GROUP BY av_ville
	HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					FROM avion
					GROUP BY av_ville);
	```

**R6 :**	Liste des avions (Numéro et capacité) qui ne sont pas encore utilisés pour un vol. 

??? question "Correction"
	```SQL
	On sélectionne les avions qui ont volé une fois donc dans la table VOL
	(SELECT vol_avion
	FROM vol)

	Puis ceux qui ne sont pas dans VOL:
	SELECT av_no, av_capacite
	FROM avion
	WHERE av_no NOT IN (SELECT vol_avion
						FROM vol); 
	```
 
**R7 :** Liste des pilotes (Numéro, nom et prénom) qui n'ont jamais volé.

??? question "Correction"
	```SQL
	SELECT pil_no, pil_nom, pil_prénom
	FROM pilote p
	WHERE pil_no NOT IN (SELECT vol_pilote
					FROM vol);
	```

## 2. Avec jointures
Il est toujours possible d'utiliser des jointures dans la requête principale et la requête imbriquées.

**R8 :** Numéro et type de l'avion le plus utilisé (variante de la question D). 

??? question "Correction"
	```SQL
	SELECT av_no, av_type
	FROM avion, vol
	WHERE av_no = vol_avion
	GROUP BY av_no, av_type
	HAVING COUNT(*) >= ALL (SELECT COUNT(*)
					FROM vol
					GROUP BY vol_avion);
	```



**R9 :** Numéro, type et capacité des avions qui ont participé au vol proposant le plus de place en tarif plein (Classe A).

??? question "Correction"
	```SQL
	SELECT av_no, av_type, av_capacite
	FROM AVION INNER JOIN VOL
		ON av_no = vol_avion
	WHERE vol_NbPassagerA= (SELECT MAX(vol_NbPassagerA)
					FROM vol);
	```

**R10 :** Indiquez le nom et prénom des pilotes ayant volé avec l'avion de la plus grande capacité

??? question "Correction"
	```SQL
	SELECT pil_nom, pil_prénom
	FROM PILOTE, VOL, AVION
	WHERE pil_no = vol_pilote
	AND vol_avion = av_no
	AND av_capacite = (SELECT MAX(av_capacite)
				FROM AVION);
	```

**R11 :** Nom et prénom du pilote de Brest qui a le plus volé.

??? question "Correction"
	```SQL
	SELECT pil_nom, pil_prénom, COUNT(*)
	FROM pilote, Vol
	WHERE pil_no = vol_pilote
	AND pil_ville = 'Brest'
	GROUP BY Pil_no, pil_nom, pil_prénom
	HAVING COUNT(*) >= ALL (SELECT COUNT(*)
				FROM pilote, Vol
				WHERE pil_no = vol_pilote
				AND pil_ville = 'Brest'
				GROUP BY Pil_no)
	```

## 3. Pour aller plus loin: les opérateurs ensemblistes

:mag: Les opérateurs ensemblistes, qui ne sont pas supportés par tous les SGBD, peuvent être réécrits avec des requêtes imbriquées.

**R12 :** Numéro des pilotes qui sont de Brest ou qui ont volé avec l'avion n°1

??? question "Correction"
	```SQL
	--Solution avec Union
	SELECT pil_no
	FROM PILOTE
	WHERE pil_ville = 'BREST'

	UNION

	SELECT vol_pilote
	FROM VOL
	WHERE vol_avion = 1;

	--Solution sans UNION
	SELECT pil_no, pil_nom, pil_prénom
	FROM PILOTE
	WHERE pil_ville = 'BREST'
		OR pil_no IN (SELECT vol_pilote
						FROM VOL
						WHERE vol_avion = 1);
	```



**R13 :** Liste des villes où sont entreposés des avions et hébergeant un pilote

??? question "Correction"
	```SQL
	--Solution avec INTERSECT
	SELECT av_ville
	FROM AVION
	INTERSECT
	SELECT pil_ville
	FROM PILOTE;

	--Solution sans INTERSECT
	SELECT DISTINCT av_ville
	FROM AVION
	WHERE av_ville IN
	(SELECT pil_ville
	FROM PILOTE);
	```

**R14 :** Nom et prénom des pilotes qui ont conduit les avions n°1 et n°2:

??? question "Correction"
	```SQL
	--Solution avec Union
	SELECT vol_pilote
	FROM VOL
	WHERE vol_avion = 1;
	UNION
	SELECT vol_pilote
	FROM VOL
	WHERE vol_avion = 2;

	--Solution sans UNION
	SELECT pil_no, pil_nom, pil_prénom
	FROM PILOTE
	WHERE vol_avion = 2
	OR pil_no IN (SELECT vol_pilote
	FROM VOL
	WHERE vol_avion = 1);
	```



## 4. Toujours plus fort !

**R15 :** Quel est avion à la capacité maximale (qui embarque le plus de passagers)

??? question "Correction"
	```SQL
	SELECT av_no
	FROM AVION
	WHERE av_capacite = (SELECT MAX(av_capacite) 
						FROM AVION);
	```


**R16 :** :boom: :boom: Quel est le pilote qui a transporté le plus de passagers ?

??? question "Correction"
	```SQL
	SELECT *
		FROM VOL INNER JOIN PILOTE
		ON VOL.vol_pilote = PILOTE.pil_no
		WHERE vol_no IN (SELECT vol_no
							FROM VOL
							GROUP BY vol_no
							HAVING (SUM(vol_NbPassagerA) + SUM (vol_NbPassagerB)) >= ALL (SELECT  (SUM(vol_NbPassagerA) 
																									+ SUM vol_NbPassagerB)) 
																							FROM VOL GROUP BY vol_no));
	```

**R17 :** Combien de pilote n’ont jamais volé pour la compagnie ?

??? question "Correction"
	```SQL
	SELECT COUNT(*)
	FROM PILOTE
	LEFT JOIN VOL
	ON PILOTE.pil_no = VOL.vol_pilote 
	WHERE vol_pilote IS NULL ;
	```

**R18 :** La compagnie possède t’elle des avions inutilisés ?

??? question "Correction"
	```SQL
	SELECT *
	FROM VOL
	RIGHT JOIN AVION
	ON AVION.av_no = VOL.vol_avion
	WHERE vol_avion IS NULL;
	```