#include "rk.h"
/// @author Xiaoyuan Yu
/// @date   2024-04-27

array_t runge_kutta_next_step(array_t next, array_t this, binary_function f)
{
    array_t k[4];
    for (size_t i = 0; i < 4; i++)
    {
        k[i] = new_array(2);
    }

    
    
    for (size_t i = 0; i < 4; i++)
    {
        del_array(k[i]);
    }
 
    return next;
}