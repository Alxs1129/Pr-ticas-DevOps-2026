#!/bin/bash
# Script: regex_log_analyzer.sh
# Atividade 2.1 - Analise de Logs e Geracao de Relatorios
# Disciplina: Laboratorio de Programacao para Operacao de Infraestrutura de Redes

# Configuracoes
LOG_FILE="access.log"
DATA_ATUAL=$(date +%Y%m%d_%H%M%S)
DIR_SAIDA="log_analysis_${DATA_ATUAL}"

# Funcao para exibir mensagens
log_info() {
    echo "[INFO] $1"
}

log_success() {
    echo "[OK] $1"
}

log_warning() {
    echo "[ATENCAO] $1"
}

log_error() {
    echo "[ERRO] $1"
}

# Funcao para verificar se o arquivo de log existe
verificar_log() {
    if [ ! -f "$LOG_FILE" ]; then
        log_error "Arquivo $LOG_FILE nao encontrado"
        echo ""
        echo "Criando arquivo de exemplo para teste..."
        
        # Criar arquivo de log de exemplo
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
10.0.0.5 - - [18/Jul/2017:14:51:22 -0300] "GET /status HTTP/1.1" 200 123 "http://site.com" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
45.67.89.10 - - [18/Jul/2017:14:52:45 -0300] "GET /api/data HTTP/1.1" 200 4567 "http://api.site.com" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
192.168.1.100 - - [18/Jul/2017:14:53:33 -0300] "GET /admin HTTP/1.1" 200 2345 "http://site.com" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
EOF
        log_success "Arquivo de exemplo criado: $LOG_FILE"
    fi
}

# Criar diretorio de saida
criar_diretorio() {
    mkdir -p "$DIR_SAIDA"
    log_info "Diretorio criado: $DIR_SAIDA"
}

# 1. Lista de IPs unicos
extrair_ips_unicos() {
    log_info "Extraindo IPs unicos..."
    grep -E -o '^([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOG_FILE" | sort -u > "$DIR_SAIDA/1_unique_ips.txt"
    total=$(wc -l < "$DIR_SAIDA/1_unique_ips.txt")
    log_success "IPs unicos encontrados: $total"
}

# 2. Metodos HTTP e quantidade
extrair_http_methods() {
    log_info "Extraindo metodos HTTP..."
    grep -E -o '"(GET|POST|PUT|DELETE|HEAD|OPTIONS|PATCH)' "$LOG_FILE" | sed 's/"//' | sort | uniq -c | sort -rn > "$DIR_SAIDA/2_http_methods.txt"
    log_success "Metodos HTTP extraidos"
}

# 3. Metodos perigosos (DELETE e PUT)
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

# 5. Top 10 IPs que mais fizeram requisicoes
extrair_top_ips() {
    log_info "Extraindo top 10 IPs..."
    grep -E -o '^([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10 > "$DIR_SAIDA/5_top_ips.txt"
    log_success "Top 10 IPs identificados"
}

# 6. Gerar relatorio consolidado
gerar_relatorio() {
    log_info "Gerando relatorio consolidado..."
    
    cat > "$DIR_SAIDA/report.txt" << EOF
RELATORIO DE ANALISE DE LOGS
Data da analise: $(date)
Arquivo de origem: $LOG_FILE
----------------------------------------

1. RESUMO GERAL
Total de requisicoes: $(wc -l < "$LOG_FILE")
IPs unicos: $(wc -l < "$DIR_SAIDA/1_unique_ips.txt")
Metodos HTTP distintos: $(grep -E -o '"(GET|POST|PUT|DELETE|HEAD|OPTIONS|PATCH)' "$LOG_FILE" | sed 's/"//' | sort -u | wc -l)

2. METODOS HTTP
$(cat "$DIR_SAIDA/2_http_methods.txt")

3. METODOS PERIGOSOS (DELETE, PUT)
Total de ocorrencias: $(wc -l < "$DIR_SAIDA/3_dangerous_methods.txt")
$(cat "$DIR_SAIDA/3_dangerous_methods.txt")

4. TOP 10 URLs MAIS ACESSADAS
$(head -10 "$DIR_SAIDA/4_urls.txt")

5. TOP 10 IPs QUE MAIS ACESSARAM
$(cat "$DIR_SAIDA/5_top_ips.txt")

6. CODIGOS DE STATUS
Codigos 2xx (sucesso): $(grep -E '"[A-Z]+ [^"]+" 2[0-9]{2}' "$LOG_FILE" | wc -l)
Codigos 4xx (erro cliente): $(grep -E '"[A-Z]+ [^"]+" 4[0-9]{2}' "$LOG_FILE" | wc -l)
Codigos 5xx (erro servidor): $(grep -E '"[A-Z]+ [^"]+" 5[0-9]{2}' "$LOG_FILE" | wc -l)

7. USER-AGENTS (BOTS)
$(grep -i -E 'bot|crawler|spider|scraper' "$LOG_FILE" | wc -l) requisicoes identificadas como bots

Principais User-Agents de bots:
$(grep -i -E 'bot|crawler|spider|scraper' "$LOG_FILE" | grep -E -o '"[^"]+"$' | sed 's/"//g' | sort | uniq -c | sort -rn | head -5)
EOF
    
    log_success "Relatorio gerado: $DIR_SAIDA/report.txt"
}

# Mostrar resumo dos arquivos gerados
mostrar_resumo() {
    echo ""
    echo "ARQUIVOS GERADOS:"
    echo "Diretorio: $DIR_SAIDA"
    echo ""
    ls -la "$DIR_SAIDA"
    echo ""
    echo "CONTEUDO DOS ARQUIVOS:"
    echo ""
    
    echo "--- 1_unique_ips.txt ---"
    cat "$DIR_SAIDA/1_unique_ips.txt"
    
    echo ""
    echo "--- 2_http_methods.txt ---"
    cat "$DIR_SAIDA/2_http_methods.txt"
    
    echo ""
    echo "--- 3_dangerous_methods.txt ---"
    cat "$DIR_SAIDA/3_dangerous_methods.txt"
    
    echo ""
    echo "--- 4_urls.txt ---"
    cat "$DIR_SAIDA/4_urls.txt"
    
    echo ""
    echo "--- 5_top_ips.txt ---"
    cat "$DIR_SAIDA/5_top_ips.txt"
}

# Funcao principal
main() {
    echo ""
    echo "Analisador de Logs - Web Server"
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
    echo "Analise concluida"
    echo "Resultados: $DIR_SAIDA/"
    echo "Relatorio: $DIR_SAIDA/report.txt"
    echo ""
}

# Executar script
main
