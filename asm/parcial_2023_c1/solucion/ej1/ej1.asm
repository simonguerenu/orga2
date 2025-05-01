global templosClasicos
global cuantosTemplosClasicos
TEMPLOARR_COLUM_LARGO_OFFSET EQU 0
TEMPLOARR_NOMBRE_OFFSET EQU 8
TEMPLOARR_COLUM_CORTO_OFFSET EQU 16
TEMPLOARR_SIZE EQU 24


;########### SECCION DE TEXTO (PROGRAMA)
section .text

templosClasicos:



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

