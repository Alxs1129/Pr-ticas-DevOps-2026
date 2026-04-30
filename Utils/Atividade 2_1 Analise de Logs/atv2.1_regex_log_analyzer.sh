#!/bin/bash
# ------------------------------------------------------------------------ #
# Script Name:   regex_log_analyzer.sh
# Description:   Análise de logs do servidor web
# Written by:    Alexandre Araujo
# ------------------------------------------------------------------------ #
# Usage: ./regex_log_analyzer.sh
# ------------------------------------------------------------------------ #

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configurações
LOG_FILE="apache.log"
DATA_ATUAL=$(date +%Y%m%d_%H%M%S)
DIR_SAIDA="log_analysis_${DATA_ATUAL}"

# Função para exibir mensagens
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[ATENCAO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

# Verificar se o arquivo de log existe
verificar_log() {
    if [ ! -f "$LOG_FILE" ]; then
        log_error "Arquivo $LOG_FILE nao encontrado!"
        echo ""
        echo "Criando arquivo de exemplo para teste..."
        
        cat > "$LOG_FILE" << 'EOF'
163.1.21.143 - - [18/Jul/2017:14:39:35 -0300] "GET /search/tag/list HTTP/1.0" 200 4973 "http://rowe.org/search.htm" "Mozilla/5.0 (Windows NT 5.2) AppleWebKit/5331 (KHTML, like Gecko) Chrome/13.0.824.0 Safari/5331"
192.168.1.100 - - [18/Jul/2017:14:40:12 -0300] "DELETE /admin/user/1 HTTP/1.1" 403 1245 "http://site.com/admin" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
10.0.0.5 - - [18/Jul/2017:14:41:05 -0300] "PUT /api/update HTTP/1.1" 401 892 "http://api.site.com" "Python-urllib/3.6"
200.150.30.45 - - [18/Jul/2017:14:42:23 -0300] "GET /login HTTP/1.1" 404 234 "http://site.com/home" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36"
163.1.21.143 - - [18/Jul/2017:14:43:17 -0300] "GET /dashboard HTTP/1.1" 500 1567 "http://site.com/home" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
192.168.1.100 - - [18/Jul/2017:14:44:02 -0300] "GET /users HTTP/1.1" 200 3421 "http://site.com/admin" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
45.67.89.10 - - [18/Jul/2017:14:45:31 -0300] "POST /api/login HTTP/1.1" 200 567 "http://api.site.com" "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15"
163.1.21.143 - - [18/Jul/2017:14:46:48 -0300] "GET /search/tag/list HTTP/1.0" 200 4973 "http://rowe.org/search.htm" "Mozilla/5.0 (Windows NT 5.2) AppleWebKit/5331 (KHTML, like Gecko) Chrome/13.0.824.0 Safari/5331"
192.168.1.100 - - [18/Jul/2017:14:47:55 -0300] "DELETE /api/session HTTP/1.1" 401 678 "http://site.com/dashboard" "curl/7.68.0"
10.0.0.5 - - [18/Jul/2017:14:48:33 -0300] "GET /config HTTP/1.1" 403 234 "http://site.com/admin" "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36"
200.150.30.45 - - [18/Jul/2017:14:49:12 -0300] "GET / HTTP/1.1" 200 9876 "http://google.com" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
45.67.89.10 - - [18/Jul/2017:14:50:05 -0300] "POST /api/upload HTTP/1.1" 413 2345 "http://api.site.com" "Go-http-client/1.1"
EOF
        log_success "Arquivo de exemplo criado: $LOG_FILE"
    fi
}

# Criar diretório de saída
criar_diretorio() {
    mkdir -p "$DIR_SAIDA"
    log_info "Diretorio criado: $DIR_SAIDA"
}

# 1. Lista de IPs únicos
extrair_ips_unicos() {
    log_info "Extraindo IPs unicos..."
    grep -E -o '^([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOG_FILE" | sort -u > "$DIR_SAIDA/1_unique_ips.txt"
    total=$(wc -l < "$DIR_SAIDA/1_unique_ips.txt")
    log_success "IPs unicos encontrados: $total"
}

# 2. Métodos HTTP e quantidade
extrair_http_methods() {
    log_info "Extraindo metodos HTTP..."
    grep -E -o '"(GET|POST|PUT|DELETE|HEAD|OPTIONS|PATCH)' "$LOG_FILE" | sed 's/"//' | sort | uniq -c | sort -rn > "$DIR_SAIDA/2_http_methods.txt"
    log_success "Metodos HTTP extraidos"
}

# 3. Métodos perigosos (DELETE e PUT)
extrair_dangerous_methods() {
    log_info "Extraindo metodos perigosos (DELETE, PUT)..."
    grep -E '"(DELETE|PUT)' "$LOG_FILE" > "$DIR_SAIDA/3_dangerous_methods.txt"
    total=$(wc -l < "$DIR_SAIDA/3_dangerous_methods.txt")
    
    if [ $total -gt 0 ]; then
        log_warning "Metodos perigosos encontrados: $total"
    else
        log_success "Nenhum metodo perigoso encontrado"
    fi
}

# 4. URLs requisitadas e contagem
extrair_urls() {
    log_info "Extraindo URLs requisitadas..."
    grep -E -o '"[A-Z]+ [^ ]+' "$LOG_FILE" | sed 's/"[A-Z]+ //' | sort | uniq -c | sort -rn > "$DIR_SAIDA/4_urls.txt"
    log_success "URLs extraidas"
}

# 5. Top 10 IPs que mais fizeram requisições
extrair_top_ips() {
    log_info "Extraindo top 10 IPs..."
    grep -E -o '^([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10 > "$DIR_SAIDA/5_top_ips.txt"
    log_success "Top 10 IPs identificados"
}

# 6. Gerar relatório consolidado
gerar_relatorio() {
    log_info "Gerando relatorio consolidado..."
    
    cat > "$DIR_SAIDA/report.txt" << EOF
================================================================================
RELATORIO DE ANALISE DE LOGS
================================================================================
Data da analise: $(date)
Arquivo de origem: $LOG_FILE
Diretorio de saida: $DIR_SAIDA

================================================================================
1. RESUMO GERAL
================================================================================
Total de requisicoes: $(wc -l < "$LOG_FILE")
IPs unicos: $(wc -l < "$DIR_SAIDA/1_unique_ips.txt")
Metodos HTTP distintos: $(grep -E -o '"(GET|POST|PUT|DELETE|HEAD|OPTIONS|PATCH)' "$LOG_FILE" | sed 's/"//' | sort -u | wc -l)

================================================================================
2. METODOS HTTP
================================================================================
$(cat "$DIR_SAIDA/2_http_methods.txt")

================================================================================
3. METODOS PERIGOSOS (DELETE, PUT)
================================================================================
Total de ocorrencias: $(wc -l < "$DIR_SAIDA/3_dangerous_methods.txt")
$(cat "$DIR_SAIDA/3_dangerous_methods.txt")

================================================================================
4. TOP 10 URLs MAIS ACESSADAS
================================================================================
$(head -10 "$DIR_SAIDA/4_urls.txt")

================================================================================
5. TOP 10 IPs QUE MAIS ACESSARAM
================================================================================
$(cat "$DIR_SAIDA/5_top_ips.txt")

================================================================================
6. CODIGOS DE STATUS
================================================================================
Codigos 2xx (sucesso): $(grep -E '"[A-Z]+ [^"]+" 2[0-9]{2}' "$LOG_FILE" | wc -l)
Codigos 4xx (erro cliente): $(grep -E '"[A-Z]+ [^"]+" 4[0-9]{2}' "$LOG_FILE" | wc -l)
Codigos 5xx (erro servidor): $(grep -E '"[A-Z]+ [^"]+" 5[0-9]{2}' "$LOG_FILE" | wc -l)

================================================================================
7. USER-AGENTS (BOTS)
================================================================================
$(grep -i -E 'bot|crawler|spider|scraper' "$LOG_FILE" | wc -l) requisicoes identificadas como bots

Principais User-Agents de bots:
$(grep -i -E 'bot|crawler|spider|scraper' "$LOG_FILE" | grep -E -o '"[^"]+"$' | sed 's/"//g' | sort | uniq -c | sort -rn | head -5)

================================================================================
FIM DO RELATORIO
================================================================================
EOF
    
    log_success "Relatorio gerado: $DIR_SAIDA/report.txt"
}

# Mostrar resumo dos arquivos gerados
mostrar_resumo() {
    echo ""
    echo "================================================================================"
    echo -e "${GREEN}ARQUIVOS GERADOS${NC}"
    echo "================================================================================"
    echo -e "📁 Diretorio: ${BLUE}$DIR_SAIDA${NC}"
    echo ""
    ls -la "$DIR_SAIDA"
    echo ""
    echo "================================================================================"
    echo -e "${GREEN}CONTEUDO DOS ARQUIVOS${NC}"
    echo "================================================================================"
    
    echo ""
    echo -e "${YELLOW}--- 1_unique_ips.txt ---${NC}"
    cat "$DIR_SAIDA/1_unique_ips.txt"
    
    echo ""
    echo -e "${YELLOW}--- 2_http_methods.txt ---${NC}"
    cat "$DIR_SAIDA/2_http_methods.txt"
    
    echo ""
    echo -e "${YELLOW}--- 3_dangerous_methods.txt ---${NC}"
    cat "$DIR_SAIDA/3_dangerous_methods.txt"
    
    echo ""
    echo -e "${YELLOW}--- 4_urls.txt ---${NC}"
    head -10 "$DIR_SAIDA/4_urls.txt"
    
    echo ""
    echo -e "${YELLOW}--- 5_top_ips.txt ---${NC}"
    cat "$DIR_SAIDA/5_top_ips.txt"
}

# Função principal
main() {
    echo ""
    echo "================================================================================"
    echo -e "${BLUE}ANALISADOR DE LOGS - WEB SERVER${NC}"
    echo "================================================================================"
    echo ""
    
    verificar_log
    criar_diretorio
    echo ""
    
    extrair_ips_unicos
    extrair_http_methods
    extrair_dangerous_methods
    extrair_urls
    extrair_top_ips
    gerar_relatorio
    mostrar_resumo
    
    echo ""
    echo "================================================================================"
    echo -e "${GREEN}ANALISE CONCLUIDA COM SUCESSO!${NC}"
    echo "================================================================================"
    echo ""
    echo -e "📁 Resultados salvos em: ${BLUE}$DIR_SAIDA/${NC}"
    echo -e "📄 Relatorio completo: ${BLUE}$DIR_SAIDA/report.txt${NC}"
    echo ""
}

# Executar script
main
