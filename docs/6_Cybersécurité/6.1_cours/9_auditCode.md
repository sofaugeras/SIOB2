# 9. Audit de code et analyse de qualité logicielle 👮‍♀️

![en construction](../../images/enConstruction.png){: .center width=50%}

!!! info "Compétences Cyber SLAM"

    **Activité B3.5**. Cybersécurisation d’une solution applicative et de son développement
    
    !!! warning "Compétences visées"

        - Analyser et corriger les vulnérabilités détectées à l’issue d’un audit de sécurité d’une application web
        - Participer à la vérification des éléments contribuant à la sûreté d’un développement informatique
        - Prendre en compte la sécurité dans un projet de développement d’une solution applicative
        - Mettre en œuvre et vérifier la conformité d’une solution applicative et de son développement à un référentiel, une - norme ou un standard de sécurité

!!! info "🎯 Objectifs du chapitre"

    - Comprendre ce qu’est un audit de code.
    - Expliquer la différence entre audit manuel et analyse automatisée.
    - Identifier les critères de qualité d’un logiciel.
    - Utiliser des outils courants d’analyse statique et dynamique.
    - Interpréter les résultats d’un outil d’audit.

## 1. Qu’est-ce qu’un audit de code ?

### 📖 Définition

L’**audit de code** est une démarche structurée consistant à examiner un code source afin d’en évaluer :

- la qualité technique,
- la maintenabilité,
- la robustesse,
- la sécurité,
- la conformité aux bonnes pratiques.

Contrairement au débogage, l’audit ne vise pas uniquement à corriger une erreur existante.  
Il cherche à **prévenir les défauts futurs** et à améliorer la qualité globale du projet.

Dans un contexte professionnel, l’audit peut être réalisé :

- avant une mise en production,
- avant une reprise de projet,
- lors d’une revue de sécurité,
- dans le cadre d’un contrôle qualité interne.

### 🧠 Audit manuel vs audit automatisé

L’audit de code repose sur deux approches complémentaires.

#### 🔎 Audit manuel

Il s’agit d’une lecture humaine du code.  
Le développeur ou l’auditeur vérifie :

- la compréhension globale du projet,
- la cohérence architecturale,
- la séparation des responsabilités,
- la clarté des noms de variables et de méthodes,
- la présence de duplication de code,
- la gestion des erreurs.

Cette approche permet de détecter des problèmes que les outils automatiques ne voient pas, notamment les défauts de conception.

#### 🤖 Analyse automatisée

Les outils d’analyse examinent le code sans l’exécuter (analyse statique) ou pendant son exécution (analyse dynamique).

Ils permettent notamment de détecter :

- des erreurs potentielles,
- des incohérences de typage,
- des vulnérabilités connues,
- du code dupliqué,
- des écarts aux standards de codage.

L’analyse automatisée est rapide, reproductible et intégrable dans une chaîne d’intégration continue.

!!! info "📝 Synthèse"

    L’audit manuel apporte une vision architecturale et métier.  <br />
    L’analyse automatisée apporte une vision technique et mesurable.  <br />
    Les deux sont nécessaires pour garantir une qualité logicielle professionnelle.<br />

## 2. Les critères de qualité logicielle

La qualité d’un logiciel ne se limite pas à son bon fonctionnement.

Un programme peut fonctionner correctement tout en étant difficile à maintenir, peu sécurisé ou mal structuré.

On peut distinguer plusieurs critères fondamentaux.

### 📚 Lisibilité

Un code lisible est un code compréhensible par un autre développeur.

La lisibilité repose sur :

- un nommage explicite,
- des méthodes courtes,
- une indentation cohérente,
- des commentaires utiles et non redondants.

Un code illisible augmente le risque d’erreur et la difficulté de maintenance.

### 🏗 Maintenabilité

La maintenabilité mesure la capacité à faire évoluer un logiciel.

Elle dépend :

- du respect de l’architecture (ex : MVC),
- de la séparation des responsabilités,
- d’un faible couplage entre les composants,
- de l’absence de duplication.

Un projet mal structuré génère rapidement de la dette technique.

### 🧪 Testabilité

Un code testable est un code dont les composants peuvent être isolés et vérifiés indépendamment.

La présence de tests unitaires permet :

- de détecter des régressions,
- de documenter le comportement attendu,
- de sécuriser les évolutions.

### 🔐 Sécurité

Un audit de code doit également vérifier :

- la validation des entrées utilisateur,
- la protection contre les injections,
- la gestion des droits d’accès,
- la gestion correcte des erreurs.

!!! info "📊 Synthèse"

    Un logiciel de qualité doit être :

    - lisible,
    - maintenable,
    - testable,
    - sécurisé.

    **La qualité est un ensemble cohérent, pas un critère isolé.**

## 3. La dette technique

La **dette technique** correspond aux compromis pris dans le développement qui devront être corrigés ultérieurement.

Elle apparaît lorsque :

- le code est dupliqué,
- les tests sont absents,
- les méthodes deviennent trop longues,
- l’architecture n’est pas respectée.

La dette technique ralentit progressivement le projet et augmente les risques d’erreur.

Un audit permet de l’identifier et de la quantifier.

## 4. Outils d’analyse couramment utilisés

Les entreprises s’appuient sur des outils spécialisés pour automatiser une partie de l’audit.

### 🔍 Analyse statique

#### SonarQube

SonarQube est une plateforme d’analyse continue qui fournit :

- un tableau de bord qualité,
- la détection de bugs,
- l’identification de vulnérabilités,
- l’évaluation de la dette technique,
- la mesure de la duplication de code.

Il est souvent intégré dans une chaîne CI/CD.

#### PHPStan

PHPStan est un outil d’analyse statique pour PHP.

Il vérifie notamment :

- les incohérences de types,
- les appels à des méthodes inexistantes,
- les erreurs potentielles avant exécution.

Il est particulièrement utile dans les projets Laravel.

### ✏️ Outils de linting et de formatage

#### Laravel Pint

Laravel Pint impose un style de code uniforme.

Il n’améliore pas la logique du programme, mais garantit une cohérence visuelle et structurelle du projet.

### 🧪 Tests automatisés

#### PHPUnit

PHPUnit permet d’écrire des tests unitaires afin de vérifier le comportement du code.

Couplé à un outil de couverture (comme Xdebug), il permet de mesurer le pourcentage de code testé.

!!! info "📝 Synthèse"

    Les outils ne remplacent pas le développeur.  <br />
    Ils assistent l’audit en détectant automatiquement des anomalies techniques mesurables.

## 5. Indicateurs de qualité (KPIs)

Lors d’un audit, certains indicateurs permettent d’objectiver la qualité :

- taux de couverture des tests,
- nombre de bugs détectés,
- nombre de vulnérabilités,
- complexité cyclomatique,
- taux de duplication,
- estimation de la dette technique.

Ces indicateurs facilitent la prise de décision technique.

## 6. Audit de code et pratique professionnelle

En entreprise, l’audit de code s’intègre dans :

- les revues de code (pull requests),
- l’intégration continue,
- les audits de sécurité,
- les processus qualité.

Il s’agit d’une pratique normale et attendue dans les équipes de développement modernes.

## 🏁 Conclusion

L’audit de code est une démarche essentielle pour garantir la qualité logicielle.

Il repose sur :

- une lecture humaine structurée,
- des outils d’analyse automatisée,
- des indicateurs mesurables,
- une démarche d’amélioration continue.

Dans vos projets (comme bijoo ou todo), cette méthodologie vous permettra d’identifier les points d’amélioration et d’adopter des pratiques professionnelles alignées avec les attentes du secteur.

A suivre Activité sur bijoo et Todo
