%{
#include <stdio.h>
#include <stdlib.h>

FILE *entrada;
FILE *saida;

int abre_par = 0;  // Contador de parênteses abertos
int fecha_par = 0;  // Contador de parênteses fechados
int operadores = 0; // Contador de operadores matemáticos
int aceito = 1;     // Variável para verificar se a cadeia é aceita
%}

%%
[0-9]+ { 
    fprintf(saida, "Numero "); 
}
[+] { 
    operadores++; 
    fprintf(saida, "Soma "); 
    if (operadores > 2) aceito = 0;  // Mais de dois operadores
}
[-] { 
    operadores++; 
    fprintf(saida, "Subtração "); 
    if (operadores > 2) aceito = 0;  // Mais de dois operadores
}
[(] { 
    abre_par++; 
    fprintf(saida, "Abre_parenteses "); 
}
[)] { 
    fecha_par++; 
    fprintf(saida, "Fecha_parenteses "); 
    if (fecha_par > abre_par) aceito = 0;  // Fechou mais parênteses do que abriu
}
[\n] { 
    // Verificar se a linha é aceita: parênteses balanceados e no máximo 2 operadores
    if (abre_par != fecha_par || operadores > 2) aceito = 0;
    
    if (aceito) {
        fprintf(saida, " -> Aceita\n");  // Linha aceita
    } else {
        fprintf(saida, " -> Rejeita\n");  // Linha rejeitada
    }
    
    // Resetar contadores para a próxima linha
    abre_par = 0;
    fecha_par = 0;
    operadores = 0;
    aceito = 1;
}
[ \t] ;  // Ignora espaços e tabulações
.    { 
    // Rejeitar caracteres não reconhecidos, exceto espaços e quebras de linha
    if (yytext[0] != '\n') {  // Ignora quebra de linha
        fprintf(saida, "Rejeita "); 
        aceito = 0;  // Qualquer caractere não reconhecido faz a linha ser rejeitada
    }
}
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
