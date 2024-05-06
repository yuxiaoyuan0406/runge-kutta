/// @author Xiaoyuan Yu
/// @date   2024-04-27
/// @brief  Simple data generator and copier.

#ifndef __DATA_GENERATOR_H
#define __DATA_GENERATOR_H

#include "common.h"
#include "data_type.h"

/// @brief type for a value-to-value math-function
typedef array_t_value_typedef simple_function_t(array_t_value_typedef);

/// @brief Linear array data generator, create a new array.
/// @param a The array where data should be saved.
/// @param begin The begin value of linear data.
/// @param step The step which each value increases.
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
/// @param sum Sum.
/// @param a1 Addend.
/// @param a2 Addend.
/// @return Sum array.
array_t array_addition(array_t sum, array_t a1, array_t a2);

/// @brief Copy array.
/// @param dest Copy to.
/// @param src Copy from.
/// @return Destination.
array_t array_copy(array_t dest, array_t src);

/// @brief Add two vectors.
/// @param sum Sum.
/// @param a1 Addend.
/// @param a2 Addend.
/// @return Sum vector.
vector_t vector_addition(vector_t sum, vector_t a1, vector_t a2);

/// @brief Array multiplied with a number.
/// @param prod The product array.
/// @param x The number to multiply.
/// @param a Tha array to multiply.
/// @return The product array.
array_t number_multiplication_array(array_t prod, array_t_value_typedef x, array_t a);

#endif
