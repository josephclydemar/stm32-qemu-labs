ASSEMBLER = arm-none-eabi-as
LINKER = arm-none-eabi-ld
ASSEMBLER_FLAGS = -mcpu=cortex-m3 -mthumb -g
LINKER_FLAGS = -T linker.ld

SOURCE_FILES = $(wildcard src/*.s)
OBJECT_FILES = $(patsubst src/%.s,build/%.o,$(SOURCE_FILES))
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

build/%.o: src/%.s
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) $< -o $@

$(TARGET_ELF): $(OBJECT_FILES)
	$(LINKER) $(LINKER_FLAGS) $^ -o $@

$(TARGET_BIN): $(TARGET_ELF)
	arm-none-eabi-objcopy -O binary $< $@

$(TARGET_IHEX): $(TARGET_ELF)
	arm-none-eabi-objcopy -O ihex $< $@

