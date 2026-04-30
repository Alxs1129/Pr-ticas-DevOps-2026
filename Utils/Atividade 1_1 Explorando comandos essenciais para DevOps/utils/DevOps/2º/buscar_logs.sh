#!/bin/bash
# O objetivo é buscar no diretório /var/log todos os arquivos com extensão .log
# e exibir seus nomes.

find /var/log -type f -name "*.log"
