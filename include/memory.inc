%ifndef __MEMORY__
%define __MEMORY__


; memset(void *buf, int c, size_t n)
;
; - rdi: Pointer to the buffer
; - rsi: The byte which should be written to the buffer
; - rdx: The amount of bytes in the buffer which should be set to the provided byte 
extern memset


; memcpy(void *dest, const void *src, size_t n)
;
; - rdi: Pointer to a buffer which should be written to
; - rsi: Pointer to the source buffer
; - rdx: The number of bytes which should be copied
extern memcpy


%endif ; __MEMORY__
