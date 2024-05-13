#include <stdio.h>
#include <math.h>
#include <time.h>
#include "rk.h"
#include "data_generator.h"
#include "data_type.h"
#include "elec.h"
#include "pid.h"
#include "util.h"

/// @brief Duration of simulation (s)
#define SIMULATION_DURATION         (1.0)
/// @brief Total simulation steps
#define SIMULATION_STEPS            (2000000)
/// @brief Duration of simulation step (s)
#define SIMULATION_STEP_DURATION    (SIMULATION_DURATION / SIMULATION_STEPS)
/// @brief The simulation steps of one work period.
#define WORK_PERIOD_STEPS           (32)

/// @brief pi
#define PI (4*atan(1))

/// @brief The mass of mass block
const real mass = 7.45e-7;
/// @brief The spring coeficient
const real spring_coef = 5.623;
/// @brief The dumping coeficient
const real dumping_coef = 4.95e-6;

/// @brief The normalized spring coeficient
real normal_spr_coef;
/// @brief The normalized dumping coeficient
real normal_dmp_coef;

/// @brief The status space function of spring-dumping system. dz = A*z + B*a
/// @param dz The differentiation of the system state.
/// @param z The system state of current time.
/// @param t Current time.
/// @param is_half Is this call to calculate a half-step value.
/// @param par Extra parameters. 
/// {(pointer to current simulation step count), (input data with time sequence), (pid command for pull direction)}
/// @return nothing
void* f(array_t dz, array_t z, real t, bool is_half, void * par)
{
    array_t_size_typedef index = *(array_t_size_typedef *)((void **)par)[0];
    vector_t v = (vector_t)((void **)par)[1];
    bit_t cmd = *(bit_t *)((void **)par)[2];
    real a = 0;

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
    
    a += force_elec(z->val[0], cmd);

    dz->val[0] = z->val[1];
    dz->val[1] = -normal_spr_coef * z->val[0] - normal_dmp_coef * z->val[1] + a;

    return NULL;
}

/// @brief Generate input acceleration. A double-to-double function.
/// @param x Independent variable.
/// @return Dependent variable.
double input_generator(double x)
{
    // return 0.00004 * sin(2*PI * 50*x);
    // return 40 * sin(2*PI * 50*x);
    // return x < SIMULATION_STEP_DURATION ? 1 : 0;
    return sin(2*PI * 50*x);
}

int main() {
    // Open parameter and output file.
    // FILE *param_file, *output_file;
    // open_data_files(&param_file, &output_file, "data");
    
    // Normalize coeficients
    normal_spr_coef = spring_coef / mass;
    normal_dmp_coef = dumping_coef / mass;

    // Generate input data.
    vector_t a_in = new_vector(2, SIMULATION_STEPS);
    linear_data_generator(a_in->member[0], 0, SIMULATION_STEP_DURATION);
    function_data_generator(a_in->member[1], a_in->member[0], input_generator);
    // FILE *input_file = fopen("standard_input.dat", "r");
    // for (size_t i = 0; i < SIMULATION_STEPS; i++)
    // {
    //     char s[40];
    //     fgets(s, sizeof(s), input_file);
    //     a_in->member[1]->val[i] = strtod(s, NULL);
    // }
    // fclose(input_file);
    
    // FILE *file_sin = fopen("standard_input.dat", "w");
    // save_array_data(a_in->member[1], file_sin);
    // fclose(file_sin);

    // The output of the simulated system.
    vector_t z = new_vector(2, SIMULATION_STEPS);

    bit_t bit_stream[SIMULATION_STEPS];
    bit_stream[0] = pull_no;

    // initial condition
    z->member[0]->val[0] = 0;
    z->member[1]->val[0] = 0;

    // Temporary status of the system.
    array_t z_tmp = new_array(2);
    // The next status of the system given by Runge-Kutta methods.
    array_t z_next = new_array(2);

    // Extra parameters pass to state space equation.
    void *extra_par[3];

    // `extra_par[1]` input data
    extra_par[1] = (void*)a_in;

    bit_t cmd = pull_no;

    // main simulation loop
    for (array_t_size_typedef i = 0; i < SIMULATION_STEPS - 1; i+=(WORK_PERIOD_STEPS))
    {
        array_t_size_typedef j;
        for (j = i; j < i + WORK_PERIOD_STEPS; j++)
        {
            bit_stream[j] = cmd;
            // update temporaty status
            z_tmp->val[0] = z->member[0]->val[i];
            z_tmp->val[1] = z->member[1]->val[i];

            if (j >= SIMULATION_STEPS - 1)
                break;
            
            // update progress bar every (SIMULATION_STEPS/500) steps
            if(j % (SIMULATION_STEPS / 500) == 0)
                update_progress_bar(j, SIMULATION_STEPS-1, "Simulation progress: ");

            // update extra parameters
            extra_par[0] = (void*)&j;
            bit_t cmd_tmp = pull_no;
            extra_par[2] = (j - i) < (WORK_PERIOD_STEPS / 2) ? (void*)&cmd_tmp: (void*)&cmd;

            // Runge-Kutta methods with status space equation.
            runge_kutta_next_step(z_next, z_tmp, a_in->member[0]->val[j], SIMULATION_STEP_DURATION, f, extra_par);
            
            // Save calculate result
            z->member[0]->val[j+1] = z_next->val[0];
            z->member[1]->val[j+1] = z_next->val[1];
        }
        cmd = pid_command(z_next->val[0]);
    }
    update_progress_bar(SIMULATION_STEPS-1, SIMULATION_STEPS-1, "Simulation progress: ");

    // Combine time sequence, input sequence, output displacement, output velocity to one vector.
    array_t out_raw[] = {a_in->member[0], a_in->member[1], z->member[0]/*, z->member[1]*/};
    vector_t out = combine_to_vector(sizeof(out_raw)/sizeof(array_t) , out_raw);
    
    // Save time and i/o data.
    FILE *output_file = fopen("disp_c.dat", "w");
    save_vector_data(out, output_file);
    fclose(output_file);

    FILE *bit_file = fopen("bit_c.dat", "w");
    for (size_t i = 0; i < sizeof(bit_stream)/sizeof(bit_stream[0]); i++)
    {
        fprintf(bit_file, "%d\n", bit_stream[i]);
    }
    fclose(bit_file);
    
    // Save sumulation parameters.
    // save_simulation_param(
    //     param_file, 
    //     SIMULATION_DURATION, 
    //     SIMULATION_STEPS, 
    //     SIMULATION_STEP_DURATION, 
    //     mass, 
    //     spring_coef, 
    //     dumping_coef);
    // fclose(param_file);

    return 0;
}
