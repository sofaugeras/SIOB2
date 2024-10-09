# Les permissions

!!! note "source"

    - N. Defay, Lycée Bellepierre, La réunion (licence Creative Commons BY-NC-SA) <br />
    - [Documatation MySQL Account Management Statements](https://dev.mysql.com/doc/refman/8.4/en/account-management-statements.html)
    - [tuto en ligne de commande](https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql)

Jusqu’à présent nous avons abordé le langage de manipulation de données puis le langage de description de données.<br />
Dans ce paragraphe nous étudierons le langage de contrôle des données qui assure la sécurité des données, et leur confidentialité.

## 1. Définition

Plusieurs  personnes  peuvent  travailler  simultanément  sur  une  base  de  données.  Ces personnes n'ont pas forcément les mêmes besoins : certaines peuvent par exemple nécessiter de modifier des données dans une table, tandis que les autres ne l'utiliseront que pour la consulter.

Ainsi, il  est  possible de  définir des  permissions pour  chaque personne  (ou  plutôt  chaque utilisateur/connexion). Cette tâche incombe à l'**administrateur de la base de données** (en anglais DBA, DataBase Administrator). Il doit dans un premier temps définir les besoins de chacun, puis les appliquer à la(les) base(s) de données sous forme de permissions.

## 2. Création d’utilisateur

La plupart du temps, lorsque l’on travaille en local avec WAMP, on utilise le compte ``root`` (administrateur) de MySQL pour se connecter au serveur et accéder aux bases de données. Cette manière de fonctionner n’est pas sans risques et ne reflète pas la réalité d’un système en production.

Des utilisateurs peuvent être créés via phpMyAdmin ou encore, en utilisant la commande suivante :

``CREATE USER user [IDENTIFIED BY [PASSWORD] 'password'] [, user [IDENTIFIED BY [PASSWORD] 'password']]`` ...

Pour pouvoir créer un utilisateur, il faut avoir les permissions pour le faire ou bien utiliser le compte administrateur (root)

Exemple :

```SQL
CREATE USER bibliAdm IDENTIFIED BY 'adm974'
```

L’utilisateur est créé, il peut se connecter au serveur MySQL mais il n’a aucun droit. Le privilège associé est nommé USAGE (seule la connexion au serveur est possible)
 
## 3. Attribution des permissions

C’est la clause ``GRANT`` qui permet d'attribuer des permissions à un ou plusieurs utilisateurs sur un ou plusieurs éléments de la base de données.

La syntaxe de cette clause est la suivante :

```SQL
GRANT Liste_de_permissions
ON Liste_d_objets
TO Liste_d_utilisateurs
[WITH GRANT OPTION];
```

### 2.1 Les principales permissions :

:arrow_forward: (Liste_de_permissions) :

-     ``DELETE``     : Privilège de supprimer les données d'une table
-     ``INSERT``     : Privilège d'ajouter des données à une table
-     ``SELECT``     : Privilège d'accéder aux données d'une table
-     ``UPDATE``     : Privilège de mettre à jour les données d'une table
-     ``ALL``        : Tous les privilèges

Il est également possible d’attribuer par exemple des permissions pour la création et la suppression d’une table, etc…
La permission peut également porter sur certains champs d’une table. Ceux-ci devront être précisés entre parenthèses.

:arrow_forward: Ces permissions peuvent être appliquées sur (Liste_d_objets) :

-     ``*.*``                   : L’ensemble des bases de données du serveur
-     ``nom_base.*``            : Une base de données précise
-     ``nom_base.une_table``    : Une table dans une base de données

:arrow_forward: Enfin, ces permissions peuvent être accordées à (Liste_d_utilisateurs) :

-     ``PUBLIC``           : L’ensemble des utilisateurs
-     ``user [,user]...``  : Un ou plusieurs utilisateurs

:arrow_forward: L'option ``WITH GRANT OPTION`` permet de définir si l'utilisateur peut lui-même accorder à un autre utilisateur les permissions qu'on lui a accordées.

## 4. Suppression des permissions

C’est la clause ``REVOKE`` qui permet de retirer des permissions à un ou plusieurs utilisateurs sur un ou plusieurs éléments de la base de données. On parle également de révocation de permission.

La syntaxe de cette clause est la suivante :
```SQL
REVOKE
[GRANT OPTION] Liste_de_permissions
ON Liste_d_objets
FROM Liste_d_utilisateurs;
```
``Liste_de_permissions``, ``Liste_d_objets`` et ``Liste_d_utilisateurs`` correspondent aux mêmes paramètres que pour la clause ``GRANT``.

L'option ``GRANT OPTION`` permet de supprimer le droit d'un utilisateur à accorder des permissions à un autre utilisateur.

!!! warning "A retenir 	:anchor:"

    En cybersécurité, il est recommandé d'appliquer le **principe du moindre privilège**. Cela signifie qu'un utilisateur ne doit avoir que les droits strictement nécessaires pour accomplir ses tâches, et rien de plus. Créer un utilisateur distinct pour chaque base de données et lui accorder des droits limités est une pratique ABSOLUMENT nécessaire pour limiter les risques en cas de compromission.

    ```SQL
    CREATE USER 'utilisateur_mabase'@'localhost' IDENTIFIED BY 'mot_de_passe';
    GRANT SELECT, INSERT, UPDATE, DELETE ON mabase.* TO 'utilisateur_mabase'@'localhost';
    FLUSH PRIVILEGES;
    ```
    Cela crée l'utilisateur ``utilisateur_mabase``, lui donne tous les droits sur la base ``mabase``, et actualise les privilèges pour que les changements soient pris en compte immédiatement.

    Cela garantit que cet utilisateur ne peut que manipuler les données sans affecter la structure de la base de données.

    En suivant ces principes, on minimise les risques et réduit l'impact potentiel d'une violation de sécurité.