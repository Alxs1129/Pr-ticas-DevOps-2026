#!/bin/bash
# Script para calcular idade aproximada

# Limpar a tela
clear

echo "========================================="
echo "   CALCULADORA DE IDADE"
echo "========================================="
echo ""

# Perguntar o nome da pessoa
echo -n "Digite seu nome: "
read nome

# Perguntar o ano de nascimento
echo -n "Digite seu ano de nascimento: "
read ano_nascimento

# Calcular a idade aproximada
ano_atual=$(date +%Y)
idade=$((ano_atual - ano_nascimento))

# Exibir os resultados
echo ""
echo "========================================="
echo "Nome: $nome"
echo "Ano de nascimento: $ano_nascimento"
echo "Idade aproximada: $idade anos"
echo "========================================="
