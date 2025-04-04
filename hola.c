#include <stdio.h>

int main(){
    char c = 100;
    short s = -34;
    int i = 20345;
    long l = 20234893435L;

    printf("Tamaño: %lu, valor: %d \n", sizeof(c), c);
    printf("Tamaño: %lu, valor: %d \n", sizeof(s), s);
    printf("Tamaño: %lu, valor: %d \n", sizeof(i), i);
    printf("Tamaño: %lu, valor: %ld \n", sizeof(l), l);
}