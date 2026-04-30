#!/bin/bash
# Script para gerar senha no formato palavra_base_numero

# Limpar a tela
clear

echo "========================================="
echo "   GERADOR DE SENHA"
echo "========================================="
echo ""

# Solicitar palavra-base
echo -n "Digite uma palavra-base: "
read palavra_base

# Solicitar um número
echo -n "Digite um número: "
read numero

# Gerar a senha
senha="${palavra_base}_${numero}"

# Exibir a senha gerada
echo ""
echo "========================================="
echo "Senha gerada: $senha"
echo "========================================="

# Perguntar se quer salvar em um arquivo
echo ""
echo -n "Deseja salvar esta senha em um arquivo? (s/n): "
read resposta

# Salvar se a resposta for sim
if [ "$resposta" = "s" ] || [ "$resposta" = "S" ]; then
    echo "$senha" >> senhas_geradas.txt
    echo ""
    echo "Senha salva no arquivo 'senhas_geradas.txt'"
    
    # Mostrar todas as senhas salvas
    echo ""
    echo "--- Senhas salvas ate agora ---"
    cat senhas_geradas.txt
else
    echo ""
    echo "Senha nao foi salva."
fi

echo ""
echo "========================================="
