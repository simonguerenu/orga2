section .text
;list
LIST_T_FIRST_OFFSET EQU 0
LIST_T_LAST_OFFSET EQU 8
LIST_T_SIZE EQU 16

;list_elem
LISTELEM_DATA_OFFSET EQU 0
LISTELEM_NEXT_OFFSET EQU 8
LISTELEM_PREV_OFFSET EQU 16
LISTELEM_SIZE EQU 24

;monto
PAGO_T_MONTO_OFFSET EQU 0
PAGO_T_APROBADO_OFFSET EQU 1
PAGO_T_PAGADOR_OFFSET EQU 8
PAGO_T_COBRADOR_OFFSET EQU 16
PAGO_T_SIZE EQU 24
global contar_pagos_aprobados_asm
global contar_pagos_rechazados_asm

;pago_splittered
PAGO_SPLITTERED_CANT_APROBADOS_OFFSET EQU 0
PAGO_SPLITTERED_CANT_RECHAZADOS_OFFSET EQU 1
PAGO_SPLITTERED_APROBADOS_OFFSET EQU 8
PAGO_SPLITTERED_RECHAZADOS_OFFSET EQU 16
PAGO_SPLITTERED_SIZE EQU 24

global split_pagos_usuario_asm

extern malloc
extern free
extern strcmp


;########### SECCION DE TEXTO (PROGRAMA)

; uint8_t contar_pagos_aprobados_asm(list_t* pList, char* usuario);
;*pList -> rdi, *usuario -> rsi
contar_pagos_aprobados_asm:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 8
    mov rbx, rsi ;usuario
    mov r13, rdi ;*pList
    mov r12, [r13 + LIST_T_FIRST_OFFSET] ;r12 actual
    xor r15, r15 ;contador
    .loop_contar_aprobados:
        cmp r12, 0
        je .fin_loop_contar_aprobados
        mov r14, [r12 + LISTELEM_DATA_OFFSET] 
        mov rdi, [r14 + PAGO_T_COBRADOR_OFFSET]
        mov rsi, rbx
        call strcmp
        cmp rax, 0
        jne .continue_loop_contar_aprobados
        movzx rax, byte [r14 + PAGO_T_APROBADO_OFFSET]
        cmp al, 1
        jne .continue_loop_contar_aprobados
        inc r15b
        .continue_loop_contar_aprobados:
            mov r12, [r12 + LISTELEM_NEXT_OFFSET]
            jmp .loop_contar_aprobados

    .fin_loop_contar_aprobados:
        xor rax, rax
        mov al, r15b
        add rsp, 8
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbx
        mov rsp, rbp
        pop rbp
        ret
        
    
; uint8_t contar_pagos_rechazados_asm(list_t* pList, char* usuario);
;*pList -> rdi, *usuario -> rsi
contar_pagos_rechazados_asm:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 8
    mov rbx, rsi ;usuario
    mov r13, rdi ;*pList
    mov r12, [r13 + LIST_T_FIRST_OFFSET] ;r12 actual
    xor r15, r15 ;contador
    .loop_contar_aprobados:
        cmp r12, 0
        je .fin_loop_contar_aprobados
        mov r14, [r12 + LISTELEM_DATA_OFFSET] 
        mov rdi, [r14 + PAGO_T_COBRADOR_OFFSET]
        mov rsi, rbx
        call strcmp
        cmp rax, 0
        jne .continue_loop_contar_aprobados
        movzx rax, byte [r14 + PAGO_T_APROBADO_OFFSET]
        cmp al, 0
        jne .continue_loop_contar_aprobados
        inc r15b
        .continue_loop_contar_aprobados:
            mov r12, [r12 + LISTELEM_NEXT_OFFSET]
            jmp .loop_contar_aprobados

    .fin_loop_contar_aprobados:
        xor rax, rax
        mov al, r15b
        add rsp, 8
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

; pagoSplitted_t* split_pagos_usuario_asm(list_t* pList, char* usuario);
;*pList -> rdi, *usuario -> rsi
split_pagos_usuario_asm:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 8
    mov r12, rdi
    mov r13, rsi

    xor r14, r14
    xor r15, r15

    call contar_pagos_rechazados_asm
    mov r14b, al ;r14b = cantPagosRechazados
    mov rdi, r12
    mov rsi, r13
    call contar_pagos_aprobados_asm
    mov r15b, al ;r15b = cantPagosAprobados

    mov rdi, PAGO_SPLITTERED_SIZE
    call malloc
    mov rbx, rax ;rbx = registroUsuario

    mov rdi, r14
    shl rdi, 3 ;cantPagosRechazados * 8 bytes (punteros)
    cmp rdi, 0
    je .listaRechazados_NULL
    call malloc
    mov [rbx + PAGO_SPLITTERED_RECHAZADOS_OFFSET], rax
    jmp .malloc_pagosAprobados
    .listaRechazados_NULL:
        mov QWORD [rbx + PAGO_SPLITTERED_RECHAZADOS_OFFSET], 0 
    .malloc_pagosAprobados:
    mov rdi, r15
    shl rdi, 3 ;cantPagosAprobados * 8 bytes (punteros)
    cmp rdi, 0
    je .listaAprobados_NULL
    call malloc
    mov [rbx + PAGO_SPLITTERED_APROBADOS_OFFSET], rax
    jmp .terminar_malloc
    .listaAprobados_NULL:
        mov QWORD [rbx + PAGO_SPLITTERED_APROBADOS_OFFSET], 0
    .terminar_malloc:

    mov [rbx + PAGO_SPLITTERED_CANT_APROBADOS_OFFSET], r15b
    mov [rbx + PAGO_SPLITTERED_CANT_RECHAZADOS_OFFSET], r14b

    mov rcx, [r12 + LIST_T_FIRST_OFFSET] ;rcx = actual
    xor r14, r14 ;contadorAprobados
    xor r15, r15 ;contadorRechazados
    mov  r8, [rbx + PAGO_SPLITTERED_APROBADOS_OFFSET]   ; base_aprobados
    mov  r9, [rbx + PAGO_SPLITTERED_RECHAZADOS_OFFSET]  ; base_rechazados
    .loop_lista:
        cmp rcx, 0 ;actual!=null
        je .fin_loop_lista

        
        mov rdx, [rcx + LISTELEM_DATA_OFFSET] ;rdx = actual->data
        mov rdi, [rdx + PAGO_T_COBRADOR_OFFSET]
        mov rsi, r13

        push rdx
        push rcx
        push r9
        push r8
        call strcmp ;if(actual->data->cobrador == usuario)
        pop r8
        pop r9
        pop rcx
        pop rdx

        cmp rax, 0
        jne .continue_loop_lista ;else
            cmp byte [rdx + PAGO_T_APROBADO_OFFSET], 1 ;if(actual->data->aprobado)
            jne .pago_rechazado
            test r8, r8
            je .skip_aceptados
            mov [r8 + r14], rdx
            .skip_aceptados:
            add r14, 8
            jmp .continue_loop_lista
            .pago_rechazado:
            test r9, r9
            je .skip_rechazados
            mov [r9 + r15], rdx
            .skip_rechazados:
            add r15, 8
        .continue_loop_lista:
        mov rcx, [rcx + LISTELEM_NEXT_OFFSET]
        jmp .loop_lista
    .fin_loop_lista:
    mov rax, rbx
    add rsp, 8
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
