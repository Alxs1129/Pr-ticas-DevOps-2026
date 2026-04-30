#!/bin/bash

# Script pra mostrar os comandos essenciais de DevOps
# Fiz na aula do professor Eder
# Data: 15/04/2026

echo "============================================"
echo "   COMANDOS ESSENCIAIS - DEVOPS"
echo "============================================"
echo ""

# 1. grep
echo ""
echo "------------------------------------------------"
echo "COMANDO: grep"
echo "------------------------------------------------"
echo "O que faz: Procura por palavras ou padrões em arquivos"
echo "Ajuda: grep --help"
echo "Exemplo: grep 'erro' arquivo.log"
echo ""

echo "linha normal" > teste.txt
echo "linha com ERRO aqui" >> teste.txt
echo "outra linha" >> teste.txt

echo "Procurando por 'ERRO' no arquivo:"
grep "ERRO" teste.txt
echo ""

# 2. touch
echo ""
echo "------------------------------------------------"
echo "COMANDO: touch"
echo "------------------------------------------------"
echo "O que faz: Cria um arquivo vazio ou atualiza a data"
echo "Ajuda: touch --help"
echo "Exemplo: touch novo_arquivo.txt"
echo ""

touch meu_arquivo.txt
ls -la meu_arquivo.txt
echo ""

# 3. curl
echo ""
echo "------------------------------------------------"
echo "COMANDO: curl"
echo "------------------------------------------------"
echo "O que faz: Baixa arquivos ou testa APIs da internet"
echo "Ajuda: curl --help"
echo "Exemplo: curl https://api.exemplo.com"
echo ""

echo "Testando curl com um site simples..."
curl -s https://httpbin.org/ip
echo ""
echo ""

# 4. cat
echo ""
echo "------------------------------------------------"
echo "COMANDO: cat"
echo "------------------------------------------------"
echo "O que faz: Mostra o conteudo de arquivos"
echo "Ajuda: cat --help"
echo "Exemplo: cat arquivo.txt"
echo ""

echo "Conteudo do arquivo teste.txt:"
cat teste.txt
echo ""

# 5. gzip
echo ""
echo "------------------------------------------------"
echo "COMANDO: gzip"
echo "------------------------------------------------"
echo "O que faz: Compacta arquivos"
echo "Ajuda: gzip --help"
echo "Exemplo: gzip arquivo.txt"
echo ""

gzip -c teste.txt > teste.txt.gz
ls -la teste.txt.gz
echo ""

# 6. chmod
echo ""
echo "------------------------------------------------"
echo "COMANDO: chmod"
echo "------------------------------------------------"
echo "O que faz: Muda as permissoes de arquivos"
echo "Ajuda: chmod --help"
echo "Exemplo: chmod +x script.sh"
echo ""

echo "#!/bin/bash" > script.sh
echo "echo 'ola mundo'" >> script.sh
echo "Permissao antes:"
ls -la script.sh
chmod +x script.sh
echo "Permissao depois:"
ls -la script.sh
echo ""

# 7. date
echo ""
echo "------------------------------------------------"
echo "COMANDO: date"
echo "------------------------------------------------"
echo "O que faz: Mostra a data e hora do sistema"
echo "Ajuda: date --help"
echo "Exemplo: date +%Y%m%d"
echo ""

echo "Data/hora atual: $(date)"
echo "Data para log: $(date +%Y%m%d_%H%M%S)"
echo ""

# 8. pwd
echo ""
echo "------------------------------------------------"
echo "COMANDO: pwd"
echo "------------------------------------------------"
echo "O que faz: Mostra em qual pasta voce esta"
echo "Ajuda: pwd --help"
echo "Exemplo: pwd"
echo ""

echo "Voce esta em: $(pwd)"
echo ""

# 9. pgrep
echo ""
echo "------------------------------------------------"
echo "COMANDO: pgrep"
echo "------------------------------------------------"
echo "O que faz: Procura pelo PID de um processo"
echo "Ajuda: pgrep --help"
echo "Exemplo: pgrep bash"
echo ""

pgrep -l bash 2>/dev/null || echo "Nenhum processo bash encontrado"
echo ""

# 10. ps
echo ""
echo "------------------------------------------------"
echo "COMANDO: ps"
echo "------------------------------------------------"
echo "O que faz: Lista os processos rodando"
echo "Ajuda: ps --help"
echo "Exemplo: ps aux | head -10"
echo ""

echo "Top 5 processos por CPU:"
ps aux --sort=-%cpu 2>/dev/null | head -6
echo ""

# 11. df
echo ""
echo "------------------------------------------------"
echo "COMANDO: df"
echo "------------------------------------------------"
echo "O que faz: Mostra o espaco em disco"
echo "Ajuda: df --help"
echo "Exemplo: df -h"
echo ""

df -h
echo ""

# 12. du
echo ""
echo "------------------------------------------------"
echo "COMANDO: du"
echo "------------------------------------------------"
echo "O que faz: Mostra o tamanho de pastas/arquivos"
echo "Ajuda: du --help"
echo "Exemplo: du -sh pasta/"
echo ""

du -sh .
echo ""

# Final
echo ""
echo "============================================"
echo "    FIM - Comandos demonstrados"
echo "============================================"
echo ""

echo "Quer apagar os arquivos de teste? (s/n)"
read resposta

if [ "$resposta" = "s" ] || [ "$resposta" = "S" ]; then
    rm -f teste.txt meu_arquivo.txt script.sh teste.txt.gz
    echo "Arquivos removidos!"
fi

echo ""
echo "Ate mais! Use 'comando --help' para saber mais."
