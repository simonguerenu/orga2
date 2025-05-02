global templosClasicos
global cuantosTemplosClasicos
extern malloc
TEMPLOARR_COLUM_LARGO_OFFSET EQU 0
TEMPLOARR_NOMBRE_OFFSET EQU 8
TEMPLOARR_COLUM_CORTO_OFFSET EQU 16
TEMPLOARR_SIZE EQU 24


;########### SECCION DE TEXTO (PROGRAMA)
section .text

;templo* templosClasicos_c(templo *temploArr, size_t temploArr_len)
;temploArr -> rdi, temploArr_len -> rsi
templosClasicos:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    mov r12, rdi
    mov r13, rsi
    call cuantosTemplosClasicos
    mov rdi, rax ;rdi = cuantosTemplosClasicos
    imul rdi, TEMPLOARR_SIZE
    call malloc
    mov rdi, r12
    mov rsi, r13
    mov r12, rax ;r12 = templosClasicosArr* (index)
    .loop_temploarr:
        test rsi, rsi ;len == 0
        jz .fin_loop_temploarr
        movzx rcx, byte [rdi + TEMPLOARR_COLUM_CORTO_OFFSET]
        shl rcx, 1
        inc rcx
        movzx r8, byte [rdi + TEMPLOARR_COLUM_LARGO_OFFSET]
        cmp r8, rcx
        jne .no_añadir_templo_clasico
        mov byte [r12 + TEMPLOARR_COLUM_LARGO_OFFSET], r8b
        mov r8, [rdi + TEMPLOARR_NOMBRE_OFFSET]
        mov [r12 + TEMPLOARR_NOMBRE_OFFSET], r8
        mov r8b, [rdi + TEMPLOARR_COLUM_CORTO_OFFSET]
        mov byte [r12 + TEMPLOARR_COLUM_CORTO_OFFSET], r8b
        add r12, TEMPLOARR_SIZE
        add rdi, TEMPLOARR_SIZE
        dec rsi
        jmp .loop_temploarr
        .no_añadir_templo_clasico:
            add rdi, TEMPLOARR_SIZE
            dec rsi
            jmp .loop_temploarr
    .fin_loop_temploarr:
        pop r13
        pop r12
        mov rsp, rbp
        pop rbp
        ret


    ;uint32_t cuantosTemplosClasicos_c(templo *temploArr, size_t temploArr_len)
    ;temploArr -> rdi, temploArr_len -> rsi
    cuantosTemplosClasicos:
        xor rax, rax
        .iterate_templos:
            test rsi, rsi
            jz .fin_iterate_templos
            movzx rdx, byte [rdi + TEMPLOARR_COLUM_CORTO_OFFSET] ;temploArr[i].colum_corto
            shl rdx, 1 ;*2
            inc rdx ;+1
            movzx r8, byte [rdi + TEMPLOARR_COLUM_LARGO_OFFSET]
            cmp rdx, r8
            jne .no_sumar_templo_clasico
            inc rax
            .no_sumar_templo_clasico:
                add rdi, TEMPLOARR_SIZE
                dec rsi
                jnz .iterate_templos
        .fin_iterate_templos:
        ret

