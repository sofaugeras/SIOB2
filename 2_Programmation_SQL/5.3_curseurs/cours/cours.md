# Les curseurs

## définition

Nous avons vu qu'il était possible d'exploiter le résultat d'un `SELECT` dans un bloc d'instructions en utilisant la commande `SELECT colonne(s) INTO variable(s)`, qui assigne les valeurs sélectionnées à des variables.<br />
Cependant, `SELECT ... INTO`  ne peut être utilisé que pour des requêtes qui ne ramènent qu'une seule ligne de résultats.<br />
Les **curseurs** permettent de parcourir un jeu de résultats d'une requête `SELECT`, quel que soit le nombre de lignes récupérées, et d'en exploiter les valeurs.<br />

Quatre étapes sont nécessaires pour utiliser un curseur.<br />
- Déclaration du curseur : avec une instruction `DECLARE`.<br />
- Ouverture du curseur : on exécute la requête `SELECT` du curseur et on stocke le résultat dans celui-ci.<br />
- Parcours du curseur : on parcourt une à une les lignes.<br />
- Fermeture du curseur.

## Syntaxe

###  Déclaration du curseur

Comme toutes les instructions `DECLARE`, la déclaration d'un curseur doit se faire au début du bloc d'instructions pour lequel celui-ci est défini. Plus précisément, on déclare les curseurs après les variables locales et les conditions, mais avant les gestionnaires d'erreurs.

```sql
DECLARE nom_curseur CURSOR FOR requete_select;
Un curseur est donc composé d'un nom, et d'une requête SELECT.
Exemple :
DECLARE curseur_client CURSOR 
    FOR SELECT * 
    FROM Client;
```

### Ouverture et fermeture du curseur

En déclarant le curseur, on a donc associé un nom et une requête `SELECT`. L'ouverture du curseur va provoquer l'exécution de la requête `SELECT`, ce qui va produire un jeu de résultats. Une fois que l'on aura parcouru les résultats, il n'y aura plus qu'à fermer le curseur. Si l'on ne le fait pas explicitement, le curseur sera fermé à la fin du bloc d'un `OPEN nom_curseur`;

```sql
  -- Parcours du curseur et instructions diverses
CLOSE nom_curseur;.
```

### Parcours du curseur

Une fois que le curseur a été ouvert et le jeu de résultats récupéré, le curseur place un **pointeur** sur la première ligne de résultats. Avec la commande **FETCH**, on récupère la ligne sur laquelle pointe le curseur, et on fait avancer le pointeur vers la ligne de résultats suivante. On peut comparer ce fonctionnement avec la lecture de requête en PHP.

```sql
FETCH nom_curseur INTO variable(s);
```

Bien entendu, comme pour `SELECT ... INTO`, il faut donner autant de variables dans la clause `INTO`  que l'on a récupéré de colonnes dans la clause `SELECT`  du curseur.

*Exemple :* la procédure suivante parcourt les deux premières lignes d’une table Client avec un curseur.

```sql
DELIMITER |
CREATE PROCEDURE parcours_deux_clients()
BEGIN
    DECLARE v_nom, v_prenom VARCHAR(100);

    DECLARE curs_clients CURSOR
        FOR SELECT nom, prenom  -- Le SELECT récupère deux colonnes
        FROM Client
        ORDER BY nom, prenom;   
        -- On trie les clients par ordre alphabétique

    OPEN curs_clients;  -- Ouverture du curseur

    FETCH curs_clients INTO v_nom, v_prenom;    
    -- On récupère la première ligne et on assigne les valeurs récupérées à nos variables locales
    SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Premier client';

    FETCH curs_clients INTO v_nom, v_prenom;
    -- On récupère la seconde ligne et on assigne les valeurs récupérées à nos variables locales
    SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Second client';

    CLOSE curs_clients;     -- Fermeture du curseur
END|
DELIMITER ;

CALL parcours_deux_clients();
```

### Restrictions

`FETCH`  est la seule commande permettant de récupérer une partie d'un jeu de résultats d'un curseur, et elle ne permet qu'une chose : récupérer la ligne de résultats suivante.<br />
Il n'est pas possible de sauter une ou plusieurs lignes ni d'aller rechercher une ligne précédente. On ne peut que parcourir les lignes une à une, de la première à la dernière. Ensuite, il n'est pas possible de modifier une ligne directement à partir d'un curseur. Il s'agit d'une restriction particulière à **MySQL**. D'autres SGBD vous permettent des requêtes d'`UPDATE` directement sur les curseurs.

### Parcourir intelligemment tous les résultats d'un curseur

Pour récupérer une ligne de résultats, on utilise donc `FETCH`. Dans la procédure `parcours_deux_clients()`, on voulait récupérer les deux premières lignes, on a donc utilisé deux `FETCH`. Cependant, la plupart du temps, on ne veut pas seulement utiliser les deux premières lignes, mais toutes ! Or, sauf exception, on ne sait pas combien de lignes seront sélectionnées.<br />

On veut donc parcourir une à une les lignes de résultats et leur appliquer un traitement, sans savoir à l'avance combien de fois ce traitement devra être répété. Pour cela, on utilise une boucle ! `WHILE`, `REPEAT` ou `LOOP`. Il n'y a plus qu'à trouver une condition pour arrêter la boucle une fois tous les résultats parcourus.

### Condition d'arrêt

Voyons ce qui se passe lorsque l'on fait un `FETCH` alors qu'il n'y a plus, ou pas, de résultats.<br />
Voici une procédure qui sélectionne les clients selon une ville donnée en paramètre. Les lignes sont récupérées et affichées grâce au `FETCH`, placé dans une boucle `LOOP`. Je rappelle que cette boucle ne définit pas de condition d'arrêt : il est nécessaire d'ajouter une instruction `LEAVE`  pour l'arrêter. Ici, pour tester, on ne mettra pas d'instruction `LEAVE`.

```sql
DELIMITER |
CREATE PROCEDURE test_condition(IN p_ville VARCHAR(100))
BEGIN
    DECLARE v_nom, v_prenom VARCHAR(100);

    DECLARE curs_clients CURSOR
        FOR SELECT nom, prenom
        FROM Client
        WHERE ville = p_ville;

    OPEN curs_clients;                                    

    LOOP                                                  
        FETCH curs_clients INTO v_nom, v_prenom;                   
        SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Client';
    END LOOP;

    CLOSE curs_clients; 
END|
DELIMITER ;
```

*Exemple :* Pour afficher la liste des articles sous la forme :
<em>L'article Numéro ........  portant la désignation ………coûte …. …..</em>>

▶️ Ecrire le curseur correspondant 

??? question "Correction"

    ```sql
    Declare @a int, @b Varchar(10), @c real
    Declare Cur_ListeArt Cursor for Select NumArt, DesArt,puart from article
    Open Cur_ListeArt
    Fetch Next from Cur_ListeArt into @a,@b,@c
    While @@fetch_status=0
    Begin
    Print 'L''article numéro ' + convert(varchar,@a) + ' portant la désignation ' + @b+ ' coûte    ' +     convert(varchar,@c)
    Fetch Next from Cur_ListeArt into @a,@b,@c
    End
    Close Cur_ListeArt
    Deallocate Cur_ListeArt
    ```
