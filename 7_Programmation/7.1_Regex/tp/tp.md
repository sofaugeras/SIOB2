# TP REGEX

!!! note "Trace écrite"

    Vous veillerez à garder une trace de votre TP pour compléter votre portefeuille de compétence.

    Vous devez décrire la démarche utilisée pour trouver la bonne expression, les tests et les choix que vous avez faits.

    Compétence : <br />
    > B2 : Rédaction des documentations technique et d’utilisation d’une solution applicative<br />
    > B3 Compétence 3.1 : Protéger les données à caractère personnel<br />
        > Activité : Sensibiliser les utilisateurs à la protection des données à caractère personnel<br />
    > B3 Compétence 3.3 : Sécuriser les équipements et les usages des utilisateurs<br />
        > Activité : Informer les utilisateurs sur les risques associés à l’utilisation d’une ressource numérique et promouvoir les bons usages à adopter  

🔧 Outil en ligne [https://www.debuggex.com/](https://www.debuggex.com/){:target="_blank"} ou un autre de votre choix.

![mème](./data/regular-expressions-meme.webp){: width=50% .center}

## 1. Exercices

### 1.1  Valider une adresse MAC

Voici les éléments pour déterminer une adresse MAC valide :

-	deux caractères compris entre ``0`` et ``F`` (0 à 9 et A à F)
-	un séparateur ``:``
-	5 fois le motif précédent
-	deux caractères compris entre ``0`` et ``F`` (0 à 9 et A à F)

Vous utiliserez les éléments ``[ ]`` et ``{ }``  et ``\.`` pour échapper le caractère spécial ``'.'``.
Vous pouvez également optimiser le travail avec les parenthèses, comme suit ``(expr1){3}[expr2]``

Liste de test des adresses MAC
```shell
AA:BB:CC:DD:EE:FF
AAA:BB:CC:DD:EE:FF
AA:BB:CC:DD:EE:FFF
AA:BB:CCD:DD:EE:FF
AA:GG:CC:DD:EE:FF
AA:aa:CC:DD:EE:FF
12:23:34:45:56:67
AA;BB:CC:DD:EE:FF
:AA:BB:CC:DD:EE:FF
```

Pour les plus malins, essayez de permettre également le format ``AA-BB-CC-DD-EE-FF`` (tirets à la place des double-points) dans la même expression.<br />
Ne cherchez pas à résoudre ``AA:BB:CC-DD-EE:FF`` car l'expression deviendrait trop complexe.

??? question "proposition"
    ``\b([0-9A-F]{2}:){5}[0-9A-F]{2}\b``
 
### 1.2  Valider une adresse IP

En utilisant les éléments ci-dessous, créez une expression régulière simple (on ne tiendra pas compte de la valeur réel des nombres, par exemple 555 sera valide) qui valide une adresse IP :

-	chaque nombre est constitué
    -	de chiffre entre 0 et 9
    -	de un à trois chiffres ensemble
-	d'un point pour les 3 premiers nombres
-	un total de 4 nombres

Liste de test des adresses IP :
```shell
192.168.168.4
25.25.25.25.25
...25
25..25.25.25
1000.168.168.25
99.99.99.99
9.-1.25.4
A.25.24.23
```
Encore une fois, ne cherchez pas la complexité.<br />
L'objectif reste la compréhension globale des expressions régulières : une solution permettant d'éviter de trop nombreux tests mais qui doit rester simple.
 
![Keep It Simple, Stupid](./data/Kiss_-_Keep_it_simple_stupid.jpg){: width=30% .center}

??? question "proposition"
    ``^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$``
    
    Explication :

    ``^`` et ``$`` :
        Le caractère ``^`` indique le début de la chaîne.
        Le caractère ``$`` indique la fin de la chaîne. Ces deux éléments garantissent que l'expression couvre l'intégralité de l'entrée.

    ``\d{1,3}`` :
        ``\d`` correspond à un chiffre (0 à 9).
        ``{1,3}`` indique qu'il doit y avoir entre 1 et 3 chiffres consécutifs.

    ``\.`` :
        Le caractère ``\.`` correspond à un point littéral. Les trois premiers nombres doivent être séparés par des points.

    Structure complète :
        L'expression recherche exactement 4 groupes de chiffres (1 à 3 chiffres chacun), séparés par des points pour les trois premiers groupes.


### 1.2 Valider un nom de fichier

Un professeur anonyme souhaite vérifier que ses étudiants utilisent le bon nom de fichier, sinon il enlève 2 points à la note du TP.

Pour cela, il donne comme consigne le format de fichier avec ``"monNOM"`` en italique pour indiquer aux étudiants qu'ils doivent remplacer ``monNOM`` par leur propre nom de famille, en majuscules.

Donnez l'expression régulière permettant de valider un nom de fichier correct : ==B1-TP_REGEX_monNOM.pdf==

Liste de test des adresses IP :
```text
B1-TP_REGEX_monNOM.pdf
B1-TP_REGEX_NOM.docx
B1-TP_REGEX_NOM.pdf
monNOM.pdf
monNOM_B1-TP_REGEX.pdf
B1-TP_REGEX_ARNAUD-DUPONT.pdf
B1-TP_REGEX_ARNAUD DUPONT.pdf
B1-TP_REGEX_.pdf
```

??? question "proposition"
    ``\bSI6-TP_REGEX_[A-Z\- ]{2,}.pdf``

## 2. Création et validation d'un mot de passe sécurisé

**Objectif :**  
Créer un formulaire en HTML pour la saisie d'un mot de passe et utiliser JavaScript avec des expressions régulières pour vérifier la solidité du mot de passe.


### 2.1 Création du formulaire HTML : 
   Le formulaire doit contenir :

   - Un champ pour la saisie du mot de passe.
   - Un bouton pour valider.
   - Une zone où afficher un message indiquant si le mot de passe est solide ou non.

### 2.1 Critères de solidité du mot de passe :

   - Contient au moins 8 caractères.
   - Contient au moins une lettre majuscule.
   - Contient au moins une lettre minuscule.
   - Contient au moins un chiffre.
   - Contient au moins un caractère spécial parmi `!@#$%^&*()`.

⚓️ [Recommandations de la CNIL sur les mots de passe](https://www.cnil.fr/fr/mots-de-passe-une-nouvelle-recommandation-pour-maitriser-sa-securite)

### 2.3 Validation avec JavaScript :
   - Utiliser des expressions régulières pour vérifier chaque critère.
   - Afficher un message dans la zone prévue si le mot de passe est :
     - **Faible** : Moins de 8 caractères ou ne respecte pas les critères.
     - **Fort** : Si tous les critères sont respectés.

??? question "Proposition"

    ```html
    <!DOCTYPE html>
    <html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Validation du mot de passe</title>
    </head>
    <body>
        <h1>Validation de la solidité du mot de passe</h1>
        <form id="password-form">
            <label for="password">Mot de passe :</label>
            <input type="password" id="password" name="password" required>
            <button type="button" id="validate-btn">Valider</button>
        </form>
        <p id="message"></p>

        <script src="script.js"></script>
    </body>
    </html>
    ```

    ```javascript
    document.getElementById('validate-btn').addEventListener('click', function () {
        const password = document.getElementById('password').value;
        const message = document.getElementById('message');

        // Critères de validation
        const minLength = /.{8,}/; // Au moins 8 caractères
        const uppercase = /[A-Z]/; // Au moins une lettre majuscule
        const lowercase = /[a-z]/; // Au moins une lettre minuscule
        const digit = /\d/;        // Au moins un chiffre
        const specialChar = /[!@#$%^&*()]/; // Au moins un caractère spécial

        // Vérification des critères
        if (
            minLength.test(password) &&
            uppercase.test(password) &&
            lowercase.test(password) &&
            digit.test(password) &&
            specialChar.test(password)
        ) {
            message.textContent = "Mot de passe solide !";
            message.style.color = "green";
        } else {
            message.textContent = "Mot de passe faible : il doit contenir au moins 8 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial.";
            message.style.color = "red";
        }
    });
    ```


![mème](./data/1_uiQuhdsvifghFD-a-G-BeA.jpg){: width=50% .center}



