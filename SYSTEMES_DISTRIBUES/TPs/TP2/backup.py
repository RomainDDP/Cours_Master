def thread_(th_player_port):
    exit()
    global FLAG_PLAYER
    global PLAYER_DATA_QUEUE
    global MAX_MOVES
    global TOKEN

    OTHERS_DATA_QUEUE = []
    player_socket = socket_setup(th_player_port, timeout=True)
    print(f"Player Thread listening on port {th_player_port}")

    while True:
        try:
            clientsocket, clientaddr = player_socket.accept()
            clientport = clientaddr[1]
            data = clientsocket.recv(1024)

            print(f"CLIENT PORT : {clientport}")
            if clientport - SEND_PORT >= 0 and clientport - SEND_PORT < nb_players:
                OTHERS_DATA_QUEUE.append(data)
            else:
                PLAYER_DATA_QUEUE.append(data)
            print("I received data !")
        except socket.timeout:
            #print(f"5 seconds without seeing the data in n°{my_id}... The player might be done, or slow.")
        
            if MAX_MOVES <= 0:
                break

        if FLAG_TOKEN is True: # J'ai le token !
            #print(f"I'm sending my data...")
            FULL_DATA_QUEUE = PLAYER_DATA_QUEUE + OTHERS_DATA_QUEUE
            OTHERS_DATA_QUEUE = []
            for move in FULL_DATA_QUEUE:
                MAX_MOVES -= 1
                send_to(my_displ_port, move) # J'envoie au display
                print(f"I sent data !!!!!!")
            
            print(f"Data transmitted.")
            # J'ai fini d'envoyer tous les moves au display, je passe le token
            with COND_TOKEN:
                COND_TOKEN.notify()
            
        if MAX_MOVES <= 0:
            break
    
    # Le thread se termine
    print(f"END THREAD PLAYER")
    player_socket.close()

def thread_token(th_token_port):
    exit()
    global FLAG_TOKEN
    global DATA_QUEUE
    global MAX_MOVES
    global TOKEN

    with COND_TOKEN:
        print(f"Token Thread listening on port {th_token_port}")
        token_socket = socket_setup(th_token_port)
        next_token_port = RECV_PORT + ((my_id+1) % nb_players)
        
        # Lance le token
        if my_id == 0:
            send_to(next_token_port, str(TOKEN).encode())
            print(f"Token launched.")

        while True:
            clientsocket, _ = token_socket.accept()
            TOKEN = int(clientsocket.recv(1024).decode()) # J'ai reçu le token !
            print(f"Token received = {TOKEN}")
            if MAX_MOVES <= 0 : # max moves à 0, je transmet et je m'arrête
                send_to(next_token_port, str(0).encode())
                break
            
            FLAG_TOKEN = True
            with COND_TOKEN:
                #print(f"J'attends d'être libéré par Thread Player...")
                COND_TOKEN.wait() # Je préviens le Thread player que le token est arrivé et j'attends qu'il me libère.
            FLAG_TOKEN = False
            
            send_to(next_token_port, str(TOKEN).encode())
            print(f"Token sent. Sending my player moves too.")
            for move in PLAYER_DATA_QUEUE:
                for i in range(nb_players): # J'envoie aux autres !
                    if i != my_id:
                        print(f"ICI {RECV_PORT + 1 }")
                        send_to(RECV_PORT + i, move)
            
            if MAX_MOVES <= 0:
                break
    
    print(f"END THREAD TOKEN")
    token_socket.close()


