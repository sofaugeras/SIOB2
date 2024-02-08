# Diagramme d'interaction


!!! abstract "Définition"

    Les **diagrammes d'interactions** sont des outils pour modéliser les interactions entre les objets d'un système logiciel. Ce chapitre explore les concepts fondamentaux des diagrammes de séquence, leur utilité dans le processus de conception logicielle.

    Ils représentent une interaction, c'est à dire un ensemble d’objets et leurs relations, y compris les messages qu’ils peuvent échanger. Il s'agit d'une vue **dynamique** du système.

Il existe 2 types de diagrammes d’interaction :<br />

- Diagrammes de séquence : mettent l’accent sur le classement chronologique des messages de collaboration d’instance

- Diagrammes de collaboration : mettent l’accent sur l’organisation structurelle des éléments qui envoient et reçoivent des messages

Les ^^diagrammes de séquence^^ et les ^^diagrammes de collaboration^^ sont **isomorphes** : l’un peut-être transformé en l’autre

Les ^^diagrammes de séquence^^ permettent de représenter des interactions entre objets (et acteurs) Selon un point de vue ==temporel== (en indiquant la chronologie des envois de messages). Il est complémentaire du diagramme de collaboration.<br />

:pushpin: Diagramme de collaboration décrit le contexte ou l'état des objets<br />
:pushpin: Diagramme de séquence se concentre sur l'expression des interactions<br />
  
^^note :^^ Les diagrammes de séquences peuvent servir à illustrer un cas d'utilisation.

![illustration](./data/exemple1.png){ .center width=50%}

L'ordre d'envoi d'un message est déterminé par sa position sur l'axe vertical du diagramme. Le temps s'écoule "de haut en bas" de cet axe. La disposition des objets sur l'axe horizontal n'a pas de conséquence pour la sémantique du diagramme.

![element de base](./data/elementBase.png){ .center width=70%}


