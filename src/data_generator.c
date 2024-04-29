/// @author Xiaoyuan Yu
/// @date   2024-04-27

#include "data_generator.h"
#include <pthread.h>

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

array_t array_addition(array_t a1, array_t a2, array_t sum)
{
    // CHECK_NONE_ZERO(a1, "Error: operating on null array");
    // CHECK_NONE_ZERO(a2, "Error: operating on null array");
    // CHECK_NONE_ZERO(sum, "Error: operating on null array");
    // CHECK_NONE_ZERO(IS_SAME_SIZE(a1, a2), "Expecting to add same size array\n");
    // CHECK_NONE_ZERO(IS_SAME_SIZE(a1, sum), "Expecting to sum to a same size array\n");

    for (array_t_size_typedef i = 0; i < a1->size; i++)
    {
        sum->val[i] = a1->val[i] + a2->val[i];
    }

    return sum;
}

array_t array_copy(array_t dest, array_t src)
{
    CHECK_NONE_ZERO(IS_SAME_SIZE(dest, src), "Error: copy from different size array.");
    for (array_t_size_typedef i = 0; i < dest->size; i++)
    {
        dest->val[i] = src->val[i];
    }
    
    return dest;
}

void* thread_add_array(void* par)
{
    array_t *a = (array_t*) par;
    array_addition(*a, *(a+1), *(a+2));
    return NULL;
}

vector_t vector_addition(vector_t a1, vector_t a2, vector_t sum)
{
    // CHECK_NONE_ZERO(a1, "Error: operating on null array");
    // CHECK_NONE_ZERO(a2, "Error: operating on null array");
    // CHECK_NONE_ZERO(sum, "Error: operating on null array");
    // CHECK_NONE_ZERO(a1->dim == a2->dim, "Expecting to add same dimension vectors\n");
    // CHECK_NONE_ZERO(a1->dim == sum->dim, "Expecting to sum to same dimension vectors\n");

    pthread_t thr;

    for (vector_t_dim_typedef i = 0; i < a1->dim; i++)
    {
        // array_addition(a1->member[i], a2->member[i], sum->member[i]);
        array_t a[3] = {a1->member[i], a2->member[i], sum->member[i]};
        pthread_create(&thr, NULL, thread_add_array, (void*)a);
    }
    pthread_join(thr, NULL);
    
    return sum;
}

array_t number_multiplication_array(array_t_value_typedef x, array_t a, array_t prod)
{
    // CHECK_NONE_ZERO(IS_SAME_SIZE(a, prod), "Expecting same size array\n");

    for (array_t_size_typedef i = 0; i < a->size; i++)
    {
        prod->val[i] = x * a->val[i];
    }
    
    return prod;
}
