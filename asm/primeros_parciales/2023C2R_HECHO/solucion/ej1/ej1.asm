; /** defines bool y puntero **/
%define NULL 0
%define TRUE 1
%define FALSE 0
;LIST
STRING_PROC_LIST_FIRST EQU 0
STRING_PROC_LIST_LAST EQU 8
STRING_PROC_LIST_SIZE EQU 16

;NODE
STRING_PROC_NODE_NEXT EQU 0
STRING_PROC_NODE_PREVIOUS EQU 8
STRING_PROC_NODE_TYPE EQU 16
STRING_PROC_NODE_HASH EQU 24
STRING_PROC_NODE_SIZE EQU 32

section .data

section .text

global string_proc_list_create_asm
global string_proc_node_create_asm
global string_proc_list_add_node_asm
global string_proc_list_concat_asm

; FUNCIONES auxiliares que pueden llegar a necesitar:
extern malloc
extern free
extern str_concat

;string_proc_list* string_proc_list_create
string_proc_list_create_asm:
    push rbp
    mov rbp, rsp
    mov rdi, STRING_PROC_LIST_SIZE
    call malloc ;rax = nuevaLista
    mov QWORD [rax + STRING_PROC_LIST_FIRST], NULL
    mov QWORD [rax + STRING_PROC_LIST_LAST], NULL
    mov rsp, rbp
    pop rbp
    ret

;string_proc_node* string_proc_node_create(uint8_t type, char* hash)
;dil->uint8 type, rsi->char* hash
string_proc_node_create_asm:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    mov rdi, STRING_PROC_NODE_SIZE
    call malloc ;rax = nuevoNodo
    pop rsi
    pop rdi
    mov byte [rax + STRING_PROC_NODE_TYPE], dil
    mov qword [rax + STRING_PROC_NODE_HASH], rsi
    mov qword [rax + STRING_PROC_NODE_NEXT], NULL
     mov qword [rax + STRING_PROC_NODE_PREVIOUS], NULL
    mov rsp, rbp
    pop rbp
    ret

;void string_proc_list_add_node(string_proc_list* list, uint8_t type, char* hash)
;rdi -> list* list, sil -> int8 type, rdx -> char* hash
string_proc_list_add_node_asm:
    push rbp
    mov rbp, rsp
    push rdi ;lista
    push rsi ;sil type
    push rdx ;hash
    sub rsp, 8
    mov dil, sil
    mov rsi, rdx
    call string_proc_node_create_asm ;rax = nodo
    add rsp, 8
    pop rdx
    pop rsi
    pop rdi
    mov rcx, qword [rdi + STRING_PROC_LIST_LAST] ;list->last
    cmp rcx, NULL
    je .no_hay_elem
        mov qword [rcx + STRING_PROC_NODE_NEXT], rax
        mov qword [rax + STRING_PROC_NODE_PREVIOUS], rcx
        mov qword [rdi + STRING_PROC_LIST_LAST], rax
        jmp .fin_string_proc_list_add_node_asm
    .no_hay_elem:
        mov qword [rdi + STRING_PROC_LIST_FIRST], rax
        mov qword [rdi + STRING_PROC_LIST_LAST], rax
    .fin_string_proc_list_add_node_asm:
    mov rsp, rbp
    pop rbp
    ret

;char* string_proc_list_concat(string_proc_list* list, uint8_t type , char* hash)
;rdi -> list* list, sil -> uint8 type, rdx -> char* hash
string_proc_list_concat_asm:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    push rbx
    sub rsp, 8
    xor rbx, rbx
    mov bl, sil ;bl = type
    mov r12, qword [rdi + STRING_PROC_LIST_FIRST] ;r12 = nodoActual
    mov r14, rdx ;r14 = hash
    mov r13, rdx ;r13 = nuevoHash
    .while_nodoActual:
        test r12, r12 ;nodoActual == NULL
        jz .fin_while_nodoActual
        cmp bl, byte [r12 + STRING_PROC_NODE_TYPE] ;if nodoActual->type == type
        jne .distinto_tipo
            mov rdi, r13
            mov rsi, qword [r12 + STRING_PROC_NODE_HASH]
            call str_concat
            mov r15, rax ;r15 = concat
            cmp r13, r14 ;if nuevoHash != hash
            je .mismo_hash
                mov rdi, r13
                call free
            .mismo_hash:
            mov r13, r15
        .distinto_tipo:
            mov r12, qword [r12 + STRING_PROC_NODE_NEXT]
            jmp .while_nodoActual
    .fin_while_nodoActual:
    mov rax, r13
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    mov rsp, rbp
    pop rbp
    ret
