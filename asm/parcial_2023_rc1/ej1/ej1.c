#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ej1.h"
#define ATTACKuNIT_CLASE_OFFSET 0
#define ATTACKUNIT_COMBUSTIBLE_OFFSET 12
#define ATTACKUNIT_REFERENCES_OFFSET 14
#define ATTACKUNIT_SIZE 16
/**
 * Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - optimizar
 */
bool EJERCICIO_1A_HECHO = true;

/**
 * Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - contarCombustibleAsignado
 */
bool EJERCICIO_1B_HECHO = true;

/**
 * Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - modificarUnidad
 */
bool EJERCICIO_1C_HECHO = true;

/**
 * OPCIONAL: implementar en C
 */
void optimizar(mapa_t mapa, attackunit_t* compartida, uint32_t (*fun_hash)(attackunit_t*)) {
    attackunit_t** mapaArr = (attackunit_t**) mapa;
    for(int i = 0; i < 255*255; i++){
        attackunit_t* unidadActual = mapaArr[i];
        if(unidadActual == NULL){
            continue;
        }else if(unidadActual == compartida){
            continue;
        }
        if(fun_hash(compartida) == fun_hash(unidadActual)){
            if(unidadActual->references == 1){
                free(unidadActual);
            }else{
                unidadActual->references--;
            }
            compartida->references++;
            mapaArr[i] = compartida;
        }
    }
}

/**
 * OPCIONAL: implementar en C
 */
uint32_t contarCombustibleAsignado(mapa_t mapa, uint16_t (*fun_combustible)(char*)) {
    attackunit_t** mapaArr = (attackunit_t**) mapa;
    uint32_t contador = 0;
    for(int i = 0; i < 255*255; i++){
        attackunit_t* unidadActual = mapaArr[i];
        if(unidadActual == NULL){
            continue;
        }
        contador += unidadActual->combustible - fun_combustible(unidadActual->clase);
    }
    return contador;
}

/**
 * OPCIONAL: implementar en C
 */
void modificarUnidad(mapa_t mapa, uint8_t x, uint8_t y, void (*fun_modificar)(attackunit_t*)) {
    attackunit_t** mapaArr = (attackunit_t**) mapa;
    uint16_t pos = (uint16_t) 255*x + y;
    attackunit_t* unidad = mapaArr[pos];
    if(unidad == NULL){
        return;
    }else if(unidad->references > 1){
        unidad->references--;
        attackunit_t* unidadModificada = (attackunit_t*) malloc(ATTACKUNIT_SIZE);
        *unidadModificada = *unidad;
        unidadModificada->references = 1;
        fun_modificar(unidadModificada);
        mapaArr[pos] = unidadModificada;
    }else{
        fun_modificar(unidad);
    }

}
