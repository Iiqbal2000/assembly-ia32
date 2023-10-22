compile:
	as -g procedure_hello.s --32 -o procedure_hello.o
	gcc -g -o procedure_hello.elf -m32 procedure_hello.o -nostdlib