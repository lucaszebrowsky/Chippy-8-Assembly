; Standard Library containing common io functions
%include "defines.asm"

section .text 

; Exit the program
exit:
        mov rax,EXIT
        mov rdi,rsi
        syscall

; open a file (readonly)
open:
        mov rax,SYS_OPEN
        mov rsi,O_RDONLY
        syscall
        ret

; Close a file
; rdi -> filedescriptor
close:
        mov rax,SYS_CLOSE
        syscall
        ret


; Read n bytes into a buffer from a given filedescriptor
; rdi -> filedescriptor
; rsi -> buffer
; rdx -> number of bytes to read
read:
        mov rax,SYS_READ
        syscall
        ret

; Get stats about a specific file. Results are stored in a struct stat buffer
; rdi -> file descriptior
; rsi -> pointer to the buffer
fstat:
        mov rax,SYS_FSTAT
        syscall
        ret

; Print a null-terminated string to stdout
; Param: rdi -> pointer to string
puts:
        xor rcx,rcx ; used to count number of characters in the string
.count:
        mov al,[rdi + rcx * 1]
        inc rcx
        cmp al,0x0
        jne .count
        mov rax,SYS_WRITE
        mov rsi,rdi ; Move the pointer to the string into rsi
        mov rdi,STDOUT
        mov rdx,rcx ; Number of bytes
        syscall
        ret
