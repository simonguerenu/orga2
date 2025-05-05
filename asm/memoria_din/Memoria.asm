extern malloc
extern free
extern fprintf

section .data
format_str: db "%s", 0
null_str:   db "NULL", 0
section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
;a-->rdi, b-->rsi
strCmp:
	xor rax, rax
	xor rcx, rcx
	mov cl, BYTE [rdi]
	mov al, BYTE [rsi]
	loop_chequeo_letra:
		cmp al, cl
		jne char_differ
		mov r8b, al
		or r8b, cl
		cmp r8b, 0
		je equals

		add rdi, 1
		add rsi, 1
		mov cl, BYTE [rdi]
		mov al, BYTE [rsi]
		jmp loop_chequeo_letra

	equals:
		mov rax, 0
		jmp fin_cmp
	char_differ:
		sub rax, rcx
		sar rax, 63
		or rax, 1
	fin_cmp:
	ret

; char* strClone(char* a)
;a->rdi
strClone:
	push rbp
	mov rbp, rsp

	push rdi
	sub rsp, 8
	call strLen 
	add rsp, 8
	pop rsi ;rsi = dir original

	mov rdi, rax ;rdi = longitud
	inc rdi ;hago espacio para '\0'

	push rdi
	push rsi
	call malloc ;rax = dir nueva
	pop rsi
	pop rdi

	dec rdi ;voy a usar rdi como longitud sin considerar '\0'
	xor rdx, rdx ;rdx = index
	mov rcx, rax ;rcx = dir nueva
	xor r8, r8 ;r8b para mover bytes
	loop_clone:
		cmp rdx, rdi
		jge fin_leer_clone
		mov r8b, BYTE [rsi]
		mov BYTE [rcx], r8b
		inc rsi
		inc rcx ;inc ambas direcciones por el offset
		inc rdx
		jmp loop_clone
	fin_leer_clone:
	mov BYTE [rcx], 0
	mov rsp, rbp
	pop rbp
	ret

; void strDelete(char* a)
;rdi --> a
strDelete:
	push rbp
	mov rbp, rsp
	call free
	mov rsp, rbp
	pop rbp
	ret

; void strPrint(char* a, FILE* pFile) fprintf(pFile, %s, string)
;rdi -> a, rsi -> pFile
strPrint:
	push rbp
	mov rbp, rsp
	mov rdx, rdi ;rdx = string
	mov rdi, rsi ;rdi = pFile
	mov rsi, format_str ;rsi = format
	cmp BYTE [rdx], 0
	je string_vacio
	call fprintf
	jmp fin
	
	string_vacio:
		mov rdx, null_str
		call fprintf
	fin:
	mov rsp, rbp
	pop rbp
	ret

; uint32_t strLen(char* a)
;a-->rdi
strLen:
	xor rax, rax
	loop_len:
		cmp BYTE [rdi], 0
		je fin_len
		add rax, 1
		add rdi, 1
		jmp loop_len
	fin_len:
	ret


