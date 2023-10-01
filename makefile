compile:
	as -g do_while.s --32 -o do_while.o
	gcc -g -o do_while.elf -m32 do_while.o -nostdlib