#!/bin/bash

# Verificar se recebeu 3 argumentos
if [ $# -ne 3 ]; then
    echo "Erro: É necessário informar 3 argumentos"
    echo "Uso: $0 numero1 operador numero2"
    echo "Operadores: + - * / %"
    echo "Exemplo: $0 10 + 5"
    exit 1
fi

num1=$1
operador=$2
num2=$3

# Verificar se os argumentos são números
if ! [[ $num1 =~ ^-?[0-9]+$ ]] || ! [[ $num2 =~ ^-?[0-9]+$ ]]; then
    echo "Erro: Os argumentos devem ser números inteiros"
    exit 1
fi

# Realizar a operação
case $operador in
    +)
        resultado=$((num1 + num2))
        echo "$num1 + $num2 = $resultado"
        ;;
    -)
        resultado=$((num1 - num2))
        echo "$num1 - $num2 = $resultado"
        ;;
    \*)
        resultado=$((num1 * num2))
        echo "$num1 * $num2 = $resultado"
        ;;
    /)
        if [ $num2 -eq 0 ]; then
            echo "Erro: Divisão por zero não permitida"
            exit 1
        fi
        resultado=$((num1 / num2))
        echo "$num1 / $num2 = $resultado"
        ;;
    %)
        if [ $num2 -eq 0 ]; then
            echo "Erro: Divisão por zero não permitida"
            exit 1
        fi
        resultado=$((num1 % num2))
        echo "$num1 % $num2 = $resultado"
        ;;
    *)
        echo "Erro: Operador inválido"
        echo "Operadores permitidos: + - * / %"
        exit 1
        ;;
esac
