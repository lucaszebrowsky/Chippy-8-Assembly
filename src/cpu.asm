%include "memory.inc"
%include "syscalls.inc"

global memory
global v_reg
global i_reg
global pc
global stack
global stp
global dt
global st
global display
global x
global y
global kk
global nnn

global init_cpu
global copy_rom
global step


        section .bss

memory:       resb 4096
v_reg:        resb 16
i_reg:        resw 1
pc:           resw 1
stack:        resw 16
stp:          resb 1
dt:           resb 1        ; delay timer
st:           resb 1        ; sound timer
display:      resb 2048     ; 64x32 screen
x:            resb 1
y:            resb 1
kk:           resb 1
nnn:          resw 1


        section .rodata

fonts:  db 0xF0, 0x90, 0x90, 0x90, 0xF0 
        db 0x20, 0x60, 0x20, 0x20, 0x70
        db 0xF0, 0x10, 0xF0, 0x80, 0xF0
        db 0xF0, 0x10, 0xF0, 0x10, 0xF0
        db 0x90, 0x90, 0xF0, 0x10, 0x10
        db 0xF0, 0x80, 0xF0, 0x10, 0xF0
        db 0xF0, 0x80, 0xF0, 0x90, 0xF0
        db 0xF0, 0x10, 0x20, 0x40, 0x40
        db 0xF0, 0x90, 0xF0, 0x90, 0xF0
        db 0xF0, 0x90, 0xF0, 0x10, 0xF0
        db 0xF0, 0x90, 0xF0, 0x90, 0x90
        db 0xE0, 0x90, 0xE0, 0x90, 0xE0
        db 0xF0, 0x80, 0x80, 0x80, 0xF0
        db 0xE0, 0x90, 0x90, 0x90, 0xE0
        db 0xF0, 0x80, 0xF0, 0x80, 0xF0
        db 0xF0, 0x80, 0xF0, 0x80, 0x80


        section .text

init_cpu:
        mov ax, 0x200
        mov [rel pc], ax
        mov al,60
        mov [rel dt],al
        mov [rel dt],al
        ; Copy fonts into memory
        mov rdi,memory
        mov rsi,fonts
        mov rdx,80
        call memcpy
        ret


copy_rom:
        ; program code starts at 0x200
        lea rsi,[memory + 0x200]
        ; Count already in rdx
        call read
        test rax,rax ; read returns -1 on failure
        ret
       

step:   movzx rax, word [pc]
        add rax, memory
        movzx rax, word [rax]
        ; Chip 8 is big endian, while most x64 CPUs are little endian
        ; so we need to swap the bytes around
        rol ax,8
        ret
