# Guia Rápido - Apache Web Server

## Comandos Essenciais

| Operação | Comando |
|----------|---------|
| Instalar | `sudo apt install apache2 -y` |
| Iniciar | `sudo systemctl start apache2` |
| Parar | `sudo systemctl stop apache2` |
| Reiniciar | `sudo systemctl restart apache2` |
| Status | `sudo systemctl status apache2` |
| Habilitar | `sudo systemctl enable apache2` |
| Testar config | `sudo apache2ctl configtest` |

## Diretórios Importantes

- Sites: `/var/www/html/`
- Configuração: `/etc/apache2/`
- Virtual Hosts: `/etc/apache2/sites-available/`
- Logs: `/var/log/apache2/`

## Arquivos de Log

- Acessos: `sudo tail -f /var/log/apache2/access.log`
- Erros: `sudo tail -f /var/log/apache2/error.log`

## Módulos Úteis

- `rewrite` - URL amigáveis
- `ssl` - HTTPS
- `headers` - Cabeçalhos HTTP
- `cache` - Cache de conteúdo

## Verificar no Navegador
