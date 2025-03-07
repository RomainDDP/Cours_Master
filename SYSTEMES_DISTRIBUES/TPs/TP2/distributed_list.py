# !/usr/bin/python3
# source ./env/bin/activate

import sys
import socket
import threading

# Variables globales à nos threads
TOKEN = 0
MUTEX_TOKEN = threading.Lock() 
COND_TOKEN = threading.Condition(MUTEX_TOKEN)
FLAG_PLAYER = True
DATA_QUEUE = []

def send_to(port, data):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect(("localhost", port))
        s.send(data)

def socket_setup(port):
    # Setup de la socket d'écoute
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            s.bind(('', port))
            s.listen(10)
    
    return s

def thread_player(port):
    global FLAG_PLAYER
    global DATA_QUEUE
    global TOKEN
    my_socket = socket_setup(port)
    while True:
        clientsocket, _ = my_socket.accept()
        DATA_QUEUE.append(clientsocket.recv(1024))

        if FLAG_PLAYER is False:
            my_socket.connect(("localhost", my_displ_port))
            for move in DATA_QUEUE:
                my_socket.send(move)

            COND_TOKEN.notify() 

        if TOKEN <= 0:
            break


def thread_token(port):
    global FLAG_PLAYER
    global DATA_QUEUE
    global TOKEN
    my_socket = socket_setup(port)
    while True:
        clientsocket, _ = my_socket.accept()
        TOKEN = int(clientsocket.recv(4).decode())
        if TOKEN <= 0 : 
            break
        nb_moves = len(DATA_QUEUE)
        FLAG_PLAYER = False
        COND_TOKEN.wait()
        FLAG_PLAYER = True
        my_socket.connect(("localhost", ports_syst[(my_token_port + 1) % len(ports_syst)]))
        my_socket.sendall(str(TOKEN - nb_moves).encode())
        if TOKEN-nb_moves <= 0:
            break
        



if len(sys.argv) < 5:
    print("Usage : distributed_lists.py n id display0 display1 .. displayn-1 systemp0 systemp1 ... systempn-1")
    print("Where : \n\t-n is the number of players\n\t-id the id of the player between 0 and n-1")
    print("\t-displayX the port of the displays\n\t-systemX the port to contact other distributed applications")
    sys.exit(0)

# Récupérations des arguments de la ligne de commande
N = int(sys.argv[1])
my_id = int(sys.argv[2])
my_player_port = int(sys.argv[3])
ports_disp = [int(txt) for txt in sys.argv[4:-N]]
ports_syst = [int(txt) for txt in sys.argv[4+N:]]

my_token_port = ports_syst[my_id]
my_displ_port = ports_disp[my_id]

TOKEN = 10 * N

print(f"There is\033[33m {N} \033[0mplayers and my id is\033[33m {my_id} \033[0m")
print(f"The port used by my player is : \033[33m {my_player_port} \033[0m")
print(f"The ports of displays are : \033[33m {ports_disp} \033[0m")
print(f"The ports of others distributed systems are : \033[33m {ports_syst} \033[0m")

# Initialisation des threads et lancement de ceux-ci
token_thread = threading.Thread(target=thread_token, args=(my_token_port,))
player_thread = threading.Thread(target=thread_token, args=(my_player_port,))

token_thread.start()
player_thread.start()


token_thread.join()
player_thread.join()

print(f"Everything is done.")

