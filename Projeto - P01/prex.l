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

\\[^\\]*\\          { printf("Token: %d (T_COMENTARIO), Lexema: %s\n", T_COMENTARIO, yytext); }

"PROGRAMA"          { printf("Token: %d (T_PROGRAMA), Lexema: %s\n", T_PROGRAMA, yytext); }
"PREX"              { printf("Token: %d (T_PREX), Lexema: %s\n", T_PREX, yytext); }
"{"                 { printf("Token: %d (T_CHAVE_ABRE), Lexema: %s\n", T_CHAVE_ABRE, yytext); }
"}"                 { printf("Token: %d (T_CHAVE_FECHA), Lexema: %s\n", T_CHAVE_FECHA, yytext); }
";"                 { printf("Token: %d (T_PONTO_VIRGULA), Lexema: %s\n", T_PONTO_VIRGULA, yytext); }
","                 { printf("Token: %d (T_VIRGULA), Lexema: %s\n", T_VIRGULA, yytext); }
"="                 { printf("Token: %d (T_IGUAL), Lexema: %s\n", T_IGUAL, yytext); }
"FLOAT"             { printf("Token: %d (T_FLOAT), Lexema: %s\n", T_FLOAT, yytext); }
"CHAR"              { printf("Token: %d (T_CHAR), Lexema: %s\n", T_CHAR, yytext); }
"LISTA"             { printf("Token: %d (T_LISTA), Lexema: %s\n", T_LISTA, yytext); }
"BOOL"              { printf("Token: %d (T_BOOL), Lexema: %s\n", T_BOOL, yytext); }
"CONST"             { printf("Token: %d (T_CONST), Lexema: %s\n", T_CONST, yytext); }
"SE"                { printf("Token: %d (T_SE), Lexema: %s\n", T_SE, yytext); }
"ENTAO"             { printf("Token: %d (T_ENTAO), Lexema: %s\n", T_ENTAO, yytext); }
"SENAO"             { printf("Token: %d (T_SENAO), Lexema: %s\n", T_SENAO, yytext); }
"ENQUANTO"          { printf("Token: %d (T_ENQUANTO), Lexema: %s\n", T_ENQUANTO, yytext); }
"FACA"              { printf("Token: %d (T_FACA), Lexema: %s\n", T_FACA, yytext); }
"LER"               { printf("Token: %d (T_LER), Lexema: %s\n", T_LER, yytext); }
"ESCREVER"          { printf("Token: %d (T_ESCREVER), Lexema: %s\n", T_ESCREVER, yytext); }
"("                 { printf("Token: %d (T_PARENTESE_ABRE), Lexema: %s\n", T_PARENTESE_ABRE, yytext); }
")"                 { printf("Token: %d (T_PARENTESE_FECHA), Lexema: %s\n", T_PARENTESE_FECHA, yytext); }

[A-Za-z][A-Za-z0-9]{0,9}                { printf("Token: %d (T_IDENTIFICADOR), Lexema: %s\n", T_IDENTIFICADOR, yytext); }

[-+]?[0-9]+,[0-9]{1,2}                  {
                                            if (strcmp(yytext, "+0,0") == 0 || strcmp(yytext, "-0,0") == 0) {
                                                printf("Erro léxico: número float inválido '%s'\n", yytext);
                                            } else {
                                                printf("Token: %d (T_NUMERO_FLOAT), Lexema: %s\n", T_NUMERO_FLOAT, yytext);
                                            }
                                        }
                                        
\'([A-Za-z0-9@_#+\-*/\.: ]|\\n)\'       { printf("Token: %d (T_CARACTERE), Lexema: %s\n", T_CARACTERE, yytext); }

\"[^\"]*\"                              { printf("Token: %d (T_STRING), Lexema: %s\n", T_STRING, yytext); }

[+\-*/]                                 { printf("Token: %d (T_OPERADOR_ARITMETICO), Lexema: %s\n", T_OPERADOR_ARITMETICO, yytext); }

[\^|~]                                  { printf("Token: %d (T_OPERADOR_LOGICO), Lexema: %s\n", T_OPERADOR_LOGICO, yytext); }

[><]|==|~=                              { printf("Token: %d (T_OPERADOR_RELACIONAL), Lexema: %s\n", T_OPERADOR_RELACIONAL, yytext); }

[ \t\n\r]+                              { /* Ignora espaços em branco */ }

.                                       { printf("Erro léxico: caractere não reconhecido '%s'\n", yytext); }

%%

#include <stdio.h>
#include <stdlib.h>

/* Função para processar um arquivo de entrada */
void processarArquivo(const char* nomeArquivo) {
    FILE* arquivo = fopen(nomeArquivo, "r");
    if (arquivo == NULL) {
        fprintf(stderr, "Erro: Não foi possível abrir o arquivo '%s'. Verifique se o arquivo existe e se você tem permissão para lê-lo.\n", nomeArquivo);
        return;
    }

    printf("==> Processando arquivo: %s\n\n", nomeArquivo);

    /* Configura o arquivo como entrada do Flex */
    yyin = arquivo;

    /* Executa o analisador léxico */
    yylex();

    /* Fecha o arquivo após o processamento */
    fclose(arquivo);

    printf("\n==> Concluído o processamento do arquivo: %s\n\n", nomeArquivo);
}

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <arquivo1.prex> [arquivo2.prex ...]\n", argv[0]);
        fprintf(stderr, "Forneça pelo menos um arquivo de entrada.\n");
        return EXIT_FAILURE;
    }

    for (int i = 1; i < argc; i++) {
        processarArquivo(argv[i]);
    }

    return EXIT_SUCCESS;
}
