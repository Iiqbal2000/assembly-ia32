.section .data
    result_str: .space 10       # Reservasi buffer untuk hasil string

.section .text
.global _start

_start:
    movl $1, %eax              # Inisialisasi hasil factorial dengan 1
    movl $3, %edi              # Inisialisasi nilai n dengan 3
factorial_loop:
    imull %edi, %eax           # Hasil = Hasil * n
    subl $1, %edi              # n = n - 1
    cmpl $1, %edi              # Periksa apakah n > 1
    jg factorial_loop          # Jika ya, ulangi loop
convert_to_string:
    leal result_str + 9, %esi  # Atur pointer ke akhir buffer
    movb $'\n', (%esi)         # Menambahkan karakter baris baru di akhir
    movl $10, %edi             # Divisor untuk konversi desimal ke ASCII
decimal_conversion_loop:
    xorl %edx, %edx            # Membersihkan EDX untuk sisa pembagian
    divl %edi                  # EAX = EAX / EDI, EDX = EAX mod EDI
    addl $'0', %edx            # Konversi sisa ke ASCII
    dec %esi                   # Geser pointer buffer ke belakang
    inc %ecx                   # Tambahkan jumlah karakter yang dikonversi
    movb %dl, (%esi)           # Menyimpan digit ke buffer
    test %eax, %eax            # Periksa apakah masih ada digit yang tersisa
    jnz decimal_conversion_loop # Jika ya, ulangi loop
print_result:
    movl $4, %eax              # syscall number for sys_write
    movl $1, %ebx              # file descriptor 1 is stdout
    leal 1(%ecx), %edx         # Panjang string + 1 untuk karakter '\n'
    movl %esi, %ecx            # Set pointer ke string
    int $0x80                  # Melakukan syscall
exit:
    movl $1, %eax              # syscall number for sys_exit
    movl $0, %ebx              # return code 0
    int $0x80                  # Melakukan syscall
