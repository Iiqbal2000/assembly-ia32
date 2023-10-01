.data:
    result db 0
    result_char db 0

.section .text
.global _start

_start:
    movl $1, %esi   # result
    movl $3, %edi   # n
    jmp .LOOP

.LOOP:
    imull %edi, %esi
    subl $1, %edi
    cmpl $1, %edi
    jg .LOOP
    jmp .PRINT

.PRINT:
    lea result, %edi
    movl %esi, %ecx
    movl $32, %edx
    movl $4, %eax   # use the `write` [interrupt-flavor] system call
    movl $1, %ebx   # write to stdout
    int $0x80       # make system call
    jmp .EXIT
.EXIT:
    movl $1, %eax   # use the `_exit` [interrupt-flavor] system call
    movl $0, %ebx   # error code 0
    int $0x80       # make system call