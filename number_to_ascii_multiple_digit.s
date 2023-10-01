.section .data
    result_str: .space 10  # Reservasi buffer untuk hasil string

.section .text
.global _start

_start:
    movl $123, %eax  # Angka untuk dikonversi
    leal result_str + 9, %edi  # Pointer ke akhir buffer
    mov $'\n', (%edi)  # Menambahkan karakter baris baru di akhir

    movl $10, %ebx  # Divisor

convert_loop:
    xorl %edx, %edx  # Membersihkan EDX untuk sisa pembagian
    divl %ebx  # EAX = EAX / EBX, EDX = EAX mod EBX
    addl $'0', %edx  # Konversi sisa ke ASCII
    dec %edi  # Menggeser pointer buffer ke belakang
    inc %ecx
    movb %dl, (%edi)  # Menyimpan digit ke buffer
    test %eax, %eax  # Mengecek apakah masih ada digit yang tersisa
    jnz convert_loop  # Jika ya, lanjutkan loop

    # Menulis string ke stdout
    movl $4, %eax  # syscall number for sys_write
    movl $1, %ebx  # file descriptor 1 is stdout

    leal 1(%ecx), %edx
    movl %edi, %ecx

    int $0x80  # Melakukan syscall

    # Keluar
    movl $1, %eax  # syscall number for sys_exit
    xorl %ebx, %ebx  # return code 0
    int $0x80  # Melakukan syscall
