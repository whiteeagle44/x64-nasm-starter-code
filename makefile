CC=gcc
ASMBIN=nasm
ASM_SRC=functions

all: assemble compile link

assemble: $(ASM_SRC).asm
	$(ASMBIN) -o $(ASM_SRC).o -f elf64 -g -l $(ASM_SRC).lst $(ASM_SRC).asm

compile: assemble main.c
	$(CC) -m64 -c -g -O0 main.c

link: compile
	$(CC) -m64 -g -o program main.o $(ASM_SRC).o

clean:
	rm *.o
	rm main
	rm $(ASM_SRC).lst

