# Un peu de Cyber :trident:

le point de fragilité premier en matière de cyber est l'homme et ses contradictions.<br />
Tout le monde sait qu'il faut un mot de passe fort <br />
Tout le monde sait qu'il faut un mot de passe par site internet<br />

Mais l'humain etant par principe faillible, c'est rarement le cas.

## Notion de mot de passe fort

-- à compléter -- 
regles de base sur un mdp
+ règles connaissance/possession/être

Forger un mot de passe 
--> voir site de la CNIL 
+ activité préparer imitation CNIL

## Notion de mot de passe unique

-- à compléter --
I have been powned
+ coffre fort de mot de passe



## Régle d'or : ne jamais stocker un mdp en clair

--> Notion de hachage

## générer hash

??? note "Code pour générer hash"

    ```python
    import hashlib
    import json

    characters = "0123456789abcdefghijklmnopqrstuvwxyz"
    password_length = 4

    # Dictionnaire pour stocker les mots de passe générés et leurs hachages MD5
    passwords = {}

    # Fonction récursive pour générer tous les mots de passe possibles
    def generate_passwords(prefix, length):
        if length == 0:
            md5_hash = hashlib.md5(prefix.encode()).hexdigest()
            passwords[prefix] = md5_hash
            return
        for char in characters:
            generate_passwords(prefix + char, length - 1)

    # Générer les mots de passe
    generate_passwords("", password_length)

    # Enregistrer les mots de passe et leurs hachages MD5 dans un fichier JSON
    with open("passwords.json", "w") as json_file:
        json.dump(passwords, json_file, indent=4)

    print("Les mots de passe ont été générés, hachés et stockés dans le fichier 'passwords.json'.")
    ```

Le jeu de données : [json](./data/passwords.json){. target="_blank" .md-button }

## déhacher

-- à compléter --
notion de rainbowTable 

attaque par force brute 
--> complexité de l'algo

tableau des temps de crackage mdp

??? note "Code pour inverser hachage"

    ```python
    import itertools
    import hashlib
    import string

    def find_md5_hash(md5_hash, max_length=6):
        characters = string.ascii_lowercase + string.digits
        hash_length = len(md5_hash)

        for length in range(1, max_length + 1):
            for combination in itertools.product(characters, repeat=length):
                attempt = ''.join(combination)
                attempt_hash = hashlib.md5(attempt.encode()).hexdigest()[:hash_length]
                if attempt_hash == md5_hash:
                    return attempt
        return "Not found"

    md5_hash_input = input("Entrez le hachage MD5 que vous souhaitez déchiffrer : ")

    original_string = find_md5_hash(md5_hash_input)

    print(f"Le texte d'origine correspondant au hachage MD5 fourni est : {original_string}")
    ```

Mais rarement mdp unique par mot de passe

## Notion de salage

-- à compléter --
obtenir un hachage "unique" en fonction d'un site web

