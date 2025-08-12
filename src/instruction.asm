%ifndef __INSTRUCTION__
%define __INSTRUCTION__

%include "stdio.asm"

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
        func0: db "Func0",NEWLINE,NULL
        func1: db "Func1",NEWLINE,NULL
        func2: db "Func2",NEWLINE,NULL
        func3: db "Func3",NEWLINE,NULL
        func4: db "Func4",NEWLINE,NULL
        func5: db "Func5",NEWLINE,NULL
        func6: db "Func6",NEWLINE,NULL
        func7: db "Func7",NEWLINE,NULL
        func8: db "Func8",NEWLINE,NULL
        func9: db "Func9",NEWLINE,NULL
        funcA: db "FuncA",NEWLINE,NULL
        funcB: db "FuncB",NEWLINE,NULL
        funcC: db "FuncC",NEWLINE,NULL
        funcD: db "FuncD",NEWLINE,NULL
        funcE: db "FuncE",NEWLINE,NULL
        funcF: db "FuncF",NEWLINE,NULL
        
section .text

INST_0:
        mov rdi,func0
        call puts
        ret

; Jump to address nnn
INST_1:
        mov ax,0xfff
        and dx,ax         ; get nnn (0x1nnn)
        mov [pc],dx
        mov rdi,func1
        call puts
        ret

; Call subroutine at address nnn
INST_2:
        inc byte [stp]
        ; Push the current PC onto the stack
        mov rdi,[stp]      ; stack pointer
        lea rdi,[stack + rdi]
        mov ax,[pc]
        mov [rdi],ax
        mov ax,0xfff
        and dx,ax          ; nnn
        mov [pc],dx
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
        mov al,[v_reg + rsi] ; mov v[x] into al
        cmp al,dl
        jne .no_skip
        ; skip nexp instruction
        mov rax,[pc]
        add rax,4
        mov [pc],rax
        ret    
.no_skip: ; goto next instruction
        mov rax,[pc]
        add rax,2
        mov [pc],rax
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
        ; mov ax,0xff
        ret

INST_7:
        mov rdi,func7
        call puts
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
        ret
INST_E:
        mov rdi,funcE
        call puts
        ret
INST_F:
        mov rdi,funcF
        call puts
        ret

%endif ; __INSTRUCTION__
