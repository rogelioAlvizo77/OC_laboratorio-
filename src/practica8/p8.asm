extern canonical_off
extern canonical_on

bskey       equ 0x7F            ; Backspace en la terminal (algunas envían 8)

section .data
    msg_prompt  db "Escribe una cadena: ", 0
    msg_orig    db "Original:    ", 0
    msg_may     db "Mayusculas:  ", 0
    msg_min     db "Minusculas:  ", 0
    salto       db 10, 0

section .bss
    cadena      resb 64
    lencadena   equ $ - cadena      ; 64

section .text
    global _start

_start:
    mov edx, msg_prompt
    call puts

    mov edx, cadena
    mov ax, lencadena
    call captura

    mov edx, msg_orig
    call puts
    mov edx, cadena
    call puts
    mov edx, salto
    call puts

    mov edx, cadena
    call mayusculas
    mov edx, msg_may
    call puts
    mov edx, cadena
    call puts
    mov edx, salto
    call puts

    mov edx, cadena
    call minusculas
    mov edx, msg_min
    call puts
    mov edx, cadena
    call puts
    mov edx, salto
    call puts

    ; --- FIN DE PROGRAMA ---
.fin_programa:
    mov eax, 1                  ; sys_exit
    xor ebx, ebx                ; return 0
    int 0x80

putchar:
    pushad
    push eax                    ; el carácter queda en [esp]
    mov eax, 4                  ; sys_write
    mov ebx, 1                  ; stdout
    mov ecx, esp
    mov edx, 1
    int 0x80
    pop eax
    popad
    ret

puts:
    push eax
    push edx
.ciclo:
    mov al, [edx]
    cmp al, 0
    je .fin
    call putchar
    inc edx
    jmp .ciclo
.fin:
    pop edx
    pop eax
    ret

getch:
    push ebx
    push ecx
    push edx
    call canonical_off
    push eax
    mov eax, 3                  ; sys_read
    mov ebx, 0                  ; stdin
    mov ecx, esp
    mov edx, 1
    int 0x80
    pop eax                     ; AL = tecla
    call canonical_on
    pop edx
    pop ecx
    pop ebx
    ret


getche:
    call getch
    call putchar
    ret

borrar:
    push eax
    mov al, 8
    call putchar
    mov al, ' '
    call putchar
    mov al, 8
    call putchar
    pop eax
    ret

captura:
    push eax
    push ebx
    push ecx
    push esi
    push edx
    movzx ebx, ax
    dec ebx                     ; límite = máx - 1 
    xor ecx, ecx                ; contador de caracteres capturados
    mov esi, edx                ; puntero de escritura
.leer:
    call getch
    cmp al, 10                  ; Enter
    je .fin
    cmp al, bskey
    je .borrar
    cmp al, 8
    je .borrar
    cmp ecx, ebx                ; buffer lleno: ignorar
    jae .leer
    mov [esi], al
    inc esi
    inc ecx
    call putchar
    jmp .leer
.borrar:
    cmp ecx, 0                  ; no borrar lo que el usuario no capturó
    je .leer
    dec ecx
    dec esi
    call borrar
    jmp .leer
.fin:
    mov byte [esi], 0           ; fin de cadena
    mov al, 10
    call putchar
    pop edx
    pop esi
    pop ecx
    pop ebx
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
    sub al, 32
    mov [edx], al
.sig:
    inc edx
    jmp .ciclo
.fin:
    pop edx
    pop eax
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
    add al, 32
    mov [edx], al
.sig:
    inc edx
    jmp .ciclo
.fin:
    pop edx
    pop eax
    ret