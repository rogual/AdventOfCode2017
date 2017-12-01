#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *f = fopen("aoc1.in", "rb");
    fseek(f, 0, SEEK_END);
    size_t sz = ftell(f);
    fseek(f, 0, SEEK_SET);

    char *string = (char *)malloc(sz);
    fread(string, sz, 1, f);
    fclose(f);

    unsigned long sum = 0;
    for (size_t i=0; i<sz; i++) {
        if (string[i] == string[(i + 1) % sz]) {
            sum += (string[i] - '0');
        }
    }

    printf("%lu\n", sum);
}
