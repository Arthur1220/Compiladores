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

// Definindo os estados para o AFD de n�meros naturais
typedef enum {
    ESTADO_INICIAL_NUM,
    ESTADO_INTERMEDIARIO_NUM,
    ESTADO_ERRO_NUM
} EstadoNumero;

// Fun��o de transi��o para identificadores
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

// Fun��o de transi��o para n�meros naturais
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

// Fun��o que verifica se uma string � um identificador v�lido
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

// Fun��o que verifica se uma string � um n�mero natural v�lido
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

    // Verifica��o de identificador
    printf("Digite o identificador: ");
    scanf("%s", input);

    if (verificarIdentificador(input)) {
        printf("Identificador v�lido!\n");
    } else {
        printf("Identificador inv�lido.\n");
    }

    // Verifica��o de n�mero natural
    printf("Digite o n�mero natural: ");
    scanf("%s", input);

    if (verificarNumero(input)) {
        printf("N�mero natural v�lido!\n");
    } else {
        printf("N�mero natural inv�lido.\n");
    }

    return 0;
}
