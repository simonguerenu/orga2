#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
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
    int resultado2 = a % b;
    int resultado3_1 = a == b;
    int resultado3_2 = a != b;
    int resultado4_1 = a & b;
    int resultado4_2 = a | b;
    int resultado5 = ~a;
    int resultado6_1 = a && b;
    int resultado6_2 = a && b;
    int resultado7 = a << 1;
    int resultado8 = a >> 1;
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

int main(){
    ej12(0);
    ej12(1);
    ej12(2);
    ej12(3);
    ej12(4);
    ej12(5);
}

