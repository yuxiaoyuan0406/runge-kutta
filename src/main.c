#include <stdio.h>
#include <math.h>
#include <time.h>
#include "rk.h"
#include "data_generator.h"
#include "data_type.h"
#include "util.h"

#define SIMULATION_DURATION         (2.0)       // second
#define SIMULATION_LENGTH           (2000000)   // steps
#define SIMULATION_STEP_DURATION    (SIMULATION_DURATION / SIMULATION_LENGTH)

#define PI (4*atan(1))

const array_t_value_typedef mass = 7.45e-7;
const array_t_value_typedef spring_coef = 5.623;
const array_t_value_typedef dumping_coef = 4.95e-6;

array_t_value_typedef normal_spr_coef;
array_t_value_typedef normal_dmp_coef;

void* f(array_t dz, array_t z, array_t_value_typedef t, bool is_half, void * par)
{
    array_t_size_typedef index = *(array_t_size_typedef *)((void **)par)[0];
    vector_t v = (vector_t)((void **)par)[1];
    array_t_value_typedef a = 0;
    if (is_half)
        if (v->member[0]->val[index] < t && t < v->member[0]->val[index+1])
            a = (v->member[1]->val[index] + v->member[1]->val[index+1])/2;
        else
            return NULL;
    else
        if (t == v->member[0]->val[index])
            a = v->member[1]->val[index]; 
        else if (t == v->member[0]->val[index + 1])
            a = v->member[1]->val[index + 1]; 
        else
            return NULL;

    dz->val[0] = z->val[1];
    dz->val[1] = -normal_spr_coef * z->val[0] - normal_dmp_coef * z->val[1] + a;

    return NULL;
}

double input_generator(double x)
{
    return 0.00004 * sin(2*PI * 50*x);
}




int main() {
    normal_spr_coef = spring_coef / mass;
    normal_dmp_coef = dumping_coef / mass;

    vector_t a_in = new_vector(2, SIMULATION_LENGTH);
    linear_data_generator(a_in->member[0], 0, SIMULATION_STEP_DURATION);
    function_data_generator(a_in->member[1], a_in->member[0], input_generator);

    vector_t z = new_vector(2, SIMULATION_LENGTH);

    // initial condition
    z->member[0]->val[0] = 0;
    z->member[1]->val[0] = 0;

    array_t z_tmp = new_array(2);
    array_t z_next = new_array(2);

    void *extra_par[2];

    for (array_t_size_typedef i = 0; i < SIMULATION_LENGTH - 1; i++)
    {
        if(i % 10000 == 0)
            update_progress_bar(i, SIMULATION_LENGTH-1);

        z_tmp->val[0] = z->member[0]->val[i];
        z_tmp->val[1] = z->member[1]->val[i];

        extra_par[0] = (void*)&i;
        extra_par[1] = (void*)a_in;

        runge_kutta_next_step(z_next, z_tmp, a_in->member[0]->val[i], SIMULATION_STEP_DURATION, f, extra_par);
        z->member[0]->val[i+1] = z_next->val[0];
        z->member[1]->val[i+1] = z_next->val[1];
    }
    putchar('\n');

    array_t out_raw[4] = {a_in->member[0], a_in->member[1], z->member[0], z->member[1]};
    vector_t out = combine_to_vector(4, out_raw);
    
    FILE *param_file, *output_file;
    open_data_files(&param_file, &output_file, "data");
    

    save_vector_data(out, output_file);
    fclose(output_file);
    save_simulation_param(
        param_file, 
        SIMULATION_DURATION, 
        SIMULATION_LENGTH, 
        SIMULATION_STEP_DURATION, 
        mass, 
        spring_coef, 
        dumping_coef);

    return 0;
}
