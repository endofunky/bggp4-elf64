TARGET ?= elf64
NASM ?= nasm

all: $(TARGET)
.PHONY: all

$(TARGET): elf64.asm
	$(NASM) -f bin -o $(TARGET) $<
	chmod +x $(TARGET)

run: $(TARGET)
	rm -f ./4
	@$(PWD)/$(TARGET)
.PHONY: run

clean:
	rm -f $(TARGET)
.PHONY: clean
