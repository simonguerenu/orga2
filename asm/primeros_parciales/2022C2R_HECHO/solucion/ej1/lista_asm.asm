%define OFFSET_NEXT  0
%define OFFSET_SUM   8
%define OFFSET_SIZE  16
%define OFFSET_ARRAY 24
%define LISTA_SIZE 32

BITS 64
extern calloc
section .text


; uint32_t proyecto_mas_dificil(lista_t*)
;
; Dada una lista enlazada de proyectos devuelve el `sum` más grande de ésta.
;
; - El `sum` más grande de la lista vacía (`NULL`) es 0.
;
global proyecto_mas_dificil
;uint32_t proyecto_mas_dificil(lista_t* lista
;rdi -> lista_t* lista
proyecto_mas_dificil:
	xor eax, eax ;esi = sumaMayor
    .while_proyecto_mas_dificil:
        test rdi, rdi
        jz .fin_proyecto_mas_dificil
        cmp dword [rdi + OFFSET_SUM], eax
        jle .no_actualiza
            mov eax, dword [rdi + OFFSET_SUM]
        .no_actualiza:
            mov rdi, qword [rdi + OFFSET_NEXT]
        jmp .while_proyecto_mas_dificil
    .fin_proyecto_mas_dificil:
	ret

; void marcar_tarea_completada(lista_t* lista, size_t index)
;
; Dada una lista enlazada de proyectos y un índice en ésta setea la i-ésima
; tarea en cero.
;
; - La implementación debe "saltearse" a los proyectos sin tareas
; - Se puede asumir que el índice siempre es válido
; - Se debe actualizar el `sum` del nodo actualizado de la lista
;rdi -> lista* lista, rsi -> size_t index
global marcar_tarea_completada
marcar_tarea_completada:
    .while_marcar_tarea_completada:
        cmp rsi, qword [rdi + OFFSET_SIZE]
        jl .fin_while_marcar_tarea_completada
        sub rsi, qword [rdi + OFFSET_SIZE]
        mov rdi, [rdi + OFFSET_NEXT]
        jmp .while_marcar_tarea_completada
    .fin_while_marcar_tarea_completada:
        mov rdx, qword [rdi + OFFSET_ARRAY] ;lista->array
        mov ecx, dword [rdx + rsi*4] ;lista->array[index]
        sub dword [rdi + OFFSET_SUM], ecx
        mov dword [rdx + rsi*4], 0
	    ret

; uint64_t* tareas_completadas_por_proyecto(lista_t*)
;
; Dada una lista enlazada de proyectos se devuelve un array que cuenta
; cuántas tareas completadas tiene cada uno de ellos.
;
; - Si se provee a la lista vacía como parámetro (`NULL`) la respuesta puede
;   ser `NULL` o el resultado de `malloc(0)`
; - Los proyectos sin tareas tienen cero tareas completadas
; - Los proyectos sin tareas deben aparecer en el array resultante
; - Se provee una implementación esqueleto en C si se desea seguir el
;   esquema implementativo recomendado
;rdi -> lista* lista
global tareas_completadas_por_proyecto
tareas_completadas_por_proyecto:
	push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    mov r13, rdi ;r13 = lista
    call lista_len
    mov r12, rax ;r12 = len
    mov rdi, r12
    mov rsi, 8
    call calloc
    mov r14, rax ;r14 = lista_tareas_completadas (indice)
    mov r15, rax ;r15 = lista_tareas_completadas (fijo)
    .while_tareas_completadas_por_proyecto:
        test r12, r12 ;len > 0
        jz .fin_while_tareas_completadas_por_proyecto
        mov rdi, qword [r13 + OFFSET_ARRAY]
        mov rsi, qword [r13 + OFFSET_SIZE]
        call tareas_completadas
        mov qword [r14], rax
        mov r13, qword [r13 + OFFSET_NEXT]
        add r14, 8
        dec r12
        jmp .while_tareas_completadas_por_proyecto
    .fin_while_tareas_completadas_por_proyecto:
    mov rax, r15
    pop r15
    pop r14
    pop r13
    pop r12
    mov rsp, rbp
    pop rbp
	ret

; uint64_t lista_len(lista_t* lista)
;
; Dada una lista enlazada devuelve su longitud.
;
; - La longitud de `NULL` es 0
;rdi -> lista
lista_len:
    xor rax, rax ;rax = lista_length
    .while_lista_len:
        test rdi, rdi
        jz .fin_lista_len
        inc rax
        mov rdi, qword [rdi + OFFSET_NEXT]
        jmp .while_lista_len
    .fin_lista_len:
	ret

; uint64_t tareas_completadas(uint32_t* array, size_t size) {
;
; Dado un array de `size` enteros de 32 bits sin signo devuelve la cantidad de
; ceros en ese array.
;
; - Un array de tamaño 0 tiene 0 ceros.
;rdi -> uint32* array, rsi -> size_t size
tareas_completadas:
    xor rax, rax ;rdx = contador_tareas_completadas
    .for_tareas_completadas:
        test rsi, rsi ;size != 0
        jz .fin_for_tareas_completadas
        cmp dword [rdi], 0
        jne .continue_for_tareas_completadas
            inc rax
        .continue_for_tareas_completadas:
        dec rsi
        add rdi, 4
        jmp .for_tareas_completadas
    .fin_for_tareas_completadas:
    ret
