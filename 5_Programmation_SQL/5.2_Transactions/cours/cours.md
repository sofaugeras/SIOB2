# Le transactionnel

Les transactions sont une fonctionnalité absolument indispensable, permettant de sécuriser une application utilisant une base de données. Sans transactions, certaines opérations risqueraient d'être à <mark>moitié</mark> réalisées, et la moindre erreur, la moindre interruption pourraient avoir des conséquences énormes. En effet, les transactions permettent de regrouper des requêtes dans des blocs, et de faire en sorte que tout le bloc soit exécuté en une seule fois, cela afin de préserver l'intégrité des données de la base.
<br />
Une transaction permet d'exécuter un groupe d'instructions. Si pour une raison ou une autre l'une de ces instructions n'a pas pu être exécutée, tous le groupe d'instructions est annulé (le tout ou rien) :<br />
▶️  Pour démarrer une transaction on utilise l'instruction `START TRANSACTION`
▶️	Pour valider la transaction et rendre les traitements qui lui sont associés effectifs, on utilise l'instruction `COMMIT`
▶️	interrompre une transaction en cours qui n'a pas encore été validée, on utilise l'instruction `ROLLBACK`
▶️	Si plusieurs transactions peuvent être en cours, on peut leur attribuer des noms pour les distinguer


## Syntaxe 

```sql
START TRANSACTION
    [transaction_characteristic [, transaction_characteristic] ...]

transaction_characteristic: {
    WITH CONSISTENT SNAPSHOT
  | READ WRITE
  | READ ONLY
}

BEGIN [WORK]
COMMIT [WORK] [AND [NO] CHAIN] [[NO] RELEASE]
ROLLBACK [WORK] [AND [NO] CHAIN] [[NO] RELEASE]
SET autocommit = {0 | 1}
```
## Exemple 

```sql
START TRANSACTION;
SELECT @A:=SUM(salary) FROM table1 WHERE type=1;
UPDATE table2 SET summary=@A WHERE type=1;
COMMIT;
```

## Application

Supposons qu'il n'existe pas de contrainte clé étrangère entre le champ `NumCom` de la table `LigneCommande` et le champ `NumCom` de la `Commande`. On souhaite supprimer la commande numéro 5 ainsi que la liste de ces articles. <br />
Le programme serait :

 ```sql
Delete from Commande where NumCom=5
Delete from LigneCommande where NumCom=5
```
Mais si, juste après l'exécution de la première instruction et alors que la deuxième n'a pas encore eu lieu, un problème survient (une coupure de courant par exemple) la base de données deviendra incohérente car on aura des lignes de commande pour une commande qui n'existe pas.<br />
En présence d'une transaction, le programme n'ayant pas atteint l'instruction Commit Tran, aurait annulé toutes les instructions depuis Begin Tran. Le programme devra être alors :

 ```sql
START TRANSACTION;
Delete from Commande where NumCom=5
Delete from LigneCommande where NumCom=5
COMMIT;
```