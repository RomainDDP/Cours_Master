import sys
import socket
import random
import json

def send_to(player_id, dx, dy):
    for port in ports:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((ip, port))
            data = json.dumps([player_id, dx, dy])
            s.send(data.encode())

def start_player(nb_moves):
    for _ in range(nb_moves):
        c = random.randrange(4)
        
        if c == 0:
            send_to(player_id, 0, -1)
        elif c == 1:
            send_to(player_id, 0, +1)
        elif c == 2:
            send_to(player_id, -1, 0)
        elif c == 3:
            send_to(player_id, +1, 0)
        else:
            break
        

if len(sys.argv) < 3:
    print("Usage : code.py player_id port1 port2 port3")
    sys.exit(0)

    
nb_moves = 10
player_id = int(sys.argv[1])

random.seed(42+player_id)

ports = [int(txt) for txt in sys.argv[2:]]
ip = "localhost"


start_player(nb_moves)
