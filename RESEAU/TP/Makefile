# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -pedantic -std=c11 -g

# Directories
SRC_DIR = src
BUILD_DIR = build
BIN_DIR = bin

# Output binaries
CLIENT_TARGET = $(BIN_DIR)/tcp_client
SERVER_TARGET = $(BIN_DIR)/tcp_server

# Source files
COMMON_SRCS = $(SRC_DIR)/file_utils.c
CLIENT_SRCS = $(SRC_DIR)/tcp_client.c $(SRC_DIR)/main_client.c
SERVER_SRCS = $(SRC_DIR)/tcp_server.c $(SRC_DIR)/main_server.c

# Object files
COMMON_OBJS = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(COMMON_SRCS))
CLIENT_OBJS = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(CLIENT_SRCS))
SERVER_OBJS = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SERVER_SRCS))

# Header dependencies
DEPS = $(wildcard $(SRC_DIR)/*.h)

# Create necessary directories
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Default target
all: directories $(CLIENT_TARGET) $(SERVER_TARGET)

# Build client
$(CLIENT_TARGET): $(COMMON_OBJS) $(CLIENT_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Build server
$(SERVER_TARGET): $(COMMON_OBJS) $(SERVER_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(DEPS) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Create directories if they don't exist
directories: $(BUILD_DIR) $(BIN_DIR)

# Clean target
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

# Phony targets
.PHONY: all clean directories

