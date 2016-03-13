#ifndef lib_h
#define lib_h
#include <stdlib.h>
typedef struct point3d{
    double x;
    double y;
    double z;
    
}point3d;

typedef struct point2d{
    double x;
    double y;
}point2d;

typedef struct dir{ //struktura trzymająca kierunek w postaci wektoru. Wyznacza kolejne przesunięcie punktu na krzywej
    double x;
    double y;
    double z;
}dir;

typedef struct vector{
    double  x;
    double  y;
    double  z;
    
}vector;


#endif
