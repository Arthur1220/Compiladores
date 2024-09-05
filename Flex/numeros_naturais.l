%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
[1-9][0-9]*  { printf("NÚMERO NATURAL\n"); }
.            { printf("ERRO\n"); }
\n           { /* Ignora nova linha */ }
%%

int main() {
    printf("Digite algo para verificar (Ctrl+D para sair):\n");
    yylex();
    return 0;
}