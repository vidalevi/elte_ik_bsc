#include <string.h>
#ifndef DATAFIND_H
#define DATAFIND_H

void middle_finder(int *startRow, int *startCol, int dimension, char *direction, char *rotation) {
    if(dimension % 2 == 0){
        if((strcmp(direction, "right")==0 && strcmp(rotation, "ccw")==0) || (strcmp(direction, "up")==0 && strcmp(rotation, "cw")==0))
            *startRow = (dimension/2), *startCol = (dimension/2)-1;
        else if((strcmp(direction, "left")==0 && strcmp(rotation, "ccw")==0) || (strcmp(direction, "down")==0 && strcmp(rotation, "cw")==0))
            *startRow = (dimension/2)-1, *startCol = (dimension/2);
        else if((strcmp(direction, "up")==0 && strcmp(rotation, "ccw")==0) || (strcmp(direction, "left")==0 && strcmp(rotation, "cw")==0))
            *startRow = (dimension/2), *startCol = (dimension/2);
        else if((strcmp(direction, "down")==0 && strcmp(rotation, "ccw")==0) || (strcmp(direction, "right")==0 && strcmp(rotation, "cw")==0))
            *startRow = (dimension/2)-1, *startCol = (dimension/2)-1;
    } else
        *startRow = (dimension/2), *startCol = (dimension/2);
}

void direction_and_rotation_finder(int **matrix, int dimension, char *direction, char *rotation){
    int startRow, startCol, twoRow, twoCol, threeRow, threeCol;
    for (int i = 0; i < dimension; i++) {
        for (int j = 0; j < dimension; j++) {
            if(matrix[i][j] == 1) startRow = i, startCol = j;
            else if(matrix[i][j] == 2) twoRow = i, twoCol = j;
            else if(matrix[i][j] == 3) threeRow = i, threeCol = j;
        }
    }
    if(dimension == 1){
        strcpy(direction, "up"), strcpy(rotation, "cw");
    } else {
        if(startRow > twoRow && startCol == twoCol) {
            strcpy(direction, "up");
            if(twoCol < threeCol) strcpy(rotation, "cw");
            else strcpy(rotation, "ccw");
        }
        else if(startRow < twoRow && startCol == twoCol) {
            strcpy(direction, "down");
            if(twoCol > threeCol) strcpy(rotation, "cw");
            else strcpy(rotation, "ccw");
        }
        else if(startRow == twoRow && startCol < twoCol) {
            strcpy(direction, "right");
            if(twoRow < threeRow) strcpy(rotation, "cw");
            else strcpy(rotation, "ccw");
        }
        else if(startRow == twoRow && startCol > twoCol) {
            strcpy(direction, "left");
            if(twoRow > threeRow) strcpy(rotation, "cw");
            else strcpy(rotation, "ccw");
        }
    }
}

#endif