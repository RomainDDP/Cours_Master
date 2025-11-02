# Rendu TP Scan de vulnérabilités - Romain DUPONT DE POOTER & Ugo VALLAT

## Premiers pas avec Nessus

Après avoir lancé Nessus sur notre machine virtuelle, un scan fut lancé sur la machine utilisant Debian 11 Bullseye pour détecter les vulnérabilités de packages installés.

Celui-ci nous a permit de repérer une quantité phénoménale de packages qui étaient victime d'une vulnérabilité critique !

![Scan Nessus](vul_scan.png)

Maintenant nous pouvons mettre à jour ces packages avec la commande suivante :

`apt-get update && apt-get install -s -V <package>`

Il est aussi bon de supprimer les packages qui nous sont inutiles, par exemple __cups__ qui est le package nécessaire à l'impression et au scan de document est inutile dans le contexte de notre machine. Dans ce cas là, la commande effectuée est la suivante :

`apt-get --purge autoremove -s -V cups`

D'autres packages, par exemple __apache__, doivent être gardés et mis à jour : `apt-get install -s -V apache2`


Malheureusement, la machine virtuelle Debian possédant un problème de certificat qui ne semble pas être trivial, ne peut effectuer d'apt-get update ou install et ainsi mettre à jour les packages. Nous ne pourrons donc pas voir le résultat d'un nouveau scan avec Nessus post mis à jour des packages.

![erreur de certificats]("apt_update.png")
