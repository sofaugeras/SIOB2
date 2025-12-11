-- Création de la base de données
CREATE DATABASE IF NOT EXISTS tp_sauvegarde;
USE tp_sauvegarde;

-- Table : utilisateurs
CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_inscription DATETIME NULL DEFAULT CURRENT_TIMESTAMP
);

-- Données pour la table utilisateurs
INSERT INTO utilisateurs (nom, email, date_inscription) VALUES
('Alice Dupont', 'alice.dupont@example.com', '2024-01-15'),
('Bob Martin', 'bob.martin@example.com', '2024-03-20'),
('Charlie Bernard', 'charlie.bernard@example.com', '2024-06-05');

-- Table : commandes
CREATE TABLE commandes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    utilisateur_id INT NOT NULL,
    produit VARCHAR(100) NOT NULL,
    quantite INT NOT NULL,
    date_commande DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs(id)
);

-- Données pour la table commandes
INSERT INTO commandes (utilisateur_id, produit, quantite, date_commande) VALUES
(1, 'Ordinateur portable', 1, '2024-07-10 14:32:00'),
(2, 'Clavier mécanique', 2, '2024-07-11 09:15:00'),
(3, 'Écran 24 pouces', 1, '2024-07-12 16:45:00');

-- Table : logs (journaux)
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(255) NOT NULL,
    date_action DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Données pour la table logs
INSERT INTO logs (action, date_action) VALUES
('Création de l’utilisateur Alice Dupont', '2024-01-15 10:00:00'),
('Commande passée par Bob Martin', '2024-07-11 09:15:00'),
('Connexion de Charlie Bernard', '2024-07-12 16:30:00');
