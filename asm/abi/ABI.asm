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
; destination --> RDI, x1 --> RSI, f1 --> XMM0
product_2_f:
    CVTSS2SD XMM0, XMM0
    CVTSI2SD XMM1, ESI
    MULSD XMM0, XMM1
    CVTTSD2SI ESI, XMM0
    mov DWORD [RDI], ESI
    ret

; void product_9_f(double * destination, ..., float f9);
; destination --> RDI, 
; x1-->RSI, f2-->XMM0, 
; x2-->RDX, f2-->XMM1, 
; x3-->RCX, f3-->XMM2,
; x4-->R8, f4--> XMM3,
; x5-->R9, f5--> XMM4,
; x6-->[RSP+8], f6--> XMM5,
; x7-->[RSP+16], f7--> XMM6,
; x8-->[RSP+24], f8--> XMM7,
; x9-->[RSP+32], f9--> [RSP+40],
product_9_f:
    ; prólogo
    sub RSP, 8
    push RBP
    mov RBP, RSP

    ;convierto float a dobles
    CVTSS2SD XMM0, XMM0
    CVTSS2SD XMM1, XMM1
    CVTSS2SD XMM2, XMM2
    CVTSS2SD XMM3, XMM3
    CVTSS2SD XMM4, XMM4
    CVTSS2SD XMM5, XMM5
    CVTSS2SD XMM6, XMM6
    CVTSS2SD XMM7, XMM7
    CVTSS2SD XMM8, [RBP+56]

    ;multiplico dobles
    MULSD XMM0, XMM1
    MULSD XMM0, XMM2
    MULSD XMM0, XMM3
    MULSD XMM0, XMM4
    MULSD XMM0, XMM5
    MULSD XMM0, XMM6
    MULSD XMM0, XMM7
    MULSD XMM0, XMM8
      
    ; convertir enteros a double y multiplicar
    CVTSI2SD XMM1, ESI
    CVTSI2SD XMM2, EDX
    CVTSI2SD XMM3, ECX
    CVTSI2SD XMM4, R8D
    CVTSI2SD XMM5, R9D
    CVTSI2SD XMM6, [RBP+24]
    CVTSI2SD XMM7, [RBP+32]
    CVTSI2SD XMM8, [RBP+40]
    CVTSI2SD XMM9, [RBP+48]

    MULSD XMM0, XMM1
    MULSD XMM0, XMM2
    MULSD XMM0, XMM3
    MULSD XMM0, XMM4
    MULSD XMM0, XMM5
    MULSD XMM0, XMM6
    MULSD XMM0, XMM7
    MULSD XMM0, XMM8
    MULSD XMM0, XMM9
    
    MOVSD QWORD [RDI], XMM0

    pop RBP
    add rsp, 8
    ret