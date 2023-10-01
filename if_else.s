.data
    msg_false: .ascii "false\n"
.set msg_false_len, (. - msg_false)
msg_true: .ascii "true\n"
.set msg_true_len, (. - msg_true)

.section .text
.global _start

# 1 > 5 -> false
_start:
    movl $10, %esi
    cmpl $5, %esi
    jle .FALSE  # jump to label false if operand1 < operand2 from cmpl instruction
    jg .TRUE

.TRUE:
    movl $msg_true, %ecx 
    movl $msg_true_len, %edx
    jmp .PRINT

.FALSE:
    movl $msg_false, %ecx 
    movl $msg_false_len, %edx
    jmp .PRINT

.PRINT:
    movl $4, %eax   # use the `write` [interrupt-flavor] system call
    movl $1, %ebx   # write to stdout
    int $0x80       # make system call
    jmp .EXIT
.EXIT:
    movl $1, %eax   # use the `_exit` [interrupt-flavor] system call
    movl $0, %ebx   # error code 0
    int $0x80       # make system call
