.data
    msg: .ascii "Hello World\n"
.set msglen, (. - msg)
.section .text
.global _start

_start:
    movl $4, %eax   # use the `write` [interrupt-flavor] system call
    movl $1, %ebx   # write to stdout
    movl $msg, %ecx # use string "Hello World"
    movl $msglen, %edx  # write 12 characters
    int $0x80       # make system call
    
    movl $1, %eax   # use the `_exit` [interrupt-flavor] system call
    movl $0, %ebx   # error code 0
    int $0x80       # make system call
