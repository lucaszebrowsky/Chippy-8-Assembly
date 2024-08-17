section .text

; Add 2 integers 
add:
        push rax
        mov rax,rsi
        add rax,rdi
        ret

; Subtract 2 integers
subtract:
        push rax
        mov rax,rsi
        sub rax,rdi
        ret
