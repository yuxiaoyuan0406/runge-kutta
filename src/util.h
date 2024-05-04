/// @author Xiaoyuan Yu
/// @date   2024-05-04

#ifndef __UTIL_H
#define __UTIL_H

#include "common.h"

/// @brief Create a directory if not-exists.
/// @param path The directory to check.
/// @return Status.
int create_directory(const char *path);

/// @brief Create a path.
/// @param path The path to create.
/// @return Status.
int create_path(const char *path);

/// @brief Get system date-time, store in a string.
/// @param buffer The string buffer.
/// @param max_size The size of the buffer.
/// @return The buffer.
char *system_time(char *buffer, size_t max_size);

/// @brief Save the simulation parameters to a file.
/// @param f The file handler.
/// @param duration The duration of the whole simulation.
/// @param step_count The step count of the simulation.
/// @param step_duration The duration of each step.
/// @param mass Mass(g) of the mass block.
/// @param spr_coef Spring coeficient(N/m).
/// @param dump_coef Dumping coeficient(N/(m/s)).
/// @return 
int save_simulation_param(
    FILE *f,
    double duration, 
    uint32_t step_count, 
    double step_duration, 
    double mass, 
    double spr_coef, 
    double dump_coef);



#endif
