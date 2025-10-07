-- =========================================================
-- BDD : Parc Informatique
-- Auteur : TP BTS SIO - LMD SQL
-- =========================================================

-- 0) (Optionnel) Nettoyage préalable
DROP DATABASE IF EXISTS parc_informatique;
CREATE DATABASE parc_informatique
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
USE parc_informatique;

-- 1) Tables
-- ---------------------------------------------------------

-- Salle : lieux d’implantation des postes
CREATE TABLE Salle (
  idSalle     INT AUTO_INCREMENT PRIMARY KEY,
  nomSalle    VARCHAR(30) NOT NULL UNIQUE,
  capacite    INT NOT NULL CHECK (capacite >= 0)
) ENGINE=InnoDB;

-- Poste : machines
CREATE TABLE Poste (
  idPoste     INT AUTO_INCREMENT PRIMARY KEY,
  nomPoste    VARCHAR(30) NOT NULL UNIQUE,
  systeme     VARCHAR(40) NOT NULL,
  dateAchat   DATE NOT NULL,
  idSalle     INT NOT NULL,
  CONSTRAINT fk_poste_salle
    FOREIGN KEY (idSalle) REFERENCES Salle(idSalle)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Utilisateur : personnes (enseignants, techniciens, etc.)
CREATE TABLE Utilisateur (
  idUtilisateur INT AUTO_INCREMENT PRIMARY KEY,
  nom           VARCHAR(30) NOT NULL,
  prenom        VARCHAR(30) NOT NULL,
  fonction      VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

-- Affectation : historique d’affectation des postes aux utilisateurs
CREATE TABLE Affectation (
  idAffectation   INT AUTO_INCREMENT PRIMARY KEY,
  idPoste         INT NOT NULL,
  idUtilisateur   INT NOT NULL,
  dateAffectation DATE NOT NULL,
  dateFin         DATE DEFAULT NULL,
  CONSTRAINT fk_aff_poste
    FOREIGN KEY (idPoste) REFERENCES Poste(idPoste)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_aff_user
    FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
    ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx_aff_poste_date (idPoste, dateAffectation DESC),
  INDEX idx_aff_user_date  (idUtilisateur, dateAffectation DESC)
) ENGINE=InnoDB;

-- Incident : tickets/pannes sur les postes
CREATE TABLE Incident (
  idIncident    INT AUTO_INCREMENT PRIMARY KEY,
  idPoste       INT NOT NULL,
  dateIncident  DATE NOT NULL,
  description   VARCHAR(255) NOT NULL,
  statut        VARCHAR(20) NOT NULL CHECK (statut IN ('Ouvert','En cours','Résolu')),
  CONSTRAINT fk_incident_poste
    FOREIGN KEY (idPoste) REFERENCES Poste(idPoste)
    ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx_incident_poste (idPoste),
  INDEX idx_incident_statut (statut)
) ENGINE=InnoDB;

-- 2) Jeux d’essai
-- ---------------------------------------------------------

-- Salles
INSERT INTO Salle (nomSalle, capacite) VALUES
('B201', 15),
('A104', 20),
('C312', 12),
('D010', 8);

-- Postes
INSERT INTO Poste (nomPoste, systeme, dateAchat, idSalle) VALUES
('PC-B201-01', 'Windows 10', '2023-01-10', (SELECT idSalle FROM Salle WHERE nomSalle='B201')),
('PC-B201-02', 'Linux Debian', '2022-05-12', (SELECT idSalle FROM Salle WHERE nomSalle='B201')),
('PC-A104-01', 'Windows 11', '2024-03-15', (SELECT idSalle FROM Salle WHERE nomSalle='A104')),
('PC-A104-02', 'Linux Ubuntu', '2021-10-03', (SELECT idSalle FROM Salle WHERE nomSalle='A104')),
('PC-C312-01', 'Windows 10', '2020-09-01', (SELECT idSalle FROM Salle WHERE nomSalle='C312')),
('PC-D010-01', 'Linux Debian', '2024-11-20', (SELECT idSalle FROM Salle WHERE nomSalle='D010')),
('PC-D010-02', 'Windows 11', '2025-01-05', (SELECT idSalle FROM Salle WHERE nomSalle='D010'));

-- Utilisateurs
INSERT INTO Utilisateur (nom, prenom, fonction) VALUES
('Martin',  'Sophie', 'Enseignant'),
('Durand',  'Lucas',  'Technicien'),
('Lemoine', 'Camille','Étudiant'),
('Petit',   'Nina',   'Enseignant'),
('Bernard', 'Maxime', 'Étudiant'),
('Roux',    'Ana',    'Personnel');


-- Affectations (historique)
INSERT INTO Affectation (idPoste, idUtilisateur, dateAffectation, dateFin) VALUES
-- B201
((SELECT idPoste FROM Poste WHERE nomPoste='PC-B201-01'), (SELECT idUtilisateur FROM Utilisateur WHERE nom='Martin'  AND prenom='Sophie'), '2024-09-01', NULL),
((SELECT idPoste FROM Poste WHERE nomPoste='PC-B201-02'), (SELECT idUtilisateur FROM Utilisateur WHERE nom='Lemoine' AND prenom='Camille'), '2025-01-10', NULL),
-- A104
((SELECT idPoste FROM Poste WHERE nomPoste='PC-A104-01'), (SELECT idUtilisateur FROM Utilisateur WHERE nom='Petit'   AND prenom='Nina'),    '2024-11-15', NULL),
((SELECT idPoste FROM Poste WHERE nomPoste='PC-A104-02'), (SELECT idUtilisateur FROM Utilisateur WHERE nom='Bernard' AND prenom='Maxime'),  '2023-02-02', '2025-02-28'), -- affectation précédente  
((SELECT idPoste FROM Poste WHERE nomPoste='PC-A104-02'), (SELECT idUtilisateur FROM Utilisateur WHERE nom='Roux'    AND prenom='Ana'),     '2025-03-01', NULL), -- réaffectation récente
-- C312
((SELECT idPoste FROM Poste WHERE nomPoste='PC-C312-01'), (SELECT idUtilisateur FROM Utilisateur WHERE nom='Durand'  AND prenom='Lucas'),   '2022-09-15', NULL),
-- D010
((SELECT idPoste FROM Poste WHERE nomPoste='PC-D010-01'), (SELECT idUtilisateur FROM Utilisateur WHERE nom='Bernard' AND prenom='Maxime'),  '2025-05-21', NULL),
((SELECT idPoste FROM Poste WHERE nomPoste='PC-D010-02'), (SELECT idUtilisateur FROM Utilisateur WHERE nom='Martin'  AND prenom='Sophie'), '2025-06-03', NULL);
-- Incidents
INSERT INTO Incident (idPoste, dateIncident, description, statut) VALUES
((SELECT idPoste FROM Poste WHERE nomPoste='PC-B201-01'), '2025-02-12', 'Écran noir au démarrage', 'Résolu'),
((SELECT idPoste FROM Poste WHERE nomPoste='PC-B201-02'), '2025-04-05', 'Problème de réseau',      'En cours'),
((SELECT idPoste FROM Poste WHERE nomPoste='PC-A104-01'), '2024-12-01', 'Clavier défectueux',       'Résolu'),
((SELECT idPoste FROM Poste WHERE nomPoste='PC-A104-02'), '2023-03-10', 'Disque plein',             'Résolu'),
((SELECT idPoste FROM Poste WHERE nomPoste='PC-C312-01'), '2025-06-25', 'Ventilation bruyante',     'Ouvert');

-- 4) Quelques index utiles supplémentaires
CREATE INDEX idx_poste_systeme ON Poste(systeme);
CREATE INDEX idx_poste_salle   ON Poste(idSalle);
