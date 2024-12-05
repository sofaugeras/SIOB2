# Sauvegarde de Base de données sous MySQL

## 0. Préparation de l’environnement

1. Récupérer la base de données exemple `tp_sauvegarde`.
[Télécharger base sauvegarde :arrow_down:](./data/tpSauv/tp_sauvegarde.sql){ .md-button .md-button--primary }

??? note "Descriptif"
      ``utilisateurs`` : contient les informations des utilisateurs inscrits.<br />
      ``commandes`` : enregistre les commandes passées par les utilisateurs. Une relation existe entre les tables utilisateurs et commandes grâce à la clé étrangère ``utilisateur_id``.<br />
      ``logs`` : journalise les actions réalisées dans le système.

2. Visualiser sa structure et son contenu :

   ```sql
   SHOW TABLES;
   SELECT * FROM nom_table LIMIT 5;
   ```

## 1. Sauvegarde par PHPMyAdmin

### 1.1 Sauvegarde au format Base de données (duplication)

![sauvegarde](./data/tpSauv/sauvegarde_phpMyAdmin.png){: width=50% .center}

### 1.2 Sauvegarde sous forme de script SQL

👀 Prenez le temps d'observer toutes les options proposées par cet écran

![sauvegarde](./data/tpSauv/sauve1.png){: width=50% .center}

??? info "Résultat"
      [Télécharger le script obtenu :arrow_down:](./data/tpSauv/tp_sauvegarde_script.sql){ .md-button .md-button--primary }

## 2. Sauvegarde par mysqldump

??? warning "préalable"

      - localiser ``mysqldump.exe`` qui doit etre dans ``C:\wamp64\bin\mysql\mysqlX.X.X\bin``<br />
      - Ajouter ce chemin dans les variables d'environnement de Windows. Cela permettra d'utiliser la commande MySQLdump depuis une invite de commande peu importe le répertoire ou l'on se trouve<br />
      
      **Détail**  <br />
      - Accédez à **Panneau de configuration > Système > Paramètres avancés > Variables d'environnement**.<br />
      - Trouvez la variable **Path** dans la section ==Système== et cliquez sur Modifier.<br />
      - Ajoutez le chemin vers le répertoire bin de MySQL (par exemple, ``C:\Program Files\MySQL\MySQL Server X.X\bin``).<br />
      - Redémarrez l’Invite de commandes.
      - tester si cela fonctionne en ouvrant une invite de commande **cmd** et en tapant ``mysqldump --version``<br />

#### 2.1 Sauvegarde avec `mysqldump`

👉 Expliquer la commande de base pour sauvegarder une base de données 

   ```bash
   mysqldump -u root -p tp_sauvegarde > sauvegarde_tp.sql
   ```
**note** : le mot de passe demandé à l'execution de la commande est celui de la base de données (associé au ``root``)

**indication** : lire la [documentation](https://dev.mysql.com/doc/refman/8.4/en/mysqldump.html){: target="blank"}

👉 Vérifier que le fichier de sauvegarde est bien créé. Où a t'il été créé ?

??? question "solution"
      Le fichier ``sauvegarde_tp.sql`` est créé dans le répertoire où la commande a été exécutée.

👉 Lancer un éditeur de texte pour explorer le contenu de `sauvegarde_tp.sql` et expliquer le format des sauvegardes (fichiers SQL).

❓ Quelles sont les informations présentes dans le fichier de sauvegarde ?

??? question "correction"
      Le fichier comprend toutes les instructions pour recréer la base, structure et données

❓ Comment récupérer uniquement la structure des tables sans les données ?

??? question "proposition"

      Réaliser une sauvegarde contenant uniquement la structure :
      ```bash
      mysqldump -u root -p --no-data tp_sauvegarde > structure_tp.sql
      ```

#### 2.2 Simuler une perte de données

👉 Supprimer une table ou des données :

??? question "proposition" 
      ```sql
      DELETE FROM logs;
      ```
👉 Vérifier que les données sont perdues :

??? question "proposition"
      ```sql
      SELECT * FROM logs;
      ```

#### 2.3 Restauration des données

👉 Restaurer la base à partir de la sauvegarde :
   ```bash
   mysql -u root -p tp_sauvegarde < sauvegarde_tp.sql
   ```
👉 Vérifier que les données sont restaurées :
   ```sql
   SELECT * FROM logs;
   ```

❓ Que se passe-t-il si la base de données `tp_sauvegarde` n’existe pas avant la restauration ?

??? question "proposition"
      Erreur SQL, la base n'existe pas.

❓ Que faire pour éviter ce problème lors de grandes restaurations ?

??? question "proposition"
      Inclure l'option ``--add-drop-database`` lors de la sauvegarde pour que le fichier contienne la commande ``DROP DATABASE IF EXISTS``.

#### 2.4 Automatisation des sauvegardes

👉 Expliquer comment planifier des sauvegardes régulières avec le planificateur de tâches sous Windows.

??? question "proposition"
      **Étape 1 : Préparer le script de sauvegarde**<br />
      1. Créez un fichier batch (par exemple, `backup_mysql.bat`) :
         ```batch
         @echo off
         set BACKUP_DIR=C:\backups
         set TIMESTAMP=%date:~10,4%-%date:~4,2%-%date:~7,2%
         set BACKUP_FILE=%BACKUP_DIR%\all_databases_%TIMESTAMP%.sql

         set MYSQL_USER=root
         set MYSQL_PASSWORD=VotreMotDePasse

         if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

         mysqldump -u %MYSQL_USER% -p%MYSQL_PASSWORD% --all-databases > "%BACKUP_FILE%"

         if %ERRORLEVEL% EQU 0 (
            echo Sauvegarde réussie : %BACKUP_FILE%
         ) else (
            echo Erreur lors de la sauvegarde
         )
         pause
         ```
      **Explications des variables :**

      - **BACKUP_DIR** : Répertoire où les sauvegardes seront enregistrées. Vous pouvez modifier ``C:\backups`` par un chemin de votre choix.<br />
      - **MYSQL_USER** et **MYSQL_PASSWORD** : Identifiants de connexion à votre serveur MySQL. Remplacez VotreMotDePasse par le mot de passe du compte MySQL ``root`` (ou un autre utilisateur disposant des droits nécessaires).<br />
      - **TIMESTAMP** : Génère une date au format YYYY-MM-DD pour inclure dans le nom du fichier.

      2. Testez le fichier batch en double-cliquant dessus ou via l'Invite de commandes.

      **Étape 2 : Configurer le Planificateur de tâches**<br />
      1. Ouvrez le **Planificateur de tâches** : Appuyez sur `Win + R`, tapez `taskschd.msc` et appuyez sur Entrée.<br />
      2. Créez une nouvelle tâche :Cliquez sur **Créer une tâche...** dans le menu de droite.<br />
      3. Configurez la tâche :<br />
      **Général :** Donnez un nom à la tâche, par exemple, "Sauvegarde MySQL", puis Cochez **Exécuter même si l'utilisateur n'est pas connecté** et sélectionnez **Exécuter avec les autorisations maximales**.<br />
      **Déclencheurs :** Cliquez sur **Nouveau...** et planifiez l'exécution (par exemple, quotidiennement à 2h du matin).<br />
      **Actions :** Cliquez sur **Nouveau...**, choisissez **Démarrer un programme**, et indiquez le chemin vers votre fichier batch (`backup_mysql.bat`).<br />
      4. Sauvegardez et testez : Cliquez sur **OK** et exécutez la tâche manuellement pour vérifier son fonctionnement.

❓ Donner une commande sauvegarder 2 bases de données en même temps.

??? question "proposition"
      ```bash
      mysqldump -u root -p --databases tp_sauvegarde autre_base > multi_backup.sql
      ```

❓  Donner une commande pour sauvegarder et compresser la sauvegarde :

??? question "proposition"
      ```bash
      mysqldump -u root -p tp_sauvegarde | gzip > sauvegarde_tp.sql.gz
      ```

!!! info "Conseils généraux"

      1. **Vérification des sauvegardes :**
         - Testez régulièrement les fichiers de sauvegarde en restaurant une base sur un environnement de test.
      2. **Sécurisation :**
         - Stockez les sauvegardes dans un endroit sécurisé, idéalement sur un autre serveur ou un service cloud.
         - Utilisez un mot de passe dédié à la sauvegarde.
      3. **Compression des sauvegardes :**
         - Ajoutez une étape de compression pour économiser de l'espace :
         - Sous Linux :
            ```bash
            mysqldump ... | gzip > sauvegarde.sql.gz
            ```
         - Sous Windows, utilisez un outil comme 7-Zip dans le script.

      Découvrir les outils de sauvegarde tiers comme **Percona XtraBackup** ou **MySQL Enterprise Backup**.