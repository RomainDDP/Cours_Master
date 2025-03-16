#include "tcp_client.h"
#include <arpa/inet.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

/**
 * create a socket and send data to a TCP server
 *
 * @param serverIP The IP adress of the TCP server.
 * @param serverPort The port number on which the server will listen.
 * @param data Data which will be sent to the server.
 * @return Returns 0 on success, or a negative value on error.
 */
int sendDataOverTCP(const char *serverIP, int serverPort, const char *data) {
  int sock = socket(AF_INET, SOCK_STREAM, 0);
  if (sock < 0) {
    perror("Socket creation failed");
    return -1;
  }

  struct sockaddr_in serverAddr;
  memset(&serverAddr, 0, sizeof(serverAddr));
  serverAddr.sin_family = AF_INET;
  serverAddr.sin_port = htons(serverPort);
  if (inet_pton(AF_INET, serverIP, &serverAddr.sin_addr) <= 0) {
    perror("Invalid address or address not supported");
    close(sock);
    return -2;
  }

  if (connect(sock, (struct sockaddr *)&serverAddr, sizeof(serverAddr)) < 0) {
    perror("Connection failed");
    close(sock);
    return -3;
  }

  if (send(sock, data, strlen(data), 0) < 0) {
    perror("Failed to send data");
    close(sock);
    return -4;
  }

  close(sock);
  return 0;
}
