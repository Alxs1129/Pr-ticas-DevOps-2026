
#!/bin/bash

extrair_ips() {

    grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}' "$1" | sort -u
}


LOG_FILE="syslog_exemplo.txt"

DATA=$(date +%Y%m%d)

RELATORIO_DIR="relatorios_ip"

RELATORIO="${RELATORIO_DIR}/ips_${DATA}.txt"


mkdir -p "$RELATORIO_DIR"


if [ ! -f "$LOG_FILE" ]; then

    echo "Erro: Arquivo $LOG_FILE nao encontrado!"

    exit 1

fi

echo "=== RELATORIO DE IPS - $(date) ===" > "$RELATORIO"

echo "" >> "$RELATORIO"

echo "IPs encontrados no arquivo:" >> "$RELATORIO"

extrair_ips "$LOG_FILE" >> "$RELATORIO"

echo "" >> "$RELATORIO"

echo "Total de IPs unicos: $(extrair_ips "$LOG_FILE" | wc -l)" >> "$RELATORIO"

echo "Relatorio gerado: $RELATORIO"

cat "$RELATORIO"

