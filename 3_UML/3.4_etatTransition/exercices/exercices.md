# Exercices

## Exercice 1 : Réveil matin :alarm_clock:
Considérons un réveille-matin simplifié : <br />
- on peut mettre l’alarme « on » ou « off » <br />
- quand l’heure courante devient égale à l’heure d’alarme, le réveil sonne sans s’arrêter <br />
- on peut interrompre la sonnerie.

??? tip "correction"
    ![correction](./data/ET_alarme_corr.png)

## Exercice 2 : Lavage de voiture :sweat_drops:

On cherche à montrer les différents états par lesquels passe une machine à laver les voitures.<br />
- En phase de lustrage ou de lavage, le client peut appuyer sur le bouton d'arrêt d'urgence. <br />
- S'il appuie sur ce bouton, la machine se met en attente. Il a alors deux minutes pour reprendre le lavage ou le lustrage (la machine continue en phase de lavage ou de lustrage, suivant l'état dans lequel elle a été interrompue), sans quoi la machine s'arrête. <br />
- En phase de séchage, le client peut aussi interrompre la machine. Mais dans ce cas, la machine s'arrêtera définitivement (avant de reprendre un autre cycle entier).

??? tip "correction"
    ![correction](./data/ET_lavage_corr.png)