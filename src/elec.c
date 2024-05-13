#include "elec.h"
/// @author Xiaoyuan Yu
/// @date   2024-05-10

real force_elec(real disp, bit_t cmd)
{
    real distance;
    switch (cmd)
    {
    case pull_up:
    /// if pull up
        distance = gap - disp;
        return coef_force_elec / distance / distance;
    case pull_dn:
    /// if pull down
        distance = gap + disp;
        return -coef_force_elec / distance / distance;
    default:
        return (real)0;
    }
}
