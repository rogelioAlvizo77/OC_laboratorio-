%include "../../lib/pc_io.inc"

section .text
    global_start

_start: 
mov edx, msg
call puts

;insiso d
mov ebx, msg                    
mov esi, 25                     
mov byte [ebx + esi], 'Z'       


mov edx, msg
call puts

mov eax, 1
xor ebx, ebx
int 0x80

section .data
    msg db 'abcdefghijklmnopqrstuvwxyz0123456789', 0xa, 0