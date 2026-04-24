CC = arm-none-eabi-gcc
CFLAGS = -std=c99 -Wno-main -Wall -Wextra -Werror -mcpu=cortex-m3 -mthumb -g
LFLAGS = -nostdlib -T linker.ld
INCLUDES = -I include

SOURCE_FILES = $(wildcard src/*.c)
OBJECT_FILES = $(patsubst src/%.c,build/%.o,$(SOURCE_FILES))
TARGET_ELF = build/netduino2-firmware.elf
TARGET_BIN = build/netduino2-firmware.bin
TARGET_IHEX = build/netduino2-firmware.hex

.PHONY: all clean debug run

all: $(TARGET_BIN) $(TARGET_IHEX)

clean:
	$(RM) $(wildcard build/*)

run:
	qemu-system-arm -M netduino2 -kernel $(TARGET_ELF) -S -gdb tcp::5400

debug:
	gdb-multiarch $(TARGET_ELF)

build/%.o: src/%.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(TARGET_ELF): $(OBJECT_FILES)
	$(CC) $(CFLAGS) $(INCLUDES) $^ $(LFLAGS) -o $@

$(TARGET_BIN): $(TARGET_ELF)
	arm-none-eabi-objcopy -O binary $< $@

$(TARGET_IHEX): $(TARGET_ELF)
	arm-none-eabi-objcopy -O ihex $< $@

