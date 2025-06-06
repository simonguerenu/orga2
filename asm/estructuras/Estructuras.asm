

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
NODO_OFFSET_NEXT EQU 0
NODO_OFFSET_CATEGORIA EQU 8
NODO_OFFSET_ARREGLO EQU 16
NODO_OFFSET_LONGITUD EQU 24
NODO_SIZE EQU 32
PACKED_NODO_OFFSET_NEXT EQU 0
PACKED_NODO_OFFSET_CATEGORIA EQU 8
PACKED_NODO_OFFSET_ARREGLO EQU 9
PACKED_NODO_OFFSET_LONGITUD EQU 17
PACKED_NODO_SIZE EQU 21
LISTA_OFFSET_HEAD EQU 0
LISTA_SIZE EQU 8
PACKED_LISTA_OFFSET_HEAD EQU 0
PACKED_LISTA_SIZE EQU 8

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista --> RDI
cantidad_total_de_elementos:
	xor rax, rax
	mov rdi, [rdi]

	loop_contar:
		test rdi, rdi ;chequeo si el next es null
		jz loop_end

		mov esi, dword [rdi + NODO_OFFSET_LONGITUD]
		add rax, rsi ;sumo longitud
		mov rdi, [rdi + NODO_OFFSET_NEXT] ;guardo en rdi el puntero al next
		jmp loop_contar
	loop_end:
	ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista --> RDI
cantidad_total_de_elementos_packed:
	xor rax, rax
	mov rdi, [rdi]

	loop_contar_packed:
		test rdi, rdi ;chequeo si el next es null
		jz loop_end_packed

		mov esi, dword [rdi + PACKED_NODO_OFFSET_LONGITUD]
		add rax, rsi ;sumo longitud
		mov rdi, [rdi + PACKED_NODO_OFFSET_NEXT] ;guardo en rdi el puntero al next
		jmp loop_contar_packed
	loop_end_packed:
	ret

