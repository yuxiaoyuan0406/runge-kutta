/// @author Xiaoyuan Yu
/// @date   2024-04-27

#include "data_generator.h"

array_t linear_data_generator(array_t_value_typedef begin, array_t_value_typedef step, array_t_size_typedef size)
{
    array_t a = new_array(size);
    if(!a)
        return a;

    for (array_t_size_typedef i = 0; i < size; i++)
        a->val[i] = begin+i*step;

    return a;
}

void function_data_generator(array_t dest, array_t src, simple_function_t f)
{
    if(!IS_SAME_SIZE(dest, src))
    {
        fprintf(stderr, "Expecting same size array.\n");
        return;
    }

    for (array_t_size_typedef i = 0; i < dest->size; i++)
        dest->val[i] = f(src->val[i]);
}

