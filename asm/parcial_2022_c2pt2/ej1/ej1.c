#include "ej1.h"

char** agrupar_c(msg_t* msgArr, size_t msgArr_len){
    char** mensajesAgrupados = (char**) malloc(MAX_TAGS * sizeof(char*));

    for(int tag = 0; tag < MAX_TAGS; tag++){
        int tamano = 0;
        for(size_t i = 0; i < msgArr_len; i++){
            if(msgArr[i].tag == tag){
                tamano += msgArr[i].text_len;
            }
        }
        mensajesAgrupados[tag] = (char*) malloc(tamano+1);
        
    }

    for(int tag = 0; tag < MAX_TAGS; tag++){
        int offset = 0;
        for(size_t i = 0; i < msgArr_len; i++){
            if(msgArr[i].tag == tag){
                memcpy(mensajesAgrupados[tag]+offset, msgArr[i].text, msgArr[i].text_len);
                offset += msgArr[i].text_len;
            }
        }
        mensajesAgrupados[tag][offset] = '\0';
    }
    return mensajesAgrupados;
}