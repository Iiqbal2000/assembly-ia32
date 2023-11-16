/*
Compile this using:
$ as -g printf_libc.s --32 -o printf_libc.o
$ ld -m elf_i386 -dynamic-linker /usr/lib/ld-linux.so.2 -lc printf_libc.o -o printf_libc.elf
*/

.section .data
        output: .asciz "%d\n"
.section .text
.globl _start
_start:
        pushl %ebp
        movl %esp, %ebp
        subl $16, %esp
        movl $1, -16(%ebp)
        movl $5, -12(%ebp)
        
        movl -12(%ebp), %eax
        pushl %eax
        pushl $output
        call printf
        
        movl -16(%ebp), %eax
        pushl %eax
        pushl $output
        call printf

        movl $0, %eax
        call exit