#include <stdio.h>
#ifndef PRINTALL_H
#define PRINTALL_H

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

void print_matrix(int **matrix, int dimension){
    for (int i = 0; i < dimension; i++) {
        for (int j = 0; j < dimension; j++) {
            printf("%4d", matrix[i][j]);
        }
        printf("\n");
    }
    printf(">> ");
}

#endif