#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "utils.h"

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

void request_input(char *input){
    fgets(input, 255, stdin);
    for(size_t i = 0; i < strlen(input); i++)
        if(input[i] == '\n')
            input[i] = '\0';
}

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

void print_menu(){
    printf(" ---------------\n");
    printf("| Spiral Matrix |\n");
    printf(" ---------------\n");
    printf("[0] User Guide\n");
    printf("[1] Generate\n");
    printf("[2] Save\n");
    printf("[3] Load\n");
    printf("[4] Print\n");
    printf("[5] Exit\n>> ");
}

void print_guide(){
    printf(" ========================== Welcome to the Matrix Generator program! ===========================\n");
    printf("| <Option 0>  You get a quick overview of the program's functionality. [Required input(s): none]|\n");
    printf("| <Option 1>  Generating a matrix. [Required input(s): dimension, direction, rotatiton.] \t|\n");
    printf("| <Option 2>  You can save your current matrix into the system. [Required input(s): none.]\t|\n");
    printf("| <Option 3>  Loading a custom matrix from a file is also an option. [Required input(s): file]  |\n");
    printf("| <Option 4>  Printing the currently saved matrix on the terminal. [Required input(s): none.]\t|\n");
    printf("| <Option 5>  When you're done using the program, press 5 to exit. [Required input(s): none.]\t|\n");
    printf(" ===============================================================================================\n>> ");
}

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

void print_matrix(int **matrix, int dimension){
    for (int i = 0; i < dimension; i++) {
        for (int j = 0; j < dimension; j++) {
            printf("%4d", matrix[i][j]);
        }
        printf("\n");
    }
    printf(">> ");
}

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
