# Exercices

## Exercice 1
Créer une procédure stockée nommée `SP_ListeArticles` qui affiche la liste des articles d'une commande dont le numéro est donné en paramètre 

??? question "Correction"

    ```sql
    Create Procedure SP_ListeArticles @NumCom int as Select A.NumArt, NomArt, PUArt, QteCommandee From Article A, LigneCommande LC
    Where LC.NumArt=A.NumArt and LC.NumCom=@NumCom

    --Exécuter cette procédure pour afficher la liste des articles de la commande numéro 1 :
    Exec SP_ListeArticles 1
    --Ou
    Declare @nc int
    Set @nc=1
    Exec SP_ListeArticles @nc
    ```

## Exercice 2 

Créer une procédure stockée nommée `SP_NbrCommandes` qui retourne le nombre de commandes 

??? question "Correction"

    ```sql
    Create Procedure SP_NbrCommandes @Nbr int output as
    Set @Nbr = (Select count(NumCom) from Commande)

    --Exécuter cette procédures pour afficher le nombre des commandes
    Declare @n int
    Exec SP_NbrCommandes @n Output
    Print 'Le nombre de commandes : ' + convert(varchar,@n)
    ```

## Exercice 3

Créer une procédure stockée nommée `SP_NbrArtCom` qui retourne le nombre d'articles d'une commande dont le numéro est donné en paramètre 

??? question "Correction"

    ```sql
    DELIMITER $
    Create Procedure SP_NbrArtCom2 (IN Num int, OUT Nbr int)
    begin
        Select count(NumArt) INTO Nbr
        from LigneCommande 
        where NumCom=Num ;
    end$
    --Exécuter cette procédure pour afficher le nombre d'articles de la commande numéro 1 :
    Declare @n int
    Exec SP_NbrArtCom 1, @n Output
    Print 'Le nombre d articles de la commande numéro 1 est : ' + convert(varchar,@n) 
    
    -- Ou
    Declare @nc int, @n int
    Set @nc=1
    Exec SP_NbrArtCom @nc, @n Output
    Print 'Le nombre d articles de la commande numéro ' + convert(varchar,@nc) + ' est : ' +
    convert(varchar,@n)
    ```

## Exercice 4
Créer une procédure stockée `SP_NbrArticlesParCommande` qui calcule le nombre d'articles par commande

??? question "Correction"

    ```sql
    Create Procedure SP_NbrArticlesParCommande as
    Select Commande.NumCom, DatCom, Count(NumArt)
    From Commande, LigneCommande
    Where Commande.NumCom=LigneCommande.NumCom
    Group by Commande.NumCom, DatCom

    --Exécuter cette procédure :
    Exec SP_NbrArticlesParCommande
    ```

## Exercice 5

Créer une procédure stockée nommée `SP_ComPeriode` qui affiche la liste des commandes effectuées entre deux dates données en paramètre 

??? question "Correction"

    ```sql
    Create Procedure SP_ComPeriode @DateD DateTime, @DateF DateTime as
    Select * from Commande Where datcom between @dateD and @DateF

    --Exécuter cette procédure pour afficher la liste des commandes effectuées entre le
    --10/10/2006 et le 14/12/2006 :

    Exec SP_ComPeriode '10/10/2006', '14/12/2006'

    --Ou
    Declare @dd DateTime, @df DateTime
    Set @dd='10/10/2006'
    Set @df='14/12/2006'
    Exec SP_ComPeriode @dd, @df
    ```

## Exercice 6

Créer une procédure stockée nommée `SP_TypeComPeriode` qui affiche la liste des commandes effectuées entre deux dates passées en paramètres. En plus si le nombre de ces commandes est supérieur à 100, afficher *Période rouge*. Si le nombre de ces commandes est entre 50 et 100 afficher *Période jaune* sinon afficher *Période blanche* (exploiter la procédure précédente)

??? question "Correction"

    ```sql
    Create Procedure SP_TypeComPeriode @DateD DateTime, @DateF DateTime as
    Exec SP_ComPeriode @DateD, @DateF
    Declare @nbr int
    Set @nbr=(Select count(NumCom) from Commande Where datcom between @dateD and
    @DateF)
    If @nbr >100
    Print 'Période Rouge'
    Else
    Begin
    If @nbr<50
    Print 'Période blanche'
    Else
    Print 'Période Jaune'
    End
    ```

## Exercice 7

Créer une procédure stockée nommée `SP_EnregistrerLigneCom` qui reçoit un numéro de commande, un numéro d'article et la quantité commandée :<br />
- Si l'article n'existe pas ou si la quantité demandée n'est pas disponible afficher un message d'erreur <br />
- Si la commande introduite en paramètre n'existe pas, la créer <br />
- Ajoute ensuite la ligne de commande et met le stock à jour

??? question "Correction"

    ```sql
    Create Procedure SP_EnregistrerLigneCom @numCom int, @numart int, @qte decimal AS
    if not exists(select numart from article where numart=@numart)
    or (select Qteenstock from article where numart=@numart) < @qte
    Begin
    Print 'Cet article n''existe pas ou stock est insuffisant'
    Return
    End
    Begin transaction
    if not exists(select numcom from Commande where numCom=@numcom)
    insert into commande values(@NumCom,getdate())
    insert into ligneCommande values(@NumCom, @Numart,@Qte)
    update article set QteEnStock=QteEnStock- @Qte where NumArt=@NumArt
    Commit Transaction
    ```
