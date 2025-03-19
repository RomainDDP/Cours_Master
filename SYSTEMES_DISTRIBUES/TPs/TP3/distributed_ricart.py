# !/usr/bin/python3
# source ./env/bin/activate

import sys
import socket
import threading

# Variables globales à nos threads
MAX_MOVES = 10
PLAYER_MOVES = []
END_QUEUE = []
SYSTEM_PORT = 30_000
CLOCK = []
CRITIC_SECTION = threading.Condition()

# Message class.
class Message:
    def __init__(self, id:int, clock:int, is_done=False):
        self.id = id  
        self.clock = clock 
        self.is_done = is_done

    def compare_clock(self, other: "Message") -> bool:
        return self.clock < other.clock


# ---- Definitions of the functions. ----

# Setup de la socket d'écoute
def socket_setup(port:int, ip='127.0.0.1', timeout=False, timer=5.0) -> socket.socket:
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        s.bind((ip, port))
        s.listen(10)
        if timeout:
            s.settimeout(timer) # timeout, la socket arrête d'écouter.

        return s
    except socket.error as e:
        print("\033[31mAn error occured during the setup of the socket : \033[0m")
        print(e)
        exit()

# Decode the data to know if its the token or something else.
# Return True if it is the token, False if not.
def decode_data(data:bytes) -> Message | None:
    pass


def listen_to(target_socket:socket.socket) -> bytes | None:
    try:
        clientsocket, _ = target_socket.accept()
        data = clientsocket.recv(1024)
        return data
    except socket.timeout:
        print(f"\033[33m30 seconds without token in system n°{my_id}.\033[0m")
        return None 


def send_to(port:int, data:bytes) -> bool:
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect(("localhost", port))
            s.send(data)
        return True
    
    except socket.error as e:
        print(f"Cannot send anything to the target port : {port}. The connection might be closed and the program done.")
        print(e)
        return False


# ---- Definitions of the threads. ----

# Listen on the port dedicated to the player and
# put into a buffer its messages.
def thread_player(player_port):
    global PLAYER_MOVES

    player_socket = socket_setup(player_port)
    print(f"Thread listening on port {player_port} has started")

    for _ in range(MAX_MOVES):
        clientsocket, _ = player_socket.accept()
        data = clientsocket.recv(1024)
        PLAYER_MOVES.append(data)
        

    print(f"Thread listening on {player_port} has finished")
    player_socket.close()

# Listen on the port dedicated to the system.
# Receive messages from others systems then act accordingly.
def thread_system(system_port):
    global PLAYER_MOVES

    next_syst_port = SYSTEM_PORT + ((my_id+1) % nb_players)
    system_socket = socket_setup(system_port, timeout=True, timer=30.0)
    
    print(f"Thread listening for the token has started")
    

    while True:
        data = listen_to(system_socket)
        
     
    print(f"Thread listening for the token has finished")
    system_socket.close()        

if len(sys.argv) < 5 or len(sys.argv) % 2 != 1:
    print("Usage : distributed_lists.py n id display0 display1 .. displayn-1 systemp0 systemp1 ... systempn-1")
    print("Where : \n\t-n is the number of players\n\t-id the id of the player between 0 and n-1")
    print("\t-displayX the port of the displays\n\t-systemX the port to contact other distributed applications")
    sys.exit(0)

# Processing of the arguments 
nb_players = int(sys.argv[1])
my_id = int(sys.argv[2])

ports = [int(txt) for txt in sys.argv[3:]]
ports_disp = ports[:nb_players]

# Port used by this system player
player_port = ports[my_id]

# Ports of others systems
ports_syst = [i+SYSTEM_PORT for i in range(nb_players)]
my_syst_port = ports_syst[my_id]
ports_syst.remove(my_syst_port)

print(f"There are\033[33m {nb_players} \033[0mplayers and my id is\033[33m {my_id} \033[0m")
print(f"The port used by my player is :\033[33m {player_port} \033[0m")
print(f"The ports of displays are :\033[33m {ports_disp} \033[0m")
print(f"The ports of others distributed systems are :\033[33m {ports_syst} \033[0m")

# Initialisation des threads et lancement de ceux-ci
thread_syst = threading.Thread(target=thread_system, args=(my_syst_port,))
thread_play = threading.Thread(target=thread_player, args=(player_port,))

thread_syst.start()
thread_play.start()

thread_syst.join()
thread_play.join()

print(f"Everything is done.")
