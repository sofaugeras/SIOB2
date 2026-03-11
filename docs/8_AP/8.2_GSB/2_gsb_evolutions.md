# 2. GSB Evolution

!!! info "Compétences Exploitation de services"
    Répondre aux incidents et aux demandes d’assistance et d’évolution : Traiter des demandes concernant les applications.

    Critères d'évaluation : <br />

    - La méthode de diagnostic de résolution d’un incident est adéquate et efficiente.
    - Une solution à l’incident est trouvée et mise en œuvre.
    - Le cycle de résolution des demandes respecte les normes et standards du prestataire informatique.
    - Le compte rendu d’intervention est clair et explicite.

## 1. User story 1 : import CSV praticiens

**En tant que** administrateur de l’application GSB<br />
**Je souhaite** importer une liste de praticiens à partir d’un fichier CSV<br />
**Afin de** mettre à jour rapidement la base de données des praticiens sans saisie manuelle<br />

**Description**

Actuellement, les praticiens doivent être ajoutés individuellement dans la base de données. Afin de faciliter la gestion et la mise à jour du référentiel des praticiens, l’application doit proposer une fonctionnalité permettant d’importer un fichier CSV contenant plusieurs praticiens.

Le système devra :

- permettre le téléversement d’un fichier CSV
- analyser le contenu du fichier
- vérifier la cohérence des données
- insérer les nouveaux praticiens dans la base
- signaler les doublons éventuels

```
PRA_NUM;PRA_NOM;PRA_PRENOM;PRA_ADRESSE;PRA_CP;PRA_VILLE;PRA_COEFNOTORIETE;TYP_CODE
2010;Martin;Claire;14 rue des Acacias;44000;Nantes;312.45;MV
2011;Benali;Nadia;7 boulevard Voltaire;59000;Lille;288.30;MH
```
[Télécharger fichier exemple](./data/nouveaux_praticiens_30.csv){ .md-button .md-button--primary }

**Validation des données**

Pour chaque ligne du fichier :

- les champs obligatoires doivent être présents
- le type de praticien doit exister dans la table type_praticien
- le code postal doit être valide
- le coefficient de notoriété doit être numérique

Si un praticien existe déjà, le praticien n'est pas importé et le nom est enregistré dans un fichier de log de traitement.<br  />
À la fin du traitement, le système affiche le nombre de praticiens importés, le nombre de lignes rejetées, le nombre de doublons détectés.

Cas de tests à effectuer pour la validation des données :

| Test                         | Résultat attendu            |
| ---------------------------- | --------------------------- |
| Import d’un fichier valide   | les praticiens sont ajoutés |
| Import avec doublons         | doublons signalés           |
| Import avec fichier invalide | message d’erreur            |
| Import d’un fichier vide     | aucun praticien ajouté      |

