# Diagramme Etat-Transition

!!! abstract "Définition"
    un diagramme d'**état-transition** est un outil de modélisation qui permet de décrire le comportement ^^dynamique^^ d'un système en représentant les états possibles d'un objet, les transitions entre ces états et les événements qui déclenchent ces transitions.

    Utilisation des diagrammes états-transitions : <br />
    ^^En phase d'analyse :^^<br />
    - Description de la dynamique du système vu de l'extérieur<br />
    - Synthèse des scénarios liés aux cas d'utilisation<br />
    - Événements = action des acteurs<br />
    ^^En phase de conception :^^<br />
    - Description de la dynamique d'un objet particulier<br />
    - Événements = appels d'opérations

## 1. Sémantique

**État :** Un état représente une condition ou une situation dans laquelle un objet peut se trouver à un moment donné. Par exemple, un objet peut être dans un état "allumé" ou "éteint".

**Transition :** Une transition représente le passage d'un état à un autre en réponse à un événement ou une condition spécifique. Les transitions sont déclenchées par des événements externes ou des actions internes.

**Événement :** Un événement est un stimulus externe ou une condition interne qui déclenche une transition entre les états. Les événements peuvent être des signaux provenant d'autres objets, des délais de temps, des conditions booléennes, etc.

**Actions :** Les actions sont des comportements associés à une transition. Elles peuvent inclure des opérations ou des traitements effectués lorsque la transition est déclenchée.

## 2. Convention de langage

![convention graphique](./data/convention.png)

Quelques éléments de langage :

:point_right: **Transition conditionnelle**

![condition](./data/ET_condition.png)

:point_right: **Évènement réflexif** : L’évènement peut arriver plusieurs fois et les action doivent être à chaque fois exécutées

![reflexif](./data/ET_refelxif.png)

:point_right: **Etat composé** : État  qui englobe d'autres états et transitions (éléments de structuration du diagramme)

![composé](./data/ET_composé.png)

:point_right: **Synchronisation** : Il est possible de synchroniser des transitions à l’aide d’une barre de synchronisation. Celle-ci permet d’ouvrir et de fermer des branches parallèles au sein d’un flôt d’exécution : Les transitions qui partent d’une barre de synchronisation ont lieu en même temps. On ne franchit une barre de synchronisation qu’après réalisation de toutes les transitions qui s’y rattachent. 

![synchronisation](./data/ET_synchro.png)

## 3. Exemple complet

![exemple complet fenetre](./data/ET_complet.png)

??? tip "exemple Analyse fonctionnel"
    Worflow des virements émis en euro (valeurs prise par un statut technique IDT_STA_TEC)
    ![worflow bancaire](./data/Worklow_bancaire.png)