.data
    number: .ascii "534\n"
.set msglen, (. - number)
.section .text
.global _start

_start:
    # prologue
    pushl   %ebp
    movl    %esp, %ebp
    subl $4, %esp # allocate stack size 4 bytes
    
    # body
    movl $number, -4(%ebp) # store number string to stack
    call print
    # the exit syscall
    movl $1, %eax 
    movl $0, %ebx
    int $0x80

    # epilogue
    leave
    ret
print:
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp   # allocate 4 bytes for
    
    movl $4, %eax   # the write syscall
    movl $1, %ebx   # 1 is fd of stdout file
    movl 8(%ebp), %ecx # get number
    movl $msglen, %edx  # write 12 characters
    int $0x80

    nop
    leave
    ret