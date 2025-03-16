#include <arpa/inet.h>
#include <stdio.h>
#include <unistd.h>

#include "tcp_server.h"

int startTCPServer(const char *serverIP, int serverPort, char *buffer,
                   int bufferSize) {
  int server_fd, client_socket;
  struct sockaddr_in address;
  int opt = 1;
  int addrlen = sizeof(address);

  // Create socket file descriptor
  if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
    perror("Socket failed");
    return -1;
  }

  // Set socket options
  if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt,
                 sizeof(opt))) {
    perror("Setsockopt failed");
    close(server_fd);
    return -2;
  }

  // Define address structure
  address.sin_family = AF_INET;
  address.sin_addr.s_addr = inet_addr(serverIP); // Bind to server's IP
  address.sin_port = htons(serverPort);

  // Bind socket to the specified port
  if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
    perror("Bind failed");
    close(server_fd);
    return -3;
  }

  // Listen for connections
  if (listen(server_fd, 3) < 0) {
    perror("Listen failed");
    close(server_fd);
    return -4;
  }

  // Accept a connection
  if ((client_socket = accept(server_fd, (struct sockaddr *)&address,
                              (socklen_t *)&addrlen)) < 0) {
    perror("Accept failed");
    close(server_fd);
    return -5;
  }

  // Read data from client
  read(client_socket, buffer, bufferSize);
  printf("Client: %s\n", buffer);

  // Close sockets
  close(client_socket);
  close(server_fd);

  return 0;
}
