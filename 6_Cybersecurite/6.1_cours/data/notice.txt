## Notice remplie — ss.txt

Preuve: ss.txt <br />
Collecté par: Enseignant <br />
Date/heure: 2025-09-25T10:14:30+02:00 <br />
Outil: ss -tnp (sortie simulée fournie) <br />
Localisation: /root/evidence/ss.txt (fichier fourni dans l'archive) <br />
Hash SHA256: 96b2767089a094f0d6cb21a420af0bda48a587d3468ca4589296e40ac25b74ca <br />
Commentaires: Sortie simulée montrant une connexion SSH établie entre 192.0.2.10:22 et 203.0.113.45:44528 (ESTAB). Corréler avec auth.log pour confirmer l’heure et l’utilisateur.

## Notice remplie — psaux.txt

Preuve: psaux.txt<br />
Collecté par: Enseignant <br />
Date/heure: 2025-09-25T10:14:30+02:00<br />
Outil: ps aux (sortie simulée fournie)<br />
Localisation: /root/evidence/psaux.txt (fichier fourni dans l'archive)<br />
Hash SHA256: eba68e3f48f01c16e4a4e9c5fad2fdee6ed15e25595c3e59fff81d85874a4955<br />
Commentaires: Processus sshd (PID 2051) et un shell interactif -bash (PID 2054) pour user1 observés. Indice d’une session ouverte, à mettre en relation avec ss.txt et auth.log.

## Notice remplie — lsof.txt

Preuve: lsof.txt<br />
Collecté par: Enseignant <br />
Date/heure: 2025-09-25T10:14:30+02:00<br />
Outil: lsof -i :22 (sortie simulée fournie)<br />
Localisation: /root/evidence/lsof.txt (fichier fourni dans l'archive)<br />
Hash SHA256: f348a4948777ed941e22c4bf52d6ba4d2e6daf62ed016e8d6ad86e90eae78a19<br />
Commentaires: Descripteur de fichier montrant sshd (PID 2051) avec connexion TCP 192.0.2.10:22 → 203.0.113.45:44528 (ESTABLISHED). Confirme la connexion active vue dans ss.txt.

## Notice remplie — auth.log

Preuve: auth.log<br />
Collecté par: Enseignant <br />
Date/heure: 2025-09-25T10:14:30+02:00<br />
Outil: copie de /var/log/auth.log (extrait simulé fourni)<br />
Localisation: /root/evidence/auth.log (fichier fourni dans l'archive)<br />
Hash SHA256: 3f13cfb51560d9190bb063ce7f1ccb617e28a453841dfedb8823fafe4c36a8b1<br />
Commentaires: Logs montrant plusieurs tentatives échouées pour l’utilisateur admin depuis 203.0.113.45, puis Accepted password for user1 from 203.0.113.45 port 44528 ssh2 (Sep 25 10:14:33). Corroboration temporelle de la session observée dans ss.txt et psaux.txt. Conclusion: accès probable au compte user1.

## Notice remplie — notice_template.txt 

Preuve: notice_template.txt<br />
Collecté par: Enseignant <br />
Date/heure: 2025-09-25T10:14:30+02:00<br />
Outil: modèle de notice (fourni)<br />
Localisation: /root/evidence/notice_template.txt (fichier fourni dans l'archive)<br />
Hash SHA256: 832dda7c28561fbb52f187015073fd72591ce4931b899bfc1a981b7cd93b3889<br />
Commentaires: Modèle de notice destiné à être rempli par l’enquêteur. À compléter pour chaque fichier réel avec signature/empreinte et chaîne de conservation.

