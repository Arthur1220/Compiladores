%{
#include "prex.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%option noyywrap
%option yylineno

%%

\\[^\\]*\\                  { /* Ignora comentários corretamente */ }

"PROGRAMA"                 { return T_PROGRAMA; }
"PREX"                     { return T_PREX; }
"{"                        { return T_CHAVE_ABRE; }
"}"                        { return T_CHAVE_FECHA; }
";"                        { return T_PONTO_VIRGULA; }
","                        { return T_VIRGULA; }
"="                        { return T_IGUAL; }
"FLOAT"                    { return T_FLOAT; }
"CHAR"                     { return T_CHAR; }
"LISTA"                    { return T_LISTA; }
"BOOL"                     { return T_BOOL; }
"CONST"                    { return T_CONST; }
"SE"                       { return T_SE; }
"ENTAO"                    { return T_ENTAO; }
"SENAO"                    { return T_SENAO; }
"ENQUANTO"                 { return T_ENQUANTO; }
"FACA"                     { return T_FACA; }
"LER"                      { return T_LER; }
"ESCREVER"                 { return T_ESCREVER; }
"("                        { return T_PARENTESE_ABRE; }
")"                        { return T_PARENTESE_FECHA; }

[A-Za-z][A-Za-z0-9]{0,9}    { 
                                yylval.str = strdup(yytext);
                                return T_IDENTIFICADOR;
                             }

[+-]?[0-9]+,[0-9]{1,2}      { 
                                if (strcmp(yytext, "+0,0") == 0 || 
                                    strcmp(yytext, "-0,0") == 0 || 
                                    strcmp(yytext, "+0,00") == 0 || 
                                    strcmp(yytext, "-0,00") == 0) {
                                    printf("Erro léxico: número float inválido '%s'\n", yytext);
                                } else {
                                    char *dot = strdup(yytext);
                                    for (int i = 0; dot[i]; i++) {
                                        if (dot[i] == ',') dot[i] = '.';
                                    }
                                    yylval.fval = atof(dot);
                                    free(dot);
                                    return T_NUMERO_FLOAT;
                                }                       
                            }

\'([A-Za-z0-9@_#+\-*/\.: ]|\\n)\'   { return T_CARACTERE; }

\"[^\"]*\"                          { 
                                        yylval.str = strdup(yytext);
                                        return T_STRING;
                                     }

[+\-*/]                             { 
                                        yylval.str = strdup(yytext);
                                        return T_OPERADOR_ARITMETICO;
                                     }

[><]|==|~=                         { 
                                        yylval.str = strdup(yytext);
                                        return T_OPERADOR_RELACIONAL;
                                     }

[\^|~]                             { 
                                        yylval.str = strdup(yytext);
                                        return T_OPERADOR_LOGICO;
                                     }

[ \t\n\r]+                         { /* Ignora espaços em branco */ }

.                                  { printf("Erro léxico: caractere não reconhecido '%s'\n", yytext); }

%%
