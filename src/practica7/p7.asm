%include "../../lib/pc_io.inc"

section .data
    bskey     equ 0x7F
    lencadena equ 64
    ln        equ 0x0A

    msg1 db ln, 'Capture un numero: ', 0
    msg2 db ln, 'Numero convertido: ', 0

section .bss
    cadena    resb lencadena
    resultado resd 1
    salida    resb 16

section .text
    global _start

_start:
    ; --- capturar un numero ---
    mov edx, msg1
    call puts

    mov edx, cadena
    mov ax, lencadena
    call captura

    ; --- convertir cadena a entero ---
    mov edx, cadena
    call atoi
    mov [resultado], eax

    ; --- convertir entero a cadena ---
    mov eax, [resultado]
    mov edx, salida
    mov ecx, 16
    call itoa

    ; --- mostrar resultado ---
    mov edx, msg2
    call puts

    mov edx, salida
    call puts

    ; --- terminar programa ---
    mov eax, 1
    xor ebx, ebx
    int 0x80

captura:
    push eax
    push ebx
    push ecx
    push edx

    movzx ebx, ax
    dec ebx
    xor ecx, ecx

.ciclo:
    call getch

    cmp al, 0x0A
    je .fin

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
    cmp ecx, ebx
    jae .ciclo

    mov [edx], al
    inc edx
    inc ecx
    call putchar
    jmp .ciclo

.fin:
    mov byte [edx], 0

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

borrar:
    push eax

    mov al, 0x08
    call putchar
    mov al, ' '
    call putchar
    mov al, 0x08
    call putchar

    pop eax
    ret

atoi:
    push ebx
    push ecx
    push esi
    push edi

    mov esi, edx
    xor eax, eax
    xor edi, edi

    ; ignorar espacios y tabulaciones
.espacios:
    mov bl, [esi]

    cmp bl, ' '
    je .avanzar

    cmp bl, 9
    je .avanzar

    jmp .signo

.avanzar:
    inc esi
    jmp .espacios

    ; revisar el signo
.signo:
    cmp bl, '-'
    jne .positivo

    mov edi, 1
    inc esi
    jmp .digitos

.positivo:
    cmp bl, '+'
    jne .digitos

    inc esi

    ; convertir los digitos
.digitos:
    movzx ebx, byte [esi]

    cmp bl, '0'
    jb .fin

    cmp bl, '9'
    ja .fin

    imul eax, eax, 10
    sub ebx, '0'
    add eax, ebx

    inc esi
    jmp .digitos

.fin:
    cmp edi, 1
    jne .salir

    neg eax

.salir:
    pop edi
    pop esi
    pop ecx
    pop ebx
    ret

itoa:
    push eax
    push ebx
    push ecx
    push esi
    push edi
    push ebp

    mov ebp, ecx
    mov edi, edx
    mov esi, edx
    mov ebx, 10

    cmp ebp, 2
    jb .salir

    ; revisar si es negativo
    test eax, eax
    jns .positivo

    mov byte [edi], '-'
    inc edi
    neg eax

.positivo:
    ; caso especial: numero cero
    test eax, eax
    jnz .convertir

    mov byte [edi], '0'
    inc edi
    jmp .terminar

.convertir:
    xor ecx, ecx

.dividir:
    xor edx, edx
    div ebx

    add dl, '0'
    push edx
    inc ecx

    test eax, eax
    jnz .dividir

    ; validar que quepa la cadena
    mov eax, edi
    sub eax, esi
    add eax, ecx
    inc eax
    cmp eax, ebp
    jbe .guardar

.descartar:
    pop eax
    loop .descartar
    mov edi, esi
    jmp .terminar

    ; guardar digitos en orden correcto
.guardar:
    pop eax
    mov [edi], al
    inc edi
    loop .guardar

.terminar:
    mov byte [edi], 0

.salir:
    mov edx, esi

    pop ebp
    pop edi
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret
