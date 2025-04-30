#include "ej1.h"

list_t* listNew(){
  list_t* l = (list_t*) malloc(sizeof(list_t));
  l->first=NULL;
  l->last=NULL;
  return l;
}

void listAddLast(list_t* pList, pago_t* data){
    listElem_t* new_elem= (listElem_t*) malloc(sizeof(listElem_t));
    new_elem->data=data;
    new_elem->next=NULL;
    new_elem->prev=NULL;
    if(pList->first==NULL){
        pList->first=new_elem;
        pList->last=new_elem;
    } else {
        pList->last->next=new_elem;
        new_elem->prev=pList->last;
        pList->last=new_elem;
    }
}


void listDelete(list_t* pList){
    listElem_t* actual= (pList->first);
    listElem_t* next;
    while(actual != NULL){
        next=actual->next;
        free(actual);
        actual=next;
    }
    free(pList);
}

uint8_t contar_pagos_aprobados(list_t* pList, char* usuario){
    listElem_t* actual = pList->first;
    uint8_t contador = 0;
    while(actual != NULL){
        if(actual->data->cobrador == usuario && actual->data->aprobado == 1){
            contador++;
        }
        actual = actual->next;
    }
    return contador;
}

uint8_t contar_pagos_rechazados(list_t* pList, char* usuario){
    listElem_t* actual = pList->first;
    uint8_t contador = 0;
    while(actual != NULL){
        if(actual->data->cobrador == usuario && actual->data->aprobado == 0){
            contador++;
        }
        actual = actual->next;
    }
    return contador;
}

pagoSplitted_t* split_pagos_usuario(list_t* pList, char* usuario){
    uint8_t cantPagosRechazados = contar_pagos_rechazados(pList, usuario);
    uint8_t cantPagosAprobados = contar_pagos_aprobados(pList, usuario);
    pagoSplitted_t *registroUsuario = malloc(sizeof(pagoSplitted_t));
    pago_t** listaRechazados = (pago_t**) malloc(cantPagosRechazados * sizeof(pago_t*));
    pago_t** listaAprobados = (pago_t**) malloc(cantPagosAprobados * sizeof(pago_t*));
    registroUsuario->cant_aprobados = cantPagosAprobados;
    registroUsuario->cant_rechazados = cantPagosRechazados;
    registroUsuario->aprobados = listaAprobados;
    registroUsuario->rechazados = listaRechazados;

    listElem_t* actual = pList->first;
    int contadorRechazados = 0;
    int contadorAprobados = 0; 
    while(actual != NULL){
        if(actual->data->cobrador == usuario){
            if(actual->data->aprobado){
                listaAprobados[contadorAprobados] = actual->data;
                contadorAprobados++;
            }else{
                listaRechazados[contadorRechazados] = actual->data;
                contadorRechazados++;
            }
        }
        actual = actual->next;
    }
    return registroUsuario;
}