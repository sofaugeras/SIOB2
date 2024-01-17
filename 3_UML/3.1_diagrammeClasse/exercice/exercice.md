# Exercices

## Exercice 2 
	Propriétés d'une classe
Une personne est caractérisée par son nom, son prénom, son sexe et son âge. Les objets de classe Personne doivent pouvoir calculer leurs revenus et leurs charges. Les attributs de la classe sont privés ; le nom, le prénom ainsi que l'âge de la personne doivent être accessibles par des opérations publiques.
	Question : Donnez une représentation UML de la classe Personne, en remplissant tous les compartiments adéquats.
Deux types de revenus sont envisagés : d'une part le salaire et d'autre part toutes les autres sources de revenus. Les deux revenus sont représentés par des nombres réels (float). Pour calculer les charges globales, on applique un coefficient fixe de 20% sur les salaires et un coefficient de 15% sur les autres revenus.
	Question : Enrichissez la représentation précédente pour prendre en compte ces nouveaux éléments.
	Un objet de la classe Personne peut être créé à partir du nom et de la date de naissance. Il est possible de changer le prénom d'une personne. Par ailleurs, le calcul des charges ne se fait pas de la même manière lorsque la personne décède.
	Question : Enrichissez encore la représentation précédente pour prendre en compte ces nouveaux éléments.

## Exercice 3 : 
Dessiner les diagrammes d’objets et de classes correspondant aux situations suivantes : 
1.	La France est frontalière de l’Espagne. L’Algérie est frontalière du Maroc.
2.	Tout écrivain a écrit au moins une œuvre
3.	Les personnes peuvent être associés à des universités en tant qu’étudiants aussi bien qu’en tant que professeurs.
4.	Un client demande une réparation. Une réparation est effectuée par un mécanicien. Elle nécessite des compétences. Un mécanicien possède des compétences.
5.	Un rectangle a deux sommets qui sont des points. On construit un rectangle à partir de coordonnées de deux points. Il est possible de calculer sa surface et son périmètre, ou encore le translater.
 

## Exercice 4 : Mariage ou PACS
Issu du livre : UML2 de l’apprentissage à la pratique de Laurent Audibert

1.	Deux personnes peuvent être mariées. Deux personnes mariées sont de sexes opposés. Proposer un diagramme de classes correspondant comportant une association réflexive.
2.	Même question que la précédente, mais en utilisant la relation de généralisation plutôt qu’une association réflexive.
3.	Deux personnes peuvent être mariées ou pacsées. Modifier le modèle de la question précédente en conséquence.
4.	Un Pacs est caractérisé par une date et un lieu. Un mariage est caractérisé par une date, un lieu et un contrat. Modifier le modèle de la question précédente en conséquence.


## Exercice 5 : Système de réservation de vols
Issu du livre : UML2 par la pratique de Pascal Roques

Cette étude de cas concerne un système simplifié de réservation de vols pour une agence de voyages.
Les interviews des experts métier auxquelles on a procédé ont permis de résumer leur connaissance du domaine sous la forme des phrases suivantes :
1. Des compagnies aériennes proposent différents vols.
2. Un vol est ouvert à la réservation et refermé sur ordre de la compagnie.
3. Un client peut réserver un ou plusieurs vols, pour des passagers différents.
4. Une réservation concerne un seul vol et un seul passager.
5. Une réservation peut être annulée ou confirmée.
6. Un vol a un aéroport de départ et un aéroport d’arrivée.
7. Un vol a un jour et une heure de départ, et un jour et une heure d’arrivée.
8. Un vol peut comporter des escales dans des aéroports.
