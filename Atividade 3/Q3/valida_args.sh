#!/bin/bash

# Verificar se o usuário informou exatamente 3 argumentos
if [ $# -ne 3 ]; then
    echo "Erro: Número de argumentos inválido"
    echo "Uso: $0 argumento1 argumento2 argumento3"
    echo "Você informou $# argumento(s)"
    exit 1
fi

# Se chegou aqui, tem 3 argumentos
echo "OK! Você informou 3 argumentos:"
echo "Argumento 1: $1"
echo "Argumento 2: $2"
echo "Argumento 3: $3"
