%include "stddef.inc"
%include "syscalls_def.inc"

global exit
global open
global close
global read
global write
global fstat

        section .text 

exit:
        mov rax,SYS_EXIT
        syscall


open:
        mov rax,SYS_OPEN
        syscall
        ret


close:
        mov rax,SYS_CLOSE
        syscall
        ret


read:
        mov rax,SYS_READ
        syscall
        ret


write:
        mov rax,SYS_WRITE
        syscall
        ret

fstat:
        mov rax,SYS_FSTAT
        syscall
        ret

