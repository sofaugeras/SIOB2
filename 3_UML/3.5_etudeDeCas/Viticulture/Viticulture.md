# viticulture

![illustration](./data/viti.jpg){ .center width=50%}

Dans le cadre d’un projet de recherche en viticulture, on désire collecter les temps de travaux sur des exploitations agricoles pilotes, pour travailler en particulier sur les opérations phytosanitaires. Pour ce faire, un glossaire des opérations culturales types a été mis en place (afin que tout le monde ait le même cadre analytique). 

Des contraintes assez fortes sont apparues sur le projet : les ouvriers agricoles des exploitations pilotes n’ont pas accès aux outils informatiques et la lourdeur d’enregistrement des temps de travaux a donc de fait écarté l’utilisation d’un outil informatique. La procédure suivante a ainsi été définie : chaque ouvrier agricole saisit ses temps de travaux sur un cahier au format prédéfini. (dans ce cahier, il peut consulter en annexes le glossaire afin d’identifier l’opération culturale type). 

Nb : pour les opérations de type phytosanitaire, les informations complémentaires sont demandées : liste des maladies visées, stade phénologique, méthodes de traitements et observation. 

En fin de mois, le chef d’exploitation vérifie la saisie effectuée sur le cahier et apporte d’éventuelles corrections. Il saisit ensuite les opérations du mois sur une application internet connectée à une base de données. Le chercheur en charge du projet reçoit automatiquement un mail qui lui indique que la saisie mensuelle a été effectuée. 
Après avoir vérifié la pertinence de la saisie, il notifie au chef d’exploitation que tout s’est bien passé et que les données intégrées dans la base de données sont valides et prêtes à être exploitées. 
Le chef d’exploitation imprime alors 2 documents sur le mois écoulé : 

- l’état mensuel des travaux pour chaque salarié (qui est remis à chaque salarié) 
- l’état des opérations phytosanitaires (état Terravitis) 

En fin d’année, le chercheur analyse toutes les opérations saisies et rédige une synthèse générale sur les temps de travaux dans les différentes exploitations. Cette synthèse est alors transmise à tous les chefs d’exploitation. 

![relevé mensuel](./data/releve.png){ .center width=40%}

![impression](./data/impression.png){ .center width=100%}

??? tip "Correction"
    ![use case](./data/Viti_useCase.png)

    ![diagramme de sequence](./data/viti_seq.png)

    ![diagramme de classe](./data/viti_DC.png)