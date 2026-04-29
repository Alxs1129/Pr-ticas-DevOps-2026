#!/usr/bin/env bash
# ------------------------------------------------------------------------ #
# Script Name:   file_operations.sh
# Description:   Multi-functional file operations script
# Site:          
# Written by:    Alexandre Araujo
# Maintenance:   Alexandre Araujo
# ------------------------------------------------------------------------ #
# Usage:         
#       $ ./file_operations.sh [opção] [argumentos]
#       $ ./file_operations.sh --menu (para modo interativo)
#       $ ./file_operations.sh rename /caminho/dir "prefixo_" "_sufixo"
#       $ ./file_operations.sh convert /caminho/imagens png jpg
#       $ ./file_operations.sh compress /caminho/pasta zip
#       $ ./file_operations.sh extract /caminho/arquivo.zip
#       $ ./file_operations.sh chmod /caminho/arquivo 755
#       $ ./file_operations.sh search /caminho "*.txt"
# ------------------------------------------------------------------------ #

# VARIABLES --------------------------------------------------------------- #
OPERATION="$1"
ARG1="$2"
ARG2="$3"
ARG3="$4"

# CORES PARA OUTPUT
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# FUNCTIONS --------------------------------------------------------------- #

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[ATENCAO]${NC} $1"
}

# ------------------------------------------------------------------------ #
# 1. RENOMEAR ARQUIVOS
# ------------------------------------------------------------------------ #
rename_files() {
    local dir="${1:-$ARG1}"
    local prefixo="${2:-$ARG2}"
    local sufixo="${3:-$ARG3}"
    
    if [ -z "$dir" ]; then
        echo -n "Digite o diretorio: "
        read dir
    fi
    
    if [ ! -d "$dir" ]; then
        log_error "Diretorio '$dir' nao encontrado!"
        return 1
    fi
    
    if [ -z "$prefixo" ]; then
        echo -n "Digite o prefixo (ex: novo_): "
        read prefixo
    fi
    
    if [ -z "$sufixo" ]; then
        echo -n "Digite o sufixo (ex: _backup): "
        read sufixo
    fi
    
    cd "$dir" || return 1
    
    local contador=0
    for arquivo in *; do
        if [ -f "$arquivo" ]; then
            nome_sem_ext="${arquivo%.*}"
            extensao="${arquivo##*.}"
            
            if [ "$nome_sem_ext" != "$arquivo" ]; then
                novo_nome="${prefixo}${nome_sem_ext}${sufixo}.${extensao}"
            else
                novo_nome="${prefixo}${arquivo}${sufixo}"
            fi
            
            mv "$arquivo" "$novo_nome"
            echo "Renomeado: $arquivo -> $novo_nome"
            ((contador++))
        fi
    done
    
    log_success "$contador arquivos renomeados em $dir"
    cd - > /dev/null || return
}

# ------------------------------------------------------------------------ #
# 2. CONVERTER IMAGENS
# ------------------------------------------------------------------------ #
convert_images() {
    local dir="${1:-$ARG1}"
    local formato_origem="${2:-$ARG2}"
    local formato_destino="${3:-$ARG3}"
    
    if [ -z "$dir" ]; then
        echo -n "Digite o diretorio das imagens: "
        read dir
    fi
    
    if [ ! -d "$dir" ]; then
        log_error "Diretorio '$dir' nao encontrado!"
        return 1
    fi
    
    if [ -z "$formato_origem" ]; then
        echo -n "Digite o formato de origem (jpg, png, gif): "
        read formato_origem
    fi
    
    if [ -z "$formato_destino" ]; then
        echo -n "Digite o formato de destino: "
        read formato_destino
    fi
    
    cd "$dir" || return 1
    
    # Verificar ImageMagick
    if command -v magick &> /dev/null; then
        CONVERT_CMD="magick convert"
    elif command -v convert &> /dev/null; then
        CONVERT_CMD="convert"
    else
        log_error "ImageMagick nao instalado!"
        log_warning "Instale com: winget install ImageMagick.ImageMagick (Windows)"
        log_warning "Ou: sudo apt install imagemagick (Linux)"
        cd - > /dev/null || return
        return 1
    fi
    
    local contador=0
    for arquivo in *."$formato_origem"; do
        if [ -f "$arquivo" ]; then
            nome_base="${arquivo%.*}"
            $CONVERT_CMD "$arquivo" "${nome_base}.${formato_destino}"
            echo "Convertido: $arquivo -> ${nome_base}.${formato_destino}"
            ((contador++))
        fi
    done
    
    if [ $contador -eq 0 ]; then
        log_warning "Nenhum arquivo .$formato_origem encontrado!"
    else
        log_success "$contador imagens convertidas para .$formato_destino"
    fi
    
    cd - > /dev/null || return
}

# ------------------------------------------------------------------------ #
# 3. COMPACTAR ARQUIVOS
# ------------------------------------------------------------------------ #
compress_files() {
    local caminho="${1:-$ARG1}"
    local formato="${2:-$ARG2}"
    local nome_saida="${3:-$ARG3}"
    
    if [ -z "$caminho" ]; then
        echo -n "Digite o caminho do arquivo/diretorio: "
        read caminho
    fi
    
    if [ ! -e "$caminho" ]; then
        log_error "Caminho '$caminho' nao encontrado!"
        return 1
    fi
    
    if [ -z "$formato" ]; then
        echo "Formatos disponiveis: zip, tar.gz, tar.bz2, 7z"
        echo -n "Digite o formato: "
        read formato
    fi
    
    if [ -z "$nome_saida" ]; then
        nome_saida=$(basename "$caminho")
    fi
    
    local dir_saida=$(dirname "$caminho")
    cd "$dir_saida" || return 1
    
    case "$formato" in
        zip)
            if command -v zip &> /dev/null; then
                zip -r "${nome_saida}.zip" "$(basename "$caminho")"
                log_success "Criado: ${nome_saida}.zip"
            else
                log_error "zip nao encontrado. Instale com: sudo apt install zip"
            fi
            ;;
        tar.gz)
            tar -czf "${nome_saida}.tar.gz" "$(basename "$caminho")"
            log_success "Criado: ${nome_saida}.tar.gz"
            ;;
        tar.bz2)
            tar -cjf "${nome_saida}.tar.bz2" "$(basename "$caminho")"
            log_success "Criado: ${nome_saida}.tar.bz2"
            ;;
        7z)
            if command -v 7z &> /dev/null; then
                7z a "${nome_saida}.7z" "$(basename "$caminho")"
                log_success "Criado: ${nome_saida}.7z"
            else
                log_error "7z nao encontrado. Instale com: sudo apt install p7zip-full"
            fi
            ;;
        *)
            log_error "Formato '$formato' nao suportado!"
            ;;
    esac
    
    cd - > /dev/null || return
}

# ------------------------------------------------------------------------ #
# 4. DESCOMPACTAR ARQUIVOS
# ------------------------------------------------------------------------ #
extract_files() {
    local arquivo="${1:-$ARG1}"
    local destino="${2:-$ARG2}"
    
    if [ -z "$arquivo" ]; then
        echo -n "Digite o caminho do arquivo: "
        read arquivo
    fi
    
    if [ ! -f "$arquivo" ]; then
        log_error "Arquivo '$arquivo' nao encontrado!"
        return 1
    fi
    
    if [ -z "$destino" ]; then
        destino="${arquivo%.*}"
        echo -n "Destino [padrao: $destino]: "
        read destino_temp
        [ -n "$destino_temp" ] && destino="$destino_temp"
    fi
    
    mkdir -p "$destino"
    
    case "$arquivo" in
        *.zip)
            if command -v unzip &> /dev/null; then
                unzip "$arquivo" -d "$destino"
                log_success "Extraido em: $destino"
            else
                log_error "unzip nao encontrado"
            fi
            ;;
        *.tar.gz|*.tgz)
            tar -xzf "$arquivo" -C "$destino"
            log_success "Extraido em: $destino"
            ;;
        *.tar.bz2)
            tar -xjf "$arquivo" -C "$destino"
            log_success "Extraido em: $destino"
            ;;
        *.tar)
            tar -xf "$arquivo" -C "$destino"
            log_success "Extraido em: $destino"
            ;;
        *.7z)
            if command -v 7z &> /dev/null; then
                7z x "$arquivo" -o"$destino"
                log_success "Extraido em: $destino"
            else
                log_error "7z nao encontrado"
            fi
            ;;
        *)
            log_error "Formato nao suportado"
            ;;
    esac
}

# ------------------------------------------------------------------------ #
# 5. ALTERAR PERMISSOES
# ------------------------------------------------------------------------ #
change_permissions() {
    local caminho="${1:-$ARG1}"
    local permissao="${2:-$ARG2}"
    
    if [ -z "$caminho" ]; then
        echo -n "Digite o caminho: "
        read caminho
    fi
    
    if [ ! -e "$caminho" ]; then
        log_error "Caminho '$caminho' nao encontrado!"
        return 1
    fi
    
    echo "Permissoes atuais:"
    ls -la "$caminho"
    echo ""
    
    if [ -z "$permissao" ]; then
        echo "Opcoes de permissao:"
        echo "  1 - Numerica (ex: 755, 644)"
        echo "  2 - Simbolica (ex: u+x, g-w)"
        echo -n "Escolha (1/2): "
        read opcao_perm
        
        if [ "$opcao_perm" = "1" ]; then
            echo -n "Digite a permissao numerica: "
            read permissao
        else
            echo -n "Digite a permissao simbolica: "
            read permissao
        fi
    fi
    
    echo -n "Aplicar recursivamente? (s/n): "
    read resposta
    
    if [ "$resposta" = "s" ] || [ "$resposta" = "S" ]; then
        chmod -R "$permissao" "$caminho"
        log_success "Permissao recursiva '$permissao' aplicada"
    else
        chmod "$permissao" "$caminho"
        log_success "Permissao '$permissao' aplicada"
    fi
    
    echo ""
    echo "Novas permissoes:"
    ls -la "$caminho"
}

# ------------------------------------------------------------------------ #
# 6. PESQUISAR ARQUIVOS
# ------------------------------------------------------------------------ #
search_files() {
    local dir="${1:-$ARG1}"
    local padrao="${2:-$ARG2}"
    
    if [ -z "$dir" ]; then
        echo -n "Digite o diretorio: "
        read dir
    fi
    
    if [ ! -d "$dir" ]; then
        log_error "Diretorio '$dir' nao encontrado!"
        return 1
    fi
    
    if [ -z "$padrao" ]; then
        echo -n "Digite o padrao (ex: *.txt, *.log): "
        read padrao
    fi
    
    log_info "Buscando por $padrao em $dir..."
    echo ""
    
    find "$dir" -type f -name "$padrao" 2>/dev/null | while read -r arquivo; do
        echo "  📄 $arquivo"
    done
    
    local total=$(find "$dir" -type f -name "$padrao" 2>/dev/null | wc -l)
    echo ""
    log_success "Total: $total arquivos"
}

# ------------------------------------------------------------------------ #
# MENU
# ------------------------------------------------------------------------ #
show_menu() {
    clear
    echo "=========================================="
    echo "     FILE OPERATIONS - DevOps Tools"
    echo "=========================================="
    echo ""
    echo "1. Rename files (add prefix/suffix)"
    echo "2. Convert images (JPG to PNG)"
    echo "3. Compress files/directories"
    echo "4. Extract compressed files"
    echo "5. Change file permissions"
    echo "6. Search files by pattern"
    echo "0. Exit"
    echo ""
    echo -n "Choose an option: "
}

# ------------------------------------------------------------------------ #
# MAIN CODE
# ------------------------------------------------------------------------ #

if [ "$OPERATION" = "--menu" ] || [ -z "$OPERATION" ]; then
    # MODO INTERATIVO
    while true; do
        show_menu
        read option
        
        case $option in
            1) rename_files ;;
            2) convert_images ;;
            3) compress_files ;;
            4) extract_files ;;
            5) change_permissions ;;
            6) search_files ;;
            0) echo "Goodbye!"; exit 0 ;;
            *) echo "Invalid option" ;;
        esac
        
        echo ""
        echo -n "Press Enter to continue..."
        read
    done
else
    # MODO LINHA DE COMANDO
    case "$OPERATION" in
        "rename") rename_files "$ARG1" "$ARG2" "$ARG3" ;;
        "convert") convert_images "$ARG1" "$ARG2" "$ARG3" ;;
        "compress") compress_files "$ARG1" "$ARG2" "$ARG3" ;;
        "extract") extract_files "$ARG1" "$ARG2" ;;
        "chmod") change_permissions "$ARG1" "$ARG2" ;;
        "search") search_files "$ARG1" "$ARG2" ;;
        "--help"|"-h")
            echo "Usage: $0 [--menu|rename|convert|compress|extract|chmod|search]"
            echo ""
            echo "Modo interativo:"
            echo "  $0 --menu"
            echo ""
            echo "Modo linha de comando:"
            echo "  $0 rename DIR PREFIXO SUFIXO"
            echo "  $0 convert DIR FORMATO_ORIGEM FORMATO_DESTINO"
            echo "  $0 compress CAMINHO FORMATO"
            echo "  $0 extract ARQUIVO [DESTINO]"
            echo "  $0 chmod CAMINHO PERMISSAO"
            echo "  $0 search DIR PADRAO"
            echo ""
            echo "Exemplos:"
            echo "  $0 rename /tmp/arquivos novo_ _backup"
            echo "  $0 convert /tmp/imagens png jpg"
            echo "  $0 compress /tmp/pasta zip"
            echo "  $0 extract arquivo.zip"
            echo "  $0 chmod script.sh 755"
            echo "  $0 search /tmp '*.txt'"
            ;;
        *)
            log_error "Operacao invalida: $OPERATION"
            echo ""
            echo "Use '$0 --help' para ajuda"
            ;;
    esac
fi
