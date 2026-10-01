%include "../../lib/pc_io.inc"

section .text
    global_start

_start: 
mov edx, msg
call puts

mov ebx, msg
mov byte [ebx+26], '@' 

mov edx, msg
call puts

mov eax, 1
xor ebx, ebx
int 0x80

section .data
    msg db 'abcdefghijklmnopqrstuvwxyz0123456789', 0xa, 0