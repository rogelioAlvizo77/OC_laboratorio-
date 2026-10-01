%include "../../lib/pc_io.inc"    
                                    
section .text
    global _start               
_start:
  
    mov edx, msg                
    call puts                  

    mov byte [msg], 'Z'          

    mov edx, msg               
    call puts                  

    ;end
    mov eax, 1                 
    xor ebx, ebx                ; return 0
    int 0x80                    ; fin de programa

section .data
    msg db 'abcdefghijklmnopqrstuvwxyz0123456789', 0xa, 0