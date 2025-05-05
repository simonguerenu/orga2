#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include "hola.h"
<<<<<<< HEAD
#include <inttypes.h>
#include <time.h>
=======
#include "type.h"
#include <inttypes.h>
#include <time.h>

>>>>>>> desarrollo
void ej3() {
        //Ejercicio3
        char c = 'c';
        unsigned char uc = 34;
        short s = -34;
        unsigned short us = 2222;
        int i = 20345;
        unsigned u = 24444;
        long l = 2093435L;
        unsigned long ul = 3942345L;
        long long ll = 2093435L;

<<<<<<< HEAD
        printf("Tamaño char 2^%lu, valor: %c \n", sizeof(c), c);
        printf("Tamaño unsigned char 2^%lu, valor: %hhu \n", sizeof(uc), uc);
        printf("Tamaño short 2^%lu, valor: %d \n", sizeof(s), s);
        printf("Tamaño unsigned short 2^%lu, valor: %hu \n", sizeof(us), us);
        printf("Tamaño int 2^%lu, valor: %d \n", sizeof(i), i);
        printf("Tamaño unsigned int 2^%lu, valor: %u \n", sizeof(u), u);
        printf("Tamaño long 2^%lu, valor: %ld \n", sizeof(l), l);
        printf("Tamaño unsigned long 2^%lu, valor: %lu \n", sizeof(ul), ul);
        printf("Tamaño long long 2^%lu, valor: %lld \n", sizeof(ll), ll); 
=======
        printf("Tamaño char 2^%zu, valor: %c \n", sizeof(c), c);
        printf("Tamaño unsigned char 2^%zu, valor: %hhu \n", sizeof(uc), uc);
        printf("Tamaño short 2^%zu, valor: %d \n", sizeof(s), s);
        printf("Tamaño unsigned short 2^%zu, valor: %hu \n", sizeof(us), us);
        printf("Tamaño int 2^%zu, valor: %d \n", sizeof(i), i);
        printf("Tamaño unsigned int 2^%zu, valor: %u \n", sizeof(u), u);
        printf("Tamaño long 2^%zu, valor: %ld \n", sizeof(l), l);
        printf("Tamaño unsigned long 2^%zu, valor: %lu \n", sizeof(ul), ul);
        printf("Tamaño long long 2^%zu, valor: %lld \n", sizeof(ll), ll); 
>>>>>>> desarrollo
    }

void ej4() {
        //Ejercicio4
        int8_t int8 = 9;
        int16_t int16 = -340;
        int32_t int32 = 23000;
        int64_t int64 = -19390354;
<<<<<<< HEAD
        printf("Tamaño int8: %lu, Tamaño valor: %"PRId8 "\n", sizeof(int8), int8);
        printf("Tamaño int16: %lu, Tamaño valor: %"PRId16 "\n", sizeof(int16), int16);
        printf("Tamaño int32: %lu, Tamaño valor: %"PRId32 "\n", sizeof(int32), int32);
        printf("Tamaño int64: %lu, Tamaño valor: %"PRId64 "\n", sizeof(int64), int64);
=======
        printf("Tamaño int8: %zu, Tamaño valor: %" PRId8 "\n", sizeof(int8), int8);
        printf("Tamaño int16: %zu, Tamaño valor: %" PRId16 "\n", sizeof(int16), int16);
        printf("Tamaño int32: %zu, Tamaño valor: %" PRId32 "\n", sizeof(int32), int32);
        printf("Tamaño int64: %zu, Tamaño valor: %" PRId64 "\n", sizeof(int64), int64);
>>>>>>> desarrollo
        uint8_t uint8 = 200;
        uint16_t uint16 = 540;
        uint32_t uint32 = 73300;
        uint64_t uint64 = 850354;
<<<<<<< HEAD
        printf("Tamaño int8: %lu, Tamaño valor: %"PRId8 "\n", sizeof(uint8), uint8);
        printf("Tamaño int16: %lu, Tamaño valor: %"PRIu16 "\n", sizeof(uint16), uint16);
        printf("Tamaño int32: %lu, Tamaño valor: %"PRIu32 "\n", sizeof(uint32), uint32);
        printf("Tamaño int64: %lu, Tamaño valor: %"PRIu64 "\n", sizeof(uint64), uint64);
=======
        printf("Tamaño int8: %zu, Tamaño valor: %" PRId8 "\n", sizeof(uint8), uint8);
        printf("Tamaño int16: %zu, Tamaño valor: %" PRIu16 "\n", sizeof(uint16), uint16);
        printf("Tamaño int32: %zu, Tamaño valor: %" PRIu32 "\n", sizeof(uint32), uint32);
        printf("Tamaño int64: %zu, Tamaño valor: %" PRIu64 "\n", sizeof(uint64), uint64);
>>>>>>> desarrollo
    }

void ej5(){
    float f = 0.1f;
    double d = 0.1;
    int intf = (int) f;
    int intd = (int) d;
    printf("%d\n", intf);
    printf("%d", intd);
}

void ej6(){
    int mensaje_secreto[] = {116, 104, 101, 32, 103, 105, 102, 116, 32, 111,
    102, 32, 119, 111, 114, 100, 115, 32, 105, 115, 32, 116, 104, 101, 32,
    103, 105, 102, 116, 32, 111, 102, 32, 100, 101, 99, 101, 112, 116, 105,
    111, 110, 32, 97, 110, 100, 32, 105, 108, 108, 117, 115, 105, 111, 110};
    size_t length = sizeof(mensaje_secreto) / sizeof(int);
    char decoded[length];
<<<<<<< HEAD
    for (int i = 0; i < length; i++) {
    decoded[i] = (char) (mensaje_secreto[i]); // casting de int a char
    }
    for (int i = 0; i < length; i++) {
    printf("%c", decoded[i]);
=======
    for (size_t i = 0; i < length; i++) {
        decoded[i] = (char) (mensaje_secreto[i]); // casting de int a char
    }
    for (size_t i = 0; i < length; i++) {
        printf("%c", decoded[i]);
>>>>>>> desarrollo
    }

}

void ej7(){
    int a = 5;
    int b = 3;
    int c = 2;
    int d = 1;
    int resultado1 = a + b * c / d;
    int resultado2 = a % b;
    int resultado3_1 = a == b;
    int resultado3_2 = a != b;
    int resultado4_1 = a & b;
    int resultado4_2 = a | b;
    int resultado5 = ~a;
<<<<<<< HEAD
    int resultado6_1 = a && b;
    int resultado6_2 = a && b;
    int resultado7 = a << 1;
    int resultado8 = a >> 1;
=======
    /*int resultado6_1 = a && b;
    int resultado6_2 = a && b;*/
    int resultado7 = a << 1;
    //int resultado8 = a >> 1;
>>>>>>> desarrollo
    int resultado9_1 = a+=b;
    int resultado9_2 = a-=b;
    int resultado9_3 = a*=b;
    int resultado9_4 = a/=b;
    int resultado9_5 = a%=b;
    printf("Resultado 1: %d\n", resultado1);
    printf("Resultado 2: %d\n", resultado2);
    printf("Resultado 3: %d y %d\n", resultado3_1, resultado3_2);
    printf("Resultado 4: 0x%x y 0x%X\n", resultado4_1, resultado4_2);
    printf("Resultado 5: 0x%x\n", resultado5);
    printf("Resultado 7: %x\n", resultado7);
    printf("Resultado 9_1: %d\n", resultado9_1);
    printf("Resultado 9_2: %d\n", resultado9_2);
    printf("Resultado 9_3: %d\n", resultado9_3);
    printf("Resultado 9_4: %d\n", resultado9_4);
    printf("Resultado 9_5: %d\n", resultado9_5); 
}

void ej8(){
    int a = 4;
    int a_antes = ++a;
    printf("Valor ++a: %d\n", a_antes);
    printf("Valor a despues: %d\n", a);
    int b = 4;
    int b_despues = b++;
    printf("\nValor b++: %d\n", b_despues);
    printf("Valor b despues: %d\n", a);
} 

void ej9(){
    unsigned int a = 0xA0C91919; //2697533721
    unsigned int b = 0x84C9BF5A; //2227814234
    a = a >> 29;
    b = b << 29;
    b = b >> 29;
    int resultado1 = a == b;

    unsigned int c = 0xA0C91914; 
    unsigned int d = 0x85EF9995; 
    c = c >> 29;
    d = d << 29;
    d = d >> 29;
    int resultado2 = c==d;
    printf("Resultado 1: %d\n", resultado1);
    printf("Resultado 2: %d", resultado2);
    
}

void ej10(){
    int i = 0;
    while(i < 10){
        printf("%d\n", i);
        i++;
    }
}

void ej11(){
    int arreglo[] = {1, 2, 3, 4};
    int primeraPos = arreglo[0]; 
    for(int i = 0; i < 3; i++){
        arreglo[i] = arreglo[i+1];
    }
    arreglo[3] = primeraPos;
    for(int i = 0; i < 4; i++){
        printf("%d,", arreglo[i]);
    }
}

void ej12(int rotacion){
    int rotacionMod = rotacion % 4;
    int arreglo[] = {1, 2, 3, 4};
    int arregloCopia[] = {1, 2, 3, 4};  
    for(int i = 0; i < 4; i++){
        arreglo[(i-rotacionMod + 4) % 4] = arregloCopia[i];
    }
    for(int i = 0; i < 4; i++){
        printf("%d,", arreglo[i]);
    }
    printf("\n");
}

void ej13(){
    srand(time(NULL));
    int dado[6] = {0};
    for(int i = 1; i <= 60000000; i++){
        dado[(rand() % 6)]++; 
    }
    for(int j = 0; j < 6; j++){
        printf("Cara %d: %d\n", j+1, dado[j]);
    }
}

int factorial(int num){
    if(num == 0){
        return 1;
    }
    return num*factorial(num-1);
}

void hola1(){
    printf("soy Hola1!");
}


<<<<<<< HEAD
=======
fat32_t* new_fat32(){
    return malloc(sizeof(fat32_t));
}

fat32_t* copy_fat32(fat32_t* file){
    fat32_t* tmp = malloc(sizeof(fat32_t));
    *tmp = *file;
    return tmp;
}

void rm_fat32(fat32_t* file){
    free(file);
}

ext4_t* new_ext4(){
    return malloc(sizeof(ext4_t));
}

ext4_t* copy_ext4(ext4_t* file){
    ext4_t* tmp = malloc(sizeof(ext4_t));
    *tmp = *file;
    return tmp;
}

void rm_ext4(ext4_t* file){
    free(file);
}

ntfs_t* new_ntfs(){
    return malloc(sizeof(ntfs_t));
}

ntfs_t* copy_ntfs(ntfs_t* file){
    ntfs_t* tmp = new_ntfs();
    *tmp = *file;
    return tmp;
}

void rm_ntfs(ntfs_t* file){
    free(file);
}

list_t* listNew(type_t t) {
    list_t* l = malloc(sizeof(list_t));
    l->type = t; // l->type es equivalente a (*l).type
    l->size = 0;
    l->first = NULL;
    l->last = NULL;
    return l;
}

void listAddFirst(list_t* l, void* data) {
    node_t* n = malloc(sizeof(node_t));
    n->previous = NULL;
    n->next = l->first;
    switch(l->type) {
        case TypeFAT32:
            n->data = (void*) copy_fat32((fat32_t*) data);
        break;
        case TypeEXT4:
            n->data = (void*) copy_ext4((ext4_t*) data);
        break;
        case TypeNTFS:
            n->data = (void*) copy_ntfs((ntfs_t*) data);
        break;
    }
    if(l->size == 0){
        l->last = n;
        l->first = n;
        l->size++;
        return;
    }
    l->first->previous = n;
    l->first = n;
    l->size++;
}

void listAddLast(list_t* l, void* data) {
    node_t* n = malloc(sizeof(node_t));
    n->next = NULL;
    n->previous = l->last;
    switch(l->type) {
        case TypeFAT32:
            n->data = (void*) copy_fat32((fat32_t*) data);
        break;
        case TypeEXT4:
            n->data = (void*) copy_ext4((ext4_t*) data);
        break;
        case TypeNTFS:
            n->data = (void*) copy_ntfs((ntfs_t*) data);
        break;
    }
    if(l->size == 0){
        l->first = n;
        l->last = n;
        l->size++;
        return;
    }
    l->last->next = n;
    l->last = n;
    l->size++;
}

//se asume: i < l->size
void* listGet(list_t* l, uint8_t i){
    node_t* n = l->first;
    if(i < (l->size-1)/2){
        for(uint8_t j = 0; j < i; j++){
            n = n->next;
        }
    }else{
        for(uint8_t j = l->size-1; j > i; j--){
            n = n->next;
        }
    }
    return n->data;
}
//se asume: i < l->size
void* listRemove(list_t* l, uint8_t i){
    node_t* n = l->first;
    if(i == 0){
        l->first = l->first->next;
        if(l->size == 1){
            l->last = NULL;
        }else{
            l->first->previous = NULL;
        }
    }else if(i == l->size-1){
        n = l->last;
        l->last = l->last->previous;
        l->last->next = NULL;
    }else{
        for(uint8_t j = 0; j < i; j++){
            n = n->next;
        }
        n->previous->next = n->next;
        n->next->previous = n->previous;
    }
    void* data = n->data;
    free(n->data);
    free(n);
    l->size--;
    return data;
}
void listDelete(list_t* l){
    node_t* n = l->first;
    while(n){
        node_t* tmp = n;
        n = n->next;
        switch(l->type) {
            case TypeFAT32:
                rm_fat32((fat32_t*) tmp->data);
            break;
            case TypeEXT4:
                rm_ext4((ext4_t*) tmp->data);
            break;
            case TypeNTFS:
                rm_ntfs((ntfs_t*) tmp->data);
            break;
        }
        free(tmp);
    }
    free(l);
}

void printLista(list_t* l){
    node_t* n = l->first;
    switch(l->type) {
        case TypeFAT32:
            for(int i = 0; i < l->size; i++){
                printf("%"PRIu32"\n", *(fat32_t*)n->data);
                n = n->next;
            }
        break;
        case TypeEXT4:
        for(int i = 0; i < l->size; i++){
            printf("%"PRIu16"\n", *(ext4_t*) n->data);
            n = n->next;
        }
        break;
        case TypeNTFS:
            for(int i = 0; i < l->size; i++){
                printf("%"PRIu8"\n", *(ntfs_t*)(n->data));
                n = n->next;
            }
        break;
        } 
}

//se asume: i < l->size
node_t* listGetNodo(list_t* l, uint8_t i){
    node_t* n = l->first;
    for(uint8_t j = 0; j < i; j++){
        n = n->next;
    }
    return n;
}

//se asume que i y j < l->size
void cambiarOrdenLista(list_t* l, uint8_t i, uint8_t j){
    if(l->size <= 1){
        return;
    }
    node_t* nodo1 = listGetNodo(l, i);
    node_t* nodo2 = listGetNodo(l, j);
    void* data1 = nodo1->data;
    nodo1->data = nodo2->data;
    nodo2->data = data1;
}
>>>>>>> desarrollo
