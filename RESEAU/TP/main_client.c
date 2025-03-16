
#include <stdio.h>
#include <stdlib.h>

#include "config.h"
#include "file_utils.h"
#include "tcp_client.h"

int main(int argc, char *argv[]) {

  const char *IP;
  int PORT;
  const char *FILE_PATH;

  if (argc != 4) {
    printf("Default parameters in use, if you wish to configure :\n");
    printf("%s <SERVER IP> <SERVER PORT> <FILE PATH>\n", argv[0]);
    IP = "192.168.";
    PORT = 5000;
    FILE_PATH = "script.sh";

  } else {
    printf("Personalized parameters in use : \n");
    printf("Server IP adress : %s\n", argv[1]);
    printf("Server port : %s\n", argv[2]);
    printf("Selected file path : %s\n", argv[3]);
    IP = argv[1];
    PORT = atoi(argv[2]);
    FILE_PATH = argv[3];
  }

  char *fileBuffer = readFileToBuffer(FILE_PATH);
  if (fileBuffer == NULL) {
    fprintf(stderr, "Failed to read file: %s\n", FILE_PATH);
    return EXIT_FAILURE;
  }

  config clientConfig;
  clientConfig.serverIP = IP;
  clientConfig.serverPort = PORT;
  clientConfig.bufferSize = 2048;
  // Send the file data over TCP
  if (sendDataToServer(clientConfig.serverIP, clientConfig.serverPort,
                       fileBuffer) != 0) {
    fprintf(stderr, "Failed to send data to the server\n");
    free(fileBuffer);
    return EXIT_FAILURE;
  }

  // Free allocated memory and exit
  free(fileBuffer);
  return EXIT_SUCCESS;
}
