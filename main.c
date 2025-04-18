#include <stdio.h>
#include "hola.h"
#include "type.h"
int main(){
    list_t* l = listNew(TypeEXT4);
    ext4_t dato1 = 1;
    ext4_t dato2 = 2;
    ext4_t dato3 = 3;
    ext4_t dato4 = 4;
    ext4_t dato5 = 5;
    listAddLast(l, (void*) &dato1);
    listAddLast(l, (void*) &dato2);
    listRemove(l, 0);
    printLista(l);
    printf("\n");
    cambiarOrdenLista(l, 1, 2);
    printLista(l);
    listDelete(l);
}