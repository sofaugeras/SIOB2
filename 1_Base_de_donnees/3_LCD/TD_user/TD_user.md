**Exemples d’attribution de privilèges**

![base bibliothèque](../2_LMD/data/bibli.png){: width=50% .center}

[Télécharger fichier Création de la base BIBLI :arrow_down:](./data/script_creation_bibli.sql){ .md-button .md-button--primary }

Donner les instructions SQL pour réaliser les traitements qui suivent.

:arrow_forward: Actions réalisées par l’administrateur (compte ``root``) :

**R1 :** L’utilisateur ``bibliAdm`` peut consulter toutes les tables des bases de données présentes sur le serveur.

??? question "Solution"

    ```SQL

    ```

**R2 :** ``bibliAdm``  peut  créer  des  utilisateurs et  leur attribuer ses droits.

??? question "Solution"

    ```SQL

    ```

**R3 :** ``bibliAdm`` possède tous les droits sur la base « bibli ».

??? question "Solution"

    ```SQL

    ```

:arrow_forward: Actions réalisées par l’administrateur de la base « bibli » (compte ``bibliAdm``) :

**R4 :** Création d’un utilisateur ``bibliCli`` avec pour mot de passe « cli974 ».

??? question "Solution"

    ```SQL

    ```

**R5 :** ``bibliCli`` peut consulter toutes les tables de la base « bibli ».

??? question "Solution"

    ```SQL

    ```

**R6 :** ``bibliCli`` peut ajouter et modifier les enregistrements dans la table « emprunter ».

??? question "Solution"

    ```SQL

    ```

**R7 :** ``bibliCli`` peut modifier le prénom des lecteurs dans la table « lecteur ».

??? question "Solution"

    ```SQL

    ```

:arrow_forward: Actions réalisées par l’administrateur de la base « bibli » (compte ``bibliAdm``) :

**R8 :** L’utilisateur ``bibliCli`` n’a plus le droit de modifier la table ``emprunter``.

??? question "Solution"

    ```SQL

    ```

**R9 :** L’utilisateur ``bibliCli`` n’a plus le droit de modifier la colonne ``prenomlecteur`` de la table ``lecteur``.

??? question "Solution"

    ```SQL

    ```

:arrow_forward: Actions réalisées par l’administrateur (compte ``root``) :

**R10 :** L’utilisateur ``bibliAdm`` ne peut plus consulter les autres bases que « bibli ».

??? question "Solution"

    ```SQL

    ```

**R11 :** L’utilisateur ``bibliAdm`` n’a plus le droit d’attribuer des privilèges aux utilisateurs.

??? question "Solution"

    ```SQL

    ```