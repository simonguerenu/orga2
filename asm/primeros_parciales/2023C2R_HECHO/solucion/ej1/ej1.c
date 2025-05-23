#include "ej1.h"
#define STRING_PROC_LIST_SIZE 16
#define STRING_PROC_NODE_SIZE 32

string_proc_list* string_proc_list_create(void){
    string_proc_list* nuevaLista = (string_proc_list*) malloc(STRING_PROC_LIST_SIZE);
    nuevaLista->first = NULL;
    nuevaLista->last = NULL;
    return nuevaLista;
}

string_proc_node* string_proc_node_create(uint8_t type, char* hash){
    string_proc_node* nuevoNodo = (string_proc_node*) malloc(STRING_PROC_NODE_SIZE);
    nuevoNodo->type = type;
    nuevoNodo->hash = hash;
    nuevoNodo->next = NULL;
    nuevoNodo->previous = NULL;
    return nuevoNodo;
}

void string_proc_list_add_node(string_proc_list* list, uint8_t type, char* hash){
    string_proc_node* nodo = string_proc_node_create(type, hash);
    if(list->last){
        list->last->next = nodo;
        nodo->previous = list->last;
        list->last = nodo;
    }else{
        list->first = nodo;
        list->last = nodo;
    }

}

char* string_proc_list_concat(string_proc_list* list, uint8_t type , char* hash){
     string_proc_node* nodoActual = list->first;
     char* nuevoHash = hash;
     while(nodoActual){
        if(nodoActual->type == type){
            char* concat = str_concat(nuevoHash, nodoActual->hash);
            if (nuevoHash != hash){
                free(nuevoHash);
            }
            nuevoHash = concat;
        }
        nodoActual = nodoActual->next;
     }
     return nuevoHash;
}


/** AUX FUNCTIONS **/

void string_proc_list_destroy(string_proc_list* list){

	/* borro los nodos: */
	string_proc_node* current_node	= list->first;
	string_proc_node* next_node		= NULL;
	while(current_node != NULL){
		next_node = current_node->next;
		string_proc_node_destroy(current_node);
		current_node	= next_node;
	}
	/*borro la lista:*/
	list->first = NULL;
	list->last  = NULL;
	free(list);
}
void string_proc_node_destroy(string_proc_node* node){
	node->next      = NULL;
	node->previous	= NULL;
	node->hash		= NULL;
	node->type      = 0;
	free(node);
}


char* str_concat(char* a, char* b) {
	int len1 = strlen(a);
    int len2 = strlen(b);
	int totalLength = len1 + len2;
    char *result = (char *)malloc(totalLength + 1);
    strcpy(result, a);
    strcat(result, b);
    return result;
}

void string_proc_list_print(string_proc_list* list, FILE* file){
        uint32_t length = 0;
        string_proc_node* current_node  = list->first;
        while(current_node != NULL){
                length++;
                current_node = current_node->next;
        }
        fprintf( file, "List length: %d\n", length );
		current_node    = list->first;
        while(current_node != NULL){
                fprintf(file, "\tnode hash: %s | type: %d\n", current_node->hash, current_node->type);
                current_node = current_node->next;
        }
}
