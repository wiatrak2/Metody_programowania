#ifndef point_ops_h
#define point_ops_h
#include "lib.h"

void move_p (point3d *point, dir *d); //wyznaczanie kolejnych punktów krzywej
point3d *new_p (point3d *point, vector *vec); //przesunięcie krzywej na środek układu
void transl (point3d *point, vector *translation); //przesunięcie krzywej o zadany wektor

#endif
