#!/bin/bash
# Script para exibir informações do usuário e sistema

# Limpar a tela
clear

echo "========================================="
echo "   INFORMACOES DO SISTEMA"
echo "========================================="
echo ""

# Exibir usuário atual
echo "Usuario atual: $(whoami)"

# Exibir diretório home
echo "Diretorio home: $HOME"

# Exibir diretório atual
echo "Diretorio atual: $(pwd)"

echo ""
echo "========================================="
