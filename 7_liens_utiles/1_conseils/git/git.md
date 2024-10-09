# github

!!! note "source"
    Propulsé par chatGPT

Voici les étapes pour sauvegarder le répertoire ``MesCours`` sur GitHub :
## Prérequis

- Avoir un compte [GitHub](https://docs.github.com/fr/education/explore-the-benefits-of-teaching-and-learning-with-github-education/github-education-for-students/apply-to-github-education-as-a-student).
- Installer Git sur votre PC. Si ce n'est pas encore fait, téléchargez et installez ==Git== depuis [git-scm.com](git-scm.com).

## Étapes

### 1. Créer un dépôt sur GitHub :

- Connectez-vous à GitHub.
- Cliquez sur le bouton New dans la section des dépôts (repositories).
- Donnez un nom à votre dépôt (par exemple ``MesCours``).
- Vous pouvez choisir de le rendre public ou privé.
- Ne cochez pas l'option d'ajouter un README.md (sinon, il y aura un conflit avec le répertoire local).
- Cliquez sur Create repository.

### 2. Initialiser Git dans le répertoire MesCours sur votre PC :

- Ouvrez l'explorateur de fichier sur votre répertoire à sauvegarder, puis tapez cmd dans la barre d'adresse.
> windows ouvre un terminal positionné directement sur le bon prompt.
- Initialisez Git dans ce répertoire :
```prompt
git init
```
- Ajouter le dépôt GitHub en tant que remote (distant) :
```prompt
    git remote add origin https://github.com/votre-utilisateur/MesCours.git
```
- Ajouter les fichiers et effectuer le premier commit :
```prompt
git add .
```
- Effectuez le commit initial :
```prompt
    git commit -m "Premier commit"
```
- Pousser les modifications vers GitHub :
```prompt
        git push -u origin master
```
## Vérification

Allez sur votre dépôt GitHub, vous devriez voir les fichiers du répertoire ``MesCours``.

!!! note "Desktop"
    Il existe un logiciel [github desktop](https://desktop.github.com/download/) pour ceux qui ne sont pas à l'aise en ligne de commande