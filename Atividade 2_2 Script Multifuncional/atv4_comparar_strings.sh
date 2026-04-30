#!/bin/bash

if [ $# -ne 2 ]; then
echo "Erro: É necessário informar duas strings"
echo "Uso: $0 string1 string2"
echo "Exemplo; $0 casa casa"
exit 1
fi

string1=$1
string2=$2

if [ "$string1" = "$string2" ]; then
echo "As strings são iguais"
echo "String: \"$string1\""
else
echo "As strings são diferentes"
echo "String 1: \"$string1\""
echo "String 2: \"$string2\""
fi
