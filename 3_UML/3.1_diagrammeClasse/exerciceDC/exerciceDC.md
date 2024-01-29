# Exercices DC

## Exercice 1 - Bibliothèque

Nous souhaitons gérer une bibliothèque simple. Nous recenserons une liste d'ouvrages, avec pour chacun le titre et l'auteur (éventuellement plusieurs). <br />
On tiendra compte du fait que des ouvrages peuvent exister en plusieurs exemplaires, certains pouvant ne pas être disponibles pour le prêt (consultables uniquement sur place, ou détruits). <br />
Une liste d'adhérents devra être tenue à jour, les adhésions devant se renouveler une fois par an. Il devra être possible de vérifier qu'une adhésion est à jour (c'est-à-dire qu'elle a été renouvelée il y a moins d'un an), mais il ne sera pas nécessaire de connaître l'historique des renouvellements.<br />
Les adhérents peuvent emprunter jusqu'à 5 livres simultanément et chaque livre emprunté doit être retourné dans les deux semaines. On devra conserver un historique permettant de savoir quel abonné a emprunté quels livres, les dates d'emprunts et de retours.

??? tip "correction"

    ![proposition de solution](./data/bibliotheque.png)

## Exercice 2 - Comptes en banque

Nous souhaitons gérer des comptes en banque. <br />
Une liste de comptes, avec numéro et libellé doit être tenue à jour. On souhaitera connaître pour chacun d'eux l'identité du propriétaire du compte (sachant qu'un compte peut dans certains cas appartenir à plusieurs personnes). Pour chaque compte, on conservera l'historique des modifications (virement, retrait, dépôt). On considérera comme un virement tout opération impliquant deux comptes et comme des retraits (ou dépôts) toute opération n'impliquant qu'un seul compte.

??? tip "correction"

    ![proposition de solution](./data/compteEnBanque.png)

## Exercice 3 - Inscriptions sportives

Une ligue sportive souhaite informatiser les inscriptions à des compétitions. <br />
Chaque compétition porte un nom et une date de clôture des inscriptions. Selon les compétitions, les candidats peuvent se présenter seul ou en équipe, sachant que le détail des équipes (liste des candidats et entraîneur) devra aussi être géré.

??? tip "correction"

    ![proposition de solution](./data/InscriptionSportive.png)

## Exercice 4 - CMS

Nous souhaitons gérer un CMS (content management system). <br />
Un CMS est un logiciel permettant de gérer le contenu d'un ou plusieurs sites web. Chaque site porte un nom, est caractérisé par une URL, et est découpé en catégories, imbricables les unes dans les autres. Des utilisateurs sont répertoriés dans le CMS, et chacun peut avoir le droit (ou non) d'écrire dans un site web. <br />
Chaque utilisateur doit avoir la possibilité de publier des articles (ou des brèves) dans une catégorie d'un site web (pourvu qu'il dispose de droits suffisants dessus). Une brève est composée d'un titre et d'un contenu textuel. Un article, en plus de son titre et de son texte d'introduction, est constitué de chapitres portant chacun un nom et contenant un texte. Il va de soi qu'on doit avoir la possibilité pour chaque site de conserver l'historique de quel article (ou brève) a été publié par quel utilisateur. <br />
Réalisez un diagramme de classes modélisant cette situation.

??? tip "correction"

    ![proposition de solution](./data/CMS.png)

## Exercice 5 : Gestion des résultats au parcours du combattant

Une caserne militaire désire gérer les résultats des soldats lors du passage des obstacles du parcours du combattant. Dans sa carrière, un soldat va passer plusieurs fois le parcours du combattant. <br />
A chaque fois qu’un soldat passe un obstacle, un instructeur lui attribue une note (note instructeur). Si le parcours comporte 20 obstacles, l’élève recevra donc 20 notes (si l’élève ne passe pas l’obstacle, la note 0 lui est attribuée). <br />
A chaque obstacle est attribué un niveau de difficulté. (facile , moyen, difficile …). <br />
Un bonus de points est ensuite attribué à chaque niveau (ex : bonus de 2 points pour les obstacles difficiles). <br />
La note finale pour le passage d’un obstacle est donc égale à : note attribuée par l’instructeur + bonus relatif à la difficulté de l’obstacle. <br />

Enfin, une note minimale à obtenir est définie pour chaque obstacle. Elle définit un niveau minimum à atteindre qui permet de dire à un soldat sur quels obstacles il doit axer en priorité son entraînement. <br />

Exemple : soit l’obstacle « Fosse » de niveau « difficile » (le bonus attribué pour ce niveau est de 2 points). La note minimale à atteindre pour cet obstacle est de 10. <br />
Si un élève est noté 6 sur cet obstacle par l’instructeur, sa note finale sera égale à $6 + 2 = 8$. On juge donc que son niveau sur cet obstacle est insuffisant et qu’il lui faut parfaire son entraînement. <br />
Les responsables de la caserne souhaitent obtenir la liste de tous les obstacles ainsi que leur niveau de difficulté. <br />
Ils souhaitent également obtenir la liste de toutes les notes attribuées sur chacun des obstacles. <br />
Enfin, ils désirent avoir le récapitulatif des notes obtenues par un soldat donné pour retracer sa progression, ainsi que le temps total qu’il a mis pour effectuer un parcours complet (ainsi que les temps intermédiaires). 

??? tip "correction"

    ![proposition de solution](./data/combattant.png)

    **SOLDAT**(^^matricule^^, nom, prenom)<br />
    **PASSAGE**(^^NumPassage^^, dateParticipation, #matricule)<br />
    **PASSE**(^^#NumPassage , #nomObstacle^^, noteInstructeur, Temps)<br />
    **OBSTACLE**(^^nomObstacle^^, noteMini, #codeDifficulte)<br />
    **DIFFCICULTE**(^^codeDifficulte^^, libelleDifficulte, bonus)

## Exercice 6 : GESTION DES LOGEMENTS DANS UNE AGENCE IMMOBILIERE

Une agence de location de maisons et d’appartements désire gérer sa liste de logements. Elle voudrait en effet connaître l’implantation de chaque logement (nom de la commune et du quartier) ainsi que les personnes qui les occupent (les signataires uniquement). 
Le loyer dépend d’un logement, mais en fonction de son type (maison, studio, T1, T2...) l’agence facturera toujours en plus du loyer la même somme forfaitaire à ses clients. Par exemple, le prix d’un studio sera toujours égal au prix du loyer + 30 € de charges forfaitaires par mois. Pour chaque logement, on veut disposer également de l’adresse, de la superficie ainsi que du loyer. 
Quant aux individus qui occupent les logements (les signataires du contrat uniquement), on se contentera de leurs noms, prénoms, date de naissance et numéro de téléphone. Pour chaque commune, on désire connaître le nombre d’habitants ainsi que la distance séparant la commune de l’agence. 

NB : on ne gérera pas l’historique de l’occupation des logements par les individus. On considèrera de plus qu’un individu ne peut être signataire que d’un seul contrat. 

Etablir :

1. Le dictionnaire des données et énoncer les règles de gestion établis
2. Le modèle conceptuel des données
3. Le modèle logique associé 

??? tip "correction"

## Exercice 7 : GESTION DES COURSES HIPPIQUES

On désire gérer les participations des divers chevaux et jockeys aux courses hippiques : connaître les participants d’une course et leur classement. Une course se déroule toujours sur le même champ de course et appartient toujours à la même catégorie (exemple de catégorie : trot attelé, trot monté, obstacle …). 
On désire connaître les catégories de course qu’un champ de course peut accueillir. 
On désire de plus gérer les informations suivantes : 

- la désignation de la course (ex : prix d’Amérique) 
- le nom du champ de course 
- le nombre de places dans les tribunes 
- la date de la course (cette date est variable) 
- la dotation de la course en euros (cette dotation est variable) 
- le nom des chevaux 
- le nom et le prénom du propriétaire (on supposera qu’il n’y en a qu’un et on ne gérera pas l’historique) 
- le sexe du cheval 
- le nom et prénom des jockeys 
- la date de naissance de chaque cheval.
- le numéro de dossard du jockey et du cheval pour la course 

NB : on désire de plus gérer les liens de parenté directs entre les chevaux. 

Une même course peut avoir lieu plusieurs fois dans la même saison sur le même champ de course et les dotations ne sont pas toujours les mêmes. 
Ex : le trot monté d’Auteuil se déroule au mois de mars avec une dotation de 5 millions, au mois de juillet avec une dotation de 3 millions et au mois de décembre avec une dotation de 4 millions. 

1. Le dictionnaire des données et énoncer les règles de gestion établis
2. Le modèle conceptuel des données
3. Le modèle logique associé 

??? tip "correction"