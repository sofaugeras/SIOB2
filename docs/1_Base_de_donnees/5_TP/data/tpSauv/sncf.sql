-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 17 oct. 2025 à 14:06
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `sncf`
--

-- --------------------------------------------------------

--
-- Structure de la table `composition`
--

DROP TABLE IF EXISTS `composition`;
CREATE TABLE IF NOT EXISTS `composition` (
  `numTrain` int NOT NULL,
  `dateDep` datetime NOT NULL,
  `Ass1` int DEFAULT NULL,
  `Ass2` int DEFAULT NULL,
  `Cch1` int DEFAULT NULL,
  `Cch2` int DEFAULT NULL,
  PRIMARY KEY (`numTrain`,`dateDep`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `composition`
--

INSERT INTO `composition` (`numTrain`, `dateDep`, `Ass1`, `Ass2`, `Cch1`, `Cch2`) VALUES
(123, '2024-09-01 11:44:57', 10, 20, 2, 5);

-- --------------------------------------------------------

--
-- Structure de la table `exception`
--

DROP TABLE IF EXISTS `exception`;
CREATE TABLE IF NOT EXISTS `exception` (
  `numTrain` int NOT NULL,
  `dateDep` datetime NOT NULL,
  PRIMARY KEY (`numTrain`,`dateDep`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `exception`
--

INSERT INTO `exception` (`numTrain`, `dateDep`) VALUES
(124, '2024-09-27 09:47:41');

-- --------------------------------------------------------

--
-- Structure de la table `gare`
--

DROP TABLE IF EXISTS `gare`;
CREATE TABLE IF NOT EXISTS `gare` (
  `codeGare` int NOT NULL,
  `nomGare` varchar(50) DEFAULT NULL,
  `nomVille` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codeGare`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `gare`
--

INSERT INTO `gare` (`codeGare`, `nomGare`, `nomVille`) VALUES
(1, 'Montparnasse', 'Paris'),
(2, 'Saint lazare', 'Paris'),
(3, 'Redon', 'Redon'),
(4, 'Pardieu', 'Lyon'),
(15, 'Montparnasse', 'Paris'),
(16, 'Questembert', 'Questembert');

-- --------------------------------------------------------

--
-- Structure de la table `train`
--

DROP TABLE IF EXISTS `train`;
CREATE TABLE IF NOT EXISTS `train` (
  `numTrain` int NOT NULL,
  `codeGareDep` int DEFAULT NULL,
  `CodeGareARR` int DEFAULT NULL,
  `HDep` datetime DEFAULT NULL,
  `HArr` datetime DEFAULT NULL,
  `CodeTrf` char(1) DEFAULT NULL,
  PRIMARY KEY (`numTrain`),
  KEY `fk_gareDep` (`codeGareDep`),
  KEY `fk_gareArr` (`CodeGareARR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `train`
--

INSERT INTO `train` (`numTrain`, `codeGareDep`, `CodeGareARR`, `HDep`, `HArr`, `CodeTrf`) VALUES
(123, 1, 3, '2024-09-01 11:41:44', '2024-09-01 15:41:44', 'Q'),
(124, 3, 1, '2024-09-01 11:41:44', '2024-09-01 15:41:44', 'Q'),
(133, 15, 3, '2024-10-01 11:41:44', '2024-10-01 15:41:44', 'Q'),
(134, 15, 1, '2024-10-01 11:41:44', '2024-10-01 15:41:44', 'Q'),
(233, 16, 3, '2024-10-11 11:41:44', '2024-10-11 15:41:44', NULL),
(234, 16, 1, '2024-10-21 11:41:44', '2024-10-21 15:41:44', NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `composition`
--
ALTER TABLE `composition`
  ADD CONSTRAINT `fk_trainComp` FOREIGN KEY (`numTrain`) REFERENCES `train` (`numTrain`);

--
-- Contraintes pour la table `exception`
--
ALTER TABLE `exception`
  ADD CONSTRAINT `fk_trainExcep` FOREIGN KEY (`numTrain`) REFERENCES `train` (`numTrain`);

--
-- Contraintes pour la table `train`
--
ALTER TABLE `train`
  ADD CONSTRAINT `fk_gareArr` FOREIGN KEY (`CodeGareARR`) REFERENCES `gare` (`codeGare`),
  ADD CONSTRAINT `fk_gareDep` FOREIGN KEY (`codeGareDep`) REFERENCES `gare` (`codeGare`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
