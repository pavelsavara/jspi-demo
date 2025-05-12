#include <stdio.h>
#include <emscripten.h>

extern char* fetchmono();

EMSCRIPTEN_KEEPALIVE
int main() {
    printf("Hello, World!\n");
    return 0;
}

static int state = 0;

EMSCRIPTEN_KEEPALIVE
int mono() {
    state++;

    // current SP
    printf("Current SP: %p \n", __builtin_frame_address(0));

    printf("Before fetch \n");
    char* result = fetchmono();
    printf("After fetch: %s \n", result);
    free(result);
    state--;
    return 0;
}

EMSCRIPTEN_KEEPALIVE
int remono() {
    printf("Re-entered %d \n", state);
    printf("Current SP: %p \n", __builtin_frame_address(0));
    return 0;
}