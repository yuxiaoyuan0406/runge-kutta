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


typedef void* binary_function(array_t, void *);

array_t runge_kutta_next_step(array_t next, array_t this, binary_function f);

#endif
