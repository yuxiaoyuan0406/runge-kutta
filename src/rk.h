/// @author Xiaoyuan Yu
/// @date   2024-04-27

#ifndef __RK_H
#define __RK_H

#include "common.h"
#include "data_generator.h"

/// Runge-Kutta Methods
/// y' = f(x,y)
/// y_{n+1} = y_{n} + h*(k_1 + 2*k_2 + 2*k_3 +k_4)/6
/// k_1 = f(x_n, y_n)
/// k_2 = f(x_n + h/2, y_n + k_1 * h/2)
/// k_3 = f(x_n + h/2, y_n + k_2 * h/2)
/// k_4 = f(x_n + h, y_n + k_3 * h)

/// @brief the binary function type.
/////////////////////////////////////////
/// To calculate a value at point (x,y):
/// `binary_function(y', y, x, is_half, other)`
typedef void* binary_function(array_t, array_t, array_t_value_typedef, bool, void *);

/// @brief Calculate the next state using runge-kutta methods.
/// @param next The next step.
/// @param this This step.
/// @param f The binary function `f` defined by `y' = f(x,y)`.
/// @param par Other parameters pass to the binary function.
/// @return The next step.
array_t runge_kutta_next_step(array_t next_y, array_t this_y, array_t_value_typedef this_x, array_t_value_typedef step_x, binary_function f, void *par);

#endif
