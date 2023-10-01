.section .data
    msg: .space 2       # Reservasi ruang untuk 2 karakter ascii

.section .text
.global _start

_start:
    movl $5, %edi      # Pindahkan angka untuk dikonversi ke %edi
    addl $'0', %edi    # Tambahkan '0' untuk mengkonversi ke nilai ASCII

    movl %edi, msg       # Simpan karakter ASCII ke msg
    movb $'\n', msg+1  # Simpan '\n' ke msg tepat setelah karakter ASCII

    movl $4, %eax      # Gunakan syscall `write`
    movl $1, %ebx      # Tulis ke stdout
    leal msg, %ecx     # Gunakan string msg
    movl $2, %edx      # Tulis 2 karakter
    int $0x80          # Lakukan syscall

    movl $1, %eax      # Gunakan syscall `_exit`
    movl $0, %ebx      # Kode error 0
    int $0x80          # Lakukan syscall
