CREATE TABLE nation (
  idnation int auto_increment,
  nation varchar(50) NOT NULL default '',
  CONSTRAINT pk_nation PRIMARY KEY  (idnation)
) ;

INSERT INTO nation VALUES (1,'USA'),
(2,'Royaume-Uni'),
(3,'Nouvelle Zélande'),
(4,'Brésil'),
(5,'France'),
(6,'Mexique'),
(7,'Allemagne')
(8,'Canada');

--
-- Table structure for table `Realisateur`
--

DROP TABLE IF EXISTS `Realisateur`;

CREATE TABLE `Realisateur` (
  `idrealisateur` int(11) NOT NULL auto_increment,
  `nom` varchar(100) NOT NULL default '',
  `prenom` varchar(50) NOT NULL default '',
  `date_naissance` date NOT NULL default '0000-0-0',
  `nation` int ,
   CONSTRAINT pk_real PRIMARY KEY  (`idrealisateur`),
   CONSTRAINT fk_nation FOREIGN KEY (`nation`) REFERENCES `nation`(`idnation`)
) ;


--
--  data for table `Realisateur`
--
INSERT INTO `Realisateur` VALUES 
(1,'Cameron','James','1954-08-16',1),
(2,'Yates','David','1963-11-30',2),
(3,'Jackson','Peter','1961-10-31',3),
(4,'Bay','Michael','1965-02-17',1),
(5,'Verbinski','Gore','1964-03-16',1),
(6,'Weitz','Chris','1969-11-30',1),
(7,'Slade','David','1969-09-26',2),
(8,'Zemeckis','Robert','1951-05-14',1),
(9,'Shyamalan','Night','1970-08-6',1),
(10,'Saldanha','Carlos','1965-07-24',4),
(11,'Unkrich','Lee','1967-08-08',1),
(12,'Marshall','Rob','1960-10-17',1),
(13,'Burton','Tim','1958-08-25',1),
(14,'Nolan','Christopher','1970-07-30',2),
(15,'Columbus','Chris','1958-09-10',1),
(16,'Howard','Ron','1954-03-01',1),
(17,'Mitchell','Mike','1970-10-20',1),
(18,'Adamson','Andrew','1966-12-01',3),
(19,'Wachowski','Larry','1967-12-29',1),
(20,'Peterson','Bob','1961-01-05',1),
(21,'Lucas','Ceorge','1944-05-14',1),
(22,'Miller','Chris','1975-09-23',1),
(23,'CuarÃ³n','Alfonso','1961-11-28',6),
(24,'Spielberg','Steven','1946-12-18',1),
(25,'Allers','Roger','1949-10-02',1),
(26,'Raimi','Sam','1959-10-23',1),
(27,'Emmerich','Roland','1955-11-10',7),
(28,'Stanton','Andrew','1965-12-03',1),
(29,'Newell','Mike','1942-03-28',2),
(30,'Hitchcok','Alfred','1899-08-13',2),
(31,'Besson','Luc','1959-03-18',5)

;

DROP TABLE IF EXISTS `Film`;

CREATE TABLE `Film` (
  `idfilm` int(11) NOT NULL auto_increment,
  `titre` varchar(100) NOT NULL default '',
  `genre` varchar(50) NOT NULL default '',
  `sortie` date NOT NULL default '0000-0-0',
  `recettes` int(20) NOT NULL default '0',
  `idrealisateur` int(100) not null default '0',
  PRIMARY KEY  (`idfilm`),
  FOREIGN KEY (`idrealisateur`) REFERENCES `Realisateur`(`idrealisateur`)
) ;


--
--  data for table `Film`
--


INSERT INTO `Film` VALUES (1,'Twilight chapitre II : Tentation','Fantastique','2009-2-12',710,6),
(2,'Transformers','Fantastique','2007-6-6',709,4),
(3,'Twilight chapitre III : HÃ©sitation','Fantastique','2010-1-10',698,7),
(4,'Forrest Gump','Histoire','1994-5-20',677,8),
(5,'Avatar','Fantastique','2009-2-15',2782,1),
(6,'Titanic','Drame','1997-7-23',1843,1),
(7,'Harry Potter et les Reliques de la Mort II','Fantastique','2011-12-1',1294,2),
(8,'Le Seigneur des anneaux : Le Retour du roi','Histoire','2003-5-23',1119,3),
(9,'SixiÃ¨me Sens','Science fiction','1999-3-6',673,9),
(10,'L Ã‚ge de glace 2','Animation','2006-9-6',655,10),
(11,'Pirates des CaraÃ¯bes : La MalÃ©diction du Black Pearl','Fantastique','2003-4-2',654,5),
(12,'Transformers 3 : La Face cachÃ©e de la Lune','Fantastique','2011-4-23',1106,4),
(13,'Pirates des CaraÃ¯bes : Le Secret du coffre maudit','Fantastique','2006-12-1',1066,5),
(14,'Toy Story 3','Animation','2010-7-10',1063,11),
(15,'Pirates des CaraÃ¯bes : La Fontaine de Jouvence','Fantastique','2011-3-9',1038,12),
(16,'Alice au pays des merveilles','Animation','2010-9-4',1024,13),
(17,'The Dark Knight : Le Chevalier noir','Fantastique','2008-8-6',1001,14),
(18,'Harry Potter Ã  l Ã©cole des Sorciers','Fantastique','2001-2-1',975,15),
(19,'Da Vinci Code','Policier','2006-8-2',758,16),
(20,'Shrek 4 : Il Ã©tait une fin','Animation','2010-1-5',753,17),
(21,'Le Monde de Narnia','Fantastique','2005-7-4',745,18),
(22,'Matrix Reloaded','Science fiction','2003-9-21',742,19),
(23,'LÃ -haut','Animation','2009-11-7',731,20),
(24,'Pirates des CaraÃ¯bes : Jusqu au bout du monde','Fantastique','2007-10-23',963,5),
(25,'Harry Potter et les Reliques de la Mort I','Fantastique','2010-4-3',955,2),
(26,'Harry Potter et l Ordre du PhÃ©nix','Fantastique','2007-2-1',940,2),
(27,'Harry Potter et le Prince de Sang-MÃªlÃ©','Fantastique','2009-9-4',934,2),
(28,'Le Seigneur des anneaux : Les Deux Tours','Histoire','2002-7-12',925,3),
(29,'Star Wars I : La Menace fantÃ´me','Science fiction','1999-6-21',924,21),
(30,'Shrek 2','Animation','2004-5-26',920,18),
(31,'Independence Day','Science fiction','1996-1-2',817,27),
(32,'Shrek le troisiÃ¨me','Animation','2007-8-3',798,22),
(33,'Harry Potter et le Prisonnier d Azkaban','Fantastique','2003-4-18',796,23),
(34,'E.T. l extra-terrestre','Science fiction','1982-4-4',792,24),
(35,'Indiana Jones','Aventure','2008-2-2',786,24),
(36,'Le Roi lion','Animation','1994-6-6',784,25),
(37,'Spider-Man 2','Fantastique','2004-11-23',783,26),
(38,'Star Wars  IV : Un nouvel espoir','Science fiction','1977-9-17',775,21),
(39,'2012','Science fiction','2009-4-3',769,27),
(40,'L Ã‚ge de glace 3','Animation','2009-9-1',886,10),
(41,'Harry Potter et la Chambre des Secrets','Fantastique','2002-3-26',878,15),
(42,'Le Seigneur des anneaux : La CommunautÃ© de l anneau','Histoire','2001-7-3',870,3),
(43,'Le Monde de Nemo','Animation','2003-5-1',867,28),
(44,'Star Wars III : La Revanche des Sith','Science fiction','2005-11-4',848,21),
(45,'Transformers 2 : La Revanche','Fantastique','2009-8-2',836,4),
(46,'Inception','Fantastique','2010-9-4',825,14),
(47,'Spider-Man','Fantastique','2002-6-6',821,26),
(48,'Jurassic Park','Fantastique','1993-8-12',914,24),
(49,'Harry Potter et la Coupe de Feu','Fantastique','2005-7-7',896,29),
(50,'Spider-Man 3','Fantastique','2007-9-1',890,26);




