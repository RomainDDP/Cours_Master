# !/usr/bin/python3
# source ./env/bin/activate

import socket
import sys
import json


def send_to(player_id, dx, dy):
    for port in ports:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((ip, port))
            data = json.dumps([player_id, dx, dy])
            s.send(data.encode())

def tuple_recv(clientsocket):
    data = ''
    while True:
        tmp = clientsocket.recv(1024)
        if tmp == b'':
            break
        data += tmp.decode()
    return json.loads(data)

def server(nb_moves):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as serversocket:
        serversocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        serversocket.bind(('', local_port))
        serversocket.listen(10) # file d'attente de connexion  

        for _ in range(nb_moves):
            clientsocket, _ = serversocket.accept()
            player_id, x, y = tuple_recv(clientsocket)
            send_to(player_id, x, y)


if len(sys.argv) < 3:
    print("Usage : server.py local_port port1 port2 port3")
    sys.exit(0)

local_port = int(sys.argv[1])
ports = [int(txt) for txt in sys.argv[2:]]
ip = "localhost"

nb_players = len(ports)
nb_moves = 10 * nb_players

print(f"The server is open...")

print(f"The server is listening on port : \033[33m {local_port} \033[0m")
print(f"The displays connected are on ports : \033[33m {ports} \033[0m")

server(nb_moves)

print(f"The server is closed...")
