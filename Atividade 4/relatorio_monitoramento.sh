#!/bin/bash
# O script deve mostrar o espaço livre em disco em formato legível para humanos
# e depois mostrar o tamanho do diretório /home.

echo "Espaço livre nos discos:"
df -h

echo ""
echo "Tamanho do diretório /home:"
du -sh /home
