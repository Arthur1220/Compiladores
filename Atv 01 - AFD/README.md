# Implementação de um Autômato Finito Determinístico (AFD)

Este projeto implementa um Autômato Finito Determinístico (AFD) que verifica se uma cadeia é aceita ou rejeitada com base nas regras definidas no arquivo de entrada. O programa lê um autômato de um arquivo de texto, exibe suas configurações e valida uma cadeia de entrada.

## Como funciona

O código lê a definição de um autômato de um arquivo de texto especificado. O arquivo deve conter os estados, o alfabeto, as transições, o estado inicial, os estados finais e a cadeia a ser verificada.

### Estrutura do Arquivo de Entrada

O arquivo de entrada deve seguir a seguinte estrutura:

1. **Primeira linha:** Lista de estados separados por espaços.
2. **Segunda linha:** Lista de símbolos do alfabeto separados por espaços.
3. **Linhas seguintes:** Definições de transições no formato `estado_atual simbolo proximo_estado`.
4. **Linha após as transições:** Estado inicial do autômato.
5. **Linha após o estado inicial:** Lista de estados finais separados por espaços.
6. **Última linha:** Cadeia a ser processada.

### Exemplo de Arquivo de Entrada (`automato_combinado.txt`)

```plaintext
q0 q1 q2 q3 q4 q5
a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 =
q0 a q2
q0 b q2
q0 c q2
...
q3 9 q4
q4 0 q4
q4 1 q4
...
q0
q1 q2 q4
aaaaaa=72368askdhj
```

## Como Compilar e Executar

### Pré-requisitos

- Compilador C++ (por exemplo, `g++`)

### Compilação

Para compilar o código, use o seguinte comando:

```bash
g++ automato.cpp -o automato
```

### Execução

Após a compilação, execute o programa com o comando:

```bash
./automato
```

Certifique-se de que o arquivo de entrada (`automato_combinado.txt`) está no mesmo diretório do executável, ou ajuste o nome do arquivo no código para corresponder ao caminho correto.

## Funcionamento do Código

1. **Inicialização do Automato:** Configura as listas de estados, alfabeto, transições, estado inicial, estados finais e a cadeia.
2. **Leitura do Arquivo:** Carrega o autômato conforme as regras definidas no arquivo de entrada.
3. **Validação da Cadeia:** Processa a cadeia, realizando transições conforme os estados e símbolos definidos.
4. **Exibição dos Resultados:** Mostra a configuração do autômato e indica se a cadeia foi aceita ou rejeitada.

## Saída

O programa exibe o autômato carregado e se a cadeia foi aceita ou rejeitada. Exemplo de saída:

```plaintext
Estados: q0 q1 q2 q3 q4 q5 
Alfabeto: a b c ... 9 = 
Transições:
(q0, a) -> q2
(q0, b) -> q2
...
Estado Inicial: q0
Estados Finais: q1 q2 q4
Cadeia: aaaaaa=72368askdhj
- Cadeia rejeitada pelo automato.
```

## Erros Comuns

- **Erro de leitura do arquivo:** Certifique-se de que o caminho e nome do arquivo estão corretos.
- **Transição inválida:** Verifique se os estados e símbolos das transições pertencem às listas definidas.
- **Estado inicial ou final inválido:** Certifique-se de que estão dentro da lista de estados.