CC = arm-none-eabi-gcc
CFLAGS = -std=c99 -Wall -Wextra -Werror -mcpu=cortex-m4 -mthumb -O3
LFLAGS = -nostdlib -T linker.ld

SOURCES = startup.c
TARGET_ELF = stm32f401re-firmware.elf

.PHONY: all clean run

all:
	$(CC) $(CFLAGS) $(LFLAGS) $(SOURCES) -o $(TARGET_ELF)

clean:
	$(RM) $(TARGET_ELF)

run:
	qemu-system-arm -nographic -M netduino2 -kernel $(TARGET_ELF)
