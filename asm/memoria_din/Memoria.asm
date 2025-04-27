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
	mov al, BYTE [rdi]
	mov cl, BYTE [rsi]
	loop_chequeo_letra:
		cmp al, cl
		jne char_differ
		mov r8b, al
		or r8b, cl
		cmp r8b, 0
		je equals

		add rdi, 1
		add rsi, 1
		mov al, BYTE [rdi]
		mov cl, BYTE [rsi]
		jmp loop_chequeo_letra

	equals:
		mov rax, 0
		jmp fin
	char_differ:
		sub al, cl
		sar al, 31
		or al, 1
	fin:
	ret

; char* strClone(char* a)
strClone:
	ret

; void strDelete(char* a)
strDelete:
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	ret

; uint32_t strLen(char* a)
strLen:
	ret


