# Práticas de DevOps 2026 - Repositório de exercícios de scripts Shell e automação.
# Aluno: Alexandre da Silva Araújo
# Curso: Análise e Desenvolvimento de Sistemas - 5º Semestre

# Scripts DevOps - Laboratório de Programação

Disciplina: Laboratório de programação para operação de infraestrutura de redes de computadores
Professor: Eder Pereira dos Santos

## Descrição do Projeto

Este repositório contém scripts desenvolvidos para automação de tarefas DevOps, incluindo:

- Análise de logs de servidores web
- Operações em lote com arquivos (renomear, converter, compactar)
- Instalação e configuração de servidores web (Nginx/Apache)
- Comandos essenciais para DevOps

## Estrutura do Repositório
script1/
├── logs/
│ └── regex_log_analyzer.sh # Análise de logs
├── utils/
│ └── essential_commands.sh # Comandos essenciais DevOps
├── file_operations.sh # Manipulação de arquivos
├── install_webserver.sh # Instalação de servidor web
├── calculadora.sh # Calculadora em shell
├── comparar.sh # Compara números
├── compara_strings.sh # Compara strings
├── ordem.sh # Ordem alfabética
├── par_impar.sh # Verifica par/ímpar
├── valida_args.sh # Valida argumentos
└── verifica_arquivo.sh # Verifica tipo de arquivo


## Como usar

### Análise de Logs
```bash
./logs/regex_log_analyzer.sh

./file_operations.sh --menu

./install_webserver.sh nginx
# ou
./install_webserver.sh apache

./utils/essential_commands.sh
