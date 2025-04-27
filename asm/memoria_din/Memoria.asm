extern malloc
extern free
extern fprintf

section .data

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
	mov r12, rdi
	call strLen
	mov rdi, r12 ;address
	xor rdx, rdx 
	mov rdx, rax ;longitud
	
	mul 
	fin_leer_clone:
	ret

; void strDelete(char* a)
strDelete:
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
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


