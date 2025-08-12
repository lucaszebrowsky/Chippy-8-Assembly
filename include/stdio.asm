%ifndef __STDIO__
%define __STDIO__

%include "syscalls.asm"

%define SDTIN  0
%define STDOUT 1
%define STDERR 2

%define EXIT_SUCCESS 0
%define EXIT_FAILURE 1

%define O_RDONLY 0
%define O_WRONLY 1
%define O_RDWR   2

%define NULL 0
%define NEWLINE 0xA

section .text 

; exit(int exit_code)
;
; - rdi: The exit code the program should be return
exit:
        mov rax,SYS_EXIT
        syscall


; open(const char *filename, int flags, umode_t mode)
;
; - rdi: The path of the file to be opened
; - rsi: The access modes (O_RDONLY, O_WRONLY, O_RDWR)
; - rdx: 
open:
        mov rax,SYS_OPEN
        syscall
        ret


; close(unsigned int fd)
;
; - rdi: file descriptor to the file which should be closed
close:
        mov rax,SYS_CLOSE
        syscall
        ret


; read(unsigned int fd, char *buf, size_t count)
;
; - rdi: the file descriptor
; - rsi: pointer to the output buffer
; - rdx: number of bytes to read from the file
read:
        mov rax,SYS_READ
        syscall
        ret


; write(unsigned int fd, const char *buf, size_t count)
; 
; - rdi: the file descriptor
; - rsi: the buffer who shall be read
; - rdx: number of bytes which should be written
write:
        mov rax,SYS_WRITE
        syscall
        ret

; fstat(unsigned int fd, struct stat *statbuf)
;
; - rdi: the file descriptor
; - rsi: pointer to a stat buffer
fstat:
        mov rax,SYS_FSTAT
        syscall
        ret
 
%endif ; __STDIO__
