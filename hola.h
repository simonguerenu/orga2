#ifndef HOLA_H
#define HOLA_H
#include "type.h" 


list_t* listNew(type_t t);
void listAddFirst(list_t* l, void* data); //copia el dato
void* listGet(list_t* l, uint8_t i); //se asume: i < l->size
void* listRemove(list_t* l, uint8_t i); //se asume: i < l->size
void listDelete(list_t* l);
list_t* listNew(type_t t);
void listAddFirst(list_t* l, void* data);
void* listGet(list_t* l, uint8_t i);
void* listRemove(list_t* l, uint8_t i);
void listDelete(list_t* l);
void listAddLast(list_t* l, void* data); 
void printLista(list_t* l);
void cambiarOrdenLista(list_t* l, uint8_t i, uint8_t j);

#endif