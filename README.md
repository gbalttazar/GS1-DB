# Desafio Inovação Azul 2024 - Projeto de Banco de Dados Oracle

## Contexto

O Desafio Inovação Azul 2024 propõe o desenvolvimento de soluções tecnológicas inovadoras que contribuam para a gestão sustentável dos oceanos, alinhando-se aos princípios da **Economia Azul**. O projeto visa abordar problemas como poluição, destruição de habitats marinhos e mudanças climáticas, afetando não apenas os ecossistemas, mas também a economia global.

Neste contexto, foi criado um banco de dados relacional Oracle para suportar o armazenamento e a gestão de dados relacionados às atividades humanas nos oceanos, garantindo que estas sejam ecologicamente responsáveis, economicamente viáveis e socialmente inclusivas.

## Requisitos do Projeto

1. **Modelagem**:
    - Um modelo entidade-relacionamento (MER) foi desenvolvido utilizando o Oracle Data Modeler, criando tabelas relacionadas às funcionalidades do projeto.
  
2. **Scripts DDL**:
    - Scripts de criação das tabelas foram gerados pelo Oracle Data Modeler e executados no banco de dados Oracle para configurar a solução de persistência de dados.

3. **Carga de Dados**:
    - Procedimentos foram implementados para realizar a carga de dados em cada tabela. A carga de dados foi feita via passagem de parâmetros, evitando o uso de valores fixos (hard-code). Em cada procedimento, foram tratados três tipos de exceções:
        - `EXCEPTION WHEN OTHERS`
        - Dois tratamentos de exceção adicionais escolhidos
    - Quando uma exceção ocorre, as informações são registradas em uma tabela de logs, incluindo o nome do procedimento, o nome do usuário, a data do erro, o código e a mensagem de erro.

## Funcionalidades

- **Modelagem Física**: Criação do modelo MER físico, refletindo as relações entre entidades que sustentam as atividades da Economia Azul.
- **Scripts DDL**: Automação da criação de tabelas no banco de dados Oracle.
- **Procedimentos**: Implementação de procedures para carregar dados com tratamento de erros e logs automáticos.
- **Auditoria**: Log das exceções ocorridas durante a execução das procedures para garantir rastreabilidade e monitoramento.

## Execução

1. Clone este repositório e importe os arquivos SQL no Oracle Database.
2. Execute os scripts DDL para criar as tabelas necessárias.
3. Utilize os procedimentos para carregar dados dinamicamente nas tabelas.
4. Verifique a tabela de logs para visualizar o registro de erros tratados.

## Créditos

- [Gabriel Baltazar]
- Nota Final: **100/100**
