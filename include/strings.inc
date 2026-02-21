%ifndef __STRINGS__
%define __STRINGS__

%include "stddef.inc"


; Creates a raw ASCII string with the provided label
%macro ascii 2+
%1:        db %2
%1_len:    equ $ - %1
%endmacro


; Creates a null-terminated ASCII string with the provided label
%macro asciiz 2+
%1:        db %2, NULL
%1_len:    equ $ - %1 - 1
%endmacro


; Creates a null-terminated ASCII string with a newline at the end
%macro asciizln 2+
%1:        db %2, NEWLINE, NULL
%1_len:    equ $ - %1 - 1
%endmacro


; strlen(char *str)
;
; - rdi: Pointer to a NULL terminated string
extern strlen


; puts(char *str)
;
; - rdi: Pointer to a NULL terminated string
extern puts


; Convert an integer to its corresponding ascii representation
; rdi -> the integer to be converted
; rsi -> a buffer where the converted string gets stored
extern to_ascii


%endif ; __STRINGS__
