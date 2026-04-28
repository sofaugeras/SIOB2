-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Ven 06 Mars 2026 à 15:30
-- Version du serveur :  5.7.14
-- Version de PHP :  7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gsb`
--
CREATE DATABASE IF NOT EXISTS `gsb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gsb`;

-- --------------------------------------------------------

--
-- Structure de la table `activite_compl`
--

CREATE TABLE `activite_compl` (
  `AC_NUM` int(11) DEFAULT NULL,
  `AC_DATE` datetime DEFAULT NULL,
  `AC_LIEU` varchar(25) DEFAULT NULL,
  `AC_THEME` varchar(10) DEFAULT NULL,
  `AC_MOTIF` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `composant`
--

CREATE TABLE `composant` (
  `CMP_CODE` varchar(4) DEFAULT NULL,
  `CMP_LIBELLE` varchar(25) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `constituer`
--

CREATE TABLE `constituer` (
  `MED_DEPOTLEGAL` varchar(10) DEFAULT NULL,
  `CMP_CODE` varchar(4) DEFAULT NULL,
  `CST_QTE` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `dosage`
--

CREATE TABLE `dosage` (
  `DOS_CODE` varchar(10) DEFAULT NULL,
  `DOS_QUANTITE` varchar(10) DEFAULT NULL,
  `DOS_UNITE` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `famille`
--

CREATE TABLE `famille` (
  `FAM_CODE` varchar(3) DEFAULT NULL,
  `FAM_LIBELLE` varchar(80) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `famille`
--

INSERT INTO `famille` (`FAM_CODE`, `FAM_LIBELLE`) VALUES
('AA', 'Antalgiques en association'),
('AAA', 'Antalgiques antipyrétiques en association'),
('AAC', 'Antidépresseur d action centrale'),
('AAH', 'Antivertigineux antihistaminique H1'),
('ABA', 'Antibiotique antituberculeux'),
('ABC', 'Antibiotique antiacnéique local'),
('ABP', 'Antibiotique de la famille des béta-lactamines (pénicilline A)'),
('AFC', 'Antibiotique de la famille des cyclines'),
('AFM', 'Antibiotique de la famille des macrolides'),
('AH', 'Antihistaminique H1 local'),
('AIM', 'Antidépresseur imipraminique (tricyclique)'),
('AIN', 'Antidépresseur inhibiteur sélectif de la recapture de la sérotonine'),
('ALO', 'Antibiotique local (ORL)'),
('ANS', 'Antidépresseur IMAO non sélectif'),
('AO', 'Antibiotique ophtalmique'),
('AP', 'Antipsychotique normothymique'),
('AUM', 'Antibiotique urinaire minute'),
('CRT', 'Corticoïde, antibiotique et antifongique à usage local'),
('HYP', 'Hypnotique antihistaminique'),
('PSA', 'Psychostimulant, antiasthénique');

-- --------------------------------------------------------

--
-- Structure de la table `formuler`
--

CREATE TABLE `formuler` (
  `MED_DEPOTLEGAL` varchar(10) DEFAULT NULL,
  `PRE_CODE` varchar(2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `interagir`
--

CREATE TABLE `interagir` (
  `MED_PERTURBATEUR` varchar(10) DEFAULT NULL,
  `MED_MED_PERTURBE` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `inviter`
--

CREATE TABLE `inviter` (
  `AC_NUM` int(11) DEFAULT NULL,
  `PRA_NUM` smallint(6) DEFAULT NULL,
  `SPECIALISTEON` bit(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `labo`
--

CREATE TABLE `labo` (
  `LAB_CODE` varchar(2) DEFAULT NULL,
  `LAB_NOM` varchar(10) DEFAULT NULL,
  `LAB_CHEFVENTE` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `labo`
--

INSERT INTO `labo` (`LAB_CODE`, `LAB_NOM`, `LAB_CHEFVENTE`) VALUES
('BC', 'Bichat', 'Suzanne Terminus'),
('GY', 'Gyverny', 'Marcel MacDouglas'),
('SW', 'Swiss Kane', 'Alain Poutre');

-- --------------------------------------------------------

--
-- Structure de la table `medicament`
--

CREATE TABLE `medicament` (
  `MED_DEPOTLEGAL` varchar(10) DEFAULT NULL,
  `MED_NOMCOMMERCIAL` varchar(25) DEFAULT NULL,
  `FAM_CODE` varchar(3) DEFAULT NULL,
  `MED_COMPOSITION` varchar(255) DEFAULT NULL,
  `MED_EFFETS` varchar(255) DEFAULT NULL,
  `MED_CONTREINDIC` varchar(255) DEFAULT NULL,
  `MED_PRIXECHANTILLON` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `medicament`
--

INSERT INTO `medicament` (`MED_DEPOTLEGAL`, `MED_NOMCOMMERCIAL`, `FAM_CODE`, `MED_COMPOSITION`, `MED_EFFETS`, `MED_CONTREINDIC`, `MED_PRIXECHANTILLON`) VALUES
('3MYC7', 'TRIMYCINE', 'CRT', 'Triamcinolone (acétonide) + Néomycine + Nystatine', 'Ce médicament est un corticoïde à  activité forte ou très forte associé à  un antibiotique et un antifongique, utilisé en application locale dans certaines atteintes cutanées surinfectées.', 'Ce médicament est contre-indiqué en cas d\'allergie à  l\'un des constituants, d\'infections de la peau ou de parasitisme non traités, d\'acné. Ne pas appliquer sur une plaie, ni sous un pansement occlusif.', 8.30),
('ADIMOL9', 'ADIMOL', 'ABP', 'Amoxicilline + Acide clavulanique', 'Ce médicament, plus puissant que les pénicillines simples, est utilisé pour traiter des infections bactériennes spécifiques.', 'Ce médicament est contre-indiqué en cas d\'allergie aux pénicillines ou aux céphalosporines.', 12.50),
('AMOPIL7', 'AMOPIL', 'ABP', 'Amoxicilline', 'Ce médicament, plus puissant que les pénicillines simples, est utilisé pour traiter des infections bactériennes spécifiques.', 'Ce médicament est contre-indiqué en cas d\'allergie aux pénicillines. Il doit être administré avec prudence en cas d\'allergie aux céphalosporines.', 8.90),
('AMOX45', 'AMOXAR', 'ABP', 'Amoxicilline', 'Ce médicament, plus puissant que les pénicillines simples, est utilisé pour traiter des infections bactériennes spécifiques.', 'La prise de ce médicament peut rendre positifs les tests de dépistage du dopage.', 7.80),
('AMOXIG12', 'AMOXI Gé', 'ABP', 'Amoxicilline', 'Ce médicament, plus puissant que les pénicillines simples, est utilisé pour traiter des infections bactériennes spécifiques.', 'Ce médicament est contre-indiqué en cas d\'allergie aux pénicillines. Il doit être administré avec prudence en cas d\'allergie aux céphalosporines.', 6.50),
('APATOUX22', 'APATOUX Vitamine C', 'ALO', 'Tyrothricine + Tétracaïne + Acide ascorbique (Vitamine C)', 'Ce médicament est utilisé pour traiter les affections de la bouche et de la gorge.', 'Ce médicament est contre-indiqué en cas d\'allergie à  l\'un des constituants, en cas de phénylcétonurie et chez l\'enfant de moins de 6 ans.', 4.50),
('BACTIG10', 'BACTIGEL', 'ABC', 'Erythromycine', 'Ce médicament est utilisé en application locale pour traiter l\'acné et les infections cutanées bactériennes associées.', 'Ce médicament est contre-indiqué en cas d\'allergie aux antibiotiques de la famille des macrolides ou des lincosanides.', 9.20),
('BACTIVIL13', 'BACTIVIL', 'AFM', 'Erythromycine', 'Ce médicament est utilisé pour traiter des infections bactériennes spécifiques.', 'Ce médicament est contre-indiqué en cas d\'allergie aux macrolides (dont le chef de file est l\'érythromycine).', 11.40),
('BITALV', 'BIVALIC', 'AAA', 'Dextropropoxyphène + Paracétamol', 'Ce médicament est utilisé pour traiter les douleurs d\'intensité modérée ou intense.', 'Ce médicament est contre-indiqué en cas d\'allergie aux médicaments de cette famille, d\'insuffisance hépatique ou d\'insuffisance rénale.', 4.80),
('CARTION6', 'CARTION', 'AAA', 'Acide acétylsalicylique (aspirine) + Acide ascorbique (Vitamine C) + Paracétamol', 'Ce médicament est utilisé dans le traitement symptomatique de la douleur ou de la fièvre.', 'Ce médicament est contre-indiqué en cas de troubles de la coagulation (tendances aux hémorragies), d\'ulcère gastroduodénal, maladies graves du foie.', 3.90),
('CLAZER6', 'CLAZER', 'AFM', 'Clarithromycine', 'Ce médicament est utilisé pour traiter des infections bactériennes spécifiques. Il est également utilisé dans le traitement de l\'ulcère gastro-duodénal, en association avec d\'autres médicaments.', 'Ce médicament est contre-indiqué en cas d\'allergie aux macrolides (dont le chef de file est l\'érythromycine).', 14.30),
('DEPRIL9', 'DEPRAMIL', 'AIM', 'Clomipramine', 'Ce médicament est utilisé pour traiter les épisodes dépressifs sévères, certaines douleurs rebelles, les troubles obsessionnels compulsifs et certaines énurésies chez l\'enfant.', 'Ce médicament est contre-indiqué en cas de glaucome ou d\'adénome de la prostate, d\'infarctus récent, ou si vous avez reà§u un traitement par IMAO durant les 2 semaines précédentes ou en cas d\'allergie aux antidépresseurs imipraminiques.', 22.50),
('DIMIRTAM6', 'DIMIRTAM', 'AAC', 'Mirtazapine', 'Ce médicament est utilisé pour traiter les épisodes dépressifs sévères.', 'La prise de ce produit est contre-indiquée en cas de d\'allergie à  l\'un des constituants.', 19.80),
('DOLRIL7', 'DOLORIL', 'AAA', 'Acide acétylsalicylique (aspirine) + Acide ascorbique (Vitamine C) + Paracétamol', 'Ce médicament est utilisé dans le traitement symptomatique de la douleur ou de la fièvre.', 'Ce médicament est contre-indiqué en cas d\'allergie au paracétamol ou aux salicylates.', 3.60),
('DORNOM8', 'NORMADOR', 'HYP', 'Doxylamine', 'Ce médicament est utilisé pour traiter l\'insomnie chez l\'adulte.', 'Ce médicament est contre-indiqué en cas de glaucome, de certains troubles urinaires (rétention urinaire) et chez l\'enfant de moins de 15 ans.', 6.90),
('EQUILARX6', 'EQUILAR', 'AAH', 'Méclozine', 'Ce médicament est utilisé pour traiter les vertiges et pour prévenir le mal des transports.', 'Ce médicament ne doit pas être utilisé en cas d\'allergie au produit, en cas de glaucome ou de rétention urinaire.', 5.20),
('EVILR7', 'EVEILLOR', 'PSA', 'Adrafinil', 'Ce médicament est utilisé pour traiter les troubles de la vigilance et certains symptomes neurologiques chez le sujet agé.', 'Ce médicament est contre-indiqué en cas d\'allergie à  l\'un des constituants.', 15.40),
('INSXT5', 'INSECTIL', 'AH', 'Diphénydramine', 'Ce médicament est utilisé en application locale sur les piqûres d\'insecte et l\'urticaire.', 'Ce médicament est contre-indiqué en cas d\'allergie aux antihistaminiques.', 4.10),
('JOVAI8', 'JOVENIL', 'AFM', 'Josamycine', 'Ce médicament est utilisé pour traiter des infections bactériennes spécifiques.', 'Ce médicament est contre-indiqué en cas d\'allergie aux macrolides (dont le chef de file est l\'érythromycine).', 13.60),
('LIDOXY23', 'LIDOXYTRACINE', 'AFC', 'Oxytétracycline +Lidocaïne', 'Ce médicament est utilisé en injection intramusculaire pour traiter certaines infections spécifiques.', 'Ce médicament est contre-indiqué en cas d\'allergie à  l\'un des constituants. Il ne doit pas être associé aux rétinoïdes.', 16.80),
('LITHOR12', 'LITHORINE', 'AP', 'Lithium', 'Ce médicament est indiqué dans la prévention des psychoses maniaco-dépressives ou pour traiter les états maniaques.', 'Ce médicament ne doit pas être utilisé si vous êtes allergique au lithium. Avant de prendre ce traitement, signalez à  votre médecin traitant si vous souffrez d\'insuffisance rénale, ou si vous avez un régime sans sel.', 17.60),
('PARMOL16', 'PARMOCODEINE', 'AA', 'Codéine + Paracétamol', 'Ce médicament est utilisé pour le traitement des douleurs lorsque des antalgiques simples ne sont pas assez efficaces.', 'Ce médicament est contre-indiqué en cas d\'allergie à  l\'un des constituants, chez l\'enfant de moins de 15 Kg, en cas d\'insuffisance hépatique ou respiratoire, d\'asthme, de phénylcétonurie et chez la femme qui allaite.', 5.40),
('PHYSOI8', 'PHYSICOR', 'PSA', 'Sulbutiamine', 'Ce médicament est utilisé pour traiter les baisses d\'activité physique ou psychique, souvent dans un contexte de dépression.', 'Ce médicament est contre-indiqué en cas d\'allergie à  l\'un des constituants.', 12.70),
('PIRIZ8', 'PIRIZAN', 'ABA', 'Pyrazinamide', 'Ce médicament est utilisé, en association à  d\'autres antibiotiques, pour traiter la tuberculose.', 'Ce médicament est contre-indiqué en cas d\'allergie à  l\'un des constituants, d\'insuffisance rénale ou hépatique, d\'hyperuricémie ou de porphyrie.', 18.90),
('POMDI20', 'POMADINE', 'AO', 'Bacitracine', 'Ce médicament est utilisé pour traiter les infections oculaires de la surface de l\'oeil.', 'Ce médicament est contre-indiqué en cas d\'allergie aux antibiotiques appliqués localement.', 5.60),
('TROXT21', 'TROXADET', 'AIN', 'Paroxétine', 'Ce médicament est utilisé pour traiter la dépression et les troubles obsessionnels compulsifs. Il peut également être utilisé en prévention des crises de panique avec ou sans agoraphobie.', 'Ce médicament est contre-indiqué en cas d\'allergie au produit.', 24.10),
('TXISOL22', 'TOUXISOL Vitamine C', 'ALO', 'Tyrothricine + Acide ascorbique (Vitamine C)', 'Ce médicament est utilisé pour traiter les affections de la bouche et de la gorge.', 'Ce médicament est contre-indiqué en cas d\'allergie à  l\'un des constituants et chez l\'enfant de moins de 6 ans.', 3.80),
('URIEG6', 'URIREGUL', 'AUM', 'Fosfomycine trométamol', 'Ce médicament est utilisé pour traiter les infections urinaires simples chez la femme de moins de 65 ans.', 'La prise de ce médicament est contre-indiquée en cas d\'allergie à  l\'un des constituants, d\'insuffisance rénale sévère, de phénylcétonurie et chez la femme enceinte ou qui allaite.', 7.20);

--
-- Structure de la table `offrir`
--

CREATE TABLE `offrir` (
  `VIS_MATRICULE` varchar(10) DEFAULT NULL,
  `RAP_NUM` int(11) DEFAULT NULL,
  `MED_DEPOTLEGAL` varchar(10) DEFAULT NULL,
  `OFF_QTE` smallint(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `offrir`

INSERT INTO `offrir` (`VIS_MATRICULE`, `RAP_NUM`, `MED_DEPOTLEGAL`, `OFF_QTE`) VALUES
('v019', 1, 'LIDOXY23', 3),
('v001', 2, 'BACTIV13', 8),
('v001', 2, 'ADIMOL9', 2),
('v001', 2, 'AMOX45', 2),
('v001', 3, 'LITHOR12', 4),
('v001', 3, 'EQUILARX6', 5),
('v004', 4, 'LITHOR12', 1),
('v018', 5, 'ADIMOL9', 2),
('v019', 6, 'CARTION6', 5),
('v004', 7, 'AMOXIG12', 4),
('v004', 7, 'URIEG6', 3),
('v015', 8, 'DORNOM8', 5),
('v015', 8, 'LITHOR12', 4),
('v015', 8, 'BITALV', 3),
('v003', 9, 'CLAZER6', 2),
('v003', 9, 'AMOPIL7', 8),
('v003', 9, 'DIMIRTAM6', 5),
('v019', 10, 'BACTIV13', 4),
('v019', 10, 'DORNOM8', 1),
('v004', 11, 'ADIMOL9', 4),
('v002', 12, 'PHYSOI8', 3),
('v002', 12, 'AMOX45', 3),
('v021', 13, 'PIRIZ8', 8),
('v021', 13, 'LIDOXY23', 3),
('v013', 14, 'DORNOM8', 2),
('v013', 14, 'EVILR7', 1),
('v013', 14, 'PHYSOI8', 3),
('v009', 15, 'URIEG6', 3),
('v009', 15, 'EVILR7', 8),
('v002', 16, 'DORNOM8', 8),
('v009', 17, 'TROXT21', 4),
('v009', 17, 'CARTION6', 1),
('v009', 17, 'PIRIZ8', 3),
('v009', 18, 'PHYSOI8', 2),
('v009', 18, 'AMOPIL7', 8),
('v001', 19, 'POMDI20', 6),
('v007', 20, 'PARMOL16', 5),
('v002', 21, 'AMOXIG12', 4),
('v002', 21, 'PIRIZ8', 8),
('v002', 21, 'BACTIV13', 6),
('v008', 22, 'DEPRIL9', 2),
('v008', 22, 'AMOXIG12', 1),
('v015', 23, 'BACTIV13', 2),
('v010', 24, 'PHYSOI8', 6),
('v010', 24, 'URIEG6', 8),
('v010', 24, 'ADIMOL9', 3),
('v009', 25, 'CARTION6', 5),
('v009', 25, 'BACTIV13', 3),
('v009', 25, 'TXISOL22', 4),
('v017', 26, 'CARTION6', 6),
('v017', 26, 'BITALV', 8),
('v001', 27, 'DIMIRTAM6', 6),
('v001', 27, 'TROXT21', 2),
('v001', 27, 'EVILR7', 4),
('v006', 28, 'URIEG6', 2),
('v015', 29, 'DOLRIL7', 6),
('v015', 29, 'INSXT5', 3),
('v004', 30, 'DORNOM8', 3),
('v001', 31, 'LIDOXY23', 3),
('v001', 31, 'ADIMOL9', 8),
('v001', 31, 'URIEG6', 3),
('v016', 32, 'BACTIG10', 8),
('v018', 33, 'DIMIRTAM6', 4),
('v006', 34, 'CARTION6', 8),
('v006', 34, 'BITALV', 2),
('v015', 35, 'BACTIG10', 1),
('v015', 35, 'DEPRIL9', 3),
('v013', 36, 'JOVAI8', 3),
('v013', 36, 'PIRIZ8', 5),
('v013', 36, 'DOLRIL7', 3),
('v006', 37, 'LITHOR12', 8),
('v006', 37, 'PARMOL16', 8),
('v006', 37, 'CLAZER6', 2),
('v013', 38, 'PIRIZ8', 2),
('v018', 39, 'EVILR7', 1),
('v013', 40, 'BACTIV13', 3),
('v013', 40, 'AMOPIL7', 8),
('v013', 40, 'PHYSOI8', 5),
('v001', 41, 'EQUILARX6', 1),
('v001', 41, '3MYC7', 1),
('v001', 41, 'INSXT5', 4),
('v009', 42, 'TXISOL22', 2),
('v009', 42, 'PHYSOI8', 2),
('v009', 42, 'PARMOL16', 2),
('v004', 43, 'TXISOL22', 2),
('v004', 43, 'DEPRIL9', 5),
('v021', 44, 'PHYSOI8', 2),
('v011', 45, 'DIMIRTAM6', 1),
('v011', 45, 'INSXT5', 2),
('v001', 46, 'JOVAI8', 3),
('v001', 46, 'URIEG6', 3),
('v018', 47, 'ADIMOL9', 2),
('v018', 47, 'AMOPIL7', 5),
('v001', 48, 'POMDI20', 4),
('v002', 49, 'PARMOL16', 2),
('v002', 49, 'INSXT5', 2),
('v008', 50, 'DOLRIL7', 5),
('v010', 51, 'POMDI20', 8),
('v010', 51, 'CLAZER6', 8),
('v003', 52, 'APATOUX22', 2),
('v003', 52, 'PARMOL16', 4),
('v014', 53, 'AMOXIG12', 5),
('v014', 53, 'DIMIRTAM6', 5),
('v002', 54, 'DEPRIL9', 2),
('v002', 54, 'POMDI20', 2),
('v003', 55, 'EVILR7', 5),
('v003', 55, 'DOLRIL7', 2),
('v003', 55, 'AMOX45', 5),
('v016', 56, 'DIMIRTAM6', 2),
('v016', 56, 'POMDI20', 6),
('v003', 57, 'EQUILARX6', 6),
('v003', 57, 'AMOXIG12', 4),
('v006', 58, 'BITALV', 8),
('v006', 58, 'BACTIV13', 2),
('v002', 59, 'TXISOL22', 8),
('v002', 59, 'LIDOXY23', 5),
('v007', 60, 'CLAZER6', 5),
('v007', 60, 'LIDOXY23', 2),
('v021', 61, 'PHYSOI8', 5),
('v021', 61, 'LITHOR12', 6),
('v021', 61, 'EQUILARX6', 4),
('v015', 62, 'JOVAI8', 1),
('v020', 63, 'DORNOM8', 6),
('v011', 64, 'BACTIV13', 6),
('v011', 64, 'BITALV', 2),
('v007', 65, 'DIMIRTAM6', 5),
('v007', 65, 'INSXT5', 2),
('v007', 65, 'EVILR7', 2),
('v014', 66, 'LIDOXY23', 6),
('v014', 66, 'ADIMOL9', 2),
('v014', 66, 'JOVAI8', 1),
('v002', 67, 'EVILR7', 8),
('v002', 67, 'INSXT5', 5),
('v002', 67, 'JOVAI8', 6),
('v007', 68, 'AMOXIG12', 4),
('v007', 68, 'DEPRIL9', 6),
('v007', 68, '3MYC7', 2),
('v002', 69, 'CLAZER6', 5),
('v002', 69, 'DORNOM8', 8),
('v002', 70, 'CARTION6', 1),
('v016', 71, 'PIRIZ8', 2),
('v005', 72, 'TROXT21', 2),
('v011', 73, 'PIRIZ8', 8),
('v010', 74, 'BACTIG10', 2),
('v010', 74, 'BITALV', 5),
('v010', 74, 'POMDI20', 5),
('v003', 75, 'URIEG6', 6),
('v003', 75, 'EQUILARX6', 2),
('v003', 75, 'EVILR7', 5),
('v005', 76, 'TXISOL22', 2),
('v005', 77, 'APATOUX22', 6),
('v006', 78, 'DOLRIL7', 2),
('v006', 78, 'APATOUX22', 8),
('v004', 79, 'LIDOXY23', 8),
('v004', 79, 'ADIMOL9', 2),
('v003', 80, 'LITHOR12', 8),
('v003', 80, 'EQUILARX6', 8),
('v003', 80, 'DOLRIL7', 2),
('v001', 81, 'CARTION6', 3),
('v009', 82, 'PIRIZ8', 2),
('v009', 82, 'POMDI20', 4),
('v009', 82, 'EQUILARX6', 5),
('v009', 83, 'DORNOM8', 3),
('v009', 83, 'INSXT5', 4),
('v009', 83, 'BACTIG10', 1),
('v007', 84, 'URIEG6', 5),
('v007', 84, 'AMOX45', 6),
('v003', 85, 'TROXT21', 4),
('v010', 86, 'CARTION6', 2),
('v010', 86, 'JOVAI8', 6),
('v010', 86, 'BITALV', 1),
('v025', 87, 'BACTIV13', 3),
('v013', 88, 'JOVAI8', 6),
('v007', 89, 'PIRIZ8', 8),
('v007', 89, 'BITALV', 5),
('v007', 89, 'PHYSOI8', 1),
('v016', 90, 'LITHOR12', 6),
('v016', 90, 'PARMOL16', 3),
('v022', 91, 'CLAZER6', 2),
('v022', 91, 'TXISOL22', 8),
('v014', 92, 'LITHOR12', 2),
('v019', 93, '3MYC7', 4),
('v019', 93, 'DOLRIL7', 2),
('v017', 94, 'DEPRIL9', 1),
('v017', 94, 'BITALV', 6),
('v017', 94, 'AMOPIL7', 4),
('v013', 95, 'AMOPIL7', 8),
('v013', 95, 'PHYSOI8', 2),
('v013', 95, 'AMOX45', 2),
('v010', 96, '3MYC7', 6),
('v010', 96, 'PHYSOI8', 2),
('v007', 97, 'PIRIZ8', 5),
('v006', 98, 'POMDI20', 2),
('v006', 98, 'TXISOL22', 1),
('v010', 99, 'PIRIZ8', 8),
('v010', 99, 'BACTIG10', 3),
('v002', 100, 'JOVAI8', 6),
('v005', 101, 'LITHOR12', 1),
('v005', 101, 'AMOPIL7', 4),
('v003', 102, 'PIRIZ8', 1),
('v014', 103, 'AMOX45', 1),
('v014', 103, 'BACTIV13', 5),
('v019', 104, 'DOLRIL7', 2),
('v019', 104, 'DEPRIL9', 1),
('v019', 104, 'INSXT5', 2),
('v001', 105, 'TROXT21', 6),
('v007', 106, 'INSXT5', 4),
('v007', 106, 'LIDOXY23', 2),
('v007', 106, 'AMOXIG12', 3),
('v023', 107, 'DIMIRTAM6', 6),
('v023', 107, 'JOVAI8', 3),
('v001', 108, 'DORNOM8', 4),
('v011', 109, 'PHYSOI8', 2),
('v008', 110, 'TROXT21', 5),
('v008', 110, 'TXISOL22', 2),
('v008', 110, 'PIRIZ8', 4),
('v013', 111, 'CLAZER6', 2),
('v004', 112, 'EQUILARX6', 1),
('v008', 113, 'APATOUX22', 3),
('v008', 113, 'BITALV', 1),
('v001', 114, 'EQUILARX6', 2),
('v003', 115, 'PIRIZ8', 3),
('v003', 115, 'LITHOR12', 6),
('v003', 115, 'DOLRIL7', 5),
('v004', 116, 'AMOX45', 3),
('v004', 116, 'EVILR7', 1),
('v020', 117, 'POMDI20', 2),
('v020', 117, 'URIEG6', 8),
('v001', 118, 'TROXT21', 8),
('v001', 118, 'CARTION6', 5),
('v001', 118, 'PIRIZ8', 8),
('v025', 119, 'POMDI20', 6),
('v025', 119, 'TROXT21', 1),
('v025', 119, 'BACTIV13', 3),
('v009', 120, 'POMDI20', 2),
('v003', 121, 'ADIMOL9', 1),
('v003', 121, 'AMOXIG12', 3),
('v018', 122, 'DEPRIL9', 2),
('v018', 122, 'DORNOM8', 6),
('v018', 122, 'PIRIZ8', 2),
('v010', 123, 'AMOXIG12', 6),
('v010', 123, 'BACTIV13', 5),
('v010', 123, 'CARTION6', 5),
('v007', 124, 'AMOXIG12', 2),
('v002', 125, 'DOLRIL7', 3),
('v002', 125, 'AMOX45', 8),
('v005', 126, 'APATOUX22', 3),
('v015', 127, 'PHYSOI8', 6),
('v008', 128, '3MYC7', 3),
('v002', 129, '3MYC7', 2),
('v003', 130, 'LITHOR12', 2),
('v003', 130, 'AMOPIL7', 1),
('v003', 130, 'JOVAI8', 2),
('v003', 131, 'URIEG6', 1),
('v020', 132, 'DOLRIL7', 1),
('v020', 132, 'TXISOL22', 6),
('v020', 132, 'PIRIZ8', 6),
('v003', 133, 'BITALV', 3),
('v003', 133, 'DORNOM8', 4),
('v008', 134, 'AMOPIL7', 2),
('v006', 135, 'TROXT21', 8),
('v006', 135, 'INSXT5', 8),
('v006', 135, '3MYC7', 5),
('v018', 136, 'BITALV', 3),
('v018', 136, 'APATOUX22', 1),
('v017', 137, 'EVILR7', 2),
('v017', 137, 'DEPRIL9', 2),
('v004', 138, 'TXISOL22', 6),
('v004', 138, 'TROXT21', 5),
('v004', 138, 'PIRIZ8', 2),
('v003', 139, 'PHYSOI8', 2),
('v003', 139, 'DEPRIL9', 3),
('v003', 139, 'JOVAI8', 8),
('v009', 140, 'AMOPIL7', 3),
('v001', 141, 'LIDOXY23', 2),
('v001', 141, 'BACTIG10', 5),
('v001', 142, 'AMOXIG12', 2),
('v001', 142, 'POMDI20', 5),
('v001', 142, 'AMOX45', 6),
('v009', 143, 'AMOXIG12', 5),
('v009', 143, 'APATOUX22', 2),
('v012', 144, 'TROXT21', 6),
('v012', 144, 'DEPRIL9', 4),
('v012', 144, 'BACTIV13', 4),
('v002', 145, 'DIMIRTAM6', 2),
('v002', 145, 'URIEG6', 5),
('v002', 145, 'POMDI20', 3),
('v011', 146, 'CLAZER6', 5),
('v023', 147, 'TXISOL22', 1),
('v004', 148, 'DEPRIL9', 1),
('v001', 149, 'APATOUX22', 5),
('v001', 149, 'DOLRIL7', 6),
('v002', 150, 'POMDI20', 2),
('v002', 150, 'PARMOL16', 1),
('v002', 150, 'BACTIV13', 4);

-- --------------------------------------------------------

--
-- Structure de la table `posseder`
--

CREATE TABLE `posseder` (
  `PRA_NUM` smallint(6) DEFAULT NULL,
  `SPE_CODE` varchar(5) DEFAULT NULL,
  `POS_DIPLOME` varchar(10) DEFAULT NULL,
  `POS_COEFPRESCRIPTION` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `praticien`
--

CREATE TABLE `praticien` (
  `PRA_NUM` smallint(6) DEFAULT NULL,
  `PRA_NOM` varchar(25) DEFAULT NULL,
  `PRA_PRENOM` varchar(30) DEFAULT NULL,
  `PRA_ADRESSE` varchar(50) DEFAULT NULL,
  `PRA_CP` varchar(5) DEFAULT NULL,
  `PRA_VILLE` varchar(25) DEFAULT NULL,
  `PRA_COEFNOTORIETE` float DEFAULT NULL,
  `TYP_CODE` varchar(3) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `praticien`

INSERT INTO `praticien` (`PRA_NUM`, `PRA_NOM`, `PRA_PRENOM`, `PRA_ADRESSE`, `PRA_CP`, `PRA_VILLE`, `PRA_COEFNOTORIETE`, `TYP_CODE`) VALUES
(1, 'Le Gall', 'Élise', '53 place du Marché', '75015', 'Paris', 302.15, 'MH'),
(2, 'Benamar', 'Karim', '111 rue de la République', '69003', 'Lyon', 535.86, 'MV'),
(3, 'Rossi', 'Giulia', '22 rue de la République', '13006', 'Marseille', 36.2, 'PH'),
(4, 'Durand', 'Paul', '50 rue des Écoles', '31000', 'Toulouse', 549.22, 'PO'),
(5, 'Nguyen', 'Linh', '101 place du Marché', '44000', 'Nantes', 193.31, 'PS'),
(6, 'Cohen', 'Sarah', '90 rue Paul-Bert', '67000', 'Strasbourg', 402.34, 'MH'),
(7, 'Lemoine', 'Mathieu', '63 rue Pasteur', '59000', 'Lille', 140.39, 'MV'),
(8, 'Fernandes', 'Ana', '28 rue des Tilleuls', '35000', 'Rennes', 356.45, 'PH'),
(9, 'Pruvost', 'Juliette', '70 rue des Tilleuls', '34000', 'Montpellier', 450.13, 'PO'),
(10, 'Gauthier', 'Nicolas', '8 rue des Tilleuls', '33000', 'Bordeaux', 359.22, 'PS'),
(11, 'Da Silva', 'João', '65 rue Paul-Bert', '06000', 'Nice', 122.38, 'MH'),
(12, 'Keller', 'Clara', '66 avenue du Général-Leclerc', '54000', 'Nancy', 507.5, 'MV'),
(13, 'Bousquet', 'Amandine', '9 allée des Roses', '14000', 'Caen', 72.72, 'PH'),
(14, 'Charpentier', 'Louis', '111 boulevard Saint-Michel', '80000', 'Amiens', 259.1, 'PO'),
(15, 'Brahimi', 'Sami', '114 allée des Roses', '37000', 'Tours', 171.65, 'PS'),
(16, 'Meyer', 'Mila', '77 rue des Tilleuls', '21000', 'Dijon', 378.76, 'MH'),
(17, 'Carpentier', 'Vincent', '54 allée des Roses', '29200', 'Brest', 348.7, 'MV'),
(18, 'M\'Baye', 'Aïcha', '41 rue des Écoles', '63000', 'Clermont-Ferrand', 148.36, 'PH'),
(19, 'Boucher', 'Arthur', '92 avenue Victor-Hugo', '51100', 'Reims', 167.47, 'PO'),
(20, 'Ait Ali', 'Leïla', '51 rue Pasteur', '38100', 'Grenoble', 407.79, 'PS'),
(21, 'Marchal', 'Jeanne', '39 place du Marché', '75015', 'Paris', 210.48, 'MH'),
(22, 'Noël', 'Olivier', '97 avenue du Général-Leclerc', '69003', 'Lyon', 40.17, 'MV'),
(23, 'Sanchez', 'Inès', '80 allée des Roses', '13006', 'Marseille', 587.83, 'PH'),
(24, 'Poirier', 'Bastien', '10 rue Paul-Bert', '31000', 'Toulouse', 153.3, 'PO'),
(25, 'Renard', 'Nora', '34 rue Pasteur', '44000', 'Nantes', 552.96, 'PS'),
(26, 'Diallo', 'Moussa', '113 avenue du Général-Leclerc', '67000', 'Strasbourg', 522.99, 'MH'),
(27, 'Leclerc', 'Claire', '48 rue des Écoles', '59000', 'Lille', 122.55, 'MV'),
(28, 'Perrin', 'Damien', '107 rue Paul-Bert', '35000', 'Rennes', 425.46, 'PH'),
(29, 'Masson', 'Emma', '79 rue Paul-Bert', '34000', 'Montpellier', 39.34, 'PO'),
(30, 'Rodrigues', 'Tiago', '105 rue Paul-Bert', '33000', 'Bordeaux', 201.16, 'PS'),
(31, 'Armand', 'Luc', '85 avenue du Général-Leclerc', '06000', 'Nice', 556.11, 'MH'),
(32, 'Blin', 'Éva', '18 rue des Écoles', '54000', 'Nancy', 99.06, 'MV'),
(33, 'Haddad', 'Nabil', '14 rue Paul-Bert', '14000', 'Caen', 121.27, 'PH'),
(34, 'Schmitt', 'Héloïse', '37 allée des Roses', '80000', 'Amiens', 151.9, 'PO'),
(35, 'Bourgeois', 'Romain', '44 boulevard Saint-Michel', '37000', 'Tours', 416.56, 'PS'),
(36, 'Hamdi', 'Sana', '110 rue des Écoles', '21000', 'Dijon', 315.5, 'MH'),
(37, 'Paris', 'Maël', '33 rue des Tilleuls', '29200', 'Brest', 86.23, 'MV'),
(38, 'Ribeiro', 'Rita', '55 rue des Écoles', '63000', 'Clermont-Ferrand', 59.47, 'PH'),
(39, 'Gilbert', 'Gabriel', '43 rue Pasteur', '51100', 'Reims', 388.6, 'PO'),
(40, 'Martins', 'Luna', '34 rue Pasteur', '38100', 'Grenoble', 446.38, 'PS'),
(41, 'Barbier', 'Zoé', '71 rue de la République', '75015', 'Paris', 346.3, 'MH'),
(42, 'Rey', 'Victor', '15 avenue du Général-Leclerc', '69003', 'Lyon', 559.5, 'MV'),
(43, 'Kone', 'Fatou', '89 rue Pasteur', '13006', 'Marseille', 337.8, 'PH'),
(44, 'Moulin', 'Alice', '107 avenue Victor-Hugo', '31000', 'Toulouse', 358.29, 'PO'),
(45, 'Briand', 'Yanis', '19 rue de la République', '44000', 'Nantes', 105.73, 'PS'),
(46, 'Aubry', 'Marion', '40 avenue Victor-Hugo', '67000', 'Strasbourg', 533.93, 'MH'),
(47, 'Hoarau', 'Noa', '102 rue des Tilleuls', '59000', 'Lille', 533.9, 'MV'),
(48, 'Morin', 'Hugo', '27 boulevard Saint-Michel', '35000', 'Rennes', 405.15, 'PH'),
(49, 'Teixeira', 'Inaya', '46 rue Paul-Bert', '34000', 'Montpellier', 525.69, 'PO'),
(50, 'Aubertin', 'Théo', '53 allée des Roses', '33000', 'Bordeaux', 450.96, 'PS'),
(51, 'Gomes', 'Catarina', '119 boulevard Saint-Michel', '06000', 'Nice', 514.86, 'MH'),
(52, 'Lamy', 'Jade', '103 rue Pasteur', '54000', 'Nancy', 524.19, 'MV'),
(53, 'Bensaïd', 'Amine', '4 rue Pasteur', '14000', 'Caen', 443.79, 'PH'),
(54, 'Guillot', 'Agathe', '43 rue de la République', '80000', 'Amiens', 480.24, 'PO'),
(55, 'Munoz', 'Diego', '111 boulevard Saint-Michel', '37000', 'Tours', 183.08, 'PS'),
(56, 'Colas', 'Lisa', '101 avenue du Général-Leclerc', '21000', 'Dijon', 247.31, 'MH'),
(57, 'Tavares', 'Mateus', '5 place du Marché', '29200', 'Brest', 158.45, 'MV'),
(58, 'Rivière', 'Chloé', '105 place du Marché', '63000', 'Clermont-Ferrand', 229.06, 'PH'),
(59, 'Klein', 'Jonas', '106 boulevard Saint-Michel', '51100', 'Reims', 158.72, 'PO'),
(60, 'Mallet', 'Anaïs', '85 boulevard Saint-Michel', '38100', 'Grenoble', 256.15, 'PS'),
(61, 'Leroux', 'Tom', '36 avenue du Général-Leclerc', '75015', 'Paris', 571.62, 'MH'),
(62, 'Bonnin', 'Lou', '36 avenue Victor-Hugo', '69003', 'Lyon', 391.02, 'MV'),
(63, 'Sow', 'Mamadou', '52 rue Paul-Bert', '13006', 'Marseille', 218.79, 'PH'),
(64, 'Vidal', 'Iris', '4 avenue du Général-Leclerc', '31000', 'Toulouse', 521.76, 'PO'),
(65, 'Marin', 'Marius', '34 rue Pasteur', '44000', 'Nantes', 357.23, 'PS'),
(66, 'Prevost', 'Salomé', '34 rue des Tilleuls', '67000', 'Strasbourg', 95.16, 'MH'),
(67, 'Lopes', 'Rafael', '56 avenue Victor-Hugo', '59000', 'Lille', 439.34, 'MV'),
(68, 'Aoun', 'Maya', '41 rue de la République', '35000', 'Rennes', 371.45, 'PH'),
(69, 'Lefort', 'Axel', '66 avenue du Général-Leclerc', '34000', 'Montpellier', 248.78, 'PO'),
(70, 'Renaudin', 'Clémence', '74 boulevard Saint-Michel', '33000', 'Bordeaux', 176.37, 'PS'),
(71, 'Tran', 'Bao', '91 rue de la République', '06000', 'Nice', 35.94, 'MH'),
(72, 'Perrot', 'Léa', '119 rue Paul-Bert', '54000', 'Nancy', 416.21, 'MV'),
(73, 'Delmas', 'Raphaël', '95 boulevard Saint-Michel', '14000', 'Caen', 237.14, 'PH'),
(74, 'Khelifi', 'Sofiane', '9 avenue Victor-Hugo', '80000', 'Amiens', 380.85, 'PO'),
(75, 'Jacquet', 'Cécile', '85 avenue du Général-Leclerc', '37000', 'Tours', 434.46, 'PS'),
(76, 'Ba', 'Ousmane', '39 rue Paul-Bert', '21000', 'Dijon', 206.65, 'MH'),
(77, 'Bourdon', 'Yvonne', '53 avenue Victor-Hugo', '29200', 'Brest', 258.33, 'MV'),
(78, 'Ferrand', 'Loris', '38 rue Paul-Bert', '63000', 'Clermont-Ferrand', 105.64, 'PH'),
(79, 'Salmon', 'Mélanie', '54 rue de la République', '51100', 'Reims', 410.91, 'PO'),
(80, 'Yilmaz', 'Emre', '116 rue Pasteur', '38100', 'Grenoble', 376.61, 'PS');

-- --------------------------------------------------------

--
-- Structure de la table `prescrire`
--

CREATE TABLE `prescrire` (
  `MED_DEPOTLEGAL` varchar(10) DEFAULT NULL,
  `TIN_CODE` varchar(5) DEFAULT NULL,
  `DOS_CODE` varchar(10) DEFAULT NULL,
  `PRE_POSOLOGIE` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `presentation`
--

CREATE TABLE `presentation` (
  `PRE_CODE` varchar(2) DEFAULT NULL,
  `PRE_LIBELLE` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `rapport_visite`
--

CREATE TABLE `rapport_visite` (
  `VIS_MATRICULE` varchar(10) DEFAULT NULL,
  `RAP_NUM` int(11) DEFAULT NULL,
  `PRA_NUM` smallint(6) DEFAULT NULL,
  `RAP_DATE` datetime DEFAULT NULL,
  `RAP_BILAN` varchar(255) DEFAULT NULL,
  `RAP_MOTIF` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `rapport_visite`

INSERT INTO `rapport_visite` (`VIS_MATRICULE`, `RAP_NUM`, `PRA_NUM`, `RAP_DATE`, `RAP_BILAN`, `RAP_MOTIF`) VALUES
('v019', 1, 35, '2024-05-20 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter LIDOXY23. Contact professionnel et disponible.', 'Actualisation dossier praticien'),
('v001', 2, 68, '2024-08-19 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de BACTIV13. Une nouvelle visite sera programmée.', 'Point de suivi trimestriel'),
('v001', 3, 71, '2024-06-10 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter LITHOR12. Contact professionnel et disponible.', 'Présentation nouvelle indication'),
('v004', 4, 8, '2026-02-26 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter LITHOR12. Contact professionnel et disponible.', 'Actualisation dossier praticien'),
('v018', 5, 23, '2025-03-03 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de ADIMOL9.', 'Point de suivi trimestriel'),
('v019', 6, 38, '2024-02-08 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur CARTION6. Bon niveau d\'écoute pendant l\'entretien.', 'Actualisation dossier praticien'),
('v004', 7, 70, '2025-06-20 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de AMOXIG12.', 'Visite de courtoisie'),
('v015', 8, 43, '2024-06-15 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour DORNOM8. Une relance est à prévoir dans 6 semaines.', 'Mise à jour coordonnées'),
('v003', 9, 52, '2025-03-13 00:00:00', 'Retour globalement positif sur CLAZER6. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Suivi prescription'),
('v019', 10, 1, '2024-09-24 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de BACTIV13. Une nouvelle visite sera programmée.', 'Préparation réunion scientifique'),
('v004', 11, 47, '2025-12-10 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de ADIMOL9.', 'Suivi prescription'),
('v002', 12, 65, '2025-12-21 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de PHYSOI8. Une nouvelle visite sera programmée.', 'Préparation réunion scientifique'),
('v021', 13, 62, '2024-06-05 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie PIRIZ8 comme une option pertinente dans certains cas.', 'Retour d\'expérience'),
('v013', 14, 77, '2024-03-24 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur DORNOM8. Bon niveau d\'écoute pendant l\'entretien.', 'Retour d\'expérience'),
('v009', 15, 20, '2024-06-17 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur URIEG6. Bon niveau d\'écoute pendant l\'entretien.', 'Présentation nouvelle indication'),
('v002', 16, 66, '2025-04-01 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie DORNOM8 comme une option pertinente dans certains cas.', 'Mise à jour coordonnées'),
('v009', 17, 72, '2025-04-18 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie TROXT21 comme une option pertinente dans certains cas.', 'Présentation produit'),
('v009', 18, 6, '2025-03-09 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour PHYSOI8. Une relance est à prévoir dans 6 semaines.', 'Visite de courtoisie'),
('v001', 19, 53, '2024-07-03 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de POMDI20. Une nouvelle visite sera programmée.', 'Point de suivi trimestriel'),
('v007', 20, 49, '2025-01-19 00:00:00', 'Retour globalement positif sur PARMOL16. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Visite de courtoisie'),
('v002', 21, 69, '2025-02-06 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour AMOXIG12. Une relance est à prévoir dans 6 semaines.', 'Présentation produit'),
('v008', 22, 30, '2024-09-10 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter DEPRIL9. Contact professionnel et disponible.', 'Préparation réunion scientifique'),
('v015', 23, 54, '2025-09-21 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur BACTIV13. Bon niveau d\'écoute pendant l\'entretien.', 'Information thérapeutique'),
('v010', 24, 58, '2025-09-04 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour PHYSOI8. Une relance est à prévoir dans 6 semaines.', 'Information thérapeutique'),
('v009', 25, 8, '2024-05-23 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de CARTION6. Une nouvelle visite sera programmée.', 'Actualisation dossier praticien'),
('v017', 26, 67, '2024-08-14 00:00:00', 'Retour globalement positif sur CARTION6. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Présentation produit'),
('v001', 27, 45, '2025-10-20 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie DIMIRTAM6 comme une option pertinente dans certains cas.', 'Retour d\'expérience'),
('v006', 28, 69, '2025-04-29 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de URIEG6. Le praticien souhaite comparer avec des alternatives.', 'Information thérapeutique'),
('v015', 29, 8, '2025-07-29 00:00:00', 'Retour globalement positif sur DOLRIL7. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Visite de courtoisie'),
('v004', 30, 43, '2025-10-24 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur DORNOM8. Bon niveau d\'écoute pendant l\'entretien.', 'Retour d\'expérience'),
('v001', 31, 49, '2025-11-20 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter LIDOXY23. Contact professionnel et disponible.', 'Suivi prescription'),
('v016', 32, 43, '2024-11-06 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur BACTIG10. Bon niveau d\'écoute pendant l\'entretien.', 'Information thérapeutique'),
('v018', 33, 78, '2025-12-21 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de DIMIRTAM6. Une nouvelle visite sera programmée.', 'Information thérapeutique'),
('v006', 34, 69, '2025-10-26 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de CARTION6.', 'Retour d\'expérience'),
('v015', 35, 61, '2026-02-18 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie BACTIG10 comme une option pertinente dans certains cas.', 'Retour d\'expérience'),
('v013', 36, 3, '2024-09-24 00:00:00', 'Retour globalement positif sur JOVAI8. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Préparation réunion scientifique'),
('v006', 37, 32, '2025-05-26 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de LITHOR12.', 'Préparation réunion scientifique'),
('v013', 38, 46, '2024-06-22 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de PIRIZ8.', 'Visite de courtoisie'),
('v018', 39, 70, '2025-10-19 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur EVILR7. Bon niveau d\'écoute pendant l\'entretien.', 'Présentation produit'),
('v013', 40, 53, '2024-05-20 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour BACTIV13. Une relance est à prévoir dans 6 semaines.', 'Mise à jour coordonnées'),
('v001', 41, 79, '2025-05-09 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie EQUILARX6 comme une option pertinente dans certains cas.', 'Visite de courtoisie'),
('v009', 42, 37, '2024-01-18 00:00:00', 'Retour globalement positif sur TXISOL22. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Point de suivi trimestriel'),
('v004', 43, 80, '2025-06-23 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie TXISOL22 comme une option pertinente dans certains cas.', 'Préparation réunion scientifique'),
('v021', 44, 59, '2025-08-01 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de PHYSOI8. Le praticien souhaite comparer avec des alternatives.', 'Information thérapeutique'),
('v011', 45, 5, '2024-04-05 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour DIMIRTAM6. Une relance est à prévoir dans 6 semaines.', 'Présentation nouvelle indication'),
('v001', 46, 56, '2025-10-22 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour JOVAI8. Une relance est à prévoir dans 6 semaines.', 'Suivi prescription'),
('v018', 47, 73, '2025-05-01 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour ADIMOL9. Une relance est à prévoir dans 6 semaines.', 'Préparation réunion scientifique'),
('v001', 48, 27, '2025-08-24 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur POMDI20. Bon niveau d\'écoute pendant l\'entretien.', 'Point de suivi trimestriel'),
('v002', 49, 31, '2025-08-03 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie PARMOL16 comme une option pertinente dans certains cas.', 'Retour d\'expérience'),
('v008', 50, 45, '2024-02-24 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur DOLRIL7. Bon niveau d\'écoute pendant l\'entretien.', 'Information thérapeutique'),
('v010', 51, 79, '2025-09-01 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de POMDI20. Le praticien souhaite comparer avec des alternatives.', 'Présentation produit'),
('v003', 52, 71, '2025-01-19 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie APATOUX22 comme une option pertinente dans certains cas.', 'Actualisation dossier praticien'),
('v014', 53, 10, '2024-03-25 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie AMOXIG12 comme une option pertinente dans certains cas.', 'Mise à jour coordonnées'),
('v002', 54, 1, '2024-11-11 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur DEPRIL9. Bon niveau d\'écoute pendant l\'entretien.', 'Préparation réunion scientifique'),
('v003', 55, 58, '2025-07-24 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur EVILR7. Bon niveau d\'écoute pendant l\'entretien.', 'Présentation produit'),
('v016', 56, 2, '2024-10-25 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter DIMIRTAM6. Contact professionnel et disponible.', 'Suivi prescription'),
('v003', 57, 35, '2024-11-04 00:00:00', 'Retour globalement positif sur EQUILARX6. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Suivi prescription'),
('v006', 58, 62, '2024-03-19 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter BITALV. Contact professionnel et disponible.', 'Présentation nouvelle indication'),
('v002', 59, 1, '2025-02-09 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de TXISOL22. Une nouvelle visite sera programmée.', 'Point de suivi trimestriel'),
('v007', 60, 77, '2024-05-19 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de CLAZER6.', 'Information thérapeutique'),
('v021', 61, 41, '2024-10-25 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter PHYSOI8. Contact professionnel et disponible.', 'Actualisation dossier praticien'),
('v015', 62, 51, '2025-01-08 00:00:00', 'Retour globalement positif sur JOVAI8. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Information thérapeutique'),
('v020', 63, 60, '2025-12-26 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur DORNOM8. Bon niveau d\'écoute pendant l\'entretien.', 'Préparation réunion scientifique'),
('v011', 64, 18, '2025-10-10 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie BACTIV13 comme une option pertinente dans certains cas.', 'Mise à jour coordonnées'),
('v007', 65, 77, '2025-05-05 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour DIMIRTAM6. Une relance est à prévoir dans 6 semaines.', 'Point de suivi trimestriel'),
('v014', 66, 46, '2024-06-19 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de LIDOXY23. Une nouvelle visite sera programmée.', 'Point de suivi trimestriel'),
('v002', 67, 29, '2025-06-06 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter EVILR7. Contact professionnel et disponible.', 'Actualisation dossier praticien'),
('v007', 68, 76, '2025-12-08 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur AMOXIG12. Bon niveau d\'écoute pendant l\'entretien.', 'Présentation nouvelle indication'),
('v002', 69, 19, '2024-12-22 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de CLAZER6.', 'Information thérapeutique'),
('v002', 70, 58, '2024-11-22 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur CARTION6. Bon niveau d\'écoute pendant l\'entretien.', 'Présentation produit'),
('v016', 71, 14, '2025-11-24 00:00:00', 'Retour globalement positif sur PIRIZ8. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Information thérapeutique'),
('v005', 72, 55, '2025-04-18 00:00:00', 'Retour globalement positif sur TROXT21. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Point de suivi trimestriel'),
('v011', 73, 56, '2025-02-09 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter PIRIZ8. Contact professionnel et disponible.', 'Actualisation dossier praticien'),
('v010', 74, 50, '2024-01-05 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur BACTIG10. Bon niveau d\'écoute pendant l\'entretien.', 'Suivi prescription'),
('v003', 75, 15, '2024-09-25 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie URIEG6 comme une option pertinente dans certains cas.', 'Retour d\'expérience'),
('v005', 76, 59, '2025-09-24 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur TXISOL22. Bon niveau d\'écoute pendant l\'entretien.', 'Préparation réunion scientifique'),
('v005', 77, 31, '2024-11-08 00:00:00', 'Retour globalement positif sur APATOUX22. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Retour d\'expérience'),
('v006', 78, 18, '2025-08-11 00:00:00', 'Retour globalement positif sur DOLRIL7. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Présentation nouvelle indication'),
('v004', 79, 24, '2024-11-18 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour LIDOXY23. Une relance est à prévoir dans 6 semaines.', 'Retour d\'expérience'),
('v003', 80, 50, '2025-07-29 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie LITHOR12 comme une option pertinente dans certains cas.', 'Présentation nouvelle indication'),
('v001', 81, 4, '2026-02-18 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de CARTION6. Le praticien souhaite comparer avec des alternatives.', 'Présentation produit'),
('v009', 82, 22, '2025-04-13 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur PIRIZ8. Bon niveau d\'écoute pendant l\'entretien.', 'Visite de courtoisie'),
('v009', 83, 6, '2026-02-17 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur DORNOM8. Bon niveau d\'écoute pendant l\'entretien.', 'Point de suivi trimestriel'),
('v007', 84, 45, '2024-03-30 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter URIEG6. Contact professionnel et disponible.', 'Information thérapeutique'),
('v003', 85, 18, '2024-07-30 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de TROXT21. Une nouvelle visite sera programmée.', 'Présentation produit'),
('v010', 86, 22, '2024-11-27 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur CARTION6. Bon niveau d\'écoute pendant l\'entretien.', 'Visite de courtoisie'),
('v025', 87, 17, '2025-12-19 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de BACTIV13. Une nouvelle visite sera programmée.', 'Mise à jour coordonnées'),
('v013', 88, 51, '2025-05-16 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie JOVAI8 comme une option pertinente dans certains cas.', 'Préparation réunion scientifique'),
('v007', 89, 12, '2025-02-16 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de PIRIZ8.', 'Retour d\'expérience'),
('v016', 90, 12, '2026-01-18 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur LITHOR12. Bon niveau d\'écoute pendant l\'entretien.', 'Retour d\'expérience'),
('v022', 91, 28, '2025-05-21 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de CLAZER6. Une nouvelle visite sera programmée.', 'Préparation réunion scientifique'),
('v014', 92, 7, '2024-02-17 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour LITHOR12. Une relance est à prévoir dans 6 semaines.', 'Présentation nouvelle indication'),
('v019', 93, 21, '2025-03-27 00:00:00', 'Retour globalement positif sur 3MYC7. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Information thérapeutique'),
('v017', 94, 36, '2024-04-05 00:00:00', 'Retour globalement positif sur DEPRIL9. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Retour d\'expérience'),
('v013', 95, 30, '2025-03-15 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter AMOPIL7. Contact professionnel et disponible.', 'Présentation produit'),
('v010', 96, 67, '2025-11-27 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur 3MYC7. Bon niveau d\'écoute pendant l\'entretien.', 'Retour d\'expérience'),
('v007', 97, 30, '2025-01-27 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur PIRIZ8. Bon niveau d\'écoute pendant l\'entretien.', 'Suivi prescription'),
('v006', 98, 39, '2024-05-20 00:00:00', 'Retour globalement positif sur POMDI20. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Mise à jour coordonnées'),
('v010', 99, 22, '2025-03-26 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie PIRIZ8 comme une option pertinente dans certains cas.', 'Mise à jour coordonnées'),
('v002', 100, 13, '2024-05-23 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de JOVAI8. Une nouvelle visite sera programmée.', 'Point de suivi trimestriel'),
('v005', 101, 18, '2024-09-10 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de LITHOR12. Le praticien souhaite comparer avec des alternatives.', 'Information thérapeutique'),
('v003', 102, 78, '2025-06-05 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de PIRIZ8. Le praticien souhaite comparer avec des alternatives.', 'Point de suivi trimestriel'),
('v014', 103, 31, '2025-05-21 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur AMOX45. Bon niveau d\'écoute pendant l\'entretien.', 'Présentation nouvelle indication'),
('v019', 104, 17, '2025-01-31 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de DOLRIL7.', 'Mise à jour coordonnées'),
('v001', 105, 28, '2024-02-10 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de TROXT21. Le praticien souhaite comparer avec des alternatives.', 'Point de suivi trimestriel'),
('v007', 106, 52, '2024-03-25 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur INSXT5. Bon niveau d\'écoute pendant l\'entretien.', 'Préparation réunion scientifique'),
('v023', 107, 20, '2025-07-03 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de DIMIRTAM6. Le praticien souhaite comparer avec des alternatives.', 'Suivi prescription'),
('v001', 108, 12, '2025-03-20 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour DORNOM8. Une relance est à prévoir dans 6 semaines.', 'Actualisation dossier praticien'),
('v011', 109, 23, '2024-05-02 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour PHYSOI8. Une relance est à prévoir dans 6 semaines.', 'Mise à jour coordonnées'),
('v008', 110, 45, '2025-06-19 00:00:00', 'Retour globalement positif sur TROXT21. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Préparation réunion scientifique'),
('v013', 111, 16, '2026-02-28 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de CLAZER6. Le praticien souhaite comparer avec des alternatives.', 'Point de suivi trimestriel'),
('v004', 112, 74, '2025-10-04 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de EQUILARX6. Une nouvelle visite sera programmée.', 'Présentation nouvelle indication'),
('v008', 113, 73, '2024-06-19 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur APATOUX22. Bon niveau d\'écoute pendant l\'entretien.', 'Suivi prescription'),
('v001', 114, 2, '2024-09-07 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie EQUILARX6 comme une option pertinente dans certains cas.', 'Retour d\'expérience'),
('v003', 115, 5, '2025-07-20 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de PIRIZ8. Une nouvelle visite sera programmée.', 'Information thérapeutique'),
('v004', 116, 10, '2025-08-08 00:00:00', 'Retour globalement positif sur AMOX45. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Présentation produit'),
('v020', 117, 9, '2025-04-21 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de POMDI20. Une nouvelle visite sera programmée.', 'Préparation réunion scientifique'),
('v001', 118, 26, '2024-10-25 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter TROXT21. Contact professionnel et disponible.', 'Actualisation dossier praticien'),
('v025', 119, 26, '2026-01-20 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour POMDI20. Une relance est à prévoir dans 6 semaines.', 'Mise à jour coordonnées'),
('v009', 120, 2, '2024-12-09 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de POMDI20. Le praticien souhaite comparer avec des alternatives.', 'Point de suivi trimestriel'),
('v003', 121, 31, '2025-03-05 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur ADIMOL9. Bon niveau d\'écoute pendant l\'entretien.', 'Préparation réunion scientifique'),
('v018', 122, 67, '2025-02-26 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur DEPRIL9. Bon niveau d\'écoute pendant l\'entretien.', 'Suivi prescription'),
('v010', 123, 8, '2025-03-21 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de AMOXIG12. Une nouvelle visite sera programmée.', 'Préparation réunion scientifique'),
('v007', 124, 30, '2024-03-17 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur AMOXIG12. Bon niveau d\'écoute pendant l\'entretien.', 'Actualisation dossier praticien'),
('v002', 125, 58, '2025-04-22 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de DOLRIL7. Une nouvelle visite sera programmée.', 'Visite de courtoisie'),
('v005', 126, 34, '2024-05-02 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour APATOUX22. Une relance est à prévoir dans 6 semaines.', 'Préparation réunion scientifique'),
('v015', 127, 42, '2024-05-31 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de PHYSOI8. Une nouvelle visite sera programmée.', 'Information thérapeutique'),
('v008', 128, 39, '2024-09-23 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de 3MYC7.', 'Point de suivi trimestriel'),
('v002', 129, 14, '2024-05-23 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter 3MYC7. Contact professionnel et disponible.', 'Présentation produit'),
('v003', 130, 52, '2025-01-16 00:00:00', 'Discussion orientée sur les usages, contre-indications et profils patients de LITHOR12. Le praticien souhaite comparer avec des alternatives.', 'Actualisation dossier praticien'),
('v003', 131, 57, '2024-05-11 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur URIEG6. Bon niveau d\'écoute pendant l\'entretien.', 'Retour d\'expérience'),
('v020', 132, 7, '2024-06-21 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de DOLRIL7.', 'Point de suivi trimestriel'),
('v003', 133, 28, '2024-07-10 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour BITALV. Une relance est à prévoir dans 6 semaines.', 'Mise à jour coordonnées'),
('v008', 134, 71, '2025-05-05 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie AMOPIL7 comme une option pertinente dans certains cas.', 'Préparation réunion scientifique'),
('v006', 135, 68, '2024-09-12 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de TROXT21. Une nouvelle visite sera programmée.', 'Point de suivi trimestriel'),
('v018', 136, 65, '2024-11-25 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de BITALV. Une nouvelle visite sera programmée.', 'Présentation produit'),
('v017', 137, 36, '2024-02-29 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter EVILR7. Contact professionnel et disponible.', 'Actualisation dossier praticien'),
('v004', 138, 31, '2024-09-29 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter TXISOL22. Contact professionnel et disponible.', 'Présentation produit'),
('v003', 139, 76, '2024-11-21 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de PHYSOI8. Une nouvelle visite sera programmée.', 'Présentation produit'),
('v009', 140, 23, '2025-05-17 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter AMOPIL7. Contact professionnel et disponible.', 'Présentation produit'),
('v001', 141, 62, '2024-01-01 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de LIDOXY23. Une nouvelle visite sera programmée.', 'Mise à jour coordonnées'),
('v001', 142, 19, '2025-08-23 00:00:00', 'Le praticien a posé des questions précises sur l\'efficacité et la tolérance de AMOXIG12. Une nouvelle visite sera programmée.', 'Visite de courtoisie'),
('v009', 143, 44, '2024-11-05 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de AMOXIG12.', 'Point de suivi trimestriel'),
('v012', 144, 72, '2025-12-11 00:00:00', 'Retour globalement positif sur TROXT21. Le praticien mentionne plusieurs prescriptions récentes dans son cabinet.', 'Actualisation dossier praticien'),
('v002', 145, 1, '2025-12-19 00:00:00', 'Échange constructif avec le praticien. Intérêt confirmé pour DIMIRTAM6. Une relance est à prévoir dans 6 semaines.', 'Actualisation dossier praticien'),
('v011', 146, 14, '2025-05-23 00:00:00', 'Le rendez-vous a permis d\'actualiser les informations du cabinet et de présenter CLAZER6. Contact professionnel et disponible.', 'Suivi prescription'),
('v023', 147, 22, '2025-10-13 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de TXISOL22.', 'Retour d\'expérience'),
('v004', 148, 32, '2025-12-10 00:00:00', 'Le praticien souhaite disposer d\'une documentation complémentaire sur DEPRIL9. Bon niveau d\'écoute pendant l\'entretien.', 'Préparation réunion scientifique'),
('v001', 149, 57, '2026-01-20 00:00:00', 'Entretien synthétique mais utile. Le praticien identifie APATOUX22 comme une option pertinente dans certains cas.', 'Présentation nouvelle indication'),
('v002', 150, 62, '2025-08-14 00:00:00', 'Le praticien est intéressé par les données de prescription et par les supports d\'aide à la décision autour de POMDI20.', 'Mise à jour coordonnées');

-- --------------------------------------------------------

--
-- Structure de la table `realiser`
--

CREATE TABLE `realiser` (
  `AC_NUM` int(11) DEFAULT NULL,
  `VIS_MATRICULE` varchar(10) DEFAULT NULL,
  `REA_MTTFRAIS` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

CREATE TABLE `region` (
  `REG_CODE` varchar(2) DEFAULT NULL,
  `SEC_CODE` varchar(1) DEFAULT NULL,
  `REG_NOM` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `region`
--

INSERT INTO `region` (`REG_CODE`, `SEC_CODE`, `REG_NOM`) VALUES
('AL', 'E', 'Alsace Lorraine'),
('AQ', 'S', 'Aquitaine'),
('AU', 'P', 'Auvergne'),
('BG', 'O', 'Bretagne'),
('BN', 'O', 'Basse Normandie'),
('BO', 'E', 'Bourgogne'),
('CA', 'N', 'Champagne Ardennes'),
('CE', 'P', 'Centre'),
('FC', 'E', 'Franche Comté'),
('HN', 'N', 'Haute Normandie'),
('IF', 'P', 'Ile de France'),
('LG', 'S', 'Languedoc'),
('LI', 'P', 'Limousin'),
('MP', 'S', 'Midi Pyrénée'),
('NP', 'N', 'Nord Pas de Calais'),
('PA', 'S', 'Provence Alpes Cote d\'Azur'),
('PC', 'O', 'Poitou Charente'),
('PI', 'N', 'Picardie'),
('PL', 'O', 'Pays de Loire'),
('RA', 'E', 'Rhone Alpes'),
('RO', 'S', 'Roussilon'),
('VD', 'O', 'Vendée');

-- --------------------------------------------------------

--
-- Structure de la table `secteur`
--

CREATE TABLE `secteur` (
  `SEC_CODE` varchar(1) DEFAULT NULL,
  `SEC_LIBELLE` varchar(15) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `secteur`
--

INSERT INTO `secteur` (`SEC_CODE`, `SEC_LIBELLE`) VALUES
('E', 'Est'),
('N', 'Nord'),
('O', 'Ouest'),
('P', 'Paris centre'),
('S', 'Sud');

-- --------------------------------------------------------

--
-- Structure de la table `specialite`
--

CREATE TABLE `specialite` (
  `SPE_CODE` varchar(5) DEFAULT NULL,
  `SPE_LIBELLE` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `specialite`
--

INSERT INTO `specialite` (`SPE_CODE`, `SPE_LIBELLE`) VALUES
('ACP', 'anatomie et cytologie pathologiques'),
('AMV', 'angéiologie, médecine vasculaire'),
('ARC', 'anesthésiologie et réanimation chirurgicale'),
('BM', 'biologie médicale'),
('CAC', 'cardiologie et affections cardio-vasculaires'),
('CCT', 'chirurgie cardio-vasculaire et thoracique'),
('CG', 'chirurgie générale'),
('CMF', 'chirurgie maxillo-faciale'),
('COM', 'cancérologie, oncologie médicale'),
('COT', 'chirurgie orthopédique et traumatologie'),
('CPR', 'chirurgie plastique reconstructrice et esthétique'),
('CU', 'chirurgie urologique'),
('CV', 'chirurgie vasculaire'),
('DN', 'diabétologie-nutrition, nutrition'),
('DV', 'dermatologie et vénéréologie'),
('EM', 'endocrinologie et métabolismes'),
('ETD', 'évaluation et traitement de la douleur'),
('GEH', 'gastro-entérologie et hépatologie (appareil digestif)'),
('GMO', 'gynécologie médicale, obstétrique'),
('GO', 'gynécologie-obstétrique'),
('HEM', 'maladies du sang (hématologie)'),
('MBS', 'médecine et biologie du sport'),
('MDT', 'médecine du travail'),
('MMO', 'médecine manuelle - ostéopathie'),
('MN', 'médecine nucléaire'),
('MPR', 'médecine physique et de réadaptation'),
('MTR', 'médecine tropicale, pathologie infectieuse et tropicale'),
('NEP', 'néphrologie'),
('NRC', 'neurochirurgie'),
('NRL', 'neurologie'),
('ODM', 'orthopédie dento maxillo-faciale'),
('OPH', 'ophtalmologie'),
('ORL', 'oto-rhino-laryngologie'),
('PEA', 'psychiatrie de l\'enfant et de l\'adolescent'),
('PME', 'pédiatrie maladies des enfants'),
('PNM', 'pneumologie'),
('PSC', 'psychiatrie'),
('RAD', 'radiologie (radiodiagnostic et imagerie médicale)'),
('RDT', 'radiothérapie (oncologie option radiothérapie)'),
('RGM', 'reproduction et gynécologie médicale'),
('RHU', 'rhumatologie'),
('STO', 'stomatologie'),
('SXL', 'sexologie'),
('TXA', 'toxicomanie et alcoologie');

-- --------------------------------------------------------

--
-- Structure de la table `switchboard items`
--

CREATE TABLE `switchboard items` (
  `SwitchboardID` int(11) DEFAULT NULL,
  `ItemNumber` smallint(6) DEFAULT NULL,
  `ItemText` varchar(255) DEFAULT NULL,
  `Command` smallint(6) DEFAULT NULL,
  `Argument` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `switchboard items`
--

INSERT INTO `switchboard items` (`SwitchboardID`, `ItemNumber`, `ItemText`, `Command`, `Argument`) VALUES
(1, 0, 'Gestion des comptes rendus', NULL, 'Par défaut'),
(1, 1, 'Comptes-Rendus', 3, 'RAPPORT_VISITE'),
(1, 2, 'Visiteurs', 3, 'F_VISITEUR'),
(1, 3, 'Praticiens', 3, 'F_PRATICIEN'),
(1, 4, 'Medicaments', 3, 'F_MEDICAMENT'),
(1, 5, 'Quitter', 8, 'quitter');

-- --------------------------------------------------------

--
-- Structure de la table `travailler`
--

CREATE TABLE `travailler` (
  `VIS_MATRICULE` varchar(10) DEFAULT NULL,
  `JJMMAA` datetime DEFAULT NULL,
  `REG_CODE` varchar(2) DEFAULT NULL,
  `TRA_ROLE` varchar(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `travailler`

INSERT INTO `travailler` (`VIS_MATRICULE`, `JJMMAA`, `REG_CODE`, `TRA_ROLE`) VALUES
('v001', '2018-12-09 00:00:00', 'VD', 'Visiteur'),
('v002', '2020-12-04 00:00:00', 'CA', 'Visiteur'),
('v002', '2022-07-27 00:00:00', 'RA', 'Visiteur'),
('v003', '2019-10-14 00:00:00', 'PL', 'Visiteur'),
('v003', '2022-01-03 00:00:00', 'LG', 'Visiteur'),
('v004', '2019-04-08 00:00:00', 'NP', 'Délégué'),
('v005', '2018-09-07 00:00:00', 'FC', 'Visiteur'),
('v005', '2021-08-22 00:00:00', 'BN', 'Visiteur'),
('v005', '2023-12-22 00:00:00', 'RO', 'Délégué'),
('v006', '2024-04-15 00:00:00', 'CA', 'Visiteur'),
('v006', '2025-06-03 00:00:00', 'MP', 'Visiteur'),
('v006', '2028-09-14 00:00:00', 'FC', 'Délégué'),
('v007', '2018-03-23 00:00:00', 'BN', 'Visiteur'),
('v008', '2022-03-07 00:00:00', 'RA', 'Visiteur'),
('v008', '2025-04-15 00:00:00', 'CE', 'Visiteur'),
('v008', '2028-03-28 00:00:00', 'VD', 'Visiteur'),
('v009', '2019-07-04 00:00:00', 'LG', 'Visiteur'),
('v010', '2023-10-09 00:00:00', 'FC', 'Visiteur'),
('v010', '2026-01-26 00:00:00', 'RO', 'Visiteur'),
('v011', '2025-09-04 00:00:00', 'BO', 'Délégué'),
('v012', '2022-11-20 00:00:00', 'LI', 'Visiteur'),
('v012', '2024-12-07 00:00:00', 'VD', 'Visiteur'),
('v013', '2021-12-03 00:00:00', 'HN', 'Responsable'),
('v014', '2021-05-03 00:00:00', 'PL', 'Visiteur'),
('v015', '2019-07-09 00:00:00', 'LG', 'Visiteur'),
('v015', '2020-05-11 00:00:00', 'CA', 'Visiteur'),
('v015', '2023-03-01 00:00:00', 'AL', 'Responsable'),
('v016', '2023-03-12 00:00:00', 'BG', 'Visiteur'),
('v017', '2022-12-22 00:00:00', 'VD', 'Visiteur'),
('v017', '2024-06-17 00:00:00', 'LI', 'Visiteur'),
('v018', '2020-09-24 00:00:00', 'BO', 'Visiteur'),
('v018', '2023-07-31 00:00:00', 'AU', 'Visiteur'),
('v019', '2025-07-09 00:00:00', 'HN', 'Visiteur'),
('v019', '2026-08-09 00:00:00', 'CE', 'Visiteur'),
('v020', '2021-11-11 00:00:00', 'PA', 'Visiteur'),
('v020', '2023-11-01 00:00:00', 'PI', 'Visiteur'),
('v021', '2018-06-13 00:00:00', 'AL', 'Visiteur'),
('v022', '2021-10-23 00:00:00', 'CA', 'Visiteur'),
('v022', '2023-04-30 00:00:00', 'BO', 'Visiteur'),
('v023', '2025-07-21 00:00:00', 'AU', 'Visiteur'),
('v023', '2026-11-20 00:00:00', 'FC', 'Visiteur'),
('v023', '2029-01-01 00:00:00', 'BN', 'Visiteur'),
('v024', '2022-03-08 00:00:00', 'PC', 'Délégué'),
('v025', '2022-12-19 00:00:00', 'VD', 'Visiteur'),
('v025', '2026-02-17 00:00:00', 'CE', 'Visiteur'),
('v025', '2027-03-19 00:00:00', 'LG', 'Visiteur');

-- --------------------------------------------------------

--
-- Structure de la table `type_individu`
--

CREATE TABLE `type_individu` (
  `TIN_CODE` varchar(5) DEFAULT NULL,
  `TIN_LIBELLE` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `type_praticien`
--

CREATE TABLE `type_praticien` (
  `TYP_CODE` varchar(3) DEFAULT NULL,
  `TYP_LIBELLE` varchar(25) DEFAULT NULL,
  `TYP_LIEU` varchar(35) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `type_praticien`
--

INSERT INTO `type_praticien` (`TYP_CODE`, `TYP_LIBELLE`, `TYP_LIEU`) VALUES
('MH', 'Médecin Hospitalier', 'Hopital ou clinique'),
('MV', 'Médecine de Ville', 'Cabinet'),
('PH', 'Pharmacien Hospitalier', 'Hopital ou clinique'),
('PO', 'Pharmacien Officine', 'Pharmacie'),
('PS', 'Personnel de santé', 'Centre paramédical');

-- --------------------------------------------------------

--
-- Structure de la table `visiteur`
--

CREATE TABLE `visiteur` (
  `VIS_MATRICULE` varchar(10) DEFAULT NULL,
  `VIS_NOM` varchar(25) DEFAULT NULL,
  `Vis_PRENOM` varchar(50) DEFAULT NULL,
  `VIS_ADRESSE` varchar(50) DEFAULT NULL,
  `VIS_CP` varchar(5) DEFAULT NULL,
  `VIS_VILLE` varchar(30) DEFAULT NULL,
  `VIS_DATEEMBAUCHE` datetime DEFAULT NULL,
  `SEC_CODE` varchar(1) DEFAULT NULL,
  `LAB_CODE` varchar(2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `visiteur`

INSERT INTO `visiteur` (`VIS_MATRICULE`, `VIS_NOM`, `Vis_PRENOM`, `VIS_ADRESSE`, `VIS_CP`, `VIS_VILLE`, `VIS_DATEEMBAUCHE`, `SEC_CODE`, `LAB_CODE`) VALUES
('v001', 'Moreau', 'Camille', '83 avenue Jean-Jaurès', '35000', 'Rennes', '2018-12-09 00:00:00', 'O', 'SW'),
('v002', 'Benali', 'Yassine', '33 rue Nationale', '69000', 'Lyon', '2020-12-04 00:00:00', 'E', 'GY'),
('v003', 'Garcia', 'Lucia', '88 avenue Foch', '13008', 'Marseille', '2019-10-14 00:00:00', 'S', 'BC'),
('v004', 'Dubois', 'Hugo', '6 rue Victor-Hugo', '59000', 'Lille', '2019-04-08 00:00:00', 'N', 'SW'),
('v005', 'Nguyen', 'Minh', '66 boulevard Carnot', '31000', 'Toulouse', '2018-09-07 00:00:00', 'S', 'GY'),
('v006', 'Schneider', 'Laura', '93 rue du Stade', '67000', 'Strasbourg', '2024-04-15 00:00:00', 'E', 'BC'),
('v007', 'Diallo', 'Mamadou', '77 rue des Lilas', '44000', 'Nantes', '2018-03-23 00:00:00', 'O', 'SW'),
('v008', 'Martin', 'Chloé', '56 rue de la Gare', '33000', 'Bordeaux', '2022-03-07 00:00:00', 'O', 'GY'),
('v009', 'Petit', 'Nathan', '45 avenue Jean-Jaurès', '06000', 'Nice', '2019-07-04 00:00:00', 'S', 'BC'),
('v010', 'Roux', 'Inès', '47 rue Saint-Michel', '34000', 'Montpellier', '2023-10-09 00:00:00', 'S', 'SW'),
('v011', 'Lefèvre', 'Julien', '7 avenue Foch', '54000', 'Nancy', '2025-09-04 00:00:00', 'E', 'GY'),
('v012', 'Bernard', 'Sarah', '50 avenue Jean-Jaurès', '14000', 'Caen', '2022-11-20 00:00:00', 'O', 'BC'),
('v013', 'Aubert', 'Thomas', '48 boulevard Carnot', '80000', 'Amiens', '2021-12-03 00:00:00', 'N', 'SW'),
('v014', 'Colin', 'Lina', '7 rue du Stade', '37000', 'Tours', '2021-05-03 00:00:00', 'O', 'GY'),
('v015', 'Chevalier', 'Mathis', '31 rue Saint-Michel', '21000', 'Dijon', '2019-07-09 00:00:00', 'E', 'BC'),
('v016', 'Lopez', 'Sofia', '60 rue du Stade', '29200', 'Brest', '2023-03-12 00:00:00', 'O', 'SW'),
('v017', 'Mercier', 'Adrien', '47 rue Nationale', '63000', 'Clermont-Ferrand', '2022-12-22 00:00:00', 'P', 'GY'),
('v018', 'Robin', 'Manon', '84 avenue Jean-Jaurès', '45000', 'Orléans', '2020-09-24 00:00:00', 'P', 'BC'),
('v019', 'Moulinec', 'Soizic', '33 boulevard Gambetta', '87000', 'Limoges', '2025-07-09 00:00:00', 'P', 'SW'),
('v020', 'Pires', 'Tiago', '83 avenue Foch', '51100', 'Reims', '2021-11-11 00:00:00', 'N', 'GY'),
('v021', 'Kaci', 'Nora', '9 rue Nationale', '25000', 'Besançon', '2018-06-13 00:00:00', 'E', 'BC'),
('v022', 'Renaud', 'Élise', '36 avenue Jean-Jaurès', '38100', 'Grenoble', '2021-10-23 00:00:00', 'E', 'SW'),
('v023', 'Charrier', 'Baptiste', '42 rue Nationale', '49000', 'Angers', '2025-07-21 00:00:00', 'O', 'GY'),
('v024', 'Belaïd', 'Samira', '60 boulevard Gambetta', '72000', 'Le Mans', '2022-03-08 00:00:00', 'O', 'BC'),
('v025', 'Vasseur', 'Victor', '97 cours Lafayette', '64000', 'Pau', '2022-12-19 00:00:00', 'S', 'SW');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
