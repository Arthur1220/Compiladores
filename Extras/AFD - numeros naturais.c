#include <stdio.h>
#include <stdbool.h>
#include <string.h>

// Definindo os estados para o AFD de identificadores
typedef enum {
    ESTADO_INICIAL,
    ESTADO_INTERMEDIARIO,
    ESTADO_ERRO
} Estado;

// Função de transição para identificadores
Estado transicao(Estado estadoAtual, char simbolo) {
    switch (estadoAtual) {
        case ESTADO_INICIAL:
            if (isdigit(simbolo)) return ESTADO_INTERMEDIARIO;
            break;
        case ESTADO_INTERMEDIARIO:
            if (isdigit(simbolo)) return ESTADO_INTERMEDIARIO;
            break;
        default:
            break;
    }
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

    return estadoAtual == ESTADO_INTERMEDIARIO;
}

int main() {
    char input[100];

    printf("Digite a cadeia: ");
    scanf("%s", input);

    if (verificarCadeia(input)) {
        printf("Cadeia valida!\n");
    } else {
        printf("Cadeia invalida.\n");
    }

    return 0;
}
