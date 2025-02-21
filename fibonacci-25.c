#include <stdio.h>

static unsigned long
fibonacci(unsigned long n)
{
    if (n <= 1) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int
main(void)
{
    printf("%lu\n", fibonacci(25));
}
