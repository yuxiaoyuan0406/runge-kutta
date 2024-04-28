/// @author Xiaoyuan Yu
/// @date   2024-04-27

#ifndef __DATA_TYPE_H
#define __DATA_TYPE_H

#include "common.h"
#include <stdbool.h>

/// Basic data type and data object function.

/// @brief check if two array data object is same size
#define IS_SAME_SIZE(a,b) ((a)->size == (b)->size)

/// @brief check if `v` is a none-zero value
#define CHECK_NONE_ZERO(v, msg) if(!(v)) fprintf(stderr, msg)

/// @brief size type of array data
typedef uint32_t array_t_size_typedef;
/// @brief value type of array data
typedef double array_t_value_typedef;

/// @brief Array data type. 
/// @note Once created, array size should never be changed.
typedef struct _array
{
    const array_t_size_typedef size;
    array_t_value_typedef val[];
}*array_t;

/// @brief size type of vector data
typedef array_t_size_typedef vector_t_dim_typedef;

/// @brief Vector data type
/// @note Once created, vector dimension should never be changed.
typedef struct _vector
{
    const vector_t_dim_typedef dim;
    array_t member[];
}*vector_t;


/// @brief Create a new array object with given size.
/// @param size size of array to create
/// @return New array object created with given size.
array_t new_array(array_t_size_typedef size);

/// @brief Delete an array object and free the space.
/// @param a Array to be deleted.
void del_array(array_t a);

/// @brief Create a new vector object with given dimension, have an empty member list.
/// @param dim Vector dimension.
/// @return New empty vector object.
vector_t new_empty_vector(vector_t_dim_typedef dim);

/// @brief Create a new vector object with given dimension, using array as member.
/// @param v_dim Vector dimension.
/// @param a_size Array length.
/// @return New vector object create with given dimension.
vector_t new_vector(vector_t_dim_typedef v_dim, array_t_size_typedef a_size);

/// @brief Delete a vector object and free the space.
/// @param v Vector to be deleted.
/// @param deep_free Whether to free array as well.
void del_vector(vector_t v, bool deep_free);

/// @brief Create a new vector contains a list of array object.
/// @param dim Vector dimension, should be same to the length of array list.
/// @param a List of array object, should be same length.
/// @return New vector combining array list.
vector_t combine_to_vector(vector_t_dim_typedef dim, array_t a[]);

/// @brief Save the data of a array type to text-base file.
/// @param a Array data object.
/// @param f File handle.
/// @return how many lines saved
array_t_value_typedef save_array_data(
    array_t a,
    FILE * f);

/// @brief Save the data of a vector object to text-base file, assuming all array member are of same size.
/// @param v Vector data object.
/// @param f File handle.
/// @return How many lines saved.
array_t_size_typedef save_vector_data(
    vector_t v,
    FILE* f);

#endif
