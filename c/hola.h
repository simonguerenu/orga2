#ifndef HOLA_H
#define HOLA_H
<<<<<<< HEAD

void hola1(void);
=======
#include "type.h" 


list_t* listNew(type_t t);
void listDelete(list_t* l);
void listAddFirst(list_t* l, void* data);
void* listGet(list_t* l, uint8_t i);
void* listRemove(list_t* l, uint8_t i);
void listAddLast(list_t* l, void* data); 
void printLista(list_t* l);
void cambiarOrdenLista(list_t* l, uint8_t i, uint8_t j);
>>>>>>> desarrollo

#endif