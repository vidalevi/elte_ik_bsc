#include <stdlib.h>
#ifndef MEMORYMATRIX_H
#define MEMORYMATRIX_H

void free_matrix(int **matrix, int dimension){
    if(matrix!=NULL){
        for (int i = 0; i < dimension; i++)
            free(matrix[i]);
        free(matrix);
    }
}

void malloc_matrix(int ***matrix, int dimension){
    *matrix = (int **)malloc(dimension * sizeof(int *));
    for (int i = 0; i < dimension; i++)
        (*matrix)[i] = (int *)malloc(dimension * sizeof(int));
}

#endif