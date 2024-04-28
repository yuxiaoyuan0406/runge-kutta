/// @author Xiaoyuan Yu
/// @date   2024-04-27

#ifndef __DATA_GENERATOR_H
#define __DATA_GENERATOR_H

#include "data_type.h"
#include "common.h"

/// @brief type for a value-to-value math-function
typedef array_t_value_typedef simple_function_t(array_t_value_typedef);

/// @brief Linear array data generator, create a new array.
/// @param begin The begin value of linear data.
/// @param step The step which each value increases.
/// @param size The size of the array.
/// @return New linear data array object.
array_t linear_data_generator(
    array_t_value_typedef begin, 
    array_t_value_typedef step,
    array_t_size_typedef size);

/// @brief Funtion defined value creator. `dest` = f(`src`)
/// @param dest output value of the function `f`
/// @param src input value of the function `f`
/// @param f function which defines a value-to-value mapping
void function_data_generator(
    array_t dest,
    array_t src,
    simple_function_t f);

/// @brief Save the data of a array type to text-base file.
/// @param a Array data object.
/// @param f File handle.
/// @return how many lines saved
array_t_value_typedef save_data(
    array_t a,
    FILE * f);

#endif
