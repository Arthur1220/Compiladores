#!/bin/bash

# Nome do arquivo Flex (sem a extensão .l)
FILENAME="prex"

# Verifica se um arquivo de entrada foi fornecido
if [ $# -eq 0 ]; then
    echo "Por favor, forneça um arquivo .prex como argumento."
    echo "Uso: $0 <arquivo.prex>"
    exit 1
fi

INPUT_FILE=$1

# Verifica se o arquivo de entrada existe
if [ ! -f "$INPUT_FILE" ]; then
    echo "O arquivo $INPUT_FILE não existe."
    exit 1
fi

# 1. Gerar o código C a partir do arquivo Flex
flex "$FILENAME.l"
if [ $? -ne 0 ]; then
    echo "Erro ao gerar o arquivo lex.yy.c"
    exit 1
fi

# 2. Compilar o código C gerado pelo Flex
gcc lex.yy.c -o "$FILENAME" -lfl
if [ $? -ne 0 ]; then
    echo "Erro ao compilar o código gerado"
    exit 1
fi

# 3. Executar o programa gerado com o arquivo de entrada
./"$FILENAME" "$INPUT_FILE" > saida_lexica.txt
if [ $? -ne 0 ]; then
    echo "Erro ao executar o programa"
    exit 1
fi

# 4. Exibir a saída gerada
echo "A análise léxica foi concluída. A saída foi gravada em 'saida_lexica.txt':"
cat saida_lexica.txt

# 5. Limpar arquivos temporários (opcional)
rm lex.yy.c
rm "$FILENAME"