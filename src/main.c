#include <stdio.h>
#include <math.h>
#include <time.h>
#include "rk.h"
#include "data_generator.h"
#include "data_type.h"
#include "util.h"

/// @brief Duration of simulation (s)
#define SIMULATION_DURATION         (2.0)
/// @brief Simulation steps
#define SIMULATION_STEPS            (2000000)
/// @brief Duration of simulation step (s)
#define SIMULATION_STEP_DURATION    (SIMULATION_DURATION / SIMULATION_STEPS)

/// @brief pi
#define PI (4*atan(1))

/// @brief The mass of mass block
const array_t_value_typedef mass = 7.45e-7;
/// @brief The spring coeficient
const array_t_value_typedef spring_coef = 5.623;
/// @brief The dumping coeficient
const array_t_value_typedef dumping_coef = 4.95e-6;

/// @brief The normalized spring coeficient
array_t_value_typedef normal_spr_coef;
/// @brief The normalized dumping coeficient
array_t_value_typedef normal_dmp_coef;

/// @brief The status space function of spring-dumping system. dz = A*z + B*a
/// @param dz The differentiation of the system state.
/// @param z The system state of current time.
/// @param t Current time.
/// @param is_half Is this call to calculate a half-step value.
/// @param par Extra parameters. 
/// {(pointer to current simulation step count), (input data with time sequence)}
/// @return nothing
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
    // Open parameter and output file.
    FILE *param_file, *output_file;
    open_data_files(&param_file, &output_file, "data");
    
    // Normalize coeficients
    normal_spr_coef = spring_coef / mass;
    normal_dmp_coef = dumping_coef / mass;

    // Generate input data.
    vector_t a_in = new_vector(2, SIMULATION_STEPS);
    linear_data_generator(a_in->member[0], 0, SIMULATION_STEP_DURATION);
    function_data_generator(a_in->member[1], a_in->member[0], input_generator);

    // The output of the simulated system.
    vector_t z = new_vector(2, SIMULATION_STEPS);

    // initial condition
    z->member[0]->val[0] = 0;
    z->member[1]->val[0] = 0;

    // Temporary status of the system.
    array_t z_tmp = new_array(2);
    // The next status of the system given by Runge-Kutta methods.
    array_t z_next = new_array(2);

    // Extra parameters pass to state space equation.
    void *extra_par[2];

    // main simulation loop
    for (array_t_size_typedef i = 0; i < SIMULATION_STEPS - 1; i++)
    {
        // update progress bar every (SIMULATION_STEPS/500) steps
        if(i % (SIMULATION_STEPS / 500) == 0)
            update_progress_bar(i, SIMULATION_STEPS-1, "Simulation progress: ");

        // update temporaty status
        z_tmp->val[0] = z->member[0]->val[i];
        z_tmp->val[1] = z->member[1]->val[i];

        // update extra parameters
        // `extra_par[0]` current loop step or status index
        // `extra_par[1]` input data
        extra_par[0] = (void*)&i;
        extra_par[1] = (void*)a_in;

        // Runge-Kutta methods with status space equation.
        runge_kutta_next_step(z_next, z_tmp, a_in->member[0]->val[i], SIMULATION_STEP_DURATION, f, extra_par);
        z->member[0]->val[i+1] = z_next->val[0];
        z->member[1]->val[i+1] = z_next->val[1];
    }
    update_progress_bar(SIMULATION_STEPS-1, SIMULATION_STEPS-1, "Simulation progress: ");

    // Combine time sequence, input sequence, output displacement, output velocity to one vector.
    array_t out_raw[4] = {a_in->member[0], a_in->member[1], z->member[0], z->member[1]};
    vector_t out = combine_to_vector(4, out_raw);
    
    // Save time and i/o data.
    save_vector_data(out, output_file);
    fclose(output_file);
    // Save sumulation parameters.
    save_simulation_param(
        param_file, 
        SIMULATION_DURATION, 
        SIMULATION_STEPS, 
        SIMULATION_STEP_DURATION, 
        mass, 
        spring_coef, 
        dumping_coef);
    fclose(param_file);

    return 0;
}
