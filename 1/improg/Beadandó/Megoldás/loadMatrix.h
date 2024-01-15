#include <stdio.h>
#include <string.h>
#include "memoryMatrix.h"
#ifndef LOADMATRIX_H
#define LOADMATRIX_H

void load_matrix(FILE *file, int ***matrix, int *dimension){
    *dimension = 0;
    char line[255];
    fgets(line, 255, file);
    for(size_t i = 0; i < strlen(line); i++)
        if(line[i] >= '0' && line[i] <= '9' && (line[i+1] == ' ' || line[i+1] == '\n'))
            (*dimension)++;
    malloc_matrix(matrix, *dimension);
    rewind(file);
    for (int i = 0; i < (*dimension); i++) {
        for (int j = 0; j < (*dimension); j++) {
            fscanf(file, "%d", &(*matrix)[i][j]);
        }
    }
    printf("Your matrix has been loaded!\n>> ");
}

#endif