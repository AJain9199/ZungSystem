WORKING_DIR := $(shell pwd)
BUILD_DIR := $(WORKING_DIR)/build
INITRD_DIR := $(BUILD_DIR)/initrd
ZS_DIR := $(INITRD_DIR)/zs
RESOURCES_DIR := $(WORKING_DIR)/resources
RESOURCES_TARGET_DIR := $(ZS_DIR)/resources
LDFLAGS := -nostdlib -n -T $(WORKING_DIR)/link.ld

all: build build-img run

build:	
	Zung $(WORKING_DIR)/src/kernel.zng -o $(BUILD_DIR) -target "x86_64-elf"
	ld $(BUILD_DIR)/kernel.o $(LDFLAGS) -o $(BUILD_DIR)/kernel.elf

build-img:
	mkdir -p $(ZS_DIR)
	cp $(BUILD_DIR)/kernel.elf $(INITRD_DIR)/zs/kernel.elf
	cp -r $(RESOURCES_DIR) $(RESOURCES_TARGET_DIR)
	mkbootimg initrd.json $(BUILD_DIR)/bootpart.bin

run:
	qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -drive file=$(BUILD_DIR)/bootpart.bin

clean:
	rm -rf $(BUILD_DIR)
