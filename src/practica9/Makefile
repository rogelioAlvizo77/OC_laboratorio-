build:
	nasm -f elf32 funciones.asm -o funciones.o
	gcc -m32 -c main.c -o main.o
	gcc -m32 funciones.o main.o -no-pie -z noexecstack -o ../../bin/practica9.exe

run:
	./../../bin/practica9.exe