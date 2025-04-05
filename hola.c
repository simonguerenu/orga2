#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

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

        printf("Tamaño char 2^%lu, valor: %c \n", sizeof(c), c);
        printf("Tamaño unsigned char 2^%lu, valor: %hhu \n", sizeof(uc), uc);
        printf("Tamaño short 2^%lu, valor: %d \n", sizeof(s), s);
        printf("Tamaño unsigned short 2^%lu, valor: %hu \n", sizeof(us), us);
        printf("Tamaño int 2^%lu, valor: %d \n", sizeof(i), i);
        printf("Tamaño unsigned int 2^%lu, valor: %u \n", sizeof(u), u);
        printf("Tamaño long 2^%lu, valor: %ld \n", sizeof(l), l);
        printf("Tamaño unsigned long 2^%lu, valor: %lu \n", sizeof(ul), ul);
        printf("Tamaño long long 2^%lu, valor: %lld \n", sizeof(ll), ll); 
    }

void ej4() {
        //Ejercicio4
        int8_t int8 = 9;
        int16_t int16 = -340;
        int32_t int32 = 23000;
        int64_t int64 = -19390354;
        printf("Tamaño int8: %lu, Tamaño valor: %"PRId8 "\n", sizeof(int8), int8);
        printf("Tamaño int16: %lu, Tamaño valor: %"PRId16 "\n", sizeof(int16), int16);
        printf("Tamaño int32: %lu, Tamaño valor: %"PRId32 "\n", sizeof(int32), int32);
        printf("Tamaño int64: %lu, Tamaño valor: %"PRId64 "\n", sizeof(int64), int64);
        uint8_t uint8 = 200;
        uint16_t uint16 = 540;
        uint32_t uint32 = 73300;
        uint64_t uint64 = 850354;
        printf("Tamaño int8: %lu, Tamaño valor: %"PRId8 "\n", sizeof(uint8), uint8);
        printf("Tamaño int16: %lu, Tamaño valor: %"PRIu16 "\n", sizeof(uint16), uint16);
        printf("Tamaño int32: %lu, Tamaño valor: %"PRIu32 "\n", sizeof(uint32), uint32);
        printf("Tamaño int64: %lu, Tamaño valor: %"PRIu64 "\n", sizeof(uint64), uint64);
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
    for (int i = 0; i < length; i++) {
    decoded[i] = (char) (mensaje_secreto[i]); // casting de int a char
    }
    for (int i = 0; i < length; i++) {
    printf("%c", decoded[i]);
    }

}

void ej7(){
    int a = 5;
    int b = 3;
    int c = 2;
    int d = 1;
    int resultado1 = a + b * c / d;
    printf("%d", resultado1); 
}

int main(){
    ej7();
}

