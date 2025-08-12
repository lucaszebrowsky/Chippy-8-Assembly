default: assemble link

assemble:
	nasm -felf64 -I include -I src src/main.asm -o main.o

link:
	ld main.o -o main
