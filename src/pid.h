/// @author Xiaoyuan Yu
/// @date   2024-05-10
#ifndef __PID_H
#define __PID_H

#include "common.h"

/// @brief Enum type for bit output.
typedef enum {
    /// @brief pull up mass block
    pull_up = 1,
    /// @brief pull down mass block
    pull_dn = -1,
    /// @brief no pulling
    pull_no = 0,
} bit_t;

bit_t pid_command(real disp);

#endif
