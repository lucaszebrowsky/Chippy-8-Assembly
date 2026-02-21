%include "stddef.inc"
%include "strings.inc"
%include "cpu.inc"

global jumptable

        section .data

jumptable:
        dq INST_0 ; CLS,RET,SYS addr
        dq INST_1 ; JP addr
        dq INST_2 ; CALL addr
        dq INST_3
        dq INST_4
        dq INST_5
        dq INST_6 ; LD V[x],kk
        dq INST_7
        dq INST_8
        dq INST_9
        dq INST_A
        dq INST_B
        dq INST_C
        dq INST_D
        dq INST_E
        dq INST_F


        section .rodata

asciizln func0, "Func0"
asciizln func1, "Func0"
asciizln func2, "Func0"
asciizln func3, "Func0"
asciizln func4, "Func0"
asciizln func5, "Func0"
asciizln func6, "Func0"
asciizln func7, "Func0"
asciizln func8, "Func0"
asciizln func9, "Func0"
asciizln funcA, "Func0"
asciizln funcB, "Func0"
asciizln funcC, "Func0"
asciizln funcD, "Func0"
asciizln funcE, "Func0"
asciizln funcF, "Func0"

        
        section .text

INST_0:
        mov rdi,func0
        call puts
        ret

; Jump to address nnn
INST_1:
        mov ax,0xfff
        and dx,ax         ; get nnn (0x1nnn)
        mov [rel pc],dx
        mov rdi,func1
        call puts
        ret

; Call subroutine at address nnn
INST_2:
        inc byte [rel stp]
        ; Push the current PC onto the stack
        mov rdi, [rel stp]      ; stack pointer
        lea rdi,[stack + rdi]
        mov ax,[rel pc]
        mov [rdi],ax
        mov ax,0xfff
        and dx,ax          ; nnn
        mov [rel pc], dx
        mov rdi,func2
        call puts
        ret

; Skip next instruction if V[x] == kk
INST_3:
        xor rsi,rsi
        push dx
        mov ax,0x0f00
        and dx,ax
        shr dx,8 ; x
        mov sil,dl ; mov x into sil
        pop dx
        mov ax,0x00ff
        and dx,ax
        ; compare v[x] and kk
        mov al,[v_reg + rsi] ; mov v[x] into al
        cmp al,dl

        mov rax,[rel pc]
        mov rcx,2
        mov rdx,4
        cmove rcx,rdx ; skip the next instruction, if v[x] == kk
        add rax,rcx
        mov [rel pc],rax
        ret    
         
INST_4:
        mov rdi,func4
        call puts
        ret

INST_5:
        mov rdi,func5
        call puts
        ret

INST_6:
        mov rdi,func6
        call puts
        xor rsi,rsi
        push dx
        mov ax,0x0f00
        and dx,ax
        shr dx,8 ; x
        mov sil,dl ; mov x into sil
        pop dx
        mov ax,0x00ff
        and dx,ax ; kk
        mov [v_reg + rsi],dl
        mov rax,[pc]
        add rax,2
        mov [rel pc],rax
        ret

INST_7:
        mov rdi,func7
        call puts
        xor rsi,rsi
        push dx
        mov ax,0x0f00
        and dx,ax
        shr dx,8 ; x
        mov sil,dl ; mov x into sil
        pop dx
        mov ax,0x00ff
        and dx,ax ; kk
        mov rax,[v_reg + rsi]
        add rax,rdx
        mov [v_reg + rsi],rax
        mov rax,[pc]
        add rax,2
        mov [pc],rax
        ret

INST_8:
        mov rdi,func8
        call puts
        ret

INST_9:
        mov rdi,func9
        call puts
        ret

; Move nnn into index register
INST_A:
        mov ax,0xfff
        and dx,ax        ; nnn in dx
        mov [i_reg],dx
        add [pc],word 2
        ret

; Set Program Counter to nnn + V[0]
INST_B:
        mov ax,0xfff
        and dx,ax        ; nnn in dx
        xor al,al
        mov al,[v_reg]   ; store V[0] in al
        mov [pc],dx      ; move nnn into pc
        add [pc],al      ; add V[0]
        ret

INST_C:
        mov rdi,funcC
        call puts
        ret
INST_D:
        mov rdi,funcD
        call puts
        mov rax,[pc]
        add rax,2
        mov [pc],rax
        ret
INST_E:
        mov rdi,funcE
        call puts
        ret
INST_F:
        mov rdi,funcF
        call puts
        ret
