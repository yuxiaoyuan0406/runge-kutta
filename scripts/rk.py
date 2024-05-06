import numpy as np
import matplotlib.pyplot as plt

from scipy.integrate import odeint

mass = 7.45e-7
spring_coef = 5.623
dumping_coef = 4.95e-6

normal_spr_coef = spring_coef/mass
normal_dmp_coef = dumping_coef/mass

def a(t):
    return 0.0004 * np.sin(2*np.pi * 50 * t)

def f(y,t,k,b):
    z1, z2 = y
    dydt = [
        z2,
        -k*z1 -b*z2 + a(t)
    ]
    return dydt

def f1(y,t):
    z1, z2 = y
    dydt = [
        z2,
        -normal_spr_coef*z1 -normal_dmp_coef*z2 + a(t)
    ]
    return np.array(dydt)

def runge_kutta(func, t_0, y_0, h):
    '''
    -
    '''
    k_0 = func(y=y_0, t=t_0)
    k_1 = func(y=y_0 + h/2 * k_0, t=t_0 + h/2)
    k_2 = func(y=y_0 + h/2 * k_1, t=t_0 + h/2)
    k_3 = func(y=y_0 + h * k_2, t=t_0 + h)

    k = 1./6. * (k_0 + 2*k_1 + 2*k_2 + k_3)

    t_1 = t_0 + h
    y_1 = y_0 + h * k

    return t_1, y_1

t_0 = 0.
y_0 = [0.,0.]

h = 1e-6

t = np.array([t_0])
y = np.array([y_0])

_t = t_0
_y = y_0
for i in range(2000000-1):
    _t, _y = runge_kutta(f1, _t, _y, h)
    np.append(t, _t)
    np.append(y, _y)


# y0 = [0.,0.]
# t = np.linspace(0.,2., num=2000000)

# sol = odeint(f, y0, t, args=(normal_spr_coef, normal_dmp_coef))

plt.plot(t, y[:][0], 'blue', label='x(t)')
# plt.plot(t, sol[:, 0], 'blue', label='x(t)')
# plt.plot(t, sol[:, 1], 'green', label='v(t)')
# plt.legend(loc='best')
plt.xlabel('t')
plt.grid()
plt.show()


