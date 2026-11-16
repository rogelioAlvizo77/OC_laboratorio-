%macro PROTOENTRADA 0
    push ebp
    mov ebp,esp
%endmacro

%macro PROTOSALIDA 0
    mov esp,ebp
    pop ebp
%endmacro


section .text
    global _setbit
    global _getbit

    _setbit:
        PROTOENTRADA

        mov eax,[ebp+8]       ; direccion del valor
        mov ecx,[ebp+12]      ; posicion del bit

        cmp ecx,8
        jae .fin_setbit

        mov edx,1
        shl edx,cl            ; desplazar el 1 a la posicion indicada

        or byte [eax],dl      ; activar el bit

    .fin_setbit:
        PROTOSALIDA
        ret


    _getbit:
        PROTOENTRADA

        movzx eax,byte [ebp+8] ; obtener el valor
        mov ecx,[ebp+12]       ; posicion del bit

        cmp ecx,8
        jae .fin_getbit

        shr eax,cl             ; desplazar el bit a la posicion 0
        and eax,1              ; obtener solamente el bit

        jmp .salida_getbit

    .fin_getbit:
        mov eax,0

    .salida_getbit:
        PROTOSALIDA
        ret
