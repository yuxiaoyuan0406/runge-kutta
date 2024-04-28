#include <stdio.h>
#include "data_type.h"
#include "data_generator.h"

#include <math.h>

#define SIMULATION_LENGTH 2000000

#define PI (4*atan(1))


double input_generator(double x)
{
    return sin(2*PI*x);
}

int main() {
    // printf("hello world\n");

    array_t t = linear_data_generator(0, 1e-6, SIMULATION_LENGTH);
    array_t input = new_array(SIMULATION_LENGTH);

    function_data_generator(input, t, input_generator);

    FILE* f = fopen("data.txt", "w");
    save_data(input, f);
    fclose(f);

    return 0;
}
