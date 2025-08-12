%include "stdio.asm"
%include "strings.asm"
%include "cpu.asm"
%include "instruction.asm"

; Note to self:
; Calling convention: rdi,rsi,rdx,rcx,r8,r9

section .rodata
        cpu_init_str: db "CPU initialized.",NEWLINE,NULL
        usage_str: db " <path to rom>",NEWLINE,NULL
        file_open_error_str: db "Failed to open ROM!",NEWLINE,NULL
        file_size_error_str: db "ROM exceeds memory size!",NEWLINE,NULL
        file_fstat_error_str: db "fstat failed!",NEWLINE,NULL
        file_read_error_str: db "Failed to read the ROM into memory!",NEWLINE,NULL


section .bss
        statbuffer: resb 144


section .text

global _start

_start:
        ; Check if a ROM path was provided
        ; This is not C, arguments are not given via rdi,rsi,
        ; but they are on the stack (rsp = argc, rsp + 8, argv[0], rsp + 16 = argv[1])
        mov rdi,[rsp] 
        cmp rdi,2 ; argc
        jne arg_error
               
open_rom:
        mov rdi, [rsp + 16]        ; argv[1]
        mov rsi,O_RDONLY
        call open
        test rax,rax               ; check if rax contains a negative number
        js file_opening_failure
        mov rdi,rax                ; fd now in rdi

        ; Check if the size of the provided ROM does not exceed the memory limit
        call check_file_size
     
init:
        ; Copy the ROM into memory
        call copy_rom
        ; close the file
        call close
        call init_cpu
        mov rdi,cpu_init_str
        call puts

run:
        ; Fetch the next opcode (16bit)
        xor rax,rax
        mov rdi,[pc]
        mov ax,[memory + rdi]
        ; Chip 8 is big endian, while most x64 CPUs are little endian
        ; so we need to swap the bytes around
        xor ah,al
        xor al,ah
        xor ah,al

        mov dx,ax ; make a copy of the original opcode
        ; Get the most significant nibble of the opcode
        ; which tells us what instruction to execute next
        ; example: 0x1234 >> 12 = 0x1 -> JP 0x234
        shr ax,12
        ; Calculate the address of the function 
        ; which corresponds to the opcode
        lea rdi,[jumptable + rax * 8]
        call [rdi]
        jmp run
        
; exit(EXIT_SUCCESS)
        mov rsi,EXIT_SUCCESS
        call exit

check_file_size:
        mov rsi,statbuffer
        call fstat
        js fstat_failed
        mov rax,0x1000
        sub rax,0x200                ; Max ROM size 4096 - 512
        mov rdx,[statbuffer + 48]
        cmp rax,rdx                  ; check that the memory size is bigger than the ROM
        jl file_size_error
        ret

; Error Routines

; invalid_number_of_arguments:
arg_error:
        mov rdi,[rsp + 8]        ; argv[0]
        call puts
        mov rdi,usage_str
        jmp error_and_exit
     
file_opening_failure:
        mov rdi,file_open_error_str
        jmp error_and_exit
        
file_size_error:
        call close        ; make sure to close the file first
        mov rdi,file_size_error_str
        jmp error_and_exit

fstat_failed:
        call close        ; make sure to close the file first
        mov rdi,file_fstat_error_str
        jmp error_and_exit

read_error:
        call close
        mov rdi,file_read_error_str
        jmp error_and_exit

error_and_exit:
        call puts
        mov rdi,EXIT_FAILURE
        call exit
   
