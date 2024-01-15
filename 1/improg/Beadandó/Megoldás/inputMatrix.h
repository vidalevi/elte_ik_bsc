#include <stdio.h>
#include <string.h>
#ifndef INPUTMATRIX_H
#define INPUTMATRIX_H

void request_input(char *input){
    fgets(input, 255, stdin);
    for(size_t i = 0; i < strlen(input); i++)
        if(input[i] == '\n')
            input[i] = '\0';
}

#endif