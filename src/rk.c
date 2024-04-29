/// @author Xiaoyuan Yu
/// @date   2024-04-27
#include "rk.h"

array_t runge_kutta_next_step(
    array_t next_y, 
    array_t this_y, 
    array_t_value_typedef this_x, 
    array_t_value_typedef step_x, 
    binary_function f, 
    void *par)
{
    array_t k[4];
    for (size_t i = 0; i < 4; i++)
    {
        k[i] = new_array(2);
    }
    array_t jump_y = new_array(2);
    array_t jump = new_array(2);

    /// k_0 = f(x_n, y_n)
   f(k[0], this_y, this_x, false, par);
    number_multiplication_array(step_x/2, k[0], jump);
    array_addition(this_y, jump, jump_y);

    /// k_1 = f(x_n + h/2, y_n + k_1 * h/2)
    f(k[1], jump_y, this_x + step_x/2, true, par);
    number_multiplication_array(step_x/2, k[1], jump);
    array_addition(this_y, jump, jump_y);

    /// k_2 = f(x_n + h/2, y_n + k_2 * h/2)
    f(k[2], jump_y, this_x + step_x/2, true, par);
    number_multiplication_array(step_x, k[2], jump);
    array_addition(this_y, jump, jump_y);

    /// k_3 = f(x_n + h, y_n + k_3 * h)
    f(k[3], jump_y, this_x + step_x, false, par);

    /// 2*k_1
    number_multiplication_array(2, k[1], k[1]);
    /// 2*k_2
    number_multiplication_array(2, k[2], k[2]);

    /// k_3 = k_0 + 2*k_1 + 2*k_2 + k_3
    for (size_t i = 0; i < 3; i++)
    {
        array_addition(k[i], k[3], k[3]);
    }
    
    /// (k_0 + 2*k_1 + 2*k_2 + k_3)*h/6
    number_multiplication_array(step_x / 6, k[3], k[3]);
    /// y_n + (k_0 + 2*k_1 + 2*k_2 + k_3)*h/6 = y_{n+1}
    array_addition(this_y, k[3], next_y);
    
    for (size_t i = 0; i < 4; i++)
    {
        del_array(k[i]);
    }
    del_array(jump);
    del_array(jump_y);
 
    return next_y;
}