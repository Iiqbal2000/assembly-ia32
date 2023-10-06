.section .data
    result_str: .space 2       # Reservasi buffer 10 bytes

.section .text
.global _start

_start:
    movl $5, %edi              # variabel n
    movl $0, %esi              # variabel i
    cmpl $0, %edi
    jle EXIT

FOR_LOOP:
    movl $0, %ecx
    movl %esi, %ecx
    addl $'0', %ecx
    movl %ecx, result_str
    movb $'\n', result_str+1
PRINT:
    movl $4, %eax
    movl $1, %ebx
    
    movl $2, %edx
    leal result_str, %ecx
    int $0x80
    # body loop
    addl $1, %esi
    cmpl %esi, %edi
    jge FOR_LOOP
EXIT:
    movl $1, %eax             
    movl $0, %ebx              
    int $0x80