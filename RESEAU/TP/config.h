#ifndef CONFIG_H
#define CONFIG_H

#include <stddef.h>

// Struct to hold optional parameters for TCP communication
typedef struct {
  const char
      *serverIP;  // IP address of the server (optional, defaults to localhost)
  int serverPort; // Port number of the server (optional, defaults to 8080)
  size_t bufferSize; // Size of the buffer (optional, defaults to 1024)
} config;

#endif // CONFIG_H
