# Exercices

## Exercice 1
Le trigger suivant interdit la modification des commandes

??? question "Correction"

    ```sql
    Create Trigger Tr_Empêcher_Modif
    On Commande
    For Update
    As
    Rollback

    ```

## Exercice 2
Le trigger suivant interdit la modification du numéro de commande et vérifie si la date saisie pour la date de commande est supérieure ou égale à la date du jour

??? question "Correction"

    ```sql
    Create Trigger Tr_Empêcher_Modif_Numcom
    On Commande
    For Update
    As
    if update(NumCom)
        Begin
        Raiserror('le numéro de commande ne peut être modifié',15,120)
        Rollback
    End
    if update(DatCom)
        Begin
        if ((select count (DatCom) from inserted
            Where datediff(day,datcom,getdate() )>0)<> 0)
            Begin
            Raiserror('La date de commande ne peut pas être inférieur à la date en cours',15,120)
            Rollback
        End
    End

    ```

## Exercice 3
Le trigger suivant empêche la suppression des commandes ayant des articles associés
Remarque : Ce trigger ne se déclenchera pas s'il existe une contrainte clé étrangère entre le champ NumCom de la table ligneCommande et le champ NumCom de la table commande.

??? question "Correction"

    ```sql
    Create Trigger Tr_Empêcher_Suppr
    On Commande
    For Delete
    As
    Declare @a int
    set @a =(Select count(numart) from lignecommande, deleted where lignecommande.numcom =deleted.numcom)
    if (@a>0)
    Begin
    Raiserror('Opération annulée. Une ou plusieurs commandes ont des articles enregistrés',15,120)
    Rollback
    End

    ```

## Exercice 4
Le trigger suivant à l'ajout d'une ligne de commande vérifie si les quantités sont disponibles et met le stock à jour

??? question "Correction"

    ```sql
    Create Trigger Tr_Ajouter_Ligne
    On LigneCommande
    For Insert
    As
    Declare @a int
    set @a=(select count(numart) from inserted, article
    where article.numart = inserted.numart
    and QteCommandee >QteEnStock)
    if (@a >0)
    Begin
    Raiserror('Ajout refusé. Quantités demandées non disponibles en stock',15,120)
    Rollback
    End
    Else
    Update article set QteEnStock = QteEnStock –
    (select Sum(QteCommandee) from inserted where
    article.NumArt=inserted.NumArt)
    From article, inserted where inserted.numart=article.numart

    ```

## Exercice 5
Le trigger suivant à la modification d'une ligne de commande vérifie si les quantités sont disponibles et met le stock à jour

??? question "Correction"

    ```sql
    Create Trigger Tr_Modifier_Ligne
    On LigneCommande
    For Update
    As
    Declare @a int
    set @a=(select count(numart) from inserted, deleted, article
    where article.numart = inserted.numart
    and article.numart = deleted.numart
    and inserted.QteCommandee > QteEnStock+deleted.QteCommandee)
    if (@a >0)
    Begin
    Raiserror('Modification refusée. Quantités demandées non disponibles en stock',15,120)
    Rollback
    End
    Else
    update article set QteEnStock = QteEnStock
    + (select Sum(QteCommandee) from deleted where deleted.NumArt=Article.NumArt)
    –  (select Sum(QteCommandee) from inserted where
    inserted.NumArt=Article.NumArt)
    From article, inserted, deleted
    where inserted.numart = article.numart
    and article.numart = deleted.numart

    ```
    *Remarque :* Si le trigger déclenché effectue une opération sur une autre table, les triggers associés à cette
    table sont alors déclenchés (principe de cascade)
