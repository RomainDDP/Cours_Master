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
  int sock = 0;
  struct sockaddr_in serv_addr;
  char *message = "Hello, Server!";
  char buffer[BUFFER_SIZE] = {0};

  // Create socket
  if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
    perror("Socket creation error");
    exit(EXIT_FAILURE);
  }

  // Define server address
  serv_addr.sin_family = AF_INET;
  serv_addr.sin_port = htons(PORT);

  // Convert IPv4 address from text to binary form
  if (inet_pton(AF_INET, "192.168.68.1", &serv_addr.sin_addr) <= 0) {
    perror("Invalid address / Address not supported");
    exit(EXIT_FAILURE);
  }

  // Connect to server
  if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
    perror("Connection failed");
    close(sock);
    exit(EXIT_FAILURE);
  }

  printf("Connected to server at 192.168.68.1:%d.\n", PORT);

  // Send message to server
  send(sock, message, strlen(message), 0);
  printf("Message sent: %s\n", message);

  // Read response from server
  read(sock, buffer, BUFFER_SIZE);
  printf("Server: %s\n", buffer);

  // Close socket
  close(sock);

  return 0;
}

#endif /* ifndef  TCPserver */
