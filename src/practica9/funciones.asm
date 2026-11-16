%include "../../lib/pc_io.inc"

;macro entrada
%macro PROTOENTRADA 0
    push ebp
    mov ebp,esp
%endmacro

;macro salida
%macro PROTOSALIDA 0
    mov esp,ebp
    pop ebp
%endmacro

;macro while
%macro WHILE 3
    push ecx
    push edx
    mov ecx,%1
    mov edx,%2
    %%ciclo:
        cmp ecx,edx
        jge %%fin
        call %3
        inc ecx
        jmp %%ciclo
    %%fin:
    pop edx
    pop ecx
%endmacro


section .text

global maximo
global minimo
global sumatoria


;procedimiento maximo
maximo:
    PROTOENTRADA
    sub esp,4

    push ebx
    push esi
    push edi

    mov edi,[ebp+8]      ; arreglo
    mov edx,[ebp+12]     ; len

    mov eax,[edi]        ; maximo inicial
    mov dword[ebp-4],eax

    WHILE 0,edx,comparar_maximo

    pop edi
    pop esi
    pop ebx

    mov eax,[ebp-4]

    add esp,4
    PROTOSALIDA
    ret


comparar_maximo:
    push ebx

    mov ebx,[edi+ecx*4]
    cmp ebx,[ebp-4]
    jle .fin_max

    mov [ebp-4],ebx

.fin_max:
    pop ebx
    ret


;procedimiento minimo
minimo:
    PROTOENTRADA
    sub esp,4

    push ebx
    push esi
    push edi

    mov edi,[ebp+8]      ; arreglo
    mov edx,[ebp+12]     ; len

    mov eax,[edi]        ; minimo inicial
    mov dword[ebp-4],eax

    WHILE 0,edx,comparar_minimo

    pop edi
    pop esi
    pop ebx

    mov eax,[ebp-4]

    add esp,4
    PROTOSALIDA
    ret


comparar_minimo:
    push ebx

    mov ebx,[edi+ecx*4]
    cmp ebx,[ebp-4]
    jge .fin_min

    mov [ebp-4],ebx

.fin_min:
    pop ebx
    ret


;procedimiento sumatoria
sumatoria:
    PROTOENTRADA

    push edi

    mov edi,[ebp+8]      ; arreglo
    mov edx,[ebp+12]     ; len

    mov eax,0            ; acumulador

    WHILE 0,edx,sumar_elemento

    pop edi

    PROTOSALIDA
    ret


sumar_elemento:
    add eax,[edi+ecx*4]
    ret