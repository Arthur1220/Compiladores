%{
#include <stdio.h>
#include <stdlib.h>

FILE *entrada;
FILE *saida;
%}

%%
[0-9]+ { fprintf(saida, "Numero "); }
[+] { fprintf(saida, "Soma "); }
[-] { fprintf(saida, "Subtração "); }
[(] { fprintf(saida, "Abre_parenteses "); }
[)] { fprintf(saida, "Fecha_parenteses "); }
[\n]   { fprintf(saida, "\n"); }  // Pula linha no arquivo de saída
[ \t]   ;  // Ignora espaços e tabulações
.    { fprintf(saida, "Rejeita "); }  // Captura qualquer outro caractere não reconhecido
%%

int main() {
    entrada = fopen("entrada.txt", "r");
    if (!entrada) {
        perror("Erro ao abrir o arquivo de entrada");
        exit(1);
    }

    saida = fopen("tabela.txt", "w");
    if (!saida) {
        perror("Erro ao abrir o arquivo de saída");
        fclose(entrada);
        exit(1);
    }

    yyin = entrada;
    yylex();

    fclose(entrada);
    fclose(saida);

    return 0;
}
