extern malloc
global agrupar


;########### SECCION DE DATOS
section .data
MAX_TAGS EQU 4
MSG_OFFSET_TEXT EQU 0
MSG_OFFSET_TEXT_LEN EQU 8
MSG_OFFSET_TAG EQU 16
MSG_SIZE EQU 24
;########### SECCION DE TEXTO (PROGRAMA)
section .text

;*msgArr --> rdi, msgArr_len --> rsi
agrupar:
    push rbp
    mov rbp, rsp
    push r12
	push r13
	push r14
	push r15
	push rbx ;pusheo no volatiles para poder usarlos
	sub rsp, 8 ;alineada

    push rdi
    push rsi
    mov rdi, MAX_TAGS
    shl rdi, 3 ; rdi = MAX_TAGS * 8 (size puntero)
    call malloc ; rax = malloc(MAX_TAGS * sizeof(char*))
    pop r13 ;r13 = msgArr_len
    pop r12 ;r12 = *msgArr
    mov r14, rax ;r14 = *arrayAgrupar
    xor rbx, rbx ;iterador tag
    .iterar_tag:
        cmp rbx, MAX_TAGS ;chequeo si termino de iterar tags
        jge .fin_iterar_tag
        xor rdi, rdi ;rcx = tamaño = 0
        inc rdi ;sumo 1 por caracter '\0'
        xor r15, r15 ; iterador array
        .recorrer_msgArr:
            cmp r15, r13 
            jge .fin_recorrer_msgArr ;si termine de recorrer
            mov rsi, r15
            imul rsi, MSG_SIZE 
            cmp ebx, [r12 + rsi + MSG_OFFSET_TAG] ;chequeo si es el tag actual
            jne .no_aumentar_espacio
            add rdi, [r12 + rsi + MSG_OFFSET_TEXT_LEN] ;aumento espacio a guardar
            .no_aumentar_espacio:
            inc r15, ;aumento iterador
            jmp .recorrer_msgArr
        .fin_recorrer_msgArr:
            call malloc ;guardo memoria 
            mov [r14 + rbx*8], rax
            inc ebx
            jmp .iterar_tag

    .fin_iterar_tag:

    xor rbx, rbx ;iterador tag
    .iterar_tag2:
        cmp ebx, MAX_TAGS ;chequeo si termino de iterar tags
        jge .fin_iterar_tag2 
        xor r15, r15 ;iterador array
        mov r9, [r14 + rbx*8] ;puntero string a movera
        .recorrer_msgArr2:
            cmp r15, r13 ;chequeo si termino de iterar msgArr
            jge .fin_recorrer_msgArr2
            mov rsi, r15
            imul rsi, MSG_SIZE  
            cmp ebx, [r12 + rsi + MSG_OFFSET_TAG] ;chequeo si es el tag actual
            jne .continue_next_msg
            mov rdx, [r12 + rsi + MSG_OFFSET_TEXT];rdx apunta a la primera letra del string
            xor rcx, rcx ;letra actual
            .loop_string: ;si es del mismo tag, recorro el string para ir agregandolo
                mov cl, BYTE [rdx]
                cmp cl, 0
                je .continue_next_msg
                mov [r9], cl ;muevo letra al arr a cierto offset
                inc r9 ;muevo por offset
                inc rdx ;continuo una pos
                jmp .loop_string

            .continue_next_msg:
                inc r15
                jmp .recorrer_msgArr2
        .fin_recorrer_msgArr2:
            mov [r9], BYTE 0
            inc ebx
            jmp .iterar_tag2 
    .fin_iterar_tag2:
        mov rax, r14
        add rsp, 8
        pop rbx
        pop r15
        pop r14
        pop r13
        pop r12
        mov rsp, rbp
        pop rbp
        ret

