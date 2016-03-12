#include "matrix.h"

point3d *turn (point3d *point, double k1, double k2)
{
    k1 *= RADIAN;
    k2 *= RADIAN;
    k1 *= -1;
    k2 *= -1;
    point3d *new_point = malloc(sizeof(point3d));
    new_point->x = (point->x * cos(k2)) - (point->z * sin(k2));
    new_point->y = (point->y * cos(k1)) - (point->z * cos(k2) * sin(k1)) - (point->x * sin(k1) * sin(k2));
    new_point->z = (point->z * cos(k1) * cos(k2)) + (point->y * sin(k1)) + (point->x * cos(k1) * sin(k2));
    return new_point;
}

point2d *surf(point3d *point, double d)
{
    point2d *new_point = malloc(sizeof(point2d));
    new_point->x = (point->x * d) / (point->z + d);
    new_point->y = (point->y * d) / (point->z + d);
    return new_point;
}