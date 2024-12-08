%{
#include "prex.tab.h"
#include <stdio.h> 
#include <string.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

extern FILE *yyin;
extern int yylineno;

FILE *outputFile;
%}

%union {
    char* str;
    float fval;
}

// Tokens necessários
%token T_PROGRAMA T_PREX T_CHAVE_ABRE T_CHAVE_FECHA T_PONTO_VIRGULA
%token T_VIRGULA T_IGUAL T_FLOAT T_LER T_ESCREVER
%token T_CHAR T_LISTA T_BOOL T_CONST
%token T_SE T_ENTAO T_SENAO T_ENQUANTO T_FACA
%token T_PARENTESE_ABRE T_PARENTESE_FECHA
%token <str> T_STRING T_CARACTERE
%token <str> T_OPERADOR_RELACIONAL T_OPERADOR_LOGICO

// Tokens com tipos
%token <str> T_IDENTIFICADOR
%token <fval> T_NUMERO_FLOAT
%token <str> T_OPERADOR_ARITMETICO

// Precedência
%left '+' '-'
%left '*' '/'

// Tipos dos não-terminais
%type <str> programa corpo lista_comandos comando declaracao
%type <str> lista_identificadores lista_variaveis comando_leitura comando_escrita
%type <str> expressao termo atribuicao expressao_aritmetica

%start programa

%%

programa:
    T_PROGRAMA T_PREX T_CHAVE_ABRE corpo T_CHAVE_FECHA
    {
        fprintf(outputFile, "#include <stdio.h>\n\nint main() {\n%s    return 0;\n}\n", $4);
    }
    ;

corpo:
    lista_comandos
    {
        $$ = $1;
    }
    ;

lista_comandos:
      lista_comandos comando
    {
        char buffer[2000];
        sprintf(buffer, "%s%s", $1, $2);
        $$ = strdup(buffer);
    }
    | comando
    {
        $$ = strdup($1);
    }
    ;

comando:
      declaracao
    | comando_leitura
    | comando_escrita
    | atribuicao
    ;

declaracao:
    T_FLOAT lista_identificadores T_PONTO_VIRGULA
    {
        char buffer[1000];
        sprintf(buffer, "    float %s;\n", $2);
        $$ = strdup(buffer);
    }
    ;

lista_identificadores:
      T_IDENTIFICADOR
    {
        $$ = strdup($1);
    }
    | lista_identificadores T_VIRGULA T_IDENTIFICADOR
    {
        char buffer[1000];
        sprintf(buffer, "%s, %s", $1, $3);
        $$ = strdup(buffer);
    }
    ;

// Adicione a seguinte regra para 'lista_variaveis'
lista_variaveis:
      T_IDENTIFICADOR
    {
        $$ = strdup($1);
    }
    | lista_variaveis T_IDENTIFICADOR
    {
        char buffer[1000];
        sprintf(buffer, "%s %s", $1, $2);
        $$ = strdup(buffer);
    }
    ;

// Modifique as regras de 'comando_leitura' e 'comando_escrita'
comando_leitura:
    T_LER lista_variaveis T_PONTO_VIRGULA
    {
        char buffer[1000] = "";
        char *token = strtok($2, " ");
        while(token != NULL) {
            strcat(buffer, "    scanf(\"%%f\", &");
            strcat(buffer, token);
            strcat(buffer, ");\n");
            token = strtok(NULL, " ");
        }
        $$ = strdup(buffer);
    }
    ;

comando_escrita:
    T_ESCREVER lista_variaveis T_PONTO_VIRGULA
    {
        char buffer[1000] = "";
        char *token = strtok($2, " ");
        while(token != NULL) {
            strcat(buffer, "    printf(\"%%f\\n\", ");
            strcat(buffer, token);
            strcat(buffer, ");\n");
            token = strtok(NULL, " ");
        }
        $$ = strdup(buffer);
    }
    ;

atribuicao:
    T_IDENTIFICADOR T_IGUAL expressao T_PONTO_VIRGULA
    {
        char buffer[100];
        sprintf(buffer, "    %s = %s;\n", $1, $3);
        $$ = strdup(buffer);
    }
    ;

expressao:
      termo
    {
        $$ = strdup($1);
    }
    | expressao_aritmetica
    {
        $$ = strdup($1);
    }
    ;

expressao_aritmetica:
      T_OPERADOR_ARITMETICO termo termo
    {
        char buffer[1000];
        sprintf(buffer, "(%s %s %s)", $2, $1, $3);
        $$ = strdup(buffer);
    }
    | T_OPERADOR_ARITMETICO expressao_aritmetica expressao_aritmetica
    {
        char buffer[1000];
        sprintf(buffer, "(%s %s %s)", $2, $1, $3);
        $$ = strdup(buffer);
    }
    | T_OPERADOR_ARITMETICO termo expressao_aritmetica
    {
        char buffer[1000];
        sprintf(buffer, "(%s %s %s)", $2, $1, $3);
        $$ = strdup(buffer);
    }
    ;

termo:
      T_NUMERO_FLOAT
    {
        char buffer[20];
        sprintf(buffer, "%.2f", $1);
        $$ = strdup(buffer);
    }
    | T_IDENTIFICADOR
    {
        $$ = strdup($1);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro Sintático na linha %d: %s\n", yylineno, s);
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <arquivo.prex>\n", argv[0]);
        return EXIT_FAILURE;
    }

    outputFile = fopen("programa.c", "w");
    if (!outputFile) {
        fprintf(stderr, "Erro: Não foi possível criar o arquivo de saída 'programa.c'\n");
        return EXIT_FAILURE;
    }

    FILE *arquivo = fopen(argv[1], "r");
    if (!arquivo) {
        fprintf(stderr, "Erro: Não foi possível abrir o arquivo %s\n", argv[1]);
        fclose(outputFile);
        return EXIT_FAILURE;
    }

    yyin = arquivo;
    yyparse();
    fclose(arquivo);
    fclose(outputFile);
    return 0;
}
