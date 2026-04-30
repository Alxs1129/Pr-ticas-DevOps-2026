#!/bin/bash
# Função para extrair emails de um arquivo

extrai_emails() {
    grep -E -o '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' "$1"
}

if [ $# -ne 1 ]; then
    echo "Uso: $0 <arquivo>"
    echo "Exemplo: $0 emails.txt"
    exit 1
fi

extrai_emails "$1"
