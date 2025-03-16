#ifndef TCP_SERVER_H
#define TCP_SERVER_H

/**
 * Starts a TCP server to listen for incoming connections and receive data.
 *
 * @param serverPort The port number on which the server will listen.
 * @param buffer A pre-allocated buffer to store the received data.
 * @param bufferSize The size of the buffer.
 * @return Returns 0 on success, or a negative value on error.
 */
int startTCPServer(const char *serverIP, int serverPort, char *buffer,
                   int bufferSize);

#endif // TCP_SERVER_H
