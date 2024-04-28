/// @author Xiaoyuan Yu
/// @date   2024-04-27

#ifndef __DATA_GENERATOR_H
#define __DATA_GENERATOR_H

#include "data_type.h"
#include "common.h"

/// @brief type for a value-to-value math-function
typedef array_t_value_typedef simple_function_t(array_t_value_typedef);

/// @brief Linear array data generator, create a new array.
/// @param a The array where data should be saved.
/// @param begin The begin value of linear data.
/// @param step The step which each value increases.
/// @param size The size of the array.
/// @return Linear data array object.
array_t linear_data_generator(
    array_t a,
    array_t_value_typedef begin, 
    array_t_value_typedef step);

/// @brief Funtion defined value creator. `dest` = f(`src`)
/// @param dest output value of the function `f`
/// @param src input value of the function `f`
/// @param f function which defines a value-to-value mapping
void function_data_generator(
    array_t dest,
    array_t src,
    simple_function_t f);

/// @brief Add two arrays.
/// @param a1 Addend.
/// @param a2 Addend.
/// @param sum Sum.
/// @return Sum array.
array_t array_addition(array_t a1, array_t a2, array_t sum);

/// @brief Add two vectors.
/// @param a1 Addend.
/// @param a2 Addend.
/// @param sum Sum.
/// @return Sum vector.
vector_t vector_addition(vector_t a1, vector_t a2, vector_t sum);

array_t number_multiplication_array(array_t_value_typedef x, array_t a, array_t prod);

#endif
