let fibonacci = fn(n) {
    if (n < 2) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
};

puts(fibonacci(25));
