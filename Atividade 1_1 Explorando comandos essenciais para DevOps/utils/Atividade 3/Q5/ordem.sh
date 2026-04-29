#!/bin/bash

# Verificar se recebeu duas strings
if [ $# -ne 2 ]; then
    echo "Erro: É necessário informar duas strings"
    echo "Uso: $0 string1 string2"
    echo "Exemplo: $0 casa carro"
    exit 1
fi

string1=$1
string2=$2

# Comparar ordem alfabética
if [ "$string1" = "$string2" ]; then
    echo "As strings são iguais: $string1"
elif [ "$string1" \< "$string2" ]; then
    echo "Ordem alfabética:"
    echo "1º: $string1"
    echo "2º: $string2"
else
    echo "Ordem alfabética:"
    echo "1º: $string2"
    echo "2º: $string1"
fi
