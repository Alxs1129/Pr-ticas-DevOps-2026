#!/bin/bash
# Script para filtrar logs

echo "=== Filtrando código 4786228.66 ==="
echo ""

# Conta total de ocorrências
total=$(grep -c "4786228.66" apache.log)
echo "Total de ocorrências: $total"
echo ""

# Mostra as 5 primeiras
echo "As 5 primeiras ocorrências:"
echo "---------------------------"
grep "4786228.66" apache.log | head -5
