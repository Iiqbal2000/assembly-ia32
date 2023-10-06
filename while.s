.section .data
    result_str: .space 10       # Reservasi buffer 10 bytes

.section .text
.global _start

_start:
    movl $5, %edi              # Inisialisasi n dengan 5
    cmpl $1, %edi              # Periksa jika n <= 1
    jle EXIT                   # Jika ya, lompat ke EXIT, selain itu terusin instruksi di bawahnya
while:
    subl $1, %edi              # Kurangi n dengan 1 (n = n - 1)
    movl %edi, %eax            # Salin n ke eax untuk konversi ke string

    xorl %esi, %esi            # reset esi
    leal result_str + 9, %esi  # Atur pointer ke akhir buffer
    movb $'\n', (%esi)         # Tambahkan karakter baris baru di akhir

    movl $10, %ebx             # Atur divisor untuk konversi desimal ke ASCII
convert_to_string:
    xorl %edx, %edx            # reset edx
    divl %ebx                  # EAX = EAX / EBX, EDX = EAX mod EBX
    addl $'0', %edx            # Konversi sisa ke ASCII

    dec %esi                   # Geser pointer buffer ke belakang

    movb %dl, (%esi)           # Simpan digit ke buffer
    test %eax, %eax            # Periksa apakah masih ada digit yang tersisa
    jnz convert_to_string      # Jika ya, lanjutkan loop
PRINT:
    movl $4, %eax              # syscall number for sys_write
    movl $1, %ebx              # file descriptor 1 is stdout

    movl $2, %edx              # Set panjang string menjadi 2 karakter
    movl %esi, %ecx            # Set pointer ke string

    int $0x80                  # Melakukan syscall

    cmpl $0, %edi              # perbandingan
    jg while                   # Jika edi >= 1 lompat ke while
EXIT:
    movl $1, %eax              # syscall number for sys_exit
    movl $0, %ebx              # return code 0
    int $0x80                  # Melakukan syscall
