# Réseau Social

Les stagiaires d’un établissement de formation désirent développer une application Web genre réseau social appelée netAtlas. L’application permet aux membres inscrits de créer un réseau d’amis et d’échanger des contenus.

Pour devenir membre de netAtlas, un internaute doit s’inscrire lors de sa visite du site web. Lorsque l’administrateur valide l’inscription, l’internaute devient membre. Il peut alors se connecter pour réaliser les opérations suivantes : 

- chercher un membre
- inviter un membre d’être son ami
- accepter un autre membre comme ami
- refuser une invitation d’amitié
- retirer un ami de sa liste d’amis. 
- Un membre peut également publier des contenus.

Un modérateur consulte les contenus publiés par les membres et peut avertir, par un message, un membre qui publie du contenu non conforme au règlement de netAtlas. Après 3 avertissements, l’administrateur supprime le compte de ce membre.

Un membre est identifié par une adresse e-mail, un nom et un prénom. Un membre peut avoir plusieurs amis qui sont aussi membres de netAtlas. Un membre peut effectuer une publication de contenu à une date donnée. une publication concerne une ressource à publier; une ressource possède un nom et peut être soit un message, soit une photo/vidéo soit un lien vers une page web. Une photo/vidéo a en plus du nom, une taille en Mo. Un lien vers une page web a une adresse (URL).

1) Etablir le diagramme des cas d’utilisation. 

??? tip "Correction"
    ![use Case](./data/RS_useCase.png)

2) Etablir le diagramme de séquence du cas d’utilisation « Publier contenu ». 

??? tip "Correction"
    ![Diagramme de séquence](./data/RS_seq.png)

3) Etablir le diagramme de classes. 

??? tip "Correction"
    ![Diagramme de classe](./data/RS_DC.png)

On veut ajouter aux fonctionnements de netAtlas le fait que les amis d’un membre soient organisés en types d’amis : les amis peuvent être de type « Ami normal », « Amis proches », « connaissances » ou « Famille ». Une publication d’une ressource par un membre est autorisée à être consultée seulement par un type d’amis donné ; par exemples une photo est partagée uniquement avec le type d’amis « Amis proches ». 

4) Modifier le diagramme de classes pour tenir compte de ce changement. 

??? tip "Correction"
    ![Diagramme de classe](./data/RS_DC2.png)

6) Traduire ce diagramme de classe en schéma relationnel (MPD). 

??? tip "Correction"
    Le schéma relationnel :

    **Membre** (^^email^^ , nom , prenom ) <br />
    **Publication** (^^idPublication^^, datePublication, #email , #idRessource) <br />
    **Ressource** (^^idRessource^^ , nomRessource, #idType) <br />
    **ListeAmis**(email , emailAmis , DateAmitie)<br />
    **Type**(^^idType^^, nomType)


