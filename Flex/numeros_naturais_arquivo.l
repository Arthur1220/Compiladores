%{
#include <stdio.h>
#include <stdlib.h>

FILE *saida;  // Declara o arquivo de saída
%}

%%

[1-9][0-9]*  { fprintf(saida, "NÚMERO NATURAL\n"); }
.            { fprintf(saida, "ERRO\n"); }
\n           { /* Ignora nova linha */ }

%%

int main() {
    FILE *entrada = fopen("entrada.txt", "r");  // Abre o arquivo de entrada
    if (!entrada) {
        printf("Erro ao abrir o arquivo de entrada.\n");
        return 1;
    }

    saida = fopen("tabela.txt", "w");  // Abre o arquivo de saída
    if (!saida) {
        printf("Erro ao abrir o arquivo de saída.\n");
        fclose(entrada);
        return 1;
    }

    // Define a entrada do Flex para o arquivo de entrada
    yyin = entrada;

    // Executa o analisador léxico
    yylex();

    // Fecha os arquivos
    fclose(entrada);
    fclose(saida);

    printf("Processamento concluído. Confira o arquivo 'tabela.txt' para a saída.\n");
    return 0;
}
