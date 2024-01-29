# Exercices MPD

## 1 Gestion d’une bibliothèque

> Trouver le modèle relationnel correspondant

![a calculer](./data/MPD_bibli.png)

??? tip "Correction"
    **NATIONALITE** ( ^^codeNat^^, LibelleNat)<br />
    **AUTEUR** ( ^^numAuteur^^, nomAuteur, prenomAuteur, dateNaiss, dateDeces, #CodeNat )<br />
    **EDITEUR** ( ^^NumEditeur^^, nomEditeur, prenomEditeur )<br />
    **ABONNE** ( ^^NumAbonne^^, NomAbonne, PrenomAbonne)<br />
    **GENRE** ( ^^CodeGenre^^, LibelleGenre )<br />
    **LIVRE** ( ^^NumLivre^^, TitreLivre, AnneeLivre, Nombre_exemplaires, #CodeGenre)<br />
    **EMPRUNT** ( ^^NumEmprunt^^, DateEmprunt, Date_retour_prevue, #NumAbonne )<br />
    **CORRESPONDRE** ( ^^#NumLivre, #NumEmprunt^^ )<br />
    **AECRIT** (^^#NumLivre, #NumAuteur^^)<br />
    **PROPOSER** ( ^^#NumLivre, #NumEditeur^^, Prix_vente )<br />

## 2 Gestion de fournitures

> Retrouvez le diagramme de classe correspondant

![a calculer](./data/MPD_fournitures.png)

??? tip "Correction"
    ![correction](./data/MPD_fournitures_corr.png)

## 3 Commande

> Complétez le modèle physique en fonction du diagramme de classe et le diagramme de classe en fonction du modèle physique.

**COULEUR** ( ^^CodeCouleur^^, LibelléCouleur )<br />
**FOURNISSEUR** ( ^^CodeFournisseur^^, NomFournisseur, TéléphoneFournisseur )<br />
**EXISTER** ( ^^#CodeCouleur, #CodeProduit^^) <br />
...

![competer](./data/MPD_com.png)

??? tip "Correction"
    ![MPD](./data/MPD_com_corr.png)

    **COULEUR** ( ^^CodeCouleur^^, LibelléCouleur )<br />
    **FOURNISSEUR** ( ^^CodeFournisseur^^, NomFournisseur, TéléphoneFournisseur )<br />
    **EXISTER** ( ^^#CodeCouleur, #CodeProduit^^) <br />
    **PRODUIT** ( ^^CodeProduit^^, Désignation, #CodeCatégorie  ) <br />
    **CATEGORIE** ( ^^CodeCatégorie^^, LibelléCatégorie ) <br />
    **PROPOSER** ( ^^CodeProduit , #CodeFournisseur^^, Prix )


## 4 Course

> A partir du modèle relationnel qui vous est fourni, retrouvez le diagramme de classe.

**VEHICULE** ( ^^N°Véhicule^^, Marque, Modèle, #TypeVéhicule )<br />
**PILOTE** ( ^^N°Pilote^^, NomPilote, #N°Véhicule )<br />
**TYPE_VEHICULE** ( ^^TypeVéhicule^^, Désignation, #CatégorieCourse  )<br />
**CATEGORIE_COURSE** ( ^^CatégorieCourse^^, Libellé )<br />

??? tip "Correction"
    ![correction](./data/MPD_course.png)