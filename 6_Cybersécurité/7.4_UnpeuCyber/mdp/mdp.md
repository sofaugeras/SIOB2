# Autour d'un mot de passe

??? note "Source"
    - Contenu extrait du MOOC [SecNumAcadémie](https://secnumacademie.gouv.fr/) de l’[ANSSI](https://cyber.gouv.fr/)
    - [CNIL](https://www.cnil.fr/)
    - Activité CNIL : Hélène Passelande


!!! info "Liaison avec le BO"
    en classe de première : <br/>
    - Type simple : parcours de chaîne de caractère<br/>
    - Notion de force brute<br/>
    - Dictionnaires par clés et valeurs<br/>

## A quoi sert un mot de passe ?

• **Accès** à des services en ligne grâce au contrôle d’accès.<br/>
• **Imputabilité**, preuve de qui a fait quoi.<br/>
• **Traçabilité** des actions, historique des actions.<br/>
Exemple, <br/>
télédéclaration de l’impôt : imputabilité = lien entre la déclaration et la personne *ET* traçabilité = connaître l’heure et la date de la déclaration.

## un mot de passe, c'est 

• La connaissance.<br/>
• La possession.<br/>
• Les caractéristiques biométriques.<br/>

![source : https://www.apog.net/deploiement-solution-mfa-indispensable](./data/Facteurs.jpg)

## Les risques 

Risques du mot de passe :<br/>
• **Divulgation :**<br/>
    o Par négligence : faiblesse d’une personne, support amovible, diffusion à un tiers.<br/>
    o Par un service non sécurisé : protocoles https, imaps, pop3s, etc… à privilégier.<br/>
    o Par l’utilisation d’un vecteur infecté.<br/>
    o Mot de passe enregistré sans protection.<br/>
• **Malveillance :**<br/>
    o Authentification sur un service illégitime.<br/>
    o Attaque par ingénierie sociale, piège.<br/>
    o Attaque par force brute ou divulgation d’une base de données mal sécurisée.<br/>
• Ces deux cas de figure peuvent entraîner :<br/>
    o La compromission des messages personnels.<br/>
    o La destruction de données.<br/>
    o La publication de messages ou photos préjudiciables sur les réseaux sociaux par exemple.<br/>
    o Des achats.<br/>
    o Des virements bancaires.<br/>

## Craquer un mot de passe

• Par force brute.<br/>
• Par dictionnaire, en général avant l’attaque par force brute.<br/>
• Par permutation en échangeant des caractères (exemple : E par 3 ou O par 0).<br/>

## Mais un souci de temps

une image plutôt qu'un long discours :

![temps de craquage par force brute d'un mdp](./data/etude-hive-systems-mots-de-passe.jpg)

## Comment construire un mot de passe fort ?

Il apporte un niveau de sécurité suffisant, c’est-à-dire difficile à découvrir par un attaquant dans un temps raisonnable à  l’aide d’outils automatisés de recherche qui mettent en oeuvre les différentes techniques d’attaque. Il doit être composé au minimum de *10 caractères* et ceux-ci doivent être de tout type.

Quelques astuces : 
- Grâce à une [phrase de passe](https://www.cnil.fr/fr/generer-un-mot-de-passe-solide) avec des mots concaténés.
- Par phonétique.
- Les premières lettres des mots d’une phrase, citation, chanson, etc…
- Mixer les trois méthodes.

!!! note "Activité"

    🔽 Télécharger le notebook Activité correspondant [ici](./phrase_de_passe-v2.ipynb)<br />
    🔽 Télécharger le notebook Activité corrigé [ici](./phrase_de_passe-v2-Corrige.ipynb)

## Les rainbows Tables

### À quoi sert une Rainbow Table ?

Une Rainbow Table est un fichier volumineux contenant une multitude de mots de passe reliés à leur valeur de hachage. 

![illustration hachage](./data/hachmd5.png)

Les cybercriminels s’en servent pour cracker des mots de passe. Les Rainbow Tables permettent généralement de réduire le temps et la mémoire nécessaires à l’attaque, contrairement aux attaques par force brute qui requièrent beaucoup de temps et aux attaques par dictionnaires qui nécessitent beaucoup de mémoire. 

À noter que les Rainbow Table peuvent également être utilisées par des experts en cybersécurité pour identifier des failles ou effectuer des tests de sécurité. 

### Comment fonctionne une Rainbow Table ? 

Lors de la génération d’une Table arc-en-ciel, chaque mot de passe est haché (le procédé peut être répété plusieurs fois en fonction des cas).  

Seul le mot de passe initial et la valeur finale sont conservés dans la Table. Ce processus est ensuite répété à partir de nouveaux mots de passe, jusqu’à obtenir une Table importante. 

Pour cracker un mot de passe, le cybercriminel va chercher son empreinte dans la Table arc-en-ciel. Une fois trouvée, il peut donc récupérer le mot de passe initial de cette empreinte.

!!! note "Activité"

    🔽 Télécharger le notebook Activité correspondant [ici](./rainbow.ipynb)<br />

## Stockage d'un mot de passe

