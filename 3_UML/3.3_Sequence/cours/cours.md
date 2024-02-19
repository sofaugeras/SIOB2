# Diagramme d'interaction

## 1. Présentation

!!! abstract "Définition"

    Les **diagrammes d'interactions** sont des outils pour modéliser les interactions entre les objets d'un système logiciel. Ce chapitre explore les concepts fondamentaux des diagrammes de séquence, leur utilité dans le processus de conception logicielle.

    Ils représentent une interaction, c'est à dire un ensemble d’objets et leurs relations, y compris les messages qu’ils peuvent échanger. Il s'agit d'une vue **dynamique** du système.

Il existe 2 types de diagrammes d’interaction :<br />

- **Diagrammes de séquence** : mettent l’accent sur le classement chronologique des messages de collaboration d’instance

- **Diagrammes de collaboration** : mettent l’accent sur l’organisation structurelle des éléments qui envoient et reçoivent des messages

Les ^^diagrammes de séquence^^ et les ^^diagrammes de collaboration^^ sont **isomorphes** : l’un peut-être transformé en l’autre

Les ^^diagrammes de séquence^^ permettent de représenter des interactions entre objets (et acteurs) Selon un point de vue ==temporel== (en indiquant la chronologie des envois de messages). Il est complémentaire du diagramme de collaboration.<br />

:pushpin: Diagramme de collaboration décrit le contexte ou l'état des objets<br />
:pushpin: Diagramme de séquence se concentre sur l'expression des interactions<br />
  
^^note :^^ Les diagrammes de séquences peuvent servir à illustrer un cas d'utilisation.

![illustration](./data/exemple1.png){ .center width=50%}

L'ordre d'envoi d'un message est déterminé par sa position sur l'axe vertical du diagramme. Le temps s'écoule "de haut en bas" de cet axe. La disposition des objets sur l'axe horizontal n'a pas de conséquence pour la sémantique du diagramme.

![element de base](./data/elementBase.png){ .center width=70%}

## 2. Convention de langage : 

:point_right: **Le Branchement conditionnel** : Deux ou plusieurs branches de séquence sont représentées à l'intérieur du fragment conditionnel. Chaque branche correspond à un chemin d'exécution possible en fonction du résultat de l'évaluation de la condition.

![branchement conditionnel](./data/messageconditionnel.png)

:point_right: **La récursivité** : un message récursif est un message envoyé par un objet à lui-même. Cette situation peut survenir lorsqu'un objet doit effectuer une action répétitive ou itérative sur lui-même, souvent dans le cadre de la logique de boucle ou de récursivité.

![message récursif](./data/messageRecurs.png)

:point_right: **Message simple**: aucune caractéristique d'envoi ou de réception particulière

![message simple](./data/messageSimple.png)

:point_right: **Message minuté** (timeout) : bloque l'expéditeur pendant un temps donné, en attendant la prise en compte du message par le récepteur. L'expéditeur est libéré si la prise en compte n'a pas eu lieu pendant le délai spécifié

![message minuté](./data/messageMinute.png)

:point_right: **Message Synchone** : bloque l'expéditeur jusqu'à prise en compte du message par le destinataire

![Message Synchrone](./data/messageSynchrone.png)

:point_right: **Message Asynchone** : n'interrompt pas l'exécution de l'expéditeur. Le message peut être pris en compte par le récepteur à tout moment ou ignoré

![Message Asynchrone](./data/messageAsynchrone.png)

## 3. Exemple complet Séquence

![exemple complet](./data/exempleSequence.png)

## 4. Exemple Diagramme de collaboration

![diagramme de collaboration](./data/exempleDiagCollab.png)