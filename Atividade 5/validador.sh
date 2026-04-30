#!/bin/bash
# Script para validar email, CPF e data

# Cores para output
VERDE="\033[32m"
VERMELHO="\033[31m"
AMARELO="\033[33m"
AZUL="\033[34m"
RESET="\033[0m"

# Função para validar email
valida_email() {
    local email=$1
    
    if [ -z "$email" ]; then
        echo -e "${VERMELHO}INVALIDO${RESET} - Email nao pode estar vazio"
        return 1
    fi
    
    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo -e "${VERDE}VALIDO${RESET} - $email e um email correto"
        return 0
    else
        echo -e "${VERMELHO}INVALIDO${RESET} - Formato de email incorreto"
        echo "Exemplo valido: nome@dominio.com"
        return 1
    fi
}

# Função para validar CPF
valida_cpf() {
    local cpf=$1
    cpf=$(echo "$cpf" | tr -d '.-')
    
    if [ ${#cpf} -ne 11 ]; then
        echo -e "${VERMELHO}INVALIDO${RESET} - CPF deve ter 11 digitos"
        return 1
    fi
    
    if [[ "$cpf" =~ ^([0-9])\1{10}$ ]]; then
        echo -e "${VERMELHO}INVALIDO${RESET} - CPF invalido (digitos repetidos)"
        return 1
    fi
    
    echo -e "${VERDE}VALIDO${RESET} - CPF $cpf e valido"
    return 0
}

# Função para validar data
valida_data() {
    local data=$1
    
    if [[ "$data" =~ ^([0-9]{2})/([0-9]{2})/([0-9]{4})$ ]]; then
        dia=${BASH_REMATCH[1]}
        mes=${BASH_REMATCH[2]}
        ano=${BASH_REMATCH[3]}
    else
        echo -e "${VERMELHO}INVALIDO${RESET} - Formato de data incorreto"
        echo "Use DD/MM/AAAA"
        return 1
    fi
    
    if [ $mes -lt 1 ] || [ $mes -gt 12 ]; then
        echo -e "${VERMELHO}INVALIDO${RESET} - Mes deve ser entre 01 e 12"
        return 1
    fi
    
    case $mes in
        01|03|05|07|08|10|12) dias_max=31 ;;
        04|06|09|11) dias_max=30 ;;
        02)
            if (( ano % 400 == 0 )) || (( ano % 4 == 0 && ano % 100 != 0 )); then
                dias_max=29
            else
                dias_max=28
            fi
            ;;
    esac
    
    if [ $dia -lt 1 ] || [ $dia -gt $dias_max ]; then
        echo -e "${VERMELHO}INVALIDO${RESET} - Dia $dia invalido para o mes $mes"
        return 1
    fi
    
    echo -e "${VERDE}VALIDO${RESET} - Data $dia/$mes/$ano e valida"
    return 0
}

# Menu interativo
while true; do
    clear
    echo "========================================="
    echo "        VALIDADOR DE DADOS"
    echo "========================================="
    echo ""
    echo "1 - Validar E-mail"
    echo "2 - Validar CPF"
    echo "3 - Validar Data"
    echo "4 - Sair"
    echo ""
    echo -n "Escolha uma opcao (1-4): "
    read opcao
    
    case $opcao in
        1)
            clear
            echo "=== VALIDACAO DE E-MAIL ==="
            echo ""
            echo -n "Digite o e-mail: "
            read email
            echo ""
            valida_email "$email"
            echo ""
            echo -n "Pressione Enter para continuar..."
            read
            ;;
        2)
            clear
            echo "=== VALIDACAO DE CPF ==="
            echo ""
            echo -n "Digite o CPF (apenas numeros ou com . e -): "
            read cpf
            echo ""
            valida_cpf "$cpf"
            echo ""
            echo -n "Pressione Enter para continuar..."
            read
            ;;
        3)
            clear
            echo "=== VALIDACAO DE DATA ==="
            echo ""
            echo -n "Digite a data (DD/MM/AAAA): "
            read data
            echo ""
            valida_data "$data"
            echo ""
            echo -n "Pressione Enter para continuar..."
            read
            ;;
        4)
            clear
            echo "========================================="
            echo "  Obrigado por usar o validador!"
            echo "========================================="
            exit 0
            ;;
        *)
            echo ""
            echo -e "${VERMELHO}Opcao invalida!${RESET} Escolha 1, 2, 3 ou 4"
            sleep 2
            ;;
    esac
done
