ASSEMBLER = nasm
LINKER = ld
ASSEMBLER_FLAGS = -f elf64
LINKER_FLAGS = -T linker.ld

SOURCE_FILES = $(wildcard src/*.s)
OBJECT_FILES = $(patsubst src/%.s,build/%.o,$(SOURCE_FILES))
TARGET_ELF = build/target.elf

.PHONY: all clean

all: $(TARGET_ELF)

clean:
	$(RM) $(wildcard build/*)

build/%.o: src/%.s
	$(ASSEMBLER) $(ASSEMBLER_FLAGS) $< -o $@

$(TARGET_ELF): $(OBJECT_FILES)
	$(LINKER) $^ $(LINKER_FLAGS) -o $@

