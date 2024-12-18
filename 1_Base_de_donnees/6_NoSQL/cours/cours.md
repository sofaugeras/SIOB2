# Découverte du NoSQL

## 1. Introduction au NoSQL

Le terme **NoSQL** (Not Only SQL) désigne une catégorie de bases de données qui diffèrent des bases relationnelles traditionnelles par leur approche flexible et leur capacité à gérer de grandes quantités de données variées, souvent à très grande échelle. Les bases NoSQL ont émergé pour répondre aux limitations des bases relationnelles face aux nouvelles exigences des systèmes modernes :  

- **Volumétrie** : Gestion massive de données (Big Data).  
- **Variété** : Données structurées, semi-structurées ou non structurées (documents, graphes, colonnes, clés-valeurs, etc.).  
- **Vitesse** : Réponse rapide aux requêtes même sur de très grands ensembles de données.  
- **Scalabilité** : Montée en charge horizontale (ajout de serveurs) au lieu de verticale (augmentation de la puissance du serveur unique).  

### 1.1 Caractéristiques des bases NoSQL :
1. **Modèles de données flexibles** : Pas de schéma strict, ce qui permet d'ajouter facilement de nouveaux champs ou types de données.
2. **Haute disponibilité** : Conçues pour être tolérantes aux pannes et offrir une disponibilité continue.
3. **Scalabilité horizontale** : Idéal pour les systèmes distribués où les données sont réparties sur plusieurs serveurs.
4. **Performances élevées** : Optimisées pour des lectures/écritures rapides, même à très grande échelle.
5. **Modèles diversifiés** :  
   - **Bases documentaires** (ex. : MongoDB, CouchDB) : Stockent les données sous forme de documents JSON ou BSON.  
   - **Bases clés-valeurs** (ex. : Redis, DynamoDB) : Associations simples entre une clé et une valeur.  
   - **Bases orientées colonnes** (ex. : Cassandra, HBase) : Stockage des données par colonnes plutôt que par lignes.  
   - **Bases de graphes** (ex. : Neo4j, ArangoDB) : Spécialisées pour les relations complexes entre entités.

### 1.2 Les types de stockages

- Clés/valeurs
![clé valeur](./data/cleValeur.png){: width=80% .center}
- Colonnes
![colonne](./data/colonne.png){: width=80% .center}
- Documents
![doc](./data/document.png){: width=80% .center}
- Graphes
![graph](./data/graphe.png){: width=80% .center}


### 1.3 Différences entre SQL (relationnel) et NoSQL

| **Aspect**              | **SQL (relationnel)**                                      | **NoSQL**                                                   |
|--------------------------|-----------------------------------------------------------|-------------------------------------------------------------|
| **Modèle de données**    | Basé sur un schéma rigide : tables, lignes, colonnes.      | Flexible : documents, clés-valeurs, colonnes, graphes, etc. |
| **Schéma**               | Fixe (défini à l’avance).                                 | Dynamique (peut évoluer à tout moment).                     |
| **Langage de requête**   | SQL standardisé.                                          | Spécifique à chaque système (ex. : MongoDB utilise MQL).    |
| **Normalisation**        | Données normalisées pour réduire la redondance.           | Données souvent dénormalisées pour améliorer les performances. |
| **Transactions**         | Support ACID (atomicité, cohérence, isolation, durabilité). | Consistance éventuelle (CAP : cohérence, disponibilité, partitionnement). |
| **Scalabilité**          | Verticale : ajout de ressources à un seul serveur.        | Horizontale : ajout de serveurs.                            |
| **Cas d’utilisation**    | Applications transactionnelles (ERP, CRM, gestion).       | Big Data, IoT, réseaux sociaux, analyses en temps réel.     |
| **Exemples**             | MySQL, PostgreSQL, Oracle.                                | MongoDB, Cassandra, Redis, Neo4j.                          |


### 1.4 SQL vs NoSQL

**Quand choisir SQL ?**
- Lorsque les relations complexes entre les données doivent être modélisées.  
- Pour des applications nécessitant des transactions rigoureuses (ex. : banque, finance).  
- Si des outils d’analyse relationnels standards doivent être utilisés.

**Quand choisir NoSQL ?**
- Lorsque les données ne suivent pas un modèle fixe (données semi-structurées ou non structurées).  
- Si la volumétrie et la scalabilité sont des enjeux critiques (grandes entreprises, applications web).  
- Pour des performances élevées dans des environnements distribués.

En MongoDB, les notions de **base de données (database)** et de **collection (collection)** jouent un rôle similaire aux concepts de **base de données** et de **table** dans un système relationnel, mais elles sont adaptées au modèle flexible et orienté documents de MongoDB.

### 1.5 Base de données (Database)
Une base de données en MongoDB est un **conteneur logique** qui regroupe plusieurs collections. Elle sert à organiser et structurer les données.

#### 1.5.1 Caractéristiques :
- Chaque base de données a son propre ensemble de fichiers sur le disque.
- Une base de données peut contenir plusieurs collections.
- Les bases de données sont indépendantes les unes des autres (isolation logique).
- MongoDB permet de créer jusqu'à 12 000 bases de données par instance, bien que ce nombre soit rarement atteint en pratique.

#### 1.5.2 Usage :
Les bases de données sont généralement utilisées pour séparer des applications ou des contextes logiques.  
**Exemple** : Une entreprise pourrait avoir une base de données distincte pour chaque service :  
- `ecommerce` pour les ventes en ligne.  
- `hr` pour la gestion des ressources humaines.

### 1.6 Collection
Une collection est un **groupe de documents** dans MongoDB, l’équivalent d’une table dans une base relationnelle. Cependant, contrairement à une table, une collection n’a pas de schéma rigide. Cela signifie que les documents qu’elle contient peuvent avoir des structures différentes.

#### 1.6.1 Caractéristiques 
- Les collections sont contenues dans une base de données.
- Elles regroupent des documents ayant un objectif ou un contexte similaire.
- Chaque collection est identifiée par un nom unique dans une base de données donnée.
- Contrairement à une table SQL, une collection n'impose pas de structure stricte aux documents.

#### 1.6.2 Usage
Les collections sont utilisées pour regrouper des documents relatifs à une entité ou un sujet commun.  
**Exemple** : Dans une base de données `ecommerce`, vous pourriez avoir des collections telles que :  
- `users` pour les utilisateurs.  
- `products` pour les produits.  
- `orders` pour les commandes.

### 1.7 Différences principales entre Database et Collection

| **Aspect**                  | **Database**                            | **Collection**                       |
|-----------------------------|-----------------------------------------|---------------------------------------|
| **Rôle**                    | Conteneur logique de collections.      | Conteneur logique de documents.      |
| **Hiérarchie**              | Niveau supérieur.                      | Niveau inférieur (contenu dans une base de données). |
| **Analogies relationnelles**| Base de données SQL.                   | Table SQL.                           |
| **Isolation logique**       | Chaque base est indépendante.          | Partage des documents d'une même base. |
| **Structure**               | Groupement de collections.             | Groupement de documents JSON.        |

---

**Exemple pratique** : Création d’une base de données et d'une collection dans MongoDB

1. **Changer de base de données** (cela la crée si elle n’existe pas) :
   ```js
   use ecommerce
   ```

2. **Créer une collection et insérer un document** :
   ```js
   db.products.insertOne({ name: "Laptop", price: 1200, stock: 50 })
   ```

3. **Lister les collections de la base** :
   ```js
   show collections
   ```

!!! warning "En résumé"

    - **Database** : Organisation des collections (contexte global).  
    - **Collection** : Organisation des documents (entité ou contexte spécifique).  

## 2. Installation MongoDB sur Windows

Installer MongoDB for VSCode

1. Télécharger [MongoDB](https://www.mongodb.com/try/download/community) 
2. Installer MongoDB : 
> Double-cliquez sur le fichier .msi téléchargé pour lancer l’installation.<br />
> Suivez les étapes de l’assistant :<br />
    > Type d'installation : Sélectionnez Complete pour installer tous les composants.<br />
    > Configuration du service : Assurez-vous que l’option Run MongoDB as a Service est cochée pour exécuter MongoDB automatiquement au démarrage de Windows.<br />
> Accepter l'installation de MongoDB Compass

## 3. Contexte Restaurant

### 3.1 Création de la base et de la collection

1. On va créer une nouvelle connexion vers le serveur MongoDB en local.
![new connection](./data/newConnection.png){: width=50% .center}

2. Puis créer la structure logique DataBase pouvant contenir plusieurs collections (même si ici on n'en aura qu'une)
![new dataBase](./data/database.png){: width=50% .center}

3. On créer la collection Restaurants qui accueillera le jeu de données sur les retaurants
![new collection](./data/collection.png){: width=50% .center}

[🔽 Télécharger le jeu de données restaurants](./data/restaurants.zip){ .md-button }

```json
{
  "address": {
     "building": "1007",
     "coord": [ -73.856077, 40.848447 ],
     "street": "Morris Park Ave",
     "zipcode": "10462"
  },
  "borough": "Bronx",
  "cuisine": "Bakery",
  "grades": [
     { "date": { "$date": 1393804800000 }, "grade": "A", "score": 2 },
     { "date": { "$date": 1378857600000 }, "grade": "A", "score": 6 },
     { "date": { "$date": 1358985600000 }, "grade": "A", "score": 10 },
     { "date": { "$date": 1322006400000 }, "grade": "A", "score": 9 },
     { "date": { "$date": 1299715200000 }, "grade": "B", "score": 14 }
  ],
  "name": "Morris Park Bake Shop",
  "restaurant_id": "30075445"
}
```

4. Puis on ajoute le jeu de données au format JSON dans la collection
![import de la collection](./data/import.png){: width=80% .center}

### 3.2 Requêtes

!!! info "Crédits"
    Les exercices sont issus d'une page de **W3Ressources**, les questions sont traduites ici mais vous pouvez tout retrouver à l'adresse suivante : [https://www.w3resource.com/mongodb-exercises/](https://www.w3resource.com/mongodb-exercises/)

pour effectuer les requêtes sur la collection Restaurants, il faut ouvrir un shell.
![shell](./data/shell.png){: width=20% .center}

!!! question "R1"
    === "Enoncé"
        Ecrivez une requête MongoDB pour afficher tous les documents de la collection restaurants. 
    === "Solution"

        ```js
        db.restaurants.find()
        ```

!!! question "R2"
    === "Enoncé"
        Ecrivez une requête MongoDB pour afficher les champs restaurant_id, name, borough et cuisine pour tous les documents de la collection restaurant. 
    === "Solution"

        ```js   
        db.restaurants.find(
            { },
            { restaurant_id: 1, name: 1, borough:1, cuisine:1 }
        )
        ```

!!! question "R3"
    === "Enoncé"     
        Ecrivez une requête MongoDB pour afficher les champs restaurant_id, name, borough et cuisine, mais excluez le champ _id pour tous les documents de la collection restaurant. 
    === "Solution"

        ```js          
        db.restaurants.find(
            { },
            { restaurant_id: 1, name: 1, borough:1, cuisine:1 , _id:0}
        )
        ```

!!! question "R4"
    === "Enoncé" 
        Ecrivez une requête MongoDB pour afficher les champs restaurant_id, name, borough et zip code, mais excluez le champ _id pour tous les documents de la collection restaurant. 
    === "Solution"

        ```js          
        db.restaurants.find(
            { },
            { restaurant_id: 1, name: 1, borough:1, "address.zipcode":1 , _id:0}
        )
        //ou
        db.restaurants.find({},{"restaurant_id" : 1,"name":1,"borough":1,"address.zipcode" :1,"_id":0});
        ```

!!! question "R5"
    === "Enoncé" 
        Écrivez une requête MongoDB pour afficher tous les restaurants du quartier Bronx. 
    === "Solution"

        ```js    
        db.restaurants.find(
            { borough: "Bronx" }
        )
        ```
!!! question "R6"
    === "Enoncé" 
        Écrivez une requête MongoDB pour afficher les 5 premiers restaurants qui se trouvent dans l'arrondissement du Bronx. 
    === "Solution"

        ```js    
        db.restaurants.find(
            { borough: "Bronx" }
        ).limit(5)
        ```

!!! question "R7"
    === "Enoncé" 
        Ecrivez une requête MongoDB pour afficher les 5 prochains restaurants après avoir ignoré les 5 premiers qui se trouvent dans l'arrondissement du Bronx. 
    === "Solution"

        ```js       
        db.restaurants.find(
            { borough: "Bronx" }
        ).limit(5).skip(5)
        ```
!!! question "R8"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver les restaurants qui ont obtenu un score supérieur à 90. 
    === "Solution"

        ```js
        db.restaurants.find({grades : { $elemMatch:{"score":{$gt : 90}}}});
        ```
!!! question "R9"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver les restaurants qui ont obtenu un score supérieur à 80 mais inférieur à 100. 
    === "Solution"

        ```js
        db.restaurants.find({grades : { $elemMatch:{"score":{$gt : 80, $lte :100}}}});
        ```
!!! question "R10"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver les restaurants dont la latitude est inférieure à -95.754168. 
    === "Solution"

        ```js
        db.restaurants.find({"address.coord.0" : {$lt : -95.754168}});
        ```

!!! question "R11"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver les restaurants qui ne préparent aucune cuisine « américaine » et leur note est supérieure à 70 et la latitude inférieure à -65.754168. 
    === "Solution"

        ```js
        db.restaurants.find(
               {$and:
                    [
                       {"cuisine" : {$ne :"American "}},
                       {"grades.score" : {$gt : 70}},
                       {"address.coord" : {$lt : -65.754168}}
                    ]
                }
                    );

        ```        
!!! question "R12"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver les restaurants qui ne préparent aucune cuisine « américaine » et ont obtenu un score supérieur à 70 et situés à une longitude inférieure à -65.754168. Remarque : faites cette requête sans utiliser $ et l'opérateur. 
    === "Solution"

        ```js
        db.restaurants.find(
                           {
                             "cuisine" : {$ne : "American "},
                             "grades.score" :{$gt: 70},
                             "address.coord" : {$lt : -65.754168}
                            }
                     );

        ```

!!! question "R13"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver les restaurants qui ne préparent aucune cuisine « américaine » et qui ont obtenu la note « A » n'appartenant pas à l'arrondissement de Brooklyn. Le document doit être affiché selon la cuisine par ordre décroissant. 
    === "Solution"

        ```js
        db.restaurants.find( {
                             "cuisine" : {$ne : "American"},
                             "grades.grade" :"A",
                             "borough": {$ne : "Brooklyn"}
                       } 
                    ).sort({"cuisine":-1});
        ```

!!! question "R14"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom, le quartier et la cuisine du restaurant pour les restaurants qui contiennent « Wil » comme trois premières lettres de son nom. 
    === "Solution"

        ```js
        db.restaurants.find(
                            {name: /^Wil/},
                            {
                            "restaurant_id" : 1,
                            "name":1,"borough":1,
                            "cuisine" :1
                            }
                            );
        ```
!!! question "R15"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom, le quartier et la cuisine du restaurant pour les restaurants qui contiennent « ces » comme trois dernières lettres de son nom. 
    === "Solution"

        ```js
        db.restaurants.find(
                        {name: /ces$/},
                        {
                        "restaurant_id" : 1,
                        "name":1,"borough":1,
                        "cuisine" :1
                        }
        );
        ```
!!! question "R16"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom, le quartier et la cuisine du restaurant pour les restaurants qui contiennent "Reg" sous forme de trois lettres quelque part dans son nom. 
    === "Solution"

        ```js
        db.restaurants.find(
        {"name": /.*Reg.*/},
        {
        "restaurant_id" : 1,
        "name":1,"borough":1,
        "cuisine" :1
        }
        );

        ```
!!! question "R17"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver les restaurants qui appartiennent à l'arrondissement du Bronx et qui ont préparé des plats américains ou chinois. 
    === "Solution"

        ```js
        db.restaurants.find(
        { 
        "borough": "Bronx" , 
        $or : [
        { "cuisine" : "American " },
        { "cuisine" : "Chinese" }
        ] 
        } 
        );
        ```
!!! question "R18"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom, le quartier et la cuisine du restaurant pour les restaurants qui appartiennent au quartier Staten Island ou Queens ou Bronxor Brooklyn. 
    === "Solution"

        ```js
        db.restaurants.find(
                    {"borough" :{$in :["Staten Island","Queens","Bronx","Brooklyn"]}},
                    {
                    "restaurant_id" : 1,
                    "name":1,"borough":1,
                    "cuisine" :1
                    }
                    );
        ``` 

!!! question "R19"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom, le quartier et la cuisine du restaurant pour les restaurants qui n'appartiennent pas au quartier Staten Island, Queens ou Bronxor Brooklyn. 
    === "Solution"

        ```js
        db.restaurants.find(
            {"borough" :{$nin :["Staten Island","Queens","Bronx","Brooklyn"]}},
            {
            "restaurant_id" : 1,
            "name":1,"borough":1,
            "cuisine" :1
            }
            );

        ``` 

!!! question "R20"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom, le quartier et la cuisine du restaurant pour les restaurants qui ont obtenu un score ne dépassant pas 10. 
    === "Solution"

        ```js
        db.restaurants.find(
                    {"grades.score" : 
                    { $not: 
                    {$gt : 10}
                    }
                    },
                    {
                    "restaurant_id" : 1,
                    "name":1,"borough":1,
                    "cuisine" :1
                    }
                    );

        ``` 
!!! question "R21"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom, le quartier et la cuisine du restaurant pour les restaurants qui ont préparé des plats à l'exception de « Américain » et « Chinees » ou le nom du restaurant commence par la lettre « Wil ». 
    === "Solution"

        ```js
        db.restaurants.find(
            {$or: [
            {name: /^Wil/}, 
            {"$and": [
                {"cuisine" : {$ne :"American "}}, 
                {"cuisine" : {$ne :"Chinees"}}
            ]}
            ]}
            ,{"restaurant_id" : 1,"name":1,"borough":1,"cuisine" :1}
            );
        ``` 

!!! question "R22"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom et les notes du restaurant pour les restaurants qui ont obtenu la note "A" et un score de 11 à une date ISO "2014-08-11T00:00:00Z" parmi de nombreuses dates d'enquête. 
    === "Solution"

        ```js
        db.restaurants.find( 
                {
                 "grades.date": ISODate("2014-08-11T00:00:00Z"), 
                 "grades.grade":"A" , 
                 "grades.score" : 11
                }, 
                {"restaurant_id" : 1,"name":1,"grades":1}
             );

        ``` 
!!! question "R23"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom et les notes du restaurant pour les restaurants où le 2e élément du tableau des notes contient une note de "A" et un score de 9 à une date ISO "2014-08-11T00:00:00Z". 
    === "Solution"

        ```js
        db.restaurants.find( 
                      { "grades.1.date": ISODate("2014-08-11T00:00:00Z"), 
                        "grades.1.grade":"A" , 
                        "grades.1.score" : 9
                      }, 
                       {"restaurant_id" : 1,"name":1,"grades":1}
                   );

        ```         
!!! question "R24"
    === "Enoncé" 
        Écrivez une requête MongoDB pour trouver l'identifiant, le nom, l'adresse et l'emplacement géographique du restaurant pour les restaurants où le 2ème élément du tableau de coordonnées contient une valeur supérieure à 42 et jusqu'à 52. 
    === "Solution"

        ```js
        db.restaurants.find( 
                      { 
                        "address.coord.1": {$gt : 42, $lte : 52}
                      },
                        {"restaurant_id" : 1,"name":1,"address":1,"coord":1}
                   );

        ```         
!!! question "R25"
    === "Enoncé"
        Écrivez une requête MongoDB pour organiser le nom des restaurants dans l'ordre croissant avec toutes les colonnes. 
    === "Solution"

        ```js
        db.restaurants.find().sort({"name":1});
        ```      
!!! question "R26"
    === "Enoncé"
        Écrivez une requête MongoDB pour organiser le nom des restaurants en ordre décroissant avec toutes les colonnes. 
    === "Solution"

        ```js
        db.restaurants.find().sort(
                          {"name":-1}
                          );

        ``` 
!!! question "R27"
    === "Enoncé"
        Écrivez une requête MongoDB pour organiser le nom de la cuisine dans l'ordre croissant et pour ce même arrondissement de cuisine devrait être dans l'ordre décroissant. 
    === "Solution"

        ```js
        db.restaurants.find().sort(
                           {"cuisine":1,"borough" : -1,}
                          );

        ```   

!!! question "R28"
    === "Enoncé"
        Écrivez une requête MongoDB pour savoir si toutes les adresses contiennent la rue ou non. 
    === "Solution"

        ```js
        db.restaurants.find(
                     {"address.street" : 
                         { $exists : true } 
                     } 
                   );

        ```       
!!! question "R29"
    === "Enoncé"
        Écrivez une requête MongoDB qui sélectionnera tous les documents de la collection de restaurants où la valeur du champ coord est Double. 
    === "Solution"

        ```js
        db.restaurants.find(
                    {"address.coord" : 
                       {$type : 1}
                    }
                   );

        ```       

!!! question "R30"
    === "Enoncé"
        Écrivez une requête MongoDB qui sélectionnera l'identifiant, le nom et les notes du restaurant pour ces restaurants qui renvoie 0 comme reste après avoir divisé le score par 7. 
    === "Solution"

        ```js
        db.restaurants.find(
                      {"grades.score" :
                         {$mod : [7,0]}
                      },
                         {"restaurant_id" : 1,"name":1,"grades":1}
                    );

        ```         

!!! question "R31"
    === "Enoncé"
        Écrivez une requête MongoDB pour trouver le nom du restaurant, l'arrondissement, la longitude, l'attitude et la cuisine des restaurants qui contiennent « mon » sous forme de trois lettres quelque part dans leur nom. 
    === "Solution"

        ```js
        db.restaurants.find(
                   { name : 
                     { $regex : "mon.*", $options: "i" } 
                   },
                       {
                         "name":1,
                         "borough":1,
                         "address.coord":1,
                         "cuisine" :1
                        }
                   );

        ```              
!!! question "R32"
    === "Enoncé"
        Écrivez une requête MongoDB pour trouver le nom du restaurant, l'arrondissement, la longitude et la latitude et la cuisine des restaurants qui contiennent « Mad » comme les trois premières lettres de son nom. 
    === "Solution"

        ```js
        db.restaurants.find(
                   { name : 
                     { $regex : /^Mad/i, } 
                   },
                       {
                         "name":1,
                         "borough":1,
                         "address.coord":1,
                         "cuisine" :1
                        }
                   );

        ```     

