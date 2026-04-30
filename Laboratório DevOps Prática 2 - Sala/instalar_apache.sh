#!/bin/bash
# Script para instalar e configurar o Apache

echo "========================================="
echo "   INSTALAÇÃO DO APACHE"
echo "========================================="
echo ""

# Verificar o sistema operacional
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Sistema Linux detectado"
    echo "Instalando Apache..."
    sudo apt update
    sudo apt install apache2 -y
    
    echo ""
    echo "Iniciando serviço..."
    sudo systemctl start apache2
    sudo systemctl enable apache2
    
    echo ""
    echo "Verificando status..."
    sudo systemctl status apache2 --no-pager
    
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    echo "Windows detectado"
    echo "Para instalar o Apache no Windows:"
    echo "1. Baixe em: https://www.apachelounge.com/download/"
    echo "2. Descompacte em C:/Apache24"
    echo "3. Execute como administrador: C:/Apache24/bin/httpd.exe"
else
    echo "Sistema não reconhecido"
fi

echo ""
echo "Para testar, abra o navegador em: http://localhost"
