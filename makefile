compile:
	as -g number_to_ascii.s --32 -o number_to_ascii.o
	gcc -g -o number_to_ascii.elf -m32 number_to_ascii.o -nostdlib