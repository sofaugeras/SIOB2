import hashlib

# generate new salt, hash password
# h est le sel qui sera utilisé pour le hachage
h = b"monsite.fr"
# Hash du mot de passe classique sans salage
pwd_md5 = hashlib.md5(b"secret").hexdigest()
print(pwd_md5)
# Hash du mot de passe classique avec salage
pwd = hashlib.pbkdf2_hmac('md5', b"secret", h, 100000)
print(pwd)