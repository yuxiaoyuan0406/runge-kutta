/// @author Xiaoyuan Yu
/// @date   2024-05-10
#include "pid.h"

bit_t pid_command(real disp)
{
    static real v_int_10 = 0,
                v_int_20 = 0;
    real v_input, v_int_1, v_int_2, v_feedback, v_sum;
    v_input = -disp;
    v_int_2 = v_int_20 + 0.038 * v_int_10;
    v_feedback = -0.01139 * v_int_2;
    v_int_1 = v_int_10 + 0.06 * v_feedback + 1.55 * v_input;
    v_sum = -5 * v_input + 0.516 * v_int_1 - 0.5 * v_int_2;

    v_int_10 = v_int_1;
    v_int_20 = v_int_2;

    return v_sum >= 0 ? pull_dn : pull_up;
}