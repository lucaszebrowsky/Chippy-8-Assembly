%ifndef __SYSCALLS__
%define __SYSCALLS__

%include "syscalls_def.inc"

; exit(int exit_code)
;
; - rdi: The exit code the program should be return
extern  exit


; open(const char *filename, int flags, umode_t mode)
;
; - rdi: The path of the file to be opened
; - rsi: The access modes (O_RDONLY, O_WRONLY, O_RDWR)
; - rdx: 
extern  open


; close(unsigned int fd)
;
; - rdi: file descriptor to the file which should be closed
extern  close


; read(unsigned int fd, char *buf, size_t count)
;
; - rdi: the file descriptor
; - rsi: pointer to the output buffer
; - rdx: number of bytes to read from the file
extern  read


; write(unsigned int fd, const char *buf, size_t count)
; 
; - rdi: the file descriptor
; - rsi: the buffer who shall be read
; - rdx: number of bytes which should be written
extern  write


; fstat(unsigned int fd, struct stat *statbuf)
;
; - rdi: the file descriptor
; - rsi: pointer to a stat buffer
extern  fstat


%endif ; __SYSCALLS__
