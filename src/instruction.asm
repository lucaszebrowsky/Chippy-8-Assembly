; %include "stdio.asm"
section .data

jumptable:
        dq INST_0 ; CLS,RET,SYS addr
        dq INST_1 ; JP addr
        dq INST_2 ; CALL addr
        dq INST_3
        dq INST_4
        dq INST_5
        dq INST_6
        dq INST_7
        dq INST_8
        dq INST_9
        dq INST_A
        dq INST_B
        dq INST_C
        dq INST_D
        dq INST_E
        dq INST_F

func0: db "Func0\n",NULL
func1: db "Func1\n",NULL
func2: db "Func2\n",NULL
        
section .text

INST_0:
mov rdi,func0
        call puts
        ret

INST_1:
        mov ax,0xfff
        and dx,ax ; get nnn (0x1nnn)
        ; mov pc
        mov rdi,func1
        call puts
        ret

INST_2:
mov rdi,func2
        call puts
        ret

INST_3:
        ret
INST_4:
        ret
INST_5:
        ret
INST_6:
        ret
INST_7:
        ret
INST_8:
        ret
INST_9:
        ret
INST_A:
        ret
INST_B:
        ret
INST_C:
        ret
INST_D:
        ret
INST_E:
        ret
INST_F:
        ret

