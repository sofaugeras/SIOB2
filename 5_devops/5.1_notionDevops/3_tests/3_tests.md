# CI - tests

![en connstruction](../../images/enConstruction.png)

L’exécution de tests unitaires et d’intégrations est au coeur de la démarche DevOps et d’intégration continue. C’est eux qui vont permettre de détecter les anomalies dans les développements réalisés. Jenkins, si un ou plusieurs tests sont en erreur, va fournir les rapports détaillés permettant d’identifier l’origine de l’erreur, et va signaler que la tâche est en erreur. Cela peut par exemple empêcher un merge de se réaliser dans GitLab.

```
- name: Run tests with coverage
  env: 
    XDEBUG_MODE: coverage 
    run: php artisan test --coverage --min=80
```

TP — Tests Laravel + Intégration CI

Objectifs pédagogiques : 

- Structurer une suite de tests Unit et Feature sous Laravel.
- Tester validation, auth, politiques, Eloquent, API, mails/queues/storage via fakes.
- Produire un rapport de couverture et fixer un seuil minimal.
- Exécuter les tests en CI GitHub Actions avec base de données dédiée.