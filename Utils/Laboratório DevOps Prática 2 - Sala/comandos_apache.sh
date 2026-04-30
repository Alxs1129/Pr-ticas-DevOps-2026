#!/bin/bash
# Comandos úteis para gerenciar o Apache

echo "========================================="
echo "   COMANDOS PARA GERENCIAR O APACHE"
echo "========================================="
echo ""

echo "1. INSTALAÇÃO:"
echo "   sudo apt update"
echo "   sudo apt install apache2 -y"
echo ""

echo "2. GERENCIAR SERVIÇO:"
echo "   sudo systemctl start apache2     # Iniciar"
echo "   sudo systemctl stop apache2      # Parar"
echo "   sudo systemctl restart apache2   # Reiniciar"
echo "   sudo systemctl status apache2    # Ver status"
echo "   sudo systemctl enable apache2    # Iniciar com sistema"
echo ""

echo "3. TESTAR CONFIGURAÇÃO:"
echo "   sudo apache2ctl configtest"
echo ""

echo "4. VER VERSÃO:"
echo "   apache2 -v"
echo ""

echo "5. DIRETÓRIOS IMPORTANTES:"
echo "   Sites: /var/www/html/"
echo "   Config: /etc/apache2/"
echo "   Logs: /var/log/apache2/"
echo ""

echo "6. VER LOGS:"
echo "   sudo tail -f /var/log/apache2/access.log"
echo "   sudo tail -f /var/log/apache2/error.log"
echo ""

echo "7. HABILITAR MÓDULOS:"
echo "   sudo a2enmod rewrite"
echo "   sudo a2enmod ssl"
echo "   sudo a2enmod headers"
echo ""

echo "8. REINICIAR APÓS CONFIGURAÇÃO:"
echo "   sudo systemctl reload apache2"
echo ""
