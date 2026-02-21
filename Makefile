
BUILD_DIR 	= build
SRC_DIR 	= src
INCLUDE_DIR = include

AS = nasm
AS_FLAGS = -felf64 -I $(INCLUDE_DIR)
LD = ld

SRCS = $(wildcard $(SRC_DIR)/*.asm)
OBJS = $(patsubst $(SRC_DIR)/%.asm, $(BUILD_DIR)/%.o, $(SRCS))

TARGET = $(BUILD_DIR)/main

default: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $^ -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(AS) $(AS_FLAGS) -o $@ $<

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)
