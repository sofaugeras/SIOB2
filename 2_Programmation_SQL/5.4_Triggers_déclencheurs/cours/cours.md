# Les triggers ou déclencheurs

Les **triggers** (ou déclencheurs) sont des objets de la base de données. Attachés à une table, ils vont déclencher l'exécution d'une instruction, ou d'un bloc d'instructions, lorsqu'une ou plusieurs lignes sont insérées, supprimées ou modifiées dans la table à laquelle ils sont attachés.<br />

Nous allons voir comment ils fonctionnent exactement, comment on peut les créer et les supprimer, et surtout, comment on peut s'en servir et quelles sont leurs restrictions.

## Principe et usage

### Qu'est-ce qu'un trigger ?

Tout comme les procédures stockées, les triggers servent à exécuter une ou plusieurs instructions. Mais à la différence des procédures, <mark>il n'est pas possible d'appeler un trigger</mark> : un trigger doit être déclenché par un événement.<br />

Un trigger est attaché à une table et peut être déclenché par :<br />
>   une **insertion** dans la table (requête `INSERT`) <br />
    la **suppression** d'une partie des données de la table (requête `DELETE`) <br />
    la **modification** d'une partie des données de la table (requête `UPDATE`)<br />

Par ailleurs, une fois le trigger déclenché, ses instructions peuvent être exécutées soit juste avant l'exécution de l'événement déclencheur, soit juste après.

### Que fait un trigger ?

Un trigger exécute un traitement pour chaque ligne insérée, modifiée ou supprimée par l'événement déclencheur. Donc si l'on insère cinq lignes, les instructions du trigger seront exécutées cinq fois, chaque itération permettant de traiter les données d'une des lignes insérées.<br />

Les instructions d'un trigger suivent les mêmes principes que les instructions d'une procédure stockée. S'il y a plus d'une instruction, il faut les mettre à l'intérieur d'un bloc d'instructions. Les structures que nous avons vues dans les deux chapitres précédents sont bien sûr utilisables (structures conditionnelles, boucles, gestionnaires d'erreurs, etc.), avec toutefois quelques restrictions que nous verrons en fin de chapitre.
<br />
Un trigger peut **modifier et/ou insérer** des données dans n'importe quelle table sauf les tables utilisées dans la requête qui l'a déclenché. En ce qui concerne la table à laquelle le trigger est attaché (qui est forcément utilisée par l'événement déclencheur), le trigger peut lire et modifier uniquement la ligne insérée, modifiée ou supprimée qu'il est en train de traiter.

### À quoi sert un trigger ?

On peut faire de nombreuses choses avec un trigger. Voici quelques exemples d'usage fréquent de ces objets. 

#### Contraintes et vérifications de données

MySQL n'implémente pas de contraintes d'assertion, qui sont des contraintes permettant de limiter les valeurs acceptées par une colonne (limiter une colonne TINYINT  à TRUE  (1) ou FALSE  (0), par exemple).<br />
Avec des triggers se déclenchant avant l'INSERT  et avant l'UPDATE, on peut vérifier les valeurs d'une colonne lors de l'insertion ou de la modification, et les corriger si elles ne font pas partie des valeurs acceptables, ou bien faire échouer la requête. On peut ainsi pallier l'absence de contraintes d'assertion.

#### Intégrité des données

Les triggers sont parfois utilisés pour remplacer les options des clés étrangères `ON UPDATE RESTRICT|CASCADE|SET NULL`  et `ON DELETE RESTRICT|CASCADE|SET NULL`, notamment pour des tables **MyISAM** qui sont non transactionnelles et ne supportent pas les clés étrangères.<br />
Cela peut aussi être utilisé avec des tables transactionnelles, dans les cas où le traitement à appliquer pour garder des données cohérentes est plus complexe que ce qui est permis par les options de clés étrangères.<br />

Par exemple, dans certains systèmes, on veut pouvoir appliquer deux systèmes de suppression :<br />
- une vraie suppression pure et dure, avec effacement des données, donc une requête DELETE  <br />
- un archivage, qui masquera les données dans l'application, mais les conservera dans la base de données.<br />

Dans ce cas, une solution possible est d'ajouter aux tables contenant des données archivables une colonne archive, pouvant contenir 0 (la ligne n'est pas archivée) ou 1 (la ligne est archivée). Pour une vraie suppression, on peut utiliser simplement un `ON DELETE RESTRICT|CASCADE|SET NULL` qui se répercutera sur les tables référençant les données supprimées. Par contre, dans le cas d'un archivage, on utilisera plutôt un trigger pour traiter les lignes qui référencent les données archivées, par exemple en les archivant également.

#### Historisation des actions

On veut parfois garder une trace des actions effectuées sur la base de données, c'est-à-dire, par exemple, savoir qui a modifié telle ligne, et quand. Avec les triggers, rien de plus simple, il suffit de mettre à jour des données d'historisation à chaque insertion, modification ou suppression, soit directement dans la table concernée, soit dans une table utilisée spécialement et exclusivement pour garder un historique des actions.

#### Mise à jour d'informations qui dépendent d'autres données

Comme pour les procédures stockées, une partie de la logique "business" de l'application peut être codée directement dans la base de données grâce aux **triggers**, plutôt que du côté applicatif (en PHP, Java ou quel que soit le langage de programmation utilisé).
À nouveau, cela peut permettre d'harmoniser un traitement à travers plusieurs applications utilisant la même base de données.
Par ailleurs, lorsque certaines informations dépendent de la valeur de certaines données, on peut en général les retrouver en faisant une requête `SELECT`. Dans ce cas, il n'est pas indispensable de stocker ces informations.<br />
**Cependant**, utiliser les triggers pour stocker ces informations peut faciliter la vie de l'utilisateur et peut aussi faire gagner en performance, par exemple, si l'on a très souvent besoin de cette information, ou si la requête à faire pour trouver cette information est longue à exécuter. C'est typiquement cet usage qui est fait des triggers dans ce que l'on appelle les "vues matérialisées".

## Création des triggers

### Syntaxe

Pour créer un trigger, on utilise la commande suivante :
```sql
CREATE TRIGGER nom_trigger moment_trigger evenement_trigger
ON nom_table FOR EACH ROW
corps_trigger;
```
➡️ `CREATE TRIGGER nom_trigger`  : les triggers ont donc un nom.<br />
➡️ `moment_trigger`` evenement_trigger`  : servent à définir quand et comment le trigger est déclenché.<br />
➡️ `ON nom_table`  : c'est là que l'on définit à quelle table le trigger est attaché.<br />
➡️ `FOR EACH ROW`  : signifie littéralement "pour chaque ligne", sous-entendu "pour chaque ligne insérée/supprimée/modifiée" selon ce qui a déclenché le trigger.<br />
➡️ `corps_trigger`  : c'est le contenu du trigger. Comme pour les procédures stockées, il peut s'agir soit d'une seule instruction, soit d'un bloc d'instructions.<br />

### Événement déclencheur

Trois événements différents peuvent déclencher l'exécution des instructions d'un trigger :<br />
➡️ l'**insertion** de lignes (INSERT) dans la table attachée au trigger <br />
➡️ la **modification** de lignes (UPDATE) de cette table <br />
➡️ la **suppression** de lignes (DELETE) de la table.<br />
Un trigger est déclenché soit par INSERT, soit par UPDATE, soit par DELETE. Il ne peut pas être déclenché par deux événements différents. On peut par contre créer plusieurs triggers par table pour couvrir chaque événement.

▶️ Avant ou après<br />
Lorsqu'un trigger est déclenché, ses instructions peuvent être exécutées à deux moments différents : soit juste avant que l'événement déclencheur n'ait lieu (`BEFORE`), soit juste après (`AFTER`).<br />

Donc, si vous avez un trigger `BEFORE UPDATE` sur la table `A`, l'exécution d'une requête `UPDATE` sur cette table va d'abord déclencher l'exécution des instructions du trigger, ensuite seulement les lignes de la table seront modifiées.<br />

*Exemple :* Pour créer un trigger sur la table `Article`, déclenché par une insertion et s'exécutant après ladite insertion, on utilisera la syntaxe suivante :
```sql
CREATE TRIGGER after_insert_article AFTER INSERT
ON Article FOR EACH ROW
corps_trigger;
```

### Règle et convention

Il ne peut exister qu'un seul trigger par combinaison `moment_trigger/evenement_trigger` par table. Donc un seul trigger `BEFORE UPDATE` par table, un seul `AFTER DELETE`, etc...<br />

Étant donné qu'il existe deux possibilités pour le moment d'exécution, et trois pour l'événement déclencheur, on a donc un maximum de **six** triggers par table. Cette règle étant établie, il existe une convention quant à la manière de nommer ses triggers, que je vous encourage à suivre : `nom_trigger = moment_evenement_table`. Donc le trigger `BEFORE UPDATE ON Animal`  aura pour nom : `before_update_animal`.

### OLD et NEW

Dans le corps du trigger, **MySQL** met à disposition deux mots-clés : OLD  et NEW.<br />
▶️ OLD  représente les valeurs des colonnes de la ligne traitée avant qu'elle ne soit modifiée par l'événement déclencheur. Ces valeurs peuvent être lues, mais pas modifiées.<br />
▶️ NEW  représente les valeurs des colonnes de la ligne traitée après qu'elle a été modifiée par l'événement déclencheur. Ces valeurs peuvent être lues et modifiées.<br />
Il n'y a que dans le cas d'un trigger `UPDATE` que `OLD` et `NEW`  coexistent. Lors d'une insertion, `OLD` n'existe pas, puisque la ligne n'existe pas avant l'événement déclencheur. Dans le cas d'une suppression, c'est `NEW`  qui n'existe pas, puisque la ligne n'existera plus après l'événement déclencheur.

### Suppression des triggers

Encore une fois, la commande `DROP` permet de supprimer un trigger.
```sql
DROP TRIGGER nom_trigger;
```
Tout comme pour les procédures stockées, il n'est pas possible de modifier un trigger. Il faut le supprimer puis le recréer différemment. Par ailleurs, si l'on supprime une table, on supprime également tous les triggers qui y sont attachés.

### Fonctionnement des tables inserted et deleted

Au cours des opérations d'ajout, de suppression et de modification, le système utilise les **tables temporaires** `inserted` et `deleted`. Ces tables ne sont accessibles qu'au niveau des triggers et leur contenu est perdu dès que les triggers sont validés.
<br />
**Action d'ajout :** Les enregistrements ajoutés sont placés dans une table temporaire nommée `inserted`<br />
▶️ Action de suppression : Les enregistrements supprimés sont placés dans une table temporaire nommée deleted.<br />
▶️ Action de modification :  L'opération de modification est interprétée comme une opération de suppression des anciennes informations et d'ajout des nouvelles informations. 

C'est pourquoi le système utilise dans ce cas les deux tables temporaires `deleted` et `inserted`. En fait quand un utilisateur demande à modifier des enregistrements, ceux ci sont d'abord sauvegardés dans la table temporaire `deleted` et la copie modifiée est enregistrée dans la table `inserted`.


### Exemple de triggers 

Le trigger suivant à la suppression d'une ligne de commande, remet à jour le stock et vérifie s'il s'agit de la dernière ligne pour cette commande. Si c'est le cas la commande est supprimée :

```sql
DELIMITER |
Create Trigger Tr_Supprimer_Ligne AFTER DELETE
On LigneCommande FOR EACH ROW
BEGIN
    Update article 
    set QteEnStock = QteEnStock + OLD.QteCommandee where OLD.numart=article.numart;
    Delete from commande where numcom not in (select numcom from lignecommande);
END |
DELIMITER ;
```
