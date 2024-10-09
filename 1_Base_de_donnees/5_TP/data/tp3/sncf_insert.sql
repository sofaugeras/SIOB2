
INSERT INTO `gare` (`codeGare`, `nomGare`, `nomVille`) VALUES 
('1', 'Montparnasse', 'Paris'), 
('2', 'Saint lazare', 'Paris')
('3', 'Redon', 'Redon'), 
('4', 'Pardieu', 'Lyon');

INSERT INTO `train` (`numTrain`, `codeGareDep`, `CodeGareARR`, `HDep`, `HArr`, `CodeTrf`) VALUES 
('123', '1', '3', '2024-09-01 11:41:44', '2024-09-01 15:41:44', 'Q')
('124', '3', '1', '2024-09-01 11:41:44', '2024-09-01 15:41:44', 'Q')
;

INSERT INTO `composition` (`numTrain`, `dateDep`, `Ass1`, `Ass2`, `Cch1`, `Cch2`) VALUES 
('123', '2024-09-01 11:44:57', '10', '20', '2', '5');

INSERT INTO `exception` (`numTrain`, `dateDep`) VALUES 
('124', '2024-09-27 09:47:41.000000');