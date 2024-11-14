#!/bin/bash

# Nome do arquivo Flex (sem a extensão .l)
FILENAME="teste"

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

# 3. Executar o programa gerado
./"$FILENAME"
if [ $? -ne 0 ]; then
    echo "Erro ao executar o programa"
    exit 1
fi

# 4. Exibir a saída gerada (opcional)
echo "A saída gerada foi gravada em 'tabela.txt':"
cat tabela.txt
