.global _start
.section .text

_start:
    pushl   %ebp
    movl    %esp, %ebp
    subl    $16, %esp
    movb    $12, -1(%ebp)
    movsbl  -1(%ebp), %edx
    movl    -8(%ebp), %eax
    movl    %edx, (%eax)
    movl    $0, %eax
    leave
    ret
