# Les procédures stockées

## 1. Définition

**MySQL** est un langage procédural (par opposition à **SQL** qui est un langage déclaratif). Il permet de programmer des algorithmes de traitement des données au sein des SGBDR (ici **MySQL**, on aura **PL/SQL** pour oracle, **TRANSACT/SQL** pour SQL Server).<br />
MySQL n'a aucun aspect normatif contrairement à SQL. C'est bien un "produit" au sein commercial du terme. En revanche depuis SQL2 et plus fortement maintenant, avec SQL3, la norme SQL a prévu les éléments de langage procédural normatif propre au langage SQL. Mais il y a une très grande différence entre la norme du SQL procédural et la programmation BD.<br />


Les procédures stockées sont disponibles depuis la version 5 de MySQL. <br />
⏩ Elles permettent d'automatiser des actions qui peuvent être très complexes.<br />
Une procédure stockée est en fait une série d'instructions SQL désignée par un nom. Lorsque l'on crée une procédure stockée, on l'_enregistre_ dans la base de données que l'on utilise, au même titre qu'une table, par exemple. Une fois la procédure créée, il est possible d'appeler celle-ci par son nom. Les instructions de la procédure sont alors exécutées.<br />
Contrairement aux requêtes préparées, qui ne sont gardées en mémoire que pour la session courante, les procédures stockées sont, comme leur nom l'indique, stockées de manière durable, et font bien partie intégrante de la base de données dans laquelle elles sont enregistrées.

### Création d’une procédure stockée

```sql
CREATE PROCEDURE nom_procedure ([parametre1 [, parametre2, ...]])
corps de la procédure;
```
exemple sur la base gesCom, pour afficher les articles en console : 
```sql
CREATE PROCEDURE afficher_liste_articles() 
    -- pas de paramètres dans les parenthèses
SELECT Desart, PUart FROM article;
```
La procédure stockée est stockée dans la base de données.
Pour exécuter la procédure, il suffit de l’appeler ..
```sql
CALL afficher_liste_articles ;
```

### Bloc D’instructions

Pour délimiter un bloc d'instructions (qui peut donc contenir plus d'une instruction), on utilise les mots **BEGIN**  et **END**.

```sql
CREATE PROCEDURE afficher_liste_articles() 
    -- pas de paramètres dans les parenthèses
BEGIN
SELECT Desart, PUart FROM article;
END ;
```
MAIS … ça plante ...<br />

Les mots-clés sont bons, il n'y a pas de paramètres, mais les parenthèses, BEGIN et END sont tous les deux présents. 
Peut-être aurez-vous compris que le problème se situe au niveau du caractère `;` : en effet, un `;` termine une instruction SQL. Or, on a mis un `;` à la suite de `SELECT * FROM article;`. Cela semble logique, mais pose problème puisque c'est le premier `;` rencontré par l'instruction `CREATE PROCEDURE`, qui naturellement pense devoir s'arrêter là. Ceci déclenche une erreur puisqu'en réalité, l'instruction `CREATE PROCEDURE`  n'est pas terminée : le bloc d'instructions n'est pas complet !<br />
🚫 Il faut changer le délimiteur !

### Délimiteur

Ce que l'on appelle délimiteur, c'est tout simplement (par défaut), le caractère `;`. C'est-à-dire le caractère qui permet de délimiter les instructions.<br />
Or, il est tout à fait possible de définir le délimiteur manuellement, de manière à ce que `;` ne signifie plus qu'une instruction se termine. Auquel cas le caractère `;` pourra être utilisé à l'intérieur d'une instruction, et donc dans le corps d'une procédure stockée.

Pour changer le délimiteur, il suffit d'utiliser cette commande :

```sql
DELIMITER |
```
Ce qui donne : 

```sql
DELIMITER |
CREATE PROCEDURE afficher_liste_articles() 
    -- pas de paramètres dans les parenthèses
BEGIN
SELECT Desart, PUart FROM article;
END |
```
__Note :__ Il est possible d'imbriquer plusieurs blocs d'instructions. De même, à l'intérieur d'un bloc d'instructions, plusieurs blocs d'instructions peuvent se suivre. Ceux-ci permettent donc de structurer les instructions en plusieurs parties distinctes et sur plusieurs niveaux d'imbrication différents.

```sql
BEGIN
    SELECT 'Bloc d''instructions principal';
	
    BEGIN
        SELECT 'Bloc d''instructions 2, imbriqué dans le bloc principal';
		
        BEGIN
            SELECT 'Bloc d''instructions 3, imbriqué dans le bloc d''instructions 2';
        END;
    END;
	
    BEGIN
        SELECT 'Bloc d''instructions 4, imbriqué dans le bloc principal';
    END;

END;
```

## 2. Les paramètres d'une procédure stockée

### Sens des paramètres

Un paramètre peut être de trois sens différents : **entrant** (IN),**sortant** (OUT), ou **les deux** (INOUT).<br />
▶️ IN  : c'est un paramètre "entrant". C'est-à-dire qu'il s'agit d'un paramètre dont la valeur est fournie à la procédure stockée. Cette valeur sera utilisée pendant la procédure (pour un calcul ou une sélection, par exemple).<br />
▶️ OUT  : il s'agit d'un paramètre "sortant", dont la valeur sera établie au cours de la procédure et qui pourra ensuite être utilisé en dehors de cette procédure.<br :>
▶️ INOUT  : un tel paramètre sera utilisé pendant la procédure, verra éventuellement sa valeur modifiée par celle-ci, et sera ensuite utilisable en dehors.<br />

### Syntaxe
Lorsque l'on crée une procédure avec un ou plusieurs paramètres, chaque paramètre est défini par trois éléments.<br />
▶️ Son **sens** : entrant, sortant, ou les deux. Si aucun sens n'est donné, il s'agira d'un paramètre IN  par défaut.<br />
▶️ Son **nom** : indispensable pour le désigner à l'intérieur de la procédure.<br />
▶️ Son **type** : INT, VARCHAR(10)…<br />

### Procédure avec un seul paramètre entrant

Voici une procédure qui renvoie l’article selon son id passé en paramètre : <br />

```sql
DELIMITER | -- Facultatif si votre délimiteur est toujours |
CREATE PROCEDURE afficher_article_par_id (IN p_id INT)  
    -- Définition du paramètre p_espece_id
BEGIN
    SELECT desart, PUart
    FROM article
    WHERE Numart = p_id;  -- Utilisation du paramètre
END |
DELIMITER ;  -- On remet le délimiteur par défaut
```
Pour utiliser la procédure 

```sql
CALL afficher_article_par_id(1);
SET @var := 2;
CALL afficher_article_par_id(@var);
```

### La déclaration d’une variable

**MySQL** reconnaît différents types de variables. Le premier type est celui des variables définies par l’utilisateur, identifiées par un symbole `@` utilisé comme préfixe. Dans **MySQL**, vous pouvez accéder aux variables définies par l’utilisateur sans les déclarer ou les initialiser au préalable. Si vous le faites, une valeur `NULL` est attribuée à la variable lors de son initialisation. Par exemple, si vous utilisez `SELECT` avec une variable sans lui donner de valeur, comme dans ce cas :

Exemples :

-	`SELECT @var1;`	 /* MySQL retourne une valeur NULL. */<br />
-	`SELECT @FirstVar=1, @SecondVar=2;`<br />

Une fois que vous avez assigné une valeur à une variable, elle aura un *type* en fonction de la valeur donnée. Dans les exemples précédents, `@FirstVar` et `@SecondVar` sont de type `int`.<br />

Les variables peuvent faire partie des listes de champs d’une déclaration `SELECT`. Vous pouvez mélanger les variables et les noms de champs lorsque vous spécifiez des champs dans une sélection, comme dans cet exemple :<br />

```sql
SET @IndexVar = 1;
SELECT Desart FROM article WHERE numart= @IndexVar;
```
//Ou pour un autre usage
```sql
SET @IndexVar = (SELECT PUart FROM article WHERE numart = 1);
SELECT Desart FROM article WHERE PUart = @IndexVar ;
```

<u>Remarque :</u> Par convention les noms des variables doivent toujours être précédés du symbole `@`

### Affichage d’informations

Syntaxe :
```sql
SELECT Elément_A_Afficher
```
exemple : 

```sql
SET @IndexVar = (SELECT PUart FROM article);
SELECT @IndexVar, Desart
FROM article;
SELECT concat("La variable est ", convert(@IndexVar, CHAR));
```
*Explication :* Affiche la valeur de `@c` concaténé avec la valeur de `@b` mais puisque `@c` est de type numérique et qu'on ne peut jamais concaténer une valeur numérique avec une valeur chaîne de caractères, il faut passer par une fonction de conversion dont la syntaxe est la suivante : `Convert (Type de conversion, Valeur à convertir) ` [Doc ici](https://sql.sh/fonctions/convert)


### Procédure avec deux paramètres, un entrant et un sortant

Voici une procédure assez similaire à la précédente, si ce n'est qu'elle n'affiche pas l’article passé en paramètres, mais compte combien il y a d’articles avec un stock >= à 5 et dont le prix passé en paramètre est inférieur, puis stocke cette valeur dans un paramètre sortant.

```sql
DELIMITER |                                                      
CREATE PROCEDURE nb_art_petit_prix (prix INT, OUT stock INT)  
BEGIN
    SELECT COUNT(*) INTO stock
    FROM article
    WHERE PUart <= prix;                               
END |
DELIMITER ;
```
▶️ Pour appeler la procedure

```sql
CALL nb_art_petit_prix(9, @st);
SELECT @st;
```
▶️ Pour pouvoir l'utiliser, il est nécessaire que le SELECT  ne renvoie **qu'une seule ligne**, et il faut que le nombre de valeurs sélectionnées et le nombre de variables à assigner soient égaux :
Exemple 1 : `SELECT ... INTO`  correct avec deux valeurs
```sql
SELECT id, nom INTO @var1, @var2
FROM tab1 
WHERE id = 7;

SELECT @var1, @var2;
```
Il existe aussi des Procédure avec deux paramètres, un entrant et un entrant-sortant.

### Variables locales

Nous connaissons déjà les variables utilisateur, qui sont des variables désignées par `@`. Il existe aussi des variables système, qui sont des variables prédéfinies par **MySQL**.<br />
Voyons maintenant les variables locales, qui peuvent être définies dans un bloc d'instructions.

**Déclaration d'une variable locale** <br />
La déclaration d'une variable locale se fait avec l'instruction `DECLARE` juste apres le début du bloc d’instruction :<br />
`DECLARE nom_variable type_variable [DEFAULT valeur_defaut];`

▶️ Pour changer la valeur d'une variable locale, on peut utiliser `SET`  ou `SELECT ... INTO`.

*Exemple :* voici une procédure stockée qui donne la date d'aujourd'hui et de demain.<br />
```sql
DELIMITER |
CREATE PROCEDURE aujourdhui_demain ()
BEGIN
    DECLARE v_date DATE DEFAULT CURRENT_DATE();               
    -- On déclare une variable locale et on lui met une valeur par défaut

    SELECT DATE_FORMAT(v_date, '%W %e %M %Y') AS Aujourdhui;

    SET v_date = v_date + INTERVAL 1 DAY;                     
    -- On change la valeur de la variable locale
    SELECT DATE_FORMAT(v_date, '%W %e %M %Y') AS Demain;
END|
DELIMITER ;
```
▶️ Appel : 
```sql
SET lc_time_names = 'fr_FR';
CALL aujourdhui_demain();
```
## 3. Modification d'une PS

### Suppression d’une procédure stockée

Syntaxe : `Drop Procedure Nom_Procédure` ;

### Modification d’une procédure stockée

Syntaxe :
ALTER Procedure Nom_Procédure as
Nouvelles instructions

## 4. Les structures de MySQL

### les structures alternatives

```sql
IF condition THEN instructions
[ELSEIF autre_condition THEN instructions
[ELSEIF ...]]
[ELSE instructions]
END IF;
```
*Exemple :* la procédure suivante affiche 'né avant 2010'  ou 'né après 2010', selon la date de naissance de l'animal transmis en paramètre.

```sql
DELIMITER |
CREATE PROCEDURE avant_apres_2010(IN p_animal_id INT)
BEGIN
    DECLARE v_annee INT;

    SELECT YEAR(date_naissance) INTO v_annee
    FROM Animal
    WHERE id = p_animal_id;

    IF v_annee < 2010 THEN
        SELECT 'né avant 2010' AS naissance;
    ELSE    -- Pas de THEN
        SELECT 'né après 2010' AS naissance;
    END IF; -- Toujours obligatoire

END |
DELIMITER ;

CALL avant_apres_2010(34);   -- Né le 20/04/2008
CALL avant_apres_2010(69);   -- Né le 13/02/2012
```
!!! question "Application"
    === "Enoncé"
        On souhaite vérifier le stock de l'article passé en paramètre.
        Si le stock a atteint le seuil minimum, afficher le message 'Rupture de stock'.
        Sinon afficher 'Stock disponible'
        ▶️ Ecrire la procédure stockée verifier_stock() 
    === "Correction"

        ```sql
        /* On souhaite vérifier si le stock de l'article passé en paramètre a atteint son seuil minimum.
        Si c'est le cas afficher le message 'Rupture de stock' : */
        DELIMITER |
        CREATE PROCEDURE affichage_rupture(num INT)
        BEGIN
            SET @QS = (Select QteEnStock from article Where NumArt =num) ;
            SET @SM = (Select SeuilMin from article Where NumArt =num); 
            If @QS<=@SM THEN
                SELECT 'Rupture de stock' ;
            Else 
                SELECT 'Stock disponible' ;
            END IF;
        END |
        DELIMITER ;

        CALL affichage_rupture2(1)
        ```


### L’instruction case

```sql
CASE valeur_a_comparer
    WHEN possibilite1 THEN instructions
    [WHEN possibilite2 THEN instructions] ...
    [ELSE instructions]
END CASE;
```

!!! question "Application"
    === "Enoncé"
        on reprend la procédure `avant_apres_2010()`, que l'on réécrit avec `CASE`, et en passant  le message en paramètre OUT pour changer un peu.

    === "correction"

        ```sql
        DELIMITER |
        CREATE PROCEDURE avant_apres_2010_case (IN p_animal_id INT, OUT p_message VARCHAR(100))
         BEGIN
            DECLARE v_annee INT;

            SELECT YEAR(date_naissance) INTO v_annee
            FROM Animal
            WHERE id = p_animal_id;

            CASE
                WHEN v_annee < 2010 THEN
                    SET p_message = 'Je suis né avant 2010.';
                WHEN v_annee = 2010 THEN
                    SET p_message = 'Je suis né en 2010.';
                ELSE
                    SET p_message = 'Je suis né après 2010.';   
            END CASE;
        END |
        DELIMITER ;

        CALL avant_apres_2010_case(59, @message);   
        SELECT @message;
        CALL avant_apres_2010_case(62, @message);   
        SELECT @message;
        CALL avant_apres_2010_case(69, @message);
        SELECT @message;
        ```
                
    Il faut au minimum une instruction ou un bloc d'instructions par clause `WHEN`  et par clause `ELSE`. Un bloc vide `BEGIN END;`  est donc nécessaire si l'on ne veut rien exécuter.


!!! question "Application"
    === "Enoncé"
        Afficher la liste des articles (Numéro, Désignation et prix) avec en plus une colonne
        Observation qui affiche 'Non Disponible' si la quantité en stock est égale à 0, 'Disponible' si la quantité en stock est supérieure au stock Minimum et 'à Commander' sinon.
        ▶️ Ecrire la PS correspondante 
    === "Correction"

        ```sql
        DELIMITER |
        CREATE PROCEDURE affichage_rupture4()
        BEGIN
            Select NumArt, DesArt, PUArt,
                Case
                    When QteEnStock=0 then 'Non Disponible'
                    When QteEnStock>SeuilMinimum then 'Disponible'
                    Else 'à Commander'
                END AS observation
                FROM article ;
        END |
        DELIMITER ;
        CALL affichage_rupture4();
        ```

### les structures répétitives

Une boucle est une structure qui permet de répéter plusieurs fois une série d'instructions. Il existe trois types de boucles en MySQL : `WHILE`, `LOOP`  et `REPEAT`.

#### La boucle WHILE

La boucle WHILE  permet de répéter une série d'instructions tant que la condition donnée reste vraie.

```sql
WHILE condition DO    
    -- Attention de ne pas oublier le DO, erreur classique
    instructions
END WHILE;
```

Exemple : la procédure suivante affiche les nombres entiers de 1 à p_nombre (passé en paramètre).<br />

```sql
DELIMITER |
CREATE PROCEDURE compter_jusque_while(IN p_nombre INT)
BEGIN
    DECLARE v_i INT DEFAULT 1;

    WHILE v_i <= p_nombre DO
        SELECT v_i AS nombre; 

        SET v_i = v_i + 1;    
        -- À ne surtout pas oublier, sinon la condition restera vraie
    END WHILE;
END |
DELIMITER ;
CALL compter_jusque_while(3);
```

!!! question "Application"
    === "Enonce"
        Tant que la moyenne des prix des articles n'a pas encore atteint 20 EUROS et le prix le plus élevé pour un article n'a pas encore atteint 30 EUROS, augmenter les prix de 10% et afficher après chaque modification effectuée la liste des articles. Une fois toutes les modifications effectuées, afficher la moyenne des prix et le prix le plus élevé.<br />
        ▶️ Ecrire la PS correspondante 
    === "Correction"

        ```sql
        DELIMITER |
        CREATE PROCEDURE application_while()
        BEGIN
            SET @moyPUart = (Select avg(PUart) from article);
            SET @maxPUart =(select max(PUart) from article);
            WHILE (@moyPUart <20  and @maxPUart <30) DO
                Update article Set puart=puart+(puart*10)/100;
                /* Select * from article ; */
            END WHILE ;
            Select avg(PUart) as moyenne , max(PUart) as Prix_élevé from article ;
        END |
        DELIMITER ;
        ```


#### La boucle REPEAT

La boucle REPEAT  travaille en quelque sorte de manière opposée à WHILE, puisqu'elle exécute des instructions de la boucle jusqu'à ce que la condition donnée devienne vraie.<br />

*Exemple :* voici la même procédure écrite avec une boucle REPEAT.

```sql
DELIMITER |
CREATE PROCEDURE compter_jusque_repeat(IN p_nombre INT)
BEGIN
    DECLARE v_i INT DEFAULT 1;

    REPEAT
        SELECT v_i AS nombre; 

        SET v_i = v_i + 1;    
        -- À ne surtout pas oublier, sinon la condition restera vraie
    UNTIL v_i > p_nombre END REPEAT;
END |
DELIMITER ;

CALL compter_jusque_repeat(3);

-- Condition fausse dès le départ, on ne rentre pas dans la boucle
CALL compter_jusque_while(0);   

-- Condition fausse dès le départ, on rentre quand même une fois dans la boucle
CALL compter_jusque_repeat(0);
```

#### La boucle LOOP

On a gardé la boucle LOOP  pour la fin, parce qu'elle est un peu particulière. En effet, voici sa syntaxe :<br />
```sql
[label:] LOOP
    instructions
END LOOP [label]
```
Il n'est question de condition nulle part. En fait, une boucle LOOP doit intégrer dans ses instructions un élément qui va la faire s'arrêter : typiquement, une instruction LEAVE. Sinon, c'est une boucle infinie.<br />

*Exemple :* à nouveau une procédure qui affiche les nombres entiers de `1 à p_nombre`.
```sql
DELIMITER |
CREATE PROCEDURE compter_jusque_loop(IN p_nombre INT)
BEGIN
    DECLARE v_i INT DEFAULT 1;

    boucle_loop: LOOP
        SELECT v_i AS nombre; 

        SET v_i = v_i + 1;

        IF v_i > p_nombre THEN
            LEAVE boucle_loop;
        END IF;    
    END LOOP;
END |
DELIMITER ;

CALL compter_jusque_loop(3);
```

## 5. Avantages, inconvénients et usage des procédures stockées

### Avantages

Les procédures stockées permettent de **réduire les allers-retours entre le client et le serveur** MySQL. En effet, si l'on englobe en une seule procédure un processus demandant l'exécution de plusieurs requêtes, le client ne communique qu'une seule fois avec le serveur (pour demander l'exécution de la procédure) pour exécuter la totalité du traitement. Cela permet donc un certain gain en performance.<br />
Elles permettent également de **sécuriser une base de données**. Par exemple, il est possible de restreindre les droits des utilisateurs de façon à ce qu'ils puissent uniquement exécuter des procédures. Finis les DELETE  dangereux ou les UPDATE  inconsidérés. Chaque requête exécutée par les utilisateurs est créée et contrôlée par l'administrateur de la base de données par l'intermédiaire des procédures stockées.<br />

Cela permet ensuite de s'assurer qu'un traitement est **toujours exécuté de la même manière**, quelle que soit l'application/le client qui le lance. Il arrive par exemple qu'une même base de données soit exploitée par plusieurs applications, lesquelles peuvent être écrites avec différents langages. Si on laisse chaque application avoir son propre code pour un même traitement, il est possible que des différences apparaissent (distraction, mauvaise communication, erreur ou autre). Par contre, si chaque application appelle la même procédure stockée, ce risque disparaît.

### Inconvénients

Les **procédures stockées** ajoutent évidemment à la charge du serveur de données. Plus on implémente de logique de traitement directement dans la base de données, moins le serveur est disponible pour son but premier : le stockage de données.<br />

Par ailleurs, certains traitements seront toujours plus simples et plus courts à écrire (et donc à maintenir) s'ils sont développés dans un langage informatique adapté. A fortiori lorsqu'il s'agit de traitements complexes. La logique qu'il est possible d'implémenter avec MySQL permet de nombreuses choses, mais reste assez basique.<br />

Enfin, la syntaxe des procédures stockées diffère beaucoup d'un SGBD à un autre. Par conséquent, si l'on désire en changer, il faudra procéder à un grand nombre de corrections et d'ajustements.<br />

### Conclusion et usage
Comme souvent, tout est question d'équilibre. Il faut savoir utiliser des procédures quand c'est utile, quand on a une bonne raison de le faire. Il ne sert à rien d'en abuser. Pour une base contenant des données ultrasensibles, une bonne gestion des droits des utilisateurs couplée à l'usage de procédures stockées peut se révéler salutaire. <br />

Pour une base de données destinée à être utilisée par plusieurs applications différentes, on choisira de créer des procédures pour les traitements généraux et/ou pour lesquels la moindre erreur peut poser de gros problèmes. Pour un traitement long, impliquant de nombreuses requêtes et une logique simple, on peut sérieusement gagner en performance en le faisant dans une procédure stockée (a fortiori si ce traitement est souvent lancé).<br />
✔️ À vous de voir quelles procédures sont utiles pour votre application et vos besoins.

!!! success	"En résumé"
    ▶️ Une procédure stockée est un ensemble d'instructions que l'on peut exécuter sur commande.<br />
    ▶️ Une procédure stockée est un objet de la base de données stocké de manière durable, au même titre qu'une table. Elle n'est pas supprimée à la fin de la session comme l'est une requête préparée.<br />
    ▶️ On peut passer des paramètres à une procédure stockée, qui peuvent avoir trois sens : IN(entrant), OUT  (sortant) ou INOUT  (les deux).<br />
    ▶️ SELECT ... INTO  permet d'assigner des données sélectionnées à des variables ou des paramètres, à condition que le SELECT  ne renvoie qu'une seule ligne, et qu'il y ait autant de valeurs sélectionnées que de variables à assigner.<br />
    ▶️ Les procédures stockées peuvent permettre de gagner en performance en diminuant les allers-retours entre le client et le serveur. Elles peuvent également aider à sécuriser une base de données et à s'assurer que les traitements sensibles sont toujours exécutés de la même manière.<br />
    ▶️ Par contre, elle ajoute à la charge du serveur et sa syntaxe n'est pas toujours portable d'un SGBD à un autre.
