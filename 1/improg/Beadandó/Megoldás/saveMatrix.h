#include <stdio.h>
#ifndef SAVEMATRIX_H
#define SAVEMATRIX_H

void save_matrix(int **matrix, int dimension, char direction, char *rotation){
    char filename[255];
    sprintf(filename, "spiral%d%c%s.txt", dimension, direction, rotation);
    FILE *file = fopen(filename, "w");
    for (int i = 0; i < dimension; i++) {
        for (int j = 0; j < dimension; j++) {
            fprintf(file, "%4d", matrix[i][j]);
        }
        fprintf(file, "\n");
    }
    fclose(file);
    printf("Your matrix has been saved in the %s file!\n>> ", filename);
}

#endif