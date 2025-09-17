CHAINPREFIX ?= aarch64-linux-gnu-

COPS = -Wall -fno-stack-protector -mgeneral-regs-only -g -O0
ASMOPS = -g

BUILD_DIR = build
SRC_DIR = src

C_FILES = $(wildcard $(SRC_DIR)/*.c)
ASM_FILES = $(wildcard $(SRC_DIR)/*.S)
OBJ_FILES = $(C_FILES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%_c.o)
OBJ_FILES += $(ASM_FILES:$(SRC_DIR)/%.S=$(BUILD_DIR)/%_s.o)

all: main assembly

clean:
	rm -rf $(BUILD_DIR)

# Build command for C files
$(BUILD_DIR)/%_c.o: $(SRC_DIR)/%.c
	mkdir -p $(@D)
	$(CHAINPREFIX)gcc $(COPS) -MMD -c $< -static -o $@

# Build command for assembly files
$(BUILD_DIR)/%_s.o: $(SRC_DIR)/%.S
	$(CHAINPREFIX)gcc $(ASMOPS) -MMD -c $< -static -o $@

main: $(OBJ_FILES)
	$(CHAINPREFIX)ld -T $(SRC_DIR)/linker-qemu.ld -o $(BUILD_DIR)/main.elf $(OBJ_FILES)


