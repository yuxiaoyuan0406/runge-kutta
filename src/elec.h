/// @author Xiaoyuan Yu
/// @date   2024-05-10
#ifndef __ELEC_H
#define __ELEC_H

#include "common.h"
#include "data_type.h"
#include "pid.h"

/// @brief Area of the parallel plate capacitor
static const real area = 1.7388e-6;
/// @brief The gap bewteen top plate or bottom plate and the middle plate which is connected to the mass block.
static const real gap  = 3e-6;

/// @brief Vacuum dielectric constant
static const real e0   = 8.854187817e-12;

/// @brief Referenct voltage
static const real v_ref= 2.5;

/// @brief Electric force coeficient. `F_elec = coef / distance^2`
static const real coef_force_elec = 0.5 * e0 * area * (2 * v_ref) * (2 * v_ref) / 10;

real force_elec(real disp, bit_t cmd);

#endif
