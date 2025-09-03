# Secure by Design

> "La cybersécurité est un domaine à part entière, il sera donc nécessaire de continuer d'en faire [note en : en BTS SIO], mais peut-être moins sur les aspects "attaquer" mais sur le **"security by design"**, la qualité du code, la gestion des frameworks... bref, la sécurité en amont plutôt qu'en aval. " David Roumanet, Lycée Louise Michel. Professeur BTS SIO.

!!! info "Définition"
    "Secure by Design" (ou "sécurité par conception" en français) est une approche de développement de systèmes informatiques et de logiciels qui intègre des principes de sécurité dès les premières étapes de la conception et tout au long du cycle de vie du produit. L'objectif est de minimiser les vulnérabilités et les risques de sécurité en adoptant des pratiques et des technologies de sécurité robustes dès le départ, plutôt que d'ajouter des mesures de sécurité après coup.

## Quelques principes : <br />
- Limitation des droits et des accès des utilisateurs et des systèmes à ce qui est strictement nécessaire pour réduire les surfaces d'attaque potentielles.<br />
- Mise en place de processus rigoureux de tests et de validations de la sécurité tout au long du cycle de vie du développement<br />

et plus globalement, **coder propre** :<br />
- Vérification des types dans les paramètres de fonction<br />
- Requêtes préparées uniquement ou utilisation d'un ORM<br />
- Supprimer le code "mort" (exemple getter/setter non utilisé)<br />
- Limiter les fonctions/méthodes à une seule tâche<br />
- Documenter les fonctions, méthodes, classes et modules<br />
- Utiliser des exceptions spécifiques plutôt que des exceptions générales<br />
- Toujours nettoyer les ressources dans un bloc finally dans la gestion des exceptions<br />
- Fermer les ressources au fur et à mesure (fichier par exemple)<br />

Exemple de code dangereux :

```python linenums='1'

def read_file(filename):
    f = open(filename, 'r')
    data = f.read()
    # Fichier jamais fermé explicitement
    return data

# Utilisation de la fonction
content = read_file('example.txt')
print(content)

# Autres opérations
# Le fichier 'example.txt' reste ouvert pendant toute la durée du programme
```

^^Problèmes Potentiels :^^

>**Fuite de Ressources :**Le descripteur de fichier reste ouvert, consommant des ressources système inutiles.<br />
>**Verrouillage de Fichier :** Le fichier peut rester verrouillé, empêchant d'autres processus ou parties du programme de le modifier.<br />
>**Incohérences et Erreurs :** Si le programme tente de lire ou d'écrire à nouveau dans le fichier, des comportements inattendus peuvent survenir.<br />

^^Solution : Utiliser le Bloc with^^<br />

L'utilisation d'un bloc with en Python garantit que le fichier est correctement fermé après son utilisation, même si une exception est levée pendant l'opération de lecture ou d'écriture. Voici comment corriger le code :

```python linenums='1'
def read_file(filename):
    with open(filename, 'r') as f:
        data = f.read()
    # Le fichier est automatiquement fermé à la fin du bloc with
    return data

# Utilisation de la fonction
content = read_file('example.txt')
print(content)

# Autres opérations
# Le fichier 'example.txt' est fermé proprement après la lecture
```