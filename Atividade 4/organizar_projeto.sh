#!/bin/bash
# O objetivo é criar um diretório chamado "teste", entrar nele e depois removê-lo.

mkdir teste
echo "Diretório 'teste' criado"

cd teste
echo "Entrou no diretório: $(pwd)"

cd ..
echo "Saiu do diretório"

rmdir teste
echo "Diretório 'teste' removido com sucesso"
