#ifndef point_ops_h
#define point_ops_h
#include "lib.h"

void move_p (point3d *point, dir *d);
point3d *new_p (point3d *point, vector *vec);
void transl (point3d *point, vector *translation);

#endif
