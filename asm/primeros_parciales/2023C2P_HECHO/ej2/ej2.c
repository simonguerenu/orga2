#include "ej2.h"

void mezclarColores_c(uint8_t *X, uint8_t *Y, uint32_t width, uint32_t height) {
    uint32_t nbytes = width * height * 4;
    for (uint32_t k = 0; k < nbytes; k += 4) {
        // lees en BGRA
        uint8_t B = X[k+0], G = X[k+1], R = X[k+2];
        // aplicas la lógica sobre R, G, B
        uint8_t r2, g2, b2;
        if      (R > G && G > B) { r2 = B; g2 = R; b2 = G; }
        else if (R < G && G < B) { r2 = G; g2 = B; b2 = R; }
        else                      { r2 = R; g2 = G; b2 = B; }
        // y escribes en orden RGBA
        Y[k+0] = r2;
        Y[k+1] = g2;
        Y[k+2] = b2;
        Y[k+3] = 0;
    }
}
