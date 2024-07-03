# Un peu de réseau 

??? note "Source"
    - Module 3 CyberEdu : module_3_reseau_et_applicatifs.pdf


!!! info "Liaison avec le BO"
    en classe de première : <br/>
    - Architecture d’un réseau : Simuler ou mettre en oeuvre un réseau. (Le rôle des différents constituants du réseau local de l’établissement est présenté.)<br/>

## La sécurité des communications numériques
La  sécurisation  des  communications  (acheminement  des  données)  dans  un réseau local implique l’utilisation de protocoles spécifiques et la mise en œuvre d’infrastructures réseaux particulières pour segmenter (diviser) de façon logique 
et physique le réseau interne.

## Quelques définitions 

### Les sous-réseaux IP
Dans  un  réseau  local,  les  hôtes  sont  identifiés par  des  adresses  IPv4  privées constituées de 4 octets de 8 bits. Une adresse est composée d’une partie réseau, qui définit le réseau d’appartenance de l’hôte, et d’une partir hôte, qui identifie l’hôte dans son réseau. Tous les hôtes d’un même réseau peuvent communiquer entre eux : on parle de domaine de diffusion. Cependant, les hôtes appartenant à des  réseaux  différents  ne  peuvent  pas  communiquer  directement:  ils  doivent utiliser une passerelle.

### Les VLANs
Un  VLAN  (Virtual  Local  Area  Network)  décrit  un  réseau local virtuel. Son  objectif est de regrouper de façon logique et indépendante un ensemble d’hôtes. Il permet de créer des domaines de diffusion gérés par les commutateurs indépendamment 
de l’emplacement géographique où se situe le nœud. 

### Un port réseau
Un port est un point virtuel où les connexions réseau commencent et se terminent. Les ports sont basés sur des logiciels et gérés par le système d'exploitation d'un ordinateur. Chaque port est associé à un processus ou à un service spécifique.<br/>
Ce numéro ajouté est ce que l'on appelle un « numéro de port », et sert à orienter le trafic Internet lorsqu'il arrive sur un serveur. Les protocoles TCP (Transmission Control Protocol) et UDP (User Datagram Protocol) sont utilisés pour acheminer un paquet de données au processus correspondant.<br/>
Exemple de port : <br/>
>  Port 80 ou 8080 : Web (HTTP)<br/>
>  Port 443 : Web sécurisé (HTTPS)<br/>
>  Port 43 : DNS (système de noms de domaine)<br/>
>  Port 3389 : Remote Desktop Protocol (RDP)<br/>
>  port 3306 : MySqL, système de gestion de base de données<br/>
>  Port 21 : FTP (File Transfer Protocol)<br/>
>  Port 22 : Secure Shell (SSH), protocole de tunnelisation utilisé pour créer des connexions réseau sécurisées

### Les routeurs
Les routeurs (ou passerelles) sont des équipements réseaux permettant de relier différents réseaux qui n’appartiennent pas au même réseau logique afin qu’ils puissent  échanger  des  donner.  Pour  acheminer  les  données  vers  les  bons réseaux, le retour dispose d’une table de routage qui lui indique la route à suivre. Dans  un  réseau  local,  le  routeur,  par  l’intermédiaire  de  règles  de  sécurité, achemine  ou  non  les  informations  vers  différents  réseaux  internes.  Cela  permet ainsi  d’instaurer  une sécurité supplémentaire.

### DMZ (zone démilitarisée)
Une DMZ  ou zone démilitarisée est un réseau périmétrique qui protège et ajoute une couche de sécurité supplémentaire au réseau local interne d’une organisation contre le trafic non fiable.<br />
L’objectif final d’un réseau de zone démilitarisé est de permettre à une organisation d’accéder à des réseaux non fiables, tels qu’Internet, tout en s’assurant que son réseau privé ou son LAN reste sécurisé. Les organisations stockent généralement des services et ressources externes, ainsi que des serveurs pour le système de noms dedomaine (DNS), le protocole de transfert defichiers (FTP), la messagerie, le proxy, le protocole VoIP (Voice over Internet Protocol) et les serveurs Web, dans la DMZ. <br />
Ces serveurs et ressources sont isolés et bénéficient d’un accès limité au LAN afin de s’assurer qu’ils sont accessibles via Internet, mais pas le réseau LAN interne. Par conséquent, une approche DMZ rend plus difficile pour un hacker d’obtenir un accès direct aux données et aux serveurs internes d’une organisation via Internet. Une entreprise peut minimiser les vulnérabilités de son réseau local, créant ainsi un environnement sûr contre les menaces tout en garantissant que les employés peuvent communiquer efficacement et partager des informations directement via une connexion sécurisée.

## Exemple pratique de sécurisation avec un réseau simple

Prenons l’exemple d’un réseau d’entreprise « à plat ». 

^^Caractéristiques de cette entreprise :^^<br />
> - Elle fournit un site WEB de e-commerce ;<br />
> - Certains employés se connectent sur le réseau local filaire, d’autres se connectent en wifi ;<br />
> - Certains employés sont nomades et doivent donc se connecter à distance ;<br />
> - Il existe deux catégories principales d’utilisateurs : les utilisateurs « standard » et les administrateurs du S.I. ;<br />
> - Afin de fonctionner, l’entreprise possède également des serveurs internes (comptabilité, wiki, etc.) ;<br />
> - L’entreprise souhaite permettre à ses visiteurs de se connecter en wifi afin de naviguer sur internet.

![réseau simple](./data/reseauAplat.png)

Parmi les nombreuses faiblesses architecturales de ce réseau, nous pouvons identifier au moins le problème suivant :<br />

- Le réseau est directement connecté à Internet, i.e. tous les systèmes et utilisateurs et systèmes peuvent communiquer avec l’extérieur (attention aux fuites de données !) et tout Internet peut se connecter sur notre réseau interne.<br />

Corrigeons cela en implémentant un **pare-feu** en frontal qui va autoriser uniquement les flux entrants vers le serveur WEB (TCP/80 et TCP/443) et le serveur DNS (UDP/53 et TCP/53). Ainsi, Internet ne pourra plus accéder au reste du réseau interne.

![réseau parefeu frontal](./data/reseauParfeuFrontal.png)

Le pare-feu empêche – certes – la connexion directe entre internet et le réseau interne, mais :<br />
Au cas où le serveur WEB présente une vulnérabilité, un hacker présent sur Internet peut potentiellement prendre la main sur ce serveur, puis rebondir ensuite sur le réseau interne.


Nous allons donc segmenter notre réseau en différentes zones de criticité, notamment :<br />
- Une DMZ (zone démilitarisée) destinée à héberger tous les serveurs qui doivent être accessibles depuis internet, et uniquement ceux-ci. Ainsi, en cas de faille dans le serveur web, un attaquant aurait plus de difficultés pour rebondir sur le réseau interne ;<br />
- Une zone destinée aux serveurs internes de l’entreprise ;<br />
- Une zone pour les postes de travail filaires des utilisateurs ;<br />
- Une zone pour les postes de travail wifi des utilisateurs ;<br />
- Une zone pour les postes wifi des visiteurs ;<br />
- Une zone pour les postes de travail des administrateurs, car ceux-ci ont besoin d’accéder à des interfaces d’administration (RDP, SSH…).<br />

Afin que cette segmentation réseau soit efficace, nous faisons passer tous les flux (y compris internes) par un deuxième pare-feu (interne) afin que seuls les flux que nous allons configurer soient autorisés.

> on observe malheureusement souvent des réseaux segmentés mais non filtrés. Cela ne sert à rien en terme de sécurité, car toutes les zones peuvent communiquer entre-elles.

![réseau segmenté](./data/reseauSegmente.png)

On va s'arrêter là à notre niveau, mais il faudrait egalement gérer de façon plus fine le WIFI, les utilisateurs nomades, analyser le trafic entrant/sortant, ... Un vrai travail d'administrateur réseau ! :wink:

## Activité Réseau :

### Présentation

On va essayer de reproduire sous filius un schéma réseau d'une micro entreprise.<br />
Pour cela, on va placer :<br />
- Un poste client extérieur à l'entreprise<br />
- Deux serveurs, un web et un DNS dans un VLAN frontal, qui illustreras la DMZ<br />
- Un sous-réseau VLAN "Prod", qui rassemblera un serveur base de données et un serveur de fichier<br />
- Un sous-réseau "Utilisateur", avec quelques postes utilisateurs.<br />

^^Contraintes : ^^<br />
La DMZ peut atteindre le VLAN "prod"<br />
Le VLAN "utilisateur" peut atteindre le VLAn "Prod" mais ne peut pas atteindre la DMZ<br />
Le client externe peut atteindre la DMZ mais aucun autre VLAN

Pour cela, nous allons utiliser uniquement les moyens à notre disposition, c'est à dire des routeurs et des adresses IP !

### Rappel sur la notation CIDR :

Une convention de notation permet d'écrire simplement le couple d'informations Adresse IP + masque de sous-réseau : la notation CIDR.

**Exemple** : Une machine d'IP ```192.168.0.33``` avec un masque de sous-réseau ```255.255.255.0``` sera désignée par ```192.168.0.33 / 24``` en notation CIDR.

Le suffixe ```/ 24``` signifie que le masque de sous-réseau commence par  24 bits consécutifs de valeur 1 : le reste des bits (donc 8 bits) est à mis à 0.  
Autrement dit, ce masque vaut ```11111111.11111111.11111111.00000000``` , soit ```255.255.255.0```.  
De la même manière, le suffixe ```/ 16``` donnera un masque de ```11111111.11111111.00000000.00000000``` , soit ```255.255.0.0```.  
Ou encore, un suffixe ```/ 21``` donnera un masque de ```11111111.11111111.11111000.00000000``` , soit ```255.255.248.0```. 







