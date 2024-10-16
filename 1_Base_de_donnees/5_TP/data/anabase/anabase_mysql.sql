USE anabase

CREATE TABLE ACTIVITE(
	N_ACTIVITE smallint ,
	NOM_ACTIVITE varchar(32) NULL,
	DATE_ACTIVITE datetime NULL,
	PRIX_ACTIVITE smallint NULL,
	HEURE_ACTIVITE datetime NULL,
 CONSTRAINT PK_ACTIVITE PRIMARY KEY (N_ACTIVITE) ); 


CREATE TABLE CONGRESSISTE(
	N_CONGRESSISTE smallint ,
	N_HOTEL smallint NULL,
	N_ORGANISME smallint NULL,
	NOM_CONGRESSISTE varchar(32) NULL,
	PRENOM_CONGRESSISTE varchar(32) NULL,
	ADRESSE_CONGRESSISTE varchar(32) NULL,
	DATE_INSCRIPTION datetime NULL,
 CONSTRAINT PK_CONGRESSISTE PRIMARY KEY (N_CONGRESSISTE));


CREATE TABLE HOTEL(
	N_HOTEL smallint ,
	NOM_HOTEL varchar(32) NULL,
	ADRESSE_HOTEL varchar(32) NULL,
	NOMBRE_D_ETOILES smallint NULL,
	PRIX_PARTICIPANT float NULL,
	PRIX_SUPPL float NULL,
 CONSTRAINT PK_HOTEL PRIMARY KEY (N_HOTEL ) );

CREATE TABLE ORGANISME_PAYEUR(
	N_ORGANISME smallint ,
	NOM_ORGANISME varchar(32) NULL,
	ADRESSE_ORGANISME varchar(32) NULL,
 CONSTRAINT PK_ORGANISME_PAYEUR PRIMARY KEY (N_ORGANISME) ); 


CREATE TABLE PARTICIPATION(
	N_CONGRESSISTE smallint NOT NULL,
	N_ACTIVITE smallint NOT NULL,
	NBRE_PERSONNES smallint NULL,
 CONSTRAINT PK_PARTICIPATION PRIMARY KEY (N_CONGRESSISTE,N_ACTIVITE));

 ALTER TABLE CONGRESSISTE ADD  CONSTRAINT FK_CONGRESSISTE_HOTEL FOREIGN KEY(N_HOTEL)
REFERENCES HOTEL (N_HOTEL);

ALTER TABLE CONGRESSISTE  ADD  CONSTRAINT FK_CONGRESSISTE_ORGANISME_PAYEUR FOREIGN KEY(N_ORGANISME)
REFERENCES ORGANISME_PAYEUR (N_ORGANISME);

ALTER TABLE PARTICIPATION  ADD CONSTRAINT FK_PARTICIPATION_ACTIVITE FOREIGN KEY(N_ACTIVITE)
REFERENCES ACTIVITE (N_ACTIVITE);

ALTER TABLE PARTICIPATION ADD CONSTRAINT FK_PARTICIPATION_CONGRESSISTE FOREIGN KEY(N_CONGRESSISTE)
REFERENCES CONGRESSISTE (N_CONGRESSISTE);


INSERT INTO ACTIVITE (N_ACTIVITE, NOM_ACTIVITE, DATE_ACTIVITE, PRIX_ACTIVITE, HEURE_ACTIVITE) VALUES (1, 'Excursion à la Rhune', CAST('2020-06-05 00:00:00.0000000' AS datetime), 20, CAST('1899-12-30 17:00:00.0000000' AS datetime));
INSERT INTO ACTIVITE (N_ACTIVITE, NOM_ACTIVITE, DATE_ACTIVITE, PRIX_ACTIVITE, HEURE_ACTIVITE) VALUES (2, 'Visite St Jean de Luz', CAST('2020-06-05 00:00:00.0000000' AS datetime), 3, CAST('1899-12-30 09:30:00.0000000' AS datetime));
INSERT INTO ACTIVITE (N_ACTIVITE, NOM_ACTIVITE, DATE_ACTIVITE, PRIX_ACTIVITE, HEURE_ACTIVITE) VALUES (3, 'Concert Jazz', CAST('2020-06-06 00:00:00.0000000' AS datetime), 15, CAST('1899-12-30 20:30:00.0000000' AS datetime));
INSERT INTO ACTIVITE (N_ACTIVITE, NOM_ACTIVITE, DATE_ACTIVITE, PRIX_ACTIVITE, HEURE_ACTIVITE) VALUES (4, 'Tournoi Pelote basque', CAST('2020-06-07 00:00:00.0000000' AS datetime), 12, CAST('1899-12-30 20:30:00.0000000' AS datetime));

INSERT INTO HOTEL (N_HOTEL, NOM_HOTEL, ADRESSE_HOTEL, NOMBRE_D_ETOILES, PRIX_PARTICIPANT, PRIX_SUPPL) VALUES (1, 'Les Flots Bleus', 'Biarritz', 3, 55, 35);
INSERT INTO HOTEL (N_HOTEL, NOM_HOTEL, ADRESSE_HOTEL, NOMBRE_D_ETOILES, PRIX_PARTICIPANT, PRIX_SUPPL) VALUES (2, 'Beau Rivage', 'Biarritz', 3, 50, 32);
INSERT INTO HOTEL (N_HOTEL, NOM_HOTEL, ADRESSE_HOTEL, NOMBRE_D_ETOILES, PRIX_PARTICIPANT, PRIX_SUPPL) VALUES (3, 'Itsas-mendia', 'Bidart', 2, 25, 15);
INSERT INTO HOTEL (N_HOTEL, NOM_HOTEL, ADRESSE_HOTEL, NOMBRE_D_ETOILES, PRIX_PARTICIPANT, PRIX_SUPPL) VALUES (4, 'Continental', 'Anglet', 3, 40, 25);
INSERT INTO ORGANISME_PAYEUR (N_ORGANISME, NOM_ORGANISME, ADRESSE_ORGANISME) VALUES (1, 'IUT Limoges', 'Limoges');
INSERT INTO ORGANISME_PAYEUR (N_ORGANISME, NOM_ORGANISME, ADRESSE_ORGANISME) VALUES (2, 'Microsoft', 'Bordeaux');
INSERT INTO ORGANISME_PAYEUR (N_ORGANISME, NOM_ORGANISME, ADRESSE_ORGANISME) VALUES (3, 'LycEe Valado', 'Limoges');
INSERT INTO ORGANISME_PAYEUR (N_ORGANISME, NOM_ORGANISME, ADRESSE_ORGANISME) VALUES (4, 'ValEo', 'Paris');

INSERT INTO CONGRESSISTE (N_CONGRESSISTE, N_HOTEL, N_ORGANISME, NOM_CONGRESSISTE, PRENOM_CONGRESSISTE, ADRESSE_CONGRESSISTE, DATE_INSCRIPTION) VALUES (1, 1, 3, 'Millet', 'Alai', 'St Junie', CAST('2020-03-01 00:00:00.0000000' AS datetime));
INSERT INTO CONGRESSISTE (N_CONGRESSISTE, N_HOTEL, N_ORGANISME, NOM_CONGRESSISTE, PRENOM_CONGRESSISTE, ADRESSE_CONGRESSISTE, DATE_INSCRIPTION) VALUES (2, 1, 3, 'Brisset', 'Eric', 'Limoges', CAST('2020-03-01 00:00:00.0000000' AS datetime));
INSERT INTO CONGRESSISTE (N_CONGRESSISTE, N_HOTEL, N_ORGANISME, NOM_CONGRESSISTE, PRENOM_CONGRESSISTE, ADRESSE_CONGRESSISTE, DATE_INSCRIPTION) VALUES (3, 3, 2, 'Namèche', 'Nicole', 'Cognac', CAST('2020-02-03 00:00:00.0000000' AS datetime));
INSERT INTO CONGRESSISTE (N_CONGRESSISTE, N_HOTEL, N_ORGANISME, NOM_CONGRESSISTE, PRENOM_CONGRESSISTE, ADRESSE_CONGRESSISTE, DATE_INSCRIPTION) VALUES (4, 1, 4, 'Micheli', 'Marie-Pierre', 'Paris', CAST('2020-05-03 00:00:00.0000000' AS datetime));
INSERT INTO CONGRESSISTE (N_CONGRESSISTE, N_HOTEL, N_ORGANISME, NOM_CONGRESSISTE, PRENOM_CONGRESSISTE, ADRESSE_CONGRESSISTE, DATE_INSCRIPTION) VALUES (5, 1, NULL, 'Caillierez', 'Gabriel', 'La Rochelle', CAST('2020-04-03 00:00:00.0000000' AS datetime));
INSERT INTO CONGRESSISTE (N_CONGRESSISTE, N_HOTEL, N_ORGANISME, NOM_CONGRESSISTE, PRENOM_CONGRESSISTE, ADRESSE_CONGRESSISTE, DATE_INSCRIPTION) VALUES (6, 2, 1, 'Santerre', 'Jea', 'St Junie', CAST('2020-01-03 00:00:00.0000000' AS datetime));
INSERT INTO CONGRESSISTE (N_CONGRESSISTE, N_HOTEL, N_ORGANISME, NOM_CONGRESSISTE, PRENOM_CONGRESSISTE, ADRESSE_CONGRESSISTE, DATE_INSCRIPTION) VALUES (7, 2, 2, 'Pasqualini', 'Gabrielle', 'Bordeaux', CAST('2020-10-03 00:00:00.0000000' AS datetime));
INSERT INTO CONGRESSISTE (N_CONGRESSISTE, N_HOTEL, N_ORGANISME, NOM_CONGRESSISTE, PRENOM_CONGRESSISTE, ADRESSE_CONGRESSISTE, DATE_INSCRIPTION) VALUES (8, 4, 3, 'Messager', 'Yves', 'St Victurnie', CAST('2020-04-03 00:00:00.0000000' AS datetime));
INSERT INTO CONGRESSISTE (N_CONGRESSISTE, N_HOTEL, N_ORGANISME, NOM_CONGRESSISTE, PRENOM_CONGRESSISTE, ADRESSE_CONGRESSISTE, DATE_INSCRIPTION) VALUES (9, 3, NULL, 'Delord', 'Thierry', 'Roya', CAST('2020-06-03 00:00:00.0000000' AS datetime));
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (1, 1, 1);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (1, 2, 1);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (1, 3, 2);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (1, 4, 2);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (3, 1, 2);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (3, 2, 2);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (3, 3, 2);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (3, 4, 2);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (5, 3, 1);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (6, 3, 1);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (6, 4, 1);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (7, 1, 1);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (7, 4, 2);
INSERT INTO PARTICIPATION (N_CONGRESSISTE, N_ACTIVITE, NBRE_PERSONNES) VALUES (8, 4, 1);
