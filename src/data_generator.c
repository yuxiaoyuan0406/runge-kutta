/// @author Xiaoyuan Yu
/// @date   2024-04-27

#include "data_generator.h"

array_t linear_data_generator(array_t a, array_t_value_typedef begin, array_t_value_typedef step)
{
    CHECK_NONE_ZERO(a, "Error: operating on an empty array.\n");

    for (array_t_size_typedef i = 0; i < a->size; i++)
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

