#include <stdio.h>
#include "data_generator.h"

#include <math.h>

#define SIMULATION_LENGTH 2000000

#define PI (4*atan(1))


double input_generator(double x)
{
    return sin(2*PI*x);
}



int main() {
    vector_t z1 = new_vector(2, SIMULATION_LENGTH);
    vector_t z2 = new_vector(2, SIMULATION_LENGTH);

    linear_data_generator(z1->member[0], 0, 1e-6);

    array_addition(z1->member[0], z1->member[0], z2->member[0]);

    function_data_generator(z1->member[1], z1->member[0], input_generator);
    function_data_generator(z2->member[1], z2->member[0], input_generator);

    vector_t s = new_vector(2, SIMULATION_LENGTH);

    vector_addition(z1, z2, s);

    FILE* f = fopen("data.dat", "w");
    save_vector_data(s, f);
    fclose(f);



    return 0;
}
