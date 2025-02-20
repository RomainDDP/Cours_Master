#ifndef TCPserver
#define TCPserver

#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define PORT 8080
#define BUFFER_SIZE 1024

int main() {
  int server_fd, new_socket;
  struct sockaddr_in address;
  int opt = 1;
  int addrlen = sizeof(address);
  char buffer[BUFFER_SIZE] = {0};

  // Create socket file descriptor
  if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
    perror("Socket failed");
    exit(EXIT_FAILURE);
  }

  // Set socket options
  if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt,
                 sizeof(opt))) {
    perror("Setsockopt failed");
    close(server_fd);
    exit(EXIT_FAILURE);
  }

  // Define address structure
  address.sin_family = AF_INET;
  address.sin_addr.s_addr = inet_addr("192.168.68.1"); // Bind to server's IP
  address.sin_port = htons(PORT);

  // Bind socket to the specified port
  if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
    perror("Bind failed");
    close(server_fd);
    exit(EXIT_FAILURE);
  }

  // Listen for connections
  if (listen(server_fd, 3) < 0) {
    perror("Listen failed");
    close(server_fd);
    exit(EXIT_FAILURE);
  }

  printf("Server listening on 192.168.68.1:%d...\n", PORT);

  // Accept a connection
  if ((new_socket = accept(server_fd, (struct sockaddr *)&address,
                           (socklen_t *)&addrlen)) < 0) {
    perror("Accept failed");
    close(server_fd);
    exit(EXIT_FAILURE);
  }

  printf("Connection established with client.\n");

  // Read data from client
  read(new_socket, buffer, BUFFER_SIZE);
  printf("Client: %s\n", buffer);

  // Echo message back to client
  send(new_socket, buffer, strlen(buffer), 0);
  printf("Message echoed back to client.\n");

  // Close sockets
  close(new_socket);
  close(server_fd);

  return 0;
}

#endif /* ifndef  TCPserver */
