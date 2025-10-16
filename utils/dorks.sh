#!/bin/bash

# Verifica que haya al menos un argumento
if [ $# -lt 2 ]; then
    echo "Usage: $0 [-c|-b] \"dork search\""
    echo "Options:"
    echo "  -c    Use curl to perform the search"
    echo "  -b    Open the search in a browser"
    echo "Example: $0 -c \"site:example.com inurl:admin\""
    exit 1
fi

# Obtener la opción y la búsqueda
OPTION=$1
shift
# Concatenar todos los argumentos como una sola búsqueda
DORK="$*"

# Codificar la búsqueda para que sea válida en una URL
QUERY=$(echo "$DORK" | sed 's/ /+/g')

# Armar la URL de búsqueda
URL="https://www.google.com/search?q=$QUERY"
#URL="https://html.duckduckgo.com/html/?q=$QUERY"

# Detectar sistema operativo para abrir en navegador
open_url_in_browser() {
    case "$OSTYPE" in
        linux*) xdg-open "$URL" ;;
        darwin*) open "$URL" ;;
        cygwin*|msys*|win32*) start "$URL" ;;
        *) echo "Could not detect the system to open the browser." ;;
    esac
}

search_with_curl() {
    echo "Realizando búsqueda con curl..."
    curl -s -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" "$URL" | \
    grep -Eo '<a href="\/url\?q=[^"]+' | \
    sed -E 's/^<a href="\/url\?q=//' | \
    grep -v "google" | \
    uniq
    exit 0
}

search_with_curl_ddg() {
    echo "Realizando búsqueda con curl (DuckDuckGo)..."
    curl -s "$URL" | \
    grep -oP '(?<=href=")[^"]+(?=")' | \
    grep "^https" | \
    head -n 10
}

# Ejecutar la opción seleccionada
case "$OPTION" in
    -c) search_with_curl_ddg ;;
    -b) open_url_in_browser ;;
    *) echo "Invalid option: $OPTION" ;;
esac

echo "Searching in Google: $DORK"
