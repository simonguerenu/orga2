#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Estructuras.h"

int main() {
	nodo_t nodo3 = {NULL, 3, NULL, 7};
	nodo_t nodo2 = {&nodo3, 2, NULL, 1};
	nodo_t nodo1 = {&nodo2, 1, NULL, 3};
	lista_t lista = {&nodo1};
	assert(cantidad_total_de_elementos(&lista) == 11);
	return 0;
}
