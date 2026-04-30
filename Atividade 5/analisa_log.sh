#!/bin/bash
# Script para analisar logs e extrair erros

analisa_log() {
    LOG_FILE="/var/log/syslog"
    DATA=$(date +%Y%m%d_%H%M%S)
    OUTPUT_FILE="erros_${DATA}.txt"
    
    if [ ! -f "$LOG_FILE" ]; then
        echo "Erro: Arquivo $LOG_FILE nao encontrado!"
        return 1
    fi
    
    echo "=== RELATORIO DE ERROS - $(date) ===" > "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "Linhas encontradas com ERROR:" >> "$OUTPUT_FILE"
    echo "-----------------------------" >> "$OUTPUT_FILE"
    
    grep -i "ERROR" "$LOG_FILE" >> "$OUTPUT_FILE"
    
    TOTAL=$(grep -i -c "ERROR" "$LOG_FILE")
    echo "" >> "$OUTPUT_FILE"
    echo "Total de erros encontrados: $TOTAL" >> "$OUTPUT_FILE"
    
    echo "Relatorio gerado: $OUTPUT_FILE"
    echo "Total de erros: $TOTAL"
}

analisa_log
