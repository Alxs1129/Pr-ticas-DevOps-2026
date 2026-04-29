#!/bin/bash

# Script pra mostrar os comandos essenciais de DevOps
# Fiz na aula do professor Eder
# Data: 15/04/2026

# Só pra ficar bonitinho
echo "============================================"
echo "   COMANDOS ESSENCIAIS - DEVOPS"
echo "============================================"
echo ""

# ================================================
# 1. grep - serve pra procurar coisas
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: grep"
echo "------------------------------------------------"
echo "O que faz: Procura por palavras ou padrões em arquivos"
echo "Ajuda: grep --help"
echo ""
echo "Exemplo: grep 'erro' arquivo.log"
echo ""

# Criando um arquivinho pra testar
echo "Teste: criando um arquivo qualquer..."
echo "linha normal" > teste.txt
echo "linha com ERRO aqui" >> teste.txt
echo "outra linha" >> teste.txt

echo "Procurando por 'ERRO' no arquivo:"
grep "ERRO" teste.txt
echo ""

# ================================================
# 2. touch - cria arquivo vazio
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: touch"
echo "------------------------------------------------"
echo "O que faz: Cria um arquivo vazio ou atualiza a data"
echo "Ajuda: touch --help"
echo ""
echo "Exemplo: touch novo_arquivo.txt"
echo ""

echo "Criando um arquivo com touch..."
touch meu_arquivo.txt
ls -la meu_arquivo.txt
echo ""

# ================================================
# 3. curl - baixa coisa da internet
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: curl"
echo "------------------------------------------------"
echo "O que faz: Baixa arquivos ou testa APIs da internet"
echo "Ajuda: curl --help"
echo ""
echo "Exemplo: curl https://api.exemplo.com"
echo ""

echo "Testando curl com um site simples..."
curl -s https://httpbin.org/ip
echo ""
echo ""

# ================================================
# 4. cat - mostra o conteudo do arquivo
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: cat"
echo "------------------------------------------------"
echo "O que faz: Mostra o conteudo de arquivos"
echo "Ajuda: cat --help"
echo ""
echo "Exemplo: cat arquivo.txt"
echo ""

echo "Mostrando o conteudo do arquivo teste.txt:"
cat teste.txt
echo ""

# ================================================
# 5. gzip - compacta arquivo
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: gzip"
echo "------------------------------------------------"
echo "O que faz: Compacta arquivos (deixa menor)"
echo "Ajuda: gzip --help"
echo ""
echo "Exemplo: gzip arquivo.txt"
echo ""

echo "Compactando o arquivo teste.txt..."
gzip -c teste.txt > teste.txt.gz
echo "Arquivo compactado: teste.txt.gz"
ls -la teste.txt.gz
echo ""

# ================================================
# 6. chmod - muda permissão de arquivo
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: chmod"
echo "------------------------------------------------"
echo "O que faz: Muda as permissões de arquivos"
echo "Ajuda: chmod --help"
echo ""
echo "Exemplo: chmod +x script.sh"
echo ""

echo "Criando um script simples..."
echo "#!/bin/bash" > script.sh
echo "echo 'ola mundo'" >> script.sh

echo "Permissao antes:"
ls -la script.sh
echo ""

echo "Dando permissao de execução..."
chmod +x script.sh

echo "Permissao depois:"
ls -la script.sh
echo ""

# ================================================
# 7. date - mostra data e hora
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: date"
echo "------------------------------------------------"
echo "O que faz: Mostra a data e hora do sistema"
echo "Ajuda: date --help"
echo ""
echo "Exemplo: date +%Y%m%d"
echo ""

echo "Data/hora atual: $(date)"
echo "Data pra usar em log: $(date +%Y%m%d_%H%M%S)"
echo ""

# ================================================
# 8. pwd - mostra onde vc ta
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: pwd"
echo "------------------------------------------------"
echo "O que faz: Mostra em qual pasta vc está"
echo "Ajuda: pwd --help"
echo ""
echo "Exemplo: pwd"
echo ""

echo "Você está na pasta: $(pwd)"
echo ""

# ================================================
# 9. pgrep - procura processo
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: pgrep"
echo "------------------------------------------------"
echo "O que faz: Procura pelo ID (PID) de um processo"
echo "Ajuda: pgrep --help"
echo ""
echo "Exemplo: pgrep bash"
echo ""

echo "Procurando processos do bash..."
pgrep -l bash 2>/dev/null || echo "Nao achei nenhum bash rodando"
echo ""

# ================================================
# 10. ps - lista processos
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: ps"
echo "------------------------------------------------"
echo "O que faz: Lista os processos rodando"
echo "Ajuda: ps --help"
echo ""
echo "Exemplo: ps aux | head -10"
echo ""

echo "Top 5 processos que tão consumindo CPU:"
ps aux --sort=-%cpu 2>/dev/null | head -6
echo ""

# ================================================
# 11. df - mostra espaço no disco
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: df"
echo "------------------------------------------------"
echo "O que faz: Mostra quanto espaço tem no disco"
echo "Ajuda: df --help"
echo ""
echo "Exemplo: df -h"
echo ""

echo "Espaço em disco:"
df -h
echo ""

# ================================================
# 12. du - mostra tamanho de pastas
# ================================================
echo ""
echo "------------------------------------------------"
echo "COMANDO: du"
echo "------------------------------------------------"
echo "O que faz: Mostra o tamanho de pastas/arquivos"
echo "Ajuda: du --help"
echo ""
echo "Exemplo: du -sh pasta/"
echo ""

echo "Tamanho da pasta atual:"
du -sh .
echo ""

# ================================================
# Finalizando
# ================================================
echo ""
echo "============================================"
echo "    FIM - Comandos demonstrados"
echo "============================================"
echo ""

# Perguntar se quer limpar
echo "Quer apagar os arquivos de teste? (s/n)"
read resposta

if [ "$resposta" = "s" ] || [ "$resposta" = "S" ]; then
    rm -f teste.txt meu_arquivo.txt script.sh teste.txt.gz
    echo "Arquivos removidos!"
fi

echo ""
echo "Até mais! Use 'comando --help' pra saber mais."
