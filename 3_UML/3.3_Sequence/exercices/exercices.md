# Exercices

## Exercice 1  : Distributeur automatique de billet

Le déroulement normal d’utilisation d’un distributeur automatique de billets est le suivant :<br />
1.     le client introduit sa carte bancaire<br />
2.     la machine vérifie alors la validité de la carte et demande le code au client<br />
3.     si le code est correct, elle envoie une demande d’autorisation de prélèvement au groupement de banques. Ce dernier renvoie le solde autorisé à prélever.<br />
4.     le distributeur propose alors plusieurs montants à prélever<br />
5.     le client saisit le montant à retirer<br />
6.     après contrôle du montant par rapport au solde autorisé, le distributeur demande au client s’il désire un ticket<br />
7.     Après la réponse du client, la carte est éjectée et récupérée par le client<br />
8.     les billets sont alors délivrés (ainsi que le ticket)<br />
9.     le client récupère enfin les billets et son ticket<br />

^^Travail à Faire :^^<br />
Modéliser cette situation à l’aide d’un diagramme de séquence en ne prenant en compte que le cas où tout se passe bien. <br />
note : on identifiera les scénarios qui peuvent poser problème en incluant des commentaires dans le diagramme

??? tip "Correction"
    ![correction DAB](./data/seq_DAB_correction.jpg)

## Exercice 2 : Décharger un camion

Pour faciliter sa gestion, un entrepôt de stockage envisage de s’informatiser. Le logiciel à produire doit allouer automatique un emplacement pour le chargement des camions qui convoient le stock à entreposer. Le fonctionnement du système informatique doit être le suivant :<br />

1 . **Déchargement d’un camion :** <br />
lors de l’arrivée d’un camion, un employé doit saisir dans le système les caractéristiques de chaque article  <br />
le système produit alors une liste où figure un emplacement pour chaque article <br />

2 . **Chargement d’un camion :** les caractéristiques des articles à charger dans un camion sont saisies par un employé afin d’indiquer au système de libérer des emplacements.<br />
Le chargement et le déchargement sont réalisés manuellement.<br />
Les employés de l’entrepôt sont sous la responsabilité d’un chef dont le rôle est de superviser la bonne application des consignes.<br />

^^Travail à Faire :^^<br />
Donner  le Diagramme de séquence pour le cas déchargement d’un camion

??? tip "correction"
    ![correction stockage](./data/seq_stockage_correction.jpg)

    et pour info, le diagramme de collaboration correspondant

    ![correction stockage collab](./data/collab_stockage_correction.jpg)

