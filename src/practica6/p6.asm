%include "../../lib/pc_io.inc"   ; incluir declaraciones de procedimiento externos

section .data
    bskey equ 0x7F
    lencadena equ 255
    ln equ 0x0A
    nline db ln,0
    msg1 db ln,'Captura: ', 0
    msg2 db ln,'Minusculas: ', 0
    msg3 db ln, 'Mayusculas', 0

section .bss
    cadena resb lencadena

section .text
    global _start         ; referencia para inicio de programa
    
_start:   
   
    ; --- IMPRIMIR CADENA  ---
    mov edx, msg1        
    call puts   

    mov  edx, cadena
    mov ax, lencadena
    call captura   

    ; --- minusculas ---
    mov edx, cadena
    call minusculas
    mov edx, msg2
    call puts 
    mov edx, cadena
    call puts 

    ; --- mayusculas ---
    mov edx, cadena
    call mayusculas
    mov edx, msg3
    call puts 
    mov edx, cadena
    call puts

    ; fin del programa
    mov edx, nline 
    call puts 
    mov eax, 1
    xor ebx, ebx 
    int 0x80
   
    captura:
    push eax
    push ebx
    push ecx
    push edx
    movzx ebx, ax
    dec ebx ;reservar 1 lugar pal caracter nulo 
    xor ecx, ecx ;ecx = caracteres capturados

.ciclo: 
    call getch 
    cmp al, ln
    je  .fin 
    cmp al, 0x0D
    je .fin 
    cmp al, bskey
    jne .normal 
    cmp ecx, 0
    je .ciclo
    dec edx 
    dec ecx
    call borrar 
    jmp .ciclo

.normal:
    cmp ecx, ebx ;si el bufer esta lleno ignora la tecla
    jae .ciclo
    mov [edx], al
    inc edx
    inc ecx
    call putchar
    jmp .ciclo

.fin: 
    mov byte [edx], 0  ;caracter nulo 
    pop edx 
    pop ecx 
    pop ebx 
    pop eax
    ret

    borrar:
        push ax 
        mov al,0x8
        call putchar    
        mov al,' '
        call putchar
        mov al,0x8
        call putchar   
        pop ax
        ret 

minusculas: 
    push eax
    push edx
.ciclo: 
    mov al, [edx]
    cmp al, 0
    je .fin
    cmp al, 'A' 
    jb .sig
    cmp al, 'Z'
    ja .sig
    add al, 0x20
    mov [edx], al
.sig:
    inc edx
    jmp .ciclo
.fin:
    pop edx
    pop eax
    ret

mayusculas: 
    push eax
    push edx
.ciclo:
    mov al, [edx]
    cmp al, 0
    je .fin
    cmp al, 'a'
    jb .sig
    cmp al, 'z'
    ja .sig
    sub al, 0x20
    mov [edx], al
.sig:
    inc edx
    jmp .ciclo
.fin:
    pop edx
    pop eax
    ret
