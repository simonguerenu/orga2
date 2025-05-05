#include "ej1.h"
#define TEMPLO_SIZE 24

uint32_t cuantosTemplosClasicos_c(templo *temploArr, size_t temploArr_len){
    uint32_t cantTemplosClasicos = 0;
    for(size_t i = 0; i < temploArr_len; i++){
        if(temploArr[i].colum_largo == 2*temploArr[i].colum_corto+1){
            cantTemplosClasicos++;
        }
    }
    return cantTemplosClasicos;
}

templo* templosClasicos_c(templo *temploArr, size_t temploArr_len){
    uint32_t cantTemplosClasicos = cuantosTemplosClasicos_c(temploArr, temploArr_len);
    templo* templosClasicosArr = malloc(cantTemplosClasicos * TEMPLO_SIZE);
    templo* index_templosClasicosArr = templosClasicosArr;
    for(size_t i = 0; i < temploArr_len; i++){
        if(temploArr[i].colum_largo == 2*temploArr[i].colum_corto+1){
            *index_templosClasicosArr = temploArr[i];
            index_templosClasicosArr++;
        }
    }
    return templosClasicosArr;
}
