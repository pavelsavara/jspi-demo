#include <stdio.h>
#include <emscripten.h>

extern char* fetchmono();

EMSCRIPTEN_KEEPALIVE
int main() {
    printf("Hello, World!\n");
    return 0;
}

EMSCRIPTEN_KEEPALIVE
int mono() {
    printf("Before fetch \n");
    char* result = fetchmono();
    printf("After fetch: %s \n", result);
    free(result);
    return 0;
}