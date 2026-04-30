#!/bin/bash
# Script para configurar um site no Apache

SITE="screenmatch"
DIRETORIO="/var/www/$SITE"

echo "Configurando site: $SITE"
echo ""

# Criar diretório do site
echo "Criando diretório: $DIRETORIO"
sudo mkdir -p "$DIRETORIO"

# Criar página de exemplo
echo "Criando página de exemplo..."
sudo cat > "$DIRETORIO/index.html" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>ScreenMatch</title>
    <style>
        body { font-family: Arial; text-align: center; padding: 50px; background: #667eea; color: white; }
        h1 { font-size: 48px; }
    </style>
</head>
<body>
    <h1>ScreenMatch</h1>
    <p>Sua plataforma de vídeos</p>
    <p>Servidor Apache configurado com sucesso!</p>
</body>
</html>
EOF

# Ajustar permissões
echo "Ajustando permissões..."
sudo chown -R www-data:www-data "$DIRETORIO"
sudo chmod -R 755 "$DIRETORIO"

# Criar configuração do virtual host
echo "Criando configuração do virtual host..."
sudo cat > "/etc/apache2/sites-available/$SITE.conf" << EOF
<VirtualHost *:80>
    ServerName $SITE.local
    DocumentRoot $DIRETORIO
    
    <Directory $DIRETORIO>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog \${APACHE_LOG_DIR}/${SITE}_error.log
    CustomLog \${APACHE_LOG_DIR}/${SITE}_access.log combined
</VirtualHost>
EOF

# Habilitar o site
echo "Habilitando o site..."
sudo a2ensite "$SITE.conf"

# Desabilitar site padrão (opcional)
# sudo a2dissite 000-default.conf

# Testar configuração
echo "Testando configuração..."
sudo apache2ctl configtest

# Recarregar o Apache
echo "Recarregando o Apache..."
sudo systemctl reload apache2

echo ""
echo "Site configurado com sucesso!"
echo "Acesse: http://localhost"
