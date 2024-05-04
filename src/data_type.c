/// @author Xiaoyuan Yu
/// @date   2024-04-27

#include "data_type.h"
#include "common.h"
#include "util.h"

array_t new_array(array_t_size_typedef size)
{
    CHECK_NONE_ZERO(size, "Cannot create a 0-length array\n");
    // if (size == 0)
    // {
    //     fprintf(stderr,"Cannot create a 0-length array");
    //     // exit(0);
    // }
    array_t a = malloc((sizeof(array_t_size_typedef)+size*sizeof(array_t_value_typedef)));
    // if(!a)
    //     a = malloc((sizeof(array_t_size_typedef)+size*sizeof(array_t_value_typedef)));
    if(!a)
    {
        perror("Fail to alloc new array.");
        return NULL;
    }
    *(array_t_size_typedef*)&a->size = size;
    for (array_t_size_typedef i = 0; i < size; i++)
        a->val[i] = 0;
    
    return a;
}

void del_array(array_t a)
{
    free((void *)a);
}

vector_t new_empty_vector(vector_t_dim_typedef dim)
{
    CHECK_NONE_ZERO(dim, "Cannot create a 0-dimension vector\n");
    // if (dim == 0)
    // {
    //     fprintf(stderr,"Cannot create a 0-dimension vector");
    //     // exit(0);
    // }
    
    vector_t v = malloc((sizeof(vector_t_dim_typedef)+dim*sizeof(array_t)));
    if(!v)
    {
        perror("Fail to alloc new vector.");
        return NULL;
    }
    *(vector_t_dim_typedef*)&v->dim = dim;
    
    for (vector_t_dim_typedef i = 0; i < dim; i++)
    {
        v->member[i] = NULL;
    }
    
    return v;
}

vector_t new_vector(vector_t_dim_typedef v_dim, array_t_size_typedef a_size)
{
    vector_t v = new_empty_vector(v_dim);

    for (vector_t_dim_typedef i = 0; i < v_dim; i++)
    {
        v->member[i] = new_array(a_size);
    }

    return v;
}

void del_vector(vector_t v, bool deep_free)
{
    if (deep_free)
    {
        for (vector_t_dim_typedef i = 0; i < v->dim; i++)
        {
            del_array(v->member[i]);
        }
    }
    free(v);
}

vector_t combine_to_vector(vector_t_dim_typedef dim, array_t a[])
{
    vector_t v = new_empty_vector(dim);

    for (vector_t_dim_typedef i = 0; i < dim; i++)
    {
        v->member[i] = a[i];
    }
    
    return v;
}

array_t_value_typedef save_array_data(array_t a, FILE *f)
{
    CHECK_NONE_ZERO(a, "Error: try to save an null array.\n");
    // if (!a)
    // {
    //     fprintf(stderr, "Error: try to save an null array.\n");
    // }
    
    array_t_size_typedef i;
    for (i = 0; i < a->size; i++)
    {
        fprintf(f, "%.18lf\n", a->val[i]);
    }
    return i;
}

array_t_size_typedef save_vector_data(vector_t v, FILE *f)
{
    CHECK_NONE_ZERO(v, "Error: try to save an null vector\n");

    array_t_size_typedef i;
    array_t_size_typedef total = v->member[0]->size;
    for (i = 0; i < total; i++)
    {
        if (i % (total / 200) == 0)
            update_progress_bar(i, total, "Saving progress: ");
        for (vector_t_dim_typedef j = 0; j < v->dim; j++)
        {
            fprintf(f, "%.18lf\t", v->member[j]->val[i]);
        }
        fprintf(f, "\n");
    }
    update_progress_bar(i, total, "Saving progress: ");
    
    return i;
}
