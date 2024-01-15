#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "printAll.h"
#include "inputMatrix.h"
#include "memoryMatrix.h"
#include "generateMatrix.h"
#include "saveMatrix.h"
#include "loadMatrix.h"
#include "dataFind.h"

int main()
{
    char input[255];
    char dim[255];
    char direction[255];
    char rotation[255];
    char filename[255];

    bool isgenerated = false;
    bool correct_dim;
    bool correct_dir;
    bool correct_rot;

    int dimension = 0;
    int **matrix = NULL;

    print_menu();
    do {
        request_input(input);
        if (strlen(input) == 1 && input[0] >= '0' && input[0] <= '5') {
            if (input[0] == '0') { /*PRINTING THE USER GUIDE ON THE TERMINAL*/
                print_guide();
            } else if (input[0] == '1') {
                free_matrix(matrix, dimension);
                do {
                    printf("Dimension: ");
                    request_input(dim);
                    correct_dim = (strlen(dim) == 1 && dim[0] >= '1' && dim[0] <= '9') || (strlen(dim) == 2 && ((dim[0] == '1' && (dim[1] >= '0' && dim[1] <= '9')) || (dim[0] == '2' && dim[1] == '0')));
                    if(correct_dim) {
                        dimension = atoi(dim);
                        do {
                            printf("Direction: ");
                            request_input(direction);
                            correct_dir = strcmp(direction, "left") == 0 || strcmp(direction, "right") == 0 || strcmp(direction, "up") == 0 || strcmp(direction, "down") == 0;
                            if(correct_dir){
                                do {
                                    printf("Rotation: ");
                                    request_input(rotation);
                                    correct_rot = strcmp(rotation, "cw") == 0 || strcmp(rotation, "ccw") == 0;
                                    if(correct_rot){ /*GENERATING A SPIRAL MATRIX*/
                                        malloc_matrix(&matrix, dimension);
                                        int startRow, startCol;
                                        middle_finder(&startRow, &startCol, dimension, direction, rotation);
                                        generate_matrix(matrix, &startRow, &startCol, dimension, direction, rotation);
                                    } else
                                        printf("Incorrect rotation! Options: cw, ccw.\n");
                                } while (!(correct_rot));
                            } else
                                printf("Incorrect direction! Options: up, down, left, right.\n");
                        } while (!(correct_dir));
                    }
                    else
                        printf("Incorrect dimension! Options: 1-20.\n");
                } while (!(correct_dim));
                isgenerated = true;
            } else if (input[0] == '2') { /*SAVING A GENERATED OR A LOADED MATRIX*/
                if(isgenerated)
                    save_matrix(matrix, dimension, direction[0], rotation);
                else
                    printf("Please generate or load a matrix first!\n>> ");
            } else if (input[0] == '3') {  /*LOADING A MATRIX FROM A FILE*/
                FILE *file;
                bool existing_file = false;
                free_matrix(matrix, dimension);
                do{
                    printf("Filename: ");
                    request_input(filename);
                    file = fopen(filename, "r");
                    if(file != NULL){
                        load_matrix(file, &matrix, &dimension);
                        direction_and_rotation_finder(matrix, dimension, direction, rotation);
                        fclose(file);
                        isgenerated = true;
                        existing_file = true;
                    } else
                        printf("Please enter an existing filename!\n");
                } while (existing_file == false);
            } else if (input[0] == '4') { /*PRINTING THE CURRENT MATRIX ON THE TERMINAL*/
                if(isgenerated)
                    print_matrix(matrix, dimension);
                else
                    printf("Please generate or load a matrix first!\n>> ");
            } else if (input[0] == '5') /*EXITING THE PROGRAM*/
                printf("You have exited the program!\n");
        } else
            printf("Incorrect input! Options: 1-5.\n>> ");
    } while (input[0] != '5' || strlen(input) != 1);
    free_matrix(matrix, dimension);
    return 0;
}
