#include <stdlib.h>
#include "lista.h"

/**
 * Dada una lista enlazada de proyectos devuelve el `sum` más grande de ésta.
 *
 * - El `sum` más grande de la lista vacía (`NULL`) es 0.
 */
uint32_t proyecto_mas_dificil(lista_t* lista) {
    uint32_t sumaMayor = 0;
    while(lista){
        if(lista->sum > sumaMayor){
            sumaMayor = lista->sum;
        }
        lista = lista->next;
    }
	return sumaMayor;
}

/**
 * Dada una lista enlazada de proyectos y un índice en ésta setea la i-ésima
 * tarea en cero.
 *
 * - La implementación debe "saltearse" a los proyectos sin tareas
 * - Se puede asumir que el índice siempre es válido
 * - Se debe actualizar el `sum` del nodo actualizado de la lista
 */
void marcar_tarea_completada(lista_t* lista, size_t index) {
    if(!lista){
        return;
    }
    while(index > (size_t) lista->size){
        index -= (size_t) lista->size;
        lista = lista->next;
    }
    lista->sum -= lista->array[index];
    lista->array[index] = 0;
}

/**
 * Dada una lista enlazada devuelve su longitud.
 *
 * - La longitud de `NULL` es 0
 */
uint64_t lista_len(lista_t* lista) {
	uint64_t lista_length = 0;
    while(lista){
        lista_length++;
        lista = lista->next;
    }
	return lista_length;
}

/**
 * Dado un array de `size` enteros de 32 bits sin signo devuelve la cantidad de
 * ceros en ese array.
 *
 * - Un array de tamaño 0 tiene 0 ceros.
 */
uint64_t tareas_completadas(uint32_t* array, size_t size) {
	uint64_t contador_tareas_completadas = 0;
    for(size_t i = 0; i < size; i++){
        if(!array[i]){
            contador_tareas_completadas++;
        }
    }
    return contador_tareas_completadas;
}

/**
 * Dada una lista enlazada de proyectos se devuelve un array que cuenta
 * cuántas tareas completadas tiene cada uno de ellos.
 *
 * - Si se provee a la lista vacía como parámetro (`NULL`) la respuesta puede
 *   ser `NULL` o el resultado de `malloc(0)`
 * - Los proyectos sin tareas tienen cero tareas completadas
 * - Los proyectos sin tareas deben aparecer en el array resultante
 * - Se provee una implementación esqueleto en C si se desea seguir el
 *   esquema implementativo recomendado
 */
uint64_t* tareas_completadas_por_proyecto(lista_t* lista) {
    uint64_t* lista_tareas_completadas = calloc(lista_len(lista), sizeof(uint64_t));
    for(uint64_t i = 0; i < lista_len(lista); i++){
        lista_tareas_completadas[i] = tareas_completadas(lista->array, lista->size);
        lista = lista->next;
    }
    return lista_tareas_completadas;
}
