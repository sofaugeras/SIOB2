# Exercices 

## 1. La bibliothèque

source : UML2 de l'apprentissage à la pratique, L. Audibert

L'objectif de cet exercice est de produire un diagramme de cas d'utilisation modélisant les besoins du système d'information d'une bibliothèque. Actuellement, la bibliothèqye est question n'en possède pas et ne travaille qu'avec des notices et des fiches papier. Vous agissez en tant que prestataire pour une société de conception de logiciel de bibliothèque. Vous allez à la rencontre du client (la bibliothécaire). L'entretien est retranscris ci dessous.

:woman: Bonjour monsieur, je vous attendais. J'ai fait appel à vous pour informatiser notre bibliothèque. En effet, nous commençons à avoir un certain nombrede livres et d'adhérents, et il devient difficile pour nous de suivre les prêts et difficile pour les adhérents de rechercher des livres.

:bust_in_silhouette: _Bonjour madame. Pourriez vous me décrire la façon dont vous fonctionnez actuellement ?_

:woman: Nous fonctionnons avec des notices papier. Une notice est affectée à chaque livre et insérée contre la couverture à l'intérieur du livre. Quand une personne emprunte un livre, elle donne la notice du livre à un assistant qui la range dans le fichier des emprunts. Nous avons aussi une fiche par adhérent. Il faut donc noter sur la fiche de l'adhérent les livres qu'il emprunte et la date de retour lorsqu'il les rend.

:bust_in_silhouette: _Qu'y a t'il d'écrit sur une notice ?_

:woman: Le titre du livre, l'auteur et l'éditeur par exemple. Mais ca depend un peu des notices. Quand une personne emprunte un livre, on écrit aussi son nom, son prénom, et la date du prêt.

:bust_in_silhouette: _Pourquoi dites-vous : "Ca dépend des notices" ?_

:woman: Parce qu'il y a plusieurs type de notice en fonction des documents. Nous avons des romans, des bandes dessinées, des livres sur la culture, comme l'histoire de l'art ...

:bust_in_silhouette: _Pouvez vous me montrer quelques notices ?_

![notices](./data/notice.png){ .center width=60%}

:bust_in_silhouette: _Quels sont exactement les différents types de documents que vous possédez ?

:woman: Des romans, des bandes dessinées, des ouvrages d'art et l'histoire, des guides de voyage et des revues qui ne peuvent pas être empruntées.

:bust_in_silhouette: _Le système doit-il aussi les revues ?_

:woman: oui, pour connaître notre fond, et pour permettre de faire des recherches.

:bust_in_silhouette: _Qu'attendez vous du système ?_

:woman: Qu'il permette de mémoriser et de gérer toutes nos notices papier. Qu'il permette d'effectuer des recherches sur notre fond. Qu'il permette de gérer les emprunts.

:bust_in_silhouette: _Tout le monde peut il emprunter des ouvrages ?_

:woman: Oui, à condition d'être abonné à la bibliothèque

:bust_in_silhouette: _Donc le système doit aussi gérer les abonnés ?_

:woman: Euh ...oui

:bust_in_silhouette: _Un adhérent a-t-il accès au système ?_

:woman: Oui, il doit pouvoir effectuer des recherches pour savoir si un ouvrage existe dans la bibliothèque et s'il est disponible. Même un simple visiteur doit pouvoir le faire.

:bust_in_silhouette: _Toutes les autres interactions avec les système sont réalisés uniquement par le bibliothécaire ?_

:woman: Oui ... et un assistant. Un assistant doit pouvoir gérer les emprunts et les retours. Il doit aussi pouvoir effectuer des recherches et savoir, le cas échéant, qui a emprunté un ouvrage en cours de prêt. Moi, je dois pouvoir, en plus modifier le fond documentaire. J'aimerais aussi pouvoir afficher la liste des ouvrages qui auraient dû être rendus et ne le sont pas encore, et qui les a empruntés.

:bust_in_silhouette: _Quelle est la durée maximale d'un prêt ?_

:woman: Ca dépend, un mois pour les romans et les autres livres. trois semaines pour un guide de voyage et deux pour une bande dessinée.

:bust_in_silhouette: _Combien un adhérent peut-il emprunter d'ouvrages ?_

:woman: Au maximun trois romans, deux guides de voyage et cinq bandes dessinées. Mais pas plus de 5 ouvrages en tout.

:bust_in_silhouette: _Bon, voyez vous des choses à rajouter_

:woman: Oui, j'aimerais bien qu'un assistant ou moi-même puissions spécifier sur une notice l'état d'un ouvrage. Par exemple avec trois niveaux : bon, moyen, abîmé. Ceci m'aiderait beaucoup pour le remplacement des exemplaires.

:point_right: Penser à utiliser vos connaissances sur le monde de l'édition et sur vos fréquentations des bibliothèques pour trouver les informations qui ne figurent pas dans cet entretien. Elles sont nombreuses !

1. identifier et spécifier les besoins en réalisant un diagramme de cas d'utilisation
2. Donner une description détaillé du cas d'utilisation **gérer un emprunt**

??? tip "Correction"
    ![use case](./data/DC_bibli.png){ .center width=60%}
    ![use case détaillée](./data/DC_bibli_detaillee.png){ .center width=80%}
    ![Diagramme de classe](./data/DC_bibli_classe.png){ .center width=75%}

## 2. La caisse enregistreuse 

source : UML2 de l'apprentissage à la pratique, L. Audibert

L'objectif de cet exercice est de produire un diagramme de cas d'utilisation modélisant les besoins du système informatique emabrqué dans une caisse enregistreuse de supermarché. Le déroulement normal d'utilisation d'une caisse enregistreuse est le suivant :

- Le client se présente à la caisse avec les articles qu'il veut acheter

- Le caissier identifie chaque article à l'aide de son code barre et saisit la quantité si celle-ci est supérieure à un.

- La caisse affiche le prix et la désignation de chaque article pour que le client puissent surveiller le déroulement des opérations.

- Lorsque tous les articles ont été enregistrés, le caissier signale la fin de la vente à la caisse.

- La caisse affiche le montant total des achats.

- Le client peut présenter des coupons de réductions avant le paiement.

- Le client a le choix entre les trois modes de paiement qui suivent

>   1. _en liquide_ : Le caissier enregiste l'argent et la caisse indique le montant éventuel à rendre au client.
>   2. _Par chèque_ : Le caissier vérifie l'identité du client ainsi que sa solvabilité en transmettant une requête au centre d'autorisation via la caisse.
>   3. _Par carte de crédit_ : Le terminal bancaire intégré à la caisse transmet la demande à un centre d'autorisation multi-banques.

- La caisse mémorise la vente et imprime le ticket.

- La caissier transmet le ticket imprimé au client.

- La caisse transmet les informations relatives aux articles vendus au sytème de gestion des stocks.

Le supermarché possède également des superviseurs qui peuvent effectuer des opérations particulières avec les caisses enregistreuses, comme son initialisation, ou un forçage de prix pour un article dont le prix (ou la réduction) affiché en magasin ne correspond pas à celui mémorisé dans le système informatique.

1. Proposer un diagramme de cas d'utilisation minimaliste contenant deux cas, _traiter le passage en caisse_ et _effectuer une opération particulière_, ainsi que le ou les acteurs principaux.

2. Ajouter les acteurs secondaires.

3. La prolifération des acteurs secondaires sur le cas _traiter le passage en caisse_ indique que le cas comporte probablement trop de responsabilités. Proposer une décomposition du cas.

4. En utilisant un point d'extension, faites figurer la prise en compte des coupons de réductions.

??? tip "Correction"
    