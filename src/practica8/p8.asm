extern canonical_off
extern canonical_on

section .data

section .bss

section .text
    global _start         ; referencia para inicio de programa


_start:
    call getch
    call getch
    call getch
    call getch
    call getch



    ; --- FIN DE PROGRAMA ---
    .fin_programa:
        mov eax, 1            ; Llamada sys_exit
	    xor ebx, ebx          ; return 0
        int 0x80              ; Fin de programa


    putchar:

        ret

    puts:
        ;SE USA putchar
        ret

    getch:
        call canonical_off
        push eax
        mov eax, 3
        mov ebx, 0
        mov ecx, esp
        mov edx, 1
        int 0x80
        pop eax
        ;CODIGO
        call canonical_on
        ret

    getche:
        call canonical_off
        ;CODIGO
        call canonical_on
        ret