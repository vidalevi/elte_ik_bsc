#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

#define N 10
#define M 20
#define S 9
#define O 2

void init_field(char game_matrix[N][M], int apples){
    for (int i = 0; i < N; i++)
        for (int j = 0; j < M; j++)
            game_matrix[i][j] = ' ';

    int appleCount = 0;
    while (appleCount != apples) {
        int randI = rand() % 10;
        int randJ = rand() % 20;
        if(game_matrix[randI][randJ] != 'a') {
            game_matrix[randI][randJ] = 'a';
            appleCount++;
        }
    }
}

void init_snake(int snake_matrix[S][O]) {
    for (int i = 0; i < S; i++){
        snake_matrix[i][0] = i;
        snake_matrix[i][1] = 0;
    }
}

void print_game(char game_matrix[N][M], int snake_matrix[S][O]) {
    char work_matrix[N][M];
    for (int i = 0; i < N; i++)
        for (int j = 0; j < M; j++)
            work_matrix[i][j] = game_matrix[i][j];
    
    for (int i = 0; i < S; i++) {
        if(i == 0) work_matrix[snake_matrix[i][0]][snake_matrix[i][1]] = '8';
        else work_matrix[snake_matrix[i][0]][snake_matrix[i][1]] = '0';
    }

    for (int i = 0; i < (M+2); i++) printf("#");
    printf("\n");
    for (int i = 0; i < N; i++)
    {
        printf("#");
        for (int j = 0; j < M; j++)
            printf("%c", work_matrix[i][j]);
        printf("#\n");
    }
    for (int i = 0; i < (M+2); i++) printf("#");
}

int update_snake(char game_matrix[N][M], int snake_matrix[S][O], char move) {
    if(move == 'w') {
        if(snake_matrix[0][0] == 0) return -1;
        
        for (int i = 0; i < (S-1); i++)
            if((snake_matrix[0][0] - 1 == snake_matrix[i][0]) && (snake_matrix[0][1] == snake_matrix[i][1])) return -2;
        
        for (int i = (S-1); i >= 1; i--) {
            snake_matrix[i][0] = snake_matrix[i-1][0];
            snake_matrix[i][1] = snake_matrix[i-1][1];
        }
        snake_matrix[0][0] -= 1;
    }
    if(move == 'a') {
        if(snake_matrix[0][1] == 0) return -1;
        
        for (int i = 0; i < (S-1); i++)
            if((snake_matrix[0][1] - 1 == snake_matrix[i][1]) && (snake_matrix[0][0] == snake_matrix[i][0])) return -2;

        for (int i = (S-1); i >= 1; i--) {
            snake_matrix[i][0] = snake_matrix[i-1][0];
            snake_matrix[i][1] = snake_matrix[i-1][1];
        }
        snake_matrix[0][1] -= 1;
    }
    if(move == 's') {
        if(snake_matrix[0][0] == 9)
            return -1;

        for (int i = 0; i < (S-1); i++)
            if((snake_matrix[0][0] + 1 == snake_matrix[i][0]) && (snake_matrix[0][1] == snake_matrix[i][1]))
                return -2;

        for (int i = (S-1); i >= 1; i--) {
            snake_matrix[i][0] = snake_matrix[i-1][0];
            snake_matrix[i][1] = snake_matrix[i-1][1];
        }
        snake_matrix[0][0] += 1;
    }
    if(move == 'd') {
        if(snake_matrix[0][1] == 19)
            return -1;

        for (int i = 0; i < (S-1); i++)
            if((snake_matrix[0][1] + 1 == snake_matrix[i][1]) && (snake_matrix[0][0] == snake_matrix[i][0]))
                return -2;

        for (int i = (S-1); i >= 1; i--) {
            snake_matrix[i][0] = snake_matrix[i-1][0];
            snake_matrix[i][1] = snake_matrix[i-1][1];
        }
        snake_matrix[0][1] += 1;
    }
    
    bool collectApple = false;
    if(game_matrix[snake_matrix[0][0]][snake_matrix[0][1]] == 'a') {
        game_matrix[snake_matrix[0][0]][snake_matrix[0][1]] = ' ';
        collectApple = true;
    }
    if(collectApple) return 1;
    else return 0;
}

int main() {
    //Deklarálás
    char input[255];
    srand(time(NULL));
    char game_matrix[N][M];
    int apples = 10;
    int snake_matrix[S][O];
    
    //Üdvözlő üzenet
    printf("\nUdvozlom a Snake jatekban. A jatek celja, hogy megegye a kigyoval az \nalmakat anelkul, hogy lefusson a palyarol vagy magaba fordulna a kigyoval.\nA kigyot az w,a,s,d billentyukkel vezerleheti. Sok sikert!\n");
    
    //Inicializálás
    init_field(game_matrix, apples);
    init_snake(snake_matrix);
    print_game(game_matrix, snake_matrix);

    //User input és játék
    int applesEaten = 0;
    bool endGame = false;
    printf("\n>> ");
    while(fgets(input, 255, stdin) != NULL && applesEaten != apples && !endGame) {
        for(size_t i = 0; i < strlen(input); i++)
            if(input[i] == '\n') input[i] = '\0';
        for (size_t i = 0; i < strlen(input); i++) {
            int result;
            if(input[i] == 'w') result = update_snake(game_matrix, snake_matrix, 'w');
            if(input[i] == 'a') result = update_snake(game_matrix, snake_matrix, 'a');
            if(input[i] == 's') result = update_snake(game_matrix, snake_matrix, 's');
            if(input[i] == 'd') result = update_snake(game_matrix, snake_matrix, 'd');
            if(result == 1) {
                applesEaten++;
                if(applesEaten == apples){
                    endGame = true;
                    print_game(game_matrix, snake_matrix);
                    printf("\nGartulalok, megetted az osszes almat. Nyertel!!!\nNyomj egy ENTERT a kilepeshez!\n");
                }
            } else if (result == -1) {
                endGame = true;
                printf("\nA jateknak vege, fallal utkoztel!\nNyomj egy ENTERT a kilepeshez!\n");
            } else if (result == -2) {
                endGame = true;
                printf("\nA jateknak vege, utkoztel sajat magaddal!\nNyomj egy ENTERT a kilepeshez!\n");
            }
        }
        if(!endGame) {
            print_game(game_matrix, snake_matrix);
            printf("\n>> ");
        }
    }
}
