#!/bin/bash

# Validar entrada
if [ -z "$1" ]; then
    echo "Use: $0 <domain>"
    exit 1
fi

# Obtener la IP del dominio
domain="$1"
logger -t "nmap-scan" "resolving IP $domain"
ip=$(dig +short "$domain" | head -n 1)
logger -t "nmap-scan" "IP resolved: $ip"

# Verificar si se obtuvo la IP
if [ -z "$ip" ]; then
    echo "cant resolve IP from domain $domain"
    exit 2
fi

echo "the IP of $domain is $ip"

# Ejecutar escaneos con Nmap
nmap -O "$ip" -oA /reports/report_"$domain"_1

echo "fast scan to common ports..."
nmap -sS "$ip" -oA /reports/report_"$domain"_2

echo "scan all ports..."
nmap -p- "$ip" -oA /reports/report_"$domain"_3

echo "XMAS scan..."
nmap -sX "$ip" -oA /reports/report_"$domain"_4

echo "detection of services and versions..."
nmap -sV "$ip" -oA /reports/report_"$domain"_5

echo "Escaneo de vulnerabilidades conocidas..."
nmap --script=vuln "$ip" -oA /reports/report_"$domain"_6

xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_1.xml -o /reports/report_"$domain"_1.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_2.xml -o /reports/report_"$domain"_2.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_3.xml -o /reports/report_"$domain"_3.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_4.xml -o /reports/report_"$domain"_4.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_5.xml -o /reports/report_"$domain"_5.html
xsltproc /usr/share/nmap/nmap.xsl /reports/report_"$domain"_6.xml -o /reports/report_"$domain"_6.html

# remove files xml
rm /reports/report_"$domain"_*.xml
rm /reports/report_"$domain"_*.nmap
rm /reports/report_"$domain"_*.gnmap
