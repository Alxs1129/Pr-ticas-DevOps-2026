#!/bin/bash

# Verificar se recebeu um argumento
if [ $# -ne 1 ]; then
    echo "Erro: É necessário informar um número"
    echo "Uso: $0 numero"
    echo "Exemplo: $0 7"
    exit 1
fi

numero=$1

# Verificar se o argumento é número
if ! [[ $numero =~ ^-?[0-9]+$ ]]; then
    echo "Erro: O argumento deve ser um número inteiro"
    exit 1
fi

# Verificar se é par ou ímpar usando o operador %
if [ $((numero % 2)) -eq 0 ]; then
    echo "$numero é par"
else
    echo "$numero é ímpar"
fi
