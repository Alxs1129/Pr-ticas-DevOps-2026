#!/bin/bash
# Versão para teste no Windows

analisa_log() {
    # Criar arquivo de exemplo
    cat > syslog_exemplo.txt << 'EOL'
2026-04-29 08:30:15 INFO Servidor iniciado
2026-04-29 08:32:22 ERROR Falha na conexão
2026-04-29 08:35:10 WARNING Uso de CPU alto
2026-04-29 08:40:05 ERROR Timeout na requisicao
2026-04-29 08:45:30 INFO Backup concluido
2026-04-29 08:50:45 ERROR Falha ao carregar modulo
EOL
    
    LOG_FILE="syslog_exemplo.txt"
    DATA=$(date +%Y%m%d_%H%M%S)
    OUTPUT_FILE="erros_${DATA}.txt"
    
    echo "=== RELATORIO DE ERROS - $(date) ===" > "$OUTPUT_FILE"
    grep -i "ERROR" "$LOG_FILE" >> "$OUTPUT_FILE"
    
    TOTAL=$(grep -i -c "ERROR" "$LOG_FILE")
    echo "Total de erros: $TOTAL" >> "$OUTPUT_FILE"
    
    cat "$OUTPUT_FILE"
}

analisa_log
