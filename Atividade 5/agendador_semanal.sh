
#!/bin/bash

echo "Agendador: verifica se é segunda-feira 3h..."

while true; do

    DIA=$(date +%u)

    HORA=$(date +%H)

    MINUTO=$(date +%M)

    if [ $DIA -eq 1 ] && [ $HORA -eq 3 ] && [ $MINUTO -eq 0 ]; then

        echo "$(date): Executando job..." >> job_log.txt

        ./extrair_emails.sh emails_exemplo.txt > emails_$(date +%Y%m%d).txt

        sleep 61

    fi

    sleep 30

done
