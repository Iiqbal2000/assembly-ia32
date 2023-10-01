.section .data
    result_str: .space 10

.section .text
.global _start

_start:
    movl $1, %eax   # factorial result
    movl $3, %edi   # n value
    jmp .LOOP1

.LOOP1:
    imull %edi, %eax
    subl $1, %edi
    cmpl $1, %edi
    jg .LOOP1
    jmp .CONVERT

.CONVERT:
    leal result_str + 9, %esi
    movb $'\n', (%esi)
    movl $10, %edi
to_loop:
    xorl %edx, %edx
    divl %edi
    addl $'0', %edx
    dec %esi
    inc %ecx
    movb %dl, (%esi)
    test %eax, %eax
    jnz to_loop
    jmp .PRINT

.PRINT:
    movl $4, %eax   # use the `write` [interrupt-flavor] system call
    movl $1, %ebx   # write to stdout

    leal 1(%ecx), %edx    # salin jumlah karakter yg mau diprint ke register edx
    movl %esi, %ecx    # salin alamat memory variable factorial result

    int $0x80       # make system call
    jmp .EXIT
.EXIT:
    movl $1, %eax   # use the `_exit` [interrupt-flavor] system call
    movl $0, %ebx   # error code 0
    int $0x80       # make system call