# import hashlib

# # generate new salt, hash password
# # h est le sel qui sera utilisé pour le hachage
# h = b"monsite.fr"
# # Hash du mot de passe classique sans salage
# pwd_md5 = hashlib.md5(b"secret").hexdigest()
# print(pwd_md5)
# # Hash du mot de passe classique avec salage
# pwd = hashlib.pbkdf2_hmac('md5', b"secret", h, 100000)
# print(pwd)


def read_file_and_write(filename, data_to_write):
    f = open(filename, 'r+')
    data = f.read()
    f.write(data_to_write)
    # Fichier jamais fermé explicitement
    return data

# Utilisation de la fonction
content = read_file_and_write('example.txt', 'Additional data\n')
print(content)

# Si nous essayons de lire à nouveau le fichier
with open('example.txt', 'r') as f:
    new_content = f.read()
    print(new_content)