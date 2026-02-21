global memset
global memcpy

        section .text

memset:
        xor rcx, rcx
.loop:  mov byte [rdi + rcx * 1], sil
        inc rcx
        cmp rdx, rcx
        jne .loop
        ret

memcpy:
        xor rcx, rcx
.loop:  mov al, byte [rsi + rcx * 1]
        mov byte [rdi + rcx * 1], al
        inc rcx
        cmp rdx, rcx
        jne .loop
        ret

