#include <string.h>
#include <stdio.h>
#ifndef GENERATE_H
#define GENERATE_H

void horizontal(int **matrix, int *startRow, int *startCol, int dimension, int *length, int *counter, int *decide_horizontal){
    if((*length) <= dimension && (*counter) <= (dimension*dimension)){
        for (int i = 0; i < *length; i++){
            matrix[(*startRow)][(*startCol)] = (*counter);
            (*counter)++;
            if((*decide_horizontal) % 2 == 0) (*startCol)++; // right
            else (*startCol)--; // left
        }
        (*decide_horizontal)++;
    }
}

void vertical(int **matrix, int *startRow, int *startCol, int dimension, int *length, int *counter, int *decide_vertical){
    if((*length) <= dimension && (*counter) <= (dimension*dimension)){
        for (int i = 0; i < *length; i++){
            matrix[(*startRow)][(*startCol)] = (*counter);
            (*counter)++;
            if((*decide_vertical) % 2 == 0) (*startRow)--; // up
            else (*startRow)++; // down
        }
        (*decide_vertical)++;
    }
}

void generate_matrix(int **matrix, int *startRow, int *startCol, int dimension, char *direction, char *rotation){    
    int length = 1, counter = 1, decide_horizontal, decide_vertical;
        if((strcmp(direction, "left")==0) || strcmp(direction, "right")==0){
            if((strcmp(direction, "right")==0) && (strcmp(rotation, "ccw")==0))
                decide_horizontal = 2, decide_vertical = 2;
            else if((strcmp(direction, "left")==0) && (strcmp(rotation, "ccw")==0))
                decide_horizontal = 1, decide_vertical = 1;
            else if((strcmp(direction, "right")==0) && (strcmp(rotation, "cw")==0))
                decide_horizontal = 2, decide_vertical = 1;
            else if((strcmp(direction, "left")==0) && (strcmp(rotation, "cw")==0))
                decide_horizontal = 1, decide_vertical = 2;
            while(length <= dimension && counter <= (dimension*dimension)){
                horizontal(matrix, startRow, startCol, dimension, &length, &counter, &decide_horizontal);
                vertical(matrix, startRow, startCol, dimension, &length, &counter, &decide_vertical);
                length++;
            }
        } else if((strcmp(direction, "up")==0) || strcmp(direction, "down")==0){
            if((strcmp(direction, "up")==0) && (strcmp(rotation, "ccw")==0))
                decide_horizontal = 1, decide_vertical = 2;
            else if((strcmp(direction, "down")==0) && (strcmp(rotation, "ccw")==0))
                decide_horizontal = 2, decide_vertical = 1;
            else if((strcmp(direction, "up")==0) && (strcmp(rotation, "cw")==0))
                decide_horizontal = 2, decide_vertical = 2;
            else if((strcmp(direction, "down")==0) && (strcmp(rotation, "cw")==0))
                decide_horizontal = 1, decide_vertical = 1;
            while(length <= dimension && counter <= (dimension*dimension)){
                vertical(matrix, startRow, startCol, dimension, &length, &counter, &decide_vertical);
                horizontal(matrix, startRow, startCol, dimension, &length, &counter, &decide_horizontal);
                length++;
            }
        }
    printf("Your matrix has been generated!\n>> ");
}

#endif