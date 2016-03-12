#include "point_ops.h"

void move_p (point3d *point, dir *d)
{
    point->x += d->x;
    point->y += d->y;
    point->z += d->z;
    
}

point3d *new_p (point3d *point, vector *vec)
{
    point3d *new_point = malloc(sizeof(point3d));
    new_point->x = point->x - vec->x;
    new_point->y = point->y - vec->y;
    new_point->z = point->z - vec->z;
    return new_point;
}

void transl (point3d *point, vector *translation)
{
    point->x = point->x + translation->x;
    point->y = point->y + translation->y;
    point->z = point->z + translation->z;
}
