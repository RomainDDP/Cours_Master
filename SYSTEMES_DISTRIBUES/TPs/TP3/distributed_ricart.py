# !/usr/bin/python3
# source ./env/bin/activate

import sys
import socket
import threading
import json

# Variables globales à nos threads
MAX_MOVES = 10
PLAYER_MOVES = []
END_QUEUE = []
WAIT_QUEUE = []
SYSTEM_PORT = 30_000
CLOCK = []
CRITIC_SECTION = threading.Condition()
FLAG_WAITING = False

# Message class.
class Message:
    def __init__(self, id:int, clock:int, is_done=False):
        self.id = id  
        self.clock = clock 
        self.is_done = is_done

    def clock_less_than(self, other: "Message") -> bool:
        return self.clock < other.clock

    def encode(self) -> bytes:
        data = json.dumps({
            "id" : self.id,
            "clock" : self.clock,
            "is_done" : self.is_done
        })
        return data.encode()

    @staticmethod
    def decode(msg : bytes | None) -> "Message":
        if msg is None:
            print("A problem occured with the message")
            exit()
        else:
            data = msg.decode()
            data = json.loads(data)
            return Message(data["id"], data["clock"], data["is_done"])

    def __str__(self) -> str:
        return f"id : {self.id}, clock : {self.clock}, is_done : {self.is_done}"

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

# Vérifie si le message est un OK.
def is_OK(data):
    try:
        _ = int(data.decode())
        return True
    except:
        return False


def ask_for_CS(is_done : bool) -> None:
    msg = Message(my_id, CLOCK[my_id], is_done)
    data = msg.encode()
    for other in ports_syst:
        send_to(other, data)


# ---- Definitions of the threads. ----

# Listen on the port dedicated to the player and
# put into a buffer its messages.
def thread_player(player_port):
    global PLAYER_MOVES
    global CLOCK
    global FLAG_WAITING

    player_socket = socket_setup(player_port)
    print(f"Thread listening on port {player_port} has started")

    for i in range(MAX_MOVES):
        clientsocket, _ = player_socket.accept()
        CLOCK[my_id] += 1 # Hmmmmmm
        data = clientsocket.recv(1024)

        # Entering critical section
        with CRITIC_SECTION:
            FLAG_WAITING = True
            ask_for_CS(i == MAX_MOVES-1)
            CRITIC_SECTION.wait()
            for port in ports_disp:
                send_to(port, data)
            FLAG_WAITING = False

    print(f"Thread listening on {player_port} has finished")
    player_socket.close()

# Listen on the port dedicated to the system.
# Receive messages from others systems then act accordingly.
def thread_system(system_port):
    global PLAYER_MOVES
    global FLAG_WAITING

    system_socket = socket_setup(system_port, timeout=False, timer=30.0)
    OK_count = 1

    print(f"Thread listening for the token has started")
    
    while True:
        data = listen_to(system_socket)
        CLOCK[my_id] += 1 
        
        if(is_OK(data)):
            OK_count += 1 
            if(OK_count == nb_players):
                OK_count = 1
                with CRITIC_SECTION:
                    CRITIC_SECTION.notify()
        else:
            msg = Message.decode(data)
            send_to(ports_syst[msg.id], str(0).encode())
            #if(FLAG_WAITING):
            #    if(msg.clock_less_than(CLOCK[my_id]) is False):

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
player_port = ports[nb_players+my_id]

# Ports of others systems
ports_syst = [i+SYSTEM_PORT for i in range(nb_players)]
my_syst_port = ports_syst[my_id]
ports_syst.remove(my_syst_port)

print(f"There are\033[33m {nb_players} \033[0mplayers and my id is\033[33m {my_id} \033[0m")
print(f"The port used by my player is :\033[33m {player_port} \033[0m")
print(f"The ports of displays are :\033[33m {ports_disp} \033[0m")
print(f"The ports of others distributed systems are :\033[33m {ports_syst} \033[0m")


# init of the global values : 
END_QUEUE = [False] * nb_players
CLOCK = [0] * nb_players

# Initialisation des threads et lancement de ceux-ci
thread_syst = threading.Thread(target=thread_system, args=(my_syst_port,))
thread_play = threading.Thread(target=thread_player, args=(player_port,))

thread_syst.start()
thread_play.start()

thread_syst.join()
thread_play.join()

print(f"Everything is done.")
