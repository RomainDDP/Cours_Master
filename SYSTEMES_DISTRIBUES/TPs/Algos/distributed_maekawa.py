# !/usr/bin/python3
# source ./env/bin/activate

import sys
import socket
import threading
import json
import enum

# global variables to the threads
SYSTEM_PORT = 30_000
MAX_PLAYER_MOVE = 10
CLOCK = 0

# Enum of messages type.
class MessageType(enum.Enum):
    DEMANDE     = 0
    ACCORD      = 1
    ECHEC       = 2
    SONDAGE     = 3
    RESTITUTION = 4
    LIBERATION  = 5


# Message class.
class Message:
    def __init__(self, id: int, time: int, type: MessageType):
        self.id = id
        self.time = time
        self.type = type

    def encode(self) -> bytes:
        data = json.dumps({
            "id": self.id,
            "port": self.time,
            "type": self.type
        })
        return data.encode()

    @staticmethod
    def decode(recv_msg: bytes | None) -> "Message":
        if recv_msg is None:
            print("A problem occured with the message")
            exit()
        else:
            data = recv_msg.decode()
            data = json.loads(data)
            return Message(data["id"], data["time"], data["type"])

    def __str__(self) -> str:
        return f"id: {self.id}, port: {self.time}, type: {self.type}"

# ---- Definitions of the functions. ----

# Setup of the listening socket. 
def socket_setup(port: int, ip='127.0.0.1', timeout=False, timer=5.0) -> socket.socket:
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        s.bind((ip, port))
        s.listen(10)

        if timeout:
            s.settimeout(timer) # Timeout to avoid waiting forever.

        return s

    except socket.error as e:
        print("\033[31mFAILURE : An error occured during the creation of the socket : \033[0m")
        print(e)
        exit()

def listen_to(target_socket:socket.socket) -> bytes | None:
    try:
        clientsocket, _ = target_socket.accept()
        data = clientsocket.recv(1024)
        return data

    except socket.timeout:
        print(f"\033[33mWARNING : {target_socket.timeout} seconds without anything sent in this system.\033[0m")
        return None 

def send_to(port: int, data:bytes) -> bool:
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect(("localhost", port))
            s.send(data)
        return True

    except socket.error as e:
        print(f"\033[33mWARNING : Cannot send anything to the target port : {port}. The connection might be closed and the program done.\033[0m")
        print(e)
        return False

def ask_CS(id, quorum):
    global CS_FLAG
    global LAST_DEM_TIME
    
    CS_FLAG = True
    LAST_DEM_TIME = CLOCK

    data = Message(id, CLOCK, MessageType.DEMANDE).encode()
    for site in quorum:
        site += SYSTEM_PORT
        send_to(site, data)


def release_CS(id, port):
    global CS_FLAG

    CS_FLAG = False
    data = Message(id, CLOCK, MessageType.LIBERATION).encode()
    send_to(port, data)

# Listen on the port dedicated to the player and
# put into a buffer its messages.
def thread_player(player_port: int, mutex: threading.Condition, id: int, quorum: list[int],
                  display_ports: list[int]) -> None:
    global CLOCK
    player_socket = socket_setup(player_port)
    print(f"Thread listening on port {player_port} has started")

    for _ in range(MAX_PLAYER_MOVE):
        clientsocket, _ = player_socket.accept()
        move = clientsocket.recv(1024)
        CLOCK += 1
        
        ask_CS(id, quorum)
        with mutex:
            mutex.wait() # Waiting for the token.
            for display in display_ports:
                send_to(display, move)

    print(f"End of the thread listening for the player.")


# TODO :
# S'occuper des demandes !
# Add a la clock apres chaque envoi.

# Receive messages from others systems then act accordingly.
def thread_system(syst_port: int, mutex: threading.Condition) -> None:
    
    global CLOCK
    global CS_FLAG
    system_socket = socket_setup(syst_port)
    accord_count = 0
    accord_sent = False
    echec_count = 0
    restitution_bool = False
    waiting_file = []

    while True:
        clientsocket, _ = system_socket.accept()
        data = clientsocket.recv(1024)
        CLOCK += 1
        recv_msg = Message.decode(data)
        sender_port = SYSTEM_PORT + recv_msg.id
        if(recv_msg == None):
            print("Message is None ???")
        
        if(CS_FLAG):
            data = Message(syst_port - SYSTEM_PORT, CLOCK, MessageType.ECHEC).encode()
            send_to(sender_port, data)
            continue

        match recv_msg.type:
            case MessageType.DEMANDE:
                waiting_file.append(recv_msg)
                if(accord_sent is False):
                    data = Message(syst_port - SYSTEM_PORT, CLOCK, MessageType.ECHEC).encode()
                    send_to(sender_port, data)
                    continue

                current = waiting_file[0].id
                waiting_file.sort(key= lambda x: x.time)

                if(current == waiting_file[0].id):
                    data = Message(syst_port - SYSTEM_PORT, CLOCK, MessageType.ECHEC).encode()
                    send_to(sender_port, data)
                    continue



            case MessageType.ACCORD:
                accord_count += 1
                restitution_bool = False

                if (accord_count = len(quorum)):
                    accord_count = 0
                    with mutex:
                        mutex.notify()

            case MessageType.SONDAGE:
                if(echec_count > 0 or restitution_bool):
                    new_msg = Message(id, CLOCK, MessageType.RESTITUTION).encode()
                    restitution_bool = True
                    send_to(sender_port, new_msg)


            case MessageType.RESTITUTION:
                new_msg = Message(id, CLOCK, MessageType.ACCORD).encode()
                port = SYSTEM_PORT + waiting_file[0].id
                send_to(port, new_msg)

                waiting_file.append(recv_msg).sort(key= lambda x: x.time)



            case MessageType.LIBERATION:
                print(f"The system {recv_msg.type} is done with its CS.")
                waiting_file.remove(recv_msg.id)

                new_msg = Message(id, CLOCK, MessageType.ACCORD).encode()
                port = SYSTEM_PORT + waiting_file[0].id
                send_to(port, new_msg)

            case MessageType.ECHEC:
                print(f"It seems another process is in CS, I have to wait.")
                echec_count += 1
 
            case _:
                print(f"Message is of no expected type : {recv_msg.type}")


def main():
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

    print(f"There are\033[33m {nb_players} \033[0mplayers and my id is\033[33m {my_id} \033[0m")
    print(f"The port used by my player is :\033[33m {player_port} \033[0m")
    print(f"The ports of displays are :\033[33m {ports_disp} \033[0m")
    print(f"The ports of distributed systems are :\033[33m {ports_syst} \033[0m")

    # Initialisation des threads et lancement de ceux-ci

    mutex = threading.Condition()

    thread_syst = threading.Thread(target=thread_system, args=(my_syst_port, mutex, nb_players))
    thread_play = threading.Thread(target=thread_player, args=(player_port, mutex, my_id, ports_disp))

    thread_syst.start()
    thread_play.start()

    thread_syst.join()
    thread_play.join()

    print(f"Everything is done.")

if __name__ == "__main__":
    main()
