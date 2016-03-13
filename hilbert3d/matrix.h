#ifndef matrix_h
#define matrix_h
#include "lib.h"
#include <stdlib.h>
#include <math.h>
#define RADIAN 0.01745329 //wartość (pi)/180 służąca do zamiany miary kąta na radiany

point3d *turn(point3d *point, double k1, double k2); //obrót krzywej za pomocą przemnożonych macierzy obrotu
point2d *surf(point3d *point, double d); //skalonwanie obrazu na 2D

#endif
