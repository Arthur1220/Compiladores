%{
#include <stdio.h>
%}

%%
[0-9]+                  { printf("Número real: %s\n", yytext); } 
"="                     { printf("Operador de atribuição: %s\n", yytext); }
[a-z]+                  { printf("Identificador: %s\n", yytext); }
.                       { printf("Erro: caractere inválido: %s\n", yytext); } 
%%

int main() {
    yylex();
    return 0;
}