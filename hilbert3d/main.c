#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "lib.h"
#include "matrix.h"
#include "point_ops.h"
FILE *file;
bool moveto;

dir *neg (dir *d)
{
    dir *new = malloc(sizeof(dir));
    new->x = - d->x;
    new->y = - d->y;
    new->z = - d->z;
    return new;
}


void print (point3d *point, double angle_x, double angle_y, double observer, vector *translation)
{
    point3d *new_point = turn(point, angle_x, angle_y);
    transl(new_point, translation);
    point2d *print_point = surf(new_point, observer);
    if (!moveto)
    {
        fprintf(file ,"%.4f %.4f moveto\n", print_point->x, print_point->y);
        moveto = true;
    }
    fprintf(file, "%.4f %.4f lineto\n", print_point->x, print_point->y);
}



void hilbert (int n, point3d *point, dir *d1, dir *d2, dir *d3, vector *vec, double angle_x, double angle_y, double observer, vector *translation)
{
    if (n > 0)
    {
        hilbert(n-1, point, d2, d3, d1, vec, angle_x, angle_y, observer, translation);
        move_p(point, d1);
        print(new_p(point, vec), angle_x, angle_y, observer, translation);
        hilbert(n-1, point, d3, d1, d2, vec, angle_x, angle_y, observer, translation);
        move_p(point, d2);
        print(new_p(point, vec), angle_x, angle_y, observer, translation);
        hilbert(n-1, point, d3, d1, d2, vec, angle_x, angle_y, observer, translation);
        move_p(point, neg(d1));
        print(new_p(point, vec), angle_x, angle_y, observer, translation);
        hilbert(n-1, point, neg(d1), neg(d2), d3, vec, angle_x, angle_y, observer, translation);
        move_p(point, d3);
        print(new_p(point, vec), angle_x, angle_y, observer, translation);
        hilbert(n-1, point, neg(d1), neg(d2), d3, vec, angle_x, angle_y, observer, translation);
        move_p(point, d1);
        print(new_p(point, vec), angle_x, angle_y, observer, translation);
        hilbert(n-1, point, neg(d3), d1, neg(d2), vec, angle_x, angle_y, observer, translation);
        move_p(point, neg(d2));
        print(new_p(point, vec), angle_x, angle_y, observer, translation);
        hilbert(n-1, point, neg(d3), d1, neg(d2), vec, angle_x, angle_y, observer, translation);
        move_p(point, neg(d1));
        print(new_p(point, vec), angle_x, angle_y, observer, translation);
        hilbert(n-1, point, d2, neg(d3), neg(d1), vec, angle_x, angle_y, observer, translation);
    }
}

int main() {
    
    int n;
    double angle_x;
    double angle_y;
    vector translation;
    double draw_size;
    double observer;
    double cube_size;
    file = fopen("test.ps", "w");
    
    n = 5;
    angle_x = 22;
    angle_y = -30;
    draw_size = 1500;
    observer = 1300;
    cube_size = ((1<<n) - 1) * 30;
    translation.x = 100;
    translation.y = 200;
    translation.z = 100;
    
    double path = cube_size / ((1<<n) - 1);

    dir d[3];
    d[0].x = path; d[0].y = 0; d[0].z = 0;
    d[1].x = 0; d[1].y = path; d[1].z = 0;
    d[2].x = 0; d[2].y = 0; d[2].z = path;
    point3d point;
    point.x = 0;
    point.y = 0;
    point.z = 0;
    vector vec;
    int v = cube_size / 2;
    vec.x = v;
    vec.y = v;
    vec.z = v;
    
    fprintf(file, "%%!PS-Adobe-2.0 EPSF-2.0\n%%%%BoundingBox: %.2lf %.2lf %.2lf %.2lf\nnewpath\n", -(draw_size / 2), -(draw_size / 2), draw_size, draw_size);
    
    print(new_p(&point, &vec), angle_x, angle_y, observer, &translation);
    hilbert(n, &point, &d[0], &d[1], &d[2], &vec, angle_x, angle_y, observer, &translation);
    
    fprintf(file, ".4 setlinewidth\nstroke\nshowpage\n%%%%Trailer\n%%EOF");
    return 0;
}
