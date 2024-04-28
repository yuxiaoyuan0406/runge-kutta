/// @author Xiaoyuan Yu
/// @date   2024-04-27

#ifndef __DATA_TYPE_H
#define __DATA_TYPE_H

#include "common.h"

/// Basic data type and data object function.

/// @brief size type of array data
typedef uint32_t array_t_size_typedef;
/// @brief value type of array data
typedef double array_t_value_typedef;

/// @brief Array data type. 
/// 
typedef struct 
{
    const array_t_size_typedef size;
    array_t_value_typedef val[];
}*array_t;

/// @brief Create a new array object with given size.
/// @param size size of array to create
/// @return New array object created with given size.
array_t new_array(array_t_size_typedef size);

/// @brief Delete an array object and free the space.
/// @param a Array to be deleted.
void del_array(array_t a);


#endif
