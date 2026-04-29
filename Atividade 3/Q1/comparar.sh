#!/bin/bash

# Verificar se recebeu dois argumentos
if [ $# -ne 2 ]; then
    echo "Erro: É necessário informar dois números"
    echo "Uso: $0 numero1 numero2"
    echo "Exemplo: $0 10 5"
    exit 1
fi

num1=$1
num2=$2

# Verificar se os argumentos são números
if ! [[ $num1 =~ ^-?[0-9]+$ ]] || ! [[ $num2 =~ ^-?[0-9]+$ ]]; then
    echo "Erro: Os argumentos devem ser números inteiros"
    exit 1
fi

# Comparar os números
if [ $num1 -gt $num2 ]; then
    echo "$num1 é maior que $num2"
elif [ $num1 -lt $num2 ]; then
    echo "$num1 é menor que $num2"
else
    echo "$num1 é igual a $num2"
fi
