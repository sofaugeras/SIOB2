
# 🧩 Programmation objet

## 1. 🔑 Principes

Comme son nom l’indique, le paradigme objet donne une vision du problème à résoudre comme un ensemble d’objets. Ces objets ont des caractéristiques et des comportements qui leurs sont propres, ce sont respectivement les attributs et les méthodes. Les objets interagissent entre eux avec des messages, en respectant leur interface (c’est-à-dire l’ensemble des spécifications en version compacte, les signatures des méthodes, on verra ce point plus en détail tout au long de l’année).

![diagramme de classe](./data/1.png){: .center}

### 1.1 📖 Un exemple « papier »

Créons un jeu vidéo de type « hack and slash ». Dans ce type de jeu, le personnage joué doit tuer un maximum de monstres sur une carte de jeu. A lire le descriptif, 3 objets apparaissent naturellement :

* 🧙‍♂️ Le personnage principal
* 👹 Les monstres
* 🗺️ La carte

On remarque immédiatement que « monstre » aurait plutôt tendance à désigner un type qu’un objet unique : les objets sont tous typés. Le type définit à la fois le nom de l’objet, et ce qu’il fait.

De même, avec cette structure, on peut avoir plusieurs objets « personnages », pour jouer en multi-joueur, et bien sûr plusieurs cartes.


### 1.2 🏗️ Classe et objets

Le « moule » avec lequel on va fabriquer un objet est appelé **classe**.

La classe personnage comprend par exemple les attributs :

* ❤️ Points de vie
* ⚔️ Dégâts maximums qu’inflige le personnage
* 📍 Position

Elle comprend les méthodes :

* 🚶 Déplacement
* 🗡️ Attaque

Et des méthodes qui permettent d’accéder aux attributs, ou bien de les modifier. Ce sont les **accesseurs** et les **mutateurs**. Les attributs sont cachés des objets extérieurs (le principe est l’encapsulation), ils sont privés. Les méthodes permettant d’y accéder sont à l’inverse publiques. Un objet extérieur ne doit pas pouvoir modifier à loisir les attributs d’un autre objet, en effet il doit y avoir un contrôle de l’objet sur ses propres attributs.

Quand on crée un personnage, l’ordinateur crée une **instance** de la classe. C’est-à-dire que tous les objets de la classe auront les mêmes attributs et méthodes, mais que deux objets de la même classe peuvent avoir des valeurs différentes pour les attributs. L’instance est créée grâce à un **constructeur**.

### 1.3 🏡 Métaphore

* 📐 Une classe, c’est le plan d’une maison (abstrait)
* 🏠 Un objet, c’est une maison issue du plan (concret). Ce qu’il y a à l’intérieur d’une maison diffère de l’intérieur d’une autre maison (décoration, mobilier, etc…)
* 🔘 L’interface c’est le bouton qui permet de régler le chauffage
* 🔧 L’implémentation (ou la réalisation) de l’interface, c’est la méthode de chauffage/climatisation retenue. L’utilisateur ne connaît pas le détail de l’implémentation, ce qui compte pour lui, c’est le bouton de réglage (donc l’interface)

## 2. Concepts de classe, attributs, méthodes

### 2.1 ☕ Une classe en Java

Le code suivant montre, étape par étape, la classe « personnage » telle qu’on l’a définie au paragraphe précédent.

Le mot-clé pour définir une classe est `class`. On donne ensuite les spécifications de la classe (on documente).

Une classe a une **visibilité** :

* 🌍 **public** : le mot `class` est alors précédé de `public`, tout utilisateur qui importe le paquetage peut utiliser la classe. Dans ce cas elle doit être définie dans un fichier qui a pour nom le nom de la classe.
* 🔒 **privé** : le mot `class` est alors précédé de `private`, seules des classes définies dans le même fichier peuvent utiliser cette classe.
* 📦 **paquetage** : le mot `class` n’est pas précédé de mot particulier, toutes les classes du paquetage peuvent utiliser la classe.

```java
public class Personnage {

    """
    Personnage d'un jeu de type hack 'n slash

    Attributs :
        nom : chaine de caractères, nom du personnage
        pv : entier positif ou nul, points de vie du personnage
        degats : entier strictement positif, dégats maximum du personnage
        position : couple d'entiers donnant l'abscisse et l'ordonnée
                   du personnage sur la carte
    Méthodes:
        Init() constructeur de la classe Personnage
        getAttribut() : accesseurs des attributs
        setAttributs(nouvelle_valeur) : mutateurs des attributs.
                Uniquement pour les attributs _pv et _position
        deplacement(paramètres) : permet de changer la position
                                  du personnage
        attaque() : renvoie les dégâts faits à l'adversaire
    """
```
La première méthode dans la classe est le **constructeur**, appelé du même nom que la classe en JAVA. Dans le constructeur de `Personnage` est aussi passé en argument le paramètre **nom**. Le constructeur initialise les attributs de l’objet (points de vie, dégâts, position).

Tous les attributs sont précédés d’un tiret bas « `_` » pour signifier qu’ils sont **privés**.

```java
Personnage(String nom) {
    """
    Constructeur de la classe Personnage

    Données:   
        nom : chaine de caractères, nom du personnage
        pv : entier positif ou nul, points de vie du personnage
        degats : entier strictement positif, dégats maximum du personnage
        position : couple d'entiers donnant l'abscisse et
                   l'ordonnée du personnage sur la carte
    Résultat : 
        ne retourne rien, crée un nouveau Personnage
    """
    nom = nom;
    pv = 80;
    degats = 8;
    position = (0,0);
}
```

ou encore :

```java
this.nom = nom;
```

Le mot-clé **this** désigne en permanence l'objet dans lequel on se trouve. Il existe dès l'instant que l'on se trouve dans l'instance de quelque chose. En particulier, il n'est pas défini dans un élément statique.

En général, ce mot-clé est utilisé pour lever l'ambigüité qui peut exister entre le champ d'une classe et un paramètre d'une méthode dans laquelle on se trouve, comme dans l'exemple qui suit.

➡️ **Exemple : Utilisation de `this` pour lever l'ambiguïté entre un champ et un paramètre**

![illustration this](./data/2.png){: .center}

### 2.2 🔑 Accesseurs (getters) et Mutateurs (setters)

Les **accesseurs** n’ont pas de paramètre, les **mutateurs** ont la nouvelle valeur.
Il n’y a pas forcément de mutateurs (ni d’accesseurs) pour tous les attributs :
👉 par exemple, le nom du personnage n’est pas modifiable ici.

On ne documente pas les accesseurs, on peut le faire pour les mutateurs.

#### 📥 Accesseurs des attributs

```java
public String getNom() {
    return this.nom;
}

public int getPv() {
    return this.pv;
}

public int getDegats() {
    return this.degats;
}

public [] getPosition() {
    return this.position;
}
```

#### 📤 Mutateurs des attributs

```java
public void setPv(int nouveaux_pv) {
    """
    Les points de vie d’un personnage sont positifs ou nuls.
    """
    if (nouveaux_pv < 0) {
        pv = 0;
    } else {
        pv = nouveaux_pv;
    }
}

public void setDegats(int nouveaux_degats) {
    degats = nouveaux_degats;
}
```
### 2.3 🛠️ Définition d’une méthode

Une méthode est définie par :

* 🏷️ **Son type de retour** : type de la valeur retournée par la méthode.
  Si la méthode ne retourne pas de valeur le type spécifié est alors `void`.
  Le type retourné peut être un tableau.
* 📝 **Son nom**
* 🔢 **Ses paramètres** :

  * spécifiés par leur type et leur nom
  * séparés par des virgules
  * tous transmis par valeur (mais la plupart sont des références)

On peut avoir un **paramètre ellipse** (`...`) qui est en fait un tableau, et doit être le dernier paramètre.

### Exemple

```java
void m(X ... e) {
    // e est un tableau à une dimension d'éléments de type X
}
```
Un appel de la méthode `m` se fait alors de la façon suivante :

```java
m(null);
m();
m(x1);
m(x1, x2);
```

#### ✍️ Signature d’une méthode

Une méthode est caractérisée par sa **signature** :

* 🔹 son nom
* 🔹 la liste des types des paramètres, dans l'ordre

👉 Deux méthodes différentes **ne peuvent pas** avoir la même signature.
👉 Deux méthodes ayant le même nom mais des paramètres différents sont des **surcharges**.

#### 👁️ Visibilité d’une méthode

* 🌍 **public** : accessible partout
* 🔒 **private** : utilisable seulement dans la classe
* 🛡️ **protected** : utilisable dans la classe et les classes dérivées
* 📦 **paquetage** : utilisable dans toutes les classes du même paquetage

![illustration classe Personnage](./data/3.png){: .center}

### 2.4 🏷️ Attributs

Un attribut se définit en donnant son type, puis son nom, (`[]` pour un tableau), et éventuellement une partie initialisation.

#### 👁️ Visibilité d’un attribut

* 🌍 **public** : sa définition est précédée de `public`, et il peut être utilisé par tout utilisateur de la classe.
* 🔒 **privé** : sa définition est précédée de `private`, et il ne peut être utilisé qu’à l’intérieur de la classe.
* 🛡️ **protégé** : sa définition est précédée de `protected`, et il ne peut être utilisé qu’à l’intérieur de la classe, ou des classes dérivées.
* 📦 **paquetage** : l’attribut peut être utilisé dans toute classe du même paquetage.

📌 À l’intérieur de la définition d’une méthode, l’accès à un attribut se fait soit directement, soit en préfixant l'attribut par `this` qui est une référence à l’objet pour lequel est appelée la méthode.

📌 À l’extérieur de la définition de la classe, l’accès se fait en écrivant :
👉 **nom de l’instance . nom de l’attribut** ou **nom de l’instance . nom de la méthode**

**Exemple**

```java
class Point {
   private int x;                
   public int y;

   void f() {
      x = 0;
      this.y = 1;
   }     
}
```

En dehors de la définition de la classe :

```java
Point p = new Point();

p.x = 0; // ❌ Erreur de compilation : la visibilité de x est privée !
p.y = 1; // ✅
```

#### 🔒 Attributs publics, attributs privés

En programmation objet, indépendamment du langage, on considère que les attributs doivent être **privés**, encapsulés à l’intérieur de la classe et accessibles uniquement par mutateurs.

Vous trouverez sur le web de nombreux exemples de code rédigés de cette manière, sans forcément savoir si les propriétés avancées de Python ont été utilisées. Nous utiliserons également ce type de code plus tard dans l’année, pour simplifier l’écriture des programmes.

!!! warning "⚠️ Remarques"

    * ❌ Ne pas donner le même nom à une méthode et à un attribut dans une classe !
    * ✅ Plusieurs classes peuvent avoir les mêmes noms de méthodes sans problème.

    👉 En effet, l’appel d’une méthode passe par :

    ```java
    objet.méthode()
    ```
    Ce qui permet de savoir dans quelle classe chercher la méthode.

    ➡️ La classe définit son **espace de noms**.

## 3. 🆕 Création d’instances

Pour créer une instance de la classe `A`, on écrira :

```java
A a;        // définition de la variable référence
a = new A(); // création de l’instance
```

### 3.1 🔄 Étapes de création avec `new`

La création d’une instance par l’opérateur `new` se déroule en trois temps :

1. 📦 Réservation de l’espace mémoire suffisamment grand pour représenter l’objet.
2. ⚡ Appel du constructeur de l’objet → Initialisation des attributs et d’une référence à l’objet représentant la classe de l’instance en train d’être créée.
3. 🔗 Renvoi d’une référence sur l’objet nouvellement créé.

**Exemple**

```java
class Point {
   int x;
   int y;
   ...
}

Point a, b;
a = new Point(...);
b = a;
```
![illustration](./data/4.gif){: .center}


### 3.2 🗑️ Destruction d’instances

La destruction des instances se fait automatiquement par un **thread**, le **garbage collector**, qui cherche tous les objets qui ne sont plus référencés et les supprime.

👉 Le garbage collector peut être appelé directement par :

```java
System.gc();
```

!!! warning "📊 résumé POO"

    |Concept |Idées Générales|
    |--------|---------------|
    |🔑 Principes|
    Objets = attributs (caractéristiques) + méthodes (comportements), Encapsulation : attributs privés, accès via getters/setters, Interface = ce qu’on voit (contrat), Implémentation = ce qui est fait en interne |
    |🏗️ Classe et Objet|Classe = modèle / plan 📝, Objet = instance concrète 🏠, Création → via un constructeur,
    Destruction → via le Garbage Collector 🗑️|
    |☕ Java (exemple)| Mot-clé ``class``, Visibilité : ``public``/``private``/``protected``/package, Méthodes → définies par type retour + nom + paramètres, Signature = nom + liste des paramètres, Surcharge = même nom, paramètres différents
    |📦 Attributs |Toujours privés (bonnes pratiques), Accès uniquement via mutateurs (setters)|

    ![infographie](./data/infographie.png){: .center width=80%}


## 4. 🧬 Héritage

L’héritage permet de **créer une nouvelle classe** (dite **classe fille**) à partir d’une classe existante (dite **classe mère**).
La classe fille hérite :

* des **attributs** de la classe mère
* des **méthodes** de la classe mère

Elle peut aussi :

* 🔄 **redéfinir** (surcharger) certaines méthodes
* ➕ **ajouter** ses propres attributs et méthodes

👉 Cela favorise la **réutilisation du code** et l’**organisation hiérarchique** des classes.

#### Exemple en Java

```java
// Classe mère
class Personnage {
    protected String nom;
    protected int pv;

    public Personnage(String nom, int pv) {
        this.nom = nom;
        this.pv = pv;
    }

    public void afficher() {
        System.out.println(nom + " possède " + pv + " points de vie.");
    }
}

// Classe fille
class Guerrier extends Personnage {
    private int force;

    public Guerrier(String nom, int pv, int force) {
        super(nom, pv); // appel du constructeur de la classe mère
        this.force = force;
    }

    @Override
    public void afficher() {
        System.out.println(nom + " (Guerrier) possède " + pv + 
                           " points de vie et " + force + " de force.");
    }
}
```

#### 📝 Remarques

* `super` appelle le constructeur ou une méthode de la classe mère.
* Les attributs hérités peuvent être accessibles selon leur **visibilité** (`protected` ou `public`).
* Une classe peut être déclarée `final` → **empêche** l’héritage.


## 5. 🎭 Polymorphisme

Le polymorphisme est la capacité d’un objet à **prendre plusieurs formes**.
Dans le cadre de la POO :

* Plusieurs classes filles héritant d’une même classe mère peuvent être manipulées **comme si elles étaient de la classe mère**.
* Les méthodes redéfinies s’exécutent en fonction de l’objet réel.

👉 Cela permet d’écrire du code plus **générique** et **réutilisable**.

#### Exemple en Java

```java
class Personnage {
    protected String nom;
    public Personnage(String nom) { this.nom = nom; }
    public void attaquer() {
        System.out.println(nom + " attaque avec ses poings.");
    }
}

class Guerrier extends Personnage {
    public Guerrier(String nom) { super(nom); }
    @Override
    public void attaquer() {
        System.out.println(nom + " attaque avec une épée !");
    }
}

class Mage extends Personnage {
    public Mage(String nom) { super(nom); }
    @Override
    public void attaquer() {
        System.out.println(nom + " lance un sort de feu !");
    }
}

// Exemple d'utilisation
Personnage p1 = new Guerrier("Arthas");
Personnage p2 = new Mage("Merlin");

p1.attaquer(); // Arthas attaque avec une épée !
p2.attaquer(); // Merlin lance un sort de feu !
```

#### 📝 Remarques

* On peut manipuler une **liste d’objets** de type `Personnage` et exécuter `attaquer()` sans savoir si c’est un `Guerrier` ou un `Mage`.
* Ce mécanisme repose sur la **liaison dynamique** (méthode choisie à l’exécution).
* On distingue :

  * **Polymorphisme d’héritage** (comme ci-dessus)
  * **Polymorphisme d’interface** (implémentation de contrats communs).
