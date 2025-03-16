#include <stdio.h>
#include <stdlib.h>

#include "file_utils.h"

char *readFileToBuffer(const char *filePath) {
  FILE *file = fopen(filePath, "r");
  if (file == NULL) {
    perror("Failed to open file");
    return NULL;
  }

  fseek(file, 0, SEEK_END);
  long fileSize = ftell(file);
  rewind(file);

  char *buffer = (char *)malloc((fileSize + 1) * sizeof(char));
  if (buffer == NULL) {
    perror("Failed to allocate memory");
    fclose(file);
    return NULL;
  }

  size_t bytesRead = fread(buffer, sizeof(char), fileSize, file);
  if (bytesRead < fileSize) {
    perror("Failed to read the file completely");
    free(buffer);
    fclose(file);
    return NULL;
  }

  buffer[fileSize] = '\0';
  fclose(file);
  return buffer;
}
