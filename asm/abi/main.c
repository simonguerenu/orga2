#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "ABI.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	assert(alternate_sum_4_using_c(8, 2, 5, 1) == 10);

	assert(alternate_sum_4_using_c_alternative(8, 2, 5, 1) == 10);

	//assert(alternate_sum_8(alternate_sum_4_using_c_alternative(8, 2, 5, 1), 10, 5, 2, 3, 2, 1, 4) == 1) ;

	assert(alternate_sum_8(1, 1, 1, 1, 1, 1, 1, 1) == 0);

	assert(alternate_sum_8(20, 5, 3, 1, 2, 1, 4, 3) == 19);

	return 0;
}
