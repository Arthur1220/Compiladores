%{
#include <stdio.h>
#include <stdlib.h>

FILE *entrada;
FILE *saida;
%}

%%
[1-9][0-9]* { fprintf(saida, "Numero "); }
[a-z]+ { fprintf(saida, "Identificador "); }
0 { fprintf(saida, "Rejeita"); }
[=] { fprintf(saida, "Atribuicao "); }
[+] { fprintf(saida, "Operador de soma "); }
%%

int main() {
    // Nome do arquivo de entrada definido diretamente no codigo
    entrada = fopen("entrada.txt", "r");
    if (!entrada) {
        perror("Erro ao abrir o arquivo de entrada");
        exit(1);
    }

    saida = fopen("tabela", "w");
    if (!saida) {
        perror("Erro ao criar o arquivo de saida");
        fclose(entrada);
        exit(1);
    }

    yyin = entrada;
    yylex();

    fclose(entrada);
    fclose(saida);

    return 0;
}
