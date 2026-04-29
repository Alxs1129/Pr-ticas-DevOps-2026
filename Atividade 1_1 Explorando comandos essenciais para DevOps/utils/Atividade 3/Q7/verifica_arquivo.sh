#!/bin/bash

# Verificar se recebeu um argumento
if [ $# -ne 1 ]; then
    echo "Erro: É necessário informar um nome de arquivo"
    echo "Uso: $0 nome_do_arquivo"
    echo "Exemplo: $0 documento.txt"
    exit 1
fi

arquivo=$1

# Verificar o tipo do arquivo
if [ -f "$arquivo" ]; then
    echo "$arquivo é um arquivo regular"
    echo "Tamanho: $(du -h "$arquivo" 2>/dev/null | cut -f1)"
    echo "Permissões: $(ls -l "$arquivo" 2>/dev/null | cut -d' ' -f1)"
elif [ -d "$arquivo" ]; then
    echo "$arquivo é um diretório"
    echo "Conteúdo: $(ls -1 "$arquivo" 2>/dev/null | wc -l) itens"
elif [ -e "$arquivo" ]; then
    echo "$arquivo existe mas não é arquivo regular nem diretório"
else
    echo "$arquivo não existe"
fi
