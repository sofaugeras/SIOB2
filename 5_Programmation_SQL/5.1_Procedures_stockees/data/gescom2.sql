USE gescom;
CREATE TABLE COMMANDE (
Numcom int PRIMARY KEY,
Datcom DATETIME)ENGINE=InnoDB;

CREATE TABLE ARTICLE (
Numart int PRIMARY KEY,
Desart varchar(50),
PUart decimal(10,2),
QteEnStock int,
SeuilMin int,
SeuilMaw int)ENGINE=InnoDB;

CREATE TABLE LIGNECOMMANDE (
Numcom int,
Numart int,
QteCommandee int,
CONSTRAINT pk_lc PRIMARY KEY (numcom, numart),
CONSTRAINT fk_lc_com FOREIGN KEY (Numcom) REFERENCES COMMANDE(Numcom),
CONSTRAINT fk_lc_art FOREIGN KEY (Numart) REFERENCES ARTICLE(Numart)
)ENGINE=InnoDB;