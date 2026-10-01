%include "../../lib/pc_io.inc"  
                        

section .text
    global _start              

_start:
    mov edx, msg               
    call puts       
    
    mov ebx, msg
    add ebx, 23                     
    mov byte [ebx], 'X'             

    mov edx, msg               
    call puts                   

   
    mov eax, 1                  ; llamada sys_exit
    xor ebx, ebx                ; return 0
    int 0x80                    ; fin de programa

section .data
    msg db 'abcdefghijklmnopqrstuvwxyz0123456789', 0xa, 0