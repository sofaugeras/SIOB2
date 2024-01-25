# Commissariat

:cop: :police_car: **Etude de cas UML :** Analyse des besoins d’un commissariat de police

Un commissariat de police fonctionne de la façon suivante. Le standard reçoit les appels téléphoniques de plaignants ou de témoins qu’il doit alors aiguiller vers la division (ou service) adéquate. Auparavant, il doit enregistrer sur ordinateur chaque appel (date, coordonnées du plaignant ou témoin, type de plainte ou témoignage). Les plaignants doivent ensuite venir vérifier puis signer leur plainte à l’accueil du commissariat. Les témoins ne sont convoqués pour compléments d’informations que si une plainte a été déposée.

Il existe essentiellement trois divisions au commissariat :

- La division des délits mineurs (vols, violence, etc.)
- La division des trafics de stupéfiants
- La division des crimes

Le commissaire répartit les missions de la journée sur les ressources dont il dispose (inspecteurs, policiers, véhicules, chiens). Une mission traite un ensemble de délits qui ont eu lieu dans la même zone géographique. Il définit l’ordre des étapes puis affecte à la mission au moins un véhicule et deux policiers. Pour toute plainte/témoignage qui relève des deux dernières divisions, au moins un inspecteur est affecté à l’affaire. Les délits liés à un trafic de stupéfiants requièrent aussi l’attribution de un ou deux chiens. Le secrétariat du commissariat doit alors enregistrer la mission et son heure de départ.

Les policiers partis en mission avec les bordereaux décrivant chaque plainte/témoignage doivent indiquer en temps réel l’état de leur mission (sur terminal portable): les arrêts et les départs aux différentes étapes ainsi que les incidents occasionnels qu’ils peuvent rencontrer (panne, retard,…). Si, au-delà d’une heure, le système n’enregistre aucun suivi de cette mission, il doit alerter le commissaire immédiatement. Celui-ci crée alors une mission de renfort dont la seule étape est la dernière rapportée par la mission qui s’est déroulée de façon anormale.

Les inspecteurs de la division des crimes doivent mener leur enquête en étroite collaboration avec un juge du tribunal d’instance. Le service des archives du commissariat les aide dans leur enquête en leur fournissant toutes les informations qu’ils trouvent en relation avec leur affaire. Une fois l’enquête terminée, les policiers, munis d’un mandat d’arrêt du juge affecté à l’affaire, procèdent à l’arrestation du ou des coupables désignés. Chaque arrestation doit alors faire l’objet d’un rapport (date, coordonnées des coupables, lieu) que les policiers doivent enregistrer sur ordinateur.

1.	Donner le diagramme des cas d’utilisation qui décrit le fonctionnement de ce commissariat de police.

2. Décrire la structure statique de ce système par un diagramme de classes (vous utiliserez la notation abrégée sans tenir compte des données, sauf si cela est indispensable à la bonne compréhension du diagramme)

^^CONSEIL :^^
Vous utiliserez le logiciel de modélisation de votre choix. Si vous ne trouvez pas la notation adéquate sur le logiciel, vous la rajouterez à la main après impression.

Pensez à utiliser toute la richesse du langage UML.


??? tip "Correction"
    ![lien vers le PDF de correction](./data/commissariat.pdf)