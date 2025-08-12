%ifndef __MEMORY__
%define __MEMORY__

; memset(void *buf, int c, size_t n)
;
; - rdi: Pointer to the buffer
; - rsi: The byte which should be written to the buffer
; - rdx: The amount of bytes in the buffer which should be set to the provided byte 
memset:
        xor rcx,rcx
.loop:  mov byte [rdi + rcx * 1],sil
        inc rcx
        cmp rdx,rcx
        jne .loop
        ret


; memcpy(void *dest, const void *src, size_t n)
;
; - rdi: Pointer to a buffer which should be written to
; - rsi: Pointer to the source buffer
; - rdx: The number of bytes which should be copied
memcpy:
        xor rcx,rcx
.loop:  mov al,byte [rsi + rcx * 1]
        mov byte [rdi + rcx * 1],al
        inc rcx
        cmp rdx,rcx
        jne .loop
        ret

%endif ; __MEMORY__
