# Repositório de Estudos da Disciplina de Compiladores

Este repositório contém arquivos de aula e atividades desenvolvidas para a disciplina de Compiladores. Ele é organizado para facilitar o estudo e prática dos conceitos vistos em aula, com foco na utilização de ferramentas como Flex e na implementação de diversos analisadores léxicos e sintáticos.

## Estrutura do Repositório

- **/Flex**: Pasta destinada ao armazenamento dos arquivos Flex (.l). Esta pasta contém todos os arquivos relacionados às atividades que utilizam o Flex para análise léxica.

- **/Atv**: Esta pasta (ou pastas com nomes específicos) contém os arquivos e códigos relacionados a atividades específicas, organizadas de acordo com o tema ou a tarefa solicitada em aula.

## Executando Arquivos Flex

Na pasta `/flex`, há um script chamado **`run_flex.sh`**. Esse script foi criado para automatizar o processo de compilação e execução dos arquivos Flex. 

### Como Utilizar o Script `run_flex.sh`

1. **Mover para a Pasta Flex**:
   
   Para executar o script, você precisa navegar até a pasta `flex` no terminal. Use o seguinte comando:

   ```bash
   cd flex
   ```

2. **Alterar o Nome do Arquivo Flex no Script**:

   Abra o arquivo `run_flex.sh` em qualquer editor de texto e modifique a variável `FILENAME` para o nome do arquivo Flex que você deseja executar, sem a extensão `.l`.

   Exemplo de modificação no script:

   ```bash
   # Nome do arquivo Flex (sem a extensão .l)
   FILENAME="expre_mat2"
   ```

3. **Executar o Script**:

   Após ajustar o nome do arquivo, execute o script com o seguinte comando:

   ```bash
   ./run_flex.sh
   ```

   Caso o script não execute, pode ser necessário conceder permissão para que o arquivo seja executável. Utilize o comando:

   ```bash
   chmod +x run_flex.sh
   ```

   Em seguida, execute novamente o script conforme instruído acima.

## Possíveis Erros

- **Permissão Negada**: Se receber um erro de permissão negada, verifique se as permissões de execução do script foram concedidas corretamente com o comando `chmod +x`.

- **Arquivo Não Encontrado**: Certifique-se de que o nome do arquivo Flex (sem extensão) corresponde ao que está especificado na variável `FILENAME` do script.

---