#!/bin/bash
# Script para ler dois valores do usuário e exibi-los

# Limpar a tela
clear

echo "========================================="
echo "   LEITOR DE VALORES"
echo "========================================="
echo ""

# Ler o primeiro valor
echo -n "Digite o primeiro valor: "
read valor1

# Ler o segundo valor
echo -n "Digite o segundo valor: "
read valor2

# Exibir os valores armazenados
echo ""
echo "========================================="
echo "Valores armazenados:"
echo "Primeiro valor: $valor1"
echo "Segundo valor: $valor2"
echo "========================================="
