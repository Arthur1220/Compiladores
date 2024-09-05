
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

// Definindo os estados para o AFD de identificadores
typedef enum {
    ESTADO_INICIAL,
    ESTADO_IDENTIFICADOR,
    ESTADO_ATRIBUICAO,
    ESTADO_NUMERO,
    ESTADO_ERRO
} Estado;

// Função de transição para identificadores
Estado transicao(Estado estadoAtual, char simbolo) {
    printf("Simbolo: %c\n", simbolo);
    switch (estadoAtual) {
        case ESTADO_INICIAL:
            if (isalpha(simbolo)){
                printf("Caso 1 - Mudando para identificador\n");
                return ESTADO_IDENTIFICADOR;
            }
            break;
        case ESTADO_IDENTIFICADOR:
            if (isalpha(simbolo)){
                printf("Caso 2 - Mudando para identificador\n");
                return ESTADO_IDENTIFICADOR;
            }
            else if (simbolo == ' '){
                printf("Caso 3 - Mudando para atribuicao\n");
                return ESTADO_ATRIBUICAO;
            }
            else if (simbolo == '='){
                printf("Caso 4 - Mudando para numero\n");
                return ESTADO_NUMERO;
            }
            break;
        case ESTADO_ATRIBUICAO:
            if (simbolo == " "){
                printf("Caso 5 - Mudando para numero\n");
                return ESTADO_NUMERO;
            }
            else if (simbolo == '='){
                printf("Caso 6 - Mudando para numero\n");
                return ESTADO_NUMERO;
            }
            break;
        case ESTADO_NUMERO:
            if (simbolo == " "){
                printf("Caso 7 - Mudando para numero\n");
                return ESTADO_NUMERO;
            }
            else if (isdigit(simbolo)){
                printf("Caso 8 - Mudando para numero\n");
                return ESTADO_NUMERO;
            }
            break;
        default:
            break;
    }
    printf("Simbolo identificado como erro: %c\n", simbolo);
    return ESTADO_ERRO;
}

// Função que verifica se uma string é um identificador válido
bool verificarCadeia(const char *input) {
    Estado estadoAtual = ESTADO_INICIAL;

    for (int i = 0; i < strlen(input); i++) {
        estadoAtual = transicao(estadoAtual, input[i]);
        if (estadoAtual == ESTADO_ERRO) {
            return false;
        }
    }

    return estadoAtual == ESTADO_NUMERO;
}

int main() {
    char input[100];

    printf("Digite a cadeia: ");
    scanf("%s", input);

    if (verificarCadeia(input)) {
        printf("\nidentificador atribuicao numero\n");
    } else {
        printf("\nERROR.\n");
    }

    return 0;
}
