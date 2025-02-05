# source ./env/bin/activate

import curses
from curses import wrapper
import sys
import socket
import json

# Envoi son id et son mouvement au serveur sur port
def send_to(player_id, dx, dy):
    for port in ports:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((ip, port))
            data = json.dumps([player_id, dx, dy])
            s.send(data.encode())

def main(stdscr):
    for _ in range(nb_moves):
        c = stdscr.getch()

        if c == curses.KEY_UP:
            send_to(player_id, 0, -1)
        elif c == curses.KEY_DOWN:
            send_to(player_id, 0, +1)
        elif c == curses.KEY_LEFT:
            send_to(player_id, -1, 0)
        elif c == curses.KEY_RIGHT:
            send_to(player_id, +1, 0)
        else:
            break

if len(sys.argv) < 3:
    print("Usage : code.py player_id port1 port2 port3")
    sys.exit(0)

nb_moves = 10
player_id = int(sys.argv[1])
ports = [int(txt) for txt in sys.argv[2:]]
ip = "localhost"


wrapper(main)

