section .text

; Convert an integer to its corresponding ascii representation
; rdi -> the integer to be converted
; rsi -> a buffer where the converted string gets stored
to_ascii:
        mov rax,rdi
        mov rcx,10 ; Divisor
        xor r8,r8 ; digit counter
.divide:
        xor rdx,rdx ; reminder gets stored in rdx
        div rcx
        push rdx
        inc r8
        test rax,rax
        jnz .divide
.next_digit:
        pop rax
        add al, '0' ; convert the digit to its ascii representation
        mov [rsi],al ; mov character to buffer
        inc rsi
        dec r8
        test r8,r8
        jnz .next_digit
        ret
