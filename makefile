compile:
	as -g foor_loop.s --32 -o foor_loop.o
	gcc -g -o foor_loop.elf -m32 foor_loop.o -nostdlib