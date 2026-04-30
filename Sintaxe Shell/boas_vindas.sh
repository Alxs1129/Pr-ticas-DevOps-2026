#!/bin/bash
# Script de boas-vindas ao sistema

# Limpar a tela
clear

# Exibir mensagem de boas-vindas
echo "========================================="
echo "   SISTEMA DE BOAS-VINDAS"
echo "========================================="
echo ""

# Perguntar o nome do usuário
echo -n "Digite seu nome: "
read nome

# Perguntar a disciplina que está cursando
echo -n "Digite a disciplina que está cursando: "
read disciplina

# Perguntar o semestre atual
echo -n "Digite o semestre atual: "
read semestre

# Exibir mensagem personalizada
echo ""
echo "========================================="
echo "Olá, $nome! Bem-vindo à disciplina $disciplina no $semestre semestre."
echo "Data e hora atual: $(date)"
echo "Seu diretório home é: $HOME"
echo "========================================="
