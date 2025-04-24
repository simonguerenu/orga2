; Importamos las funciones de C que queremos usar
extern sumar_c 
extern restar_c

;########### SECCIÓN DE DATOS
section .data

;########### SECCIÓN DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global alternate_sum_4
global alternate_sum_4_using_c
global alternate_sum_4_using_c_alternative
global alternate_sum_8
global product_2_f
global product_9_f

;########### DEFINICIÓN DE FUNCIONES

; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parámetros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4:
    sub EDI, ESI
    add EDI, EDX
    sub EDI, ECX
    mov EAX, EDI
    ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parámetros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4_using_c:
    ; prólogo
    push RBP
    mov RBP, RSP
    push R12
    push R13     ; preservo no-volátiles, al ser 2 la pila queda alineada

    mov R12D, EDX ; guardo x3
    mov R13D, ECX ; guardo x4

    call restar_c ; recibe parámetros en EDI y ESI

    mov EDI, EAX
    mov ESI, R12D
    call sumar_c

    mov EDI, EAX
    mov ESI, R13D
    call restar_c

    ; epílogo
    pop R13
    pop R12
    pop RBP
    ret

; Versión alternativa usando pila
alternate_sum_4_using_c_alternative:
    ; prólogo
    push RBP
    mov RBP, RSP
    sub RSP, 16               ; reservo espacio para x4 + alineación
    mov [RBP-8], RCX          ; guardo x4

    push RDX                 ; preservo x3
    sub RSP, 8               ; alineo
    call restar_c
    add RSP, 8
    pop RDX                  ; recupero x3

    mov EDI, EAX
    mov ESI, EDX
    call sumar_c

    mov EDI, EAX
    mov ESI, [RBP-8]         ; leo x4
    call restar_c

    ; epílogo
    add RSP, 16
    pop RBP
    ret

;x1 -> EDI, x2 -> ESI, x3 -> EDX, x4 -> ECX, x5 -> R8, x6 -> R9, x7 -> [RSP + 8], x8 -> [RSP + 16]
alternate_sum_8:
    push RBP
    mov RBP, RSP ;alineado
    push R12
    push R13

    mov R12D, R8D
    mov R13D, R9D
    call alternate_sum_4_using_c

    mov EDI, R12D
    mov ESI, R13D
    mov EDX, [RBP + 16]
    mov ECX, [RBP + 24]
    mov R12D, EAX
    call alternate_sum_4_using_c

    mov EDI, R12D
    mov ESI, EAX
    call sumar_c

    pop R13
    pop R12
    pop RBP
    ret

; void product_2_f(uint32_t * destination, uint32_t x1, float f1);
; registros: destination[?], x1[?], f1[?]
product_2_f:
    ; COMPLETAR
    ret

; void product_9_f(double * destination, ..., float f9);
; registros y pila: destination[rdi], x1[?], f1[?], ..., x9[?], f9[?]
product_9_f:
    ; prólogo
    push RBP
    mov RBP, RSP

    ; convertir floats a doubles
    ; COMPLETAR

    ; multiplicar doubles
    ; COMPLETAR

    ; convertir enteros a double y multiplicar
    ; COMPLETAR

    ; epílogo
    pop RBP
    ret