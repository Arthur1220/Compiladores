%{
#include <stdio.h>
#include <string.h>

// Definições de tokens
#define T_PROGRAMA 1
#define T_PREX 2
#define T_CHAVE_ABRE 3
#define T_CHAVE_FECHA 4
#define T_PONTO_VIRGULA 5
#define T_VIRGULA 6
#define T_IGUAL 7
#define T_FLOAT 8
#define T_CHAR 9
#define T_LISTA 10
#define T_BOOL 11
#define T_CONST 12
#define T_SE 13
#define T_ENTAO 14
#define T_SENAO 15
#define T_ENQUANTO 16
#define T_FACA 17
#define T_LER 18
#define T_ESCREVER 19
#define T_IDENTIFICADOR 20
#define T_NUMERO_FLOAT 21
#define T_CARACTERE 22
#define T_STRING 23
#define T_OPERADOR_ARITMETICO 24
#define T_OPERADOR_LOGICO 25
#define T_OPERADOR_RELACIONAL 26
#define T_COMENTARIO 27
#define T_PARENTESE_ABRE 28
#define T_PARENTESE_FECHA 29

%}

%option noyywrap

%%

"PROGRAMA"          { printf("Token: %d, Lexema: %s\n", T_PROGRAMA, yytext); }
"PREX"              { printf("Token: %d, Lexema: %s\n", T_PREX, yytext); }
"{"                 { printf("Token: %d, Lexema: %s\n", T_CHAVE_ABRE, yytext); }
"}"                 { printf("Token: %d, Lexema: %s\n", T_CHAVE_FECHA, yytext); }
";"                 { printf("Token: %d, Lexema: %s\n", T_PONTO_VIRGULA, yytext); }
","                 { printf("Token: %d, Lexema: %s\n", T_VIRGULA, yytext); }
"="                 { printf("Token: %d, Lexema: %s\n", T_IGUAL, yytext); }
"FLOAT"             { printf("Token: %d, Lexema: %s\n", T_FLOAT, yytext); }
"CHAR"              { printf("Token: %d, Lexema: %s\n", T_CHAR, yytext); }
"LISTA"             { printf("Token: %d, Lexema: %s\n", T_LISTA, yytext); }
"BOOL"              { printf("Token: %d, Lexema: %s\n", T_BOOL, yytext); }
"CONST"             { printf("Token: %d, Lexema: %s\n", T_CONST, yytext); }
"SE"                { printf("Token: %d, Lexema: %s\n", T_SE, yytext); }
"ENTAO"             { printf("Token: %d, Lexema: %s\n", T_ENTAO, yytext); }
"SENAO"             { printf("Token: %d, Lexema: %s\n", T_SENAO, yytext); }
"ENQUANTO"          { printf("Token: %d, Lexema: %s\n", T_ENQUANTO, yytext); }
"FACA"              { printf("Token: %d, Lexema: %s\n", T_FACA, yytext); }
"LER"               { printf("Token: %d, Lexema: %s\n", T_LER, yytext); }
"ESCREVER"          { printf("Token: %d, Lexema: %s\n", T_ESCREVER, yytext); }
"("                 { printf("Token: %d, Lexema: %s\n", T_PARENTESE_ABRE, yytext); }
")"                 { printf("Token: %d, Lexema: %s\n", T_PARENTESE_FECHA, yytext); }

[A-Za-z][A-Za-z0-9]+     { printf("Token: %d, Lexema: %s\n", T_IDENTIFICADOR, yytext); }

[-+]?[0-9]+,[0-9]{1,2}   { printf("Token: %d, Lexema: %s\n", T_NUMERO_FLOAT, yytext); }

'.'                      { printf("Token: %d, Lexema: %s\n", T_CARACTERE, yytext); }

\"[^\"]*\"               { printf("Token: %d, Lexema: %s\n", T_STRING, yytext); }

[+\-*/]                  { printf("Token: %d, Lexema: %s\n", T_OPERADOR_ARITMETICO, yytext); }

[\^|~]                   { printf("Token: %d, Lexema: %s\n", T_OPERADOR_LOGICO, yytext); }

[><]=?|==|~=             { printf("Token: %d, Lexema: %s\n", T_OPERADOR_RELACIONAL, yytext); }

\\[^\\]*\\               { printf("Token: %d, Lexema: %s\n", T_COMENTARIO, yytext); }

[ \t\n\r]+               { /* Ignora espaços em branco */ }

.                        { printf("Erro léxico: caractere não reconhecido '%s'\n", yytext); }

%%

int main(int argc, char** argv) {
    if (argc != 2) {
        printf("Uso: %s exemplo1.prex\n", argv[0]);
        return 1;
    }

    FILE* arquivo = fopen(argv[1], "r");
    if (arquivo == NULL) {
        printf("Erro ao abrir o arquivo %s\n", argv[1]);
        return 1;
    }

    yyin = arquivo;

    yylex();

    fclose(arquivo);
    return 0;
}