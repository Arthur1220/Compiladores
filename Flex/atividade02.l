%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
[1-9][0-9]* printf("Numero ");
[a-z]+ printf("Identificador ");
0 printf("Erro");
[=] printf("Atribuicao ");
[+] printf("Operador de soma ");
%%
int main() {
var = yylex();
return(0);
}
