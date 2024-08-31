#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#include <string.h>

// Definindo os estados para o AFD de identificadores
typedef enum {
    ESTADO_INICIAL_ID,
    ESTADO_INTERMEDIARIO_ID,
    ESTADO_ERRO_ID
} EstadoIdentificador;

// Definindo os estados para o AFD de números naturais
typedef enum {
    ESTADO_INICIAL_NUM,
    ESTADO_INTERMEDIARIO_NUM,
    ESTADO_ERRO_NUM
} EstadoNumero;

// Função de transição para identificadores
EstadoIdentificador transicaoIdentificador(EstadoIdentificador estadoAtual, char simbolo) {
    switch (estadoAtual) {
        case ESTADO_INICIAL_ID:
            if (isalpha(simbolo)) return ESTADO_INTERMEDIARIO_ID;
            break;
        case ESTADO_INTERMEDIARIO_ID:
            if (isalnum(simbolo)) return ESTADO_INTERMEDIARIO_ID;
            break;
        default:
            break;
    }
    return ESTADO_ERRO_ID;
}

// Função de transição para números naturais
EstadoNumero transicaoNumero(EstadoNumero estadoAtual, char simbolo) {
    switch (estadoAtual) {
        case ESTADO_INICIAL_NUM:
            if (isdigit(simbolo)) return ESTADO_INTERMEDIARIO_NUM;
            break;
        case ESTADO_INTERMEDIARIO_NUM:
            if (isdigit(simbolo)) return ESTADO_INTERMEDIARIO_NUM;
            break;
        default:
            break;
    }
    return ESTADO_ERRO_NUM;
}

// Função que verifica se uma string é um identificador válido
bool verificarIdentificador(const char *input) {
    EstadoIdentificador estadoAtual = ESTADO_INICIAL_ID;

    for (int i = 0; i < strlen(input); i++) {
        estadoAtual = transicaoIdentificador(estadoAtual, input[i]);
        if (estadoAtual == ESTADO_ERRO_ID) {
            return false;
        }
    }

    return estadoAtual == ESTADO_INTERMEDIARIO_ID;
}

// Função que verifica se uma string é um número natural válido
bool verificarNumero(const char *input) {
    EstadoNumero estadoAtual = ESTADO_INICIAL_NUM;

    for (int i = 0; i < strlen(input); i++) {
        estadoAtual = transicaoNumero(estadoAtual, input[i]);
        if (estadoAtual == ESTADO_ERRO_NUM) {
            return false;
        }
    }

    return estadoAtual == ESTADO_INTERMEDIARIO_NUM;
}

int main() {
    char input[100];

    // Verificação de identificador
    printf("Digite o identificador: ");
    scanf("%s", input);

    if (verificarIdentificador(input)) {
        printf("Identificador válido!\n");
    } else {
        printf("Identificador inválido.\n");
    }

    // Verificação de número natural
    printf("Digite o número natural: ");
    scanf("%s", input);

    if (verificarNumero(input)) {
        printf("Número natural válido!\n");
    } else {
        printf("Número natural inválido.\n");
    }

    return 0;
}
