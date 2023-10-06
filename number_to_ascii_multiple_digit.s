.section .data
    result_str: .space 10  # Reservasi buffer untuk menyimpan hasil string

.section .text
.global _start

_start:
    movl $123, %eax  # Angka yg akan dikonversi
    leal result_str + 9, %edi  # Pointer ke akhir buffer untuk meletakkan '\n'
    mov $'\n', (%edi)  # Menambahkan karakter '\n'

    movl $10, %ebx  # 10 adalah pembagi untuk merubah number ke ascii

convert_loop:
    xorl %edx, %edx  # Reset EDX
    divl %ebx  # EAX = EAX / EBX, EDX = EAX mod EBX
    addl $'0', %edx  # Konversi sisa ke ASCII
    dec %edi  # Menggeser pointer buffer ke belakang
    inc %ecx  # ecx untuk menghitung jumlah karakter
    movb %dl, (%edi)  # Menyimpan digit ke buffer
    test %eax, %eax  # Mengecek apakah masih ada digit yang tersisa
    jnz convert_loop  # Jika ya, lanjutkan loop

    # Menulis string ke stdout
    movl $4, %eax  # syscall number for sys_write
    movl $1, %ebx  # file descriptor untuk stdout

    leal 1(%ecx), %edx  # salin panjang karakter yg akan ditulis
    movl %edi, %ecx # salin alamat buffer ke ecx agar bisa ditulis

    int $0x80  # Melakukan syscall

    # Keluar
    movl $1, %eax  # syscall number for sys_exit
    xorl %ebx, %ebx  # return code 0
    int $0x80  # Melakukan syscall
