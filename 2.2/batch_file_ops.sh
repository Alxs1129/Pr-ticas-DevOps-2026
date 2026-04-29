#!/bin/bash
# Script: batch_file_ops.sh
# Atividade: Operacoes em Lote com Arquivos
# Funcionalidades: renomear, converter, compactar, descompactar e alterar permissoes

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

# Funcao para limpar a tela
limpar_tela() {
    clear
}

# Funcao para aguardar enter
aguardar_enter() {
    echo ""
    echo -n "Pressione Enter para continuar..."
    read
}

# =======================================================
# 1. RENOMEAR ARQUIVOS EM LOTE
# =======================================================
renomear_arquivos() {
    limpar_tela
    echo "RENOMEAR ARQUIVOS EM LOTE"
    echo ""
    
    echo -n "Digite o diretorio onde estao os arquivos: "
    read diretorio
    
    if [ ! -d "$diretorio" ]; then
        log_error "Diretorio nao encontrado"
        aguardar_enter
        return 1
    fi
    
    echo ""
    echo "Arquivos encontrados no diretorio:"
    ls -la "$diretorio"
    echo ""
    
    echo -n "Digite o prefixo desejado (ex: novo_): "
    read prefixo
    
    echo -n "Digite o sufixo desejado (ex: _backup): "
    read sufixo
    
    echo ""
    echo "Opcoes de renomeacao:"
    echo "1 - Apenas prefixo"
    echo "2 - Apenas sufixo"
    echo "3 - Prefixo + Sufixo"
    echo "4 - Substituir texto"
    echo -n "Escolha (1-4): "
    read opcao_rename
    
    cd "$diretorio" || return 1
    
    contador=0
    case $opcao_rename in
        1)
            for arquivo in *; do
                if [ -f "$arquivo" ]; then
                    novo_nome="${prefixo}${arquivo}"
                    mv "$arquivo" "$novo_nome"
                    echo "Renomeado: $arquivo -> $novo_nome"
                    ((contador++))
                fi
            done
            ;;
        2)
            for arquivo in *; do
                if [ -f "$arquivo" ]; then
                    nome_sem_ext="${arquivo%.*}"
                    extensao="${arquivo##*.}"
                    if [ "$nome_sem_ext" != "$arquivo" ]; then
                        novo_nome="${nome_sem_ext}${sufixo}.${extensao}"
                    else
                        novo_nome="${arquivo}${sufixo}"
                    fi
                    mv "$arquivo" "$novo_nome"
                    echo "Renomeado: $arquivo -> $novo_nome"
                    ((contador++))
                fi
            done
            ;;
        3)
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
            ;;
        4)
            echo -n "Digite o texto a ser substituido: "
            read texto_antigo
            echo -n "Digite o novo texto: "
            read texto_novo
            for arquivo in *; do
                if [ -f "$arquivo" ]; then
                    novo_nome="${arquivo//$texto_antigo/$texto_novo}"
                    if [ "$arquivo" != "$novo_nome" ]; then
                        mv "$arquivo" "$novo_nome"
                        echo "Renomeado: $arquivo -> $novo_nome"
                        ((contador++))
                    fi
                fi
            done
            ;;
        *)
            log_error "Opcao invalida"
            ;;
    esac
    
    log_success "$contador arquivos renomeados"
    cd - > /dev/null || return
    aguardar_enter
}

# =======================================================
# 2. CONVERTER FORMATOS DE IMAGEM
# =======================================================
converter_imagens() {
    limpar_tela
    echo "CONVERTER FORMATOS DE IMAGEM"
    echo ""
    
    # Verificar se o ImageMagick esta instalado
    if ! command -v convert &> /dev/null; then
        log_error "ImageMagick nao encontrado"
        echo "Instale com: apt-get install imagemagick (Linux) ou baixe para Windows"
        aguardar_enter
        return 1
    fi
    
    echo -n "Digite o diretorio das imagens: "
    read diretorio
    
    if [ ! -d "$diretorio" ]; then
        log_error "Diretorio nao encontrado"
        aguardar_enter
        return 1
    fi
    
    echo ""
    echo "Formatos suportados: jpg, jpeg, png, gif, bmp, tiff, webp"
    echo -n "Digite o formato de origem (ex: png): "
    read formato_origem
    
    echo -n "Digite o formato de destino (ex: jpg): "
    read formato_destino
    
    echo -n "Digite a qualidade (1-100, padrao 85): "
    read qualidade
    qualidade=${qualidade:-85}
    
    cd "$diretorio" || return 1
    
    contador=0
    for arquivo in *."$formato_origem"; do
        if [ -f "$arquivo" ]; then
            nome_base="${arquivo%.*}"
            convert "$arquivo" -quality "$qualidade" "${nome_base}.${formato_destino}"
            echo "Convertido: $arquivo -> ${nome_base}.${formato_destino}"
            ((contador++))
        fi
    done
    
    if [ $contador -eq 0 ]; then
        log_warning "Nenhum arquivo .$formato_origem encontrado"
    else
        log_success "$contador imagens convertidas"
    fi
    
    cd - > /dev/null || return
    aguardar_enter
}

# =======================================================
# 3. COMPACTAR ARQUIVOS
# =======================================================
compactar_arquivos() {
    limpar_tela
    echo "COMPACTAR ARQUIVOS"
    echo ""
    
    echo -n "Digite o diretorio dos arquivos: "
    read diretorio
    
    if [ ! -d "$diretorio" ]; then
        log_error "Diretorio nao encontrado"
        aguardar_enter
        return 1
    fi
    
    echo -n "Digite o nome do arquivo compactado (sem extensao): "
    read nome_compactado
    
    echo ""
    echo "Formatos de compactacao:"
    echo "1 - ZIP"
    echo "2 - TAR.GZ"
    echo "3 - TAR.BZ2"
    echo "4 - 7Z (requer p7zip)"
    echo -n "Escolha (1-4): "
    read formato_compact
    
    cd "$diretorio" || return 1
    
    case $formato_compact in
        1)
            if command -v zip &> /dev/null; then
                zip -r "../${nome_compactado}.zip" .
                log_success "Arquivo criado: ${nome_compactado}.zip"
            else
                log_error "Comando zip nao encontrado"
            fi
            ;;
        2)
            tar -czf "../${nome_compactado}.tar.gz" .
            log_success "Arquivo criado: ${nome_compactado}.tar.gz"
            ;;
        3)
            tar -cjf "../${nome_compactado}.tar.bz2" .
            log_success "Arquivo criado: ${nome_compactado}.tar.bz2"
            ;;
        4)
            if command -v 7z &> /dev/null; then
                7z a "../${nome_compactado}.7z" .
                log_success "Arquivo criado: ${nome_compactado}.7z"
            else
                log_error "7z nao encontrado. Instale o p7zip"
            fi
            ;;
        *)
            log_error "Opcao invalida"
            ;;
    esac
    
    cd - > /dev/null || return
    aguardar_enter
}

# =======================================================
# 4. DESCOMPACTAR ARQUIVOS
# =======================================================
descompactar_arquivos() {
    limpar_tela
    echo "DESCOMPACTAR ARQUIVOS"
    echo ""
    
    echo -n "Digite o caminho do arquivo compactado: "
    read arquivo_compactado
    
    if [ ! -f "$arquivo_compactado" ]; then
        log_error "Arquivo nao encontrado"
        aguardar_enter
        return 1
    fi
    
    echo -n "Digite o diretorio de destino: "
    read destino
    
    mkdir -p "$destino"
    
    case "$arquivo_compactado" in
        *.zip)
            if command -v unzip &> /dev/null; then
                unzip "$arquivo_compactado" -d "$destino"
                log_success "Arquivo descompactado em: $destino"
            else
                log_error "Comando unzip nao encontrado"
            fi
            ;;
        *.tar.gz|*.tgz)
            tar -xzf "$arquivo_compactado" -C "$destino"
            log_success "Arquivo descompactado em: $destino"
            ;;
        *.tar.bz2)
            tar -xjf "$arquivo_compactado" -C "$destino"
            log_success "Arquivo descompactado em: $destino"
            ;;
        *.tar)
            tar -xf "$arquivo_compactado" -C "$destino"
            log_success "Arquivo descompactado em: $destino"
            ;;
        *.7z)
            if command -v 7z &> /dev/null; then
                7z x "$arquivo_compactado" -o"$destino"
                log_success "Arquivo descompactado em: $destino"
            else
                log_error "7z nao encontrado"
            fi
            ;;
        *)
            log_error "Formato nao suportado"
            ;;
    esac
    
    aguardar_enter
}

# =======================================================
# 5. ALTERAR PERMISSOES
# =======================================================
alterar_permissoes() {
    limpar_tela
    echo "ALTERAR PERMISSOES"
    echo ""
    
    echo -n "Digite o diretorio ou arquivo: "
    read caminho
    
    if [ ! -e "$caminho" ]; then
        log_error "Caminho nao encontrado"
        aguardar_enter
        return 1
    fi
    
    echo ""
    echo "Permissoes atuais:"
    ls -la "$caminho"
    echo ""
    
    echo "Opcoes de permissao:"
    echo "1 - Numerica (ex: 755, 644)"
    echo "2 - Simbolica (ex: u+x, g-w, o+r)"
    echo "3 - Recursiva (para diretorios)"
    echo -n "Escolha (1-3): "
    read opcao_perm
    
    case $opcao_perm in
        1)
            echo -n "Digite a permissao numerica: "
            read permissao
            chmod "$permissao" "$caminho"
            log_success "Permissao alterada para $permissao"
            ;;
        2)
            echo -n "Digite a permissao simbolica: "
            read permissao
            chmod "$permissao" "$caminho"
            log_success "Permissao alterada: $permissao"
            ;;
        3)
            if [ -d "$caminho" ]; then
                echo -n "Digite a permissao recursiva: "
                read permissao
                chmod -R "$permissao" "$caminho"
                log_success "Permissao recursiva alterada para $permissao"
            else
                log_error "Recursiva so eh valida para diretorios"
            fi
            ;;
        *)
            log_error "Opcao invalida"
            ;;
    esac
    
    echo ""
    echo "Novas permissoes:"
    ls -la "$caminho"
    
    aguardar_enter
}

# =======================================================
# MENU PRINCIPAL
# =======================================================
exibir_menu() {
    limpar_tela
    echo "OPERACOES EM LOTE COM ARQUIVOS - DEVOPS"
    echo ""
    echo "1) RENOMEAR ARQUIVOS EM LOTE"
    echo "   - Adicionar prefixo/sufixo, substituir texto"
    echo ""
    echo "2) CONVERTER FORMATOS DE IMAGEM"
    echo "   - Converter entre JPG, PNG, GIF, etc (requer ImageMagick)"
    echo ""
    echo "3) COMPACTAR ARQUIVOS"
    echo "   - ZIP, TAR.GZ, TAR.BZ2, 7Z"
    echo ""
    echo "4) DESCOMPACTAR ARQUIVOS"
    echo "   - ZIP, TAR.GZ, TAR.BZ2, 7Z"
    echo ""
    echo "5) ALTERAR PERMISSOES"
    echo "   - Numerica (755, 644) ou Simbolica (u+x, g-w)"
    echo ""
    echo "6) SAIR"
    echo ""
}

# Loop principal
main() {
    while true; do
        exibir_menu
        echo -n "Escolha uma opcao (1-6): "
        read opcao
        
        case $opcao in
            1) renomear_arquivos ;;
            2) converter_imagens ;;
            3) compactar_arquivos ;;
            4) descompactar_arquivos ;;
            5) alterar_permissoes ;;
            6)
                limpar_tela
                echo "OBRIGADO POR USAR O SCRIPT"
                echo ""
                exit 0
                ;;
            *)
                log_error "Opcao invalida. Digite 1-6"
                sleep 2
                ;;
        esac
    done
}

# Executar script
main
