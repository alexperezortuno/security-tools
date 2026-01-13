#!/bin/bash

OUTPUT_DIR="./results"
MAX_PARALLEL=5
COUNT=0

mkdir -p "$OUTPUT_DIR"

if [[ ! -f targets.txt ]]; then
    echo "[!] targets.txt no encontrado. Ejecuta primero nmap_filter.sh"
    exit 1
fi

echo "[*] Ejecutando escaneo Nikto paralelo..."

while read -r LINE; do
    HOST=$(echo "$LINE" | cut -d':' -f1)
    PORT=$(echo "$LINE" | cut -d':' -f2)

    if [[ -n "$HOST" && -n "$PORT" ]]; then
        {
            echo "[+] Escaneando $HOST:$PORT"

            SSL_PORTS="443 8443 2083 2096"
            if echo "$SSL_PORTS" | grep -qw "$PORT"; then
                SSL_FLAG="-ssl"
            else
                SSL_FLAG=""
            fi

            OUTPUT_FILE="$OUTPUT_DIR/nikto_${HOST}_${PORT}.txt"

            nikto -host "$HOST" -port "$PORT" $SSL_FLAG -nointeractive -Format txt -output "$OUTPUT_FILE"

            echo "[✓] Completado $HOST:$PORT"
        } &

        COUNT=$((COUNT + 1))
        if [[ "$COUNT" -ge "$MAX_PARALLEL" ]]; then
            wait
            COUNT=0
        fi
    fi
done < targets.txt

wait
echo "[*] Escaneo completo. Revisa los archivos en: $OUTPUT_DIR"
