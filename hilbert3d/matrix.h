#ifndef matrix_h
#define matrix_h
#include "lib.h"
#include <stdlib.h>
#include <math.h>
#define RADIAN 0.01745329

point3d *turn(point3d *point, double k1, double k2);
point2d *surf(point3d *point, double d);

#endif
