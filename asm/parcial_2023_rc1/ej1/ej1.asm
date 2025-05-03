extern malloc
extern free

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
EJERCICIO_1B_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1C como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - modificarUnidad
global EJERCICIO_1C_HECHO
EJERCICIO_1C_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

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
    push rdx
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
        pop rdx
        push rdx
        call rdx
        pop rdx
        push rdx
        mov ebx, eax
        mov rdi, r14
        call rdx
        pop rdx
        push rdx
        cmp ebx, eax ;if funhash iguales
            jne .continue_loop_optimizar
            xor rdx, rdx
            cmp byte [r14 + ATTACKUNIT_REFERENCES], 1
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
    .continue_loop_optimizar:
        add r12, 8
        jmp .loop_optimizar
    .fin_loop_optimizar:
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    mov rsp, rbp
    pop rbp
	ret

global contarCombustibleAsignado
;uint32_t contarCombustibleAsignado(mapa_t mapa, uint16_t (*fun_combustible)(char*))
;mapa -> rdi, fun_combustible -> rsi
contarCombustibleAsignado:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    push rbx
    sub rsp, 8
    xor r12, r12 ;index
    xor rbx, rbx ;contador
    mov r13, rdi ;mapa
    mov r15, rsi ;fun_combustible
    .loop_combustible:
        cmp r12, 520200 ;255*255*8
        je .fin_loop_combustible
        mov r14, [r13 + r12] ;unidadActual
        test r14, r14 ;if unidadActual == null
        jz .continue_loop_combustible
        mov rdi, r14
        call r15
        xor rdx, rdx
        mov dx, word [r14 + ATTACKUNIT_COMBUSTIBLE]
        sub dx, ax
        add ebx, edx
        .continue_loop_combustible:
            add r12, 8
            jmp .loop_combustible
    .fin_loop_combustible:
        mov eax, ebx
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    mov rsp, rbp
    pop rbp
	ret

global modificarUnidad
;void modificarUnidad(mapa_t mapa, uint8_t x, uint8_t y, void (*fun_modificar)(attackunit_t*))
;mapa -> rdi, x -> sil, y -> dl, fun_modificar -> rcx
modificarUnidad:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    push rbx
    sub rsp, 8
    mov rbx, rcx ;fun_modificar
    mov r13, rdi ;r13 mapa
    movzx r8, dl
    movzx r12, sil ;r12 = x
    imul r12, 255 ;x*255
    add r12, r8 ;r12 = pos
    shl r12, 3 ;va de a bytes
    mov r14, [r13 + r12] ;r14 = unidad
    test r14, r14 ;unidad == NULL
    je .fin_modificarUnidad
    cmp byte [r14 + ATTACKUNIT_REFERENCES], 1
    jle .una_referencia
        mov r8b, byte [r14 + ATTACKUNIT_REFERENCES]
        dec r8b
        mov byte [r14 + ATTACKUNIT_REFERENCES], r8b ;unidad->references--
        mov rdi, ATTACKUNIT_SIZE
        call malloc
        mov r15, rax ;r15 = unidadModificada
        ;copio el char[11]
        mov r8, [r14 + ATTACKUNIT_CLASE]
        mov [r15 + ATTACKUNIT_CLASE], r8
        ;paso los 4 bytes restantes
        mov r8d, dword [r14 + ATTACKUNIT_CLASE + 8]
        mov dword [r15 + ATTACKUNIT_CLASE + 8], r8d
        mov r8w, word [r14 + ATTACKUNIT_COMBUSTIBLE]
        mov word [r15 + ATTACKUNIT_COMBUSTIBLE], r8w
        mov byte [r15 + ATTACKUNIT_REFERENCES], 1
        mov rdi, r15
        call rbx
        mov [r13 + r12], r15
        jmp .fin_modificarUnidad
    .una_referencia:
        mov rdi, r14
        call rbx
    .fin_modificarUnidad:
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    mov rsp, rbp
    pop rbp
	ret
