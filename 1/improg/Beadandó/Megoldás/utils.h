#ifndef _UTILS_
#define _UTILS_
#include "utils.c"

// Main fgv-k:
void print_menu();
void print_guide();
void generate_matrix(int **matrix, int *startRow, int *startCol, int dimension, char *direction, char *rotation);
void save_matrix(int **matrix, int dimension, char direction, char *rotation);
void load_matrix(FILE *file, int ***matrix, int *dimension);
void print_matrix(int **matrix, int dimension);

// Extra fgv-k:
void free_matrix(int **matrix, int dimension);
void malloc_matrix(int ***matrix, int dimension);
void request_input(char *input);
void middle_finder(int *startRow, int *startCol, int dimension, char *direction, char *rotation);
void direction_and_rotation_finder(int **matrix, int dimension, char *direction, char *rotation);
void vertical(int **matrix, int *startRow, int *startCol, int dimension, int *length, int *counter, int *decide_vertical);
void horizontal(int **matrix, int *startRow, int *startCol, int dimension, int *length, int *counter, int *decide_horizontal);

#endif