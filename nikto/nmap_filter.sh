#!/bin/bash

RAW_TARGETS="raw_targets.txt"
OUTPUT="targets.txt"
PORTS=$(paste -sd, ports.txt)

#> "$OUTPUT"

echo "[*] Escaneando hosts para detectar puertos web abiertos..."

while read -r HOST; do
    if [[ -n "$HOST" ]]; then
        echo "[+] Escaneando $HOST..."
        nmap -p "$PORTS" --open -Pn -T4 "$HOST" -oG - | \
        awk '/\/open\// {
          ip = $2
          for (i = 3; i <= NF; i++) {
            if ($i ~ /\/open\/tcp/) {
              split($i, a, "/")
              print ip ":" a[1]
            }
          }
        }' >> "$OUTPUT"
    fi
done < "$RAW_TARGETS"

echo "[✓] Puertos HTTP/HTTPS abiertos guardados en $OUTPUT"
