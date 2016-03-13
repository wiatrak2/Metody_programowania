CC = gcc
Flags = -Wall -std=c99

hilbert3D: main.o point_ops.o matrix.o
	$(CC) $(Flags) -o hilbert3D main.o point_ops.o matrix.o -lm

main.o: main.c matrix.h lib.h point_ops.h
	$(CC) -c $(Flags) main.c -o main.o

matrix.o: matrix.c matrix.h lib.h
	$(CC) -c $(Flags) matrix.c -o matrix.o 

point_ops.o: point_ops.c point_ops.h lib.h
	$(CC) -c $(Flags) point_ops.c -o point_ops.o