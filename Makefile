
default: assemble link

assemble:
	nasm -felf64 -iinclude -isrc  src/main.asm -o main.o

link:
	ld main.o -o main
