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


[![GitHub last commit](https://img.shields.io/github/last-commit/Alxs1129/Pr-ticas-DevOps-2026)](https://github.com/Alxs1129/Pr-ticas-DevOps-2026)

## 📚 Sobre o Projeto

Scripts desenvolvidos para a disciplina **Laboratório de programação para operação de infraestrutura de redes de computadores** sob orientação do professor **Eder Pereira dos Santos**.

## 📁 Estrutura

| Arquivo | Atividade | Descrição |
|---------|-----------|-----------|
| `atv2.1_regex_log_analyzer.sh` | 2.1 | Análise de logs de servidor web |
| `atv2.2_file_operations.sh` | 2.2 | Manipulação de arquivos (renomear, converter, compactar) |
| `atv4_comparar_strings.sh` | 4 | Compara duas strings |
| `atv7_verificar_arquivo.sh` | 7 | Verifica tipo de arquivo |

## 🚀 Como usar

```bash
# Análise de logs
./atv2.1_regex_log_analyzer.sh

# Manipulação de arquivos (modo menu)
./atv2.2_file_operations.sh --menu

# Comparar strings
./atv4_comparar_strings.sh "string1" "string2"

# Verificar arquivo
./atv7_verificar_arquivo.sh /caminho/arquivo
