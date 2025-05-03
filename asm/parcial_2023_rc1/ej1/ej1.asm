extern malloc

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

; Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - optimizar
global EJERCICIO_1A_HECHO
EJERCICIO_1A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - contarCombustibleAsignado
global EJERCICIO_1B_HECHO
EJERCICIO_1B_HECHO: db FALSE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1C como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - modificarUnidad
global EJERCICIO_1C_HECHO
EJERCICIO_1C_HECHO: db FALSE ; Cambiar por `TRUE` para correr los tests.

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
ATTACKUNIT_CLASE EQU 0
ATTACKUNIT_COMBUSTIBLE EQU 12
ATTACKUNIT_REFERENCES EQU 14
ATTACKUNIT_SIZE EQU 16

global optimizar
;void optimizar(mapa_t mapa, attackunit_t* compartida, uint32_t (*fun_hash)(attackunit_t*))
;mapa->rdi, compartida->rsi, fun_hash -> rdx
optimizar:
	push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    push rbx
    sub rsp, 8
    xor r12, r12 ;i
    mov r13, rdi
    mov r15, rsi
    .loop_optimizar:
        cmp r12, 520200 ;255*255*8
        je .fin_loop_optimizar
        mov r14, [r13 + r12] ;r14 = unidadActual
        test r14, r14
        jz .continue_loop_optimizar
        cmp r14, r15
        je .continue_loop_optimizar
        mov rdi, r15
        call fun_hash
        mov rbx, rax
        mov rdi, r14
        call fun_hash
        cmp rbx, rax ;if funhash iguales
            jne .continue_loop_optimizar
            cmp byte [r14 + ATTACKUNIT_REFERENCES], 1
            xor rdx, rdx
            jne .no_compartido
                mov rdi, r14
                call free
                jmp .fin_compartido
            .no_compartido:
                mov dl, byte [r14 + ATTACKUNIT_REFERENCES]
                dec dl
                mov byte [r14 + ATTACKUNIT_REFERENCES], dl
            .fin_compartido:
                mov dl, byte [r15 + ATTACKUNIT_REFERENCES]
                inc dl
                mov byte [r15 + ATTACKUNIT_REFERENCES], dl
                mov [r13 + r12], r15
        jz .continue_loop_optimizar

    .continue_loop_optimizar:

    .fin_loop_optimizar:
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r14
    mov rsp, rbp
    pop rbp
	ret

global contarCombustibleAsignado
contarCombustibleAsignado:
	; r/m64 = mapa_t           mapa
	; r/m64 = uint16_t*        fun_combustible(char*)
	ret

global modificarUnidad
modificarUnidad:
	; r/m64 = mapa_t           mapa
	; r/m8  = uint8_t          x
	; r/m8  = uint8_t          y
	; r/m64 = void*            fun_modificar(attackunit_t*)
	ret
