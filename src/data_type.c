/// @author Xiaoyuan Yu
/// @date   2024-04-27

#include "data_type.h"
#include "common.h"

array_t new_array(array_t_size_typedef size)
{
    if (size == 0)
    {
        fprintf(stderr,"Cannot create a 0-length array");
        // exit(0);
    }
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