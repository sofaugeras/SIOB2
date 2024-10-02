CREATE TABLE AVION (
av_no INTEGER,
av_type VARCHAR(6),
av_capacite  INTEGER,
av_ville varchar(30),
CONSTRAINT pk_avion PRIMARY KEY (av_no)
);

CREATE TABLE PILOTE (
pil_no    VARCHAR(4),
pil_nom   VARCHAR(30),
pil_prénom VARCHAR(30),
pil_datenais DATETIME,
pil_ville VARCHAR(30),
CONSTRAINT pk_pilote PRIMARY KEY (pil_no)
);

CREATE TABLE VOL (
vol_no VARCHAR(6),
vol_pilote vARCHAR(4),
vol_avion INT,
vol_NbPassagerA INTEGER,
vol_NbPassagerB INTEGER,
Vol_PrixClasseA INTEGER,
Vol_PrixClasseB INTEGER,
CONSTRAINT pk_vol PRIMARY KEY (vol_no)
CONSTRAINT fk_vol_pilote FOREIGN KEY (vol_pilote) REFERENCES PILOTE(pil_no),
CONSTRAINT fk_vol_avion FOREIGN KEY (vol_avion) REFERENCES AVION(av_no)
);

