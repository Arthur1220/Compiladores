%{
#include <stdio.h>
%}

%%
[a-zA-Z][a-zA-Z0-9]*  { printf("Identificador: %s\n", yytext); }
[0-9]+                  { printf("Número inteiro: %s\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}